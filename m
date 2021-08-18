Return-Path: <SRS0=8Uya=NJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3055CC4338F
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 05:11:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E0960249
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 05:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C4E0960249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 88221402B8;
	Wed, 18 Aug 2021 05:11:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aWPbCLkjtmGq; Wed, 18 Aug 2021 05:11:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D0A71400D2;
	Wed, 18 Aug 2021 05:11:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94547C001A;
	Wed, 18 Aug 2021 05:11:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31090C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 05:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 19649402F7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 05:11:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rP6Y3pOOnPgm
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 05:11:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BA886403AD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 05:11:00 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R611e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04420; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0Ujd6AJ2_1629263457; 
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0Ujd6AJ2_1629263457) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 18 Aug 2021 13:10:57 +0800
Subject: Re: [Virtio-fs] [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
To: Vivek Goyal <vgoyal@redhat.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRuCHvhICtTzMK04@work-vm>
 <CAJfpegvM+S5Xru3Yfc88C64mecvco=f99y-TajQBDfkLD-S8zQ@mail.gmail.com>
 <0896b1f6-c8c4-6071-c05b-a333c6cccacd@linux.alibaba.com>
 <YRvNnmy5Mra/AUix@redhat.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <509ea06b-27db-63f9-d32f-563f2f6c2290@linux.alibaba.com>
Date: Wed, 18 Aug 2021 13:10:57 +0800
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
> On Tue, Aug 17, 2021 at 09:08:35PM +0800, JeffleXu wrote:
>>
>>
>> On 8/17/21 6:09 PM, Miklos Szeredi wrote:
>>> On Tue, 17 Aug 2021 at 11:32, Dr. David Alan Gilbert
>>> <dgilbert@redhat.com> wrote:
>>>>
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
>>>
>>> If this is a performance issue, it should be fixed in a way that
>>> doesn't require hand tuning like you suggest, I think.
>>>
>>> I'm not sure what the  ext4/xfs case for per-file DAX is.  Maybe that
>>> can help understand the virtiofs case as well.
>>>
>>
>> Some hints why ext4/xfs support per-file DAX can be found [1] and [2].
>>
>> "Boaz Harrosh wondered why someone might want to turn DAX off for a
>> persistent memory device. Hellwig said that the performance "could
>> suck"; Williams noted that the page cache could be useful for some
>> applications as well. Jan Kara pointed out that reads from persistent
>> memory are close to DRAM speed, but that writes are not; the page cache
>> could be helpful for frequent writes. Applications need to change to
>> fully take advantage of DAX, Williams said; part of the promise of
>> adding a flag is that users can do DAX on smaller granularities than a
>> full filesystem."
>>
>> In summary, page cache is preferable in some cases, and thus more fine
>> grained way of DAX control is needed.
> 
> In case of virtiofs, we are using page cache on host. So this probably
> is not a factor for us. Writes will go in page cache of host.
> 
>>
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

There's no precise performance data yet. Empirically, small files used
to have worse performance with dax, while frequently accessed files
(such as .so libraries) behave better with dax.

> 
> W.r.t small file, is that a real concern. If that file is being accessed
> mutliple times, then we will still see the speed gain. Only down side
> is that there is little wastage of resources because our minimum dax
> mapping granularity is 2MB. I am wondering can we handle that by
> supporting other dax mapping granularities as well. say 256K and let
> users choose it.


-- 
Thanks,
Jeffle
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
