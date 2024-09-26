Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6389815D5BB
	for <virtualization@lists.linux-foundation.org>; Thu, 26 Sep 2024 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368672; cv=none; b=embMgY0KP+P8S819AnTzw67F3gmHhWBiYBgTaGToyklc0s4sC4wc7LnfSxRK5mQo/TEISgERGvKky3KVz1JpoIFLP3TcbTVLeuSv3kcU3wuEpY71cKqHABATFni8+hZt/Hi8KlWVuymhMzr6zeysj5nbdsjI2x0HuhFaDUtXj6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368672; c=relaxed/simple;
	bh=DeJLVfa+98msi+WOdi6aZw7WZW+rjhDtw9LT+pzpoOo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OkYR+FJKCgtt+9qGvOYSUDlxwTdndBDzEGOrbMiFX8/7bNflBNtY49T34jo18eavhlwla1JzejyyLuij4GELnmLFhrpyz9K5GHLPoNLjgrzSaxrFwGXHMBPOI8JGCuHRvaUg05hGrzCyEI3Ggprps69LdDICagdpQR0wwLlr15o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJbzHoSr; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJbzHoSr"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 014D6401BE
	for <virtualization@lists.linux-foundation.org>; Thu, 26 Sep 2024 16:37:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AA5xX4uG4U0r for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Sep 2024 16:37:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0986940188
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0986940188
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iJbzHoSr
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0986940188
	for <virtualization@lists.linux-foundation.org>; Thu, 26 Sep 2024 16:37:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1B3DD5C5EE9;
	Thu, 26 Sep 2024 16:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5738C4CEC5;
	Thu, 26 Sep 2024 16:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727368667;
	bh=DeJLVfa+98msi+WOdi6aZw7WZW+rjhDtw9LT+pzpoOo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iJbzHoSrdvQ+e+RNwota6cvSa9hKcDOOPpEyHz0PotTZMeimzmouwxMfWQP1+TbjG
	 yiLXOQNsPNVw1UGnm6gja55mpHSS3IqabWs2ceQ5wH4RdivDjsdSj6w/omUhLmjhQr
	 X1B9e/UawSw6vkmJnYZUxJwPTjezctVk9QfZ34r89r7yMrM7mJoE9i6wHNgEgm+jqk
	 6fqLhOr1GpMUGxyzUu8kPpl1cRd2t24kteZUJKcU6bi5qjtXU7HGxW2o2lLIsBiJy9
	 UM+DNs/M+Js1/SHmX1uh6ADT7LhQX+jBNjaOVnp+7I9/StVbYZSg617Sb6tbUPs9Ip
	 tNYXbirX8J6sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710F8380DBF5;
	Thu, 26 Sep 2024 16:37:51 +0000 (UTC)
Subject: Re: [GIT PULL v2] virtio: features, fixes, cleanups
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240925070949-mutt-send-email-mst@kernel.org>
References: <20240925070949-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240925070949-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: efcd71af38be403fa52223092f79ada446e121ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0181f8c809d6116a8347d8beb25a8c35ed22f7d7
Message-Id: <172736867005.1312674.17372931311041898879.pr-tracker-bot@kernel.org>
Date: Thu, 26 Sep 2024 16:37:50 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, david@redhat.com, dtatulea@nvidia.com, eperezma@redhat.com, jasowang@redhat.com, leiyang@redhat.com, leonro@nvidia.com, lihongbo22@huawei.com, luigi.leonardi@outlook.com, lulu@redhat.com, marco.pinn95@gmail.com, mgurtovoy@nvidia.com, mst@redhat.com, pankaj.gupta.linux@gmail.com, philipchen@chromium.org, pizhenwei@bytedance.com, sgarzare@redhat.com, yuehaibing@huawei.com, zhujun2@cmss.chinamobile.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 25 Sep 2024 07:09:49 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0181f8c809d6116a8347d8beb25a8c35ed22f7d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
