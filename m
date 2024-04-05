Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A342316D4E1
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Apr 2024 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322791; cv=none; b=rxTX91l4NN/5rEWxIiNVPtZP2eZHZi8CS+iTRX1UNWnsGkliGlL6+OrpQlgYhJyIUBq5tkNBdoHiWI9/J0biT4g6kESlWG50AgQfWMWL6ryxAZNk++z9hwi7qxPzOjxXStk1OqWR4yyV7mWRchFn6kuU6cjva01WtEfavkxJUxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322791; c=relaxed/simple;
	bh=VEyed/ecHyBqgaA8v+Xe6IFTwm1TtgE9SEoK//nPgEI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Tigg3BDVGwHSnxP+tVkFpS+YO1mhPv/kC24UVcNfPQitQmZKguORJY5FUxRh3OdR5fTkAVQDOMFW5s8qnEI8B7fHe4hLsNXegkf3UuXrfILPYlHHmdcers81tCth9lSCFmTndLTZMVHs0hHZ+nywERLx1kH1ZOHHCkKCjdB9JVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tx+q/GGZ; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tx+q/GGZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42EEE60AF2
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Apr 2024 13:13:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sgs7j-sNV3Dg for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Apr 2024 13:13:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=mripard@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 978996064E
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 978996064E
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tx+q/GGZ
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 978996064E
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Apr 2024 13:13:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1EF1D618FF;
	Fri,  5 Apr 2024 13:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925C9C433F1;
	Fri,  5 Apr 2024 13:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712322786;
	bh=VEyed/ecHyBqgaA8v+Xe6IFTwm1TtgE9SEoK//nPgEI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tx+q/GGZxrVngkwOS8gFgGmvPhKZBJty9/r0v9W6KxDR4q7LW2DKE/90/6iTg5Lpp
	 khAQFoyq/950o5C66xexkrWnwTvP9ODsID+Ue1i2Kg+Mv1j9EcEGzJ0NUdcMlCC0h8
	 o0QgSPnKlDtSyjET8kvChwpZfv+mgx7u5mwgGpTq5YV7IWNGuxzVR8RZhrM4WLEYNn
	 48DvvijRxSE+RtmHTq4kDEZGuUhBuKTYG3ORkecEMwB9cUoVgjRDTMewTF6kagtQWR
	 n2QLnkWlXXRJlMrflacttX1VbthH0jqld+PFv69b2R3OznwDng65dX6XH6yNARcGo7
	 MfNIIZDZbJHzg==
From: Maxime Ripard <mripard@kernel.org>
To: Alex Constantino <dreaming.about.electric.sheep@gmail.com>
Cc: 1054514@bugs.debian.org, airlied@redhat.com, carnil@debian.org, 
 daniel@ffwll.ch, dri-devel@lists.freedesktop.org, kraxel@redhat.com, 
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
 regressions@lists.linux.dev, spice-devel@lists.freedesktop.org, 
 timo.lindfors@iki.fi, tzimmermann@suse.de, 
 virtualization@lists.linux-foundation.org
In-Reply-To: <20240404181448.1643-2-dreaming.about.electric.sheep@gmail.com>
References: <20240327-cuddly-smooth-trogon-59c02d@houat>
 <20240404181448.1643-1-dreaming.about.electric.sheep@gmail.com>
 <20240404181448.1643-2-dreaming.about.electric.sheep@gmail.com>
Subject: Re: (subset) [PATCH v2 1/1] Revert "drm/qxl: simplify
 qxl_fence_wait"
Message-Id: <171232278434.15085.12649965715947984950.b4-ty@kernel.org>
Date: Fri, 05 Apr 2024 15:13:04 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 04 Apr 2024 19:14:48 +0100, Alex Constantino wrote:
> This reverts commit 5a838e5d5825c85556011478abde708251cc0776.
> 
> Changes from commit 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait") would
> result in a '[TTM] Buffer eviction failed' exception whenever it reached a
> timeout.
> Due to a dependency to DMA_FENCE_WARN this also restores some code deleted
> by commit d72277b6c37d ("dma-buf: nuke DMA_FENCE_TRACE macros v2").
> 
> [...]

Applied to misc/kernel.git (drm-misc-fixes).

Thanks!
Maxime

