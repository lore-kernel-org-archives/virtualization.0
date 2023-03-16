Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DB8C6FD19
	for <virtualization@archiver.kernel.org>; Thu, 16 Mar 2023 10:11:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 692DC81F7A;
	Thu, 16 Mar 2023 10:11:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 692DC81F7A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X1fG1zie
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6RbfmorQ6ABL; Thu, 16 Mar 2023 10:11:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C78BB81F43;
	Thu, 16 Mar 2023 10:11:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C78BB81F43
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8ED2CC0071;
	Thu, 16 Mar 2023 10:11:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D34F4C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 10:11:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A76A4607B0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 10:11:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A76A4607B0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=X1fG1zie
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bxytwvpEXZQm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 10:11:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE48E60784
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE48E60784
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 10:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678961481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eBYYYx6ebaSPMy4LYead5i1f9hXn4823DINswCsrSc8=;
 b=X1fG1ziecxSF+YF8Sy9FY/talIB/5+naEOamtBG5s5j14oUv4AyE9Oku/SNxib7etdNJyN
 JwNpSGbP4OX1oDE7Yr/qGBfrajgcDkEOp2lk2YbZpzCro6O+oxddZvmSs1PahMDdUXBYaO
 pUpWT73m6fHuww8yhkfpPs25TnmCvgM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-tZ_F_gy_P9OoxvwKUWo7Aw-1; Thu, 16 Mar 2023 06:11:19 -0400
X-MC-Unique: tZ_F_gy_P9OoxvwKUWo7Aw-1
Received: by mail-wr1-f70.google.com with SMTP id
 g6-20020adfa486000000b002c55ef1ec94so174805wrb.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 03:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678961478;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eBYYYx6ebaSPMy4LYead5i1f9hXn4823DINswCsrSc8=;
 b=Nin+cPOLUyl8Te7ZTkgxAPmmZa7bjxLl8YoKn9FWc8RHaaBqVTiPV8rtK7X+yqGbAn
 nl4b05XCUeVRYG57QOhpdSAr339xakq51U4IsaCtTAzBb2T3WyXPH8xNM5LiWVAkoYPY
 OiekzGzdEKEr5vSJqaSqxJ71yqIvts2StaQjiVAMd8korRxubzeLa2zfBMsiubRtXMEy
 /x8Gg+H/ESvxf5W5FAX2VQ7PerI+ITZLRpdXu/eeWbqLRinMznKOQIkmMZqEQ3ViqIx9
 01NOaCNUoEafUQswnm2Vy8F2Peuicw8wuwMLhzCF4iAzFdiR54dyF+N8R4hVOn0aJyTb
 fnmw==
X-Gm-Message-State: AO0yUKUvLfWJPXVXZ/TzJ2sBh/i8GdbqczN2nohLZFkTC15PHCv/JdU5
 d08R9CoHiV+TrEDg31JfEWy0nOyuSgW2nI+8TdDfi294tEqcJWzDIh7W7mOqfKHSjJDVAaBMeVg
 NJ+GYt6ceQnH3l2Mq3eNu8aeOwMRHWX8jhue1hCJPug==
X-Received: by 2002:a05:600c:35cd:b0:3e9:f4c2:b604 with SMTP id
 r13-20020a05600c35cd00b003e9f4c2b604mr22373477wmq.24.1678961478532; 
 Thu, 16 Mar 2023 03:11:18 -0700 (PDT)
X-Google-Smtp-Source: AK7set/Lu433zhP9PilHomJbmSQWYVXOQWWKmTm0C09FAmF8pzNNFzHUbJzlyQH+yr7BXNl3vtwXzw==
X-Received: by 2002:a05:600c:35cd:b0:3e9:f4c2:b604 with SMTP id
 r13-20020a05600c35cd00b003e9f4c2b604mr22373453wmq.24.1678961478236; 
 Thu, 16 Mar 2023 03:11:18 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 o23-20020a05600c511700b003ed29b332b8sm5045142wms.35.2023.03.16.03.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Mar 2023 03:11:17 -0700 (PDT)
Date: Thu, 16 Mar 2023 11:11:15 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 2/8] vhost-vdpa: use bind_mm/unbind_mm device callbacks
Message-ID: <CAGxU2F6Pa9Dar0MVvW=qUh0k30pdtbrSy_5u2NuREd8u-id=MA@mail.gmail.com>
References: <20230302113421.174582-1-sgarzare@redhat.com>
 <20230302113421.174582-3-sgarzare@redhat.com>
 <CACGkMEttgd82xOxV8WLdSFdfhRLZn68tSaV4APSDh8qXxf4OEw@mail.gmail.com>
 <20230316083122.hliiktgsymrfpozy@sgarzare-redhat>
MIME-Version: 1.0
In-Reply-To: <20230316083122.hliiktgsymrfpozy@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

T24gVGh1LCBNYXIgMTYsIDIwMjMgYXQgOTozMeKAr0FNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dh
cnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIE1hciAxNCwgMjAyMyBhdCAxMTo0
ODozM0FNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID5PbiBUaHUsIE1hciAyLCAyMDIzIGF0
IDc6MzTigK9QTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+IHdyb3Rl
Ogo+ID4+Cj4gPj4gV2hlbiB0aGUgdXNlciBjYWxsIFZIT1NUX1NFVF9PV05FUiBpb2N0bCBhbmQg
dGhlIHZEUEEgZGV2aWNlCj4gPj4gaGFzIGB1c2VfdmFgIHNldCB0byB0cnVlLCBsZXQncyBjYWxs
IHRoZSBiaW5kX21tIGNhbGxiYWNrLgo+ID4+IEluIHRoaXMgd2F5IHdlIGNhbiBiaW5kIHRoZSBk
ZXZpY2UgdG8gdGhlIHVzZXIgYWRkcmVzcyBzcGFjZQo+ID4+IGFuZCBkaXJlY3RseSB1c2UgdGhl
IHVzZXIgVkEuCj4gPj4KPiA+PiBUaGUgdW5iaW5kX21tIGNhbGxiYWNrIGlzIGNhbGxlZCBkdXJp
bmcgdGhlIHJlbGVhc2UgYWZ0ZXIKPiA+PiBzdG9wcGluZyB0aGUgZGV2aWNlLgo+ID4+Cj4gPj4g
U2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+
ID4+IC0tLQo+ID4+Cj4gPj4gTm90ZXM6Cj4gPj4gICAgIHYyOgo+ID4+ICAgICAtIGNhbGwgdGhl
IG5ldyB1bmJpbmRfbW0gY2FsbGJhY2sgZHVyaW5nIHRoZSByZWxlYXNlIFtKYXNvbl0KPiA+PiAg
ICAgLSBhdm9pZCB0byBjYWxsIGJpbmRfbW0gY2FsbGJhY2sgYWZ0ZXIgdGhlIHJlc2V0LCBzaW5j
ZSB0aGUgZGV2aWNlCj4gPj4gICAgICAgaXMgbm90IGRldGFjaGluZyBpdCBub3cgZHVyaW5nIHRo
ZSByZXNldAo+ID4+Cj4gPj4gIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgMzAgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCsp
Cj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zo
b3N0L3ZkcGEuYwo+ID4+IGluZGV4IGRjMTJkYmQ1YjQzYi4uMWFiODlmY2NkODI1IDEwMDY0NAo+
ID4+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPj4gKysrIGIvZHJpdmVycy92aG9zdC92
ZHBhLmMKPiA+PiBAQCAtMjE5LDYgKzIxOSwyOCBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcmVz
ZXQoc3RydWN0IHZob3N0X3ZkcGEgKnYpCj4gPj4gICAgICAgICByZXR1cm4gdmRwYV9yZXNldCh2
ZHBhKTsKPiA+PiAgfQo+ID4+Cj4gPj4gK3N0YXRpYyBsb25nIHZob3N0X3ZkcGFfYmluZF9tbShz
dHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPiA+PiArewo+ID4+ICsgICAgICAgc3RydWN0IHZkcGFfZGV2
aWNlICp2ZHBhID0gdi0+dmRwYTsKPiA+PiArICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZp
Z19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKPiA+PiArCj4gPj4gKyAgICAgICBpZiAoIXZkcGEt
PnVzZV92YSB8fCAhb3BzLT5iaW5kX21tKQo+ID4+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsK
PiA+PiArCj4gPj4gKyAgICAgICByZXR1cm4gb3BzLT5iaW5kX21tKHZkcGEsIHYtPnZkZXYubW0p
Owo+ID4+ICt9Cj4gPj4gKwo+ID4+ICtzdGF0aWMgdm9pZCB2aG9zdF92ZHBhX3VuYmluZF9tbShz
dHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPiA+PiArewo+ID4+ICsgICAgICAgc3RydWN0IHZkcGFfZGV2
aWNlICp2ZHBhID0gdi0+dmRwYTsKPiA+PiArICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZp
Z19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKPiA+PiArCj4gPj4gKyAgICAgICBpZiAoIXZkcGEt
PnVzZV92YSB8fCAhb3BzLT51bmJpbmRfbW0pCj4gPj4gKyAgICAgICAgICAgICAgIHJldHVybjsK
PiA+PiArCj4gPj4gKyAgICAgICBvcHMtPnVuYmluZF9tbSh2ZHBhKTsKPiA+PiArfQo+ID4+ICsK
PiA+PiAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9nZXRfZGV2aWNlX2lkKHN0cnVjdCB2aG9zdF92
ZHBhICp2LCB1OCBfX3VzZXIgKmFyZ3ApCj4gPj4gIHsKPiA+PiAgICAgICAgIHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4gPj4gQEAgLTcxMSw2ICs3MzMsMTMgQEAgc3RhdGlj
IGxvbmcgdmhvc3RfdmRwYV91bmxvY2tlZF9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZXAsCj4gPj4g
ICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4+ICAgICAgICAgZGVmYXVsdDoKPiA+PiAgICAgICAg
ICAgICAgICAgciA9IHZob3N0X2Rldl9pb2N0bCgmdi0+dmRldiwgY21kLCBhcmdwKTsKPiA+PiAr
ICAgICAgICAgICAgICAgaWYgKCFyICYmIGNtZCA9PSBWSE9TVF9TRVRfT1dORVIpIHsKPiA+PiAr
ICAgICAgICAgICAgICAgICAgICAgICByID0gdmhvc3RfdmRwYV9iaW5kX21tKHYpOwo+ID4+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGlmIChyKSB7Cj4gPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB2aG9zdF9kZXZfcmVzZXRfb3duZXIoJnYtPnZkZXYsIE5VTEwpOwo+ID4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgfQo+ID4+ICsgICAgICAgICAgICAgICB9Cj4gPgo+ID5OaXQ6IGlzIGl0IGJldHRl
ciB0byBoYXZlIGEgbmV3IGNvbmRpdGlvbi9zd2l0Y2ggYnJhbmNoIGluc3RlYWQgb2YKPiA+cHV0
dGluZyB0aGVtIHVuZGVyIGRlZmF1bHQ/IChhcyB3aGF0IHZyaW5nX2lvY3RsIGRpZCkuCj4KPiBZ
ZXAsIEkgYWdyZWUhCj4KPiBJJ2xsIGNoYW5nZSBpdC4KCk9yIG1heWJlIEkgY2FuIHNpbXBseSBh
ZGQgYGNhc2UgVkhPU1RfU0VUX09XTkVSYCBvbiB0aGlzIHN3aXRjaCBhbmQgY2FsbAp2aG9zdF9k
ZXZfc2V0X293bmVyKCkgYW5kIHZob3N0X3ZkcGFfYmluZF9tbSgpLCBJIG1lYW4gc29tZXRoaW5n
IGxpa2UKdGhpczoKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMv
dmhvc3QvdmRwYS5jCmluZGV4IDMzMWQ0YTcxOGJmNi4uMjAyNTBjMzQxOGIyIDEwMDY0NAotLS0g
YS9kcml2ZXJzL3Zob3N0L3ZkcGEuYworKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwpAQCAtNzMx
LDE1ICs3MzEsMTYgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV91bmxvY2tlZF9pb2N0bChzdHJ1
Y3QgZmlsZSAqZmlsZXAsCiAgICAgICAgY2FzZSBWSE9TVF9WRFBBX1JFU1VNRToKICAgICAgICAg
ICAgICAgIHIgPSB2aG9zdF92ZHBhX3Jlc3VtZSh2KTsKICAgICAgICAgICAgICAgIGJyZWFrOwor
ICAgICAgIGNhc2UgVkhPU1RfU0VUX09XTkVSOgorICAgICAgICAgICAgICAgciA9IHZob3N0X2Rl
dl9zZXRfb3duZXIoZCk7CisgICAgICAgICAgICAgICBpZiAocikKKyAgICAgICAgICAgICAgICAg
ICAgICAgYnJlYWs7CisgICAgICAgICAgICAgICByID0gdmhvc3RfdmRwYV9iaW5kX21tKHYpOwor
ICAgICAgICAgICAgICAgaWYgKHIpCisgICAgICAgICAgICAgICAgICAgICAgIHZob3N0X2Rldl9y
ZXNldF9vd25lcihkLCBOVUxMKTsKKyAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgIGRlZmF1
bHQ6CiAgICAgICAgICAgICAgICByID0gdmhvc3RfZGV2X2lvY3RsKCZ2LT52ZGV2LCBjbWQsIGFy
Z3ApOwotICAgICAgICAgICAgICAgaWYgKCFyICYmIGNtZCA9PSBWSE9TVF9TRVRfT1dORVIpIHsK
LSAgICAgICAgICAgICAgICAgICAgICAgciA9IHZob3N0X3ZkcGFfYmluZF9tbSh2KTsKLSAgICAg
ICAgICAgICAgICAgICAgICAgaWYgKHIpIHsKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB2aG9zdF9kZXZfcmVzZXRfb3duZXIoJnYtPnZkZXYsIE5VTEwpOwotICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGJyZWFrOwotICAgICAgICAgICAgICAgICAgICAgICB9Ci0gICAgICAg
ICAgICAgICB9CiAgICAgICAgICAgICAgICBpZiAociA9PSAtRU5PSU9DVExDTUQpCiAgICAgICAg
ICAgICAgICAgICAgICAgIHIgPSB2aG9zdF92ZHBhX3ZyaW5nX2lvY3RsKHYsIGNtZCwgYXJncCk7
CiAgICAgICAgICAgICAgICBicmVhazsKCldEWVQ/CgpUaGFua3MsClN0ZWZhbm8KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
