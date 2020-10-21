Return-Path: <SRS0=2FsC=D4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F335AC55178
	for <virtualization@archiver.kernel.org>; Wed, 21 Oct 2020 14:19:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A75D2224E
	for <virtualization@archiver.kernel.org>; Wed, 21 Oct 2020 14:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxtUeUD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A75D2224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BB00886964;
	Wed, 21 Oct 2020 14:19:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id caXvDSn2yzyw; Wed, 21 Oct 2020 14:19:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B6420869B9;
	Wed, 21 Oct 2020 14:19:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96B93C0052;
	Wed, 21 Oct 2020 14:19:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA523C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 14:19:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D1EA786102
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 14:19:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZBhcdaVGz30A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 14:19:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f65.google.com (mail-ua1-f65.google.com
 [209.85.222.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 105E486101
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 14:19:01 +0000 (UTC)
Received: by mail-ua1-f65.google.com with SMTP id c1so698862uap.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 07:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OjMv92+4oU1Jh0KOe7rYhLDxGnwEq0TYxE8gqZwye8I=;
 b=pxtUeUD4lPmCkWzUTrMWaieU/qLdb3ndVcshp+AGw5M9jgNmSgKxhTFShTFQ1NBM1E
 mW2V9Oog1rFYQY0RRuhaC8xfiT7rs8M3ACbx8yAp48YvwF8ODRMa2+mSJNSVH3qVCd1n
 +cVB8OedpHsz7td37fQtX2cWO4EDasdM0rZ5bwWe3MRzPXMFyMwSwZ0FBZE0I5qlPVpN
 /tVvPOMxO8V9+rzZvpa3Ual6RWdmY3WtWJrj7iBQtho2+5Lg1PKjKq4d+ECi28g8patC
 jZzy/Xi1BL49TqewVix6QCHI///WBFCPUZh7s2ZRE/O3dNizAx77SYzjK9N7gOq5WQKl
 SLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OjMv92+4oU1Jh0KOe7rYhLDxGnwEq0TYxE8gqZwye8I=;
 b=ToYzLSu4wScBmoweCvOHez53+qfo2yYMi+P6eyFt2pUf0aCOaznCiOUvo6M5KGntge
 ztadSlmbqEIghZXX02utTi1GKjRWaWUFcVEs3RXyyM2/TciUv075x/5y6Gdarbd2/q9D
 rxzfK+H93tt6a6ZufTN/1TgDAeH/nsIV/hcrDg65e9a52zWPcQJuS2auGh6uJRLM8Plp
 LJed4Okq/kDsGJOC+aSTrqY80QdzI7MzVO3kf7CC0q34QJoaGlTXLFdcHYaQQ6M04M8i
 CRpNwEgu4t6EilJZ2KSEHvTMws6X69UJv8+WW1Qfd88wKtAT/IEs8Mq3aKk0zU7GAtsz
 omEA==
X-Gm-Message-State: AOAM531KNdYGwejWewztXBIs0DO+CCDbQWA4obawu36lLeD8NpwWPq/I
 UHja0ED3WjyIaoQVZu2i5NiG+AclSfM=
X-Google-Smtp-Source: ABdhPJyOVX4hG82vnR5G8TecpAuFcwnLnbTkDYTp8IUkOtVuNx2c1a0DglOmJU+GlHF0+dUv/DxzhQ==
X-Received: by 2002:ab0:48ae:: with SMTP id x43mr1881033uac.114.1603289938578; 
 Wed, 21 Oct 2020 07:18:58 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com.
 [209.85.217.52])
 by smtp.gmail.com with ESMTPSA id t5sm273658vsb.33.2020.10.21.07.18.57
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 07:18:57 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id w25so1309619vsk.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 07:18:57 -0700 (PDT)
X-Received: by 2002:a05:6102:398:: with SMTP id
 m24mr2117226vsq.14.1603289936531; 
 Wed, 21 Oct 2020 07:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201021115915.8286-1-mst@redhat.com>
In-Reply-To: <20201021115915.8286-1-mst@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 21 Oct 2020 10:18:20 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdorOgOUAAepP+q7MzU0GPi0OQ0sMVpaYu18GsE9TqxiA@mail.gmail.com>
Message-ID: <CA+FuTSdorOgOUAAepP+q7MzU0GPi0OQ0sMVpaYu18GsE9TqxiA@mail.gmail.com>
Subject: Re: [PATCH v3] Revert "virtio-net: ethtool configurable RXCSUM"
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

On Wed, Oct 21, 2020 at 8:00 AM Michael S. Tsirkin <mst@redhat.com> wrote:
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

Right. The fix might be to make the call to virtnet_set_guest_offloads
conditional again

-       err = virtnet_set_guest_offloads(vi, offloads);
-       if (err)
-               return err;
+       if (offloads ^ vi->guest_offloads) {
+               err = virtnet_set_guest_offloads(vi, offloads);
+               if (err)
+                       return err;
+       }

Whether the two features in virtnet_set_features are configurable at
all depends on whether they are part of dev->hw_features, which is
conditional on guest offload support:

        if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
                dev->hw_features |= NETIF_F_RXCSUM;
                dev->hw_features |= NETIF_F_LRO;
        }

so I had not expected virtnet_set_features to get called at all unless
this was enabled. Clearly an incorrect assumption.

The conservative solution is a  full revert and resubmitting a correct
new patch for net-next. Thanks for preparing the revert, sorry for the
breakage. Are you sending it for a third time because of the patchwork
quirk?

> If device does not have a control vq, everything breaks.
>
> Looking at this some more, I noticed that it's not really checking the
> hardware too much. E.g.
>
>         if ((dev->features ^ features) & NETIF_F_LRO) {
>                 if (features & NETIF_F_LRO)
>                         offloads |= GUEST_OFFLOAD_LRO_MASK &
>                                     vi->guest_offloads_capable;
>                 else
>                         offloads &= ~GUEST_OFFLOAD_LRO_MASK;
>         }
>
> and
>
>                                 (1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
>                                 (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
>                                 (1ULL << VIRTIO_NET_F_GUEST_UFO))
>
> But there's no guarantee that e.g. VIRTIO_NET_F_GUEST_TSO6 is set.
>
> If it isn't command should not send it.

It only toggles the subset of this mask that is agreed on at probe and
at that time stored in guest_offloads_capable. As Jason also
mentioned. I think this comment is obsolete.

        for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
                if (virtio_has_feature(vi->vdev, guest_offloads[i]))
                        set_bit(guest_offloads[i], &vi->guest_offloads);
        vi->guest_offloads_capable = vi->guest_offloads;
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
