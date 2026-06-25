Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85442C15AC
	for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782419072; cv=none; b=tU74R/Wbc0PxndtsxRTBcsxuEBE6Nbw/nJu9Kdgz+GUb9DhRkxWiCl/bj5jaExsKB+f9L/EZ7bayKie8OcJPjkRkuLSX5yJdnGEWA+t1tww8c5hSDgKZV5szwKBFEzqlSEqHoR4biXyktQ7olROfhFtSL4H+YmUJBR7amV2iyRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782419072; c=relaxed/simple;
	bh=5Gu1djFx39qL2WPBl6XhzgHlaItkNMyPxsKAOu99RMA=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=BiuZ4k0SPds8TvluZ4dsJfRIMjYscj97CsrbnYYSWRyPxe7RmAptM8n2QO0mc8Zj5jkSn//AasDNYOjWBL4BdmlLA1Sm2Qd5P5clQ1B9g+72rKJvqXD484aInj7s0v/uQLYAw5MlM4hXgRJSx9+iouXlIpi+YHPsHSbFvjSF7vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OLjiWCkH; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OLjiWCkH"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-8068416764bso6006247b3.2
        for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 13:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782419070; x=1783023870; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZaSx917b9Ih36+MYmm85gG9khksXUi5kk9ml14nZ7SI=;
        b=OLjiWCkHy+ipEL1L9EyiXijdFqE7hQxIpZzUxJJPSulSSNMYz3tKq4OlTWfwIqRUye
         EB9Q7nrp3EZjGD0UbKJLDvCJ/ote1NAS0WdIbGU4wZ4aCA/cunhYlRLdyyO4qNR8rluL
         jN861ydE0vz6Zeuex8KQ6BqkXFFzjJRp5HHBMuJW2IKgfc2ZwpOwbdG6uV7C82YY/G7s
         LkAypxfbLbxsolPP6sSfvvShz1ioS1RqUCnfH+YqlA9AQq86uxKu7e9RqAJvmDQkL9Yz
         PcoMPJqZKKRWxZoiuTPNeOKT53AexmPPsKRfNeDrZFUeQgrhFcHz84klOu+8XSRBzD2s
         38og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782419070; x=1783023870;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZaSx917b9Ih36+MYmm85gG9khksXUi5kk9ml14nZ7SI=;
        b=og93vg9y5YcKlN2/B/8FlLzm6MQ3Hlass7rMkaKHt2y7K493iz9W25alEFegpzQEp2
         fA0brn8V99c3RiLR0lSWG7l4rL4yWJxk5Zq2UNmaeZR8+uTvyOkqTJ+qL6CV0pQK0ZcT
         aSZWUsXjvWBM27atTXBBn/rr/jPZh84uvZ+XmpeOWFWXwHRJaQFUQSYWnMnz0KtCeooG
         us8nHBkJBS1PdCubNK0M2due3inlc40HMenhgCvQqHNehAe4RwEkSe0HY/IUQivF47fq
         AwzJu4dCOWKiGADbVvcVaByGgy55kSKvd77QWqduyrovp6luyIiaOtT6mcfYipfjfEHE
         4Shw==
X-Forwarded-Encrypted: i=1; AHgh+Rpd7Rbt4BbHp06G2AqLV8rZ4vrvmQW5nRlTOBlZRgAmeIRL8JZq8xPx1LTHid5XgAjpNi5LD4m1vDLTuFq2Dg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDRC8OkejdDoLzMDouSrPGmpRACgwHrOQTNyx0l4YFWOPbGw7A
	pDaszgyc26LjNRCivaD5j6N5S4AHZlWDV40+h2keriwCfc+3OHt+ZjLgEgK2iYaq9OyweveUttd
	eON43SJHOfwWIJl0gGbMqieMFB01e
X-Received: from ywao9.prod.google.com ([2002:a05:690c:e6e9:b0:80a:9749:d2dd])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:d8e:b0:7e8:6d46:a15e with SMTP id 00721157ae682-80a6af82548mr42549557b3.20.1782419069721;
 Thu, 25 Jun 2026 13:24:29 -0700 (PDT)
Date: Thu, 25 Jun 2026 16:24:03 -0400
In-Reply-To: <4b2078a0-9422-467b-b167-9a0b5444f18d@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625202412.2986772-1-briandaniels@google.com>
Subject: Re: [PATCH v4 1/8] media: virtio: Add protocol
From: Brian Daniels <briandaniels@google.com>
To: "Bryan O'Donoghue" <bod@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Brian Daniels <briandaniels@google.com>, acourbot@google.com, adelva@google.com, 
	aesteve@redhat.com, changyeon@google.com, daniel.almeida@collabora.com, 
	eperezma@redhat.com, gnurou@gmail.com, gurchetansingh@google.com, 
	hverkuil@xs4all.nl, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mst@redhat.com, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > +	u32 __reserved;
>=20
> Knowing ~ nothing about virtio with ~ no experience of it I'll offer up=
=20
> a question/statement anyway.
>=20
> Aren't your reservations here a bit conservative ? Would you not be well=
=20
> advised to reserve a bit more space per other virtio protocols ?
>=20
> =E2=9E=9C   grep reserved ./include/uapi/linux/*.h | grep virtio
> ./include/uapi/linux/virtio_balloon.h: *         __u8 reserved[6];
> ./include/uapi/linux/virtio_balloon.h: * In other words, add explicit=20
> reserved fields to align field and
> ./include/uapi/linux/virtio_blk.h:      __u8 reserved[38];
> ./include/uapi/linux/virtio_blk.h:      __u8 reserved[56];
> ./include/uapi/linux/virtio_config.h: * VIRTIO_TRANSPORT_F_END are=20
> reserved for the transport
> ./include/uapi/linux/virtio_crypto.h:   __le32 reserved;
> ./include/uapi/linux/virtio_i2c.h: * Copyright (c) 2021 Intel=20
> Corporation. All rights reserved.
> ./include/uapi/linux/virtio_input.h:    __u8    reserved[5];
> ./include/uapi/linux/virtio_iommu.h:    __u8=20
>         reserved[3];
> ./include/uapi/linux/virtio_iommu.h:    __u8=20
>         reserved[3];
> ./include/uapi/linux/virtio_iommu.h:    __u8=20
>         reserved[3];
> ./include/uapi/linux/virtio_iommu.h:    __u8=20
>         reserved[4];
> ./include/uapi/linux/virtio_iommu.h:    __u8=20
>         reserved[8];
> ./include/uapi/linux/virtio_iommu.h:    __u8=20
>         reserved[4];
> ./include/uapi/linux/virtio_iommu.h:    __u8=20
>         reserved[3];
> ./include/uapi/linux/virtio_iommu.h:    __u8=20
>         reserved[64];
> ./include/uapi/linux/virtio_iommu.h:    __u8=20
>         reserved[3];
> ./include/uapi/linux/virtio_iommu.h:    __u8=20
>         reserved2[4];
> ./include/uapi/linux/virtio_net.h:      __le16 reserved[4];
> ./include/uapi/linux/virtio_net.h:      __le16 reserved;
> ./include/uapi/linux/virtio_net.h:              __le16 reserved[3];
> ./include/uapi/linux/virtio_net.h:      __u8 reserved;
> ./include/uapi/linux/virtio_net.h:      __le16 reserved1;
> ./include/uapi/linux/virtio_pcidev.h: * @VIRTIO_PCIDEV_OP_RESERVED:=20
> reserved to catch errors
> ./include/uapi/linux/virtio_pcidev.h: * @reserved: reserved
> ./include/uapi/linux/virtio_pcidev.h:   __u16 reserved;
> ./include/uapi/linux/virtio_pci.h:      * 2-65535 - reserved
> ./include/uapi/linux/virtio_pci.h:      /* Unused, reserved for future=20
> extensions. */
> ./include/uapi/linux/virtio_pci.h:      __u8 reserved1[12];
> ./include/uapi/linux/virtio_pci.h:      /* Unused, reserved for future=20
> extensions. */
> ./include/uapi/linux/virtio_pci.h:      __u8 reserved2[4];
> ./include/uapi/linux/virtio_pci.h:      __u8 reserved[7];
> ./include/uapi/linux/virtio_pci.h:      __u8 reserved[6];
> ./include/uapi/linux/virtio_pci.h:      __u8 reserved[6];
> ./include/uapi/linux/virtio_pci.h:      __u8 reserved[2];
> ./include/uapi/linux/virtio_pci.h:      __u8 reserved[7];
> ./include/uapi/linux/virtio_pci.h:      __u8 reserved[7];
> ./include/uapi/linux/virtio_pci.h:      __u8 reserved;
> ./include/uapi/linux/virtio_pci.h:                      __le32 reserved;
> ./include/uapi/linux/virtio_pci.h:                      __u8 reserved[6];
> ./include/uapi/linux/virtio_pci.h:                      __le32 reserved;
> ./include/uapi/linux/virtio_pci.h:                      __le32 reserved;
> ./include/uapi/linux/virtio_pci.h:                      __le32 reserved;
> ./include/uapi/linux/virtio_pci.h:      __u8 reserved[7];
> ./include/uapi/linux/virtio_rtc.h: * Copyright (c) 2024 Qualcomm=20
> Innovation Center, Inc. All rights reserved.
> ./include/uapi/linux/virtio_rtc.h:      __u8 reserved[6];
> ./include/uapi/linux/virtio_rtc.h:      __u8 reserved[7];
> ./include/uapi/linux/virtio_rtc.h:      __u8 reserved[6];
> ./include/uapi/linux/virtio_rtc.h:      __u8 reserved[6];
> ./include/uapi/linux/virtio_rtc.h:      __u8 reserved[5];
> ./include/uapi/linux/virtio_rtc.h:      __u8 reserved[6];
> ./include/uapi/linux/virtio_rtc.h:      __u8 reserved[6];
> ./include/uapi/linux/virtio_rtc.h:      __u8 reserved[5];
> ./include/uapi/linux/virtio_rtc.h:      __u8 reserved[5];
> ./include/uapi/linux/virtio_rtc.h:      __u8 reserved[7];
> ./include/uapi/linux/virtio_rtc.h:      __u8 reserved[6];
> ./include/uapi/linux/virtio_rtc.h:      __u8 reserved[7];
> ./include/uapi/linux/virtio_rtc.h:      __u8 reserved[5];
> ./include/uapi/linux/virtio_rtc.h:      __u8 reserved[5];
> ./include/uapi/linux/virtio_rtc.h:      __u8 reserved[6];
> ./include/uapi/linux/virtio_spi.h: * Copyright (C) 2025 Qualcomm=20
> Innovation Center, Inc. All rights reserved.
> ./include/uapi/linux/virtio_spi.h: *   other bits are reserved as 0,=20
> 1-bit transfer is always supported.
> ./include/uapi/linux/virtio_spi.h: *   other bits are reserved as 0,=20
> 1-bit transfer is always supported.
> ./include/uapi/linux/virtio_spi.h: * @reserved: for future use.
> ./include/uapi/linux/virtio_spi.h:      __u8 reserved[3];+      u32=20
> __reserved;

I'm not an expert here, but taking a look at those files, the vast majority=
 of
those reserved fields appear to be padding to ensure the struct has 64-bit
alignment, which matches the use here in virtio-media as well.

virtio_pci appears to be the only device that explicitly states the
reserved bytes are for future extensions. Unless there's a good a reason to
expect a future use case where more space is needed, I would prefer to not =
add
more at this time.
