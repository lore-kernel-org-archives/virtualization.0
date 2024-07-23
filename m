Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9FB13C832
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 06:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714516; cv=none; b=TtDj9eiloiuT5pYj5wWQb5zoUy0islUFJHSNtKxAbP9Yf4rWX2N3SvH3YaGlgS3zOcMADAWHDnHWeVWXlvxb9H7y2fHo0ts5rrLnkzXCYwoO9UavlADvlgoEDk5h6J5Cd/SrgcC8Mj/nXzkJw4R1sa4IZP55Tt2hnKVUj3eLkKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714516; c=relaxed/simple;
	bh=9xwqJwDsGR3pFv2mlR4oUH8gkzfpSSnRrp+hDPttC1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snx4KrF8DMA9y/42nLtvMpyNT8tZRnBIO43W8IMd/jjpDmiKBuZIFvi0yX1hCV8lSaFWIhW06mj1nR8eJmrAWLnkvBh21TkFZeqG6Ti9/Lp6SCWym4BNi3XeExgT/goOVPakv8VNDs/NzS6tl/wZKXLtr2umKQFpeYevlaEKCdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0qtiKHT; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0qtiKHT"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0090660684
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 06:01:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1l2ipcb__8qh for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Jul 2024 06:01:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3C7DD60669
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C7DD60669
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N0qtiKHT
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3C7DD60669
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 06:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721714513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xwqJwDsGR3pFv2mlR4oUH8gkzfpSSnRrp+hDPttC1M=;
	b=N0qtiKHTBNOTjhVji/dVGgH2jevC7nnRmT/yvvYy+nNrEQgFbChZfkv3RjKH7+s2MEUThD
	Wn4SdzycGeGikrdwT2oEimLsKvzqGNXX3mGCePeiYd6Nz5ebs+oCjEJjs2OdW9TAWe1LvH
	43lMORVLeLGf7b8nKrARYvlQDziEyz8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-2ygZziUHPLOdNO2WbRMd7Q-1; Tue, 23 Jul 2024 02:01:49 -0400
X-MC-Unique: 2ygZziUHPLOdNO2WbRMd7Q-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cb4c2276b9so4492562a91.0
        for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 23:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714508; x=1722319308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xwqJwDsGR3pFv2mlR4oUH8gkzfpSSnRrp+hDPttC1M=;
        b=jJOeG41rlxVsjhe0idgfp271eNcOan60qEE/l2SNvMA4g0fcx97AFT3y8hak/nqUgS
         H9+hYIl6c/q6w7PBWLhiiomAXAEyPOMSB11cuogGmCMT3sz+vRgF4PGRrIi2E05JVnVu
         T669z4uQ9ewH+UZChiAmNtRd3s+8xzo+aUodyPZDCPPXJq80p70Fl6CCo5K8iQ0cbvb9
         oEa9+S+EDLsiY3sDzCvn/QDqnLfEVDc6SuK7h5P6HDTg8fW0jDhAwYjXNJS2MzLY/kKH
         jyV1VnCxLLumxrvH8T5ByErDwyGYc8mgBggufAYqDx/4nd8xe0mAX/8pK4V/lYLuBcjI
         T/EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOKERpZ8xz5FcIX06FVIDflZrz3Bgyfro2Chr5+0z3kb9EhjVX+G0hEb9y6JHCkgWK3xKLRPCyknwxTf0/FooXNj21+KebovMXvIZA9+nlN4+nvGtiIm80mA==
X-Gm-Message-State: AOJu0Yzh+t+WH+7u3dz9VcthliLqLcBKHRUYBi5j0+SjjLX7qGuuHNNs
	GgcAL6Sje10a756bO13xgIkkF95ICQysmng2GBo5jsNYHaOSx2ilh064rlUa0CAydZwrFBxIoXF
	DwAB/h8aXG8NQHN1QNt4xRm5EiOQMUvubxZjQGVEjsZKdUftpUWjf12uFc8G3SdCHljLPm+sR5J
	wwxoav2kuJgJR9hlE/hZ2vI5Y0zgfhjVnvU0d9ZDhCKiW9YYTJb4ELxA==
X-Received: by 2002:a17:90b:1e4d:b0:2c8:7897:eb46 with SMTP id 98e67ed59e1d1-2cd274d48c6mr5248610a91.37.1721714508220;
        Mon, 22 Jul 2024 23:01:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoEpwALYUFixu5BsTTbuOhYXcOpaanMm+heueYUhW44DeZ/5YttPO4b63Hy50iMiec8ZUd1PMvKMmbsaX93RM=
X-Received: by 2002:a17:90b:1e4d:b0:2c8:7897:eb46 with SMTP id
 98e67ed59e1d1-2cd274d48c6mr5248585a91.37.1721714507652; Mon, 22 Jul 2024
 23:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240723054047.1059994-1-lulu@redhat.com> <20240723054047.1059994-3-lulu@redhat.com>
In-Reply-To: <20240723054047.1059994-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Jul 2024 14:01:34 +0800
Message-ID: <CACGkMEv5-Hn+LNKNT9ObCaT8xBv_BKrhoJjBA9RShGgh3Hwq3g@mail.gmail.com>
Subject: Re: [PATH v5 2/3] vdpa_sim_net: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 1:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa_sim_net, the driver will write the MAC address
> to the config space, and other devices can implement
> their own functions to support this.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

