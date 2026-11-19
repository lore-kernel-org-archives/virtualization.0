Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.137
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795104771;
	b=HdTWwA2pDwB0qxIhjpl2c9QaonHMXUKqJky+gBMfMUozU4I88TTBNOUfjuaxK7h1RkYB
	 Gf/ksKrjCGSclb/NQosF8ku6aShYnv1HcZFAs2C43FJBCfNa1ZYrSBubq6FVQX9XW8VCc
	 EkAWOFpfBd2KW62y51YSKwb10OlqYTKrlh38Fwq6yNHSCdn3Ebgw9UrHCZNEAkh3hoo4X
	 fsk4qW3Lq40hUtThb9AkKD6sB+yVYOkKPKidiWOtLbbpnDNVnSILHHrXGpwX7H0/2kIzU
	 gRKOJZPUPkab3QgIs/rT6rL5QTnQz1XxJgL9JhU6vQGzoO1AbAfwHfp7xmLcjMEk4Jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104771;
	h=Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=wD6BFJ6JrYkMRhR+rPzMaMCFtMlLO4L8u3ZtLB0XJ/0=;
	b=n16V+FhXGmY53785D/T6GQlTeRvCh+MITY8k4Yz7C/oPzAEwFIg97C+KoG9JFSeq91/0
	 DHIgqGcnccePtdrmnR2dQ/tPMvrIOGZREt1ZUajHZiv0rQ3bWu1mNJ17J8EOVJxRibas6
	 ENQDdZ6Hw+YelFewOPecNRPY8AT5VWDLV1PNYE1tkb8gc9ZI6B0sbYMzyRojSGSAYTlMk
	 ce+Shn+sNjCuvhI0QoGp7FmP61hQEKMCY+ys2NhiJuRFMDxP3C5pBPff4hXWzcJqQ3umz
	 nD6z0TzP3MWephiDlNrNyNkcg9oWm1kNp/YQHkKjfrLBhytZuBgSaqp0jhvQIq5DTHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNk3+buX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.137
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C333606A332
	for <virtualization@lists.linux-foundation.org>; Thu, 19 Nov 2026 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNk3+buX
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B438F40C66
	for <virtualization@lists.linux-foundation.org>; Thu, 19 Nov 2026 16:12:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.651
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j-phJUmkMtbq for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2026 16:12:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EFF6140AE2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795104770;
	b=f05DhV0JFH3nsWvnXlHTeN1IZkQgpedTyrJcHtnk+mH53uWLz1lKEFyo6ZlcDQPVBPT5
	 /oQGkAXdIwxRHdqHdBBo0Yhq3UOSfUirxC7vV9kkcJhbVpzA0GlI7cJj290R+D9lkgvxI
	 P8b7mWkJmoyDuhHCugD2MKR8eBV5WQ9SmbDmJsVwDAojFf83I1LrbyzXFHxRDEZuIffes
	 ofV7d8V3N3EH53h+7BPGYzKqSBkPVux3/+/i9KA5H6qMFM69bQVvTFoP2RvGHHAT5ZlID
	 Mv5AgaEdfQ1zrtZ/PSr7PFfeuTRnwM2lu5200en6YwqTMyJ0eTDWoj/kMjw8NDfeT+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795104770;
	h=Received-SPF:Received:Received:DKIM-Signature:Received:Subject:From:
	 In-Reply-To:References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=wD6BFJ6JrYkMRhR+rPzMaMCFtMlLO4L8u3ZtLB0XJ/0=;
	b=oyUg+4fKy2uV2lDvGF6Pjjci3/8VSbFi1rph4QI/debKlEPVthlgarGLEuCnX7O4/MlS
	 a1FrjBcEff2eKn65btqJ7gUIG2UkR1AB4blT/l6+dJLIECmdW99fEK6lblmg+7FQj6aGc
	 C6N8JoZwDi3pZMSAKKx9GxYZZVdbjB4LP8ftoGClnBpQQysuKMIy4467WQbGDKkAI4sK6
	 6IKpNSfBnpy6FRYHYOIbOwY+NwY7H43uwCbM32wAbjlpy78/3TpGdIDRCZxiS/Vt2zDFo
	 iSFMOKmKFUn31F3eUXf3fZc2jIYtsJseAOfTYiD4sVy2Gtwd7jw1suaIQafQsgsg5+w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNk3+buX;
	arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNk3+buX
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EFF6140AE2
	for <virtualization@lists.linux-foundation.org>; Thu, 19 Nov 2026 16:12:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DB4A347058;
	Thu, 19 Nov 2026 16:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFBD1F000C6;
	Thu, 19 Nov 2026 16:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104768;
	bh=wD6BFJ6JrYkMRhR+rPzMaMCFtMlLO4L8u3ZtLB0XJ/0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=QNk3+buXrSibxNQDgUJXaT3j9GxjhJpmtSYGUgcrEET8ySMhSpsQG939EwGOwf0CY
	 8cSA0qlKIPq/QPyT5IYRGBTs4veseVn6PtosddlXXlYEtTefr2dOAqUpkSBfxzrMLN
	 0mIj1EV0GgHSekEccIh7Zkfk2N3UNT6k6RaRPzDjZa06mFMv23ryqCpRQdw+izPYY/
	 HjbZNQuvbtG+deKTXCg3nxyRyWbLrCHQZdW+sbn+9rwbCmIKxYakVsTDXrB6NWDMmK
	 zJ6DshMrlXnh8hHOKk4EBYYXSgTjzob7lpd+FxlpLo2anIMpbnyhoxouuQCboLzK1e
	 9zNsBueYXIbMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B47603808210;
	Thu, 19 Nov 2026 16:12:48 +0000 (UTC)
Subject: Re: [GIT PULL] vhost: bugfix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261119022615-mutt-send-email-mst@kernel.org>
References: <20261119022615-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <stable.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261119022615-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 5570a998b884c988dbe105430d7e2d8e9411e37e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1715c0c04606ebbe832cc760abf49dfd6f2ae1f
Message-Id: <179510476718.3187685.502114948524303216.pr-tracker-bot@kernel.org>
Date: Thu, 19 Nov 2026 16:12:47 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bioloidgp@gmail.com, jasowangio@gmail.com, minki@morningstarsec.dev, mst@redhat.com, stable@vger.kernel.org
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

The pull request you sent on Thu, 19 Nov 2026 02:26:15 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1715c0c04606ebbe832cc760abf49dfd6f2ae1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
