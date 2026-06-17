Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981F93806D6
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Jun 2026 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781723707; cv=none; b=ICYecJZ4olEvrO0RxkCI2yEDuhv89kDS505CClQZuE9Chz8wBLXVDxP5e7e3GeE7lVgl/tAR5sN2SYpeKtLPKKCfgUKm+JUWTWcNHNnFtwc/FPmhNqI99lglHU+bmyvwxaXLVs7JqCAlYbxbvShXQgIJds05TyhqgiFhAy/IgLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781723707; c=relaxed/simple;
	bh=U/JjWDaNTGpaVDDjDb7/UO/EuFA3dV5VcowRISEDLcY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oYcDSvWQ0b9r63etkzt+nU0GXLkGrUTDCRuPN66rWjxonB8WTBxNDiXK88Lotkqoa1kbAKzlGeHPIEgod0B21usjjnlfBkgy6cX4X2yWjk0QbdiYLRAyshoxS7IxtgNWNBo9vvFQw8KoPkM3RObS4GQDUPnO6U+oijC1TnuE/Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeZ2uI+Y; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeZ2uI+Y"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 55E0C4021C
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Jun 2026 19:15:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zn7HftirAU1i for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Jun 2026 19:15:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 080E140208
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 080E140208
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JeZ2uI+Y
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 080E140208
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Jun 2026 19:15:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4EE0A40610;
	Wed, 17 Jun 2026 19:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2655A1F000E9;
	Wed, 17 Jun 2026 19:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781723702;
	bh=FASyi1AWkm+i6K2loGoBP4D8Pk6x5oWdo88DHdM7e3M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=JeZ2uI+YYS81CYkYXl5rr2DX06e0pb02WFbd4Q04fu1pKRXGLh3pO3L4+aa4/PnzA
	 4IuAU/mVOpzj81LyZML8/JASJTgYhPYDnt5EIqtenZjzcbts/PKm7jpDWHMuQsBRbe
	 yNDdcZSM+FjrFVahUrWVuSB+Nsb6u/Q9UU1dgQSiCOUwy4JY0ZFzY/6M5kzk5UPRFQ
	 uSbpUhe0KceTihL1nm2a2u35+SlHk7z/EFy8XkkbavXnHJNUCarmCUNHux4krTx4rd
	 SMGDkLWdxMkRfM57lgxgr8+E1mfQR94ZuAVgDbUKK9VtAApntrP93yMu/CXgltvfpb
	 YS+96iLSJ6fqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569AF3931008;
	Wed, 17 Jun 2026 19:14:57 +0000 (UTC)
Subject: Re: [GIT PULL] virtio,vhost,vdpa: features, fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260617065516-mutt-send-email-mst@kernel.org>
References: <20260617065516-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260617065516-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 8cb2c9285e4ce9154f45fb15633ebd45dfd8d9cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d44ade05aa21468bd30652bc4492891b854a400a
Message-Id: <178172369584.1775335.8856194024948624969.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jun 2026 19:14:55 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, a0yami@mailbox.org, ammarfaizi2@openresty.com, arnd@arndb.de, chenhuacai@kernel.org, chenhuacai@loongson.cn, christfontanez@gmail.com, Damir.Shaikhutdinov@opensynergy.com, david@kernel.org, den@openvz.org, enelsonmoore@gmail.com, eperezma@redhat.com, ethan@ethancedwards.com, evg28bur@yandex.ru, filip.hejsek@gmail.com, francesco@valla.it, graf@amazon.com, harald.mommer@oss.qualcomm.com, jasowang@redhat.com, jiri@nvidia.com, johan@kernel.org, johannes.thumshirn@wdc.com, lingshan.zhu@kernel.org, luis.hernandez093@gmail.com, lulu@redhat.com, mhi@mailbox.org, michael.bommarito@gmail.com, mikhail.golubev-ciuchea@oss.qualcomm.com, mkl@pengutronix.de, mst@redhat.com, mvaralar@redhat.com, nathan@kernel.org, oleg@redhat.com, pawel.moll@arm.com, physicalmtea@gmail.com, polina.vishneva@virtuozzo.com, q.h.hack.winter@gmail.com, r
 osenp@gmail.com, schalla@marvell.com, shuangyu@yunyoo.cc, stefanha@redhat.com, vattunuru@marvell.com, yanlonglong@kylinos.cn, yichun@openresty.com, yui.washidu@gmail.com, yuka@umeyashiki.org, zhangtianci.1997@bytedance.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 17 Jun 2026 06:55:16 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d44ade05aa21468bd30652bc4492891b854a400a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
