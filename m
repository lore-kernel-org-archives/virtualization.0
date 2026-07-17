Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438003EDAA2;
	Fri, 17 Jul 2026 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285098; cv=none; b=o/nX8g+2BcK4rp1Nt6Re4TZszZHwJWe14UY+o2JGfSJOoD9SLJ4n7Spl5JO3IOwLXGQZbox7b+WxCWBd0zuMg4o8rlE9MmUfH7yvypYQQM/qqtTZT5DMUu5A+OWP5Se2LgRO+d4wsM0yRIMUDyMY9pWEADnMrLg9RyOADbsYb9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285098; c=relaxed/simple;
	bh=9VESTv34SwKu5EPEhC7WVOcTKXT3ryne/CRt34QAqxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3cF8dC5OKlIlLi4F9xFsEjXXCmlj52A9fPRH5WrntFN5XOT8rAy4JSbPwdxGn3Ou7A/85Enem65/j/lQR9Y/liUoayCHBuMijBBWLA00ZmvrB2bpx7PwRvknwRrpODoeeOJVEo9FpDHGQAThOsUD6aSKipCtZ75sxR0gAgYn/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xH3Z88QL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xH3Z88QL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFBF1F000E9;
	Fri, 17 Jul 2026 10:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784285096;
	bh=yRWXerK8Zlb/jzpAdXS7EXG0BOBX6b6ooZ3AHSG5q4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=xH3Z88QLGPIfC9gjNPCIyHgUxtHjYV27Qmtkczl49gcq/Lh590YNf1Iyd3F3I/U6V
	 ozftgxRxT8GZoBkzy8sbVyeiZtAn4sJWmTpDx2pn7H5cmwgCvj5fUytdisOqppPBj0
	 0HshoteE5MCCL2RnHiOfGuA1U9lXIfXhIyRRVXv0=
Date: Fri, 17 Jul 2026 12:44:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Hari Mishal <harimishal1@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	elena.reshetova@intel.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
Message-ID: <2026071717-unfiled-manned-3305@gregkh>
References: <b2176313-b444-4f66-a71c-647b92cc16a8@kernel.org>
 <2026071635-relive-flogging-2a81@gregkh>
 <4dda47ba-534a-4297-a25e-0d63d9167033@kernel.org>
 <20260717014134-mutt-send-email-mst@kernel.org>
 <3b32a38f-0964-45b9-9529-933abedbf69b@kernel.org>
 <20260717044019-mutt-send-email-mst@kernel.org>
 <2026071746-deviation-clad-1712@gregkh>
 <20260717060822-mutt-send-email-mst@kernel.org>
 <2026071757-grout-composer-165d@gregkh>
 <5877a6ae-5a9c-4376-8297-f17695964db0@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5877a6ae-5a9c-4376-8297-f17695964db0@kernel.org>

On Fri, Jul 17, 2026 at 11:21:34AM +0100, David Hildenbrand (Arm) wrote:
> On 7/17/26 12:15, Greg Kroah-Hartman wrote:
> > On Fri, Jul 17, 2026 at 06:10:41AM -0400, Michael S. Tsirkin wrote:
> >> On Fri, Jul 17, 2026 at 11:14:23AM +0200, Greg Kroah-Hartman wrote:
> >>>
> >>> Why not do what USB does?  Don't trust the device until AFTER probe()
> >>> succeeds?  All of the needed checking should happen before then, as that
> >>> is a "slow path" so lots of validation and the like can happen at that
> >>> point.
> >>>
> >>> After that, during the normal data paths, after the driver is bound,
> >>> trust it all you want as attempting to validate every single packet is
> >>> just going to be impossible.
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
> >>
> >> People do expect that data path validation at this point.
> > 
> > Ok, so you want this patch :)
> 
> I fail to see the value of this patch given that there are plenty of other cases
> the device can mess with us.

How can the device mess with us?

> But sure, let's check for some conditions if it makes us feel warm and fluffy as
> we audited a driver and it's now super safe, fine with me.

I'm all for the folly of "it's an audited driver!" claims, but you all
need to decide either you do or you do not trust the device.  Either way
is fine with me.

If you don't trust it, great, take patches that fix that.  If you do
trust it, great, reject those types of patches.

But pick one please.

thanks,

greg k-h
