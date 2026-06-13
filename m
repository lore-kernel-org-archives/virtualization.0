Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767BA26F29C;
	Sat, 13 Jun 2026 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781374876; cv=none; b=SSR3PzuVhN+dsYXWc47KS4IypVlS5Q1mj7IG/q8SFRL9tjlVjsWFQSuZZ8qR2FzB/uCFiCqE9cWz4cgcrkKikx0UIE7HGnD7arP1ccDDm/OauFnjK7DqWZfTiDydpRNjbkx3WGYhmX4YqKdrt12HRaXkNMumRFpF+jdwosdS0NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781374876; c=relaxed/simple;
	bh=qCwndZHyXA6xUFuzUo1gjzi7k2UxYupYS00ajtitHeI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9WgOrF7v3HihvgWmJjA7TCPZWkBaqENRVn79M6tSZrcQtP5Y3j0f1Vq0G5lwtFgqZ+VSx5t0Mfen/zROrBlVs2QpsbkjXULNylpByxEJTOGC0YGrrd4cDk3Z2o4ULgNsENyscArVkiaNHx31CCB2IxRCDFdjXQlovQpHpU6IeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/0Y3q6z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/0Y3q6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9811F000E9;
	Sat, 13 Jun 2026 18:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781374875;
	bh=blcmY51mUhrNozT7HIFdG8GhMoBehBU1E2kCKeAJ478=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C/0Y3q6zoX8+6dr7X6HlsOEXaGuN2o37Svsp5c6BPqYPmEKFYDs9bY8jLHaowmYVd
	 U5eWvCrGBgTzFjPADHSE7v/Glbzz1uMzIUvym6u+tE8pfmMydrj58yAkhJFLgaPBNU
	 OLFCsCnLd5OTCuzeF3XquFmZn5nU0cSo1iQbftzwMU4I9fbfyk6+eP+BStg6t16+aa
	 CQeetiMjwcj2zXtA8D+0lrWh3oWLHz1qYYugT5Kd6kcG6SXT9d0PEW6g6ymEpfuJZE
	 qe6yy1u6VG/NcwtUTpVv1tKcxyhBqoBcD8jWvwm+r5ud4TRP0nfc3AbF36TT0s7ecG
	 1uPDS8iIxXsnw==
Date: Sat, 13 Jun 2026 11:21:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: menglong8.dong@gmail.com
Cc: jasowang@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, bjorn@kernel.org, kerneljasonxing@gmail.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: busy-poll: introduce
 sk_tx_busy_loop()
Message-ID: <20260613112113.55d9313f@kernel.org>
In-Reply-To: <20260611071242.2485058-2-dongml2@chinatelecom.cn>
References: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
	<20260611071242.2485058-2-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 15:12:40 +0800 menglong8.dong@gmail.com wrote:
> For now, we use sk_busy_loop() for both rx and tx path. The sk_busy_loop()
> will call napi_busy_loop() for the specified napi_id. However, some
> nic drivers have tx napi, such as virtio-net. In this case, sk_busy_loop()
> doesn't work, as it can only schedule the NAPI for the rx queue.
> 
> Therefore, introduce sk_tx_busy_loop() for the nic drivers that support tx
> napi, which will schedule the tx napi if available.

First, I thought the only difference with Tx NAPI is that it can't be
busy polled. So if you want to poll an instance don't register it as 
a Tx one instead of adding all this "tx polling" stuff in the core?

Second, can this problem happen for any other NIC or is it purely 
an artifact of virtio's delayed Tx completion handling?

Third, this series does not apply.
