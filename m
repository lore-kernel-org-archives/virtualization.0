Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB1C287268
	for <virtualization@lists.linux-foundation.org>; Sat,  4 Oct 2025 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759601912; cv=none; b=AMv5kOM0SBO2d4jCjDwTWWj6iFnIc/mMr1Oc/1IxRENaG4oGa8hv6LToFiQKNdSVMdzTSVdC39+ShRAzjgfIyjzHGr+cB7kCuV/88LRtiTsSfS3u0GmVBkTWiJHuix5iKTEYth750RQr3cwj3V3EhUdGjhjpdXCnrzs8MF+cslQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759601912; c=relaxed/simple;
	bh=9DSDvi20syE4S/9NQ+idEY3W2vXhnKSx/nttmOpTDx4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GFKM5VVa9dQD/vKolnE8AB7moYIHbU1NoquwCLsVN414P8FriSlBgoBBWVyYkSh3GuycwqKj0xlHaIRnn/T5k66J8etzRX5fi9IlDvcg0+4v4YRppWXexONUI2fzrl+VoBO5szBk+aofiF4irZd9dFb3aIlFKUV3LEaM8uEl5kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSRrfV9m; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSRrfV9m"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4EB3460BAA
	for <virtualization@lists.linux-foundation.org>; Sat,  4 Oct 2025 18:18:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1pxFWboFD6NB for <virtualization@lists.linux-foundation.org>;
 Sat,  4 Oct 2025 18:18:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A019160B9F
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A019160B9F
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cSRrfV9m
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A019160B9F
	for <virtualization@lists.linux-foundation.org>; Sat,  4 Oct 2025 18:18:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 05848604D5;
	Sat,  4 Oct 2025 18:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A880FC4CEF1;
	Sat,  4 Oct 2025 18:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759601908;
	bh=9DSDvi20syE4S/9NQ+idEY3W2vXhnKSx/nttmOpTDx4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cSRrfV9mmTTVKN4fc0CviumXfOHJG7PkAJL5PsnHjpJH0DVDmAjrlC8CequpCRr1Y
	 y+cqs+9+eI+hKJd+HIabZEXaI0zf2k61l8i6wLwE97lqZ3G4R7KEoNqeFso++HynkQ
	 T34fyb7CsnFa7adDsDqmj/xQwS3N9l29ng/TI7REBY/s4QQ1LfSBbGW26GWbzLwtge
	 Tb8UvmSecRTqLz4rHKG8fGwPRuSszZqlx9J1xOEzAIDtPgA/weUFUNZvr73Rjap4Mk
	 C2lAapC5IFsaJKiE8Y9u06s4Z+K/izj82zZcbGo4ZT2E0ehkSRwENLeCLx/Cso1g4m
	 9OmviVNcn7Mlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD4639D0C1A;
	Sat,  4 Oct 2025 18:18:20 +0000 (UTC)
Subject: Re: [GIT PULL] virtio,vhost: fixes, cleanups
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251001073158-mutt-send-email-mst@kernel.org>
References: <20251001073158-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251001073158-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: ed9f3ab9f3d3655e7447239cac80e4e0388faea8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf897d2626abe4559953342e2f7dda05d034c8c7
Message-Id: <175960189917.404121.15074893987937595842.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 18:18:19 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jasowang@redhat.com, leiyang@redhat.com, mst@redhat.com, rongqianfeng@vivo.com, sgarzare@redhat.com, sheng.zhao@bytedance.com, zhangjiao2@cmss.chinamobile.com, zhao.xichao@vivo.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 1 Oct 2025 07:31:58 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf897d2626abe4559953342e2f7dda05d034c8c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
