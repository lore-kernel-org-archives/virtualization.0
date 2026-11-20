Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166365;
	b=sCmEf11iMHiEApGxc9s8zIAHKgGntM2tbUQOMYDMpQPdyHe7xGI67bJ1IVkVyz3TF4qD
	 SNRIJwcOPZLlPHUB4YJCNVH0tyzRZKuFNZTcEPCbDXZD9xOM77mjnBGoAd2+H9j9IbW5Q
	 yA8Z6l65bHEYwmxaBvPe8Xiqi+V+CklWc+MGJHYm73ftD14SRAWOlPvEdwkCH6FtaG5tN
	 CaVtD/F+IHUVkZWBAqykQZ+HuXCpId+VZvZFuDHbU4tHIjE8Sm8RIEJBFVWtuk9uirE8d
	 SvGSoZ/g4nMzTx0LMSqrmk26CVilQ7HKdChbqy7spV7Y1U4SWMdG2F1bDwnlc8iZJgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=NXbyh/zLUD7PEdLtCVAgHutA0kCgtrDRw7/iSzMTz60=;
	b=FUIw+T/ajZAsx4tkESA85IMwG/DcRhlYt0tkuLrZ5xw7EdGPK+8iSsz1uVcZeU69bi5I
	 Lvv/Vb5Z6ggnar4YjS9l+InNXE22Y2sxU+6siDgny1bMv+kJO0np7lFKb2WxdyOEZVwGW
	 7ut2XM2YoI+hMu6nmzOxDqyZQ1NjBIzLePrT9UvG9Hfquj7GkWMEJsDH0hNAlQTgh65DM
	 0HS7QbimRl3CBziK/L6cNfcyNvBvHVtmbKVuyq2Z4AHAJ5bff38YH6MtqVxsP0rk/sT6L
	 6JUcmvCZSj5v/DHNsth/mf9vq3G0iV1W7tGhVUOhrViDIq7Lm0g5H351DGpixmXTdLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Yr71gXJQ;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67132606A325
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 09:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67132606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Yr71gXJQ
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso7014855e9.1
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 01:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795166364; x=1795771164; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NXbyh/zLUD7PEdLtCVAgHutA0kCgtrDRw7/iSzMTz60=;
        b=Yr71gXJQhbWwmCDDkDdIcp3TsTADRMJyuWataLdALNWWOCBbfstEoDv61UEkog5MbR
         b1t9saCyf5PyNAG4AGvwGY33toLxkyQGsG/dTN36lO2N/e0ULkSkV1KpDTxJq+bDMe+j
         Xto8mduggMtuxrkGmlSvnyTBg9dnCW/O0NdXBVjsCwSFudKX3arQ+agyZXqIQiPWoiX2
         A4bJl0to2vW98Jz+MaeteCDFB7fFWuuaaQdXs2PlgM33ab6E6mrO5Tb443z+zU8ICF0U
         SLwGPRkB5GmyWCdPR5QTK8vnLZhkX7pEZLtZxq0D86lB3F2MVjFgNiB0BkfbneDk6pBZ
         +tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795166364; x=1795771164;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NXbyh/zLUD7PEdLtCVAgHutA0kCgtrDRw7/iSzMTz60=;
        b=IlWE3sSANRqcCuKHv1INofasFAqMU/r+i/4r9vP0DsbGniJ+TaO4/Ligr6JGlI/IXt
         E2xbQhLIm1w3PMo93XynBAaa43tO3Oq9kIcYO6Y33MM3uTOvHda9MjZMEzQvorRWqfF1
         /0XK91x5FNOiLAfTYBEWjGh00w5ng36B5lwlgyWu2NZVrM6scBNS0X7o3e0uepjtq4Z8
         Tu+K4CHFwAEg4GfCkT/wAbKWJmlagXzZm+z5apO2y7nFVaUpztUOOdzic2tzH4qn+Md2
         LouKhnIzHMfVdXLJ8bY+mMhFmvxF3QuCzG+oS/KLwsCSFMPGt7tmvRtf6B5LQZfiPMHi
         mEFg==
X-Forwarded-Encrypted: i=1; AL+hErFVfQwFm8f5yUuRefwTche5EjJaQm04oLZM96dsOS3pc8EMNdcmMr4oJlwOnEFwcJOnbZE6Jadit55kjunRZA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/YkL7H6hDEbPrR+Q9jRwfiN6zGZHXyZwJiPVEwyMDFH+FAf5cS
	Yh7VyVzboyGNyvlguULailtC1a1A8aMwCGW89nDcJSVZqqgi8iaExUhXsgzIpAg7t8g=
X-Gm-Gg: AYBFou3x6mqKrGVCL5vOoA2F2dY83QJCun82qeij1CWjUZbLOSrVcuogAYJWYHkYcFA
	up8wk8mgIAIDxWEezHrdtinksQlgZidUZ05/+u9QckBqKscPoexCogCbz2k1EgB2QsxtJd3rraq
	VotpgBD6eNEbp9R2aEl5Cf9g0bhv/ys4WPBnuWnJi/KICcXGCbSTHyawjzvHr65SWFGKfqrMJAh
	crKYd1cV9Au8OXbwCZtkluP32RAbmcr4zZfORAvc63hh6ujUMCc7Gq9fvVvacq2UFhj8K6nvCQg
	m7bHxLc270012ZtnwSfdbBckyvRD+RNBfPyKDgTmqLWkVRJVGkhgl7/KnRGYthF+ctv5wywQZzp
	ACPYyiFShbi1zfsGqCj+CvqclWZoD/C3SqrMoaiPwf6zVm18evd67q2kEeGapyl3As1orlRiJgI
	aourSMBQF/rvYfyXsAlCj+4XEDP896YT3q5EzdURkAM55JqTkkdBtaYfWUv4GWifGzRZYQyii9j
	SV5Ik/mGQ2b1w9q9dSALPdGd+2YUEIAvOBexnG59FUx6O9NEPQ1jIDxHM1ERzAVVfFqWQYam/2m
	KwFspQJt4bxJPVzg0YKv
X-Received: by 2002:a05:600c:530e:b0:4b2:2ec5:8a2b with SMTP id 5b1f17b1804b1-4bb887fe8f1mr53972495e9.10.1795166363741;
        Fri, 20 Nov 2026 01:19:23 -0800 (PST)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88f643adsm27023055e9.1.2026.11.20.01.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:19:23 -0800 (PST)
Date: Fri, 20 Nov 2026 10:19:20 +0100
From: Petr Mladek <pmladek@suse.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>, Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
	Joel Granados <joel.granados@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Bo Gan <bo.gan@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Ian Forbes <ian.forbes@broadcom.com>,
	Bradley Morgan <brads@mainlining.org>
Subject: Re: [PATCH v4 3/4] x86/vmware: Add the vmware_record_panic_msg sysctl
Message-ID: <awAQmI2wu0rI-efH@pathway>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
 <4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com>

On Wed 2026-11-18 01:01:50, Zack Rusin wrote:
> Allow administrators to disable host log transfer on ordinary guests or
> opt in on encrypted guests. Expose the boolean recording policy through
> kernel.vmware_record_panic_msg using proc_dobool(), as Joel suggested.
> Zero disables recording, nonzero integers enable it, and reads return
> 0 or 1.
> 
> Register the sysctl only after the logger is ready. A registration failure
> leaves the internal default in force. Document that the log is sent
> before kdump, and that disable_panic_notifiers_platform_list also skips
> it.
> 
> Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

LGTM:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
