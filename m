Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E90513B7AB;
	Tue, 27 Feb 2024 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045666; cv=none; b=tCup4jB015jgABvjlTMQ1r1st4hlhk5FXZtLsXyr6pfn6yMUspz+P9TLCAJ4VjifvTuKz9IxHxAG9Fw5RhqKLufg/jKLXde7Ugli0MkMJ8OkVXjqkk1PPp2xfO0xMy+3QexhNLSIa+7nEuxmLLwYbb68JkfftYo+2HSiK04frZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045666; c=relaxed/simple;
	bh=N5HvdqXvwhBgH1Ndp8D3niqXCw6Eg7QBKEt4IFt9RkY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hje5ujBasbiiOtri7povU9N5dF2NzdHSP2ugHw+F9H6H+tKwqUPIyUDZ1bCBKKxxoRJp9o3UJXRSwwNCTp9wzJ/NE7VNbjCLlnq/PGGSztQYDq9O4FX4gtJOP+wJIWPDnFpafajtECWRiX5hZLe3ngMwLbekD4M9+UPWu7biCPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+ReUhkl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+ReUhkl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FFAC433F1;
	Tue, 27 Feb 2024 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709045665;
	bh=N5HvdqXvwhBgH1Ndp8D3niqXCw6Eg7QBKEt4IFt9RkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M+ReUhklzGRPjIKN8TcvqwkxdvmP8OJpPASPYeUBmnUjMG5Iu34bAZG0R2tp367DL
	 F4DRofcUpFtjUdRbn8gWlURlS5uEAoirPFSZyDWEtV8f7CtcReh/g/wPfqzMTXU467
	 6QcDvH5S3xubxMtRhmK/1g3Oe8fS+3cj+1U4lJqzBLO++UMfuiK01w6jEdOuy4zaK6
	 cKdLep/Eb9yZAqMN9Izt4SBqpfpVzhlYD0QL0PR7dZv8bv9GX2Irpl88iiUdhaTszN
	 ZGiCkBMdjQgrggUUaLVreADtJ91PjZ3dMqrQ4z0RnyC99h58JbKjr1SbIqJmdPfA3J
	 DtL+I/s2fQUUA==
Date: Tue, 27 Feb 2024 06:54:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v3 5/6] virtio_net: add the total stats field
Message-ID: <20240227065424.2548eccd@kernel.org>
In-Reply-To: <20240227080303.63894-6-xuanzhuo@linux.alibaba.com>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
	<20240227080303.63894-6-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 16:03:02 +0800 Xuan Zhuo wrote:
> Now, we just show the stats of every queue.
> 
> But for the user, the total values of every stat may are valuable.

Please wait for this API to get merged:
https://lore.kernel.org/all/20240226211015.1244807-1-kuba@kernel.org/
A lot of the stats you're adding here can go into the new API.
More drivers can report things like number of LSO / GRO packets.
