Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062EF4A2D
	for <virtualization@lists.linux.dev>; Thu, 13 Mar 2025 00:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741825603; cv=none; b=jcy1w4NHuQH43ANbDafXZqMzBvtthhefMQ5dJSXyTjCeZ6yu8QfIuG1UeG3h7yc5qHWGAwRmJnsMbsbBGBTB9IVfDeaCVVJCYi4QQfrNVUTE3t2pQ022X1bbZEvPAxJDjj9IS2XdsBpeAOgTwXryPn3Cn+nhUCJNuljnTBV5WvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741825603; c=relaxed/simple;
	bh=6Rc6J3Ph6dfxqwkjoMVz7ABCl1ew9fnFyyH4KQ9IHWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1cin5D+ee6SADanUlLgSVRiBv90HG/6zXrZ8t5ZXMgbT2edzXV8+HajNorqMwg86fKFUkkQxoJaBBw1myawkIxwYJdTZ/+RA0w0i+efn88ltVWYTDMulQmoi9oSu3isBYfhJDwvs08j+PyQca/T6BWTlkMbD9szByxG+yqtiGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UFjkCsOv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFjkCsOv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741825600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2xc6FM+mqWnW8B2obbyayW6a16PfjrreKGG+xe06AIA=;
	b=UFjkCsOv2d7emEV4mdhEbI5mm18RaVyez2mvxoR97mut307EZ2dV8OmOKi33sSgmiY2cdx
	oORB0Q3MTEmGL3rUDMn9/Np4/xuN95B9NgZi/ruseSEqhD8G54Cz09e+Mhc37NPqcOtacW
	mOHd7ce4fqF602i2geW5fTvaQ9Ffj/s=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-ccR_lbTxPcauRmRc3hN6hA-1; Wed, 12 Mar 2025 20:26:38 -0400
X-MC-Unique: ccR_lbTxPcauRmRc3hN6hA-1
X-Mimecast-MFC-AGG-ID: ccR_lbTxPcauRmRc3hN6hA_1741825596
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3011c150130so663995a91.2
        for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 17:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741825593; x=1742430393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xc6FM+mqWnW8B2obbyayW6a16PfjrreKGG+xe06AIA=;
        b=TDTd+9F5badwW8Ty3H5ILSHdy+5ZbxFLtnIPuEkx/IBifevUOABsCNqwwfw+obr40E
         PqmttQI+UGuqgBDPEgmH17yjRcq+gnKZzsEVrj3lnYrTJh8Qy4P4ZW2mG7RyPFsxTiFG
         o1dGQOelzy6e/bjEQ/rKp5oFsv0ipOyFGZLrOz8gDkLVVX2xznYr3vOOzq+7RD0KtB/B
         QlqQ1PMUFsCl6V4wwoSf3T/WzKiw+kC9nYA5ZTpyR5xfdDS8SjuJB9dpYHR3gioiEgtR
         NHQxfkTafC77vopz31t0spChXQ0hjq+erN64SeM1GZq9PVU5zVew/M3MFH1EijKojTjx
         8oKA==
X-Forwarded-Encrypted: i=1; AJvYcCV2kovx90K3Y3ghR+YbWisccVmf8nkl/olQM2uiI9jNeWfXeus2Tmqp07T4PgYByxa7YFYJzLZ6L4PzTd81OA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3UCVTsC+BGu7rAoLdlLKaX5EKYnGtiw0dyRq1JoxdPYx1QqHm
	t1t99670K11Rgck6LAo4ZZccAIrf8VIGbAayaOHsiTOXAZtO7yO7WBO9jyvw/+v6cAAh8kVGwPd
	uTDdhC7FGUefVQn4g595ShJbNcHHOsi27ecQzfYgLSiks1IHp57KMY6zsFYHUx/VxxVoFTDdF//
	SD0FF6gLDAaoPaPPzz7NC99ac0dlp8amgpqZ1yTgg=
X-Gm-Gg: ASbGncvY1OlFm6KDJDYAhFinBLAVDCy6G6S6c1Fg7ElAXmbm88Cc1hGxj6fh3QCUznv
	eoHiT8ZBOK58OiV/v0KZAyNCusYjVoX1/yV4tB4B6IpIvfwn0VlbCM7hVUGY3wFQuJLaSWw==
X-Received: by 2002:a17:90a:d2c6:b0:2ff:4f04:4266 with SMTP id 98e67ed59e1d1-2ff7cef5c11mr28261645a91.23.1741825593460;
        Wed, 12 Mar 2025 17:26:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3dWZ4QwsfIUvoSozMvh5gYtrSDcXVdnTP4UK28eIoOYkpHPAKxIFpR9h9De/pEc9Z+J0NEctSIkQBCBJ5tuk=
X-Received: by 2002:a17:90a:d2c6:b0:2ff:4f04:4266 with SMTP id
 98e67ed59e1d1-2ff7cef5c11mr28261612a91.23.1741825592977; Wed, 12 Mar 2025
 17:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr> <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
 <Z9FicA7bHAYZWJAb@fedora> <20250312-conscious-sloppy-pegasus-b5099d-mkl@pengutronix.de>
 <Z9GL6o01fuhTbHWO@fedora> <20250312-able-refreshing-hog-ed14e7-mkl@pengutronix.de>
In-Reply-To: <20250312-able-refreshing-hog-ed14e7-mkl@pengutronix.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Mar 2025 08:26:21 +0800
X-Gm-Features: AQ5f1Jotgxkur0pCBX2T6-2ZHfB5Ly_E8Asn7gts-0i5WF5UC5k-dBCU_8yc-ak
Message-ID: <CACGkMEtHZB8bLMqepRxd3qvtXWA8g_5pofNBw1=XvxF4ANr6Cg@mail.gmail.com>
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, Harald Mommer <harald.mommer@opensynergy.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>, 
	Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y3T-FZhFcZZ4rg8zJ5tC7lfgiHCoUKW2OKk1qqdkPcQ_1741825596
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 9:36=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>
> On 12.03.2025 14:28:10, Matias Ezequiel Vara Larsen wrote:
> > On Wed, Mar 12, 2025 at 11:41:26AM +0100, Marc Kleine-Budde wrote:
> > > On 12.03.2025 11:31:12, Matias Ezequiel Vara Larsen wrote:
> > > > On Thu, Feb 01, 2024 at 07:57:45PM +0100, Harald Mommer wrote:
> > > > > Hello,
> > > > >
> > > > > I thought there would be some more comments coming and I could ad=
dress
> > > > > everything in one chunk. Not the case, besides your comments sile=
nce.
> > > > >
> > > > > On 08.01.24 20:34, Christophe JAILLET wrote:
> > > > > >
> > > > > > Hi,
> > > > > > a few nits below, should there be a v6.
> > > > > >
> > > > >
> > > > > I'm sure there will be but not so soon. Probably after acceptance=
 of the
> > > > > virtio CAN specification or after change requests to the specific=
ation are
> > > > > received and the driver has to be adapted to an updated draft.
> > > > >
> > > > What is the status of this series?
> > >
> > > There has been no movement from the Linux side. The patch series is
> > > quite extensive. To get this mainline, we need not only a proper Linu=
x
> > > CAN driver, but also a proper VirtIO specification.
> >
> > Thanks for your answer. AFAIK the spec has been merged (see
> > https://github.com/oasis-tcs/virtio-spec/tree/virtio-1.4).
>
> Yes, the spec was merged. I think it was written with a specific
> use-case (IIRC: automotive, Linux on-top of a specific hypervisor) in
> mind, in Linux we have other use cases that might not be covered.
>
> > > This whole project is too big for me to do it as a collaborative
> > > effort.
> >
> > What do you mean?
>
> I mean the driver is too big to review on a non-paid community based
> effort.

If you can split the path into smaller ones, I'm happy to review.

Thanks


>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

