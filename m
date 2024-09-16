Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1C3165EFE;
	Mon, 16 Sep 2024 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726512665; cv=none; b=nq3rOWjrnui0bHlkywq8t6BEtaxfKThjRBlw7wzgfVAvnTenL+YNd/ANqvZtr66Z1rtE1sZaS+mBSV5F56dK/sChnKroyVrWO4xKoZ5UBRstYt143wASJDdGXHmMzyIsPogbtcsxb3QpM7ilFuQZiUDdfRGbDdktWqGA5Rgg/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726512665; c=relaxed/simple;
	bh=Nv63AinJ6rLovkHXFWEsHdyEwEF6WfG3BMXI/rjmgvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iceGfVeGx8UHGAKLvpzqvpxUPG1zK9lag/+NoiElbtd8mvps7KXTeEBEQrFkUW0P9O9oW4QeA9kUC/b8rJuqKCGp0+vCKPTCqGq256pheP5LowW3miiuGaR69aONBFURY3//tYGjRizZ6k/doml9a+GCiO0CoFqmE+g52Ri3A08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=msfx8BMF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="msfx8BMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BCCC4CEC5;
	Mon, 16 Sep 2024 18:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726512664;
	bh=Nv63AinJ6rLovkHXFWEsHdyEwEF6WfG3BMXI/rjmgvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=msfx8BMFERfG2Jub8AyaHLgQzOBaw4ZLe7C6UfC9Io3/uSkBNAxGiZr2C/zTKZzZv
	 dnLRbH4sHgv847s1yFcA2cMvEFMjHhTftaXBWMVshZ9PAEb5fwRZQwXpGkejEdBlpr
	 yH93QV88V/kU7dA66r58sEeIrmGUZJctDGMzwmOU=
Date: Mon, 16 Sep 2024 20:50:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio_console: fix misc probe bugs
Message-ID: <2024091606-unsteady-cesarean-094b@gregkh>
References: <ad982e975a6160ad110c623c016041311ca15b4f.1726511547.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad982e975a6160ad110c623c016041311ca15b4f.1726511547.git.mst@redhat.com>

On Mon, Sep 16, 2024 at 02:32:56PM -0400, Michael S. Tsirkin wrote:
> This fixes the following issue discovered by code review:
> 
> after vqs have been created, a buggy device can send an interrupt.
> 
> A control vq callback will then try to schedule control_work which has
> not been initialized yet. Similarly for config interrupt.  Further, in
> and out vq callbacks invoke find_port_by_vq which attempts to take
> ports_lock which also has not been initialized.
> 
> To fix, init all locks and work before creating vqs.
> 
> Fixes: 17634ba25544 ("virtio: console: Add a new MULTIPORT feature, support for generic ports")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/char/virtio_console.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

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
