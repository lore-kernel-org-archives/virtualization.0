Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943FB22A4FD
	for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742504219; cv=none; b=rvYyO4kRwgmZa5Cvn9pmtYtoKwk3AnIerq0PaqcjMgUVuPHSRJXf1BlTeXqJ3YU6PMKorv12Yb201vx7gZZ9qKNdFYAEZQgSiU1W+HYbhdfLzYONmwRDzKAe65HxaENPBvRD2C6FQR5r89mHs9k+QhuRD/Q+ABPZNIWXdIune5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742504219; c=relaxed/simple;
	bh=YbkcEp08crIyVSJNAbnRj22WAOqP2FQy1uoUXoMkAOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGPhbS+t9LTF2Xn63C/M5E7z6bL5I2z4W0r+FJIUpMuPuPp3K4WGdZAVIGaYC1Dis6EsYX8LKRBH1n1pQz2cRr08+rwFHALu1MEzQWF6SuMZrF9Qc+pHJGIHVHuu7yX7ayRO+V7FLHdKF9rm9h2663dD4T2Jy7nxrVX1zzo/YSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hF6oo0J8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hF6oo0J8"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22349bb8605so29354395ad.0
        for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 13:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742504218; x=1743109018; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eHYP+FzwYtTkT6zfxoUjmlhsBz/CXrX0uDvDDrwF0V0=;
        b=hF6oo0J87FSx75HsFfHT2aGc/djm6w9WoPxEnddzS3It0wWrjgBfMOBCD7oVRaRmxa
         kz0gbwptkPuTvxBaNftEYf1p7sAnyPpdWrRdkNj2UUGwScujjMUro9KVv31EWZbfEZ4Z
         TLxyfHf5d/Rdwek8QqfEZ6T/M3M3iCUQ33yAoyGae4gfvYmsOZv3gcxfCBVp5HfLz1gN
         m+lQ97/7Zovu2pa2EKHTV7G3mXmGwE6/LCmF50wKk2t0kPhLIfxl5LQSjo8NGiKPv4vM
         qbi4qCOFtjVPjgW+S1x2AAwwLOys3DRyMk2AJ6xVgrEDtL19vzp+1LDX//P8fHXcG/fb
         L3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742504218; x=1743109018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHYP+FzwYtTkT6zfxoUjmlhsBz/CXrX0uDvDDrwF0V0=;
        b=t+zVaya7BsF9YHHV+CVlwm5eBR5JhMLyVb6ghGn5i0m+PHH6GpGFz28K6JkpQvGGZO
         JoAUjsQxIn5gLj3M9GwYJfl4QXi2yMy7g0BEcaur5VClsfzmIw7ED3qe/h2I406OLev9
         SXo07bqDfjMXoLYiteo6ebeJQzy9LY4SbxR1CknD2EhJCG/t31NukXZ6475/lGlqVRxb
         Yw1Cwz4VTXH7MVeszhDrINwjM5gr6ITSLRgcb/mxW9s0s20cTGqJGoGZOFev/zxw+xyw
         THYdHGj6xSelrNMayjn01am3RUK3COve/bUbovWYyYwfWSZbzb6ey3FlS98zkgqPMNJI
         PQ/w==
X-Forwarded-Encrypted: i=1; AJvYcCVIQz9vLO7Wq4EvznG6E/VOWdBBUK4dxcvs47kt4G+1EexjvCVJbfGhkt0T4LnDgVFe8+DM9qXy2Nim2ERLOg==@lists.linux.dev
X-Gm-Message-State: AOJu0YygdQjvB/0uzzPp9BP98bF9skhTJETUtSM4arOCzT+pYCoItFmS
	XVBSlNyh6eslO42xO5hZ+qIYlZq2/rD751MedtVRzTO1JReQS5Gf
X-Gm-Gg: ASbGnctBHCCuCuxlbgxyOt3TWKoDoOOownnOH5s+lIzKu2rRp0rZC3V6CFGOwgo97ji
	MHR7+YCewMCc5KuAyZkT4sNse9mThEFQFejcxxGsxLNuuSHyFz3otjHkS5mGeoDlRFiEfR2z7OF
	qtyUt7JeO2PBeh411RMRzl+lWxBSLK8gu/nO/g0XMVMQbMs2bmAWo2sFXehe3iVVG2YJRvNmTHA
	GJJ1RS4m/pTEOym5FVPZnSNKwoaQqDwqqWqDKW7bwlGKgc7aBnUdRASv8DSCUO2J6sa7s/HGnUE
	U6vOFuTSI8t9vjEIMXM2oJKoyHcOG/aYZZy+ngKFucwCM5mOC0SYSZc1qpanDZhRXw==
X-Google-Smtp-Source: AGHT+IFObV1UYBWVHJijbUkAFQ5WtUBQhMfiBb9p0afEFRGISPI3ams4CTR87ewzq5lhgqlJcABDfw==
X-Received: by 2002:a17:902:d48a:b0:223:2cae:4a96 with SMTP id d9443c01a7336-22780e3fb29mr9391595ad.42.1742504217670;
        Thu, 20 Mar 2025 13:56:57 -0700 (PDT)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2278120981fsm2384085ad.250.2025.03.20.13.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 13:56:56 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:56:54 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] vsock: add network namespace support
Message-ID: <Z9yBFrmGLdKzfgBd@devvm6277.cco0.facebook.com>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-1-84bffa1aa97a@gmail.com>
 <sqvqvlovlxpfo2tlkazugkocwmlhc7iay2kvq7b75bgwk7vhfw@tvgfe5fj3mw6>
 <Z9sUVs1Tq3SN83MQ@devvm6277.cco0.facebook.com>
 <sarbzv7tqaljonkuerlmirulq25ouk6mwyfbr4oaqfzfry2kcm@efbhpxgpxikk>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sarbzv7tqaljonkuerlmirulq25ouk6mwyfbr4oaqfzfry2kcm@efbhpxgpxikk>

On Thu, Mar 20, 2025 at 09:57:57AM +0100, Stefano Garzarella wrote:
> On Wed, Mar 19, 2025 at 12:00:38PM -0700, Bobby Eshleman wrote:
> > On Wed, Mar 19, 2025 at 02:02:32PM +0100, Stefano Garzarella wrote:
> > > On Wed, Mar 12, 2025 at 01:59:35PM -0700, Bobby Eshleman wrote:
> > > > From: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > BTW, I was unsure about just making NULL a macro (e.g.,
> > VIRTIO_VSOCK_GLOBAL_NET?) instead of a function. I just used a function
> > because A) I noticed in the prior rev that the default net was a
> > function instead of some macro to &init_net, and B) the function seemed
> > a little more flexible for future changes. What are your thoughts here?
> 
> Inline function in the header should be fine IMHO.
> 
> Thanks,
> Stefano
> 

Got it, thanks!

Best,
Bobby
