Return-Path: <SRS0=U4FE=NK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CC0C4338F
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 06:14:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308DF610FF
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 06:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 308DF610FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5DC1404B1;
	Thu, 19 Aug 2021 06:14:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hJbZ4pvzfQoF; Thu, 19 Aug 2021 06:14:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6C59140799;
	Thu, 19 Aug 2021 06:14:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3ED47C0010;
	Thu, 19 Aug 2021 06:14:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1A57C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 06:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 88FCE60825
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 06:14:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iFIcxL1cyV5N
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 06:14:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3ABF9607A1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 06:14:05 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0Ujyf7dO_1629353642; 
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0Ujyf7dO_1629353642) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 19 Aug 2021 14:14:03 +0800
Subject: Re: [Virtio-fs] [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
To: Vivek Goyal <vgoyal@redhat.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRuCHvhICtTzMK04@work-vm>
 <CAJfpegvM+S5Xru3Yfc88C64mecvco=f99y-TajQBDfkLD-S8zQ@mail.gmail.com>
 <0896b1f6-c8c4-6071-c05b-a333c6cccacd@linux.alibaba.com>
 <YRvNnmy5Mra/AUix@redhat.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <b36a4258-cba1-8185-3e23-78a7e4856fc1@linux.alibaba.com>
Date: Thu, 19 Aug 2021 14:14:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRvNnmy5Mra/AUix@redhat.com>
Content-Language: en-US
Cc: Miklos Szeredi <miklos@szeredi.hu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 virtualization@lists.linux-foundation.org,
 virtio-fs-list <virtio-fs@redhat.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
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



On 8/17/21 10:54 PM, Vivek Goyal wrote:
[...]
>>
>> As for virtiofs, Dr. David Alan Gilbert has mentioned that various files
>> may compete for limited DAX window resource.
>>
>> Besides, supporting DAX for small files can be expensive. Small files
>> can consume DAX window resource rapidly, and if small files are accessed
>> only once, the cost of mmap/munmap on host can not be ignored.
> 
> W.r.r access pattern, same applies to large files also. So if a section
> of large file is accessed only once, it will consume dax window as well
> and will have to be reclaimed.
> 
> Dax in virtiofs provides speed gain only if map file once and access
> it multiple times. If that pattern does not hold true, then dax does
> not seem to provide speed gains and in fact might be slower than
> non-dax.
> 
> So if there is a pattern where we know some files are accessed repeatedly
> while others are not, then enabling/disabling dax selectively will make
> sense. Question is how many workloads really know that and how will
> you make that decision. Do you have any data to back that up.

Empirically, some files are naturally accessed only once, such as
configuration files under /etc/ directory, .py, .js files, etc. It's the
real case that we have met in real world. While some others are most
likely accessed multiple times, such as .so libraries. With per-file DAX
feature, administrator can decide on their own which files shall be dax
enabled and thus gain most benefit from dax, while others not.

As for how we can distinguish the file access mode, besides the
intuitive insights described previously, we can develop more advanced
method distinguishing it, e.g., scanning the DAX window map and finding
the hot files. With the mechanism offered by kernel, more advanced
strategy can be developed then.

> 
> W.r.t small file, is that a real concern. If that file is being accessed
> mutliple times, then we will still see the speed gain. Only down side
> is that there is little wastage of resources because our minimum dax
> mapping granularity is 2MB. I am wondering can we handle that by
> supporting other dax mapping granularities as well. say 256K and let
> users choose it.
> 


-- 
Thanks,
Jeffle
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
