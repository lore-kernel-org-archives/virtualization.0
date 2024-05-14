Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECD517F375;
	Tue, 14 May 2024 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702862; cv=none; b=ntiooRD2LAgLN+vyhB4bNg8kEIBjL9uocV4Ds1U1QflcadsJ5rcDlHZxqMoap2leqDGDedXvjbkbqO/yIuvxfZP+xtHEogZroo6Jw7PnZ3jPq0a7OdktkVzm0WDI8/G4C/ie/ytjBDwikTXgWEMKBZ6FyuD6crKy3qEN+zIexZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702862; c=relaxed/simple;
	bh=ML3v5tzrHw3VPJFi38YFLewOGIWpzxuRisvnBjpMwZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMIG2MDEsV5V+pZIlJDjo+TxavZXeRkkX4T3ZDugQByFgfjmumYPXUlFVpvwRgFvZn5xdOf1ZmSW0Ck/Up2wPuMjIJD9YqCcELF7sNQgxnPu0NEMyOUEThxvfSQ02v3xgOOzSS6tOv6V+pO0vBjmLsH6BqtaxOBnhLSMboUv0lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=szp5EbkA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="szp5EbkA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECFEC2BD10;
	Tue, 14 May 2024 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715702861;
	bh=ML3v5tzrHw3VPJFi38YFLewOGIWpzxuRisvnBjpMwZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=szp5EbkA0s/5LKz4st/tlejsC9BXeyG4iVh+NDoskdfd8/ms5ij+41djwFLr+SO6f
	 Ulz9rPSS8WHuAZIgdVhPDvYwtP9mOIvBAi1JE8iubmrlD5Bpr1JRik5Hzbsbjbh2Pj
	 LyJ4HrDj7j2tIcwybOem26knshcc5DrFTvZHf9Ss=
Date: Tue, 14 May 2024 18:07:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yuanchu Xie <yuanchu@google.com>
Cc: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	virtualization@lists.linux.dev, dev@lists.cloudhypervisor.org
Subject: Re: [RFC PATCH v1 1/2] virt: memctl: control guest physical memory
 properties
Message-ID: <2024051429-cultural-prayer-438a@gregkh>
References: <20240514020301.1835794-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514020301.1835794-1-yuanchu@google.com>

On Mon, May 13, 2024 at 07:03:00PM -0700, Yuanchu Xie wrote:
> +/*
> + * Used for internal kernel memctl calls, i.e. to better support kernel stacks,
> + * or to efficiently zero hugetlb pages.
> + */
> +long memctl_vmm_call(__u64 func_code, __u64 addr, __u64 length, __u64 arg,
> +		     struct memctl_buf *buf)
> +{
> +	buf->call.func_code = func_code;
> +	buf->call.addr = addr;
> +	buf->call.length = length;
> +	buf->call.arg = arg;
> +
> +	return __memctl_vmm_call(buf);
> +}
> +EXPORT_SYMBOL(memctl_vmm_call);

You export something that is never actually called, which implies that
this is not tested at all (i.e. it is dead code.)  Please remove.

Also, why not EXPORT_SYMBOL_GPL()?   (I have to ask, sorry.)

thanks,

greg k-h
