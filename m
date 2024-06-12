Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC60EAE6
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 01:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718157499; cv=none; b=TZKYNuxplrIuL3g96dPAEJ7czXH22NFjPimuT/sIPAxElsbPiSewm93p0ENpC+O1CeY9UmrbC6lu1S1CMTz2dAAXEq4kXciA842uqYB9KrVnh3GALCKrtpBm6ZBodcQynNz0jHRq/X5tWWq2d8t9OkmZg0Uvl2KydlTWNsDEFS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718157499; c=relaxed/simple;
	bh=2bnaKdaynOx054pD82xWQVJDxU3JbEDxOintaWbN69s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvoZsik8c3EC2OaaCudQmZBjYpkmcy5+OhGgvzztfwnjw7qThsx4Ude49FBBKig2/PLxnTNSvlaRLmfc0bkD9gMqP37/lhCV7OMhgVF1mc9IDFuYbiYIkKyt23tfGDN/gXzAhMfAhaCAMV9r3D5QXvYIvIXMFJvAdYMijc0vtlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZBjx/gT; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZBjx/gT"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 67FD44056D
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 01:58:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BdMwnT9xVOr9 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jun 2024 01:58:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6B8AF402E6
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6B8AF402E6
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lZBjx/gT
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6B8AF402E6
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 01:58:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E00A5CE1F54;
	Wed, 12 Jun 2024 01:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA76CC2BD10;
	Wed, 12 Jun 2024 01:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718157492;
	bh=2bnaKdaynOx054pD82xWQVJDxU3JbEDxOintaWbN69s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lZBjx/gTHx9YKarrC8CvdwhFfBSzSxbGQip/VEVCmFRnPMWL635PuFcqkRgZJA9o6
	 xZt7O0tH6JvN+axGo9BD/RG9hdsVMnU4LIFc4+xp7Ya8f0w1c0nBs8uZKeBw1hO/KQ
	 vZBW6OXTQJRrdu460dZ/Y962uISetM+gYupq07A1+LUPoknCQpDPfUVzf2Ox9wrJQw
	 rDpj0uFoREv52sd8+/s+OuX/fhgl06Hz5XPS8pqM2wBb4jUAtvtwn5wuRNQS66+L1Z
	 cce51eJM25kJNW3YFSk/LpEy+Unmn9KR3ouo4JZK4MdCTgyrvb/JL2gFXBVx6jdpaK
	 Gb6qbKG2XLlRg==
Date: Tue, 11 Jun 2024 18:58:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240611185810.14b63d7d@kernel.org>
In-Reply-To: <20240611053239.516996-1-lulu@redhat.com>
References: <20240611053239.516996-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
> Add new UAPI to support the mac address from vdpa tool
> Function vdpa_nl_cmd_dev_config_set_doit() will get the
> MAC address from the vdpa tool and then set it to the device.
> 
> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**

Why don't you use devlink?
