Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D707935940
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Sep 2025 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818633; cv=none; b=aDJusLDU0XcnZlWm0WnpPK7alAXXDxnW/3h0jdg3RPv1QSHDAkQSE+x8uEv96JZH9adZrETfi5TzPBeUpQ6sz5kpNJbCCovW/9QuEAmbCsUrmlB4gHu3CoxZxKHaSSuzDKgNPXVYstm9cf+SW5eUHoXIowZSJWCc6Kk1MxJ75C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818633; c=relaxed/simple;
	bh=9tcBYDdZ4S6nbwrUFIFB3h4QO456zS81f4jRq6orFXs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=P/vgMxXRlQAT1u4WEte6JeQGE9+vLaafTa8cdzzMUj6vourlxat5uYw7XlN2P2numx2lmtwdiy0lSvnfLmU1hlKD3IZ/ifPvHTK034ST9YveNOsANlq5EyPzm/dGco+8Pa5YMx+pgZCNPYzFTNRnntMudB7l+rvw8yspxOxyYcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIWqlZ8H; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIWqlZ8H"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85AFE84215
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Sep 2025 16:43:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nbh9LqVAqyeY for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Sep 2025 16:43:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CC755841A1
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC755841A1
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tIWqlZ8H
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CC755841A1
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Sep 2025 16:43:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E43F343D33;
	Thu, 25 Sep 2025 16:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C267CC4CEF0;
	Thu, 25 Sep 2025 16:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758818246;
	bh=9tcBYDdZ4S6nbwrUFIFB3h4QO456zS81f4jRq6orFXs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tIWqlZ8HejUNKANLk/MejQIG4f/GpvCn/AESrfpzylBzsxhFqdnjwRwkLIZzi6Yqk
	 pHq9ww1nIRPbxalyOiv2W9QRxxt8jOMzVfDxRrFncI4MYqevMCkYHLM81S+eCvG45S
	 jCFlYDWhpGf5GTrk24CWmPCV/kw8nPlM5sBWL2KIsYkRpkvvrOvLOfEEge0emW4IQ9
	 H2qOij0Dj3PBFLiQWgaXPgrqzLN43MwGNKY+Kxb6msaVyGtkb5LrTH1lMspRdDUUAZ
	 cWgnfnNqxP/z1KriQhw1WGFNK+xZwNCicT7Y83tCN3rYzN5a7zVTWKTTdJAqYwgEiQ
	 7gFXWkmoQVb7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB13E39D0C9F;
	Thu, 25 Sep 2025 16:37:23 +0000 (UTC)
Subject: Re: [GIT PULL] virtio,vhost: last minute fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250925091012-mutt-send-email-mst@kernel.org>
References: <20250925091012-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <stable.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250925091012-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: cde7e7c3f8745a61458cea61aa28f37c3f5ae2b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93a274456158f178aa713fbb60642e0094e6065e
Message-Id: <175881824263.3435360.2694015779934794373.pr-tracker-bot@kernel.org>
Date: Thu, 25 Sep 2025 16:37:22 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alok.a.tiwari@oracle.com, ashwini@wisig.com, bigeasy@linutronix.de, hi@alyssa.is, jasowang@redhat.com, jon@nutanix.com, mst@redhat.com, peter.hilber@oss.qualcomm.com, seanjc@google.com, stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 25 Sep 2025 09:10:12 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93a274456158f178aa713fbb60642e0094e6065e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
