Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21BE26F289
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 01:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764206855; cv=none; b=Bwdg8fBrD1ann2pEyh6WjrcAezmrLq4Vow8B01DTWJ5Rph07jC7ZVd/pjwgKwgb1M621eRW7M8N+wgtZCRO8/0ixNcRTDxRMWfFiQDx6Nof3q4BoMPeiEy+JhvZ31MPshZ16+CsMlHFMPJEumOsNQf7hOBGPRD6vpgXAdmhprnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764206855; c=relaxed/simple;
	bh=r7KEz8iqgaXG1/tonNQbAHreoU8BpvA4RzO7XTtNj+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6hd9HCHS38plsfTR92sP328Z/bYdBbTGMFbxywx4Uf1SVzSFW7LJdGsKSqK/E+i58JMftvR4hqHTW/mT3gukLvgnPt5UD5OjlYnTqKYVhB7JHOplyi2S7rr3EpckZdNur3c5NVoCN+fhs+kbqj6ffXsxWmdZJMh6t+Ve90G2TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ywlpl2xU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ywlpl2xU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764206852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7KEz8iqgaXG1/tonNQbAHreoU8BpvA4RzO7XTtNj+M=;
	b=Ywlpl2xU8oeyjqTDzDY8S5xTLk8LH3E7pilbCiKa8fWBjpQ2YPfM0YsR51x6pHr69LWWOT
	5K/yRt/Xk1xslaW8sLdC0aoRBZyVuuLq8ldMdd00Rfj/l/LWMq2YFsZAU0wbmtoXSD2WM4
	Hb8h87TSEevGYJeOjvirzAiYmWyYve4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-JmOJYrNDNxyHDai578EDPw-1; Wed, 26 Nov 2025 20:27:29 -0500
X-MC-Unique: JmOJYrNDNxyHDai578EDPw-1
X-Mimecast-MFC-AGG-ID: JmOJYrNDNxyHDai578EDPw_1764206848
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297f587dc2eso6296435ad.2
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 17:27:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764206848; x=1764811648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r7KEz8iqgaXG1/tonNQbAHreoU8BpvA4RzO7XTtNj+M=;
        b=QdO+X6K7ydc8q5rlXiFZ2a3eJ3PMEQa6Cm/Vg5X/XIzkOfePoVXjk53dGUC8ih/d1j
         TkkTKtV6jc7HivjMga4zBpvaZXU82j5nlrysTY/PgRwdAfhjHdBl0ndk0DdnW/bVIl63
         yVacGfR/tb+OgcYVcJBosXjIt7HXvE465yP6OQzgvPuud5xSRFt/QsTQ+ap/wINV1E5S
         rL2FYK3zid7hp2Zh908IblKruKZcKNvwnubJJTdYM/Uxq3sU/d/DyjNKW5IiflOdd4Dz
         MHH8Zs+GDd+UW6MglJ5I18qHBqVDIE1sGzc0RDn5kHMJtsJEJGA/2eC6ic/cEwxU0jph
         CMNA==
X-Forwarded-Encrypted: i=1; AJvYcCUJpMplm1n7VLb83IGCv99gPPu0ZdX5/fCJrnBlLB3DVKP+3xM4JVR/AOqT/wmhuAoaXSx/FlafAH+/MYnMug==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuYh0DShjtMsPZl2FUayxmWEgzbpwJ3tjF09DAt4PQ5bYpYcDp
	1fXS7KZAzuE4/sGcwx71Z3FKFPBS1sJ8EVuvoN9NgGbQs8bYKxZfiaeTk+AesaEJ1yeWP9Gfj9V
	0abm6J+YafoaiW/DimLnE8O80flqi+2avd2ohMkN4cOjL7jfSJiQyBYF6Kdis+L/pQsl9GIgP6a
	Sq8uwqQB6F982l8kheR26vFsDetimVh/r4RTDpk1uTX6c=
X-Gm-Gg: ASbGncsHwRYDvUquGTGvKu1jVwJ5T9bzLSi3jDWbrnDd/alfWdjGzUizOFTbfvGu65e
	YvzqdfUkAFynqkGMOziA5waWe8OT4tT1qGZ37rSBXTaSuLArRczxK90iTtKtPT/RQ6+1voKAN4M
	S84HAwOuK1GWxPmmJ9I35mQrxuMqYUr0dJYML0KLlYoYgmPwzBsCF/6yceiDYUVNa4
X-Received: by 2002:a17:903:1ae5:b0:295:3a79:e7e5 with SMTP id d9443c01a7336-29b6bf3bd68mr239483465ad.34.1764206848300;
        Wed, 26 Nov 2025 17:27:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkO8PdlOXSckshzA60VPUWOZAaeSJuC4qSXUdbHgCezX+9REgWbWrPJr0c4cJsSiRA2TS68/Axo338N+hgPfY=
X-Received: by 2002:a17:903:1ae5:b0:295:3a79:e7e5 with SMTP id
 d9443c01a7336-29b6bf3bd68mr239483305ad.34.1764206847831; Wed, 26 Nov 2025
 17:27:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251125222754.1737443-1-jon@nutanix.com> <CACGkMEvK1M_h783QyEXJ5jz25T-Vtkj4=-_dPLzYGwPg8NSU5Q@mail.gmail.com>
 <8FC82034-6D22-4CDC-B444-60F67A25514C@nutanix.com>
In-Reply-To: <8FC82034-6D22-4CDC-B444-60F67A25514C@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 27 Nov 2025 09:27:16 +0800
X-Gm-Features: AWmQ_bmCfWxgTJtsgAzMnemOZLmAhjUF-FCkJ83NqHraHOHyDs9XYJ5GbyTvy2Q
Message-ID: <CACGkMEt2FFSiodAN=FFT7JnV78pmVRN4VTr_XDm05J0xpSfmHA@mail.gmail.com>
Subject: Re: [PATCH net v3] virtio-net: avoid unnecessary checksum calculation
 on guest RX
To: Jon Kohler <jon@nutanix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TILW5nMKviIDCQNWD_Qnig_lLEwk2DkvWB_4Gi0e9Ac_1764206848
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 12:12=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote=
:
>
>
>
> > On Nov 26, 2025, at 1:29=E2=80=AFAM, Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Wed, Nov 26, 2025 at 5:46=E2=80=AFAM Jon Kohler <jon@nutanix.com> wr=
ote:
> >>
> >> Commit a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP
> >> GSO tunneling.") inadvertently altered checksum offload behavior
> >> for guests not using UDP GSO tunneling.
> >>
> >> Before, tun_put_user called tun_vnet_hdr_from_skb, which passed
> >> has_data_valid =3D true to virtio_net_hdr_from_skb.
> >>
> >> After, tun_put_user began calling tun_vnet_hdr_tnl_from_skb instead,
> >> which passes has_data_valid =3D false into both call sites.
> >>
> >> This caused virtio hdr flags to not include VIRTIO_NET_HDR_F_DATA_VALI=
D
> >> for SKBs where skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY. As a result=
,
> >> guests are forced to recalculate checksums unnecessarily.
> >>
> >> Restore the previous behavior by ensuring has_data_valid =3D true is
> >> passed in the !tnl_gso_type case, but only from tun side, as
> >> virtio_net_hdr_tnl_from_skb() is used also by the virtio_net driver,
> >> which in turn must not use VIRTIO_NET_HDR_F_DATA_VALID on tx.
> >>
> >> Cc: Paolo Abeni <pabeni@redhat.com>
> >> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO =
tunneling.")
> >> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >> ---
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > (Should this go -stable?)
> >
> > Thanks
>
> It could, sure. This made it into 6.17 branch.
>
> Would you like me to send a separate patch with a Cc: stable
> or could someone just edit the commit msg when they queue
> this?

I think a new version might be better.

Thanks

