Return-Path: <SRS0=U4FE=NK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F45C4320A
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 20:58:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1CC661029
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 20:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1CC661029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7051640001;
	Thu, 19 Aug 2021 20:58:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tbiJrzADc3Z6; Thu, 19 Aug 2021 20:58:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A20A74011D;
	Thu, 19 Aug 2021 20:58:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 740DCC001A;
	Thu, 19 Aug 2021 20:58:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EAA2C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 20:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F9B3600B3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 20:58:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LA2LIPw7ANK0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 20:58:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F0A46061D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 20:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629406714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2UHMerpqZ9eR069h1JBuFg7zOxooV3lEAS9zu/hg+/c=;
 b=DpYtFG6QGnrKsYByET2IRttC13xIVt6XeUlHFqgRkj5K38rHNhHhaU2t/ChAa1FjTbCSq9
 wQ/QJFXdpM7jdZZxvW8b/mFmFpgwlH2pXDoPBSa01ca3rXu8tnB93ppYruSmd2Js0eNFiK
 fMagahc5jFh0FvWtnH48Mf4e1eyXV54=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-SBPLr101O2u79bTgFvPMeA-1; Thu, 19 Aug 2021 16:58:31 -0400
X-MC-Unique: SBPLr101O2u79bTgFvPMeA-1
Received: by mail-ej1-f70.google.com with SMTP id
 h22-20020a170906719600b005bc74a33a63so2773156ejk.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 13:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=2UHMerpqZ9eR069h1JBuFg7zOxooV3lEAS9zu/hg+/c=;
 b=h1nyXRnzER7iiNuhFPmBH0znP2P3fLxrkZDBcSMvtbHPRsomhw335PyvNCYvnc8cDE
 huxTb0pSVIRhgkx/64hk7a1oIdpOrCTKaxYkHMLAS8dFCECZCqi5wjr4RmjV+AxEaStM
 /H8qvarVQ5dfCRtB00ZIofLAMSsyw0eqhBO4N1gGx5tvMcGgagmDzWPXqoIZeGQRz0Cg
 wotWhkJNZOD2Py3Y3og9QimTKnA/w3+Ye5gfaPjRVwIQ7eVYOb6ck5rj3Ex6QzdcEuJD
 uFLiHjaZLvJV8NE+t1itotEQYi+/MNzujhL20odTZcBeJmC4QJZzaB7kMcIGTqPB5yJe
 FT/g==
X-Gm-Message-State: AOAM533qDhkXEtWDeo6yM8ZkQXZkHn0uA73fb1RvsUS72NzUOlr6x/jl
 KUpGFBEdVPfzhFyfcb8YH2C52pJQQXltsJwE4yqScfS3M4vxbTvDipXN1vZ7hLLPR0AzgFdXG51
 wsf5y78s6Y4i7kVEvp2T+BvaNEWg6H6iUnDbmGqlL4Q==
X-Received: by 2002:aa7:d40e:: with SMTP id z14mr18796736edq.250.1629406710406; 
 Thu, 19 Aug 2021 13:58:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy65DUcopDhD9RE8G3tq56LZZGuM8sRyIax2Z3iB8RPCZVKilCkyTXN7VWm57VY1lQdwIHiMA==
X-Received: by 2002:aa7:d40e:: with SMTP id z14mr18796726edq.250.1629406710273; 
 Thu, 19 Aug 2021 13:58:30 -0700 (PDT)
Received: from redhat.com ([2.55.137.136])
 by smtp.gmail.com with ESMTPSA id p25sm1549075ejf.50.2021.08.19.13.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Aug 2021 13:58:29 -0700 (PDT)
Date: Thu, 19 Aug 2021 16:58:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Potapenko <glider@google.com>
Subject: Re: Use of uninitialized memory with CONFIG_HW_RANDOM_VIRTIO
Message-ID: <20210819165742-mutt-send-email-mst@kernel.org>
References: <CAG_fn=WwQ29akxY1Eq=N_=HCF3t7z+T2obh9aRVUDFy1FSA3-Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAG_fn=WwQ29akxY1Eq=N_=HCF3t7z+T2obh9aRVUDFy1FSA3-Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, amit@kernel.org, rusty@rustcorp.com.au,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Nov 13, 2020 at 06:26:16PM +0100, Alexander Potapenko wrote:
> Hi Amos, Rusty, Amit, Michael,
> =

> I am hitting something that I believe to be a minor problem in the
> virtio RNG driver.
> When running the kernel under KMSAN with "-device virtio-rng-pci"
> passed to QEMU, I am seeing reports about rng_fillbuf in
> drivers/char/hw_random/core.c being used before initialization (see
> the report below).
> =

> This can be verified by initializing rng_fillbuf with 'A' as follows:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> index 8c1c47dd9f46..44d609a5796a 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -439,8 +439,11 @@ static int hwrng_fillfn(void *unused)
>                 if (IS_ERR(rng) || !rng)
>                         break;
>                 mutex_lock(&reading_mutex);
> +               memset(rng_fillbuf, 'A', rng_buffer_size());
> +               rng_fillbuf[rng_buffer_size()-1] =3D 0;
>                 rc =3D rng_get_data(rng, rng_fillbuf,
>                                   rng_buffer_size(), 1);
> +               pr_err("rng_fillbuf: %s\n", rng_fillbuf);
>                 mutex_unlock(&reading_mutex);
>                 put_rng(rng);
>                 if (rc <=3D 0) {
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> and booting the kernel: the first call of hwrng_fillfn() will print
> "AAAAAAA.." instead of random data.
> =

> For some reason on that first iteration vi->busy is true here:
> https://elixir.bootlin.com/linux/latest/source/drivers/char/hw_random/vir=
tio-rng.c#L62,
> therefore the buffer is not being sent to virtio ring.
> =

> While probably being benign, this bug is preventing syzkaller from
> finding more bugs, so it would be nice to fix it.
> Perhaps the easiest solution is to kzalloc rng_fillbuf, but if it's
> critical for this driver to not skip even the first read, then maybe
> you have better ideas?
> =

> KMSAN report follows:
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in _mix_pool_bytes+0x7d2/0x950
> drivers/char/random.c:570
> CPU: 0 PID: 2711 Comm: hwrng Not tainted 5.9.0-rc8-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x21c/0x280 lib/dump_stack.c:118
>  kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:122
>  __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:201
>  _mix_pool_bytes+0x7d2/0x950 drivers/char/random.c:570
>  mix_pool_bytes+0xca/0x2a0 drivers/char/random.c:599
>  add_hwgenerator_randomness+0x4ac/0x500 drivers/char/random.c:2319
>  hwrng_fillfn+0x6ae/0x940 drivers/char/hw_random/core.c:452
>  kthread+0x51c/0x560 kernel/kthread.c:293
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> =

> Uninit was created at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:129 [inline]
>  kmsan_internal_poison_shadow+0x5c/0xf0 mm/kmsan/kmsan.c:112
>  kmsan_slab_alloc+0x8d/0xe0 mm/kmsan/kmsan_hooks.c:80
>  slab_alloc_node mm/slub.c:2903 [inline]
>  slab_alloc mm/slub.c:2912 [inline]
>  kmem_cache_alloc_trace+0x61e/0xc90 mm/slub.c:2929
>  kmalloc include/linux/slab.h:554 [inline]
>  hwrng_modinit+0x103/0x2ef drivers/char/hw_random/core.c:621
>  do_one_initcall+0x371/0x9c0 init/main.c:1208
>  do_initcall_level+0x1e5/0x3c6 init/main.c:1281
>  do_initcalls+0x127/0x1cb init/main.c:1297
>  do_basic_setup+0x33/0x36 init/main.c:1317
>  kernel_init_freeable+0x238/0x38b init/main.c:1517
>  kernel_init+0x1f/0x840 init/main.c:1406
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> =

> Thanks,
> Alex


Cc Laurent - I think he said he was going to look at virtio rng.


> -- =

> Alexander Potapenko
> Software Engineer
> =

> Google Germany GmbH
> Erika-Mann-Stra=DFe, 33
> 80636 M=FCnchen
> =

> Gesch=E4ftsf=FChrer: Paul Manicle, Halimah DeLaine Prado
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
