Return-Path: <SRS0=pcMQ=O6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0EFC433EF
	for <virtualization@archiver.kernel.org>; Sun, 10 Oct 2021 05:33:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37BEA60F12
	for <virtualization@archiver.kernel.org>; Sun, 10 Oct 2021 05:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37BEA60F12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1DDF82B1A;
	Sun, 10 Oct 2021 05:33:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DQFneERleB9V; Sun, 10 Oct 2021 05:33:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9BA1282AF8;
	Sun, 10 Oct 2021 05:33:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BBD8C000F;
	Sun, 10 Oct 2021 05:33:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A1E2C000D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Oct 2021 05:33:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2464402F1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Oct 2021 05:33:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xWrN_GAB2eM1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Oct 2021 05:33:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C2D5402C5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Oct 2021 05:33:47 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06EC960F57;
 Sun, 10 Oct 2021 05:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1633844027;
 bh=fFtb1mrI1ST0Z8ENmJv/UKksOGpmgzo0n0USEL4Xz6g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=smXj9SNPXY/VYJ7AwIAIvQr4XCStM2hHJtZQ52RReVdA1DR3fY6BMbjoILsiYXcwh
 LzZBmcysuTwVBN1I7oual3OdQG2egw9nzEpa0t649Lm+Cwnop68l+yIPNjj2bTErdx
 9Ws+cgeAupflqf4h+gvutPzjmvOuBurPcGpE1nhM=
Date: Sun, 10 Oct 2021 07:33:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH v10 2/3] tty: hvc: pass DMA capable memory to put_chars()
Message-ID: <YWJ7NuapWOZ4QirJ@kroah.com>
References: <20211009114829.1071021-1-xianting.tian@linux.alibaba.com>
 <20211009114829.1071021-3-xianting.tian@linux.alibaba.com>
 <YWGD8y9VfBIQBu2h@kroah.com>
 <3516c58c-e8e6-2e5a-2bc8-ad80e2124d37@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3516c58c-e8e6-2e5a-2bc8-ad80e2124d37@linux.alibaba.com>
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

T24gU2F0LCBPY3QgMDksIDIwMjEgYXQgMTE6NDU6MjNQTSArMDgwMCwgWGlhbnRpbmcgVGlhbiB3
cm90ZToKPiAKPiDlnKggMjAyMS8xMC85IOS4i+WNiDc6NTgsIEdyZWcgS0gg5YaZ6YGTOgo+ID4g
RGlkIHlvdSBsb29rIGF0IHRoZSBwbGFjZW1lbnQgdXNpbmcgcGFob2xlIGFzIHRvIGhvdyB0aGlz
IHN0cnVjdHVyZSBub3cKPiA+IGxvb2tzPwo+IAo+IHRoYW5rcyBmb3IgYWxsIHlvdXIgY29tbW50
cy4gZm9yIHRoaXMgb25lLCBkbyB5b3UgbWVhbiBJIG5lZWQgdG8gcmVtb3ZlIHRoZQo+IGJsYW5r
IGxpbmU/wqAgdGhhbmtzCj4KCk5vLCBJIG1lYW4gdG8gdXNlIHRoZSB0b29sICdwYWhvbGUnIHRv
IHNlZSB0aGUgc3RydWN0dXJlIGxheW91dCB0aGF0IHlvdQpqdXN0IGNyZWF0ZWQgYW5kIGRldGVy
bWluZSBpZiBpdCByZWFsbHkgaXMgdGhlIGJlc3Qgd2F5IHRvIGFkZCB0aGVzZSBuZXcKZmllbGRz
LCBlc3BlY2lhbGx5IGFzIHlvdSBhcmUgYWRkaW5nIGh1Z2UgYnVmZmVycyB3aXRoIG9kZCBhbGln
bm1lbnQuCgp0aGFua3MsCgpncmVnIGstaApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
