Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681E4C25B06
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 02:36:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCD9182CFD;
	Thu, 28 Jul 2022 02:36:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CCD9182CFD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TmTlgIkb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vDR99aczEqPm; Thu, 28 Jul 2022 02:36:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2D75882C91;
	Thu, 28 Jul 2022 02:36:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D75882C91
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDE9CC0033;
	Thu, 28 Jul 2022 02:36:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C99E9C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 02:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 926E140A35
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 02:36:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 926E140A35
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TmTlgIkb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p507yqJKSdSO
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 02:36:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AFEEA400D1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AFEEA400D1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 02:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658975804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JKkkMBWIpIIe2oTOsj/mSHWBLF5WPUCRKemqNyKpd7k=;
 b=TmTlgIkbBMG1b4ywUgrV9bDsUcSn/ZQJgiNx/Csi9PEjKGqFl4UVoXI8o6nUYGxqlRQzFE
 CEPBrz06uC6qSV8V7Y2dfMOCMbvNfRvV7aO2f/0h77y24CMnTgAdT9DIYb4Rf0653xiucp
 Ofd8H/TQvCKeiTKQeK2ZGqIeh+IUWqg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-I7JyhdHFNQeaK-xtqVUgkg-1; Wed, 27 Jul 2022 22:36:41 -0400
X-MC-Unique: I7JyhdHFNQeaK-xtqVUgkg-1
Received: by mail-ej1-f69.google.com with SMTP id
 ji2-20020a170907980200b0072b5b6d60c2so123952ejc.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 19:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JKkkMBWIpIIe2oTOsj/mSHWBLF5WPUCRKemqNyKpd7k=;
 b=Z8vXkx2gzUWxHjpLK0wMNnYgtdpi1dKZrFgM+qI/Rzu3/xC8BREwJZYPfoAb4DhaaR
 ax+6HEOQmheqXKbkGkAKfPg3fGkqPEkrCjXbVAdGxcZo5N4P1RZxAHmB5/1xXxZFaYkm
 CtCCt9nToZBZtQUe5HNBAQd6te44cefpEIA84lzeb3kEGWljEsR4gcIlAgyzA40nT34A
 nm9LxpSocuHhQxbsT/PS6K8VgRukBVeL615rwXMTdKqz9/CMbZ0YTg4jPualJWq4BLgI
 rzViBC/nGGy7TlCfj5RUa/NEgjzjWMKpb2hVi5+eGDuBqW3oL/qMm7arTBX1iN5MNqMA
 bqag==
X-Gm-Message-State: AJIora8dICExYTdh8L3illbNj2I28IloXUgAr7Q57z3yaxTbKZhGbZdw
 gA3iezdlyESJHt4BXiTFKxiQq0DbtFCKQu2Cr6sg0/Yc6y42E9H1aHKYteLsVK+ijDAqk9k6zfk
 pN+0gACvyMGb57HMT1JSERtKEY9eyMhaiFjbBgttZ94oY+PBZ4QXACZer3w==
X-Received: by 2002:a17:907:a063:b0:72b:52f7:feea with SMTP id
 ia3-20020a170907a06300b0072b52f7feeamr20017153ejc.740.1658975799929; 
 Wed, 27 Jul 2022 19:36:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uGPEobsHGsN+6u62z1/vXP5Tu4y+DTY3UAmlLElWTmVhegB4KOwUXCDIsRewcmE149sdCA2s8SYedOFlVJtFU=
X-Received: by 2002:a17:907:a063:b0:72b:52f7:feea with SMTP id
 ia3-20020a170907a06300b0072b52f7feeamr20017130ejc.740.1658975799433; Wed, 27
 Jul 2022 19:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-8-xuanzhuo@linux.alibaba.com>
 <a5449e49-ba38-9760-ac07-cfad048bc602@redhat.com>
 <1658907340.34387-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1658907340.34387-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Jul 2022 10:36:28 +0800
Message-ID: <CACGkMEuP8e3znP9ZjsoHbzTFZPRt25nHVam390yrwEsLPCH+YQ@mail.gmail.com>
Subject: Re: [PATCH v13 07/42] virtio_ring: split: stop __vring_new_virtqueue
 as export symbol
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

T24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMzozNiBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgMjcgSnVsIDIwMjIgMTA6NTg6MDUgKzA4
MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IOWcqCAy
MDIyLzcvMjYgMTU6MjEsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPiA+IFRoZXJlIGlzIGN1cnJlbnRs
eSBvbmx5IG9uZSBwbGFjZSB0byByZWZlcmVuY2UgX192cmluZ19uZXdfdmlydHF1ZXVlKCkKPiA+
ID4gZGlyZWN0bHkgZnJvbSB0aGUgb3V0c2lkZSBvZiB2aXJ0aW8gY29yZS4gQW5kIGhlcmUgdnJp
bmdfbmV3X3ZpcnRxdWV1ZSgpCj4gPiA+IGNhbiBiZSB1c2VkIGluc3RlYWQuCj4gPiA+Cj4gPiA+
IFN1YnNlcXVlbnQgcGF0Y2hlcyB3aWxsIG1vZGlmeSBfX3ZyaW5nX25ld192aXJ0cXVldWUsIHNv
IHN0b3AgaXQgYXMgYW4KPiA+ID4gZXhwb3J0IHN5bWJvbCBmb3Igbm93Lgo+ID4gPgo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4g
PiAtLS0KPiA+ID4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMjUgKysrKysrKysr
KysrKysrKy0tLS0tLS0tLQo+ID4gPiAgIGluY2x1ZGUvbGludXgvdmlydGlvX3JpbmcuaCAgfCAx
MCAtLS0tLS0tLS0tCj4gPiA+ICAgdG9vbHMvdmlydGlvL3ZpcnRpb190ZXN0LmMgICB8ICA0ICsr
LS0KPiA+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9u
cygtKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
YyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4gaW5kZXggMGFkMzVlY2EwZDM5
Li40ZTU0ZWQ3ZWU3ZmIgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19y
aW5nLmMKPiA+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiBAQCAt
MjA0LDYgKzIwNCwxNCBAQCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlIHsKPiA+ID4gICAjZW5kaWYK
PiA+ID4gICB9Owo+ID4gPgo+ID4gPiArc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdf
bmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdnJpbmcgdnJpbmcsCj4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmlydGlvX2Rldmlj
ZSAqdmRldiwKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGJvb2wgd2Vha19iYXJyaWVycywKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGJvb2wgY29udGV4dCwKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGJvb2wgKCpub3RpZnkpKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICgqY2Fs
bGJhY2spKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpuYW1lKTsKPiA+ID4KPiA+ID4gICAvKgo+
ID4gPiAgICAqIEhlbHBlcnMuCj4gPiA+IEBAIC0yMTk3LDE0ICsyMjA1LDE0IEBAIGlycXJldHVy
bl90IHZyaW5nX2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpfdnEpCj4gPiA+ICAgRVhQT1JUX1NZ
TUJPTF9HUEwodnJpbmdfaW50ZXJydXB0KTsKPiA+ID4KPiA+ID4gICAvKiBPbmx5IGF2YWlsYWJs
ZSBmb3Igc3BsaXQgcmluZyAqLwo+ID4gPiAtc3RydWN0IHZpcnRxdWV1ZSAqX192cmluZ19uZXdf
dmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiA+ID4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IHZyaW5nIHZyaW5nLAo+ID4gPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwKPiA+ID4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCB3ZWFrX2JhcnJpZXJzLAo+ID4g
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGNvbnRleHQsCj4gPiA+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgKCpub3RpZnkpKHN0cnVj
dCB2aXJ0cXVldWUgKiksCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHZvaWQgKCpjYWxsYmFjaykoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiA+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqbmFtZSkKPiA+ID4gK3N0YXRpYyBz
dHJ1Y3QgdmlydHF1ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4
LAo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHZyaW5nIHZyaW5nLAo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHdlYWtfYmFycmllcnMsCj4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGNvbnRleHQsCj4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sICgqbm90aWZ5
KShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdm9pZCAoKmNhbGxiYWNrKShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+ID4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAq
bmFtZSkKPiA+ID4gICB7Cj4gPiA+ICAgICBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cTsKPiA+
ID4KPiA+ID4gQEAgLTIyNzIsNyArMjI4MCw2IEBAIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdf
bmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gPiA+ICAgICBrZnJlZSh2cSk7Cj4g
PiA+ICAgICByZXR1cm4gTlVMTDsKPiA+ID4gICB9Cj4gPiA+IC1FWFBPUlRfU1lNQk9MX0dQTChf
X3ZyaW5nX25ld192aXJ0cXVldWUpOwo+ID4gPgo+ID4gPiAgIHN0cnVjdCB2aXJ0cXVldWUgKnZy
aW5nX2NyZWF0ZV92aXJ0cXVldWUoCj4gPiA+ICAgICB1bnNpZ25lZCBpbnQgaW5kZXgsCj4gPiA+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19yaW5nLmggYi9pbmNsdWRlL2xpbnV4
L3ZpcnRpb19yaW5nLmgKPiA+ID4gaW5kZXggYjQ4NWIxM2ZhNTBiLi44YjhhZjFhMzg5OTEgMTAw
NjQ0Cj4gPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvX3JpbmcuaAo+ID4gPiArKysgYi9p
bmNsdWRlL2xpbnV4L3ZpcnRpb19yaW5nLmgKPiA+ID4gQEAgLTc2LDE2ICs3Niw2IEBAIHN0cnVj
dCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+
ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAoKmNhbGxiYWNr
KShzdHJ1Y3QgdmlydHF1ZXVlICp2cSksCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBjb25zdCBjaGFyICpuYW1lKTsKPiA+ID4KPiA+ID4gLS8qIENyZWF0ZXMgYSB2
aXJ0cXVldWUgd2l0aCBhIGN1c3RvbSBsYXlvdXQuICovCj4gPiA+IC1zdHJ1Y3QgdmlydHF1ZXVl
ICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+ID4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdnJpbmcgdnJpbmcsCj4gPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2
ZGV2LAo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHdlYWtf
YmFycmllcnMsCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wg
Y3R4LAo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sICgqbm90
aWZ5KShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB2b2lkICgqY2FsbGJhY2spKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKm5hbWUpOwo+ID4g
PiAtCj4gPiA+ICAgLyoKPiA+ID4gICAgKiBDcmVhdGVzIGEgdmlydHF1ZXVlIHdpdGggYSBzdGFu
ZGFyZCBsYXlvdXQgYnV0IGEgY2FsbGVyLWFsbG9jYXRlZAo+ID4gPiAgICAqIHJpbmcuCj4gPiA+
IGRpZmYgLS1naXQgYS90b29scy92aXJ0aW8vdmlydGlvX3Rlc3QuYyBiL3Rvb2xzL3ZpcnRpby92
aXJ0aW9fdGVzdC5jCj4gPiA+IGluZGV4IDIzZjE0MmFmNTQ0YS4uODZhNDEwZGRjZWRkIDEwMDY0
NAo+ID4gPiAtLS0gYS90b29scy92aXJ0aW8vdmlydGlvX3Rlc3QuYwo+ID4gPiArKysgYi90b29s
cy92aXJ0aW8vdmlydGlvX3Rlc3QuYwo+ID4gPiBAQCAtMTAyLDggKzEwMiw4IEBAIHN0YXRpYyB2
b2lkIHZxX3Jlc2V0KHN0cnVjdCB2cV9pbmZvICppbmZvLCBpbnQgbnVtLCBzdHJ1Y3QgdmlydGlv
X2RldmljZSAqdmRldikKPiA+ID4KPiA+ID4gICAgIG1lbXNldChpbmZvLT5yaW5nLCAwLCB2cmlu
Z19zaXplKG51bSwgNDA5NikpOwo+ID4gPiAgICAgdnJpbmdfaW5pdCgmaW5mby0+dnJpbmcsIG51
bSwgaW5mby0+cmluZywgNDA5Nik7Cj4gPgo+ID4KPiA+IExldCdzIHJlbW92ZSB0aGUgZHVwbGlj
YXRlZCB2cmluZ19pbml0KCkgaGVyZS4KPiA+Cj4gPiBXaXRoIHRoaXMgcmVtb3ZlZDoKPgo+IFRo
ZSByZWFzb24gSSBkaWRuJ3QgZGVsZXRlIHRoaXMgdnJpbmdfaW5pdCgpIGlzIGJlY2F1c2UgaW5m
by0+dnJpbmcgaXMgdXNlZAo+IGVsc2V3aGVyZS4gU28gaXQgY2FuJ3QgYmUgZGVsZXRlZCBkaXJl
Y3RseS4KCk9rLCBzbyB3ZSBjYW4gbGVhdmUgaXQgZm9yIGZ1dHVyZSByZWZhY3RvcmluZy4KCkFj
a2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+Cj4gVGhh
bmtzLgo+Cj4gPgo+ID4gQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
Cj4gPgo+ID4KPiA+ID4gLSAgIGluZm8tPnZxID0gX192cmluZ19uZXdfdmlydHF1ZXVlKGluZm8t
PmlkeCwgaW5mby0+dnJpbmcsIHZkZXYsIHRydWUsCj4gPiA+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBmYWxzZSwgdnFfbm90aWZ5LCB2cV9jYWxsYmFjaywgInRlc3QiKTsK
PiA+ID4gKyAgIGluZm8tPnZxID0gdnJpbmdfbmV3X3ZpcnRxdWV1ZShpbmZvLT5pZHgsIG51bSwg
NDA5NiwgdmRldiwgdHJ1ZSwgZmFsc2UsCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaW5mby0+cmluZywgdnFfbm90aWZ5LCB2cV9jYWxsYmFjaywgInRlc3QiKTsKPiA+
ID4gICAgIGFzc2VydChpbmZvLT52cSk7Cj4gPiA+ICAgICBpbmZvLT52cS0+cHJpdiA9IGluZm87
Cj4gPiA+ICAgfQo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
