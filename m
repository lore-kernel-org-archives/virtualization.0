Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEE0C77B7F
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 00:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CF1954107A;
	Wed, 17 May 2023 00:50:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CF1954107A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A4ttkVak
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 01A3p3ZnMVqI; Wed, 17 May 2023 00:50:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 79BC2403FB;
	Wed, 17 May 2023 00:50:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 79BC2403FB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49B31C0036;
	Wed, 17 May 2023 00:50:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AC73C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 00:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D984A841D1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 00:50:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D984A841D1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=A4ttkVak
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ePNFl3bZxs2t
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 00:50:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4956C841D2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4956C841D2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 00:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684284643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fnUG3gCHSV8pX9AU0bIvLG+bCyI62wX6MiEqPgLszqc=;
 b=A4ttkVak1r3Szd2YFGtZfcWVQ8frvlQGuakKP5Qe2fxa93QVF/63nJR1e0JzU3rAyWLO5n
 mUbO5W9lCzPNq2s7oW9IiWhDHikHnLOh6BjohqTwvbQId3uaDPKyIzEjmmUvhQf2mqwPty
 C70HmYl4edmRWZJDV2APNTR5SZtDs40=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-Nc2dO2s9O6aROAswto-S8A-1; Tue, 16 May 2023 20:50:42 -0400
X-MC-Unique: Nc2dO2s9O6aROAswto-S8A-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f14f266ac3so3941388e87.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 17:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684284641; x=1686876641;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fnUG3gCHSV8pX9AU0bIvLG+bCyI62wX6MiEqPgLszqc=;
 b=JGtRsslsBVJkM2dypG8aMYxADpDEAsuaHW/s76agIBXGFrieTU8GTaLPRmXvbv7wUe
 kKnWMtkhKtPUBo2Up1VQkripE0NJS/QWoUEg4dmmOwBuCaFjoNaktg+IPNhysr6aqFaU
 uk5xQ9Nn3X1/cFzwbK/XpiluuOzs2Sofn4A20L8cAXN+s09yb8AAN536UiXmwMaegmfv
 ZiqFtYxm8W0QXFf13Jtv6Xhjprbqp4i4VZGc8BfjnyhXq3GCFhZYdaHFL+mMTPbVCh+7
 SZK5DKVRAbh1F/ytQuemJ098+NM0aOvQH78RyCizOKi177AmXgJyAZcyVct8O/me7m0A
 1gNQ==
X-Gm-Message-State: AC+VfDxAgpuOt+z1lUEwu9wnAYc7vU7pZ5YjmCnLiIdfhOHnnD3CDIVE
 f5XncrSBydEODfK4xnrgFC08ix3ew06CaOF59LjHvfOpYn8tqtpGZ9ED855e+nCOfSYA8U6TvCZ
 KlVM9LJhCbWUhhSztrRrPY++bc2PpoQ5fWRdjCnaAO1I2YKMJLylVQpsrng==
X-Received: by 2002:a05:6512:3c96:b0:4f0:ee3:848f with SMTP id
 h22-20020a0565123c9600b004f00ee3848fmr139126lfv.15.1684284640826; 
 Tue, 16 May 2023 17:50:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5nvocPyqtz2w18jvJ0wQ4AoTYZDsKWUnk+PG33ZiW+Bm0B7nLwAw3MuqDn+seYoyIrrp7GFtqIyu0p+Uu+2hY=
X-Received: by 2002:a05:6512:3c96:b0:4f0:ee3:848f with SMTP id
 h22-20020a0565123c9600b004f00ee3848fmr139117lfv.15.1684284640530; Tue, 16 May
 2023 17:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230413064027.13267-1-jasowang@redhat.com>
 <20230413064027.13267-3-jasowang@redhat.com>
 <20230516165043-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230516165043-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 May 2023 08:50:29 +0800
Message-ID: <CACGkMEutCg7OkJQ7-fcfb0zO-cJS0RhtTPtSf+YGcn4m4ujtfg@mail.gmail.com>
Subject: Re: [PATCH net-next V2 2/2] virtio-net: sleep instead of busy waiting
 for cvq command
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, david.marchand@redhat.com, davem@davemloft.net
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

T24gV2VkLCBNYXkgMTcsIDIwMjMgYXQgNDo1NOKAr0FNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCBBcHIgMTMsIDIwMjMgYXQgMDI6NDA6MjdQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IFdlIHVzZWQgdG8gYnVzeSB3YWl0aW5nIG9u
IHRoZSBjdnEgY29tbWFuZCB0aGlzIHRlbmRzIHRvIGJlCj4gPiBwcm9ibGVtYXRpYyBzaW5jZSB0
aGVyZSBubyB3YXkgZm9yIHRvIHNjaGVkdWxlIGFub3RoZXIgcHJvY2VzcyB3aGljaAo+ID4gbWF5
IHNlcnZlIGZvciB0aGUgY29udHJvbCB2aXJ0cXVldWUuIFRoaXMgbWlnaHQgYmUgdGhlIGNhc2Ug
d2hlbiB0aGUKPiA+IGNvbnRyb2wgdmlydHF1ZXVlIGlzIGVtdWxhdGVkIGJ5IHNvZnR3YXJlLiBU
aGlzIHBhdGNoIHN3aXRjaGVzIHRvIHVzZQo+ID4gY29tcGxldGlvbiB0byBhbGxvdyB0aGUgQ1BV
IHRvIHNsZWVwIGluc3RlYWQgb2YgYnVzeSB3YWl0aW5nIGZvciB0aGUKPiA+IGN2cSBjb21tYW5k
Lgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
Cj4gPiAtLS0KPiA+IENoYW5nZXMgc2luY2UgVjE6Cj4gPiAtIHVzZSBjb21wbGV0aW9uIGZvciBz
aW1wbGljaXR5Cj4gPiAtIGRvbid0IHRyeSB0byBoYXJkZW4gdGhlIENWUSBjb21tYW5kIHdoaWNo
IHJlcXVpcmVzIG1vcmUgdGhvdWdodAo+ID4gQ2hhbmdlcyBzaW5jZSBSRkM6Cj4gPiAtIGJyZWFr
IHRoZSBkZXZpY2Ugd2hlbiB0aW1lb3V0Cj4gPiAtIGdldCBidWZmZXIgbWFudWFsbHkgc2luY2Ug
dGhlIHZpcnRpbyBjb3JlIGNoZWNrIG1vcmVfdXNlZCgpIGluc3RlYWQKPiA+IC0tLQo+ID4gIGRy
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDIxICsrKysrKysrKysrKysrLS0tLS0tLQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+ID4KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMKPiA+IGluZGV4IDJlNTZiYmY4Njg5NC4uZDNlYjhmZDZjOWRjIDEwMDY0NAo+ID4gLS0t
IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMKPiA+IEBAIC0xOSw2ICsxOSw3IEBACj4gPiAgI2luY2x1ZGUgPGxpbnV4L2F2ZXJhZ2Uu
aD4KPiA+ICAjaW5jbHVkZSA8bGludXgvZmlsdGVyLmg+Cj4gPiAgI2luY2x1ZGUgPGxpbnV4L2tl
cm5lbC5oPgo+ID4gKyNpbmNsdWRlIDxsaW51eC9jb21wbGV0aW9uLmg+Cj4gPiAgI2luY2x1ZGUg
PG5ldC9yb3V0ZS5oPgo+ID4gICNpbmNsdWRlIDxuZXQveGRwLmg+Cj4gPiAgI2luY2x1ZGUgPG5l
dC9uZXRfZmFpbG92ZXIuaD4KPiA+IEBAIC0yOTUsNiArMjk2LDggQEAgc3RydWN0IHZpcnRuZXRf
aW5mbyB7Cj4gPgo+ID4gICAgICAgLyogZmFpbG92ZXIgd2hlbiBTVEFOREJZIGZlYXR1cmUgZW5h
YmxlZCAqLwo+ID4gICAgICAgc3RydWN0IGZhaWxvdmVyICpmYWlsb3ZlcjsKPiA+ICsKPiA+ICsg
ICAgIHN0cnVjdCBjb21wbGV0aW9uIGNvbXBsZXRpb247Cj4gPiAgfTsKPiA+Cj4gPiAgc3RydWN0
IHBhZGRlZF92bmV0X2hkciB7Cj4gPiBAQCAtMTcwOSw2ICsxNzEyLDEzIEBAIHN0YXRpYyBib29s
IHRyeV9maWxsX3JlY3Yoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIHN0cnVjdCByZWNlaXZlX3F1
ZXVlICpycSwKPiA+ICAgICAgIHJldHVybiAhb29tOwo+ID4gIH0KPiA+Cj4gPiArc3RhdGljIHZv
aWQgdmlydG5ldF9jdnFfZG9uZShzdHJ1Y3QgdmlydHF1ZXVlICpjdnEpCj4gPiArewo+ID4gKyAg
ICAgc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBjdnEtPnZkZXYtPnByaXY7Cj4gPiArCj4gPiAr
ICAgICBjb21wbGV0ZSgmdmktPmNvbXBsZXRpb24pOwo+ID4gK30KPiA+ICsKPiA+ICBzdGF0aWMg
dm9pZCBza2JfcmVjdl9kb25lKHN0cnVjdCB2aXJ0cXVldWUgKnJ2cSkKPiA+ICB7Cj4gPiAgICAg
ICBzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IHJ2cS0+dmRldi0+cHJpdjsKPiA+IEBAIC0yMTY5
LDEyICsyMTc5LDggQEAgc3RhdGljIGJvb2wgdmlydG5ldF9zZW5kX2NvbW1hbmQoc3RydWN0IHZp
cnRuZXRfaW5mbyAqdmksIHU4IGNsYXNzLCB1OCBjbWQsCj4gPiAgICAgICBpZiAodW5saWtlbHko
IXZpcnRxdWV1ZV9raWNrKHZpLT5jdnEpKSkKPiA+ICAgICAgICAgICAgICAgcmV0dXJuIHZpLT5j
dHJsLT5zdGF0dXMgPT0gVklSVElPX05FVF9PSzsKPiA+Cj4gPiAtICAgICAvKiBTcGluIGZvciBh
IHJlc3BvbnNlLCB0aGUga2ljayBjYXVzZXMgYW4gaW9wb3J0IHdyaXRlLCB0cmFwcGluZwo+ID4g
LSAgICAgICogaW50byB0aGUgaHlwZXJ2aXNvciwgc28gdGhlIHJlcXVlc3Qgc2hvdWxkIGJlIGhh
bmRsZWQgaW1tZWRpYXRlbHkuCj4gPiAtICAgICAgKi8KPiA+IC0gICAgIHdoaWxlICghdmlydHF1
ZXVlX2dldF9idWYodmktPmN2cSwgJnRtcCkgJiYKPiA+IC0gICAgICAgICAgICAhdmlydHF1ZXVl
X2lzX2Jyb2tlbih2aS0+Y3ZxKSkKPiA+IC0gICAgICAgICAgICAgY3B1X3JlbGF4KCk7Cj4gPiAr
ICAgICB3YWl0X2Zvcl9jb21wbGV0aW9uKCZ2aS0+Y29tcGxldGlvbik7Cj4gPiArICAgICB2aXJ0
cXVldWVfZ2V0X2J1Zih2aS0+Y3ZxLCAmdG1wKTsKPiA+Cj4gPiAgICAgICByZXR1cm4gdmktPmN0
cmwtPnN0YXR1cyA9PSBWSVJUSU9fTkVUX09LOwo+Cj4gVGhpcyBzZWVtcyB0byBicmVhayBzdXJw
cmlzZSByZW1vdmFsIGFuZCBvdGhlcgo+IHNpdHVhdGlvbnMgd2hlcmUgdnEgZ2V0cyBicm9rZW4g
c2luY2UgY2FsbGJhY2tzCj4gYXJlbid0IHVzdWFsbHkgaW52b2tlZCB0aGVuLgoKWWVzLCBzbyBJ
IHRoaW5rIEkgY2FuIGdvIGJhY2sgdG8gdGhlIG9yaWdpbmFsIGlkZWEgYnkgc2ltcGx5IGFkZGlu
Zwpjb25kX3Jlc2NoZWQoKSBoZXJlLgoKPgo+Cj4gPiAgfQo+ID4gQEAgLTM2NzIsNyArMzY3OCw3
IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9maW5kX3ZxcyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkK
PiA+Cj4gPiAgICAgICAvKiBQYXJhbWV0ZXJzIGZvciBjb250cm9sIHZpcnRxdWV1ZSwgaWYgYW55
ICovCj4gPiAgICAgICBpZiAodmktPmhhc19jdnEpIHsKPiA+IC0gICAgICAgICAgICAgY2FsbGJh
Y2tzW3RvdGFsX3ZxcyAtIDFdID0gTlVMTDsKPiA+ICsgICAgICAgICAgICAgY2FsbGJhY2tzW3Rv
dGFsX3ZxcyAtIDFdID0gdmlydG5ldF9jdnFfZG9uZTsKPiA+ICAgICAgICAgICAgICAgbmFtZXNb
dG90YWxfdnFzIC0gMV0gPSAiY29udHJvbCI7Cj4gPiAgICAgICB9Cj4gPgo+Cj4gVGhlcmUgaXMg
YSBjb3N0IHRvIHRoaXMsIGluIHRoYXQgd2UgYXJlIGJ1cm5pbmcgYW4gZXh0cmEgTVNJIHZlY3Rv
cgo+IGZvciB0aGUgc2xvdyBwYXRoIGN2cS4gaWYgZGV2aWNlIGhhcyAzIHZlY3RvcnMsIHN1ZGRl
bmx5IHdlIGNhbid0Cj4gYWxsb2NhdGUgdmVjdG9ycyBmb3IgcnggYW5kIHR4LCBiaWcgcHJvYmxl
bS4KPgo+IFNvIEknbSBhZnJhaWQgd2UgbmVlZCB0byBwYXNzIGEgbmV3IGZsYWcgdGhhdCB3aWxs
IHNoYXJlCj4gdGhlIGNvbmZpZyBjaGFuZ2VkIGludGVycnVwdCBhbmQgY3ZxLgoKU2VlIGFib3Zl
LCBpdCBsb29rcyB0byBtZSBhIHNpbXBsZSBjb25kX3Jlc2NoZWQoKSBpcyBzdWZmaWNpZW50LCB0
aGVuCndlIGRvbid0IG5lZWQgYSBuZXcgdmVjdG9yLgoKVGhhbmtzCgo+Cj4KPgo+ID4gQEAgLTQx
MjIsNiArNDEyOCw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9wcm9iZShzdHJ1Y3QgdmlydGlvX2Rl
dmljZSAqdmRldikKPiA+ICAgICAgIGlmICh2aS0+aGFzX3JzcyB8fCB2aS0+aGFzX3Jzc19oYXNo
X3JlcG9ydCkKPiA+ICAgICAgICAgICAgICAgdmlydG5ldF9pbml0X2RlZmF1bHRfcnNzKHZpKTsK
PiA+Cj4gPiArICAgICBpbml0X2NvbXBsZXRpb24oJnZpLT5jb21wbGV0aW9uKTsKPiA+ICAgICAg
IGVuYWJsZV9yeF9tb2RlX3dvcmsodmkpOwo+ID4KPiA+ICAgICAgIC8qIHNlcmlhbGl6ZSBuZXRk
ZXYgcmVnaXN0ZXIgKyB2aXJ0aW9fZGV2aWNlX3JlYWR5KCkgd2l0aCBuZG9fb3BlbigpICovCj4g
PiAtLQo+ID4gMi4yNS4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
