Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496EF35AC3B;
	Thu,  8 Oct 2026 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479067; cv=none; b=Inol4E5fYpUc2UbO6pdMEAkOBXDCWz88+Jz6kbwJvgtXTwk3LbHUEOrj2pYld/XdXxpK8dojQMYrPqHuhBq5pZkK3Aa64GaFvaCWnXPo1AvQrwxiEnYORPaW913bkSFmr8RaXBKCrM3G2maE8Ma05tBOcbD8gNVGKEFE91iQKXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479067; c=relaxed/simple;
	bh=zeXAfNyMzMtpZ6XIIPeyxfOse65FiIIiR1VxZOcL+s4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3aGNwXxsuH+6+ime4xhuQyYRNL5JX76n9LLkGDFRXvLclOZpE2Rw4Auq+cLk8cgxryrT53OaxXZchtnbijjDE8xRUuMvQ3GmrOUQL/09DkJ63yeIuhk7TOd+fdDWd2f7E5i6zRLklQO6pDQG4MtwJhMnyt17lo8nP/2Ww+4Xfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMcgJbwk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMcgJbwk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF671F000FF;
	Thu,  8 Oct 2026 17:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791479066;
	bh=05VwJ//GGaLPNsovqdRTrOoxahdGDhD+PXWnG0jTr/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YMcgJbwk2LZ4GzpsKjIRZhgUBWewCtX7oMM2g8VwWD1QIQmQANCEMILQ5cCYETJ+H
	 GSm6lHFYv/0Tc1tUJx/EbN+DSQmerK8WG6E7APv9xmaUZN5UyBbc40XwiHieiuJpSZ
	 F6UlFIxMmUdZYiF3ghSzYY9A7YRgBfCGH6WaUZD0rvnF7CMrCMfjlYwFywoL8Q0mdb
	 /l875R7cNiajYlLyUgq/hbgR0zrMnCIAUUEHOYXjXRcoXgMVotiEYc7Lwkdq2v96NP
	 cbOB/Cj299r2JCG9t7YFvMK3piiWQouaVZkX5uqi+beqGPj1g9wBoWBZmNjwYkEZhu
	 TPxt3EjiErgFw==
Date: Thu, 8 Oct 2026 10:04:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: physicalmtea@gmail.com
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, virtualization@lists.linux.dev, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] vsock: split socket lookup from locked RX
 processing
Message-ID: <20261008100424.4c65ed9c@kernel.org>
In-Reply-To: <20261008100352.706042b7@kernel.org>
References: <20261002074551.318789-2-physicalmtea@gmail.com>
	<20261008100352.706042b7@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Oct 2026 10:03:52 -0700 Jakub Kicinski wrote:
> On Fri,  2 Oct 2026 07:45:47 +0000 physicalmtea@gmail.com wrote:
> > Split virtio_transport_recv_pkt() so socket lookup is separate from the
> > receive state machine that runs under the socket lock.  
> 
> Please add a cover letter to the series and repost correctly threaded.

Ugh, I see the cover letter now, just thread things correctly when you
repost, please.
