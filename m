Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DB3C2FA
	for <virtualization@lists.linux.dev>; Wed,  4 Jun 2025 00:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997456; cv=none; b=ADZ+ISbtQbDUAXoyefgvVJ1BomDpyVwzGxtEA/fU2ySZs4nsKY8bU+fLKj80A/LhXdNO7rhkxbNz6dh5zLztFTEx0AP1s+Y6XqDBnzGKK6ToZK+PUus2IqE5sfWCc1NVvAlDMGfYMssCJVeT1KXUq7TwlQr8y/JYGc9wEHHAY6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997456; c=relaxed/simple;
	bh=FIhhwRMnEvPjuGUpf9qf+tqZDLEP9lZKLjQ3YYZd4as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RO3cxzamWp+exuKzx5hfr/orv6gcmVln+0QSxsueeCSFaH7idyGwJYgHjYCH7P8M5YO0dOXrBsFuiESB63T//lxfssxZ11jeoALuMMcnrCKSK9L2CYqukrG+8YZ5kzORcdCswG0kR0JgfMGMNmxbCWgxmwPlNt/UmRWxNiwK/Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JHrHmKTt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHrHmKTt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748997453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCJQT/kav5ff3pRxvzcaTAEwPIznqrXjhdq5yD+vQEE=;
	b=JHrHmKTtGxsbSDhcDPs7r88LWdiZ8uKIHJaxRhtVsTNvL1uwwNFSci40UEyq54QcNOXWIl
	roPeCoFKS0qCfUMBz+Oak/7jaKqqECqFibnwBOTe6Q9C0FvPYcHWNhg4t5iMCpYd0YV79Y
	BLssLdnKty1e1qWe84SBWMXE56pGTUA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-JiWV8prUNcW9BYxm_TB-qg-1; Tue, 03 Jun 2025 20:37:30 -0400
X-MC-Unique: JiWV8prUNcW9BYxm_TB-qg-1
X-Mimecast-MFC-AGG-ID: JiWV8prUNcW9BYxm_TB-qg_1748997449
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-310efe825ccso6228258a91.3
        for <virtualization@lists.linux.dev>; Tue, 03 Jun 2025 17:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748997449; x=1749602249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCJQT/kav5ff3pRxvzcaTAEwPIznqrXjhdq5yD+vQEE=;
        b=lKGAsK6gSwQsR7eAo+tf5JFwMG+EXOFDPLaWcvKMPol+98J3nazpllep/J8N/D375S
         e6TggaD1Rdja/iNQEozEGdmMG0EylEno9M7PMcDmL1nFT1GqOchqbGVm059qsZbEePwP
         jipdchVjGTQMvrbix9uPmtpQCSbDZD6u96JLm2eUEnUEs3o2pSPEAdFgKbrqWoMZbWBY
         LFHAjEbE/u8hLDssTHfWk6xNjkPDU71ysxUsNSl+UMdeMask+QwAe7yySJe1iSs1P1Ya
         y3T4oOcqNLOYK+GbWR3lzXGGx7DhNlWYKvQeUYHXjhKC3ock3udzq7w2sR5PcyBZbgLC
         dN+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZe6AteqVVelUQmXkJzrTbqhwbU4sTZ8i+jn+Oq3H/eU/086mXMGeEtw1hnGouyygz9gjekubQ/KGFdVUokQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOv0exWRp3PfH40XpE2fgiBLPU9gRAedYatqp0AnE+HB99Fle8
	aenpPNSCECEoAaSaiiqR9EnZo0ubZw3nvKVhkABcCADG/IMoGk9/MDt12nkAiTLh4D7TffkebXn
	b6jumgAUSSl2bnYIEqJyMbZd7xtouLdL6o1sXLKMZbi7OH8bCNO9er7NHGyIAoABJVl4cLtFfDP
	Ar6tfHjYDRGhusDkd5S2o74ck7n4SSFVYveuE4Qmkma+w=
X-Gm-Gg: ASbGnctBZ8KUTM3xORrOY1DMRYFgaWo+sPjk3fBhiw0pP1i/5P7tuYGrCnkJX7xpexV
	IRIttKSL/ka82YoXay6i+6/KtapGhOfZAsO3UVWkM00k8H8UNDpiEOZl06y59iYvkjyK8ZQ==
X-Received: by 2002:a17:90b:51c4:b0:311:c1ec:7d0c with SMTP id 98e67ed59e1d1-3130cd65aaemr1426541a91.27.1748997449159;
        Tue, 03 Jun 2025 17:37:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQeODWbQfUbRlPw0j1gKXQJysD64GEXXnB2RuYnjq0y+PzQoFeIG5PN3PQdqbkgUndiDNUyG9oiwKSrJbbewE=
X-Received: by 2002:a17:90b:51c4:b0:311:c1ec:7d0c with SMTP id
 98e67ed59e1d1-3130cd65aaemr1426509a91.27.1748997448759; Tue, 03 Jun 2025
 17:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
In-Reply-To: <20250603150613.83802-1-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Jun 2025 08:37:16 +0800
X-Gm-Features: AX0GCFt_tMiNdtyDIBlXvuQJILPten36fjn0u2OKQnhU-6uwjA7mU6t1xM2SrDY
Message-ID: <CACGkMEuHDLJiw=VdX38xqkaS-FJPTAU6+XUNwfGkNZGfp+6tKg@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in zerocopy
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8czkrIFcK3_3NaMGi5gvzKfAVMSlKIWx3SErZGBomJ4_1748997449
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 11:07=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> In virtio-net, we have not yet supported multi-buffer XDP packet in
> zerocopy mode when there is a binding XDP program. However, in that
> case, when receiving multi-buffer XDP packet, we skip the XDP program
> and return XDP_PASS. As a result, the packet is passed to normal network
> stack which is an incorrect behavior. This commit instead returns
> XDP_DROP in that case.
>
> Fixes: 99c861b44eb1 ("virtio_net: xsk: rx: support recv merge mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a..4c35324d6e5b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1309,9 +1309,14 @@ static struct sk_buff *virtnet_receive_xsk_merge(s=
truct net_device *dev, struct
>         ret =3D XDP_PASS;

It would be simpler to just assign XDP_DROP here?

Or if you wish to stick to the way, we can simply remove this assignment.

>         rcu_read_lock();
>         prog =3D rcu_dereference(rq->xdp_prog);
> -       /* TODO: support multi buffer. */
> -       if (prog && num_buf =3D=3D 1)
> -               ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, sta=
ts);
> +       if (prog) {
> +               /* TODO: support multi buffer. */
> +               if (num_buf =3D=3D 1)
> +                       ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_x=
mit,
> +                                                 stats);
> +               else
> +                       ret =3D XDP_DROP;
> +       }
>         rcu_read_unlock();
>
>         switch (ret) {
> --
> 2.43.0
>

Thanks

