Return-Path: <SRS0=+sYM=C3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51A3C43467
	for <virtualization@archiver.kernel.org>; Fri, 18 Sep 2020 02:17:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581F123600
	for <virtualization@archiver.kernel.org>; Fri, 18 Sep 2020 02:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fjn5NYgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581F123600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0212887434;
	Fri, 18 Sep 2020 02:17:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UPoqKDcOOA9M; Fri, 18 Sep 2020 02:17:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 20E098741C;
	Fri, 18 Sep 2020 02:17:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04352C0859;
	Fri, 18 Sep 2020 02:17:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E285AC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 02:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D1ACE87195
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 02:17:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W7Mw1xr4HGZ6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 02:17:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0297287146
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 02:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600395430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ku+sICGKzWJ9hbk/lDryotAHNAcONZujUxBnYspdRTU=;
 b=Fjn5NYgscaLzBZ6FN8sKBSmHnI/WMoDdmHlolpOGkrjbf5Q+cpPux7UCoeCB7I7fj+A++V
 Nmj7l+wxDQjEdU5lT3gYTTlMmBH6WqzPtY9GSewOJ3qRILKSQNZ89+/71hTqoe6b1j60kk
 aI90lrhALptljSN76WqronQMioeIkYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-wx2RmR3bNLelwWeZZ_RbzQ-1; Thu, 17 Sep 2020 22:17:06 -0400
X-MC-Unique: wx2RmR3bNLelwWeZZ_RbzQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B88110BBEE6;
 Fri, 18 Sep 2020 02:17:05 +0000 (UTC)
Received: from [10.72.13.167] (ovpn-13-167.pek2.redhat.com [10.72.13.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4314510013C1;
 Fri, 18 Sep 2020 02:16:58 +0000 (UTC)
Subject: Re: [PATCH v2 -next] vdpa: mlx5: change Kconfig depends to fix build
 errors
To: Randy Dunlap <rdunlap@infradead.org>,
 virtualization@lists.linux-foundation.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Stephen Rothwell
 <sfr@canb.auug.org.au>, "Michael S. Tsirkin" <mst@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
References: <22a2bd60-d895-2bfb-50be-4ac3d131ed82@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f306fbfb-2984-d52d-b7be-7d65db643955@redhat.com>
Date: Fri, 18 Sep 2020 10:16:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <22a2bd60-d895-2bfb-50be-4ac3d131ed82@infradead.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjAvOS8xOCDkuIrljYgzOjQ1LCBSYW5keSBEdW5sYXAgd3JvdGU6Cj4gRnJvbTogUmFu
ZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+Cj4KPiBkcml2ZXJzL3ZkcGEvbWx4NS8g
dXNlcyB2aG9zdF9pb3RsYiooKSBpbnRlcmZhY2VzLCBzbyBhZGQgYSBkZXBlbmRlbmN5Cj4gb24g
VkhPU1QgdG8gZWxpbWluYXRlIGJ1aWxkIGVycm9ycy4KPgo+IGxkOiBkcml2ZXJzL3ZkcGEvbWx4
NS9jb3JlL21yLm86IGluIGZ1bmN0aW9uIGBhZGRfZGlyZWN0X2NoYWluJzoKPiBtci5jOigudGV4
dCsweDEwNik6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHZob3N0X2lvdGxiX2l0cmVlX2ZpcnN0
Jwo+IGxkOiBtci5jOigudGV4dCsweDFjZik6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHZob3N0
X2lvdGxiX2l0cmVlX25leHQnCj4gbGQ6IG1yLmM6KC50ZXh0KzB4MzBkKTogdW5kZWZpbmVkIHJl
ZmVyZW5jZSB0byBgdmhvc3RfaW90bGJfaXRyZWVfZmlyc3QnCj4gbGQ6IG1yLmM6KC50ZXh0KzB4
M2U4KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgdmhvc3RfaW90bGJfaXRyZWVfbmV4dCcKPiBs
ZDogZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5vOiBpbiBmdW5jdGlvbiBgX21seDVfdmRwYV9j
cmVhdGVfbXInOgo+IG1yLmM6KC50ZXh0KzB4OTA4KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBg
dmhvc3RfaW90bGJfaXRyZWVfZmlyc3QnCj4gbGQ6IG1yLmM6KC50ZXh0KzB4OWU2KTogdW5kZWZp
bmVkIHJlZmVyZW5jZSB0byBgdmhvc3RfaW90bGJfaXRyZWVfbmV4dCcKPiBsZDogZHJpdmVycy92
ZHBhL21seDUvY29yZS9tci5vOiBpbiBmdW5jdGlvbiBgbWx4NV92ZHBhX2hhbmRsZV9zZXRfbWFw
JzoKPiBtci5jOigudGV4dCsweGYxZCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHZob3N0X2lv
dGxiX2l0cmVlX2ZpcnN0Jwo+Cj4gU2lnbmVkLW9mZi1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFw
QGluZnJhZGVhZC5vcmc+Cj4gQ2M6ICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNv
bT4KPiBDYzogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiBDYzogdmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPiBDYzogU2FlZWQgTWFoYW1lZWQgPHNh
ZWVkbUBudmlkaWEuY29tPgo+IENjOiBMZW9uIFJvbWFub3Zza3kgPGxlb25yb0BudmlkaWEuY29t
Pgo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnCj4gLS0tCj4gdjI6IGNoYW5nZSBmcm9tIHNl
bGVjdCB0byBkZXBlbmRzIChTYWVlZCkKPgo+ICAgZHJpdmVycy92ZHBhL0tjb25maWcgfCAgICAy
ICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+
IC0tLSBsaW51eC1uZXh0LTIwMjAwOTE3Lm9yaWcvZHJpdmVycy92ZHBhL0tjb25maWcKPiArKysg
bGludXgtbmV4dC0yMDIwMDkxNy9kcml2ZXJzL3ZkcGEvS2NvbmZpZwo+IEBAIC0zMSw3ICszMSw3
IEBAIGNvbmZpZyBJRkNWRgo+ICAgCj4gICBjb25maWcgTUxYNV9WRFBBCj4gICAJYm9vbCAiTUxY
NSBWRFBBIHN1cHBvcnQgbGlicmFyeSBmb3IgQ29ubmVjdFggZGV2aWNlcyIKPiAtCWRlcGVuZHMg
b24gTUxYNV9DT1JFCj4gKwlkZXBlbmRzIG9uIFZIT1NUICYmIE1MWDVfQ09SRQoKCkl0IGxvb2tz
IHRvIG1lIHRoYXQgZGVwZW5kaW5nIG9uIFZIT1NUIGlzIHRvbyBoZWF2eXdlaWdodC4KCkkgZ3Vl
c3Mgd2hhdCBpdCByZWFsbHkgbmVlZHMgaXMgVkhPU1RfSU9UTEIuIFNvIHdlIGNhbiB1c2Ugc2Vs
ZWN0IApWSE9TVF9JT1RMQiBoZXJlLgoKVGhhbmtzCgoKPiAgIAlkZWZhdWx0IG4KPiAgIAloZWxw
Cj4gICAJICBTdXBwb3J0IGxpYnJhcnkgZm9yIE1lbGxhbm94IFZEUEEgZHJpdmVycy4gUHJvdmlk
ZXMgY29kZSB0aGF0IGlzCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
