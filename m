Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C70C15B97D
	for <virtualization@lists.linux.dev>; Fri, 13 Dec 2024 03:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062164; cv=none; b=kEZsLOZFBgpp0G8/j5qG0a5OVv+/bh/MxM74vpzD19KTiaXzEJoNm+2L9+1PnautdtXNTAgpQEwuXnMdfHfezzdjVB0vkoDMstGsWprVzQErDuZPwqJzCSjE29UrSFeElpZg9A4qHMUPmkHCDppQsZhj77abUYDARZ0ruVephrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062164; c=relaxed/simple;
	bh=U4lhy29Z8mWIZhXRxJyY/aLJFxrOaq/vlhjoFQPjVqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxhRchqmNekhg6AGSomE7h/S8OIHMitV27S/HIMu60AHmx/5mKmfSFmkLixg1By2reEjw3rBKOBnmx1Ae0E7Cv6r0ZVLF2UWwBYR2HvzQnh8T0KMhdQOuRtf5S4mmc5hmC1ejG6ZhsGMBy/xxpY2OFpU1g4sDLTBWH5hjSLGSTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f4haocp3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4haocp3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734062161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hohhC+HKp9CnfbKmvLDDIi1grr9DkV90ygzzybVd/UU=;
	b=f4haocp3NgyZh/hl/CDs3Q4GTebA4b9BgYwGUrsZdx4v3phLABkWvwDX0CM6PgeV7V0YlC
	Lf8t8Gx+us2zhqqh4MMXIjdWvEtqy4z1lDJYdHRsCTNU+KzUJuEdpstyqh1aCKefDGSq4X
	lSRo1aNKLntYlbpMRj+LhQ5yjPnTgMM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-Px2SCvjIOPu1nEH8TX3fYw-1; Thu, 12 Dec 2024 22:55:59 -0500
X-MC-Unique: Px2SCvjIOPu1nEH8TX3fYw-1
X-Mimecast-MFC-AGG-ID: Px2SCvjIOPu1nEH8TX3fYw
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef9e4c5343so1901736a91.0
        for <virtualization@lists.linux.dev>; Thu, 12 Dec 2024 19:55:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734062159; x=1734666959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hohhC+HKp9CnfbKmvLDDIi1grr9DkV90ygzzybVd/UU=;
        b=tt4yQghicH+bzpFxl3lyLzm3xLzBqb9ASBF7S+Kdx2vAsP3RtQVs6grrkcU2r6qwnS
         HNVZ6lDzo/GHYGM06B2AQ/0BtpuXQ9Jhf7fy3aanTTNrDBNpYPw/jEQ/9qLS3Y4y8JOd
         atLj48ABstXLXAbh58QEfLNvTjKDcuvlymfdEK15ydaI8Ee+OoBC8Af96yv/I8RXjFnR
         mV1ui+3R/xJJJY+6a13ttC+hUbsyPO9H/aSShF0Ntq80dLZzAd0WH4g1sS+4LyVRYwnG
         wPulBlhqtMqvZaPCIxmdg8wx7uQAV8cXrMI35yyjxA8hdfUVfI0oQxzM0IUBlW5bWBqD
         UiAA==
X-Gm-Message-State: AOJu0YzRRIlxKFAqE1mpZYQ8UNl3QtQ3RQz5j/JqIQ9Ycrr020zEMJG+
	iII2a19R/w1cOozU+UfP4vefbxYS9osVQZCqqcILM9IszSYsuEml0Ar78wPFg6F147JsE38PPgJ
	47KE6A9wd+fG/5KSkVhdwE0sla2coriVcEl83Hg2YTeYI+2OMCuH50jpSjGBdU7Z6/AukkjQW1G
	FNdn+xig6qQsPdsfd7A73f71ftEhBRzAoT7BETPrU=
X-Gm-Gg: ASbGnctwEfvo2D1qxKViSqTqWvGA9pDrAUGxTrb7llLZ49DEG+limLuK7uWWV1iSvjx
	IWJG14kl9vM+xlDZk6thMJwfBnDPiKSGKDTNlFkM=
X-Received: by 2002:a17:90b:53c6:b0:2ee:4982:e59f with SMTP id 98e67ed59e1d1-2f28fd733f2mr2137662a91.17.1734062158958;
        Thu, 12 Dec 2024 19:55:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEafW2iox6ODPxu6qNDR+J2ks4Wa7nnNcsBTsO7vNPjs+72V/eu9MzyQy/i6saU+9tuWkzkyrbFKZ5asDGbRf8=
X-Received: by 2002:a17:90b:53c6:b0:2ee:4982:e59f with SMTP id
 98e67ed59e1d1-2f28fd733f2mr2137631a91.17.1734062158559; Thu, 12 Dec 2024
 19:55:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241209151427.3720026-1-sthotton@marvell.com> <20241209151427.3720026-3-sthotton@marvell.com>
In-Reply-To: <20241209151427.3720026-3-sthotton@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Dec 2024 11:55:47 +0800
Message-ID: <CACGkMEsmU4LjUzKFfyoY1ao8pRCETHRqPM3X8uK9KO-TCN8Trg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] virtio-pci: define type and header for PCI vendor data
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, dan.carpenter@linaro.org, 
	schalla@marvell.com, vattunuru@marvell.com, ndabilpuram@marvell.com, 
	jerinj@marvell.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7-nJ7exphDxvZsRQCEBzGWjIOIKK7IsGO6O3A-oTCCk_1734062159
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:16=E2=80=AFPM Shijith Thotton <sthotton@marvell.c=
om> wrote:
>
> Added macro definition for VIRTIO_PCI_CAP_VENDOR_CFG to identify the PCI
> vendor data type in the virtio_pci_cap structure. Defined a new struct
> virtio_pci_vndr_data for the vendor data capability header as per the
> specification.
>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---
>  include/uapi/linux/virtio_pci.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_=
pci.h
> index a8208492e822..1f3ea5d2a6af 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -115,6 +115,8 @@
>  #define VIRTIO_PCI_CAP_PCI_CFG         5
>  /* Additional shared memory capability */
>  #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
> +/* PCI vendor data configuration */
> +#define VIRTIO_PCI_CAP_VENDOR_CFG      9
>
>  /* This is the PCI capability header: */
>  struct virtio_pci_cap {
> @@ -129,6 +131,15 @@ struct virtio_pci_cap {
>         __le32 length;          /* Length of the structure, in bytes. */
>  };
>
> +/* This is the PCI vendor data capability header: */
> +struct virtio_pci_vndr_data {
> +       __u8 cap_vndr;          /* Generic PCI field: PCI_CAP_ID_VNDR */
> +       __u8 cap_next;          /* Generic PCI field: next ptr. */
> +       __u8 cap_len;           /* Generic PCI field: capability length *=
/
> +       __u8 cfg_type;          /* Identifies the structure. */
> +       __u16 vendor_id;        /* Identifies the vendor-specific format.=
 */
> +};

Nit: I would have the following comments from the virtio spec:

"""
 /* For Vendor Definition */
  /* Pads structure to a multiple of 4 bytes */
  /* Reads must not have side effects */
"""

Thanks

> +
>  struct virtio_pci_cap64 {
>         struct virtio_pci_cap cap;
>         __le32 offset_hi;             /* Most sig 32 bits of offset */
> --
> 2.25.1
>

