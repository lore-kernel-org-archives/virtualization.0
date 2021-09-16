Return-Path: <SRS0=0+SM=OG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC15C433F5
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 08:22:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8236113E
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 08:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA8236113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A0D5F40298;
	Thu, 16 Sep 2021 08:22:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id shFls63iiP84; Thu, 16 Sep 2021 08:22:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E964E400E6;
	Thu, 16 Sep 2021 08:22:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB14AC0011;
	Thu, 16 Sep 2021 08:22:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B0F3C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 08:22:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 06DE8406DF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 08:22:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4zEFvgECGNpt
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 08:22:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73BB5406CD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 08:22:04 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R471e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UoZbq6m_1631780519; 
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0UoZbq6m_1631780519) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 16 Sep 2021 16:22:00 +0800
Subject: Re: [Virtio-fs] [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
To: Vivek Goyal <vgoyal@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Miklos Szeredi <miklos@szeredi.hu>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRuCHvhICtTzMK04@work-vm> <YRuuRo8jEs5dkfw9@redhat.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <299689e9-bdeb-a715-3f31-8c70369cf0ba@linux.alibaba.com>
Date: Thu, 16 Sep 2021 16:21:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YRuuRo8jEs5dkfw9@redhat.com>
Content-Language: en-US
Cc: virtio-fs-list <virtio-fs@redhat.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
 Liu Bo <bo.liu@linux.alibaba.com>, virtualization@lists.linux-foundation.org
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

Hi, I add some performance statistics below.


On 8/17/21 8:40 PM, Vivek Goyal wrote:
> On Tue, Aug 17, 2021 at 10:32:14AM +0100, Dr. David Alan Gilbert wrote:
>> * Miklos Szeredi (miklos@szeredi.hu) wrote:
>>> On Tue, 17 Aug 2021 at 04:22, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
>>>>
>>>> This patchset adds support of per-file DAX for virtiofs, which is
>>>> inspired by Ira Weiny's work on ext4[1] and xfs[2].
>>>
>>> Can you please explain the background of this change in detail?
>>>
>>> Why would an admin want to enable DAX for a particular virtiofs file
>>> and not for others?
>>
>> Where we're contending on virtiofs dax cache size it makes a lot of
>> sense; it's quite expensive for us to map something into the cache
>> (especially if we push something else out), so selectively DAXing files
>> that are expected to be hot could help reduce cache churn.

Yes, the performance of dax can be limited when the DAX window is
limited, where dax window may be contended by multiple files.

I tested kernel compiling in virtiofs, emulating the scenario where a
lot of files contending dax window and triggering dax window reclaiming.

Environment setup:
- guest vCPU: 16
- time make vmlinux -j128

type    | cache  | cache-size | time
------- | ------ | ---------- | ----
non-dax | always |   --       | real 2m48.119s
dax     | always | 64M        | real 4m49.563s
dax     | always |   1G       | real 3m14.200s
dax     | always |   4G       | real 2m41.141s


It can be seen that there's performance drop, comparing to the normal
buffered IO, when dax window resource is restricted and dax window
relcaiming is triggered. The smaller the cache size is, the worse the
performance is. The performance drop can be alleviated and eliminated as
cache size increases.

Though we may not compile kernel in virtiofs, indeed we may access a lot
of small files in virtiofs and suffer this performance drop.


> In that case probaly we should just make DAX window larger. I assume

Yes, as the DAX window gets larger, it is less likely that we can run
short of dax window resource.

However it doesn't come without cost. 'struct page' descriptor for dax
window will consume guest memory at a ratio of ~1.5% (64/4096 = ~1.5%,
page descriptor is of 64 bytes size, assuming 4K sized page). That is,
every 1GB cache size will cost 16MB guest memory. As the cache size
increases, the memory footprint for page descriptors also increases,
which may offset the benefit of dax by eliminating guest page cache.

In summary, per-file dax feature tries to achieve a balance between
performance and memory overhead, by offering a finer gained control for
dax to users.


> that selecting which files to turn DAX on, will itself will not be
> a trivial. Not sure what heuristics are being deployed to determine
> that. Will like to know more about it.

Currently we enable dax for hot and large blob files, while disabling
dax for other miscellaneous small files.



-- 
Thanks,
Jeffle
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
