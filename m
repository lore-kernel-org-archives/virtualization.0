Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6ED2F1FF6
	for <virtualization@lists.linux.dev>; Mon, 29 Dec 2025 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766992610; cv=none; b=h6Kiaa0sgist1AqGnG60Qi+xVlhljHERZdFOB44//Mfhap9rIkP5mudyw/igmb6KjanyYxT56tIwDBeebyMJb0r+bCIDE/SUvEkUQJZfzhRykLOmhA3EwM6/8W9K5nW6Dz5YvBiZYudxRb3u1dX1FO8LzTAZiDWHwXYKmcoHLoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766992610; c=relaxed/simple;
	bh=9nMy6UIKiJjQDrZOmtzJeU9J+pC5jzt6vP7kK8x7wAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F36oKpH4iKc5gv0kimEJ5+eE6oTPq24ITI+WXxHLDCkv1tD4MEKk+uDUWY5jMCdKWoDstzVdFdc8l1TCU+cjg1pjvbypMY6/zPIgxtyD+hAs9iAFKns2TUIl6ZvAbjZiLL9GYI9bynHHOo27MdeG6iMTN2Ml7KZ40BaDFoYByHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwYqkTIY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwYqkTIY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766992606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQrOk1Jj8f6z61HqfLzQc4Y9ZdE0PdAOAqjoNpizJQY=;
	b=dwYqkTIYkflpC63pRp+VVfvnA1rHunxCRnZPPWpbbWkUlj7teHV41IQrjL/jzYTiIl3Sjn
	tGnimgUZc+zLoeAsFkAvoqlZGI7UgBmoc+yBABcIXW2PgU5a4aX82exps3XYZU7ZWZgAc3
	AKS2o5pVtuZXAAUQ5mD71FiHZtJQ2WU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-XootJTIRMc6WF71fiUVkDQ-1; Mon, 29 Dec 2025 02:16:43 -0500
X-MC-Unique: XootJTIRMc6WF71fiUVkDQ-1
X-Mimecast-MFC-AGG-ID: XootJTIRMc6WF71fiUVkDQ_1766992602
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c48a76e75so20067127a91.1
        for <virtualization@lists.linux.dev>; Sun, 28 Dec 2025 23:16:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766992602; x=1767597402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vQrOk1Jj8f6z61HqfLzQc4Y9ZdE0PdAOAqjoNpizJQY=;
        b=OjZEM4L/CY+DRl4RhxMD/+XDM0sQGxR3Anp/4IA0nZp7fHgvwczmNy8qFravbPP2UA
         NXgNIQXCOPKeVP06Uan3+QShPh3Ew8LTRM9VWjH9hlok5gwJ/7Q6UBz9VZI9I+H8M+yG
         uJ8NLkLKXSsoDHs6Y/N5CWTic/7Ag5JE9wZAVcq1Muzpo6CEvqfcGOyUDtD8YKUvdCfx
         6sDO5yb8jYSaEEhAdJWpAqPe5OiuP6P4S94dGeQ2vRgxWLTdS4p1dynKH1KXStIfDc9/
         RmVd8K/Cv7u70ZmCYtwQaovdqXYhd3J9+RzGFY0DcRSlldAe4vCiocfC5ONjXb12Okt9
         Kewg==
X-Forwarded-Encrypted: i=1; AJvYcCWicOQyU3LstFZ02pHAuK+CJcVAxXldjZQSaFwSWQGX/XKXlu6BT3C/HPVnOZUQAaFwSPDfG5xsTMkP9Z5e3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKQh7HEHss6BEvDJJOw2eea/yBcpjDh/dcJ6nBqONPBs/sn/8y
	Uwr1chiZrwNuExLwH1K1+/EY7kBh6mocBJS1rV9X5t1B2UHoBhCdbhQ0J/1WHf+bDH1yHOvicqt
	8dXB6b/YFGICnwV3h9UCGWG54ASe7N6yYAXtmGyR/4CYUijIEG20kLsvolnRH30sRyJu0RxtFHh
	iei/vbgLdTFL+P3VsYhJbbgM7XtXEwc09XJQnj+gYEr60=
X-Gm-Gg: AY/fxX4m+lmWHIdp7j17epVPEpW+cYZbpyH75Ms9ImoajSTg0qTEpR8Z6MJaa4jOEZm
	IPIz6YHZclDEu0AlqcT31NuB70RUADUTo9DlvifnVaZ3EMZfxJ/HRghrUYDXbKN/QLTVTuSALtX
	g+BAvz81AJM4l1Lx5UBIezehiByn0fqwpI4PpJO7DgmfR4XD1B3rmtJEb05pxuuYmLJgw=
X-Received: by 2002:a17:90b:4c06:b0:34c:c50e:9b80 with SMTP id 98e67ed59e1d1-34e921bba16mr28500169a91.27.1766992602080;
        Sun, 28 Dec 2025 23:16:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVj8YRRP0j6Dco0iuzp+od4xrHYUEr+X07ummQf+tQ8QJW9qN+dfFMDptTqbJVc23dU1rkpsOBDag0ZtgZd2Y=
X-Received: by 2002:a17:90b:4c06:b0:34c:c50e:9b80 with SMTP id
 98e67ed59e1d1-34e921bba16mr28500148a91.27.1766992601620; Sun, 28 Dec 2025
 23:16:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251225042608.32350-1-jasowang@redhat.com> <20251225042608.32350-14-jasowang@redhat.com>
 <20251226143433-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251226143433-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Dec 2025 15:16:30 +0800
X-Gm-Features: AQt7F2q6CZrHbVDF7YepR3vhIaF4JXkfh7MG2R1hxLH5bCMt9o6hNLrc6t0GWEg
Message-ID: <CACGkMEvM7mxtezJEqg8f==mLqoy9ZbVPb=vwQ6Ydvrtje-rjSQ@mail.gmail.com>
Subject: Re: [PATCH V11 13/19] virtio_ring: introduce virtqueue ops
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VkfgIWkCzv9QPuy3Xew2OP_YcVNGE6978SJ0eYuz-ZM_1766992602
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 3:37=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Dec 25, 2025 at 12:26:02PM +0800, Jason Wang wrote:
> > This patch introduces virtqueue ops which is a set of callbacks
> > that will be called for different queue layout or features. This would
> > help to avoid branches for split/packed and will ease the future
> > implementation like in order.
> >
> > Note that in order to eliminate the indirect calls this patch uses
> > global array of const ops to allow compiler to avoid indirect
> > branches.
> >
> > Tested with CONFIG_MITIGATION_RETPOLINE, no performance differences
> > were noticed.
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 173 ++++++++++++++++++++++++++---------
> >  1 file changed, 130 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index f804c5c6975a..4e905dc7b6cb 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -67,6 +67,12 @@
> >  #define LAST_ADD_TIME_INVALID(vq)
> >  #endif
> >
> > +enum vq_layout {
> > +     SPLIT =3D 0,
> > +     PACKED,
> > +     VQ_TYPE_MAX,
> > +};
> > +
>
> VQ_LAYOUT_SPLIT and VQ_LAYOUT_PACKED would be better.
>
> and VQ_LAYOUT_MAX for consistency.
>
>

Fixed.

Thanks

