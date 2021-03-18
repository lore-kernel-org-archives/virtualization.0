Return-Path: <SRS0=KYCx=IQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CC3C433DB
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 18:24:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC0364F2B
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 18:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC0364F2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 317224EBD1;
	Thu, 18 Mar 2021 18:24:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04iGpmmiApAn; Thu, 18 Mar 2021 18:24:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9359D4E578;
	Thu, 18 Mar 2021 18:24:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51728C000A;
	Thu, 18 Mar 2021 18:24:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD026C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 18:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A411660672
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 18:24:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IPFZB6GR0ZHS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 18:24:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0889460633
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 18:24:13 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id A5A7D64F1D;
 Thu, 18 Mar 2021 18:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616091851;
 bh=mm5Gj2cRzymNcWhINozh1pQMZ8f06QUkUYUCX5wN1zQ=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=B5G9Nw7oh0SL8uCt7TnQRKu0AEzIPKfSfK09VntyzyU2POAnVxFpSfpXF1b422qBw
 clJSwBHwJe+YjmnbAO8JXaUTZggOXhQJw8QOsPE/GAtmjY94tdjSF/nyWB0Dtw7AVh
 6cigBZqpvdLdNJ5fqXHOiKP0EBzggCgei7vcgeRuBP+2fwTJsCmzZUjjrAbYCvh5u9
 ORQhgCkBjkQMFB3eyCCrI1GXX61JUWF69GWaGeXM+tGWSgZ/TX2ySXStJvSOhvd+tA
 zOabVCrcoVkFltxCxEoB0UPh9NKLzpWflay/zbVhQZidpH4DL4d44HQFz8afjua1gK
 KrB87wpGxDtVw==
Subject: Re: [GIT PULL] vhost: cleanups and fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20210318141135-mutt-send-email-mst@kernel.org>
References: <20210318141135-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <stable.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210318141135-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 0bde59c1723a29e294765c96dbe5c7fb639c2f96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf152b0b41dc141c8d32eb6e974408f5804f4d00
Message-Id: <161609185164.1841.2155981862734069676.pr-tracker-bot@kernel.org>
Date: Thu, 18 Mar 2021 18:24:11 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: lvivier@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, tangbin@cmss.chinamobile.com, gdawar.xilinx@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xianting_tian@126.com,
 lingshan.zhu@intel.com, Linus Torvalds <torvalds@linux-foundation.org>
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

The pull request you sent on Thu, 18 Mar 2021 14:11:35 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf152b0b41dc141c8d32eb6e974408f5804f4d00

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
