Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0682015382E;
	Fri,  7 Mar 2025 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339972; cv=none; b=qSoAhIcucWLXJ2iUdkuI08UpaIuyZ05k0+daXcG93Ir3bWW7ZR1pltI747QhLoX17Ze1N1diHbvey/gI6oqCFxO2drRxLQOmJrjWB71RG3uf9J8E4eXPQyW4QdH/3yDVtZG2/1yYwV1JF/uxPq7RGlhbUYu3/cStNoxurMVdgnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339972; c=relaxed/simple;
	bh=kUGNhKndVnG4lvy0lWi69O4G6X3wRJgHqMdT0byLlYc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rCCjRtofDP6379liJbQkmbFAe8jTW7o0JxNcfWp9bTO2BVMb+ZgGBh+taulSZhtfrjq6Q2j1k1sBKxwITyEhsE3ehWxnt+Ic6ScDFPYcphRPmwrEJhPCPwGUZ4uC4Pm+7qNndMnQ/FTIuhIQx3Q3qCFJNATDBmtYzFikT2NbrEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=lwfzFAp+; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="lwfzFAp+"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tqU4T-0032It-7r; Fri, 07 Mar 2025 10:32:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=I6WduNgDa6X5BJ/G54SlQLFV0rIsjm0NYn74kwGYfC4=; b=lwfzFAp++zSl/XVJsfmLsgAb7b
	rMO4Kh38ac0I6Ab0OhU0JPnLpcW5I1oNrMnwGwPXWAQw8Rvf5b1QCyodGeykF6W9WVremiubCW9Qk
	8j5ZhQOM2oA3tl3LFuSUAvQ+5x2ybKTtu54pNSGxXoXmmlXG4BmQlFjVcuJiUNbRBYeNH3Azylo8i
	oXMZvtllBUWdbosyzX2XzQGWFNYV7vFm8YkZCMTZk9cNO0p1oWpMxZymLEFS68ZIUzdJ2OYVzZ4pO
	bch9zFw7um2YBOFSiR83u8fciR7qKwN4dV/WqYENXZMZ1EhAZJtlOqqgyNNN1qcTvyLKq+SV19wek
	ihOJwMHQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tqU4S-0002Qc-Ls; Fri, 07 Mar 2025 10:32:44 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tqU4C-0064FB-VN; Fri, 07 Mar 2025 10:32:29 +0100
Message-ID: <7e3ccc22-0028-4cb6-829f-67d93cb5c14e@rbox.co>
Date: Fri, 7 Mar 2025 10:32:27 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net-next 2/2] vsock/test: Add test for null ptr deref when
 transport changes
To: Luigi Leonardi <leonardi@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250306-test_vsock-v1-0-0320b5accf92@redhat.com>
 <20250306-test_vsock-v1-2-0320b5accf92@redhat.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <20250306-test_vsock-v1-2-0320b5accf92@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/25 17:09, Luigi Leonardi wrote:
> Add a new test to ensure that when the transport changes a null pointer
> dereference does not occur[1].
> 
> Note that this test does not fail, but it may hang on the client side if
> it triggers a kernel oops.
> 
> This works by creating a socket, trying to connect to a server, and then
> executing a second connect operation on the same socket but to a
> different CID (0). This triggers a transport change. If the connect
> operation is interrupted by a signal, this could cause a null-ptr-deref.
> 
> Since this bug is non-deterministic, we need to try several times. It
> is safe to assume that the bug will show up within the timeout period.
> 
> If there is a G2H transport loaded in the system, the bug is not
> triggered and this test will always pass.
> 
> [1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
> 
> Suggested-by: Michal Luczaj <mhal@rbox.co>
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---

I think the credit should be given to Hyunwoo Kim, not me.

Thanks though,
Michal
