Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B632D287503
	for <virtualization@lists.linux-foundation.org>; Fri, 13 Feb 2026 20:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771013887; cv=none; b=rkHDy5XeTlfIBY3J8FpoMuhFnV6kGjHM6oLhSYRiSWV792LPdBHGdQd2L8Cu2It09E7g5OZ2EhloCztKVGDpm30x74dagw2B/IstxGRocxOuXvPUJcJVsIm6hjeQs4CBlowi5/pt9KIDGZOAeJXheQ2Pea5BjePogfnFOIbCU90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771013887; c=relaxed/simple;
	bh=HMsprEr0dyBLg0uFzoHbSkfaujjhcOnGu3Pvq12CrGc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HZHKpZcfUnayUVVzt9v3XSrs4OYyIQhiGCMx2UWzyoZRXqt9yHpjETGL7q/DzP5Dsskkl2Yrcg5TIhT6tqQUk0s25pBup4N0ScPrSBx87Dtr6uDcwsMmKGFTc6JAUKKO869wtTwCcW5bfa8wCleKMBP3wwFRdGjsUN49iCl7kMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/fRggaH; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/fRggaH"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6710D60699
	for <virtualization@lists.linux-foundation.org>; Fri, 13 Feb 2026 20:18:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 643_3WK2SfoQ for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Feb 2026 20:18:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A2E9E6066C
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2E9E6066C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N/fRggaH
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A2E9E6066C
	for <virtualization@lists.linux-foundation.org>; Fri, 13 Feb 2026 20:18:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2CC3C40AE7;
	Fri, 13 Feb 2026 20:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3AAC116C6;
	Fri, 13 Feb 2026 20:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771013884;
	bh=HMsprEr0dyBLg0uFzoHbSkfaujjhcOnGu3Pvq12CrGc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=N/fRggaHx9S5tzgpnzVbwhhrR4yvNwkpv2HNG2kr0t7eWx5JowEVQzjSNdZ/KIqmC
	 GoajvbE7j2XJiR8uA5d9+TLZHvOwT/iDbbsJdfd7A1a+W/JOWcwbE6jILRHiySuQEd
	 Akv7PBzgcdgDo95aLonHfvOCS/fIBV4fGIfKsoFF7oEkNZALx4M/LCm8maVUvZOpK/
	 3eN44T9LYVVWIfdswr6vWnLcItzH+caw0K8PqwAZsLg/fg/m0X7EXpJhG/HemiWS6P
	 y/+QDzUq8VYDOFWpydVGUy89qQBg7qCUk3OJ7O9T7dotTpAp22vo1g3UG4zWEoMlrX
	 icyMTJBWqGVIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B0AC3811A44;
	Fri, 13 Feb 2026 20:17:59 +0000 (UTC)
Subject: Re: [GIT PULL] virtio,vhost,vdpa: features, fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260213050602-mutt-send-email-mst@kernel.org>
References: <20260213050602-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260213050602-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: ebcff9dacaf2c1418f8bc927388186d7d3674603
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a353e7260b5951a62dce43630ae9265accd96a4b
Message-Id: <177101387763.2542361.9540347559826877081.pr-tracker-bot@kernel.org>
Date: Fri, 13 Feb 2026 20:17:57 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, bartosz.golaszewski@oss.qualcomm.com, bp@alien8.de, eperezma@redhat.com, jasowang@redhat.com, jon@nutanix.com, kshankar@marvell.com, leiyang@redhat.com, lulu@redhat.com, maobibo@loongson.cn, mst@redhat.com, m.szyprowski@samsung.com, seanjc@google.com, sgarzare@redhat.com, stable@vger.kernel.org, thomas.weissschuh@linutronix.de, viresh.kumar@linaro.org, xiyou.wangcong@gmail.com, zhangdongchuan@eswincomputing.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 13 Feb 2026 05:06:02 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a353e7260b5951a62dce43630ae9265accd96a4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
