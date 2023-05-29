Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F64C77B7C
	for <virtualization@archiver.kernel.org>; Mon, 29 May 2023 01:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B39F7408A7;
	Mon, 29 May 2023 01:21:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B39F7408A7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mw7NbaPW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0BYWHGfdMGZ6; Mon, 29 May 2023 01:21:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DDBF9400FD;
	Mon, 29 May 2023 01:21:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DDBF9400FD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBD12C0035;
	Mon, 29 May 2023 01:21:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D9A4C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 01:21:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 50AAA610CB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 01:21:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 50AAA610CB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mw7NbaPW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7uO7N1tYxJQA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 01:21:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BADD2610C3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BADD2610C3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 01:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685323298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jRboE5I0SRRDrF1SEw1w2ie0hUe/SapzMbi4K8/lSwo=;
 b=Mw7NbaPWYMAL/hPMuj34QidVm+k4Fy3QWH1scfg53S0K/9py2bmtTSL8y7Jd9ejTg8rACG
 fWZ4I+D8Thzxi/Aka0ldCekrcru9Dx97zRuk1+35bhvZZDpkQZzKpDt2PH1g4QVLQYIkKz
 BkAQPnrP4dTTaOw54PHHhAU5H8P9p1E=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-D5rknnrON9SnEVElS-Qo7g-1; Sun, 28 May 2023 21:21:35 -0400
X-MC-Unique: D5rknnrON9SnEVElS-Qo7g-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2af1589c75aso11408141fa.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 18:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685323294; x=1687915294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jRboE5I0SRRDrF1SEw1w2ie0hUe/SapzMbi4K8/lSwo=;
 b=g1DE4F+0mThgvKIiuPFFsBqdygGWF+DiHkN6xegaIxWFoy/HmRDC6bb2WpZ3HcDfXb
 5Uehj9Cyu+q3iWa9DhaVTimersRsyR8JLmrJv+SXUZEaJNR0t67ZDbFq5No6pVM28qqS
 x3YyyrbnNvtvcJA2O+9+QemfTNdenfY6VhjcmMPA0NhhzKYy36IwATlMyy6c/f2kJGFA
 nQEUCRN0qTB4fFZTLV3ZhuMP2ZW+KiJUH9Tk9sh1pIAgj8ntFUs7jEZQSu36tHlCyTLP
 apCECpZFC/3zsCMJVLqpGr4O04HiLba8bJFnSrSVw2Y6fUx1xxuHAAjWuEOgSbWEkfBQ
 VajA==
X-Gm-Message-State: AC+VfDwf8ZYk7aWjxGK9TMcnmj1ZRRu7U/M13eVF51eLksnV/Ku8/EiT
 o2Buz4xsXaEZuNvI4oTVa/SPzLbQZEt6ghAHoGj7xBuJvPXmbfR0xBmwdNfXvJyLwlDUYDnFscD
 wP3BKK1NYm4rMUlBbmKT2dTUSVSVTUdFHcPo2raJ+we8oPEvr17AZw8Ug1Q==
X-Received: by 2002:a05:651c:103b:b0:2af:2088:2548 with SMTP id
 w27-20020a05651c103b00b002af20882548mr3351419ljm.21.1685323294044; 
 Sun, 28 May 2023 18:21:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Kg07odPok1mdzPXs0HAFAv23D18/pYqhOKE9PgjFglnQ61GcVmzx9bqJteIa9LDbtm572mPL52Am1k7VDScA=
X-Received: by 2002:a05:651c:103b:b0:2af:2088:2548 with SMTP id
 w27-20020a05651c103b00b002af20882548mr3351413ljm.21.1685323293731; Sun, 28
 May 2023 18:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230524081842.3060-1-jasowang@redhat.com>
 <20230524081842.3060-2-jasowang@redhat.com>
 <20230524050604-mutt-send-email-mst@kernel.org>
 <CACGkMEvm=MJz5e2C_7U=yjrvoo7pxsr=tRAL29OdxJDWhvtiSQ@mail.gmail.com>
 <20230525033750-mutt-send-email-mst@kernel.org>
 <CACGkMEtCA0-NY=qq_FnGzoY+VXmixGmBV3y80nZWO=NmxdRWmw@mail.gmail.com>
 <20230528073139-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230528073139-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 May 2023 09:21:21 +0800
Message-ID: <CACGkMEvcjjGRfNYeZaG0hS8R2fnpve62QFv_ReRTXxCUKwf36w@mail.gmail.com>
Subject: Re: [PATCH V3 net-next 1/2] virtio-net: convert rx mode setting to
 use workqueue
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

T24gU3VuLCBNYXkgMjgsIDIwMjMgYXQgNzozOeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBNYXkgMjYsIDIwMjMgYXQgMDk6MzE6MzRB
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIFRodSwgTWF5IDI1LCAyMDIzIGF0IDM6
NDHigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4K
PiA+ID4gT24gVGh1LCBNYXkgMjUsIDIwMjMgYXQgMTE6NDM6MzRBTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gPiBPbiBXZWQsIE1heSAyNCwgMjAyMyBhdCA1OjE14oCvUE0gTWljaGFl
bCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4g
T24gV2VkLCBNYXkgMjQsIDIwMjMgYXQgMDQ6MTg6NDFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiA+ID4gPiA+ID4gVGhpcyBwYXRjaCBjb252ZXJ0IHJ4IG1vZGUgc2V0dGluZyB0byBiZSBk
b25lIGluIGEgd29ya3F1ZXVlLCB0aGlzIGlzCj4gPiA+ID4gPiA+IGEgbXVzdCBmb3IgYWxsb3cg
dG8gc2xlZXAgd2hlbiB3YWl0aW5nIGZvciB0aGUgY3ZxIGNvbW1hbmQgdG8KPiA+ID4gPiA+ID4g
cmVzcG9uc2Ugc2luY2UgY3VycmVudCBjb2RlIGlzIGV4ZWN1dGVkIHVuZGVyIGFkZHIgc3BpbiBs
b2NrLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gQ2hhbmdlcyBz
aW5jZSBWMToKPiA+ID4gPiA+ID4gLSB1c2UgUlROTCB0byBzeW5jaHJvbml6ZSByeCBtb2RlIHdv
cmtlcgo+ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
YyB8IDU1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0KPiA+ID4gPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
IGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gPiA+IGluZGV4IDU2Y2ExZDI3MDMw
NC4uNWQyZjFkYTRlYWEwIDEwMDY0NAo+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+
ID4gPiA+IEBAIC0yNjUsNiArMjY1LDEyIEBAIHN0cnVjdCB2aXJ0bmV0X2luZm8gewo+ID4gPiA+
ID4gPiAgICAgICAvKiBXb3JrIHN0cnVjdCBmb3IgY29uZmlnIHNwYWNlIHVwZGF0ZXMgKi8KPiA+
ID4gPiA+ID4gICAgICAgc3RydWN0IHdvcmtfc3RydWN0IGNvbmZpZ193b3JrOwo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiArICAgICAvKiBXb3JrIHN0cnVjdCBmb3IgY29uZmlnIHJ4IG1vZGUgKi8K
PiA+ID4gPiA+Cj4gPiA+ID4gPiBXaXRoIGEgYml0IGxlc3MgYWJicmV2aWF0aW9uIG1heWJlPyBz
ZXR0aW5nIHJ4IG1vZGU/Cj4gPiA+ID4KPiA+ID4gPiBUaGF0J3MgZmluZS4KPiA+ID4gPgo+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gKyAgICAgc3RydWN0IHdvcmtfc3RydWN0IHJ4X21vZGVfd29yazsK
PiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiArICAgICAvKiBJcyByeCBtb2RlIHdvcmsgZW5hYmxl
ZD8gKi8KPiA+ID4gPiA+Cj4gPiA+ID4gPiBVZ2ggbm90IGEgZ3JlYXQgY29tbWVudC4KPiA+ID4g
Pgo+ID4gPiA+IEFueSBzdWdnZXN0aW9ucyBmb3IgdGhpcy4gRS5nIHdlIGhhZDoKPiA+ID4gPgo+
ID4gPiA+ICAgICAgICAgLyogSXMgZGVsYXllZCByZWZpbGwgZW5hYmxlZD8gKi8KPiA+ID4KPiA+
ID4gLyogT0sgdG8gcXVldWUgd29yayBzZXR0aW5nIFJYIG1vZGU/ICovCj4gPgo+ID4gT2suCj4g
Pgo+ID4gPgo+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+ID4gKyAgICAgYm9vbCByeF9tb2RlX3dv
cmtfZW5hYmxlZDsKPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPgo+
ID4gPiA+ID4gPiAgICAgICAvKiBEb2VzIHRoZSBhZmZpbml0eSBoaW50IGlzIHNldCBmb3Igdmly
dHF1ZXVlcz8gKi8KPiA+ID4gPiA+ID4gICAgICAgYm9vbCBhZmZpbml0eV9oaW50X3NldDsKPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gQEAgLTM4OCw2ICszOTQsMjAgQEAgc3RhdGljIHZvaWQgZGlz
YWJsZV9kZWxheWVkX3JlZmlsbChzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkKPiA+ID4gPiA+ID4g
ICAgICAgc3Bpbl91bmxvY2tfYmgoJnZpLT5yZWZpbGxfbG9jayk7Cj4gPiA+ID4gPiA+ICB9Cj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ICtzdGF0aWMgdm9pZCBlbmFibGVfcnhfbW9kZV93b3JrKHN0
cnVjdCB2aXJ0bmV0X2luZm8gKnZpKQo+ID4gPiA+ID4gPiArewo+ID4gPiA+ID4gPiArICAgICBy
dG5sX2xvY2soKTsKPiA+ID4gPiA+ID4gKyAgICAgdmktPnJ4X21vZGVfd29ya19lbmFibGVkID0g
dHJ1ZTsKPiA+ID4gPiA+ID4gKyAgICAgcnRubF91bmxvY2soKTsKPiA+ID4gPiA+ID4gK30KPiA+
ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiArc3RhdGljIHZvaWQgZGlzYWJsZV9yeF9tb2RlX3dvcmso
c3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gPiA+ID4gPiA+ICt7Cj4gPiA+ID4gPiA+ICsgICAg
IHJ0bmxfbG9jaygpOwo+ID4gPiA+ID4gPiArICAgICB2aS0+cnhfbW9kZV93b3JrX2VuYWJsZWQg
PSBmYWxzZTsKPiA+ID4gPiA+ID4gKyAgICAgcnRubF91bmxvY2soKTsKPiA+ID4gPiA+ID4gK30K
PiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiAgc3RhdGljIHZvaWQgdmlydHF1ZXVlX25hcGlfc2No
ZWR1bGUoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLAo+ID4gPiA+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRxdWV1ZSAqdnEpCj4gPiA+ID4gPiA+ICB7
Cj4gPiA+ID4gPiA+IEBAIC0yMzQxLDkgKzIzNjEsMTEgQEAgc3RhdGljIGludCB2aXJ0bmV0X2Ns
b3NlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4gPiA+ID4gPiA+ICAgICAgIHJldHVybiAwOwo+
ID4gPiA+ID4gPiAgfQo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiAtc3RhdGljIHZvaWQgdmlydG5l
dF9zZXRfcnhfbW9kZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ID4gPiA+ID4gPiArc3RhdGlj
IHZvaWQgdmlydG5ldF9yeF9tb2RlX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ID4g
PiA+ID4gPiAgewo+ID4gPiA+ID4gPiAtICAgICBzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IG5l
dGRldl9wcml2KGRldik7Cj4gPiA+ID4gPiA+ICsgICAgIHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZp
ID0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICBjb250YWluZXJfb2Yod29yaywgc3RydWN0IHZp
cnRuZXRfaW5mbywgcnhfbW9kZV93b3JrKTsKPiA+ID4gPiA+ID4gKyAgICAgc3RydWN0IG5ldF9k
ZXZpY2UgKmRldiA9IHZpLT5kZXY7Cj4gPiA+ID4gPiA+ICAgICAgIHN0cnVjdCBzY2F0dGVybGlz
dCBzZ1syXTsKPiA+ID4gPiA+ID4gICAgICAgc3RydWN0IHZpcnRpb19uZXRfY3RybF9tYWMgKm1h
Y19kYXRhOwo+ID4gPiA+ID4gPiAgICAgICBzdHJ1Y3QgbmV0ZGV2X2h3X2FkZHIgKmhhOwo+ID4g
PiA+ID4gPiBAQCAtMjM1Niw2ICsyMzc4LDggQEAgc3RhdGljIHZvaWQgdmlydG5ldF9zZXRfcnhf
bW9kZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ID4gPiA+ID4gPiAgICAgICBpZiAoIXZpcnRp
b19oYXNfZmVhdHVyZSh2aS0+dmRldiwgVklSVElPX05FVF9GX0NUUkxfUlgpKQo+ID4gPiA+ID4g
PiAgICAgICAgICAgICAgIHJldHVybjsKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gKyAgICAgcnRu
bF9sb2NrKCk7Cj4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gICAgICAgdmktPmN0cmwtPnByb21p
c2MgPSAoKGRldi0+ZmxhZ3MgJiBJRkZfUFJPTUlTQykgIT0gMCk7Cj4gPiA+ID4gPiA+ICAgICAg
IHZpLT5jdHJsLT5hbGxtdWx0aSA9ICgoZGV2LT5mbGFncyAmIElGRl9BTExNVUxUSSkgIT0gMCk7
Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEBAIC0yMzczLDE0ICsyMzk3LDE5IEBAIHN0YXRpYyB2
b2lkIHZpcnRuZXRfc2V0X3J4X21vZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ID4gPiA+
ID4gICAgICAgICAgICAgICBkZXZfd2FybigmZGV2LT5kZXYsICJGYWlsZWQgdG8gJXNhYmxlIGFs
bG11bHRpIG1vZGUuXG4iLAo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgIHZpLT5j
dHJsLT5hbGxtdWx0aSA/ICJlbiIgOiAiZGlzIik7Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ICsg
ICAgIG5ldGlmX2FkZHJfbG9ja19iaChkZXYpOwo+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ICAg
ICAgIHVjX2NvdW50ID0gbmV0ZGV2X3VjX2NvdW50KGRldik7Cj4gPiA+ID4gPiA+ICAgICAgIG1j
X2NvdW50ID0gbmV0ZGV2X21jX2NvdW50KGRldik7Cj4gPiA+ID4gPiA+ICAgICAgIC8qIE1BQyBm
aWx0ZXIgLSB1c2Ugb25lIGJ1ZmZlciBmb3IgYm90aCBsaXN0cyAqLwo+ID4gPiA+ID4gPiAgICAg
ICBidWYgPSBremFsbG9jKCgodWNfY291bnQgKyBtY19jb3VudCkgKiBFVEhfQUxFTikgKwo+ID4g
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICgyICogc2l6ZW9mKG1hY19kYXRhLT5lbnRyaWVz
KSksIEdGUF9BVE9NSUMpOwo+ID4gPiA+ID4gPiAgICAgICBtYWNfZGF0YSA9IGJ1ZjsKPiA+ID4g
PiA+ID4gLSAgICAgaWYgKCFidWYpCj4gPiA+ID4gPiA+ICsgICAgIGlmICghYnVmKSB7Cj4gPiA+
ID4gPiA+ICsgICAgICAgICAgICAgbmV0aWZfYWRkcl91bmxvY2tfYmgoZGV2KTsKPiA+ID4gPiA+
ID4gKyAgICAgICAgICAgICBydG5sX3VubG9jaygpOwo+ID4gPiA+ID4gPiAgICAgICAgICAgICAg
IHJldHVybjsKPiA+ID4gPiA+ID4gKyAgICAgfQo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiAgICAg
ICBzZ19pbml0X3RhYmxlKHNnLCAyKTsKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gQEAgLTI0MDEs
NiArMjQzMCw4IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfc2V0X3J4X21vZGUoc3RydWN0IG5ldF9k
ZXZpY2UgKmRldikKPiA+ID4gPiA+ID4gICAgICAgbmV0ZGV2X2Zvcl9lYWNoX21jX2FkZHIoaGEs
IGRldikKPiA+ID4gPiA+ID4gICAgICAgICAgICAgICBtZW1jcHkoJm1hY19kYXRhLT5tYWNzW2kr
K11bMF0sIGhhLT5hZGRyLCBFVEhfQUxFTik7Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ICsgICAg
IG5ldGlmX2FkZHJfdW5sb2NrX2JoKGRldik7Cj4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gICAg
ICAgc2dfc2V0X2J1Zigmc2dbMV0sIG1hY19kYXRhLAo+ID4gPiA+ID4gPiAgICAgICAgICAgICAg
ICAgIHNpemVvZihtYWNfZGF0YS0+ZW50cmllcykgKyAobWNfY291bnQgKiBFVEhfQUxFTikpOwo+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBAQCAtMjQwOCw5ICsyNDM5LDE5IEBAIHN0YXRpYyB2b2lk
IHZpcnRuZXRfc2V0X3J4X21vZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ID4gPiA+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fTkVUX0NUUkxfTUFDX1RBQkxF
X1NFVCwgc2cpKQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgIGRldl93YXJuKCZkZXYtPmRldiwg
IkZhaWxlZCB0byBzZXQgTUFDIGZpbHRlciB0YWJsZS5cbiIpOwo+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiArICAgICBydG5sX3VubG9jaygpOwo+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ICAgICAg
IGtmcmVlKGJ1Zik7Cj4gPiA+ID4gPiA+ICB9Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ICtzdGF0
aWMgdm9pZCB2aXJ0bmV0X3NldF9yeF9tb2RlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4gPiA+
ID4gPiA+ICt7Cj4gPiA+ID4gPiA+ICsgICAgIHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0gbmV0
ZGV2X3ByaXYoZGV2KTsKPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiArICAgICBpZiAodmktPnJ4
X21vZGVfd29ya19lbmFibGVkKQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgIHNjaGVkdWxlX3dv
cmsoJnZpLT5yeF9tb2RlX3dvcmspOwo+ID4gPiA+ID4gPiArfQo+ID4gPiA+ID4gPiArCj4gPiA+
ID4gPgo+ID4gPiA+ID4gPiAgc3RhdGljIGludCB2aXJ0bmV0X3ZsYW5fcnhfYWRkX3ZpZChzdHJ1
Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBfX2JlMTYgcHJvdG8sIHUxNiB2aWQpCj4gPiA+ID4gPiA+ICB7Cj4gPiA+ID4gPiA+
IEBAIC0zMTgxLDYgKzMyMjIsOCBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X2ZyZWV6ZV9kb3duKHN0
cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiAgICAgICAv
KiBNYWtlIHN1cmUgbm8gd29yayBoYW5kbGVyIGlzIGFjY2Vzc2luZyB0aGUgZGV2aWNlICovCj4g
PiA+ID4gPiA+ICAgICAgIGZsdXNoX3dvcmsoJnZpLT5jb25maWdfd29yayk7Cj4gPiA+ID4gPiA+
ICsgICAgIGRpc2FibGVfcnhfbW9kZV93b3JrKHZpKTsKPiA+ID4gPiA+ID4gKyAgICAgZmx1c2hf
d29yaygmdmktPnJ4X21vZGVfd29yayk7Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ICAgICAgIG5l
dGlmX3R4X2xvY2tfYmgodmktPmRldik7Cj4gPiA+ID4gPiA+ICAgICAgIG5ldGlmX2RldmljZV9k
ZXRhY2godmktPmRldik7Cj4gPiA+ID4gPgo+ID4gPiA+ID4gSG1tIHNvIHF1ZXVlZCByeCBtb2Rl
IHdvcmsgd2lsbCBqdXN0IGdldCBza2lwcGVkCj4gPiA+ID4gPiBhbmQgb24gcmVzdG9yZSB3ZSBn
ZXQgYSB3cm9uZyByeCBtb2RlLgo+ID4gPiA+ID4gQW55IHdheSB0byBtYWtlIHRoaXMgbW9yZSBy
b2J1c3Q/Cj4gPiA+ID4KPiA+ID4gPiBJdCBjb3VsZCBiZSBkb25lIGJ5IHNjaGVkdWxpbmcgYSB3
b3JrIG9uIHJlc3RvcmUuCj4gPgo+ID4gUmV0aGluayB0aGlzLCBJIHRoaW5rIHdlIGRvbid0IG5l
ZWQgdG8gY2FyZSBhYm91dCB0aGlzIGNhc2Ugc2luY2UgdGhlCj4gPiB1c2VyIHByb2Nlc3NlcyBz
aG91bGQgaGF2ZSBiZWVuIGZyb3plbmVkLgo+Cj4gWWVzIGJ1dCBub3QgdGhlIHdvcmtxdWV1ZS4g
V2FudCB0byBzd2l0Y2ggdG8gc3lzdGVtX2ZyZWV6YWJsZV93cT8KClllcywgSSB3aWxsIGRvIGl0
IGluIHYyLgoKVGhhbmtzCgo+Cj4gPiBBbmQgdGhhdCB0aGUgcmVhc29uIHdlIGRvbid0Cj4gPiBl
dmVuIG5lZWQgdG8gaG9sZCBSVE5MIGhlcmUuCj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4gPiA+Cj4g
PiA+ID4gVGhhbmtzCj4gPiA+Cj4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
QEAgLTMyMDMsNiArMzI0Niw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9yZXN0b3JlX3VwKHN0cnVj
dCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiA+ID4gPiAgICAgICB2aXJ0aW9fZGV2aWNlX3Jl
YWR5KHZkZXYpOwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiAgICAgICBlbmFibGVfZGVsYXllZF9y
ZWZpbGwodmkpOwo+ID4gPiA+ID4gPiArICAgICBlbmFibGVfcnhfbW9kZV93b3JrKHZpKTsKPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gICAgICAgaWYgKG5ldGlmX3J1bm5pbmcodmktPmRldikpIHsK
PiA+ID4gPiA+ID4gICAgICAgICAgICAgICBlcnIgPSB2aXJ0bmV0X29wZW4odmktPmRldik7Cj4g
PiA+ID4gPiA+IEBAIC00MDAyLDYgKzQwNDYsNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUo
c3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPiA+ID4gPiA+ICAgICAgIHZkZXYtPnByaXYg
PSB2aTsKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gICAgICAgSU5JVF9XT1JLKCZ2aS0+Y29uZmln
X3dvcmssIHZpcnRuZXRfY29uZmlnX2NoYW5nZWRfd29yayk7Cj4gPiA+ID4gPiA+ICsgICAgIElO
SVRfV09SSygmdmktPnJ4X21vZGVfd29yaywgdmlydG5ldF9yeF9tb2RlX3dvcmspOwo+ID4gPiA+
ID4gPiAgICAgICBzcGluX2xvY2tfaW5pdCgmdmktPnJlZmlsbF9sb2NrKTsKPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gICAgICAgaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVU
X0ZfTVJHX1JYQlVGKSkgewo+ID4gPiA+ID4gPiBAQCAtNDExMCw2ICs0MTU1LDggQEAgc3RhdGlj
IGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiA+ID4g
PiAgICAgICBpZiAodmktPmhhc19yc3MgfHwgdmktPmhhc19yc3NfaGFzaF9yZXBvcnQpCj4gPiA+
ID4gPiA+ICAgICAgICAgICAgICAgdmlydG5ldF9pbml0X2RlZmF1bHRfcnNzKHZpKTsKPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gKyAgICAgZW5hYmxlX3J4X21vZGVfd29yayh2aSk7Cj4gPiA+ID4g
PiA+ICsKPiA+ID4gPiA+ID4gICAgICAgLyogc2VyaWFsaXplIG5ldGRldiByZWdpc3RlciArIHZp
cnRpb19kZXZpY2VfcmVhZHkoKSB3aXRoIG5kb19vcGVuKCkgKi8KPiA+ID4gPiA+ID4gICAgICAg
cnRubF9sb2NrKCk7Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEBAIC00MjA3LDYgKzQyNTQsOCBA
QCBzdGF0aWMgdm9pZCB2aXJ0bmV0X3JlbW92ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikK
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gICAgICAgLyogTWFrZSBzdXJlIG5vIHdvcmsgaGFuZGxl
ciBpcyBhY2Nlc3NpbmcgdGhlIGRldmljZS4gKi8KPiA+ID4gPiA+ID4gICAgICAgZmx1c2hfd29y
aygmdmktPmNvbmZpZ193b3JrKTsKPiA+ID4gPiA+ID4gKyAgICAgZGlzYWJsZV9yeF9tb2RlX3dv
cmsodmkpOwo+ID4gPiA+ID4gPiArICAgICBmbHVzaF93b3JrKCZ2aS0+cnhfbW9kZV93b3JrKTsK
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gICAgICAgdW5yZWdpc3Rlcl9uZXRkZXYodmktPmRldik7
Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IC0tCj4gPiA+ID4gPiA+IDIuMjUuMQo+ID4gPiA+ID4K
PiA+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
