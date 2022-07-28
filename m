Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B8AC19F29
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 09:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31F4C60F31;
	Thu, 28 Jul 2022 09:04:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31F4C60F31
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TyqEgzjY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Dman572yq7q; Thu, 28 Jul 2022 09:04:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7D38F60F30;
	Thu, 28 Jul 2022 09:04:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D38F60F30
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42A8BC0035;
	Thu, 28 Jul 2022 09:04:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46558C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 09:04:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1529782ED2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 09:04:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1529782ED2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TyqEgzjY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LeDNYlVnUoBL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 09:04:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9ED5B82EA2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9ED5B82EA2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 09:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658999093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DE+7ye1yGql++GLaeEI3m8GcZZJm0NhK1cN8F4iHjXQ=;
 b=TyqEgzjYGV8D00yhp8ci+WZMssXVO2TnYOJdyp+SXVe5TmTYyJCW2/KoIr1mVW6cOozQvr
 UyYOCv3jpSW6J6WdZ177fjdWQ/eD3jQOwve0RdW3EHSKab3Jnqv3NvzXKSbeuYAXW5pQKb
 XT6Qi8/ya/AuHpm26NF4Aiswz4xC+f0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-LOt1bcDENyGr-TBpk-mixA-1; Thu, 28 Jul 2022 05:04:49 -0400
X-MC-Unique: LOt1bcDENyGr-TBpk-mixA-1
Received: by mail-ed1-f69.google.com with SMTP id
 z1-20020a05640235c100b0043bca7d9b3eso711522edc.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 02:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DE+7ye1yGql++GLaeEI3m8GcZZJm0NhK1cN8F4iHjXQ=;
 b=QKy/B+9JLHzZZaJGG+6Y6JM5RhJ/AzJWV+JhP+nHNorshrQkf5/E4tf9Jj+NLIHkGj
 hcZb7yYrYCBeoXZIBP1jMPN7DQS3iM4NYz2/s5fqlURYXmboUOGVdN+r25w/ZIK5ukX2
 PW3pGZLt8sbU+hJ0NB4B11EyH40rw1BFTelVTuEZbZvyh6wq60jP2wqHsFRoVOojOZWT
 k1C17dKnEs0aUL/8pY1FdJ4vSmQO9+YtPe7Wr+VH4V46ojxev8Iy4npsS08JbQ4Fc7WB
 pgcl2mb+23LO0ToCXfkFRCuOmFE51ygmApkV1TGa797O/zYO5baKdOKeR+oXuUqSvnsB
 mziA==
X-Gm-Message-State: AJIora84XDhoBSsfrPCoEXp4F3Kef8C7KLvE4DoeP81diXhnQpMO9Bnr
 aEYP4n8IkmhFJkNkShGCnIIX/uMguVNiDdXzV2heZ7f9ksvlego6OT41RUNw//ncNYxMOSZxkrY
 mIcgAL3e1+XD61mSD76vvWIdeLS/DgeRiknscil3y64WvX3i+4zW+Pc7w2g==
X-Received: by 2002:a05:6402:e8d:b0:43b:b989:67a7 with SMTP id
 h13-20020a0564020e8d00b0043bb98967a7mr26870686eda.365.1658999088580; 
 Thu, 28 Jul 2022 02:04:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s1w+ifPe5brXP86zsuwWmOU7w3VBKz6YZbGZMkO1Ncvx95MYfD9EAWpCCUuuHrp8ACTACnKlnhDk4GL3uXFGk=
X-Received: by 2002:a05:6402:e8d:b0:43b:b989:67a7 with SMTP id
 h13-20020a0564020e8d00b0043bb98967a7mr26870656eda.365.1658999088045; Thu, 28
 Jul 2022 02:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-17-xuanzhuo@linux.alibaba.com>
 <15aa26f2-f8af-5dbd-f2b2-9270ad873412@redhat.com>
 <1658907413.1860468-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvxsOfiiaWWAR8P68GY1yfwgTvaAbHk1JF7pTw-o2k25w@mail.gmail.com>
 <1658992162.584327-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEv-KYieHKXY_Qn0nfcnLMOSF=TowF5PwLKOxESL3KQ40Q@mail.gmail.com>
 <1658995783.1026692-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1658995783.1026692-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Jul 2022 17:04:36 +0800
Message-ID: <CACGkMEv6Ptn4zj_F-ww3Nay-VPmCNrXLaf5U98PvupAvo44FpA@mail.gmail.com>
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

T24gVGh1LCBKdWwgMjgsIDIwMjIgYXQgNDoxOCBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgMjggSnVsIDIwMjIgMTU6NDI6NTAgKzA4
MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gT24gVGh1LCBK
dWwgMjgsIDIwMjIgYXQgMzoyNCBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEu
Y29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gVGh1LCAyOCBKdWwgMjAyMiAxMDozODo1MSArMDgw
MCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gT24gV2Vk
LCBKdWwgMjcsIDIwMjIgYXQgMzo0NCBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJh
YmEuY29tPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiBPbiBXZWQsIDI3IEp1bCAyMDIyIDEx
OjEyOjE5ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4g5ZyoIDIwMjIvNy8yNiAxNToyMSwgWHVhbiBaaHVvIOWGmemB
kzoKPiA+ID4gPiA+ID4gPiB2aXJ0aW8gcmluZyBzcGxpdCBzdXBwb3J0cyByZXNpemUuCj4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBPbmx5IGFmdGVyIHRoZSBuZXcgdnJpbmcgaXMgc3VjY2Vz
c2Z1bGx5IGFsbG9jYXRlZCBiYXNlZCBvbiB0aGUgbmV3IG51bSwKPiA+ID4gPiA+ID4gPiB3ZSB3
aWxsIHJlbGVhc2UgdGhlIG9sZCB2cmluZy4gSW4gYW55IGNhc2UsIGFuIGVycm9yIGlzIHJldHVy
bmVkLAo+ID4gPiA+ID4gPiA+IGluZGljYXRpbmcgdGhhdCB0aGUgdnJpbmcgc3RpbGwgcG9pbnRz
IHRvIHRoZSBvbGQgdnJpbmcuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBJbiB0aGUgY2Fz
ZSBvZiBhbiBlcnJvciwgcmUtaW5pdGlhbGl6ZSh2aXJ0cXVldWVfcmVpbml0X3NwbGl0KCkpIHRo
ZQo+ID4gPiA+ID4gPiA+IHZpcnRxdWV1ZSB0byBlbnN1cmUgdGhhdCB0aGUgdnJpbmcgY2FuIGJl
IHVzZWQuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpo
dW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gPiA+ID4gPiA+IEFja2VkLWJ5OiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+
ID4gPiA+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDM0ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysKPiA+ID4gPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzNCBp
bnNlcnRpb25zKCspCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMK
PiA+ID4gPiA+ID4gPiBpbmRleCBiNmZkYTkxYzgwNTkuLjU4MzU1ZTFhYzdkNyAxMDA2NDQKPiA+
ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ID4gPiA+
ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiA+ID4gPiA+IEBAIC0y
MjAsNiArMjIwLDcgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRx
dWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKCpjYWxsYmFjaykoc3RydWN0IHZpcnRxdWV1
ZSAqKSwKPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29uc3QgY2hhciAqbmFtZSk7Cj4gPiA+ID4gPiA+ID4gICBzdGF0aWMgc3RydWN0IHZy
aW5nX2Rlc2NfZXh0cmEgKnZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEodW5zaWduZWQgaW50IG51bSk7
Cj4gPiA+ID4gPiA+ID4gK3N0YXRpYyB2b2lkIHZyaW5nX2ZyZWUoc3RydWN0IHZpcnRxdWV1ZSAq
X3ZxKTsKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ICAgLyoKPiA+ID4gPiA+ID4gPiAgICAq
IEhlbHBlcnMuCj4gPiA+ID4gPiA+ID4gQEAgLTExMTcsNiArMTExOCwzOSBAQCBzdGF0aWMgc3Ry
dWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiA+ID4gPiA+ID4g
PiAgICAgcmV0dXJuIHZxOwo+ID4gPiA+ID4gPiA+ICAgfQo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gK3N0YXRpYyBpbnQgdmlydHF1ZXVlX3Jlc2l6ZV9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVl
ICpfdnEsIHUzMiBudW0pCj4gPiA+ID4gPiA+ID4gK3sKPiA+ID4gPiA+ID4gPiArICAgc3RydWN0
IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCB2cmluZ19zcGxpdCA9IHt9Owo+ID4gPiA+ID4gPiA+ICsg
ICBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ID4gPiA+ID4gPiA+
ICsgICBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiA9IF92cS0+dmRldjsKPiA+ID4gPiA+ID4g
PiArICAgaW50IGVycjsKPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gKyAgIGVyciA9IHZy
aW5nX2FsbG9jX3F1ZXVlX3NwbGl0KCZ2cmluZ19zcGxpdCwgdmRldiwgbnVtLAo+ID4gPiA+ID4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2cS0+c3BsaXQudnJpbmdfYWxp
Z24sCj4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZxLT5z
cGxpdC5tYXlfcmVkdWNlX251bSk7Cj4gPiA+ID4gPiA+ID4gKyAgIGlmIChlcnIpCj4gPiA+ID4g
PiA+ID4gKyAgICAgICAgICAgZ290byBlcnI7Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+IEkgdGhpbmsgd2UgZG9uJ3QgbmVlZCB0byBkbyBhbnl0aGluZyBoZXJlPwo+ID4gPiA+
ID4KPiA+ID4gPiA+IEFtIEkgbWlzc2luZyBzb21ldGhpbmc/Cj4gPiA+ID4KPiA+ID4gPiBJIG1l
YW50IGl0IGxvb2tzIHRvIG1lIG1vc3Qgb2YgdGhlIHZpcnRxdWV1ZV9yZWluaXQoKSBpcyB1bm5l
Y2Vzc2FyeS4KPiA+ID4gPiBXZSBwcm9iYWJseSBvbmx5IG5lZWQgdG8gcmVpbml0IGF2YWlsL3Vz
ZWQgaWR4IHRoZXJlLgo+ID4gPgo+ID4gPgo+ID4gPiBJbiB0aGlzIGZ1bmN0aW9uLCB3ZSBjYW4g
aW5kZWVkIHJlbW92ZSBzb21lIGNvZGUuCj4gPiA+Cj4gPiA+ID4gICAgICAgc3RhdGljIHZvaWQg
dmlydHF1ZXVlX3JlaW5pdF9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSkKPiA+ID4g
PiAgICAgICB7Cj4gPiA+ID4gICAgICAgICAgICAgICBpbnQgc2l6ZSwgaTsKPiA+ID4gPgo+ID4g
PiA+ICAgICAgICAgICAgICAgbWVtc2V0KHZxLT5zcGxpdC52cmluZy5kZXNjLCAwLCB2cS0+c3Bs
aXQucXVldWVfc2l6ZV9pbl9ieXRlcyk7Cj4gPiA+ID4KPiA+ID4gPiAgICAgICAgICAgICAgIHNp
emUgPSBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfc3BsaXQpICogdnEtPnNwbGl0LnZy
aW5nLm51bTsKPiA+ID4gPiAgICAgICAgICAgICAgIG1lbXNldCh2cS0+c3BsaXQuZGVzY19zdGF0
ZSwgMCwgc2l6ZSk7Cj4gPiA+ID4KPiA+ID4gPiAgICAgICAgICAgICAgIHNpemUgPSBzaXplb2Yo
c3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEpICogdnEtPnNwbGl0LnZyaW5nLm51bTsKPiA+ID4gPiAg
ICAgICAgICAgICAgIG1lbXNldCh2cS0+c3BsaXQuZGVzY19leHRyYSwgMCwgc2l6ZSk7Cj4gPiA+
Cj4gPiA+IFRoZXNlIG1lbXNldHMgY2FuIGJlIHJlbW92ZWQsIGFuZCB0aGVvcmV0aWNhbGx5IGl0
IHdpbGwgbm90IGNhdXNlIGFueQo+ID4gPiBleGNlcHRpb25zLgo+ID4KPiA+IFllcywgb3RoZXJ3
aXNlIHdlIGhhdmUgYnVncyBpbiBkZXRhY2hfYnVmKCkuCj4gPgo+ID4gPgo+ID4gPiA+Cj4gPiA+
ID4KPiA+ID4gPgo+ID4gPiA+ICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IHZxLT5zcGxp
dC52cmluZy5udW0gLSAxOyBpKyspCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIHZxLT5z
cGxpdC5kZXNjX2V4dHJhW2ldLm5leHQgPSBpICsgMTsKPiA+ID4KPiA+ID4gVGhpcyBjYW4gYWxz
byBiZSByZW1vdmVkLCBidXQgd2UgbmVlZCB0byByZWNvcmQgZnJlZV9oZWFkIHRoYXQgd2lsbCBi
ZWVuIHVwZGF0ZQo+ID4gPiBpbnNpZGUgdmlydHF1ZXVlX2luaXQoKS4KPiA+Cj4gPiBXZSBjYW4g
c2ltcGx5IGtlZXAgZnJlZV9oZWFkIHVuY2hhbmdlZD8gT3RoZXJ3aXNlIGl0J3MgYSBidWcgc29t
ZXdoZXJlIEkgZ3Vlc3MuCj4gPgo+ID4KPiA+ID4KPiA+ID4gPgo+ID4gPiA+ICAgICAgICAgICAg
ICAgdmlydHF1ZXVlX2luaXQodnEsIHZxLT5zcGxpdC52cmluZy5udW0pOwo+ID4gPgo+ID4gPiBU
aGVyZSBhcmUgc29tZSBvcGVyYXRpb25zIGluIHRoaXMsIHdoaWNoIGNhbiBhbHNvIGJlIHNraXBw
ZWQsIHN1Y2ggYXMgc2V0dGluZwo+ID4gPiB1c2VfZG1hX2FwaS4gQnV0IEkgdGhpbmsgY2FsbGlu
ZyB0aGlzIGZ1bmN0aW9uIGRpcmVjdGx5IHdpbGwgYmUgbW9yZSBjb252ZW5pZW50Cj4gPiA+IGZv
ciBtYWludGVuYW5jZS4KPiA+Cj4gPiBJIGRvbid0IHNlZSBhbnl0aGluZyB0aGF0IGlzIG5lY2Vz
c2FyeSBoZXJlLgo+Cj4gVGhlc2UgdGhyZWUgYXJlIGN1cnJlbnRseSBpbnNpZGUgdmlydHF1ZXVl
X2luaXQoKQo+Cj4gdnEtPmxhc3RfdXNlZF9pZHggPSAwOwo+IHZxLT5ldmVudF90cmlnZ2VyZWQg
PSBmYWxzZTsKPiB2cS0+bnVtX2FkZGVkID0gMDsKClJpZ2h0LiBMZXQncyBrZWVwIGl0IHRoZXJl
LgoKKFRob3VnaCBpdCdzIGtpbmQgb2Ygc3RyYW5nZSB0aGF0IHRoZSBsYXN0X3VzZWRfaWR4IGlz
IG5vdCBpbml0aWFsaXplZAphdCB0aGUgc2FtZSBwbGFjZSB3aXRoIGF2YWlsX2lkeC9mbGFnc19z
aGFkb3csIHdlIGNhbiBvcHRpbWl6ZSBpdCBvbgp0b3ApLgoKVGhhbmtzCgo+Cj4gVGhhbmtzLgo+
Cj4KPiA+Cj4gPiA+Cj4gPiA+Cj4gPiA+ID4gICAgICAgICAgICAgICB2aXJ0cXVldWVfdnJpbmdf
aW5pdF9zcGxpdCgmdnEtPnNwbGl0LCB2cSk7Cj4gPiA+Cj4gPiA+IHZpcnRxdWV1ZV92cmluZ19p
bml0X3NwbGl0KCkgaXMgbmVjZXNzYXJ5Lgo+ID4KPiA+IFJpZ2h0Lgo+ID4KPiA+ID4KPiA+ID4g
PiAgICAgICB9Cj4gPiA+Cj4gPiA+IEFub3RoZXIgbWV0aG9kLCB3ZSBjYW4gdGFrZSBvdXQgYWxs
IHRoZSB2YXJpYWJsZXMgdG8gYmUgcmVpbml0aWFsaXplZAo+ID4gPiBzZXBhcmF0ZWx5LCBhbmQg
cmVwYWNrYWdlIHRoZW0gaW50byBhIG5ldyBmdW5jdGlvbi4gSSBkb27igJl0IHRoaW5rIGl04oCZ
cyB3b3J0aAo+ID4gPiBpdCwgYmVjYXVzZSB0aGlzIHBhdGggd2lsbCBvbmx5IGJlIHJlYWNoZWQg
aWYgdGhlIG1lbW9yeSBhbGxvY2F0aW9uIGZhaWxzLCB3aGljaAo+ID4gPiBpcyBhIHJhcmUgb2Nj
dXJyZW5jZS4gSW4gdGhpcyBjYXNlLCBkb2luZyBzbyB3aWxsIGluY3JlYXNlIHRoZSBjb3N0IG9m
Cj4gPiA+IG1haW50ZW5hbmNlLiBJZiB5b3UgdGhpbmsgc28gYWxzbywgSSB3aWxsIHJlbW92ZSB0
aGUgYWJvdmUgbWVtc2V0IGluIHRoZSBuZXh0Cj4gPiA+IHZlcnNpb24uCj4gPgo+ID4gSSBhZ3Jl
ZS4KPiA+Cj4gPiBUaGFua3MKPiA+Cj4gPiA+Cj4gPiA+IFRoYW5rcy4KPiA+ID4KPiA+ID4KPiA+
ID4gPgo+ID4gPiA+IFRoYW5rcwo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiArICAgZXJyID0gdnJpbmdfYWxsb2Nf
c3RhdGVfZXh0cmFfc3BsaXQoJnZyaW5nX3NwbGl0KTsKPiA+ID4gPiA+ID4gPiArICAgaWYgKGVy
cikgewo+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgIHZyaW5nX2ZyZWVfc3BsaXQoJnZyaW5nX3Nw
bGl0LCB2ZGV2KTsKPiA+ID4gPiA+ID4gPiArICAgICAgICAgICBnb3RvIGVycjsKPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gSSBzdWdnZXN0IHRvIG1vdmUgdnJpbmdfZnJlZV9z
cGxpdCgpIGludG8gYSBkZWRpY2F0ZWQgZXJyb3IgbGFiZWwuCj4gPiA+ID4gPgo+ID4gPiA+ID4g
V2lsbCBjaGFuZ2UuCj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhhbmtzLgo+ID4gPiA+ID4KPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ICsgICB9Cj4gPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ICsgICB2
cmluZ19mcmVlKCZ2cS0+dnEpOwo+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiArICAgdmly
dHF1ZXVlX3ZyaW5nX2luaXRfc3BsaXQoJnZyaW5nX3NwbGl0LCB2cSk7Cj4gPiA+ID4gPiA+ID4g
Kwo+ID4gPiA+ID4gPiA+ICsgICB2aXJ0cXVldWVfaW5pdCh2cSwgdnJpbmdfc3BsaXQudnJpbmcu
bnVtKTsKPiA+ID4gPiA+ID4gPiArICAgdmlydHF1ZXVlX3ZyaW5nX2F0dGFjaF9zcGxpdCh2cSwg
JnZyaW5nX3NwbGl0KTsKPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gKyAgIHJldHVybiAw
Owo+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiArZXJyOgo+ID4gPiA+ID4gPiA+ICsgICB2
aXJ0cXVldWVfcmVpbml0X3NwbGl0KHZxKTsKPiA+ID4gPiA+ID4gPiArICAgcmV0dXJuIC1FTk9N
RU07Cj4gPiA+ID4gPiA+ID4gK30KPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiAgIC8qCj4gPiA+ID4gPiA+ID4gICAgKiBQYWNrZWQgcmluZyBzcGVjaWZpYyBmdW5j
dGlvbnMgLSAqX3BhY2tlZCgpLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPgo+
ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
