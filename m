Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D80C12002
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 12:32:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B5661221
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 12:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B5661221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 97D11400C3;
	Wed, 21 Jul 2021 12:32:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lH8V0GzQTZ2D; Wed, 21 Jul 2021 12:32:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E0157400F7;
	Wed, 21 Jul 2021 12:32:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA7FDC0010;
	Wed, 21 Jul 2021 12:32:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 202CBC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 12:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F23BD4059F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 12:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 93zX5cFGamKO
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 12:32:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4EE914059E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 12:32:23 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UgWKU3Y_1626870739; 
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0UgWKU3Y_1626870739) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 21 Jul 2021 20:32:20 +0800
Subject: Re: [PATCH v2 0/4] virtiofs,fuse: support per-file DAX
To: Vivek Goyal <vgoyal@redhat.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <YPXu3BefIi7Ts48I@redhat.com>
 <031efb1d-7c0d-35fb-c147-dcc3b6cac0ef@linux.alibaba.com>
 <YPchgf665bwUMKWU@redhat.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <38e9da34-cc2b-f496-7ebb-18db8da1aa01@linux.alibaba.com>
Date: Wed, 21 Jul 2021 20:32:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPchgf665bwUMKWU@redhat.com>
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



On 7/21/21 3:18 AM, Vivek Goyal wrote:
> On Tue, Jul 20, 2021 at 01:25:11PM +0800, JeffleXu wrote:
>>
>>
>> On 7/20/21 5:30 AM, Vivek Goyal wrote:
>>> On Fri, Jul 16, 2021 at 06:47:49PM +0800, Jeffle Xu wrote:
>>>> This patchset adds support of per-file DAX for virtiofs, which is
>>>> inspired by Ira Weiny's work on ext4[1] and xfs[2].
>>>>
>>>> There are three related scenarios:
>>>> 1. Alloc inode: get per-file DAX flag from fuse_attr.flags. (patch 3)
>>>> 2. Per-file DAX flag changes when the file has been opened. (patch 3)
>>>> In this case, the dentry and inode are all marked as DONT_CACHE, and
>>>> the DAX state won't be updated until the file is closed and reopened
>>>> later.
>>>> 3. Users can change the per-file DAX flag inside the guest by chattr(1).
>>>> (patch 4)
>>>> 4. Create new files under directories with DAX enabled. When creating
>>>> new files in ext4/xfs on host, the new created files will inherit the
>>>> per-file DAX flag from the directory, and thus the new created files in
>>>> virtiofs will also inherit the per-file DAX flag if the fuse server
>>>> derives fuse_attr.flags from the underlying ext4/xfs inode's per-file
>>>> DAX flag.
>>>
>>> Thinking little bit more about this from requirement perspective. I think
>>> we are trying to address two use cases here.
>>>
>>> A. Client does not know which files DAX should be used on. Only server
>>>    knows it and server passes this information to client. I suspect
>>>    that's your primary use case.
>>
>> Yes, this is the starting point of this patch set.
>>
>>>
>>> B. Client is driving which files are supposed to be using DAX. This is
>>>    exactly same as the model ext4/xfs are using by storing a persistent
>>>    flag on inode. 
>>>
>>> Current patches seem to be a hybrid of both approach A and B. 
>>>
>>> If we were to implement B, then fuse client probably needs to have the
>>> capability to query FS_XFLAG_DAX on inode and decide whether to
>>> enable DAX or not. (Without extra round trip). Or know it indirectly
>>> by extending GETATTR and requesting this explicitly.
>>
>> If guest queries if the file is DAX capable or not by an extra GETATTR,
>> I'm afraid this will add extra round trip.
>>
>> Or if we add the DAX flag (ATTR_DAX) by extending LOOKUP, as done by
>> this patch set, then the FUSE server needs to set ATTR_DAX according to
>> the FS_XFLAG_DAX of the backend files, *to make the FS_XFLAG_DAX flag
>> previously set by FUSE client work*. Then it becomes a *mandatory*
>> requirement when implementing FUSE server. i.e., it becomes part of the
>> FUSE protocol rather than implementation specific. FUSE server can still
>> implement some other algorithm deciding whether to set ATTR_DAX or not,
>> though it must set ATTR_DAX once the backend file is flagged with
>> FS_XFLAG_DAX.
>>
>> Besides, as you said, FUSE server needs to add one extra
>> GETFLAGS/FSGETXATTR ioctl per LOOKUP in this case. To eliminate this
>> cost, we could negotiate the per-file DAX capability during FUSE_INIT.
>> Only when the per-file DAX capability is negotiated, will the FUSE
>> server do extra GETFLAGS/FSGETXATTR ioctl and set ATTR_DAX flag when
>> doing LOOKUP.
>>
>>
>> Personally, I prefer the second way, i.e., by extending LOOKUP (adding
>> ATTR_DAX), to eliminate the extra round trip.
> 
> Negotiating a fuse feature say FUSE_FS_XFLAG_DAX makes sense. If
> client is mounted with "-o dax=inode", then client will negotitate
> this feature and if server does not support it, mount can fail.
> 
> But this probably will be binding on server that it needs to return
> the state of FS_XFLAG_DAX attr on inode upon lookup/getattr. I don't
> this will allow server to implement its own separate policy which
> does not follow FS_XFLAG_DAX xattr. 

That means the backend fs must be ext4/xfs supporting per-file DAX feature.

If given more right to construct its own policy, FUSE server could
support per-file DAX upon other backend fs, though it will always fail
when virtiofs wants to set FS_XFLAG_DAX inside guest.

> 
> IOW, I don't think server can choose to implement its own policy
> for enabling dax for "-o dax=inode".
> 
> If there is really a need to for something new where server needs
> to dynamically decide which inodes should use dax (and not use
> FS_XFLAG_FS), I guess that probably should be a separate mount
> option say "-o dax=server" and it negotiates a separate feature
> say FUSE_DAX_SERVER. Once that's negotiated, now both client
> and server know that DAX will be used on files as determined
> by server and not necessarily by using file attr FS_XFLAG_DAX.
> 
> So is "dax=inode" enough for your needs? What's your requirement,
> can you give little bit of more details.

In our use case, the backend fs is something like SquashFS on host. The
content of the file on host is downloaded *as needed*. When the file is
not completely ready (completely downloaded), the guest will follow the
normal IO routine, i.e., by FUSE_READ/FUSE_WRITE request. While the file
is completely ready, per-file DAX is enabled for this file. IOW the FUSE
server need to dynamically decide if per-file DAX shall be enabled,
depending on if the file is completely downloaded.

Our strategy and design is still under discussion and may change. Any
comment and discussion is welcomed.

> 
>>
>>>
>>> If we were only implementing A, then server does not have a way to 
>>> tell client to enable DAX. Server can either look at FS_XFLAG_DAX
>>> and decide to enable DAX or use some other property. Given querying
>>> FS_XFLAG_DAX will be an extra ioctl() on every inode lookup/getattr,
>>> it probably will be a server option. But enabling on server does not
>>> mean client will enable it.
>>
>> As I said previously, it can be negotiated whether this per-file DAX
>> capability is needed. Guest can advertise this capability when '-o
>> dax=inode' is configured.
>>
>>>
>>> I think my primary concern with this patch right now is trying to
>>> figure out which requirement we are trying to cater to first and how
>>> to connect server and client well so they both understand what mode
>>> they are operating in and interact well.
>>>
>>
>>
>> -- 
>> Thanks,
>> Jeffle
>>

-- 
Thanks,
Jeffle
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
