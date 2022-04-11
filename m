Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1236C433F5
	for <virtualization@archiver.kernel.org>; Mon, 11 Apr 2022 02:10:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A39A4155C;
	Mon, 11 Apr 2022 02:10:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7c30q0OK0QZf; Mon, 11 Apr 2022 02:10:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 949554159A;
	Mon, 11 Apr 2022 02:10:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47B11C0033;
	Mon, 11 Apr 2022 02:10:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B904C002C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 02:10:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 428F4401D5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 02:10:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oRkkWFidulQ5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 02:10:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A3FAE400BA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 02:10:29 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R941e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0V9gdvlU_1649643023; 
Received: from 30.225.24.83(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V9gdvlU_1649643023) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 11 Apr 2022 10:10:24 +0800
Message-ID: <d5c1b2bc-78d1-c6f8-0fb0-512a702b6e3b@linux.alibaba.com>
Date: Mon, 11 Apr 2022 10:10:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH] fuse: avoid unnecessary spinlock bump
Content-Language: en-US
To: Vivek Goyal <vgoyal@redhat.com>
References: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
 <Yk7w8L1f/yik+qrR@redhat.com>
 <b7a50fac-0259-e56c-0445-cca3fbf99888@linux.alibaba.com>
 <YlAbqF4Yts8Aju+W@redhat.com>
 <586dd7bb-4218-63da-c7db-fe8d46f43cde@linux.alibaba.com>
 <YlAlR0xVDqQzl98w@redhat.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YlAlR0xVDqQzl98w@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 miklos@szeredi.hu
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



On 4/8/22 8:06 PM, Vivek Goyal wrote:
> On Fri, Apr 08, 2022 at 07:50:55PM +0800, JeffleXu wrote:
>>
>>
>> On 4/8/22 7:25 PM, Vivek Goyal wrote:
>>> On Fri, Apr 08, 2022 at 10:36:40AM +0800, JeffleXu wrote:
>>>>
>>>>
>>>> On 4/7/22 10:10 PM, Vivek Goyal wrote:
>>>>> On Sat, Apr 02, 2022 at 06:32:50PM +0800, Jeffle Xu wrote:
>>>>>> Move dmap free worker kicker inside the critical region, so that extra
>>>>>> spinlock lock/unlock could be avoided.
>>>>>>
>>>>>> Suggested-by: Liu Jiang <gerry@linux.alibaba.com>
>>>>>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>>>>>
>>>>> Looks good to me. Have you done any testing to make sure nothing is
>>>>> broken.
>>>>
>>>> xfstests -g quick shows no regression. The tested virtiofs is mounted
>>>> with "dax=always".
>>>
>>> I think xfstests might not trigger reclaim. You probably will have to
>>> run something like blogbench with a small dax window like 1G so that
>>> heavy reclaim happens.
>>
>>
>> Actually, I configured the DAX window to 8MB, i.e. 4 slots when running
>> xfstests. Thus I think the reclaim path is most likely triggered.
>>
>>
>>>
>>> For fun, I sometimes used to run it with a window of just say 16 dax
>>> ranges so that reclaim was so heavy that if there was a bug, it will
>>> show up.
>>>
>>
>> Yeah, my colleague had ever reported that a DAX window of 4KB will cause
>> hang in our internal OS (which is 4.19, we back ported virtiofs to
>> 4.19). But then I found that this issue doesn't exist in the latest
>> upstream. The reason seems that in the upstream kernel,
>> devm_memremap_pages() called in virtio_fs_setup_dax() will fail directly
>> since the dax window (4KB) is not aligned with the sparse memory section.
> 
> Given our default chunk size is 2MB (FUSE_DAX_SHIFT), may be it is not
> a bad idea to enforce some minimum cache window size. IIRC, even one
> range is not enough. Minimum 2 are required for reclaim to not deadlock.

Curiously, why minimum 1 range is not adequate? In which case minimum 2
are required?


-- 
Thanks,
Jeffle
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
