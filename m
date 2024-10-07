Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B4B1D319B
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Oct 2024 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326270; cv=none; b=aRotI1WoXQCWvhlinO/Qa4IF3EWHFS3krShNxdTb7OYluwq+ZaYnyshb7pTH6Otl4fYSR1oul6+1BGrhEINoWjwoVy7iwR0IIjDOMo4FSMovfWh1qqgQI5fbwqB0+tfQd7hnYI0I940VsmzoMqObBrkr/bG9xLJI5P5pWrchneg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326270; c=relaxed/simple;
	bh=LLhywHX9oky1MmQko4cR0K0+0vGqeLQ5ItXxdltoVMY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NjaESW08b1jlaWyF8XGEDbOgi4rhx6j7JruDrAk9W3VG0DcTOs4N9B1sTlSY/en21qbZTOIdI5QTIci/B/dPToMLrSPSd7pq4ru6NijrpA5dL8l7tK+JnqhgKjt8iwNvmoLGm3aMPTaIfpg9KYjoOvJcV3Uhcubmn4PqzO4gw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbwE+EjL; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbwE+EjL"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B4EFF40921
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Oct 2024 18:37:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6SjfVkJW1nza for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Oct 2024 18:37:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AF99E400B9
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AF99E400B9
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bbwE+EjL
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AF99E400B9
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Oct 2024 18:37:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 77DEDA41FFF;
	Mon,  7 Oct 2024 18:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9255C4CEC6;
	Mon,  7 Oct 2024 18:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728326265;
	bh=LLhywHX9oky1MmQko4cR0K0+0vGqeLQ5ItXxdltoVMY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bbwE+EjL8F4nNIiefYEhe+cGfTjuDVF04N09G5HJ/ae0oiHdcPHoKP5On9Er/ne9i
	 0Y0kNH8Gwx/qH6R5iGKt9bkLYBRfFFfr4wh2yea8ClhQWyVMiJ555AhUG230hKv4zi
	 wxeyR1wiWGe2jHeEyR1kctQHIBbUCb4yGjeHYGRgsLfalvjMCdCPys7ngMkIiiyIRm
	 PN/4s3aPYytfsGoWAMkCwsrlrbPVRS8xh75xD6DMF+weeKdKeoXx+AbE+2y6UEY+0y
	 wY93g1/6abauy2QRE1Sw2BzoN+xM2KBrVRebU/fy5y26fUfxVxJ/HHiY1EmrGTfUJG
	 OE3i55Img3KuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB58C3803262;
	Mon,  7 Oct 2024 18:37:50 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: bugfixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241007115158-mutt-send-email-mst@kernel.org>
References: <20241007115158-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241007115158-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 221af82f606d928ccef19a16d35633c63026f1be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87d6aab2389e5ce0197d8257d5f8ee965a67c4cd
Message-Id: <172832626951.4133236.13974754342123497528.pr-tracker-bot@kernel.org>
Date: Mon, 07 Oct 2024 18:37:49 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, brauner@kernel.org, dan.carpenter@linaro.org, elver@google.com, jasowang@redhat.com, lkp@intel.com, luigi.leonardi@outlook.com, michael.christie@oracle.com, mst@redhat.com, schalla@marvell.com, sgarzare@redhat.com, syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com, wh1sper@zju.edu.cn
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 7 Oct 2024 11:51:58 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87d6aab2389e5ce0197d8257d5f8ee965a67c4cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
