Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EE63AC24
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeqkDXwP"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1BD8F40201
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 21:59:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1BD8F40201
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MeqkDXwP
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CcYmDCQGQIwg
	for <virtualization@lists.linux-foundation.org>;
	Mon,  4 Dec 2023 21:59:08 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B265E40151
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 21:59:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B265E40151
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2F4CBCE0AF2;
	Mon,  4 Dec 2023 21:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BBC2C433C8;
	Mon,  4 Dec 2023 21:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701727142;
	bh=4akh1rC0M9jmWAqlssoPVtfX3XuQwBwyV+kVe6CKKoM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MeqkDXwP2g+C3IlQVxb2MPczoqWb43F58+S64DwRa0C96/RgSFeonT54QEStxdh5T
	 efgHyoYJwuk3j5QMp4YQ/6O6aZvtxLW0eFwAXV7caOtrs/mNuiACv0oTvfjl96Ul3/
	 dSkdHKQpdv4lM4wADMSUyb7ocOweooA8hzFzCPQc8cutUPdwIY5yeMqbgyY2/YH3VT
	 A4/J+XtkyIV3Xff7a/PRt4KuNJhtiRfHhUuuIQ8Bycq4fHYgR1UdvRAVDsha+u0+Ti
	 8fTzMY/VKrH7uhfCubpcbnX7Ja0nmJeW+rsjLy8Ryu+RIFnFpFadwCtA6+aLLMvGrN
	 wnGrnF89E0KgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58A6AC41677;
	Mon,  4 Dec 2023 21:59:02 +0000 (UTC)
Subject: Re: [GIT PULL] vdpa: bugfixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231204083808-mutt-send-email-mst@kernel.org>
References: <20231204083808-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231204083808-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: cefc9ba6aed48a3aa085888e3262ac2aa975714b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e535748449a51842872c46db61525f7524fc63a
Message-Id: <170172714235.21763.13703793577004715330.pr-tracker-bot@kernel.org>
Date: Mon, 04 Dec 2023 21:59:02 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, eperezma@redhat.com, jasowang@redhat.com, lkp@intel.com, mst@redhat.com, shannon.nelson@amd.com, steven.sistare@oracle.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 4 Dec 2023 08:38:08 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e535748449a51842872c46db61525f7524fc63a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
