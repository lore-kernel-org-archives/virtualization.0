Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ABFC3F6B0
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 02:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6395141504;
	Thu, 28 Jul 2022 02:39:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6395141504
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TD1Y7yp6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mJc93ga46Dcs; Thu, 28 Jul 2022 02:39:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 260F8409BB;
	Thu, 28 Jul 2022 02:39:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 260F8409BB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6FF0C0033;
	Thu, 28 Jul 2022 02:39:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F03EAC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 02:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B6F7B81D47
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 02:39:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B6F7B81D47
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TD1Y7yp6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 67ElohTkQtRd
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 02:39:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB2AA81D02
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB2AA81D02
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 02:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658975945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ymtTMNSBtFOhhmPgtQl8t8lfFLbeHZYYSYD2cD7gjw=;
 b=TD1Y7yp6SCyT5z7CfU/EbKhv2qvWsuIig3NRr5kU4Ng1gSj3nwUMNWLyBXB7k8eqKHutW8
 S9gvwO2OQ7UuZ50peSqboT3VYIcpH9Dyx9p6dNOqHNormHLI3lvymQtb92EkiJoEfbZosG
 Xzp+utBxDG4swmjbWP4w5hhcGy4VD2g=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-l-ZL4oRBNSmg5IQERX9w-w-1; Wed, 27 Jul 2022 22:39:04 -0400
X-MC-Unique: l-ZL4oRBNSmg5IQERX9w-w-1
Received: by mail-lf1-f70.google.com with SMTP id
 k7-20020a05651239c700b0048a9f539070so222893lfu.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 19:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5ymtTMNSBtFOhhmPgtQl8t8lfFLbeHZYYSYD2cD7gjw=;
 b=qB+zq88Sh2Oa+4UHG0CYdJkGIH4FFnmG+nxMRmcZLK6c005kjPNdN2E/BWZLgoTYLA
 1vhH/RUjzB98X5VGyTfEAAAqix5ljqO5XT1idahRSjCSYmpjAbsRDKA7v+dWODuGGFO/
 MN5HP0ZI+O0tyXU+MLEJx89MF6tQQxojFNhQucOKxm0aP3yj0ILdwt61/16i5eOGSzd1
 T6wvzOOfpmUwW2AlNnoj3jfDk1pSczfshJjhqZO9/5XhtqulCZqumlO4/48fY3AXWDDW
 OaLMLQENtHqusu6mI6trbsSXFD5qz9Cc4itkZs2dhjJMB63VDJKuOBiAatFbdRWAjZMQ
 kKIQ==
X-Gm-Message-State: AJIora+cLu9vmZsoKeeZhQ63CxXtIexgV49F/AATrz3QVDBaZNlGUZq2
 ks7z7pfNoR9f5k0bNzu3e3jYSPdUUwfwo3kXHNrbkj8axkC4rC9QYd90ge81mAf83AooRxSUyQC
 avtrodbeZTib9UpXF1pA4zcoAkhLWySn5pKkIlaBwjRuLE929vMPaUlPmvA==
X-Received: by 2002:a05:651c:2103:b0:25d:6478:2a57 with SMTP id
 a3-20020a05651c210300b0025d64782a57mr8391221ljq.496.1658975943130; 
 Wed, 27 Jul 2022 19:39:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uHdGB5CGdI+a5RxWiQio7u+TOL7GEOspu6vejhdOqf5wuC1xMtb49c5PXiFMMNBwahHTh2HSqnjfW+BjjqQXo=
X-Received: by 2002:a05:651c:2103:b0:25d:6478:2a57 with SMTP id
 a3-20020a05651c210300b0025d64782a57mr8391199ljq.496.1658975942872; Wed, 27
 Jul 2022 19:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-17-xuanzhuo@linux.alibaba.com>
 <15aa26f2-f8af-5dbd-f2b2-9270ad873412@redhat.com>
 <1658907413.1860468-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1658907413.1860468-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Jul 2022 10:38:51 +0800
Message-ID: <CACGkMEvxsOfiiaWWAR8P68GY1yfwgTvaAbHk1JF7pTw-o2k25w@mail.gmail.com>
Subject: Re: [PATCH v13 16/42] virtio_ring: split: introduce
 virtqueue_resize_split()
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

T24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMzo0NCBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgMjcgSnVsIDIwMjIgMTE6MTI6MTkgKzA4
MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IOWcqCAy
MDIyLzcvMjYgMTU6MjEsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPiA+IHZpcnRpbyByaW5nIHNwbGl0
IHN1cHBvcnRzIHJlc2l6ZS4KPiA+ID4KPiA+ID4gT25seSBhZnRlciB0aGUgbmV3IHZyaW5nIGlz
IHN1Y2Nlc3NmdWxseSBhbGxvY2F0ZWQgYmFzZWQgb24gdGhlIG5ldyBudW0sCj4gPiA+IHdlIHdp
bGwgcmVsZWFzZSB0aGUgb2xkIHZyaW5nLiBJbiBhbnkgY2FzZSwgYW4gZXJyb3IgaXMgcmV0dXJu
ZWQsCj4gPiA+IGluZGljYXRpbmcgdGhhdCB0aGUgdnJpbmcgc3RpbGwgcG9pbnRzIHRvIHRoZSBv
bGQgdnJpbmcuCj4gPiA+Cj4gPiA+IEluIHRoZSBjYXNlIG9mIGFuIGVycm9yLCByZS1pbml0aWFs
aXplKHZpcnRxdWV1ZV9yZWluaXRfc3BsaXQoKSkgdGhlCj4gPiA+IHZpcnRxdWV1ZSB0byBlbnN1
cmUgdGhhdCB0aGUgdnJpbmcgY2FuIGJlIHVzZWQuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6
IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+IEFja2VkLWJ5OiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiAtLS0KPiA+ID4gICBkcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspCj4gPiA+Cj4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYwo+ID4gPiBpbmRleCBiNmZkYTkxYzgwNTkuLjU4MzU1ZTFhYzdkNyAx
MDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiArKysg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+IEBAIC0yMjAsNiArMjIwLDcgQEAg
c3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBp
bnQgaW5kZXgsCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB2b2lkICgqY2FsbGJhY2spKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpuYW1lKTsKPiA+ID4g
ICBzdGF0aWMgc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKnZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEo
dW5zaWduZWQgaW50IG51bSk7Cj4gPiA+ICtzdGF0aWMgdm9pZCB2cmluZ19mcmVlKHN0cnVjdCB2
aXJ0cXVldWUgKl92cSk7Cj4gPiA+Cj4gPiA+ICAgLyoKPiA+ID4gICAgKiBIZWxwZXJzLgo+ID4g
PiBAQCAtMTExNyw2ICsxMTE4LDM5IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19j
cmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+ID4gPiAgICAgcmV0dXJuIHZxOwo+ID4gPiAgIH0KPiA+
ID4KPiA+ID4gK3N0YXRpYyBpbnQgdmlydHF1ZXVlX3Jlc2l6ZV9zcGxpdChzdHJ1Y3QgdmlydHF1
ZXVlICpfdnEsIHUzMiBudW0pCj4gPiA+ICt7Cj4gPiA+ICsgICBzdHJ1Y3QgdnJpbmdfdmlydHF1
ZXVlX3NwbGl0IHZyaW5nX3NwbGl0ID0ge307Cj4gPiA+ICsgICBzdHJ1Y3QgdnJpbmdfdmlydHF1
ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ID4gPiArICAgc3RydWN0IHZpcnRpb19kZXZpY2UgKnZk
ZXYgPSBfdnEtPnZkZXY7Cj4gPiA+ICsgICBpbnQgZXJyOwo+ID4gPiArCj4gPiA+ICsgICBlcnIg
PSB2cmluZ19hbGxvY19xdWV1ZV9zcGxpdCgmdnJpbmdfc3BsaXQsIHZkZXYsIG51bSwKPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZxLT5zcGxpdC52cmluZ19hbGlnbiwK
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZxLT5zcGxpdC5tYXlfcmVk
dWNlX251bSk7Cj4gPiA+ICsgICBpZiAoZXJyKQo+ID4gPiArICAgICAgICAgICBnb3RvIGVycjsK
PiA+Cj4gPgo+ID4gSSB0aGluayB3ZSBkb24ndCBuZWVkIHRvIGRvIGFueXRoaW5nIGhlcmU/Cj4K
PiBBbSBJIG1pc3Npbmcgc29tZXRoaW5nPwoKSSBtZWFudCBpdCBsb29rcyB0byBtZSBtb3N0IG9m
IHRoZSB2aXJ0cXVldWVfcmVpbml0KCkgaXMgdW5uZWNlc3NhcnkuCldlIHByb2JhYmx5IG9ubHkg
bmVlZCB0byByZWluaXQgYXZhaWwvdXNlZCBpZHggdGhlcmUuCgpUaGFua3MKCj4KPiA+Cj4gPgo+
ID4gPiArCj4gPiA+ICsgICBlcnIgPSB2cmluZ19hbGxvY19zdGF0ZV9leHRyYV9zcGxpdCgmdnJp
bmdfc3BsaXQpOwo+ID4gPiArICAgaWYgKGVycikgewo+ID4gPiArICAgICAgICAgICB2cmluZ19m
cmVlX3NwbGl0KCZ2cmluZ19zcGxpdCwgdmRldik7Cj4gPiA+ICsgICAgICAgICAgIGdvdG8gZXJy
Owo+ID4KPiA+Cj4gPiBJIHN1Z2dlc3QgdG8gbW92ZSB2cmluZ19mcmVlX3NwbGl0KCkgaW50byBh
IGRlZGljYXRlZCBlcnJvciBsYWJlbC4KPgo+IFdpbGwgY2hhbmdlLgo+Cj4gVGhhbmtzLgo+Cj4K
PiA+Cj4gPiBUaGFua3MKPiA+Cj4gPgo+ID4gPiArICAgfQo+ID4gPiArCj4gPiA+ICsgICB2cmlu
Z19mcmVlKCZ2cS0+dnEpOwo+ID4gPiArCj4gPiA+ICsgICB2aXJ0cXVldWVfdnJpbmdfaW5pdF9z
cGxpdCgmdnJpbmdfc3BsaXQsIHZxKTsKPiA+ID4gKwo+ID4gPiArICAgdmlydHF1ZXVlX2luaXQo
dnEsIHZyaW5nX3NwbGl0LnZyaW5nLm51bSk7Cj4gPiA+ICsgICB2aXJ0cXVldWVfdnJpbmdfYXR0
YWNoX3NwbGl0KHZxLCAmdnJpbmdfc3BsaXQpOwo+ID4gPiArCj4gPiA+ICsgICByZXR1cm4gMDsK
PiA+ID4gKwo+ID4gPiArZXJyOgo+ID4gPiArICAgdmlydHF1ZXVlX3JlaW5pdF9zcGxpdCh2cSk7
Cj4gPiA+ICsgICByZXR1cm4gLUVOT01FTTsKPiA+ID4gK30KPiA+ID4gKwo+ID4gPgo+ID4gPiAg
IC8qCj4gPiA+ICAgICogUGFja2VkIHJpbmcgc3BlY2lmaWMgZnVuY3Rpb25zIC0gKl9wYWNrZWQo
KS4KPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
