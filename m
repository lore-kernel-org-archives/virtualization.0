Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB5E253934
	for <virtualization@lists.linux.dev>; Thu, 28 Aug 2025 06:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363725; cv=none; b=bX1TOd4wYUqmLtRMujsksVXYN4olFyrX+ujVHQ+NrKZeSgY+OcJ3pgA0aYn5K2h2pOhm0hSz89x50BjIGXQSjaXWrA+MzsHGhhvufnwnF03C/jrsKsYpBVm00Hr5CPKdWgM8FgV1vy8GpR0Y1LPm6hk2Aa6CG47EgXypU2NfXrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363725; c=relaxed/simple;
	bh=w7FnD7146wVnQD9QJzGzTqFOBi/FQOVNfgQNXpdhqmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROkzUe0M94052q8IStrstaFxBxpleLJeDg1139S07ShvxgVFGIEYca5eKWc6kIvZw3zP+ChrSslpepOkLR7RQMoSBgZBbFf0pJYmQ7A6oBio8GnhrVNk2MHj1n181PwEeIBSqpKHBgo0BQ5WbpELAHf/9La02rXfB2sFhKOotuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U2w5ixTg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IiydNowM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U2w5ixTg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IiydNowM"
Date: Thu, 28 Aug 2025 08:48:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756363722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6/jHY0vfu4GMSQ8pouxgtZETq0PwRLZOeTYTRkcKuB0=;
	b=U2w5ixTg7bIPxbAzJ084ukICiP7yEKF+Tt2FJeI5+TCcPe3TqHfZQjuZnULDEiWjRSenRE
	H1XCw28Mduw8PAR6kAo6oNQbP5adKlu+oCBfSLtYYBecxGSngeYkOmNFClhefDsZE/ODoF
	Z+QOSjjcEY0zPOW2HgR1JNJaHCUto1pg+XO5COAm/Tv2W1oC1IaQaYjRjHWfL3VwEQHHx9
	YOjrrNox1sk8/PHAE8n3fzN5nti0iYelHZzByWzRSDfSiK2GqN0NTayJ9BBALcCJeTWWl9
	AaiL3sj1t351lGePY0f7kOX7l/l3ePOVDjeXMAjmIMZC24o9RVuI/2dAqPqfaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756363722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6/jHY0vfu4GMSQ8pouxgtZETq0PwRLZOeTYTRkcKuB0=;
	b=IiydNowMllNcmVg+GducwRs8uvTqXawWAkw6baeC35bajJy9/8O+o4dQM0flAtlwR3zkVo
	RRIzGuFh/yrKqgBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited
 task
Message-ID: <20250828064841.oOab1Z9K@linutronix.de>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
 <aK-f45qszH2VEzV7@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aK-f45qszH2VEzV7@google.com>

On 2025-08-27 17:16:35 [-0700], Sean Christopherson wrote:
> Nice!  This fixes things too.  Either solution works for me.  Or maybe do both?
> Attempting to wake a task that vhost_task knows has exited (is exiting?) is a
> bit gross, but even with that hardening, guarding against UAF is very nice to
> have too.

I don't mind either way.
If this is requested I can submit a proper patch.

> Tested-by: Sean Christopherson <seanjc@google.com>

Sebastian
