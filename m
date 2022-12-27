Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069F3C4708D
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 07:49:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B5FC80BF2;
	Tue, 27 Dec 2022 07:49:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B5FC80BF2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=athKvejD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pgNGShd6HMse; Tue, 27 Dec 2022 07:49:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E524080B80;
	Tue, 27 Dec 2022 07:49:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E524080B80
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1842C0035;
	Tue, 27 Dec 2022 07:49:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EF6CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:49:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4666780BC6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:49:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4666780BC6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 50dJC0fUkXKN
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:49:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED56480B80
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED56480B80
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:49:33 +0000 (UTC)
Received: by mail-ua1-x92a.google.com with SMTP id k23so2778421ual.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5to3Z4Sn21mWEIZEJGvSoWUEuZOvMtlIkM4pTNXTa4=;
 b=athKvejDkz6WSCUOqN63r4RkPc7PljBcdn1pqKggjZSE8/UMue7d69Hl0+z0dS1T14
 TMhEMq/PWya4AXj39g9+GOrmLL/6PF0RM4WrxXttFOwovqpHxNQYtyH4IboGtbgLeNqV
 SXdXhdL07fADUCEVkrw4TPoqd61my8VqkLH8JoelYHKVxjoTN/wxYvv/ArhTnhs9dRHG
 k5aaZcuYrmlAQmcwMjLycR0ZuNHCCCf3taivtDVAZ5oAdkOHU0A1//IUelvkKEKIWYYa
 jNK5gRLbWE3DV++L1ZnaRG6YpOx9jMjvsaOPkoQD+v6pnSzOtW7vFH5SC2hG7hXGo4AN
 ec2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W5to3Z4Sn21mWEIZEJGvSoWUEuZOvMtlIkM4pTNXTa4=;
 b=f4ZwNZ1e8Y760r2OxgiGB7SuEFr9RDlega53jx9hplWiLrFGA1U8uhvqtHGZofVoMF
 FNB134igkRIugfJBFRgBWtH9b+vs2dhLF2rdkorfAfzz8B4N5GjUEaPxjIlcECUeMfGb
 s842j55hfAltTW34kyCeQ137REHpbkB+EDmlsek0CGOD/TM7S5NFNrJVZL6GDwLIlytF
 71CvJZmuCAhNg09nHwCBKO4XUVfs7z9JleL1OKfM2Iu5wL9OOZUghf+MdxB+p+8ixyhZ
 WTnTTr8dRe9HpPlqwWYMBiULSnY3trwbwEnnQaCCd7ANTj6gh9lpYhgc5GP/8FASiZ4B
 4hnw==
X-Gm-Message-State: AFqh2kqlHbXYo/OlYJMWA3Fqs9WtrWW25o7Df0fYMS3BlOZcP7hPJpFR
 V5L+xeHnoEvKRfbZK9xh3CLgd1xtfPhR8MO0OXP7/g==
X-Google-Smtp-Source: AMrXdXusNUsGQL0Ne/cKnzjlrEkV3MuC9iimVicFSzsdURbLbmAJZHBO2efWxuvY91KyNogPqzmtu2qQDpJ5tYpw3H8=
X-Received: by 2002:ab0:2eb7:0:b0:43a:243f:35b7 with SMTP id
 y23-20020ab02eb7000000b0043a243f35b7mr2032126uay.101.1672127372773; Mon, 26
 Dec 2022 23:49:32 -0800 (PST)
MIME-Version: 1.0
References: <20221227022528.609839-1-mie@igel.co.jp>
 <20221227022528.609839-5-mie@igel.co.jp>
 <20221227020007-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221227020007-mutt-send-email-mst@kernel.org>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Tue, 27 Dec 2022 16:49:21 +0900
Message-ID: <CANXvt5pRy-i7=_ikNkZPp2HcRmWZYNJYpjO_ieBJJVc90nds+A@mail.gmail.com>
Subject: Re: [RFC PATCH 4/9] vringh: unify the APIs for all accessors
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

MjAyMuW5tDEy5pyIMjfml6Uo54GrKSAxNjowNCBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRo
YXQuY29tPjoKPgo+IE9uIFR1ZSwgRGVjIDI3LCAyMDIyIGF0IDExOjI1OjI2QU0gKzA5MDAsIFNo
dW5zdWtlIE1pZSB3cm90ZToKPiA+IEVhY2ggdnJpbmdoIG1lbW9yeSBhY2Nlc3NvcnMgdGhhdCBh
cmUgZm9yIHVzZXIsIGtlcm4gYW5kIGlvdGxiIGhhcyBvd24KPiA+IGludGVyZmFjZXMgdGhhdCBj
YWxscyBjb21tb24gY29kZS4gQnV0IHNvbWUgY29kZXMgYXJlIGR1cGxpY2F0ZWQgYW5kIHRoYXQK
PiA+IGJlY29tZXMgbG9zcyBleHRlbmRhYmlsaXR5Lgo+ID4KPiA+IEludHJvZHVjZSBhIHN0cnVj
dCB2cmluZ2hfb3BzIGFuZCBwcm92aWRlIGEgY29tbW9uIEFQSXMgZm9yIGFsbCBhY2Nlc3NvcnMu
Cj4gPiBJdCBjYW4gYmVlIGVhc2lseSBleHRlbmRlZCB2cmluZ2ggY29kZSBmb3IgbmV3IG1lbW9y
eSBhY2Nlc3NvciBhbmQKPiA+IHNpbXBsaWZpZWQgYSBjYWxsZXIgY29kZS4KPiA+Cj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBTaHVuc3VrZSBNaWUgPG1pZUBpZ2VsLmNvLmpwPgo+ID4gLS0tCj4gPiAgZHJp
dmVycy92aG9zdC92cmluZ2guYyB8IDY2NyArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQo+ID4gIGluY2x1ZGUvbGludXgvdnJpbmdoLmggfCAxMDAgKysrLS0tCj4gPiAg
MiBmaWxlcyBjaGFuZ2VkLCAyMjUgaW5zZXJ0aW9ucygrKSwgNTQyIGRlbGV0aW9ucygtKQo+ID4K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jIGIvZHJpdmVycy92aG9zdC92
cmluZ2guYwo+ID4gaW5kZXggYWEzY2QyN2QyMzg0Li5lYmZkMzY0NGExYTMgMTAwNjQ0Cj4gPiAt
LS0gYS9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4gPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZyaW5n
aC5jCj4gPiBAQCAtMzUsMTUgKzM1LDEyIEBAIHN0YXRpYyBfX3ByaW50ZigxLDIpIF9fY29sZCB2
b2lkIHZyaW5naF9iYWQoY29uc3QgY2hhciAqZm10LCAuLi4pCj4gPiAgfQo+ID4KPiA+ICAvKiBS
ZXR1cm5zIHZyaW5nLT5udW0gaWYgZW1wdHksIC12ZSBvbiBlcnJvci4gKi8KPiA+IC1zdGF0aWMg
aW5saW5lIGludCBfX3ZyaW5naF9nZXRfaGVhZChjb25zdCBzdHJ1Y3QgdnJpbmdoICp2cmgsCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50ICgqZ2V0dTE2KShjb25zdCBz
dHJ1Y3QgdnJpbmdoICp2cmgsCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1MTYgKnZhbCwgY29uc3QgX192aXJ0aW8xNiAqcCksCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdTE2ICpsYXN0X2F2YWlsX2lkeCkKPiA+ICtzdGF0
aWMgaW5saW5lIGludCBfX3ZyaW5naF9nZXRfaGVhZChjb25zdCBzdHJ1Y3QgdnJpbmdoICp2cmgs
IHUxNiAqbGFzdF9hdmFpbF9pZHgpCj4gPiAgewo+ID4gICAgICAgdTE2IGF2YWlsX2lkeCwgaSwg
aGVhZDsKPiA+ICAgICAgIGludCBlcnI7Cj4gPgo+ID4gLSAgICAgZXJyID0gZ2V0dTE2KHZyaCwg
JmF2YWlsX2lkeCwgJnZyaC0+dnJpbmcuYXZhaWwtPmlkeCk7Cj4gPiArICAgICBlcnIgPSB2cmgt
Pm9wcy5nZXR1MTYodnJoLCAmYXZhaWxfaWR4LCAmdnJoLT52cmluZy5hdmFpbC0+aWR4KTsKPiA+
ICAgICAgIGlmIChlcnIpIHsKPiA+ICAgICAgICAgICAgICAgdnJpbmdoX2JhZCgiRmFpbGVkIHRv
IGFjY2VzcyBhdmFpbCBpZHggYXQgJXAiLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICZ2
cmgtPnZyaW5nLmF2YWlsLT5pZHgpOwo+Cj4gSSBsaWtlIHRoYXQgdGhpcyBwYXRjaCByZW1vdmVz
IG1vcmUgbGluZXMgb2YgY29kZSB0aGFuIGl0IGFkZHMuCj4KPiBIb3dldmVyIG9uZSBvZiB0aGUg
ZGVzaWduIHBvaW50cyBvZiB2cmluZ2ggYWJzdHJhY3Rpb25zIGlzIHRoYXQgdGhleSB3ZXJlCj4g
Y2FyZWZ1bGx5IHdyaXR0ZW4gdG8gYmUgdmVyeSBsb3cgb3ZlcmhlYWQuCj4gVGhpcyBpcyB3aHkg
d2UgYXJlIHBhc3NpbmcgZnVuY3Rpb24gcG9pbnRlcnMgdG8gaW5saW5lIGZ1bmN0aW9ucyAtCj4g
Y29tcGlsZXIgY2FuIG9wdGltaXplIHRoYXQgb3V0Lgo+Cj4gSSB0aGluayB0aGF0IGludHJvZHVj
aW5nIG9wcyBpbmRpcmVjdCBmdW5jdGlvbnMgY2FsbHMgaGVyZSBpcyBnb2luZyB0byBicmVhawo+
IHRoZXNlIGFzc3VtcHRpb25zIGFuZCBodXJ0IHBlcmZvcm1hbmNlLgo+IFVubGVzcyBjb21waWxl
ciBjYW4gc29tZWhvdyBmaWd1cmUgaXQgb3V0IGFuZCBvcHRpbWl6ZT8KPiBJIGRvbid0IHNlZSBo
b3cgaXQncyBwb3NzaWJsZSB3aXRoIG9wcyBwb2ludGVyIGluIG1lbW9yeQo+IGJ1dCBtYXliZSBJ
J20gd3JvbmcuCkkgdGhpbmsgeW91ciBjb25jZXJuIGlzIGNvcnJlY3QuIEkgaGF2ZSB0byB1bmRl
cnN0YW5kIHRoZSBjb21waWxlcgpvcHRpbWl6YXRpb24gYW5kIHJlZGVzaWduIHRoaXMgYXBwcm9h
Y2ggSWYgaXQgaXMgbmVlZGVkLgo+IFdhcyBhbnkgZWZmb3J0IHRha2VuIHRvIHRlc3QgZWZmZWN0
IG9mIHRoZXNlIHBhdGNoZXMgb24gcGVyZm9ybWFuY2U/CkkganVzdCB0ZXN0ZWQgdnJpbmdoX3Rl
c3QgYW5kIGFscmVhZHkgZmFjZWQgbGl0dGxlIHBlcmZvcm1hbmNlIHJlZHVjdGlvbi4KSSBoYXZl
IHRvIGludmVzdGlnYXRlIHRoYXQsIGFzIHlvdSBzYWlkLgoKVGhhbmsgeW91IGZvciB5b3VyIGNv
bW1lbnRzLgo+IFRoYW5rcyEKPgo+CkJlc3QsClNodW5zdWtlLgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
