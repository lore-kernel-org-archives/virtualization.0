Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3482134A31D
	for <virtualization@lists.linux.dev>; Tue,  2 Sep 2025 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756836636; cv=none; b=aXaCkb88merVcAlUpA8TebPBNI4WEJQNUH7943l9Gqwr7ukg/rNjQZjLXu5iH0Eg909Csu6fu3KSJTH6VjYEr2HZrSV8Wc+5xueDBxtPxhoJyvr7mokArHNlEIk2QOMOPZW5GrrD0Ak611St98bM79KwFypwPhb0vkkCBwESuGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756836636; c=relaxed/simple;
	bh=mnD4JRGbk9W/QM5EuH31k1b1ffUiZwbDvhrc0zl10ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Si6vr48T8p3IxDtRxqrIbBCFsF3XCBcrKqC6WROeGdFcu5gMW2ogpgLxpVauyJ3jzOIWzaWvZ1pitQPPar4ohNnbqw0B8rUyKA9JocflrEdAgF6E5nEOh0jpk9C5kinHE/L1ifLXGy5CcJinCjj7aBSWhY94IWjJ6d4pY1JPDks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5LbWSba; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5LbWSba"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4c738ee2fbso4389107a12.3
        for <virtualization@lists.linux.dev>; Tue, 02 Sep 2025 11:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756836634; x=1757441434; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=11SI7K2HrD1Xkcfg4YipKbfNlLrbJJRsWjUQWdPP85o=;
        b=k5LbWSbabSi3jUvPu1CvlVNK0vN0E8KQVszAu9ihs8nl3yxD31YsxlFbn/rbaLQZ1t
         R3N+Eqku/gcHLUq1f559YRPtJjeRvHP4OWrnsVrUo4hi0aqixAmku37REaCckGgmtC1N
         hsQf2qaZWKHDqgS7uW/i1g15+Tfe+Rv0SHacGNs5efBS5au55bhYTAO9ZEL9mDx+RASK
         ly8TWeGZLYWZL1OA0k1ro6K4dPm/CNxmhIxiKOVaiU6GvmBr60se6Dbjv5AUagPvpr95
         htuzl4eRX6WEbV7cidr/zwjhmYp5nWput37QLvIJ3jm8g7F5LvtRtYMIWGklrRb2zejW
         wT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756836634; x=1757441434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11SI7K2HrD1Xkcfg4YipKbfNlLrbJJRsWjUQWdPP85o=;
        b=FY/yN3pfB0EycRf6wvDcvfzBH+V60r0PyFT2Wlv0NWJUZjlWTXkpsxWdDW4+1cWyET
         v8rqmO6R8u//FyZuN1gswksMLao3ddEKfichYlX3NPogFfCbzWP479rkn/xCVGVR+3aA
         Grvarv9e4acgILJcAle08ahq0UPW+0kL94A+MPmjb0h1k3dy6jsW7FGf197DIarzTFyF
         q5rBqUQy68Tm0xhWjyusFyOjmdzx30zV1VL0PIyay+yQuQCXxuC2xjSZkPik5paL37ki
         67fV29deKtRFpP8Ctb3KhTKFXnp2w8UO7EwkD5I2xeUJ+4T/3SgYHxNoIAlxaMLRZK0x
         2efA==
X-Forwarded-Encrypted: i=1; AJvYcCVgYWaJ7BPOiIyYmmqj/zSD3K4zGzZKpZRV2sPdmWHm7egLTbGtkMKC1+1AHYT8cA9bOVsh7NmJBoeycajxRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOrcUbuiIuTiNn5BB7GrhhGbhq/LWKLcUuqlJSXRlhrzB8+Vx9
	fm9EN8we7mXxUZYVs61V6N+oPPcEtdsLtrg0D5t2rUwehuEjkrqwLe5n
X-Gm-Gg: ASbGnctlDSh5mSKL2tGhLnuG6NTVG4S4E7S46p+QlVPLBP5VfYLYp1z4Bg/S3QbuJs3
	cjeawfpdVIjteTogloQpoPY6nDRKnb0HK6oIWZkoYdOZ1nCAShJnfo1E/9cV5KkU0o9sb+i4aJS
	kcO8yQgOrQXUsMIG9v/IJ82uKGYMFUBj13yv7M5Yxh3O07nPltfJc2mod/11UBqbrp6qturdKhe
	ywZDq4VdCb2xPFCySspBI3ljVlYO+UfbepdA1lvhZNYI4mjygiDiV2wWFVrkm/Pc5jS6A4TiKSX
	fVCODpnd9lbNBIzFBzjxdhXf+A0EebXeXDRLpasSwuVxr1qagdKd0k7LWiHwN1nSHP4EpU+1pvN
	M5gY6R0tCiECZnhZFAesBLRD9cweIF6GDWIwKK5wxvBU=
X-Google-Smtp-Source: AGHT+IFi/A5kl+CSm9Pre9tgHAXuj4Y9/s3vbKAIdfdu32Djhb4qcTMLMePJS7ddZUuOGxsxTT3zRQ==
X-Received: by 2002:a17:903:230c:b0:248:ea98:3d12 with SMTP id d9443c01a7336-24944acc7d6mr170727225ad.40.1756836634401;
        Tue, 02 Sep 2025 11:10:34 -0700 (PDT)
Received: from devvm6216.cco0.facebook.com ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b2570cfb0sm18256955ad.139.2025.09.02.11.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 11:10:33 -0700 (PDT)
Date: Tue, 2 Sep 2025 11:10:31 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 9/9] selftests/vsock: add namespace tests
Message-ID: <aLczFwjAClnFvANG@devvm6216.cco0.facebook.com>
References: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
 <20250827-vsock-vmtest-v5-9-0ba580bede5b@meta.com>
 <phckm6qx2drazblg4fsheqe4meg7likmvhbyquffwct4xj35ub@ddz2iikovcq5>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <phckm6qx2drazblg4fsheqe4meg7likmvhbyquffwct4xj35ub@ddz2iikovcq5>

On Tue, Sep 02, 2025 at 05:40:38PM +0200, Stefano Garzarella wrote:
> On Wed, Aug 27, 2025 at 05:31:37PM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add tests for namespace support in vsock. Use socat for basic connection
> 
> Are netns tests skipped if the kernel doesn't support it?

No, will fix in next rev.

Thanks,
Bobby
