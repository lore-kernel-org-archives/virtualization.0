Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAC2C6FD20
	for <virtualization@archiver.kernel.org>; Wed, 22 Mar 2023 02:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 92FC240462;
	Wed, 22 Mar 2023 02:36:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 92FC240462
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iAU6UfeE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1qUzGO43vRAB; Wed, 22 Mar 2023 02:36:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0062A401C9;
	Wed, 22 Mar 2023 02:36:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0062A401C9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C2CBC0035;
	Wed, 22 Mar 2023 02:36:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 701F9C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 02:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B7D560F48
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 02:36:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B7D560F48
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iAU6UfeE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id siRxx7TFNf5O
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 02:36:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 37D1E60D90
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 37D1E60D90
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 02:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679452610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZswUpIaZmBcMPoqevve8ROOrxF8yB084rqzIQZF6EMs=;
 b=iAU6UfeEHFMWa6S+34zQ67Rx3wGHyAVDY1/m8XsFkRpRVeWGpB2hCq5iVPG2uCqr0qhCm6
 yj8cxHWgLPdPthSyhkDK15tcQ03ASMr7oPcrd1pRos8GRmJ8Tl3cMdnAqJkCHaE+6XTe8u
 986K26eRIyU2oy6Zczom95wFn9Lgt/Q=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-jZVseHVaOaW_97apod4nSw-1; Tue, 21 Mar 2023 22:36:48 -0400
X-MC-Unique: jZVseHVaOaW_97apod4nSw-1
Received: by mail-oi1-f198.google.com with SMTP id
 q83-20020acad956000000b00387216d1bfbso1553204oig.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 19:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679452608;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZswUpIaZmBcMPoqevve8ROOrxF8yB084rqzIQZF6EMs=;
 b=c4mk6CBLI8wroF7n/e+LbMeB+XObwhM5XUsQZ1ExV6uRBlnZcwcoQ9uZKdYm7jNm6D
 ja5k/APu2VpwztcPc/sQrb/nl/iwnQffrtnAkiCO8WAZR38yAlWangoibgwpb04944/Q
 vpz7QkJmhqSStJRdPYR60pr3axlxYhswYjsaYKgQkBJOJ63c6BWhr+yvscdtZwI8F326
 mF6u20abXiykp7HUkZ16Udk63BfsFrLtRgxcZ7MKtlTR0VZDaZKSFjTvf2nizvgBcxTl
 REladRv1kvvmIcZVQYa2DulnQeRhOjZy1/pckPN5uiqRAV63AZ/9A6SFCRkPkAnglMRt
 Dpfw==
X-Gm-Message-State: AO0yUKXf3MZAOdTLhVShswGou92/RZagqwDg1dmDP2PZ1PBT3+Mq8Q99
 uszW1uxIkd8mcenmyncORTucSDzXpm5SLXdracbqOrysQSyexwW9N7Es6Fnd3GTqkWABTfaGHt/
 rJQnWfh4mA/dJe/0dP1KwanOgwEnetD2x7sO13A1RJgo8C+Fhig/ITY5WhA==
X-Received: by 2002:a05:6808:5ca:b0:386:9bb5:a786 with SMTP id
 d10-20020a05680805ca00b003869bb5a786mr461807oij.9.1679452608212; 
 Tue, 21 Mar 2023 19:36:48 -0700 (PDT)
X-Google-Smtp-Source: AK7set8Euo9xnX2EzZK6rq+8uzOIdBXb/npOzMT77cuKFmRJ6ZuOmV/eKi1ENLGwuGb+rqnFeE8pxZI4r58Kkes5j/k=
X-Received: by 2002:a05:6808:5ca:b0:386:9bb5:a786 with SMTP id
 d10-20020a05680805ca00b003869bb5a786mr461799oij.9.1679452607976; Tue, 21 Mar
 2023 19:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230321085953.24949-1-huangjie.albert@bytedance.com>
In-Reply-To: <20230321085953.24949-1-huangjie.albert@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Mar 2023 10:36:36 +0800
Message-ID: <CACGkMEvx_-3XbnBk1PakqODhL+C0Oy-BVORm=FsMxvzVcBbrnA@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: Suppress tx interrupt when napi_tx disable
To: Albert Huang <huangjie.albert@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
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

T24gVHVlLCBNYXIgMjEsIDIwMjMgYXQgNTowMOKAr1BNIEFsYmVydCBIdWFuZwo8aHVhbmdqaWUu
YWxiZXJ0QGJ5dGVkYW5jZS5jb20+IHdyb3RlOgo+Cj4gRnJvbTogImh1YW5namllLmFsYmVydCIg
PGh1YW5namllLmFsYmVydEBieXRlZGFuY2UuY29tPgo+Cj4gZml4IGNvbW1pdCA4ZDYyMmQyMWQy
NDggKCJ2aXJ0aW86IGZpeCB1cCB2aXJ0aW9fZGlzYWJsZV9jYiIpCj4KPiBpZiB3ZSBkaXNhYmxl
IHRoZSBuYXBpX3R4LiB3aGVuIHdlIHRyaWdlciBhIHR4IGludGVycnVwdCwgdGhlCgp0eXBvIHNo
b3VsZCBiZSAidHJpZ2dlciIKCj4gdnEtPmV2ZW50X3RyaWdnZXJlZCB3aWxsIGJlIHNldCB0byB0
cnVlLiBJdCB3aWxsIG5vIGxvbmdlciBiZQo+IHNldCB0byBmYWxzZS4gVW5sZXNzIHdlIGV4cGxp
Y2l0bHkgY2FsbCB2aXJ0cXVldWVfZW5hYmxlX2NiX2RlbGF5ZWQKPiBvciB2aXJ0cXVldWVfZW5h
YmxlX2NiX3ByZXBhcmUKPgo+IGlmIHdlIGRpc2FibGUgdGhlIG5hcGlfdHgsIEl0IHdpbGwgb25s
eSBiZSBjYWxsZWQgd2hlbiB0aGUgdHggcmluZwo+IGJ1ZmZlciBpcyByZWxhdGl2ZWx5IHNtYWxs
Ogo+IHZpcnRpb19uZXQtPnN0YXJ0X3htaXQ6Cj4gICAgICAgICBpZiAoc3EtPnZxLT5udW1fZnJl
ZSA8IDIrTUFYX1NLQl9GUkFHUykgewo+ICAgICAgICAgICAgICAgICBuZXRpZl9zdG9wX3N1YnF1
ZXVlKGRldiwgcW51bSk7Cj4gICAgICAgICAgICAgICAgIGlmICghdXNlX25hcGkgJiYKPiAgICAg
ICAgICAgICAgICAgICAgIHVubGlrZWx5KCF2aXJ0cXVldWVfZW5hYmxlX2NiX2RlbGF5ZWQoc3Et
PnZxKSkpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICAvKiBNb3JlIGp1c3QgZ290IHVzZWQs
IGZyZWUgdGhlbSB0aGVuIHJlY2hlY2suICovCj4gICAgICAgICAgICAgICAgICAgICAgICAgZnJl
ZV9vbGRfeG1pdF9za2JzKHNxLCBmYWxzZSk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYg
KHNxLT52cS0+bnVtX2ZyZWUgPj0gMitNQVhfU0tCX0ZSQUdTKSB7Cj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBuZXRpZl9zdGFydF9zdWJxdWV1ZShkZXYsIHFudW0pOwo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdmlydHF1ZXVlX2Rpc2FibGVfY2Ioc3EtPnZxKTsK
PiAgICAgICAgICAgICAgICAgICAgICAgICB9CgpUaGUgY29kZSBleGFtcGxlIGhlcmUgaXMgb3V0
IG9mIGRhdGUsIG1ha2Ugc3VyZSB5b3VyIHRyZWUgaGFzIHRoaXM6Cgpjb21taXQgZDcxZWJlODEx
NGI0YmY2MjI4MDRiODEwZjVlMjc0MDY5MDYwYTE3NApBdXRob3I6IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+CkRhdGU6ICAgVHVlIEphbiAxNyAxMTo0NzowNyAyMDIzICswODAwCgog
ICAgdmlydGlvLW5ldDogY29ycmVjdGx5IGVuYWJsZSBjYWxsYmFjayBkdXJpbmcgc3RhcnRfeG1p
dAoKPiAgICAgICAgICAgICAgICAgfQo+ICAgICAgICAgfQo+IEJlY2F1c2UgZXZlbnRfdHJpZ2dl
cmVkIGlzIHRydWUuVGhlcmVmb3JlLCBWUklOR19BVkFJTF9GX05PX0lOVEVSUlVQVCBvcgo+IFZS
SU5HX1BBQ0tFRF9FVkVOVF9GTEFHX0RJU0FCTEUgd2lsbCBub3QgYmUgc2V0LlNvIHdlIHVwZGF0
ZQo+IHZyaW5nX3VzZWRfZXZlbnQoJnZxLT5zcGxpdC52cmluZykgb3IgdnEtPnBhY2tlZC52cmlu
Zy5kcml2ZXItPm9mZl93cmFwCj4gZXZlcnkgdGltZSB3ZSBjYWxsIHZpcnRxdWV1ZV9nZXRfYnVm
X2N0eC5UaGlzIHdpbGwgYnJpbmcgbW9yZSBpbnRlcnJ1cHRpb25zLgoKQ2FuIHlvdSBwbGVhc2Ug
cG9zdCBob3cgdG8gdGVzdCB3aXRoIHRoZSBwZXJmb3JtYW5jZSBudW1iZXJzPwoKPgo+IGlmIGV2
ZW50X3RyaWdnZXJlZCBpcyBzZXQgdG8gdHJ1ZSwgZG8gbm90IHVwZGF0ZSB2cmluZ191c2VkX2V2
ZW50KCZ2cS0+c3BsaXQudnJpbmcpCj4gb3IgdnEtPnBhY2tlZC52cmluZy5kcml2ZXItPm9mZl93
cmFwCj4KPiBTaWduZWQtb2ZmLWJ5OiBodWFuZ2ppZS5hbGJlcnQgPGh1YW5namllLmFsYmVydEBi
eXRlZGFuY2UuY29tPgo+IC0tLQo+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNiAr
KysrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDMwN2UxMzljYjExZC4uZjQ4NmNjY2FkYmViIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTc5NSw3ICs3OTUsOCBAQCBzdGF0aWMgdm9pZCAq
dmlydHF1ZXVlX2dldF9idWZfY3R4X3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiAgICAg
ICAgIC8qIElmIHdlIGV4cGVjdCBhbiBpbnRlcnJ1cHQgZm9yIHRoZSBuZXh0IGVudHJ5LCB0ZWxs
IGhvc3QKPiAgICAgICAgICAqIGJ5IHdyaXRpbmcgZXZlbnQgaW5kZXggYW5kIGZsdXNoIG91dCB0
aGUgd3JpdGUgYmVmb3JlCj4gICAgICAgICAgKiB0aGUgcmVhZCBpbiB0aGUgbmV4dCBnZXRfYnVm
IGNhbGwuICovCj4gLSAgICAgICBpZiAoISh2cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93ICYg
VlJJTkdfQVZBSUxfRl9OT19JTlRFUlJVUFQpKQo+ICsgICAgICAgaWYgKCEodnEtPnNwbGl0LmF2
YWlsX2ZsYWdzX3NoYWRvdyAmIFZSSU5HX0FWQUlMX0ZfTk9fSU5URVJSVVBUKQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICYmICh2cS0+ZXZlbnRfdHJpZ2dlcmVkID09IGZhbHNlKSkKCkknbSBu
b3Qgc3VyZSB0aGlzIGNhbiB3b3JrLCB3aGVuIGV2ZW50X3RyaWdnZXJlZCBpcyB0cnVlIGl0IG1l
YW5zCndlJ3ZlIGdvdCBhbiBpbnRlcnJ1cHQsIGluIHRoaXMgY2FzZSBpZiB3ZSB3YW50IGFub3Ro
ZXIgaW50ZXJydXB0IGZvcgp0aGUgbmV4dCBlbnRyeSwgd2Ugc2hvdWxkIHVwZGF0ZSB1c2VkX2V2
ZW50IG90aGVyd2lzZSB3ZSB3aWxsIGxvc2UKdGhhdCBpbnRlcnJ1cHQ/CgpUaGFua3MKCj4gICAg
ICAgICAgICAgICAgIHZpcnRpb19zdG9yZV9tYih2cS0+d2Vha19iYXJyaWVycywKPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICZ2cmluZ191c2VkX2V2ZW50KCZ2cS0+c3BsaXQudnJp
bmcpLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3B1X3RvX3ZpcnRpbzE2KF92
cS0+dmRldiwgdnEtPmxhc3RfdXNlZF9pZHgpKTsKPiBAQCAtMTUyOSw3ICsxNTMwLDggQEAgc3Rh
dGljIHZvaWQgKnZpcnRxdWV1ZV9nZXRfYnVmX2N0eF9wYWNrZWQoc3RydWN0IHZpcnRxdWV1ZSAq
X3ZxLAo+ICAgICAgICAgICogYnkgd3JpdGluZyBldmVudCBpbmRleCBhbmQgZmx1c2ggb3V0IHRo
ZSB3cml0ZSBiZWZvcmUKPiAgICAgICAgICAqIHRoZSByZWFkIGluIHRoZSBuZXh0IGdldF9idWYg
Y2FsbC4KPiAgICAgICAgICAqLwo+IC0gICAgICAgaWYgKHZxLT5wYWNrZWQuZXZlbnRfZmxhZ3Nf
c2hhZG93ID09IFZSSU5HX1BBQ0tFRF9FVkVOVF9GTEFHX0RFU0MpCj4gKyAgICAgICBpZiAodnEt
PnBhY2tlZC5ldmVudF9mbGFnc19zaGFkb3cgPT0gVlJJTkdfUEFDS0VEX0VWRU5UX0ZMQUdfREVT
Qwo+ICsgICAgICAgICAgICAgICAgICAgICAgICYmICh2cS0+ZXZlbnRfdHJpZ2dlcmVkID09IGZh
bHNlKSkKPiAgICAgICAgICAgICAgICAgdmlydGlvX3N0b3JlX21iKHZxLT53ZWFrX2JhcnJpZXJz
LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnZxLT5wYWNrZWQudnJpbmcuZHJp
dmVyLT5vZmZfd3JhcCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNwdV90b19s
ZTE2KHZxLT5sYXN0X3VzZWRfaWR4KSk7Cj4gLS0KPiAyLjMxLjEKPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
