Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B207148318
	for <virtualization@lists.linux.dev>; Tue, 24 Sep 2024 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163558; cv=none; b=M0kb+Thbcfcd4PKie3gBLZJF4rIZnaXzsmQeeTfTsngW3DuSo7jwOH8oizJWcu3qMmkigorsn79RQd2Mm5H++xbBCV7xprOK8mcE60CZSxhcYQBpCq9/j40D2Q44hQXwnEVsuwJu6r28DRlZNe26tS18M24mv/fOhgPdVL7sjiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163558; c=relaxed/simple;
	bh=kz928wtItTS/T+OAyfeKGmn9uJKBIYs4Xp4zJMxCumE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IiOd5EHSycn5DNaK7uIiGtFog7d5NyGnZ3altTZGlOS5sidy65RomARA8g6nFfuEtJupy0qdUFW1+K5dlklPedAqYRT4MZdggeMsrYIGT4z0LBfoRJyx1Iypnna0PQd4NRdNJLyDkOsN4vBuhVHnmzv3ZauKbQeZZvlfbMEfTRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P3PdhiMC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3PdhiMC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727163556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W5tdTWacXHLXV2KKpTB060Zl1NAoyRVDT06D/VDPCyo=;
	b=P3PdhiMCVNPb6QD6/aKjeYllJHc4kAuAR2eXTRZHa/PRAyU33WXbZI5Irh2dVMFwh91zg7
	x4PjjWcJEHcfgFrL8/1YNxJzc2zhY4mNfudzBZHawndADkD60KcuAJIzB3eVH5qSeq01VX
	aM5vu8W0LAtsjgZ2U6fpAHgYpw0vbrU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-H5nc6AB9P4-yoLp8UnmpXg-1; Tue, 24 Sep 2024 03:39:14 -0400
X-MC-Unique: H5nc6AB9P4-yoLp8UnmpXg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d8e7e427d5so4807503a91.0
        for <virtualization@lists.linux.dev>; Tue, 24 Sep 2024 00:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163552; x=1727768352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5tdTWacXHLXV2KKpTB060Zl1NAoyRVDT06D/VDPCyo=;
        b=KbO/MqguE8pxKC+9P1RRCdakKl9aeIvUsog4nuBZ4MrVzfIvR8kj9swaSUnGEMKmbQ
         Aqox6FyM0qmcjTP2qe1ovoev1j4LH38vQaJIGlRj6U6/9o5ZJfzg4vULkbPJCpqKq0Kw
         dgCVeEVhibKxOGVKo06Fugr+vsdYlr/ThYSu0p3Qjq1ug4/akEb7ac28mHRcpepbMYgF
         au9MIMnU25ySnu+eaZ2Q/cp2VmFf6/oNZalU1qaZZg8UHH5Plji9cJdfi9p9JWkKXKK8
         QEhIlRA9WWLZ7Zn8L1rOS5bDcNSYYzUsclRWNDIJ112IEaLIGTkU6oZkuT8yXIV1m7jX
         fhfA==
X-Forwarded-Encrypted: i=1; AJvYcCUzKlPnOwnbVAeEMvE0AoqDVoWw+IL+8sEzMGAMwUNjU+1aXHsXnqqdY9Yy2pgFgNKVKE1X4s7SMGT6OfpVkA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxrh8AcYUF3g9iFvkati12fTrSCNyl6vzrzJwLVt4Nfz3v82AuH
	BQNELj1NZh+KutTvxi219v+JpXFJrbomt06H1LzxNS9dkwCbaNgpAkL3be7bfacFKR0K2zxa83u
	T94wdr0O9SSU+QVrY5tW3TPiPUmz8kikZMYcsUjHY+5Q+cJDWG+g4sG1kFutwic17SGpW7eRsJv
	D1K4K08a5KCaj5HTwA3twh6quTGJOmj/63x9YIS7MUJ9thGqlK8Q==
X-Received: by 2002:a17:90a:6b42:b0:2d8:adfc:b3d3 with SMTP id 98e67ed59e1d1-2e05660a905mr3720149a91.0.1727163552528;
        Tue, 24 Sep 2024 00:39:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHusiLeMX22XkLQBmPcNwHXnUOIk0do8BzlzANeO896VqFMVCVa9ccxF5oCn94NELDMSfDyZc+kwr42I2BvXpA=
X-Received: by 2002:a17:90a:6b42:b0:2d8:adfc:b3d3 with SMTP id
 98e67ed59e1d1-2e05660a905mr3720128a91.0.1727163552071; Tue, 24 Sep 2024
 00:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240922123435.17946-1-quic_jianguos@quicinc.com>
In-Reply-To: <20240922123435.17946-1-quic_jianguos@quicinc.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Sep 2024 15:38:59 +0800
Message-ID: <CACGkMEv1ndVVwVrD1J_ghHpyZB0=3sLdSrXxchZ2QoQzMJihdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Virtio: Add CONFIG_VIRTIO_MMIO_POLL_RESET
To: Jianguo Sun <quic_jianguos@quicinc.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, Anant Goel <quic_anantg@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 8:35=E2=80=AFPM Jianguo Sun <quic_jianguos@quicinc.=
com> wrote:
>
> Add CONFIG_VIRTIO_MMIO_POLL_RESET to as an option to enable
> synchronous reset for the MMIO based transport for virtio.
>
> Change-Id: Ifa7e29b4c0cfa26922535f921c6ab69eacdc4cfc
> Signed-off-by: Jianguo Sun <quic_jianguos@quicinc.com>
> Signed-off-by: Anant Goel <quic_anantg@quicinc.com>

Any reason this is not a feature but a config option?

> ---
>  drivers/virtio/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 42a48ac763ee..fb17b1078d53 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -188,4 +188,12 @@ config VIRTIO_DEBUG
>
>           If unsure, say N.
>
> +config VIRTIO_MMIO_POLL_RESET
> +       bool "Virti-mmio device synchronous reset support"
> +       depends on VIRTIO_MMIO
> +       help
> +         Say y here to enable synchronous reset for the MMIO transport b=
ased
> +         virtio device. After writing 0 to device_status, the driver mus=
t
> +         wait for a read of device_status to return 0 before reinitializ=
ing
> +         the device.
>  endif # VIRTIO_MENU
> --
> 2.17.1
>

Thanks

