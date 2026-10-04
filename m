Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE84156F0;
	Sun,  4 Oct 2026 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791118566; cv=none; b=LXvJIuUSj1zbz+B66D+uaZL9a0XSJAuGPJ+WokueTtHqL1INn3xwCfkE6SWsA1rSQTJu03eWoMUQDRJas1Vp493G9zH5PaA7fO+6Auf/VxXms22YPo+YCEGYjQpohAGMQQtHGALA1Mui/V/fUUThl8c7Ed/pIbzUDFck8qW20Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791118566; c=relaxed/simple;
	bh=a7fEkya+eiLiIllDm+mhWmrv3McI5X/eL0cHkPiNtyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yd1WD4vL8XEHK70Gj4LDsJA3istKsSDTC8XKdxzpEWa1kI3W6xryg8RGvhFE4s1307UYy6Rq/dlc+DuEq9aSCLY9kREGT50zklIWoNWufnlRa8x0WnQ1s2d+z13/pk1gDpkvrzF3A/wPIu1JKdQBo9mBMobPdKOHi8RixBaKWIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yshBgo+i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yshBgo+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7871F000FF;
	Sun,  4 Oct 2026 12:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791118564;
	bh=+zyDIlut7TP1j+n//D3AqYQMcrNu+Ijij1LbJXSVLPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=yshBgo+i7fF7Shqs12G8SVVUGuFA0fiV1ORRHZWol+yLghFe+eEKrWR1jHQBAbZx5
	 0IXkME2pCN9M1ylMuwoI+Jge97xNtEsp7cbgPLkBIeJWRkRN2n8tEOsm8kknusl5PJ
	 PKdD0KLV9Kyk0v4r/cgujjMK3/hDbeT1dm5w5Qis=
Date: Sun, 4 Oct 2026 14:56:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: sungbyeongchan <tjdqudcks0424@naver.com>
Cc: German Maglione <gmaglione@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtiofs: validate fixed-output response length
Message-ID: <2026100445-cataract-anthem-8edb@gregkh>
References: <20261004123405.586168-1-tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004123405.586168-1-tjdqudcks0424@naver.com>

On Sun, Oct 04, 2026 at 09:34:05PM +0900, sungbyeongchan wrote:
> A short successful virtiofs response can leave the fixed-output
> portion of the request argument buffer unwritten. The completion path
> nevertheless copies the full declared output to the request destination,
> allowing stale allocator contents to reach callers such as
> fuse_statfs().
> 
> Require successful fixed-output responses to contain their complete
> declared output. Continue to permit a shorter final argument only for
> out_argvar requests, and do not copy output arguments from error
> replies.
> 
> A header-only FUSE_STATFS success returned stale fields in nine of
> nine calls across three boots. The patched kernel rejected the short
> response in three boots and preserved complete replies and existing
> error controls.
> 
> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
> Signed-off-by: sungbyeongchan <tjdqudcks0424@naver.com>
> ---
>  fs/fuse/virtio_fs.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
