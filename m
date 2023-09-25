Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43FECE7A8B
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 02:58:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2EE8E40649;
	Mon, 25 Sep 2023 02:58:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2EE8E40649
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PLVTPb8n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KUpGt-chOsyM; Mon, 25 Sep 2023 02:58:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 91D02400B9;
	Mon, 25 Sep 2023 02:58:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 91D02400B9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 765A2C0039;
	Mon, 25 Sep 2023 02:58:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 166B0C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 02:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E4881403F9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 02:58:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E4881403F9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OwnhYuaKyrBk
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 02:58:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 06C81400B9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 02:58:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06C81400B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695610683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=03qSg2yEAIVwRPqjjQs4G4M60zsU0m+0zE8R/M2ccL4=;
 b=PLVTPb8nVGamxngGjVqufSjZKZuhPiLrWFUeMgfWabfmqjkwdm/WT7o17Pth6x3OIsmKhO
 H2vDTQiwZaaJx0w0sLJsDv4Xy+sKl/O21VbxIK5NIh7ke3MUMAvkeKddnaIlo74hlYz1z/
 WSmg1pQKSaH0jHwM9BL0TBoPdlNvUhU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-LzB9qknAMkitucIu_Cd5_g-1; Sun, 24 Sep 2023 22:57:59 -0400
X-MC-Unique: LzB9qknAMkitucIu_Cd5_g-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5039413f4f9so7558407e87.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Sep 2023 19:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695610678; x=1696215478;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=03qSg2yEAIVwRPqjjQs4G4M60zsU0m+0zE8R/M2ccL4=;
 b=TbSWLo6tLPiLtyYU8pxoAMkiVqmZKmMa+PpbetPjzirm+PUMyztRK+6nAHK0GGSe12
 XBy5mcmmS9RJexU+jIiPr9nzKXQwVtDleuXjQr1Zficc7xSvHT1lrrtI9bh3JyQZ5anA
 Jd9D5kb8RTiw0QxCiVHERaOkkSkKCNDIe3ljA0SAYeDysdN9tuqnMrzq+QB4wvsnpcdN
 wTvmKJ0brIIVh2btUxAtVqGoD/X1jQWi2MBPs3F5ybYlqC7JIBpLlC7p1ROgC+rEYqSL
 e0X1XATmI3ZXEv54qOaKGzeZP0MFVO2Dp5dWGVlHiOUUust/ATXlCgHPy+jTcv+Hh8Wh
 Aeig==
X-Gm-Message-State: AOJu0YxOlgjjVurQ6cFHUowAw6XpayXfQCJzLLXAcpBzEKOhzIXsXvxo
 LQwqXeawnbdhuZ8XYTMf4D9auMqGgv4ZPKrcSiy1eJ6e2gfq3bA6RXJgPFUHXFV4MiYSa1jdbd8
 VjCI4RtF7xQ+kgVZ5H+Fqyuoo9tdApnNPQmTZ1NqJgk7Sm/cFMWzwmbslYA==
X-Received: by 2002:a05:6512:12c5:b0:4fb:8948:2b28 with SMTP id
 p5-20020a05651212c500b004fb89482b28mr5070666lfg.63.1695610678373; 
 Sun, 24 Sep 2023 19:57:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHF2qhzIv6Pe7cJCbr0RrCTBfYBL4roCVlrTfhCiGgKQygDz63GyQyQzV/OUarEVYJNkAsC1zhXb8toENTH6k=
X-Received: by 2002:a05:6512:12c5:b0:4fb:8948:2b28 with SMTP id
 p5-20020a05651212c500b004fb89482b28mr5070657lfg.63.1695610678004; Sun, 24 Sep
 2023 19:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com>
 <20230912030008.3599514-5-lulu@redhat.com>
 <CACGkMEtCYG8-Pt+V-OOwUV7fYFp_cnxU68Moisfxju9veJ-=qw@mail.gmail.com>
 <CACLfguW3NS_4+YhqTtGqvQb70mVazGVfheryHx4aCBn+=Skf9w@mail.gmail.com>
In-Reply-To: <CACLfguW3NS_4+YhqTtGqvQb70mVazGVfheryHx4aCBn+=Skf9w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Sep 2023 10:57:47 +0800
Message-ID: <CACGkMEt-m9bOh9YnqLw0So5wqbZ69D0XRVBbfG73Oh7Q8qTJsQ@mail.gmail.com>
Subject: Re: [RFC v2 4/4] vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 maxime.coquelin@redhat.com
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

T24gVGh1LCBTZXAgMjEsIDIwMjMgYXQgMTA6MDfigK9QTSBDaW5keSBMdSA8bHVsdUByZWRoYXQu
Y29tPiB3cm90ZToKPgo+IE9uIE1vbiwgU2VwIDE4LCAyMDIzIGF0IDQ6NDnigK9QTSBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBUdWUsIFNlcCAxMiwg
MjAyMyBhdCAxMTowMeKAr0FNIENpbmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4g
Pgo+ID4gPiBJbiBWRFVTRV9HRVRfUkVDT05ORUNUX0lORk8sIHRoZSBVc2Vyc3BhY2UgQXBwIGNh
biBnZXQgdGhlIG1hcCBzaXplCj4gPiA+IGFuZCBUaGUgbnVtYmVyIG9mIG1hcHBpbmcgbWVtb3J5
IHBhZ2VzIGZyb20gdGhlIGtlcm5lbC4gVGhlIHVzZXJzcGFjZQo+ID4gPiBBcHAgY2FuIHVzZSB0
aGlzIGluZm9ybWF0aW9uIHRvIG1hcCB0aGUgcGFnZXMuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IENpbmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgZHJpdmVycy92
ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYyB8IDE1ICsrKysrKysrKysrKysrKwo+ID4gPiAgaW5j
bHVkZS91YXBpL2xpbnV4L3ZkdXNlLmggICAgICAgICB8IDE1ICsrKysrKysrKysrKysrKwo+ID4g
PiAgMiBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspCj4gPiA+Cj4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jIGIvZHJpdmVycy92ZHBhL3Zk
cGFfdXNlci92ZHVzZV9kZXYuYwo+ID4gPiBpbmRleCA2ODBiMjNkYmRkZTIuLmM5OWY5OTg5MmI1
YyAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+
ID4gPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4gPiA+IEBAIC0x
MzY4LDYgKzEzNjgsMjEgQEAgc3RhdGljIGxvbmcgdmR1c2VfZGV2X2lvY3RsKHN0cnVjdCBmaWxl
ICpmaWxlLCB1bnNpZ25lZCBpbnQgY21kLAo+ID4gPiAgICAgICAgICAgICAgICAgcmV0ID0gMDsK
PiA+ID4gICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4gPiAgICAgICAgIH0KPiA+ID4gKyAgICAg
ICBjYXNlIFZEVVNFX0dFVF9SRUNPTk5FQ1RfSU5GTzogewo+ID4gPiArICAgICAgICAgICAgICAg
c3RydWN0IHZkdXNlX3JlY29ubmVjdF9tbWFwX2luZm8gaW5mbzsKPiA+ID4gKwo+ID4gPiArICAg
ICAgICAgICAgICAgcmV0ID0gLUVGQVVMVDsKPiA+ID4gKyAgICAgICAgICAgICAgIGlmIChjb3B5
X2Zyb21fdXNlcigmaW5mbywgYXJncCwgc2l6ZW9mKGluZm8pKSkKPiA+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgYnJlYWs7Cj4gPiA+ICsKPiA+ID4gKyAgICAgICAgICAgICAgIGluZm8uc2l6
ZSA9IFBBR0VfU0laRTsKPiA+ID4gKyAgICAgICAgICAgICAgIGluZm8ubWF4X2luZGV4ID0gZGV2
LT52cV9udW0gKyAxOwo+ID4gPiArCj4gPiA+ICsgICAgICAgICAgICAgICBpZiAoY29weV90b191
c2VyKGFyZ3AsICZpbmZvLCBzaXplb2YoaW5mbykpKQo+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBicmVhazsKPiA+ID4gKyAgICAgICAgICAgICAgIHJldCA9IDA7Cj4gPiA+ICsgICAgICAg
ICAgICAgICBicmVhazsKPiA+ID4gKyAgICAgICB9Cj4gPiA+ICAgICAgICAgZGVmYXVsdDoKPiA+
ID4gICAgICAgICAgICAgICAgIHJldCA9IC1FTk9JT0NUTENNRDsKPiA+ID4gICAgICAgICAgICAg
ICAgIGJyZWFrOwo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZkdXNlLmgg
Yi9pbmNsdWRlL3VhcGkvbGludXgvdmR1c2UuaAo+ID4gPiBpbmRleCBkNTg1NDI1ODAzZmQuLmNl
NTVlMzRmNjNkNyAxMDA2NDQKPiA+ID4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZkdXNlLmgK
PiA+ID4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZkdXNlLmgKPiA+ID4gQEAgLTM1Niw0ICsz
NTYsMTkgQEAgc3RydWN0IHZob3N0X3JlY29ubmVjdF92cmluZyB7Cj4gPiA+ICAgICAgICAgX0Jv
b2wgYXZhaWxfd3JhcF9jb3VudGVyOwo+ID4gPiAgfTsKPiA+ID4KPiA+ID4gKy8qKgo+ID4gPiAr
ICogc3RydWN0IHZkdXNlX3JlY29ubmVjdF9tbWFwX2luZm8KPiA+ID4gKyAqIEBzaXplOiBtYXBw
aW5nIG1lbW9yeSBzaXplLCBhbHdheXMgcGFnZV9zaXplIGhlcmUKPiA+ID4gKyAqIEBtYXhfaW5k
ZXg6IHRoZSBudW1iZXIgb2YgcGFnZXMgYWxsb2NhdGVkIGluIGtlcm5lbCxqdXN0Cj4gPiA+ICsg
KiB1c2UgZm9yIGNoZWNrCj4gPiA+ICsgKi8KPiA+ID4gKwo+ID4gPiArc3RydWN0IHZkdXNlX3Jl
Y29ubmVjdF9tbWFwX2luZm8gewo+ID4gPiArICAgICAgIF9fdTMyIHNpemU7Cj4gPiA+ICsgICAg
ICAgX191MzIgbWF4X2luZGV4Owo+ID4gPiArfTsKPiA+Cj4gPiBPbmUgdGhpbmcgSSBkaWRuJ3Qg
dW5kZXJzdGFuZCBpcyB0aGF0LCBhcmVuJ3QgdGhlIHRoaW5ncyB3ZSB1c2VkIHRvCj4gPiBzdG9y
ZSBjb25uZWN0aW9uIGluZm8gYmVsb25nIHRvIHVBUEk/IElmIG5vdCwgaG93IGNhbiB3ZSBtYWtl
IHN1cmUgdGhlCj4gPiBjb25uZWN0aW9ucyB3b3JrIGFjcm9zcyBkaWZmZXJlbnQgdmVuZG9ycy9p
bXBsZW1lbnRhdGlvbnMuIElmIHllcywKPiA+IHdoZXJlPwo+ID4KPiA+IFRoYW5rcwo+ID4KPiBU
aGUgcHJvY2VzcyBmb3IgdGhpcyByZWNvbm5lY3R0aW9uICBpcwo+IEEuVGhlIGZpcnN0LXRpbWUg
Y29ubmVjdGlvbgo+IDE+IFRoZSB1c2VybGFuZCBhcHAgY2hlY2tzIGlmIHRoZSBkZXZpY2UgZXhp
c3RzCj4gMj4gIHVzZSB0aGUgaW9jdGwgdG8gY3JlYXRlIHRoZSB2ZHVzZSBkZXZpY2UKPiAzPiBN
YXBwaW5nIHRoZSBrZXJuZWwgcGFnZSB0byB1c2VybGFuZCBhbmQgc2F2ZSB0aGUKPiBBcHAtdmVy
c2lvbi9mZWF0dXJlcy9vdGhlciBpbmZvcm1hdGlvbiB0byB0aGlzIHBhZ2UKPiA0PiAgaWYgdGhl
IFVzZXJsYW5kIGFwcCBuZWVkcyB0byBleGl0LCB0aGVuIHRoZSBVc2VybGFuZCBhcHAgd2lsbCBv
bmx5Cj4gdW5tYXAgdGhlIHBhZ2UgYW5kIHRoZW4gZXhpdAo+Cj4gQiwgdGhlIHJlLWNvbm5lY3Rp
b24KPiAxPiB0aGUgdXNlcmxhbmQgYXBwIGZpbmRzIHRoZSBkZXZpY2UgaXMgZXhpc3RpbmcKPiAy
PiBNYXBwaW5nIHRoZSBrZXJuZWwgcGFnZSB0byB1c2VybGFuZAo+IDM+IGNoZWNrIGlmIHRoZSBp
bmZvcm1hdGlvbiBpbiBzaGFyZWQgbWVtb3J5IGlzIHNhdGlzZmllZCB0bwo+IHJlY29ubmVjdCxp
ZiBvayB0aGVuIGNvbnRpbnVlIHRvIHJlY29ubmVjdAo+IDQ+IGNvbnRpbnVlIHdvcmtpbmcKPgo+
ICBGb3Igbm93IHRoZXNlIGluZm9ybWF0aW9uIGFyZSBhbGwgZnJvbSB1c2VybGFuZCxTbyBoZXJl
IHRoZSBwYWdlIHdpbGwKPiBiZSBtYWludGFpbmVkIGJ5IHRoZSB1c2VybGFuZCBBcHAKPiBpbiB0
aGUgcHJldmlvdXMgY29kZSB3ZSBvbmx5IHNhdmVkIHRoZSBhcGktdmVyc2lvbiBieSB1QVBJIC4g
IGlmICB3ZQo+IG5lZWQgdG8gc3VwcG9ydCByZWNvbm5lY3Rpb24gbWF5YmUgd2UgbmVlZCB0byBh
ZGQgMiBuZXcgdUFQSSBmb3IgdGhpcywKPiBvbmUgb2YgdGhlIHVBUEkgaXMgdG8gc2F2ZSB0aGUg
cmVjb25uZWN0ICBpbmZvcm1hdGlvbiBhbmQgYW5vdGhlciBpcwo+IHRvIGdldCB0aGUgaW5mb3Jt
YXRpb24KPgo+IG1heWJlIHNvbWV0aGluZyBsaWtlCj4KPiBzdHJ1Y3Qgdmhvc3RfcmVjb25uZWN0
X2RhdGEgewo+IHVpbnQzMl90IHZlcnNpb247Cj4gdWludDY0X3QgZmVhdHVyZXM7Cj4gdWludDhf
dCBzdGF0dXM7Cj4gc3RydWN0IHZpcnRpb19uZXRfY29uZmlnIGNvbmZpZzsKPiB1aW50MzJfdCBu
cl92cmluZ3M7Cj4gfTsKClByb2JhYmx5LCB0aGVuIHdlIGNhbiBtYWtlIHN1cmUgdGhlIHJlLWNv
bm5lY3Rpb24gd29ya3MgYWNyb3NzCmRpZmZlcmVudCB2ZHVzZS1kYWVtb24gaW1wbGVtZW50YXRp
b25zLgoKPgo+ICNkZWZpbmUgVkRVU0VfR0VUX1JFQ09OTkVDVF9JTkZPIF9JT1IgKFZEVVNFX0JB
U0UsIDB4MWMsIHN0cnVjdAo+IHZob3N0X3JlY29ubmVjdF9kYXRhKQo+Cj4gI2RlZmluZSBWRFVT
RV9TRVRfUkVDT05ORUNUX0lORk8gIF9JT1dSKFZEVVNFX0JBU0UsIDB4MWQsIHN0cnVjdAo+IHZo
b3N0X3JlY29ubmVjdF9kYXRhKQoKTm90IHN1cmUgSSBnZXQgdGhpcywgYnV0IHRoZSBpZGVhIGlz
IHRvIG1hcCB0aG9zZSBwYWdlcyB0byB1c2VyIHNwYWNlLAphbnkgcmVhc29uIHdlIG5lZWQgdGhp
cyB1QVBJPwoKVGhhbmtzCgo+Cj4gVGhhbmtzCj4gQ2luZHkKPgo+Cj4KPgo+ID4gPiArCj4gPiA+
ICsjZGVmaW5lIFZEVVNFX0dFVF9SRUNPTk5FQ1RfSU5GTyBcCj4gPiA+ICsgICAgICAgX0lPV1Io
VkRVU0VfQkFTRSwgMHgxYiwgc3RydWN0IHZkdXNlX3JlY29ubmVjdF9tbWFwX2luZm8pCj4gPiA+
ICsKPiA+ID4gICNlbmRpZiAvKiBfVUFQSV9WRFVTRV9IXyAqLwo+ID4gPiAtLQo+ID4gPiAyLjM0
LjMKPiA+ID4KPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
