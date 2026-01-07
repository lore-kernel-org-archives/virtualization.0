Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5594C97;
	Wed,  7 Jan 2026 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767828835; cv=none; b=bLrw2r6QvndesiPJ5vY1jm0QRQJjsvkk+6+0jY6jR93XldRHELvIwvQ4yR4eCH/woYwuyYZV6p+BBLkhCqBxhenr6FJWynCj8xrgX5i7lHgyiecKHLRWRO24rVH5SHYlf8gJRin/5Tfp1n+pTMSGD+I1xV23mULliPQogWJF8EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767828835; c=relaxed/simple;
	bh=WUaEOya31dg1J97PZUfkIOu6cbbt8+NJt/GsqGwv3tE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcW22tERYhZLRMQZyTg7Wvse/Z91zVnLBZePe6Z6tnUuxbPOmqD1lJziBTz0iTioGHGqAwdZJp+3bTXfw9bv8uWqaYs8MTHbb8dDCnXXqwJ7Xt1J+S3EKj1O0oKInw2f5bA3zWBpuWFB86183SsWbTYtHI79DckG3KDFkoFCM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKSXRBsB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKSXRBsB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7B7C4CEF1;
	Wed,  7 Jan 2026 23:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767828835;
	bh=WUaEOya31dg1J97PZUfkIOu6cbbt8+NJt/GsqGwv3tE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dKSXRBsB7fvtgwAJBamAtz1K6amRmSMVN2KC1A5E2K7o8y8AvdOFK7s7CzJKj1fxT
	 gmmXZTViGyO2MhK17LUMtkOi8FIFRHQ/2qVS8EMbliNYvbgx58SOINPxLHpInMummG
	 Nxy0diu0Us76prg3y9e7JIe+DDdWKDyPAyPOh9HmZr3W6YFzIBQGHVzN/fi5SjY14K
	 TmsqBXqrKDbbnRCLJvzvZN/e+KbIJOmPMtT7b8gdC+FWRYQpM9HXY5TYUHd7vvTMQz
	 ez+6KD40cvJuWDwtBfgKyqQEmjShufiyvDclYcx3uxi2msvlbgfGqNMrJzBaHDBe/5
	 gt+1vA1LVODJQ==
Date: Wed, 7 Jan 2026 15:33:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
 andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v15 05/12] virtio_net: Query and set flow
 filter caps
Message-ID: <20260107153353.028ed4bc@kernel.org>
In-Reply-To: <17453401-86b8-4fbc-8907-c2cf1faa06ac@nvidia.com>
References: <20260107170422.407591-1-danielj@nvidia.com>
	<20260107170422.407591-6-danielj@nvidia.com>
	<20260107133747.2ae75f3d@kernel.org>
	<17453401-86b8-4fbc-8907-c2cf1faa06ac@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 16:09:01 -0600 Dan Jurgens wrote:
> > disable_delayed_refill() is going away in net 
> > 
> > https://lore.kernel.org/all/20260106150438.7425-1-minhquangbui99@gmail.com/
> > 
> > You'll have to wait for that change to propagate to net-next to avoid
> > a transient build issue:
> > 
> > https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2026-01-07--21-00&pw-n=0&pass=0  
> 
> Thanks for the heads up. The AI bot flagged another bug with the return
> value of virtnet_restore_up so I'll send a v16 once this patch comes in.

FWIW it costs us ~$17.04 to run the AI review on your series.
I presume you have access to Claude or Gemini at nvidia, if
you could potentially run the reviews internally that'd both
save us money and shorten the review loop for you.

All we do is clone this:
https://github.com/masoncl/review-prompts

And give AI this prompt:

        Current directory is the root of a Linux Kernel git repository.
        Read the prompt from {full_prompt_path}.
        Using the prompt, do a deep dive regression analysis of the HEAD commit.
        Use commit range {git_range} for the false-positive-guide.md section. 
