Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D648C77B7D
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 13:49:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EBAFB40584;
	Wed, 17 May 2023 13:49:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EBAFB40584
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sz0mq+nI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 61AWyKPX6tut; Wed, 17 May 2023 13:49:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3417D400F2;
	Wed, 17 May 2023 13:49:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3417D400F2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13940C0036;
	Wed, 17 May 2023 13:49:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F330C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 13:49:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2A1AD42113
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 13:49:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A1AD42113
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sz0mq+nI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ApdgdVYeJ5mG
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 13:49:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 93C6C41EBA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 93C6C41EBA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 13:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684331373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0e/SUf5A48wwb3JWMFE3HoGFxkqjXULKhzRKlOy/0Pk=;
 b=Sz0mq+nIoIyqtQ22doy1nrF+vVAQvIxREvlO7LrLfIgkWOAxc0SZ3YOUf3alY1LYe8Yw9w
 chl12fPdtzkddzF8hoKZ0nHgHyt0i+8l8aHPK0lfxXgqEE4HRj7uunSXPf/Hf9DyaEq6G9
 WgjdmWMpYX6cThNKCYIFvdvl21ALxd8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-hr17p6FIM3iu_8gzzwuISQ-1; Wed, 17 May 2023 09:49:32 -0400
X-MC-Unique: hr17p6FIM3iu_8gzzwuISQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3079d15b51dso10880f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 06:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684331369; x=1686923369;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0e/SUf5A48wwb3JWMFE3HoGFxkqjXULKhzRKlOy/0Pk=;
 b=CRXyh/zlknG2JPXVpCY6gFdM48+R7+Y17PYqPZxom7F2FVs+uZHIZzyMGlbCNXn8Zy
 3pIVO7MMhf31tzNMYzbCB0JRVtjpxhkGkLBaSdwlrIeRSUjrKvieJy9l9QM52W/X8KlT
 oYlw5cxvsI6KUVCuXL46GvUxE6u2gf0pFyRDed7aXXPlOHav9VqEvGZUdHWtgzfZDH0f
 3RbykD+UMI3yZZPhLe05TXKWkooO3gAHHLvV84AZJVyIeVje7NSvUcD12pt8JGrXSZaK
 mZEjbUYk0SprRxSkn8qvo5fLHv39PkXAzIFeTJiDvV1MdqiasEG98sHLHqe07Hg4Jhi1
 rV8g==
X-Gm-Message-State: AC+VfDzICoK0Hn71TlRTwdrHxNNS7AkWKsYzh8rcDuWQdBalafXXXsq2
 T0+/wyb/EhHPVtEh3Lmtm/Tc4eVDabpB2QuM7N/bWoqWN8+j+6TGv/k4X0xRiU6ODo3hLenqA9R
 Z2N/FgY4Za0unFRzn0BTx9HXs222mnkePCRJejQXjqA==
X-Received: by 2002:adf:e74f:0:b0:2f7:cfe2:6507 with SMTP id
 c15-20020adfe74f000000b002f7cfe26507mr675509wrn.20.1684331369591; 
 Wed, 17 May 2023 06:49:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5a5arMtnNTOv8xW4922VW8BZeZ7wJoPt5cnWb7Q96XDpQAvRopJCLeAn9BjbsFKP1k1Lhf+w==
X-Received: by 2002:adf:e74f:0:b0:2f7:cfe2:6507 with SMTP id
 c15-20020adfe74f000000b002f7cfe26507mr675476wrn.20.1684331369155; 
 Wed, 17 May 2023 06:49:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3900:757e:83f8:a99d:41ae?
 (p200300cbc7073900757e83f8a99d41ae.dip0.t-ipconnect.de.
 [2003:cb:c707:3900:757e:83f8:a99d:41ae])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a05600c224300b003f17848673fsm2323496wmm.27.2023.05.17.06.49.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 06:49:28 -0700 (PDT)
Message-ID: <9aa7d030-19b5-01df-70c0-86d8d6ab86a6@redhat.com>
Date: Wed, 17 May 2023 15:49:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/7] riscv: Memory Hot(Un)Plug support
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org
References: <20230512145737.985671-1-bjorn@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230512145737.985671-1-bjorn@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, linux@rivosinc.com,
 linux-kernel@vger.kernel.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Oscar Salvador <osalvador@suse.de>
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

T24gMTIuMDUuMjMgMTY6NTcsIEJqw7ZybiBUw7ZwZWwgd3JvdGU6Cj4gRnJvbTogQmrDtnJuIFTD
tnBlbCA8Ympvcm5Acml2b3NpbmMuY29tPgo+IAo+IE1lbW9yeSBIb3QoVW4pUGx1ZyBzdXBwb3J0
IGZvciB0aGUgUklTQy1WIHBvcnQKPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09Cj4gCj4gSW50cm9kdWN0aW9uCj4gLS0tLS0tLS0tLS0tCj4gCj4gVG8gcXVv
dGUgIkRvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvbW0vbWVtb3J5LWhvdHBsdWcucnN0IjogIk1l
bW9yeQo+IGhvdCh1bilwbHVnIGFsbG93cyBmb3IgaW5jcmVhc2luZyBhbmQgZGVjcmVhc2luZyB0
aGUgc2l6ZSBvZiBwaHlzaWNhbAo+IG1lbW9yeSBhdmFpbGFibGUgdG8gYSBtYWNoaW5lIGF0IHJ1
bnRpbWUuIgo+IAo+IFRoaXMgc2VyaWVzIGF0dGVtcHRzIHRvIGFkZCBtZW1vcnkgaG90KHVuKXBs
dWcgc3VwcG9ydCBmb3IgdGhlIFJJU0MtVgo+IExpbnV4IHBvcnQuCj4gCj4gSSdtIHNlbmRpbmcg
dGhlIHNlcmllcyBhcyBhIHYxLCBidXQgaXQncyBib3JkZXJsaW5lIFJGQy4gSXQgZGVmaW5pdGVs
eQo+IG5lZWRzIG1vcmUgdGVzdGluZyB0aW1lLCBidXQgaXQgd291bGQgYmUgbmljZSB3aXRoIHNv
bWUgZWFybHkgaW5wdXQuCj4gCj4gSW1wbGVtZW50YXRpb24KPiAtLS0tLS0tLS0tLS0tLQo+IAo+
ICBGcm9tIGFuIGFyY2ggcGVyc3BlY3RpdmUsIGEgY291cGxlIG9mIGNhbGxiYWNrcyBuZWVkcyB0
byBiZQo+IGltcGxlbWVudGVkIHRvIHN1cHBvcnQgaG90IHBsdWdnaW5nOgo+IAo+IGFyY2hfYWRk
X21lbW9yeSgpCj4gVGhpcyBjYWxsYmFjayBpcyByZXNwb25zaWJsZSBmb3IgdXBkYXRpbmcgdGhl
IGxpbmVhci9kaXJlY3QgbWFwLCBhbmQKPiBjYWxsIGludG8gdGhlIG1lbW9yeSBob3QgcGx1Z2dp
bmcgZ2VuZXJpYyBjb2RlIHZpYSBfX2FkZF9wYWdlcygpLgo+IAo+IGFyY2hfcmVtb3ZlX21lbW9y
eSgpCj4gSW4gdGhpcyBjYWxsYmFjayB0aGUgbGluZWFyL2RpcmVjdCBtYXAgaXMgdG9yZSBkb3du
Lgo+IAo+IHZtZW1tYXBfZnJlZSgpCj4gVGhlIGZ1bmN0aW9uIHRlYXJzIGRvd24gdGhlIHZtZW1t
YXAgbWFwcGluZ3MgKGlmCj4gQ09ORklHX1NQQVJTRU1FTV9WTUVNTUFQIGlzIGluLXVzZSksIGFu
ZCBhbHNvIGRlYWxsb2NhdGVzIHRoZSBiYWNraW5nCj4gdm1lbW1hcCBwYWdlcy4gTm90ZSB0aGF0
IGZvciBwZXJzaXN0ZW50IG1lbW9yeSwgYW4gYWx0ZXJuYXRpdmUKPiBhbGxvY2F0b3IgZm9yIHRo
ZSBiYWNraW5nIHBhZ2VzIGNhbiBiZSB1c2VkIC0tIHRoZSB2bWVtX2FsdG1hcC4gVGhpcwo+IG1l
YW5zIHRoYXQgd2hlbiB0aGUgYmFja2luZyBwYWdlcyBhcmUgY2xlYXJlZCwgZXh0cmEgY2FyZSBp
cyBuZWVkZWQgc28KPiB0aGF0IHRoZSBjb3JyZWN0IGRlYWxsb2NhdGlvbiBtZXRob2QgaXMgdXNl
ZC4gTm90ZSB0aGF0IFJJU0MtVgo+IHBvcHVsYXRlcyB0aGUgdm1lbW1hcCB1c2luZyB2bWVtbWFw
X3BvcHVsYXRlX2Jhc2VwYWdlcygpLCBzbyBjdXJyZW50bHkKPiBubyBodWdlcGFnZXMgYXJlIHVz
ZWQgZm9yIHRoZSBiYWNraW5nIHN0b3JlLgo+IAo+IFRoZSBwYWdlIHRhYmxlIHVubWFwL3RlYXJk
b3duIGZ1bmN0aW9ucyBhcmUgaGVhdmlseSBiYXNlZCAoY29waWVkISkKPiBmcm9tIHRoZSB4ODYg
dHJlZS4gVGhlIHNhbWUgcmVtb3ZlX3BnZF9tYXBwaW5nKCkgaXMgdXNlZCBpbiBib3RoCj4gdm1l
bW1hcF9mcmVlKCkgYW5kIGFyY2hfcmVtb3ZlX21lbW9yeSgpLCBidXQgaW4gdGhlIGxhdHRlciBm
dW5jdGlvbgo+IHRoZSBiYWNraW5nIHBhZ2VzIGFyZSBub3QgcmVtb3ZlZC4KPiAKPiBPbiBSSVND
LVYsIHRoZSBQR0QgbGV2ZWwga2VybmVsIG1hcHBpbmdzIG5lZWRzIHRvIHN5bmNocm9uaXplZCB3
aXRoCj4gYWxsIHBhZ2UtdGFibGVzIChlLmcuIHZpYSBzeW5jX2tlcm5lbF9tYXBwaW5ncygpKS4g
U3luY2hyb25pemF0aW9uCj4gaW52b2x2ZXMgc3BlY2lhbCBjYXJlLCBsaWtlIGxvY2tpbmcuIElu
c3RlYWQsIHRoaXMgcGF0Y2ggc2VyaWVzIHRha2VzCj4gYSBkaWZmZXJlbnQgYXBwcm9hY2ggKGlu
dHJvZHVjZWQgYnkgSsO2cmcgUsO2ZGVsIGluIHRoZSB4ODYtdHJlZSk7Cj4gUHJlLWFsbG9jYXRl
IHRoZSBQR0QtbGVhdmVzIChQNEQsIFBVRCwgb3IgUE1EIGRlcGVuZGluZyBvbiB0aGUgcGFnaW5n
Cj4gc2V0dXApIGF0IG1lbV9pbml0KCksIGZvciB2bWVtbWFwIGFuZCB0aGUgZGlyZWN0IG1hcC4K
PiAKPiBQcmUtYWxsb2NhdGluZyB0aGUgUEdELWxlYXZlcyB3YXN0ZSBzb21lIG1lbW9yeSwgYnV0
IGlzIG9ubHkgZW5hYmxlZAo+IGZvciBDT05GSUdfTUVNT1JZX0hPVFBMVUcuIFRoZSBudW1iZXIg
cGFnZXMsIHBvdGVudGlhbGx5IHVudXNlZCwgYXJlCj4gfjEyOCAqIDRLLgo+IAo+IFBhdGNoIDE6
IFByZXBhcmF0aW9uIGZvciBob3RwbHVnZ2luZyBzdXBwb3J0LCBieSBwcmUtYWxsb2NhdGluZyB0
aGUKPiAgICAgICAgICAgUEdEIGxlYXZlcy4KPiAKPiBQYXRjaCAyOiBDaGFuZ2VzIHRoZSBfX2lu
aXQgYXR0cmlidXRlIHRvIF9fbWVtaW5pdCwgdG8gYXZvaWQgdGhhdCB0aGUKPiAgICAgICAgICAg
ZnVuY3Rpb25zIGFyZSByZW1vdmVkIGFmdGVyIGluaXQuIF9fbWVtaW5pdCBrZWVwcyB0aGUKPiAg
ICAgICAgICAgZnVuY3Rpb25zIGFmdGVyIGluaXQsIGlmIG1lbW9yeSBob3RwbHVnZ2luZyBpcyBl
bmFibGVkIGZvcgo+ICAgICAgICAgICB0aGUgYnVpbGQuCj4gICAgICAgICAgIAo+IFBhdGNoIDM6
IFJlZmFjdG9yIHRoZSBkaXJlY3QgbWFwIHNldHVwLCBzbyBpdCBjYW4gYmUgdXNlZCBmb3IgaG90
IGFkZC4KPiAKPiBQYXRjaCA0OiBUaGUgYWN0dWFsIGFkZC9yZW1vdmUgY29kZS4gTW9zdGx5IGEg
cGFnZS10YWJsZS13YWxrCj4gICAgICAgICAgIGV4ZXJjaXNlLgo+IAo+IFBhdGNoIDU6IFR1cm4g
b24gdGhlIGFyY2ggc3VwcG9ydCBpbiBLY29uZmlnCj4gCj4gUGF0Y2ggNjogTm93IHRoYXQgbWVt
b3J5IGhvdHBsdWdnaW5nIGlzIGVuYWJsZWQsIG1ha2UgdmlydGlvLW1lbQo+ICAgICAgICAgICB1
c2FibGUgZm9yIFJJU0MtVgo+ICAgICAgICAgICAKPiBQYXRjaCA3OiBQcmUtYWxsb2NhdGUgdm1h
bGxvYyBQR0QtbGVhdmVzIGFzIHdlbGwsIHdoaWNoIHJlbW92ZXMgdGhlCj4gICAgICAgICAgIG5l
ZWQgZm9yIHZtYWxsb2MgZmF1bHRpbmcuCj4gICAgICAgICAgIAo+IFJGQwo+IC0tLQo+IAo+ICAg
KiBUTEIgZmx1c2hlcy4gVGhlIGN1cnJlbnQgc2VyaWVzIHVzZXMgQmlnIEhhbW1lciBmbHVzaC1p
dC1hbGwuCj4gICAqIFByZS1hbGxvY2F0aW9uIHZzIGV4cGxpY2l0IHN5bmNzCj4gCj4gVGVzdGlu
Zwo+IC0tLS0tLS0KPiAKPiBBQ1BJIHN1cHBvcnQgaXMgc3RpbGwgaW4gdGhlIG1ha2luZyBmb3Ig
UklTQy1WLCBzbyB0ZXN0cyB0aGF0IGludm9sdmUKPiBDWEwgYW5kIHNpbWlsYXIgZmFuY2luZXNz
IGlzIGN1cnJlbnRseSBub3QgcG9zc2libGUuIFZpcnRpby1tZW0sCj4gaG93ZXZlciwgd29ya3Mg
d2l0aG91dCBwcm9wZXIgQUNQSSBzdXBwb3J0LiBJbiBvcmRlciB0byB0cnkgdGhpcyBvdXQKPiBp
biBRZW11LCBzb21lIGFkZGl0aW9uYWwgcGF0Y2hlcyBmb3IgUWVtdSBhcmUgbmVlZGVkOgo+IAo+
ICAgKiBFbmFibGUgdmlydGlvLW1lbSBmb3IgUklTQy1WCj4gICAqIEFkZCBwcm9wZXIgaG90cGx1
ZyBzdXBwb3J0IGZvciB2aXJ0aW8tbWVtCj4gICAKPiBUaGUgcGF0Y2ggZm9yIFFlbXUgY2FuIGJl
IGZvdW5kIGlzIGNvbW1pdCA1ZDkwYTdlZjFiYzAKPiAoImh3L3Jpc2N2L3ZpcnQ6IFN1cHBvcnQg
Zm9yIHZpcnRpby1tZW0tcGNpIiksIGFuZCBjYW4gYmUgZm91bmQgaGVyZQo+IAo+ICAgIGh0dHBz
Oi8vZ2l0aHViLmNvbS9iam90by9xZW11L3RyZWUvcmlzY3YtdmlydGlvLW1lbQo+IAo+IEkgd2ls
bCB0cnkgdG8gdXBzdHJlYW0gdGhhdCB3b3JrIGluIHBhcmFsbGVsIHdpdGggdGhpcy4KPiAgICAK
PiBUaGFua3MgdG8gRGF2aWQgSGlsZGVuYnJhbmQgZm9yIHZhbHVhYmxlIGlucHV0IGZvciB0aGUg
UWVtdSBzaWRlIG9mCj4gdGhpbmdzLgo+IAo+IFRoZSBzZXJpZXMgaXMgYmFzZWQgb24gdGhlIFJJ
U0MtViBmaXhlcyB0cmVlCj4gICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvcmlzY3YvbGludXguZ2l0L2xvZy8/aD1maXhlcwo+IAoKQ29vbCBzdHVmZiEg
SSdtIGZhaXJseSBidXN5IHJpZ2h0IG5vdywgc28gc29tZSBoaWdoLWxldmVsIHF1ZXN0aW9ucyB1
cGZyb250OgoKV2hhdCBpcyB0aGUgbWVtb3J5IHNlY3Rpb24gc2l6ZSAod2hpY2ggaW1wbGllcyB0
aGUgbWVtb3J5IGJsb2NrIHNpemUgCmFuZCk/IFRoaXMgaW1wbGllcyB0aGUgbWluaW11bSBESU1N
IGdyYW51bGFyaXR5IGFuZCB0aGUgaGlnaC1sZXZlbCAKZ3JhbnVsYXJpdHkgaW4gd2hpY2ggdmly
dGlvLW1lbSBhZGRzIG1lbW9yeS4KCldoYXQgaXMgdGhlIHBhZ2VibG9jayBzaXplLCBpbXBseWlu
ZyB0aGUgbWluaW11bSBncmFudWxhcml0eSB0aGF0IAp2aXJ0aW8tbWVtIGNhbiBvcGVyYXRlIG9u
PwoKT24geDg2LTY0IGFuZCBhcm02NCB3ZSBjdXJyZW50bHkgdXNlIHRoZSBBQ1BJIFNSQVQgdG8g
ZXhwb3NlIHRoZSBtYXhpbXVtIApwaHlzaWNhbCBhZGRyZXNzIHdoZXJlIHdlIGNhbiBzZWUgbWVt
b3J5IGdldHRpbmcgaG90cGx1Z2dlZC4gWzFdIEZyb20gCnRoYXQsIHdlIGNhbiBkZXJpdmUgdGhl
ICJtYXhfcG9zc2libGVfcGZuIiBhbmQgcHJlcGFyZSB0aGUga2VybmVsIAp2aXJ0dWFsIG1lbW9y
eSBsYXlvdXJ0IChlc3BlY2lhbGx5LCBkaXJlY3QgbWFwKS4KCklzIHNvbWV0aGluZyBzaW1pbGFy
IHJlcXVpcmVkIG9uIFJJU0MtVj8gT24gczM5MHgsIEknbSBwbGFubmluZyBvbiAKYWRkaW5nIGEg
cGFyYXZpcnR1YWxpemVkIG1lY2hhbmlzbSB0byBkZXRlY3Qgd2hlcmUgbWVtb3J5IGRldmljZXMg
bWlnaHQgCmJlIGxvY2F0ZWQuIChJIGhhZCBhIHJ1bm5pbmcgUkZDLCBidXQgd2FzIGRpc3RyYWN0
ZWQgYnkgYWxsIG90aGVyIGtpbmRzIApvZiBzdHVmZikKCgpbMV0gaHR0cHM6Ly92aXJ0aW8tbWVt
LmdpdGxhYi5pby9kZXZlbG9wZXItZ3VpZGUuaHRtbAoKLS0gClRoYW5rcywKCkRhdmlkIC8gZGhp
bGRlbmIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
