Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BA8EB64D7
	for <virtualization@archiver.kernel.org>; Thu, 29 Jun 2023 03:20:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1522781CDB;
	Thu, 29 Jun 2023 03:20:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1522781CDB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PKzWAfFo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bspix0FHQti7; Thu, 29 Jun 2023 03:20:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4CE078145E;
	Thu, 29 Jun 2023 03:20:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4CE078145E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BF81C0072;
	Thu, 29 Jun 2023 03:20:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA00CC0037
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jun 2023 03:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A03074043D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jun 2023 03:20:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A03074043D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PKzWAfFo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XJI4IBPNHlgM
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jun 2023 03:20:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD1E54038C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BD1E54038C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jun 2023 03:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688008840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C847EGUrdqxVrqfFw1LBCKXsSidk17jhy+GW2Xvh8nI=;
 b=PKzWAfFoQZSMnEaBaOKUYT6YfE2fDNXICCwCVftB2TgLnB12IAz8lnSwpjsBf4VnuHw4Fn
 WEJWWYtrAVPCrvuMJZTBHe7FH61KmISPAvAEB3MivD2+OXqcBvFptke9+Z86zZlht6ByKb
 CvQWNnDISD9ldSz7uwPLgQE6KENCe9o=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-GdDfLpF-Pt6enBCQKmt7oQ-1; Wed, 28 Jun 2023 23:20:31 -0400
X-MC-Unique: GdDfLpF-Pt6enBCQKmt7oQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b6bf4d97beso2669481fa.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 20:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688008830; x=1690600830;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C847EGUrdqxVrqfFw1LBCKXsSidk17jhy+GW2Xvh8nI=;
 b=M14iBDhjFtdbZzENeE4t/XaDQXb9Oom+RFDrp0rAfnKq2eZuw4V2EBHrpdFLITrRRr
 uIiJyqSSiQfmuy4bngpnG8UYcQZLJX1QeDbPn78a1kaoPCiIRXxPfd0yk3w/AseZDmf6
 qt86BO+PCMViRFC12B1+inqVz1hnpnbmjE6r3oiNIucZPW62kdoBJpIFqB3g4AETLq3j
 53jFl18MYM0wT2Lv1BQwoCfWId3M7JlczM/i6ABl+7CniBJcN7daFjodE/yvVVRLErF7
 404U2RUm9h783EiXSKLExrKzO8lRHdVDhzcbMZeCVnvTCvcECfMOsraxDVpSkt9keQt1
 c2tA==
X-Gm-Message-State: AC+VfDzkqX0Jc3t+PrrFFe4HZI0k55nEbppExl5Ho64//rhmCcYyx61N
 r9fm3IyjuzX7SUyZVOfP0TlALRteOK6ZzVNGnPBUFTUkILl9kfSBOzpPp3xCQqIJCGQtwTopXcB
 Be/8Wn2I2l8DSVSW3NCmHk25Dsxu2uj1MVydkj8hUG7nDfqWFE0653s1f1w==
X-Received: by 2002:a19:5f44:0:b0:4f6:2317:f387 with SMTP id
 a4-20020a195f44000000b004f62317f387mr19425145lfj.35.1688008830220; 
 Wed, 28 Jun 2023 20:20:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7A4ns/TdSRlQkma0fVdfYjsBbD/XKG6hmD+EMizVgr6A9kvJ+XcgGTf234JNmcmpMJJYQg2Hz3YW+zckNXips=
X-Received: by 2002:a19:5f44:0:b0:4f6:2317:f387 with SMTP id
 a4-20020a195f44000000b004f62317f387mr19425133lfj.35.1688008829881; Wed, 28
 Jun 2023 20:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230524081842.3060-1-jasowang@redhat.com>
 <20230524081842.3060-2-jasowang@redhat.com>
 <20230524050604-mutt-send-email-mst@kernel.org>
 <CACGkMEvm=MJz5e2C_7U=yjrvoo7pxsr=tRAL29OdxJDWhvtiSQ@mail.gmail.com>
 <20230525033750-mutt-send-email-mst@kernel.org>
 <CACGkMEtCA0-NY=qq_FnGzoY+VXmixGmBV3y80nZWO=NmxdRWmw@mail.gmail.com>
 <20230528073139-mutt-send-email-mst@kernel.org>
 <CACGkMEvcjjGRfNYeZaG0hS8R2fnpve62QFv_ReRTXxCUKwf36w@mail.gmail.com>
 <CACGkMEtgZ_=L2noqdADgNTr_E7s3adw=etvcFt3G7ZERQq43_g@mail.gmail.com>
 <20230628093334-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230628093334-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Jun 2023 11:20:18 +0800
Message-ID: <CACGkMEvR71nDWLyGoxVR1vsAqP+t93Pdv5ixFY4dXowWNBrzEQ@mail.gmail.com>
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

T24gV2VkLCBKdW4gMjgsIDIwMjMgYXQgOTozNOKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gV2VkLCBNYXkgMzEsIDIwMjMgYXQgMDk6MDc6MjVB
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIE1vbiwgTWF5IDI5LCAyMDIzIGF0IDk6
MjHigK9BTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4KPiA+
ID4gT24gU3VuLCBNYXkgMjgsIDIwMjMgYXQgNzozOeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24gRnJpLCBNYXkgMjYsIDIw
MjMgYXQgMDk6MzE6MzRBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+IE9uIFRo
dSwgTWF5IDI1LCAyMDIzIGF0IDM6NDHigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRo
YXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gT24gVGh1LCBNYXkgMjUsIDIw
MjMgYXQgMTE6NDM6MzRBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiBP
biBXZWQsIE1heSAyNCwgMjAyMyBhdCA1OjE14oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gT24gV2Vk
LCBNYXkgMjQsIDIwMjMgYXQgMDQ6MTg6NDFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+
ID4gPiA+ID4gPiA+ID4gVGhpcyBwYXRjaCBjb252ZXJ0IHJ4IG1vZGUgc2V0dGluZyB0byBiZSBk
b25lIGluIGEgd29ya3F1ZXVlLCB0aGlzIGlzCj4gPiA+ID4gPiA+ID4gPiA+IGEgbXVzdCBmb3Ig
YWxsb3cgdG8gc2xlZXAgd2hlbiB3YWl0aW5nIGZvciB0aGUgY3ZxIGNvbW1hbmQgdG8KPiA+ID4g
PiA+ID4gPiA+ID4gcmVzcG9uc2Ugc2luY2UgY3VycmVudCBjb2RlIGlzIGV4ZWN1dGVkIHVuZGVy
IGFkZHIgc3BpbiBsb2NrLgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+ID4gPiA+
ID4gPiAtLS0KPiA+ID4gPiA+ID4gPiA+ID4gQ2hhbmdlcyBzaW5jZSBWMToKPiA+ID4gPiA+ID4g
PiA+ID4gLSB1c2UgUlROTCB0byBzeW5jaHJvbml6ZSByeCBtb2RlIHdvcmtlcgo+ID4gPiA+ID4g
PiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8
IDU1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0KPiA+ID4gPiA+ID4g
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+
ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gPiA+ID4g
PiA+IGluZGV4IDU2Y2ExZDI3MDMwNC4uNWQyZjFkYTRlYWEwIDEwMDY0NAo+ID4gPiA+ID4gPiA+
ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+ID4gPiA+ID4gKysr
IGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gPiA+ID4gPiA+IEBAIC0yNjUsNiAr
MjY1LDEyIEBAIHN0cnVjdCB2aXJ0bmV0X2luZm8gewo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAv
KiBXb3JrIHN0cnVjdCBmb3IgY29uZmlnIHNwYWNlIHVwZGF0ZXMgKi8KPiA+ID4gPiA+ID4gPiA+
ID4gICAgICAgc3RydWN0IHdvcmtfc3RydWN0IGNvbmZpZ193b3JrOwo+ID4gPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4gPiArICAgICAvKiBXb3JrIHN0cnVjdCBmb3IgY29uZmlnIHJ4IG1v
ZGUgKi8KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBXaXRoIGEgYml0IGxlc3MgYWJi
cmV2aWF0aW9uIG1heWJlPyBzZXR0aW5nIHJ4IG1vZGU/Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiBUaGF0J3MgZmluZS4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+ID4gKyAgICAgc3RydWN0IHdvcmtfc3RydWN0IHJ4X21vZGVfd29yazsKPiA+ID4gPiA+
ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4gPiArICAgICAvKiBJcyByeCBtb2RlIHdvcmsgZW5h
YmxlZD8gKi8KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBVZ2ggbm90IGEgZ3JlYXQg
Y29tbWVudC4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEFueSBzdWdnZXN0aW9ucyBmb3Ig
dGhpcy4gRS5nIHdlIGhhZDoKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ICAgICAgICAgLyog
SXMgZGVsYXllZCByZWZpbGwgZW5hYmxlZD8gKi8KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gLyog
T0sgdG8gcXVldWUgd29yayBzZXR0aW5nIFJYIG1vZGU/ICovCj4gPiA+ID4gPgo+ID4gPiA+ID4g
T2suCj4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+ID4gKyAgICAgYm9vbCByeF9tb2RlX3dvcmtfZW5hYmxlZDsKPiA+ID4gPiA+
ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAvKiBEb2VzIHRoZSBhZmZpbml0eSBoaW50IGlzIHNl
dCBmb3IgdmlydHF1ZXVlcz8gKi8KPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgYm9vbCBhZmZpbml0
eV9oaW50X3NldDsKPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gQEAgLTM4OCw2
ICszOTQsMjAgQEAgc3RhdGljIHZvaWQgZGlzYWJsZV9kZWxheWVkX3JlZmlsbChzdHJ1Y3Qgdmly
dG5ldF9pbmZvICp2aSkKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgc3Bpbl91bmxvY2tfYmgoJnZp
LT5yZWZpbGxfbG9jayk7Cj4gPiA+ID4gPiA+ID4gPiA+ICB9Cj4gPiA+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gPiA+ICtzdGF0aWMgdm9pZCBlbmFibGVfcnhfbW9kZV93b3JrKHN0cnVjdCB2
aXJ0bmV0X2luZm8gKnZpKQo+ID4gPiA+ID4gPiA+ID4gPiArewo+ID4gPiA+ID4gPiA+ID4gPiAr
ICAgICBydG5sX2xvY2soKTsKPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgdmktPnJ4X21vZGVfd29y
a19lbmFibGVkID0gdHJ1ZTsKPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgcnRubF91bmxvY2soKTsK
PiA+ID4gPiA+ID4gPiA+ID4gK30KPiA+ID4gPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4g
PiArc3RhdGljIHZvaWQgZGlzYWJsZV9yeF9tb2RlX3dvcmsoc3RydWN0IHZpcnRuZXRfaW5mbyAq
dmkpCj4gPiA+ID4gPiA+ID4gPiA+ICt7Cj4gPiA+ID4gPiA+ID4gPiA+ICsgICAgIHJ0bmxfbG9j
aygpOwo+ID4gPiA+ID4gPiA+ID4gPiArICAgICB2aS0+cnhfbW9kZV93b3JrX2VuYWJsZWQgPSBm
YWxzZTsKPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgcnRubF91bmxvY2soKTsKPiA+ID4gPiA+ID4g
PiA+ID4gK30KPiA+ID4gPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4gPiAgc3RhdGljIHZv
aWQgdmlydHF1ZXVlX25hcGlfc2NoZWR1bGUoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLAo+ID4g
PiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZp
cnRxdWV1ZSAqdnEpCj4gPiA+ID4gPiA+ID4gPiA+ICB7Cj4gPiA+ID4gPiA+ID4gPiA+IEBAIC0y
MzQxLDkgKzIzNjEsMTEgQEAgc3RhdGljIGludCB2aXJ0bmV0X2Nsb3NlKHN0cnVjdCBuZXRfZGV2
aWNlICpkZXYpCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgIHJldHVybiAwOwo+ID4gPiA+ID4gPiA+
ID4gPiAgfQo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiAtc3RhdGljIHZvaWQg
dmlydG5ldF9zZXRfcnhfbW9kZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ID4gPiA+ID4gPiA+
ID4gPiArc3RhdGljIHZvaWQgdmlydG5ldF9yeF9tb2RlX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0
ICp3b3JrKQo+ID4gPiA+ID4gPiA+ID4gPiAgewo+ID4gPiA+ID4gPiA+ID4gPiAtICAgICBzdHJ1
Y3QgdmlydG5ldF9pbmZvICp2aSA9IG5ldGRldl9wcml2KGRldik7Cj4gPiA+ID4gPiA+ID4gPiA+
ICsgICAgIHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0KPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAg
ICAgICAgICBjb250YWluZXJfb2Yod29yaywgc3RydWN0IHZpcnRuZXRfaW5mbywgcnhfbW9kZV93
b3JrKTsKPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgc3RydWN0IG5ldF9kZXZpY2UgKmRldiA9IHZp
LT5kZXY7Cj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgIHN0cnVjdCBzY2F0dGVybGlzdCBzZ1syXTsK
PiA+ID4gPiA+ID4gPiA+ID4gICAgICAgc3RydWN0IHZpcnRpb19uZXRfY3RybF9tYWMgKm1hY19k
YXRhOwo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICBzdHJ1Y3QgbmV0ZGV2X2h3X2FkZHIgKmhhOwo+
ID4gPiA+ID4gPiA+ID4gPiBAQCAtMjM1Niw2ICsyMzc4LDggQEAgc3RhdGljIHZvaWQgdmlydG5l
dF9zZXRfcnhfbW9kZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ID4gPiA+ID4gPiA+ID4gPiAg
ICAgICBpZiAoIXZpcnRpb19oYXNfZmVhdHVyZSh2aS0+dmRldiwgVklSVElPX05FVF9GX0NUUkxf
UlgpKQo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgIHJldHVybjsKPiA+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgcnRubF9sb2NrKCk7Cj4gPiA+ID4gPiA+ID4g
PiA+ICsKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgdmktPmN0cmwtPnByb21pc2MgPSAoKGRldi0+
ZmxhZ3MgJiBJRkZfUFJPTUlTQykgIT0gMCk7Cj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgIHZpLT5j
dHJsLT5hbGxtdWx0aSA9ICgoZGV2LT5mbGFncyAmIElGRl9BTExNVUxUSSkgIT0gMCk7Cj4gPiA+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IEBAIC0yMzczLDE0ICsyMzk3LDE5IEBAIHN0
YXRpYyB2b2lkIHZpcnRuZXRfc2V0X3J4X21vZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+
ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICBkZXZfd2FybigmZGV2LT5kZXYsICJGYWlsZWQg
dG8gJXNhYmxlIGFsbG11bHRpIG1vZGUuXG4iLAo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgIHZpLT5jdHJsLT5hbGxtdWx0aSA/ICJlbiIgOiAiZGlzIik7Cj4gPiA+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ICsgICAgIG5ldGlmX2FkZHJfbG9ja19iaChkZXYp
Owo+ID4gPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgIHVjX2NvdW50ID0g
bmV0ZGV2X3VjX2NvdW50KGRldik7Cj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgIG1jX2NvdW50ID0g
bmV0ZGV2X21jX2NvdW50KGRldik7Cj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgIC8qIE1BQyBmaWx0
ZXIgLSB1c2Ugb25lIGJ1ZmZlciBmb3IgYm90aCBsaXN0cyAqLwo+ID4gPiA+ID4gPiA+ID4gPiAg
ICAgICBidWYgPSBremFsbG9jKCgodWNfY291bnQgKyBtY19jb3VudCkgKiBFVEhfQUxFTikgKwo+
ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICgyICogc2l6ZW9mKG1hY19kYXRh
LT5lbnRyaWVzKSksIEdGUF9BVE9NSUMpOwo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICBtYWNfZGF0
YSA9IGJ1ZjsKPiA+ID4gPiA+ID4gPiA+ID4gLSAgICAgaWYgKCFidWYpCj4gPiA+ID4gPiA+ID4g
PiA+ICsgICAgIGlmICghYnVmKSB7Cj4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgbmV0
aWZfYWRkcl91bmxvY2tfYmgoZGV2KTsKPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICBy
dG5sX3VubG9jaygpOwo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgIHJldHVybjsKPiA+
ID4gPiA+ID4gPiA+ID4gKyAgICAgfQo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
PiAgICAgICBzZ19pbml0X3RhYmxlKHNnLCAyKTsKPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+ID4gQEAgLTI0MDEsNiArMjQzMCw4IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfc2V0X3J4
X21vZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgbmV0
ZGV2X2Zvcl9lYWNoX21jX2FkZHIoaGEsIGRldikKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAg
ICAgICBtZW1jcHkoJm1hY19kYXRhLT5tYWNzW2krK11bMF0sIGhhLT5hZGRyLCBFVEhfQUxFTik7
Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ICsgICAgIG5ldGlmX2FkZHJfdW5s
b2NrX2JoKGRldik7Cj4gPiA+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAg
c2dfc2V0X2J1Zigmc2dbMV0sIG1hY19kYXRhLAo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAg
ICAgICAgIHNpemVvZihtYWNfZGF0YS0+ZW50cmllcykgKyAobWNfY291bnQgKiBFVEhfQUxFTikp
Owo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBAQCAtMjQwOCw5ICsyNDM5LDE5
IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfc2V0X3J4X21vZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRl
dikKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWSVJU
SU9fTkVUX0NUUkxfTUFDX1RBQkxFX1NFVCwgc2cpKQo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAg
ICAgICAgIGRldl93YXJuKCZkZXYtPmRldiwgIkZhaWxlZCB0byBzZXQgTUFDIGZpbHRlciB0YWJs
ZS5cbiIpOwo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiArICAgICBydG5sX3Vu
bG9jaygpOwo+ID4gPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgIGtmcmVl
KGJ1Zik7Cj4gPiA+ID4gPiA+ID4gPiA+ICB9Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiA+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3NldF9yeF9tb2RlKHN0cnVjdCBuZXRfZGV2aWNl
ICpkZXYpCj4gPiA+ID4gPiA+ID4gPiA+ICt7Cj4gPiA+ID4gPiA+ID4gPiA+ICsgICAgIHN0cnVj
dCB2aXJ0bmV0X2luZm8gKnZpID0gbmV0ZGV2X3ByaXYoZGV2KTsKPiA+ID4gPiA+ID4gPiA+ID4g
Kwo+ID4gPiA+ID4gPiA+ID4gPiArICAgICBpZiAodmktPnJ4X21vZGVfd29ya19lbmFibGVkKQo+
ID4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgICAgIHNjaGVkdWxlX3dvcmsoJnZpLT5yeF9tb2Rl
X3dvcmspOwo+ID4gPiA+ID4gPiA+ID4gPiArfQo+ID4gPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiAgc3RhdGljIGludCB2aXJ0bmV0X3ZsYW5fcnhfYWRk
X3ZpZChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBfX2JlMTYgcHJvdG8sIHUxNiB2aWQpCj4gPiA+ID4gPiA+
ID4gPiA+ICB7Cj4gPiA+ID4gPiA+ID4gPiA+IEBAIC0zMTgxLDYgKzMyMjIsOCBAQCBzdGF0aWMg
dm9pZCB2aXJ0bmV0X2ZyZWV6ZV9kb3duKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAvKiBNYWtlIHN1cmUgbm8gd29y
ayBoYW5kbGVyIGlzIGFjY2Vzc2luZyB0aGUgZGV2aWNlICovCj4gPiA+ID4gPiA+ID4gPiA+ICAg
ICAgIGZsdXNoX3dvcmsoJnZpLT5jb25maWdfd29yayk7Cj4gPiA+ID4gPiA+ID4gPiA+ICsgICAg
IGRpc2FibGVfcnhfbW9kZV93b3JrKHZpKTsKPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgZmx1c2hf
d29yaygmdmktPnJ4X21vZGVfd29yayk7Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
PiA+ICAgICAgIG5ldGlmX3R4X2xvY2tfYmgodmktPmRldik7Cj4gPiA+ID4gPiA+ID4gPiA+ICAg
ICAgIG5ldGlmX2RldmljZV9kZXRhY2godmktPmRldik7Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4gSG1tIHNvIHF1ZXVlZCByeCBtb2RlIHdvcmsgd2lsbCBqdXN0IGdldCBza2lwcGVk
Cj4gPiA+ID4gPiA+ID4gPiBhbmQgb24gcmVzdG9yZSB3ZSBnZXQgYSB3cm9uZyByeCBtb2RlLgo+
ID4gPiA+ID4gPiA+ID4gQW55IHdheSB0byBtYWtlIHRoaXMgbW9yZSByb2J1c3Q/Cj4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiBJdCBjb3VsZCBiZSBkb25lIGJ5IHNjaGVkdWxpbmcgYSB3b3Jr
IG9uIHJlc3RvcmUuCj4gPiA+ID4gPgo+ID4gPiA+ID4gUmV0aGluayB0aGlzLCBJIHRoaW5rIHdl
IGRvbid0IG5lZWQgdG8gY2FyZSBhYm91dCB0aGlzIGNhc2Ugc2luY2UgdGhlCj4gPiA+ID4gPiB1
c2VyIHByb2Nlc3NlcyBzaG91bGQgaGF2ZSBiZWVuIGZyb3plbmVkLgo+ID4gPiA+Cj4gPiA+ID4g
WWVzIGJ1dCBub3QgdGhlIHdvcmtxdWV1ZS4gV2FudCB0byBzd2l0Y2ggdG8gc3lzdGVtX2ZyZWV6
YWJsZV93cT8KPiA+ID4KPiA+ID4gWWVzLCBJIHdpbGwgZG8gaXQgaW4gdjIuCj4gPgo+ID4gQWN0
dWFsbHksIHRoaXMgZG9lc24ndCB3b3JrLiBGcmVlemFibGUgd29ya3F1ZXVlIGNhbiBvbmx5IGd1
YXJhbnRlZQo+ID4gd2hlbiBiZWluZyBmcmVlemVkIHRoZSBuZXcgd29yayB3aWxsIGJlIHF1ZXVl
ZCBhbmQgbm90IHNjaGVkdWxlZCB1bnRpbAo+ID4gdGhhdy4gU28gdGhlIGt0cmhlYWQgdGhhdCBp
cyBleGVjdXRpbmcgdGhlIHdvcmtxdWV1ZSBpcyBub3QgZnJlZXphYmxlLgo+ID4gVGhlIGJ1c3kg
bG9vcCAoZXZlbiB3aXRoIGNvbmRfcmVzY2hlZCgpKSB3aWxsIGZvcmNlIHN1c3BlbmQgaW4gdGhp
cwo+ID4gY2FzZS4KPiA+Cj4gPiBJIHdvbmRlciBpZiB3ZSBzaG91bGQgc3dpdGNoIHRvIHVzaW5n
IGEgZGVkaWNhdGVkIGt0aHJlYWQgZm9yCj4gPiB2aXJ0aW8tbmV0IHRoZW4gd2UgY2FuIGFsbG93
IGl0IHRvIGJlIGZyb3plbi4KPiA+Cj4gPiBUaGFua3MKPiA+Cj4KPiBTbyB3aGF0J3MgdGhlIHBs
YW4gdGhlbj8KCkkgcGxhbiB0byBzZW5kIGEgbmV3IHZlcnNpb24gdGhhdCBkb2Vzbid0IHRha2Ug
c3BlY2lhbCBjYXJlIHRvIGZyZWV6ZS4KQW5kIGFkZHJlc3MgdGhlIGZyZWV6ZSBvbiB0b3AsIHBy
b2JhYmx5IHdpdGggYSBkZWRpY2F0ZWQga3RocmVhZCB0aGF0CmNhbiBiZSBmcm96ZW4gYW5kIHJl
c3BvbmQgdG8gdGhpbmdzIGxpa2UgU0lHS0lMTCAod2hpY2ggaXMgc29tZWhvdwpzaW1pbGFyIHRv
IHdoYXQgd2Ugd2FudCB0byBzb2x2ZSBmb3Igdmhvc3QpLgoKVGhhbmtzCgo+Cj4gPiA+Cj4gPiA+
IFRoYW5rcwo+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBBbmQgdGhhdCB0aGUgcmVhc29uIHdlIGRv
bid0Cj4gPiA+ID4gPiBldmVuIG5lZWQgdG8gaG9sZCBSVE5MIGhlcmUuCj4gPiA+ID4gPgo+ID4g
PiA+ID4gVGhhbmtzCj4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVGhhbmtz
Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gQEAgLTMyMDMsNiArMzI0Niw3IEBAIHN0YXRpYyBpbnQgdmlydG5l
dF9yZXN0b3JlX3VwKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiA+ID4gPiA+ID4g
PiAgICAgICB2aXJ0aW9fZGV2aWNlX3JlYWR5KHZkZXYpOwo+ID4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gPiAgICAgICBlbmFibGVfZGVsYXllZF9yZWZpbGwodmkpOwo+ID4gPiA+ID4g
PiA+ID4gPiArICAgICBlbmFibGVfcnhfbW9kZV93b3JrKHZpKTsKPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gICAgICAgaWYgKG5ldGlmX3J1bm5pbmcodmktPmRldikpIHsKPiA+
ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICBlcnIgPSB2aXJ0bmV0X29wZW4odmktPmRldik7
Cj4gPiA+ID4gPiA+ID4gPiA+IEBAIC00MDAyLDYgKzQwNDYsNyBAQCBzdGF0aWMgaW50IHZpcnRu
ZXRfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPiA+ID4gPiA+ID4gPiA+ICAg
ICAgIHZkZXYtPnByaXYgPSB2aTsKPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
ICAgICAgSU5JVF9XT1JLKCZ2aS0+Y29uZmlnX3dvcmssIHZpcnRuZXRfY29uZmlnX2NoYW5nZWRf
d29yayk7Cj4gPiA+ID4gPiA+ID4gPiA+ICsgICAgIElOSVRfV09SSygmdmktPnJ4X21vZGVfd29y
aywgdmlydG5ldF9yeF9tb2RlX3dvcmspOwo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICBzcGluX2xv
Y2tfaW5pdCgmdmktPnJlZmlsbF9sb2NrKTsKPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4gICAgICAgaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfTVJH
X1JYQlVGKSkgewo+ID4gPiA+ID4gPiA+ID4gPiBAQCAtNDExMCw2ICs0MTU1LDggQEAgc3RhdGlj
IGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiA+ID4g
PiA+ID4gPiAgICAgICBpZiAodmktPmhhc19yc3MgfHwgdmktPmhhc19yc3NfaGFzaF9yZXBvcnQp
Cj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgdmlydG5ldF9pbml0X2RlZmF1bHRfcnNz
KHZpKTsKPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgZW5hYmxlX3J4
X21vZGVfd29yayh2aSk7Cj4gPiA+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiA+ID4gICAg
ICAgLyogc2VyaWFsaXplIG5ldGRldiByZWdpc3RlciArIHZpcnRpb19kZXZpY2VfcmVhZHkoKSB3
aXRoIG5kb19vcGVuKCkgKi8KPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgcnRubF9sb2NrKCk7Cj4g
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IEBAIC00MjA3LDYgKzQyNTQsOCBAQCBz
dGF0aWMgdm9pZCB2aXJ0bmV0X3JlbW92ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiA+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgLyogTWFrZSBzdXJlIG5vIHdv
cmsgaGFuZGxlciBpcyBhY2Nlc3NpbmcgdGhlIGRldmljZS4gKi8KPiA+ID4gPiA+ID4gPiA+ID4g
ICAgICAgZmx1c2hfd29yaygmdmktPmNvbmZpZ193b3JrKTsKPiA+ID4gPiA+ID4gPiA+ID4gKyAg
ICAgZGlzYWJsZV9yeF9tb2RlX3dvcmsodmkpOwo+ID4gPiA+ID4gPiA+ID4gPiArICAgICBmbHVz
aF93b3JrKCZ2aS0+cnhfbW9kZV93b3JrKTsKPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4gICAgICAgdW5yZWdpc3Rlcl9uZXRkZXYodmktPmRldik7Cj4gPiA+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gPiA+IC0tCj4gPiA+ID4gPiA+ID4gPiA+IDIuMjUuMQo+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
