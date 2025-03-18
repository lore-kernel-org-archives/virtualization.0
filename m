Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5179622EE5
	for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 01:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742260391; cv=none; b=Ak1bqNIWJgb2irrkW9SyhuUB6gyVoTG475oddgUkNkmKpkrBbbJwgz2GnfAFNgLB9MLsrXz8TiERuq4FT1i1iX6z2oRQKDHcaWTUJ8M0e17fOrvSqeu8aTqFif1PGNHt+Wl6opbi/pjFMgxhFLwQocgVMxNg4g/OTnsUp7mlIgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742260391; c=relaxed/simple;
	bh=vVnJRAcF4XjPI6SSdN6jevcltS6LnQAekeugzFVLO8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Og6jHGjExb1yCta/AoKKxYVpp+ZePPkqharlQuw3NGPzesz5s1qxMU74zPHmvMveCj0irXsmnHVnvLHMO3UONNSW0eLjBhuKkGmQtCFZYHF1A8n0/Vb4B+TIbb5fCuiRfg/mqDoqwlIIb+LiYGn7sQ3FeIzfqcATc66S34/F2mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hb2bssKs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hb2bssKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742260388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1M6tJ0kGDf/4rh9VaynueL0NEwnUCgZxe75UeVU/TOY=;
	b=Hb2bssKsnSSRd+mmFw4dX/htbDT1MCMNsQjofKA9MToMU/bPVrca2s8GjgwQUNbV5xMHxo
	ryqeDl6ACc3oLU/A+PLuf/+uGkOjVxRDvyw60q0r3sD+C+LomkVkysYyQtjh/YEDE7/DF9
	WYdiFviEQQR2d2s7zKJuHPMc54CyHCU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-bQPPUaeIOeiRmmiWGpbVog-1; Mon, 17 Mar 2025 21:13:07 -0400
X-MC-Unique: bQPPUaeIOeiRmmiWGpbVog-1
X-Mimecast-MFC-AGG-ID: bQPPUaeIOeiRmmiWGpbVog_1742260386
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2233b764fc8so86921975ad.3
        for <virtualization@lists.linux.dev>; Mon, 17 Mar 2025 18:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742260386; x=1742865186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1M6tJ0kGDf/4rh9VaynueL0NEwnUCgZxe75UeVU/TOY=;
        b=ntCgeUPHb0OPKQJTeXYQCvx7B8GEz0hAFK0OH8idPD015+sZ0t/lv7Qi2qVDXHu7un
         dM3bCKGVNxZEzb18oQNVA2V7tBbmjpDOC/J5CJ1zgj7X2pjQIW3VnSrOj24wqIjF8qWr
         o9y+4hL3SuRJ8vJCzqYOvb0p2DdzXviY6wEalcEhnMp937Wxf5wrhavmoNIAxKgELAiD
         /SIDXoPzGjISlanghebAFbvnDcX0bJSSXCsS1M0npIL5cmJGSa/6eUWMYZuOM/YIV+gP
         YSOmSr958Grqn7TdjZijZUOqWGvmGFv+kO1sUkfr5g8FW2hzxb8nSmGRwMkGP9/lfqfL
         lV/w==
X-Gm-Message-State: AOJu0YzEfYj06be/7o7cGMqG/4GhkhBAZq+Nf1F4i0cNrTnwbNxXSs5I
	a2YwTOfdTolaX9+5FvWaC6Oe7nCJ+GmxFI5DWeylwSIWMh3/GqZgdplfoEWHnPsRJrnOThTPm51
	iatuM+ap9yTkwQlSBdb5ItzG7o5QXUdYblTNXu1XwoMaYKElG5Drv1khH6tQLmXVbQLBYRPDsAV
	0hgVY6kJr7JR6iLmW0k4I+fWe9+OSApV0NytWpc94=
X-Gm-Gg: ASbGncs5/v/pqJgM+zgVs6l/vRagEBpycV/BN0unV4WhI+D2qszD18mmz27ptUMGtzu
	oLDyCyEAooMa2N6LhQ/1F9ngl7N+3Q6kOxmsPVf+s5Vru+q4zkCThIn62ihXtpM/Z3s9Maw==
X-Received: by 2002:a17:902:c949:b0:223:4537:65b1 with SMTP id d9443c01a7336-225e0af0420mr180659695ad.36.1742260386009;
        Mon, 17 Mar 2025 18:13:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIVPHDIs5M9plAOorlau4YdurAALCKn+kxBp22IbRBmqOdZKYB31BAjG6ty8opgO8ulSCd62gsOH3FMiNLFLU=
X-Received: by 2002:a17:902:c949:b0:223:4537:65b1 with SMTP id
 d9443c01a7336-225e0af0420mr180659405ad.36.1742260385637; Mon, 17 Mar 2025
 18:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250317235546.4546-1-dongli.zhang@oracle.com> <20250317235546.4546-5-dongli.zhang@oracle.com>
In-Reply-To: <20250317235546.4546-5-dongli.zhang@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Mar 2025 09:12:53 +0800
X-Gm-Features: AQ5f1JpW64jPZ95eCFPlRfsQ1ehFyqhUrVvJdzZsIx4MNfGhOKRdnRftHbIpkhg
Message-ID: <CACGkMEtOsQg68O+Nqo9ycLSq7sN4AMZ92ZvLLMEF7xYDCA5Ycw@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] vhost: modify vhost_log_write() for broader users
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, mst@redhat.com, michael.christie@oracle.com, 
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
	joao.m.martins@oracle.com, joe.jin@oracle.com, si-wei.liu@oracle.com, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BsvD96qBlb1maUwTQeDHIwHlSFgiRFu5KDaz7USDH6k_1742260386
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 7:51=E2=80=AFAM Dongli Zhang <dongli.zhang@oracle.c=
om> wrote:
>
> Currently, the only user of vhost_log_write() is vhost-net. The 'len'
> argument prevents logging of pages that are not tainted by the RX path.
>
> Adjustments are needed since more drivers (i.e. vhost-scsi) begin using
> vhost_log_write(). So far vhost-net RX path may only partially use pages
> shared by the last vring descriptor. Unlike vhost-net, vhost-scsi always
> logs all pages shared via vring descriptors. To accommodate this, a new
> argument 'partial' is introduced. This argument works alongside 'len' to
> indicate whether the driver should log all pages of a vring descriptor, o=
r
> only pages that are tainted by the driver.
>
> In addition, removes BUG().
>
> Suggested-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  drivers/vhost/net.c   |  2 +-
>  drivers/vhost/vhost.c | 28 +++++++++++++++++-----------
>  drivers/vhost/vhost.h |  2 +-
>  3 files changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index b9b9e9d40951..0e5d82bfde76 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1219,7 +1219,7 @@ static void handle_rx(struct vhost_net *net)
>                 if (nvq->done_idx > VHOST_NET_BATCH)
>                         vhost_net_signal_used(nvq);
>                 if (unlikely(vq_log))
> -                       vhost_log_write(vq, vq_log, log, vhost_len,
> +                       vhost_log_write(vq, vq_log, log, vhost_len, true,
>                                         vq->iov, in);
>                 total_len +=3D vhost_len;
>         } while (likely(!vhost_exceeds_weight(vq, ++recv_pkts, total_len)=
));
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 9ac25d08f473..db3b30aba940 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2304,8 +2304,14 @@ static int log_used(struct vhost_virtqueue *vq, u6=
4 used_offset, u64 len)
>         return 0;
>  }
>
> -int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
> -                   unsigned int log_num, u64 len, struct iovec *iov, int=
 count)
> +/*
> + * 'len' is used only when 'partial' is true, to indicate whether the
> + * entire length of each descriptor is logged.
> + */

While at it, let's document all the parameters here.

> +int vhost_log_write(struct vhost_virtqueue *vq,
> +                   struct vhost_log *log, unsigned int log_num,
> +                   u64 len, bool partial,
> +                   struct iovec *iov, int count)
>  {
>         int i, r;
>
> @@ -2323,19 +2329,19 @@ int vhost_log_write(struct vhost_virtqueue *vq, s=
truct vhost_log *log,
>         }
>
>         for (i =3D 0; i < log_num; ++i) {
> -               u64 l =3D min(log[i].len, len);
> +               u64 l =3D partial ? min(log[i].len, len) : log[i].len;
> +
>                 r =3D log_write(vq->log_base, log[i].addr, l);
>                 if (r < 0)
>                         return r;
> -               len -=3D l;
> -               if (!len) {
> -                       if (vq->log_ctx)
> -                               eventfd_signal(vq->log_ctx);
> -                       return 0;
> -               }
> +
> +               if (partial)
> +                       len -=3D l;

I wonder if it's simpler to just tweak the caller to call with the
correct len (or probably U64_MAX) in this case?

>         }
> -       /* Length written exceeds what we have stored. This is a bug. */
> -       BUG();
> +
> +       if (vq->log_ctx)
> +               eventfd_signal(vq->log_ctx);
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(vhost_log_write);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index bb75a292d50c..5de5941988fe 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -224,7 +224,7 @@ bool vhost_vq_avail_empty(struct vhost_dev *, struct =
vhost_virtqueue *);
>  bool vhost_enable_notify(struct vhost_dev *, struct vhost_virtqueue *);
>
>  int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
> -                   unsigned int log_num, u64 len,
> +                   unsigned int log_num, u64 len, bool partial,
>                     struct iovec *iov, int count);
>  int vq_meta_prefetch(struct vhost_virtqueue *vq);
>
> --
> 2.39.3
>

Thanks

