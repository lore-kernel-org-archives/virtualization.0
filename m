Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB0C1649DF
	for <virtualization@lists.linux.dev>; Wed, 29 May 2024 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966924; cv=none; b=EqE07ZC17lH3MzB9hg2Dn8DSgyWC9mVKtpBPo0ftP5jXKTEDfjPo7lR7ZV7z721Zh+drh6+x30AJhWAV378QiseGC0/+FH7Tas8acO1HQf+rMPsfzhoVmi4j0PnBdSemgag+0s10Zqo+GXXNISI4Vke6HVf9bH2Gzi8TmjP/tsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966924; c=relaxed/simple;
	bh=VM23rw6dU+frl/564HTXigSeDbMXZ1+KDQbkMYied2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ox3JsNRmtwQ+83ALS29J7pnlvqGIJI0PbhGfnGlO1V0X0506UbQgObGmwuQO5VrCbhQ3tSivsbrbqHeWb6eyL442RIw6sZqtYy346dCpXeA1m5Ng/v6JhhF7tpzYkxfvaZgnbIwqbjN+DDKBZFBoR/eFs0pnzuH0cAQuCiWSnB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSlZO8X6; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSlZO8X6"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d19dfb3dceso903142b6e.1
        for <virtualization@lists.linux.dev>; Wed, 29 May 2024 00:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716966922; x=1717571722; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGIkK8b/tRFkmBW8sJbMAhIfVD5fwtlLdHMjbfiTK78=;
        b=hSlZO8X6BC9ZVDrD4ixghnYQPcafKAfK+D4UgjJkp5Y/obvPdcybuAa6VMP0G6dXR/
         8NOwwi2ZwI6KReEyvPHXHceszjUApzYE+3k2ry7P1IZCnChB8eaUI7e+7WOYPEQufGBL
         Y6UkhnvaO8Da+6Nd+sRwiHVEghGzYO2pr06gMTbvBDNx4Oo0dVbRXUQNQRDK1y4RSPQB
         4xOhAsGtttHuHi6g+4wMQdV6acLymCY61i9v0c28uIcwrZuklu9s0Pmw1rB2/Q64O/P4
         XsQfY9Dt9vQT2FtngCewyRrDRn2PKFlTRtlXnS9oafnjITEgcQjGLyGZB93jOj09TnAw
         eAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716966922; x=1717571722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGIkK8b/tRFkmBW8sJbMAhIfVD5fwtlLdHMjbfiTK78=;
        b=XmrO75OXq/5RyJtC5FII0phql+BcgYmlmj334bqcvIr4uAG9rmyS8/fAjpl/QNm2oH
         UjIjONLWPsvP1H/D4zOm40KUtu7Obn9GMLaZebfPrSRjH3+Na09eG5NmSJQW6DOTf6u8
         Geq9X9oArC4Vm8pAGxGWvvc3O7Lbw3WWimtiE+7tK7gO91yQfGcaP3/B1OVMTjLtwDb1
         lw032MEhgZrvOuBrtNmHz6kYtx34g/wQeYmWkz98lPzvJkp/DCggdsY+C1yprccC58P6
         0qOSniLD43fyZo2pH/kOwB7U7+t5jIQLvJsRHNJZMAHeLbusrR6rEwC4pQSOOQZVHdGI
         oUxg==
X-Forwarded-Encrypted: i=1; AJvYcCV7x+I1CYB1m77DG/R3dJCG44qfu2hcFJbG/KBX30LxYoNeaIrh1s8TQdgeHm8J5fqGctTAu3y1BYV54xiW+bOyr0WbDERXfttVVesFwvM=
X-Gm-Message-State: AOJu0Yw0NSSDTUOsfAF80ko985PtSPkdnBKFz+t6N7HGz2iK90B/HF/6
	XVAmQHeOZzrK8mg/O+qAUOlm0L49pToaaNJjauWXQ/25B7HGRYt8
X-Google-Smtp-Source: AGHT+IFpgK5EbeZmdQsPAD6gq3FDM0KmWMgWUg5qm7Tlx36oZyOez4zO17hG2GaX6tAQPImObN94CA==
X-Received: by 2002:a05:6870:8a0a:b0:23c:5f20:8393 with SMTP id 586e51a60fabf-24ca1472b59mr14007992fac.50.1716966922495;
        Wed, 29 May 2024 00:15:22 -0700 (PDT)
Received: from devant.hz.ali.com ([47.89.83.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbfaaf1sm7449629b3a.129.2024.05.29.00.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 00:15:22 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: mst@redhat.com
Cc: davem@davemloft.net,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	niuxuewei.nxw@antgroup.com,
	niuxuewei97@gmail.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	fupan.lfp@antgroup.com
Subject: Re: Re: [RFC PATCH 0/5] vsock/virtio: Add support for multi-devices
Date: Wed, 29 May 2024 15:15:13 +0800
Message-Id: <20240529071513.466374-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523104010-mutt-send-email-mst@kernel.org>
References: <20240523104010-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, MST!

> >  include/linux/virtio_vsock.h            |   2 +-
> >  include/net/af_vsock.h                  |  25 ++-
> >  include/uapi/linux/virtio_vsock.h       |   1 +
> >  include/uapi/linux/vm_sockets.h         |  14 ++
> >  net/vmw_vsock/af_vsock.c                | 116 +++++++++--
> >  net/vmw_vsock/virtio_transport.c        | 255 ++++++++++++++++++------
> >  net/vmw_vsock/virtio_transport_common.c |  16 +-
> >  net/vmw_vsock/vsock_loopback.c          |   4 +-
> >  8 files changed, 352 insertions(+), 81 deletions(-)
> 
> As any change to virtio device/driver interface, this has to
> go through the virtio TC. Please subscribe at
> virtio-comment+subscribe@lists.linux.dev and then
> contact the TC at virtio-comment@lists.linux.dev
> 
> You will likely eventually need to write a spec draft document, too.

Thanks for your reply. I've sent a series of RFC documents for the spec
changes to virtio TC [1].

[1]: https://lore.kernel.org/virtio-comment/20240528054725.268173-1-niuxuewei.nxw@antgroup.com/

Thanks
Xuewei

