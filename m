Return-Path: <SRS0=6mDK=MM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937B6C07E95
	for <virtualization@archiver.kernel.org>; Tue, 20 Jul 2021 09:22:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426C9611F2
	for <virtualization@archiver.kernel.org>; Tue, 20 Jul 2021 09:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426C9611F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00D6B824CE;
	Tue, 20 Jul 2021 09:22:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FM3zRFYQLGsi; Tue, 20 Jul 2021 09:22:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7F39981D65;
	Tue, 20 Jul 2021 09:22:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29AE9C0010;
	Tue, 20 Jul 2021 09:22:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A28AC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 09:22:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E4A960796
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 09:22:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hvegyteyN4BI
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 09:22:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC224605F2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 09:22:28 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UgPaTDY_1626772944; 
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0UgPaTDY_1626772944) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 20 Jul 2021 17:22:25 +0800
Subject: Re: [PATCH v2 3/4] fuse: add per-file DAX flag
From: JeffleXu <jefflexu@linux.alibaba.com>
To: Vivek Goyal <vgoyal@redhat.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <20210716104753.74377-4-jefflexu@linux.alibaba.com>
 <YPXWA+Uo5vFuHCH0@redhat.com>
 <61bca75f-2efa-f032-41d6-fcb525d8b528@linux.alibaba.com>
Message-ID: <9746c189-bbce-738c-7308-bdf094996bc8@linux.alibaba.com>
Date: Tue, 20 Jul 2021 17:22:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <61bca75f-2efa-f032-41d6-fcb525d8b528@linux.alibaba.com>
Content-Language: en-US
Cc: miklos@szeredi.hu, virtualization@lists.linux-foundation.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 7/20/21 2:51 PM, JeffleXu wrote:
> 
> 
> On 7/20/21 3:44 AM, Vivek Goyal wrote:
>> On Fri, Jul 16, 2021 at 06:47:52PM +0800, Jeffle Xu wrote:
>>> Add one flag for fuse_attr.flags indicating if DAX shall be enabled for
>>> this file.
>>>
>>> When the per-file DAX flag changes for an *opened* file, the state of
>>> the file won't be updated until this file is closed and reopened later.
>>>
>>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>>> ---
>>>  fs/fuse/dax.c             | 21 +++++++++++++++++----
>>>  fs/fuse/file.c            |  4 ++--
>>>  fs/fuse/fuse_i.h          |  5 +++--
>>>  fs/fuse/inode.c           |  5 ++++-
>>>  include/uapi/linux/fuse.h |  5 +++++
>>>  5 files changed, 31 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
>>> index a478e824c2d0..0e862119757a 100644
>>> --- a/fs/fuse/dax.c
>>> +++ b/fs/fuse/dax.c
>>> @@ -1341,7 +1341,7 @@ static const struct address_space_operations fuse_dax_file_aops  = {
>>>  	.invalidatepage	= noop_invalidatepage,
>>>  };
>>>  
>>> -static bool fuse_should_enable_dax(struct inode *inode)
>>> +static bool fuse_should_enable_dax(struct inode *inode, unsigned int flags)
>>>  {
>>>  	struct fuse_conn *fc = get_fuse_conn(inode);
>>>  	unsigned int mode;
>>> @@ -1354,18 +1354,31 @@ static bool fuse_should_enable_dax(struct inode *inode)
>>>  	if (mode == FUSE_DAX_MOUNT_NEVER)
>>>  		return false;
>>>  
>>> -	return true;
>>> +	if (mode == FUSE_DAX_MOUNT_ALWAYS)
>>> +		return true;
>>> +
>>> +	WARN_ON(mode != FUSE_DAX_MOUNT_INODE);
>>> +	return flags & FUSE_ATTR_DAX;
>>>  }
>>>  
>>> -void fuse_dax_inode_init(struct inode *inode)
>>> +void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
>>>  {
>>> -	if (!fuse_should_enable_dax(inode))
>>> +	if (!fuse_should_enable_dax(inode, flags))
>>>  		return;
>>>  
>>>  	inode->i_flags |= S_DAX;
>>>  	inode->i_data.a_ops = &fuse_dax_file_aops;
>>>  }
>>>  
>>> +void fuse_dax_dontcache(struct inode *inode, bool newdax)
>>> +{
>>> +	struct fuse_conn *fc = get_fuse_conn(inode);
>>> +
>>> +	if (fc->dax && fc->dax->mode == FUSE_DAX_MOUNT_INODE &&
>>> +	    IS_DAX(inode) != newdax)
>>> +		d_mark_dontcache(inode);
>>> +}
>>> +
>>
>> This capability to mark an inode dontcache should probably be in a
>> separate patch. These seem to logically two functionalities. One is
>> enabling DAX on an inode. And second is making sure how soon you
>> see the effect of that change and hence marking inode dontcache.
> 
> OK, sounds reasonable.
> 
>>
>> Not sure how useful this is. In cache=none mode we should get rid of
>> inode ASAP. In cache=auto mode we will get rid of after 1 second (or
>> after a user specified timeout). So only place this seems to be
>> useful is cache=always.
> 
> Actually dontcache here is used to avoid dynamic switching between DAX
> and non-DAX state while file is opened. The complexity of dynamic
> switching is that, you have to clear the address_space, since page cache
> and DAX entry can not coexist in the address space. Besides,
> inode->a_ops also needs to be changed dynamically.

FYI some context on the complication of switching DAX state dynamically,
when Ira Weiny was working on per-file DAX of ext4/xfs.

> At LSF/MM we discussed the difficulties of switching the DAX state of
a file with active mappings / page cache.  It was thought the races
could be avoided by limiting DAX state flips to 0-length files.
>
> However, this turns out to not be true.[3][5] This is because address
space operations (a_ops) may be in use at any time the inode is referenced.
> from Ira Weiny

[1]
https://patchwork.kernel.org/project/xfs/cover/20200407182958.568475-1-ira.weiny@intel.com/
[2] https://lore.kernel.org/lkml/20200305155144.GA5598@lst.de/
[3] https://lore.kernel.org/lkml/20200401040021.GC56958@magnolia/
[4] https://lore.kernel.org/lkml/20200403182904.GP80283@magnolia/

> 
> With dontcache, dynamic switching is no longer needed and the DAX state
> will be decided only when inode (in memory) is initialized. The downside
> is that the new DAX state won't be updated until the file is closed and
> reopened later.
> 
> 'cache=none' only invalidates dentry, while the inode (in memory) is
> still there (with address_space uncleared and a_ops unchanged).
> 
> The dynamic switching may be done, though it's not such straightforward.
> Currently, ext4/xfs are all implemented in this dontcache way, i.e., the
> new DAX state won't be seen until the file is closed and reopened later.
> 

-- 
Thanks,
Jeffle
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
