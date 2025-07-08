Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2AF2066F7
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Jul 2025 01:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751938659; cv=none; b=hkY24XhVUQ6z9bfIWPCaNlvT0aGB7mZ9gQeqf+jjFPvWxC8EJCLeqktvl4GNpdCeZlg+bnu4fGqEK6380DVCcVNSIqHTIa2Ne16FlahI0VwcDqZvnC4E+dNS6GiBObqRvcgnKsFm9pM+chozS9B0+HwfXcGeaKAwqHTxsdOBzsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751938659; c=relaxed/simple;
	bh=0/e0f/iH5qAnC0FrVkBoQWY70peX3hblYE56Ge41Mek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ll4pz4lTgXoj/s48YQ5pSQbQBPXNpt+FCwRfiMBYBHhXaFzakajriF7H01BYwmGXG5eXFUtPs/gTylv9neDlwwQ+yzcIZ1TVeH2FMdlwILBwgWaL0ZDxvKMnID4B4HSmclzardW6PF2Mf8KHVUFxtj3rEEuPAuqFj7cRL2DpXng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKCR0Vap; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKCR0Vap"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B8D6606CB
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Jul 2025 01:37:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rIesQBWDUDFr for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jul 2025 01:37:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AC2B661022
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC2B661022
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jKCR0Vap
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AC2B661022
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Jul 2025 01:37:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0B73C61126;
	Tue,  8 Jul 2025 01:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB00C4CEE3;
	Tue,  8 Jul 2025 01:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751938654;
	bh=0/e0f/iH5qAnC0FrVkBoQWY70peX3hblYE56Ge41Mek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jKCR0VapSS1zGE4Tc+APcWxosUmIwqlOR9+T8vWqOFOu/nE7+JLgXkw7FdfEjUSkO
	 SiMK2VOcMAAQskVP9s0XHQqIG6V1kJK2TD+xQQixtEwAgRswaz3GVyfwd6btcPswkO
	 8bNp9z2vp4csEoYGd5sc5B0ztfjZf3VQ6qFI4qiaCY4sVS7rflmwUr5cHRRFW4n/YB
	 9nnH2LWWGmwykIljbhw5BijxupwiUTrc2RX30h5T1L1bPs+B1HbO3DcgII5cE49fhI
	 0zEZu1Q49UnHIx0GBsaKmUwGcw/6GKxil2gntz+fTOimLCq4yysVbcI/99YA0mHWuT
	 jLV/0nT8x10rg==
Date: Mon, 7 Jul 2025 18:37:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: liming.wu@jaguarmicro.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, angus.chen@jaguarmicro.com
Subject: Re: [PATCH] virtio_net: simplify tx queue wake condition check
Message-ID: <20250707183733.4088e82f@kernel.org>
In-Reply-To: <20250702014139.721-1-liming.wu@jaguarmicro.com>
References: <20250702014139.721-1-liming.wu@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Jul 2025 09:41:39 +0800 liming.wu@jaguarmicro.com wrote:
> From: Liming Wu <liming.wu@jaguarmicro.com>
> 
> Consolidate the two nested if conditions for checking tx queue wake
> conditions into a single combined condition. This improves code
> readability without changing functionality. And move netif_tx_wake_queue
> into if condition to reduce unnecessary checks for queue stops.

No longer applies, please rebase and repost if its still necessary.
-- 
pw-bot: cr
