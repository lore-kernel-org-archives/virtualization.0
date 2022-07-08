Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554DDC433EF
	for <virtualization@archiver.kernel.org>; Fri,  8 Jul 2022 06:24:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D477B8467C;
	Fri,  8 Jul 2022 06:24:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D477B8467C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EZ/PqXIZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9e7NbfWNNNod; Fri,  8 Jul 2022 06:24:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 577B08407A;
	Fri,  8 Jul 2022 06:24:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 577B08407A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D731C0033;
	Fri,  8 Jul 2022 06:24:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0A0CC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 06:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA23C42415
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 06:24:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CA23C42415
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EZ/PqXIZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mMb_UwClQCy4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 06:24:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A90B542414
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A90B542414
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 06:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657261456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MuCsAQqcP9jRhnofNGlkag+3lFIM4NlF43nORVr9O9Q=;
 b=EZ/PqXIZz+3sV8DbfQXi0QY1szkvg/nhKbIT4RSv4Mb7ad5KXacg6rOoIET0OX4l6stw0Z
 BHmU8D5Zw0cdIm1iAfstGPBN8e/hRt/cdKA+ksbuL5GKkGaYvZgsrgAW1xFTrWpDmTPUna
 y+/Vn06ztiZnAZbnorO1WlMKB/HUY9o=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-qmtmxaSLPJmsnbQHZCnx0g-1; Fri, 08 Jul 2022 02:24:10 -0400
X-MC-Unique: qmtmxaSLPJmsnbQHZCnx0g-1
Received: by mail-lf1-f71.google.com with SMTP id
 j12-20020a056512028c00b00482dd0d9748so4331034lfp.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 07 Jul 2022 23:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MuCsAQqcP9jRhnofNGlkag+3lFIM4NlF43nORVr9O9Q=;
 b=11za63rUBGz0QV1Qcuf2anPxYpy4zNGukmNVmpcoeKyAAoFJppvD2aGGTY260ry8+b
 i8LjiaDj04vmvhWxdX5Z6aTTv+zR0Sx1/Qu3oJHR7AdGeWjTxH4u4FCKD5xa/McC3G63
 AbD2mXL62w/zrDkOSfOImZUkMZN0sRjGGv6JdMX6ofN3o4zsXOcW/wCWEVp0xJ1GlWYK
 lmlFURztTEsnsq+VbmSmGHnslk3NimKnkXttRFVVf+52/cPjgO7UxwkNgaL7vVMfzgL8
 WqQ0L1bpJ4ZC5Rci+doYG+i2t8ZZNeRdwqBhQFuf3ntnRALq7mZ+/C3qRYfyV8cndOAB
 FU/A==
X-Gm-Message-State: AJIora+m825yxNIFGOE3jSKK7oJUYPNLRsoM34345AijWm7UKStgobBx
 idQwNBJH3CrdW5SbqvYSVKcM1GdaokeBzgTGq1grXsvRhtoCVkZ0bO1ZBP9yzmRakORgsnA/q1m
 TZ+WBC5rJYUSRq+JjHxx5Le0wjy9RZTG2Bg3NMjxAOyBtSjo+mvnk+T6QQg==
X-Received: by 2002:a2e:b703:0:b0:25a:93d0:8a57 with SMTP id
 j3-20020a2eb703000000b0025a93d08a57mr1045832ljo.487.1657261448491; 
 Thu, 07 Jul 2022 23:24:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tzPsP1k2g24mQnHNz5CBL+LS/XojwCfoJppvOK3luPVsAL9MMOxyPmQUAGDT4ZWM4iccKWwEJaWyc8djFVrqw=
X-Received: by 2002:a2e:b703:0:b0:25a:93d0:8a57 with SMTP id
 j3-20020a2eb703000000b0025a93d08a57mr1045787ljo.487.1657261448283; Thu, 07
 Jul 2022 23:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-40-xuanzhuo@linux.alibaba.com>
 <102d3b83-1ae9-a59a-16ce-251c22b7afb0@redhat.com>
 <1656986432.1164997-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1656986432.1164997-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Jul 2022 14:23:57 +0800
Message-ID: <CACGkMEt8MSS=tcn=Hd6WF9+btT0ccocxEd1ighRgK-V1uiWmCQ@mail.gmail.com>
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

T24gVHVlLCBKdWwgNSwgMjAyMiBhdCAxMDowMSBBTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgNCBKdWwgMjAyMiAxMTo0NTo1MiArMDgw
MCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4g5ZyoIDIw
MjIvNi8yOSAxNDo1NiwgWHVhbiBaaHVvIOWGmemBkzoKPiA+ID4gVGhpcyBwYXRjaCBpbXBsZW1l
bnRzIHRoZSByZXNpemUgZnVuY3Rpb24gb2YgdGhlIHR4IHF1ZXVlcy4KPiA+ID4gQmFzZWQgb24g
dGhpcyBmdW5jdGlvbiwgaXQgaXMgcG9zc2libGUgdG8gbW9kaWZ5IHRoZSByaW5nIG51bSBvZiB0
aGUKPiA+ID4gcXVldWUuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVh
bnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgIGRyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYyB8IDQ4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysK
PiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKQo+ID4gPgo+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4gPiA+IGluZGV4IDZhYjE2ZmQxOTNlNS4uZmQzNTg0NjJmODAyIDEwMDY0NAo+ID4gPiAt
LS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4gPiA+IEBAIC0xMzUsNiArMTM1LDkgQEAgc3RydWN0IHNlbmRfcXVldWUgewo+
ID4gPiAgICAgc3RydWN0IHZpcnRuZXRfc3Ffc3RhdHMgc3RhdHM7Cj4gPiA+Cj4gPiA+ICAgICBz
dHJ1Y3QgbmFwaV9zdHJ1Y3QgbmFwaTsKPiA+ID4gKwo+ID4gPiArICAgLyogUmVjb3JkIHdoZXRo
ZXIgc3EgaXMgaW4gcmVzZXQgc3RhdGUuICovCj4gPiA+ICsgICBib29sIHJlc2V0Owo+ID4gPiAg
IH07Cj4gPiA+Cj4gPiA+ICAgLyogSW50ZXJuYWwgcmVwcmVzZW50YXRpb24gb2YgYSByZWNlaXZl
IHZpcnRxdWV1ZSAqLwo+ID4gPiBAQCAtMjc5LDYgKzI4Miw3IEBAIHN0cnVjdCBwYWRkZWRfdm5l
dF9oZHIgewo+ID4gPiAgIH07Cj4gPiA+Cj4gPiA+ICAgc3RhdGljIHZvaWQgdmlydG5ldF9ycV9m
cmVlX3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1Zik7Cj4gPiA+ICtz
dGF0aWMgdm9pZCB2aXJ0bmV0X3NxX2ZyZWVfdW51c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVlICp2
cSwgdm9pZCAqYnVmKTsKPiA+ID4KPiA+ID4gICBzdGF0aWMgYm9vbCBpc194ZHBfZnJhbWUodm9p
ZCAqcHRyKQo+ID4gPiAgIHsKPiA+ID4gQEAgLTE2MDMsNiArMTYwNywxMSBAQCBzdGF0aWMgdm9p
ZCB2aXJ0bmV0X3BvbGxfY2xlYW50eChzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEpCj4gPiA+ICAg
ICAgICAgICAgIHJldHVybjsKPiA+ID4KPiA+ID4gICAgIGlmIChfX25ldGlmX3R4X3RyeWxvY2so
dHhxKSkgewo+ID4gPiArICAgICAgICAgICBpZiAoUkVBRF9PTkNFKHNxLT5yZXNldCkpIHsKPiA+
ID4gKyAgICAgICAgICAgICAgICAgICBfX25ldGlmX3R4X3VubG9jayh0eHEpOwo+ID4gPiArICAg
ICAgICAgICAgICAgICAgIHJldHVybjsKPiA+ID4gKyAgICAgICAgICAgfQo+ID4gPiArCj4gPiA+
ICAgICAgICAgICAgIGRvIHsKPiA+ID4gICAgICAgICAgICAgICAgICAgICB2aXJ0cXVldWVfZGlz
YWJsZV9jYihzcS0+dnEpOwo+ID4gPiAgICAgICAgICAgICAgICAgICAgIGZyZWVfb2xkX3htaXRf
c2ticyhzcSwgdHJ1ZSk7Cj4gPiA+IEBAIC0xODY4LDYgKzE4NzcsNDUgQEAgc3RhdGljIGludCB2
aXJ0bmV0X3J4X3Jlc2l6ZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiA+ID4gICAgIHJldHVy
biBlcnI7Cj4gPiA+ICAgfQo+ID4gPgo+ID4gPiArc3RhdGljIGludCB2aXJ0bmV0X3R4X3Jlc2l6
ZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCBzZW5kX3F1ZXVlICpzcSwgdTMyIHJpbmdfbnVtKQo+ID4gPiArewo+ID4gPiArICAg
c3RydWN0IG5ldGRldl9xdWV1ZSAqdHhxOwo+ID4gPiArICAgaW50IGVyciwgcWluZGV4Owo+ID4g
PiArCj4gPiA+ICsgICBxaW5kZXggPSBzcSAtIHZpLT5zcTsKPiA+ID4gKwo+ID4gPiArICAgdmly
dG5ldF9uYXBpX3R4X2Rpc2FibGUoJnNxLT5uYXBpKTsKPiA+ID4gKwo+ID4gPiArICAgdHhxID0g
bmV0ZGV2X2dldF90eF9xdWV1ZSh2aS0+ZGV2LCBxaW5kZXgpOwo+ID4gPiArCj4gPiA+ICsgICAv
KiAxLiB3YWl0IGFsbCB4aW10IGNvbXBsZXRlCj4gPiA+ICsgICAgKiAyLiBmaXggdGhlIHJhY2Ug
b2YgbmV0aWZfc3RvcF9zdWJxdWV1ZSgpIHZzIG5ldGlmX3N0YXJ0X3N1YnF1ZXVlKCkKPiA+ID4g
KyAgICAqLwo+ID4gPiArICAgX19uZXRpZl90eF9sb2NrX2JoKHR4cSk7Cj4gPiA+ICsKPiA+ID4g
KyAgIC8qIFByZXZlbnQgcnggcG9sbCBmcm9tIGFjY2Vzc2luZyBzcS4gKi8KPiA+ID4gKyAgIFdS
SVRFX09OQ0Uoc3EtPnJlc2V0LCB0cnVlKTsKPiA+Cj4gPgo+ID4gQ2FuIHdlIHNpbXBseSBkaXNh
YmxlIFJYIE5BUEkgaGVyZT8KPgo+IERpc2FibGUgcnggbmFwaSBpcyBpbmRlZWQgYSBzaW1wbGUg
c29sdXRpb24uIEJ1dCBJIGhvcGUgdGhhdCB3aGVuIGRlYWxpbmcgd2l0aAo+IHR4LCBpdCB3aWxs
IG5vdCBhZmZlY3QgcnguCgpPaywgYnV0IEkgdGhpbmsgd2UndmUgYWxyZWFkeSBzeW5jaHJvbml6
ZWQgd2l0aCB0eCBsb2NrIGhlcmUsIGlzbid0IGl0PwoKVGhhbmtzCgo+Cj4gVGhhbmtzLgo+Cj4K
PiA+Cj4gPiBUaGFua3MKPiA+Cj4gPgo+ID4gPiArCj4gPiA+ICsgICAvKiBQcmV2ZW50IHRoZSB1
cHBlciBsYXllciBmcm9tIHRyeWluZyB0byBzZW5kIHBhY2tldHMuICovCj4gPiA+ICsgICBuZXRp
Zl9zdG9wX3N1YnF1ZXVlKHZpLT5kZXYsIHFpbmRleCk7Cj4gPiA+ICsKPiA+ID4gKyAgIF9fbmV0
aWZfdHhfdW5sb2NrX2JoKHR4cSk7Cj4gPiA+ICsKPiA+ID4gKyAgIGVyciA9IHZpcnRxdWV1ZV9y
ZXNpemUoc3EtPnZxLCByaW5nX251bSwgdmlydG5ldF9zcV9mcmVlX3VudXNlZF9idWYpOwo+ID4g
PiArICAgaWYgKGVycikKPiA+ID4gKyAgICAgICAgICAgbmV0ZGV2X2Vycih2aS0+ZGV2LCAicmVz
aXplIHR4IGZhaWw6IHR4IHF1ZXVlIGluZGV4OiAlZCBlcnI6ICVkXG4iLCBxaW5kZXgsIGVycik7
Cj4gPiA+ICsKPiA+ID4gKyAgIC8qIE1lbW9yeSBiYXJyaWVyIGJlZm9yZSBzZXQgcmVzZXQgYW5k
IHN0YXJ0IHN1YnF1ZXVlLiAqLwo+ID4gPiArICAgc21wX21iKCk7Cj4gPiA+ICsKPiA+ID4gKyAg
IFdSSVRFX09OQ0Uoc3EtPnJlc2V0LCBmYWxzZSk7Cj4gPiA+ICsgICBuZXRpZl90eF93YWtlX3F1
ZXVlKHR4cSk7Cj4gPiA+ICsKPiA+ID4gKyAgIHZpcnRuZXRfbmFwaV90eF9lbmFibGUodmksIHNx
LT52cSwgJnNxLT5uYXBpKTsKPiA+ID4gKyAgIHJldHVybiBlcnI7Cj4gPiA+ICt9Cj4gPiA+ICsK
PiA+ID4gICAvKgo+ID4gPiAgICAqIFNlbmQgY29tbWFuZCB2aWEgdGhlIGNvbnRyb2wgdmlydHF1
ZXVlIGFuZCBjaGVjayBzdGF0dXMuICBDb21tYW5kcwo+ID4gPiAgICAqIHN1cHBvcnRlZCBieSB0
aGUgaHlwZXJ2aXNvciwgYXMgaW5kaWNhdGVkIGJ5IGZlYXR1cmUgYml0cywgc2hvdWxkCj4gPgo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
