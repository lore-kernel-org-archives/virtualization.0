Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D5333F8A7
	for <virtualization@lists.linux.dev>; Tue, 16 Dec 2025 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765925118; cv=none; b=ZeSYtHFxul7IrCzBOFtlt0jI+b7prat0pW3v/2r3tpi5/7O8ChVRGU8lz8sNmTI8gvpGBt+1MZ6gjeCgzDh1IF9PMg9hJG7nkeXE1fXrYX+rSdyNGhunDX31tfsXgF9s8u22jvbTLTy1OC7qlCUka+fbqTZ9A712IO4SIOZyH1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765925118; c=relaxed/simple;
	bh=3NEQ5V9RhdJFlg/bSRdDII08BAgyJYCFrsNJhWAbvGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgBPkxHQDOGTVx7hykdofvXnDcMclPGIwyEJGreAeiNXfdsWDLMZAY8+RiWV1vuKweZlzGGMt/V+QwPf073G0pHUvGdsBnAORxPetY4tdUOc1x8Cww0MQnI1jLKksFGL0Ryf00QhovWUvxkUpjF3UAwgGol6RA7GzxZ6crSInYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rwkgqt0z; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rwkgqt0z"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29f1bc40b35so74823585ad.2
        for <virtualization@lists.linux.dev>; Tue, 16 Dec 2025 14:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765925116; x=1766529916; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AR1JGVCrYOq5uwCMMI70hgFcm+ktjWSWnpXwIlRejaE=;
        b=Rwkgqt0zkRLhA+wANWMyHM+GRweS4Pf+L1vhWVzEk/sebVOkq35gUJi321MOv+2z8B
         iKEaaeXDOJMmTP6z/kHByJxv/HDnd79SLVcj3Ggsd5A4pc/eeyhU/cz3IRYLlRASqFIQ
         tn5qFp/Qe9tZiKSK6N2aZaDdYWGJsXYK7vNPGdJzmVnrie6zfUONU7oZy6W71TzaEFbe
         6Z1FJ7S5LKGjYUwIwtE6Ey0+8GsqXpVfVjIimyfkNcveMdQJ7gGu7INoahHIdeu/092H
         uBOKaReH/EB9RwhC81Od9ph0DugM06krhqdI84Bb8r1myOmeSYrYvad/+PPvlcbNIZKF
         2cHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765925116; x=1766529916;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AR1JGVCrYOq5uwCMMI70hgFcm+ktjWSWnpXwIlRejaE=;
        b=po9AFH6nek48lnGLRcHCW1ierQeYsUdeuI/eNIYLaTJ7+el2uA3gMP9vksXw1jDjL2
         SACFBpOsm6EUSjTZVKvmYWQih/DyaX7DjlczOu0sRRUfX5X7ScDUDx/mcGqCJQYGPpVI
         FZ+5TnfjhF59hZw8fIG6NbVo+tg2ShqPG9nu81rDnT9jJuqyrpJXs8eq03mHuPnGZ9dR
         yd4BQLOvSaymfxz2lNA0FMb3YvbYSA4rKDA+2sOmSOf0OdOX81Kdk9NxRnNG8DR0GHlE
         76IvHgrCRHsc+AhInVzFZ9BNa5ukEmW+GoT18hRQSGw4QQncV5DWvoBwgWJSvZAblPCU
         xq2A==
X-Forwarded-Encrypted: i=1; AJvYcCUcg4VEd195+WpgVmiRM5EMa+QX/wWWR9UFDMfQ1cIrbPN1Kc9fStqd89OwUSJ6Mps1MlINEs72Atws8jGUuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOR9YhLn6plGS3cA26ck2Cv1ZnLyRznxt6RwAotkRUrZZvXQGG
	CSAnIpixJ/xxLHOmV5pnpuoqlhbtplXszbmvHiOk1+LEG+oF5zj2i5+FY2gE0AhUanM=
X-Gm-Gg: AY/fxX4jPRBK2ADbE2VKon/heMu70z1AIZUoz23LIds18RugiXodO3kggnUoo0AwwQ6
	JpvDoHWfd0vTIgsQ+wosP3kQM+NVsNvhsq72Q+X/gLhQVMvmBwhthzovmMo3GiKM9oh/XTfJ+oH
	wYZh5bMqVX+HW4bv5AY3ZiD27TjohG/QVj6qZtE2VNawG0i3hh9Ncrbs51sYYUNQEP2+UtmxWYp
	D54dc13JqFlD3p/ceo/xB5LvdZc2jCA2pIkjl7utHbebtyRQHVs6i/PnbUBFeCDgBV8W4bwvQ++
	8Ir9TZZ5jL8eYVg+UJn/eyQUKkRwq4Gc218v0u/+/PdwDUPFc29OX53HNMfqnYJJJmPjkV6gOZu
	3xwDeSwNMSNjejB0tg6pPfCXJ836Jt+lk22a0vZROR3JOM4FEzCD8KRXsZWTEWgA0C523m61Ry1
	/fLN5jGFF56PCi7g==
X-Google-Smtp-Source: AGHT+IHlf022sKmg9PvWm1g6x5qCleg7CGbhTD0sTz9lR3tqhWCn1Hso1Ql/qQ0jJj968JLmuQBbrw==
X-Received: by 2002:a17:902:f9c3:b0:295:96bc:8699 with SMTP id d9443c01a7336-29f23b53ef6mr108947955ad.20.1765925116256;
        Tue, 16 Dec 2025 14:45:16 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:ba5d:91e2:900a:fb01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea03fa7bsm179137035ad.68.2025.12.16.14.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 14:45:15 -0800 (PST)
Date: Tue, 16 Dec 2025 15:45:13 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, andersson@kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, virtualization@lists.linux.dev,
	xiaoxiang@xiaomi.com, Xiang Xiao <xiaoxiang781216@gmail.com>,
	arnaud.pouliquen@foss.st.com
Subject: Re: [RFC PATCH 2/2] rpmsg: virtio_rpmsg_bus: get buffer size from
 config space
Message-ID: <aUHg-bN90ZPyZk0W@p14s>
References: <20251114184640.3020427-1-tanmay.shah@amd.com>
 <20251114184640.3020427-3-tanmay.shah@amd.com>
 <11280877-95f0-4361-9112-23bb17372e91@oss.qualcomm.com>
 <c5395ebf-b0ea-4be8-b0c0-6a51d4c98e09@amd.com>
 <20251203142540-mutt-send-email-mst@kernel.org>
 <d858a46d-e5cc-4d87-b5b5-8130dfd42145@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d858a46d-e5cc-4d87-b5b5-8130dfd42145@amd.com>

On Thu, Dec 04, 2025 at 10:55:10AM -0600, Tanmay Shah wrote:
> 
> 
> On 12/3/25 1:35 PM, Michael S. Tsirkin wrote:
> > On Wed, Dec 03, 2025 at 12:12:46PM -0600, Tanmay Shah wrote:
> > > Hello,
> > > 
> > > Thanks for your reviews. Please find the response below.
> > > 
> > > On 11/22/25 6:05 AM, Zhongqiu Han wrote:
> > > > On 11/15/2025 2:46 AM, Tanmay Shah wrote:
> > > > > From: Xiang Xiao <xiaoxiang781216@gmail.com>
> > > > > 
> 
> [...]
> 
> > > 
> > > Thanks, that's a good question. I keept id 2 unmodified from the original
> > > series. I don't know why ID 2 was chosen in the original series. I will have
> > > to discuss this with the linux remoteproc/rpmsg maintainers and choose the
> > > correct ID.
> > > 
> > > I don't see any problem choosing ID 1, but for some reason if ID 1 was
> > > assigned and deprecated (I don't think that is the case) then only we should
> > > use ID 2.
> > > 
> > > 
> > > Arnaud, Mathieu, Bjorn any input here?
> > > 
> > > > > +
> > > > > +struct virtio_rpmsg_config {
> > > > > +    /* The tx/rx individual buffer size(if VIRTIO_RPMSG_F_BUFSZ) */
> > > > > +    __u32 txbuf_size;
> > > > > +    __u32 rxbuf_size;
> > > > > +    __u32 reserved[14]; /* Reserve for the future use */
> > > > 
> > > > Should we use __virtio32 instead of __u32 to avoid endianness issues?
> > > > 
> > > > 
> > > 
> > > Sure, if that is the standard in other virtio headers I will modify it.
> > > 
> > > Thanks,
> > > Tanmay
> > 
> > rpmsg is still not standardized, sadly. It's really time it was.
> > 
> > 
> > 
> > Modern virtio devices use __le32.
> > Accordingly, accessed with virtio_cread_le
> > 
> > 
> > __virtioXX and virtio_cread are for legacy compatible parts of config space.
> > 
> 
> As of now, I am using virtio_cread so I think it is legacy compatible.
> 
> > 
> > Does rpmsg want to be modern or keep using legacy? I donnu.
> > 
> 
> I don't know either. This we have to discuss with the maintainers and other
> vendors.
>

I would certainly like to see a modernization effort, but it needs to be
backward compatible.  Probably outside the scope of this set though.
 
> 
> > Ideally it should finally be documented and at that point we
> > definitely will want to switch to __le32.
> > 
> > 
> > For now, run sparse to make sure you don't introduce new endian-ness
> > issues.
> 
> Ack.
> 
> > 
> > 
> 
> 
> 
> > > > > +    /* Put the customize config here */
> > > > > +} __attribute__((packed));
> > > > > +
> > > > > +#endif /* _LINUX_VIRTIO_RPMSG_H */
> > > > 
> > > > 
> > 
> 
