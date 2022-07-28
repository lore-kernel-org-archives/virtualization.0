Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D70EC19F2A
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 07:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 003E9401D6;
	Thu, 28 Jul 2022 07:43:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 003E9401D6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eFIIcTPh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hxW5lvkkKnSw; Thu, 28 Jul 2022 07:43:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C64E0401C0;
	Thu, 28 Jul 2022 07:43:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C64E0401C0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89D9EC0033;
	Thu, 28 Jul 2022 07:43:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6977AC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 07:43:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2FEE660AE0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 07:43:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2FEE660AE0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eFIIcTPh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LJ0qY8pBYn_3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 07:43:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3365660671
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3365660671
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 07:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658994184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MiRkDMIa3SaNcNAA4LhevtztHl/rFve9e8RNCF7+zFQ=;
 b=eFIIcTPhqtBqOXdkN8FJu7gTSWotVhGDlBI0DsmaEuQERG/U5ixemzBzKlf9wdltI5334P
 5y0+S1nbso3PrlP27Q9ZaA3d6av2ixSrTH8KI9c11SXy4R9EH73U0lUplXJixexOfEH+is
 M0oj18pfomfXKE2+Wb5HkCpTE8K0zbU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-ZDtbMh6VONSUe71oqVTd3w-1; Thu, 28 Jul 2022 03:43:03 -0400
X-MC-Unique: ZDtbMh6VONSUe71oqVTd3w-1
Received: by mail-lf1-f69.google.com with SMTP id
 9-20020ac25f09000000b0048aae4b6e40so388665lfq.20
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 00:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MiRkDMIa3SaNcNAA4LhevtztHl/rFve9e8RNCF7+zFQ=;
 b=DFXs4sqbs+tSdZtPhn6Z4sD/gymvZ5v1IJyzTAI+UvSuhN34Ff3BIgCnJl7Ds4rbQ6
 rPUch0GC6zE9R697Rc9Dgo6TzZOjM4xeYHviDMwxXL0Sx1CQCLSd4n+Jb9932rOitYt+
 o4etpPMH4KqIAGZCSykfMKZUlJU/1uMXwNPCdaMLGRa+cS9AAD1LbEHGCq5ID8FrjTRJ
 eVdQPfLt7ZK7LeBc5+KRs+nEThgVwA31dOL74ynsL8KCqDaunh/4qlYob4pGkJcSOf/0
 Xp3kR1IeaG43dQgMa2r4uHc0luyjVI37P/4Q6B6apWAlFE94jn6IiXGXrPJO5MenuWOh
 pgug==
X-Gm-Message-State: AJIora+lkZ4f12CCFvVCGhqCAWKQ1RNC+xDZE7J8VBsQaB2+2QYhb/Fd
 chZRVEH+WsMwP88cRigNmKuwHE1euI1WYjG8pqfnLSzY8zu4SExKt/NNps/KGxM+sMS70kl3PuU
 17PAxa0ehDKAIweO7BjiH+3+/C0K4ip0WrQfSIjkKDpZZkkt3jklCO5oWPw==
X-Received: by 2002:a2e:a99e:0:b0:25e:a54:8328 with SMTP id
 x30-20020a2ea99e000000b0025e0a548328mr5494963ljq.141.1658994181679; 
 Thu, 28 Jul 2022 00:43:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u68nBKmGtn3ybA4uLX2AOBJSklXcUMjbmYLhRoC0rjTaSlVKsgAzpWU4s1tY/769/tc0LwTRbMsEcj8iXfSPw=
X-Received: by 2002:a2e:a99e:0:b0:25e:a54:8328 with SMTP id
 x30-20020a2ea99e000000b0025e0a548328mr5494947ljq.141.1658994181424; Thu, 28
 Jul 2022 00:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-17-xuanzhuo@linux.alibaba.com>
 <15aa26f2-f8af-5dbd-f2b2-9270ad873412@redhat.com>
 <1658907413.1860468-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvxsOfiiaWWAR8P68GY1yfwgTvaAbHk1JF7pTw-o2k25w@mail.gmail.com>
 <1658992162.584327-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1658992162.584327-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Jul 2022 15:42:50 +0800
Message-ID: <CACGkMEv-KYieHKXY_Qn0nfcnLMOSF=TowF5PwLKOxESL3KQ40Q@mail.gmail.com>
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

T24gVGh1LCBKdWwgMjgsIDIwMjIgYXQgMzoyNCBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgMjggSnVsIDIwMjIgMTA6Mzg6NTEgKzA4
MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gT24gV2VkLCBK
dWwgMjcsIDIwMjIgYXQgMzo0NCBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEu
Y29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gV2VkLCAyNyBKdWwgMjAyMiAxMToxMjoxOSArMDgw
MCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4g
PiDlnKggMjAyMi83LzI2IDE1OjIxLCBYdWFuIFpodW8g5YaZ6YGTOgo+ID4gPiA+ID4gdmlydGlv
IHJpbmcgc3BsaXQgc3VwcG9ydHMgcmVzaXplLgo+ID4gPiA+ID4KPiA+ID4gPiA+IE9ubHkgYWZ0
ZXIgdGhlIG5ldyB2cmluZyBpcyBzdWNjZXNzZnVsbHkgYWxsb2NhdGVkIGJhc2VkIG9uIHRoZSBu
ZXcgbnVtLAo+ID4gPiA+ID4gd2Ugd2lsbCByZWxlYXNlIHRoZSBvbGQgdnJpbmcuIEluIGFueSBj
YXNlLCBhbiBlcnJvciBpcyByZXR1cm5lZCwKPiA+ID4gPiA+IGluZGljYXRpbmcgdGhhdCB0aGUg
dnJpbmcgc3RpbGwgcG9pbnRzIHRvIHRoZSBvbGQgdnJpbmcuCj4gPiA+ID4gPgo+ID4gPiA+ID4g
SW4gdGhlIGNhc2Ugb2YgYW4gZXJyb3IsIHJlLWluaXRpYWxpemUodmlydHF1ZXVlX3JlaW5pdF9z
cGxpdCgpKSB0aGUKPiA+ID4gPiA+IHZpcnRxdWV1ZSB0byBlbnN1cmUgdGhhdCB0aGUgdnJpbmcg
Y2FuIGJlIHVzZWQuCj4gPiA+ID4gPgo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVv
IDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+ID4gPiA+IEFja2VkLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiAgIGRyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCj4gPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspCj4gPiA+
ID4gPgo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ID4gPiBpbmRleCBiNmZkYTkxYzgw
NTkuLjU4MzU1ZTFhYzdkNyAxMDA2NDQKPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19yaW5nLmMKPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMK
PiA+ID4gPiA+IEBAIC0yMjAsNiArMjIwLDcgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKl9f
dnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gPiA+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAoKmNhbGxiYWNrKShzdHJ1
Y3QgdmlydHF1ZXVlICopLAo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbnN0IGNoYXIgKm5hbWUpOwo+ID4gPiA+ID4gICBzdGF0aWMgc3RydWN0
IHZyaW5nX2Rlc2NfZXh0cmEgKnZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEodW5zaWduZWQgaW50IG51
bSk7Cj4gPiA+ID4gPiArc3RhdGljIHZvaWQgdnJpbmdfZnJlZShzdHJ1Y3QgdmlydHF1ZXVlICpf
dnEpOwo+ID4gPiA+ID4KPiA+ID4gPiA+ICAgLyoKPiA+ID4gPiA+ICAgICogSGVscGVycy4KPiA+
ID4gPiA+IEBAIC0xMTE3LDYgKzExMTgsMzkgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZy
aW5nX2NyZWF0ZV92aXJ0cXVldWVfc3BsaXQoCj4gPiA+ID4gPiAgICAgcmV0dXJuIHZxOwo+ID4g
PiA+ID4gICB9Cj4gPiA+ID4gPgo+ID4gPiA+ID4gK3N0YXRpYyBpbnQgdmlydHF1ZXVlX3Jlc2l6
ZV9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsIHUzMiBudW0pCj4gPiA+ID4gPiArewo+ID4g
PiA+ID4gKyAgIHN0cnVjdCB2cmluZ192aXJ0cXVldWVfc3BsaXQgdnJpbmdfc3BsaXQgPSB7fTsK
PiA+ID4gPiA+ICsgICBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+
ID4gPiA+ID4gKyAgIHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2ID0gX3ZxLT52ZGV2Owo+ID4g
PiA+ID4gKyAgIGludCBlcnI7Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiArICAgZXJyID0gdnJpbmdf
YWxsb2NfcXVldWVfc3BsaXQoJnZyaW5nX3NwbGl0LCB2ZGV2LCBudW0sCj4gPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnEtPnNwbGl0LnZyaW5nX2FsaWduLAo+ID4g
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZxLT5zcGxpdC5tYXlfcmVk
dWNlX251bSk7Cj4gPiA+ID4gPiArICAgaWYgKGVycikKPiA+ID4gPiA+ICsgICAgICAgICAgIGdv
dG8gZXJyOwo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBJIHRoaW5rIHdlIGRvbid0IG5lZWQgdG8g
ZG8gYW55dGhpbmcgaGVyZT8KPiA+ID4KPiA+ID4gQW0gSSBtaXNzaW5nIHNvbWV0aGluZz8KPiA+
Cj4gPiBJIG1lYW50IGl0IGxvb2tzIHRvIG1lIG1vc3Qgb2YgdGhlIHZpcnRxdWV1ZV9yZWluaXQo
KSBpcyB1bm5lY2Vzc2FyeS4KPiA+IFdlIHByb2JhYmx5IG9ubHkgbmVlZCB0byByZWluaXQgYXZh
aWwvdXNlZCBpZHggdGhlcmUuCj4KPgo+IEluIHRoaXMgZnVuY3Rpb24sIHdlIGNhbiBpbmRlZWQg
cmVtb3ZlIHNvbWUgY29kZS4KPgo+ID4gICAgICAgc3RhdGljIHZvaWQgdmlydHF1ZXVlX3JlaW5p
dF9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSkKPiA+ICAgICAgIHsKPiA+ICAgICAg
ICAgICAgICAgaW50IHNpemUsIGk7Cj4gPgo+ID4gICAgICAgICAgICAgICBtZW1zZXQodnEtPnNw
bGl0LnZyaW5nLmRlc2MsIDAsIHZxLT5zcGxpdC5xdWV1ZV9zaXplX2luX2J5dGVzKTsKPiA+Cj4g
PiAgICAgICAgICAgICAgIHNpemUgPSBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfc3Bs
aXQpICogdnEtPnNwbGl0LnZyaW5nLm51bTsKPiA+ICAgICAgICAgICAgICAgbWVtc2V0KHZxLT5z
cGxpdC5kZXNjX3N0YXRlLCAwLCBzaXplKTsKPiA+Cj4gPiAgICAgICAgICAgICAgIHNpemUgPSBz
aXplb2Yoc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEpICogdnEtPnNwbGl0LnZyaW5nLm51bTsKPiA+
ICAgICAgICAgICAgICAgbWVtc2V0KHZxLT5zcGxpdC5kZXNjX2V4dHJhLCAwLCBzaXplKTsKPgo+
IFRoZXNlIG1lbXNldHMgY2FuIGJlIHJlbW92ZWQsIGFuZCB0aGVvcmV0aWNhbGx5IGl0IHdpbGwg
bm90IGNhdXNlIGFueQo+IGV4Y2VwdGlvbnMuCgpZZXMsIG90aGVyd2lzZSB3ZSBoYXZlIGJ1Z3Mg
aW4gZGV0YWNoX2J1ZigpLgoKPgo+ID4KPiA+Cj4gPgo+ID4gICAgICAgICAgICAgICBmb3IgKGkg
PSAwOyBpIDwgdnEtPnNwbGl0LnZyaW5nLm51bSAtIDE7IGkrKykKPiA+ICAgICAgICAgICAgICAg
ICAgICAgICB2cS0+c3BsaXQuZGVzY19leHRyYVtpXS5uZXh0ID0gaSArIDE7Cj4KPiBUaGlzIGNh
biBhbHNvIGJlIHJlbW92ZWQsIGJ1dCB3ZSBuZWVkIHRvIHJlY29yZCBmcmVlX2hlYWQgdGhhdCB3
aWxsIGJlZW4gdXBkYXRlCj4gaW5zaWRlIHZpcnRxdWV1ZV9pbml0KCkuCgpXZSBjYW4gc2ltcGx5
IGtlZXAgZnJlZV9oZWFkIHVuY2hhbmdlZD8gT3RoZXJ3aXNlIGl0J3MgYSBidWcgc29tZXdoZXJl
IEkgZ3Vlc3MuCgoKPgo+ID4KPiA+ICAgICAgICAgICAgICAgdmlydHF1ZXVlX2luaXQodnEsIHZx
LT5zcGxpdC52cmluZy5udW0pOwo+Cj4gVGhlcmUgYXJlIHNvbWUgb3BlcmF0aW9ucyBpbiB0aGlz
LCB3aGljaCBjYW4gYWxzbyBiZSBza2lwcGVkLCBzdWNoIGFzIHNldHRpbmcKPiB1c2VfZG1hX2Fw
aS4gQnV0IEkgdGhpbmsgY2FsbGluZyB0aGlzIGZ1bmN0aW9uIGRpcmVjdGx5IHdpbGwgYmUgbW9y
ZSBjb252ZW5pZW50Cj4gZm9yIG1haW50ZW5hbmNlLgoKSSBkb24ndCBzZWUgYW55dGhpbmcgdGhh
dCBpcyBuZWNlc3NhcnkgaGVyZS4KCj4KPgo+ID4gICAgICAgICAgICAgICB2aXJ0cXVldWVfdnJp
bmdfaW5pdF9zcGxpdCgmdnEtPnNwbGl0LCB2cSk7Cj4KPiB2aXJ0cXVldWVfdnJpbmdfaW5pdF9z
cGxpdCgpIGlzIG5lY2Vzc2FyeS4KClJpZ2h0LgoKPgo+ID4gICAgICAgfQo+Cj4gQW5vdGhlciBt
ZXRob2QsIHdlIGNhbiB0YWtlIG91dCBhbGwgdGhlIHZhcmlhYmxlcyB0byBiZSByZWluaXRpYWxp
emVkCj4gc2VwYXJhdGVseSwgYW5kIHJlcGFja2FnZSB0aGVtIGludG8gYSBuZXcgZnVuY3Rpb24u
IEkgZG9u4oCZdCB0aGluayBpdOKAmXMgd29ydGgKPiBpdCwgYmVjYXVzZSB0aGlzIHBhdGggd2ls
bCBvbmx5IGJlIHJlYWNoZWQgaWYgdGhlIG1lbW9yeSBhbGxvY2F0aW9uIGZhaWxzLCB3aGljaAo+
IGlzIGEgcmFyZSBvY2N1cnJlbmNlLiBJbiB0aGlzIGNhc2UsIGRvaW5nIHNvIHdpbGwgaW5jcmVh
c2UgdGhlIGNvc3Qgb2YKPiBtYWludGVuYW5jZS4gSWYgeW91IHRoaW5rIHNvIGFsc28sIEkgd2ls
bCByZW1vdmUgdGhlIGFib3ZlIG1lbXNldCBpbiB0aGUgbmV4dAo+IHZlcnNpb24uCgpJIGFncmVl
LgoKVGhhbmtzCgo+Cj4gVGhhbmtzLgo+Cj4KPiA+Cj4gPiBUaGFua3MKPiA+Cj4gPiA+Cj4gPiA+
ID4KPiA+ID4gPgo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gKyAgIGVyciA9IHZyaW5nX2FsbG9jX3N0
YXRlX2V4dHJhX3NwbGl0KCZ2cmluZ19zcGxpdCk7Cj4gPiA+ID4gPiArICAgaWYgKGVycikgewo+
ID4gPiA+ID4gKyAgICAgICAgICAgdnJpbmdfZnJlZV9zcGxpdCgmdnJpbmdfc3BsaXQsIHZkZXYp
Owo+ID4gPiA+ID4gKyAgICAgICAgICAgZ290byBlcnI7Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+
IEkgc3VnZ2VzdCB0byBtb3ZlIHZyaW5nX2ZyZWVfc3BsaXQoKSBpbnRvIGEgZGVkaWNhdGVkIGVy
cm9yIGxhYmVsLgo+ID4gPgo+ID4gPiBXaWxsIGNoYW5nZS4KPiA+ID4KPiA+ID4gVGhhbmtzLgo+
ID4gPgo+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtzCj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+
ID4gKyAgIH0KPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICsgICB2cmluZ19mcmVlKCZ2cS0+dnEpOwo+
ID4gPiA+ID4gKwo+ID4gPiA+ID4gKyAgIHZpcnRxdWV1ZV92cmluZ19pbml0X3NwbGl0KCZ2cmlu
Z19zcGxpdCwgdnEpOwo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gKyAgIHZpcnRxdWV1ZV9pbml0KHZx
LCB2cmluZ19zcGxpdC52cmluZy5udW0pOwo+ID4gPiA+ID4gKyAgIHZpcnRxdWV1ZV92cmluZ19h
dHRhY2hfc3BsaXQodnEsICZ2cmluZ19zcGxpdCk7Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiArICAg
cmV0dXJuIDA7Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiArZXJyOgo+ID4gPiA+ID4gKyAgIHZpcnRx
dWV1ZV9yZWluaXRfc3BsaXQodnEpOwo+ID4gPiA+ID4gKyAgIHJldHVybiAtRU5PTUVNOwo+ID4g
PiA+ID4gK30KPiA+ID4gPiA+ICsKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgIC8qCj4gPiA+ID4gPiAg
ICAqIFBhY2tlZCByaW5nIHNwZWNpZmljIGZ1bmN0aW9ucyAtICpfcGFja2VkKCkuCj4gPiA+ID4K
PiA+ID4KPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
