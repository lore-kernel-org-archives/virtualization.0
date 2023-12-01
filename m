Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C8446A5
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 05:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtiHjif6"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0C4D8455B
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 05:16:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0C4D8455B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZtiHjif6
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JUuoof5NL341
	for <virtualization@lists.linux-foundation.org>;
	Fri,  1 Dec 2023 05:16:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C75748454D
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 05:16:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C75748454D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701407772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RO9dlLuPVsPspGkvaReqOeQPvfarrlXS7rOWsP5RM2E=;
	b=ZtiHjif6qOuTxuMrtGOF/g52u9SYJ6fNz4OFdkpKX/XmIM2VCO+gRwqm5v0Ye5Ci27qIRP
	PzYMA2msH8xfMqk83W3oh+tac28AcU57fjP3zAJgYo7h9hgMuQDcLMgFvKPJm3lBl+XIpA
	gfNY1gjCimOl/MM7jBqKqdC4uzoz4wE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-6u28HJvTMhqe5vOu5QoVMg-1; Fri, 01 Dec 2023 00:16:11 -0500
X-MC-Unique: 6u28HJvTMhqe5vOu5QoVMg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50bc71772e2so2008894e87.1
        for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 21:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701407770; x=1702012570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RO9dlLuPVsPspGkvaReqOeQPvfarrlXS7rOWsP5RM2E=;
        b=wiQQm15Yaq75QPbJe2xBuai+Ns++OHtSfhq+tt0yzJnQts8Lb15gft8AXPmYZRaFLw
         RSOOcN8OxkZKgVej0EtbcK1+NchCUdb5iXqt38h1MOCGKIdiY3h2HH2GJMisnExMdERO
         UMlIf7iu5R2tZ/AYAxG6AMC2j5wsaSQYiduVgIKcUtk9fCnB8iJZzvH8slvvxqSYtcjh
         dXg3j5vRQPzNqXR0xCOxxFCje+dtLUJSD2b2e56X63dg1eV34LhvszX6YmhMMNAuY7N3
         dP3L9OHwQ7geNpXeI/JCFGBfpLEv+sf2qfxS2B/Mwre8hbVJnzot5ULdjEhExUPVkL1Q
         fDCA==
X-Gm-Message-State: AOJu0YykK8l3QXoH3dw1orYbjmTlN1FzQAm4VZGNVo2DsdVEOMyXA8eY
	j6KdzsNnIxzjL3qQQ49YxfkZTKV4Xyw85q/4kHUqs4XUkBGklRsDOsIxLKCzeutdVytMarHkYe/
	l/Ljf7LoeQOxijilw8AWiqGE1D2hwc/o/1v3X6BXNCv8iDtnQxCG1BGrr28ZoR5G9VIGb
X-Received: by 2002:a19:f704:0:b0:50b:c227:57e7 with SMTP id z4-20020a19f704000000b0050bc22757e7mr389964lfe.4.1701407769899;
        Thu, 30 Nov 2023 21:16:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHC518r6lbFa3XGBlo+C8KoNhkpB4/TaegdAMLvWo2QH9Xw+hTC0ysnoouvm5EB6vbny9aJwDz3fhJ4/empbA4=
X-Received: by 2002:a19:f704:0:b0:50b:c227:57e7 with SMTP id
 z4-20020a19f704000000b0050bc22757e7mr389962lfe.4.1701407769591; Thu, 30 Nov
 2023 21:16:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231201033303.25141-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231201033303.25141-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 1 Dec 2023 13:15:58 +0800
Message-ID: <CACGkMEtxTWyCv6MYX3HxoLtUf3udFcHu5D-idLiUjT3WExuWeQ@mail.gmail.com>
Subject: Re: [PATCH vhost] virtio_ring: fix syncs DMA memory with different direction
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "Ning, Hongyu" <hongyu.ning@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 11:33=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now the APIs virtqueue_dma_sync_single_range_for_{cpu,device} ignore
> the parameter 'dir', that is a mistake.
>
> [    6.101666] ------------[ cut here ]------------
> [    6.102079] DMA-API: virtio-pci 0000:00:04.0: device driver syncs DMA =
memory with different direction [device address=3D0x00000000ae010000] [size=
=3D32752 bytes] [mapped with DMA_FROM_DEVICE] [synced with DMA_BIDIRECTIONA=
L]
> [    6.103630] WARNING: CPU: 6 PID: 0 at kernel/dma/debug.c:1125 check_sy=
nc+0x53e/0x6c0
> [    6.107420] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G            E     =
 6.6.0+ #290
> [    6.108030] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    6.108936] RIP: 0010:check_sync+0x53e/0x6c0
> [    6.109289] Code: 24 10 e8 f5 d9 74 00 4c 8b 4c 24 10 4c 8b 44 24 18 4=
8 8b 4c 24 20 48 89 c6 41 56 4c 89 ea 48 c7 c7 b0 f1 50 82 e8 32 fc f3 ff <=
0f> 0b 48 c7 c7 48 4b 4a 82 e8 74 d9 fc ff 8b 73 4c 48 8d 7b 50 31
> [    6.110750] RSP: 0018:ffffc90000180cd8 EFLAGS: 00010092
> [    6.111178] RAX: 00000000000000ce RBX: ffff888100aa5900 RCX: 000000000=
0000000
> [    6.111744] RDX: 0000000000000104 RSI: ffffffff824c3208 RDI: 00000000f=
fffffff
> [    6.112316] RBP: ffffc90000180d40 R08: 0000000000000000 R09: 00000000f=
ffeffff
> [    6.112893] R10: ffffc90000180b98 R11: ffffffff82f63308 R12: ffffffff8=
3d5af00
> [    6.113460] R13: ffff888100998200 R14: ffffffff824a4b5f R15: 000000000=
0000286
> [    6.114027] FS:  0000000000000000(0000) GS:ffff88842fd80000(0000) knlG=
S:0000000000000000
> [    6.114665] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    6.115128] CR2: 00007f10f1e03030 CR3: 0000000108272004 CR4: 000000000=
0770ee0
> [    6.115701] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [    6.116272] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [    6.116842] PKRU: 55555554
> [    6.117069] Call Trace:
> [    6.117275]  <IRQ>
> [    6.117452]  ? __warn+0x84/0x140
> [    6.117727]  ? check_sync+0x53e/0x6c0
> [    6.118034]  ? __report_bug+0xea/0x100
> [    6.118353]  ? check_sync+0x53e/0x6c0
> [    6.118653]  ? report_bug+0x41/0xc0
> [    6.118944]  ? handle_bug+0x3c/0x70
> [    6.119237]  ? exc_invalid_op+0x18/0x70
> [    6.119551]  ? asm_exc_invalid_op+0x1a/0x20
> [    6.119900]  ? check_sync+0x53e/0x6c0
> [    6.120199]  ? check_sync+0x53e/0x6c0
> [    6.120499]  debug_dma_sync_single_for_cpu+0x5c/0x70
> [    6.120906]  ? dma_sync_single_for_cpu+0xb7/0x100
> [    6.121291]  virtnet_rq_unmap+0x158/0x170 [virtio_net]
> [    6.121716]  virtnet_receive+0x196/0x220 [virtio_net]
> [    6.122135]  virtnet_poll+0x48/0x1b0 [virtio_net]
> [    6.122524]  __napi_poll+0x29/0x1b0
> [    6.123083]  net_rx_action+0x282/0x360
> [    6.123612]  __do_softirq+0xf3/0x2fb
> [    6.124138]  __irq_exit_rcu+0x8e/0xf0
> [    6.124663]  common_interrupt+0xbc/0xe0
> [    6.125202]  </IRQ>
>
> We need to enable CONFIG_DMA_API_DEBUG and work with need sync mode(such
> as swiotlb) to reproduce this warn.
>
> Fixes: 8bd2f71054bd ("virtio_ring: introduce dma sync api for virtqueue")
> Reported-by: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
> Closes: https://lore.kernel.org/all/f37cb55a-6fc8-4e21-8789-46d468325eea@=
linux.intel.com/
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

