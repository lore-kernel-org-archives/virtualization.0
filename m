Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E302DEA6E
	for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 05:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760335036; cv=none; b=W5+zH4amiudJlTs4+9TjlQljbcngW22/7PUGp92ifzSppZ8xAULZUdzJF38UASdPstL/2yLpcBjWcPc50DuotgXzwnGqOB/JzFsxxVarKIFGgNysCVhWmEEJAyJbQMjw1rWeCKTr3rbLBbSufSBpe1q1peRwUpGXzHJ7hrwo1Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760335036; c=relaxed/simple;
	bh=GNr9HIVCO7ET2qTQE2UUyDNtrbTlpLvWSYXgJNwgEz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcaUJkTjL1ecYdRGCT4D6/5NY8PfK54Qzg7XpXfvxVtxMLtpS3BTGf1MZuF+dQIpnXP7eLPguXXqv1pyulD7aXFJAcK4LYE5F4Y2qS5gejU11IziQKhawzwEe2NEVIMBzmmb0ikgB+Xh7ESbuoXkLK9Qz84yvDuaq4RuwXz0cpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBx0NxsD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBx0NxsD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760335033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rTBbY4ERQzfsiR/UCEXfoNcgIIzJ1jIibSchJTMZ+g0=;
	b=SBx0NxsD7GTa7x3T9zHXsOLho8lL3DQxEQFpuGu0V+nC5Cwm4fGj1c0NQGTrOtXNbRMl/x
	oMYMZuxq6H06yYNGXmi4F32dkLQgu3t1HKZJ6Jc2AjHSKOZxCnnKgZudiMFC7GL+KnxVrT
	xY+CZijVXjGp1YGIjbb+wnR4BRgkdOg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-dz9RlivtMFuRAwg7CKngxg-1; Mon, 13 Oct 2025 01:57:11 -0400
X-MC-Unique: dz9RlivtMFuRAwg7CKngxg-1
X-Mimecast-MFC-AGG-ID: dz9RlivtMFuRAwg7CKngxg_1760335031
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3307af9b595so7722679a91.0
        for <virtualization@lists.linux.dev>; Sun, 12 Oct 2025 22:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760335030; x=1760939830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTBbY4ERQzfsiR/UCEXfoNcgIIzJ1jIibSchJTMZ+g0=;
        b=mENzI71dH/BPkm52e9VlBhOoelPpKtFuNp9Q5LLyQ34989TfoB/r7HVbHNaP82fMAA
         yAw855xpqRPgGKjKcQgWOM4uoabPSnXw7jOcsnupMT1JemOkLjPxNWLELU8rlj/Dy3Ve
         Qb2e2KvjdmD1G8TnwJY37mhxNxTY8SFq9ZT+e0iNGZAed12mCbljzJpp0C73dwaN2ti8
         hT0qO+BZ3LZ0K6XJCVSng+y69nk/ks9tUF+vzW5f4aOO7LUmRxXI5CLmnIWoGqyrCqfe
         5oUviaJ+IIGwC/YKZpWtTciMkHW3Sren90qjmCW5ylIDsDmk0ZFqAJfOWsO92uqUwwT/
         kvHg==
X-Forwarded-Encrypted: i=1; AJvYcCXFY2c0qnyp4i+ZyN7HorfwIOksaGeOjX7if7E/q0COjC1RHw8CLB1u5oy+FrmfPlT1O6c7t+iETTCmUeut8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlbHdiTo1mon+OoMehTBQ6BJ20gcNZ/CZo+mjPKZ3r8zd8/Kt9
	ZYc3bGzz/4te7mRN4KWTDsWmu1Iyt2I5SpOG9lregPx6t/n3KKiveG1Xmhcah3SS3sZebmr/zCO
	fjtwGaXRXIRhDou9jVd1FnMyIVD3ZIEPh063hrpaPK4lDb0h00djfj54zfiSGm2yBqc15LwiQyT
	DWGIqP9BSYvqEmDTA5+husRM49NKv4kuYCXps1CWkSdEw=
X-Gm-Gg: ASbGncsHYwg59MzASyVn568wRxJZS5FHU5K/Scj4s2NlLSaqd02jX7rY2VeVpNHJBZh
	vigRcQtJGA4wMePTUgITG9Cq+rWlJ7e/f++c2UvqPr8MDMHnRpfcrmeIU7Jc+I/ndria+j21wAo
	vvcjXq4PTL6m7zsuT8UQ==
X-Received: by 2002:a17:90b:33ce:b0:32e:ca03:3ba with SMTP id 98e67ed59e1d1-33b513b233cmr25472476a91.22.1760335030541;
        Sun, 12 Oct 2025 22:57:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+1ASVfPg+lv3jSt18c0CP35x0+AGwhiwZAYn/wCujwDEfGVeBA93XTgv9bz62fD/SkCCE1X0vWwbHFagz8RU=
X-Received: by 2002:a17:90b:33ce:b0:32e:ca03:3ba with SMTP id
 98e67ed59e1d1-33b513b233cmr25472454a91.22.1760335030144; Sun, 12 Oct 2025
 22:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251013020629.73902-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20251013020629.73902-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Oct 2025 13:56:58 +0800
X-Gm-Features: AS18NWBMAKf3DfwXNPEeWec1id0-xVBudV2t5aLXFJknu5e8GZOXPWDvpzof4kY
Message-ID: <CACGkMEugrT0K3LcJsPaN6FDncvBgXRLkG6By8scm8PyABF2BUA@mail.gmail.com>
Subject: Re: [PATCH net v2 0/3] fixes two virtio-net related bugs.
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jiri Pirko <jiri@resnulli.us>, 
	Alvaro Karsz <alvaro.karsz@solid-run.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c5S2dpMov-7rVhUqSyxQ3NaqGxRjk5uGZu5E2vKz56o_1760335031
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 10:06=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> As discussed in http://lore.kernel.org/all/20250919013450.111424-1-xuanzh=
uo@linux.alibaba.com
> Commit #1 Move the flags into the existing if condition; the issue is tha=
t it introduces a
> small amount of code duplication.
>
> Commit #3 is new to fix the hdr len in tunnel gso feature.
>
> Hi @Paolo Abenchi,
> Could you please test commit #3? I don't have a suitable test environment=
, as
> QEMU doesn't currently support the tunnel GSO feature.

It has been there.

Thanks

>
> Thanks.
>
> Xuan Zhuo (3):
>   virtio-net: fix incorrect flags recording in big mode
>   virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
>   virtio-net: correct hdr_len handling for tunnel gso
>
>  drivers/net/virtio_net.c   | 16 ++++++++-----
>  include/linux/virtio_net.h | 46 ++++++++++++++++++++++++++++++++------
>  2 files changed, 50 insertions(+), 12 deletions(-)
>
> --
> 2.32.0.3.g01195cf9f
>

