Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02343C12002
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:14:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F4961242
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F4961242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6B6324014C;
	Wed, 21 Jul 2021 14:14:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AeEwZ8pIzamk; Wed, 21 Jul 2021 14:14:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D6EFC400D0;
	Wed, 21 Jul 2021 14:14:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5977C0010;
	Wed, 21 Jul 2021 14:14:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 233F5C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 117E760891
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:14:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vqyi8EkI0Egz
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:14:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8F6BA6088D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:14:47 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UgX56vV_1626876884; 
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0UgX56vV_1626876884) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 21 Jul 2021 22:14:45 +0800
Subject: Re: [PATCH v2 3/4] fuse: add per-file DAX flag
To: Vivek Goyal <vgoyal@redhat.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <20210716104753.74377-4-jefflexu@linux.alibaba.com>
 <YPXWA+Uo5vFuHCH0@redhat.com>
 <61bca75f-2efa-f032-41d6-fcb525d8b528@linux.alibaba.com>
 <YPcjlN1ThL4UX8dn@redhat.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <0ad3b5d2-3d19-a33b-7841-1912ea30c081@linux.alibaba.com>
Date: Wed, 21 Jul 2021 22:14:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPcjlN1ThL4UX8dn@redhat.com>
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



On 7/21/21 3:27 AM, Vivek Goyal wrote:
> On Tue, Jul 20, 2021 at 02:51:34PM +0800, JeffleXu wrote:
>>
>>
>> On 7/20/21 3:44 AM, Vivek Goyal wrote:
>>> On Fri, Jul 16, 2021 at 06:47:52PM +0800, Jeffle Xu wrote:
>>>> Add one flag for fuse_attr.flags indicating if DAX shall be enabled for
>>>> this file.
>>>>
>>>> When the per-file DAX flag changes for an *opened* file, the state of
>>>> the file won't be updated until this file is closed and reopened later.
>>>>
>>>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>>>> ---
>>>>  fs/fuse/dax.c             | 21 +++++++++++++++++----
>>>>  fs/fuse/file.c            |  4 ++--
>>>>  fs/fuse/fuse_i.h          |  5 +++--
>>>>  fs/fuse/inode.c           |  5 ++++-
>>>>  include/uapi/linux/fuse.h |  5 +++++
>>>>  5 files changed, 31 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
>>>> index a478e824c2d0..0e862119757a 100644
>>>> --- a/fs/fuse/dax.c
>>>> +++ b/fs/fuse/dax.c
>>>> @@ -1341,7 +1341,7 @@ static const struct address_space_operations fuse_dax_file_aops  = {
>>>>  	.invalidatepage	= noop_invalidatepage,
>>>>  };
>>>>  
>>>> -static bool fuse_should_enable_dax(struct inode *inode)
>>>> +static bool fuse_should_enable_dax(struct inode *inode, unsigned int flags)
>>>>  {
>>>>  	struct fuse_conn *fc = get_fuse_conn(inode);
>>>>  	unsigned int mode;
>>>> @@ -1354,18 +1354,31 @@ static bool fuse_should_enable_dax(struct inode *inode)
>>>>  	if (mode == FUSE_DAX_MOUNT_NEVER)
>>>>  		return false;
>>>>  
>>>> -	return true;
>>>> +	if (mode == FUSE_DAX_MOUNT_ALWAYS)
>>>> +		return true;
>>>> +
>>>> +	WARN_ON(mode != FUSE_DAX_MOUNT_INODE);
>>>> +	return flags & FUSE_ATTR_DAX;
>>>>  }
>>>>  
>>>> -void fuse_dax_inode_init(struct inode *inode)
>>>> +void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
>>>>  {
>>>> -	if (!fuse_should_enable_dax(inode))
>>>> +	if (!fuse_should_enable_dax(inode, flags))
>>>>  		return;
>>>>  
>>>>  	inode->i_flags |= S_DAX;
>>>>  	inode->i_data.a_ops = &fuse_dax_file_aops;
>>>>  }
>>>>  
>>>> +void fuse_dax_dontcache(struct inode *inode, bool newdax)
>>>> +{
>>>> +	struct fuse_conn *fc = get_fuse_conn(inode);
>>>> +
>>>> +	if (fc->dax && fc->dax->mode == FUSE_DAX_MOUNT_INODE &&
>>>> +	    IS_DAX(inode) != newdax)
>>>> +		d_mark_dontcache(inode);
>>>> +}
>>>> +
>>>
>>> This capability to mark an inode dontcache should probably be in a
>>> separate patch. These seem to logically two functionalities. One is
>>> enabling DAX on an inode. And second is making sure how soon you
>>> see the effect of that change and hence marking inode dontcache.
>>
>> OK, sounds reasonable.
>>
>>>
>>> Not sure how useful this is. In cache=none mode we should get rid of
>>> inode ASAP. In cache=auto mode we will get rid of after 1 second (or
>>> after a user specified timeout). So only place this seems to be
>>> useful is cache=always.
>>
>> Actually dontcache here is used to avoid dynamic switching between DAX
>> and non-DAX state while file is opened. The complexity of dynamic
>> switching is that, you have to clear the address_space, since page cache
>> and DAX entry can not coexist in the address space. Besides,
>> inode->a_ops also needs to be changed dynamically.
>>
>> With dontcache, dynamic switching is no longer needed and the DAX state
>> will be decided only when inode (in memory) is initialized. The downside
>> is that the new DAX state won't be updated until the file is closed and
>> reopened later.
>>
>> 'cache=none' only invalidates dentry, while the inode (in memory) is
>> still there (with address_space uncleared and a_ops unchanged).
> 
> Aha.., that's a good point.
>>
>> The dynamic switching may be done, though it's not such straightforward.
>> Currently, ext4/xfs are all implemented in this dontcache way, i.e., the
>> new DAX state won't be seen until the file is closed and reopened later.
> 
> Got it. Agreed that dontcache seems reasonable if file's DAX state
> has changed. Keep it in separate patch though with proper commit
> logs.
> 
> Also, please copy virtiofs list (virtio-fs@redhat.com) when you post
> patches next time.
> 

Got it. By the way, what's the git repository of virtiofsd? AFAIK,
virtiofsd included in qemu (git@github.com:qemu/qemu.git) doesn't
support DAX yet?

-- 
Thanks,
Jeffle
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
