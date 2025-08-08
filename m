Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245BE367
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Aug 2025 04:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754626110; cv=none; b=aZwFdj1e1shAMfuSozdXVbJviFAotJ4cfB/d1NeJ8YqNxo+QeH1MnePJQka+OWfoV1G6vu10NghkmqGT9YMDiu5h1SICOsll1sSVFyKSTt7zcGry2/Yce1D9m24GcA6ibf3xM93yQCIPf2H11TSJiKUFz13+ZGcHM7CJ2kVChlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754626110; c=relaxed/simple;
	bh=ljvdP6Lnfm1PY+j0GIMGtIa6gjo7I2ezz1+J9fW+I0Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NCh6fSfWbNW1G/NmXiCalHt1Dy84qDEbydgqqhH8u6XLTRZFTEBL+GC3hfHDjFA8xtS5OETffH00DFniLB2lDRQUR9QkefDfa4RYlFuEtFX9NJBaYeIaEJYTaGggYXiapyZM3j+Gue3qGYg5Aq2n0PCNVEC/AShvjGjFJ4XILVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ON9M83+X; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ON9M83+X"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB41140751
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Aug 2025 04:08:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xhRPf8ykN_H4 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Aug 2025 04:08:28 +0000 (UTC)
X-Greylist: delayed 548 seconds by postgrey-1.37 at util1.osuosl.org; Fri, 08 Aug 2025 04:08:27 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0658340730
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0658340730
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ON9M83+X
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0658340730
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Aug 2025 04:08:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B1693601E3;
	Fri,  8 Aug 2025 03:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A7EC4CEF0;
	Fri,  8 Aug 2025 03:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754625556;
	bh=ljvdP6Lnfm1PY+j0GIMGtIa6gjo7I2ezz1+J9fW+I0Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ON9M83+XrEhayMhNPS+DYqM/xZAX2QUjmvIaqnBANau7hdVbSbGjIVhuPSIgAxP1V
	 w4gcxgIWgpI9b5Dx05z610LcKh6LrRO7/lHz6LNwURJEyQhY9LxwT/e1UVfyaAVhK3
	 7YDzgBC6JgbtokQ2hTVMIBOwSxMuqI2dCKKK5ao8q45krvB5vCqZ6a+guxX9iYUdv+
	 9Ty6ayWsvv1L8S8p4xKETc71WaXqJ+QMUgrGyfBeYOMzFaBV6sIxqnhe8NmWJV9O/6
	 D8Bp2O/xORr9+ZqOnPcEbmDFo5C/MJnmqOqAI5JWN/6lXu0VUftAHilrHTElVcE/VP
	 KNUjcsNTEUpFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0CB383BF4E;
	Fri,  8 Aug 2025 03:59:30 +0000 (UTC)
Subject: Re: [GIT PULL] vhost: bugfix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250807084721-mutt-send-email-mst@kernel.org>
References: <20250807084721-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250807084721-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 6a20f9fca30c4047488a616b5225acb82367ef6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1e06c19abd2efbdd080047b2e70195c04ac2139
Message-Id: <175462556918.3795225.10405999923797232759.pr-tracker-bot@kernel.org>
Date: Fri, 08 Aug 2025 03:59:29 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jasowang@redhat.com, jhkim@linux.ibm.com, leitao@debian.org, mst@redhat.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 7 Aug 2025 08:47:21 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1e06c19abd2efbdd080047b2e70195c04ac2139

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
