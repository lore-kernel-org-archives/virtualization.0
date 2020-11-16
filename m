Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BBDC5519F
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 23:10:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA3A22417F
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 23:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTku/Brz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3A22417F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 989AB8669C;
	Mon, 16 Nov 2020 23:10:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oyPacEe-r8GN; Mon, 16 Nov 2020 23:10:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5E2F486096;
	Mon, 16 Nov 2020 23:10:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 401C5C0800;
	Mon, 16 Nov 2020 23:10:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A777C07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 23:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 11C8C8718C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 23:10:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QsIpCuWwMRqz
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 23:10:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7795587182
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 23:10:29 +0000 (UTC)
Subject: Re: [GIT PULL] vhost,vdpa: fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605568229;
 bh=9UphfRPbiDtx8WS14mhj6/UOt2mT19XhifgecFASUOs=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=KTku/Brz6ZjeXVo9xQupyPGd1Y1dQsZxB7GXoN4kFmuVTsjPNsdiOimXk76b3ElUf
 BWWuD9BgPsWLAXgu8Pn8AjmwVpoD26QOrh8z0yAya/jlYLQ4T2z5C1KNKBuGPH7Hvj
 GaSe6H04/fDrR3MEE96hw6fWvhSvStheKM4BpaQU=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20201116081420-mutt-send-email-mst@kernel.org>
References: <20201116081420-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201116081420-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: efd838fec17bd8756da852a435800a7e6281bfbc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a08f4523243c86fe35dec8c81c5ec50f721004ce
Message-Id: <160556822900.30215.12731806046913817813.pr-tracker-bot@kernel.org>
Date: Mon, 16 Nov 2020 23:10:29 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: lvivier@redhat.com, sfr@canb.auug.org.au, lkp@intel.com,
 kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 Linus Torvalds <torvalds@linux-foundation.org>, michael.christie@oracle.com
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

The pull request you sent on Mon, 16 Nov 2020 08:14:20 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a08f4523243c86fe35dec8c81c5ec50f721004ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
