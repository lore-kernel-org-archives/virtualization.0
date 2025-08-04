Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6171E47B7;
	Mon,  4 Aug 2025 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326257; cv=none; b=R9lLNjMRCQoPLGLJcaHqQQ/Om54eUaf7iLmI7a4aDNtr7YW1227gDVY8uEOjdlJDG4mHdZIDwNB5YgplVhvmn5t7BEYcT8/LTAZ0QtYI2x9pmHFCBPbCvDjVM4qvDDKOd+VYEbQGYJCXCCvV2jr6WVWRhTgw1R4rkwt1SCWgA+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326257; c=relaxed/simple;
	bh=0Oc6CJJXv6M0O3s0By2qhy9KWFhr/GezKeSWHqXPXrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nbf95lVsq/y7p64r10rnXJif8Z/2MiN6tGRQ8n6lYM+VUt2ApJa5mu+TrQ+nJvHsVB3eTWItai78MWe2icvbluQLdIBrJ6FRdoySfQPWc34ntuhojkAqoJrTKY7bCdT35kXX7eir51chaEtpY9VyVEF60EmLCOIGvaZ40xgfIoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VyG/0oeJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VyG/0oeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F86C4CEE7;
	Mon,  4 Aug 2025 16:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754326256;
	bh=0Oc6CJJXv6M0O3s0By2qhy9KWFhr/GezKeSWHqXPXrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VyG/0oeJGvqVOT3upmjt/Z/wfBfkNOYCYQm915nBssyTf1DrqQ2h+0y9LF8n1loPm
	 Sjxj1I5bztu0eWnvarMCnBTiBmVZ/eL+Zf4FuOwohSiUgstYXlC6SOE//o7vq/Zn0p
	 ATeQbdH7QlBMZBqHlK5yT3awVzLFAuzL2YKjyfW8=
Date: Mon, 4 Aug 2025 17:50:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Abinash Singh <abinashsinghlalotra@gmail.com>
Cc: amit@kernel.org, arnd@arndb.de, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/char/virtio_console : refactor resource cleanup
 to use scope-based helpers
Message-ID: <2025080440-foam-oversight-53b5@gregkh>
References: <20250804113020.620352-1-abinashsinghlalotra@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804113020.620352-1-abinashsinghlalotra@gmail.com>

On Mon, Aug 04, 2025 at 05:00:20PM +0530, Abinash Singh wrote:
> This refactors the 'alloc_buf' function to replace traditional goto-based
> error handling with scope-based cleanup helpers.
> 
> No functional changes intended.

Please only do this in new code being submitted, no need to change any
existing code unless it is needed.

> Signed-off-by: Abinash Singh <abinashsinghlalotra@gmail.com>
> ---
>  drivers/char/virtio_console.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)

Did you test this?

thanks,

greg k-h
