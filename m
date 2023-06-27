Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8978EEB64D9
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 08:03:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 10ED6416ED;
	Tue, 27 Jun 2023 08:03:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 10ED6416ED
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NtQ4/bd6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SQXTs3kI8Gdv; Tue, 27 Jun 2023 08:03:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8E82B416D6;
	Tue, 27 Jun 2023 08:03:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E82B416D6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E781C007C;
	Tue, 27 Jun 2023 08:03:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F9F8C0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:03:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A20480CE0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:03:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A20480CE0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NtQ4/bd6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jfxzn81PMKhY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:03:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 15DED80CCE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 15DED80CCE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687853016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tQ1KiUIpCNyDhBtgM+t3Kj4l2XehoEKxQO7OYIILltw=;
 b=NtQ4/bd6BA8tX8JLRDRXXJOvbaKx+veH+RpDnl6Q9Aez9ydQQJOwaAtjn5iktD76P1Na3b
 ZYx+eYFZdoVpETNtnxA7LELMAzYg1qC7IFNuXZDv1In0jFss0aIPN8mXXGR9oJV1O6cYB+
 6xCSiVeVjVVdpQ3qlNT3rwj7ps7/yh4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-j8GwQiDpOPyQCx4EZ8oCjA-1; Tue, 27 Jun 2023 04:03:33 -0400
X-MC-Unique: j8GwQiDpOPyQCx4EZ8oCjA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f76712f950so3564510e87.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 01:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687853011; x=1690445011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQ1KiUIpCNyDhBtgM+t3Kj4l2XehoEKxQO7OYIILltw=;
 b=ldLZUDy/ggJuj9nr3YDN6VVNp+U4Dp13+URTpYEyfw9RVzBMJp0cGs+2AeJuPX6F4w
 2Eq+v933bf3sfRs6S1v4MAgsc5iHaTt3JkxbVXJkKqGTrL7zGfHvt19i7C+TTVWCed7I
 HVOx/yA5HSuCw/pdI3M+qWJI4u9qtd17zq/v1wldzI15amx6mXMISJKUz89mCWCHU9tq
 u4NKOJ27JXl+yCvtOqWTbflfO2HU1QQPdpPnA9SKBMOA1kya6FkdcoChfV3yYaxK12IO
 BJMHv50fRKXaBE+NTQoJ2ddx8oNP7OCMCFIsSLUDHFme3b6Mrz3RtsWNNixXQtzmK/4o
 O61w==
X-Gm-Message-State: AC+VfDxRppvigzCX+jQb8rY8YVQYsDEsFTut+aS3+93bbYuylgKJf2bf
 UVqjlsPBvMcvv4wnM2OmHN5ZC+Xgzl7FVerrm9+JOtH31DGm+VRwF5rYNwAENz4aJkmvLtLJvoD
 hR8OoXyeuJFsXbs07/HwjDew+UbtW99vNJatXwoKJqWy+tZNHbt+Yuv08ow==
X-Received: by 2002:a19:7111:0:b0:4f3:9136:9cd0 with SMTP id
 m17-20020a197111000000b004f391369cd0mr17569911lfc.44.1687853011632; 
 Tue, 27 Jun 2023 01:03:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5/gIIK3zpzyK5hdGmnBvsXW1vftwaoK5OxHi4uoENLn5lDqWlNIYsZvweYSeoKVGgDi8bQXCRsOIUaUEHvEiw=
X-Received: by 2002:a19:7111:0:b0:4f3:9136:9cd0 with SMTP id
 m17-20020a197111000000b004f391369cd0mr17569879lfc.44.1687853011290; Tue, 27
 Jun 2023 01:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230602092206.50108-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Jun 2023 16:03:19 +0800
Message-ID: <CACGkMEuS3DsjgP0RB2C-DbsACq4FU6RKD4C+p3dOGQHWdZJJhg@mail.gmail.com>
Subject: Re: [PATCH vhost v10 01/10] virtio_ring: put mapping error check in
 vring_map_one_sg
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
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

T24gRnJpLCBKdW4gMiwgMjAyMyBhdCA1OjIy4oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBUaGlzIHBhdGNoIHB1dCB0aGUgZG1hIGFkZHIgZXJy
b3IgY2hlY2sgaW4gdnJpbmdfbWFwX29uZV9zZygpLgo+Cj4gVGhlIGJlbmVmaXRzIG9mIGRvaW5n
IHRoaXM6Cj4KPiAxLiByZWR1Y2Ugb25lIGp1ZGdtZW50IG9mIHZxLT51c2VfZG1hX2FwaS4KPiAy
LiBtYWtlIHZyaW5nX21hcF9vbmVfc2cgbW9yZSBzaW1wbGUsIHdpdGhvdXQgY2FsbGluZwo+ICAg
IHZyaW5nX21hcHBpbmdfZXJyb3IgdG8gY2hlY2sgdGhlIHJldHVybiB2YWx1ZS4gc2ltcGxpZmll
cyBzdWJzZXF1ZW50Cj4gICAgY29kZQo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFu
emh1b0BsaW51eC5hbGliYWJhLmNvbT4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPgoKVGhhbmtzCgoKPiAtLS0KPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
YyB8IDM3ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQo+ICAxIGZpbGUgY2hh
bmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5n
LmMKPiBpbmRleCBjNTMxMGVhZjhiNDYuLjcyZWQwN2E2MDRkNCAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYwo+IEBAIC0zNTUsOSArMzU1LDggQEAgc3RhdGljIHN0cnVjdCBkZXZpY2UgKnZyaW5nX2Rt
YV9kZXYoY29uc3Qgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEpCj4gIH0KPgo+ICAvKiBNYXAg
b25lIHNnIGVudHJ5LiAqLwo+IC1zdGF0aWMgZG1hX2FkZHJfdCB2cmluZ19tYXBfb25lX3NnKGNv
bnN0IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IHNjYXR0ZXJsaXN0ICpzZywKPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGVudW0gZG1hX2RhdGFfZGlyZWN0aW9uIGRpcmVjdGlvbikKPiArc3Rh
dGljIGludCB2cmluZ19tYXBfb25lX3NnKGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZx
LCBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBl
bnVtIGRtYV9kYXRhX2RpcmVjdGlvbiBkaXJlY3Rpb24sIGRtYV9hZGRyX3QgKmFkZHIpCj4gIHsK
PiAgICAgICAgIGlmICghdnEtPnVzZV9kbWFfYXBpKSB7Cj4gICAgICAgICAgICAgICAgIC8qCj4g
QEAgLTM2Niw3ICszNjUsOCBAQCBzdGF0aWMgZG1hX2FkZHJfdCB2cmluZ19tYXBfb25lX3NnKGNv
bnN0IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ICAgICAgICAgICAgICAgICAgKiBkZXBl
bmRpbmcgb24gdGhlIGRpcmVjdGlvbi4KPiAgICAgICAgICAgICAgICAgICovCj4gICAgICAgICAg
ICAgICAgIGttc2FuX2hhbmRsZV9kbWEoc2dfcGFnZShzZyksIHNnLT5vZmZzZXQsIHNnLT5sZW5n
dGgsIGRpcmVjdGlvbik7Cj4gLSAgICAgICAgICAgICAgIHJldHVybiAoZG1hX2FkZHJfdClzZ19w
aHlzKHNnKTsKPiArICAgICAgICAgICAgICAgKmFkZHIgPSAoZG1hX2FkZHJfdClzZ19waHlzKHNn
KTsKPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gICAgICAgICB9Cj4KPiAgICAgICAgIC8q
Cj4gQEAgLTM3NCw5ICszNzQsMTQgQEAgc3RhdGljIGRtYV9hZGRyX3QgdnJpbmdfbWFwX29uZV9z
Zyhjb25zdCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiAgICAgICAgICAqIHRoZSB3YXkg
aXQgZXhwZWN0cyAod2UgZG9uJ3QgZ3VhcmFudGVlIHRoYXQgdGhlIHNjYXR0ZXJsaXN0Cj4gICAg
ICAgICAgKiB3aWxsIGV4aXN0IGZvciB0aGUgbGlmZXRpbWUgb2YgdGhlIG1hcHBpbmcpLgo+ICAg
ICAgICAgICovCj4gLSAgICAgICByZXR1cm4gZG1hX21hcF9wYWdlKHZyaW5nX2RtYV9kZXYodnEp
LAo+ICsgICAgICAgKmFkZHIgPSBkbWFfbWFwX3BhZ2UodnJpbmdfZG1hX2Rldih2cSksCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHNnX3BhZ2Uoc2cpLCBzZy0+b2Zmc2V0LCBzZy0+bGVu
Z3RoLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkaXJlY3Rpb24pOwo+ICsKPiArICAg
ICAgIGlmIChkbWFfbWFwcGluZ19lcnJvcih2cmluZ19kbWFfZGV2KHZxKSwgKmFkZHIpKQo+ICsg
ICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsKPiArCj4gKyAgICAgICByZXR1cm4gMDsKPiAg
fQo+Cj4gIHN0YXRpYyBkbWFfYWRkcl90IHZyaW5nX21hcF9zaW5nbGUoY29uc3Qgc3RydWN0IHZy
aW5nX3ZpcnRxdWV1ZSAqdnEsCj4gQEAgLTU4OCw4ICs1OTMsOSBAQCBzdGF0aWMgaW5saW5lIGlu
dCB2aXJ0cXVldWVfYWRkX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPgo+ICAgICAgICAg
Zm9yIChuID0gMDsgbiA8IG91dF9zZ3M7IG4rKykgewo+ICAgICAgICAgICAgICAgICBmb3IgKHNn
ID0gc2dzW25dOyBzZzsgc2cgPSBzZ19uZXh0KHNnKSkgewo+IC0gICAgICAgICAgICAgICAgICAg
ICAgIGRtYV9hZGRyX3QgYWRkciA9IHZyaW5nX21hcF9vbmVfc2codnEsIHNnLCBETUFfVE9fREVW
SUNFKTsKPiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAodnJpbmdfbWFwcGluZ19lcnJvcih2
cSwgYWRkcikpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZG1hX2FkZHJfdCBhZGRyOwo+ICsK
PiArICAgICAgICAgICAgICAgICAgICAgICBpZiAodnJpbmdfbWFwX29uZV9zZyh2cSwgc2csIERN
QV9UT19ERVZJQ0UsICZhZGRyKSkKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdv
dG8gdW5tYXBfcmVsZWFzZTsKPgo+ICAgICAgICAgICAgICAgICAgICAgICAgIHByZXYgPSBpOwo+
IEBAIC02MDMsOCArNjA5LDkgQEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxp
dChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gICAgICAgICB9Cj4gICAgICAgICBmb3IgKDsgbiA8
IChvdXRfc2dzICsgaW5fc2dzKTsgbisrKSB7Cj4gICAgICAgICAgICAgICAgIGZvciAoc2cgPSBz
Z3Nbbl07IHNnOyBzZyA9IHNnX25leHQoc2cpKSB7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ZG1hX2FkZHJfdCBhZGRyID0gdnJpbmdfbWFwX29uZV9zZyh2cSwgc2csIERNQV9GUk9NX0RFVklD
RSk7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKHZyaW5nX21hcHBpbmdfZXJyb3IodnEs
IGFkZHIpKQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGRtYV9hZGRyX3QgYWRkcjsKPiArCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHZyaW5nX21hcF9vbmVfc2codnEsIHNnLCBETUFf
RlJPTV9ERVZJQ0UsICZhZGRyKSkKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdv
dG8gdW5tYXBfcmVsZWFzZTsKPgo+ICAgICAgICAgICAgICAgICAgICAgICAgIHByZXYgPSBpOwo+
IEBAIC0xMjc5LDkgKzEyODYsOCBAQCBzdGF0aWMgaW50IHZpcnRxdWV1ZV9hZGRfaW5kaXJlY3Rf
cGFja2VkKHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+Cj4gICAgICAgICBmb3IgKG4gPSAw
OyBuIDwgb3V0X3NncyArIGluX3NnczsgbisrKSB7Cj4gICAgICAgICAgICAgICAgIGZvciAoc2cg
PSBzZ3Nbbl07IHNnOyBzZyA9IHNnX25leHQoc2cpKSB7Cj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgYWRkciA9IHZyaW5nX21hcF9vbmVfc2codnEsIHNnLCBuIDwgb3V0X3NncyA/Cj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERNQV9UT19ERVZJQ0UgOiBETUFfRlJP
TV9ERVZJQ0UpOwo+IC0gICAgICAgICAgICAgICAgICAgICAgIGlmICh2cmluZ19tYXBwaW5nX2Vy
cm9yKHZxLCBhZGRyKSkKPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAodnJpbmdfbWFwX29u
ZV9zZyh2cSwgc2csIG4gPCBvdXRfc2dzID8KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBETUFfVE9fREVWSUNFIDogRE1BX0ZST01fREVWSUNFLCAmYWRkcikp
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIHVubWFwX3JlbGVhc2U7Cj4K
PiAgICAgICAgICAgICAgICAgICAgICAgICBkZXNjW2ldLmZsYWdzID0gY3B1X3RvX2xlMTYobiA8
IG91dF9zZ3MgPwo+IEBAIC0xNDI2LDkgKzE0MzIsMTAgQEAgc3RhdGljIGlubGluZSBpbnQgdmly
dHF1ZXVlX2FkZF9wYWNrZWQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLAo+ICAgICAgICAgYyA9IDA7
Cj4gICAgICAgICBmb3IgKG4gPSAwOyBuIDwgb3V0X3NncyArIGluX3NnczsgbisrKSB7Cj4gICAg
ICAgICAgICAgICAgIGZvciAoc2cgPSBzZ3Nbbl07IHNnOyBzZyA9IHNnX25leHQoc2cpKSB7Cj4g
LSAgICAgICAgICAgICAgICAgICAgICAgZG1hX2FkZHJfdCBhZGRyID0gdnJpbmdfbWFwX29uZV9z
Zyh2cSwgc2csIG4gPCBvdXRfc2dzID8KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRE1BX1RPX0RFVklDRSA6IERNQV9GUk9NX0RFVklDRSk7Cj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgaWYgKHZyaW5nX21hcHBpbmdfZXJyb3IodnEsIGFkZHIpKQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGRtYV9hZGRyX3QgYWRkcjsKPiArCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKHZyaW5nX21hcF9vbmVfc2codnEsIHNnLCBuIDwgb3V0X3NncyA/Cj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRE1BX1RPX0RFVklDRSA6IERN
QV9GUk9NX0RFVklDRSwgJmFkZHIpKQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Z290byB1bm1hcF9yZWxlYXNlOwo+Cj4gICAgICAgICAgICAgICAgICAgICAgICAgZmxhZ3MgPSBj
cHVfdG9fbGUxNih2cS0+cGFja2VkLmF2YWlsX3VzZWRfZmxhZ3MgfAo+IC0tCj4gMi4zMi4wLjMu
ZzAxMTk1Y2Y5Zgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
