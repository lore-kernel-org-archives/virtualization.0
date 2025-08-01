Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB71D1A0712
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754084170; cv=none; b=fNcO/Z3uljCiQuyW/kDKEY/pFNH/MmftkSqY1A9vO4EyUzuVfHFh4XwuB/r6Ym2EyB56hVQkCPrN0iRg3xAjG9f7L6kKhWJxTTxRqWGTEM08SfoIjKiK0Ng2SskBqizd7ZEYyhB1SQHDGSlVI7jnqkOJdi+BVb4wc6cGAnN4HcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754084170; c=relaxed/simple;
	bh=OAhxtFG5/w7PuEcTCyyGE3DZIR3gPMJhst9cdG+Sii8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sZ37vIpJY6qojjLsxwtBPMW67dKWHMStF+nlDgcAtDOIHW+v0g3EI3voRwz0oxeJ9xtP/y8Xlvky6uvr0R8Bg0POac2ayjRONG9AjoEWeLeSxklgiWKoaRkdj8V9FQODk9S6JOmYcLdNgddjDZC+KPD+x80rkBcJLrsKBNoKjzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKbOGzXg; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKbOGzXg"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 847606119D
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 21:36:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n6f_IzLlHHwO for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Aug 2025 21:36:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 28EF56113B
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 28EF56113B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LKbOGzXg
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 28EF56113B
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 21:36:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 88323A5582C;
	Fri,  1 Aug 2025 21:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3145BC4CEE7;
	Fri,  1 Aug 2025 21:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754084166;
	bh=OAhxtFG5/w7PuEcTCyyGE3DZIR3gPMJhst9cdG+Sii8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LKbOGzXgxsPFW8TtF7VP1qfx/+sHCW+gx/mom/RaRml6ukmz1lpq/rjEGlVoP4HVI
	 M0GibQPDIEob8KYA5gikYNNvrQ9+6OH9tSatdzwdHZCOxip8I9wx0DFIL/HSQQZBAO
	 6s9e4PLoo7Y95EXKcghNJ3gZs8AqdnjJrXgZBflyIrd3P9ZXPxa2q2QvtMvRLtRkzN
	 S7n4RaG7sCWNx5io3KS4U3xzhlzKylo+NcAqQd8YE0v2+8/FNMpmsGUnrQPZza1Uc/
	 hEDW5+1Lit4nBcozsOGaF5WrPDxPeC7/zmuEi4Rkvw7SuLx0A3CR7/TVdA7/430OBg
	 ZF5fm4Hdqn3SQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE152383BF56;
	Fri,  1 Aug 2025 21:36:22 +0000 (UTC)
Subject: Re: [GIT PULL v2] virtio, vhost: features, fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250801091318-mutt-send-email-mst@kernel.org>
References: <20250801091318-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <stable.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250801091318-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 6693731487a8145a9b039bc983d77edc47693855
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 821c9e515db512904250e1d460109a1dc4c7ef6b
Message-Id: <175408418138.4088284.1058038045286020103.pr-tracker-bot@kernel.org>
Date: Fri, 01 Aug 2025 21:36:21 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alok.a.tiwari@oracle.com, anders.roxell@linaro.org, dtatulea@nvidia.com, eperezma@redhat.com, eric.auger@redhat.com, jasowang@redhat.com, jonah.palmer@oracle.com, kraxel@redhat.com, leiyang@redhat.com, linux@treblig.org, lulu@redhat.com, michael.christie@oracle.com, mst@redhat.com, parav@nvidia.com, si-wei.liu@oracle.com, stable@vger.kernel.org, viresh.kumar@linaro.org, wangyuli@uniontech.com, will@kernel.org, wquan@redhat.com, xiaopei01@kylinos.cn
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 1 Aug 2025 09:13:18 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/821c9e515db512904250e1d460109a1dc4c7ef6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
