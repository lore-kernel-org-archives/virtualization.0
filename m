Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B71A222582;
	Sat,  7 Feb 2026 03:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770433990; cv=none; b=rSfjzDiit+oQ5Kc6siMEw8t7ILkQIBYZoeCmw7i3kzdlJBlTuoaXDf6v1g2y+lTBP1qEnV+OcIC6IuDhAy4ptafsGkDU1q5dLTKBO3jNFVxkxnkB0OnSeEI1TwcomGj4CLeXyPX9B2oTbl2wKGIVAMZ92j5fwGSiYb8NvOBdksA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770433990; c=relaxed/simple;
	bh=jO9T6Wauc6sgCUGQKDfmY5wCuFcBaI3/fiI365rgQYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1dErc+sKQUNnv1GC1cdUulBOFMcpVcWhzuN3xZCJDE5VGc0XL0Tt6SLoekgtkXKbbjeT9yKvt3bMSjoKDvgT9FHzkfWrjUsCiFDQpMjUBjgDHF2T/m0i2C0+SmgFZKiiehfOKDZccxAf0sJOytrOznnd5bJS8CMqcQ/6CxEt44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiz1CHPB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiz1CHPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3A6C116C6;
	Sat,  7 Feb 2026 03:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770433989;
	bh=jO9T6Wauc6sgCUGQKDfmY5wCuFcBaI3/fiI365rgQYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aiz1CHPBvgEHRzoYQ7Hlt+jua/1QQnJo9V88pJWZKQu7kQBAE9j8Pe31BJVth3mmB
	 l0zBzbPZZA67vkrulASCUX9vvHCkHjo4nqPnuXG2BMrsPAJ2Eb5TXon2JWRaPC3gLN
	 QQCQLA8ii6k51y/dPPosCAs9BKoNBF4Ah0+TvvEwOh4DTWW9HXg8wGM8ypcglqMmzl
	 xlVw7PHJE7vZcyCN+oaXQruGMWWISjP8ZrGGrJBwL308bgnNCjL7bGr55+avkFOmtJ
	 hCkfsZm9E2O5YDMVy2kLxI393dmmkvhAfViXovLWfw6/DJkk+H0eMOoTZ77ym9nyAh
	 U69GKuF8OybRA==
Date: Fri, 6 Feb 2026 19:13:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Srujana Challa <schalla@marvell.com>
Cc: <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
 <pabeni@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <ndabilpuram@marvell.com>, <kshankar@marvell.com>
Subject: Re: [PATCH v2 net-next] virtio_net: Improve RSS key size validation
 and use NETDEV_RSS_KEY_LEN
Message-ID: <20260206191308.7fdbfef4@kernel.org>
In-Reply-To: <20260206120154.2548079-1-schalla@marvell.com>
References: <20260206120154.2548079-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Feb 2026 17:31:54 +0530 Srujana Challa wrote:
> Replace hardcoded RSS max key size limit with NETDEV_RSS_KEY_LEN to
> align with kernel's standard RSS key length. Add validation for RSS
> key size against spec minimum (40 bytes) and driver maximum. When
> validation fails, gracefully disable RSS features and continue
> initialization rather than failing completely.

Hm, FWIW clang says:

drivers/net/virtio_net.c:6841:31: warning: result of comparison of constant 256 with expression of type 'u8' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
 6841 |                 } else if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
      |                            ~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~

Which is kinda annoying because the value was increased in net-next.
If Machael wants this backported then we need to keep the check
and follow up in net-next? We could try to cast the u32 away but
that feels dirty..
