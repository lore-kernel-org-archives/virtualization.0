Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136C2221F12
	for <virtualization@lists.linux.dev>; Sun, 28 Dec 2025 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766944787; cv=none; b=DWxO01SVNO2M+f7K6+96VO9IfYYkva80thkyC3hgT3zyZojWpzkm9SZULCuYelqIj01bL0QqSZltn/Vp6kTxmhn4T7VN3sloJVHZycLIcNImLCxTcRF6h0YVLZHsjLS6S5MHRErtuueE8jmjLAkyLlAJjmSNjQHzVaNKglp9Uw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766944787; c=relaxed/simple;
	bh=ABr9QuCuFpvVEjGLA5zflWNdvKSNMSKsOWE1W8HNYzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rV3cf/bxOmWQynP7tBzjv/fTqpypSINz8eH0+CDT7cMbIuvvmJkJxtVIFrAEvbkCD0W8hn4exgCEmB+iOTIfkbiWPLACe4ahoY0CwE599qKiWJZolVHl1gQyBke4SH5QArpuQn8bhkrSY6imWNov6oiv1+g/K5yt6jitbIOPzfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9agbdIr; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9agbdIr"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7277324054so1347973266b.0
        for <virtualization@lists.linux.dev>; Sun, 28 Dec 2025 09:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766944784; x=1767549584; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V/ARQOXIbK4vcozFQlBAvDR8Ur22ZtFHr6qerGT5Zz4=;
        b=I9agbdIrEBxNBN8NmPOZLDuXUpKMjMdYKLMthNB/gF/B5CM3Pr9hjXxk21gsR2Z41D
         0OFk0jH1UizDNJRqGc4i4kKSCgr4yGqJHo1jwau2+Q3ZIcrkpwpvNMOFMB1XoG/8e9WO
         S/Jmw3ugkv1tH5jAaVOPG0MSLYH059As/le+glmBBIQ7hiXRxu8c2S6r/Aq6nsUYGfbN
         n+tanp0500ljTu+OTPrFxwfEyyxtuCdheQtNoFHzhlR+3hbU4tGzCeDmMxiW6DCM22d5
         91yB9oxybANzfafaRd2SpcXbBT8Ro8G6nP/ZgVYeMVVO7WXXeZIKCOT76tDnjUpjJqs8
         QMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766944784; x=1767549584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/ARQOXIbK4vcozFQlBAvDR8Ur22ZtFHr6qerGT5Zz4=;
        b=CRsfrPBxEMY4HpgKa+AfZD7oY3DFLXbUHLdNZ1kZKhEPmuxhzaoetoHvVT32Tk2XLH
         uAEgY171rfjVpKx0bvNz1d0vIN+t+ZTmg/N6Y8YluaZ/UK1orvazpCToOak8pcgPBZ2J
         1xpJeWXY64t9v6G3rPZ2QKxhst80e7yHc+cYNAhQejMycXuXgS5z4HuE1FzX7YeWxE6/
         XJzNSFGeFVphyFITAmq+RFi7+9d9Ie5/jZh32hZuAPdkNYotPzSene2VGF3E+9nZHm1K
         z+fyT74HBIZqYj8PGT1ZdQ4yG+My5p83e8XTTD+SfUBfOcU7i+fdMjqvvIyUhimpuShC
         DlbA==
X-Forwarded-Encrypted: i=1; AJvYcCUaqtycrCxEBG6EUNYn7tH2iw2QHqnllEdoezsW0sskPOuZvAra8OySaCyLJpufK0t3XeICN/quIoffUkG2XQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5bayx5Lrvv8NvXIhcAMIlbDDLN8RntoMnEOnsq+846hn2Ddvk
	i9kU4is1OfFsCerjMhSdeLIvA4aimfBe725Dv6gKIDCSCE250UbeTL1svw/t0wuL7tb9c++tZju
	XA2UTr3TW9Izzr6Tkgo6GDg6+R5yys/I=
X-Gm-Gg: AY/fxX6G50Ulwl6VC9iufmqYm3dhBb30zgVu/1A6wBIK0qd4T2KE/JSY4qL1P9am/1w
	BDaN+mThCJQyQwocR29PKHj0naKL0NF6+YmwMlxcpjsRywUqyDFFZlmpbPSEF2TeUVjJoj3iolX
	st6KZJFD04e7o/8nI2dJBloh3qbUEjYDdOQGO9+Y0sqIHLlTqlT3uDO2UkeIJ3psQAk0u6C3Ssb
	8hLL2MQHGoCxDXnBc178UloSXVCT4GhuUoXUG93llAwws12wlyPCXWMkfONCMGfBzzZBj/udYgP
	NNJeu07bB/gm4sOLc75bmg2KtnaWwxw1Myc7+94zZVUFpriW3+JG7e92MFR2XQ==
X-Google-Smtp-Source: AGHT+IEjpKXeQCELZ0y3D93JccaLcbcsCsJMzBKlzwHx4rSSOF4PpFJWw69I7R6QVlfuHQJLhsgZt18C6Rdh7uTf/2M=
X-Received: by 2002:a17:906:fd86:b0:b7a:615:75aa with SMTP id
 a640c23a62f3a-b80371a3a86mr2951475166b.42.1766944784132; Sun, 28 Dec 2025
 09:59:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251227174225.699975-1-viswanathiyyappan@gmail.com> <f7840b22-38b5-4252-9663-4aefb993b211@redhat.com>
In-Reply-To: <f7840b22-38b5-4252-9663-4aefb993b211@redhat.com>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Sun, 28 Dec 2025 17:59:32 +0530
X-Gm-Features: AQt7F2ppih5Ccj2k4B7ak3uDByTwQEcqT1aY3KEaxGLvP0C0cSGUUvKLxXP3Hv4
Message-ID: <CAPrAcgOaEt_4V289tiab2T2B7+A9PjizXMPjGL5ogWhNc-MR3g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/2] net: Split ndo_set_rx_mode into snapshot
 and deferred write
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, horms@kernel.org, andrew+netdev@lunn.ch, 
	edumazet@google.com, xuanzhuo@linux.alibaba.com, mst@redhat.com, 
	jasowang@redhat.com, eperezma@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Dec 2025 at 20:50, Paolo Abeni <pabeni@redhat.com> wrote:
> ## Form letter - net-next-closed
>
> The net-next tree is closed for new drivers, features, code refactoring
> and optimizations due to the merge window and the winter break. We are
> currently accepting bug fixes only.
>
> Please repost when net-next reopens after Jan 2nd.
>
> RFC patches sent for review only are obviously welcome at any time.
>

Hello,
   I would like feedback on the design of the cleanup mechanism, i.e.,
the members deferred_work_cleanup and needs_deferred_cleanup in struct
net_device
 and the functions netif_alloc_deferred_work_cleanup,
netif_free_deferred_work_cleanup and netif_deferred_work_cleanup_fn

  I will resend this as RFC if required

Thanks
Viswanath
