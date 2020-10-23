Return-Path: <SRS0=p/QF=D6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1BDC5517A
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 18:53:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF992192A
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 18:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1rYV7y8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF992192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9935422011;
	Fri, 23 Oct 2020 18:53:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YIJjvFl13bOL; Fri, 23 Oct 2020 18:53:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A508E2153D;
	Fri, 23 Oct 2020 18:53:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7807FC0052;
	Fri, 23 Oct 2020 18:53:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14542C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 18:53:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 080478703F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 18:53:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TzU3n0QEHKJm
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 18:53:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9E13A86FD9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 18:53:10 +0000 (UTC)
Subject: Re: [GIT PULL] vhost,vdpa,virtio: cleanups, fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603479190;
 bh=Fut4z9JGmD3maTcbN0fyqQYAM6FFJ60UFXb6vsO1lrQ=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=1rYV7y8L4fqyq9/Y6Bnv1MRUN5CH9C1NVdDlnXKwc+pHbTGwO+qs9nuzXdqbcqgQ2
 iK879U4YmweY6ZAB3WKs5YSBOBm357iHtVfUFwj6qAaBElopHUrBpO3aA07Cyr9mpu
 +ORWDuaAJduX+3FjpxGUBUrHT/szHvvNtSoosSfs=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20201023113832-mutt-send-email-mst@kernel.org>
References: <20201023113832-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: Linux virtualization
 <virtualization.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20201023113832-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 88a0d60c6445f315fbcfff3db792021bb3a67b28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9313f8026328d0309d093f6774be4b8f5340c0e5
Message-Id: <160347919010.2166.1997610625454370758.pr-tracker-bot@kernel.org>
Date: Fri, 23 Oct 2020 18:53:10 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: pankaj.gupta.linux@gmail.com, pmorel@linux.ibm.com, kvm@vger.kernel.org,
 mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 rikard.falkeborn@gmail.com, virtualization@lists.linux-foundation.org,
 li.wang@windriver.com, borntraeger@de.ibm.com, stable@vger.kernel.org,
 tiantao6@hisilicon.com, elic@nvidia.com,
 Linus Torvalds <torvalds@linux-foundation.org>, lingshan.zhu@intel.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The pull request you sent on Fri, 23 Oct 2020 11:38:32 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9313f8026328d0309d093f6774be4b8f5340c0e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
