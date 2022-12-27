Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8D5C10F1B
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 07:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B64568139B;
	Tue, 27 Dec 2022 07:14:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B64568139B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=JnDgLgH3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DRctbz0aREza; Tue, 27 Dec 2022 07:14:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4945781385;
	Tue, 27 Dec 2022 07:14:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4945781385
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AFE3C0032;
	Tue, 27 Dec 2022 07:14:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5AF0C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5D2C403A7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:14:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B5D2C403A7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=JnDgLgH3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oFkuLqL6jWIn
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:14:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F481400D1
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F481400D1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:14:01 +0000 (UTC)
Received: by mail-vs1-xe33.google.com with SMTP id h26so11924330vsr.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KQfd0qQa24pmN4jbSpJWNWeqDqVNRsi5GfHHVHb10I=;
 b=JnDgLgH3KEZYTTFz2OogWOc6UzxCg8sWVfEVHFghkWlpxlqZqelxy06X6jxl+1Qu4U
 5XbZ9CYTNySXfjx+Auz3LO7ziUDzSgOCEbwfyVWxcBj6aHAVy30eyInCPVqdjrDhDv5D
 azzjNfXtFa5kF8SmRD+zMOl+khoViUXeCmhNAe9I72Wjdi9Ui5C8X9geF1uK+l4iH7Yk
 3fd4ZsS+OZBcYdUAkNiCfqhm0ZUf8J05J/Y34snl9SUh4i+9ws7mgvc5B0ot+dCwyb9z
 atFV+c2Hn+RKPH8wgEI+ZMKfo6h7s7HJ5APo3ZeAwVy6CrblZf3x2fXCkVo+ZEQH/TBJ
 Ytuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+KQfd0qQa24pmN4jbSpJWNWeqDqVNRsi5GfHHVHb10I=;
 b=7d5z9SbjaLbgCZYV7QtSPLtBdX6TaGuqZavrntiblIJqjP3XePlzOhbr+82ZlHETgk
 +S9T8gTg3PUyJKAe/ft+fqyEuX1VzhHsW1ewXUvdyD0HSRffX6XyQoIniDSEwR9E82le
 cikAQLRW6W7FbsybVUkxL3SRR7rVHWosM7O02onBAhx/K7nDGidvyYW6nznKC4lTEqdj
 QD/tzGT/FdVBQQRapwWP4FhuDNPLWR/Y3o9o0YO4j5QLNJyJodq5JS5h9P2OKuDz2xPa
 4bVdk0kHmCdZsJeeLwIcfOdrcItCQz+HIGFLkOzLH7NihDamEkzwxhfRxSDQDskwUli6
 bRIg==
X-Gm-Message-State: AFqh2krBMPAaPPVZMmLDxxFrxZFVzd+Py0OgVDRwXVwsfhIQ/I8hALvG
 WMoNINsD1VEIBUi5JBbCLlHQpfHn6mrMhtcCI/kdog==
X-Google-Smtp-Source: AMrXdXveVEzfaCgCX7ll10/TckFbSv+JK5mIYKf8aCht+1Noe74CJXwAERw1BZvxxJVNWvLE//EQJd/v6X6NLOza8Yc=
X-Received: by 2002:a05:6102:14a7:b0:3b5:1126:2b62 with SMTP id
 d39-20020a05610214a700b003b511262b62mr2182450vsv.51.1672125239853; Mon, 26
 Dec 2022 23:13:59 -0800 (PST)
MIME-Version: 1.0
References: <20221227022528.609839-1-mie@igel.co.jp>
 <20221227022528.609839-3-mie@igel.co.jp>
 <CACGkMEtAaYpuZtS0gx_m931nFzcvqSNK9BhvUZH_tZXTzjgQCg@mail.gmail.com>
 <20221227020425-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221227020425-mutt-send-email-mst@kernel.org>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Tue, 27 Dec 2022 16:13:49 +0900
Message-ID: <CANXvt5pXkS=TTOU0+Lkx6CjcV7xvDHRS6FbFikJ4Ww8832sg8g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] vringh: remove vringh_iov and unite to vringh_kiov
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

MjAyMuW5tDEy5pyIMjfml6Uo54GrKSAxNjowNSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRo
YXQuY29tPjoKPgo+IE9uIFR1ZSwgRGVjIDI3LCAyMDIyIGF0IDAyOjA0OjAzUE0gKzA4MDAsIEph
c29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBUdWUsIERlYyAyNywgMjAyMiBhdCAxMDoyNSBBTSBTaHVu
c3VrZSBNaWUgPG1pZUBpZ2VsLmNvLmpwPiB3cm90ZToKPiA+ID4KPiA+ID4gc3RydWN0IHZyaW5n
aF9pb3YgaXMgZGVmaW5lZCB0byBob2xkIHVzZXJsYW5kIGFkZHJlc3Nlcy4gSG93ZXZlciwgdG8g
dXNlCj4gPiA+IGNvbW1vbiBmdW5jdGlvbiwgX192cmluZ19pb3YsIGZpbmFsbHkgdGhlIHZyaW5n
aF9pb3YgY29udmVydHMgdG8gdGhlCj4gPiA+IHZyaW5naF9raW92IHdpdGggc2ltcGxlIGNhc3Qu
IEl0IGluY2x1ZGVzIGNvbXBpbGUgdGltZSBjaGVjayBjb2RlIHRvIG1ha2UKPiA+ID4gc3VyZSBp
dCBjYW4gYmUgY2FzdCBjb3JyZWN0bHkuCj4gPiA+Cj4gPiA+IFRvIHNpbXBsaWZ5IHRoZSBjb2Rl
LCB0aGlzIHBhdGNoIHJlbW92ZXMgdGhlIHN0cnVjdCB2cmluZ2hfaW92IGFuZCB1bmlmaWVzCj4g
PiA+IEFQSXMgdG8gc3RydWN0IHZyaW5naF9raW92Lgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBTaHVuc3VrZSBNaWUgPG1pZUBpZ2VsLmNvLmpwPgo+ID4KPiA+IFdoaWxlIGF0IHRoaXMsIEkg
d29uZGVyIGlmIHdlIG5lZWQgdG8gZ28gZnVydGhlciwgdGhhdCBpcywgc3dpdGNoIHRvCj4gPiB1
c2luZyBhbiBpb3YgaXRlcmF0b3IgaW5zdGVhZCBvZiBhIHZyaW5naCBjdXN0b21pemVkIG9uZS4K
PiA+Cj4gPiBUaGFua3MKPgo+IFBvc3NpYmx5LCBidXQgd2hlbiBkb2luZyBjaGFuZ2VzIGxpa2Ug
dGhpcyBvbmUgbmVlZHMgdG8gYmUgY2FyZWZ1bAo+IHRvIGF2b2lkIGJyZWFraW5nIGFsbCB0aGUg
aW5saW5pbmcgdHJpY2tzIHZyaW5naCByZWxpZXMgb24gZm9yCj4gcGVyZm9ybWFuY2UuCkRlZmlu
aXRlbHksIEknbSBldmFsdWF0aW5nIHRoZSBwZXJmb3JtYW5jZSB1c2luZyB2cmluZ2hfdGVzdC4g
SSdsbCBhZGQgYQpyZXN1bHQgb2YgdGhlIGV2YWx1YXRpb24uIEJ1dCwgSWYgdGhlcmUgYXJlIG90
aGVyIGV2YWx1YXRpb24gbWV0aG9kcywgY291bGQgeW91CnBsZWFzZSB0ZWxsIG1lPwo+IC0tCj4g
TVNUCj4KCkJlc3QsClNodW5zdWtlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
