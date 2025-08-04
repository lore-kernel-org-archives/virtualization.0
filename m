Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1881246799
	for <virtualization@lists.linux.dev>; Mon,  4 Aug 2025 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298374; cv=none; b=kbTo4qU6YRWJlFk3RkQYTVx7hXkQq2Oddc+CrAu7j9r8Do+ICNoBoJAXJMYthm3/oyvjiGU5NFH+5zfXAezAIbZ0iLvVKvFPK2hftllDnIx+DdDci8OLELHTRp5AXM14lzPXrbNHRqTSoXN/6Cal0YSuCHAJJUb1rKGLayR9DPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298374; c=relaxed/simple;
	bh=FC2gKnlK0tlH4AVIjMhG/aH0ST923yLbY61/gTdaWtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTwIGtJbEVYDeDpFYiYXP3G8/QCbQrol4nxHgFgeWq18B7YXVYYreiP2pK3uth9tbmg/urgRq9eF+93AIE2BWTnWsVxjoUkWdYKFcxeIkDN8bc7BJq5qk15H8PGwgNYl53NeyCRQRSFmbIQ/bJlqIulN8eP5/JJ5/OT3h5DJFPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LN0P8mM0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LN0P8mM0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754298371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FC2gKnlK0tlH4AVIjMhG/aH0ST923yLbY61/gTdaWtU=;
	b=LN0P8mM05fuXxVG3KM7mnua5lUZVv3dAPqEojOA+pleWq6Ec7Hr0RCspmUMKJ1NvW4ZNLS
	7/LnuqrwNV+Ws2s9TDhtGMsMVz1my3B2taDjw8+z4HpiTkcA1LpVsX2SfoF/XQMR+ioEXI
	g0VUT+y0fwiZ6JzPcvSy2PtfwrLcHto=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-UB2N5FlDO4-BNornbo-t3g-1; Mon, 04 Aug 2025 05:06:10 -0400
X-MC-Unique: UB2N5FlDO4-BNornbo-t3g-1
X-Mimecast-MFC-AGG-ID: UB2N5FlDO4-BNornbo-t3g_1754298369
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24283069a1cso140425ad.1
        for <virtualization@lists.linux.dev>; Mon, 04 Aug 2025 02:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298369; x=1754903169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FC2gKnlK0tlH4AVIjMhG/aH0ST923yLbY61/gTdaWtU=;
        b=YwEp4RNn21voxmCKJZfGy/z7ntvSTpeTyGhc34af9YmxRlyBbkBLKvBef6Xu93MBzd
         rGaaJkVLAQP5sfe84rdH8KnS8b/oP0wVsupqhO7mXzr8dQ+h1xHnG/eoUPsylBlXZhmZ
         dMgA4hNwcxRMXis/kgYtqilYUZTq0RWZLOUqk540UknuL6MsxAuL6th6GiHN3GM4fuk5
         G+2qbs8JDJWOOLNMKgwGWIBdYUqkc9myU1l2wlMxNtP0WK4a8IA7lmjsTAmtB/fVkHI5
         9cpajHklPoX697tH5FkOOxN8ggP6I8ySSJ2okMD27xJUOnKsX5vtTZYp/lUEJQhdJmnz
         IydA==
X-Forwarded-Encrypted: i=1; AJvYcCUlFkhVHEwHFVHMDEyYhqorEScBHwIGSHLJS4R2dYMEFhk40z0Wsayzgo14mzizwC14/svLxBMBjxjAcpPmGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoCtxQIClB6aKd6yCxr6RnswDT51gsomtjVDjwbY33wmUcOqVu
	i0opaitQP7nf/s6fWhzUBe2If9M/55Qo8JwxZHHkcLCb/rU4CFotwj529tQt/KB+BXuIF+MoyH1
	EOrDoasGLyaSTLrJRBQoLGclOpQF8909fHzz4HptVJWoYcGPTeKOTOIFpscxFZ0kDwLFTbMVyCw
	bWqkVZas+KxmNp7Gtc5nnsqqDVyY3jCOEladfCzFPZT8Y=
X-Gm-Gg: ASbGncsvYz0i1IrOdA0Sx7MFH/4ngkSeJ5ztmLopMbmk582Gz8Fe4ZvwZozO2Vd7HGh
	hUx7Kx0LAKORdfVbIoblOHbSlp4wVo1b1p7gYunXU+ojCTX6EaYtDQBhhp2yA30CHObCqXkTynV
	kX4kpqgteyflDGrlwiBpoIaA==
X-Received: by 2002:a17:902:f552:b0:23f:f983:5ca1 with SMTP id d9443c01a7336-24246f5dfb2mr132550155ad.12.1754298369517;
        Mon, 04 Aug 2025 02:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEcYXd+G3MrEs13nVvxY8yeK+0iPt6uzM6BT+j7IwyIkqouuxJCmX+aT/C268Bf+EzVOioFJTajAeAVP8Oj2U=
X-Received: by 2002:a17:902:f552:b0:23f:f983:5ca1 with SMTP id
 d9443c01a7336-24246f5dfb2mr132549655ad.12.1754298369069; Mon, 04 Aug 2025
 02:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250729073916.80647-1-jasowang@redhat.com>
In-Reply-To: <20250729073916.80647-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 4 Aug 2025 17:05:57 +0800
X-Gm-Features: Ac12FXy2PpNcxx7Wuo6WWD9onNx5D2Zc4zo6EJWLkWuf_3KiHYfBpugk7fN5otM
Message-ID: <CACGkMEuNx_7Q_Jq+xcE83fwbFa2uVZkrqr0Nx=1pxcZuFkO91w@mail.gmail.com>
Subject: Re: [PATCH] vhost: initialize vq->nheads properly
To: mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sgarzare@redhat.com, 
	will@kernel.org, JAEHOON KIM <jhkim@linux.ibm.com>, Breno Leitao <leitao@debian.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QvDmYJ2KJNE6Xd9zGQtgAjls6g_pU1K9-1dgVCBDnhs_1754298369
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael:

On Tue, Jul 29, 2025 at 3:39=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Commit 7918bb2d19c9 ("vhost: basic in order support") introduces
> vq->nheads to store the number of batched used buffers per used elem
> but it forgets to initialize the vq->nheads to NULL in
> vhost_dev_init() this will cause kfree() that would try to free it
> without be allocated if SET_OWNER is not called.
>
> Reported-by: JAEHOON KIM <jhkim@linux.ibm.com>
> Reported-by: Breno Leitao <leitao@debian.org>
> Fixes: 7918bb2d19c9 ("vhost: basic in order support")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I didn't see this in your pull request.

Thanks

