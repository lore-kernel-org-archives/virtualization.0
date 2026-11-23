Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436845;
	b=GHuQNKtGOCI1RYr9MxtvuGqMJ1hvStTOIF4bH0M3IZoTEWRcjxlUJ5x1Hc48m/Gyptlc
	 3B0L2VIi03YThNlwcGwahkOn8gy70BUTXEk27AsENT7VWYSShHV8XCWRpYHmX6iqatWTI
	 79Q1L2nwFpXfjVG3ypP8RE2KAFK2rIzaAIjLfdClWncobZygg07cvTaqDjQZZ1oUHvF7h
	 W+wLy5gZU7fpT4aEeLYYJmz/MJjz7MnSLcLoGzPkeC3cfflcqOjGj6tbbJXZehjg0Bfm3
	 WOHekbRgL+vWIFLz47lCPQQHXoNTIENgniyCChMDivgMLxcBfNzTSyHVrXyzEeoZg4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436845;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=YImJ/ALCtekb57+DaL5zQvBLKaVvYqpkrQRdHCmg3Uk=;
	b=2DXbBxg/+n5IoA1rrIz1z8eXrfmE71XJeKAxtJsd4B+pJ75O+1fYw+TlWDdBfoT1fE3G
	 rI/AsjSvVw43p8xPF1AsYY2PIAAr01n3eOsRzGmLodLigCrovWhmwLz8klAqDlHE8FitP
	 M8kFsK4F7PFHEJN6zv1ZILQBlasmMcs1ypVyKa0RVgW2lCwn6m5K360sDUTEFrBxnFsPG
	 8SiYS6UsPL+Uvaa8t7o+TEAiO5jL5yVdHayXKLcsHwXzvMEJZDlJJEl0y4mYqYADX4sG6
	 ls2Q/ErhjIWg8wYOVY8VmRo5CDkjQKEbBV0FvWrjSfoDVh9+tvftvQKJ8zSWaq1IVLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=austTnm7;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCAE606A31A
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 12:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBCAE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=austTnm7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795436844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YImJ/ALCtekb57+DaL5zQvBLKaVvYqpkrQRdHCmg3Uk=;
	b=austTnm7GrXvKGBWWbH7EvCQRT/3bOSu4hhfoJ8Pnc9yCya1+YU0j6JMjuXyAder4h2uOh
	szhZaW/9DV8y1eI0olivAEHPnDLG/tWAgMr297bwBRx1kGOtt5MPFKxZ6wxPF6wjnKPm3W
	8v4G2N2GgOXhQ5LVO0ChNlIe4AvLjuI=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-3Q57t59APUKCJwZWhc7MMQ-1; Mon, 23 Nov 2026 12:27:22 +0000
X-MC-Unique: 3Q57t59APUKCJwZWhc7MMQ-1
X-Mimecast-MFC-AGG-ID: 3Q57t59APUKCJwZWhc7MMQ_1795436841
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-67906c453b8so4815469d50.1
        for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 04:27:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795436841; x=1796041641;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YImJ/ALCtekb57+DaL5zQvBLKaVvYqpkrQRdHCmg3Uk=;
        b=bzPSVru5bZaN8swmtaF6hZU55I02yVGZ09ccmWCFn4/3rDqzgQ+DdSksoBbPFxISE6
         VQmWClWmBh1VSEWBb8hHBDGn57fcXe1DBgXv+gf6llv26M+MhNDPISl44kmi+OfErJJa
         ELlWVJ/iAOa+voLCA0cKEtPr3r232nzSP5xkvAfo0m1cz6Ce403MsC5oVZJ6lnGeW3of
         UsliD1ZNqSu7EwxMiHDw2afM5/dmF3kQQL7dVyqazNh72NYzElWK+EtnzWcpPNTdyGp6
         b+rE+bfGEIE6DGnITfCEr74amlS2qsRHA7thxToOzmVZi7hu9tNYwMoKz1Adu5d/8eFL
         eIPg==
X-Forwarded-Encrypted: i=1; AL+hErGYI6Tt+ZQHK9P2iHO9dEEmKtGx6R5nw5devtN4WW3X4bx5qNTWtimgVq9Xnpmq+B29J/biPYQ8DMqsqieA7Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Hx/YN0T8M1VJd+6M0rSUaGhRRW7TI7nHKOZpRzD4lyYcBVAko
	qeONj28JWsioE2HfNsVof6H4OrB2GRgoQPaVNhaUSSGYzJnW3yG5pkx93TTgfW41JlmWMi1ALyO
	MrKAz22mo2PHsk7SdXv8IWGhNoCq1reXxsyH4C4ndm/KtUizogVZC/XM9SEY+BEABVLCA2DZWSy
	0WaksuEEUq+j67/a0oN0a1VMgForGe+oPxExJ41gMeKs8=
X-Gm-Gg: AZFdTZcQSLDq1dFNu9xacRB91IVTfP84ZLgbprgXZGLzCVbYsGvfcbZ6obMwWE+M0/j
	vbG32K8ZSydYd4fFHRoCN6Mf+WR/1ALTjh2fupnzW2QLiTZ+MHSB8IEqLquR2njpNAY6aQZZJuW
	soyrKQT5hY/9A09fWd/RDr+7FCHFa6akv4uCQ7pIw9xJV5EUxzqB3G5OF2ihUGXSMFCXdJtfj2V
	mHHgVAOSmuNjx3F4qaEHQSoMrHaeJfJolHzvpopFh36pFokaBtavsXsvug=
X-Received: by 2002:a05:690e:11c5:b0:67d:a3c2:c95 with SMTP id 956f58d0204a3-67dec2bd130mr4963366d50.3.1795436841330;
        Mon, 23 Nov 2026 04:27:21 -0800 (PST)
X-Received: by 2002:a05:690e:11c5:b0:67d:a3c2:c95 with SMTP id
 956f58d0204a3-67dec2bd130mr4963360d50.3.1795436840812; Mon, 23 Nov 2026
 04:27:20 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261122-b4-06-vhost-in-order-log-oob-v1-35efdba8fbab-v1-1-fc1253d60351@pm.me>
In-Reply-To: <20261122-b4-06-vhost-in-order-log-oob-v1-35efdba8fbab-v1-1-fc1253d60351@pm.me>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 23 Nov 2026 13:26:44 +0100
X-Gm-Features: Aa3M54pt5PWY45sVKrMEfHYWn7Rl4h8pw_TEQAIUnc03qW3ChT2fpOFP_O-rkHg
Message-ID: <CAJaqyWdOF3LVF+WHaGw8gimULaCunRkuLnKAhciB7HWpYhnm9w@mail.gmail.com>
Subject: Re: [PATCH] vhost: mask the in-order used-ring log cursor
To: fadouse@pm.me
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Linfeng Sun <linfeng.sun.dev@gmail.com>, Fang Xieyan <fangxy@xiaopeng.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XQnPdPkkzBWMK6s-SCtJ7D5oqqAKUwsnHOWfPIfY4oQ_1795436841
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 2:20=E2=80=AFPM YanXin Li via B4 Relay
<devnull+fadouse.pm.me@kernel.org> wrote:
>
> From: YanXin Li <fadouse@pm.me>
>
> vhost_add_used_n_in_order() plays the batch of used-ring writes back a
> second time for dirty logging.  Commit e244725e86be ("vhost: fix used
> ring index wrap in vhost_add_used_n_in_order") masked the index in the
> descriptor-publishing loop.  The dirty-logging loop introduced by
> bfcde6b64769 still uses the single-subtraction form
>
>     next =3D start + nheads[i];
>     if (next >=3D vq->num)
>         next -=3D vq->num;
>
> If the guest refills the available ring while get_rx_bufs() collects
> one mergeable-RX packet, that packet can consume more heads than
> vq->num.

Although I'm ok with the proposed patch as hardening or optimization,
this sounds more like a bug in get_rx_bufs. Where are the memory
addresses for these pieces stored if there are no more buffers in the
virtqueue? Or is it able to loop through the vq?

> get_rx_bufs() permits up to UIO_MAXIOV =3D 1024 descriptor
> chains in one call, so a single subtraction is not enough.  For
> vq->num =3D 32, last_used_idx =3D 0 and nheads[0] =3D 64, next becomes
> 64 - 32 =3D 32, which is still equal to vq->num and out of bounds.  The
> next iteration then logs
>
>     used =3D vq->used->ring + 32;
>     log_used(vq, 4 + 32 * 8, 8);
>
> which starts past the end of the 260-byte ring body (4 + 32 * 8).
> For a used ring placed inside page 7 at guest address 0x7ef8 (so the
> entire 262-byte ring occupies [0x7ef8, 0x7ffe) and
> vq_log_used_access_ok() validates only log_base[0]), log_used()
> marks [0x7ffc, 0x8004) as dirty.  log_write() then sets a bit in
> log_base[1] for page 8, past the single validated byte.  On a
> vhost-net RX queue configured with VIRTIO_F_IN_ORDER,
> VIRTIO_NET_F_MRG_RXBUF,
> VHOST_F_LOG_ALL, VHOST_VRING_F_LOG, vq->num =3D 32, and
> log_guest_addr =3D 0x7ef8, delivering one 8 KiB frame consuming 64
> mergeable buffers followed by one 1-buffer frame in the same
> count =3D 2 flush writes
>
>     log_base[1] =3D 0x01
>
> where log_base[0] =3D 0x80 is the only byte the kernel was entitled to
> touch.  A guest attached to a vhost-net backend with dirty-page
> logging enabled (for example during live migration) and a small RX
> ring can therefore corrupt dirty-log bitmap memory that the VMM owns
> outside the region registered for this ring.
>
> Wrap the logging loop index the same way the first loop does:
>
>     next =3D (start + nheads[i]) & (vq->num - 1);
>
> vhost_vring_set_num() already enforces that vq->num is a nonzero
> power of two, so this is well defined for every accepted ring size.
> The coalescing invariant is preserved: if a run is not flushed,
> next =3D=3D start + 1.  When start =3D=3D vq->num - 1, start + 1 =3D=3D v=
q->num,
> whereas the masked next is always less than vq->num.  The run is
> therefore flushed before the cursor wraps.
> With this change the same vhost-net configuration publishes
> used->idx =3D 65 and confines the dirty log to log_base[0] =3D 0x80,
> leaving log_base[1] =3D 0x00.  The mask keeps next in [0, vq->num) for
> every accepted power-of-two ring size.  As a bounded cross-check of
> the index arithmetic, a Z3 model over ring sizes {1, 2, 4, 8, 16, 32}
> and buffer counts in [1, 64] finds an out-of-range result for the old
> subtraction (vq->num =3D 16, start =3D 15, nheads =3D 17) and none for th=
e
> mask within those bounds.
>
> Runtime verification and fix validation were performed in an x86-64
> QEMU/KVM guest running mainline after v7.4-rc3, with Generic KASAN,
> UBSAN, lockdep, and DEBUG_OBJECTS.
>

Can you post the reproducer? Even better if it is integrated in
tools/virtio/vhost_net_test.c.

Thanks!

> Fixes: bfcde6b64769 ("vhost: fix dirty logging for in-order used ring ent=
ries")
> Cc: stable@vger.kernel.org
> Signed-off-by: YanXin Li <fadouse@pm.me>
> ---
>  drivers/vhost/vhost.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index dc973287567..80b887e1511 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -3206,9 +3206,7 @@ static int vhost_add_used_n_in_order(struct vhost_v=
irtqueue *vq,
>                                 log_start =3D start;
>                         log_count++;
>
> -                       next =3D start + nheads[i];
> -                       if (next >=3D vq->num)
> -                               next -=3D vq->num;
> +                       next =3D (start + nheads[i]) & (vq->num - 1);
>                         if (i + 1 =3D=3D count || next !=3D start + 1) {
>                                 used =3D vq->used->ring + log_start;
>                                 log_used(vq,
>
> ---
> base-commit: c44104f3642da720164042623e4832836aefdd8e
> change-id: 20261122-b4-06-vhost-in-order-log-oob-v1-35efdba8fbab-43734ad1=
0f0a
>
> Best regards,
> --
> YanXin Li <fadouse@pm.me>
>
>
>

