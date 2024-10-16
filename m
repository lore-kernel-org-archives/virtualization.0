Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FCD12E75;
	Wed, 16 Oct 2024 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729107877; cv=none; b=OItEfTDarPe3h0F4yIIRJ2AnWRMVoJ2e/RKJl+3eyXyNytSbScBxZr2IDF6lnM7eZwu/FzKeb7MidUw0lHTEBopEfF1Xwn+XnsEAOMQ01bp3lBitq6ElGhycxrNnaz76qUr5r5gjmm/ESJRKg1h+fo6OSZ2fXygtvn8/AWS/QZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729107877; c=relaxed/simple;
	bh=Jhh0yfMM7l++TtxllfpIEDWIC8mh0Q+gx/KXS6ZzBRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foM1SkGjW6gG6i3xLthrJoSYTDmmg4n0mgMTVvLtqCktmsca3TyfqRMF5+iorR0Y1sToYzrLLCS+7W8UlpDeJF+1uw/qsQ7cvB83GHJTg4X7kcG0tiUAp3ObUZaqbreuV7q8k8PdG5DjOlSdpvRZkCn+vrsNUlNo2ukzmSLMwHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eoo2WlCF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eoo2WlCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8BDC4CEC5;
	Wed, 16 Oct 2024 19:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729107876;
	bh=Jhh0yfMM7l++TtxllfpIEDWIC8mh0Q+gx/KXS6ZzBRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eoo2WlCFiFSoe9VPy+DYQVt03XW1OwXIi0Rm6xMzAo0qbzIOuVNDQl1ZyBIOi6MG8
	 co6xbkD73WHOjryK5nnMu6bTJADoUHKvLeQzPsK8h4Nn/5Q7txrGbCYyqaOY8c1qnw
	 Lv0uaZYhK0eEvWyY3ErvFMq+U63Upc8c/h1Rv8I8=
Date: Wed, 16 Oct 2024 21:44:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yuanchu Xie <yuanchu@google.com>
Cc: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	virtualization@lists.linux.dev, dev@lists.cloudhypervisor.org
Subject: Re: [PATCH v3 1/2] virt: pvmemcontrol: control guest physical memory
 properties
Message-ID: <2024101657-motion-lunacy-dc6d@gregkh>
References: <20241016193947.48534-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016193947.48534-1-yuanchu@google.com>

On Wed, Oct 16, 2024 at 12:39:46PM -0700, Yuanchu Xie wrote:
> +	dev_info(dev->device,
> +		 "pvmemcontrol_vmm_info.ret_errno = %u\n"
> +		 "pvmemcontrol_vmm_info.ret_code = %u\n"
> +		 "pvmemcontrol_vmm_info.major_version = %llu\n"
> +		 "pvmemcontrol_vmm_info.minor_version = %llu\n"
> +		 "pvmemcontrol_vmm_info.page_size = %llu\n",
> +		 dev->pvmemcontrol_vmm_info.ret_errno,
> +		 dev->pvmemcontrol_vmm_info.ret_code,
> +		 dev->pvmemcontrol_vmm_info.arg0,
> +		 dev->pvmemcontrol_vmm_info.arg1,
> +		 dev->pvmemcontrol_vmm_info.ret_value);

When a driver works properly, it is quiet.  Please do not spam the
kernel log when your driver properly binds to the device like this,
that's just not ok at all.

thanks,

greg k-h
