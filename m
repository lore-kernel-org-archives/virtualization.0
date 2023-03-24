Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82533C76196
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 07:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1829560F6E;
	Fri, 24 Mar 2023 07:37:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1829560F6E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QY79+tgB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XtZODuLw5BOc; Fri, 24 Mar 2023 07:37:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A1D2E60F44;
	Fri, 24 Mar 2023 07:37:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A1D2E60F44
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95CF5C008E;
	Fri, 24 Mar 2023 07:37:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3BBBC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 07:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9267C83EDA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 07:37:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9267C83EDA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QY79+tgB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QiEl8O4EAGiA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 07:37:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D631F83EC8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D631F83EC8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 07:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679643442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oI3YP5H//KMb6ytpFmPOGwN6yfZbn5OQ14jrKUqyLT8=;
 b=QY79+tgBz9k91/69KT90q17APl2VxfAsQ1Rv0Ao4BSrF5m7XcFcpjzmGPc9tC8fQ4DBWc7
 aPrELllTZB00ixXqEsJ1FfoEPQI3Anurb7ZZK50azybjwzTqttSugKtlRcNz7SgDXSFw+n
 luAyDFjVQ2w4jegjPw5i/vHzfU246Xs=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-h5vof-5dNZqKS-9XVDe80g-1; Fri, 24 Mar 2023 03:37:21 -0400
X-MC-Unique: h5vof-5dNZqKS-9XVDe80g-1
Received: by mail-ot1-f71.google.com with SMTP id
 a15-20020a0568300b8f00b0069965814cf7so420056otv.15
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 00:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679643440;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oI3YP5H//KMb6ytpFmPOGwN6yfZbn5OQ14jrKUqyLT8=;
 b=oMwqBQHOpxu4p3cPaB64ORV7pAouFK6aMfhh7gr+kbV+UKgmQADi8PKbv9IYK8Xr/b
 LuUqxfnaKoMrqfMq9WhxW1xlROCZDqxSaHzb8o3PPcOmfKI+J17I+HyGZqSr/Otz6uxL
 Pc/sZkI9EdNtqOHpKP39RjvFkpAOiQIhO/Vx6zYs7XQvYMBLxQlDF8f1t8vkGn3jRkoQ
 c+euD1Fm8bJIeKJRd9UYj7QGG9mG746N24w1WKwBc/uA395gm0LBr7yjwIEnp9InEKrw
 5zv64oT+Ee+TsO0oplRTV3RPo9i2NXBpMa/eh26vKRBnZ/staxdlpjmmQbLo+nwJXuAU
 DOkg==
X-Gm-Message-State: AO0yUKVuCsDz+wy4KOqzywnXJdlXT17Y5QW9VnWxPQtxYlE5rbkFC+2N
 iQx+phuJh4iGXHVf/sFuSOOsG1ulLENlVy4wRAb6e3ky4xTMwdeMUYv48d5A7pckAv+M1/Og0YN
 wOQUgLhdOyfyQwIQF3K5ijat5Wdj3jr0snKK550PiXn7dFTTXAjA7nMXkkA==
X-Received: by 2002:a05:6808:171c:b0:387:5a8c:4125 with SMTP id
 bc28-20020a056808171c00b003875a8c4125mr649529oib.3.1679643440271; 
 Fri, 24 Mar 2023 00:37:20 -0700 (PDT)
X-Google-Smtp-Source: AK7set8gepGqlvh46NVJ46lGnFuJlDRSdtlw8SsX02BTqTtYmKiq9G+Titwkw0wIQNRE+o30bTxm5JOkh2XRSM/65/M=
X-Received: by 2002:a05:6808:171c:b0:387:5a8c:4125 with SMTP id
 bc28-20020a056808171c00b003875a8c4125mr649522oib.3.1679643439752; Fri, 24 Mar
 2023 00:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230324063010.48670-1-xuanzhuo@linux.alibaba.com>
 <20230324063010.48670-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEtoii-vXeFfdcYQ8VMk-PomqNMdpcZ9ymVvZ39zZ=6s0g@mail.gmail.com>
 <1679640931.657412-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1679640931.657412-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 Mar 2023 15:37:08 +0800
Message-ID: <CACGkMEt8JfzdHpcUb=1qY61ho4hdVzjXWoavQ2EPW1bD0SW=YA@mail.gmail.com>
Subject: Re: [PATCH vhost v5 05/11] virtio_ring: packed: support premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

T24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgMjo1N+KAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCAyNCBNYXIgMjAyMyAxNDo0Nzo1NiAr
MDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiBPbiBGcmks
IE1hciAyNCwgMjAyMyBhdCAyOjMw4oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGli
YWJhLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IHZpcnRpbyBjb3JlIG9ubHkgc3VwcG9ydHMgdmly
dHVhbCBhZGRyZXNzZXMsIGRtYSBpcyBjb21wbGV0ZWQgaW4gdmlydGlvCj4gPiA+IGNvcmUuCj4g
PiA+Cj4gPiA+IEluIHNvbWUgc2NlbmFyaW9zIChzdWNoIGFzIHRoZSBBRl9YRFApLCB0aGUgbWVt
b3J5IGlzIGFsbG9jYXRlZAo+ID4gPiBhbmQgRE1BIG1hcHBpbmcgaXMgY29tcGxldGVkIGluIGFk
dmFuY2UsIHNvIGl0IGlzIG5lY2Vzc2FyeSBmb3IgdXMgdG8KPiA+ID4gc3VwcG9ydCBwYXNzaW5n
IHRoZSBETUEgYWRkcmVzcyB0byB2aXJ0aW8gY29yZS4KPiA+ID4KPiA+ID4gRHJpdmVzIGNhbiB1
c2Ugc2ctPmRtYV9hZGRyZXNzIHRvIHBhc3MgdGhlIG1hcHBlZCBkbWEgYWRkcmVzcyB0byB2aXJ0
aW8KPiA+ID4gY29yZS4gSWYgb25lIHNnLT5kbWFfYWRkcmVzcyBpcyB1c2VkIHRoZW4gYWxsIHNn
cyBtdXN0IHVzZQo+ID4gPiBzZy0+ZG1hX2FkZHJlc3MsIG90aGVyd2lzZSBhbGwgbXVzdCBiZSBu
dWxsIHdoZW4gcGFzc2luZyBpdCB0byB0aGUgQVBJcwo+ID4gPiBvZiB2aXJ0aW8uCj4gPiA+Cj4g
PiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+
Cj4gPiA+IC0tLQo+ID4gPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDE3ICsrKysr
KysrKysrKysrLS0tCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+IGluZGV4IDFjMzA4
NGE4ZjRlMy4uZGY2ZDUxNGE2ODFhIDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+
ID4gQEAgLTc4LDYgKzc4LDcgQEAgc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfc3BsaXQgewo+ID4g
PiAgc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfcGFja2VkIHsKPiA+ID4gICAgICAgICB2b2lkICpk
YXRhOyAgICAgICAgICAgICAgICAgICAgIC8qIERhdGEgZm9yIGNhbGxiYWNrLiAqLwo+ID4gPiAg
ICAgICAgIHN0cnVjdCB2cmluZ19wYWNrZWRfZGVzYyAqaW5kaXJfZGVzYzsgLyogSW5kaXJlY3Qg
ZGVzY3JpcHRvciwgaWYgYW55LiAqLwo+ID4gPiArICAgICAgIHU2NCBmbGFnczsgICAgICAgICAg
ICAgICAgICAgICAgLyogU3RhdGUgZmxhZ3MuICovCj4gPgo+ID4gSSdkIHVzZSB1MzIgdGhlbiB0
aGVyZSB3b3VsZCBiZSBubyBuZWVkIGZvciB0aGUgY29tcGlsZXIgdG8gcGFkIHRoZQo+ID4gc3Ry
dWN0dXJlIGluIGJvdGggMzIgYW5kIDY0IGJpdCBhcmNocy4KPgo+Cj4gT0suCj4KPiBJIGp1c3Qg
dHJ5IHRvIGtlZXAgdGhlIHNhbWUgYXMgc3BsaXQuIE1heWJlIEkgc2hvdWxkIGFkZCBzb21lIG5v
dGVzLAo+IGluZGljYXRpbmcgdGhhdCB0aGVyZSBpcyBzb21lIGRpZmZlcmVuY2UgYmV0d2VlbiBz
cGxpdC4KCkl0IHdvdWxkIGJlIGJldHRlciB0byB1c2UgYSB1MzIgKyBleHBsaWNpdCBwYWQgZm9y
IHNwbGl0IGluIHRoaXMgY2FzZS4KClRoYW5rcwoKPgo+Cj4gVGhhbmtzLgo+Cj4KPiA+Cj4gPiBU
aGFua3MKPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
