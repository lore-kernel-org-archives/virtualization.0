Return-Path: <SRS0=qgkY=OM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C013DC433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Sep 2021 08:16:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27D836124A
	for <virtualization@archiver.kernel.org>; Wed, 22 Sep 2021 08:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 27D836124A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D91BF40768;
	Wed, 22 Sep 2021 08:16:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yZ5_oIqCIzSM; Wed, 22 Sep 2021 08:16:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 736BE40746;
	Wed, 22 Sep 2021 08:16:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 442A8C0011;
	Wed, 22 Sep 2021 08:16:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3DF9C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 08:16:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D572560B5A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 08:16:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kJUV2qjBUcKf
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 08:16:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A741560B56
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 08:16:21 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UpCviSN_1632298576; 
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0UpCviSN_1632298576) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 22 Sep 2021 16:16:17 +0800
Subject: Re: [Virtio-fs] [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
To: Vivek Goyal <vgoyal@redhat.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRuCHvhICtTzMK04@work-vm> <YRuuRo8jEs5dkfw9@redhat.com>
 <299689e9-bdeb-a715-3f31-8c70369cf0ba@linux.alibaba.com>
 <YUeTP1B+JE5gGudq@redhat.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <ef66622c-586c-81e0-86a6-85e01af316c2@linux.alibaba.com>
Date: Wed, 22 Sep 2021 16:16:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUeTP1B+JE5gGudq@redhat.com>
Content-Language: en-US
Cc: Miklos Szeredi <miklos@szeredi.hu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 virtualization@lists.linux-foundation.org,
 virtio-fs-list <virtio-fs@redhat.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org
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

Thanks for the replying and suggesting. ;)


On 9/20/21 3:45 AM, Vivek Goyal wrote:
> On Thu, Sep 16, 2021 at 04:21:59PM +0800, JeffleXu wrote:
>> Hi, I add some performance statistics below.
>>
>>
>> On 8/17/21 8:40 PM, Vivek Goyal wrote:
>>> On Tue, Aug 17, 2021 at 10:32:14AM +0100, Dr. David Alan Gilbert wrote:
>>>> * Miklos Szeredi (miklos@szeredi.hu) wrote:
>>>>> On Tue, 17 Aug 2021 at 04:22, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
>>>>>>
>>>>>> This patchset adds support of per-file DAX for virtiofs, which is
>>>>>> inspired by Ira Weiny's work on ext4[1] and xfs[2].
>>>>>
>>>>> Can you please explain the background of this change in detail?
>>>>>
>>>>> Why would an admin want to enable DAX for a particular virtiofs file
>>>>> and not for others?
>>>>
>>>> Where we're contending on virtiofs dax cache size it makes a lot of
>>>> sense; it's quite expensive for us to map something into the cache
>>>> (especially if we push something else out), so selectively DAXing files
>>>> that are expected to be hot could help reduce cache churn.
>>
>> Yes, the performance of dax can be limited when the DAX window is
>> limited, where dax window may be contended by multiple files.
>>
>> I tested kernel compiling in virtiofs, emulating the scenario where a
>> lot of files contending dax window and triggering dax window reclaiming.
>>
>> Environment setup:
>> - guest vCPU: 16
>> - time make vmlinux -j128
>>
>> type    | cache  | cache-size | time
>> ------- | ------ | ---------- | ----
>> non-dax | always |   --       | real 2m48.119s
>> dax     | always | 64M        | real 4m49.563s
>> dax     | always |   1G       | real 3m14.200s
>> dax     | always |   4G       | real 2m41.141s
>>
>>
>> It can be seen that there's performance drop, comparing to the normal
>> buffered IO, when dax window resource is restricted and dax window
>> relcaiming is triggered. The smaller the cache size is, the worse the
>> performance is. The performance drop can be alleviated and eliminated as
>> cache size increases.
>>
>> Though we may not compile kernel in virtiofs, indeed we may access a lot
>> of small files in virtiofs and suffer this performance drop.
> 
> Hi Jeffle,
> 
> If you access lot of big files or a file bigger than dax window, still
> you will face performance drop due to reclaim. IOW, if data being
> accessed is bigger than dax window, then reclaim will trigger and
> performance drop will be observed. So I think its not fair to assciate
> performance drop with big for small files as such.

Yes, it is. Actually what I mean is that small files (with size smaller
than dax window chunk size) is more likely to consume more dax windows
compared to large files, under the same total file size.


> 
> What makes more sense is that memomry usage argument you have used
> later in the email. That is, we have a fixed chunk size of 2MB. And
> that means we use 512 * 64 = 32K of memory per chunk. So if a file
> is smaller than 32K in size, it might be better to just access it
> without DAX and incur the cost of page cache in guest instead. Even this
> argument also works only if dax window is being utilized fully.

Yes, agreed. In this case, the meaning of per-file dax is that, admin
could control the size of overall dax window under a limited number,
while still sustaining a reasonable performance. But at least, users are
capable of tuning it now.

> 
> Anyway, I think Miklos already asked you to send patches so that
> virtiofs daemon specifies which file to use dax on. So are you
> planning to post patches again for that. (And drop patches to
> read dax attr from per inode from filesystem in guest).

OK. I will send a new version, disabling dax based on the file size on
the host daemon side. Besides, I'm afraid the negotiation phase is also
not needed anymore, since currently the hint whether dax shall be
enabled or not is completely feeded from host daemon, and the guest side
needn't set/clear per inode dax attr now.

-- 
Thanks,
Jeffle
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
