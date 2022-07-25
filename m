Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD78FC433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Jul 2022 07:29:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D6C26105B;
	Mon, 25 Jul 2022 07:29:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D6C26105B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UuhvzleC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eMKshx02YTk3; Mon, 25 Jul 2022 07:29:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D1F3B61063;
	Mon, 25 Jul 2022 07:29:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1F3B61063
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C411C0033;
	Mon, 25 Jul 2022 07:29:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 097AAC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 07:29:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D02414185A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 07:29:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D02414185A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UuhvzleC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id on85ZjJ2speJ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 07:29:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 73A7A417D3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73A7A417D3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 07:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658734150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7V73Urf85bEAl0pJImVws1FSD2o2Nh9wuLCajEhv1dQ=;
 b=UuhvzleC7C3ZwDyuYvwUb9V7eyomBOsXr1mDMqFp8kk/KFG6dxtHz+vmvotfa/Mt+Ob0ku
 2KefS7nicYLQXzKoF6Cl368vhyH5IxMWSlxqMtxh+0lDtC6KrXZ78EHFmfBUbe2j5NR+3S
 03xqqwdjI89HNx4FzVyQ9dV07zAFLXQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-y2c1TT6yPgysVg4jPpnWHw-1; Mon, 25 Jul 2022 03:29:09 -0400
X-MC-Unique: y2c1TT6yPgysVg4jPpnWHw-1
Received: by mail-lf1-f71.google.com with SMTP id
 k25-20020a195619000000b00489e6a6527eso3207924lfb.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 00:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7V73Urf85bEAl0pJImVws1FSD2o2Nh9wuLCajEhv1dQ=;
 b=UcO4sBGCM7UH/pGJCL40kaK/KBdLi5MS54mPfTpz9pUj9sQ3G/UQLKyXCywWgJVmFw
 +mEfBcEuYsQuTVl+HG3QtKL1sCNY2AidJwOhD2hKaobTEIVbZYqSouINnOiEL+1FV26s
 7UGqR+6pxbbK/3OVaeS++qNa3erY47skvXsVuLnE3AY8BREc1f12S6piVpkv+pFM/8fO
 SPXtLwYqQT4VAAdbhDVB5H+VlH3bAuoy1uf6fYxgK2t3DsUJj9+loZjHrRk654gQxOrJ
 XRxWR4U+Df4f5U6XyTshM8UpKlvxK1T0avT/3H1UVNVh/sCp/lDkjXlY1J3+RW4BzvDX
 6Rww==
X-Gm-Message-State: AJIora8ods6R5PCOoq1GgiWKrRDgW+bjwPnG3RHYx2t5wEOBqhJm4MaE
 1zTKhqLErgbaCj6p5NbmjM/88cruB3Cl1SmFTN7aT3qZVE+NJsT8lHHnW7CqipXLFWIBDws/3dg
 W1opM6VsOS+ftmmKzUsrmkdgMj1j15BFncsdsH2rNio3hy1PVgNm8AqminQ==
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr3893769lfa.124.1658734147157; 
 Mon, 25 Jul 2022 00:29:07 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vSilpMwka+2TIjWzkO9OCXsrSScPIWOm9X8cfPvK1yqV+F7/YxylSd832Ayyg4Jn4Euf9+iYQrDan3aN009eg=
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr3893759lfa.124.1658734146714; Mon, 25
 Jul 2022 00:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-39-xuanzhuo@linux.alibaba.com>
 <726a5056-789a-b445-a2c6-879008ad270a@redhat.com>
 <1658731116.1695666-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvsAyR5uRprobv-bQYPOKKOM4sZzQ-Vw5ZiETMjiCkdRQ@mail.gmail.com>
 <1658733700.3892667-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1658733700.3892667-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Jul 2022 15:28:55 +0800
Message-ID: <CACGkMEvsS_QVbq3iCG8hvHuKrp9ObTy3jPUn75zPk-bSHd7tzA@mail.gmail.com>
Subject: Re: [PATCH v12 38/40] virtio_net: support rx queue resize
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
 Vasily Gorbik <gor@linux.ibm.com>, Kangjie Xu <kangjie.xu@linux.alibaba.com>,
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

T24gTW9uLCBKdWwgMjUsIDIwMjIgYXQgMzoyMyBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgMjUgSnVsIDIwMjIgMTQ6NTc6MTEgKzA4
MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gT24gTW9uLCBK
dWwgMjUsIDIwMjIgYXQgMjo0MyBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEu
Y29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gVGh1LCAyMSBKdWwgMjAyMiAxNzoyNTo1OSArMDgw
MCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4g
PiDlnKggMjAyMi83LzIwIDExOjA0LCBYdWFuIFpodW8g5YaZ6YGTOgo+ID4gPiA+ID4gVGhpcyBw
YXRjaCBpbXBsZW1lbnRzIHRoZSByZXNpemUgZnVuY3Rpb24gb2YgdGhlIHJ4IHF1ZXVlcy4KPiA+
ID4gPiA+IEJhc2VkIG9uIHRoaXMgZnVuY3Rpb24sIGl0IGlzIHBvc3NpYmxlIHRvIG1vZGlmeSB0
aGUgcmluZyBudW0gb2YgdGhlCj4gPiA+ID4gPiBxdWV1ZS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4g
PiA+ID4gLS0tCj4gPiA+ID4gPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDIyICsrKysr
KysrKysrKysrKysrKysrKysKPiA+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlv
bnMoKykKPiA+ID4gPiA+Cj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gPiBpbmRleCBmZTRkYzQz
YzA1YTEuLjExMTVhOGI1OWEwOCAxMDA2NDQKPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+
ID4gPiBAQCAtMjc4LDYgKzI3OCw4IEBAIHN0cnVjdCBwYWRkZWRfdm5ldF9oZHIgewo+ID4gPiA+
ID4gICAgIGNoYXIgcGFkZGluZ1sxMl07Cj4gPiA+ID4gPiAgIH07Cj4gPiA+ID4gPgo+ID4gPiA+
ID4gK3N0YXRpYyB2b2lkIHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKHN0cnVjdCB2aXJ0cXVl
dWUgKnZxLCB2b2lkICpidWYpOwo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gICBzdGF0aWMgYm9vbCBp
c194ZHBfZnJhbWUodm9pZCAqcHRyKQo+ID4gPiA+ID4gICB7Cj4gPiA+ID4gPiAgICAgcmV0dXJu
ICh1bnNpZ25lZCBsb25nKXB0ciAmIFZJUlRJT19YRFBfRkxBRzsKPiA+ID4gPiA+IEBAIC0xODQ2
LDYgKzE4NDgsMjYgQEAgc3RhdGljIG5ldGRldl90eF90IHN0YXJ0X3htaXQoc3RydWN0IHNrX2J1
ZmYgKnNrYiwgc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ID4gPiA+ICAgICByZXR1cm4gTkVU
REVWX1RYX09LOwo+ID4gPiA+ID4gICB9Cj4gPiA+ID4gPgo+ID4gPiA+ID4gK3N0YXRpYyBpbnQg
dmlydG5ldF9yeF9yZXNpemUoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxLCB1MzIgcmluZ19u
dW0pCj4gPiA+ID4gPiArewo+ID4gPiA+ID4gKyAgIGludCBlcnIsIHFpbmRleDsKPiA+ID4gPiA+
ICsKPiA+ID4gPiA+ICsgICBxaW5kZXggPSBycSAtIHZpLT5ycTsKPiA+ID4gPiA+ICsKPiA+ID4g
PiA+ICsgICBuYXBpX2Rpc2FibGUoJnJxLT5uYXBpKTsKPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4g
V2UgbmVlZCB0byBkaXNhYmxlIHJlZmlsbCB3b3JrIGFzIHdlbGwuIFNvIHRoaXMgc2VyaWVzIG1p
Z2h0IG5lZWQKPiA+ID4gPiByZWJhc2luZyBvbiB0b3Agb2YKPiA+ID4gPgo+ID4gPiA+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDIyMDcwNDA3NDg1OS4xNjkxMi0xLWphc293YW5n
QHJlZGhhdC5jb20vCj4gPiA+Cj4gPiA+IEkgdW5kZXJzdGFuZCB0aGF0IHlvdXIgcGF0Y2ggaXMg
dXNlZCB0byBzb2x2ZSB0aGUgc2l0dWF0aW9uIHdoZXJlIGRldiBpcwo+ID4gPiBkZXN0b3J5ZWQg
YnV0IHJlZmlsbCB3b3JrIGlzIHJ1bm5pbmcuCj4gPiA+Cj4gPiA+IEFuZCBpcyB0aGVyZSBzdWNo
IGEgcG9zc2liaWxpdHkgaGVyZT8KPiA+Cj4gPiBFLmcgdGhlIHJlZmlsbCB3b3JrIHJ1bnMgaW4g
cGFyYWxsZWwgd2l0aCB0aGlzIGZ1bmN0aW9uPwo+Cj4gbmFwaV9kaXNhYmxlIGVuYWJsZXMgbG9j
ay1saWtlIGZ1bmN0aW9uYWxpdHkuIFNvIEkgdGhpbmsgaXQncyBzYWZlLgo+CgpPaywgcmlnaHQs
IHNpbmNlIHRoZXJlIHdpbGwgYmUgYSBuYXBpX2VuYWJsZSgpIHNvb24gYWZ0ZXJ3YXJkcy4KClNv
CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPiBU
aGFua3MuCj4KPiA+Cj4gPiBUaGFua3MKPiA+Cj4gPiA+IE9yIGlzIHRoZXJlIGFueSBvdGhlciBz
Y2VuYXJpbyB0aGF0IEknbQo+ID4gPiBub3QgZXhwZWN0aW5nPwo+ID4gPgo+ID4gPiBUaGFua3Mu
Cj4gPiA+Cj4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBJIHdpbGwgc2VuZCBhIG5ldyB2ZXJzaW9uIChw
cm9iYWJseSB0b21vcnJvdykuCj4gPiA+ID4KPiA+ID4gPiBUaGFua3MKPiA+ID4gPgo+ID4gPiA+
Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiArICAgZXJyID0gdmlydHF1ZXVlX3Jlc2l6ZShycS0+dnEs
IHJpbmdfbnVtLCB2aXJ0bmV0X3JxX2ZyZWVfdW51c2VkX2J1Zik7Cj4gPiA+ID4gPiArICAgaWYg
KGVycikKPiA+ID4gPiA+ICsgICAgICAgICAgIG5ldGRldl9lcnIodmktPmRldiwgInJlc2l6ZSBy
eCBmYWlsOiByeCBxdWV1ZSBpbmRleDogJWQgZXJyOiAlZFxuIiwgcWluZGV4LCBlcnIpOwo+ID4g
PiA+ID4gKwo+ID4gPiA+ID4gKyAgIGlmICghdHJ5X2ZpbGxfcmVjdih2aSwgcnEsIEdGUF9LRVJO
RUwpKQo+ID4gPiA+ID4gKyAgICAgICAgICAgc2NoZWR1bGVfZGVsYXllZF93b3JrKCZ2aS0+cmVm
aWxsLCAwKTsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICsgICB2aXJ0bmV0X25hcGlfZW5hYmxlKHJx
LT52cSwgJnJxLT5uYXBpKTsKPiA+ID4gPiA+ICsgICByZXR1cm4gZXJyOwo+ID4gPiA+ID4gK30K
PiA+ID4gPiA+ICsKPiA+ID4gPiA+ICAgLyoKPiA+ID4gPiA+ICAgICogU2VuZCBjb21tYW5kIHZp
YSB0aGUgY29udHJvbCB2aXJ0cXVldWUgYW5kIGNoZWNrIHN0YXR1cy4gIENvbW1hbmRzCj4gPiA+
ID4gPiAgICAqIHN1cHBvcnRlZCBieSB0aGUgaHlwZXJ2aXNvciwgYXMgaW5kaWNhdGVkIGJ5IGZl
YXR1cmUgYml0cywgc2hvdWxkCj4gPiA+ID4KPiA+ID4KPiA+Cj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
