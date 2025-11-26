Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58F4316910
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764138618; cv=none; b=eUxRmjRGcE660wpjwHJVs/U4mMQT/g1N96kd+q42SX4nWXYplDn/ObbsLHGEla2e7PBT9DCGcQRjiGslgjzRSpz4AlC1hVobLy2l23SqhArmYb7LSrIRMU7gMSO8yfdYQSXJ9kBXzH89QwuW6xaQyov+WZbmPWIHbjQ82vjW2AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764138618; c=relaxed/simple;
	bh=shDW0bp9CYlSovPFi/gL4KjEH8ciVonuyi+rYc3qW8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUZ+rHYz+hlw6R1AdrA4RdI7jdNGGceI2IB/Tr8f+0/3YQMTYuzxdxzqnpLyB7Qpf72EkjfReZEBP8llhphYb3ml3gn3cFU8rivPs8MtTA1w8QGMast4KTmAhcBkGzJakmzHR1W0MqMT7vCsRWG/zKg8EElNTvWGuGHB3uX1oCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hv2uUHj+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hv2uUHj+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764138615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shDW0bp9CYlSovPFi/gL4KjEH8ciVonuyi+rYc3qW8U=;
	b=Hv2uUHj+R4wtwKBzfHOsyWPkP+SkT2iDXeSQc++FeLtJIH/CApmnIVa+DqCsk4tNBrdfkd
	BvA+cw9i9VfH9u7JeBPDiZlsND/xSIGbd0nrOrI2UxvUST77DWuwsd+D5jFYg6qZy0BuH/
	oCRi/LEex7gmShthZFwFSScZC2GnRTI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-yqCeX1rlOcSXuDSXZCVnSA-1; Wed, 26 Nov 2025 01:30:13 -0500
X-MC-Unique: yqCeX1rlOcSXuDSXZCVnSA-1
X-Mimecast-MFC-AGG-ID: yqCeX1rlOcSXuDSXZCVnSA_1764138613
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-343daf0f488so6473426a91.1
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 22:30:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764138613; x=1764743413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=shDW0bp9CYlSovPFi/gL4KjEH8ciVonuyi+rYc3qW8U=;
        b=B8vpuhN6t5iOHsuDDsZLtZ7tEKF2lEAjDzeS6hG+tLciSIG5AttSqB2EWkyw4VD+MD
         aU8X1o7GpdpHh5j9Ki1GcgBk7AAQc+WHuAI+af92o9bHWVCxn6XmrA+A6wQzLLbvoqdq
         q1FD4kchAEhJ2/vKxUaPY3iajbiKIIyCx45Fb/ZCglIRtG2htsVZYCE4ry2RIg/mvkNb
         6hn/c/bCMdbcFO1Hu4PNO+eIgyMa0KSOZbztHgrzXiz8H4Quko4h9hso5cvZsU0kIblC
         ongUcx30qQmWn/YDL3BrZKboBYP90KfPnsqOVKZAY2zurPhAUH+8gEDXY4bSUKI1PcAk
         ls4w==
X-Forwarded-Encrypted: i=1; AJvYcCUaEsDnf6eM3C0CvPW/8nYxSqKNHjiH7MMRBlUPktbTLIU49ZUrZ11cHksYN5yvSNeds4FbrW1CBHV2HvLSuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzk/MG9MYM68F8MqdEKVAsuQbni5fscXixYdx99S4mSD4PJU+2r
	5c2j6XdVyffLUPBy5WU/FCNXpFh4eAHfOO7OrgD1+iNg3MRtCQexMF1gYUQEs4UXTe9DzkQVfLT
	bVAECWkjNU1A+ua2a0+a9v2nAKgwmvXCwztT6CAgwpyYkXzA930Z7YUyBFCahyNMzXRDWW9HWV+
	HEnVHMIjNca6VEI7MD3GrN+YbynGxfrsZmeMEy9s61Q4o=
X-Gm-Gg: ASbGncsHRC6RzHSk6oXRlxWIFwxBzbGlfk2clgYNIvaHDVVDxycT2f/+HUl/ysO9B6x
	cR1AskxRMRdm9QJp5M8W746DXtC6MklH3ore0FC8iWv2Hd2Q+HdDzUoUbkL01rsw2NvnXSICUd2
	5irY9Qc312i4XAejek/hvPIswdtWcfYglhCMLH5IZ3Uq2l08JpBLMlerNxJHop5sc2+wU=
X-Received: by 2002:a17:90b:2f83:b0:341:194:5e7d with SMTP id 98e67ed59e1d1-3475ed51453mr5743353a91.24.1764138612823;
        Tue, 25 Nov 2025 22:30:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeL2+MjlKvJTulnscTHHFaOIKShldd6HAyu8s9k6V/8uabjg3AQSXsiYn3FxybeY1hV6sKpHRSMvuAzqJKStI=
X-Received: by 2002:a17:90b:2f83:b0:341:194:5e7d with SMTP id
 98e67ed59e1d1-3475ed51453mr5743332a91.24.1764138612403; Tue, 25 Nov 2025
 22:30:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251125222754.1737443-1-jon@nutanix.com>
In-Reply-To: <20251125222754.1737443-1-jon@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Nov 2025 14:29:58 +0800
X-Gm-Features: AWmQ_blHu1BZqv-6yOkAhpdiGvIH6FCxP2EMvVPtPSNF_eBgleWvB8nW8HekDzQ
Message-ID: <CACGkMEvK1M_h783QyEXJ5jz25T-Vtkj4=-_dPLzYGwPg8NSU5Q@mail.gmail.com>
Subject: Re: [PATCH net v3] virtio-net: avoid unnecessary checksum calculation
 on guest RX
To: Jon Kohler <jon@nutanix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hGcJStr10fqg3p6XGdXGzwWGwxmt884Fpt99LerrKrc_1764138613
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 5:46=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
>
> Commit a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP
> GSO tunneling.") inadvertently altered checksum offload behavior
> for guests not using UDP GSO tunneling.
>
> Before, tun_put_user called tun_vnet_hdr_from_skb, which passed
> has_data_valid =3D true to virtio_net_hdr_from_skb.
>
> After, tun_put_user began calling tun_vnet_hdr_tnl_from_skb instead,
> which passes has_data_valid =3D false into both call sites.
>
> This caused virtio hdr flags to not include VIRTIO_NET_HDR_F_DATA_VALID
> for SKBs where skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY. As a result,
> guests are forced to recalculate checksums unnecessarily.
>
> Restore the previous behavior by ensuring has_data_valid =3D true is
> passed in the !tnl_gso_type case, but only from tun side, as
> virtio_net_hdr_tnl_from_skb() is used also by the virtio_net driver,
> which in turn must not use VIRTIO_NET_HDR_F_DATA_VALID on tx.
>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tun=
neling.")
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

(Should this go -stable?)

Thanks

