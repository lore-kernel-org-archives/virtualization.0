Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B679FC433F5
	for <virtualization@archiver.kernel.org>; Wed, 16 Mar 2022 02:02:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5229D842A7;
	Wed, 16 Mar 2022 02:02:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id crHp30T_zR8t; Wed, 16 Mar 2022 02:02:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9DCA6842A6;
	Wed, 16 Mar 2022 02:02:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E15AC001A;
	Wed, 16 Mar 2022 02:02:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E543BC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 02:02:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BEF4760EBB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 02:02:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7xknG8w7YvCA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 02:02:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 668D460D76
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 02:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647396147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o37LbVxFoFTbHwgohf/LnM2c2D+jii/VdcCnff+u9NU=;
 b=h0/JBzYp/4gSm3cHZyF11qZl8MaEdtSF0uVFpMMiHTgs5JvRj9JQg+x3e1Zh1pF9hMiUvP
 90M7fUdbDW+SUgKdTzipsMNdWbXSppLWu0razWFEk9h9rYz79JJ7MXPvGqkSd8TyVXDPVC
 M3qcDOcxxK673e0OVTGMWOOK2eVg3/A=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-Y3sDJohoPACP84T3DxUOpA-1; Tue, 15 Mar 2022 22:02:26 -0400
X-MC-Unique: Y3sDJohoPACP84T3DxUOpA-1
Received: by mail-yb1-f200.google.com with SMTP id
 h8-20020a25e208000000b00628c0565607so928823ybe.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 19:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=o37LbVxFoFTbHwgohf/LnM2c2D+jii/VdcCnff+u9NU=;
 b=ztCKRk4hrmVI4XJbHrOlPYHDcELO4/NPdfuhMmCOVsCX6eRzLZTkF9a+9QakjzWfER
 gwhlWM1wuWgZGk2CilD1Dv/wCPab+zJHyGakxCNfMNRUPY1rnQ0MauODGzQQImFtVzrA
 mg5FqKjkBf+/HoZn3f1JUjl815I9ByIYM4Lgdh8Ez8YfC64MHNjSG6KAf6Kt6c55TRy8
 V+BoVAXZFqkl/FwdyAjhio7FVMXa8v+FP10He1zv1wCm3KzvKx7UA58ucD0ri/x7ESMt
 D5OFo4iPwwgC8EtjE88ouiy4fPtX/kzxSw6lsB0DB3MlD+A/0H3Akqe8GEHc4UFZmUPg
 ZldA==
X-Gm-Message-State: AOAM531fFmvw+FfbLuaWL29COHRmPz/4YudxoVQbWfrFqsP7W03bcjBn
 slyaDLjaDA91GAkiZmv8lRdQmdqM9bFYd8LfpeLbSdkxRYY6mtPD3pI+HepysLym4l9hymhrCqf
 P02LsxM4NNVe5kVK0vwEfPIa6uYp4epJrsXF4wt+/OlHPlkzcDAjvaKybrQ==
X-Received: by 2002:a81:d50c:0:b0:2e5:8836:fd3c with SMTP id
 i12-20020a81d50c000000b002e58836fd3cmr6662126ywj.152.1647396144899; 
 Tue, 15 Mar 2022 19:02:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKFPpjUd1sLV1ynNZptANCctqBe8rTJFe/lMdb+mkXy5jBmNpVPspV5AMEWkK64Xzzx1M5KEbv0HsCX/fYCl4=
X-Received: by 2002:a81:d50c:0:b0:2e5:8836:fd3c with SMTP id
 i12-20020a81d50c000000b002e58836fd3cmr6662108ywj.152.1647396144685; Tue, 15
 Mar 2022 19:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <ea838f63-5f63-6f3b-f49e-1107b43f7d1c@redhat.com>
 <Yi82BL9KecQsVfgX@localhost.localdomain>
 <CACGkMEujXYNE-88=m9ohjbeAj2F7CqEUes8gOUmasTNtwn2bUA@mail.gmail.com>
 <YjCmBkjgtQZffiXw@localhost.localdomain>
In-Reply-To: <YjCmBkjgtQZffiXw@localhost.localdomain>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Mar 2022 10:02:13 +0800
Message-ID: <CACGkMEtxadf1+0Db06nE3SuQZhvyELq7ZwvKaH8x_utj91dRdg@mail.gmail.com>
Subject: Re: [PATCH] virtio-blk: support polling I/O
To: Suwan Kim <suwan.kim027@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-block@vger.kernel.org, pbonzini <pbonzini@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, mst <mst@redhat.com>
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

T24gVHVlLCBNYXIgMTUsIDIwMjIgYXQgMTA6NDMgUE0gU3V3YW4gS2ltIDxzdXdhbi5raW0wMjdA
Z21haWwuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgTWFyIDE1LCAyMDIyIGF0IDA0OjU5OjIzUE0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBNb24sIE1hciAxNCwgMjAyMiBhdCA4OjMz
IFBNIFN1d2FuIEtpbSA8c3V3YW4ua2ltMDI3QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPgo+ID4gPiBP
biBNb24sIE1hciAxNCwgMjAyMiBhdCAwMjoxNDo1M1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+ID4gPiA+Cj4gPiA+ID4g5ZyoIDIwMjIvMy8xMSDkuIvljYgxMToyOCwgU3V3YW4gS2ltIOWG
memBkzoKPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX2Js
ay5oCj4gPiA+IGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19ibGsuaAo+ID4gPiA+ID4gaW5k
ZXggZDg4OGYwMTNkOWZmLi4zZmNhZjkzN2FmZTEgMTAwNjQ0Cj4gPiA+ID4gPiAtLS0gYS9pbmNs
dWRlL3VhcGkvbGludXgvdmlydGlvX2Jsay5oCj4gPiA+ID4gPiArKysgYi9pbmNsdWRlL3VhcGkv
bGludXgvdmlydGlvX2Jsay5oCj4gPiA+ID4gPiBAQCAtMTE5LDggKzExOSw5IEBAIHN0cnVjdCB2
aXJ0aW9fYmxrX2NvbmZpZyB7Cj4gPiA+ID4gPiAgICAgICogZGVhbGxvY2F0aW9uIG9mIG9uZSBv
ciBtb3JlIG9mIHRoZSBzZWN0b3JzLgo+ID4gPiA+ID4gICAgICAqLwo+ID4gPiA+ID4gICAgIF9f
dTggd3JpdGVfemVyb2VzX21heV91bm1hcDsKPiA+ID4gPiA+ICsgICBfX3U4IHVudXNlZDE7Cj4g
PiA+ID4gPiAtICAgX191OCB1bnVzZWQxWzNdOwo+ID4gPiA+ID4gKyAgIF9fdmlydGlvMTYgbnVt
X3BvbGxfcXVldWVzOwo+ID4gPiA+ID4gICB9IF9fYXR0cmlidXRlX18oKHBhY2tlZCkpOwo+ID4g
PiA+Cj4gPiA+ID4KPiA+ID4gPiBUaGlzIGxvb2tzIGxpa2UgYSBpbXBsZW1lbnRhdGlvbiBzcGVj
aWZpYyAodmlydGlvLWJsay1wY2kpIG9wdGltaXphdGlvbiwKPiA+ID4gaG93Cj4gPiA+ID4gYWJv
dXQgb3RoZXIgaW1wbGVtZW50YXRpb24gbGlrZSB2aG9zdC11c2VyLWJsaz8KPiA+ID4KPiA+ID4g
SSBkaWRu4oCZdCBjb25zaWRlciB2aG9zdC11c2VyLWJsayB5ZXQuIEJ1dCBkb2VzIHZob3N0LXVz
ZXItYmxrIGFsc28KPiA+ID4gdXNlIHZyaXRpb19ibGtfY29uZmlnIGFzIGtlcm5lbC1xZW11IGlu
dGVyZmFjZT8KPiA+ID4KPiA+Cj4gPiBZZXMsIGJ1dCBzZWUgYmVsb3cuCj4gPgo+ID4KPiA+ID4K
PiA+ID4gRG9lcyB2aG9zdC11c2VyLWJsayBuZWVkIGFkZGl0aW9uYWwgbW9kaWZpY2F0aW9uIHRv
IHN1cHBvcnQgcG9sbGluZwo+ID4gPiBpbiBrZXJuZWwgc2lkZT8KPiA+ID4KPiA+Cj4gPgo+ID4g
Tm8sIGJ1dCB0aGUgaXNzdWUgaXMsIHRoaW5ncyBsaWtlIHBvbGxpbmcgbG9va3Mgbm90IGEgZ29v
ZCBjYW5kaWRhdGUgZm9yCj4gPiB0aGUgYXR0cmlidXRlcyBiZWxvbmdpbmcgdG8gdGhlIGRldmlj
ZSBidXQgdGhlIGRyaXZlci4gU28gSSBoYXZlIG1vcmUKPiA+IHF1ZXN0aW9uczoKPiA+Cj4gPiAx
KSB3aGF0IGRvZXMgaXQgcmVhbGx5IG1lYW4gZm9yIGhhcmR3YXJlIHZpcnRpbyBibG9jayBkZXZp
Y2VzPwo+ID4gMikgRG9lcyBkcml2ZXIgcG9sbGluZyBoZWxwIGZvciB0aGUgcWVtdSBpbXBsZW1l
bnRhdGlvbiB3aXRob3V0IHBvbGxpbmc/Cj4gPiAzKSBVc2luZyBibGtfY29uZmlnIG1lYW5zIHdl
IGNhbiBvbmx5IGdldCB0aGUgYmVuZWZpdCBmcm9tIHRoZSBuZXcgZGV2aWNlCj4KPiAxKSB3aGF0
IGRvZXMgaXQgcmVhbGx5IG1lYW4gZm9yIGhhcmR3YXJlIHZpcnRpbyBibG9jayBkZXZpY2VzPwo+
IDMpIFVzaW5nIGJsa19jb25maWcgbWVhbnMgd2UgY2FuIG9ubHkgZ2V0IHRoZSBiZW5lZml0IGZy
b20gdGhlIG5ldyBkZXZpY2UKPgo+IFRoaXMgcGF0Y2ggYWRkcyBkZWRpY2F0ZWQgSFcgcXVldWUg
Zm9yIHBvbGxpbmcgcHVycG9zZSB0byB2aXJ0aW8KPiBibG9jayBkZXZpY2UuCj4KPiBTbyBJIHRo
aW5rIGl0IGNhbiBiZSBhIG5ldyBodyBmZWF0dXJlLiBBbmQgaXQgY2FuIGJlIGEgbmV3IGRldmlj
ZQo+IHRoYXQgc3VwcG9ydHMgaHcgcG9sbCBxdWV1ZS4KCk9uZSBwb3NzaWJsZSBpc3N1ZSBpcyB0
aGF0IHRoZSAicG9sbCIgbG9va3MgbW9yZSBsaWtlIGEKc29mdHdhcmUvZHJpdmVyIGNvbmNlcHQg
b3RoZXIgdGhhbiB0aGUgZGV2aWNlL2hhcmR3YXJlLgoKPgo+IEJUVywgSSBoYXZlIG90aGVyIGlk
ZWEgYWJvdXQgaXQuCj4KPiBIb3cgYWJvdXQgYWRkaW5nIOKAnG51bS1wb2xsLXF1ZXVlcyIgcHJv
cGVydHkgYXMgYSBkcml2ZXIgcGFyYW1ldGVyCj4gbGlrZSBOVk1lIGRyaXZlciwgbm90IHRvIFFF
TVUgdmlydGlvLWJsay1wY2kgcHJvcGVydHk/CgpJdCBzaG91bGQgYmUgZmluZSwgYnV0IHdlIG5l
ZWQgdG8gbGlzdGVuIHRvIG90aGVycy4KCj4KPiBJZiB0aGVuLCB3ZSBkb27igJl0IG5lZWQgdG8g
bW9kaWZ5IHZpcnRpb19ibGtfY29uZmlnLgo+IEFuZCB3ZSBjYW4gYXBwbHkgdGhlIHBvbGxpbmcg
ZmVhdHVyZSBvbmx5IHRvIHZpcnRpby1ibGstcGNpLgo+IEJ1dCBjYW4gUUVNVSBwYXNzIOKAnG51
bS1wb2xsLXF1ZXVlcyIgdG8gdmlydGlvLWJsayBkcml2ZXIgcGFyYW0/CgpBcyBNaWNoYWVsIHNh
aWQgd2UgY2FuIGxlYXZlIHRoaXMgdG8gZ3Vlc3Qga2VybmVsIC8gYWRtaW5pc3RyYXRvci4KCj4K
Pgo+Cj4gMikgRG9lcyBkcml2ZXIgcG9sbGluZyBoZWxwIGZvciB0aGUgcWVtdSBpbXBsZW1lbnRh
dGlvbiB3aXRob3V0IHBvbGxpbmc/Cj4KPiBTb3JyeSwgSSBkaWRuJ3QgdW5kZXJzdGFuZCB5b3Vy
IHF1ZXN0aW9uLiBDb3VsZCB5b3UgcGxlYXNlIGV4cGxhaW4gbW9yZSBhYm91dD8KCkkgbWVhbiBk
b2VzIHRoZSBwb2xsaW5nIHdvcmsgZm9yIHRoZSBvcmRpbmFyeSBxZW11IGJsb2NrIGRldmljZQp3
aXRob3V0IGJ1c3kgcG9sbGluZz8KClRoYW5rcwoKPgo+IFJlZ2FyZHMsCj4gU3V3YW4gS2ltCj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
