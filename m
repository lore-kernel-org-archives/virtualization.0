Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF73416103;
	Wed, 19 Aug 2026 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127630; cv=none; b=LozD158pMy79tsbcvQcZ/XQ5O/JBeWuoc4dDHZeDZQGuF89r1guMpgpwVHX/jPWudrRKaOFETFy39mkX5pq7otlzHX6bNdVoPU9VVD4IlVFfBFNM0Y9gdFaT+cP9j/uBHMD/1r+1Jjd92XkQ4jt9Tv1+42fjyz+RVMcC0xqbVCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127630; c=relaxed/simple;
	bh=xlMH0zLV+GN3Z+g/ZE0s2W2CYfFxTpHqtLRQ5fznyzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ll0/zp675JQrQ4cVHmbPiyEo6qEKRSBqNo2Cl1UuoIrdUfGEVITnQmDOqG23gwacu4jD4pwmXofAdS4Q5eYlrQ5Dm5+ZwmDioxm8z9iC2Gm6EeN45wyNAobdVPT/t/CWvl3A2Qe4TuuRjZssWJ3IcQUTkkGk5pBBLGNcaFgbIDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=bSBGO68W; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="bSBGO68W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xlMH0zLV+GN3Z+g/ZE0s2W2CYfFxTpHqtLRQ5fznyzM=; b=bSBGO68WYPSOxeVao+M5SvebeM
	Oo3wDFHp0dmL9/XRC6hKSxRJxiGAt+/zSXu8iVJiYrRurqGJdQqmhpyRNr3ohw9OxLN6ghrEq///t
	yWcCTNzOLsO2XeA+XibXODgpOlE4wntQv6pMOdBgCxaOhU443LgHrNvzqj3P8Nv7ixUfD17wPFlVl
	+CE0YLuoG4IDH4Wx1pdmwECvgVuXQ/UHx9RV7rIhFdb1tSKXHNLEx4DfmyF+keTnvyokT2pxAUFAn
	whisaI9YtgYYWuoMCaOW9C8TXsOS9gyDw64qOXKISLEH9bjxDeRoph1qo81RIR2t0ox78lWSLOVoP
	j1+Lk8mQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wwbWt-009eiB-1R;
	Wed, 19 Aug 2026 08:20:11 +0000
Date: Wed, 19 Aug 2026 01:20:05 -0700
From: Breno Leitao <leitao@debian.org>
To: Sungho Bae <baver.bae@gmail.com>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sungho Bae <baver.bae@lge.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] virtio_console: allocate the port_buffer with the
 caller's gfp
Message-ID: <aoVnGcGWSqaHfNKU@gmail.com>
References: <20260810-serial-v1-1-abbe51602c13@debian.org>
 <aoQggUaBZC9GeY1Y@gmail.com>
 <6B66D650-D65F-4176-ACBF-DC42488883AB@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6B66D650-D65F-4176-ACBF-DC42488883AB@gmail.com>
X-Debian-User: leitao

Hello Sungho,

On Wed, Aug 19, 2026 at 11:39:26AM +0900, Sungho Bae wrote:
> I am sorry for the late reply.
> I fully agree with your patch.
> It was my mistake. I should have to allocate the buffer with gfp flags.
> Thank you for the corrections.

Thanks, would you mind adding your reviewed-by or acked-by tag, please?

--breno
