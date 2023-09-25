Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5E8CE7A8B
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 02:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49E3381AD7;
	Mon, 25 Sep 2023 02:35:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49E3381AD7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bK/t0VhL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9SiItskBIgbV; Mon, 25 Sep 2023 02:35:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CC3DF81A6A;
	Mon, 25 Sep 2023 02:35:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC3DF81A6A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BBB2C0039;
	Mon, 25 Sep 2023 02:35:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21065C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 02:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE38F40933
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 02:35:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE38F40933
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bK/t0VhL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rRpFEI_hlA-q
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 02:35:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DEBD64092A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 02:35:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DEBD64092A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695609309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJDDBFzzf0f976aKgGjgkxn+o0F4gwbckCrIwzls0H4=;
 b=bK/t0VhLfu+2njKTVJEqxiMAIPWL7n0W+dt48SHp4C7IHSQXp04mlbI2cRzYug6boY1/ye
 5RBXr8gbhpDe6NGZ8lSxSXciH0vBjzNh4v5SozG4KdEl+c4fCnHezPqO88Lpe+Y3jOz/pq
 IHAeAeMq2Gpk6ctjscBEVlD57Le61LA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-VYdXUP1oOVOXjWO39CXCVA-1; Sun, 24 Sep 2023 22:35:07 -0400
X-MC-Unique: VYdXUP1oOVOXjWO39CXCVA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5041ae34ce4so6894217e87.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Sep 2023 19:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609306; x=1696214106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DJDDBFzzf0f976aKgGjgkxn+o0F4gwbckCrIwzls0H4=;
 b=pyhHXE//6UzRG7G3AMryGd3gRpyIKTNO/dPkVhZkuaXB3FBoP2zo9ZS9lL5dYmgLlr
 YgB8ib7ySrdsePNTKE8tLtL82k5HhI+k6I/6MK8hNBaJ7FfT542tHkHnj1DuoWZYnYKF
 nnlMUra5jBzz6o9DyYpXk31xYq7JK/8PNfzlpcLQKPBJcVUyV0KwBedpnPARf46CEUOJ
 TfBbP7O4HjK8FSxNkSq/o9vriV+tu2xzXTYE+r8oYa5txrVRA0SWtBlcKgYFeu3XoVRV
 64M+qoh00UJlMWP1E4A0yWnorGTcFeLZhNpkNe7v82CkUHxQOm07zuv51ny7inhto9Vv
 yJMw==
X-Gm-Message-State: AOJu0Ywg0fVI6JJ5F0HASUb+6McF8f8bnb13BJ9QiA8A3KfHDX5VXh5r
 RKPkzLGdWKJ89JB3r02Me8lFk9xmKQ8E8mFSRyuYQNoRgtUapBcKlaziD1oiXCDEw46UF6T5OAa
 BvQUWGh+3dSm5mpas2PKCT8tLgg3aQU/K5cSu8ceJhCg/tUp8geXrDIMY0Q==
X-Received: by 2002:a05:6512:78f:b0:4f9:5519:78b8 with SMTP id
 x15-20020a056512078f00b004f9551978b8mr4313437lfr.63.1695609306084; 
 Sun, 24 Sep 2023 19:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7ePPnscYK9n57PETbG37KL/UR7SLgpvhXvkhZD4U2cOFzvg7U2Z7qqf18PhQy9Ne5wwUAakW+Lil2KUHmN5U=
X-Received: by 2002:a05:6512:78f:b0:4f9:5519:78b8 with SMTP id
 x15-20020a056512078f00b004f9551978b8mr4313419lfr.63.1695609305728; Sun, 24
 Sep 2023 19:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921090844-mutt-send-email-mst@kernel.org>
 <20230921141125.GM13733@nvidia.com>
 <20230921101509-mutt-send-email-mst@kernel.org>
 <20230921164139.GP13733@nvidia.com>
 <20230921124331-mutt-send-email-mst@kernel.org>
 <20230921183926.GV13733@nvidia.com>
 <20230921150448-mutt-send-email-mst@kernel.org>
 <20230921194946.GX13733@nvidia.com>
 <CACGkMEvMP05yTNGE5dBA2-M0qX-GXFcdGho7_T5NR6kAEq9FNg@mail.gmail.com>
 <20230922121132.GK13733@nvidia.com>
In-Reply-To: <20230922121132.GK13733@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Sep 2023 10:34:54 +0800
Message-ID: <CACGkMEsxgYERbyOPU33jTQuPDLUur5jv033CQgK9oJLW+ueG8w@mail.gmail.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
To: Jason Gunthorpe <jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 maorg@nvidia.com, virtualization@lists.linux-foundation.org, jiri@nvidia.com,
 leonro@nvidia.com
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

T24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgODoxMeKAr1BNIEphc29uIEd1bnRob3JwZSA8amdnQG52
aWRpYS5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgMTE6MDE6MjNBTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPgo+ID4gPiBFdmVuIHdoZW4gaXQgZG9lcywgdGhlcmUg
aXMgbm8gcmVhbCB1c2UgY2FzZSB0byBsaXZlIG1pZ3JhdGUgYQo+ID4gPiB2aXJ0aW8tbmV0IGZ1
bmN0aW9uIGZyb20sIHNheSwgQVdTIHRvIEdDUC4KPiA+Cj4gPiBJdCBjYW4gaGFwcGVuIGluc2lk
ZSBhIHNpbmdsZSBjbG91ZCB2ZW5kb3IuIEZvciBzb21lIHJlYXNvbnMsIERQVSBtdXN0Cj4gPiBi
ZSBwdXJjaGFzZWQgZnJvbSBkaWZmZXJlbnQgdmVuZG9ycy4gQW5kIHZEUEEgaGFzIGJlZW4gdXNl
ZCBpbiB0aGF0Cj4gPiBjYXNlLgo+Cj4gTm9wZSwgeW91IG1pc3VuZGVyc3RhbmQgdGhlIERQVSBz
Y2VuYXJpby4KPgo+IExvb2sgYXQgc29tZXRoaW5nIGxpa2Ugdm13YXJlIERQVSBlbmFibGVtZW50
LiB2bXdhcmUgcnVucyB0aGUgc29mdHdhcmUKPiBzaWRlIG9mIHRoZSBEUFUgYW5kIGFsbCB0aGVp
ciBzdXBwb3J0ZWQgRFBVIEhXLCBmcm9tIGV2ZXJ5IHZlbmRvciwKPiBnZW5lcmF0ZXMgdGhlIHNh
bWUgUENJIGZ1bmN0aW9ucyBvbiB0aGUgeDg2LiBUaGV5IGFyZSB0aGUgc2FtZSBiZWNhdXNlCj4g
dGhlIHNhbWUgc29mdHdhcmUgb24gdGhlIERQVSBzaWRlIGlzIGNyZWF0aW5nIHRoZW0uCj4KPiBU
aGVyZSBpcyBubyByZWFzb24gdG8gcHV0IGEgbWVkaWF0aW9uIGxheWVyIGluIHRoZSB4ODYgaWYg
eW91IGFsc28KPiBjb250cm9sIHRoZSBEUFUuCj4KPiBDbG91ZCB2ZW5kb3JzIHdpbGwgc2ltaWxh
cmx5IHVzZSBEUFVzIHRvIGNyZWF0ZSBhIFBDSSBmdW5jdGlvbnMgdGhhdAo+IG1lZXQgdGhlIGNs
b3VkIHZlbmRvcidzIGludGVybmFsIHNwZWNpZmljYXRpb24uCgpUaGlzIGNhbiBvbmx5IHdvcmsg
aWY6CgoxKSB0aGUgaW50ZXJuYWwgc3BlY2lmaWNhdGlvbiBoYXMgZmluZXIgZ2FyaW4gdGhhbiB2
aXJ0aW8gc3BlYwoyKSBzbyBpdCBjYW4gZGVmaW5lIHdoYXQgaXMgbm90IGltcGxlbWVudGVkIGlu
IHRoZSB2aXJ0aW8gc3BlYyAobGlrZQptaWdyYXRpb24gYW5kIGNvbXBhdGliaWxpdHkpCgpBbGwg
b2YgdGhlIGFib3ZlIGRvZXNuJ3Qgc2VlbSB0byBiZSBwb3NzaWJsZSBvciByZWFsaXN0aWMgbm93
LCBhbmQgaXQKYWN0dWFsbHkgaGFzIGEgcmlzayB0byBiZSBub3QgY29tcGF0aWJsZSB3aXRoIHZp
cnRpbyBzcGVjLiBJbiB0aGUKZnV0dXJlIHdoZW4gdmlydGlvIGhhcyBsaXZlIG1pZ3JhdGlvbiBz
dXBwb3J0ZWQsIHRoZXkgd2FudCB0byBiZSBhYmxlCnRvIG1pZ3JhdGUgYmV0d2VlbiB2aXJ0aW8g
YW5kIHZEUEEuCgpBcyBJIHNhaWQsIHZEUEEgaGFzIGJlZW4gdXNlZCBmb3IgY3Jvc3MgdmVuZG9y
IGxpdmUgbWlncmF0aW9uIGZvciBhIHdoaWxlLgoKPiBSZWdhcmRsZXNzIG9mIERQVQo+IHZlbmRv
ci4KPgo+IEZ1bmRhbWVudGFsbHkgaWYgeW91IGNvbnRyb2wgdGhlIERQVSBTVyBhbmQgdGhlIGh5
cGVydmlzb3Igc29mdHdhcmUKPiB5b3UgZG8gbm90IG5lZWQgaHlwZXJ2aXNvciBtZWRpdGF0aW9u
IGJlY2F1c2UgZXZlcnl0aGluZyB5b3UgY291bGQgZG8KPiBpbiBoeXBlcnZpc29yIG1lZGlhdGlv
biBjYW4ganVzdCBiZSBkb25lIGluIHRoZSBEUFUuIFB1dHRpbmcgaXQgaW4gdGhlCj4gRFBVIGlz
IGJldHRlciBpbiBldmVyeSByZWdhcmQuCj4KPiBTbywgYXMgSSBrZWVwIHNheWluZywgaW4gdGhp
cyBzY2VuYXJpbyB0aGUgZ29hbCBpcyBubyBtZWRpYXRpb24gaW4gdGhlCj4gaHlwZXJ2aXNvci4K
ClRoYXQncyBwcmV0dHkgZmluZSwgYnV0IEkgZG9uJ3QgdGhpbmsgdHJhcHBpbmcgKyByZWx5aW5n
IGlzIG5vdAptZWRpYXRpb24uIERvZXMgaXQgcmVhbGx5IG1hdHRlciB3aGF0IGhhcHBlbnMgYWZ0
ZXIgdHJhcHBpbmc/Cgo+IEl0IGlzIHBvaW50bGVzcywgZXZlcnl0aGluZyB5b3UgdGhpbmsgeW91
IG5lZWQgdG8gZG8gdGhlcmUKPiBpcyBhY3R1YWxseSBhbHJlYWR5IGJlaW5nIGRvbmUgaW4gdGhl
IERQVS4KCldlbGwsIG1pZ3JhdGlvbiBvciBldmVuIFFlbXUgY291bGQgYmUgb2ZmbG9hZGVkIHRv
IERQVSBhcyB3ZWxsLiBJZgp0aGF0J3MgdGhlIGRpcmVjdGlvbiB0aGF0J3MgcHJldHR5IGZpbmUu
CgpUaGFua3MKCj4KPiBKYXNvbgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
