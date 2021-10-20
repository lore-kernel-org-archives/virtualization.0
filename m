Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5096AC433EF
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 08:56:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0879661183
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 08:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0879661183
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C59DA40375;
	Wed, 20 Oct 2021 08:56:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eFd8pmWzePxO; Wed, 20 Oct 2021 08:56:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2B7094021B;
	Wed, 20 Oct 2021 08:56:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05529C0011;
	Wed, 20 Oct 2021 08:56:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D3E8C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 08:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4ECBD40235
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 08:56:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jT9Tdgf_OJDd
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 08:56:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0860D4021B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 08:56:08 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1ED0161004;
 Wed, 20 Oct 2021 08:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1634720168;
 bh=Zb6cdSPaiuzX2LILzLYpQZahassfoYygri0Z+gn9Gz4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FicmaPqpkSATWNrLIg8kQtlJwJHkROycKClRvuxklISlxxuO30+tNoBPYHiBsCIBY
 C6Ud01eugF8PkSmgVqo2XsImrPWY0z3qR/a/K0N43SLAWSUD0W9ULDN/+B15nFQJQs
 i5RvQMtOvPKejoj1RYvlevNKvsQtmDmgDVSO0SRA=
Date: Wed, 20 Oct 2021 10:56:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH v11 2/3] tty: hvc: pass DMA capable memory to put_chars()
Message-ID: <YW/ZpdHa35kStzbt@kroah.com>
References: <20211015024658.1353987-1-xianting.tian@linux.alibaba.com>
 <20211015024658.1353987-3-xianting.tian@linux.alibaba.com>
 <d56c2c23-3e99-417b-8144-cf1bb31b5f6d@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d56c2c23-3e99-417b-8144-cf1bb31b5f6d@linux.alibaba.com>
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

QTogaHR0cDovL2VuLndpa2lwZWRpYS5vcmcvd2lraS9Ub3BfcG9zdApROiBXZXJlIGRvIEkgZmlu
ZCBpbmZvIGFib3V0IHRoaXMgdGhpbmcgY2FsbGVkIHRvcC1wb3N0aW5nPwpBOiBCZWNhdXNlIGl0
IG1lc3NlcyB1cCB0aGUgb3JkZXIgaW4gd2hpY2ggcGVvcGxlIG5vcm1hbGx5IHJlYWQgdGV4dC4K
UTogV2h5IGlzIHRvcC1wb3N0aW5nIHN1Y2ggYSBiYWQgdGhpbmc/CkE6IFRvcC1wb3N0aW5nLgpR
OiBXaGF0IGlzIHRoZSBtb3N0IGFubm95aW5nIHRoaW5nIGluIGUtbWFpbD8KCkE6IE5vLgpROiBT
aG91bGQgSSBpbmNsdWRlIHF1b3RhdGlvbnMgYWZ0ZXIgbXkgcmVwbHk/CgpodHRwOi8vZGFyaW5n
ZmlyZWJhbGwubmV0LzIwMDcvMDcvb25fdG9wCgpPbiBXZWQsIE9jdCAyMCwgMjAyMSBhdCAwNDo0
NzoyM1BNICswODAwLCBYaWFudGluZyBUaWFuIHdyb3RlOgo+IGhpIEdyZWfvvIwKPiAKPiBDb3Vs
ZCBJIGdldMKgIHlvdXIgY29tbWVudHMgb2YgdGhpcyBuZXcgdmVyc2lvbiBwYXRjaGVz77yfIHRo
YW5rcwoKSXQgaGFzIGJlZW4gbGVzcyB0aGFuIDUgZGF5cy4gIFBsZWFzZSByZWxheCwgYW5kIG9u
bHkgd29ycnkgYWZ0ZXIgMgp3ZWVrcyBoYXZlIGdvbmUgYnkuICBXZSBoYXZlIGxvdHMgb2YgcGF0
Y2hlcyB0byByZXZpZXcuICBUbyBoZWxwCm1haW50YWluZXJzIG91dCwgd2h5IGRvbid0IHlvdSBy
ZXZpZXcgb3RoZXIgcGF0Y2hlcyBvbiB0aGUgbWFpbGluZyBsaXN0cwphcyB3ZWxsIHdoaWxlIHlv
dSB3YWl0PwoKdGhhbmtzLAoKZ3JlZyBrLWgKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
