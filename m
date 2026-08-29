Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7B337C0F8;
	Sat, 29 Aug 2026 06:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787984191; cv=none; b=rqRslVvGMzNcoqMHEBc8s9Gc5JbMQIuk3c3QmsUflF6pjXAARoUwBbRT2k7fnQ9nZv+MASPQhhEltREvzoG+PAAcif2cH5s3mChrdwbl6cO+uIkmiIlRjui2/sxUD8pLJP+gCt4HT1jTLNQvHlsnysVlK0tS2bHV8pUQzY3CBpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787984191; c=relaxed/simple;
	bh=Ge6ipf01cEEZqxDZwzACLtW6P3JirXxs4BNN+JwBLow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISUSgA7GUR5EFJAO1Mv2GtzZvxDfMwprbibETiLH9e6fa+a0OfIb6fCpyLaaGIFPnkjbKYqvmONKAE/lpu+Lwc9AuPN6paY1e50Z5Cb0hB/2RPvTAB0QdiEQ+v/0sWr2NM5AxpxW9rpN7pffIC6H/0WZ0KXpRSdVk9mPBlqFHas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZumQ4TsV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZumQ4TsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EB91F000E9;
	Sat, 29 Aug 2026 06:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787984189;
	bh=ip6gQ5LKx8wY6rM4s5FRFrSL0aoXIUAUm56JVSYKJ08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZumQ4TsVxXC0PmzsRRQJ7E/4Idpa3OOIBwiepYu2hH3kqlMBEr1ykrqbG9+NsYIIz
	 keeaxWNjApgJlmBd9rBtrZsVRr/x65qp4lNfsb488YRe9/y1MAq1yE1xTIm+UWcHRU
	 39ozNr1D9SQyL9IStcu9j7yxcnfruB0SsXt6FhG4=
Date: Sat, 29 Aug 2026 08:14:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, Sungho Bae <baver.bae@lge.com>
Subject: Re: [PATCH] virtio_console: Fix alloc_buf(.gfp) usage
Message-ID: <2026082929-steep-clumsily-3f5e@gregkh>
References: <20260828153706.GR687043@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828153706.GR687043@noisy.programming.kicks-ass.net>

On Fri, Aug 28, 2026 at 05:37:06PM +0200, Peter Zijlstra wrote:
> 
> Commit fc220d6be3c7 ("virtio_console: refactor __send_to_port() buffer
> ownership") added a .gfp argument to alloc_buf(), but forgot to convert
> all allocation calls.
> 
> The result is that any GFP_ATOMIC calls, such as those from:
> 
>   hvc_console_print()
>     put_chars()
>       alloc_buf(.gfp = GFP_ATOMIC)
> 
> will trip the might_sleep_if() check when used from an atomic context.
> 
> Fixes: fc220d6be3c7 ("virtio_console: refactor __send_to_port() buffer
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 62eecfa61646..7f6cbe851d1e 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -426,7 +426,7 @@ static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size
>  	 * Allocate buffer and the sg list. The sg list array is allocated
>  	 * directly after the port_buffer struct.
>  	 */
> -	buf = kmalloc_flex(*buf, sg, pages);
> +	buf = kmalloc_flex(*buf, sg, pages, gfp);
>  	if (!buf)
>  		goto fail;
>  

Sorry about that, will grab it after -rc1 is out.

thanks,

greg k-h
