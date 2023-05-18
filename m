Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8CFC7EE22
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 08:38:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99A9660A80;
	Thu, 18 May 2023 08:38:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 99A9660A80
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U7oM5Toe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id obMFLPW_M_eg; Thu, 18 May 2023 08:38:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D3FB060767;
	Thu, 18 May 2023 08:38:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D3FB060767
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFB0FC0036;
	Thu, 18 May 2023 08:38:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89841C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 08:38:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6AA87841D2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 08:38:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6AA87841D2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=U7oM5Toe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Vif0x0Y7_PM
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 08:38:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5B36D841B9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5B36D841B9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 08:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684399102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uF37NzKzLXUhy9KMjxqXABXX17UWB9gVckUkSDvfIcI=;
 b=U7oM5ToeiPbdYH98Eyr2oz3TWgukbIF1nFsw1XtpII+MAS6u7JJm2EQ4H0tPu3jtXsp3tT
 NBBct7KwwVLJE7cwQTi2S5MGt4DIIyI/XDUy7viNMVuQ0pMG/txcB5TW7kRL7HEMmSHRCC
 1uncAz3svg2PZn8aPJY9TCs/6rW0KZk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-_NfKl5CoPNKKqxHtfBPP0A-1; Thu, 18 May 2023 04:38:19 -0400
X-MC-Unique: _NfKl5CoPNKKqxHtfBPP0A-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-306286b3573so1112749f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 01:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684399098; x=1686991098;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uF37NzKzLXUhy9KMjxqXABXX17UWB9gVckUkSDvfIcI=;
 b=PeIonOXf5D2p9VIF/zDOietclO/xp6u4M3dUyUPTyRW8lZ7SmI2tDZ82Fd3xpARn0E
 BhFTW2GXM7mW1rbPH3oRU3XbDXEQiWIZmQSpIrV7Z0RNwwm3IVHxYS3MWsFLFGdePS6g
 ExBlo5VDLCovlO8CPtITxyyliz6hVfqSvIEtyhdspZ9P4VZW1R82ig4R4qPgYBnwdD2j
 S5fJOygylkdOiRBFVqqH5+t1G6z02ExX2eAkWq8l67TDnGNwO+41GTInyaH323C8sFsr
 rSJnihcAmT2Yv7eX+MMt6bRyjcKZxbZlurtlFamB4wnrPBUpOGPKPUGsEw7ZxGXCYpKg
 UHCg==
X-Gm-Message-State: AC+VfDwLa7W6GWPn7Dy/YHejVTyikjceM23wasQp0vWvU38Hd5YVjVC8
 xJlOVZfr+B76mDMDhJStWddmi3qf2wAXaskfMvEwYEYbR5Ne+Xlkx9zpbB/9jI131AOoMPZvmR1
 y1dEDhuKcpzm9/onsUt2Q4waY3TW2iCubo4Lnz62kpw==
X-Received: by 2002:a5d:678f:0:b0:306:2d32:8ec with SMTP id
 v15-20020a5d678f000000b003062d3208ecmr1089308wru.6.1684399098167; 
 Thu, 18 May 2023 01:38:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Rkd8/6W0bx9goJ/NTT4R2571VQCgIXo/JRYm+66qINnMkAoW0QFyjHv9X11qJFI/o0iMqfw==
X-Received: by 2002:a5d:678f:0:b0:306:2d32:8ec with SMTP id
 v15-20020a5d678f000000b003062d3208ecmr1089293wru.6.1684399097843; 
 Thu, 18 May 2023 01:38:17 -0700 (PDT)
Received: from redhat.com ([2.52.6.43]) by smtp.gmail.com with ESMTPSA id
 z23-20020a7bc7d7000000b003f1957ace1fsm4567397wmk.13.2023.05.18.01.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 01:38:17 -0700 (PDT)
Date: Thu, 18 May 2023 04:38:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 2/3] vhost: support PACKED when setting-getting
 vring_base
Message-ID: <20230518043114-mutt-send-email-mst@kernel.org>
References: <20230424225031.18947-3-shannon.nelson@amd.com>
 <ogzrlfid7jwfzgk42zffegaq4xhdsrpi6vu22333ub4bkmvpc3@3pa2eyzub3jn>
 <58f93ced-2f2b-dba1-b8a3-96bdb755d54e@amd.com>
 <q6cmfha36sdkgflwwd3pr4sw7rgajag4ahgjbpfjrr76w4o2b6@3yc7zs5u65s4>
 <dcfb15e6-a4c9-cb91-becd-a1e56e14d340@amd.com>
 <CACGkMEsNo4O0uAdO5koXgYbgQLoOWp81KNjsaZYSuQ7YzjvPbA@mail.gmail.com>
 <CAGxU2F4kwnGq41q99nx879Y4Br=0aeZsf2bjx2ZqpOc93G_gDQ@mail.gmail.com>
 <CACGkMEsi0Vu21ZX2WZuEWNKQ4KTGA1iNb6+8SHeCb+Penqxr8g@mail.gmail.com>
 <CAGxU2F63yQuc-eefSkEKZKZUxpnS4myGhNP2Bkj+QQk01Pi_yg@mail.gmail.com>
 <CACGkMEudGC8jbCyD6A4mCpeBomatZ88t+5WahLGAxe9vaYH6fw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEudGC8jbCyD6A4mCpeBomatZ88t+5WahLGAxe9vaYH6fw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Gautam Dawar <gdawar@xilinx.com>, virtualization@lists.linux-foundation.org,
 drivers@pensando.io
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

T24gVGh1LCBNYXkgMTgsIDIwMjMgYXQgMDM6NTI6MTBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUaHUsIE1heSAxOCwgMjAyMyBhdCAzOjM04oCvUE0gU3RlZmFubyBHYXJ6YXJlbGxh
IDxzZ2FyemFyZUByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBUaHUsIE1heSAxOCwgMjAy
MyBhdCA3OjI04oCvQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4g
PiA+Cj4gPiA+IE9uIFdlZCwgTWF5IDE3LCAyMDIzIGF0IDM6MDDigK9QTSBTdGVmYW5vIEdhcnph
cmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24gV2Vk
LCBNYXkgMTcsIDIwMjMgYXQgNzoyNuKAr0FNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+IE9uIFdlZCwgTWF5IDE3LCAyMDIzIGF0IDI6
MjbigK9BTSBTaGFubm9uIE5lbHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4gd3JvdGU6Cj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE9uIDUvMTYvMjMgMTI6NDkgQU0sIFN0ZWZhbm8gR2FyemFy
ZWxsYSB3cm90ZToKPiA+ID4gPiA+ID4gPiBPbiBNb24sIE1heSAxNSwgMjAyMyBhdCAwMTo0MTox
MlBNIC0wNzAwLCBTaGFubm9uIE5lbHNvbiB3cm90ZToKPiA+ID4gPiA+ID4gPj4gT24gNS85LzIz
IDE6NDYgQU0sIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiA+ID4gPiA+ID4gPj4+IE9uIE1v
biwgQXByIDI0LCAyMDIzIGF0IDAzOjUwOjMwUE0gLTA3MDAsIFNoYW5ub24gTmVsc29uIHZpYQo+
ID4gPiA+ID4gPiA+Pj4gVmlydHVhbGl6YXRpb24gd3JvdGU6Cj4gPiA+ID4gPiA+ID4+Pj4gVXNl
IHRoZSByaWdodCBzdHJ1Y3RzIGZvciBQQUNLRUQgb3Igc3BsaXQgdnFzIHdoZW4gc2V0dGluZyBh
bmQKPiA+ID4gPiA+ID4gPj4+PiBnZXR0aW5nIHRoZSB2cmluZyBiYXNlLgo+ID4gPiA+ID4gPiA+
Pj4+Cj4gPiA+ID4gPiA+ID4+Pj4gU2lnbmVkLW9mZi1ieTogU2hhbm5vbiBOZWxzb24gPHNoYW5u
b24ubmVsc29uQGFtZC5jb20+Cj4gPiA+ID4gPiA+ID4+Pj4gLS0tCj4gPiA+ID4gPiA+ID4+Pj4g
ZHJpdmVycy92aG9zdC92aG9zdC5jIHwgMTggKysrKysrKysrKysrKy0tLS0tCj4gPiA+ID4gPiA+
ID4+Pj4gZHJpdmVycy92aG9zdC92aG9zdC5oIHwgIDggKysrKysrLS0KPiA+ID4gPiA+ID4gPj4+
PiAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4gPiA+
ID4gPiA+ID4+Pj4KPiA+ID4gPiA+ID4gPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92
aG9zdC5jIGIvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gPiA+ID4gPiA+ID4+Pj4gaW5kZXggZjEx
YmRiZTRjMmM1Li5mNjRlZmRhNDhmMjEgMTAwNjQ0Cj4gPiA+ID4gPiA+ID4+Pj4gLS0tIGEvZHJp
dmVycy92aG9zdC92aG9zdC5jCj4gPiA+ID4gPiA+ID4+Pj4gKysrIGIvZHJpdmVycy92aG9zdC92
aG9zdC5jCj4gPiA+ID4gPiA+ID4+Pj4gQEAgLTE2MzMsMTcgKzE2MzMsMjUgQEAgbG9uZyB2aG9z
dF92cmluZ19pb2N0bChzdHJ1Y3Qgdmhvc3RfZGV2Cj4gPiA+ID4gPiA+ID4+Pj4gKmQsIHVuc2ln
bmVkIGludCBpb2N0bCwgdm9pZCBfX3VzZXIgKmFyZwo+ID4gPiA+ID4gPiA+Pj4+ICAgICAgICAg
ICAgICAgICAgICAgICByID0gLUVGQVVMVDsKPiA+ID4gPiA+ID4gPj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgYnJlYWs7Cj4gPiA+ID4gPiA+ID4+Pj4gICAgICAgICAgICAgICB9Cj4gPiA+ID4g
PiA+ID4+Pj4gLSAgICAgICAgICAgICAgaWYgKHMubnVtID4gMHhmZmZmKSB7Cj4gPiA+ID4gPiA+
ID4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICByID0gLUVJTlZBTDsKPiA+ID4gPiA+ID4gPj4+
PiAtICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4gPiA+ID4gPiA+Pj4+ICsgICAgICAg
ICAgICAgIGlmICh2aG9zdF9oYXNfZmVhdHVyZSh2cSwgVklSVElPX0ZfUklOR19QQUNLRUQpKSB7
Cj4gPiA+ID4gPiA+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICB2cS0+bGFzdF9hdmFpbF9p
ZHggPSBzLm51bSAmIDB4ZmZmZjsKPiA+ID4gPiA+ID4gPj4+PiArICAgICAgICAgICAgICAgICAg
ICAgIHZxLT5sYXN0X3VzZWRfaWR4ID0gKHMubnVtID4+IDE2KSAmIDB4ZmZmZjsKPiA+ID4gPiA+
ID4gPj4+PiArICAgICAgICAgICAgICB9IGVsc2Ugewo+ID4gPiA+ID4gPiA+Pj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgaWYgKHMubnVtID4gMHhmZmZmKSB7Cj4gPiA+ID4gPiA+ID4+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHIgPSAtRUlOVkFMOwo+ID4gPiA+ID4gPiA+Pj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+ID4gPiA+ID4gPj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgIH0KPiA+ID4gPiA+ID4gPj4+PiArICAgICAgICAgICAgICAg
ICAgICAgIHZxLT5sYXN0X2F2YWlsX2lkeCA9IHMubnVtOwo+ID4gPiA+ID4gPiA+Pj4+ICAgICAg
ICAgICAgICAgfQo+ID4gPiA+ID4gPiA+Pj4+IC0gICAgICAgICAgICAgIHZxLT5sYXN0X2F2YWls
X2lkeCA9IHMubnVtOwo+ID4gPiA+ID4gPiA+Pj4+ICAgICAgICAgICAgICAgLyogRm9yZ2V0IHRo
ZSBjYWNoZWQgaW5kZXggdmFsdWUuICovCj4gPiA+ID4gPiA+ID4+Pj4gICAgICAgICAgICAgICB2
cS0+YXZhaWxfaWR4ID0gdnEtPmxhc3RfYXZhaWxfaWR4Owo+ID4gPiA+ID4gPiA+Pj4+ICAgICAg
ICAgICAgICAgYnJlYWs7Cj4gPiA+ID4gPiA+ID4+Pj4gICAgICAgY2FzZSBWSE9TVF9HRVRfVlJJ
TkdfQkFTRToKPiA+ID4gPiA+ID4gPj4+PiAgICAgICAgICAgICAgIHMuaW5kZXggPSBpZHg7Cj4g
PiA+ID4gPiA+ID4+Pj4gLSAgICAgICAgICAgICAgcy5udW0gPSB2cS0+bGFzdF9hdmFpbF9pZHg7
Cj4gPiA+ID4gPiA+ID4+Pj4gKyAgICAgICAgICAgICAgaWYgKHZob3N0X2hhc19mZWF0dXJlKHZx
LCBWSVJUSU9fRl9SSU5HX1BBQ0tFRCkpCj4gPiA+ID4gPiA+ID4+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICBzLm51bSA9ICh1MzIpdnEtPmxhc3RfYXZhaWxfaWR4IHwKPiA+ID4gPiA+ID4gPj4+
PiAoKHUzMil2cS0+bGFzdF91c2VkX2lkeCA8PCAxNik7Cj4gPiA+ID4gPiA+ID4+Pj4gKyAgICAg
ICAgICAgICAgZWxzZQo+ID4gPiA+ID4gPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgcy5u
dW0gPSB2cS0+bGFzdF9hdmFpbF9pZHg7Cj4gPiA+ID4gPiA+ID4+Pgo+ID4gPiA+ID4gPiA+Pj4g
VGhlIGNoYW5nZXMgTEdUTSwgYnV0IHNpbmNlIHdlIGFyZSBjaGFuZ2luZyB0aGUgVUFQSSwgc2hv
dWxkIHdlCj4gPiA+ID4gPiA+ID4+PiB1cGRhdGUgdGhlIGRvY3VtZW50YXRpb24gb2YgVkhPU1Rf
U0VUX1ZSSU5HX0JBU0UgYW5kCj4gPiA+ID4gPiA+ID4+PiBWSE9TVF9HRVRfVlJJTkdfQkFTRSBp
biBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaD8KPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4g
Pj4gQ29ycmVjdCBtZSBpZiBJJ20gd3JvbmcsIGJ1dCBJIGRvbid0IHRoaW5rIHdlJ3JlIGNoYW5n
aW5nIGFueXRoaW5nIGluCj4gPiA+ID4gPiA+ID4+IHRoZSBVQVBJIGhlcmUsIGp1c3QgZml4aW5n
IGNvZGUgdG8gd29yayBjb3JyZWN0bHkgd2l0aCB3aGF0IGlzIGFscmVhZHkKPiA+ID4gPiA+ID4g
Pj4gaGFwcGVuaW5nLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gSUlVQyBiZWZvcmUgdGhp
cyBwYXRjaCBWSE9TVF9HRVRfVlJJTkdfQkFTRSBhbmQgVkhPU1RfU0VUX1ZSSU5HX0JBU0UKPiA+
ID4gPiA+ID4gPiBuZXZlciB3b3JrZWQgd2l0aCBwYWNrZWQgdmlydHF1ZXVlLCBzaW5jZSB3ZSB3
ZXJlIG9ubHkgaGFuZGxpbmcKPiA+ID4gPiA+ID4gPiBsYXN0X2F2YWlsX2lkeC4gTm93IHdlIGFy
ZSBzdXBwb3J0aW5nIHBhY2tlZCB2aXJ0cXVldWUsIGhhbmRsaW5nCj4gPiA+ID4gPiA+ID4gaW4g
dmhvc3RfdnJpbmdfc3RhdGUubnVtIGJvdGggbGFzdF9hdmFpbF9pZHggYW5kIGxhc3RfdXNlZF9p
ZHggKHdpdGgKPiA+ID4gPiA+ID4gPiB3cmFwIGNvdW50ZXJzKS4KPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+IEZvciBleGFtcGxlIGZvciBWSE9TVF9HRVRfVlJJTkdfQkFTRSB3aGVyZSBpcyBk
b2N1bWVudGVkIHRoYXQgdGhlIGZpcnN0Cj4gPiA+ID4gPiA+ID4gMTUgYml0cyBhcmUgbGFzdF9h
dmFpbF9pZHgsIHRoZSAxNnRoIHRoZSBhdmFpbF93cmFwX2NvdW50ZXIsIGFuZCB0aGUKPiA+ID4g
PiA+ID4gPiBvdGhlcnMgYXJlIGxhc3RfdXNlZF9pZHggYW5kIHVzZWRfd3JhcF9jb3VudGVyPwo+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gTWF5YmUgSSBtaXNzZWQgc29tZXRoaW5nLCBidXQg
c2luY2UgdGhpcyBpcyBVQVBJLCBJTUhPIHdlIHNob3VsZAo+ID4gPiA+ID4gPiA+IGRvY3VtZW50
IHRoZSBwYXJhbWV0ZXJzIG9mIGlvY3RscyBhdCBsZWFzdCBpbgo+ID4gPiA+ID4gPiA+IGluY2x1
ZGUvdWFwaS9saW51eC92aG9zdC5oLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBQZXJoYXBzIEph
c29uIGFscmVhZHkgaGFzIHNvbWV0aGluZyB3cml0dGVuIHVwIHRoYXQgY291bGQgYmUgcHV0IGlu
IGhlcmUKPiA+ID4gPiA+ID4gZnJvbSB3aGVuIGhlIGZpcnN0IGFkZGVkIHRoZSB3cmFwX2NvdW50
ZXIgYSBjb3VwbGUgb2YgeWVhcnMgYWdvPwo+ID4gPiA+ID4KPiA+ID4gPiA+IElmIHlvdSBtZWFu
dCB0aGUgdmlydGlvIGRyaXZlciBzdXBwb3J0IGZvciBwYWNrZWQsIEkgdGhpbmsgaXQncwo+ID4g
PiA+ID4gZGlmZmVyZW50IGZyb20gdGhlIGNvbnRleHQgd2hpY2ggaXMgdmhvc3QgaGVyZS4KPiA+
ID4gPiA+Cj4gPiA+ID4gPiBJIGFncmVlIHdpdGggU3RlZmFubyB0aGF0IHdlIG5lZWQgdG8gdXBk
YXRlIHRoZSBjb21tZW50cyBhcm91bmQKPiA+ID4gPiA+IEdFVF9WUklOR19CQVNFIGFuZCBTRVRf
VlJJTkdfQkFTRSwgdGhlbiB3ZSBhcmUgZmluZS4KPiA+ID4gPgo+ID4gPiA+IEknbSB0aGlua2lu
ZyBpZiB3ZSBzaG91bGQgYWxzbyBhZGQgYSBuZXcgVkhPU1RfQkFDS0VORF9GX1JJTkdfUEFDS0VE
Cj4gPiA+ID4gZmVhdHVyZSAob3Igc29tZXRoaW5nIHNpbWlsYXIpIHRvIGluZm9ybSB0aGUgdXNl
ciBzcGFjZSB0aGF0IG5vdyB3ZQo+ID4gPiA+IGFyZSBhYmxlIHRvIGhhbmRsZSBwYWNrZWQgdmly
dHF1ZXVlIHRocm91Z2ggdmhvc3QgSU9DVExzLCBvdGhlcndpc2UKPiA+ID4gPiBob3cgY2FuIHRo
ZSB1c2Vyc3BhY2Uga25vdyBpZiBpdCBpcyBzdXBwb3J0ZWQgb3Igbm90Pwo+ID4gPgo+ID4gPiBJ
IHByb2JhYmx5IHVuZGVyc3RhbmQgdGhpcyBidXQgSSB0aGluayBpdCBzaG91bGQgYmUgZG9uZSB2
aWEKPiA+ID4gVkhPU1RfR0VUX0ZFQUVUVVJFUy4gSXQgd291bGQgYmUgYSBidXJkZW4gaWYgd2Ug
bWF0aWFuaW5nIGR1cGxpY2F0ZWQKPiA+ID4gZmVhdHVyZXMuCj4gPgo+ID4gR29vZCBwb2ludCwg
SSBzZWUuCj4gPgo+ID4gSSB0aGluayB3ZSBzaG91bGQgZG8gb25lIG9mIHRoZXNlIHRoaW5ncywg
dGhvdWdoOgo+ID4gLSBtYXNrIFZJUlRJT19GX1JJTkdfUEFDS0VEIGluIHRoZSBzdGFibGUga2Vy
bmVscyB3aGVuCj4gPiBWSE9TVF9HRVRfRkVBRVRVUkVTIGlzIGNhbGxlZAo+ID4gLSBiYWNrcG9y
dCB0aGlzIHBhdGNoIG9uIGFsbCBzdGFibGUga2VybmVscyB0aGF0IHN1cHBvcnQgdmhvc3QtdmRw
YQo+ID4KPiA+IE1heWJlIHRoZSBsYXN0IG9uZSBtYWtlcyBtb3JlIHNlbnNlLgo+IAo+IE5vdCBz
dXJlLCBpdCBsb29rcyB0byBtZSB0aGUgcGFja2VkIHN1cHBvcnQgZm9yIHZEUEEgd2FzIGZpcnN0
IGFkZGVkCj4gYnkgR2F1dGFtLiBTbyBpdCBwcm9iYWJseSBtZWFucyB0aGF0IGV4Y2VwdCBmb3Ig
dnBfdmRwYSwgd2UgZG9uJ3QgaGF2ZQo+IGEgdkRQQSBwYXJlbnQgdGhhdCBjYW4gZG8gdGhlIHBh
Y2tlZCB2aXJ0dXF1ZSBub3cuIEFkZGluZyB0aGUgcmVsZXZhbnQKPiBwZW9wbGUgaGVyZSBmb3Ig
bW9yZSBjb21tZW50Cj4gCj4gVGhhbmtzCgpCVFcgc2hvdWxkIHdlIGZpeCB1cCB2aG9zdC5jIHRv
IHN1cHBvcnQgcGFja2VkIHJpbmdzIHRvbz8KRS5nLiBzbyB3ZSBjYW4gbWlncmF0ZSB0byB2aG9z
dD8KVGhlcmUncyBhbiBvbGQgcGF0Y2hzZXQgb2YgbWluZSB0aGF0IHN0YXJ0ZWQgd29yayBvbiB0
aGlzOgoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjAwNDA3MDExNjEyLjQ3ODIyNi0x
LW1zdCU0MHJlZGhhdC5jb20KCklzIHRoZXJlIG5lZWQgZm9yIHRoaXMgbm93PwoKPiA+Cj4gPiBU
aGFua3MsCj4gPiBTdGVmYW5vCj4gPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
