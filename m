Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0E9363C46
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163029; cv=none; b=Sg4fhPhaX7th25l5+BGochzuRg5mejVkTeeOyGalgshBlKjhExTtoKrS+Xukx3HIQY4scrXgk5jrn4mcJnmrWA/MoTYZUEyq4FG26P92E/oTeYLb8urHkQvXzofSw7iMpdMgmOQeWv4HGaBDQP18QBOV3v9ylOI4zl/xXSgbxeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163029; c=relaxed/simple;
	bh=42msgMb3P+btIm3Tjqc0kuZBe+w26HUqseSgoftktpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=u5f5fTw5Xy+DVOZ2iY21rfrgGimnT4hL6/C+s09ePxRkR2xfw7yNn1T1yjqD46wH+rYLXwMO8Ii1YwY5Oy1GR59Y6cfQhAOtN8rQz1D2QW1ouGINHssnlVm8L3QXWxxYJE8Fw1oZJLNxFBsNwf7HaN5YACoKFnNwpIaYx+wWCHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4ZauaEa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4ZauaEa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781163027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QHOpC92ZLUKoaDH3aPL88/GHfZMM5nBt86vbyTmpcKE=;
	b=E4ZauaEa7bSQcpoocHP9MbR1XspNk62nxp8Mjj4hg3U4YqKalheZqUFjoh1jT9K0huYs2s
	S0T4cQau8BWwgxk8LXZpWBH4DGkRO0XoVEa6F6UVXFRDNy2pBOkBygUMdp5UG5nDuInUAM
	aNgpDKxtNbWJoKfwVTC5obADe/gnvZE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10--m7F6rsTPGiM0dg3ulVBvg-1; Thu, 11 Jun 2026 03:30:26 -0400
X-MC-Unique: -m7F6rsTPGiM0dg3ulVBvg-1
X-Mimecast-MFC-AGG-ID: -m7F6rsTPGiM0dg3ulVBvg_1781163025
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ef0af9517so4977382f8f.3
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 00:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781163025; x=1781767825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHOpC92ZLUKoaDH3aPL88/GHfZMM5nBt86vbyTmpcKE=;
        b=kecq0iZ825osj9vv6FwO0hnuLl2PoHj2InL7rjAfOM4QFx62hnxptWOyml3644LahF
         ZVtoC7+UcVnmR24xDSwQNddqWcPHUzfymd2/nBzunYm5jfO70cAtmRV+lyBFLIfdR4To
         q6ZWGyeiFrMUUG/+MwcywsOC+gH2hL9755frwe47GXy4dvmaSz5/+vESY4Xj1zMuwqn4
         cVNd0sKt0eEeDRFBoB+yCUjm+ELFD1y7gtPyBwFGATVpxMerx998Eep16Z8vv5h1d+u0
         CY61ViI2HiVIJuzzoB6uLkRwJyGsjAlc63nlTDh7uEIoEbmnVFTksNM1QqMNGyZR6UPS
         vbrQ==
X-Forwarded-Encrypted: i=1; AFNElJ8mzBR/zL9v7tmHh2a6YnBRw+VkGDHFRq6JT67O0Y43o+37YMkZRhOnZulsmIpSDLvNUPPNMLhiXOb7uPONCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlmBAmJWD8oaYA6o2PWfSRXrSGjGIy5OgH752RSwL7DG0Nv6HT
	MXCZ8LGI3NpIfHXXZEfyOEEPSuTy2BzjWqhS/h3Nvqc6JA48MmIGmqjfiGaYGldp9snMfUAl5e3
	05r9GYsoKo/GiYmYqobuNj+CZhL+UfufA27Xv+ZePaCeejBZd7QvZa9QkOvltYCYqkhYF
X-Gm-Gg: Acq92OGVf/dCLprmyTQo9MG6ZeRaIaj7KqfH59/kno53tLR6Rvx1iN+UZpQwRimR/EM
	jdUIu/ZZpnn1CF+4cxELDH+5dcx7eiTGYmKKTRtwI1cvsSKSfQqETvnHSM0l395z0ztWWD/FS33
	IQRO6MiaBmiolN0kTAVolPNeLzaEpHkx860r4ds0aHPQYiRLM+cZ8mI/dOGAbG0mrT2N0duNifU
	UQ73v3nnduHaX+JLa7R2j5drV7SBql/TCOt4lJEaI3GMwmyNE7cpR5GW+p6TaDebIdj5L4ZrKUL
	6TIsHCuOWzusLnczATA8MWYR+Udw7iDQ4bBCMjkRlJDwp0BIh01GWMODcd247cofuw84drwqpFT
	4Dg306Y/P8ZYD23EThnaYB5nPHNnc0CCnU+1q1x2nfz8kWewnRnXY2w==
X-Received: by 2002:a05:6000:220b:b0:460:1643:caf7 with SMTP id ffacd0b85a97d-460677acf24mr2526960f8f.27.1781163019828;
        Thu, 11 Jun 2026 00:30:19 -0700 (PDT)
X-Received: by 2002:a05:6000:220b:b0:460:1643:caf7 with SMTP id ffacd0b85a97d-460677acf24mr2526879f8f.27.1781163019248;
        Thu, 11 Jun 2026 00:30:19 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4b18sm62096991f8f.10.2026.06.11.00.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:30:18 -0700 (PDT)
Date: Thu, 11 Jun 2026 03:30:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Olivia Mackall <olivia@selenic.com>, linux-crypto@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>, Kees Cook <kees@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dan Williams <djbw@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, torvalds@linux-foundation.org,
	alan@linux.intel.com, tglx@linutronix.de
Subject: Re: [PATCH v3] hwrng: virtio: clamp device-reported used.len at
 copy_data()
Message-ID: <20260611025916-mutt-send-email-mst@kernel.org>
References: <20260531142251.2792061-1-michael.bommarito@gmail.com>
 <aio83ZWadVTiuNpR@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aio83ZWadVTiuNpR@gondor.apana.org.au>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2rEj9FlJYSH0xLd_HPbYYNaDMyE9t5YhnXvp1_LT6NU_1781163025
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 11, 2026 at 12:43:09PM +0800, Herbert Xu wrote:
> On Sun, May 31, 2026 at 10:22:51AM -0400, Michael Bommarito wrote:
> >
> > +	size = min_t(unsigned int, size, avail - vi->data_idx);
> > +	idx = array_index_nospec(vi->data_idx, sizeof(vi->data));
> > +	memcpy(buf, vi->data + idx, size);
> 
> I don't see how nospec can help here.  Please enlighten me.


All the "malicious device" things are confusing. Spectre things -
doubly so.

So if an access is speculated then CPU might speculate feeding a kernel
secret into RNG. And then the speculated RNG value maybe can be also
speculatively be used by some kernel code as an index
to trigger a cache access, finally leaking the secret?

Maybe?




> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

