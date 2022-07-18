Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAF0C43334
	for <virtualization@archiver.kernel.org>; Mon, 18 Jul 2022 08:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1D9B540323;
	Mon, 18 Jul 2022 08:58:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1D9B540323
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BFnAA1dW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9H_MSxGHRpYM; Mon, 18 Jul 2022 08:58:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 79C9340192;
	Mon, 18 Jul 2022 08:58:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 79C9340192
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43F2EC0035;
	Mon, 18 Jul 2022 08:58:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43A04C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 08:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 111A3401C9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 08:58:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 111A3401C9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uZbVolokaiZa
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 08:58:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2CD4840192
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2CD4840192
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 08:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658134688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7nIMD1pZp7DvAbftOgkHoQnYaSEiIlnRZj9mFpTSWE0=;
 b=BFnAA1dW5lllEEJgAsoMR1XHcTgXe2hvw2Bacwr6eJKLet8To2ecPoT5G0DXNeWhK6KWYG
 tKBdOzAUH62auSCsBjnbWqGqb9vtXf1cZbw5GWnOImAzMq+HWnE1qyS9rM1PyjLSTbZ862
 LKBs/nEUIr01UxigCssNZ8Fv1xusvB0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-NkqDBcH7MymgzqV97xmt-A-1; Mon, 18 Jul 2022 04:58:06 -0400
X-MC-Unique: NkqDBcH7MymgzqV97xmt-A-1
Received: by mail-lf1-f70.google.com with SMTP id
 d41-20020a0565123d2900b00489ed34ed26so4033341lfv.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 01:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7nIMD1pZp7DvAbftOgkHoQnYaSEiIlnRZj9mFpTSWE0=;
 b=ldtOE9tokrHAv+TWiktoPc5seYYVN85ZBybgOui3IvLEALn0dEknJR6yCPkcGSnKT+
 d0MBTs7LrUnpw42/TSmCoIwX/t0IASNgPmfEYKhoxfmtO6exsjel5+axcoi28W6ci/fv
 8NzfdnLO+Ld3RdBKGnx4Yt0ydkKbWzjxlXIRdLhcNzNIEdduHvog3YdIXzJFHEAv22e4
 ++l0uBGfNuWjhfbMt+sjRpfZinif7NI4cNhSZxlNcOBmnXdF/oIfq4yDKb4ABm0pF4U/
 UjcnlJLFzBWgTnxPaF6toDVq2C8DhDytWJoiDnhlG0UUxU6nijMs47MJo9Py3O4M+jDx
 5TWw==
X-Gm-Message-State: AJIora9NUiT0KmnP+FY3nkwBjF0G8drg7MX6fnC9yAJ3YFHaegV2tFb+
 QB+9fO4cnqRt2iD6vX1ukCvCJEtxCy+EP9Ch/QGTMlOC+w8fRglKCu1fWJCA7Vg0fk2yyVcI9Nb
 JKkjR06sM1/bT9+tTheZYWU/rU7IFwEgk3gr8heeCGXzEGynbLG9/YUEgeQ==
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr13647796lfa.124.1658134685272; 
 Mon, 18 Jul 2022 01:58:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vD/uj0rBcjiBGY3Pz66eOvA4LBNOKix2XOGkqmNrz5XDPze6r4T1HFvAe5/PHEmMxafySmO7QbTaIHfgsMrcc=
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr13647755lfa.124.1658134685003; Mon, 18
 Jul 2022 01:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-40-xuanzhuo@linux.alibaba.com>
 <102d3b83-1ae9-a59a-16ce-251c22b7afb0@redhat.com>
 <1656986432.1164997-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEt8MSS=tcn=Hd6WF9+btT0ccocxEd1ighRgK-V1uiWmCQ@mail.gmail.com>
 <1657873703.9301925-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1657873703.9301925-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Jul 2022 16:57:53 +0800
Message-ID: <CACGkMEvgjX+67NxwrUym7CnbNFU2-=CbAXPN_UmtvDOTS1LrHA@mail.gmail.com>
Subject: Re: [PATCH v11 39/40] virtio_net: support tx queue resize
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm <kvm@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, kangjie.xu@linux.alibaba.com,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org,
 "open list:XDP \(eXpress Data Path\)" <bpf@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev <netdev@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>, Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>
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

T24gRnJpLCBKdWwgMTUsIDIwMjIgYXQgNDozMiBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIEZyaSwgOCBKdWwgMjAyMiAxNDoyMzo1NyArMDgw
MCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiBPbiBUdWUsIEp1
bCA1LCAyMDIyIGF0IDEwOjAxIEFNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5j
b20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBNb24sIDQgSnVsIDIwMjIgMTE6NDU6NTIgKzA4MDAs
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4g
5ZyoIDIwMjIvNi8yOSAxNDo1NiwgWHVhbiBaaHVvIOWGmemBkzoKPiA+ID4gPiA+IFRoaXMgcGF0
Y2ggaW1wbGVtZW50cyB0aGUgcmVzaXplIGZ1bmN0aW9uIG9mIHRoZSB0eCBxdWV1ZXMuCj4gPiA+
ID4gPiBCYXNlZCBvbiB0aGlzIGZ1bmN0aW9uLCBpdCBpcyBwb3NzaWJsZSB0byBtb2RpZnkgdGhl
IHJpbmcgbnVtIG9mIHRoZQo+ID4gPiA+ID4gcXVldWUuCj4gPiA+ID4gPgo+ID4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+ID4g
PiA+IC0tLQo+ID4gPiA+ID4gICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA0OCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiA+ID4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCA0OCBpbnNlcnRpb25zKCspCj4gPiA+ID4gPgo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+
ID4gaW5kZXggNmFiMTZmZDE5M2U1Li5mZDM1ODQ2MmY4MDIgMTAwNjQ0Cj4gPiA+ID4gPiAtLS0g
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+ID4gPiA+ID4gQEAgLTEzNSw2ICsxMzUsOSBAQCBzdHJ1Y3Qgc2VuZF9xdWV1
ZSB7Cj4gPiA+ID4gPiAgICAgc3RydWN0IHZpcnRuZXRfc3Ffc3RhdHMgc3RhdHM7Cj4gPiA+ID4g
Pgo+ID4gPiA+ID4gICAgIHN0cnVjdCBuYXBpX3N0cnVjdCBuYXBpOwo+ID4gPiA+ID4gKwo+ID4g
PiA+ID4gKyAgIC8qIFJlY29yZCB3aGV0aGVyIHNxIGlzIGluIHJlc2V0IHN0YXRlLiAqLwo+ID4g
PiA+ID4gKyAgIGJvb2wgcmVzZXQ7Cj4gPiA+ID4gPiAgIH07Cj4gPiA+ID4gPgo+ID4gPiA+ID4g
ICAvKiBJbnRlcm5hbCByZXByZXNlbnRhdGlvbiBvZiBhIHJlY2VpdmUgdmlydHF1ZXVlICovCj4g
PiA+ID4gPiBAQCAtMjc5LDYgKzI4Miw3IEBAIHN0cnVjdCBwYWRkZWRfdm5ldF9oZHIgewo+ID4g
PiA+ID4gICB9Owo+ID4gPiA+ID4KPiA+ID4gPiA+ICAgc3RhdGljIHZvaWQgdmlydG5ldF9ycV9m
cmVlX3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1Zik7Cj4gPiA+ID4g
PiArc3RhdGljIHZvaWQgdmlydG5ldF9zcV9mcmVlX3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1
ZSAqdnEsIHZvaWQgKmJ1Zik7Cj4gPiA+ID4gPgo+ID4gPiA+ID4gICBzdGF0aWMgYm9vbCBpc194
ZHBfZnJhbWUodm9pZCAqcHRyKQo+ID4gPiA+ID4gICB7Cj4gPiA+ID4gPiBAQCAtMTYwMyw2ICsx
NjA3LDExIEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfcG9sbF9jbGVhbnR4KHN0cnVjdCByZWNlaXZl
X3F1ZXVlICpycSkKPiA+ID4gPiA+ICAgICAgICAgICAgIHJldHVybjsKPiA+ID4gPiA+Cj4gPiA+
ID4gPiAgICAgaWYgKF9fbmV0aWZfdHhfdHJ5bG9jayh0eHEpKSB7Cj4gPiA+ID4gPiArICAgICAg
ICAgICBpZiAoUkVBRF9PTkNFKHNxLT5yZXNldCkpIHsKPiA+ID4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgX19uZXRpZl90eF91bmxvY2sodHhxKTsKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgcmV0dXJuOwo+ID4gPiA+ID4gKyAgICAgICAgICAgfQo+ID4gPiA+ID4gKwo+ID4gPiA+ID4g
ICAgICAgICAgICAgZG8gewo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICB2aXJ0cXVldWVf
ZGlzYWJsZV9jYihzcS0+dnEpOwo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICBmcmVlX29s
ZF94bWl0X3NrYnMoc3EsIHRydWUpOwo+ID4gPiA+ID4gQEAgLTE4NjgsNiArMTg3Nyw0NSBAQCBz
dGF0aWMgaW50IHZpcnRuZXRfcnhfcmVzaXplKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ID4g
PiA+ID4gICAgIHJldHVybiBlcnI7Cj4gPiA+ID4gPiAgIH0KPiA+ID4gPiA+Cj4gPiA+ID4gPiAr
c3RhdGljIGludCB2aXJ0bmV0X3R4X3Jlc2l6ZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiA+
ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3EsIHUz
MiByaW5nX251bSkKPiA+ID4gPiA+ICt7Cj4gPiA+ID4gPiArICAgc3RydWN0IG5ldGRldl9xdWV1
ZSAqdHhxOwo+ID4gPiA+ID4gKyAgIGludCBlcnIsIHFpbmRleDsKPiA+ID4gPiA+ICsKPiA+ID4g
PiA+ICsgICBxaW5kZXggPSBzcSAtIHZpLT5zcTsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICsgICB2
aXJ0bmV0X25hcGlfdHhfZGlzYWJsZSgmc3EtPm5hcGkpOwo+ID4gPiA+ID4gKwo+ID4gPiA+ID4g
KyAgIHR4cSA9IG5ldGRldl9nZXRfdHhfcXVldWUodmktPmRldiwgcWluZGV4KTsKPiA+ID4gPiA+
ICsKPiA+ID4gPiA+ICsgICAvKiAxLiB3YWl0IGFsbCB4aW10IGNvbXBsZXRlCj4gPiA+ID4gPiAr
ICAgICogMi4gZml4IHRoZSByYWNlIG9mIG5ldGlmX3N0b3Bfc3VicXVldWUoKSB2cyBuZXRpZl9z
dGFydF9zdWJxdWV1ZSgpCj4gPiA+ID4gPiArICAgICovCj4gPiA+ID4gPiArICAgX19uZXRpZl90
eF9sb2NrX2JoKHR4cSk7Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiArICAgLyogUHJldmVudCByeCBw
b2xsIGZyb20gYWNjZXNzaW5nIHNxLiAqLwo+ID4gPiA+ID4gKyAgIFdSSVRFX09OQ0Uoc3EtPnJl
c2V0LCB0cnVlKTsKPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gQ2FuIHdlIHNpbXBseSBkaXNhYmxl
IFJYIE5BUEkgaGVyZT8KPiA+ID4KPiA+ID4gRGlzYWJsZSByeCBuYXBpIGlzIGluZGVlZCBhIHNp
bXBsZSBzb2x1dGlvbi4gQnV0IEkgaG9wZSB0aGF0IHdoZW4gZGVhbGluZyB3aXRoCj4gPiA+IHR4
LCBpdCB3aWxsIG5vdCBhZmZlY3QgcnguCj4gPgo+ID4gT2ssIGJ1dCBJIHRoaW5rIHdlJ3ZlIGFs
cmVhZHkgc3luY2hyb25pemVkIHdpdGggdHggbG9jayBoZXJlLCBpc24ndCBpdD8KPgo+IFllcywg
ZG8geW91IGhhdmUgYW55IHF1ZXN0aW9ucyBhYm91dCBXUklURV9PTkNFKCk/IFRoZXJlIGlzIGEg
c2V0IGZhbHNlIG9wZXJhdGlvbgo+IGxhdGVyLCBJIGRpZCBub3QgdXNlIGxvY2sgdGhlcmUsIHNv
IEkgdXNlZCBXUklURS9SRUFEX09OQ0UKPiB1bmlmb3JtbHkuCgpJIG1lYW4sIHNpbmNlIHdlJ3Zl
IGFscmVhZHkgdXNlZCB0eCBsb2NrcyBzb21ld2hlcmUsIHdlJ2QgYmV0dGVyIHVzZQp0aGVtIGhl
cmUgYXMgd2VsbCBhdCBsZWFzdCBhcyBhIHN0YXJ0LgoKVGhhbmtzCgo+Cj4gVGhhbmtzLgo+Cj4g
Pgo+ID4gVGhhbmtzCj4gPgo+ID4gPgo+ID4gPiBUaGFua3MuCj4gPiA+Cj4gPiA+Cj4gPiA+ID4K
PiA+ID4gPiBUaGFua3MKPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiArICAg
LyogUHJldmVudCB0aGUgdXBwZXIgbGF5ZXIgZnJvbSB0cnlpbmcgdG8gc2VuZCBwYWNrZXRzLiAq
Lwo+ID4gPiA+ID4gKyAgIG5ldGlmX3N0b3Bfc3VicXVldWUodmktPmRldiwgcWluZGV4KTsKPiA+
ID4gPiA+ICsKPiA+ID4gPiA+ICsgICBfX25ldGlmX3R4X3VubG9ja19iaCh0eHEpOwo+ID4gPiA+
ID4gKwo+ID4gPiA+ID4gKyAgIGVyciA9IHZpcnRxdWV1ZV9yZXNpemUoc3EtPnZxLCByaW5nX251
bSwgdmlydG5ldF9zcV9mcmVlX3VudXNlZF9idWYpOwo+ID4gPiA+ID4gKyAgIGlmIChlcnIpCj4g
PiA+ID4gPiArICAgICAgICAgICBuZXRkZXZfZXJyKHZpLT5kZXYsICJyZXNpemUgdHggZmFpbDog
dHggcXVldWUgaW5kZXg6ICVkIGVycjogJWRcbiIsIHFpbmRleCwgZXJyKTsKPiA+ID4gPiA+ICsK
PiA+ID4gPiA+ICsgICAvKiBNZW1vcnkgYmFycmllciBiZWZvcmUgc2V0IHJlc2V0IGFuZCBzdGFy
dCBzdWJxdWV1ZS4gKi8KPiA+ID4gPiA+ICsgICBzbXBfbWIoKTsKPiA+ID4gPiA+ICsKPiA+ID4g
PiA+ICsgICBXUklURV9PTkNFKHNxLT5yZXNldCwgZmFsc2UpOwo+ID4gPiA+ID4gKyAgIG5ldGlm
X3R4X3dha2VfcXVldWUodHhxKTsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICsgICB2aXJ0bmV0X25h
cGlfdHhfZW5hYmxlKHZpLCBzcS0+dnEsICZzcS0+bmFwaSk7Cj4gPiA+ID4gPiArICAgcmV0dXJu
IGVycjsKPiA+ID4gPiA+ICt9Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiAgIC8qCj4gPiA+ID4gPiAg
ICAqIFNlbmQgY29tbWFuZCB2aWEgdGhlIGNvbnRyb2wgdmlydHF1ZXVlIGFuZCBjaGVjayBzdGF0
dXMuICBDb21tYW5kcwo+ID4gPiA+ID4gICAgKiBzdXBwb3J0ZWQgYnkgdGhlIGh5cGVydmlzb3Is
IGFzIGluZGljYXRlZCBieSBmZWF0dXJlIGJpdHMsIHNob3VsZAo+ID4gPiA+Cj4gPiA+Cj4gPgo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
