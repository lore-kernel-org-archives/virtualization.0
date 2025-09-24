Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2592227B32B
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699215; cv=none; b=ReG7hhFJL2f0KPEc2yXxGF7VqXJjqXbZD91j86WQGTNHmdhFQ69b7nyBaZCmQBn8eUuXqH24w/oocoQ9cFlh8ZLemk5REIBBkNYRAWyOx2Mkb5WZYhst9kT83kC7iGVKDXS0sCv4bM7udyO18riakFaedWZ0RcuHLIhjfDkUOe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699215; c=relaxed/simple;
	bh=b6wRV+hU0qQluBXkA/BkhIVUgI+95DTwLYGQyvNsXeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Frwjr30LgmzABIKYCHjeuTu5T/SKPFjEPtPhbsH7TbNpzRbG6RnIRtxNg2uRdc1tPgHIy1Y+N6IGcFok89h+tmB/oRgYIdkd+qH5e83fbslpumEH59nmgyw9QVI7lQHa4umc+Z3wNxWr1gNZI/dJhwA3aUx6axcT3Ax1jtZEAT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kkm2B5oc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kkm2B5oc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758699206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6wRV+hU0qQluBXkA/BkhIVUgI+95DTwLYGQyvNsXeM=;
	b=Kkm2B5ocQzlyqwOFxDhnWPWRI4PsK3Vh9mtGUccpC3rbAXUARonX7eMZS0n/ra4mo0/eqh
	HQC9MDG7455Lf6yl2cV946bxp7FqFcKGcWniMyguoZIdLEC/KzPFRuYSY+zxJHKB8hM6RC
	ybeJ/BcYmjlrgzLHJhglNaarGoa3u6c=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-2_r0HqxmMESJbSkwKBO3bQ-1; Wed, 24 Sep 2025 03:33:21 -0400
X-MC-Unique: 2_r0HqxmMESJbSkwKBO3bQ-1
X-Mimecast-MFC-AGG-ID: 2_r0HqxmMESJbSkwKBO3bQ_1758699201
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24458345f5dso94728215ad.3
        for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 00:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758699201; x=1759304001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6wRV+hU0qQluBXkA/BkhIVUgI+95DTwLYGQyvNsXeM=;
        b=ZshtCESRH0kZjm/rK1h5d8aeJ7WBXI/CABoG6wNxMe3jlkcr75Xp0qJEBc54XKBmSJ
         c+BJ6A4ifyBCDHEU3ztX3V2cWk5QmrGE/G2csLtsAPyrOK+3pH6kZhROB9A3EQUYcN8d
         9iSs3YYVieQLkn1Yq5D5AMFrkTR6dZbh2uuPh+O/0owxHDcdwlOn4/uoq+K3aVpiLDEz
         A86uUnpwGWQBdjG/BImRlEUv6Vq9l4GfrqNWa5aLI2HW9zvz370pofhyh8Sa2g7Ly/dt
         vbFVH/ONlZjD8Gpf91eIFROchr8tI1d/4em8TAsCg0lVyquWDPgIyLK0IuE1LsvJpfIQ
         XDvw==
X-Forwarded-Encrypted: i=1; AJvYcCWYLnp1SNfwn5mlL6RTfWrN7daojZ0j3q+pfGh4zA5G/OcGQE1jK5jvZsYwiM7F4ewaDNbENKgagdFY7Pm1ZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywn/pECpOqoHS72qcmU5/fYC4YLKJvYKi70y5nELWKgpHVGUqcw
	goqM3yFgEcdhCwPel9R5tGr+l/HKtdK/jQg1EfPJHE9Osgh6v+zzfqWPoLhf6p6A7G2FwsJSlI2
	dh2+I6kKdMsVEdZQKaBi5QQFZEKQoQpze/9MkcfogLmVdOyeLixaMLFV8LC9g23g160r5HD0uXm
	2MTtomGLkiXXU2D2/ljTejP0HdJdzn4sGsQLqEF+YF9hc=
X-Gm-Gg: ASbGncugkcyK48FS4VjsqgbHybXlWBB+kY/cX0SC1PPtzhLICJl/X6l0U2eHUvs4DuZ
	Lyjq7dygcLqk3U5FpSYoxhQRA8GCtEYPk75O+Kzv5VPTCNdVAtJ2QU5WG8wV0LAeQwxKUsFZrw7
	f6x8o7al2gLZwtymAuQQ==
X-Received: by 2002:a17:903:190:b0:265:a159:2bab with SMTP id d9443c01a7336-27cbaf0e24amr61534885ad.0.1758699200885;
        Wed, 24 Sep 2025 00:33:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+14SJa59MjbvP9DJUdCwTBFSU+ad1kkLu/Xoi0kve8FMkca56Fj+oIDkby//sq4cwlX8+6BEG+AYJCQZEwnA=
X-Received: by 2002:a17:903:190:b0:265:a159:2bab with SMTP id
 d9443c01a7336-27cbaf0e24amr61534425ad.0.1758699200205; Wed, 24 Sep 2025
 00:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de> <20250924031105-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250924031105-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 15:33:08 +0800
X-Gm-Features: AS18NWBSU_1fvQZUvaWmku_qO0_MGvBZjZq20karT9w3KYqASj9gmSz5-R3j6Bg
Message-ID: <CACGkMEuriTgw4+bFPiPU-1ptipt-WKvHdavM53ANwkr=iSvYYg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/8] TUN/TAP & vhost_net: netdev queue flow
 control to avoid ptr_ring tail drop
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>, willemdebruijn.kernel@gmail.com, 
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b7YAs-Cg5_sWLBpnV1YkUXob8nbnYAJ-7lC-zE53kw4_1758699201
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 3:18=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Sep 23, 2025 at 12:15:45AM +0200, Simon Schippers wrote:
> > This patch series deals with TUN, TAP and vhost_net which drop incoming
> > SKBs whenever their internal ptr_ring buffer is full. Instead, with thi=
s
> > patch series, the associated netdev queue is stopped before this happen=
s.
> > This allows the connected qdisc to function correctly as reported by [1=
]
> > and improves application-layer performance, see our paper [2]. Meanwhil=
e
> > the theoretical performance differs only slightly:
>
>
> About this whole approach.
> What if userspace is not consuming packets?
> Won't the watchdog warnings appear?
> Is it safe to allow userspace to block a tx queue
> indefinitely?

I think it's safe as it's a userspace device, there's no way to
guarantee the userspace can process the packet in time (so no watchdog
for TUN).

Thanks

>
> --
> MST
>

