Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B08F204095
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Nov 2024 21:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732743631; cv=none; b=ZJ5tz3gRzdX/+uhwuTBxFMTGf7RwAjT+/XOQCJ0h5CTgdyu91IcU6vJADWqW2ddZd5/5RsAMaLY9t20hjVebBGM3RC/Z8PQ+B5avjo10i4ZTbg1B1+YQ7O8BnSnJfPz7K04y3WghsOZNi+ejyEaCkx/wI7cE78Hi7E8j+kUVwQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732743631; c=relaxed/simple;
	bh=fU3yQoPBUwwHe11Y/r/SWLKZYVkaYtuYawhFhhwo+jM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TWqb7qOS/2V8tWXBgeRSAIvlNS5/Az88T4gBqkTlqo39Rt2Lv7TaU+9lpnuQBu/FuCll072MdDv23H5KCW6apbAj3gIB2RmB6WyLvqEi54zaSZ+Q+K0CLr0ufeiLb3aawSVJybNcnzr1MEtQaVmFRW4KtQr5EmfCn/c/6vA1KvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4Y8TeTj; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4Y8TeTj"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 380044092B
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Nov 2024 21:40:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wH7vGZrR00ev for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Nov 2024 21:40:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 36D03401B0
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 36D03401B0
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Y4Y8TeTj
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 36D03401B0
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Nov 2024 21:40:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DD66BA4379C;
	Wed, 27 Nov 2024 21:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D683C4CECC;
	Wed, 27 Nov 2024 21:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732743626;
	bh=fU3yQoPBUwwHe11Y/r/SWLKZYVkaYtuYawhFhhwo+jM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Y4Y8TeTjNUGN3Sx5K8/Eo7H+w2r6PTxa72WY8eSOXjtUxg7DUNJzN45odT+hNE4tc
	 Vrt/T0xdFXoTokrpaxYG4xrHE2gZbFyACNyhZa14/bEwE05T29JI4gsavXJNqloYNO
	 zqCPmj9j6Efmru0zw1bB2xSZctmedgG4zG/r4PArCVy2EuNYBOPMzN1E2BE0odw/r+
	 fLlEOGMSn++wn24wZxyEGoxa/2CmGDiCDOPjXkEpusSb51Jl4W6YyYQCUzByf5WKop
	 C4EjpdnLLsg/BieimgniXSw5cTnWl3BUvzP3at1SYbCbyViqyODMfUzZDgqN4d8WLT
	 UCst6BuDDJGlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 79D65380A944;
	Wed, 27 Nov 2024 21:40:40 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241126163144-mutt-send-email-mst@kernel.org>
References: <20241126163144-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <virtualization.lists.linux.dev>
X-PR-Tracked-Message-Id: <20241126163144-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 6a39bb15b3d1c355ab198d41f9590379d734f0bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a50b1e766a09f1a2da5f291956b8dceb58b5d54
Message-Id: <173274364003.1220377.12173502747975037192.pr-tracker-bot@kernel.org>
Date: Wed, 27 Nov 2024 21:40:40 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, colin.i.king@gmail.com, dtatulea@nvidia.com, eperezma@redhat.com, huangwenyu1998@gmail.com, jasowang@redhat.com, mgurtovoy@nvidia.com, mst@redhat.com, philipchen@chromium.org, si-wei.liu@oracle.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 26 Nov 2024 16:31:44 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a50b1e766a09f1a2da5f291956b8dceb58b5d54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
