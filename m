Return-Path: <SRS0=poyg=NL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69C6C4338F
	for <virtualization@archiver.kernel.org>; Fri, 20 Aug 2021 16:17:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E4660F58
	for <virtualization@archiver.kernel.org>; Fri, 20 Aug 2021 16:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 82E4660F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 47F5740105;
	Fri, 20 Aug 2021 16:17:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZnhP0l3AoG75; Fri, 20 Aug 2021 16:17:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 84C89401D5;
	Fri, 20 Aug 2021 16:17:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C59BC0010;
	Fri, 20 Aug 2021 16:17:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EDF0C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 16:17:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D9A2613F3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 16:17:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ka_oAWRPco6r
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 16:16:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D97560623
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 16:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629476215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/Y9AMOFZpn9Mffh7q3wgNMYJ0d8FeTKYvbaQITK9EY=;
 b=jBIbqeP2MDxvcs8ZT+JdPxS0CwDl9tNla4HOMFjv/4SfmVxi1QCdwd1f0bfk4wI4EwWTcy
 0eskKdegL8XVVyL/zeNzhHKgsiR8b/C3A3P5AhS0W41SmIkS4qYx97/Yjhl8Rm7o0vOuda
 i8GRMS3dB1Q87aOsqq7OIUDZePHk1RU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-e_FDsoCiMcihLtXbfFjmeA-1; Fri, 20 Aug 2021 12:15:45 -0400
X-MC-Unique: e_FDsoCiMcihLtXbfFjmeA-1
Received: by mail-wm1-f71.google.com with SMTP id
 n20-20020a05600c4f9400b002e6dc6a99b9so2553952wmq.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 09:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T/Y9AMOFZpn9Mffh7q3wgNMYJ0d8FeTKYvbaQITK9EY=;
 b=YcFp9dBSQMIjtnFuzFd5NxoJ09+aF8VrMFOrACTukRqDiTbN76uWl1fAV4zp99foMH
 E0tbecaEpCvX+S552058O1QPsytf5ooBRJzSHPaX9IE/ckAIH2XccCz1ellvKZIIE5Bi
 t/vDnZ9W5tk5k7ptc7y3xnCWKmTBRuY4DHNusm9xjnlQ3HQ2yNFdqaU0fpEKY/qePAWM
 1RLyKgqhrG4jMMLHI1U/WKGSV4XNmIbDJYKp7oJvXnS5DmQrYE2symcG1QpS5DH53SJF
 SV8uoVHEnkMazlwcaIUTcB+Du81RsuVvGRpOHhASXgs6VV2r4C3II1cRZfYys7jwBSEI
 /2gQ==
X-Gm-Message-State: AOAM531B65uFoVB8k29AvmWRHc2ya2IXtB7Nb0zt+KQMGQ/vkwvueQcH
 C05P1nNo98Jw2iMkVPYysuQsbsWqxkF1/HWdZn4WVemET9Hk9xoNOFvPzn28WgvAq08hba7DuNa
 zDmS8VFC89pIBHvctCc10VQHHr5s4awBHt38FbyaoB+2pam1A20HiSDQrNrphCtDPcZ+G8rrD/b
 IwbqBNsyN5Z+l+ct2t
X-Received: by 2002:a5d:54c3:: with SMTP id x3mr4525029wrv.208.1629476143990; 
 Fri, 20 Aug 2021 09:15:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBcg3k9npU4dMY2BmnjMv373xUAuZtdDBkvqrQ75S6Aev6kI6/TmatYJMuLecD4GmQyZL7Ng==
X-Received: by 2002:a5d:54c3:: with SMTP id x3mr4524993wrv.208.1629476143725; 
 Fri, 20 Aug 2021 09:15:43 -0700 (PDT)
Received: from [192.168.100.42] ([82.142.22.194])
 by smtp.gmail.com with ESMTPSA id 18sm12213057wmv.27.2021.08.20.09.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Aug 2021 09:15:42 -0700 (PDT)
Subject: Re: Use of uninitialized memory with CONFIG_HW_RANDOM_VIRTIO
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Potapenko <glider@google.com>
References: <CAG_fn=WwQ29akxY1Eq=N_=HCF3t7z+T2obh9aRVUDFy1FSA3-Q@mail.gmail.com>
 <20210819165742-mutt-send-email-mst@kernel.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <d0d232ab-5222-5eef-60de-e8cc0f2a0791@redhat.com>
Date: Fri, 20 Aug 2021 18:15:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819165742-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: amit@kernel.org, rusty@rustcorp.com.au,
 virtualization@lists.linux-foundation.org,
 syzkaller <syzkaller@googlegroups.com>, akong@redhat.com,
 Dmitriy Vyukov <dvyukov@google.com>
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

On 19/08/2021 22:58, Michael S. Tsirkin wrote:
> On Fri, Nov 13, 2020 at 06:26:16PM +0100, Alexander Potapenko wrote:
>> Hi Amos, Rusty, Amit, Michael,
>>
>> I am hitting something that I believe to be a minor problem in the
>> virtio RNG driver.
>> When running the kernel under KMSAN with "-device virtio-rng-pci"
>> passed to QEMU, I am seeing reports about rng_fillbuf in
>> drivers/char/hw_random/core.c being used before initialization (see
>> the report below).
>>
>> This can be verified by initializing rng_fillbuf with 'A' as follows:
>> ==========================================
>> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
>> index 8c1c47dd9f46..44d609a5796a 100644
>> --- a/drivers/char/hw_random/core.c
>> +++ b/drivers/char/hw_random/core.c
>> @@ -439,8 +439,11 @@ static int hwrng_fillfn(void *unused)
>>                 if (IS_ERR(rng) || !rng)
>>                         break;
>>                 mutex_lock(&reading_mutex);
>> +               memset(rng_fillbuf, 'A', rng_buffer_size());
>> +               rng_fillbuf[rng_buffer_size()-1] = 0;
>>                 rc = rng_get_data(rng, rng_fillbuf,
>>                                   rng_buffer_size(), 1);
>> +               pr_err("rng_fillbuf: %s\n", rng_fillbuf);
>>                 mutex_unlock(&reading_mutex);
>>                 put_rng(rng);
>>                 if (rc <= 0) {
>> ==========================================
>>
>> and booting the kernel: the first call of hwrng_fillfn() will print
>> "AAAAAAA.." instead of random data.
>>
>> For some reason on that first iteration vi->busy is true here:
>> https://elixir.bootlin.com/linux/latest/source/drivers/char/hw_random/virtio-rng.c#L62,
>> therefore the buffer is not being sent to virtio ring.
>>
>> While probably being benign, this bug is preventing syzkaller from
>> finding more bugs, so it would be nice to fix it.
>> Perhaps the easiest solution is to kzalloc rng_fillbuf, but if it's
>> critical for this driver to not skip even the first read, then maybe
>> you have better ideas?
>>
>> KMSAN report follows:
>>
>> =====================================================
>> BUG: KMSAN: uninit-value in _mix_pool_bytes+0x7d2/0x950
>> drivers/char/random.c:570
>> CPU: 0 PID: 2711 Comm: hwrng Not tainted 5.9.0-rc8-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine,
>> BIOS Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x21c/0x280 lib/dump_stack.c:118
>>  kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:122
>>  __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:201
>>  _mix_pool_bytes+0x7d2/0x950 drivers/char/random.c:570
>>  mix_pool_bytes+0xca/0x2a0 drivers/char/random.c:599
>>  add_hwgenerator_randomness+0x4ac/0x500 drivers/char/random.c:2319
>>  hwrng_fillfn+0x6ae/0x940 drivers/char/hw_random/core.c:452
>>  kthread+0x51c/0x560 kernel/kthread.c:293
>>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
>>
>> Uninit was created at:
>>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:129 [inline]
>>  kmsan_internal_poison_shadow+0x5c/0xf0 mm/kmsan/kmsan.c:112
>>  kmsan_slab_alloc+0x8d/0xe0 mm/kmsan/kmsan_hooks.c:80
>>  slab_alloc_node mm/slub.c:2903 [inline]
>>  slab_alloc mm/slub.c:2912 [inline]
>>  kmem_cache_alloc_trace+0x61e/0xc90 mm/slub.c:2929
>>  kmalloc include/linux/slab.h:554 [inline]
>>  hwrng_modinit+0x103/0x2ef drivers/char/hw_random/core.c:621
>>  do_one_initcall+0x371/0x9c0 init/main.c:1208
>>  do_initcall_level+0x1e5/0x3c6 init/main.c:1281
>>  do_initcalls+0x127/0x1cb init/main.c:1297
>>  do_basic_setup+0x33/0x36 init/main.c:1317
>>  kernel_init_freeable+0x238/0x38b init/main.c:1517
>>  kernel_init+0x1f/0x840 init/main.c:1406
>>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
>> =====================================================
>>
>> Thanks,
>> Alex
> 
> 
> Cc Laurent - I think he said he was going to look at virtio rng.

I will have look next week.

Thanks,
Laurent

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
