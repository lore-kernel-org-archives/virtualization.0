Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB66C433DB
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 18:13:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C14B64E55
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 18:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C14B64E55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 04F0387304;
	Fri,  5 Feb 2021 18:13:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3iVgH650fP1F; Fri,  5 Feb 2021 18:13:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DB27F871D0;
	Fri,  5 Feb 2021 18:13:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDC3BC0174;
	Fri,  5 Feb 2021 18:13:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46384C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 18:12:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3B52920372
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 18:12:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2TfPwXtTj8A9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 18:12:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id BE1122E12B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 18:12:57 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 3A41064E49;
 Fri,  5 Feb 2021 18:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612548777;
 bh=OEdo9FgWHCfNz1W4m5jQ8e6zfGEvZ8qUY/UkHoGEWXA=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=SV2rfU2qRQ15Rr/3zIRHopOucvCIp5MECi1h0m4HSokeQmDfZO6iingAuJk/mbYDG
 b51bX2UmrwO7iwY642mCbyCEDlFmp4z+qOm+W6EPeZzL2+LdmPtfRAAtzXMqF6stdH
 86rOJBQ0+JGuBVbcTUu7JoYv5aWbVVVTAFAvKsCnn/dBi7P4UFDkq1l8fQmPDx9Urb
 wweqaC4MB3Za/u3HAG36UhnvYvbh0rm+L35FBnaWnOqFmYBp35GsqsWjhYQcWFZiMp
 ZNIGoenfWsEIvjeHOWvGEe6nsGALW/yfD2pmKc6A7oPQUB8hqunH3/OmSZ8YryVPgc
 Kr0vllqySu4Qw==
Subject: Re: [GIT PULL] vdpa: last minute bugfix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20210205104520-mutt-send-email-mst@kernel.org>
References: <20210205104520-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210205104520-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: b35ccebe3ef76168aa2edaa35809c0232cb3578e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e07ce64d83046178c9c0c35e9d230a9b178b62ef
Message-Id: <161254877710.14736.823422420550424616.pr-tracker-bot@kernel.org>
Date: Fri, 05 Feb 2021 18:12:57 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elic@nvidia.com, Linus Torvalds <torvalds@linux-foundation.org>
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

The pull request you sent on Fri, 5 Feb 2021 10:45:20 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e07ce64d83046178c9c0c35e9d230a9b178b62ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
