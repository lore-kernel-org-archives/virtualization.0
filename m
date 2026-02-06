Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8215027FB2E;
	Fri,  6 Feb 2026 02:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770345810; cv=none; b=YJ9IOCNRRpC6+29LJkdk7VuSaS8BS4/s+9W3ixAyX8+uCAwF9/Kv/CkHcfV51jcEp1blPAsR5os24sZRR6vtXhJmuUO451vYuYGlYcsSE+yqKSxcR1CG4r36Gzw1So+YwQTwHCcC226ctuUZ7Y+cyLJIpvRFXhG9g0XS5ZCUH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770345810; c=relaxed/simple;
	bh=1mtz9bXcHfQVPpIO3Wmak3+aScB0UmfFuOn2bp1w4Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMkI4g40fe3VPlFQHYD6Dgu68wESdJFPej4QZru+nNCUcCZNf9U7qSVjocF+SXLgWM+fonHhifEsCvYJ0R0owRSrz786/j3V1UyohS9xnSXYRohBn6x/hr2D95pqbUpvVKu8X4tRsnG1n0fWZ5uoHdQQ0c/Um0eWsonB+Wj/1uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqa0prJB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqa0prJB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAB0C4CEF7;
	Fri,  6 Feb 2026 02:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770345810;
	bh=1mtz9bXcHfQVPpIO3Wmak3+aScB0UmfFuOn2bp1w4Kk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cqa0prJB58Yv3GvnfmJQn7jYhNnJjH5I4koyBZ6riuURArYRuT9hFzNUbEqfk0Zal
	 jYxVlj4aZTW/BmFePom6+JsuZ4uANJ8uXfBFQ/euyAm1jsO4YAC0tJsiOhZTEk9t0C
	 FMvGHQhLQ1NSR3nZXU7m1bUFuGBN4AjgZ7riQKoYYuLwEYaxKW63/X1aEkQn6ReMzD
	 PHF86CiEI0xSsCX2VZGemiKFK4tJwF5L1uv5tDEcLGwBuUuYIc/QR8jG3Q3UFdVVNc
	 7lJKSYjvNbx+rPSsmwZnSveIZVgDQdi55sUA8NDHXqmG0JnPWCCcfdjoU+kItIKss8
	 Tlow9FMb9ACHw==
Date: Thu, 5 Feb 2026 18:43:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
 <pabeni@redhat.com>, <virtualization@lists.linux.dev>, <parav@nvidia.com>,
 <shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
 <eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
 <andrew+netdev@lunn.ch>, <edumazet@google.com>
Subject: Re: [PATCH net-next v20 00/12] virtio_net: Add ethtool flow rules
 support
Message-ID: <20260205184328.3b706154@kernel.org>
In-Reply-To: <20260205224707.16995-1-danielj@nvidia.com>
References: <20260205224707.16995-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Feb 2026 16:46:55 -0600 Daniel Jurgens wrote:
> This series implements ethtool flow rules support for virtio_net using the
> virtio flow filter (FF) specification. The implementation allows users to
> configure packet filtering rules through ethtool commands, directing
> packets to specific receive queues, or dropping them based on various
> header fields.

This is a 4th version of this you posted in as many days and it doesn't
even build. Please slow down. Please wait with v21 until after the merge
window. We have enough patches to sift thru still for v7.0.
