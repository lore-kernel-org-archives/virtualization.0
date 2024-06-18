Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0B819CCF1
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 03:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679704; cv=none; b=fWy9xKcM+LW9vukN/71VkFGEuOpGH90DD/OhJ+mbCVBUxGqGEcPy2g9e+55gSqOhGvTbtVtzsWWPvEQ6i3eghy/YhHYblX3s1sWITlgV1TnY+R23IuADPvQVqtAhMnAnU22Q9p12Rq3BbYmMQ+F+JZEi3y8ui/qnfXEgnj0mHcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679704; c=relaxed/simple;
	bh=nu4pca2mi6dQrvgDKgyW+yuVYeHR3Cy1A2xzxgA6xT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgeMUVv+1W/+EeFZOgAKHNJkfYeuBTJwXDJHBM8POLBTQ7CkuHB91iSqJBeJ/d7IpBEFs+680KMrc1jHbs8hTerxZ23yoNMHQTo1Ws37Bicu29KtikqLUt32qo9TTRYwfXTUvKmdNwXNGJ+Nnl0xCoZ0JqSomQwkBbiNHaQ1R38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I23exiRU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I23exiRU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718679701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGO8xJv2KXgMjNv3VApDR/tvDfjbFvWmFZHb4b/swhY=;
	b=I23exiRUElPAcgpS+joY2T9GNiHD/UdrTyP5yrjqroNY83kAh6I1eXIYx8yOQa7YTcb4Do
	pPOJ4G0OxYHENtGf3gibEPnAnfYKehzKrMKFAAV+k+t3EGVnOe1Nhx59tfKlS1Lkk/aqAh
	/cHvlWCdHacLccVBh+XC3q6+JpvcvrU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-DyHsvFkHNuyfr1f_V5jmGg-1; Mon, 17 Jun 2024 23:01:40 -0400
X-MC-Unique: DyHsvFkHNuyfr1f_V5jmGg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c2d6e09e62so5227820a91.2
        for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 20:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718679699; x=1719284499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGO8xJv2KXgMjNv3VApDR/tvDfjbFvWmFZHb4b/swhY=;
        b=SH4ojglsjD5O1UJxnPfKrOTrrn0FHCcfEBFh5pKR6vH1ZLpZUCAYTVoVXxPp27Q6L/
         lT12FiuitbgXBQvSS7rGoVhZ0zH07vrGwoXf3HKp1i4dCTexbu85JANOK3vBrt+WojFI
         MCMdHj9mJe8n5u+7GtW7sy5q14Fcuw1tZs1PcsRWhTSyrzusJwobF0rfyfRFWL3xYWlA
         OkIqmiwu3gqzI13bCUofg/RGTxMlThUGeiuwqHy5+N+aACButEi5otmbRXiRo/3Fb9Ol
         6bCtXq9wZn9eJ1Xf8e/bxS4TEiLvSAvZKRiak67xf4RKQHDmdzLmnQ1uRxDlgPTFHyDZ
         RNbg==
X-Forwarded-Encrypted: i=1; AJvYcCWgIn2SrhTmSg0/6ptZ990FWez8x0JZ99TJ6DRY0C72oQ1iHNhEnFBrYExaZBktydOsSudjLgxAZVHGCg8GLYNSJyVGGTZzCxGAZCKuWBw=
X-Gm-Message-State: AOJu0YxTBCWwP7ABGF8QWqdDjh1yr/xPB+OmNWiDYk/bcaUAiMAzQC4J
	pIuE+S+jsvWjtWQ0Cojow6SgTkwvB5RyHQtHcUpACyaJfdHVFzhaQkvResheSgBguQRLEpwlwZn
	zbtdAya4nedM/Cmv5aLlIrjDokKxX/I0/eEw16SQaL9J1Efol314YWteLlhSNkx+mn7uG3/YvEH
	yD8VFxBfjcIRz+h24JSIYG0QlRLgAN7No49ZrW2AQ=
X-Received: by 2002:a17:90b:4f4b:b0:2c1:aa8e:d70 with SMTP id 98e67ed59e1d1-2c4da9c8de9mr11714892a91.0.1718679698938;
        Mon, 17 Jun 2024 20:01:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZBrfswUVDW/XgtKdE78Hbo2pv4VMfsIIEd1NV+lkFxY0mc3r22zWjQXrs9N3V9yGvI6LQ5+NPtf2aGgXqQlY=
X-Received: by 2002:a17:90b:4f4b:b0:2c1:aa8e:d70 with SMTP id
 98e67ed59e1d1-2c4da9c8de9mr11714876a91.0.1718679698612; Mon, 17 Jun 2024
 20:01:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240617131524.63662-1-hengqi@linux.alibaba.com> <20240617131524.63662-2-hengqi@linux.alibaba.com>
In-Reply-To: <20240617131524.63662-2-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Jun 2024 11:01:27 +0800
Message-ID: <CACGkMEvDUcVmaT1dBoWnFx0CO5kH+HYp9je5bJ1dFR1+EEdyWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio_net: checksum offloading handling fix
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	Thomas Huth <thuth@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 9:15=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> In virtio spec 0.95, VIRTIO_NET_F_GUEST_CSUM was designed to handle
> partially checksummed packets, and the validation of fully checksummed
> packets by the device is independent of VIRTIO_NET_F_GUEST_CSUM
> negotiation. However, the specification erroneously stated:
>
>   "If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device MUST set flag=
s
>    to zero and SHOULD supply a fully checksummed packet to the driver."
>
> This statement is inaccurate because even without VIRTIO_NET_F_GUEST_CSUM
> negotiation, the device can still set the VIRTIO_NET_HDR_F_DATA_VALID fla=
g.
> Essentially, the device can facilitate the validation of these packets'
> checksums - a process known as RX checksum offloading - removing the need
> for the driver to do so.
>
> This scenario is currently not implemented in the driver and requires
> correction. The necessary specification correction[1] has been made and
> approved in the virtio TC vote.
> [1] https://lists.oasis-open.org/archives/virtio-comment/202401/msg00011.=
html
>
> Fixes: 4f49129be6fa ("virtio-net: Set RXCSUM feature if GUEST_CSUM is ava=
ilable")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

(Should we manually do checksum if RXCUSM is disabled?)

Thanks

