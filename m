Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E611D15746E
	for <virtualization@lists.linux.dev>; Tue,  9 Dec 2025 04:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765254646; cv=none; b=o32HkQY5edWBWApCv72chhFg4MztNnoEoAtAth2Ob5mgWWU4XT3it2DZ924lZAKo3yLUtRZqrCuCX8yNmR3U4YUTXC/sRZiiDuR6EcSeODQGDlSApASv4WqUq/sYvXS5PuQs+nRreWeXEeSM85095MmM+VZp4if6/K4iqmvp2bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765254646; c=relaxed/simple;
	bh=FqRrkq9RkhhKrp58S/BccmT+zycBzvr/ayVbPtBPhHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABPwWdxYjyiaTgjofPgLrN5QFgMPlAMwI1529TXkzcSTiZ3hOfW2VEx1fji/Sv/AXq5nFxB+QemkNPvXZLOlpSiftJHUplBqOowhFijiYYWa3iuK70zgB4isXcpXEBFuvHL5bMm61aXCxacXuwgd2ZY3+1NaYoDNcKfGzxT9Zrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBZRjZTF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBZRjZTF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765254643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjZkNBzK8xQG6o4l+/b1jesEnkz3gHkSmOVvKHR9eIw=;
	b=ZBZRjZTFWNK7zIN8RxYQvvsLryGbiYrIB+2yY5GRF5VrT1KokE6e0LM4gQ2f8f1LCL4gQy
	3s7CDNngGhXGi6LOXNjxiGnMZ5yHhR51367BLNpYBovcX7NrfSOAG/P/F4Kb53KkbLVuqa
	zkz9QEKq5qGDFDrJcVkA/cMTEBccNfY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-UNAp34NBM4-su-TIc2Lg6Q-1; Mon, 08 Dec 2025 23:30:32 -0500
X-MC-Unique: UNAp34NBM4-su-TIc2Lg6Q-1
X-Mimecast-MFC-AGG-ID: UNAp34NBM4-su-TIc2Lg6Q_1765254631
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-341616a6fb7so5463804a91.0
        for <virtualization@lists.linux.dev>; Mon, 08 Dec 2025 20:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765254631; x=1765859431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hjZkNBzK8xQG6o4l+/b1jesEnkz3gHkSmOVvKHR9eIw=;
        b=Mxn5Ii9ojFXxmMB27HQ/7livlK6JsYpgFWb8bS/jheKztNU0g9K7h8N70/hBh55FZR
         Vq7kqI28e7GeEv4s+OnIb02ZUl6PjQZX1mDJN+gBlPwXxzP/7k1qmHmddjp0m2WvcPa1
         PLH7AYt6yao6+DBAPES8Gtr5hvedyxz+J9+NgdO4SHQn8d1AEWDGTipnlKs8EtAaJXsP
         POV0xId25lxK/jacWwjT2I/Z5WAqtRce6L6DrktEEPS9CU6m95pFv5uEcj+LKpBXnHgO
         IKkNTe+8klYp2BERZrWZRza6LxbDlKx0Yk8D0W1jG6gxJk/kERy4d2CB27tcyDuoD46G
         1+vA==
X-Forwarded-Encrypted: i=1; AJvYcCUHr7KTQDp+aQQOnCtYVdhWgsAVJP71CGMT6MfNN3Z2ZFJmtiHG71RcG8w8skqLFE3go85CZQviguzTEziVeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLo9r3m/PGv7O56JYtqQSgpNV9l8uM/EvO7ZWgmgvNCY5BkglA
	xjIVzHyJJb3Fv8Q4OG8PdJy+w0BmE8NmYM6/n1diQkVj+iKNnnsm7B+8gvCfbw0aLB0PyGjR7En
	CAp4xxWV6aVfJdCV8QXYkUKhK2N+oKdK3Mo/Txqg2Fbj5xkO+zz03aVz7UoiwTBXGS/Rn0Fx+pE
	7ogEk+aEhMrEpYSVfaI3SKE7epB5yyBQZDxqFEdDs85Mc=
X-Gm-Gg: ASbGncs+hUAKmhkH/D28axX1jlklr80OX+f8EJUrthw9oQJkPQpw7mexW52mToCTtMU
	xpZoXPiARlagz14lEiF9KGDHh85P2sqVi/hufMfSwodBsLpiXryMyN7qENSi7roE/yXB4yOoZT+
	gDo0YW5jXBfhMHe1lTvhftZgg8GMycBlPdASG7gQIMz5T788EqTRdtxVcZblrLgyET1w==
X-Received: by 2002:a17:90b:2689:b0:341:212b:fdd1 with SMTP id 98e67ed59e1d1-349a256e409mr8500174a91.16.1765254630805;
        Mon, 08 Dec 2025 20:30:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExGqnqO+DyztHKRZgQziFfQnzweFIyxEgvKR3AsKvJmK7dcSqQvfdQGlSNvqQr39deZXVUow2OFVn3WFQTU/s=
X-Received: by 2002:a17:90b:2689:b0:341:212b:fdd1 with SMTP id
 98e67ed59e1d1-349a256e409mr8500154a91.16.1765254630384; Mon, 08 Dec 2025
 20:30:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251208153419.18196-1-minhquangbui99@gmail.com>
In-Reply-To: <20251208153419.18196-1-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Dec 2025 12:30:19 +0800
X-Gm-Features: AQt7F2pdiWKYZftUX6M208UPAFNmS9Br13quSDg8KS6iZmKHEOuykxku7dVVBJ4
Message-ID: <CACGkMEvtKVeoTMrGG0gZOrNKY=m-DGChVcM0TYcqx6-Ap+FY8w@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: enable all napis before scheduling refill work
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aRnAW4BYAxof86JWPFevXsU3gx18mIMbQRtPSfT4F8g_1765254631
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 11:35=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> Calling napi_disable() on an already disabled napi can cause the
> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
> when pausing rx"), to avoid the deadlock, when pausing the RX in
> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
> However, in the virtnet_rx_resume_all(), we enable the delayed refill
> work too early before enabling all the receive queue napis.
>
> The deadlock can be reproduced by running
> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
> device and inserting a cond_resched() inside the for loop in
> virtnet_rx_resume_all() to increase the success rate. Because the worker
> processing the delayed refilled work runs on the same CPU as
> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
> In real scenario, the contention on netdev_lock can cause the
> reschedule.
>
> This fixes the deadlock by ensuring all receive queue's napis are
> enabled before we enable the delayed refill work in
> virtnet_rx_resume_all() and virtnet_open().
>
> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx"=
)
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results=
/400961/3-xdp-py/stderr
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 59 +++++++++++++++++++---------------------
>  1 file changed, 28 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e04adb57f52..f2b1ea65767d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_info *vi,=
 struct receive_queue *rq,
>         return err !=3D -ENOMEM;
>  }
>
> +static void virtnet_rx_refill_all(struct virtnet_info *vi)
> +{
> +       bool schedule_refill =3D false;
> +       int i;
> +
> +       enable_delayed_refill(vi);

This seems to be still racy?

For example, in virtnet_open() we had:

static int virtnet_open(struct net_device *dev)
{
        struct virtnet_info *vi =3D netdev_priv(dev);
        int i, err;

        for (i =3D 0; i < vi->max_queue_pairs; i++) {
                err =3D virtnet_enable_queue_pair(vi, i);
                if (err < 0)
                        goto err_enable_qp;
        }

        virtnet_rx_refill_all(vi);

So NAPI and refill work is enabled in this case, so the refill work
could be scheduled and run at the same time?

Thanks

