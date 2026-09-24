Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B493EC82B;
	Thu, 24 Sep 2026 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285273; cv=none; b=qACGzEr1zKBKPrRRxqitg3UmcaffXk4S1LtCe9YYOv0mcYW2Xm4ltZKFIzLEJZq2rPxv4KhtxIDeC7kUvdA7b0PRQtpk+O679nCk4+3PtO9BepTmHFXZZlKVgimqXznmyWlWtHrhd+4jOmlMqnqhkpiT2nBhaRFbdxtW4mIIuYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285273; c=relaxed/simple;
	bh=1zHAnH+umV1L8En3XVT+LSTrQHaSKX0xHUSYjQWoiLo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qofBwEeQOXailCZ3ZmTzfYStLufo4mGJrnTYMRa/5SZIfF6LAMu0VGxRmXmE5EbzqDEtqkvA5zSHEscQU3roRADMu/Lt8wIvWO9iDPfcjTtE41tD/7CxUQ85ZWXldUjAVYll00DlQ0swUCe7ziZDomaH8cTIvSjrAW/zqaFl+40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=eyf1r5mA; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="eyf1r5mA"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x9qyl-00CkCZ-Kx; Thu, 24 Sep 2026 23:27:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=tGlJKDqmPFMEFHThxe627EIkqKrm5WZ1IFuaT9TyLzM=; b=eyf1r5mAEwAl2hfabVqkoQMQ2q
	xUCKOzD0Casr+kGospDDCdPxRPNQexUDChQXAIECGdYLUGeppCDGtXiF0vIHb4CG5bF9sJupY/XXG
	uIHJaOwqwbT6OpVqjcIisIeb5/Q083Ff9kNMSLcpO7sSxOVBB6BZu5OBMCXdz9wOgFm91guW9tn6/
	6FH/itkv50SXTzd3x+mJpyo+4txRIcdyUpJgUtDSKL2it4uNf1lU/zTRWGBtL8+4sRB0Z+vjwYqIp
	5B0qEtUxSiBdXmZ9T3XkKds9y54VNcrya2DlmuITHRwhXwWwrLwoLvzsgidWoTtcKLjcdaPcXE55W
	tvnEgPOw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x9qyg-0006Mo-Bh; Thu, 24 Sep 2026 23:27:38 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x9qyc-0058Im-ML;
	Thu, 24 Sep 2026 23:27:34 +0200
Message-ID: <4cc045be-3c58-4b31-86e2-f06d6ecb2177@rbox.co>
Date: Thu, 24 Sep 2026 23:27:33 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net v3 4/8] vsock: drop the re-assignment logic
To: netdev-bot+sashiko@kernel.org
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, davem@davemloft.net,
 xuanzhuo@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imv4bel@gmail.com
References: <20260922-vsock-connect-reset-closing-v3-4-78907b8200d4@rbox.co>
 <179025570429.2160803.6079312973703621422@kernel.org>
Content-Language: pl-PL, en-GB
In-Reply-To: <179025570429.2160803.6079312973703621422@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/26 15:15, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> Is the invariant behind this assertion always true?  The commit message
> says "On a failed connect(), transport is de-assigned", but
> vsock_unconnected_reset() can return early without de-assigning:

Addressed in comments to patch #3.

> [Severity: Low]
> Could the new precondition be documented?

Yes.

> [Severity: Low]
> With this block gone, two comments elsewhere in the file still explain a
> load-bearing check in terms of reassignment.  Should they be updated?

Yes.
