Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793926639;
	b=AY3WUXd43DSDkzBwDIRMThFN9eljBpHa+gT9n4TltfZwj4LiBpsI8WHP7Kc5z3FxJ80q
	 esADHy5PxcuDjm9sFfhsGYlZXHJgpHZC3yNO7N+2d3oat1rPBIlcFBaGrX0+NvV2cXAuu
	 8bvrwV1skPvy++yFrQEzwoSJMrQ5fGpjFxxqwQCLJrpSoxLkKeci2Gu+yx5IN5hom0Q86
	 7NTXeHUxlimf2hTp5bcIdXP9AVvDN/1pNo6Q09BGmYsYB3m08LJu7bQ6cTagFLqG1gJ01
	 uTEXUThjpJ2Xl9pz3t93LFFfK8TV9kkhy363oDJdB3RC+5gGg3lvKjtXeoKlc9uaaHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926639;
	h=Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=7fNxTmo1iJxAalqGfiJl8NK5T396HgpYiPcomm03E7g=;
	b=sR099MIxdq8DrEhIXiA87qHsPj0VRX66ckmc/WMNcLrZzHz21nHTD4O5w1GS+4Nn4Q6g
	 IjOCoHstvXQZK8AQsyZWTzGJpErnF7Qvl6Uiymxi8/xqwd54ub7QitWTxvbr3y/WMQybJ
	 ZfBwgJt0NQVhHLsJz54H8xJJR5vLGEY2ZX9LEF0HIU7n5lCMovH4qV0K+o5gvLbPG/8up
	 Jpyg9qEwKYOEQIMNw9vfMPOvQOAD0d3cCjsYOSCKHtpfWxFJorUfl4uokcribQcvGQYj8
	 zvDSR0LGL0N99Fju0NCLMYQWtQJ2eWOlBNfIKt7KVVCe3RMkkrZ6ZiqMhqwRTqLOlTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MberW9n1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.138
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65517606A328
	for <virtualization@lists.linux-foundation.org>; Fri,  6 Nov 2026 00:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MberW9n1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11E1F80DA1
	for <virtualization@lists.linux-foundation.org>; Fri,  6 Nov 2026 00:57:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.651
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9-Ww1X4QSPaH for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Nov 2026 00:57:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 199B780B97
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793926638;
	b=RoBMTKPVBV0iRWp4PAX5o7AlIHpun+Wn0JfHyRnSU2wrRGIB8itTDVenSaMsEUn6Tt2R
	 i/auLHNaBi9ebwEdn+5VxqsBEU68lz/Mnp5VUS1hlqZiQyi3UdAKXRpalmonLOu10RKjv
	 jn5lhUrIBkpH2x8qoKP4QCbcgltBkTUOm4xxdLfYQXiEoKGWhglrgGDQnJAU7FGjISvnX
	 9Qd08bOKoVtH9sBLd+0LWnOc+f8aQAwj0fbzvHIc6IwOZ6Z4DQJ7/cdrHnkpcyhemyPSb
	 ZFJFvGhgn8fcK1NTQQywlDUGxO6I55KJ/FZCZzipFyBqplAmXCjnefWyHY+yb6HrS1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793926638;
	h=Received-SPF:Received:Received:DKIM-Signature:Received:Subject:From:
	 In-Reply-To:References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=7fNxTmo1iJxAalqGfiJl8NK5T396HgpYiPcomm03E7g=;
	b=Ts02gaGxJMG6KND1bMgQ0ZjTeSCvCAGuuxkjKJYlQMj83fZ3+i5gZft/E3ZHhr1XzfZe
	 up7q4G6NVWSV/t8Ginw6T5UN1AaJwNtJFf8BOMSCX1WErmmAO9zVQMbrpsQANwUZK0brK
	 oYYf5ASwWXqG1Z5pfltC4fcPWFQaCGQKMpjRhl0bHgSCQwKQbwukFNyG9vrgesqr/75hR
	 +OoYyjBRDOxTxCNmzDSe33+RKcp8cTIKIJakEnM1RbomI7Yy9AQlAaCR2E3qCdySFW7ah
	 19KIyjgN9qoRTl3Vlj8XvdbAetXg1hIuZhAR5z0Lvze09ba0bkmAdyta6BjRZLfmQAQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MberW9n1;
	arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MberW9n1
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 199B780B97
	for <virtualization@lists.linux-foundation.org>; Fri,  6 Nov 2026 00:57:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0D76A43AF0;
	Fri,  6 Nov 2026 00:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A351F0089F;
	Fri,  6 Nov 2026 00:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926636;
	bh=7fNxTmo1iJxAalqGfiJl8NK5T396HgpYiPcomm03E7g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=MberW9n17EZW4JlwHg7V3W2ZtrrnmWJZJwd5mtDOUt4gkSqspi6hiq2lUAbh20wMI
	 rFqBlTQbht0+DqdtjOuN0SmjyEXbBZuLJoOEBOhsuMPw947OvgOtUtQ1DSF/r9bcfj
	 jfPS2xcTdyOKwzwT2S2xU/hIBHVm2AtyCalEnBOlBIpZ3tC23W8ZtJLLbnxF9ax6nN
	 h55b3FV4Vbss7w5ODyoF/SwwbSZ5vFg4fCMdugmp4oJc/2nejeb/0Nu8RXnzmhgLrX
	 /+6BYha2HZanVKCEFyQHV4pcd91eQnyc1DXTb6/pKN+uTUAxK3zV1vLQ8stm7ZWGn5
	 oFwmv9LsdOSZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D85E2391B1B3;
	Fri,  6 Nov 2026 00:57:16 +0000 (UTC)
Subject: Re: [GIT PULL] vhost,virtio,vdpa: bugfixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261104081535-mutt-send-email-mst@kernel.org>
References: <20261104081535-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <stable.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261104081535-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 1a577f9402c1780cc1e663f48d5dd54c02051b09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69e2b55fc3b4fa3639b8c320374c255f046ddda5
Message-Id: <179392663544.268614.18316121610882837897.pr-tracker-bot@kernel.org>
Date: Fri, 06 Nov 2026 00:57:15 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 2312891301@qq.com, blum@kernel.org, co+6dcbccedc9ec6452@bugs.sh, eperezma@redhat.com, fangxy@xiaopeng.com, jasowangio@gmail.com, kmehltretter@gmail.com, linfeng.sun.dev@gmail.com, lirongqing@baidu.com, longpareto@gmail.com, mst@redhat.com, oss.patchbox@gmail.com, p@1g4.org, phx0fer@gmail.com, physicalmtea@gmail.com, sergiiushakov@google.com, shubham@octane.security, stable@vger.kernel.org, stjepan.poljak@gmail.com, syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com, tavhadia@gmail.com, tjdqudcks0424@naver.com, tz2294@columbia.edu, xieyongji@bytedance.com, xmei5@asu.edu, yuz08559@gmail.com, zenghui.yu@linux.dev, zhaimingbing@cmss.chinamobile.com, zhangjiao2@cmss.chinamobile.com
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

The pull request you sent on Wed, 4 Nov 2026 08:15:35 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69e2b55fc3b4fa3639b8c320374c255f046ddda5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
