Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7C020B22
	for <virtualization@lists.linux.dev>; Tue, 17 Dec 2024 02:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734401967; cv=none; b=nv/olCOciG2d0Fp5GZDqwMU8NNb8HJOW8JABnD/2n5W/fWxPa+MboLneMERgmzOIneQhTgBGW5nKzVGOMXBjQCBTQa5YiGuuJKD5iCEjCkrPT76WGD+nFYpMy3FGHxqJxBYYVCg27Xi4ke4k50JoLQ0vnO4YEj0W0wxZXsHF8NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734401967; c=relaxed/simple;
	bh=EMVRt8Z0FZtdUlMH22a7skR+XExEKWpqSYCuJqQjsK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+6WwQQko0JODGGE5odDxCXU/iedBBheaYTCjjQ5j2qLHzCceGjgV1ueEP+ga5bGvVYIMDEhMuowuxORd+n8KxjuASLGRBcvd7+92ecZd/3kE2uHhA0AY2lf+w78vVkqz1xzR55mDDcfDfOyZj+K+h62HnbR7Rofe/mxp57e5Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLPS7Df2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLPS7Df2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734401964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMVRt8Z0FZtdUlMH22a7skR+XExEKWpqSYCuJqQjsK0=;
	b=WLPS7Df2zpx1AZbx2btsDodu2E4AxpcdGQCdYch8evU1Gd6zxjSeOR0R12cOfZYpZMqsy+
	rYmXln1l5/+nk3ZOmHEY+mMAp3VQ8eFHOK12juRdctKoSsyTwbRE4iOjKkuuq1I5gvNXhf
	TTpDXpXz8xmXOam2Nmxwl4vr3O0SdNI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-AFxMM7LWMXOJRjR-ySzjdQ-1; Mon, 16 Dec 2024 21:19:23 -0500
X-MC-Unique: AFxMM7LWMXOJRjR-ySzjdQ-1
X-Mimecast-MFC-AGG-ID: AFxMM7LWMXOJRjR-ySzjdQ
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-216728b170cso43968835ad.2
        for <virtualization@lists.linux.dev>; Mon, 16 Dec 2024 18:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734401962; x=1735006762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMVRt8Z0FZtdUlMH22a7skR+XExEKWpqSYCuJqQjsK0=;
        b=V7sKUly0lhfB1k8Q25m3SSR3NRy3OQtj7tYs+jekoL2tquNYh1X01Jzr4k4jIjL+Sb
         gs4TMIZp8X5gl2cuTdH3hbhlgV3KgZ6HF/1qP2P8I13JzLqkP8Sf2IJsTzebzGdORyjj
         3DeNLIwpRcoQtHJKlavWyVb7elgVf+L0ExpmQQZ8QqvvHEmQd4a+Di61c2KF53Azy084
         2E21UnNu5rI34mRkgGgRg2+1jhvcVx2n1j5WX9l7WfqGrBhN00Eg3+fqnJYSV3BVpmME
         LSjonul7jB5zQAWftt3D28CN9qLqYGyhwhnqwu70eKA6UECwdHpPJk4KgEPkuu542uzq
         PfxA==
X-Gm-Message-State: AOJu0Yz3uc/UjD3hwiuC7XmnDAZ2mZwZa5yIvMMH0FUBlDnerzt/xFaS
	fIQvN7c4XXrTERJ3biWz/gkxmR+sFlN9/L0I07hyRCZeLi9t/GY3EBpbyiyGj1SCBisfRRza9OP
	OLn2d++OfOysEzrVbPP9q5ukAhj8wOmXiPjy6WiqkJroWdnRFrhhIXoDR5VPd9QAWVNRLH7Qd4d
	GZaTrqHsCbilwMnuXQAxlTKVcfXTVZ0qZ0l0+CRBI=
X-Gm-Gg: ASbGnctcU2ZvY2Fw8J4W1UbivF56njlPdB8kI1cxErSoo4tSedZOPedsxh0cg2hrw6J
	XLUsoea81mnUGbyYda/ZlidCImCrjuxXZULVREpI=
X-Received: by 2002:a17:902:ccc7:b0:216:59d4:40eb with SMTP id d9443c01a7336-21892a847f6mr189534335ad.57.1734401962140;
        Mon, 16 Dec 2024 18:19:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/MjEzcA522BkO1WbgCEU349rXldXRhDHOSRwH1IThWF1Zf1U4FfgD8Qsk8l40TDb27osULcYHpC+vu/ab3L8=
X-Received: by 2002:a17:902:ccc7:b0:216:59d4:40eb with SMTP id
 d9443c01a7336-21892a847f6mr189533965ad.57.1734401961699; Mon, 16 Dec 2024
 18:19:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241214070835.568818-1-sthotton@marvell.com> <20241214070835.568818-3-sthotton@marvell.com>
In-Reply-To: <20241214070835.568818-3-sthotton@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Dec 2024 10:19:10 +0800
Message-ID: <CACGkMEuY-6hsxbwgiaVKWTnirAK=3Pxf8FxVx_C9iHxf=kWaJw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] virtio-pci: define type and header for PCI vendor data
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, dan.carpenter@linaro.org, 
	schalla@marvell.com, vattunuru@marvell.com, ndabilpuram@marvell.com, 
	jerinj@marvell.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u78-g8cG808RFtx_1FkcCiOsKG0fzPiK9B2LxTgXxC4_1734401962
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 3:12=E2=80=AFPM Shijith Thotton <sthotton@marvell.c=
om> wrote:
>
> Added macro definition for VIRTIO_PCI_CAP_VENDOR_CFG to identify the PCI
> vendor data type in the virtio_pci_cap structure. Defined a new struct
> virtio_pci_vndr_data for the vendor data capability header as per the
> specification.
>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

