Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822DF289340
	for <virtualization@lists.linux.dev>; Thu,  8 Jan 2026 04:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767847131; cv=none; b=qG2029qlxTLwTo+xvzonfnyZcCWzsM1PktTQSwe/gH1d6ZUmf3BscmeOZXo4BSgsXQOrSddBvh6do/DxGDs6QQRcGX9jkiw+iwVXt0UK1aCsQVwJf2T376iT3xP+dYzGrgmgIzIhbfHAXEgzjdhqUW8bc5pz+YAhxFKAtZ7fFEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767847131; c=relaxed/simple;
	bh=1Mw4+/RnBE3HC1Gi2CHwhB4Ll3ThRjwOgtBMJvxn2cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdEnQBPmcvD0Nrh+Iy+7QXVVNHuQV3Nh0d/LNSKMeRdiNnA3yj9dm6ibpEzphjNtoKVN6Aah2c3LaGOftSZZVRqngC4q+MzNRWYTqoNgBIzUYa4zsczZLAdaDMNIcooWJnQCr2YsX0n7dfWCbgr2/cu/qdO9Hv9vbdBt9MFVxkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GG7/ztLi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GG7/ztLi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767847128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITK/RdRB2R5i8Otgr7paxSBzAk4X73xXTbyRHE7SKp4=;
	b=GG7/ztLi5ftZNh8vtEnStI3pSrtSbPJ1btNCJHg3mnVRyLzdBz5Gf6Y3wlEbOrr/JDcSga
	TGA0cYwt7odG85rldIHPtWRbbhbhtmT7N3GfErJOxyF9y9tZjaxAEy+HIynr0hrnt8GOB7
	rq4SkGG3uYqvNO1hXu1C0HVqNEmwxpg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-9wgb7MU7M8edVxwGHvokmA-1; Wed, 07 Jan 2026 23:38:47 -0500
X-MC-Unique: 9wgb7MU7M8edVxwGHvokmA-1
X-Mimecast-MFC-AGG-ID: 9wgb7MU7M8edVxwGHvokmA_1767847126
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c5d203988so5480703a91.3
        for <virtualization@lists.linux.dev>; Wed, 07 Jan 2026 20:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767847126; x=1768451926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ITK/RdRB2R5i8Otgr7paxSBzAk4X73xXTbyRHE7SKp4=;
        b=oNM5GHwQESAMIFUwjB4YCP2vpXJZgaGt5Q6dUOn6f15JIjqKu8ml2BCKaRSJJ7plIM
         qq6/R5ACPriZ2NOk7csBV062gxyKLvwyP8pGfH2x4jV/bQvuCTn1GXdDhNEHNuU8WpLa
         NgO9+ufQrTbULe/Z3Mk2qGnzdJVX9tWjkcRIYM8/8Vfy99hJuXmjzTvcwQiNio4ZvOjv
         3dzRvGiLB9fQ/ozn1475S8y1ePU6SG8dNx693RoI4HqedNRKgM0AUnVG5TzlLkX8O0f9
         QOse289b99YsLYnWqEE8o2cCHrnlJAz/8sxlbYXS9CmlfKkBzz1xGw4e8HfwYUE0QyQH
         UW1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCCy3tpdTP3o8JnGsZM1OaOdSX1yHEsA6cOoJEbTMGJOJqGzFREN2IYFbUGlfUuZhX6xakxcDRYK9HlUVO1w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzr+0iS51XkYUW68dvop7vpdESxYAsKF4HNuIg+O11c8KW+VhZH
	sig9/aog9gxy5ZKaT05Dcw6UI7Cl6iUhgtCERh5WOG7k/34ZrMkqZDh6cfiYeus96xt80gQR2XF
	KcuWUn3KJEBRIotTt2IarZuHpmdZiiRfgsqe2riJ6X9LsQ09DD5+Ik6sEFcskYfjGG79JDf5omF
	bQb2/m4QH1O4CivosRRrTWXCgzgzO11cigbj3axW3X0zw=
X-Gm-Gg: AY/fxX5q1NujJjijWpRSEqzhBPByhFQ/F90vmHGZdVzang7wGvf3vIUzLyWIEB/ycMs
	5I5KaUGPqMjJ5Pgx/c4fsYPythAv98utyzdLWEzkGspgIaBhARbJAkfrcDeHreaCJKYj0p0gr29
	iRoX7OiA99zT1mECg2W+rqyVjWvGPcSfcc6hnnfcvDpbMFqW5SpzAzgq8KUP3hoE8=
X-Received: by 2002:a17:90b:38cd:b0:340:ad5e:cb with SMTP id 98e67ed59e1d1-34f68b8325amr4472105a91.8.1767847126208;
        Wed, 07 Jan 2026 20:38:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5VQZiGe7r1S4uFGT8iu+UqDGLcVAm47K+xxuFBZErtPwJUSS5ANbzbriNBgtK4Or956wAzsqxr3sqB3YdRdc=
X-Received: by 2002:a17:90b:38cd:b0:340:ad5e:cb with SMTP id
 98e67ed59e1d1-34f68b8325amr4472074a91.8.1767847125793; Wed, 07 Jan 2026
 20:38:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de> <20260107210448.37851-8-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260107210448.37851-8-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Jan 2026 12:38:34 +0800
X-Gm-Features: AQt7F2ojlTg8w4ZELX6uaVy4snIzQbNmqFa41GC72EmW5kfc8xJcEouDgWh6mwE
Message-ID: <CACGkMEtndGm+GX+3Kn5AWTkEc+PK0Fo1=VSZzhgBQoYRQbicQw@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: pIItHMzcDLhO7EFg-iDytJ57-ZcSMzgtKtxS3WgNPGw_1767847126
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> Replace the direct use of ptr_ring in the vhost-net virtqueue with
> tun/tap ring wrapper helpers. Instead of storing an rx_ring pointer,
> the virtqueue now stores the interface type (IF_TUN, IF_TAP, or IF_NONE)
> and dispatches to the corresponding tun/tap helpers for ring
> produce, consume, and unconsume operations.
>
> Routing ring operations through the tun/tap helpers enables netdev
> queue wakeups, which are required for upcoming netdev queue flow
> control support shared by tun/tap and vhost-net.
>
> No functional change is intended beyond switching to the wrapper
> helpers.
>
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Co-developed by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/vhost/net.c | 92 +++++++++++++++++++++++++++++----------------
>  1 file changed, 60 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 7f886d3dba7d..215556f7cd40 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -90,6 +90,12 @@ enum {
>         VHOST_NET_VQ_MAX =3D 2,
>  };
>
> +enum if_type {
> +       IF_NONE =3D 0,
> +       IF_TUN =3D 1,
> +       IF_TAP =3D 2,
> +};

This looks not elegant, can we simply export objects we want to use to
vhost like get_tap_socket()?

Thanks

