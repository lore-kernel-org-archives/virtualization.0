Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48CC6F06D
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 02:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280309; cv=none; b=mR9Zurvos11gKpspE3iX3XakG4wxVmB5Roc5gYQoSMgN5cr5HS1G6TOMeV+M0gaBU9QMdqJILUDQrDfnG3rjJt2/ZIFhPji9Q4u0+BjNLf0mbMptmZvnGlw5UOEBw04CMK7dVLhWVEef5zhhZV+/617GeocxQh/ubiqupNE1sWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280309; c=relaxed/simple;
	bh=XbnQOq3MesemtOcTeCYxeKP2DW43Br9wh3sOMpJ7Mmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJanI4t3F8xlbisj33M0y+7daoFBHEkBIBx9ES9FpGJYNszVA2Dz3dhHnibRfRu2WqyKJXymJd96zLLpdRnrr8orMyMSdYnqpG3B5NG63fEw7XwhBhZUIIY2R4bd4cpJJG3jIcqX7o5dfiXhRsjVe0uClx9xqMMlgLJoUJC5GuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bd853IoJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bd853IoJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733280306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbnQOq3MesemtOcTeCYxeKP2DW43Br9wh3sOMpJ7Mmo=;
	b=bd853IoJ9M59Vi9SDpGb7XLU+BKP1IUEcsm4ilm7ZGWRgzZXcoIeouF+dii64J+ZGWpn4/
	Ke+0XLv+nH3u/cWMdIEh5WnkzpXnTPjC/5IpE0rVZfQ0FwIHG8e2aFGaaiTOgRZSrItOnQ
	PCSDVY8pR4pWFWrWenB2dF9DOV5s1hA=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-a8glt5-jP12GYgyLtUliLQ-1; Tue, 03 Dec 2024 21:45:03 -0500
X-MC-Unique: a8glt5-jP12GYgyLtUliLQ-1
X-Mimecast-MFC-AGG-ID: a8glt5-jP12GYgyLtUliLQ
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-85b8847b024so841856241.2
        for <virtualization@lists.linux.dev>; Tue, 03 Dec 2024 18:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733280303; x=1733885103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbnQOq3MesemtOcTeCYxeKP2DW43Br9wh3sOMpJ7Mmo=;
        b=UtrK/lVEQnDaJtuadmY/dtfEO3jRkBCOAyLtLGOv+eF5NyNfcYEN0TLXiKSInlhhVK
         bjdaaOW+aiG9oFlvVjVJz61RT8UDyLh2dV8SBeXyNYGZdll9dQcRilEk4I5xlff26TzE
         q1IcKT1HZsVH0wpmkH0rQmYILfY8EBbBrdHJESeQl98SE0RhfFgu+HjYUrvzEMLbnizl
         CJo/nTNkoopWbGn+1Didijwr+MtNqzr1o9CkCfydwpdv+sujNvvq6ExohuySbAD/DNCY
         KJfNi5BQg5yGIEMzOx/6b1JrTE+LoT823r7j7gYmVyDde7EaQpIj5KQ2HYVofhcyN/tM
         sO2g==
X-Gm-Message-State: AOJu0Yx+jXUC5rVG2QiO8jexJznaKLqhaqMry6Se6fLK9n3ueKywoZpH
	lw/MZifLTN1D2AjVwGiOvmmX3DbUDW6TWKhOoy1BQDNZOwO91I9tRRzK54YYtsN+6S9oS0UXbEg
	MWsHx+DNBX3/fqEEg/oeH9Ne7Fo/dvJvB6jpFYaHd9YvVvzUx0XznUVlu1g0UOz6Nay32qopcIJ
	WRspvmydOrrvqFtb8RUQne9C2LoUW9UdOqXzFGuVE=
X-Gm-Gg: ASbGncstgUW2mZ2I6rY9CZaaywnhiT/3PPiou5v/5tRxM5prtGj6IkfjlPSx71cN+kZ
	cOpCKshB4xDpcLu5U9R8bGxQW+ChQP7g2
X-Received: by 2002:a05:6102:5489:b0:4af:aaa4:dd9a with SMTP id ada2fe7eead31-4afaaa51842mr2184609137.10.1733280303451;
        Tue, 03 Dec 2024 18:45:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnv582pmJNRSCddpQRIMLUIrhRF1VM316y4CUO+jOhzMa7TrksbE6s7FhVZ/bBvYjjr0SiWjodQSlPoQUf1dM=
X-Received: by 2002:a05:6102:5489:b0:4af:aaa4:dd9a with SMTP id
 ada2fe7eead31-4afaaa51842mr2184605137.10.1733280303130; Tue, 03 Dec 2024
 18:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241203073025.67065-1-koichiro.den@canonical.com> <20241203073025.67065-3-koichiro.den@canonical.com>
In-Reply-To: <20241203073025.67065-3-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Dec 2024 10:44:50 +0800
Message-ID: <CACGkMEu=zjbnyLGLESsSUx_J_KkcKHYo2dBDuQ_evvkOuJ=bEw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/5] virtio_ring: add 'flushed' as an argument
 to virtqueue_resize()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vYvDaFg8z3IgxiVJ6isauHqF2MbIVCs59Rbx6LqxIiQ_1733280303
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 3:31=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> When virtqueue_resize() has actually recycled all unused buffers,
> additional work may be required in some cases. Relying solely on its
> return status is fragile, so introduce a new argument 'flushed' to
> explicitly indicate whether it has really occurred.
>
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

