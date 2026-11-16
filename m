Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827834;
	b=zGXeclOSsLqMbF1nRzkOR4xxukezRDTiKaxINt7BfHYfmD3UHynUJP14wo7WuFyIkqEL
	 C8oORICWKRWwcvVqlTFGMmv0/J5FtM6Mr7AYiZ/Nfe44TIMv4egVrIN/eMp9Kk75hxBLF
	 2BXspGFM9fFATofjra5t+TlHckF7HrPVkKgg8xFKgZZkvXhgVclRxxbCOV8NIgoUn+c39
	 ISAEvIwgKoxIe2GW+yl4BWsXwxy//Gd3iUVAJXQ2lSNRzte13qKgkLTxA7pUOTegwvbgY
	 LqiURPdAAXCYyuAjCoHOM/zKXjwWWxY91HjWOV8yy9zRbpIzPfEKozu47GzV1OMDqZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ITw6ygw2AXNWGd7QRacWknaddhmjMVGAScdWdo2ralM=;
	b=L09A3pSLz9ecZtVBzUipFTL/VPJUmBgr8JkZ65SOICqi+eR3L9i8V7pwpmKICy3+E5id
	 r9n3bzDZK9lsog5mxo6QhKOb9aGAdf3bs4Mxc3ggpkx0+dwTtCcZ19CI7XAHdN1WxRaBU
	 hhDNjFNWh5o8KgeXEStUGeyhEmGaJmJ8mZ1cyFt9Wg2l7vIgsxJiUAzesPdRAT2iLlTnn
	 AWnvP+cdRcZqh8bd6m8Z49jhOqfRtsdX2SZeaVxMU+36aBmXSFCkQhA88XpEPRhhduqmm
	 WfwYOxHQ6fsfmfs6snRzJbimLStgdGLFnB2EoyyDEC106IRmXlAPocGNl4wCuPV4NtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UJhszDOC;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B30D606A339
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 11:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B30D606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UJhszDOC
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e47347279so1424189f8f.1
        for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 03:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794827833; x=1795432633; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ITw6ygw2AXNWGd7QRacWknaddhmjMVGAScdWdo2ralM=;
        b=UJhszDOCtS5Wmv2QoXaPJPzXTTvCxMBlt0wZuEKdh4JAWn2k0cdqfhQ6eeN56ne0AU
         /r0BmivCzzBm98iQkfcoQziIeY122u/cPLinI2hFHfCrTQmdS67ag2dJep1BvmSZm8eG
         UVepOz0WqdesXhlEb+FFAppGS+D529n03zb9510Fz9o5MEPN51hpIXgXjQExsTTTtfbk
         BOd3O0NlRnD0gw3iZEaH99boWxii4WgJPRIlaUh/iUOw1IzOsQdkRAgHQX9m2nzdp4eM
         AXef2234YzVbVaSZWruRh6tplEzzz5/So01O+tBuEwNhNtPs4U3oEs3gd7MNT0xQCgcn
         VD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794827833; x=1795432633;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ITw6ygw2AXNWGd7QRacWknaddhmjMVGAScdWdo2ralM=;
        b=wPRsSKnZoPPU3JUMANN/YNnDls8kltUFVr13ze9vq9LwwiBKdgeTz3DpiC4O/g80bH
         OLsOrVlkTuoHVNTMooBuyO3OxQKLOKeNXqQ9K0KJHnQWWeW42z1xIaxDt/VCoNz38gir
         Xgu6EwkPr8k342ven9biRgvkP+FOOOVeLfob7r3tHdkAYLdr/cTCX+uswe4ttoqXXP0q
         tS/G9gCKy+89ewmEpC7O868vOF/5oviziSwbcZGuZQ+Wzxiy5T4pvqMc92LBErGEJuX/
         22MBwfdy60XnVeTE0FXLuGAJHfnjCXFJEeGvzm4BocyT9prR50ShhoLiGZmpV5lszJ/b
         GaRA==
X-Forwarded-Encrypted: i=1; AL+hErHtmKdUtiTAocHxS8TKFH6e3+QzqVi3dsucrqnod7ktm1wQnFGp9/few5AmQn08XVLIEzOshOc6AGNNVi4eIg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9F77EyBxYqM0b7d2xKfbYy3VTrKJXRBG0AYKT0883Squ2LPUOj
	uQjRhZxxsBMLbXDCKDs8H0xfdyQ8jHggKhQ3P+5SDSeDlQ2j99CZA0e7
X-Gm-Gg: AZFdTZebAKjhsyHyFG75QgSzRntI2hJ1UH6mI+N4Bg/Dqvx3S3JrwVonZqm+iYzPG1R
	mYzxC69dxlJSsq3HMkSOucxaWTKI59fKAonPJzZ7x+eUgvJ+GxZO0KHMFgb4MJ/K7gTjwytovte
	/mcdaepO8j2IoBM0qDJXX3Op9R13WJu2LfjxTAtFhIE4M+2JwE5vKpcN+k79bpxF16Dxy3enxod
	gtOGhL73BGsN05Y8skD4+SZGEaPZ9VZp4IE88mb8+GIJNkiVa1dNi+WA9AbAsJx/mDSYxVx+vSv
	xoLsjk6UYio0cPfxVpeHwDGmtQXMLgTyeW1xFPALNx1NRWxewLCXsLSf2lTWC+UWBUHaxmj14tG
	pdTdDImp4kaXupR1Kpz1PmfbrPMcTkhn5wP4IShA1KHdoSKsO2g45biqYko3OhORzbOpbu8+b7s
	ZDytmqFxngnCdqXrdv5jFum+6lFKDDeCfsvYK2lZW9bCus/fyupXG9vZvcIQ5AK812TcKzHyHym
	o4DjQFbJDXo3YDd5fQ0dS40jbVlxP/TlzTMHx6IcB9mV4ir2Amh6sEGSTvfm4ZkLZZ0Rr6zgkjX
	tsXyKUuS+/xbhgZ/yfPLS3/P96pC65l1NoMs6cwkV1Y39HIfMbLBDZYRaIDODU6XRj/7wCghluL
	rQ0gxLojSPAiM
X-Received: by 2002:a5d:6f07:0:b0:490:f98f:addc with SMTP id ffacd0b85a97d-49c71d48742mr21084457f8f.27.1794827832625;
        Mon, 16 Nov 2026 03:17:12 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c8d286480sm39476298f8f.7.2026.11.16.03.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 03:17:12 -0800 (PST)
Date: Mon, 16 Nov 2026 11:17:11 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Pavel Popov <pavel.e.popov@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, Arnd Bergmann
 <arnd@arndb.de>, Leon Romanovsky <leon@kernel.org>, Lukas Wunner
 <lukas@wunner.de>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, Jim Chow
 <jim.chow@broadcom.com>, Radu Rugina <radu.rugina@broadcom.com>, Alexey
 Makhalov <alexey.makhalov@broadcom.com>, Wei Liu <wei.liu@kernel.org>,
 Michael Kelley <mhklinux@outlook.com>, Nathan Ciobanu
 <nathan.d.ciobanu@linux.intel.com>, bcm-kernel-feedback-list@broadcom.com,
 virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server
 CPUs
Message-ID: <20261116111711.7b473feb@pumpkin>
In-Reply-To: <avqhIQ2krd1qgp6K@infradead.org>
References: <20261111234439.4098-1-pavel.e.popov@intel.com>
	<20261111234439.4098-4-pavel.e.popov@intel.com>
	<avqhIQ2krd1qgp6K@infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Nov 2026 22:22:25 -0800
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Nov 11, 2026 at 04:44:39PM -0700, Pavel Popov wrote:
> >  #ifdef CONFIG_X86
> > +/* Intel Xeon CPUs whose host bridges support p2pdma */
> > +static const struct x86_cpu_id p2pdma_intel_cpu_ids[] = {  
> 
> Why is this in drivers/pci/ instead of behind a clean abstraction in
> arch code?
> 
> (and the fact that the CPU vendors still haven't managed to provide
> a firmware interface to expose the P2P capabilities is just insane)
> 

Isn't it a motherboard issue?
Since it depends on all the PCIe bridges on the motherboard.

IIRC P2P can also deadlock under load.
So it needs to be use with extreme care.

David
