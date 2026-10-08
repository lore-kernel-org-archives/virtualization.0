Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9763A900B;
	Thu,  8 Oct 2026 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479034; cv=none; b=b7pVp2aXaEXtxr1zta2ppHpg/3VlEQgQRuVCQ7TZfso79hyzw1fjmYIqj82JToDHk6POBp+IaQIsIb7mei1KdKmHhN0n1O+gsQkNFNO9PUB9Gtv1M2WkOSB6LWi96XRgBhcTSht9EzeZhKgn/H9UUsP57y+nIep3fAyzCK+iT3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479034; c=relaxed/simple;
	bh=m0JHlrkY6xDVCDKQCvoGOXdszsBxiXKJOVumrugRMIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Co3284tKuTYy1ZyFM48vtw82cY2Y6zhW87YK7LhRZWB06P2rDVaJLTRB3Iias4Hx1ulnxFstY48kFwtoEQJSEoQESobrFgUmxZL4+zpQSASGySAYUvnTOdwJ2Fs1ZiUwJ6Rf+1okrZe2Kxy0VAjbNTi7Y7MqOPHBpw0I5+42eZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFzkZHur; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFzkZHur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7891F000FF;
	Thu,  8 Oct 2026 17:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791479033;
	bh=cE8svecQU6hVayIRGXWmu5m+S3bQy/8AOVXJcUz4+R4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cFzkZHurxEWJXfzMMQN1DF9f1xRst19i7wBkXsgJeuytToRz159u8eG6hDS8WG9Pu
	 bJyT3RefcG792xHiJLp4bpsP/0QAlkuLudU/TbOTmVIY9Bo5qw9RsnGeXrZcwGNSUn
	 mxX/ocyhcpmG+SH4wN7d/E70mJadJIAI8fbYyvExLQdstBNFKKAs+K0YVz/dMwCCvK
	 rOwnncE9BASb4iU8M8Oua8bOZT1qCBOvRfhZmRb9W61GXPXl49WBT6ZIDsbSoI6ofm
	 oaOE6DhnPSqxrNOHLH3in0+BJUMMzMGLj+Chvx+t19kZvpHKcLIGJ7eKl8R9CmM9ax
	 zvuLtZFJ+gbaA==
Date: Thu, 8 Oct 2026 10:03:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: physicalmtea@gmail.com
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, virtualization@lists.linux.dev, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] vsock: split socket lookup from locked RX
 processing
Message-ID: <20261008100352.706042b7@kernel.org>
In-Reply-To: <20261002074551.318789-2-physicalmtea@gmail.com>
References: <20261002074551.318789-2-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Oct 2026 07:45:47 +0000 physicalmtea@gmail.com wrote:
> Split virtio_transport_recv_pkt() so socket lookup is separate from the
> receive state machine that runs under the socket lock.

Please add a cover letter to the series and repost correctly threaded.
