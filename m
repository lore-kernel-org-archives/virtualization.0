Return-Path: <SRS0=2FsC=D4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBC2C388F9
	for <virtualization@archiver.kernel.org>; Wed, 21 Oct 2020 14:34:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84C4F22249
	for <virtualization@archiver.kernel.org>; Wed, 21 Oct 2020 14:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhHKSipK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C4F22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E7A0387403;
	Wed, 21 Oct 2020 14:34:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zP73LGPFN7Z3; Wed, 21 Oct 2020 14:34:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3CEB887219;
	Wed, 21 Oct 2020 14:34:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E52AC0052;
	Wed, 21 Oct 2020 14:34:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18793C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 14:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 13C90855FE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 14:34:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BnJrUFfMLwEL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 14:34:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f67.google.com (mail-ua1-f67.google.com
 [209.85.222.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5BC9E855D1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 14:34:18 +0000 (UTC)
Received: by mail-ua1-f67.google.com with SMTP id x26so720544uau.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VmRKVQeRsF5XXdxrVGzoz/VPiQ1G/DrEd5eWr/793iM=;
 b=IhHKSipK6sX/mITywnB42dvTSeILc1wMT0ISsC1r4OnOF6ON6M5yEkOw+PaQOM9i2I
 WUdUr89l2WpLNCmW8VRTMoCNBFqXMihiNngIpZ+HiVJdr1jFuGVjjCMEOUifu3pRAAbh
 DFfed1lcby+zWbYVttxksMQHFcR6OQcHEFfWxnTHj5CN5tY0a3w1tTWEhofIwP8N5NNT
 7RIMn4q+dDYJ6Y11WLpE/nUXKyHMeAdB/FvPlfGXD8YDmzS0J5PqWmI1B1VvUPiVwS3S
 1+mQPdhK93QDmCExjEHzN4QTkzwgE/mxWhmWXdkrmMQDSFYh3wrBvfsOlQlbZ4Z31hpD
 M3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VmRKVQeRsF5XXdxrVGzoz/VPiQ1G/DrEd5eWr/793iM=;
 b=bz7ctjLPvEBeIPMgbXyKCWNlwv6JYun6hGWxCR/B3ZPdbcCz52jadimtExABn9S75e
 3IEW2hSKYaGtjI/3P5C9IHaD7dDaGKuddPjbX3kwaNw2LivMVhxnaWvIUQ6T8FIdyNoZ
 uSz82JqBshKkUGtQNGBXDAdM9UujofPfl7yiiEyJnXokDqm1SUXSx7n/sl0Q0ZA52wg6
 1Hrz9BFIpsVk7XhuYCd6o+l+bDDNG89J+eSjwnAQLeHITMA7awxmkYIvfo3kDjG5JlCv
 G8UNAh54sTUDBZNib/CIUcdz6SVdUadqWlorjAKF4EolYV0+4HeKVPiyZt5HPjdMx+0l
 DykA==
X-Gm-Message-State: AOAM533fhv+i2j6PyUGppKckDGjkcikuVRtynisusGw0AUZCQhMk/TRa
 Ok69NBaqFzVVmAKvjHpm9zllP9uOU4E=
X-Google-Smtp-Source: ABdhPJzFlzVNcU/1BRFvhofNdXSCJUAEOJTbr7p+ToH1YcZfOT6DGnPWoyY5PeaGe3ibvel/foaoFA==
X-Received: by 2002:ab0:314b:: with SMTP id e11mr1918282uam.117.1603290856784; 
 Wed, 21 Oct 2020 07:34:16 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com.
 [209.85.217.52])
 by smtp.gmail.com with ESMTPSA id h7sm304565vsc.31.2020.10.21.07.34.13
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 07:34:14 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id p9so1372566vsl.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 07:34:13 -0700 (PDT)
X-Received: by 2002:a67:7704:: with SMTP id s4mr2165928vsc.51.1603290853086;
 Wed, 21 Oct 2020 07:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201021142944.13615-1-mst@redhat.com>
In-Reply-To: <20201021142944.13615-1-mst@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 21 Oct 2020 10:33:37 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdG=mPvSWpGLqoQ1YB0duQQvOkkV+KPW3BBTHGStS5_Qg@mail.gmail.com>
Message-ID: <CA+FuTSdG=mPvSWpGLqoQ1YB0duQQvOkkV+KPW3BBTHGStS5_Qg@mail.gmail.com>
Subject: Re: [PATCH v4] Revert "virtio-net: ethtool configurable RXCSUM"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kernel test robot <lkp@intel.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>
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

On Wed, Oct 21, 2020 at 10:30 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> This reverts commit 3618ad2a7c0e78e4258386394d5d5f92a3dbccf8.
>
> When control vq is not negotiated, that commit causes a crash:
>
> [   72.229171] kernel BUG at drivers/net/virtio_net.c:1667!
> [   72.230266] invalid opcode: 0000 [#1] PREEMPT SMP
> [   72.231172] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc8-02934-g3618ad2a7c0e7 #1
> [   72.231172] EIP: virtnet_send_command+0x120/0x140
> [   72.231172] Code: 00 0f 94 c0 8b 7d f0 65 33 3d 14 00 00 00 75 1c 8d 65 f4 5b 5e 5f 5d c3 66 90 be 01 00 00 00 e9 6e ff ff ff 8d b6 00
> +00 00 00 <0f> 0b e8 d9 bb 82 00 eb 17 8d b4 26 00 00 00 00 8d b4 26 00 00 00
> [   72.231172] EAX: 0000000d EBX: f72895c0 ECX: 00000017 EDX: 00000011
> [   72.231172] ESI: f7197800 EDI: ed69bd00 EBP: ed69bcf4 ESP: ed69bc98
> [   72.231172] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
> [   72.231172] CR0: 80050033 CR2: 00000000 CR3: 02c84000 CR4: 000406f0
> [   72.231172] Call Trace:
> [   72.231172]  ? __virt_addr_valid+0x45/0x60
> [   72.231172]  ? ___cache_free+0x51f/0x760
> [   72.231172]  ? kobject_uevent_env+0xf4/0x560
> [   72.231172]  virtnet_set_guest_offloads+0x4d/0x80
> [   72.231172]  virtnet_set_features+0x85/0x120
> [   72.231172]  ? virtnet_set_guest_offloads+0x80/0x80
> [   72.231172]  __netdev_update_features+0x27a/0x8e0
> [   72.231172]  ? kobject_uevent+0xa/0x20
> [   72.231172]  ? netdev_register_kobject+0x12c/0x160
> [   72.231172]  register_netdevice+0x4fe/0x740
> [   72.231172]  register_netdev+0x1c/0x40
> [   72.231172]  virtnet_probe+0x728/0xb60
> [   72.231172]  ? _raw_spin_unlock+0x1d/0x40
> [   72.231172]  ? virtio_vdpa_get_status+0x1c/0x20
> [   72.231172]  virtio_dev_probe+0x1c6/0x271
> [   72.231172]  really_probe+0x195/0x2e0
> [   72.231172]  driver_probe_device+0x26/0x60
> [   72.231172]  device_driver_attach+0x49/0x60
> [   72.231172]  __driver_attach+0x46/0xc0
> [   72.231172]  ? device_driver_attach+0x60/0x60
> [   72.231172]  bus_add_driver+0x197/0x1c0
> [   72.231172]  driver_register+0x66/0xc0
> [   72.231172]  register_virtio_driver+0x1b/0x40
> [   72.231172]  virtio_net_driver_init+0x61/0x86
> [   72.231172]  ? veth_init+0x14/0x14
> [   72.231172]  do_one_initcall+0x76/0x2e4
> [   72.231172]  ? rdinit_setup+0x2a/0x2a
> [   72.231172]  do_initcalls+0xb2/0xd5
> [   72.231172]  kernel_init_freeable+0x14f/0x179
> [   72.231172]  ? rest_init+0x100/0x100
> [   72.231172]  kernel_init+0xd/0xe0
> [   72.231172]  ret_from_fork+0x1c/0x30
> [   72.231172] Modules linked in:
> [   72.269563] ---[ end trace a6ebc4afea0e6cb1 ]---
>
> The reason is that virtnet_set_features now calls virtnet_set_guest_offloads
> unconditionally, it used to only call it when there is something
> to configure.
>
> If device does not have a control vq, everything breaks.
>
> Revert the original commit for now.
>
> Cc: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Fixes: 3618ad2a7c0e7 ("virtio-net: ethtool configurable RXCSUM")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Willem de Bruijn <willemb@google.com>

Thanks Michael.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
