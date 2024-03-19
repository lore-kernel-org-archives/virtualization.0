Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CEB1CD24
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865942; cv=none; b=a5UPoGQlYhXNowGehg04U2uzF6WDvxFTsTWgXxwP3tlePqwbXaYhzaXWEdC/T4zPSx0Su1vbBGcWOQdr5//f/liXZ3NuFzPZW1SpRVUq0cKKDCUFI+JVyk5iCXUuqEEyzyRRLSVERI/X8rsoHdMNsNshJwOUOJeGjmNdyAQYKt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865942; c=relaxed/simple;
	bh=dlwS+ClYwtdCIhyRMHsdbtRf3zIzcBodhDuKwd+a6r4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WgIbyIbWSmXt7j2P+mdZFzsQoGSs/2kbVpnfrqaudFC1cZh10QdZpgnv46E6dzrargSxzhy99WvwfXsvg5BCwvfg5xJVGdVR4lPS3LmOJ3DQT093hyWABptAokqTLd2NV0en5bNEKlrGP8ldP1kLo2/zdHDZQG46CkEZTctnz9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqafG1FO; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqafG1FO"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2543F40BD5
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 16:32:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lRLRvAHV69nP
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Mar 2024 16:32:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1D3D8403E5
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1D3D8403E5
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KqafG1FO
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1D3D8403E5
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 16:32:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D3816CE0ECB;
	Tue, 19 Mar 2024 16:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07641C433C7;
	Tue, 19 Mar 2024 16:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710865935;
	bh=dlwS+ClYwtdCIhyRMHsdbtRf3zIzcBodhDuKwd+a6r4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KqafG1FOkpQ1tdSHmOM60N3qo+kOfsYOfMeSna55txX+1i+AeJRYBB0RLCBBwOJdA
	 P8Zl+dfevApg/fTIQzEwgyrWb/g2LivLHaHjVjnZFHXDxLpRR2hihs7OGrSZFFdDZu
	 e5szhg4Z+P6J0PAnAVAfHnj08LTiNzpKMxgC3V17cKU2TMawKIrDohePcxHoPclan9
	 sWVA46+AnWm6O7WR0Mlcw01n+EU7qeyguE34jiW1OrK+VUxpCQkbTmaph2xrv0bs8s
	 Y6KXl7cKjswa3L4uxlA+jknT5YRY0Woznmtz8Ldre8Uh75/h0QYeGzPWtD9aVospJA
	 P6DpI9lV8tBtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1E92D84BB3;
	Tue, 19 Mar 2024 16:32:14 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: features, fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240319034143-mutt-send-email-mst@kernel.org>
References: <20240319034143-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240319034143-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 5da7137de79ca6ffae3ace77050588cdf5263d33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d95fcdf4961d27a3d17e5c7728367197adc89b8d
Message-Id: <171086593498.7768.14462757833782378841.pr-tracker-bot@kernel.org>
Date: Tue, 19 Mar 2024 16:32:14 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, andrew@daynix.com, david@redhat.com, dtatulea@nvidia.com, eperezma@redhat.com, feliu@nvidia.com, gregkh@linuxfoundation.org, jasowang@redhat.com, jean-philippe@linaro.org, jonah.palmer@oracle.com, leiyang@redhat.com, lingshan.zhu@intel.com, maxime.coquelin@redhat.com, mst@redhat.com, ricardo@marliere.net, shannon.nelson@amd.com, stable@kernel.org, steven.sistare@oracle.com, suzuki.poulose@arm.com, xuanzhuo@linux.alibaba.com, yishaih@nvidia.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 19 Mar 2024 03:41:43 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d95fcdf4961d27a3d17e5c7728367197adc89b8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
