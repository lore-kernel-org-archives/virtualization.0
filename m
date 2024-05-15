Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D73339ACD;
	Wed, 15 May 2024 05:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715751252; cv=none; b=Smhs+iWj2uoqkyvmnpcqhgWMCvg+si9Rwpvy4G5bV+3Ttowzb4D1buNbVJjKSN9DYuyXoj8sH4H4fFm5oNWSm6VhC379w5XeDAl9ViM/xxWheY+Y0i9ggEEXDyCY9kbRkYm6tCNMHFDVfpz7KSr0kpZ+x31+KxwAYPd8ctAIVP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715751252; c=relaxed/simple;
	bh=wSb8ns8IYZ3jF3HlcEZvCD5f6COiy9Og6hXxxUm6NI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJyDS+mwTSs6/Fp3/1mkJn5B9YCY6tCxOxxUjVtAhdsTpfnJUA0iQGw2VZZkqTSgp9Fpd2EG4B6CXGnMXL4rlDNb2LNJ4uU22+O1GBT96AgwmZPotJizQOrtDftWuuWj7Rkgnwpv90+aQ9jfhC4nt0YHYrFTLxzqPYo5yKPip7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EkXoEdxd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EkXoEdxd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF115C116B1;
	Wed, 15 May 2024 05:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715751251;
	bh=wSb8ns8IYZ3jF3HlcEZvCD5f6COiy9Og6hXxxUm6NI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EkXoEdxdufurf2ejP3e8GacLs23Ir9io+Z1Sq4qTFZSM3vx/dnPIclnY0aKAhVf3L
	 x+rFw38ymOqlv0+Gluk6x35UhNsJoOTE4JIqLJTsY1KDQ2lnKMZ3Q1tenbovMOq0Pd
	 7VBdUa7hAnsACpceW24rSuCol+Ca86eL9vjc9T5U=
Date: Wed, 15 May 2024 07:34:07 +0200
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
Message-ID: <2024051533-cyclic-unshipped-5599@gregkh>
References: <20240514020301.1835794-1-yuanchu@google.com>
 <2024051414-untie-deviant-ed35@gregkh>
 <CAJj2-QFnOjzwbsMrTcrzPsbCFchtJLM0hiJDbR-xe1HcmV+ytw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJj2-QFnOjzwbsMrTcrzPsbCFchtJLM0hiJDbR-xe1HcmV+ytw@mail.gmail.com>

On Tue, May 14, 2024 at 06:21:57PM -0700, Yuanchu Xie wrote:
> On Tue, May 14, 2024 at 9:06 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, May 13, 2024 at 07:03:00PM -0700, Yuanchu Xie wrote:
> > > Memctl provides a way for the guest to control its physical memory
> > > properties, and enables optimizations and security features. For
> > > example, the guest can provide information to the host where parts of a
> > > hugepage may be unbacked, or sensitive data may not be swapped out, etc.
> > >...
> > Pretty generic name for a hardware-specific driver :(
> It's not for real hardware btw. Its use case is similar to pvpanic
> where the device is emulated by the VMM. I can change the name if it's
> a problem.

This file is only used for a single PCI device, that is very
hardware-specific even if that hardware is "fake" :)

Please make the name more specific as well.

thanks,

greg k-h
