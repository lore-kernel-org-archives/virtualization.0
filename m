Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD19C76196
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 07:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 201FA81442;
	Tue, 11 Apr 2023 07:06:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 201FA81442
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dZsqF+Kn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oyDl2fIHOlqQ; Tue, 11 Apr 2023 07:06:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E7BE781453;
	Tue, 11 Apr 2023 07:06:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7BE781453
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDAECC0037;
	Tue, 11 Apr 2023 07:06:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD333C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:06:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 950E7408CA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:06:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 950E7408CA
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dZsqF+Kn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hWUSo4MhZjwW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:06:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DB1E84056D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DB1E84056D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681196777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nAXE80WYdMbrqhPmqBV4AcmhnEUMDbz/xHZM8D2AI58=;
 b=dZsqF+KnT/ZOkH69uxnNPTl1qnNjShJxJyhCB1ttcRMCFnPHK4jICDI7DwtaBnpv+10O6o
 zoh28+EDrdpKCWkt4FEadduqJEH0CDZUKsoOBcN4mFTpnfby4JF3NUUIR7veNz7M4Ng0ED
 UwJlGQcvs4wYffSvSXfK+8Ie14RCB2U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-g5qJW0w9MSy7YPQa1RXAgw-1; Tue, 11 Apr 2023 03:06:16 -0400
X-MC-Unique: g5qJW0w9MSy7YPQa1RXAgw-1
Received: by mail-wm1-f71.google.com with SMTP id
 r20-20020a05600c35d400b003edd2023418so4970365wmq.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 00:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681196775;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nAXE80WYdMbrqhPmqBV4AcmhnEUMDbz/xHZM8D2AI58=;
 b=EAlkT649eZg0CI+7abomOTCZmGU/WulXm5NRFMOLs5VfETIEDAxBYw7o482i7SdS21
 MDHgjFR3JA2jX+lEurdeuZbjv5ev7Ob/05Sc5E2Q5QYiyCZ7df8mQ1E63LbD2wLKJxGH
 QJ5jJ1AdNiCmZJx18WU4vV69CwnC1Wfd4vu9p180auO1aGq+MkvE2QF76+oW2NX6VvYP
 KTV2PUZGBod96Ej5YJkUuTtYDf3j8LX8OzW4rN1Cj67v2DGigpDggJ3f49fF6dPSeXhM
 pS57vaEWKdNOtfXcpe3mn3AdawrFN7KPxbHT7KBcXxqsdfo01ypyob2SL+kXFS5GNlNL
 PNBw==
X-Gm-Message-State: AAQBX9dHSmq7STesDjak5TkztaRW4LrG8zzDSnqtKfblKwoTQVAHgiPr
 0sjWW9RQGeoryqg8qM0sSAGMASmuPpRyJrtZCkIc+B/Gxo6TJA6D5RkEsNt+g0XGxmp2ioM6Qsp
 MCgYzTG47HA9tnNZnZqHZ9AHwmg9eixv2VRanAYksx7dSeICZtg==
X-Received: by 2002:adf:dd04:0:b0:2cf:eb86:bd90 with SMTP id
 a4-20020adfdd04000000b002cfeb86bd90mr8795021wrm.63.1681196774839; 
 Tue, 11 Apr 2023 00:06:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350a1SnKmeCaqaQc/BcZ1jOCI9oFamGvDUwJGlOUcONHQXGLgGrPLR76BFWn1zGF7e0HUL2yHEQ==
X-Received: by 2002:adf:dd04:0:b0:2cf:eb86:bd90 with SMTP id
 a4-20020adfdd04000000b002cfeb86bd90mr8795005wrm.63.1681196774479; 
 Tue, 11 Apr 2023 00:06:14 -0700 (PDT)
Received: from redhat.com ([2.52.10.80]) by smtp.gmail.com with ESMTPSA id
 f8-20020a05600c154800b003f034c76e85sm20276672wmg.38.2023.04.11.00.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Apr 2023 00:06:13 -0700 (PDT)
Date: Tue, 11 Apr 2023 03:06:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2] virtio-vdpa: add VIRTIO_F_NOTIFICATION_DATA feature
 support
Message-ID: <20230411030442-mutt-send-email-mst@kernel.org>
References: <20230409070706.3288876-1-alvaro.karsz@solid-run.com>
 <CACGkMEvEp6UjTQ_HC4GDjchJ6CHUQefLoMkAPNAAryCxBzFhAA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvEp6UjTQ_HC4GDjchJ6CHUQefLoMkAPNAAryCxBzFhAA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

T24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMDE6MjU6NTNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBTdW4sIEFwciA5LCAyMDIzIGF0IDM6MDfigK9QTSBBbHZhcm8gS2Fyc3ogPGFsdmFy
by5rYXJzekBzb2xpZC1ydW4uY29tPiB3cm90ZToKPiA+Cj4gPiBBZGQgVklSVElPX0ZfTk9USUZJ
Q0FUSU9OX0RBVEEgc3VwcG9ydCBmb3IgdkRQQSB0cmFuc3BvcnQuCj4gPiBJZiB0aGlzIGZlYXR1
cmUgaXMgbmVnb3RpYXRlZCwgdGhlIGRyaXZlciBwYXNzZXMgZXh0cmEgZGF0YSB3aGVuIGtpY2tp
bmcKPiA+IGEgdmlydHF1ZXVlLgo+ID4KPiA+IEEgZGV2aWNlIHRoYXQgb2ZmZXJzIHRoaXMgZmVh
dHVyZSBuZWVkcyB0byBpbXBsZW1lbnQgdGhlCj4gPiBraWNrX3ZxX3dpdGhfZGF0YSBjYWxsYmFj
ay4KPiA+Cj4gPiBraWNrX3ZxX3dpdGhfZGF0YSByZWNlaXZlcyB0aGUgdkRQQSBkZXZpY2UgYW5k
IGRhdGEuCj4gPiBkYXRhIGluY2x1ZGVzOgo+ID4gMTYgYml0cyB2cW4gYW5kIDE2IGJpdHMgbmV4
dCBhdmFpbGFibGUgaW5kZXggZm9yIHNwbGl0IHZpcnRxdWV1ZXMuCj4gPiAxNiBiaXRzIHZxcywg
MTUgbGVhc3Qgc2lnbmlmaWNhbnQgYml0cyBvZiBuZXh0IGF2YWlsYWJsZSBpbmRleAo+ID4gYW5k
IDEgYml0IG5leHRfd3JhcCBmb3IgcGFja2VkIHZpcnRxdWV1ZXMuCj4gPgo+ID4gVGhpcyBwYXRj
aCBmb2xsb3dzIGEgcGF0Y2ggWzFdIGJ5IFZpa3RvciBQcnV0eWFub3Ygd2hpY2ggYWRkcyBzdXBw
b3J0Cj4gPiBmb3IgdGhlIE1NSU8sIGNoYW5uZWwgSS9PIGFuZCBtb2Rlcm4gUENJIHRyYW5zcG9y
dHMuCj4gPgo+ID4gVGhpcyBwYXRjaCBuZWVkcyB0byBiZSBhcHBsaWVkIG9uIHRvcCBvZiBWaWt0
b3IncyBwYXRjaC4KPiA+Cj4gPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIz
MDMyNDE5NTAyOS4yNDEwNTAzLTEtdmlrdG9yQGRheW5peC5jb20vCj4gPgo+ID4gU2lnbmVkLW9m
Zi1ieTogQWx2YXJvIEthcnN6IDxhbHZhcm8ua2Fyc3pAc29saWQtcnVuLmNvbT4KPiA+IC0tLQo+
ID4gdjI6Cj4gPiAgICAgICAgIC0gY2xlYXIgdGhlIGZlYXR1cmUgYml0IGlmIGtpY2tfdnFfd2l0
aF9kYXRhIGlzIG5vdCBpbXBsZW1lbnRlZC4KPiA+ICAgICAgICAgLSBGaXgga2lja192cV93aXRo
X2RhdGEgY29tbWVudCBpbiBpbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ID4gICAgICAgICAtIFdyaXRl
IGluIG1vcmUgZGV0YWlsIGFib3V0IHRoZSBleHRyYSBkYXRhIGluIHRoZSBjb21taXQgbG9nCj4g
Pgo+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgfCAyMyArKysrKysrKysrKysrKysr
KysrKystLQo+ID4gIGluY2x1ZGUvbGludXgvdmRwYS5oICAgICAgICAgfCAgOSArKysrKysrKysK
PiA+ICAyIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4g
Pgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gPiBpbmRleCBkN2Y1YWY2MmRkYS4uNzM3YzFmMzZkMzIg
MTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gPiArKysgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gPiBAQCAtMTEyLDYgKzExMiwxNyBAQCBzdGF0
aWMgYm9vbCB2aXJ0aW9fdmRwYV9ub3RpZnkoc3RydWN0IHZpcnRxdWV1ZSAqdnEpCj4gPiAgICAg
ICAgIHJldHVybiB0cnVlOwo+ID4gIH0KPiA+Cj4gPiArc3RhdGljIGJvb2wgdmlydGlvX3ZkcGFf
bm90aWZ5X3dpdGhfZGF0YShzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPiA+ICt7Cj4gPiArICAgICAg
IHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHZkX2dldF92ZHBhKHZxLT52ZGV2KTsKPiA+ICsg
ICAgICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+
ID4gKyAgICAgICB1MzIgZGF0YSA9IHZyaW5nX25vdGlmaWNhdGlvbl9kYXRhKHZxKTsKPiA+ICsK
PiA+ICsgICAgICAgb3BzLT5raWNrX3ZxX3dpdGhfZGF0YSh2ZHBhLCBkYXRhKTsKPiA+ICsKPiA+
ICsgICAgICAgcmV0dXJuIHRydWU7Cj4gPiArfQo+ID4gKwo+ID4gIHN0YXRpYyBpcnFyZXR1cm5f
dCB2aXJ0aW9fdmRwYV9jb25maWdfY2Iodm9pZCAqcHJpdmF0ZSkKPiA+ICB7Cj4gPiAgICAgICAg
IHN0cnVjdCB2aXJ0aW9fdmRwYV9kZXZpY2UgKnZkX2RldiA9IHByaXZhdGU7Cj4gPiBAQCAtMTM4
LDYgKzE0OSw3IEBAIHZpcnRpb192ZHBhX3NldHVwX3ZxKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2
ZGV2LCB1bnNpZ25lZCBpbnQgaW5kZXgsCj4gPiAgICAgICAgIHN0cnVjdCBkZXZpY2UgKmRtYV9k
ZXY7Cj4gPiAgICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEt
PmNvbmZpZzsKPiA+ICAgICAgICAgc3RydWN0IHZpcnRpb192ZHBhX3ZxX2luZm8gKmluZm87Cj4g
PiArICAgICAgIGJvb2wgKCpub3RpZnkpKHN0cnVjdCB2aXJ0cXVldWUgKnZxKSA9IHZpcnRpb192
ZHBhX25vdGlmeTsKPiA+ICAgICAgICAgc3RydWN0IHZkcGFfY2FsbGJhY2sgY2I7Cj4gPiAgICAg
ICAgIHN0cnVjdCB2aXJ0cXVldWUgKnZxOwo+ID4gICAgICAgICB1NjQgZGVzY19hZGRyLCBkcml2
ZXJfYWRkciwgZGV2aWNlX2FkZHI7Cj4gPiBAQCAtMTU0LDYgKzE2NiwxNCBAQCB2aXJ0aW9fdmRw
YV9zZXR1cF92cShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50IGluZGV4
LAo+ID4gICAgICAgICBpZiAoaW5kZXggPj0gdmRwYS0+bnZxcykKPiA+ICAgICAgICAgICAgICAg
ICByZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsKPiA+Cj4gPiArICAgICAgIC8qIFdlIGNhbm5vdCBh
Y2NlcHQgVklSVElPX0ZfTk9USUZJQ0FUSU9OX0RBVEEgd2l0aG91dCBraWNrX3ZxX3dpdGhfZGF0
YSAqLwo+ID4gKyAgICAgICBpZiAoX192aXJ0aW9fdGVzdF9iaXQodmRldiwgVklSVElPX0ZfTk9U
SUZJQ0FUSU9OX0RBVEEpKSB7Cj4gPiArICAgICAgICAgICAgICAgaWYgKG9wcy0+a2lja192cV93
aXRoX2RhdGEpCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBub3RpZnkgPSB2aXJ0aW9fdmRw
YV9ub3RpZnlfd2l0aF9kYXRhOwo+ID4gKyAgICAgICAgICAgICAgIGVsc2UKPiAKPiBJZiB3ZSBk
byB0aGlzLCBJIHdvbmRlciBpZiB3ZSBuZWVkIHRvIGZhaWwgb3IgYXQgbGVhc3Qgd2FybiBpbiB0
aGlzIGNhc2UuCj4gCj4gVGhhbmtzCgpOb3BlLiAgRWl0aGVyIGRldmljZSBjYW4gd29yayB3aXRo
b3V0IFZJUlRJT19GX05PVElGSUNBVElPTl9EQVRBCmFuZCB0aGVuIGFsbCBpcyB3ZWxsIG9yIGl0
IGNhbid0IGFuZCB0aGVuIGl0IHdpbGwgZmFpbCBGRUFUVVJFU19PSy4KCklmIGRyaXZlcnMgc3Rh
cnQgZmFpbGluZyB3aGVuIHNlZWluZyBuZXcgZmVhdHVyZXMgd2UnbGwgbmV2ZXIKYmUgYWJsZSB0
byBleHRlbmQgdmlydGlvIGFnYWluLgpTYW1lIGZvciB3YXJucywgc29tZSBwZW9wbGUgcnVuIHdp
dGggcGFuaWMgb24gd2Fybi4KCgoKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIF9fdmlydGlv
X2NsZWFyX2JpdCh2ZGV2LCBWSVJUSU9fRl9OT1RJRklDQVRJT05fREFUQSk7Cj4gPiArICAgICAg
IH0KPiA+ICsKPiA+ICAgICAgICAgLyogUXVldWUgc2hvdWxkbid0IGFscmVhZHkgYmUgc2V0IHVw
LiAqLwo+ID4gICAgICAgICBpZiAob3BzLT5nZXRfdnFfcmVhZHkodmRwYSwgaW5kZXgpKQo+ID4g
ICAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FTk9FTlQpOwo+ID4gQEAgLTE4Myw4ICsy
MDMsNyBAQCB2aXJ0aW9fdmRwYV9zZXR1cF92cShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwg
dW5zaWduZWQgaW50IGluZGV4LAo+ID4gICAgICAgICAgICAgICAgIGRtYV9kZXYgPSB2ZHBhX2dl
dF9kbWFfZGV2KHZkcGEpOwo+ID4gICAgICAgICB2cSA9IHZyaW5nX2NyZWF0ZV92aXJ0cXVldWVf
ZG1hKGluZGV4LCBtYXhfbnVtLCBhbGlnbiwgdmRldiwKPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB0cnVlLCBtYXlfcmVkdWNlX251bSwgY3R4LAo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRpb192ZHBhX25vdGlmeSwgY2Fs
bGJhY2ssCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbmFtZSwg
ZG1hX2Rldik7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbm90
aWZ5LCBjYWxsYmFjaywgbmFtZSwgZG1hX2Rldik7Cj4gPiAgICAgICAgIGlmICghdnEpIHsKPiA+
ICAgICAgICAgICAgICAgICBlcnIgPSAtRU5PTUVNOwo+ID4gICAgICAgICAgICAgICAgIGdvdG8g
ZXJyb3JfbmV3X3ZpcnRxdWV1ZTsKPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEu
aCBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gPiBpbmRleCA0M2Y1OWVmMTBjYy4uMDRjZGFhZDc3
ZGQgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ID4gKysrIGIvaW5jbHVk
ZS9saW51eC92ZHBhLmgKPiA+IEBAIC0xNDMsNiArMTQzLDE0IEBAIHN0cnVjdCB2ZHBhX21hcF9m
aWxlIHsKPiA+ICAgKiBAa2lja192cTogICAgICAgICAgICAgICAgICAgS2ljayB0aGUgdmlydHF1
ZXVlCj4gPiAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEB2ZGV2OiB2ZHBhIGRldmlj
ZQo+ID4gICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAaWR4OiB2aXJ0cXVldWUgaW5k
ZXgKPiA+ICsgKiBAa2lja192cV93aXRoX2RhdGE6ICAgICAgICAgS2ljayB0aGUgdmlydHF1ZXVl
IGFuZCBzdXBwbHkgZXh0cmEgZGF0YQo+ID4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAob25seSBpZiBWSVJUSU9fRl9OT1RJRklDQVRJT05fREFUQSBpcyBuZWdvdGlhdGVkKQo+ID4g
KyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAdmRldjogdmRwYSBkZXZpY2UKPiA+ICsg
KiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQGRhdGEgZm9yIHNwbGl0IHZpcnRxdWV1ZToK
PiA+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMTYgYml0cyB2cW4gYW5kIDE2IGJp
dHMgbmV4dCBhdmFpbGFibGUgaW5kZXguCj4gPiArICogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEBkYXRhIGZvciBwYWNrZWQgdmlydHF1ZXVlOgo+ID4gKyAqICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAxNiBiaXRzIHZxbiwgMTUgbGVhc3Qgc2lnbmlmaWNhbnQgYml0cyBvZgo+ID4g
KyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuZXh0IGF2YWlsYWJsZSBpbmRleCBhbmQg
MSBiaXQgbmV4dF93cmFwLgo+ID4gICAqIEBzZXRfdnFfY2I6ICAgICAgICAgICAgICAgICBTZXQg
dGhlIGludGVycnVwdCBjYWxsYmFjayBmdW5jdGlvbiBmb3IKPiA+ICAgKiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYSB2aXJ0cXVldWUKPiA+ICAgKiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgQHZkZXY6IHZkcGEgZGV2aWNlCj4gPiBAQCAtMzAwLDYgKzMwOCw3IEBAIHN0cnVjdCB2
ZHBhX2NvbmZpZ19vcHMgewo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTY0IGRl
dmljZV9hcmVhKTsKPiA+ICAgICAgICAgdm9pZCAoKnNldF92cV9udW0pKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRldiwgdTE2IGlkeCwgdTMyIG51bSk7Cj4gPiAgICAgICAgIHZvaWQgKCpraWNrX3Zx
KShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUxNiBpZHgpOwo+ID4gKyAgICAgICB2b2lkICgq
a2lja192cV93aXRoX2RhdGEpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTMyIGRhdGEpOwo+
ID4gICAgICAgICB2b2lkICgqc2V0X3ZxX2NiKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUx
NiBpZHgsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2ZHBhX2NhbGxiYWNr
ICpjYik7Cj4gPiAgICAgICAgIHZvaWQgKCpzZXRfdnFfcmVhZHkpKHN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRldiwgdTE2IGlkeCwgYm9vbCByZWFkeSk7Cj4gPiAtLQo+ID4gMi4zNC4xCj4gPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
