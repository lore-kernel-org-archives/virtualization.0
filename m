Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4FDC433EF
	for <virtualization@archiver.kernel.org>; Wed, 30 Mar 2022 06:58:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 848DC409D6;
	Wed, 30 Mar 2022 06:58:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L5mtYMVXQzDw; Wed, 30 Mar 2022 06:58:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0156540B1C;
	Wed, 30 Mar 2022 06:58:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAD0CC002C;
	Wed, 30 Mar 2022 06:58:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D69B0C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:58:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3F27611A4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:58:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FWuUF_4BRCKo
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:58:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E81906118B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648623483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NC+5mcuLR0G9pxga3BEAbS/KMDFEcd18SJ92Wbt+hqI=;
 b=fSRx2J6d5iw2d+41gbEASBku3ZzMnujYyPsP2UB95qPz5bZGlyKG0cUBzZc3kuilnhBeGd
 7QVdTF+QkbGWHV3lchjPbuZpjzEuCC7vI8fXFlUTy+nYaGFWg20xkYb//H4S50jo8tEi1E
 mswFB2BLvLFa8JrEfQfUPFJ7BGeIybQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-axNhcl3JMqKczcjcS1mF_g-1; Wed, 30 Mar 2022 02:58:02 -0400
X-MC-Unique: axNhcl3JMqKczcjcS1mF_g-1
Received: by mail-lj1-f199.google.com with SMTP id
 67-20020a2e0946000000b002493a3be913so8285378ljj.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 23:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NC+5mcuLR0G9pxga3BEAbS/KMDFEcd18SJ92Wbt+hqI=;
 b=G3PsePvpM9fktQnTU/Ujf+03pJYl8kSy/rLUWAvbPDf2MYbJb4NW02dMextsXTyMwk
 5+3gou142v56hRWmP153nq5bwrnotsiPAcNBlHyggmth7XNYkq3SjjrBXh5YQLwSvn/k
 +n6ne//FC7AkGgIZ5ioOjVD4BKZ7Z4EDo1nfWuqzutpuyNoJrPrav08D7VVC4uxNUIco
 M5vjykKvXM/PB07lZ+KwnReUi71He3rL2WxahDyc+Jj+OsCDZWTwGnfFHOX8VAV24gOl
 O2DG6aK3voD1g6eM0iJmt172N45so/mVLjLvUZyz22iTPKrS3fmS5f2tzs5oCPVd8rW9
 Mg0g==
X-Gm-Message-State: AOAM532yuMQ3MHCsYKCmMtbIN+Qvnvh0weL296iMwVlYAbHqFRTkki7Z
 4U0tpUWs9uNU/PHnKO5aENKQknHFdgMRaBNuSP4V/Gax9c6O7XFIbDbWhTtGtnxlCyInEpZ/2gk
 ZHVkXrTnO1ki3JF+qwxDuvoj+HE7m0yIZsSmOoPNwrO3DbFFW3NC0aGBGSA==
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr5653385lfa.210.1648623480813; 
 Tue, 29 Mar 2022 23:58:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXOzzvLf51Mvn+IXO6DuEpJK0knFm/baIhplRoWg6n8GEROXJGl75Ps4jZHQd2dWnZoOx8n3O0eKRfOKU08Mg=
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr5653373lfa.210.1648623480537; Tue, 29
 Mar 2022 23:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
 <20220314093455.34707-11-xuanzhuo@linux.alibaba.com>
 <a75ecf24-6d00-b790-4da8-602205381b1d@redhat.com>
 <1648111444.337551-4-xuanzhuo@linux.alibaba.com>
 <53a42ba3-8111-dd14-40d4-1c1ae077268a@redhat.com>
 <1648620828.6202424-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1648620828.6202424-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 30 Mar 2022 14:57:49 +0800
Message-ID: <CACGkMEv46XN1_z7df0ov-BreSORaMpRfqrr+7yZ-+1yK8WpL5Q@mail.gmail.com>
Subject: Re: [PATCH v8 10/16] virtio_ring: split: implement
 virtqueue_resize_split()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gV2VkLCBNYXIgMzAsIDIwMjIgYXQgMjoxNSBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgMzAgTWFyIDIwMjIgMTE6NDg6MjkgKzA4
MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IOWcqCAy
MDIyLzMvMjQg5LiL5Y2INDo0NCwgWHVhbiBaaHVvIOWGmemBkzoKPiA+ID4gT24gVHVlLCAyMiBN
YXIgMjAyMiAxNDozMDoyOSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4gPiA+PiDlnKggMjAyMi8zLzE0IOS4i+WNiDU6MzQsIFh1YW4gWmh1byDlhpnpgZM6
Cj4gPiA+Pj4gdmlydGlvIHJpbmcgc3BsaXQgc3VwcG9ydHMgcmVzaXplLgo+ID4gPj4+Cj4gPiA+
Pj4gT25seSBhZnRlciB0aGUgbmV3IHZyaW5nIGlzIHN1Y2Nlc3NmdWxseSBhbGxvY2F0ZWQgYmFz
ZWQgb24gdGhlIG5ldyBudW0sCj4gPiA+Pj4gd2Ugd2lsbCByZWxlYXNlIHRoZSBvbGQgdnJpbmcu
IEluIGFueSBjYXNlLCBhbiBlcnJvciBpcyByZXR1cm5lZCwKPiA+ID4+PiBpbmRpY2F0aW5nIHRo
YXQgdGhlIHZyaW5nIHN0aWxsIHBvaW50cyB0byB0aGUgb2xkIHZyaW5nLiBJbiB0aGUgY2FzZSBv
Zgo+ID4gPj4+IGFuIGVycm9yLCB3ZSB3aWxsIHJlLWluaXRpYWxpemUgdGhlIHN0YXRlIG9mIHRo
ZSB2cmluZyB0byBlbnN1cmUgdGhhdAo+ID4gPj4+IHRoZSB2cmluZyBjYW4gYmUgdXNlZC4KPiA+
ID4+Pgo+ID4gPj4+IEluIGFkZGl0aW9uLCB2cmluZ19hbGlnbiwgbWF5X3JlZHVjZV9udW0gYXJl
IG5lY2Vzc2FyeSBmb3IgcmVhbGxvY2F0aW5nCj4gPiA+Pj4gdnJpbmcsIHNvIHRoZXkgYXJlIHJl
dGFpbmVkIGZvciBjcmVhdGluZyB2cS4KPiA+ID4+Pgo+ID4gPj4+IFNpZ25lZC1vZmYtYnk6IFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+Pj4gLS0tCj4gPiA+Pj4g
ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDYyICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKwo+ID4gPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA2MiBpbnNlcnRpb25z
KCspCj4gPiA+Pj4KPiA+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4+PiBpbmRleCA4MWJiZmQ2
NTQxMWUuLmExNTg2OTUxNDE0NiAxMDA2NDQKPiA+ID4+PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jCj4gPiA+Pj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+
ID4gPj4+IEBAIC0xMzksNiArMTM5LDEyIEBAIHN0cnVjdCB2cmluZ192aXJ0cXVldWUgewo+ID4g
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogRE1BIGFkZHJlc3MgYW5kIHNpemUgaW5m
b3JtYXRpb24gKi8KPiA+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIGRtYV9hZGRyX3Qg
cXVldWVfZG1hX2FkZHI7Cj4gPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplX3Qg
cXVldWVfc2l6ZV9pbl9ieXRlczsKPiA+ID4+PiArCj4gPiA+Pj4gKyAgICAgICAgICAgICAgICAg
LyogVGhlIHBhcmFtZXRlcnMgZm9yIGNyZWF0aW5nIHZyaW5ncyBhcmUgcmVzZXJ2ZWQgZm9yCj4g
PiA+Pj4gKyAgICAgICAgICAgICAgICAgICogY3JlYXRpbmcgbmV3IHZyaW5ncyB3aGVuIGVuYWJs
aW5nIHJlc2V0IHF1ZXVlLgo+ID4gPj4+ICsgICAgICAgICAgICAgICAgICAqLwo+ID4gPj4+ICsg
ICAgICAgICAgICAgICAgIHUzMiB2cmluZ19hbGlnbjsKPiA+ID4+PiArICAgICAgICAgICAgICAg
ICBib29sIG1heV9yZWR1Y2VfbnVtOwo+ID4gPj4+ICAgICAgICAgICAgICAgICAgIH0gc3BsaXQ7
Cj4gPiA+Pj4KPiA+ID4+PiAgICAgICAgICAgICAgICAgICAvKiBBdmFpbGFibGUgZm9yIHBhY2tl
ZCByaW5nICovCj4gPiA+Pj4gQEAgLTE5OCw2ICsyMDQsMTYgQEAgc3RydWN0IHZyaW5nX3ZpcnRx
dWV1ZSB7Cj4gPiA+Pj4gICAgI2VuZGlmCj4gPiA+Pj4gICAgfTsKPiA+ID4+Pgo+ID4gPj4+ICtz
dGF0aWMgdm9pZCBfX3ZyaW5nX2ZyZWUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKTsKPiA+ID4+PiAr
c3RhdGljIHZvaWQgX192cmluZ192aXJ0cXVldWVfaW5pdF9zcGxpdChzdHJ1Y3QgdnJpbmdfdmly
dHF1ZXVlICp2cSwKPiA+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KTsKPiA+ID4+PiArc3RhdGljIHZvaWQgX192cmluZ192
aXJ0cXVldWVfYXR0YWNoX3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ID4gPj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdnJpbmcgdnJpbmcs
Cj4gPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2cmlu
Z19kZXNjX3N0YXRlX3NwbGl0ICpkZXNjX3N0YXRlLAo+ID4gPj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdnJpbmdfZGVzY19leHRyYSAqZGVzY19leHRyYSk7
Cj4gPiA+Pj4gK3N0YXRpYyBpbnQgX192cmluZ19hbGxvY19zdGF0ZV9leHRyYV9zcGxpdCh1MzIg
bnVtLAo+ID4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
dnJpbmdfZGVzY19zdGF0ZV9zcGxpdCAqKmRlc2Nfc3RhdGUsCj4gPiA+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2cmluZ19kZXNjX2V4dHJhICoqZGVzY19l
eHRyYSk7Cj4gPiA+Pj4KPiA+ID4+PiAgICAvKgo+ID4gPj4+ICAgICAqIEhlbHBlcnMuCj4gPiA+
Pj4gQEAgLTk5MSw2ICsxMDA3LDggQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2Ny
ZWF0ZV92aXJ0cXVldWVfc3BsaXQoCj4gPiA+Pj4gICAgICAgICAgICAgICAgICAgcmV0dXJuIE5V
TEw7Cj4gPiA+Pj4gICAgICAgICAgIH0KPiA+ID4+Pgo+ID4gPj4+ICsgdG9fdnZxKHZxKS0+c3Bs
aXQudnJpbmdfYWxpZ24gPSB2cmluZ19hbGlnbjsKPiA+ID4+PiArIHRvX3Z2cSh2cSktPnNwbGl0
Lm1heV9yZWR1Y2VfbnVtID0gbWF5X3JlZHVjZV9udW07Cj4gPiA+Pj4gICAgICAgICAgIHRvX3Z2
cSh2cSktPnNwbGl0LnF1ZXVlX2RtYV9hZGRyID0gZG1hX2FkZHI7Cj4gPiA+Pj4gICAgICAgICAg
IHRvX3Z2cSh2cSktPnNwbGl0LnF1ZXVlX3NpemVfaW5fYnl0ZXMgPSBxdWV1ZV9zaXplX2luX2J5
dGVzOwo+ID4gPj4+ICAgICAgICAgICB0b192dnEodnEpLT53ZV9vd25fcmluZyA9IHRydWU7Cj4g
PiA+Pj4gQEAgLTk5OCw2ICsxMDE2LDUwIEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmlu
Z19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+ID4gPj4+ICAgICAgICAgICByZXR1cm4gdnE7Cj4g
PiA+Pj4gICAgfQo+ID4gPj4+Cj4gPiA+Pj4gK3N0YXRpYyBpbnQgdmlydHF1ZXVlX3Jlc2l6ZV9z
cGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsIHUzMiBudW0pCj4gPiA+Pj4gK3sKPiA+ID4+PiAr
IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gPiA+Pj4gKyBzdHJ1
Y3QgdmlydGlvX2RldmljZSAqdmRldiA9IF92cS0+dmRldjsKPiA+ID4+PiArIHN0cnVjdCB2cmlu
Z19kZXNjX3N0YXRlX3NwbGl0ICpzdGF0ZTsKPiA+ID4+PiArIHN0cnVjdCB2cmluZ19kZXNjX2V4
dHJhICpleHRyYTsKPiA+ID4+PiArIHNpemVfdCBxdWV1ZV9zaXplX2luX2J5dGVzOwo+ID4gPj4+
ICsgZG1hX2FkZHJfdCBkbWFfYWRkcjsKPiA+ID4+PiArIHN0cnVjdCB2cmluZyB2cmluZzsKPiA+
ID4+PiArIGludCBlcnIgPSAtRU5PTUVNOwo+ID4gPj4+ICsgdm9pZCAqcXVldWU7Cj4gPiA+Pj4g
Kwo+ID4gPj4+ICsgQlVHX09OKCF2cS0+d2Vfb3duX3JpbmcpOwo+ID4gPj4KPiA+ID4+IEkgZG9u
J3Qgc2VlIGFueSBjaGVja3MgaW4gdmlydHF1ZXVlX3Jlc2l6ZSgpLiBTbyBJIHRoaW5rIGl0J3Mg
YmV0dGVyIHRvCj4gPiA+PiBlaXRoZXIKPiA+ID4+Cj4gPiA+PiAxKSByZXR1cm4gLUVJTlZBTCBo
ZXJlCj4gPiA+Pgo+ID4gPj4gb3IKPiA+ID4+Cj4gPiA+PiAyKSBhZGQgYSBjaGVjayBpbiB2aXJ0
cXVldWVfcmVzaXplIGFuZCBmYWlsIHRoZXJlCj4gPiA+Pgo+ID4gPj4KPiA+ID4+PiArCj4gPiA+
Pj4gKyBxdWV1ZSA9IHZyaW5nX2FsbG9jX3F1ZXVlX3NwbGl0KHZkZXYsICZkbWFfYWRkciwgJm51
bSwKPiA+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnEtPnNwbGl0LnZy
aW5nX2FsaWduLAo+ID4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2cS0+
d2Vha19iYXJyaWVycywKPiA+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dnEtPnNwbGl0Lm1heV9yZWR1Y2VfbnVtKTsKPiA+ID4+PiArIGlmICghcXVldWUpCj4gPiA+Pj4g
KyAgICAgICAgIGdvdG8gaW5pdDsKPiA+ID4+PiArCj4gPiA+Pj4gKyBxdWV1ZV9zaXplX2luX2J5
dGVzID0gdnJpbmdfc2l6ZShudW0sIHZxLT5zcGxpdC52cmluZ19hbGlnbik7Cj4gPiA+Pj4gKwo+
ID4gPj4+ICsgZXJyID0gX192cmluZ19hbGxvY19zdGF0ZV9leHRyYV9zcGxpdChudW0sICZzdGF0
ZSwgJmV4dHJhKTsKPiA+ID4+PiArIGlmIChlcnIpIHsKPiA+ID4+PiArICAgICAgICAgdnJpbmdf
ZnJlZV9xdWV1ZSh2ZGV2LCBxdWV1ZV9zaXplX2luX2J5dGVzLCBxdWV1ZSwgZG1hX2FkZHIpOwo+
ID4gPj4+ICsgICAgICAgICBnb3RvIGluaXQ7Cj4gPiA+Pj4gKyB9Cj4gPiA+Pj4gKwo+ID4gPj4+
ICsgX192cmluZ19mcmVlKCZ2cS0+dnEpOwo+ID4gPj4+ICsKPiA+ID4+PiArIHZyaW5nX2luaXQo
JnZyaW5nLCBudW0sIHF1ZXVlLCB2cS0+c3BsaXQudnJpbmdfYWxpZ24pOwo+ID4gPj4+ICsgX192
cmluZ192aXJ0cXVldWVfYXR0YWNoX3NwbGl0KHZxLCB2cmluZywgc3RhdGUsIGV4dHJhKTsKPiA+
ID4+Cj4gPiA+PiBJIHdvbmRlciBpZiB3ZSBuZWVkIGEgc3ltbWV0cmljIHZpcnRxdWV1ZV9yZXNp
emVfZGV0YWNoKCkgaW50ZXJuYWwgaGVscGVyLgo+ID4gPiBJIHRoaW5rIF9fdnJpbmdfZnJlZSgp
IGlzIHNvbWV3aGF0IHNpbWlsYXIgdG8gd2hhdCB5b3Ugc2FpZCBhYm91dAo+ID4gPiB2aXJ0cXVl
dWVfcmVzaXplX2RldGFjaCgpIC4KPiA+Cj4gPgo+ID4gU28gZnJvbSB3aGF0IEknbSB1bmRlcnN0
YW5kaW5nIHRoZSBjb2RlLCB0aGUga2V5IHBvaW50IGZvciBhdHRhY2hpbmcgaXM6Cj4gPgo+ID4g
ICAgICAgICAgdnEtPnNwbGl0LnZyaW5nID0gdnJpbmc7Cj4gPgo+ID4gQnV0IHRoaXMgaXMgbm90
IHdoYXQgX192cmluZ19mcmVlKCkgZGlkLCBpdCBqdXN0IGZyZWUgdGhlIHJlc291cmNlcy4KPgo+
IE9LLgo+Cj4gPgo+ID4KPiA+ID4KPiA+ID4+Cj4gPiA+Pj4gKyB2cS0+c3BsaXQucXVldWVfZG1h
X2FkZHIgPSBkbWFfYWRkcjsKPiA+ID4+PiArIHZxLT5zcGxpdC5xdWV1ZV9zaXplX2luX2J5dGVz
ID0gcXVldWVfc2l6ZV9pbl9ieXRlczsKPiA+ID4+PiArCj4gPiA+Pj4gKyBlcnIgPSAwOwo+ID4g
Pj4+ICsKPiA+ID4+PiAraW5pdDoKPiA+ID4+PiArIF9fdnJpbmdfdmlydHF1ZXVlX2luaXRfc3Bs
aXQodnEsIHZkZXYpOwo+ID4gPj4+ICsgdnEtPndlX293bl9yaW5nID0gdHJ1ZTsKPiA+ID4+Cj4g
PiA+PiBUaGVuIHdlIGNhbiBsZWF2ZSB0aGlzIHVuY2hhbmdlZC4KPiA+ID4gSSB0aGluayB5b3Ug
bWVhbiAidnEtPndlX293bl9yaW5nID0gdHJ1ZSI7Cj4gPiA+Cj4gPiA+IFRoZSByZWFzb24gZm9y
IG1vZGlmeWluZyB3ZV9vd25fcmluZyBhbG9uZSBpcyB0aGF0IGluIHRoZSBnZW5lcmFsIHByb2Nl
c3Mgb2YKPiA+ID4gY3JlYXRpbmcgYSByaW5nLCBfX3ZyaW5nX3ZpcnRxdWV1ZV9pbml0X3NwbGl0
IGlzIGNhbGxlZCBpbgo+ID4gPiBfX3ZyaW5nX25ld192aXJ0cXVldWUuIEF0IHRoaXMgdGltZSwg
d2Vfb3duX3JpbmcgaXMgZmFsc2UuCj4gPiA+IHZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfc3BsaXQg
d2lsbCBjaGFuZ2UgaXQgdG8gdHJ1ZS4gU28gYWZ0ZXIgY2FsbGluZwo+ID4gPiBfX3ZyaW5nX3Zp
cnRxdWV1ZV9pbml0X3NwbGl0IGFsb25lLCB3ZV9vd25fcmluZyBpcyBmYWxzZS4KPiA+ID4KPiA+
ID4gSSB0aGluayBpdCdzIHBvc3NpYmxlIHRvIHdyYXAgX192cmluZ192aXJ0cXVldWVfaW5pdF9z
cGxpdCgpIGFnYWluCj4gPiA+Cj4gPiA+IHN0YXRpYyB2b2lkIHZyaW5nX3ZpcnRxdWV1ZV9pbml0
X3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ID4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPiA+IHsK
PiA+ID4gICAgIF9fdnJpbmdfdmlydHF1ZXVlX2luaXRfc3BsaXQodnEsIHZkZXYpOwo+ID4gPiAg
ICAgdnEtPndlX293bl9yaW5nID0gdHJ1ZTsKPiA+ID4gfQo+ID4gPgo+ID4gPiBJcyB0aGlzIHdo
YXQgeW91IHdhbnQ/Cj4gPgo+ID4KPiA+IE5vcGUsIEkgbWVhbnQgdGhlcmUgYXJlIHNvbWUgdHJh
bnNwb3J0cyB0aGF0IGFsbG9jYXRlIHRoZSB2cmluZyBieQo+ID4gdGhlbXNlbHZlcywgd2UgY2Fu
J3QgcmVzaXplIHRob3NlIHZyaW5nLgo+ID4KPiA+IFNlZSB0aGUgY2FsbGVycyBvZiB2cmluZ19u
ZXdfdmlydHF1ZXVlKCkKPgo+IFNvLCB5b3UgbWVhbiwgZG8gbm90IGltcGxlbWVudCByZXNpemUg
Zm9yIHdlX293bl9yaW5nIGlzIGZhbHNlLgoKWWVzLCBJIHRoaW5rIHNvLiBUaGlzIGlzIGJlY2F1
c2UgdGhlIHZyaW5nIGlzIG5vdCBhbGxvY2F0ZWQgYnkgdXMsCmV2ZW4gaWYgd2UgcmVzaXplIHRo
ZXJlJ3Mgbm8gd2F5IGZvciB0aGUgdXNlciB0byBrbm93IGFib3V0IHRoYXQuCgpUaGFua3MKCj4K
PiBUaGFua3MuCj4KPiA+Cj4gPiBUaGFua3MKPiA+Cj4gPgo+ID4gPgo+ID4gPiBUaGFua3MuCj4g
PiA+Cj4gPiA+Cj4gPiA+PiBUaGFua3MKPiA+ID4+Cj4gPiA+Pgo+ID4gPj4+ICsgcmV0dXJuIGVy
cjsKPiA+ID4+PiArfQo+ID4gPj4+ICsKPiA+ID4+Pgo+ID4gPj4+ICAgIC8qCj4gPiA+Pj4gICAg
ICogUGFja2VkIHJpbmcgc3BlY2lmaWMgZnVuY3Rpb25zIC0gKl9wYWNrZWQoKS4KPiA+Cj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
