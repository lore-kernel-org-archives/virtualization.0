Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259C7C7EE24
	for <virtualization@archiver.kernel.org>; Wed, 31 May 2023 08:17:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9F8F841CF7;
	Wed, 31 May 2023 08:17:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F8F841CF7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ackYPBYG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pLkPIL7bTntx; Wed, 31 May 2023 08:17:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1BCBC41C7E;
	Wed, 31 May 2023 08:17:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1BCBC41C7E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6B4BC0087;
	Wed, 31 May 2023 08:17:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A453BC0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 08:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E20082287
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 08:17:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E20082287
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ackYPBYG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ew9m52vwTP-C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 08:17:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0EEAB82284
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0EEAB82284
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 08:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685521061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSz+dEeNYH+4ngZm7IwuL2caHNvp+UxojfSLvR5hzoc=;
 b=ackYPBYGUWFuy9OxlOLeGCOynGDE+gevcuY3QSco1/WRnhirM/dr+5xlxkzfweJpWvD3v5
 vA2pWyoBNT1cMQDmiC+DjHewi5S9yMbNMKwsdloJ9GXTtu94iFRBWpgN+oclr10NZCkDT7
 Q5oqpyomV73Kji7FUoZ9Yx/ODsHSJQk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-HjowNkWTN12jGgrrIbKi5A-1; Wed, 31 May 2023 04:17:40 -0400
X-MC-Unique: HjowNkWTN12jGgrrIbKi5A-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2af23cfd23aso28691201fa.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 01:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685521059; x=1688113059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kSz+dEeNYH+4ngZm7IwuL2caHNvp+UxojfSLvR5hzoc=;
 b=G9cO/2R5Uv7vk3kMz83WIBQCoYTk2eZf+yhOr5qEPclElRjDNZrGXN3/IvkvTNRGCF
 kvaicJ3rOxE2Ib/n2/j2p5wZxZY8ZjdECVB2xz+UDxSy2Ggl/P5+MWOEe4zEegtMBkmY
 yBigMj/0o5YItR7T0DZdIbg3ihHH1JMlnBKTrRuqT6vfp8YEPTB0eoYqzBg5S4P0G2hM
 uh1I2wJYbZJdlps2t0glk/fHVCV2+Nf/xoZ+Kd1LwvUFt02DHovphZLEXFplhXj3t6H3
 rRKq/2hu26DysTuq5mcZX6qni2rdAidwiHqa5/EE31c9p6U5W5BY1vwsnFSgHctWeSDt
 unaw==
X-Gm-Message-State: AC+VfDxSKwKwnS+A0qecIux5TALERNctJSj+Ty46FZNm5hLQ/TRZL+Pj
 VkCCP6Q5vQf6rxE3KHioSNYtVAcIsjpOFdNOAWwEyZ7LsAuKNEewd3LtoTaHcBwojhVfCKQNqIm
 KR/3iwTDLBmVSPVIG35iuN2fqY1yKap2TgtmYNP+eOZMYeD3o9k6hQekJZg==
X-Received: by 2002:a05:651c:112:b0:2ad:92b9:83b4 with SMTP id
 a18-20020a05651c011200b002ad92b983b4mr1940392ljb.5.1685521059039; 
 Wed, 31 May 2023 01:17:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4W9YPS64wIKnQUYIqsmxXjeO0NPXfY7EevU0tX2ZqFX30ZAyvOoYCnOyPk0y8CnFb/TcsnmbVC7HuBZyZHL5U=
X-Received: by 2002:a05:651c:112:b0:2ad:92b9:83b4 with SMTP id
 a18-20020a05651c011200b002ad92b983b4mr1940387ljb.5.1685521058739; Wed, 31 May
 2023 01:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com>
 <20230523121506.GA6562@redhat.com>
 <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com>
 <20230531072449.GA25046@redhat.com>
In-Reply-To: <20230531072449.GA25046@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 May 2023 16:17:27 +0800
Message-ID: <CACGkMEv2kB9J1qGYkGkywk1YHV2gU2fMr7qx4vEv9L5f6qL5mg@mail.gmail.com>
Subject: Re: [PATCH 3/3] fork,
 vhost: Use CLONE_THREAD to fix freezer/ps regression
To: Oleg Nesterov <oleg@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com, linux@leemhuis.info,
 linux-kernel@vger.kernel.org, ebiederm@xmission.com, stefanha@redhat.com,
 nicolas.dichtel@6wind.com, virtualization@lists.linux-foundation.org,
 torvalds@linux-foundation.org
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

T24gV2VkLCBNYXkgMzEsIDIwMjMgYXQgMzoyNeKAr1BNIE9sZWcgTmVzdGVyb3YgPG9sZWdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiAwNS8zMSwgSmFzb24gV2FuZyB3cm90ZToKPiA+Cj4gPiDl
nKggMjAyMy81LzIzIDIwOjE1LCBPbGVnIE5lc3Rlcm92IOWGmemBkzoKPiA+ID4KPiA+ID4gICAg
ICAgICAgICAgLyogbWFrZSBzdXJlIGZsYWcgaXMgc2VlbiBhZnRlciBkZWxldGlvbiAqLwo+ID4g
PiAgICAgICAgICAgICBzbXBfd21iKCk7Cj4gPiA+ICAgICAgICAgICAgIGxsaXN0X2Zvcl9lYWNo
X2VudHJ5X3NhZmUod29yaywgd29ya19uZXh0LCBub2RlLCBub2RlKSB7Cj4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgY2xlYXJfYml0KFZIT1NUX1dPUktfUVVFVUVELCAmd29yay0+ZmxhZ3MpOwo+
ID4gPgo+ID4gPkkgYW0gbm90IHN1cmUgYWJvdXQgc21wX3dtYiArIGNsZWFyX2JpdC4gT25jZSB3
ZSBjbGVhciBWSE9TVF9XT1JLX1FVRVVFRCwKPiA+ID52aG9zdF93b3JrX3F1ZXVlKCkgY2FuIGFk
ZCB0aGlzIHdvcmsgYWdhaW4gYW5kIGNoYW5nZSB3b3JrLT5ub2RlLT5uZXh0Lgo+ID4gPgo+ID4g
PlRoYXQgaXMgd2h5IHdlIHVzZSBfc2FmZSwgYnV0IHdlIG5lZWQgdG8gZW5zdXJlIHRoYXQgbGxp
c3RfZm9yX2VhY2hfc2FmZSgpCj4gPiA+Y29tcGxldGVzIExPQUQod29yay0+bm9kZS0+bmV4dCkg
YmVmb3JlIFZIT1NUX1dPUktfUVVFVUVEIGlzIGNsZWFyZWQuCj4gPgo+ID4gVGhpcyBzaG91bGQg
YmUgZmluZSBzaW5jZSBzdG9yZSBpcyBub3Qgc3BlY3VsYXRlZCwgc28gd29yay0+bm9kZS0+bmV4
dCBuZWVkcwo+ID4gdG8gYmUgbG9hZGVkIGJlZm9yZSBWSE9TVF9XT1JLX1FVRVVFRCBpcyBjbGVh
cmVkIHRvIG1lZXQgdGhlIGxvb3AgY29uZGl0aW9uLgo+Cj4gSSBkb24ndCB1bmRlcnN0YW5kIHlv
dS4gT0ssIHRvIHNpbXBsaWZ5LCBzdXBwb3NlIHdlIGhhdmUgMiBnbG9iYWwgdmFycwo+Cj4gICAg
ICAgICB2b2lkICpQVFIgPSBzb21ldGhpbmdfbm9uX251bGw7Cj4gICAgICAgICB1bnNpZ25lZCBs
b25nIEZMQUdTID0gLTF1bDsKPgo+IE5vdyBJIHRoaW5rIHRoaXMgY29kZQo+Cj4gICAgICAgICBD
UFVfMCAgICAgICAgICAgICAgICAgICAgICAgICAgIENQVV8xCj4KPiAgICAgICAgIHZvaWQgKnB0
ciA9IFBUUjsgICAgICAgICAgICAgICAgaWYgKCF0ZXN0X2FuZF9zZXRfYml0KDAsIEZMQUdTKSkK
PiAgICAgICAgIGNsZWFyX2JpdCgwLCBGTEFHUyk7ICAgICAgICAgICAgICAgICAgICBQVFIgPSBO
VUxMOwo+ICAgICAgICAgQlVHX09OKCFwdHIpOwo+Cj4gaXMgcmFjeSBhbmQgY2FuIGhpdCB0aGUg
QlVHX09OKCFwdHIpLgoKVGhpcyBzZWVtcyBkaWZmZXJlbnQgdG8gdGhlIGFib3ZlIGNhc2U/IEFu
ZCB5b3UgY2FuIGhpdCBCVUdfT04gd2l0aAp0aGUgZm9sbG93aW5nIGV4ZWN1dGlvbiBzZXF1ZW5j
ZToKCltjcHUgMF0gY2xlYXJfYml0KDAsIEZMQUdTKTsKW2NwdSAxXSBpZiAoIXRlc3RfYW5kX3Nl
dF9iaXQoMCwgRkxBR1MpKQpbY3B1IDFdIFBUUiA9IE5VTEw7CltjcHUgMF0gQlVHX09OKCFwdHIp
CgpJbiB2aG9zdCBjb2RlLCB0aGVyZSdzIGEgY29uZGl0aW9uIGJlZm9yZSB0aGUgY2xlYXJfYml0
KCkgd2hpY2ggc2l0cwppbnNpZGUgbGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZSgpOgoKI2RlZmlu
ZSBsbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHBvcywgbiwgbm9kZSwgbWVtYmVyKSAgICAgICAg
ICAgICAgICAgICAgICAgIFwKICAgICAgICBmb3IgKHBvcyA9IGxsaXN0X2VudHJ5KChub2RlKSwg
dHlwZW9mKCpwb3MpLCBtZW1iZXIpOyAgICAgICAgICAgICAgICAgIFwKICAgICAgICAgICAgIG1l
bWJlcl9hZGRyZXNzX2lzX25vbm51bGwocG9zLCBtZW1iZXIpICYmICAgICAgICAgICAgICAgICAg
ICAgICAgIFwKICAgICAgICAgICAgICAgIChuID0gbGxpc3RfZW50cnkocG9zLT5tZW1iZXIubmV4
dCwgdHlwZW9mKCpuKSwgbWVtYmVyKSwgdHJ1ZSk7IFwKICAgICAgICAgICAgIHBvcyA9IG4pCgpU
aGUgY2xlYXJfYml0KCkgaXMgYSBzdG9yZSB3aGljaCBpcyBub3Qgc3BlY3VsYXRlZCwgc28gdGhl
cmUncyBhCmNvbnRyb2wgZGVwZW5kZW5jeSwgdGhlIHN0b3JlIGNhbid0IGJlIGV4ZWN1dGVkIHVu
dGlsIHRoZSBjb25kaXRpb24KZXhwcmVzc2lvbiBpcyBldmFsdWF0ZWQgd2hpY2ggcmVxdWlyZXMg
cG9zLT5tZW1iZXIubmV4dAood29yay0+bm9kZS5uZXh0KSB0byBiZSBsb2FkZWQuCgo+Cj4gSSBn
dWVzcyBpdCBpcyBmaW5lIG9uIHg4NiwgYnV0IGluIGdlbmVyYWwgeW91IG5lZWQgc21wX21iX19i
ZWZvcmVfYXRvbWljKCkKPiBiZWZvcmUgY2xlYXJfYml0KCksIG9yIGNsZWFyX2JpdF91bmxvY2so
KS4KPgo+ID4gPiAgICAgICAgICAgICAgICAgICAgIF9fc2V0X2N1cnJlbnRfc3RhdGUoVEFTS19S
VU5OSU5HKTsKPiA+ID4KPiA+ID5XaHkgZG8gd2Ugc2V0IFRBU0tfUlVOTklORyBpbnNpZGUgdGhl
IGxvb3A/IERvZXMgdGhpcyBtZWFuIHRoYXQgd29yay0+Zm4oKQo+ID4gPmNhbiByZXR1cm4gd2l0
aCBjdXJyZW50LT5zdGF0ZSAhPSBSVU5OSU5HID8KPiA+Cj4gPiBJdCBpcyBiZWNhdXNlIHRoZSBz
dGF0ZSB3ZXJlIHNldCB0byBUQVNLX0lOVEVSUlVQVElCTEUgaW4gdGhlIGJlZ2lubmluZyBvZgo+
ID4gdGhlIGxvb3Agb3RoZXJ3aXNlIGl0IG1pZ2h0IGJlIHNpZGUgZWZmZWN0IHdoaWxlIGV4ZWN1
dGluZyB3b3JrLT5mbigpLgo+Cj4gQWdhaW4sIEkgZG9uJ3QgdW5kZXJzdGFuZCB5b3UuIFNvIGxl
dCBtZSByZXBlYXQ6IGNhbiB3b3JrLT5mbigpIHJldHVybiB3aXRoCj4gY3VycmVudC0+X3N0YXRl
ICE9IFRBU0tfUlVOTklORyA/IElmIG5vdCAoYW5kIEknZCBzYXkgaXQgc2hvdWxkIG5vdCksIHlv
dSBjYW4KPiBkbyBfX3NldF9jdXJyZW50X3N0YXRlKFRBU0tfUlVOTklORykgb25jZSwgYmVmb3Jl
IGxsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoKS4KPgoKT2ssIHRoYXQgc2hvdWxkIGJlIGZpbmUu
CgpUaGFua3MKCgo+ID4gPk5vdyB0aGUgbWFpbiBxdWVzdGlvbi4gV2hhdGV2ZXIgd2UgZG8sIFNJ
R0tJTEwvU0lHU1RPUC9ldGMgY2FuIGNvbWUgcmlnaHQKPiA+ID5iZWZvcmUgd2UgY2FsbCB3b3Jr
LT5mbigpLiBJcyBpdCAic2FmZSIgdG8gcnVuIHRoaXMgY2FsbGJhY2sgd2l0aAo+ID4gPnNpZ25h
bF9wZW5kaW5nKCkgb3IgZmF0YWxfc2lnbmFsX3BlbmRpbmcoKSA/Cj4gPgo+ID4gSXQgbG9va3Mg
c2FmZSBzaW5jZToKPiA+Cj4gPiAxKSB2aG9zdCBob2xkIHJlZmNudCBvZiB0aGUgbW0KPiA+IDIp
IHJlbGVhc2Ugd2lsbCBzeW5jIHdpdGggdGhlIHdvcmtlcgo+Cj4gV2VsbCwgdGhhdCdzIG5vdCB3
aGF0IEkgYXNrZWQuLi4gbmV2ZXJtaW5kLCBwbGVhc2UgZm9yZ2V0Lgo+Cj4gVGhhbmtzLgo+Cj4g
T2xlZy4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
