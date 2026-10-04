Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F74F246781;
	Sun,  4 Oct 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131499; cv=none; b=ngLnWV+TNy45oClHjXaQ0cBcGZmE5g5GFHLeF8gRTCqi7j9sWQdX9eKM8qmzWzk5/zt6Pnwb0sabnQZJPi8YMlKGdSh1lRorxwnR90zA+rB/7qiD0uGQSbn0ukU6GVwpDiGq4ozcHfBvhfen6HVA+EN81o9QNIhzg8oIgjUhWvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131499; c=relaxed/simple;
	bh=8P67gz19cpgeFJPOMVt1SSWjvPa/gxhRq2QRe35w0HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fob1RSAWFez3kuJdiwcqTj38MbsArgsB4aOp4aF0VPmQm+JdI6R+iKzyHGKsX0sE5tTo5ePhCrfSxd4mowp+t73mPiRbiE2aoqkfus4oGrIvtGf3HQp1U1AZlG3ce5lqdh7NpPSq/5ZSf3b+zpkepHRzLv30QmoBLfCpTL2AU0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLgblLRV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLgblLRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58D81F0089B;
	Sun,  4 Oct 2026 16:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791131496;
	bh=pmLmCHhZUkng1a1sJsVWurObbYX5gzaqi+ICK+jZ02A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YLgblLRVb2UJ1uybJdbAh5CkyQV0wIDLlYNs/81LP1rCVJ5ab35wFfxZBcEOCCwmX
	 w3zmzi1Yfm3hBAxoRvAZhjKP+qlJ3PDif8MsrYiw80ECM45gdw17heZ534D9GPl7C7
	 Xd0gBXpQ0IliUCymjw1xIMdxUIoECba4OOMq53pk4RdMG71ZkXGqOM6BE6IxHOdAqi
	 cGy1oDXELWxnij2MHzdopHv3/9s2p4S6ACshwYPDRjZ1vhV6lBgvpiHy9SYPezz5d0
	 wFGED41QhyScmUudpLkxoQZ0wd0hb1aiipLgoB3TqWmVXQv1HLjvCq3rKn9L5Pk+IN
	 NqjGCa4mLcO3Q==
Date: Sun, 4 Oct 2026 17:31:30 +0100
From: Will Deacon <will@kernel.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] vhost/vsock: size receive SKBs from declared
 payload
Message-ID: <asJ_Yt2kGhkG8b2E@willie-the-truck>
References: <20261004073419.4039011-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004073419.4039011-1-4ncienth@gmail.com>

On Sun, Oct 04, 2026 at 04:34:19PM +0900, Daehyeon Ko wrote:
> vhost_vsock_alloc_skb() allocates an skb from the total guest descriptor
> length before reading hdr->len.  Descriptor capacity and declared payload
> length are independent, so a guest can supply a large descriptor with a
> zero or short payload.
> 
> On Linux v7.2, 455 zero-payload packets with 64 KiB descriptors retained
> 30,255,680 bytes on a 256 KiB receive buffer while rx_bytes and buf_used
> stayed zero.  A full-payload control retained 265,984 bytes.  The existing
> SKB_TRUESIZE(0) budget caps skb count but does not account for the
> descriptor-sized allocation.

Are you saying that we leak the descriptor memory or that we don't account
for it properly or something else? I'm trying to understand why the
zero-payload part is important.

> Repeating this across connections can exhaust host kernel memory.
> 
> Trimming after allocation is insufficient.  Linear skbs retain their full
> head, while a nonlinear payload exceeding head tailroom can retain its
> first page fragment.

Seems like a weird paragraph to include here... that's commentary on why
you did a v2, no?

> Copy the header into a stack object, validate hdr->len before allocating,
> and size the skb from the declared payload plus the header.  This keeps the
> allocation proportional to receive accounting for both linear and
> nonlinear skbs.
> 
> Use payload_len > len - sizeof(hdr) for validation.  This avoids addition
> overflow on 32-bit hosts and ensures payload_len fits the subsequent
> int-length copy path.
> 
> Fixes: ab9aa2f3afc2 ("vhost/vsock: Allocate nonlinear SKBs for handling large receive buffers")

Are you sure about this Fixes tag? The linear allocation before that
patch doesn't look much different when considering the report above (which
is a little hard to follow given that it's the usual LLM-style of prose).

Will
