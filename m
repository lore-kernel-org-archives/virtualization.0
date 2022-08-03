Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E07C19F2A
	for <virtualization@archiver.kernel.org>; Wed,  3 Aug 2022 06:48:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC3C740214;
	Wed,  3 Aug 2022 06:48:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC3C740214
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Gm63wnj9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VmVGhECfd1QV; Wed,  3 Aug 2022 06:48:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1944A4014E;
	Wed,  3 Aug 2022 06:48:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1944A4014E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDA94C0033;
	Wed,  3 Aug 2022 06:48:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D290C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 06:48:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5451A405F4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 06:48:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5451A405F4
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=Gm63wnj9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oF9sdAAfeD4N
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 06:48:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 847A240363
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 847A240363
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 06:48:29 +0000 (UTC)
Received: from localhost (unknown [213.194.152.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 7830E6601B14;
 Wed,  3 Aug 2022 07:48:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1659509307;
 bh=PIUJHmpgxxfrpQGGhlN2EDOjeTri6mVCxV3nWgqmn7A=;
 h=From:To:Cc:Subject:References:In-reply-to:Date:From;
 b=Gm63wnj9YeuzKEvGabOU8KtRLtvtFv7DA94v4gEY/zCa9M0Pt30Tqp93M0U2X0QTd
 ZTPKPr7jc5HyzMlPe15haHC3OqG/GJxpCNTHgMz3C75QbUHcglGN98kS17rJjUPZu9
 J81Cehv8E94WW9qQ814akIzFqSsJf5DNwxvDq7Xs78lQQxAqBTQJeyKVGo6EUGi7DD
 wxtc1nENpCqjQnHzcjTNtEbI3Et5EQYLoUBHeIq9V4EJ1tJWHPytgjBjvhZUZCl3Lb
 PcBzCORAfYcFgW/bEA/+NQPlTtYR09SLrnUAwyRtI1MSVuPQrEZjMHObVG8cHaAeoR
 Z9+UF/o93G4HA==
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] docs: driver-api: virtio: virtio on Linux
References: <20220802124222.3563378-1-ricardo.canuelo@collabora.com>
 <YuknUeDjmtgKHB0M@debian.me>
In-reply-to: <YuknUeDjmtgKHB0M@debian.me>
Date: Wed, 03 Aug 2022 08:48:23 +0200
Message-ID: <877d3pstzc.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com,
 kernel@collabora.com, linux-doc@vger.kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Bagas,

Thanks for reviewing

Bagas Sanjaya <bagasdotme@gmail.com> writes:
> I can't apply this patch on top of mainline. On what commit (and what
> tree) was it based from?

The patch applies cleanly on recent tags of linux-next (tested on
next-20220802). If this needs to be tested on a different tree/commit
let me know, as I'll have to submit a new version of it.

Cheers,
Ricardo
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
