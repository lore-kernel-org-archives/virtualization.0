Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75115C00144
	for <virtualization@archiver.kernel.org>; Mon,  1 Aug 2022 04:49:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0439E60757;
	Mon,  1 Aug 2022 04:49:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0439E60757
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HdNfbLfY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8EVo13SyKikc; Mon,  1 Aug 2022 04:49:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0003360759;
	Mon,  1 Aug 2022 04:49:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0003360759
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A838EC0032;
	Mon,  1 Aug 2022 04:49:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 393D8C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 04:49:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E58A40192
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 04:49:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E58A40192
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HdNfbLfY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BBPga3bhktto
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 04:49:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CF5D54017C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF5D54017C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 04:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659329366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q+tpGySP9Lk1FyvMvrEtbd53hrU4ZKX1FexyKVAWT9g=;
 b=HdNfbLfYZDJUN5WgV+kqtn6f6DClx+U3/gEhMfZ98KLDV5HUsJSBr/IDSUUeNKaJnQuG9+
 i5Gm7RqAggl/KBW5s35m98C1n/DA+nO12w6seIVcj5ozbJftuGrQf3AQNCPtRy9jgbrkfJ
 LvATCZEVrWXq+vUfJ9lThDvzSCfl5nU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-jpSDDxjEPUSPtKuB2PPTNA-1; Mon, 01 Aug 2022 00:49:24 -0400
X-MC-Unique: jpSDDxjEPUSPtKuB2PPTNA-1
Received: by mail-ej1-f71.google.com with SMTP id
 qf23-20020a1709077f1700b007308a195618so140554ejc.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Jul 2022 21:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=q+tpGySP9Lk1FyvMvrEtbd53hrU4ZKX1FexyKVAWT9g=;
 b=C2gY0+/QMEu5VaxHKyrZRtLeNBrzuplaczde+1Zf2IsRpV45ZqsoX7Xupqm568twhX
 mS8DDIcgmRtJ5kC9Ki0VXhKK8KUrJvoEYf9MoPiTuZy+xosuh/NX6j4fU7l7WAgbCKNY
 Isq6dteiXyqS2Va3WqCj4OY0KQz5yjCo2wTg0z79pcciW/mEv2BE2El59Qjgo5Lb9VHh
 MLgvOsCMjHhuRgEcYl97u841v9OYajrL1r5cMSBnYuQpIF8/jm1ob3Zfd7jBcEgLyKu+
 60lbbqyJlZlfu/znaG8hUysFLpLh/dSFdwrSVAnjnP6Og4hKOnLkYSbv24/IOaHBvGJw
 6hjg==
X-Gm-Message-State: ACgBeo23r1qDCQnHKpX5yYG8zpWkHQYRLTTk5kn2C5gsDTGmswsD7x7S
 s2cUWl2iGNF4XorYfsl9Rk4gjWNKnPgdtG1A5KAEYBgIqsgu4jZxfBhyc0beh0RCFLgn3V1Qswk
 XijJG98cCH001SWSBX+P7wbUaVdyYqjeQiQpipJpOLR6qlx4qRyzJGwtK+w==
X-Received: by 2002:a17:906:7952:b0:730:6ab7:6655 with SMTP id
 l18-20020a170906795200b007306ab76655mr4103319ejo.171.1659329363743; 
 Sun, 31 Jul 2022 21:49:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6QSahe3Oz+0hcT4zTabdKp5OW3wU+PvaOKgpjGIS2wuAOteNl/QWorIgyoG68O4FkZexN8Vy86JXN1G06sGrw=
X-Received: by 2002:a17:906:7952:b0:730:6ab7:6655 with SMTP id
 l18-20020a170906795200b007306ab76655mr4103291ejo.171.1659329363476; Sun, 31
 Jul 2022 21:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-17-xuanzhuo@linux.alibaba.com>
 <15aa26f2-f8af-5dbd-f2b2-9270ad873412@redhat.com>
 <1658907413.1860468-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvxsOfiiaWWAR8P68GY1yfwgTvaAbHk1JF7pTw-o2k25w@mail.gmail.com>
 <1658992162.584327-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEv-KYieHKXY_Qn0nfcnLMOSF=TowF5PwLKOxESL3KQ40Q@mail.gmail.com>
 <1658995783.1026692-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEv6Ptn4zj_F-ww3Nay-VPmCNrXLaf5U98PvupAvo44FpA@mail.gmail.com>
 <1659001321.5738833-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1659001321.5738833-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 1 Aug 2022 12:49:12 +0800
Message-ID: <CACGkMEvcRxbqJ01sjC50muW3cQJiJKUJW+67QrsOP662FCgi0g@mail.gmail.com>
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

T24gVGh1LCBKdWwgMjgsIDIwMjIgYXQgNzoyNyBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgMjggSnVsIDIwMjIgMTc6MDQ6MzYgKzA4
MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gT24gVGh1LCBK
dWwgMjgsIDIwMjIgYXQgNDoxOCBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEu
Y29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gVGh1LCAyOCBKdWwgMjAyMiAxNTo0Mjo1MCArMDgw
MCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gT24gVGh1
LCBKdWwgMjgsIDIwMjIgYXQgMzoyNCBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJh
YmEuY29tPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiBPbiBUaHUsIDI4IEp1bCAyMDIyIDEw
OjM4OjUxICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+
ID4gPiA+ID4gT24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMzo0NCBQTSBYdWFuIFpodW8gPHh1YW56
aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
IE9uIFdlZCwgMjcgSnVsIDIwMjIgMTE6MTI6MTkgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IOWcqCAy
MDIyLzcvMjYgMTU6MjEsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPiA+ID4gPiA+ID4gPiA+IHZpcnRp
byByaW5nIHNwbGl0IHN1cHBvcnRzIHJlc2l6ZS4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+ID4gT25seSBhZnRlciB0aGUgbmV3IHZyaW5nIGlzIHN1Y2Nlc3NmdWxseSBhbGxvY2F0
ZWQgYmFzZWQgb24gdGhlIG5ldyBudW0sCj4gPiA+ID4gPiA+ID4gPiA+IHdlIHdpbGwgcmVsZWFz
ZSB0aGUgb2xkIHZyaW5nLiBJbiBhbnkgY2FzZSwgYW4gZXJyb3IgaXMgcmV0dXJuZWQsCj4gPiA+
ID4gPiA+ID4gPiA+IGluZGljYXRpbmcgdGhhdCB0aGUgdnJpbmcgc3RpbGwgcG9pbnRzIHRvIHRo
ZSBvbGQgdnJpbmcuCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IEluIHRoZSBj
YXNlIG9mIGFuIGVycm9yLCByZS1pbml0aWFsaXplKHZpcnRxdWV1ZV9yZWluaXRfc3BsaXQoKSkg
dGhlCj4gPiA+ID4gPiA+ID4gPiA+IHZpcnRxdWV1ZSB0byBlbnN1cmUgdGhhdCB0aGUgdnJpbmcg
Y2FuIGJlIHVzZWQuCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+ID4gPiA+
ID4gPiA+IEFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+
ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gPiA+ID4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gPiA+ID4g
PiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspCj4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiA+ID4gPiA+ID4gPiBp
bmRleCBiNmZkYTkxYzgwNTkuLjU4MzU1ZTFhYzdkNyAxMDA2NDQKPiA+ID4gPiA+ID4gPiA+ID4g
LS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiA+ID4gPiA+ID4gPiArKysg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ID4gPiA+ID4gPiA+IEBAIC0yMjAs
NiArMjIwLDcgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1
ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICgqY2FsbGJhY2spKHN0cnVjdCB2aXJ0cXVl
dWUgKiksCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBjb25zdCBjaGFyICpuYW1lKTsKPiA+ID4gPiA+ID4gPiA+ID4gICBzdGF0aWMg
c3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKnZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEodW5zaWduZWQg
aW50IG51bSk7Cj4gPiA+ID4gPiA+ID4gPiA+ICtzdGF0aWMgdm9pZCB2cmluZ19mcmVlKHN0cnVj
dCB2aXJ0cXVldWUgKl92cSk7Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ICAg
LyoKPiA+ID4gPiA+ID4gPiA+ID4gICAgKiBIZWxwZXJzLgo+ID4gPiA+ID4gPiA+ID4gPiBAQCAt
MTExNyw2ICsxMTE4LDM5IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVf
dmlydHF1ZXVlX3NwbGl0KAo+ID4gPiA+ID4gPiA+ID4gPiAgICAgcmV0dXJuIHZxOwo+ID4gPiA+
ID4gPiA+ID4gPiAgIH0KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gK3N0YXRp
YyBpbnQgdmlydHF1ZXVlX3Jlc2l6ZV9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsIHUzMiBu
dW0pCj4gPiA+ID4gPiA+ID4gPiA+ICt7Cj4gPiA+ID4gPiA+ID4gPiA+ICsgICBzdHJ1Y3QgdnJp
bmdfdmlydHF1ZXVlX3NwbGl0IHZyaW5nX3NwbGl0ID0ge307Cj4gPiA+ID4gPiA+ID4gPiA+ICsg
ICBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ID4gPiA+ID4gPiA+
ID4gPiArICAgc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYgPSBfdnEtPnZkZXY7Cj4gPiA+ID4g
PiA+ID4gPiA+ICsgICBpbnQgZXJyOwo+ID4gPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4g
PiA+ICsgICBlcnIgPSB2cmluZ19hbGxvY19xdWV1ZV9zcGxpdCgmdnJpbmdfc3BsaXQsIHZkZXYs
IG51bSwKPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHZxLT5zcGxpdC52cmluZ19hbGlnbiwKPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHZxLT5zcGxpdC5tYXlfcmVkdWNlX251bSk7Cj4gPiA+ID4gPiA+
ID4gPiA+ICsgICBpZiAoZXJyKQo+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgICBnb3RvIGVy
cjsKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gSSB0aGlu
ayB3ZSBkb24ndCBuZWVkIHRvIGRvIGFueXRoaW5nIGhlcmU/Cj4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiBBbSBJIG1pc3Npbmcgc29tZXRoaW5nPwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBJ
IG1lYW50IGl0IGxvb2tzIHRvIG1lIG1vc3Qgb2YgdGhlIHZpcnRxdWV1ZV9yZWluaXQoKSBpcyB1
bm5lY2Vzc2FyeS4KPiA+ID4gPiA+ID4gV2UgcHJvYmFibHkgb25seSBuZWVkIHRvIHJlaW5pdCBh
dmFpbC91c2VkIGlkeCB0aGVyZS4KPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gSW4gdGhp
cyBmdW5jdGlvbiwgd2UgY2FuIGluZGVlZCByZW1vdmUgc29tZSBjb2RlLgo+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gICAgICAgc3RhdGljIHZvaWQgdmlydHF1ZXVlX3JlaW5pdF9zcGxpdChzdHJ1Y3Qg
dnJpbmdfdmlydHF1ZXVlICp2cSkKPiA+ID4gPiA+ID4gICAgICAgewo+ID4gPiA+ID4gPiAgICAg
ICAgICAgICAgIGludCBzaXplLCBpOwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiAgICAgICAgICAg
ICAgIG1lbXNldCh2cS0+c3BsaXQudnJpbmcuZGVzYywgMCwgdnEtPnNwbGl0LnF1ZXVlX3NpemVf
aW5fYnl0ZXMpOwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgIHNpemUgPSBz
aXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfc3BsaXQpICogdnEtPnNwbGl0LnZyaW5nLm51
bTsKPiA+ID4gPiA+ID4gICAgICAgICAgICAgICBtZW1zZXQodnEtPnNwbGl0LmRlc2Nfc3RhdGUs
IDAsIHNpemUpOwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgIHNpemUgPSBz
aXplb2Yoc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEpICogdnEtPnNwbGl0LnZyaW5nLm51bTsKPiA+
ID4gPiA+ID4gICAgICAgICAgICAgICBtZW1zZXQodnEtPnNwbGl0LmRlc2NfZXh0cmEsIDAsIHNp
emUpOwo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoZXNlIG1lbXNldHMgY2FuIGJlIHJlbW92ZWQsIGFu
ZCB0aGVvcmV0aWNhbGx5IGl0IHdpbGwgbm90IGNhdXNlIGFueQo+ID4gPiA+ID4gZXhjZXB0aW9u
cy4KPiA+ID4gPgo+ID4gPiA+IFllcywgb3RoZXJ3aXNlIHdlIGhhdmUgYnVncyBpbiBkZXRhY2hf
YnVmKCkuCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IHZxLT5zcGxpdC52
cmluZy5udW0gLSAxOyBpKyspCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICB2cS0+
c3BsaXQuZGVzY19leHRyYVtpXS5uZXh0ID0gaSArIDE7Cj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhp
cyBjYW4gYWxzbyBiZSByZW1vdmVkLCBidXQgd2UgbmVlZCB0byByZWNvcmQgZnJlZV9oZWFkIHRo
YXQgd2lsbCBiZWVuIHVwZGF0ZQo+ID4gPiA+ID4gaW5zaWRlIHZpcnRxdWV1ZV9pbml0KCkuCj4g
PiA+ID4KPiA+ID4gPiBXZSBjYW4gc2ltcGx5IGtlZXAgZnJlZV9oZWFkIHVuY2hhbmdlZD8gT3Ro
ZXJ3aXNlIGl0J3MgYSBidWcgc29tZXdoZXJlIEkgZ3Vlc3MuCj4gPiA+ID4KPiA+ID4gPgo+ID4g
PiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICB2aXJ0cXVldWVfaW5p
dCh2cSwgdnEtPnNwbGl0LnZyaW5nLm51bSk7Cj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhlcmUgYXJl
IHNvbWUgb3BlcmF0aW9ucyBpbiB0aGlzLCB3aGljaCBjYW4gYWxzbyBiZSBza2lwcGVkLCBzdWNo
IGFzIHNldHRpbmcKPiA+ID4gPiA+IHVzZV9kbWFfYXBpLiBCdXQgSSB0aGluayBjYWxsaW5nIHRo
aXMgZnVuY3Rpb24gZGlyZWN0bHkgd2lsbCBiZSBtb3JlIGNvbnZlbmllbnQKPiA+ID4gPiA+IGZv
ciBtYWludGVuYW5jZS4KPiA+ID4gPgo+ID4gPiA+IEkgZG9uJ3Qgc2VlIGFueXRoaW5nIHRoYXQg
aXMgbmVjZXNzYXJ5IGhlcmUuCj4gPiA+Cj4gPiA+IFRoZXNlIHRocmVlIGFyZSBjdXJyZW50bHkg
aW5zaWRlIHZpcnRxdWV1ZV9pbml0KCkKPiA+ID4KPiA+ID4gdnEtPmxhc3RfdXNlZF9pZHggPSAw
Owo+ID4gPiB2cS0+ZXZlbnRfdHJpZ2dlcmVkID0gZmFsc2U7Cj4gPiA+IHZxLT5udW1fYWRkZWQg
PSAwOwo+ID4KPiA+IFJpZ2h0LiBMZXQncyBrZWVwIGl0IHRoZXJlLgo+ID4KPiA+IChUaG91Z2gg
aXQncyBraW5kIG9mIHN0cmFuZ2UgdGhhdCB0aGUgbGFzdF91c2VkX2lkeCBpcyBub3QgaW5pdGlh
bGl6ZWQKPiA+IGF0IHRoZSBzYW1lIHBsYWNlIHdpdGggYXZhaWxfaWR4L2ZsYWdzX3NoYWRvdywg
d2UgY2FuIG9wdGltaXplIGl0IG9uCj4gPiB0b3ApLgo+Cj4gSSBwdXQgZnJlZV9oZWFkID0gMCBp
biB0aGUgYXR0YWNoIGZ1bmN0aW9uLCBpdCBpcyBvbmx5IG5lY2Vzc2FyeSB0byBzZXQKPiBmcmVl
X2hlYWQgPSAwIHdoZW4gYSBuZXcgc3RhdGUvZXh0cmEgaXMgYXR0YWNoZWQuCgpPaywgc28gSSBt
ZWFudCBJIHRlbmQgdG8ga2VlcCBpdCB0byBtYWtlIHRoaXMgc2VyaWVzIGNvbnZlcmdlIHNvb24g
OikKCldlIGNhbiBkbyBvcHRpbWl6YXRpb24gb24gdG9wIGFueWhvdy4KClRoYW5rcwoKPgo+IElu
IHRoaXMgd2F5LCB3aGVuIHdlIGNhbGwgdmlydHF1ZXVlX2luaXQoKSwgd2UgZG9uJ3QgaGF2ZSB0
byB3b3JyeSBhYm91dAo+IGZyZWVfaGVhZCBiZWluZyBtb2RpZmllZC4KPgo+IFJldGhpbmtpbmcg
dGhpcyBwcm9ibGVtLCBJIHRoaW5rIHZpcnRxdWV1ZV9pbml0KCkgY2FuIGJlIHJld3JpdHRlbiBh
bmQgc29tZQo+IHZhcmlhYmxlcyB0aGF0IHdpbGwgbm90IGNoYW5nZSBhcmUgcmVtb3ZlZCBmcm9t
IGl0LiAodXNlX2RtYV9hcGksIGV2ZW50LAo+IHdlYWtfYmFycmllcnMpCj4KPiArc3RhdGljIHZv
aWQgdmlydHF1ZXVlX2luaXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsIHUzMiBudW0pCj4g
K3sKPiArICAgICAgIHZxLT52cS5udW1fZnJlZSA9IG51bTsKPiArCj4gKyAgICAgICBpZiAodnEt
PnBhY2tlZF9yaW5nKQo+ICsgICAgICAgICAgICAgICB2cS0+bGFzdF91c2VkX2lkeCA9IDAgfCAo
MSA8PCBWUklOR19QQUNLRURfRVZFTlRfRl9XUkFQX0NUUik7Cj4gKyAgICAgICBlbHNlCj4gKyAg
ICAgICAgICAgICAgIHZxLT5sYXN0X3VzZWRfaWR4ID0gMDsKPiArCj4gKyAgICAgICB2cS0+ZXZl
bnRfdHJpZ2dlcmVkID0gZmFsc2U7Cj4gKyAgICAgICB2cS0+bnVtX2FkZGVkID0gMDsKPiArCj4g
KyNpZmRlZiBERUJVRwo+ICsgICAgICAgdnEtPmluX3VzZSA9IGZhbHNlOwo+ICsgICAgICAgdnEt
Pmxhc3RfYWRkX3RpbWVfdmFsaWQgPSBmYWxzZTsKPiArI2VuZGlmCj4gK30KPiArCj4KPiBUaGFu
a3MuCj4KPgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+ID4KPiA+ID4gVGhhbmtzLgo+ID4gPgo+ID4g
Pgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICB2
aXJ0cXVldWVfdnJpbmdfaW5pdF9zcGxpdCgmdnEtPnNwbGl0LCB2cSk7Cj4gPiA+ID4gPgo+ID4g
PiA+ID4gdmlydHF1ZXVlX3ZyaW5nX2luaXRfc3BsaXQoKSBpcyBuZWNlc3NhcnkuCj4gPiA+ID4K
PiA+ID4gPiBSaWdodC4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+ID4gICAgICAgfQo+ID4g
PiA+ID4KPiA+ID4gPiA+IEFub3RoZXIgbWV0aG9kLCB3ZSBjYW4gdGFrZSBvdXQgYWxsIHRoZSB2
YXJpYWJsZXMgdG8gYmUgcmVpbml0aWFsaXplZAo+ID4gPiA+ID4gc2VwYXJhdGVseSwgYW5kIHJl
cGFja2FnZSB0aGVtIGludG8gYSBuZXcgZnVuY3Rpb24uIEkgZG9u4oCZdCB0aGluayBpdOKAmXMg
d29ydGgKPiA+ID4gPiA+IGl0LCBiZWNhdXNlIHRoaXMgcGF0aCB3aWxsIG9ubHkgYmUgcmVhY2hl
ZCBpZiB0aGUgbWVtb3J5IGFsbG9jYXRpb24gZmFpbHMsIHdoaWNoCj4gPiA+ID4gPiBpcyBhIHJh
cmUgb2NjdXJyZW5jZS4gSW4gdGhpcyBjYXNlLCBkb2luZyBzbyB3aWxsIGluY3JlYXNlIHRoZSBj
b3N0IG9mCj4gPiA+ID4gPiBtYWludGVuYW5jZS4gSWYgeW91IHRoaW5rIHNvIGFsc28sIEkgd2ls
bCByZW1vdmUgdGhlIGFib3ZlIG1lbXNldCBpbiB0aGUgbmV4dAo+ID4gPiA+ID4gdmVyc2lvbi4K
PiA+ID4gPgo+ID4gPiA+IEkgYWdyZWUuCj4gPiA+ID4KPiA+ID4gPiBUaGFua3MKPiA+ID4gPgo+
ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcy4KPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiA+
ID4gKyAgIGVyciA9IHZyaW5nX2FsbG9jX3N0YXRlX2V4dHJhX3NwbGl0KCZ2cmluZ19zcGxpdCk7
Cj4gPiA+ID4gPiA+ID4gPiA+ICsgICBpZiAoZXJyKSB7Cj4gPiA+ID4gPiA+ID4gPiA+ICsgICAg
ICAgICAgIHZyaW5nX2ZyZWVfc3BsaXQoJnZyaW5nX3NwbGl0LCB2ZGV2KTsKPiA+ID4gPiA+ID4g
PiA+ID4gKyAgICAgICAgICAgZ290byBlcnI7Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiA+IEkgc3VnZ2VzdCB0byBtb3ZlIHZyaW5nX2ZyZWVfc3BsaXQoKSBp
bnRvIGEgZGVkaWNhdGVkIGVycm9yIGxhYmVsLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
V2lsbCBjaGFuZ2UuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBUaGFua3MuCj4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IFRoYW5r
cwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ICsgICB9
Cj4gPiA+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiA+ID4gKyAgIHZyaW5nX2ZyZWUoJnZx
LT52cSk7Cj4gPiA+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiA+ID4gKyAgIHZpcnRxdWV1
ZV92cmluZ19pbml0X3NwbGl0KCZ2cmluZ19zcGxpdCwgdnEpOwo+ID4gPiA+ID4gPiA+ID4gPiAr
Cj4gPiA+ID4gPiA+ID4gPiA+ICsgICB2aXJ0cXVldWVfaW5pdCh2cSwgdnJpbmdfc3BsaXQudnJp
bmcubnVtKTsKPiA+ID4gPiA+ID4gPiA+ID4gKyAgIHZpcnRxdWV1ZV92cmluZ19hdHRhY2hfc3Bs
aXQodnEsICZ2cmluZ19zcGxpdCk7Cj4gPiA+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiA+
ID4gKyAgIHJldHVybiAwOwo+ID4gPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gPiA+ICtl
cnI6Cj4gPiA+ID4gPiA+ID4gPiA+ICsgICB2aXJ0cXVldWVfcmVpbml0X3NwbGl0KHZxKTsKPiA+
ID4gPiA+ID4gPiA+ID4gKyAgIHJldHVybiAtRU5PTUVNOwo+ID4gPiA+ID4gPiA+ID4gPiArfQo+
ID4gPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ICAg
LyoKPiA+ID4gPiA+ID4gPiA+ID4gICAgKiBQYWNrZWQgcmluZyBzcGVjaWZpYyBmdW5jdGlvbnMg
LSAqX3BhY2tlZCgpLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+
ID4gPiA+ID4KPiA+ID4gPgo+ID4gPgo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
