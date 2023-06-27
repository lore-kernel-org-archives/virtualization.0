Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79ECEB64DC
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 14:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F68B61450;
	Tue, 27 Jun 2023 14:57:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F68B61450
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U3tUcQLS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I8CFnTDi6KXH; Tue, 27 Jun 2023 14:57:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9DE2F61446;
	Tue, 27 Jun 2023 14:57:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9DE2F61446
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7292BC0072;
	Tue, 27 Jun 2023 14:57:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D50C2C0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 14:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A946561450
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 14:57:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A946561450
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id veblBXjLEP3U
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 14:57:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E4DE6144C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E4DE6144C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 14:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687877826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjhqKJ6qHLUSB8vtY/otx3G8KHzKt0XENzTe4gO6p4g=;
 b=U3tUcQLSOyeeIsnJGl4gYm8MNrluonvVlbLgBkucrXyzo7kpzrc+FhBdfTrBJGbkQW61dR
 Wv2Gb7RwxXDJvOH0/LbfieSppL6JOzo6palR2P7ahFFlsYhem2RRU3tbtt495DuQfznTv2
 mndzyrh9sxK7zQQB3oFCw4nDbXDnO64=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-8YycT1F9ME-wYhPGIlJjDg-1; Tue, 27 Jun 2023 10:57:03 -0400
X-MC-Unique: 8YycT1F9ME-wYhPGIlJjDg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-634dacfa27bso39535696d6.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 07:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687877822; x=1690469822;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MjhqKJ6qHLUSB8vtY/otx3G8KHzKt0XENzTe4gO6p4g=;
 b=l/chhqjF/0Kc0LzOW4TUqucXp1CKAqw9O6JzLWJgBovyA1AhQ1/rzt/YzzW6viiqN5
 am2AUNAXMaZg9Am/BHRu1qIzV2xVWGKWh2Tr+0Xo+P4c+eicL8df+sprhwdHX5GG2SFa
 itZ4t/McyfHJJ0lNwHoJ3lZddqdKCjbHdi282xak1AeRqMZQJNFVE/wmSu3qAIoA4blr
 nsaP8eyKMcrLavuYcz3/w/8p8rubVxAEBBtz61OhkMvpa2NBmTFH33Eryc+g6OtODpLZ
 Ru/hbWSHu9giZKusP7jZE7Xm++9wLXlIjJ1rnkvUM38yPnv0zu8sxFnikVGp3EgmyGtL
 vwFQ==
X-Gm-Message-State: AC+VfDxuD8jy5RREy1NUYHohwAwkiui5y3h3LN60e26GXdIi9L42VA1u
 K/zs7AbUah6XDDSLArUwkI8ebgacLB3AT8hgNHYMigf5SleYvEEd6oTXtM09+Puvh6MDATMjlGy
 1xH9nVc+ahvwDvuTbgRZBZj8+l/VAeG+5jtdhkL/shA==
X-Received: by 2002:a05:6214:2aae:b0:632:32ce:7947 with SMTP id
 js14-20020a0562142aae00b0063232ce7947mr14376529qvb.28.1687877822161; 
 Tue, 27 Jun 2023 07:57:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5FD4BbrfWJUBHlxMixbL2nRBP622c0YmQmLo/tSNy5xIH+gMS3yY4rfgKonMVPNm3KAa5EFw==
X-Received: by 2002:a05:6214:2aae:b0:632:32ce:7947 with SMTP id
 js14-20020a0562142aae00b0063232ce7947mr14376506qvb.28.1687877821863; 
 Tue, 27 Jun 2023 07:57:01 -0700 (PDT)
Received: from redhat.com ([45.144.113.5]) by smtp.gmail.com with ESMTPSA id
 fc4-20020ad44f24000000b00635ef0579c2sm1022904qvb.39.2023.06.27.07.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 07:57:01 -0700 (PDT)
Date: Tue, 27 Jun 2023 10:56:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v10 02/10] virtio_ring: introduce
 virtqueue_set_premapped()
Message-ID: <20230627105503-mutt-send-email-mst@kernel.org>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEt3xRvn5na+f4vHjFQoJJcPTvvE3Yd_bGxrDFo9owkqCA@mail.gmail.com>
 <1687855801.1280077-4-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1687855801.1280077-4-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gVHVlLCBKdW4gMjcsIDIwMjMgYXQgMDQ6NTA6MDFQTSArMDgwMCwgWHVhbiBaaHVvIHdyb3Rl
Ogo+IE9uIFR1ZSwgMjcgSnVuIDIwMjMgMTY6MDM6MjMgKzA4MDAsIEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gT24gRnJpLCBKdW4gMiwgMjAyMyBhdCA1OjIy4oCv
UE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+Cj4g
PiA+IFRoaXMgaGVscGVyIGFsbG93cyB0aGUgZHJpdmVyIGNoYW5nZSB0aGUgZG1hIG1vZGUgdG8g
cHJlbWFwcGVkIG1vZGUuCj4gPiA+IFVuZGVyIHRoZSBwcmVtYXBwZWQgbW9kZSwgdGhlIHZpcnRp
byBjb3JlIGRvIG5vdCBkbyBkbWEgbWFwcGluZwo+ID4gPiBpbnRlcm5hbGx5Lgo+ID4gPgo+ID4g
PiBUaGlzIGp1c3Qgd29yayB3aGVuIHRoZSB1c2VfZG1hX2FwaSBpcyB0cnVlLiBJZiB0aGUgdXNl
X2RtYV9hcGkgaXMgZmFsc2UsCj4gPiA+IHRoZSBkbWEgb3B0aW9ucyBpcyBub3QgdGhyb3VnaCB0
aGUgRE1BIEFQSXMsIHRoYXQgaXMgbm90IHRoZSBzdGFuZGFyZAo+ID4gPiB3YXkgb2YgdGhlIGxp
bnV4IGtlcm5lbC4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1
b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+ID4gLS0tCj4gPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcmluZy5jIHwgNDAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiA+
ICBpbmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAgIHwgIDIgKysKPiA+ID4gIDIgZmlsZXMgY2hh
bmdlZCwgNDIgaW5zZXJ0aW9ucygrKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4g
aW5kZXggNzJlZDA3YTYwNGQ0Li4yYWZkZmI5ZTNlMzAgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYwo+ID4gPiBAQCAtMTcyLDYgKzE3Miw5IEBAIHN0cnVjdCB2cmluZ192aXJ0cXVldWUg
ewo+ID4gPiAgICAgICAgIC8qIEhvc3QgcHVibGlzaGVzIGF2YWlsIGV2ZW50IGlkeCAqLwo+ID4g
PiAgICAgICAgIGJvb2wgZXZlbnQ7Cj4gPiA+Cj4gPiA+ICsgICAgICAgLyogRG8gRE1BIG1hcHBp
bmcgYnkgZHJpdmVyICovCj4gPiA+ICsgICAgICAgYm9vbCBwcmVtYXBwZWQ7Cj4gPiA+ICsKPiA+
ID4gICAgICAgICAvKiBIZWFkIG9mIGZyZWUgYnVmZmVyIGxpc3QuICovCj4gPiA+ICAgICAgICAg
dW5zaWduZWQgaW50IGZyZWVfaGVhZDsKPiA+ID4gICAgICAgICAvKiBOdW1iZXIgd2UndmUgYWRk
ZWQgc2luY2UgbGFzdCBzeW5jLiAqLwo+ID4gPiBAQCAtMjA1OSw2ICsyMDYyLDcgQEAgc3RhdGlj
IHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfcGFja2VkKAo+ID4gPiAg
ICAgICAgIHZxLT5wYWNrZWRfcmluZyA9IHRydWU7Cj4gPiA+ICAgICAgICAgdnEtPmRtYV9kZXYg
PSBkbWFfZGV2Owo+ID4gPiAgICAgICAgIHZxLT51c2VfZG1hX2FwaSA9IHZyaW5nX3VzZV9kbWFf
YXBpKHZkZXYpOwo+ID4gPiArICAgICAgIHZxLT5wcmVtYXBwZWQgPSBmYWxzZTsKPiA+ID4KPiA+
ID4gICAgICAgICB2cS0+aW5kaXJlY3QgPSB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElP
X1JJTkdfRl9JTkRJUkVDVF9ERVNDKSAmJgo+ID4gPiAgICAgICAgICAgICAgICAgIWNvbnRleHQ7
Cj4gPiA+IEBAIC0yNTQ4LDYgKzI1NTIsNyBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqX192
cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiA+ID4gICNlbmRpZgo+ID4g
PiAgICAgICAgIHZxLT5kbWFfZGV2ID0gZG1hX2RldjsKPiA+ID4gICAgICAgICB2cS0+dXNlX2Rt
YV9hcGkgPSB2cmluZ191c2VfZG1hX2FwaSh2ZGV2KTsKPiA+ID4gKyAgICAgICB2cS0+cHJlbWFw
cGVkID0gZmFsc2U7Cj4gPiA+Cj4gPiA+ICAgICAgICAgdnEtPmluZGlyZWN0ID0gdmlydGlvX2hh
c19mZWF0dXJlKHZkZXYsIFZJUlRJT19SSU5HX0ZfSU5ESVJFQ1RfREVTQykgJiYKPiA+ID4gICAg
ICAgICAgICAgICAgICFjb250ZXh0Owo+ID4gPiBAQCAtMjY5MSw2ICsyNjk2LDQxIEBAIGludCB2
aXJ0cXVldWVfcmVzaXplKHN0cnVjdCB2aXJ0cXVldWUgKl92cSwgdTMyIG51bSwKPiA+ID4gIH0K
PiA+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9yZXNpemUpOwo+ID4gPgo+ID4gPiAr
LyoqCj4gPiA+ICsgKiB2aXJ0cXVldWVfc2V0X3ByZW1hcHBlZCAtIHNldCB0aGUgdnJpbmcgcHJl
bWFwcGVkIG1vZGUKPiA+ID4gKyAqIEBfdnE6IHRoZSBzdHJ1Y3QgdmlydHF1ZXVlIHdlJ3JlIHRh
bGtpbmcgYWJvdXQuCj4gPiA+ICsgKgo+ID4gPiArICogRW5hYmxlIHRoZSBwcmVtYXBwZWQgbW9k
ZSBvZiB0aGUgdnEuCj4gPiA+ICsgKgo+ID4gPiArICogVGhlIHZyaW5nIGluIHByZW1hcHBlZCBt
b2RlIGRvZXMgbm90IGRvIGRtYSBpbnRlcm5hbGx5LCBzbyB0aGUgZHJpdmVyIG11c3QKPiA+ID4g
KyAqIGRvIGRtYSBtYXBwaW5nIGluIGFkdmFuY2UuIFRoZSBkcml2ZXIgbXVzdCBwYXNzIHRoZSBk
bWFfYWRkcmVzcyB0aHJvdWdoCj4gPiA+ICsgKiBkbWFfYWRkcmVzcyBvZiBzY2F0dGVybGlzdC4g
V2hlbiB0aGUgZHJpdmVyIGdvdCBhIHVzZWQgYnVmZmVyIGZyb20KPiA+ID4gKyAqIHRoZSB2cmlu
ZywgaXQgaGFzIHRvIHVubWFwIHRoZSBkbWEgYWRkcmVzcy4gU28gdGhlIGRyaXZlciBtdXN0IGNh
bGwKPiA+ID4gKyAqIHZpcnRxdWV1ZV9nZXRfYnVmX3ByZW1hcHBlZCgpL3ZpcnRxdWV1ZV9kZXRh
Y2hfdW51c2VkX2J1Zl9wcmVtYXBwZWQoKS4KPiA+ID4gKyAqCj4gPiA+ICsgKiBUaGlzIG11c3Qg
YmUgY2FsbGVkIGJlZm9yZSBhZGRpbmcgYW55IGJ1ZiB0byB2cmluZy4KPiA+Cj4gPiBBbmQgYW55
IG9sZCBidWZmZXIgc2hvdWxkIGJlIGRldGFjaGVkPwo+IAo+IEkgbWVhbiB0aGF0IGJlZm9yZSBh
ZGRpbmcgYW55IGJ1ZiwgU28gdGhlcmUgYXJlIG5vdCBvbGQgYnVmZmVyLgo+IAoKT2guIFNvIHB1
dCB0aGlzIGluIHRoZSBzYW1lIHNlbnRlbmNlOgoKCVRoaXMgZnVuY3Rpb24gbXVzdCBiZSBjYWxs
ZWQgaW1tZWRpYXRlbHkgYWZ0ZXIgY3JlYXRpbmcgdGhlIHZxLAoJb3IgYWZ0ZXIgdnEgcmVzZXQs
IGFuZCBiZWZvcmUgYWRkaW5nIGFueSBidWZmZXJzIHRvIGl0LgoKCj4gPgo+ID4gPiArICogU28g
dGhpcyBzaG91bGQgYmUgY2FsbGVkIGltbWVkaWF0ZWx5IGFmdGVyIGluaXQgdnEgb3IgdnEgcmVz
ZXQuCgpEbyB5b3UgcmVhbGx5IG5lZWQgdG8gY2FsbCB0aGlzIGFnYWluIGFmdGVyIGVhY2ggcmVz
ZXQ/CgoKPiA+IEFueSB3YXkgdG8gZGV0ZWN0IGFuZCB3YXJuIGluIHRoaXMgY2FzZT8gKG5vdCBh
IG11c3QgaWYgaXQncyB0b28KPiA+IGV4cGVuc2l2ZSB0byBkbyB0aGUgY2hlY2spCj4gCj4gCj4g
SSBjYW4gdHJ5IHRvIGNoZWNrIHdoZXRoZXIgdGhlIHFldWV1IGlzIGVtcHR5Lgo+IAo+IAo+ID4K
PiA+ID4gKyAqCj4gPiA+ICsgKiBDYWxsZXIgbXVzdCBlbnN1cmUgd2UgZG9uJ3QgY2FsbCB0aGlz
IHdpdGggb3RoZXIgdmlydHF1ZXVlIG9wZXJhdGlvbnMKPiA+ID4gKyAqIGF0IHRoZSBzYW1lIHRp
bWUgKGV4Y2VwdCB3aGVyZSBub3RlZCkuCj4gPiA+ICsgKgo+ID4gPiArICogUmV0dXJucyB6ZXJv
IG9yIGEgbmVnYXRpdmUgZXJyb3IuCj4gPiA+ICsgKiAwOiBzdWNjZXNzLgo+ID4gPiArICogLUVJ
TlZBTDogdnJpbmcgZG9lcyBub3QgdXNlIHRoZSBkbWEgYXBpLCBzbyB3ZSBjYW4gbm90IGVuYWJs
ZSBwcmVtYXBwZWQgbW9kZS4KPiA+ID4gKyAqLwo+ID4gPiAraW50IHZpcnRxdWV1ZV9zZXRfcHJl
bWFwcGVkKHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPiA+ID4gK3sKPiA+ID4gKyAgICAgICBzdHJ1
Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ID4gPiArCj4gPiA+ICsgICAg
ICAgaWYgKCF2cS0+dXNlX2RtYV9hcGkpCj4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJ
TlZBTDsKPiA+ID4gKwo+ID4gPiArICAgICAgIHZxLT5wcmVtYXBwZWQgPSB0cnVlOwo+ID4KPiA+
IEkgZ3Vlc3MgdGhlcmUgc2hvdWxkIGJlIGEgd2F5IHRvIGRpc2FibGUgaXQuIFdvdWxkIGl0IGJl
IHVzZWZ1bCBmb3IKPiA+IHRoZSBjYXNlIHdoZW4gQUZfWERQIHNvY2tldHMgd2VyZSBkZXN0cm95
ZWQ/Cj4gCj4gWWVzLgo+IAo+IFdoZW4gd2UgcmVzZXQgdGhlIHF1ZXVlLCB0aGUgdnEtPnByZW1h
cHBlZCB3aWxsIGJlIHNldCB0byAwLgo+IAo+IFRoZSBpcyBjYWxsZWQgYWZ0ZXIgZmluZF92cXMg
b3IgcmVzZXQgdnEuCj4gCj4gVGhhbmtzLgo+IAo+IAo+IAo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+
Cj4gPiA+ICsKPiA+ID4gKyAgICAgICByZXR1cm4gMDsKPiA+ID4gK30KPiA+ID4gK0VYUE9SVF9T
WU1CT0xfR1BMKHZpcnRxdWV1ZV9zZXRfcHJlbWFwcGVkKTsKPiA+ID4gKwo+ID4gPiAgLyogT25s
eSBhdmFpbGFibGUgZm9yIHNwbGl0IHJpbmcgKi8KPiA+ID4gIHN0cnVjdCB2aXJ0cXVldWUgKnZy
aW5nX25ld192aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBudW0sCj4gPiA+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+ID4g
PiBpbmRleCBiOTMyMzhkYjk0ZTMuLjFmYzBlMTAyM2JkNCAxMDA2NDQKPiA+ID4gLS0tIGEvaW5j
bHVkZS9saW51eC92aXJ0aW8uaAo+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4g
PiA+IEBAIC03OCw2ICs3OCw4IEBAIGJvb2wgdmlydHF1ZXVlX2VuYWJsZV9jYihzdHJ1Y3Qgdmly
dHF1ZXVlICp2cSk7Cj4gPiA+Cj4gPiA+ICB1bnNpZ25lZCB2aXJ0cXVldWVfZW5hYmxlX2NiX3By
ZXBhcmUoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+ID4gPgo+ID4gPiAraW50IHZpcnRxdWV1ZV9z
ZXRfcHJlbWFwcGVkKHN0cnVjdCB2aXJ0cXVldWUgKl92cSk7Cj4gPiA+ICsKPiA+ID4gIGJvb2wg
dmlydHF1ZXVlX3BvbGwoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHVuc2lnbmVkKTsKPiA+ID4KPiA+
ID4gIGJvb2wgdmlydHF1ZXVlX2VuYWJsZV9jYl9kZWxheWVkKHN0cnVjdCB2aXJ0cXVldWUgKnZx
KTsKPiA+ID4gLS0KPiA+ID4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+ID4gPgo+ID4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
