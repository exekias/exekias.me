---
layout: post
title: Samba AD LDAP indexes
tags:
- zentyal
- samba
- ldap
---

Indexes are noticeable as soon your load rises above some users and can really improve the overall performance of the system. Monitoring query times is fundamental to provide a successful service and avoid future problems from appearing.

We use [Samba] AD Server in [Zentyal Cloud] as *Active Directory* replacement, so it holds user accounts and mailboxes info. It's also helpful to perform seamlessly migrations from existing systems.

When the number of hosted mailboxes is high, it is important to keep all your query times to a minimum, as every time a mail hits the system (both inbound and outbound mail), some queries are run against Samba (LDAP) in order to resolve its destination. For the case of Zentyal, we support virtual domains, mail alias, and mail forwarding configuration directly from LDAP.

In this post I will go through the process of checking and adding new indexes to the database. Depending on the scenario that could reduce query times by 50x!


Checking indexed attributes
---------------------------
Samba stores LDAP entries using its own database engine ([LDB]). Indexes support is fairly simple, at the moment only exact attribute indexing and one level indexing are available. Attribute indexing allows to index entries by attribute value and one level indexing allows to index child entries for faster access.

{% highlight sh %}
root@ad1:~# ldbsearch -H /var/lib/samba/private/sam.ldb  -s base -b @INDEXLIST
# record 1
dn: @INDEXLIST
@IDXONE: 1
@IDXVERSION: 2
@IDXATTR: virtualdomain
@IDXATTR: msExchRecipientTypeDetails
@IDXATTR: msExchRecipientDisplayType
@IDXATTR: msExchVoiceMailboxID
@IDXATTR: msExchUserAccountControl
@IDXATTR: msExchUnmergedAttsPt
@IDXATTR: targetAddress
...
{% endhighlight %}

Adding a new index
------------------
For the case of Samba AD we are editing a schema based database. Take into account that directly editing @INDEXLIST will not work, as @INDEXLIST is generated from the schema. We will need to edit the schema to ensure indexing on the desired attributes:

First find the base DN for your setup:

{% highlight sh %}
root@ad1:~# ldbsearch -H /var/lib/samba/private/sam.ldb  -s base -b "" defaultNamingContext
# record 1
dn: 
defaultNamingContext: DC=ad1,DC=devel,DC=zentyal,DC=lan
{% endhighlight %}

And then edit the schema, using `ldbedit` and set `searchFlags` attribute to 1 on the attribute entry you want to index:

{% highlight sh %}
root@ad1:~# ldbedit -H /var/lib/samba/private/sam.ldb  -b CN=SCHEMA,CN=CONFIGURATION,DC=AD1,DC=DEVEL,DC=ZENTYAL,DC=LAN

# record 1870
dn: CN=Other-Mailbox,CN=Schema,CN=Configuration,DC=ad1,DC=devel,DC=zentyal,DC=lan
objectClass: top
objectClass: attributeSchema
cn: Other-Mailbox
instanceType: 4
whenCreated: 20150506172645.0Z
whenChanged: 20150506172645.0Z
uSNCreated: 1011
attributeID: 1.2.840.113556.1.4.651
attributeSyntax: 2.5.5.12
isSingleValued: FALSE
uSNChanged: 1011
showInAdvancedViewOnly: TRUE
adminDisplayName: Other-Mailbox
adminDescription: Other-Mailbox
oMSyntax: 64
lDAPDisplayName: otherMailbox
name: Other-Mailbox
objectGUID: 97fdabc3-0a74-4e43-b12a-f26b6c1ee16e
schemaIDGUID: 0296c123-40da-11d1-a9c0-0000f80367c1
attributeSecurityGUID: e48d0154-bcf8-11d1-8702-00c04fb96050
systemOnly: FALSE
searchFlags: 1
{% endhighlight %}

That's all! You can check again all your indexes and see your attribute is now there, query times should have been improved significantly.


[Zentyal Cloud]: https://www.zentyal.com/zinc/
[Samba]: https://www.samba.org/
[LDB]: https://wiki.samba.org/index.php/LDB#How_LDB_Indexing_works
