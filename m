Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E70C433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 06:52:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95F760FC1
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 06:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D95F760FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8AE64044E;
	Mon, 13 Sep 2021 06:52:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uNKroklC9LnG; Mon, 13 Sep 2021 06:52:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3CEA640449;
	Mon, 13 Sep 2021 06:52:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12DD6C0011;
	Mon, 13 Sep 2021 06:52:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F74EC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E0D0540249
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:52:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g1GYxmJ91sNA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:52:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DE526401EF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631515922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kl26xpXTnGYgFarHlszjYjC6hsL4Xd95eYecdgvpeDw=;
 b=fF/+P0eL+PEcumVQ9JMJfLBoaVbCqrsV5qQDLhgjZRjjJt38C1b9Bn4VUHPpNcMNgTGat3
 dIaJqFi5R5lXacls2lMLF3FpyhovMCmodgNf+wxdeQZD5K42RDLFgLO9gKDSCmLw13cOD4
 LAyvbGSGu7HBK0/sXABgpYGKZREqljs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-_OxL_xufMQGZlmKO28x_Cg-1; Mon, 13 Sep 2021 02:51:59 -0400
X-MC-Unique: _OxL_xufMQGZlmKO28x_Cg-1
Received: by mail-wr1-f69.google.com with SMTP id
 q14-20020a5d574e000000b00157b0978ddeso2298385wrw.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 23:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Kl26xpXTnGYgFarHlszjYjC6hsL4Xd95eYecdgvpeDw=;
 b=Sms4tGWUixnDtI4GrumhSwzGxPiO2cD4sxs+Cqq5zxosnTKTM3lHcVMnyeCqLovqVc
 yyHs1bUUJHKAdDIydUcRkIqyOMZ93lPfcvBtvGUP7n5SeCF6d2BwbAh64+qXyeVGdSzW
 KyF2hBwk6ORVxEttrCqw0r5E2YAm5J6ZNECLsmfH5ErInLic4DKPXnEdTRied1JY4W6S
 JqAuDkXmcdG2UQ0G96stdPQ3lVYa8s2FB8fd3F1x35g/KTsnjdSQo8DZxbH9yY2xbEl3
 x2FHWHFaUWbiIC4nwNx04lpLxbylGBXM7O/SNkvW8IrrcYDq8qGUVhkYztiNs/yqeBmH
 Vrtw==
X-Gm-Message-State: AOAM531ffHl82B1rhhZrm8Ma7n5+v/GqCSphZvWc+mHqW4xo7CWOpAte
 F4Xg+ybLY3j4s1VdqJg4tm+gF7+FglHg+pezFdJ/lXGuwZVSk0BZW0YYahOL13c30BInT1uMOSd
 vFf4LIsFKIsJ3buZ88xUcYjh3qYYbFGzod/hzQMR50IfooizIshlBgWhsQRrJFPCrx+iOHhEjio
 pw6cete8LiMuXzXym6
X-Received: by 2002:a1c:3184:: with SMTP id x126mr9319871wmx.123.1631515918073; 
 Sun, 12 Sep 2021 23:51:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/aMYfCMZS36L28j4NzgJRcpAIrASgnPhaikQ6W+JcGOCweIChh0CuuOAkAxXS6w5QjxMC7A==
X-Received: by 2002:a1c:3184:: with SMTP id x126mr9319858wmx.123.1631515917833; 
 Sun, 12 Sep 2021 23:51:57 -0700 (PDT)
Received: from [192.168.100.42] ([82.142.27.6])
 by smtp.gmail.com with ESMTPSA id i5sm6438470wrc.86.2021.09.12.23.51.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Sep 2021 23:51:56 -0700 (PDT)
Subject: Re: Use of uninitialized memory with CONFIG_HW_RANDOM_VIRTIO
To: Alexander Potapenko <glider@google.com>
References: <CAG_fn=WwQ29akxY1Eq=N_=HCF3t7z+T2obh9aRVUDFy1FSA3-Q@mail.gmail.com>
 <20210819165742-mutt-send-email-mst@kernel.org>
 <d0d232ab-5222-5eef-60de-e8cc0f2a0791@redhat.com>
 <CAG_fn=Um3Up2VyGOC0ezJ51N8AWZfGcWz+98cvwpBrJkby3+NA@mail.gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <639bbb70-eca8-97c5-7faa-8563e594d67a@redhat.com>
Date: Mon, 13 Sep 2021 08:51:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAG_fn=Um3Up2VyGOC0ezJ51N8AWZfGcWz+98cvwpBrJkby3+NA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: amit@kernel.org, rusty@rustcorp.com.au,
 virtualization@lists.linux-foundation.org,
 syzkaller <syzkaller@googlegroups.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 akong@redhat.com, Dmitriy Vyukov <dvyukov@google.com>
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

Hi Alexander,

On 12/09/2021 19:05, Alexander Potapenko wrote:
> Hi Laurent,
> 
> Do you by any chance have an update on this?

I'm sorry I didn't have the time until now.

I try today.

Could you give more details how to reproduce this?
(kernel version, .config, tools to run?)

Thanks,
Laurent
> Thanks,
> Alex
> 
> On Fri, Aug 20, 2021 at 6:15 PM Laurent Vivier <lvivier@redhat.com> wrote:
>>
>> On 19/08/2021 22:58, Michael S. Tsirkin wrote:
>>> On Fri, Nov 13, 2020 at 06:26:16PM +0100, Alexander Potapenko wrote:
>>>> Hi Amos, Rusty, Amit, Michael,
>>>>
>>>> I am hitting something that I believe to be a minor problem in the
>>>> virtio RNG driver.
>>>> When running the kernel under KMSAN with "-device virtio-rng-pci"
>>>> passed to QEMU, I am seeing reports about rng_fillbuf in
>>>> drivers/char/hw_random/core.c being used before initialization (see
>>>> the report below).
>>>>
>>>> This can be verified by initializing rng_fillbuf with 'A' as follows:
>>>> ==========================================
>>>> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
>>>> index 8c1c47dd9f46..44d609a5796a 100644
>>>> --- a/drivers/char/hw_random/core.c
>>>> +++ b/drivers/char/hw_random/core.c
>>>> @@ -439,8 +439,11 @@ static int hwrng_fillfn(void *unused)
>>>>                 if (IS_ERR(rng) || !rng)
>>>>                         break;
>>>>                 mutex_lock(&reading_mutex);
>>>> +               memset(rng_fillbuf, 'A', rng_buffer_size());
>>>> +               rng_fillbuf[rng_buffer_size()-1] = 0;
>>>>                 rc = rng_get_data(rng, rng_fillbuf,
>>>>                                   rng_buffer_size(), 1);
>>>> +               pr_err("rng_fillbuf: %s\n", rng_fillbuf);
>>>>                 mutex_unlock(&reading_mutex);
>>>>                 put_rng(rng);
>>>>                 if (rc <= 0) {
>>>> ==========================================
>>>>
>>>> and booting the kernel: the first call of hwrng_fillfn() will print
>>>> "AAAAAAA.." instead of random data.
>>>>
>>>> For some reason on that first iteration vi->busy is true here:
>>>> https://elixir.bootlin.com/linux/latest/source/drivers/char/hw_random/virtio-rng.c#L62,
>>>> therefore the buffer is not being sent to virtio ring.
>>>>
>>>> While probably being benign, this bug is preventing syzkaller from
>>>> finding more bugs, so it would be nice to fix it.
>>>> Perhaps the easiest solution is to kzalloc rng_fillbuf, but if it's
>>>> critical for this driver to not skip even the first read, then maybe
>>>> you have better ideas?
>>>>
>>>> KMSAN report follows:
>>>>
>>>> =====================================================
>>>> BUG: KMSAN: uninit-value in _mix_pool_bytes+0x7d2/0x950
>>>> drivers/char/random.c:570
>>>> CPU: 0 PID: 2711 Comm: hwrng Not tainted 5.9.0-rc8-syzkaller #0
>>>> Hardware name: Google Google Compute Engine/Google Compute Engine,
>>>> BIOS Google 01/01/2011
>>>> Call Trace:
>>>>  __dump_stack lib/dump_stack.c:77 [inline]
>>>>  dump_stack+0x21c/0x280 lib/dump_stack.c:118
>>>>  kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:122
>>>>  __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:201
>>>>  _mix_pool_bytes+0x7d2/0x950 drivers/char/random.c:570
>>>>  mix_pool_bytes+0xca/0x2a0 drivers/char/random.c:599
>>>>  add_hwgenerator_randomness+0x4ac/0x500 drivers/char/random.c:2319
>>>>  hwrng_fillfn+0x6ae/0x940 drivers/char/hw_random/core.c:452
>>>>  kthread+0x51c/0x560 kernel/kthread.c:293
>>>>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
>>>>
>>>> Uninit was created at:
>>>>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:129 [inline]
>>>>  kmsan_internal_poison_shadow+0x5c/0xf0 mm/kmsan/kmsan.c:112
>>>>  kmsan_slab_alloc+0x8d/0xe0 mm/kmsan/kmsan_hooks.c:80
>>>>  slab_alloc_node mm/slub.c:2903 [inline]
>>>>  slab_alloc mm/slub.c:2912 [inline]
>>>>  kmem_cache_alloc_trace+0x61e/0xc90 mm/slub.c:2929
>>>>  kmalloc include/linux/slab.h:554 [inline]
>>>>  hwrng_modinit+0x103/0x2ef drivers/char/hw_random/core.c:621
>>>>  do_one_initcall+0x371/0x9c0 init/main.c:1208
>>>>  do_initcall_level+0x1e5/0x3c6 init/main.c:1281
>>>>  do_initcalls+0x127/0x1cb init/main.c:1297
>>>>  do_basic_setup+0x33/0x36 init/main.c:1317
>>>>  kernel_init_freeable+0x238/0x38b init/main.c:1517
>>>>  kernel_init+0x1f/0x840 init/main.c:1406
>>>>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
>>>> =====================================================
>>>>
>>>> Thanks,
>>>> Alex
>>>
>>>
>>> Cc Laurent - I think he said he was going to look at virtio rng.
>>
>> I will have look next week.
>>
>> Thanks,
>> Laurent
>>
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
