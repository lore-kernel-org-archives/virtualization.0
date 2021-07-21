Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3786C636C9
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 12:35:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B796121F
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 12:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B796121F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29CAE60890;
	Wed, 21 Jul 2021 12:35:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6LS2FjWqlOwv; Wed, 21 Jul 2021 12:35:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8830060783;
	Wed, 21 Jul 2021 12:35:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 653BEC0010;
	Wed, 21 Jul 2021 12:35:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61270C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 12:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5009682EAD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 12:35:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b2wh4WVyeJxN
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 12:35:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C24982E4C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 12:35:35 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UgWonHl_1626870932; 
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0UgWonHl_1626870932) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 21 Jul 2021 20:35:33 +0800
Subject: Re: [PATCH v2 3/4] fuse: add per-file DAX flag
To: Vivek Goyal <vgoyal@redhat.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <20210716104753.74377-4-jefflexu@linux.alibaba.com>
 <YPXHWmiYXMNxxhf7@redhat.com>
 <99f346bf-e08d-3dad-d931-9d7aeb16ad08@linux.alibaba.com>
 <YPcmrK/XdPiFIisJ@redhat.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <da4671aa-1956-a244-61f9-1f820722f879@linux.alibaba.com>
Date: Wed, 21 Jul 2021 20:35:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPcmrK/XdPiFIisJ@redhat.com>
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



On 7/21/21 3:40 AM, Vivek Goyal wrote:
> On Tue, Jul 20, 2021 at 03:19:50PM +0800, JeffleXu wrote:
>>
>>
>> On 7/20/21 2:41 AM, Vivek Goyal wrote:
>>> On Fri, Jul 16, 2021 at 06:47:52PM +0800, Jeffle Xu wrote:
>>>> Add one flag for fuse_attr.flags indicating if DAX shall be enabled for
>>>> this file.
>>>>
>>>> When the per-file DAX flag changes for an *opened* file, the state of
>>>> the file won't be updated until this file is closed and reopened later.
>>>>
>>>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>>>
>>> [..]
>>>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>>>> index 36ed092227fa..90c9df10d37a 100644
>>>> --- a/include/uapi/linux/fuse.h
>>>> +++ b/include/uapi/linux/fuse.h
>>>> @@ -184,6 +184,9 @@
>>>>   *
>>>>   *  7.34
>>>>   *  - add FUSE_SYNCFS
>>>> + *
>>>> + *  7.35
>>>> + *  - add FUSE_ATTR_DAX
>>>>   */
>>>>  
>>>>  #ifndef _LINUX_FUSE_H
>>>> @@ -449,8 +452,10 @@ struct fuse_file_lock {
>>>>   * fuse_attr flags
>>>>   *
>>>>   * FUSE_ATTR_SUBMOUNT: Object is a submount root
>>>> + * FUSE_ATTR_DAX: Enable DAX for this file in per-file DAX mode
>>>>   */
>>>>  #define FUSE_ATTR_SUBMOUNT      (1 << 0)
>>>> +#define FUSE_ATTR_DAX		(1 << 1)
>>>
>>> Generic fuse changes (addition of FUSE_ATTR_DAX) should probably in
>>> a separate patch. 
>>
>> Got it.
>>
>>>
>>> I am not clear on one thing. If we are planning to rely on persistent
>>> inode attr (FS_XFLAG_DAX as per Documentation/filesystems/dax.rst), then
>>> why fuse server needs to communicate the state of that attr using a 
>>> flag? Can client directly query it?  I am not sure where at these
>>> attrs stored and if fuse protocol currently supports it.
>>
>> There are two issues.
>>
>> 1. FUSE server side: Algorithm of deciding whether DAX is enabled for a
>> file.
>>
>> As I previously replied in [1], FUSE server must enable DAX if the
>> backend file is flagged with FS_XFLAG_DAX, to make the FS_XFLAG_DAX
>> previously set by FUSE client effective.
>>
>> But I will argue that FUSE server also has the flexibility of the
>> algorithm implementation. Even if guest queries FS_XFLAG_DAX by
>> GETFLAGS/FSGETXATTR ioctl, FUSE server can still enable DAX when the
>> backend file is not FS_XFLAG_DAX flagged.
>>
>>
>> 2. The protocol between server and client.
>>
>> extending LOOKUP vs. LOOKUP + GETFLAGS/FSGETXATTR ioctl
>>
>> As I said in [1], client can directly query the FS_XFLAG_DAX flag, but
>> there will be one more round trip.
>>
>>
>> [1]
>> https://lore.kernel.org/linux-fsdevel/031efb1d-7c0d-35fb-c147-dcc3b6cac0ef@linux.alibaba.com/T/#m3f3407158b2c028694c85d82d0d6bd0387f4e24e
>>
>>>
>>> What about flag STATX_ATTR_DAX. We probably should report that too
>>> in stat if we are using dax on the inode?
>>>
>>
>> VFS will automatically report STATX_ATTR_DAX if inode is in DAX mode,
>> e.g., in vfs_getattr_nosec().
> 
> Good to know. Given user will know which files are using dax and 
> which ones are not, it is even more important to define semantics
> properly. In what cases DAX will be driven by FS_XFLAGS_DAX attr
> and in what cases DAX will completely be driven by server.
> 
> May be we should divide it in two patch series. First patch series
> implements "-o dax=inode" and server follows FS_XFLAGS_DAX attr
> and reports during lookup/getattr/..... 

Agreed, '-o dax=inode' and policy upon FS_XFLAG_DAX xattr could be
implemented as the first step.

> 
> And once that is merged this can be ehanced with "-o dax=server" where
> server is free to choose what files dax should be used on. Only if
> this is still needed.

I also need to discuss with my colleagues about our using case, and if
FS_XFLAG_DAX poly is enough.


-- 
Thanks,
Jeffle
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
