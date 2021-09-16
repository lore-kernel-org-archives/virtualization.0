Return-Path: <SRS0=0+SM=OG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6324C433F5
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 08:53:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C43D60F93
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 08:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C43D60F93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BCA5607AA;
	Thu, 16 Sep 2021 08:53:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gGKH5ZNo1bkB; Thu, 16 Sep 2021 08:53:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A1F8060636;
	Thu, 16 Sep 2021 08:53:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 738A5C000F;
	Thu, 16 Sep 2021 08:53:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8FE7C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 08:53:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C4C11606BD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 08:53:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XyKjiXf2NeCB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 08:53:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2EB3660636
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 08:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631782387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lLDtLsrMjT90Se2yvekEwSe1X6OCW5YZMNEdFSk68AU=;
 b=MRU1+HeQ6qFPiK03TJEl+hz7PBhX9nNlR3ps6PyIjxjKV28r5qp/3CggbaqTfpQhhr8h2z
 ow00QRbGx6po8KkU8pDGRNicjJF8DkM6Rpv0yizxzzMoSprACi/9SmI61gvZfR7N3Pk1sY
 BnoTGVMSmuuHvZrk6kAtwUm/7rHgE7k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-p-mdbR8rOWqYLI-38qllNQ-1; Thu, 16 Sep 2021 04:53:03 -0400
X-MC-Unique: p-mdbR8rOWqYLI-38qllNQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 c2-20020adfa302000000b0015e4260febdso841700wrb.20
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 01:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=lLDtLsrMjT90Se2yvekEwSe1X6OCW5YZMNEdFSk68AU=;
 b=qRi2nrEf7OdOaFexsx3eJe8LIHQQk7JCpW/Hu6hCoIxhO0mnpfV4bdPFuaumqcCmNu
 o/THTqRKwcWeYdtSJcOu5yURSvVdGqKHgyRj8o9x6fvAkefiiGS62uLAjm8Swf+C3h2Z
 Kd5sNO+alr+a/qTuIcKFvfkijAEL883GX9BhLSz9ZoCztR5+0B45Ndke+v7shMCSSq8R
 GJCD/mETBCSEeucKRz1zVv4LfCHue75Dd4UzWVX1HZEd/n3piPUS6nac40AUR1TYP61x
 4F/koI7DXn8pnO30HrE5q+fVIMPGGuEAhmW9x2K6aRF/MuBZqYM5UtXyYiKw1O5GI445
 JMuQ==
X-Gm-Message-State: AOAM53166qBWV/PrAoBqb3gM1yfnAzSLwMhG7YaVBuTZolM7FsPT+Wnv
 i+4tct3Yii/OaBNHhh3mtau/6pwi8hODGZNXn3SsxxYcq/CKMpY0nLnVOXstqM7B6BIqnPVrBNq
 JrQAT3+5P59tJwDXBPKSVLqRPHq2DRXKOlRlW4lTTgQ==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr4918082wrn.66.1631782381982;
 Thu, 16 Sep 2021 01:53:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzOLsRcqmDZeb4zhYgqlmHDUPtGz90zJw3LF70bMpv0zsFDHLwMaBguqNoE4suTAH8hdmPiQ==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr4918070wrn.66.1631782381722;
 Thu, 16 Sep 2021 01:53:01 -0700 (PDT)
Received: from [192.168.100.42] ([82.142.27.6])
 by smtp.gmail.com with ESMTPSA id l2sm7308232wmi.1.2021.09.16.01.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Sep 2021 01:53:01 -0700 (PDT)
Message-ID: <e4ecab9b-1d09-069f-1ef1-d8d5a3499826@redhat.com>
Date: Thu, 16 Sep 2021 10:52:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Use of uninitialized memory with CONFIG_HW_RANDOM_VIRTIO
To: Alexander Potapenko <glider@google.com>
References: <CAG_fn=WwQ29akxY1Eq=N_=HCF3t7z+T2obh9aRVUDFy1FSA3-Q@mail.gmail.com>
 <20210819165742-mutt-send-email-mst@kernel.org>
 <d0d232ab-5222-5eef-60de-e8cc0f2a0791@redhat.com>
 <CAG_fn=Um3Up2VyGOC0ezJ51N8AWZfGcWz+98cvwpBrJkby3+NA@mail.gmail.com>
 <639bbb70-eca8-97c5-7faa-8563e594d67a@redhat.com>
 <CAG_fn=VGU5A+JDC9mqksLbHHjHEJ6RSB9Ce2WVF9ysAHd=RWKg@mail.gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <CAG_fn=VGU5A+JDC9mqksLbHHjHEJ6RSB9Ce2WVF9ysAHd=RWKg@mail.gmail.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 13/09/2021 10:25, Alexander Potapenko wrote:
> Hi Laurent,
> 
> I took the latest kernel (5.15-rc1,
> 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f) and a slightly modified
> config from syzbot (see attached)
> The latter has a lot of unnecessary debug checks, but those should not
> affect the RNG.
> 
> You then need to apply the following patch to the kernel:
> 
> ====================================================
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> index a3db27916256d..a4cba9f0ff8cb 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -433,8 +433,11 @@ static int hwrng_fillfn(void *unused)
>                  if (IS_ERR(rng) || !rng)
>                          break;
>                  mutex_lock(&reading_mutex);
> +               memset(rng_fillbuf, 'A', rng_buffer_size());
> +               rng_fillbuf[rng_buffer_size()-1] = 0;
>                  rc = rng_get_data(rng, rng_fillbuf,
>                                    rng_buffer_size(), 1);
> +               pr_err("rng_fillbuf: %s\n", rng_fillbuf);
>                  mutex_unlock(&reading_mutex);
>                  put_rng(rng);
>                  if (rc <= 0) {
> ====================================================
> 
> and run the kernel under QEMU.
> 
> On my machine I'm seeing the following output:
> 
> $ cat log | strings | grep rng_fillbuf
> [    4.901931][  T897] rng_fillbuf:
> AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
> [    4.903104][  T897] rng_fillbuf: >
> [    4.903641][  T897] rng_fillbuf:
> [    4.904846][  T897] rng_fillbuf: ?
> [    4.913442][  T897] rng_fillbuf: [
> 
> , which denotes that the first call to rng_get_data() leaves
> rng_fillbuf uninitialized.


Thank you for the detailed steps.

The problem happens because we mix two different buffers:
- in add_early_randomness() we provide rng_buffer but don't wait it is full (see [1])
- in hwrng_fillfn() we provide rng_fillbuf, and we wait data here, but we received the 
signal from QEMU that there are data, but these data are in rng_buffer while we expect 
them in rng_fillbuf.

There are several ways to fix/workaround that:

1- ignore the read when wait=0 :

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index a90001e02bf7..8466d76566fd 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -59,15 +59,15 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool 
wait)
         if (vi->hwrng_removed)
                 return -ENODEV;

+       if (!wait)
+               return 0;
+
         if (!vi->busy) {
                 vi->busy = true;
                 reinit_completion(&vi->have_data);
                 register_buffer(vi, buf, size);
         }

-       if (!wait)
-               return 0;
-
         ret = wait_for_completion_killable(&vi->have_data);
         if (ret < 0)
                 return ret;


2- Use an internal intermediate buffer in virtio-rng, at a cost of a copy,
    I have some patches (somewhere) I can refresh to do that.

3- modify hw_random/core.c to use only one buffer

Thanks,
Laurent

[1] 78887832e765 ("hwrng: core - don't wait on add_early_randomness()")

> 
> HTH,
> Alex
> 
> On Mon, Sep 13, 2021 at 8:52 AM Laurent Vivier <lvivier@redhat.com> wrote:
>>
>> Hi Alexander,
>>
>> On 12/09/2021 19:05, Alexander Potapenko wrote:
>>> Hi Laurent,
>>>
>>> Do you by any chance have an update on this?
>>
>> I'm sorry I didn't have the time until now.
>>
>> I try today.
>>
>> Could you give more details how to reproduce this?
>> (kernel version, .config, tools to run?)
>>
>> Thanks,
>> Laurent
>>> Thanks,
>>> Alex
>>>
>>> On Fri, Aug 20, 2021 at 6:15 PM Laurent Vivier <lvivier@redhat.com> wrote:
>>>>
>>>> On 19/08/2021 22:58, Michael S. Tsirkin wrote:
>>>>> On Fri, Nov 13, 2020 at 06:26:16PM +0100, Alexander Potapenko wrote:
>>>>>> Hi Amos, Rusty, Amit, Michael,
>>>>>>
>>>>>> I am hitting something that I believe to be a minor problem in the
>>>>>> virtio RNG driver.
>>>>>> When running the kernel under KMSAN with "-device virtio-rng-pci"
>>>>>> passed to QEMU, I am seeing reports about rng_fillbuf in
>>>>>> drivers/char/hw_random/core.c being used before initialization (see
>>>>>> the report below).
>>>>>>
>>>>>> This can be verified by initializing rng_fillbuf with 'A' as follows:
>>>>>> ==========================================
>>>>>> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
>>>>>> index 8c1c47dd9f46..44d609a5796a 100644
>>>>>> --- a/drivers/char/hw_random/core.c
>>>>>> +++ b/drivers/char/hw_random/core.c
>>>>>> @@ -439,8 +439,11 @@ static int hwrng_fillfn(void *unused)
>>>>>>                  if (IS_ERR(rng) || !rng)
>>>>>>                          break;
>>>>>>                  mutex_lock(&reading_mutex);
>>>>>> +               memset(rng_fillbuf, 'A', rng_buffer_size());
>>>>>> +               rng_fillbuf[rng_buffer_size()-1] = 0;
>>>>>>                  rc = rng_get_data(rng, rng_fillbuf,
>>>>>>                                    rng_buffer_size(), 1);
>>>>>> +               pr_err("rng_fillbuf: %s\n", rng_fillbuf);
>>>>>>                  mutex_unlock(&reading_mutex);
>>>>>>                  put_rng(rng);
>>>>>>                  if (rc <= 0) {
>>>>>> ==========================================
>>>>>>
>>>>>> and booting the kernel: the first call of hwrng_fillfn() will print
>>>>>> "AAAAAAA.." instead of random data.
>>>>>>
>>>>>> For some reason on that first iteration vi->busy is true here:
>>>>>> https://elixir.bootlin.com/linux/latest/source/drivers/char/hw_random/virtio-rng.c#L62,
>>>>>> therefore the buffer is not being sent to virtio ring.
>>>>>>
>>>>>> While probably being benign, this bug is preventing syzkaller from
>>>>>> finding more bugs, so it would be nice to fix it.
>>>>>> Perhaps the easiest solution is to kzalloc rng_fillbuf, but if it's
>>>>>> critical for this driver to not skip even the first read, then maybe
>>>>>> you have better ideas?
>>>>>>
>>>>>> KMSAN report follows:
>>>>>>
>>>>>> =====================================================
>>>>>> BUG: KMSAN: uninit-value in _mix_pool_bytes+0x7d2/0x950
>>>>>> drivers/char/random.c:570
>>>>>> CPU: 0 PID: 2711 Comm: hwrng Not tainted 5.9.0-rc8-syzkaller #0
>>>>>> Hardware name: Google Google Compute Engine/Google Compute Engine,
>>>>>> BIOS Google 01/01/2011
>>>>>> Call Trace:
>>>>>>   __dump_stack lib/dump_stack.c:77 [inline]
>>>>>>   dump_stack+0x21c/0x280 lib/dump_stack.c:118
>>>>>>   kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:122
>>>>>>   __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:201
>>>>>>   _mix_pool_bytes+0x7d2/0x950 drivers/char/random.c:570
>>>>>>   mix_pool_bytes+0xca/0x2a0 drivers/char/random.c:599
>>>>>>   add_hwgenerator_randomness+0x4ac/0x500 drivers/char/random.c:2319
>>>>>>   hwrng_fillfn+0x6ae/0x940 drivers/char/hw_random/core.c:452
>>>>>>   kthread+0x51c/0x560 kernel/kthread.c:293
>>>>>>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
>>>>>>
>>>>>> Uninit was created at:
>>>>>>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:129 [inline]
>>>>>>   kmsan_internal_poison_shadow+0x5c/0xf0 mm/kmsan/kmsan.c:112
>>>>>>   kmsan_slab_alloc+0x8d/0xe0 mm/kmsan/kmsan_hooks.c:80
>>>>>>   slab_alloc_node mm/slub.c:2903 [inline]
>>>>>>   slab_alloc mm/slub.c:2912 [inline]
>>>>>>   kmem_cache_alloc_trace+0x61e/0xc90 mm/slub.c:2929
>>>>>>   kmalloc include/linux/slab.h:554 [inline]
>>>>>>   hwrng_modinit+0x103/0x2ef drivers/char/hw_random/core.c:621
>>>>>>   do_one_initcall+0x371/0x9c0 init/main.c:1208
>>>>>>   do_initcall_level+0x1e5/0x3c6 init/main.c:1281
>>>>>>   do_initcalls+0x127/0x1cb init/main.c:1297
>>>>>>   do_basic_setup+0x33/0x36 init/main.c:1317
>>>>>>   kernel_init_freeable+0x238/0x38b init/main.c:1517
>>>>>>   kernel_init+0x1f/0x840 init/main.c:1406
>>>>>>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
>>>>>> =====================================================
>>>>>>
>>>>>> Thanks,
>>>>>> Alex
>>>>>
>>>>>
>>>>> Cc Laurent - I think he said he was going to look at virtio rng.
>>>>
>>>> I will have look next week.
>>>>
>>>> Thanks,
>>>> Laurent
>>>>
>>>
>>>
>>
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
