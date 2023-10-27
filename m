Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAE3C25B47
	for <virtualization@archiver.kernel.org>; Fri, 27 Oct 2023 08:25:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABDBD41C33;
	Fri, 27 Oct 2023 08:25:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ABDBD41C33
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TPFJAgaQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3T27Nu5px8AU; Fri, 27 Oct 2023 08:25:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E4F6C41BEB;
	Fri, 27 Oct 2023 08:25:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E4F6C41BEB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C48A7C0071;
	Fri, 27 Oct 2023 08:25:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB6CEC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 08:25:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B3D0E6FAA0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 08:25:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B3D0E6FAA0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TPFJAgaQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gjoaNuh1xjnr
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 08:25:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 984236F6C6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 08:25:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 984236F6C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698395102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/sRPbObTy+hr2BTc4OunFroR638IOm6pKQx0eqZEmBc=;
 b=TPFJAgaQHAuCsv0HevVH7CRjqcA0NUhU/KP0HgRQNqMgb797qxJO9V+XG4a0Lhq6FNP4FE
 UPE1jg/dugDwXgMeibNmvDmP5WaYbfpPjdmyJ8PYoiZ69O4Ge6nSWv0KWxyK0m5n5+lFly
 9sHV5fqVYjtyooPHXCpfHbxaG7Zcmpc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-rvRBXQ4GMoCefLY6iUKueA-1; Fri, 27 Oct 2023 04:25:01 -0400
X-MC-Unique: rvRBXQ4GMoCefLY6iUKueA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe1521678fso13948085e9.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 01:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698395100; x=1698999900;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/sRPbObTy+hr2BTc4OunFroR638IOm6pKQx0eqZEmBc=;
 b=v2XRgz2QZ41LTGFBwru4cm9JQj4t0aexjIirY3GV6YkQT9cQfua4td9hm8xjN+mr2k
 zVXmvu1QBqqFzrNWaqdi/wsdndBS40rxwyGQwJ5g7bcCecydex9mSiSMdKpf2GGIHc0K
 fvFPvluHjQAGSQuLR2IXBpRsA7ohlc77iSxiTtFZwjwxbR184BjWVIqlCscATRSOvLFL
 dRLmPNwF94C27rUrXzE18epxGNI734g5ctlpxHTbWz+s3zOORtQQdzDXDRlmAx3vDv5i
 OAGvWG+iFOms/Zk/kRwHdMyNHFr+1m8Tjk1AVdclbou0V1HonREHhPMJaUTRyRJ66TSC
 cpmg==
X-Gm-Message-State: AOJu0Ywgw/0h2FSvKOx/LaKtsMy45Y5kRQARbvjPQ5UcOaZYLPNrS7Df
 SRbF1/q6mnCEp1JK/eboq1v5DPEn6U2YF+DUoF6Sk0AUz8YAUd+WM4zSzKZiC9WR2nF+171tjGM
 9YGKI5crCZPmMajb6oTwT0UcOoWXp+XoetgjDmLOY6A==
X-Received: by 2002:a05:600c:3b8f:b0:3f6:9634:c8d6 with SMTP id
 n15-20020a05600c3b8f00b003f69634c8d6mr1735087wms.18.1698395100030; 
 Fri, 27 Oct 2023 01:25:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO1d9NiGLpMH9UwrjFO3nIKYTeiI3b8cMpfwR9v8L7e0iFdiDoeQvQOBZ/uEP3Wgl9+7lyBw==
X-Received: by 2002:a05:600c:3b8f:b0:3f6:9634:c8d6 with SMTP id
 n15-20020a05600c3b8f00b003f69634c8d6mr1735069wms.18.1698395099613; 
 Fri, 27 Oct 2023 01:24:59 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it.
 [87.12.185.56]) by smtp.gmail.com with ESMTPSA id
 l12-20020adfe9cc000000b0032dba85ea1bsm1221968wrn.75.2023.10.27.01.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 01:24:59 -0700 (PDT)
Date: Fri, 27 Oct 2023 10:24:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: syzbot <syzbot+0c8ce1da0ac31abbadcd@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in virtio_transport_recv_pkt
Message-ID: <ooihytsfbk3brbwi2oj27ju3ff43ns36qhksfixrxdau2nieor@ervvukakvk4n>
References: <00000000000008b2940608ae3ce9@google.com>
MIME-Version: 1.0
In-Reply-To: <00000000000008b2940608ae3ce9@google.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: syoshida@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
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

On Fri, Oct 27, 2023 at 01:11:24AM -0700, syzbot wrote:
>Hello,
>
>syzbot found the following issue on:
>
>HEAD commit:    d90b0276af8f Merge tag 'hardening-v6.6-rc3' of git://git.k..
>git tree:       upstream
>console+strace: https://syzkaller.appspot.com/x/log.txt?x=102c8b22680000
>kernel config:  https://syzkaller.appspot.com/x/.config?x=6f1a4029b69273f3
>dashboard link: https://syzkaller.appspot.com/bug?extid=0c8ce1da0ac31abbadcd
>compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101e58ec680000
>C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f7adb6680000
>
>Downloadable assets:
>disk image: https://storage.googleapis.com/syzbot-assets/83ae10beee39/disk-d90b0276.raw.xz
>vmlinux: https://storage.googleapis.com/syzbot-assets/c231992300f6/vmlinux-d90b0276.xz
>kernel image: https://storage.googleapis.com/syzbot-assets/6377c9c2ea97/bzImage-d90b0276.xz
>
>IMPORTANT: if you fix the issue, please add the following tag to the commit:
>Reported-by: syzbot+0c8ce1da0ac31abbadcd@syzkaller.appspotmail.com
>
>=====================================================
>BUG: KMSAN: uninit-value in virtio_transport_recv_pkt+0x1c42/0x2580 net/vmw_vsock/virtio_transport_common.c:1421
> virtio_transport_recv_pkt+0x1c42/0x2580 net/vmw_vsock/virtio_transport_common.c:1421
> vsock_loopback_work+0x3e2/0x5d0 net/vmw_vsock/vsock_loopback.c:120
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2703
> worker_thread+0xf45/0x1490 kernel/workqueue.c:2784
> kthread+0x3e8/0x540 kernel/kthread.c:388
> ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
>Uninit was stored to memory at:
> virtio_transport_space_update net/vmw_vsock/virtio_transport_common.c:1274 [inline]
> virtio_transport_recv_pkt+0x1ea4/0x2580 net/vmw_vsock/virtio_transport_common.c:1415
> vsock_loopback_work+0x3e2/0x5d0 net/vmw_vsock/vsock_loopback.c:120
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2703
> worker_thread+0xf45/0x1490 kernel/workqueue.c:2784
> kthread+0x3e8/0x540 kernel/kthread.c:388
> ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
>Uninit was created at:
> slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
> slab_alloc_node mm/slub.c:3478 [inline]
> kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3523
> kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:559
> __alloc_skb+0x318/0x740 net/core/skbuff.c:650
> alloc_skb include/linux/skbuff.h:1286 [inline]
> virtio_vsock_alloc_skb include/linux/virtio_vsock.h:66 [inline]
> virtio_transport_alloc_skb+0x8b/0x1170 net/vmw_vsock/virtio_transport_common.c:58
> virtio_transport_reset_no_sock net/vmw_vsock/virtio_transport_common.c:957 [inline]
> virtio_transport_recv_pkt+0x1531/0x2580 net/vmw_vsock/virtio_transport_common.c:1387
> vsock_loopback_work+0x3e2/0x5d0 net/vmw_vsock/vsock_loopback.c:120
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2703
> worker_thread+0xf45/0x1490 kernel/workqueue.c:2784
> kthread+0x3e8/0x540 kernel/kthread.c:388
> ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
>CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.6.0-rc2-syzkaller-00337-gd90b0276af8f #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
>Workqueue: vsock-loopback vsock_loopback_work
>=====================================================
>

Shigeru Yoshida already posted a patch here:

https://lore.kernel.org/netdev/20231026150154.3536433-1-syoshida@redhat.com/

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
