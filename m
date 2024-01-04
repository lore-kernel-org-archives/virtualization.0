Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B521FB3
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jan 2024 02:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N48utm4m"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 06451404AB
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jan 2024 02:36:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06451404AB
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N48utm4m
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZX5-7yN2lKsQ
	for <virtualization@lists.linux-foundation.org>;
	Thu,  4 Jan 2024 02:36:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DAFA44010C
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jan 2024 02:36:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DAFA44010C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704335764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rf/5T2evTdbJccKyC3hgdo+xqOBYB4xVojuOWjkZbrU=;
	b=N48utm4mPaWcMIIgvRTN1ag9q+7JPaxcmwOewiPjwFQXNR6IggOjce4s9TYs3VfiVVfpZQ
	KB7srlBlY4LhPaNh7q7mxFo2IX45eyeiGklkYQ5eSsuKiJUQbfnxX3Y7HUSUsPagOUFCFA
	Z1cLJZdQgTleXDGT+pxS7HsG+qSOLOs=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-1KZO_QOFM7qOPPeVTY8kwQ-1; Wed, 03 Jan 2024 21:36:03 -0500
X-MC-Unique: 1KZO_QOFM7qOPPeVTY8kwQ-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bbc40771a9so92715b6e.0
        for <virtualization@lists.linux-foundation.org>; Wed, 03 Jan 2024 18:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704335762; x=1704940562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rf/5T2evTdbJccKyC3hgdo+xqOBYB4xVojuOWjkZbrU=;
        b=m5RMq/6efibEl3Wluty6P5wDi+HXEhT+R51tzXYrf6aKGcsvRTtdiY7OcgqcipAHjr
         Hk0axFlQTdWITcTJFFjR4g9+ITUBIW6iZ+Sa5AFN8gRnnJmm85WdRuz43QnFPG233ay1
         5B3omypGN+Bg8P66LPwlqEECp6FWd3bfIBDHmD+DycwD6N3nOFW4QD4yNiWfpZ6jJ7hy
         Xo+l6bcX1QrXz0eC8Phc0/N0It4L1a0I/w7OBueH6hEktr/VDUsXwGjmoP+5BsCD6vsH
         3m0gpUmqNBZPQ1pvZyDhFXt6TSyLGLALuYbEweCtg3c8z0u7/JqgVor/8qNBpV+mmT79
         ApGA==
X-Gm-Message-State: AOJu0YyUKUJOmz0Dr0rOZSHQpOTt4TlTGyFV4IorkygiLUdWWzr3IGxv
	0+vdNc0eAjLp0OZltUYXdkbbqCjOS2vK0YENLBvJatdAtgQICZKRbdP2ayx7e8eAzuGjxY+arec
	X6MR3/7mbFjuL/xfGewGQDSSd3nv0rZy7DGierHllUuvsesson6cXYHjT5w2q626vqA==
X-Received: by 2002:a05:6808:140b:b0:3bc:24f7:d17b with SMTP id w11-20020a056808140b00b003bc24f7d17bmr18441oiv.32.1704335762479;
        Wed, 03 Jan 2024 18:36:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEsOm3tBKEdQghMXJb5vuIMFj3a5lz4AHsDr95eXR33C+UTugrKPoagZEv9Sy19ULon5rHPKAdPIkhXKAZSAw=
X-Received: by 2002:a05:6808:140b:b0:3bc:24f7:d17b with SMTP id
 w11-20020a056808140b00b003bc24f7d17bmr18433oiv.32.1704335762254; Wed, 03 Jan
 2024 18:36:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231226094333.47740-1-xuanzhuo@linux.alibaba.com>
 <20240103135803.24dddfe9@kernel.org> <20240103171814-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240103171814-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 4 Jan 2024 10:35:51 +0800
Message-ID: <CACGkMEsoi9rxd88a3mQa4J3QvnYsb_AzYyL4h5wvESdQ9ojQiA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_net: fix missing dma unmap for resize
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux-foundation.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 6:18=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Jan 03, 2024 at 01:58:03PM -0800, Jakub Kicinski wrote:
> > On Tue, 26 Dec 2023 17:43:33 +0800 Xuan Zhuo wrote:
> > > For rq, we have three cases getting buffers from virtio core:
> > >
> > > 1. virtqueue_get_buf{,_ctx}
> > > 2. virtqueue_detach_unused_buf
> > > 3. callback for virtqueue_resize
> > >
> > > But in commit 295525e29a5b("virtio_net: merge dma operations when
> > > filling mergeable buffers"), I missed the dma unmap for the #3 case.
> > >
> > > That will leak some memory, because I did not release the pages refer=
red
> > > by the unused buffers.
> > >
> > > If we do such script, we will make the system OOM.
> > >
> > >     while true
> > >     do
> > >             ethtool -G ens4 rx 128
> > >             ethtool -G ens4 rx 256
> > >             free -m
> > >     done
> > >
> > > Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling m=
ergeable buffers")
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >
> > Michael, Jason, looks good? Worth pushing it to v6.7?
>
> I'd say yes.
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>

