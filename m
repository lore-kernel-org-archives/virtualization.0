Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3146D4A07
	for <virtualization@lists.linux.dev>; Mon, 10 Nov 2025 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762758985; cv=none; b=Tl+AIo0LIhFXg2Nmd1+sXxojLNNaCP/KNzu/3Lwzdc9FBvEkcNCBZcq9cVPqICNi0dCO+Uc0D+4yHnm36k9eV102/BLPKheDknTY4Yd1T8UEWFS2ko6dRM8eJzQ/Fe7dFF4BOR+o+AT168kb5t5GE/93p5q5NCQVDdhkvFhF4gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762758985; c=relaxed/simple;
	bh=woNJ/L3aR+lFVkkQCQU3hOMfYvGPT0/Us16RZEML7Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ov0uKTpcm8J+kNr0QMuZPzzS1ebs0EHPn/TwqDhbevIPROtYDEqmQEFR2Sut2jcXliHHBb/YdCJ08BFjXBwb/12kL1D+MI5w7JUKkcJJ1eptnfZcRepLTjwL9oFwTLP9YFVQNvjaDWTBV6AwpeXvBaDJD9OVPN6/YcBQ5vfLwAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIgxcZIj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIgxcZIj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762758983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=woNJ/L3aR+lFVkkQCQU3hOMfYvGPT0/Us16RZEML7Qc=;
	b=UIgxcZIjy/tkRmwjMHmn/U2Q0ku20Ubf0e8TIF1k2K0+WRkS/eC1gaXl6XNjXp+E6wGaI9
	fo3j1gLUbsytCYeYRCKLWHXEyKc9N1Fp4FixX2ByUZSALjAGhe09V9hYVH7ergAEEhMWG3
	H3lmmJ81fFEfsjc99EaTqEsmV8OQEcI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-PvXr71LSPz6h8Gn_1UgHYA-1; Mon, 10 Nov 2025 02:16:21 -0500
X-MC-Unique: PvXr71LSPz6h8Gn_1UgHYA-1
X-Mimecast-MFC-AGG-ID: PvXr71LSPz6h8Gn_1UgHYA_1762758981
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2982dec5ccbso8333385ad.3
        for <virtualization@lists.linux.dev>; Sun, 09 Nov 2025 23:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762758981; x=1763363781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=woNJ/L3aR+lFVkkQCQU3hOMfYvGPT0/Us16RZEML7Qc=;
        b=pWERXsQPsI91v7bYqP+9HnBsbVawjmr3ISZy7K5FqXlu0KbOxVykXOUGvsRuvraHu/
         y0XKiiXOi9NhnsoDQ4yBYk4cln0Y1i0RPrUPHoz2kg9FhdZHkr3pgGCQmxe5tPLQxCMc
         drtvYyOLbljJ1mdqK67FKruz1aFa6L8JlMF13SFoT9NzcsiMJNmMhgsK0CRn7fSZoUCB
         ogaYxC/uXO41+pyHTMSO6DQFiLxFqmhoPgbvpN9i2EGIyAxktDMGxMyUEvMPwjELOLY9
         q+pgNxJ3qOWYuxlxJtolaJ8G1caaYKDqwG17ZvidE21ybiSaWlyYMfBNfGbnq0H2PlfV
         T4Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVsTTO6yrYNu/QKfiXW1ApTpHTvipJqWXzmsXvt6qZYPsWlQaeUjKeeUMHUIYvzkAMhGhcxgkh5G4lO1J0csQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKGKx5nYRbwFzfv9Or1kk9hN1XFt/pHvhsZbyRGWKbQBEFgtUi
	qtRS5jbAm93QmpZvrkzBiFkL8qotjC0TepwY4dDj4WOcYlatcM+EYhXF0+09xRbBsGj3ivmrdTA
	IfUgkMCmkyrbbV3HCDzI21aacChXT5gsDDKIDAIMaU9reMCZPY9s1+N/WUdTgpOoNvCnMeJrZ81
	PwXysQ1A2d5TzuXRTXaIrr4r2v/B6TiBt2BIC4bRvBJe0=
X-Gm-Gg: ASbGncv/wceSgzb/uHQnJYYDdEtzbkYvFkngKo9oGgZ+vjQHN9d/I5j5kgZ1bSdWhI8
	mkus1ZrUtLS6kGRhxDJP4/5T6C445Zuq9GND6ly1OVL9rSzBBJZPNjhKFYdGMYGUiqNORMT6uIX
	72uCyRV95PBUcfyLGYWdxqYnVQz158ntTR9OqdwQ2Cc9cbdsZeYS8r
X-Received: by 2002:a17:902:c94b:b0:294:9813:4512 with SMTP id d9443c01a7336-297e540dd6fmr99366225ad.3.1762758980721;
        Sun, 09 Nov 2025 23:16:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyWxROkXiMDUVSb3RLFtOHycy16XKfPRQV2OSVyu8OSlagDoRuUKg6J6cQIIbyBm0s3zF/+eWz7qoXIAaK5M8=
X-Received: by 2002:a17:902:c94b:b0:294:9813:4512 with SMTP id
 d9443c01a7336-297e540dd6fmr99365985ad.3.1762758980269; Sun, 09 Nov 2025
 23:16:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
 <20251029030913.20423-4-xuanzhuo@linux.alibaba.com> <CACGkMEu=Zs-T0WyD7mrWjuRDdufvRiz2DM=98neD+L2npP5_dQ@mail.gmail.com>
 <20251109163911-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251109163911-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Nov 2025 15:16:08 +0800
X-Gm-Features: AWmQ_bnkx6vTf5wHnwoJGVSoRMptjjphfDUQyvyoKqLw1ru0NtOodqRvT7p8cgc
Message-ID: <CACGkMEtxfZh=66TSTC2B8TdXWP-fsTrYFkfz5aOViYkZmmcvxg@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, Willem de Bruijn <willemb@google.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lT_Ko0-zN1pt6CqMTDCWO--Cyz4G7sF__JTQsCpezeo_1762758981
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 5:41=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Oct 30, 2025 at 10:53:01AM +0800, Jason Wang wrote:
> > On Wed, Oct 29, 2025 at 11:09=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > The commit be50da3e9d4a ("net: virtio_net: implement exact header len=
gth
> > > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> > > feature in virtio-net.
> > >
> > > This feature requires virtio-net to set hdr_len to the actual header
> > > length of the packet when transmitting, the number of
> > > bytes from the start of the packet to the beginning of the
> > > transport-layer payload.
> > >
> > > However, in practice, hdr_len was being set using skb_headlen(skb),
> > > which is clearly incorrect. This commit fixes that issue.
> >
> > I still think it would be more safe to check the feature
>
> which feature VIRTIO_NET_F_GUEST_HDRLEN ?
>

Yes.

Thanks

