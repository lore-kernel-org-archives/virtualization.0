Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3EC1DF985
	for <virtualization@lists.linux.dev>; Sat, 11 Oct 2025 05:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760160157; cv=none; b=pGLluL00UWAe8N4aa4otYlbGG8WOKLABuXIlcSP9Oqw2BcpdwhYknN7SJObqi6sZnWmIOknwvnuB4VyaL+ZcENCP/s9aBb9MGJixS/6ync9p3TmVZsC4Uzacc3WUZjv6X0j+QAhivilhoRXX6JJT3w2VBOJ3Q5qUT/VU+12q3FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760160157; c=relaxed/simple;
	bh=e04oQWhlj41jJDtpl4el4ThZmCFiSoM1TXi2OUeKSO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVtKxfYJ4+r3PeakbD06jUn6EJUfDg5s6urw3C+ocByv5TSwbclhgrti4rroqC0B+JyXLc40sKyOHVL8oHB9h/mlKzW9CTv6seqwqI8UXp0tWejDamGn99KdxrhqN5BIIV+yVnXEvgsEQpi9LNtoRnm2OrZM5WK3lQe/w50/cFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdBKxHlm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdBKxHlm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760160154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOrWPiTFGdMEMeP8X2LbrcJmInJ4Xbwuhaj7Gm0dZUA=;
	b=BdBKxHlm673Cy7RxbMwV1L0lBSVvEVO04CntJU9DB8CSyHyAQWTx5L7Ft7UUaCjddq0IbS
	ghPwRyNKwXBoTxrp5FpwsjkN2bo3A4pmSE4/oQw022xjTAE+LR1CIo/q55JYwzWOSI3a44
	Y0Z+DazNDe9sUyEyH2n4cdNnQyRkoDM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-LkvC2KQKNQqoxJF4qtoPng-1; Sat, 11 Oct 2025 01:22:33 -0400
X-MC-Unique: LkvC2KQKNQqoxJF4qtoPng-1
X-Mimecast-MFC-AGG-ID: LkvC2KQKNQqoxJF4qtoPng_1760160152
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28d1747f23bso67637735ad.3
        for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 22:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760160152; x=1760764952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOrWPiTFGdMEMeP8X2LbrcJmInJ4Xbwuhaj7Gm0dZUA=;
        b=KzmP7hZljQb4dsETN8URrX3p9GuCokIaJYLcAGjrVRmCM4LlYmR/29f5040BlxwRuY
         UemwClpMF9gzVdv4rdRL7k3mXqYtov3zBEYM/e5F76qI4OD4LC9iHJAK5rwddxnJO1UT
         YIZRhresjnNjbHjx/pQrZWZHzURodJT9eutQARraSPfekmrtdUGRkUvW8EAfPXc/v50e
         0QI7x6LgNEV2r8S6aBwJSqwYhSHG6lJHNFaa15ene8t8l6bfZC4IKCDgh/wMLbIPeg6S
         LHnKNbnBARaZ/PAKtULfzy+3+YagbWViDM+V3MU5A13OY6vCBtorVjabiTLBemw88hvs
         ojLw==
X-Forwarded-Encrypted: i=1; AJvYcCXvX/61Fdq3fiNoZjM4fnOISd+xP6LGlvcG51LCT5jgwt4ab/+Mhr6aPzEPIcoyDiklbCJRSh/cqroxfWXNow==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7+JNj8QWmXHFGwB3MQSRsDXLULnj1U0YopxSI2Z0GOklZavWb
	xfZacAUQ7HkdGCMnLOaU5yJ3H+atVR76zz/bM7bkrXV/d9N4ubjJrbTBDdLeN5/XLE6l70R3D+5
	MoTvYDLBEQNC56c12kGTny24+In95GAFufnVfg2/wvPZzVlGwHf2wY9HmFO7j1u9ecFQHJ+myjy
	Awhrlpa3JtBfV2N32atRBIvoTatjiX9wFvIELhsYmrJYQ=
X-Gm-Gg: ASbGncvthAVvf2INk61OU9D2+ELo8iTq7yb8aDdWsolN6YyVhxFCOs4GmVAOEB3jtox
	pIUUDRiF4hE76NN6YLxLLrKutg+9xwuZn6p4UqhnTKiPFGY9A+4XCR1s0MZwU4RTWv1+uMPyPMN
	AohxDu1GmpPqaOw33PpQ==
X-Received: by 2002:a17:903:2c04:b0:28d:195a:7d79 with SMTP id d9443c01a7336-290273569aamr186999575ad.5.1760160152247;
        Fri, 10 Oct 2025 22:22:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaIXAN+QxEwIj9euOLEBZqP+lrqQuyOE0OJMjvLYvUoxffY4RyNLYpCkZmbxudKcW+eMip7jkXCCWEkrirdSs=
X-Received: by 2002:a17:903:2c04:b0:28d:195a:7d79 with SMTP id
 d9443c01a7336-290273569aamr186999415ad.5.1760160151872; Fri, 10 Oct 2025
 22:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251010085827.116958-1-eperezma@redhat.com> <20251010085827.116958-5-eperezma@redhat.com>
In-Reply-To: <20251010085827.116958-5-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 11 Oct 2025 13:22:19 +0800
X-Gm-Features: AS18NWCyuXcACrW_v1qn4GL9s4-F86uKmBzdbuqiFdJOXV966wmVyHItVpmf798
Message-ID: <CACGkMEsUpg-hcgYGimL7Zs=yr6M7LEKrWRrruBcDU+0116hoaw@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] vduse: return internal vq group struct as map token
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GlyO2KOcf97SF68xrcSe5IYhgWZjys-AztVXylVFJPY_1760160152
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 4:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Return the internal struct that represents the vq group as virtqueue map
> token, instead of the device.  This allows the map functions to access
> the information per group.
>
> At this moment all the virtqueues share the same vq group, that only
> can point to ASID 0.  This change prepares the infrastructure for actual
> per-group address space handling
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

