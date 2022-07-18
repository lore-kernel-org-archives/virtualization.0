Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1935AC43334
	for <virtualization@archiver.kernel.org>; Mon, 18 Jul 2022 08:56:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86D3C82F9E;
	Mon, 18 Jul 2022 08:56:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86D3C82F9E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NWPyndKq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BJZiV-xaIG6j; Mon, 18 Jul 2022 08:56:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DE88482AEF;
	Mon, 18 Jul 2022 08:56:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE88482AEF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1256C0035;
	Mon, 18 Jul 2022 08:56:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88A76C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 08:56:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5CB8240192
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 08:56:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5CB8240192
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NWPyndKq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id epaxNHjp8PkY
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 08:56:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21EBA4010C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 21EBA4010C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 08:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658134598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OWEVZ0lWemvnjJGr1KMJVEu33/f4lcOHck1LBmLT0x4=;
 b=NWPyndKqiiALIP0h9Pk5HFNLdaRo74E7HqnT5JnQeuq4WI3nacKSGivB4DgbxhbMjsmeKn
 ASLHd+lSj/QrGkGVbq3wx/AiMFdF7wFLzd/Jq8wGdPmqPAN0zgaUf5V7Meob/5vH1qQx/O
 1XcmVgTlq7efUkg7K8ShMKEIeyPAwkg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-q_jOChNmNAqv9v_cNqUugA-1; Mon, 18 Jul 2022 04:56:37 -0400
X-MC-Unique: q_jOChNmNAqv9v_cNqUugA-1
Received: by mail-lf1-f69.google.com with SMTP id
 d12-20020a056512368c00b00489f92be8c4so3993731lfs.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 01:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OWEVZ0lWemvnjJGr1KMJVEu33/f4lcOHck1LBmLT0x4=;
 b=zp46moctrRc+rbgQ9EU1qFE+q71p9OELRP8ogVjWUJ5mWk9QItiIKZ1rW17daJj8NR
 5V4DJNImWRz4i2I5G4JUgYmVMFizJ4oC+TvS/SvF0tcnlFy3yReoQgBxg0Efuk0kCZV3
 ZiHHz7mmf8oO4nZtT/UUMrXBdKaMqJeMeb9c19CjDhIaaVoQNW90mrunv38VFlpBQYWS
 qVDd8SWLRgz05qJzw6WHFmR5yNj61sVecQYoPJ5TRZwnv4he1jzykrIxt4+w0Z+bn9E6
 vBmGkVIckjpKMZwu9EDwyD880HPsqeIgO6BgGjBvgBqA2flvk7RsYhCX4sb2b2vtZFQp
 oxhg==
X-Gm-Message-State: AJIora/IivMfMN9bu/ygPBkN67ue82vFOei5VoxVv+T4sUXdr9h7v+/5
 ZNPuHb4Lg6+WPMUY/Nvov1Az7Q1Co7S/xDasvWiyW19nHsoanrnv+KZMekDal186JCyYqsZA6Ao
 rw4/lmuVaZOKMWPeu0HoeDKMXhSGMSoNJw43Yl+W3URfhsGxfwZ4APbJDQw==
X-Received: by 2002:ac2:4c4c:0:b0:489:fe2c:c877 with SMTP id
 o12-20020ac24c4c000000b00489fe2cc877mr15771597lfk.238.1658134595414; 
 Mon, 18 Jul 2022 01:56:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uT17stmgD/4/ICa/9NkCqW44+T43NZzTbYZlFnn5f6GksCmVOwfYnKSj/DtJ2DugQNpv1qMO4BpXj9dv3Brrw=
X-Received: by 2002:ac2:4c4c:0:b0:489:fe2c:c877 with SMTP id
 o12-20020ac24c4c000000b00489fe2cc877mr15771561lfk.238.1658134595164; Mon, 18
 Jul 2022 01:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-39-xuanzhuo@linux.alibaba.com>
 <c0747cbc-685b-85a9-1931-0124124755f2@redhat.com>
 <1656986375.3420787-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEu80KP-ULz_CBvauRk_3XsCubMkkWv0uLnbt-wib5KOnA@mail.gmail.com>
 <1657874178.9766078-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1657874178.9766078-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Jul 2022 16:56:24 +0800
Message-ID: <CACGkMEtF5NSXh-=nnsniLqy0pX2Tpyh413S5Bu5vZ6h=d+aHTA@mail.gmail.com>
Subject: Re: [PATCH v11 38/40] virtio_net: support rx queue resize
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

T24gRnJpLCBKdWwgMTUsIDIwMjIgYXQgNDozNyBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIEZyaSwgOCBKdWwgMjAyMiAxNDoyMDo1MiArMDgw
MCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiBPbiBUdWUsIEp1
bCA1LCAyMDIyIGF0IDEwOjAwIEFNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5j
b20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBNb24sIDQgSnVsIDIwMjIgMTE6NDQ6MTIgKzA4MDAs
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4g
5ZyoIDIwMjIvNi8yOSAxNDo1NiwgWHVhbiBaaHVvIOWGmemBkzoKPiA+ID4gPiA+IFRoaXMgcGF0
Y2ggaW1wbGVtZW50cyB0aGUgcmVzaXplIGZ1bmN0aW9uIG9mIHRoZSByeCBxdWV1ZXMuCj4gPiA+
ID4gPiBCYXNlZCBvbiB0aGlzIGZ1bmN0aW9uLCBpdCBpcyBwb3NzaWJsZSB0byBtb2RpZnkgdGhl
IHJpbmcgbnVtIG9mIHRoZQo+ID4gPiA+ID4gcXVldWUuCj4gPiA+ID4gPgo+ID4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+ID4g
PiA+IC0tLQo+ID4gPiA+ID4gICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAyMiArKysrKysr
KysrKysrKysrKysrKysrCj4gPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25z
KCspCj4gPiA+ID4gPgo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+ID4gaW5kZXggOWZlMjIyYTM2
NjNhLi42YWIxNmZkMTkzZTUgMTAwNjQ0Cj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+
ID4gQEAgLTI3OCw2ICsyNzgsOCBAQCBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPiA+ID4gPiA+
ICAgICBjaGFyIHBhZGRpbmdbMTJdOwo+ID4gPiA+ID4gICB9Owo+ID4gPiA+ID4KPiA+ID4gPiA+
ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3JxX2ZyZWVfdW51c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVl
ICp2cSwgdm9pZCAqYnVmKTsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICAgc3RhdGljIGJvb2wgaXNf
eGRwX2ZyYW1lKHZvaWQgKnB0cikKPiA+ID4gPiA+ICAgewo+ID4gPiA+ID4gICAgIHJldHVybiAo
dW5zaWduZWQgbG9uZylwdHIgJiBWSVJUSU9fWERQX0ZMQUc7Cj4gPiA+ID4gPiBAQCAtMTg0Niw2
ICsxODQ4LDI2IEBAIHN0YXRpYyBuZXRkZXZfdHhfdCBzdGFydF94bWl0KHN0cnVjdCBza19idWZm
ICpza2IsIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4gPiA+ID4gPiAgICAgcmV0dXJuIE5FVERF
Vl9UWF9PSzsKPiA+ID4gPiA+ICAgfQo+ID4gPiA+ID4KPiA+ID4gPiA+ICtzdGF0aWMgaW50IHZp
cnRuZXRfcnhfcmVzaXplKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ID4gPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgIHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSwgdTMyIHJpbmdfbnVt
KQo+ID4gPiA+ID4gK3sKPiA+ID4gPiA+ICsgICBpbnQgZXJyLCBxaW5kZXg7Cj4gPiA+ID4gPiAr
Cj4gPiA+ID4gPiArICAgcWluZGV4ID0gcnEgLSB2aS0+cnE7Cj4gPiA+ID4gPiArCj4gPiA+ID4g
PiArICAgbmFwaV9kaXNhYmxlKCZycS0+bmFwaSk7Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IERv
IHdlIG5lZWQgdG8gY2FuY2VsIHRoZSByZWZpbGwgd29yayBoZXJlPwo+ID4gPgo+ID4gPgo+ID4g
PiBJIHRoaW5rIG5vLCBuYXBpX2Rpc2FibGUgaXMgbXV0dWFsbHkgZXhjbHVzaXZlLCB3aGljaCBl
bnN1cmVzIHRoYXQgdGhlcmUgd2lsbCBiZQo+ID4gPiBubyBjb25mbGljdHMgYmV0d2VlbiB0aGVt
Lgo+ID4KPiA+IFNvIHRoaXMgc291bmRzIHNpbWlsYXIgdG8gd2hhdCBJJ3ZlIGZpeGVkIHJlY2Vu
dGx5Lgo+ID4KPiA+IDEpIE5BUEkgc2NoZWR1bGUgZGVsYXllZCB3b3JrLgo+ID4gMikgd2UgZGlz
YWJsZSBOQVBJIGhlcmUKPiA+IDMpIGRlbGF5ZWQgd29yayBnZXQgc2NoZWR1bGUgYW5kIGNhbGwg
TkFQSSBhZ2Fpbgo+ID4KPiA+ID8KPgo+IFllcywgYnV0IEkgZG9uJ3QgdGhpbmsgdGhlcmUgYXJl
IGFueSBuZWdhdGl2ZSBlZmZlY3RzLgoKQW4gaW5maW5pdGUgd2FpdCBvbiB0aGUgbmFwaV9kaXNh
YmxlKCk/CgpUaGFua3MKCj4KPiBUaGFua3MuCj4KPiA+Cj4gPiBUaGFua3MKPiA+Cj4gPiA+Cj4g
PiA+IFRoYW5rcy4KPiA+ID4KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcwo+ID4gPiA+Cj4gPiA+ID4K
PiA+ID4gPiA+ICsKPiA+ID4gPiA+ICsgICBlcnIgPSB2aXJ0cXVldWVfcmVzaXplKHJxLT52cSwg
cmluZ19udW0sIHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKTsKPiA+ID4gPiA+ICsgICBpZiAo
ZXJyKQo+ID4gPiA+ID4gKyAgICAgICAgICAgbmV0ZGV2X2Vycih2aS0+ZGV2LCAicmVzaXplIHJ4
IGZhaWw6IHJ4IHF1ZXVlIGluZGV4OiAlZCBlcnI6ICVkXG4iLCBxaW5kZXgsIGVycik7Cj4gPiA+
ID4gPiArCj4gPiA+ID4gPiArICAgaWYgKCF0cnlfZmlsbF9yZWN2KHZpLCBycSwgR0ZQX0tFUk5F
TCkpCj4gPiA+ID4gPiArICAgICAgICAgICBzY2hlZHVsZV9kZWxheWVkX3dvcmsoJnZpLT5yZWZp
bGwsIDApOwo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gKyAgIHZpcnRuZXRfbmFwaV9lbmFibGUocnEt
PnZxLCAmcnEtPm5hcGkpOwo+ID4gPiA+ID4gKyAgIHJldHVybiBlcnI7Cj4gPiA+ID4gPiArfQo+
ID4gPiA+ID4gKwo+ID4gPiA+ID4gICAvKgo+ID4gPiA+ID4gICAgKiBTZW5kIGNvbW1hbmQgdmlh
IHRoZSBjb250cm9sIHZpcnRxdWV1ZSBhbmQgY2hlY2sgc3RhdHVzLiAgQ29tbWFuZHMKPiA+ID4g
PiA+ICAgICogc3VwcG9ydGVkIGJ5IHRoZSBoeXBlcnZpc29yLCBhcyBpbmRpY2F0ZWQgYnkgZmVh
dHVyZSBiaXRzLCBzaG91bGQKPiA+ID4gPgo+ID4gPgo+ID4KPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
