Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806B328980E
	for <virtualization@lists.linux.dev>; Fri,  9 Jan 2026 06:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767938666; cv=none; b=go6IBwiYPXFrQLuNN1slfTk70tCtmTlN64zphXHHVdsq0GomDhFGRIoHMJtOxCbgjRfYCE83iDGBJjrplIKdmYNA5CR2t4hfZW1PD3Dq4sdsrOLpk98CnwfFhAzyEfDilgN90lIQX/iCl0/SJwHauCEqGPJyKXoQ0HtjSMZtZ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767938666; c=relaxed/simple;
	bh=K/AQAxHPYO+xESgKb7dsvzgDxLsXGlauHRN5QI/r2ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9MvoTpUBl7Y7CxWMmsqVYTLYkybtQyg0Xh+5f16vytA+s3wRiaPN7f7DsrOlCKzmtJlhZi9WAQrPpmVlOemTSUxpPaOyQkvCP/+0Zh/cSZ+tifOXWZ5dBp/IgATMawkIYx0vaLhIP0ovBkQuNaTH7EEduyR76bQB6r5GPRUYrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TD7QZy09; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TD7QZy09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767938662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9euP3q0+K8AwZBKxdvyTpCOtWvHbXFyeoGTxktHAEbg=;
	b=TD7QZy09b0XRqObBQnu8WxreTd7O0j9WQQNpLYP5XHBKminxYpxB78xpP1yCMW1X6BIg6+
	Q/BvbZoIyDqz2knLal6J/7N0Up7wMpYkLnnGvAZd/mrlpxvTG1TZdiuVZKEhE3ElLcaL+Y
	K5XcPsXxBJfa+49fA+xbLqhukQvU5hc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-lvVLBIckM76Ie34QxU1Kbw-1; Fri, 09 Jan 2026 01:04:21 -0500
X-MC-Unique: lvVLBIckM76Ie34QxU1Kbw-1
X-Mimecast-MFC-AGG-ID: lvVLBIckM76Ie34QxU1Kbw_1767938660
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81d9b88caf2so680867b3a.1
        for <virtualization@lists.linux.dev>; Thu, 08 Jan 2026 22:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767938660; x=1768543460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9euP3q0+K8AwZBKxdvyTpCOtWvHbXFyeoGTxktHAEbg=;
        b=Kgu/nWUrITAq0HCo62Y9QztNd+skrRTraxhSKRMgZTQkia+x7MFmK6m4/xrGCHNnWt
         TMJKIle2IKLIJGKuiHjOu8WaohSb9QMv9dfNAxauMQkqJP19uzGpk83inVArG6nVGAul
         LUiqu87qh/kYgzkjdvUDWdGwlM670Agz6aZRuy8Dm+2Z1JAB/uoDETOTI6+YPRVWhvjZ
         vw1JBGKGkWFN1YiIAstREEaQB+EKyMMAkB+hrtmA7E2eb8TUhQlBifb9OEpKPkshi0L2
         nQZA7lxS0HKEIF91t+Cv4ZzFOv1JlQPhOtZX3cYWScFDu5DaFfVJAcDx5qmz8LqBGn0H
         8mJw==
X-Forwarded-Encrypted: i=1; AJvYcCV4umktMm4ohiBKgxI4IlG7byBRMVVp74eQB96FEJjXCyUbA39zhG31QvxWcwGjU8zhIFP4lQLJWNFzbVEAIA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz57Ixfd5EtD+pVo5w3ynWHeSd1ydYDcgR7QHGYlKb1zj07VYjJ
	7YBWaTZ3nQOtx30JwRLo+E2pi3ZoMrcTWbbglGbEGVNY35IxKivADwlgzKr+TcAtZRGHmelFZSx
	FxwdmcLRLyYTRkGGa7Us04Dt1Yl0fOKU/M+0vYEszs60ARULCwoU0BBNvg9HBJFcby/fH92uUKb
	EUVSkqAXW2n1IjFsRbxun+2q80bUGg+2zGe8py89rNpvk=
X-Gm-Gg: AY/fxX60+ZPb2j0crjMvDyPK+kbeM5OT+0vPXrSMnQvFfJUJVTW81iPnZIRnNlyh7GW
	fvfwE11KpPGF5IzozJMIop3L3TKoEO7hR56FY8khcbBru4Bx1UrHILd07TEb7rYrgzICbwzUEZZ
	WMbr3DR45SotyXiSX+qaDidjrCBhD+VL3QRdXCl/etSniugEymP3DtUu8zBm4zwFw=
X-Received: by 2002:a05:6a20:3d0e:b0:37e:4319:d7c9 with SMTP id adf61e73a8af0-3898fa56a3amr8187083637.77.1767938660191;
        Thu, 08 Jan 2026 22:04:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHks8HlK8qz7tOXnNtDUBht+V9M/gKJPD9ctTiTc2gpfN67WzvNH4nzU7jF/ixjfYRwtv/VDNE2iyuLZO3PQg=
X-Received: by 2002:a05:6a20:3d0e:b0:37e:4319:d7c9 with SMTP id
 adf61e73a8af0-3898fa56a3amr8187060637.77.1767938659753; Thu, 08 Jan 2026
 22:04:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-8-simon.schippers@tu-dortmund.de> <CACGkMEtndGm+GX+3Kn5AWTkEc+PK0Fo1=VSZzhgBQoYRQbicQw@mail.gmail.com>
 <5961e982-9c52-4e7a-b1ca-caaf4c4d0291@tu-dortmund.de>
In-Reply-To: <5961e982-9c52-4e7a-b1ca-caaf4c4d0291@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 9 Jan 2026 14:04:08 +0800
X-Gm-Features: AQt7F2rgadpgQhtK4XQcquScTSmPGhMX0nFO2ljkD4pebbVz-Sl7My5aAmLeFXY
Message-ID: <CACGkMEsKFcsumyNU6vVgBE4LjYWNb2XQNaThwd9H5eZ+RjSwfQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 7/9] vhost-net: vhost-net: replace rx_ring
 with tun/tap ring wrappers
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f-H3w5WDYhwIWUZkQs6Oe1RjngnmS2vL2BRN3umgTn8_1767938660
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 3:48=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 1/8/26 05:38, Jason Wang wrote:
> > On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> Replace the direct use of ptr_ring in the vhost-net virtqueue with
> >> tun/tap ring wrapper helpers. Instead of storing an rx_ring pointer,
> >> the virtqueue now stores the interface type (IF_TUN, IF_TAP, or IF_NON=
E)
> >> and dispatches to the corresponding tun/tap helpers for ring
> >> produce, consume, and unconsume operations.
> >>
> >> Routing ring operations through the tun/tap helpers enables netdev
> >> queue wakeups, which are required for upcoming netdev queue flow
> >> control support shared by tun/tap and vhost-net.
> >>
> >> No functional change is intended beyond switching to the wrapper
> >> helpers.
> >>
> >> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Co-developed by: Jon Kohler <jon@nutanix.com>
> >> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >> ---
> >>  drivers/vhost/net.c | 92 +++++++++++++++++++++++++++++---------------=
-
> >>  1 file changed, 60 insertions(+), 32 deletions(-)
> >>
> >> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >> index 7f886d3dba7d..215556f7cd40 100644
> >> --- a/drivers/vhost/net.c
> >> +++ b/drivers/vhost/net.c
> >> @@ -90,6 +90,12 @@ enum {
> >>         VHOST_NET_VQ_MAX =3D 2,
> >>  };
> >>
> >> +enum if_type {
> >> +       IF_NONE =3D 0,
> >> +       IF_TUN =3D 1,
> >> +       IF_TAP =3D 2,
> >> +};
> >
> > This looks not elegant, can we simply export objects we want to use to
> > vhost like get_tap_socket()?
>
> No, we cannot do that. We would need access to both the ptr_ring and the
> net_device. However, the net_device is protected by an RCU lock.
>
> That is why {tun,tap}_ring_consume_batched() are used:
> they take the appropriate locks and handle waking the queue.

How about introducing a callback in the ptr_ring itself, so vhost_net
only need to know about the ptr_ring?

Thanks

>
> >
> > Thanks
> >
>

