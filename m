Return-Path: <SRS0=Pjyk=MI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4798CC636C9
	for <virtualization@archiver.kernel.org>; Fri, 16 Jul 2021 01:59:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAA26128C
	for <virtualization@archiver.kernel.org>; Fri, 16 Jul 2021 01:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAA26128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2BCE60AF7;
	Fri, 16 Jul 2021 01:59:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Czs9zndUojx; Fri, 16 Jul 2021 01:59:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5BB7B60AF0;
	Fri, 16 Jul 2021 01:59:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F567C0010;
	Fri, 16 Jul 2021 01:59:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9B46C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 01:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C80E64163F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 01:59:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qI3sWPlBdVEx
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 01:59:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9DD864161F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 01:59:28 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R551e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0Ufw0Wkn_1626400764; 
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0Ufw0Wkn_1626400764) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 16 Jul 2021 09:59:25 +0800
Subject: Re: [RFC PATCH 3/3] fuse: add per-file DAX flag
To: Vivek Goyal <vgoyal@redhat.com>
References: <20210715093031.55667-1-jefflexu@linux.alibaba.com>
 <20210715093031.55667-4-jefflexu@linux.alibaba.com>
 <20210716004028.GA30967@rsjd01523.et2sqa> <YPDX9S3/TD3CL0CZ@redhat.com>
 <6d956097-47c1-5193-bbaa-faf14f0989ef@linux.alibaba.com>
 <YPDhv0JJHqbMCyXD@redhat.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <bfde6c40-4b67-fd24-0df1-21f0cf5a8fd1@linux.alibaba.com>
Date: Fri, 16 Jul 2021 09:59:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPDhv0JJHqbMCyXD@redhat.com>
Content-Language: en-US
Cc: linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Liu Bo <bo.liu@linux.alibaba.com>, stefanha@redhat.com, miklos@szeredi.hu
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



On 7/16/21 9:32 AM, Vivek Goyal wrote:
> On Fri, Jul 16, 2021 at 09:18:34AM +0800, JeffleXu wrote:
>>
>>
>> On 7/16/21 8:51 AM, Vivek Goyal wrote:
>>> On Fri, Jul 16, 2021 at 08:40:29AM +0800, Liu Bo wrote:
>>>> On Thu, Jul 15, 2021 at 05:30:31PM +0800, Jeffle Xu wrote:
>>>>> Add one flag for fuse_attr.flags indicating if DAX shall be enabled for
>>>>> this file.
>>>>>
>>>>> When the per-file DAX flag changes for an *opened* file, the state of
>>>>> the file won't be updated until this file is closed and reopened later.
>>>>>
>>>>> Currently it is not implemented yet to change per-file DAX flag inside
>>>>> guest kernel, e.g., by chattr(1).
>>>>
>>>> Thanks for the patch, it looks good to me.
>>>>
>>>> I think it's a good starting point, what I'd like to discuss here is
>>>> whether we're going to let chattr to toggle the dax flag.
>>>
>>> I have the same question. Why not take chattr approach as taken
>>> by ext4/xfs as well.
>>>
>>> Vivek
>>
>> Thanks.
>>
>> We can implement the chattr approach as ext4/xfs do, if we have this use
>> scenario. It's an RFC patch, and I want to collect more feedback as soon
>> as possible.
> 
> I guess chattr approach will allow client (as well as server) to control
> which files should be DAX. While this approach allows only server to
> specify which files should use DAX. Given currently we let client
> control whether to use dax or not (-o dax), it probably will make
> sense to use chattr based approach?

Yes, changing the per-file DAX flag from guest side, such as by chattr,
may be needed for completeness. I will include this in the next version.

> 
> I will look at the patches. Do you have a corresponding user space
> implementation somewhere so that I can test it?

Thanks. I have sent the corresponding patch in-reply-to your mail.

-- 
Thanks,
Jeffle
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
