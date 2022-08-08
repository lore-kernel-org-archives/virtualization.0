Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38075C25B06
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 07:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2AE8826C0;
	Mon,  8 Aug 2022 07:55:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2AE8826C0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XkPX2y3D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 95VfPBfAKL5A; Mon,  8 Aug 2022 07:55:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 25A3C826AA;
	Mon,  8 Aug 2022 07:55:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 25A3C826AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6610C0032;
	Mon,  8 Aug 2022 07:55:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 898D5C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 07:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4EB91410C0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 07:55:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4EB91410C0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XkPX2y3D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5jzRv6smKwOo
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 07:55:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C0D65410A6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C0D65410A6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 07:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659945344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oC/JLDjGvWP0iiaK2n12rCrZ705odT+KLXUuwmVFqrk=;
 b=XkPX2y3Di7PAF3CR4a1kFonl7N7m0o+1Pxif16pMeZ+I6NxqsuLf680g9EF+pZ1Op72i8W
 arYLHLD0o3UvdjHkWbtAgXrNA4YuJ4HJtC6LFSP8lk0Y/Jou7MKQk2BOX4Ye1FdRxjateN
 GYQ5wRbPht4AII1jBMM7/u93wgRBvMM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-G8L2IzAUO3qyP0Xk5cDGsw-1; Mon, 08 Aug 2022 03:55:43 -0400
X-MC-Unique: G8L2IzAUO3qyP0Xk5cDGsw-1
Received: by mail-qv1-f71.google.com with SMTP id
 dn2-20020a056214094200b0047491ead6a2so4037967qvb.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Aug 2022 00:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=oC/JLDjGvWP0iiaK2n12rCrZ705odT+KLXUuwmVFqrk=;
 b=ShcJQPgzKy27+M2AcOSPKrfUnXal4WS6vlfg6DA/AiMR80JbGMnvR2DXfTXp6Zbcvd
 h0o7QiwlSvk5kEvN8fmZ/rB9HaVjdLxqP/VCvja52jcKqywOF4t2nW0cNfYqk1L1CJHx
 hwGdY1ptNl0gKc+zYqUsGv0Sq/ZehKI/2fLUcCSKWAD7I5QNQWDHCYzsqGqK7LNAAWMR
 byP99nCqS8MNxAexTFIF9MAt6WMOtWPYpyftFWqJykkMiPla/YmnXmsZixhfISC14I6s
 O+q8Gkitmxy+lnNxgEo6rBx2TzbmD9P72jP9Q/FLFFdR8wxrKNmj6ly//ZAewrV21rh3
 eR4Q==
X-Gm-Message-State: ACgBeo28gXNZWsP5FDYJZFkjk7iAyMkjIz1/cmfO5Ujhx7rwLIDe7U2F
 +Jh4XoVINkcfmhjW5Li7AUw+tVdpmfEUQ37kdwwUkTORQmyqKNUpIYiQcuy6ZCn+sj3qD6yWRNH
 8L3WKfDMQC61FJsgpk+BeiBRu+73Jk3CaRai5Ux+tDg==
X-Received: by 2002:a05:620a:1706:b0:6b9:234:f735 with SMTP id
 az6-20020a05620a170600b006b90234f735mr13305795qkb.623.1659945342758; 
 Mon, 08 Aug 2022 00:55:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7iWdzerRsas1XKbzpMRoloSe+T09VDPfGvxnYWtJ3xP4fybH8ZIzd+8wJd6v36LUCEu/kjSA==
X-Received: by 2002:a05:620a:1706:b0:6b9:234:f735 with SMTP id
 az6-20020a05620a170600b006b90234f735mr13305776qkb.623.1659945342506; 
 Mon, 08 Aug 2022 00:55:42 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 w20-20020a05620a0e9400b006b8f8e9bd00sm8365097qkm.5.2022.08.08.00.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Aug 2022 00:55:41 -0700 (PDT)
Date: Mon, 8 Aug 2022 09:55:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Peilin Ye <yepeilin.cs@gmail.com>
Subject: Re: [PATCH net v2 1/2] vsock: Fix memory leak in vsock_connect()
Message-ID: <20220808075533.p7pczlnixb2phrun@sgarzare-redhat>
References: <20220804020925.32167-1-yepeilin.cs@gmail.com>
 <a02c6e7e3135473d254ac97abc603d963ba8f716.1659862577.git.peilin.ye@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <a02c6e7e3135473d254ac97abc603d963ba8f716.1659862577.git.peilin.ye@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andy King <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Peilin Ye <peilin.ye@bytedance.com>, "David S. Miller" <davem@davemloft.net>,
 George Zhang <georgezhang@vmware.com>
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

On Sun, Aug 07, 2022 at 02:00:11AM -0700, Peilin Ye wrote:
>From: Peilin Ye <peilin.ye@bytedance.com>
>
>An O_NONBLOCK vsock_connect() request may try to reschedule
>@connect_work.  Imagine the following sequence of vsock_connect()
>requests:
>
>  1. The 1st, non-blocking request schedules @connect_work, which will
>     expire after 200 jiffies.  Socket state is now SS_CONNECTING;
>
>  2. Later, the 2nd, blocking request gets interrupted by a signal after
>     a few jiffies while waiting for the connection to be established.
>     Socket state is back to SS_UNCONNECTED, but @connect_work is still
>     pending, and will expire after 100 jiffies.
>
>  3. Now, the 3rd, non-blocking request tries to schedule @connect_work
>     again.  Since @connect_work is already scheduled,
>     schedule_delayed_work() silently returns.  sock_hold() is called
>     twice, but sock_put() will only be called once in
>     vsock_connect_timeout(), causing a memory leak reported by syzbot:
>
>  BUG: memory leak
>  unreferenced object 0xffff88810ea56a40 (size 1232):
>    comm "syz-executor756", pid 3604, jiffies 4294947681 (age 12.350s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      28 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  (..@............
>    backtrace:
>      [<ffffffff837c830e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1930
>      [<ffffffff837cbe22>] sk_alloc+0x32/0x2e0 net/core/sock.c:1989
>      [<ffffffff842ccf68>] __vsock_create.constprop.0+0x38/0x320 net/vmw_vsock/af_vsock.c:734
>      [<ffffffff842ce8f1>] vsock_create+0xc1/0x2d0 net/vmw_vsock/af_vsock.c:2203
>      [<ffffffff837c0cbb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
>      [<ffffffff837c3acf>] sock_create net/socket.c:1519 [inline]
>      [<ffffffff837c3acf>] __sys_socket+0x6f/0x140 net/socket.c:1561
>      [<ffffffff837c3bba>] __do_sys_socket net/socket.c:1570 [inline]
>      [<ffffffff837c3bba>] __se_sys_socket net/socket.c:1568 [inline]
>      [<ffffffff837c3bba>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
>      [<ffffffff84512815>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>      [<ffffffff84512815>] do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
>      [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>  <...>
>
>Use mod_delayed_work() instead: if @connect_work is already scheduled,
>reschedule it, and undo sock_hold() to keep the reference count
>balanced.
>
>Reported-and-tested-by: syzbot+b03f55bf128f9a38f064@syzkaller.appspotmail.com
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Co-developed-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
>---
>change since v1:
>  - merged with Stefano's patch [1]
>
>[1] https://gitlab.com/sgarzarella/linux/-/commit/2d0f0b9cbbb30d58fdcbca7c1a857fd8f3110d61
>
>Hi Stefano,
>
>About the Fixes: tag, [2] introduced @connect_work, but all it did was
>breaking @dwork into two and moving some INIT_DELAYED_WORK()'s, so I don't
>think [2] introduced this memory leak?
>
>Since [2] has already been backported to 4.9 and 4.14, I think we can
>Fixes: commit d021c344051a ("VSOCK: Introduce VM Sockets"), too, to make
>backporting easier?

Yep, I think it should be fine!

>
>[2] commit 455f05ecd2b2 ("vsock: split dwork to avoid reinitializations")
>
>Thanks,
>Peilin Ye
>
> net/vmw_vsock/af_vsock.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index f04abf662ec6..fe14f6cbca22 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1391,7 +1391,13 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 			 * timeout fires.
> 			 */
> 			sock_hold(sk);
>-			schedule_delayed_work(&vsk->connect_work, timeout);
>+
>+			/* If the timeout function is already scheduled,
>+			 * reschedule it, then ungrab the socket refcount to
>+			 * keep it balanced.
>+			 */
>+			if (mod_delayed_work(system_wq, &vsk->connect_work, timeout))
                             ^
Checkpatch warns here about line lenght.
If you have to re-send, please split it.

Anyway, the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
