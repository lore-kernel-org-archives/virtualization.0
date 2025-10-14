Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727AA2F7AB1
	for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760438529; cv=none; b=ifWTYUq9+6uFdQWbzHODbQ3FuH2AI11vDDSCvYUeCQlMGnJEhCZvD6Ec+iSdVAqDDDONp7oTIAggtSJOILQiwB8k+KsbxXnN22+w+Mc95ssc5B4NhvexYN1yW+Iw1rovjQjxytYlrHt4zJhSiM4fO+Yuxvl7VIw0YOeEMXGqVBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760438529; c=relaxed/simple;
	bh=RQ34rsynT3KecWsHgfGDM8IdNGjfn+DFKLSv7fE7Jw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=D0e4hJ2q6kFopEUP1IZB/+NL5Kp/c7JAY72wDXi9Jo/d2/feW36Trd4q5QCV2GH3x335B757SxO1TXHEdDCY/8qUgI2GJmn3NOZOU0OEtbryPL/q+Q5esutuqqU1rop6DYyKduo99YkHCpYYGjvLOuZ/eVkgmoIXdLOS9Nwa6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHPfFQIh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHPfFQIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760438526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L/5Sp+hrhl8fiP8iEDx4RrYCvuJ3p5/YndbyKEzBmXc=;
	b=HHPfFQIh7bf4pCPWoNbbBuXVepDsywzqvoxaWE67DY6Szl+Uxzbtgf3lNWi8r0AgT13viW
	epjZ7jcBzE6CBHJyuZptAG+jLzl7S2qBPX1uaz6aiZF7k9xZD0wjr3R/wT1G4FtbseTCs4
	BtF3S8CelWlaQVGI9FTT0e6UsVz0nHo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-FKkkMeuJPHSiAmaslbVeNQ-1; Tue, 14 Oct 2025 06:42:05 -0400
X-MC-Unique: FKkkMeuJPHSiAmaslbVeNQ-1
X-Mimecast-MFC-AGG-ID: FKkkMeuJPHSiAmaslbVeNQ_1760438524
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e473e577eso37381955e9.0
        for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 03:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760438524; x=1761043324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/5Sp+hrhl8fiP8iEDx4RrYCvuJ3p5/YndbyKEzBmXc=;
        b=fcN9c5E1LewPugQ3WAzHiXUg1jsE3FFsyP8nW62Lf3W0cCbM70HQITf1BViUABxzY3
         fyBai9CI1fYjU5Nvbw1F+9H2eIevorBq8z9rNMg8iNMfipeZ0Vfg/Wddqv7bjYf89qcD
         FFpb0Tw9O2yxb3VAB4f+h85Qf/j3Q6wLe/qODw4YOx6J3vLYHJ5PanFX+O+JOM9fq9gU
         DFDGUaudAtLoebYy4+TCsTSWEsnxzAuNjS/LvQcsRpG/HNua6yNUZ2hFuXOuaPEujk+n
         KlCFHOjij1dT+S+q89CKxyXty6wwo//hdCP8sl+5PeC8rKPucH7xujOlD/tsDevgfgeW
         DhsA==
X-Forwarded-Encrypted: i=1; AJvYcCU8rVJL6mi5+836aqo2WLutntpAB+VFZflnTQOTM6k3tbfQQ1WvHKgJLPp3drmga6dbQEgO3YaJ2DyAizlFLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXc3kLaBFr5pl43LuoFjhRjIfwiDihbA/HJBERkZflpw1ho8Jo
	W6zGbCC1i+deuOQM6E7PHYRTyLkuokTWChGHpRFRJ8tyBzwIdFT5g/+g7UqoM7f/mZ3T20p7ISD
	7g9YAVi5hoofPNkdQsMKQ/N9zMzdhOkmRpsU/7NiNrJyR65UHmZdpVGeCf5ZE0T3ZUvjs
X-Gm-Gg: ASbGnctwwdCNzUAOyn2UWRIVUXPT8Z8elXj/UBsTdtH27XJDJkTMn3nDGMuU81MhOKt
	wzqfyUx33wATN7ce0Hr0ZnHiWd1tbO5Jb2KPg6ljj9edCkCCT+Foj3+0iHyEdxFUXeig7sDQoCU
	HhuX+l39O/+qIrDrgPeF7sinCG5WxBJYdlC8eJCQW7mDmIg0g3AfF7dDkA/EQGpqzKwWLZkw32q
	wrsg1hTxPd4JhWTmP53dA/0Pv0YVBxdZ54tjcswDpHY3XyBFZ12W2C2+t1DUL88HkeMHYX4cc+Q
	Tg7gkf7ml/yPBn3Zrh4vmXtOvMRzCr1CNw==
X-Received: by 2002:a05:600c:529a:b0:46e:37a3:3ec1 with SMTP id 5b1f17b1804b1-46fa9af1797mr166476975e9.24.1760438524046;
        Tue, 14 Oct 2025 03:42:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGutYCRnhkia1gciP+0bCtZ7c2UH3BQX943fXSvrDEskZ8kHpp3PY0jTsWYLQa9dYN9SqSj9g==
X-Received: by 2002:a05:600c:529a:b0:46e:37a3:3ec1 with SMTP id 5b1f17b1804b1-46fa9af1797mr166476685e9.24.1760438523635;
        Tue, 14 Oct 2025 03:42:03 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe69sm23489497f8f.32.2025.10.14.03.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:42:03 -0700 (PDT)
Date: Tue, 14 Oct 2025 12:42:01 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Francesco Valla <francesco@valla.it>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
	Harald Mommer <harald.mommer@opensynergy.com>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	development@redaril.me
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <aO4o+Zmzlnqc12dx@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <2243144.yiUUSuA9gR@fedora.fritz.box>
 <aO0qZ4kKcgpRmlIl@fedora>
 <2332595.vFx2qVVIhK@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2332595.vFx2qVVIhK@fedora.fritz.box>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZT-XckDXYkZJZsnKjGmZF73848Z2A0wwwMm-o-j7Y8U_1760438524
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 14, 2025 at 08:54:23AM +0200, Francesco Valla wrote:
> On Monday, 13 October 2025 at 18:35:51 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > > [...]
> > > 
> > > > +
> > > > +/* TX queue message types */
> > > > +struct virtio_can_tx_out {
> > > > +#define VIRTIO_CAN_TX                   0x0001
> > > > +	__le16 msg_type;
> > > > +	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
> > > > +	__u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
> > > > +	__u8 padding;
> > > > +	__le16 reserved_xl_priority; /* May be needed for CAN XL priority */
> > > > +	__le32 flags;
> > > > +	__le32 can_id;
> > > > +	__u8 sdu[64];
> > > > +};
> > > > +
> > > 
> > > sdu[] here might be a flexible array, if the driver allocates
> > > virtio_can_tx_out structs dyncamically (see above). This would be
> > > beneficial in case of CAN-XL frames (if/when they will be supported).
> > > 
> > 
> > If we use a flexible array for sdu[] here, then we will have a problem
> > when defining the virtio_can_tx struct since it is not in the end of the
> > structure. I think it is a good idea to define it as a flexible array
> > but I do not know how. 
> 
> In this case, I'd move struct virtio_can_tx_out at the end of the
> virtio_can_tx struct - in this way, sdu[] would be at the end:
> 
> struct virtio_can_tx {
> 	struct list_head list;
> 	unsigned int putidx;
> 	struct virtio_can_tx_in tx_in;
> 	struct virtio_can_tx_out tx_out;
> };
> 

Done.

> Maybe an additional comment declaring why it is done this way would
> be a good idea? Also considering that the two structures are defined
> in different files.
> 
I am not sure if a comment is required since moving the tx_out field
would make the compiler complains anyway but I do not have an strong
opinion. Also, would it help to put both structures in the same file?

Matias

