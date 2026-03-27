Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E34310763
	for <virtualization@lists.linux.dev>; Fri, 27 Mar 2026 03:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774581781; cv=none; b=HSMWKfYKf3xMkL0HT50E+sbSmCZ7wU6DvHnfbXgDa+QmjyAAu4eodFLQDONtxCJI79+ABRRhd9ILsN1PIbUw4YYai34CFcIOSobi/sraFE9Tg5XMnS3sGBdWTCMaxG/2It4HPQTr3EsRuV4WpQWR0/gYmR340PBi+FT8pMrfF+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774581781; c=relaxed/simple;
	bh=C36kZHRM+V1llXfOdIsMdSubkfgVK0RS45pfG2iUJ2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNSfXAbLM314fGmtb92TfAU8R5W6YKm8JsmPxBkDsQJnvxMeOlc5WszqSObJPUqY6Uiv+vtf0tBv95UW46KWbf2zcFPaUqrD3WT/8Dj539nO+si+138ZFxlrhzvdxtrAeVgD+fTBzjBGsIwNNYAyN9k8U1N5X7/YOtNGjr2p7zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGsoDGaw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGsoDGaw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774581778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C36kZHRM+V1llXfOdIsMdSubkfgVK0RS45pfG2iUJ2Y=;
	b=iGsoDGawThmtM3EcdDlKNJeSiaObsLZy+V7NF7cj7F0unxrbmmtP3FHmFG6jorlvjF/N51
	xFPA391KDqfVtB0z9S1tFDV8VgUVD1jTF6cChhWH4J6cSqduJiQwZ5WHnhcxl4uWGYZjFN
	CtYYsJCWGzZqIyQCTLS4Q+HgND7qlew=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-5fgmvGQXNRySrX02M5FHPA-1; Thu, 26 Mar 2026 23:22:57 -0400
X-MC-Unique: 5fgmvGQXNRySrX02M5FHPA-1
X-Mimecast-MFC-AGG-ID: 5fgmvGQXNRySrX02M5FHPA_1774581776
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-354490889b6so3498894a91.3
        for <virtualization@lists.linux.dev>; Thu, 26 Mar 2026 20:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774581775; x=1775186575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C36kZHRM+V1llXfOdIsMdSubkfgVK0RS45pfG2iUJ2Y=;
        b=aQU1J24x4dTJW04M9Ao16fJp2Rob/mF7cy/oAcyOnMyJQceiN8PkAxmTdV2nDMYFWE
         FRTPXxZOHNvAseyNTwucVB9FL/GybzQWJl9k8bSWwmRGOzy+1PVnP2nOtKAcisrBrgsR
         UmYpNVk37jfk7nvJSja/VVHUcq2pi+MDYXzoTsKH6t/1d7PErjYk8cjKTGFgdeQZlzPa
         PfHTZlnVm+Qjg5MF8yY6sMReS/RFzyAhA9zcJF+a2PaGKdwftIQ6aEGDZpG1LfpiZqQl
         UWj+M5U0AiFKFW8HKhdUBVu3cfCpknyn0VS61sAZXq14gQbg7a7+z64ie5FkvxH7CjhO
         6eUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWofXFGvvJxhsjzFeoyX8OaSPWHNQJ2H60HvhkSOxU8wutm3S/Qzn4oMGI0ZBIvzU1cFGe82s8iq5Dqj2mzyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzp/w5vcLZpsxZva/qsp6DLb1VHtM4pqktZhWvARLEwZpebVNUI
	trvcbsAdepNCzwv+x7kFf3UT5ziv15THopyyePLM5MWoJLApWItWV6NQRrqE/Z3551C5pVoDDVP
	AtaNbGT1NVqlxl+vUlXOtLhf3rzudtmQTiELL3fU+SVurxdhSI/rDOjJ+2bDq+FEGoZ3lrzJ2Z6
	FZCekw01M8C3EsqV6Zr4g19iDCmjr3NA3hcEQeWCcnGG/cqlRlqb8=
X-Gm-Gg: ATEYQzy34YvZegVqmBFkegor67IcLVmfYf/wL0OARHDr3fkdp4kqO6toPmSutCtNCdj
	veaVi1AGEYCo/Esx45xWixQO5KI7xifwG1fgWVp4441LS+84YtKPE9SiV+qEDAAfj1zD/yWJduT
	KoL9pMYYXym9+VwaE4Bgs/E8qLvd6GqFeh4v0tR5oenYP2OrX3Z45/1EM03mCYiPMG+pDUV5CSV
	vicaZA=
X-Received: by 2002:a05:6a20:3d83:b0:394:518c:eb89 with SMTP id adf61e73a8af0-39c8780b641mr1212510637.2.1774581775592;
        Thu, 26 Mar 2026 20:22:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d83:b0:394:518c:eb89 with SMTP id
 adf61e73a8af0-39c8780b641mr1212462637.2.1774581775042; Thu, 26 Mar 2026
 20:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260323041730.986351-1-zhud@hygon.cn> <20260326200346.438702a6@kernel.org>
In-Reply-To: <20260326200346.438702a6@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Mar 2026 11:22:43 +0800
X-Gm-Features: AQROBzBPA1qr4Vk13kqcA9kah5M34BuAu0Zq25NCKCV0BTGn2cAu7ih_M_IJ8HM
Message-ID: <CACGkMEshcxj-R1Ek1dRykBTQ6NLS11jt-9NAu8PbcmtzobRY0g@mail.gmail.com>
Subject: Re: [PATCH net-next v4] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
To: Jakub Kicinski <kuba@kernel.org>
Cc: mst@redhat.com, Di Zhu <zhud@hygon.cn>, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, willemb@google.com, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, lijing@hygon.cn, 
	yingzhiwei@hygon.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4VZSiLyRnBNABbDvdB3YWrqcwHzZ7B4wtBLlFEazVck_1774581776
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 11:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 23 Mar 2026 12:17:30 +0800 Di Zhu wrote:
> > Negotiating VIRTIO_NET_F_CTRL_GUEST_OFFLOADS indicates the device
> > allows control over offload support, but the offloads that can be
> > controlled may have nothing to do with GRO (e.g., if neither GUEST_TSO4
> > nor GUEST_TSO6 is supported).
> >
> > In such a setup, reporting NETIF_F_GRO_HW as available for the device
> > is too optimistic and misleading to the user.
> >
> > Improve the situation by masking off NETIF_F_GRO_HW unless the device
> > possesses actual GRO-related offload capabilities. Out of an abundance
> > of caution, this does not change the current behaviour for hardware wit=
h
> > just v6 or just v4 GRO: current interfaces do not allow distinguishing
> > between v6/v4 GRO, so we can't expose them to userspace precisely.
>
> Michael, Jason, does this patch look good now?
>
> https://lore.kernel.org/all/20260323041730.986351-1-zhud@hygon.cn/
>

Yes, I've acked.

Thanks

