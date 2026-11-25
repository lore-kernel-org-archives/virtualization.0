Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602861;
	b=TUnbdLyH57/cVBQsydMgWaUO7EnZiOmNLIW/sHO5U67gPDsJ7XZuQfL5xWum0N2YqJ++
	 P+hMkhHxlos0c3eNFewWRXyeuJB+wpuPcLKkyX3tYGjmWPmEUixqrVyAyrQ6CntGDZQQZ
	 N7s00bxRc2OUbOw4lmBZxt95W3G3g8JBB/3KlgthvpjCnYQHq7FvdNuNxx0b9XXrwJGCj
	 gmpZCp0z+B97hN4380o1pKX/GJ4CBgLl+qjyNiSmtrA93sNpH+04XyXx9R6bpsbRv3h2k
	 z+bhZWbNGwGatGUhGwptTnz+vLeLvk26BSYp8DyeISMD2u3rJbUQa+Pck0pG2IGEjlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=x31Cn92Vg77F6imWAfZybXJjBGrGrkLdCuHHEheoTWk=;
	b=5RwoaBfUcI6Gd5IzRsyRCPg7g9ClzRHyLD3uX0OHIm4zc1m8m+83yDtw6NAl7dxyZAQR
	 +lCTR6PmDRXO3dYdYNiV7kOZl3EP1OxKdRx8n/ii6lkj6VheRmefLTsKXgF2jnzA+QVVB
	 qzJYfZot1ygLDFGstF/qv/h2MCu3aggDCTAz6UVAoWI5dKJMe5RjH9SC6KmhIf9hYsN7T
	 2S0Ibt/01mQfoGJ/qR4h+WGZkCkRpQRX0aY7KoZvmXKbOl9nEu2uYh+6+xBfc/hYT6Weo
	 e+mKFQhEFqG5VBSX9Oz5e1kaUGHzrsFeHaDuKIkUhkrX3TkYTEgkRpWLNWAjON/RrVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iOr6j9SG;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BBF606A696
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 10:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85BBF606A696
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iOr6j9SG
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso58062975e9.0
        for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 02:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795602860; x=1796207660; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x31Cn92Vg77F6imWAfZybXJjBGrGrkLdCuHHEheoTWk=;
        b=iOr6j9SGpZHphLWit9zM1HIUK4Hf/3MpDOotUAhlNKoFOxeWargz5hBiNFnRD3BTE9
         sBB9G3fRFWYgmZJRDHLAxNuE3TVUrgx18gyCP3nVtcTcGgEwpZ4lRSDFXxwf+RGb6CEF
         jnA+iPTt9/NK60HT8GUpuLdeVqmjEni86cPPaNQNb2n9YhM2W3QTTR2ZDbp5rUe3dJVH
         U9HIyqQkiTScq2554600k5vwD6O4MX6lAO/TC7Vy4mzw/nGIPTrDsm8rbFfNveRGtFHs
         X2Ont5CYQl+mx3Z9gauis2k7NZN1mbFCb/nsmQEhSfqEAznYmk9W4pein1vOaNefRRjQ
         HWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795602860; x=1796207660;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x31Cn92Vg77F6imWAfZybXJjBGrGrkLdCuHHEheoTWk=;
        b=05X97quMBWkqejJPrxcWgUE9Rm20SlDL/ARSyeqb3ynzlq2S6nJ6Cm3flwRlavcThv
         tYVAR5qa3cMOSF/9RAGM4roAayV2fuHFbRjjE9NLoQJ9VU3t7EqsFniiTbfqokVWdlPk
         WMTln3eKr9b5tTo6UR/1ppLRJ2yRbRPMsNBchxiXjTfMRD0esQs6VbZd/f4Xqi8amxCj
         72z3aRikFTTDMAfdux05PddyK7j4Cu9jCZRCepqhQ1DBgLQn+0CiRqiOcimydiXcFNZC
         ibkwlOQDB2J87mALCDoRwUPlk8yo96Dvrjordds0vzAuAxIm7DQ9BkZD6QyKXjc5SmNz
         F68w==
X-Forwarded-Encrypted: i=1; AL+hErE/rI4tqSGeBboHN9nuPw2GOv+dsnQMCf6ieOcGKJeUaMtC6g7F57MUVzM8jQ0R1Z7mGGLaOPqR2xchKnEXQg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+8J6cZZdqAcEDDiOr7fxc3KQvEBT8IKhGUhLPtXjwwzHph9urS
	36t0iYDMlChUAGIjU3eicB+RCAsYgSddeJJpd7150EVcl9LZKrE4SUne
X-Gm-Gg: AZFdTZc6kQ+gT1pnmrC6lcT2aYjCHSj0MW+fqlzDpUhDKU+P+V0tHPSdlGuMSz/efsx
	octDu5gMZeCERrz/hj18EOc2VZwE6NkznmVfYtqwmbpJz9J72VXrhUd5lzQjJS93vwAONbazuAV
	KcQ5n52DPp6jP9OAzEfN2/7pq1BWdFubay56Fxwnp+Ti0xnP/utsC4Cn9PqfuRAEv8GwGONX7Tb
	jdZIYu/Qmgg8XSFBGLv66WExLfU6N0SEkXz6vtJ4shVMJVaTeHCn/w8NSzSsqDd4RKOWqsOdaOk
	gCvB4056TfmOQWjmja+h1I4VLNxjemo60LG8vJt/YDLr4wE2p0c4rzP1zjAKcN0/ZHgd9JgzA+0
	e6LHSFiiArH9Xa8uIQUSjtSFMMbS74AiXNYe/vy1ZxO+gYT2ur5TXzkWK/2tYtmKUG8im0JM8EX
	Z2D2p/r6IlI54xAZY5VMkunuvkoRiY4hfZMfVoTM3D8cAOMEWf5zOF0VWWagAKwXzYMtLg+K2Je
	S6wuqCd597LxaGexO3nE8rsesl7M3HOgHLg4mYg/iwDv2i3yndTbM6qz/DoE+BRJYQSIFTcteZp
	2su76g9Pf7mpb9IWhRUhZxsGKpXQF1VVu2+40wKCHKsXxrVuqGVHwx6EOru/bXcz
X-Received: by 2002:a05:600c:4e0b:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4bb887fb66cmr368507105e9.5.1795602859819;
        Wed, 25 Nov 2026 02:34:19 -0800 (PST)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853c9170sm577084885e9.14.2026.11.25.02.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:34:19 -0800 (PST)
Date: Wed, 25 Nov 2026 12:34:18 +0200
From: Michail Tatas <michail.tatas@gmail.com>
To: Jiaming Fan <fan.jiaming@hotmail.com>
Cc: amit@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_console: Put device on failure
Message-ID: <awa5qh-waK2uVwSv@michalis-linux>
References: <aoWK_qpSBeO6Bw0M@michalis-linux>
 <OS3PR01MB10251DDB055D1679B1EDE974FE7442@OS3PR01MB10251.jpnprd01.prod.outlook.com>
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
In-Reply-To: <OS3PR01MB10251DDB055D1679B1EDE974FE7442@OS3PR01MB10251.jpnprd01.prod.outlook.com>

On Tue, Nov 24, 2026 at 07:18:34AM +0000, Jiaming Fan wrote:
> I ran into this patch while reviewing another fix for the same leak. That one was dropped as a duplicate, but the leak is still there in mainline.
> 
> Any chance you could resend this?
>

Yes sure thing, I will resend this

Best regards,
Michail 
