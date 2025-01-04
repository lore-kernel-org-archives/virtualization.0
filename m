Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECFB149C7B;
	Sat,  4 Jan 2025 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735982060; cv=none; b=CtXMkIvfp6nk7Wal3tB1Asau9Djcu4/ZZOYEpFcQA//bQl6qL307bNJOR1pglLj5IiUedF5xBeYQgbD2isew/TSxID67OcC01oxvSJ5pc/QS3CJNgjo/tLJ+BDxxK64zVVxaJhPi6oGKvLW2tWUClm2jhTGlIVU8oPKnjsqH57M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735982060; c=relaxed/simple;
	bh=yi4bm2VUFTkWYOWwMe3sVb/5qkLbD5gtmB4nXFKVM3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S96e+KsOc0U6qNRxi/F3mPGkTSCHy37krRUv26ib49eODz8ex0p7nNtismYVl8nxY7GHd6tfX4pE+WW3LnNT1jddnJiIs5jdWqtpNe3OS/fInE87VrnWOINmMYOL5d9L+n2vPvCzBwDsciRLoosVFhxDjMGFZPqJ7BMzChpBr2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xhvTTGyJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xhvTTGyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED36CC4CED1;
	Sat,  4 Jan 2025 09:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735982059;
	bh=yi4bm2VUFTkWYOWwMe3sVb/5qkLbD5gtmB4nXFKVM3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xhvTTGyJoNsMo/reawAcbWj7tBJLuLFt2Dud5GR24I2D8Z7atIfV+ybNrg11EZ9pi
	 egBCf25l+YyskZNXkF8OQ8ue3A5Fjhae2rxP36SyDc9XIdMQ1T1MgRfGUxhqPZt7pk
	 fp5EJCdx6PkN2XuyQFr22e9Ji/mPcHJodiRYd80Y=
Date: Sat, 4 Jan 2025 10:13:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yuanchu Xie <yuanchu@google.com>
Cc: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	virtualization@lists.linux.dev, dev@lists.cloudhypervisor.org
Subject: Re: [PATCH v5 1/2] virt: pvmemcontrol: control guest physical memory
 properties
Message-ID: <2025010409-vegan-marine-f5e2@gregkh>
References: <20241203002328.694071-1-yuanchu@google.com>
 <CAJj2-QFSmtCcQ=dm3yMhNi9F6trbcP0rg5z8cns5V64Pmn0c9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJj2-QFSmtCcQ=dm3yMhNi9F6trbcP0rg5z8cns5V64Pmn0c9Q@mail.gmail.com>

On Thu, Dec 19, 2024 at 10:58:24AM -0800, Yuanchu Xie wrote:
> On Mon, Dec 2, 2024 at 4:24 PM Yuanchu Xie <yuanchu@google.com> wrote:
> >
> > Pvmemcontrol provides a way for the guest to control its physical memory
> > properties and enables optimizations and security features. For example,
> > the guest can provide information to the host where parts of a hugepage
> > may be unbacked, or sensitive data may not be swapped out, etc.
> Hello Greg,
> 
> I addressed the feedback from you earlier at [1]. Let me know how the v5 goes.

Why isn't this being reviewed by the KVM and mm developers?  THat's the
subsytems you are interacting with, right?

thanks,

greg k-h
