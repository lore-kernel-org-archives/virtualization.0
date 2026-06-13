Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52A02459DC;
	Sat, 13 Jun 2026 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781368007; cv=none; b=IdFz14c8vxORQ2mCNmaDiMn8UdnsitYsQ2TeFJeLYHsCGmmAVzkKgchFM9t8IesANKGggHKfsWwzBOz2Xfm3D0Z20AKA0z2BXZRydI8KlDk0CCeST6iyBTOP8CmhCIkagYsqsbMMsRJGwLI+/m9KkylPv2yZyX+sGLJF1yRBrkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781368007; c=relaxed/simple;
	bh=6wyKlt/rkdkUyUC217gMouOHcTy4/PdKfaskDk3EwKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZz9S23QoHKRaDjcx07EmJGkV+BfH3xptsFGe3IeJsabtYtTeDxy/zF/ziasef/15ijIgJWc7uDvWedCe8eHiRyQn6TYdcUYmHhyAb1NIVwhHs27pYB2COLlZBdBDajSqkxycHAtcMp1Bdb6ewTzSyXJR/O3xvtYq8BoAt/zILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ataMPZg9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ataMPZg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8951F000E9;
	Sat, 13 Jun 2026 16:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781368006;
	bh=quHP7KcGd6kRdMSIND7iYUAuCYasmRY32NiFq9JBOVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ataMPZg9iqpQuZ4K+KyXbM5t+5ZEDAZWlSSgehtwxnID/5KGzWRo4xRn6wFfWJCiC
	 /UaFVNt+54AXniRya83/4iiXbEz5NzJAjmlkxSzI3KUGegh/kchqgwvRBk1acLbdbi
	 skvydT7irWQ/A2n4879liE2Gc5w+MR0biDQx5tCxV948vKNzY+EHA8unCfca5wEKkr
	 nv5YJ5zeV3TqhoXEZNEm8Ld9hX0IbHRlnnJcLiv88sHSJqlvPycKWAZxCstwD69gqR
	 nYiNJS78wD8mMtvHVoblTe+riVJyOxEJ/CwfAufQQp1wRwSKOnOcmKbMD0ocaxIGZk
	 CEa8EvXH8A7UQ==
Date: Sat, 13 Jun 2026 12:26:41 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] vduse: Fix error around jumping over a __cleanup()
 variable
Message-ID: <20260613162641.GA2697431@ax162>
References: <20260610-vduse_vq_kick-fix-guard-usage-v1-1-0ce02c08006e@kernel.org>
 <20260611110346.2b9388a1@pumpkin>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611110346.2b9388a1@pumpkin>

On Thu, Jun 11, 2026 at 11:03:46AM +0100, David Laight wrote:
> On Wed, 10 Jun 2026 12:16:49 -0700
> Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > When building with clang, there is an error in vduse_vq_kick() from
> > attempting to jump over a variable declared with the cleanup attribute
> > using goto:
> .
> > Jumping over a variable declared with the cleanup attribute does not
> > prevent the cleanup function from running, it would just result in the
> > variable being passed uninitialized to the cleanup function .clang
> > errors instead of generating the invalid code, unlike GCC.
> 
> Does the same apply to variables allocated inside switch statements?
> I'm sure I've seen one that wasn't inside an extra block.

Yes:

  https://lore.kernel.org/20251002233627.GA3978676@ax162/

-- 
Cheers,
Nathan
