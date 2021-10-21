Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8132BC433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 08:35:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A476115B
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 08:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37A476115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 039B04044F;
	Thu, 21 Oct 2021 08:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HaRy5fdHhxer; Thu, 21 Oct 2021 08:35:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 75E42401D5;
	Thu, 21 Oct 2021 08:35:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F5F4C0033;
	Thu, 21 Oct 2021 08:35:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28A2CC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 08:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07B6D40297
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 08:35:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0d0k1rDzL4SD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 08:35:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 67D2E401D5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 08:35:42 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78D1860FC0;
 Thu, 21 Oct 2021 08:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1634805342;
 bh=zYc8BgeDcX1s9EwG1PG1svkNJLRcwRDOiYfOT1psu/w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sBm0ahUKom/4sjWMN7UsVVmSTYE5go6xo+vqXtemDB4h4gsXgmsXCYlgBWEfBOn4b
 cEoqlrRFNrEuhVJasvYjvjr9TSEia2qhT25QGckTskYY07TePSyyP9DfRmaKkvlyJu
 /gn7FMJwlwl+kb/Pn9IN0OkXo7rKFMU7fqImyMA4=
Date: Thu, 21 Oct 2021 10:35:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH v11 0/3] make hvc pass dma capable memory to its backend
Message-ID: <YXEmW071C+GlmXqw@kroah.com>
References: <20211015024658.1353987-1-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211015024658.1353987-1-xianting.tian@linux.alibaba.com>
Cc: arnd@arndb.de, amit@kernel.org, jirislaby@kernel.org,
 shile.zhang@linux.alibaba.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 osandov@fb.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gRnJpLCBPY3QgMTUsIDIwMjEgYXQgMTA6NDY6NTVBTSArMDgwMCwgWGlhbnRpbmcgVGlhbiB3
cm90ZToKPiBEZWFyIGFsbCwKPiAKPiBUaGlzIHBhdGNoIHNlcmllcyBtYWtlIGh2YyBmcmFtZXdv
cmsgcGFzcyBETUEgY2FwYWJsZSBtZW1vcnkgdG8KPiBwdXRfY2hhcnMoKSBvZiBodmMgYmFja2Vu
ZChlZywgdmlydGlvLWNvbnNvbGUpLCBhbmQgcmV2ZXJ0IGNvbW1pdAo+IGM0YmFhZDUwMjkgKCJ2
aXJ0aW8tY29uc29sZTogYXZvaWQgRE1BIGZyb20gc3RhY2vigJ0pCgpUaGFua3MgZm9yIHN0aWNr
aW5nIHdpdGggdGhpcywgbG9va3MgbXVjaCBiZXR0ZXIgbm93LCBhbGwgbm93IHF1ZXVlZCB1cC4K
CmdyZWcgay1oCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
