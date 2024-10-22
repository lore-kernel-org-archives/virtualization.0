Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AC91DDF5;
	Tue, 22 Oct 2024 05:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574335; cv=none; b=isYd5S7ev6H+hnQr+ORl6J0ZL5BZ3pdHaM+qLZiBVWuByRP/Mfk24lxl0SShBx3mudi9r0X6qqN0M20CcRXiewDTs7uYV/rXyUB3Gktw9jGw7dB7bXtAQn7McRLOBFCsmEjFEWnwK6SPXE7BKLgl1NCa5jInY+gQn1f0DU8haKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574335; c=relaxed/simple;
	bh=RAhRQrMU/Jtdv6RJGp290Zy6A86u4CQL3hSzqxzV+MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rk/jPFk5Tw0wf1dCGdQbI1jHKv6Ma8dXFzI5gUtA7URn3l1Dfgs7zvA7zbcUG7whPlYMiOfdYLC4KHI4SrYsDNaEEo6WUrjHFoL0+do0cIAGV+1wRWq7oIWsD8JW5s0/nK9yKhRpzl2e6JJicMmCEmdugCtqPaFMwPrVz5PJzLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x6kjNyBk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x6kjNyBk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACB3C4CEC3;
	Tue, 22 Oct 2024 05:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729574334;
	bh=RAhRQrMU/Jtdv6RJGp290Zy6A86u4CQL3hSzqxzV+MY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x6kjNyBkmkyAsInHuER1P5sOUfn+u2m10/9gK4m8d0gjLRYI0B569eNzxqqDLFSuZ
	 pUfFJpsgSJ2G9YmDhNrIDygUG7uP0l5x9MSTtMZSObE8d5OqUDH21GSvG4ITKTYzet
	 0V4KEORQl6P5yJIaZ5AjGaw9qLNF56gk30pCwzOE=
Date: Tue, 22 Oct 2024 07:18:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yuanchu Xie <yuanchu@google.com>
Cc: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	virtualization@lists.linux.dev, dev@lists.cloudhypervisor.org
Subject: Re: [PATCH v4 1/2] virt: pvmemcontrol: control guest physical memory
 properties
Message-ID: <2024102220-creed-darkening-aac0@gregkh>
References: <20241021204849.1580384-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021204849.1580384-1-yuanchu@google.com>

On Mon, Oct 21, 2024 at 01:48:48PM -0700, Yuanchu Xie wrote:
> +static DEFINE_RWLOCK(pvmemcontrol_lock);

What does this lock control?

> +static struct pvmemcontrol *pvmemcontrol __read_mostly;

Having a single static device should not be needed, please tie this
properly to the pci device that the driver core gives you.  With this
design, you have limited yourself to a fixed number of devices in the
system at once (i.e. 1).  This isn't the 1990's anymore, drivers should
be able to handle any number of devices at once.

thanks,

greg k-h
