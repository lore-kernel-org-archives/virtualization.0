Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E40E171E55
	for <virtualization@lists.linux.dev>; Thu, 26 Sep 2024 01:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727313303; cv=none; b=CrwnX0bgE3BS3c1cnWRfNthVxQvv5u+6YuEeeJhnjUNuc9eWIaCvHFGmQRhHFOfgGwZic2IiZ5DP/6G8GXSP4IqfzlfS5VI581RNJCte3Jol7DdwDKMjJpZPnqTqU3ia32zQCSKkg7A7B1DLTgaWi2VwBSKZE8LFdhL5rlH9PTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727313303; c=relaxed/simple;
	bh=sYw3bLi0VVpIFbO0o6RPwVhINWF+W88ODkv2xc9RYOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdKCQjQbna/bPBSG7yzpvAIaeIcDuFX2n5EAN2B8//tp+dUtyctd2iNzWBphZmzftmK5G4sEOIMsxlHkmF6rDjUcXU3sPj5he+kUPxJEOCwHAdgQB+sZazWi38d2wKFE0VNgnCDbqr8V/rTVtoUnL7rwTXtwxX61kLhNOCYm6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SnaXVP8E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SnaXVP8E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11A9C4CEC3;
	Thu, 26 Sep 2024 01:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727313303;
	bh=sYw3bLi0VVpIFbO0o6RPwVhINWF+W88ODkv2xc9RYOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SnaXVP8E782eVWG3I3zpUa1OqFcxdk11Oau6t5jBFg/xzZn2x7/Y+RH1Uyc2/avJU
	 VCSBO5P85e5+PGZi83mpfvzYrPLqEevPaIebRi/nUNXDCFQkcTEbqGfqDb1JpVyD03
	 d/09OVe/4gzIH4S98ciO4q3kCh9Yfg1XxvrzI+yg=
Date: Wed, 25 Sep 2024 21:14:59 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>, virtualization@lists.linux.dev, 
	helpdesk@kernel.org
Subject: Re: Bouncing maintainer: Alexey Makhalov
Message-ID: <20240925-rational-succinct-vulture-cca9fb@lemur>
References: <20240925-sturdy-red-seagull-2c17a6@lemur>
 <7ffe60a3-2dc1-40fa-814d-b0ec0aca7ed4@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ffe60a3-2dc1-40fa-814d-b0ec0aca7ed4@broadcom.com>

On Wed, Sep 25, 2024 at 02:10:56PM GMT, Alexey Makhalov wrote:
> > The email address for the only maintainer listed for that subsystem is
> > bouncing:
> > 
> >    M: Alexey Makhalov <alexey.amakhalov@broadcom.com>
> > 
> > This appears to be a typo in the email address, because I do see email coming
> > in from <alexey.makhalov@broadcom.com> on the mailing lists. Please send in a
> > patch to correct all MAINTAINERS entries to the valid address.
> Hi Konstantin,
> 
> The email address is correct.

So, both "alexey.makhalov" and "alexey.amakhalov" are valid?

-K
