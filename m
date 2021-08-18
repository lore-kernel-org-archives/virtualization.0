Return-Path: <SRS0=8Uya=NJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3963C4338F
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 05:20:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ABBA61051
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 05:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9ABBA61051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68BDD80CB9;
	Wed, 18 Aug 2021 05:20:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QuoVKiGyP3VK; Wed, 18 Aug 2021 05:20:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E5C5580CA5;
	Wed, 18 Aug 2021 05:20:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD887C001A;
	Wed, 18 Aug 2021 05:20:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35FFDC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 05:20:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C9734035D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 05:20:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j29gNTJkptnZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 05:20:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CD2DB400D2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 05:20:47 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=jefflexu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0UjdW34i_1629264044; 
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0UjdW34i_1629264044) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 18 Aug 2021 13:20:44 +0800
Subject: Re: [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
To: Vivek Goyal <vgoyal@redhat.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRut5sioYfc2M1p7@redhat.com>
 <6043c0b8-0ff1-2e11-0dd0-e23f9ff6b952@linux.alibaba.com>
 <YRvOZI3CvLsF96JA@redhat.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <bde1d657-0aa4-324d-064e-711efa893c2f@linux.alibaba.com>
Date: Wed, 18 Aug 2021 13:20:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRvOZI3CvLsF96JA@redhat.com>
Content-Language: en-US
Cc: Miklos Szeredi <miklos@szeredi.hu>,
 virtualization@lists.linux-foundation.org,
 virtio-fs-list <virtio-fs@redhat.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, Stefan Hajnoczi <stefanha@redhat.com>,
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



On 8/17/21 10:57 PM, Vivek Goyal wrote:
> On Tue, Aug 17, 2021 at 09:22:53PM +0800, JeffleXu wrote:
>>
>>
>> On 8/17/21 8:39 PM, Vivek Goyal wrote:
>>> On Tue, Aug 17, 2021 at 10:06:53AM +0200, Miklos Szeredi wrote:
>>>> On Tue, 17 Aug 2021 at 04:22, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
>>>>>
>>>>> This patchset adds support of per-file DAX for virtiofs, which is
>>>>> inspired by Ira Weiny's work on ext4[1] and xfs[2].
>>>>
>>>> Can you please explain the background of this change in detail?
>>>>
>>>> Why would an admin want to enable DAX for a particular virtiofs file
>>>> and not for others?
>>>
>>> Initially I thought that they needed it because they are downloading
>>> files on the fly from server. So they don't want to enable dax on the file
>>> till file is completely downloaded. 
>>
>> Right, it's our initial requirement.
>>
>>
>>> But later I realized that they should
>>> be able to block in FUSE_SETUPMAPPING call and make sure associated
>>> file section has been downloaded before returning and solve the problem.
>>> So that can't be the primary reason.
>>
>> Saying we want to access 4KB of one file inside guest, if it goes
>> through FUSE request routine, then the fuse daemon only need to download
>> this 4KB from remote server. But if it goes through DAX, then the fuse
>> daemon need to download the whole DAX window (e.g., 2MB) from remote
>> server, so called amplification. Maybe we could decrease the DAX window
>> size, but it's a trade off.
> 
> Downloading 2MB chunk should not be a big issue (IMHO). 

Then the latency increases. Latency really matters in our use case.


> And if this
> turns out to be real concern, we could experiment with a smaller
> mapping granularity.
> 


-- 
Thanks,
Jeffle
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
