Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED4B3A6B93;
	Thu, 26 Mar 2026 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549063; cv=none; b=DkORzzIaHFVQ6JRbX8gftOUS6AyCbU0zDf+jf59y/xNOw8VoAsuJLWiWjUYwSLb02ZshpeWXj8cpqy+kU2+x/rn0TGZFnA3MQiuIK5EwsPBXX7RY/uFYVyQhUnC2SZ+CcaVTd5lpk17i8hPNa2+79nrPTpRi/CzEl7/8hzQuh5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549063; c=relaxed/simple;
	bh=8PyXRhXDYUicfM3gHiAkz4aS4iQGx9RZA0ICuqAXkpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=li4/W5n3juPTmYHv2LOZqI904/xVm2ZPzI+eAQUDnwrZHfXfX6AT3wwJQmpH3asn2GKDDHUOLHAtLo9KxNBqvsGcwrttQxsZL3lGgtTBSw1eNGg0t6ML1b/6j7dp1L1Bu0Wu2h4CRMxsiDmTtkzPBjC5xWyqCnXEELBHbCJQDnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJuxRyPN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJuxRyPN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D17C116C6;
	Thu, 26 Mar 2026 18:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774549063;
	bh=8PyXRhXDYUicfM3gHiAkz4aS4iQGx9RZA0ICuqAXkpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nJuxRyPNvbWaauHzIM6Yk02jw/EyANttS+tq9b85vZYZzLDQ+kax0lrk4ILII0jRa
	 DagXkiatqQ9ZlqHRx2CzlKntbLCLiO9Mjyet4WYVA4RhvvkVXoXiGHlMpjozluqlgR
	 Q1A8dbK+KWDsgieXX9mcaNm8NWUpiYtAwWxetA3yhFtlS4Ivh+A2ffvAYBiKqwO4gm
	 1CPUc4QyiuypYsIstmwG3XqCK6czkbXqZ1fwdPAeV6UYiNhr7InV3Pgm92xeWA1mnG
	 BEx0lhLepIzWDi4G/9JOkgyL1cuE4+tOoZUCLAa76nnNSFdNBnTmeQrWORoP7PI0D7
	 PMePimlTaGVAQ==
Date: Thu, 26 Mar 2026 18:17:36 +0000
From: Simon Horman <horms@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Omar Elghoul <oelghoul@linux.ibm.com>,
	Srikanth Aithal <sraithal@amd.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Vishwanath Seshagiri <vishs@meta.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] virtio_net: sync RX buffer before reading the
 header
Message-ID: <20260326181736.GV111839@horms.kernel.org>
References: <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>

On Tue, Mar 24, 2026 at 11:15:54AM -0400, Michael S. Tsirkin wrote:
> receive_buf() reads the virtio header through buf before
> page_pool_dma_sync_for_cpu() runs in receive_small() or
> receive_mergeable(). The header buffer is thus unsynchronized at the
> point where flags and, for mergeable buffers, num_buffers are consumed.
> 
> Omar Elghoul reported that on s390x Secure Execution this showed up as
> greatly reduced virtio-net performance together with "bad gso" and
> "bad csum" messages in dmesg. This is because with SE sync actually
> copies data, so the header is uninitialized.
> 
> Move the sync into receive_buf() so the
> header is synchronized before any access through buf.
> 
> Tool use: Cursor with GPT-5.4 drafted the initial code move from prompt:
> "in drivers/net/virtio_net.c, move page_pool_dma_sync_for_cpu on receive
> path to before memory is accessed through buf".
> The result and the commit log were reviewed and edited manually.
> 
> Fixes: 168b61da6871 ("virtio_net: add page_pool support for buffer allocation")

Hi Michael,

The hash for a patch with that subject in net-next appears to be 24fbd3967f3f.

> Reported-by: Omar Elghoul <oelghoul@linux.ibm.com>
> Tested-by: Srikanth Aithal <sraithal@amd.com>
> Tested-by: Omar Elghoul <oelghoul@linux.ibm.com>
> Link: https://lore.kernel.org/r/20260323150136.14452-1-oelghoul@linux.ibm.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

...
