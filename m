Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753A63F44EC;
	Fri, 15 May 2026 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859705; cv=none; b=NjqKaQ4F4q5V+f0RW7A4QJT7jjDAng+oAjrFaKSvuBm7HAMeYKCeXIiZ4zWpeemN7HbgZr+GsUqJg6EpUnL9mDmOzlaGPPbulCR4uxqNxO8uOkFeO+vRQX57eE2+Jk9LjX/hCOTNzOqK7/rhl0Tj/dJuOmFhUwxw+a7AXwurrZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859705; c=relaxed/simple;
	bh=7oQCmUv6XtTNkP993mMSXuzO0uqOKIQYC74wm3kDeZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Si3E17gDSRl8bUtElOAquBetvyc7ssAe9tJZ/Ox8/ZswGzyFKf9ueVddHynWEUjDQgtzKketUhGqIa28ICjqlD997rNU1Al/15dPFzZCETH+8O8grclQDtATHHEAjvQlk0FbcgQIcxv8x12u4SEbSZPPNrAJIOYF4JSXAjGskmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bLKM6ZUY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bLKM6ZUY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB9FC2BCB0;
	Fri, 15 May 2026 15:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778859704;
	bh=7oQCmUv6XtTNkP993mMSXuzO0uqOKIQYC74wm3kDeZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLKM6ZUYn3NrzCzXhL9xO9aiul47R+LcSEmHnA3xnCFH/EcNuQUBnchHEUOo/SAMo
	 OdTZvPK+xRJ+6F5tgjbc4xV5rsQFaJDY6q9vKMji/mEJRzLIq7DsB0rv2rkqViWH6m
	 wtgojdSUljI2GHsH+MUQik3E7zyr/h7VA7paafsI=
Date: Fri, 15 May 2026 17:41:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: AVKrasnov@sberdevices.ru, edumazet@google.com, eperezma@redhat.com,
	jasowang@redhat.com, kuba@kernel.org, leonardi@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	stable-commits@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Patch "vsock/virtio: fix potential unbounded skb queue" has been
 added to the 6.6-stable tree
Message-ID: <2026051526-banish-strife-6dba@gregkh>
References: <2026051553-santa-unretired-a417@gregkh>
 <20260515113503-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515113503-mutt-send-email-mst@kernel.org>

On Fri, May 15, 2026 at 11:36:12AM -0400, Michael S. Tsirkin wrote:
> On Fri, May 15, 2026 at 05:21:53PM +0200, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     vsock/virtio: fix potential unbounded skb queue
> > 
> > to the 6.6-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      vsock-virtio-fix-potential-unbounded-skb-queue.patch
> > and it can be found in the queue-6.6 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> 
> Yea I have some doubts. It fixes the DoS at the cost of losing
> messages. We are trying to fix that upstream now, maybe wait
> for that?

being bug compatible is good!  :(

What's the status of that fix?  Should it be reverted elsewhere?

thanks,

greg k-h
