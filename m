Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253CA1B652E;
	Mon,  1 Jun 2026 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324286; cv=none; b=T/hVqIT4vxUbvDl7WtrunBuhcmKy2/E8VrSdDa2+YbEID5CGeSN0zRauTV91oEdMPX9+CL8ux7DQ4OI72zIqMnTHXzxxQsW6PrJNMkcTafwwdFwuIYAFpGy+Dd8jd+6+qgXbdqdFKMjzMQuewNT2f7kUUty7dE/XjJUoRTsH+SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324286; c=relaxed/simple;
	bh=2jwmh+SlxYgxb9Di9ikNV4ZS34pbdHfu2xCgzXk1FYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ln9xoMGNUTge9aMj7KamUX1e7puunL6blcnxRFIQ62yRl4Iyz66PDZZewC2GhXbde2/EpKdEl326tHQLh4QNBwD+U7NBUgZhkEgZL5iEyJTynGD+YqmALgd7u45ccEaHUw49n2dUDIj3Y4QzfjVVHjoRY/2iLWdNEsTy3q3g2R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PryuN4iN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PryuN4iN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101C61F00893;
	Mon,  1 Jun 2026 14:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780324284;
	bh=Bq6O2RrhmZoA4hbFJfvSSctD1SJWtZ9biSN5MV5XoDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PryuN4iNYyuVR26MH/0nKrw5yXVFDqzFduzde5AFVVNoaMNBLgHp1KwGwBhhAdSHd
	 niIvkG+6TipTYT+n9+z5ihr6k7Z3p7P9QDwtLe6fknk1c0+sUzs6LE/psVF1fTIFQM
	 4uDncJ+yAy6ccywrXCMgcXEXqMGv5jSrzvtpEta4=
Date: Mon, 1 Jun 2026 16:30:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Goncalo Gomes <gomesgoncalo@gmail.com>
Cc: amit@kernel.org, arnd@arndb.de, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Goncalo Gomes <gomesgoncalo+linuxkernel@gmail.com>
Subject: Re: [PATCH] virtio_console: clean up port name sysfs attribute
Message-ID: <2026060152-armrest-duller-fc38@gregkh>
References: <20260601142508.3740862-1-gomesgoncalo+linuxkernel@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601142508.3740862-1-gomesgoncalo+linuxkernel@gmail.com>

On Mon, Jun 01, 2026 at 03:25:08PM +0100, Goncalo Gomes wrote:
> Fix issues flagged by checkpatch.pl:

This is only needed for new code, or stuff in drivers/staging/  Stick to
there unless you know the maintainer will take such changes.

> Replace `sprintf` with `sysfs_emit` in the `name_show` callback.
> sysfs.rst states that `show` methods should only use `sysfs_emit`
> when formatting output for user space.
> 
> Rename `show_port_name` to `name_show` to follow the naming convention
> for sysfs attribute callbacks, and replace the open-coded DEVICE_ATTR()
> with DEVICE_ATTR_RO(name) which encodes both the mode and the expected
> function name.
> 
> Also fix a missing blank line after a declaration in free_buf().

You should have broken this up into multiple patches anyway :(

thanks,

greg k-h
