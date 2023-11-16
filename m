Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A242630CE2
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBmwkGjI"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A8ED6F6A0
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 13:07:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A8ED6F6A0
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JBmwkGjI
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TsJzvkVOGoTv
	for <virtualization@lists.linux-foundation.org>;
	Thu, 16 Nov 2023 13:07:04 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 684926F687
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 13:07:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 684926F687
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1FC9CCE20A1;
	Thu, 16 Nov 2023 13:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2F81C433C8;
	Thu, 16 Nov 2023 13:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700140018;
	bh=p4MjUYmwNsoB0zXjL2QElamoa3NDWfUyYXsPy3eVInM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JBmwkGjIsSE1vcTsOpwTK1gUCAMeXbLozosp2IWfDBGlRfxi3kXwckKu3+iIZsT9N
	 vLqxMktN/9pUTIyq0Q81/B+sN/NxpIzqIt2YuEAxX3dScmd+vDHIHSzUJhrIHRUY7l
	 maZmdKKfKc9gpuIU6jQE9TgRk+iEYlcsyXwHtVg/RRw7+9x7pU8xTSlskLNbNC+N30
	 YmkNuaUA31R6ogLVckBmFCfLeQXY1vURh2Pii4GiTPLMBBrgYEur9cposQpME9XE/2
	 ivAR1q+kLEe6H98Gw4O3ox8dADglM+/H+TsizvaI/DZtgPbHcWk0tl1vAyCXvGcYY8
	 5AcippUo6AmNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90506E1F660;
	Thu, 16 Nov 2023 13:06:58 +0000 (UTC)
Subject: Re: [GIT PULL] vhost,virtio,vdpa,firmware: bugfixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231114152436-mutt-send-email-mst@kernel.org>
References: <20231114152436-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231114152436-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: e07754e0a1ea2d63fb29574253d1fd7405607343
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 372bed5fbb87314abf410c3916e51578cd382cd1
Message-Id: <170014001858.19711.13760886707112955163.pr-tracker-bot@kernel.org>
Date: Thu, 16 Nov 2023 13:06:58 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alistair.francis@wdc.com, bjorn@rivosinc.com, cleger@rivosinc.com, dan.carpenter@linaro.org, eperezma@redhat.com, jakub@cloudflare.com, jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 14 Nov 2023 15:24:36 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/372bed5fbb87314abf410c3916e51578cd382cd1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
