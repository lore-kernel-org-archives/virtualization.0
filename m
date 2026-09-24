Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02164A3F00;
	Thu, 24 Sep 2026 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285345; cv=none; b=TdBcS9cHTdVLfY3DI55FnJc8Y1IiKk1uispGGA1Tve64pE7uPPxWwQU5v5fTwfnzgVyS5B9Jm2rsuVJCr4muJELSr6QDSP8XfOtlMwtMIL45JAT7Gzipgk2Z+5mR/M5lwT0+oEsRaM1s6tTWyjpGUw84lTxE0oS+ncMDfAZOWBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285345; c=relaxed/simple;
	bh=om+RJ+QXspKaejPVoSHZ1TuCE+tX2EHu5TiJ8vNtiaM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D+MO8pAYsWZlcxujde541/YRfAITndvcd2VRQigq68zvn37R0h1ZYwXt4bOsLaYDMvsmjyMCLtXVmAUttPqKS3A+qYBxZAXctair/AacN3Ihw0NHSDrFubavAIZzqGGCrSGY5hN0B5ZqW4VlUiW5IH53q+3EaTKMv6ZWtSZ5dtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=EVWS7L0E; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="EVWS7L0E"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x9qzu-00A25I-P9; Thu, 24 Sep 2026 23:28:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=zq0Yypkw+lCWYBwte3egR/lX//BzxUvq+dS6Cvr3pFc=; b=EVWS7L0EnvzZF+AWua+jffUkis
	mxpz7gJ3g/F/9kpKyuTt4dzt+I9bH1EBvNBw0fBUPF6q00NLdbBfHRMquT8eYJML2ilpqsNq3zYMt
	ztXp07gBmoWbAMySbrXsv7w+LDqCkszdpxo95aSXL3E3a84hh0SMfbfMgaNTZC8jd+Gkpjfliaab7
	lw/2+DdkWjrunt2s77jWJtlEFKTd85TCgRsLy5rv0g2xT4Nrg0dYob+y9PE7RFQ9+kz9Gd39cMrtn
	3dBU5LxycL17taFLxjy0t/QpQzeBckr9tBe+XN+76FJ7iVQLguQ4CaJ/Rzq+8qf1ld7h1SL2E0Hug
	gf3nxfNg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x9qzp-0006RA-Dc; Thu, 24 Sep 2026 23:28:49 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x9qzf-006JgX-PI;
	Thu, 24 Sep 2026 23:28:39 +0200
Message-ID: <fe215c10-b8f6-4e3d-b542-325a15ea1ba4@rbox.co>
Date: Thu, 24 Sep 2026 23:28:38 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net v3 7/8] vsock: handle listen() racing connect()
To: netdev-bot+sashiko@kernel.org
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, davem@davemloft.net,
 xuanzhuo@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imv4bel@gmail.com
References: <20260922-vsock-connect-reset-closing-v3-7-78907b8200d4@rbox.co>
 <179025570873.2160803.3404632155755678732@kernel.org>
Content-Language: pl-PL, en-GB
In-Reply-To: <179025570873.2160803.3404632155755678732@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/26 15:15, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> ...
> Would it make sense to squash this TCP_LISTEN check into the commit that
> introduced that WARN_ON_ONCE, or otherwise mention the warning in the
> changelog?

I think it's easier to review as it is now.

> [Severity: Low]
> Should this patch carry a Fixes: tag?  The sibling fixes in the same
> series carry Fixes: d021c344051a ("VSOCK: Introduce VM Sockets"), while
> this one has only a Signed-off-by.

Yes.
