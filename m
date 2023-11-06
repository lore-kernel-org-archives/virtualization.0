Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC73EC4332F
	for <virtualization@archiver.kernel.org>; Mon,  6 Nov 2023 08:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4565341EB1;
	Mon,  6 Nov 2023 08:43:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4565341EB1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GeICvC9c
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iYG_fzmhp9WA; Mon,  6 Nov 2023 08:43:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 92A5241EAC;
	Mon,  6 Nov 2023 08:43:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 92A5241EAC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72EF5C0039;
	Mon,  6 Nov 2023 08:43:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 094F2C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 08:43:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D1D6E41EB1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 08:43:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D1D6E41EB1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hXGb4-Fw133i
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 08:43:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B2C9D41EAC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 08:43:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B2C9D41EAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699260185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t2V4SrKmDXM7Q2ya/olfBds0kRGyhozqRxAHHZYjEaw=;
 b=GeICvC9cS0oavNbL80sw0chDc/BqwZU4se9E30Yp6H94R50fxNNKV64Ae41458yBgIeHfY
 AaxW7plsaGNkExIiyfSubEhjz2F8uBbUAojRAE55z6ZpTupcPKrpuikBqkHtemHZShTQQo
 zH3F1cl4o3ilrm1m54/7dTshZn/dLXY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-aKYUQnCpMV2DyuU_OJC_TQ-1; Mon, 06 Nov 2023 03:43:03 -0500
X-MC-Unique: aKYUQnCpMV2DyuU_OJC_TQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32ddd6f359eso2126594f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Nov 2023 00:43:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699260183; x=1699864983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2V4SrKmDXM7Q2ya/olfBds0kRGyhozqRxAHHZYjEaw=;
 b=e6rACDlOSk2Mb5U3yedikj5Dsljowik42I6+VV35Y8z7pK0crBiMbjLvw6/Fx+RiTV
 Hwpr8bI8QLiW5/5H2C5+xUNMgeYjRsehoYOHjBG8jW7SVg2809wDFTS7VPk5glj2Gncc
 BUyGS8P3xDGFt5m+TxkPIe/RJzQEX9fg5Plfb8psXjkzrmzAOVanD13OrUWfbFhMF8f5
 JiXrayaHqBxDVfsrYvUJ1e9mCum/LHA1qc5RVPrbp2qWUEMJDy6dBuFosRWA+GuVWg03
 zJ8sFM7UruWwTf4lDq5yohZzxYjgHwhRjpJ76A7IlBcMcKyQkWIrxV7TxP6eIPOL7jlt
 Oi+w==
X-Gm-Message-State: AOJu0YwGo04LF8vKVQqXI8yNyk5mzDWcMO6raJiemB1KVR2uzUW0NAIi
 KkOie3E0TYxKaBrTf9FirIr3tlNFxLKaGf0IoS4k+HdP0ul+n7YF6S/YtAazvkVwjgM6BDl/MmV
 s8ckMNmjvtFwsbDE74/WhrKSmPXtMypesuip2rKH5Yg==
X-Received: by 2002:a05:6000:1b09:b0:31f:a256:4bbb with SMTP id
 f9-20020a0560001b0900b0031fa2564bbbmr19083187wrz.71.1699260182726; 
 Mon, 06 Nov 2023 00:43:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX7O05rSfYP8gnU/IJPVZ20H/dR30/gVHdp15QL98NSczZRPr1cdg4L3jI9YQeK5n1BcwYMw==
X-Received: by 2002:a05:6000:1b09:b0:31f:a256:4bbb with SMTP id
 f9-20020a0560001b0900b0031fa2564bbbmr19083166wrz.71.1699260182307; 
 Mon, 06 Nov 2023 00:43:02 -0800 (PST)
Received: from sgarzare-redhat ([5.179.191.143])
 by smtp.gmail.com with ESMTPSA id
 y15-20020adff6cf000000b0032f7f4089b7sm8733539wrp.43.2023.11.06.00.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 00:43:01 -0800 (PST)
Date: Mon, 6 Nov 2023 09:42:56 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Subject: Re: [PATCH net v2] virtio/vsock: Fix uninit-value in
 virtio_transport_recv_pkt()
Message-ID: <pqynwprcnwpg5febbvz2z5gdjkayri6tm2azorkdhgnedyzpln@o7bgedbhmjfn>
References: <20231104150531.257952-1-syoshida@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20231104150531.257952-1-syoshida@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: syzbot+0c8ce1da0ac31abbadcd@syzkaller.appspotmail.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 stefanha@redhat.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Sun, Nov 05, 2023 at 12:05:31AM +0900, Shigeru Yoshida wrote:
>KMSAN reported the following uninit-value access issue:
>
>=====================================================
>BUG: KMSAN: uninit-value in virtio_transport_recv_pkt+0x1dfb/0x26a0 net/vmw_vsock/virtio_transport_common.c:1421
> virtio_transport_recv_pkt+0x1dfb/0x26a0 net/vmw_vsock/virtio_transport_common.c:1421
> vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
> worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
> kthread+0x3cc/0x520 kernel/kthread.c:388
> ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
>Uninit was stored to memory at:
> virtio_transport_space_update net/vmw_vsock/virtio_transport_common.c:1274 [inline]
> virtio_transport_recv_pkt+0x1ee8/0x26a0 net/vmw_vsock/virtio_transport_common.c:1415
> vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
> worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
> kthread+0x3cc/0x520 kernel/kthread.c:388
> ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
>Uninit was created at:
> slab_post_alloc_hook+0x105/0xad0 mm/slab.h:767
> slab_alloc_node mm/slub.c:3478 [inline]
> kmem_cache_alloc_node+0x5a2/0xaf0 mm/slub.c:3523
> kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:559
> __alloc_skb+0x2fd/0x770 net/core/skbuff.c:650
> alloc_skb include/linux/skbuff.h:1286 [inline]
> virtio_vsock_alloc_skb include/linux/virtio_vsock.h:66 [inline]
> virtio_transport_alloc_skb+0x90/0x11e0 net/vmw_vsock/virtio_transport_common.c:58
> virtio_transport_reset_no_sock net/vmw_vsock/virtio_transport_common.c:957 [inline]
> virtio_transport_recv_pkt+0x1279/0x26a0 net/vmw_vsock/virtio_transport_common.c:1387
> vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
> worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
> kthread+0x3cc/0x520 kernel/kthread.c:388
> ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
>CPU: 1 PID: 10664 Comm: kworker/1:5 Not tainted 6.6.0-rc3-00146-g9f3ebbef746f #3
>Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
>Workqueue: vsock-loopback vsock_loopback_work
>=====================================================
>
>The following simple reproducer can cause the issue described above:
>
>int main(void)
>{
>  int sock;
>  struct sockaddr_vm addr = {
>    .svm_family = AF_VSOCK,
>    .svm_cid = VMADDR_CID_ANY,
>    .svm_port = 1234,
>  };
>
>  sock = socket(AF_VSOCK, SOCK_STREAM, 0);
>  connect(sock, (struct sockaddr *)&addr, sizeof(addr));
>  return 0;
>}
>
>This issue occurs because the `buf_alloc` and `fwd_cnt` fields of the
>`struct virtio_vsock_hdr` are not initialized when a new skb is allocated
>in `virtio_transport_init_hdr()`. This patch resolves the issue by
>initializing these fields during allocation.
>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Reported-and-tested-by: syzbot+0c8ce1da0ac31abbadcd@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=0c8ce1da0ac31abbadcd
>Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>---
>v1->v2:
>- Rebase on the latest net tree
>https://lore.kernel.org/all/20231026150154.3536433-1-syoshida@redhat.com/
>---
> net/vmw_vsock/virtio_transport_common.c | 2 ++
> 1 file changed, 2 insertions(+)

The patch remained the same, so you could bring back my R-b ;-)
In any case:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index e22c81435ef7..dc65dd4d26df 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -130,6 +130,8 @@ static void virtio_transport_init_hdr(struct sk_buff *skb,
> 	hdr->dst_port	= cpu_to_le32(dst_port);
> 	hdr->flags	= cpu_to_le32(info->flags);
> 	hdr->len	= cpu_to_le32(payload_len);
>+	hdr->buf_alloc	= cpu_to_le32(0);
>+	hdr->fwd_cnt	= cpu_to_le32(0);
> }
>
> static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
>-- 
>2.41.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
