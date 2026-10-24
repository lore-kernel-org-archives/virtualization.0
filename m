Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792801892;
	b=kLjyE8f37DJ/Zn96r8Es4Gzjk88uEhTvCMRX5/RyrbfvGXN5tvBSJExvDjOfLUvepWjH
	 gNmYA7ULpF3jq3N9pz/e+ti8Ejg8a85aHjXz3h9ejTUFuYLT4rShZsa1ZmQhDHM7Imvns
	 PApeTAV/zA/8Qz5LdixMTbqGXOtQ/ZDsH2HycFR4W0ROwKMCqkSlsfe1Mb+uzxvefjcIs
	 A1G5FBdohgnYKpotUB/DXauaB9UBdq+NzfeavOitrSSztDABZxVE6qfe9EcH+HL7JS8Ws
	 xyYfrNjVxAsvItFgw0vTS595V4lei/sgY9wFQq4JdB7NpoqQ+9uF/D5Ny3CTL9gIyFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792801892;
	h=Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=sjQeLM9OWjEhb6ijlYk2QLCQmlTcffG14fcVhLRT5jM=;
	b=DmcWxvWZqVZ9kdPIsf6F7V3q1sBGXzIf2mRCW+BuZV0qyfsGg14kntn1eTVGGog7rvOB
	 OKFqIVYbjpbgmd4mdPY3KZFbEVUXBPd3Sx3hmfD5VTFOlXfNfFcwpKhze/69JMQvYyOVA
	 MjxouQ1F3PKIex2qst4rwPyMmuA0zrouQuSwVc19BerUsKt2tMssAwCf6NQxDGiyhQOaL
	 bxJeM5mFNcvW1eLX1J8GIZ/34gLKFQz4VyBXGoznPShB36Q0Gw5Hc/atNbjs1Pdh++rp8
	 hM5au56Vsmu0OkDF+mKMhC0g5pS4c4v7qDhzRjcgkVR1U/2PmfVh0Tco//MjPkTcxbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2Z963Eo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.138
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECD2606A31E
	for <virtualization@lists.linux-foundation.org>; Sat, 24 Oct 2026 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2Z963Eo
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C40A18159B
	for <virtualization@lists.linux-foundation.org>; Sat, 24 Oct 2026 00:31:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.991
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h38VBAoVKzFm for <virtualization@lists.linux-foundation.org>;
 Sat, 24 Oct 2026 00:31:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D846780F5C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792801891;
	b=DHVGurqz2oOz8lnZkHvbo13SMI3f86DTSv9TcuPZla9f8LpGl2PSG2DrfV3WBKJ7ifT2
	 zl7vccpk4V2Ww6iXiNFnWaIiEfgJfW8Zc8ZFHw2pjfnjuV5A119XMHtCfehCB6jh9bsQX
	 tEiS0WvTO42jf1EtViJ8eLwhrGNZrFuORQTTe7E5YjVbogMHz20yZ5ZMf7vOvAuMiXOTc
	 2bOVotMGEhRWC/Zqd5PsVtsCvs56V2Qw4+SaXiprfR0jA388HmOihxQdj8Q7wfaGKqQD0
	 KxoM6Smq27t5xKz5kpKURTjI/g232zsSO4471NAch1260d0IQEKuKorn80gmnBsGBsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792801891;
	h=Received-SPF:Received:Received:DKIM-Signature:Received:Subject:From:
	 In-Reply-To:References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=sjQeLM9OWjEhb6ijlYk2QLCQmlTcffG14fcVhLRT5jM=;
	b=mZ5tOCfqCsMCB/bTML6SY44W+TOsr0gtSKRfx5zWk06cGsu2/zDXUgf0NKiCGTUrqHUg
	 t3d8tBFG/w5haC+2FO8v+wniQeTNweB7oXjpiQUN6tL+7C+7koZfMqHFeqeiYARg14ENr
	 qz3yKekiato3FKXg53tIabRFpnNxp0APflbaA3Xb0DBIUxz6Frkj+hH0ZJiRHowkX1pgn
	 hq6UGJlbhrcr8OmonhESYaOaZDJJvce2UUTHhINHEIV4r4Is9S+w5TQXUQgYXs2cWJLYc
	 4nlB8EoM76u4hJWmibsYld4yjI1HmlTFVfN8tx2YoazmhVQ+9S0xGONuw1NH4UeW7nA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2Z963Eo;
	arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2Z963Eo
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D846780F5C
	for <virtualization@lists.linux-foundation.org>; Sat, 24 Oct 2026 00:31:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7BD83601DE;
	Sat, 24 Oct 2026 00:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315C91F01825;
	Sat, 24 Oct 2026 00:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792801888;
	bh=sjQeLM9OWjEhb6ijlYk2QLCQmlTcffG14fcVhLRT5jM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=n2Z963EobQcaAOZKGzDdZvxvgd6HCizxNO87gixeKLH6Vvtq7NAiI5AEwLhNfUMFW
	 8Z2LfFAEaj+zTPBt45rUxUb1QcsYe2VyVKLT8agwDESOzojZ1efoJeSelJls9TuxXG
	 jByi6KMO+IQ4ghwJ8aQ7++3pdy51od6r+Wneo57CqdtdIUglJtAdQku4E9hiWIIKYQ
	 SL1xiWEU5n1+eeF7EZUB/WTUxlf6RrNSUao6zUr/7mQ5evN/mNMeX6crSnEtHbA5Sh
	 FJX5H6kJDS/96hbhngO3HFmwSkrES1hLWjsH8Ax/aWRsgWbzxCUR8t67ULqMS9jNGU
	 CpV5zBoYCHE0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 09BA2391B16E;
	Sat, 24 Oct 2026 00:31:28 +0000 (UTC)
Subject: Re: [GIT PULL] vhost,virtio: fixes, features, cleanups
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261020064022-mutt-send-email-mst@kernel.org>
References: <20261020064022-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <virtualization.lists.linux.dev>
X-PR-Tracked-Message-Id: <20261020064022-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: c69023b5e16e5ffe9368603dca76d85bd544ee57
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f2516f45b7cfca237f4d8e1c91c1f307e295dc5
Message-Id: <179280188679.1367831.7681253040178931221.pr-tracker-bot@kernel.org>
Date: Sat, 24 Oct 2026 00:31:26 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrey.drobyshev@virtuozzo.com, den@openvz.org, jiri@resnulli.us, kmehltretter@gmail.com, mst@redhat.com, ptikhomirov@virtuozzo.com, sashiko-bot@kernel.org, tanglongjun@kylinos.cn
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

The pull request you sent on Tue, 20 Oct 2026 06:40:22 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f2516f45b7cfca237f4d8e1c91c1f307e295dc5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
