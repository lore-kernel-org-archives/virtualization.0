Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393D3EB64D9
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 08:03:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5C2C418C3;
	Tue, 27 Jun 2023 08:03:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A5C2C418C3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q+cK26JG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f92oJ0w82aaN; Tue, 27 Jun 2023 08:03:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CAA6A409A2;
	Tue, 27 Jun 2023 08:03:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CAA6A409A2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2EBBC007C;
	Tue, 27 Jun 2023 08:03:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76457C0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43D7F6076C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:03:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43D7F6076C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q+cK26JG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lRjv-1JT7yES
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:03:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 63574605A9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 63574605A9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687853021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EAIgwfCxKCOJsdi6od/XlBbV/+5tFRsCfnVys12ZFNk=;
 b=Q+cK26JGG7+USFRP0zwfM3T8iMhPV7CnhjAa9wIN7OMdG9twBtqrGmHV2zePVN6QVxghPV
 76T0c4zdimLzYC1QT4ECulz3Ife7FfDFPPUOWkYTZHGmTfTENDM1dJpIFJKb69lbal1PD4
 Qn1+JuvKLkIaANDB7NusGbm9Uc2eB2w=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-mzWR5BfxO9CoP4DF2tmMmg-1; Tue, 27 Jun 2023 04:03:36 -0400
X-MC-Unique: mzWR5BfxO9CoP4DF2tmMmg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b6a0772b97so17546751fa.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 01:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687853015; x=1690445015;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAIgwfCxKCOJsdi6od/XlBbV/+5tFRsCfnVys12ZFNk=;
 b=D3WzjUET/w1OSjJmeE/SSJqpuamyO1AppCUsYamIKPrhoXAq/iADtAivuXHYa6JKsA
 SZcG7nKKGCCvhuC8L/STREdt9xkjCSoUBo040WqwJW2vJb+u6vHmUwO+U0a7J/dECFtu
 vgs171UeHgE9aEkH4fVAXgeankGYnTO3CzOVm/WCaHJqeJxB99vTpFLaByXOdmTcq5nY
 +U8vqHaoFXno1aeXZGf9ivJY9fEPGfQwX4P00s01RtpZAwvUxbKT528L8y6mGjpWgfmw
 NuDMtz5qdrlx16uLXyFVjC79BLW8dCjyxOtQEWxulfoHuQCP4cLV9Otqh7z7SOdWj0sI
 9CGA==
X-Gm-Message-State: AC+VfDxm6oD+VI/xt2Q2mXJWFm5023wPKZAyL6ZE1tOD603kykKdNRET
 JgH2EgbdsZB2d6z1LezGG1HqXo166ikdsplvBg+iBaxzDyug0Fwg69nSpAnSUWSZ7e/H3nwq9JN
 rv9fhTlXxbUMg3SJV2GUJbCKJek4PzGK8aUQDbot4AlDhnOWaqcpqn9TKKw==
X-Received: by 2002:a2e:7316:0:b0:2b6:9e58:33e4 with SMTP id
 o22-20020a2e7316000000b002b69e5833e4mr3819044ljc.4.1687853014817; 
 Tue, 27 Jun 2023 01:03:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5hU3RHXYr/pj0pxaHkeuHxuPz++Ykm7OjgngDYXG0THDVyAk4d453g90XaTYXzIjRL+EoepNV13PFA/YETwDY=
X-Received: by 2002:a2e:7316:0:b0:2b6:9e58:33e4 with SMTP id
 o22-20020a2e7316000000b002b69e5833e4mr3819029ljc.4.1687853014630; Tue, 27 Jun
 2023 01:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230602092206.50108-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Jun 2023 16:03:23 +0800
Message-ID: <CACGkMEt3xRvn5na+f4vHjFQoJJcPTvvE3Yd_bGxrDFo9owkqCA@mail.gmail.com>
Subject: Re: [PATCH vhost v10 02/10] virtio_ring: introduce
 virtqueue_set_premapped()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
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

T24gRnJpLCBKdW4gMiwgMjAyMyBhdCA1OjIy4oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBUaGlzIGhlbHBlciBhbGxvd3MgdGhlIGRyaXZlciBj
aGFuZ2UgdGhlIGRtYSBtb2RlIHRvIHByZW1hcHBlZCBtb2RlLgo+IFVuZGVyIHRoZSBwcmVtYXBw
ZWQgbW9kZSwgdGhlIHZpcnRpbyBjb3JlIGRvIG5vdCBkbyBkbWEgbWFwcGluZwo+IGludGVybmFs
bHkuCj4KPiBUaGlzIGp1c3Qgd29yayB3aGVuIHRoZSB1c2VfZG1hX2FwaSBpcyB0cnVlLiBJZiB0
aGUgdXNlX2RtYV9hcGkgaXMgZmFsc2UsCj4gdGhlIGRtYSBvcHRpb25zIGlzIG5vdCB0aHJvdWdo
IHRoZSBETUEgQVBJcywgdGhhdCBpcyBub3QgdGhlIHN0YW5kYXJkCj4gd2F5IG9mIHRoZSBsaW51
eCBrZXJuZWwuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFs
aWJhYmEuY29tPgo+IC0tLQo+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNDAgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gIGluY2x1ZGUvbGludXgvdmlydGlv
LmggICAgICAgfCAgMiArKwo+ICAyIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKykKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDcyZWQwN2E2MDRkNC4uMmFmZGZiOWUzZTMwIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTE3Miw2ICsxNzIsOSBAQCBzdHJ1Y3QgdnJpbmdfdmly
dHF1ZXVlIHsKPiAgICAgICAgIC8qIEhvc3QgcHVibGlzaGVzIGF2YWlsIGV2ZW50IGlkeCAqLwo+
ICAgICAgICAgYm9vbCBldmVudDsKPgo+ICsgICAgICAgLyogRG8gRE1BIG1hcHBpbmcgYnkgZHJp
dmVyICovCj4gKyAgICAgICBib29sIHByZW1hcHBlZDsKPiArCj4gICAgICAgICAvKiBIZWFkIG9m
IGZyZWUgYnVmZmVyIGxpc3QuICovCj4gICAgICAgICB1bnNpZ25lZCBpbnQgZnJlZV9oZWFkOwo+
ICAgICAgICAgLyogTnVtYmVyIHdlJ3ZlIGFkZGVkIHNpbmNlIGxhc3Qgc3luYy4gKi8KPiBAQCAt
MjA1OSw2ICsyMDYyLDcgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92
aXJ0cXVldWVfcGFja2VkKAo+ICAgICAgICAgdnEtPnBhY2tlZF9yaW5nID0gdHJ1ZTsKPiAgICAg
ICAgIHZxLT5kbWFfZGV2ID0gZG1hX2RldjsKPiAgICAgICAgIHZxLT51c2VfZG1hX2FwaSA9IHZy
aW5nX3VzZV9kbWFfYXBpKHZkZXYpOwo+ICsgICAgICAgdnEtPnByZW1hcHBlZCA9IGZhbHNlOwo+
Cj4gICAgICAgICB2cS0+aW5kaXJlY3QgPSB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElP
X1JJTkdfRl9JTkRJUkVDVF9ERVNDKSAmJgo+ICAgICAgICAgICAgICAgICAhY29udGV4dDsKPiBA
QCAtMjU0OCw2ICsyNTUyLDcgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3
X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gICNlbmRpZgo+ICAgICAgICAgdnEtPmRt
YV9kZXYgPSBkbWFfZGV2Owo+ICAgICAgICAgdnEtPnVzZV9kbWFfYXBpID0gdnJpbmdfdXNlX2Rt
YV9hcGkodmRldik7Cj4gKyAgICAgICB2cS0+cHJlbWFwcGVkID0gZmFsc2U7Cj4KPiAgICAgICAg
IHZxLT5pbmRpcmVjdCA9IHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fUklOR19GX0lO
RElSRUNUX0RFU0MpICYmCj4gICAgICAgICAgICAgICAgICFjb250ZXh0Owo+IEBAIC0yNjkxLDYg
KzI2OTYsNDEgQEAgaW50IHZpcnRxdWV1ZV9yZXNpemUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLCB1
MzIgbnVtLAo+ICB9Cj4gIEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9yZXNpemUpOwo+Cj4g
Ky8qKgo+ICsgKiB2aXJ0cXVldWVfc2V0X3ByZW1hcHBlZCAtIHNldCB0aGUgdnJpbmcgcHJlbWFw
cGVkIG1vZGUKPiArICogQF92cTogdGhlIHN0cnVjdCB2aXJ0cXVldWUgd2UncmUgdGFsa2luZyBh
Ym91dC4KPiArICoKPiArICogRW5hYmxlIHRoZSBwcmVtYXBwZWQgbW9kZSBvZiB0aGUgdnEuCj4g
KyAqCj4gKyAqIFRoZSB2cmluZyBpbiBwcmVtYXBwZWQgbW9kZSBkb2VzIG5vdCBkbyBkbWEgaW50
ZXJuYWxseSwgc28gdGhlIGRyaXZlciBtdXN0Cj4gKyAqIGRvIGRtYSBtYXBwaW5nIGluIGFkdmFu
Y2UuIFRoZSBkcml2ZXIgbXVzdCBwYXNzIHRoZSBkbWFfYWRkcmVzcyB0aHJvdWdoCj4gKyAqIGRt
YV9hZGRyZXNzIG9mIHNjYXR0ZXJsaXN0LiBXaGVuIHRoZSBkcml2ZXIgZ290IGEgdXNlZCBidWZm
ZXIgZnJvbQo+ICsgKiB0aGUgdnJpbmcsIGl0IGhhcyB0byB1bm1hcCB0aGUgZG1hIGFkZHJlc3Mu
IFNvIHRoZSBkcml2ZXIgbXVzdCBjYWxsCj4gKyAqIHZpcnRxdWV1ZV9nZXRfYnVmX3ByZW1hcHBl
ZCgpL3ZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1Zl9wcmVtYXBwZWQoKS4KPiArICoKPiArICog
VGhpcyBtdXN0IGJlIGNhbGxlZCBiZWZvcmUgYWRkaW5nIGFueSBidWYgdG8gdnJpbmcuCgpBbmQg
YW55IG9sZCBidWZmZXIgc2hvdWxkIGJlIGRldGFjaGVkPwoKPiArICogU28gdGhpcyBzaG91bGQg
YmUgY2FsbGVkIGltbWVkaWF0ZWx5IGFmdGVyIGluaXQgdnEgb3IgdnEgcmVzZXQuCgpBbnkgd2F5
IHRvIGRldGVjdCBhbmQgd2FybiBpbiB0aGlzIGNhc2U/IChub3QgYSBtdXN0IGlmIGl0J3MgdG9v
CmV4cGVuc2l2ZSB0byBkbyB0aGUgY2hlY2spCgo+ICsgKgo+ICsgKiBDYWxsZXIgbXVzdCBlbnN1
cmUgd2UgZG9uJ3QgY2FsbCB0aGlzIHdpdGggb3RoZXIgdmlydHF1ZXVlIG9wZXJhdGlvbnMKPiAr
ICogYXQgdGhlIHNhbWUgdGltZSAoZXhjZXB0IHdoZXJlIG5vdGVkKS4KPiArICoKPiArICogUmV0
dXJucyB6ZXJvIG9yIGEgbmVnYXRpdmUgZXJyb3IuCj4gKyAqIDA6IHN1Y2Nlc3MuCj4gKyAqIC1F
SU5WQUw6IHZyaW5nIGRvZXMgbm90IHVzZSB0aGUgZG1hIGFwaSwgc28gd2UgY2FuIG5vdCBlbmFi
bGUgcHJlbWFwcGVkIG1vZGUuCj4gKyAqLwo+ICtpbnQgdmlydHF1ZXVlX3NldF9wcmVtYXBwZWQo
c3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+ICt7Cj4gKyAgICAgICBzdHJ1Y3QgdnJpbmdfdmlydHF1
ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ICsKPiArICAgICAgIGlmICghdnEtPnVzZV9kbWFfYXBp
KQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiArCj4gKyAgICAgICB2cS0+cHJl
bWFwcGVkID0gdHJ1ZTsKCkkgZ3Vlc3MgdGhlcmUgc2hvdWxkIGJlIGEgd2F5IHRvIGRpc2FibGUg
aXQuIFdvdWxkIGl0IGJlIHVzZWZ1bCBmb3IKdGhlIGNhc2Ugd2hlbiBBRl9YRFAgc29ja2V0cyB3
ZXJlIGRlc3Ryb3llZD8KClRoYW5rcwoKCj4gKwo+ICsgICAgICAgcmV0dXJuIDA7Cj4gK30KPiAr
RVhQT1JUX1NZTUJPTF9HUEwodmlydHF1ZXVlX3NldF9wcmVtYXBwZWQpOwo+ICsKPiAgLyogT25s
eSBhdmFpbGFibGUgZm9yIHNwbGl0IHJpbmcgKi8KPiAgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdf
bmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgbnVtLAo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+IGluZGV4IGI5MzIzOGRi
OTRlMy4uMWZjMGUxMDIzYmQ0IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvLmgK
PiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gQEAgLTc4LDYgKzc4LDggQEAgYm9vbCB2
aXJ0cXVldWVfZW5hYmxlX2NiKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPgo+ICB1bnNpZ25lZCB2
aXJ0cXVldWVfZW5hYmxlX2NiX3ByZXBhcmUoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+Cj4gK2lu
dCB2aXJ0cXVldWVfc2V0X3ByZW1hcHBlZChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpOwo+ICsKPiAg
Ym9vbCB2aXJ0cXVldWVfcG9sbChzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdW5zaWduZWQpOwo+Cj4g
IGJvb2wgdmlydHF1ZXVlX2VuYWJsZV9jYl9kZWxheWVkKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsK
PiAtLQo+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
