Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C8CC4361B
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 13:54:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A8D23444
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 13:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A8D23444
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6E4052E1FE;
	Mon,  7 Dec 2020 13:54:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rgp89mW6uUdZ; Mon,  7 Dec 2020 13:53:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9A73A2E201;
	Mon,  7 Dec 2020 13:53:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F26CC0893;
	Mon,  7 Dec 2020 13:53:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6893CC013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 13:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4EA798789C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 13:53:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SIcdW2WYT0UZ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 13:53:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6047A8789F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 13:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607349236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a53OP+sz/FZD7xQxfgASvprmIF0p8vj6RU1ckdy2paI=;
 b=BnZG9szM2EHeUpmAMz1YX0H04JKhh4nO1sfXEG9o1LnVsIux43WVvZZEiSo+nh/NDUwHOU
 X2TNG1ky1ql+2I05tbgD2a+Y2DH4Co9t7olAs5SuCb+t5+LkvvtPWgGtZDpgPaIAeLByJ5
 cjHnAdNrlbuN/0u+uOyJ6g8YSlmhUNc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-m3RYHx_oMAqH9YHMkkk4mA-1; Mon, 07 Dec 2020 08:53:54 -0500
X-MC-Unique: m3RYHx_oMAqH9YHMkkk4mA-1
Received: by mail-wr1-f70.google.com with SMTP id w17so4856026wrl.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Dec 2020 05:53:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=a53OP+sz/FZD7xQxfgASvprmIF0p8vj6RU1ckdy2paI=;
 b=R0RL5ZeY7wcjszsbryh0wjo5zikHJshfEr80Zm/LTuxdQQmuSacVkOdsdsJ128biIo
 JFIaWy7em40klohoXXWlAIOgpyHdTwqR9SgKBo+EU1Dsy0AAzGqpSiWmyNdnmmSksmp7
 rYkQ1Omazy+GbKniP7TTK/Hzqd1/PV79yOFY04YFlL/ii2WqmEdZxHhACGOswv6QB/k0
 DR1KzV5BpE+XOn4XGmoXn8GyvkVA0YgNVEUk/FUZCQjju910UEARHe3q9TXF+5FJ0VLQ
 Y6Jj5tVhwOD7HJAE19TVVHQ/vDa1jRmCSoOaEddkGISxOEM3dOafLGJPt35fLVsDvA5Y
 0fHA==
X-Gm-Message-State: AOAM531YVSCku7cKotkJgPVpwPSa8u2kor0eTKW9ZG2OuYHiGGOGZHGd
 6AQaZ4HgPneAM7TGgLa4pQsupti6wPPYqHxXzp4jvSbLrL/wCENWHBx6y6tV5PJqn+v4+P3vhQd
 aZfHverpTzHXoFibeuJuRW5Uz48Znt/MCr6+RjvJ+bw==
X-Received: by 2002:a1c:7218:: with SMTP id n24mr18476346wmc.186.1607349233152; 
 Mon, 07 Dec 2020 05:53:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDMDoy/W2sgstBoP6oEPEFLzcmZHr+KtnYFjyMu7YeY3+NBrhAUVxzjo1UnbiGlW76bxVjFA==
X-Received: by 2002:a1c:7218:: with SMTP id n24mr18476325wmc.186.1607349232936; 
 Mon, 07 Dec 2020 05:53:52 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id m81sm13857942wmf.29.2020.12.07.05.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Dec 2020 05:53:52 -0800 (PST)
Date: Mon, 7 Dec 2020 08:53:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 2/2] drivers: gpio: add virtio-gpio guest driver
Message-ID: <20201207085247-mutt-send-email-mst@kernel.org>
References: <20201203191135.21576-1-info@metux.net>
 <20201203191135.21576-2-info@metux.net>
 <8209ce55-a4aa-f256-b9b9-f7eb3cac877b@redhat.com>
 <96aca1e6-2d5a-deb1-2444-88f938c7a9de@metux.net>
 <20201205142218-mutt-send-email-mst@kernel.org>
 <842519cc-94ca-3c11-ddd6-543e5a89c998@redhat.com>
MIME-Version: 1.0
In-Reply-To: <842519cc-94ca-3c11-ddd6-543e5a89c998@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: stefanha@redhat.com, corbet@lwn.net, linus.walleij@linaro.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, bgolaszewski@baylibre.com,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org, msuchanek@suse.de,
 "Enrico Weigelt, metux IT consult" <info@metux.net>
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

T24gTW9uLCBEZWMgMDcsIDIwMjAgYXQgMTE6MTI6NTBBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzEyLzYg5LiK5Y2IMzozMiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gU2F0LCBEZWMgMDUsIDIwMjAgYXQgMDg6NTk6NTVBTSArMDEwMCwgRW5yaWNvIFdl
aWdlbHQsIG1ldHV4IElUIGNvbnN1bHQgd3JvdGU6Cj4gPiA+IE9uIDA0LjEyLjIwIDA0OjM1LCBK
YXNvbiBXYW5nIHdyb3RlOgo+ID4gPiAKPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvZ3Bpby9LY29u
ZmlnCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL2dwaW8vS2NvbmZpZwo+ID4gPiA+ID4gQEAgLTE2
MTUsNiArMTYxNSwxNSBAQCBjb25maWcgR1BJT19NT0NLVVAKPiA+ID4gPiA+IMOCwqDDgsKgw4LC
oMOCwqDDgsKgw4LCoMOCwqAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZ3Bpby9ncGlvLW1vY2t1
cC5zaC4gUmVmZXJlbmNlIHRoZQo+ID4gPiA+ID4gdXNhZ2UgaW4KPiA+ID4gPiA+IMOCwqDDgsKg
w4LCoMOCwqDDgsKgw4LCoMOCwqAgaXQuCj4gPiA+ID4gPiDDgsKgICtjb25maWcgR1BJT19WSVJU
SU8KPiA+ID4gPiA+ICvDgsKgw4LCoMOCwqAgdHJpc3RhdGUgIlZpcnRJTyBHUElPIHN1cHBvcnQi
Cj4gPiA+ID4gPiArw4LCoMOCwqDDgsKgIGRlcGVuZHMgb24gVklSVElPCj4gPiA+ID4gCj4gPiA+
ID4gTGV0J3MgdXNlIHNlbGVjdCwgc2luY2UgdGhlcmUncyBubyBwcm9tcHQgZm9yIFZJUlRJTyBh
bmQgaXQgZG9lc24ndCBoYXZlCj4gPiA+ID4gYW55IGRlcGVuZGVuY2llcy4KPiA+ID4gd2hvb3Bz
LCBpdCdzIG5vdCB0aGF0IHNpbXBsZToKPiA+ID4gCj4gPiA+IG1ha2U6IEVudGVyaW5nIGRpcmVj
dG9yeSAnL2hvbWUvbmVrcmFkL3NyYy9hcHUyLWRldi9wa2cva2VybmVsLmFwdTIuZ2l0Jwo+ID4g
PiBtYWtlWzFdOiBFbnRlcmluZyBkaXJlY3RvcnkKPiA+ID4gJy9ob21lL25la3JhZC9zcmMvZGsv
RGlzdHJvS2l0L3BsYXRmb3JtLXg4Nl82NC9idWlsZC10YXJnZXQvbGludXgtNS44LjktYnVpbGQn
Cj4gPiA+ICAgIEdFTiAgICAgTWFrZWZpbGUKPiA+ID4gZHJpdmVycy9ncHUvZHJtL0tjb25maWc6
NzQ6ZXJyb3I6IHJlY3Vyc2l2ZSBkZXBlbmRlbmN5IGRldGVjdGVkIQo+ID4gPiBkcml2ZXJzL2dw
dS9kcm0vS2NvbmZpZzo3NDoJc3ltYm9sIERSTV9LTVNfSEVMUEVSIGlzIHNlbGVjdGVkIGJ5Cj4g
PiA+IERSTV9WSVJUSU9fR1BVCj4gPiA+IGRyaXZlcnMvZ3B1L2RybS92aXJ0aW8vS2NvbmZpZzoy
OglzeW1ib2wgRFJNX1ZJUlRJT19HUFUgZGVwZW5kcyBvbiBWSVJUSU8KPiA+ID4gZHJpdmVycy92
aXJ0aW8vS2NvbmZpZzoyOglzeW1ib2wgVklSVElPIGlzIHNlbGVjdGVkIGJ5IEdQSU9fVklSVElP
Cj4gPiA+IGRyaXZlcnMvZ3Bpby9LY29uZmlnOjE2MTg6CXN5bWJvbCBHUElPX1ZJUlRJTyBkZXBl
bmRzIG9uIEdQSU9MSUIKPiA+ID4gZHJpdmVycy9ncGlvL0tjb25maWc6MTQ6CXN5bWJvbCBHUElP
TElCIGlzIHNlbGVjdGVkIGJ5IEkyQ19NVVhfTFRDNDMwNgo+ID4gPiBkcml2ZXJzL2kyYy9tdXhl
cy9LY29uZmlnOjQ3OglzeW1ib2wgSTJDX01VWF9MVEM0MzA2IGRlcGVuZHMgb24gSTJDCj4gPiA+
IGRyaXZlcnMvaTJjL0tjb25maWc6ODoJc3ltYm9sIEkyQyBpcyBzZWxlY3RlZCBieSBGQl9EREMK
PiA+ID4gZHJpdmVycy92aWRlby9mYmRldi9LY29uZmlnOjYzOglzeW1ib2wgRkJfRERDIGRlcGVu
ZHMgb24gRkIKPiA+ID4gZHJpdmVycy92aWRlby9mYmRldi9LY29uZmlnOjEyOglzeW1ib2wgRkIg
aXMgc2VsZWN0ZWQgYnkgRFJNX0tNU19GQl9IRUxQRVIKPiA+ID4gZHJpdmVycy9ncHUvZHJtL0tj
b25maWc6ODA6CXN5bWJvbCBEUk1fS01TX0ZCX0hFTFBFUiBkZXBlbmRzIG9uCj4gPiA+IERSTV9L
TVNfSEVMUEVSCj4gPiA+IAo+ID4gPiBTZWVtcyB0aGF0IHdlIGNhbiBvbmx5IGRlcGVuZCBvbiBv
ciBzZWxlY3Qgc29tZSBzeW1ib2wgLSB3ZSBydW4gaW50bwo+ID4gPiBodWdlIHRyb3VibGUgaWYg
dGhhdHMgbWl4ZWQuIEp1c3QgY2hhbmdlZCBEUk1fVklSVElPX0dQVSB0byBqdXN0IHNlbGVjdAo+
ID4gPiBWSVJJTyBpbnN0ZWFkIG9mIGRlcGVuZGluZyBvbiBpdCwgYW5kIG5vdyBpdCB3b3Jrcy4K
PiA+ID4gCj4gPiA+IEkndmUgcG9zdGVkIGFub3RoZXIgcGF0Y2ggZm9yIGZpeGluZyBkcml2ZXJz
L2dwdS9kcm0vdmlydGlvL0tjb25maWcKPiA+ID4gdG8gdXNlICdzZWxlY3QnIGluc3RlYWQgb2Yg
J2RlcGVuZHMgb24nLgo+ID4gSXQgc2VlbXMgYSBiaXQgb2YgYSBtZXNzLCBhdCB0aGlzIHBvaW50
IEknbSBub3QgZW50aXJlbHkgc3VyZSB3aGVuCj4gPiBzaG91bGQgZHJpdmVycyBzZWxlY3QgVklS
VElPIGFuZCB3aGVuIGRlcGVuZCBvbiBpdC4KPiA+IAo+ID4gVGhlIHRleHQgbmVhciBpdCBzYXlz
Ogo+ID4gCj4gPiAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkKPiA+IGNv
bmZpZyBWSVJUSU8KPiA+ICAgICAgICAgIHRyaXN0YXRlCj4gPiAgICAgICAgICBoZWxwCj4gPiAg
ICAgICAgICAgIFRoaXMgb3B0aW9uIGlzIHNlbGVjdGVkIGJ5IGFueSBkcml2ZXIgd2hpY2ggaW1w
bGVtZW50cyB0aGUgdmlydGlvCj4gPiAgICAgICAgICAgIGJ1cywgc3VjaCBhcyBDT05GSUdfVklS
VElPX1BDSSwgQ09ORklHX1ZJUlRJT19NTUlPLCBDT05GSUdfUlBNU0cKPiA+ICAgICAgICAgICAg
b3IgQ09ORklHX1MzOTBfR1VFU1QuCj4gPiAKPiA+IFdoaWNoIHNlZW1zIGNsZWFyIGVub3VnaCBh
bmQgd291bGQgaW5kaWNhdGUgZHJpdmVycyBmb3IgZGV2aWNlcyAqYmVoaW5kKgo+ID4gdGhlIGJ1
cyBzaG91bGQgbm90IHNlbGVjdCBWSVJUSU8gYW5kIHRodXMgcHJlc3VtYWJseSBzaG91bGQgImRl
cGVuZCBvbiIgaXQuCj4gPiBUaGlzIGlzIHZpb2xhdGVkIGluIHZpcnRpbyBjb25zb2xlIGFuZCB2
aXJ0aW8gZnMgZHJpdmVycy4KPiA+IAo+ID4gRm9yIGNvbnNvbGUgaXQgc2F5czoKPiA+IAo+ID4g
Y29tbWl0IDlmMzBlYjI5YzUxNDU4OWUxNmYyOTk5ZWEwNzA1OTg1ODNkMWY2ZWMKPiA+IEF1dGhv
cjogTWljaGFsIFN1Y2hhbmVrIDxtc3VjaGFuZWtAc3VzZS5kZT4KPiA+IERhdGU6ICAgTW9uIEF1
ZyAzMSAxODo1ODo1MCAyMDIwICswMjAwCj4gPiAKPiA+ICAgICAgY2hhcjogdmlydGlvOiBTZWxl
Y3QgVklSVElPIGZyb20gVklSVElPX0NPTlNPTEUuCj4gPiAgICAgIE1ha2UgaXQgcG9zc2libGUg
dG8gaGF2ZSB2aXJ0aW8gY29uc29sZSBidWlsdC1pbiB3aGVuCj4gPiAgICAgIG90aGVyIHZpcnRp
byBkcml2ZXJzIGFyZSBtb2R1bGFyLgo+ID4gICAgICBTaWduZWQtb2ZmLWJ5OiBNaWNoYWwgU3Vj
aGFuZWsgPG1zdWNoYW5la0BzdXNlLmRlPgo+ID4gICAgICBSZXZpZXdlZC1ieTogQW1pdCBTaGFo
IDxhbWl0QGtlcm5lbC5vcmc+Cj4gPiAgICAgIExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3IvMjAyMDA4MzExNjU4NTAuMjYxNjMtMS1tc3VjaGFuZWtAc3VzZS5kZQo+ID4gICAgICBTaWdu
ZWQtb2ZmLWJ5OiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3Jn
Pgo+ID4gCj4gPiB3aGljaCBzZWVtcyBraW5kIG9mIGJvZ3VzIC0gd2h5IGRvIHdlIGNhcmUgYWJv
dXQgYWxsb3dpbmcgYSBidWlsdGluCj4gPiB2aXJ0aW8gY29uc29sZSBkcml2ZXIgaWYgdGhlIHBj
aSB2aXJ0aW8gYnVzIGRyaXZlciBpcyBhIG1vZHVsZT8KPiA+IFRoZXJlIHdvbid0IGJlIGFueSBk
ZXZpY2VzIG9uIHRoZSBidXMgdG8gYXR0YWNoIHRvIC4uLgo+IAo+IAo+IEZvciB0ZXN0aW5nIGxp
a2Ugc3dpdGNoaW5nIGJ1cyBmcm9tIHBjaSB0byBNTUlPPwoKCk5vdCBzdXJlIEkgdW5kZXJzdGFu
ZCAuLi4gY2FuIHlvdSBnaXZlIGFuIGV4YW1wbGU/Cgo+IAo+ID4gQW5kIGZvciB2aXJ0aW8gZnMg
aXQgd2FzIGxpa2UgdGhpcyBmcm9tIHRoZSBiZWdpbm5pbmcuCj4gPiAKPiA+IEkgYW0gaW5jbGlu
ZWQgdG8gZml4IGNvbnNvbGUgYW5kIHZpcnRpbyBmcyB0byBkZXBlbmQgb24gVklSVElPOgo+ID4g
c2VsZWN0IGlzIGhhcmRlciB0byB1c2UgY29ycmVjdGx5IC4uLgo+ID4gCj4gPiBKYXNvbj8KPiAK
PiAKPiBJIHRoaW5rIGl0IHdvcmtzLCBidXQgd2UgbmVlZCBhIHByb21wdCBmb3IgVklSVElPIG90
aGVyd2lzZSB0aGVyZSdzIG5vIHdheQo+IHRvIGVuYWJsZSBpdC4KPiAKPiBUaGFua3MKClRoYXQn
cyBldmVuIG1lc3NpZXIuIE5vIG9uZSBuZWVkcyBWSVJUSU8gY29yZSBieSBpdHNlbGYgLSBpdCdz
IG9ubHkgdXNlZApieSB0cmFuc3BvcnRzIGFuZCBkcml2ZXJzLgoKPiAKPiA+IAo+ID4gCj4gPiA+
IC0tIAo+ID4gPiAtLS0KPiA+ID4gSGlud2VpczogdW52ZXJzY2hsw4PCvHNzZWx0ZSBFLU1haWxz
IGvDg8K2bm5lbiBsZWljaHQgYWJnZWjDg8K2cnQgdW5kIG1hbmlwdWxpZXJ0Cj4gPiA+IHdlcmRl
biAhIEbDg8K8ciBlaW5lIHZlcnRyYXVsaWNoZSBLb21tdW5pa2F0aW9uIHNlbmRlbiBTaWUgYml0
dGUgaWhyZW4KPiA+ID4gR1BHL1BHUC1TY2hsw4PCvHNzZWwgenUuCj4gPiA+IC0tLQo+ID4gPiBF
bnJpY28gV2VpZ2VsdCwgbWV0dXggSVQgY29uc3VsdAo+ID4gPiBGcmVlIHNvZnR3YXJlIGFuZCBM
aW51eCBlbWJlZGRlZCBlbmdpbmVlcmluZwo+ID4gPiBpbmZvQG1ldHV4Lm5ldCAtLSArNDktMTUx
LTI3NTY1Mjg3CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
