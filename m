Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36717C001B0
	for <virtualization@archiver.kernel.org>; Mon, 14 Aug 2023 11:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B45B061030;
	Mon, 14 Aug 2023 11:25:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B45B061030
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ilXc7RSx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DVoIaBZOCq4D; Mon, 14 Aug 2023 11:25:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0698E60F8E;
	Mon, 14 Aug 2023 11:25:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0698E60F8E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B9B0C0072;
	Mon, 14 Aug 2023 11:25:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0934C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 11:25:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A2ECD40523
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 11:25:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A2ECD40523
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ilXc7RSx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SXAUTY49S_I6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 11:25:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4D86740151
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 11:25:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4D86740151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692012309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A5yFkqGLAbx9780NfgouP2k81nxEAsxnlewTCXDZKT8=;
 b=ilXc7RSx1wEWtNvfkAteeLDzfk9owKLlEWssq/AGmTeKOTx3rxDmuPV4N/+vxBnqdr/Kwq
 HLJqlm4W9xiDq5voZxjK8hsRjHP10P85/BpugEQjgdytlFiBVhw7c6YPioykGrWEJb0I0Z
 jV3lm5/Qw4skACh4Qruej5gvy88XTGk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-ILgVzJqhN6u1Jpxj4vup1g-1; Mon, 14 Aug 2023 07:25:07 -0400
X-MC-Unique: ILgVzJqhN6u1Jpxj4vup1g-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b9ba719605so43427501fa.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 04:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692012306; x=1692617106;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A5yFkqGLAbx9780NfgouP2k81nxEAsxnlewTCXDZKT8=;
 b=FrhoR23ttpBTNG0QF8E2OSTZzO1UXB6rGXGJzbfcx/JVIm7fSR3mi10yPJQqdURSHv
 Q5YAyXQeoXsTUAaP9xL35YKXE7ySUd+s7P2rz5P/1p3V2coXMtTeefaYv3uIaCLa+2DO
 0x3HvnA5AF4U37v7SuzzaWWcffg8yDwD+gxDWZYsyJQVfR3kFbWvt/wURP13NLeRuS/B
 2gmNqyTqO+S65hbCTbeyxMGip/RAcJyCAKxLRb2MCs/O0VquDlA23t1eeaJfk4LjESWI
 ZPUF5gchlJKEHdGWD0Y4/eRSB3hsdcuNvKhUzQQG/MQN5+EL5hQZa+ujJuyXppWljzVX
 2DCQ==
X-Gm-Message-State: AOJu0YwRQ7mlCXFJPOTfD9pWNjtcewkDb7hBzEEP1vBhj1fTHEP60M3a
 Vzh7Jwu25XRTwKQbgCfixybeZSk/+cEuBXgPJ/ZKP7UsmHFJ//jLoRnsGbaEPXeVH3X5z6qoH9q
 j3ytPYN6m/iGKDcKqWHttLadVJxaz/TQ1ZmgDGgM4Og==
X-Received: by 2002:a2e:9e42:0:b0:2b6:de52:357 with SMTP id
 g2-20020a2e9e42000000b002b6de520357mr5802368ljk.40.1692012306398; 
 Mon, 14 Aug 2023 04:25:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7GN0c3iSPO6lf+9QKRg8LqTQs22sq8qWlpAoK8JTl071RpztkZugmMhPN+lO9ut/U1h2cmQ==
X-Received: by 2002:a2e:9e42:0:b0:2b6:de52:357 with SMTP id
 g2-20020a2e9e42000000b002b6de520357mr5802347ljk.40.1692012306024; 
 Mon, 14 Aug 2023 04:25:06 -0700 (PDT)
Received: from redhat.com ([2.55.42.146]) by smtp.gmail.com with ESMTPSA id
 b12-20020a170906660c00b00992c92af6f4sm5597282ejp.144.2023.08.14.04.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 04:25:05 -0700 (PDT)
Date: Mon, 14 Aug 2023 07:24:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v13 05/12] virtio_ring: introduce virtqueue_dma_dev()
Message-ID: <20230814072350-mutt-send-email-mst@kernel.org>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
 <1692003413.6339955-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1692003413.6339955-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
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

T24gTW9uLCBBdWcgMTQsIDIwMjMgYXQgMDQ6NTY6NTNQTSArMDgwMCwgWHVhbiBaaHVvIHdyb3Rl
Ogo+IE9uIE1vbiwgMTQgQXVnIDIwMjMgMTE6MDU6NDkgKzA4MDAsIEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gT24gVGh1LCBBdWcgMTAsIDIwMjMgYXQgODozMeKA
r1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPgo+
ID4gPiBBZGRlZCB2aXJ0cXVldWVfZG1hX2RldigpIHRvIGdldCBETUEgZGV2aWNlIGZvciB2aXJ0
aW8uIFRoZW4gdGhlCj4gPiA+IGNhbGxlciBjYW4gZG8gZG1hIG9wZXJhdGlvbiBpbiBhZHZhbmNl
LiBUaGUgcHVycG9zZSBpcyB0byBrZWVwIG1lbW9yeQo+ID4gPiBtYXBwZWQgYWNyb3NzIG11bHRp
cGxlIGFkZC9nZXQgYnVmIG9wZXJhdGlvbnMuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+IEFja2VkLWJ5OiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4KPiA+IFNvIEkgdGhpbmsgd2UgZG9uJ3Qg
aGF2ZSBhY3R1YWwgdXNlcnMgZm9yIHRoaXMgaW4gdGhpcyBzZXJpZXM/IENhbiB3ZQo+ID4gc2lt
cGx5IGhhdmUgYW5vdGhlciBpbmRlcGVuZGVudCBwYXRjaCBmb3IgdGhpcz8KPiAKPiBJIGFtIG9r
LiBJIHdpbGwgcmVtb3ZlIHRoaXMgZnJvbSB0aGUgbmV4dCB2ZXJzaW9uLgo+IAo+IEJ1dCBJIGFs
c28gaGVscCBtZXJnZSB0aGlzIHRvIDYuNi4gVGhlbiB3ZSBjYW4gbGV0IHRoZSB2aXJ0aW8tbmV0
IHRvIHN1cHBvcnQKPiBBRl9YRFAgaW4gNi43Ky4KCklzIHRoZXJlIGdvaW5nIHRvIGJlIGEgbmV4
dCB2ZXJzaW9uPyBCZWNhdXNlIGlmIHllcyBpdCB3aWxsIGJlIHRvbyBsYXRlIGZvciB0aGUgbmV4
dCByZWxlYXNlLgppZiBhbGwgeW91IHdhbnQgdG8gZG8gaXMgZHJvcCB0aGlzIHBhdGNoIHRoZW4g
anVzdCBzYXkgc28sIG5vIG5lZWQKZm9yIGFub3RoZXIgdmVyc2lvbi4KCj4gCj4gPgo+ID4gPiAt
LS0KPiA+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAxNyArKysrKysrKysrKysr
KysrKwo+ID4gPiAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8ICAyICsrCj4gPiA+ICAy
IGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jCj4gPiA+IGluZGV4IGY5Zjc3MmU4NWEzOC4uYmIzZDczZDIyMWNkIDEwMDY0NAo+ID4gPiAt
LS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4gQEAgLTIyNjUsNiArMjI2NSwyMyBAQCBpbnQgdmlydHF1
ZXVlX2FkZF9pbmJ1Zl9jdHgoc3RydWN0IHZpcnRxdWV1ZSAqdnEsCj4gPiA+ICB9Cj4gPiA+ICBF
WFBPUlRfU1lNQk9MX0dQTCh2aXJ0cXVldWVfYWRkX2luYnVmX2N0eCk7Cj4gPiA+Cj4gPiA+ICsv
KioKPiA+ID4gKyAqIHZpcnRxdWV1ZV9kbWFfZGV2IC0gZ2V0IHRoZSBkbWEgZGV2Cj4gPiA+ICsg
KiBAX3ZxOiB0aGUgc3RydWN0IHZpcnRxdWV1ZSB3ZSdyZSB0YWxraW5nIGFib3V0Lgo+ID4gPiAr
ICoKPiA+ID4gKyAqIFJldHVybnMgdGhlIGRtYSBkZXYuIFRoYXQgY2FuIGJlZW4gdXNlZCBmb3Ig
ZG1hIGFwaS4KPiA+ID4gKyAqLwo+ID4gPiArc3RydWN0IGRldmljZSAqdmlydHF1ZXVlX2RtYV9k
ZXYoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+ID4gPiArewo+ID4gPiArICAgICAgIHN0cnVjdCB2
cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gPiA+ICsKPiA+ID4gKyAgICAgICBp
ZiAodnEtPnVzZV9kbWFfYXBpKQo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIHZyaW5nX2Rt
YV9kZXYodnEpOwo+ID4gPiArICAgICAgIGVsc2UKPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVy
biBOVUxMOwo+ID4gPiArfQo+ID4gPiArRVhQT1JUX1NZTUJPTF9HUEwodmlydHF1ZXVlX2RtYV9k
ZXYpOwo+ID4KPiA+IE9uZSBwb3NzaWJsZSBjb25jZXJuIGlzIHRoYXQgZXhwb3J0aW5nIHRoaW5n
cyBsaWtlIE5VTEwgbWF5IHJlc3VsdCBpbgo+ID4gdGhlIHN3aXRjaCBpbiB0aGUgY2FsbGVyIChk
cml2ZXIpLiBJIHdvbmRlciBpZiBpdCdzIGJldHRlciB0byBkbwo+ID4gQlVHX09OKCkgaW4gdGhl
IHBhdGggb2YgTlVMTD8KPiAKPiAKPiBJIGFncmVlLgo+IAo+IEJ1dCB3ZSBuZWVkIGEgbmV3IGhl
bHBlciB0byB0ZWxsIHRoZSBkcml2ZXIob3IgQUZfWERQKSB0aGF0IHRoZSBkZXZpY2Ugc3VwcG9y
dAo+IEFDQ0VTU19QTEFURk9STSBvciBub3QuCj4gCj4gV2UgbmVlZCBhIHN3aXRjaCwgYnV0IHdl
IGNhbiBtYWtlIHRoZSBzd2l0Y2ggaXMgaXJyZWxldmFudCB0byB0aGUgRE1BLgo+IAo+IFRoYW5r
cy4KPiAKPiAKPiAKPiA+Cj4gPiBUaGFua3MKPiA+Cj4gPiA+ICsKPiA+ID4gIC8qKgo+ID4gPiAg
ICogdmlydHF1ZXVlX2tpY2tfcHJlcGFyZSAtIGZpcnN0IGhhbGYgb2Ygc3BsaXQgdmlydHF1ZXVl
X2tpY2sgY2FsbC4KPiA+ID4gICAqIEBfdnE6IHRoZSBzdHJ1Y3QgdmlydHF1ZXVlCj4gPiA+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8u
aAo+ID4gPiBpbmRleCA4YWRkMzgwMzg4NzcuLmJkNTVhMDVlZWMwNCAxMDA2NDQKPiA+ID4gLS0t
IGEvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRp
by5oCj4gPiA+IEBAIC02MSw2ICs2MSw4IEBAIGludCB2aXJ0cXVldWVfYWRkX3NncyhzdHJ1Y3Qg
dmlydHF1ZXVlICp2cSwKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKmRhdGEsCj4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICBnZnBfdCBnZnApOwo+ID4gPgo+ID4gPiArc3RydWN0
IGRldmljZSAqdmlydHF1ZXVlX2RtYV9kZXYoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+ID4gPiAr
Cj4gPiA+ICBib29sIHZpcnRxdWV1ZV9raWNrKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiA+ID4K
PiA+ID4gIGJvb2wgdmlydHF1ZXVlX2tpY2tfcHJlcGFyZShzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7
Cj4gPiA+IC0tCj4gPiA+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPiA+ID4KPiA+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
