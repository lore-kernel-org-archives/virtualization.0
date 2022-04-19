Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD98EC433EF
	for <virtualization@archiver.kernel.org>; Tue, 19 Apr 2022 15:03:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7796B418B7;
	Tue, 19 Apr 2022 15:03:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q4rM-6KCN1m7; Tue, 19 Apr 2022 15:03:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 738DB418C0;
	Tue, 19 Apr 2022 15:03:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 329C6C002F;
	Tue, 19 Apr 2022 15:03:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E91BC002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 15:03:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ABF9E84335
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 15:03:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jnGDiwQv9EHX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 15:03:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76AC58418A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 15:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650380588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7pIVH9izP79zR+Fy90DYh/Zd/5XnwDm4/pXGyag/Kgg=;
 b=PdqrjNmonnvGmL40Skr4nV+G4RaHhEfP3BfkUx4MdbKaqRy9YB13UF8UGPhfwYcRv0T63I
 VjgMzRAJ/QuWeY01cPR0KVDXIzHr31F30/3Ic/WMp4PDGkEevjpulK9cNsobwrcJNnDiDi
 rctf6wDO5260JEeJUU5CtoTFQPGkIaw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-Q_ZOr831NV6XQvS5cIQaGg-1; Tue, 19 Apr 2022 11:03:07 -0400
X-MC-Unique: Q_ZOr831NV6XQvS5cIQaGg-1
Received: by mail-wm1-f71.google.com with SMTP id
 l41-20020a05600c1d2900b0038ec007ac7fso1467214wms.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 08:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7pIVH9izP79zR+Fy90DYh/Zd/5XnwDm4/pXGyag/Kgg=;
 b=2d4QiRRTwzRkmZuGvjAsSqhXD3EILzsRsjq2kuYlaEkAUXZdXGGtQBykQ9s+78TOzO
 q0H1K7WeDUvdJlNk/J3jT08vreMbL5Ji/cbTHi2aVXtyO11Gh2X7M9zlRXNWnkhUbccl
 +fTIiY/UALnfCu1pOd/cqwYyhd5O2/DZDSWANq48lWz/RbEV8wwTaenPaXxWl6QziYSA
 8d5i+yooxh1VugKeW6h0IhDtRseCMu6MqFbnkklmiY+V8dmVOJW9ogl3rPEAzHOg5t60
 hTpSdaLF3WHKU11SVcEqm2oRJ6bOWAGcWY/yzMpEDSVUtudtf7x6SmU7Qrr0QUmcO5D7
 0dQw==
X-Gm-Message-State: AOAM5302arAFs2nkSNMbvswSAHwh0CuAhIiLSt1vm6H2P0fFs8igjfWw
 grWSUt2NEoyKHWm6QjY/2kTg3ke6M5wO8FKp8QCSmMSmckrWjtjJ3PWu7BoZ6bdxnh6rmQ8mRvq
 VSenuNbZBsmoSv6qFHdVbtzCpA4vmj76WV9wlHnCZoQ==
X-Received: by 2002:a05:600c:3507:b0:392:8dea:ef21 with SMTP id
 h7-20020a05600c350700b003928deaef21mr14593373wmq.74.1650380585972; 
 Tue, 19 Apr 2022 08:03:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTFNXIgXG69bsQ5wElbIe0FcmR4m/Hkue7Q8wdTjNIT4KT/pd4PXVwRCBzsSl5Ebb+EdJ1zA==
X-Received: by 2002:a05:600c:3507:b0:392:8dea:ef21 with SMTP id
 h7-20020a05600c350700b003928deaef21mr14593354wmq.74.1650380585657; 
 Tue, 19 Apr 2022 08:03:05 -0700 (PDT)
Received: from redhat.com ([2.53.17.80]) by smtp.gmail.com with ESMTPSA id
 m4-20020a7bcb84000000b00389efb7a5b4sm19629762wmi.17.2022.04.19.08.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Apr 2022 08:03:04 -0700 (PDT)
Date: Tue, 19 Apr 2022 11:03:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maciej =?utf-8?Q?Szyma=C5=84ski?= <maciej.szymanski@opensynergy.com>
Subject: Re: virtio-net: Unpermitted usage of virtqueue before virtio driver
 initialization
Message-ID: <20220419103826-mutt-send-email-mst@kernel.org>
References: <c0c17b91-747e-ab58-83e5-b6f7dfa55e75@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <c0c17b91-747e-ab58-83e5-b6f7dfa55e75@opensynergy.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemb@google.com>,
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

T24gVHVlLCBBcHIgMTksIDIwMjIgYXQgMDQ6MTI6MzFQTSArMDIwMCwgTWFjaWVqIFN6eW1hxYRz
a2kgd3JvdGU6Cj4gSGVsbG8sCj4gCj4gSSd2ZSBmb3VuZCBhIHByb2JsZW0gaW4gdmlydGlvLW5l
dCBkcml2ZXIuCj4gSWYgdmlydGlvLW5ldCBiYWNrZW5kIGRldmljZSBhZHZlcnRpc2VzIGd1ZXN0
IG9mZmxvYWQgZmVhdHVyZXMsIHRoZXJlIGlzCj4gYW4gdW5wZXJtaXR0ZWQgdXNhZ2Ugb2YgY29u
dHJvbCB2aXJ0cXVldWUgYmVmb3JlIGRyaXZlciBpcyBpbml0aWFsaXplZC4KPiBBY2NvcmRpbmcg
dG8gVklSVElPIHNwZWNpZmljYXRpb24gMi4xLjIgOgo+ICJUaGUgZGV2aWNlIE1VU1QgTk9UIGNv
bnN1bWUgYnVmZmVycyBvciBzZW5kIGFueSB1c2VkIGJ1ZmZlcgo+IG5vdGlmaWNhdGlvbnMgdG8g
dGhlIGRyaXZlciBiZWZvcmUgRFJJVkVSX09LLiIKClJpZ2h0LgoKPiBEdXJpbmcgYW4gaW5pdGlh
bGl6YXRpb24sIGRyaXZlciBjYWxscyByZWdpc3Rlcl9uZXRkZXZpY2Ugd2hpY2ggaW52b2tlcwo+
IGNhbGxiYWNrIGZ1bmN0aW9uIHZpcnRuZXRfc2V0X2ZlYXR1cmVzIGZyb20gX19uZXRkZXZfdXBk
YXRlX2ZlYXR1cmVzLgo+IElmIGd1ZXN0IG9mZmxvYWQgZmVhdHVyZXMgYXJlIGFkdmVydGlzZWQg
YnkgdGhlIGRldmljZSwKPiB2aXJ0bmV0X3NldF9ndWVzdF9vZmZsb2FkcyBpcyB1c2luZyB2aXJ0
bmV0X3NlbmRfY29tbWFuZCB0byB3cml0ZSBhbmQKPiByZWFkIGZyb20gVlEuCj4gVGhhdCBsZWFk
cyB0byBpbml0aWFsaXphdGlvbiBzdHVjayBhcyBkZXZpY2UgaXMgbm90IHBlcm1pdHRlZCB5ZXQg
dG8gdXNlIFZRLgoKCgpIbW0gc28gd2UgaGF2ZSB0aGlzOgoKCiAgICAgICAgaWYgKChkZXYtPmZl
YXR1cmVzIF4gZmVhdHVyZXMpICYgTkVUSUZfRl9HUk9fSFcpIHsKICAgICAgICAgICAgICAgIGlm
ICh2aS0+eGRwX2VuYWJsZWQpCiAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUJVU1k7
CgogICAgICAgICAgICAgICAgaWYgKGZlYXR1cmVzICYgTkVUSUZfRl9HUk9fSFcpCiAgICAgICAg
ICAgICAgICAgICAgICAgIG9mZmxvYWRzID0gdmktPmd1ZXN0X29mZmxvYWRzX2NhcGFibGU7CiAg
ICAgICAgICAgICAgICBlbHNlCiAgICAgICAgICAgICAgICAgICAgICAgIG9mZmxvYWRzID0gdmkt
Pmd1ZXN0X29mZmxvYWRzX2NhcGFibGUgJgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIH5HVUVTVF9PRkZMT0FEX0dST19IV19NQVNLOwoKICAgICAgICAgICAgICAgIGVyciA9IHZp
cnRuZXRfc2V0X2d1ZXN0X29mZmxvYWRzKHZpLCBvZmZsb2Fkcyk7CiAgICAgICAgICAgICAgICBp
ZiAoZXJyKQogICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOwogICAgICAgICAgICAg
ICAgdmktPmd1ZXN0X29mZmxvYWRzID0gb2ZmbG9hZHM7CiAgICAgICAgfQoKd2hpY2ggSSBndWVz
cyBzaG91bGQgaGF2ZSBwcmV2ZW50ZWQgdmlydG5ldF9zZXRfZ3Vlc3Rfb2ZmbG9hZHMgZnJvbSBl
dmVyIHJ1bm5pbmcuCgpGcm9tIHlvdXIgZGVzY3JpcHRpb24gaXQgc291bmRzIGxpa2UgeW91IGhh
dmUgb2JzZXJ2ZWQgdGhpcwppbiBwcmFjdGljZSwgcmlnaHQ/CgoKCj4gSSBoYXZlIGF0dGFjaGVk
IGEgcGF0Y2ggZm9yIGtlcm5lbCA1LjE4LXJjMyB3aGljaCBmaXhlcyB0aGUgcHJvYmxlbSBieQo+
IGRlZmVycmluZyBmZWF0dXJlIHNldCBhZnRlciB2aXJ0aW8gZHJpdmVyIGluaXRpYWxpemF0aW9u
Lgo+IAo+IEJlc3QgUmVnYXJkcywKPiAKPiAtLQo+IE1hY2llaiBTenltYcWEc2tpCj4gU2VuaW9y
IFN0YWZmIEVuZ2luZWVyCj4gCj4gT3BlblN5bmVyZ3kgR21iSAo+IFJvdGhlcnN0ci4gMjAsIDEw
MjQ1IEJlcmxpbgo+IAo+IFBob25lOiAgICArNDkgMzAgNjAgOTggNTQgMCAtODYKPiBGYXg6ICAg
ICAgKzQ5IDMwIDYwIDk4IDU0IDAgLTk5Cj4gRS1NYWlsOiAgIG1hY2llai5zenltYW5za2lAb3Bl
bnN5bmVyZ3kuY29tCj4gCj4gd3d3Lm9wZW5zeW5lcmd5LmNvbQo+IAo+IEhhbmRlbHNyZWdpc3Rl
ci9Db21tZXJjaWFsIFJlZ2lzdHJ5OiBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZywgSFJCIDEw
ODYxNkIKPiBHZXNjaMOkZnRzZsO8aHJlci9NYW5hZ2luZyBEaXJlY3RvcjogUmVnaXMgQWRqYW1h
aAo+IAo+IFBsZWFzZSBtaW5kIG91ciBwcml2YWN5IG5vdGljZTxodHRwczovL3d3dy5vcGVuc3lu
ZXJneS5jb20vZGF0ZW5zY2h1dHplcmtsYWVydW5nL3ByaXZhY3ktbm90aWNlLWZvci1idXNpbmVz
cy1wYXJ0bmVycy1wdXJzdWFudC10by1hcnRpY2xlLTEzLW9mLXRoZS1nZW5lcmFsLWRhdGEtcHJv
dGVjdGlvbi1yZWd1bGF0aW9uLWdkcHIvPiBwdXJzdWFudCB0byBBcnQuIDEzIEdEUFIuIC8vIFVu
c2VyZSBIaW53ZWlzZSB6dW0gRGF0ZW5zY2h1dHogZ2VtLiBBcnQuIDEzIERTR1ZPIGZpbmRlbiBT
aWUgaGllci48aHR0cHM6Ly93d3cub3BlbnN5bmVyZ3kuY29tL2RlL2RhdGVuc2NodXR6ZXJrbGFl
cnVuZy9kYXRlbnNjaHV0emhpbndlaXNlLWZ1ZXItZ2VzY2hhZWZ0c3BhcnRuZXItZ2VtLWFydC0x
My1kc2d2by8+Cgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCA4NzgzOGNiLi5hNDQ0NjJkIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYwo+IEBAIC0yNjQsNiArMjY0LDggQEAgc3RydWN0IHZpcnRuZXRfaW5mbyB7Cj4gICAgICAg
ICB1bnNpZ25lZCBsb25nIGd1ZXN0X29mZmxvYWRzOwo+ICAgICAgICAgdW5zaWduZWQgbG9uZyBn
dWVzdF9vZmZsb2Fkc19jYXBhYmxlOwo+ICAKPiArICAgICAgIG5ldGRldl9mZWF0dXJlc190IGZl
YXR1cmVzOwo+ICsKCkkgZG9uJ3QgbXVjaCBsaWtlIGhvdyB3ZSBhcmUgZm9yY2VkIHRvIGtlZXAg
YSBjb3B5IG9mIGZlYXR1cmVzCmhlcmUgOiggQXQgbGVhc3QgcGxzIGFkZCBhIGNvbW1lbnQgZXhw
bGFpbmluZyB3aGF0J3MgZ29pbmcgb24sCndobyBvd25zIHRoaXMgZXRjLgoKPiAgICAgICAgIC8q
IGZhaWxvdmVyIHdoZW4gU1RBTkRCWSBmZWF0dXJlIGVuYWJsZWQgKi8KPiAgICAgICAgIHN0cnVj
dCBmYWlsb3ZlciAqZmFpbG92ZXI7Cj4gIH07Cj4gQEAgLTI5NzYsNiArMjk3OCwxNSBAQCBzdGF0
aWMgaW50IHZpcnRuZXRfZ2V0X3BoeXNfcG9ydF9uYW1lKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYs
IGNoYXIgKmJ1ZiwKPiAgCj4gIHN0YXRpYyBpbnQgdmlydG5ldF9zZXRfZmVhdHVyZXMoc3RydWN0
IG5ldF9kZXZpY2UgKmRldiwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5ldGRl
dl9mZWF0dXJlc190IGZlYXR1cmVzKQo+ICt7Cj4gKyAgICAgICBzdHJ1Y3QgdmlydG5ldF9pbmZv
ICp2aSA9IG5ldGRldl9wcml2KGRldik7Cj4gKyAgICAgICB2aS0+ZmVhdHVyZXMgPSBmZWF0dXJl
czsKPiArCj4gKyAgICAgICByZXR1cm4gMDsKPiArfQoKCkxvb2tzIGxpa2UgdGhpcyBicmVha3Mg
Y2hhbmdpbmcgZmVhdHVyZXMgYWZ0ZXIgaW5pdGlhbGl6YXRpb24gLQp0aGVzZSB3aWxsIG5ldmVy
IGJlIHByb3BhZ2F0ZWQgdG8gaGFyZHdhcmUgbm93LgoKPiArCj4gK3N0YXRpYyBpbnQgdmlydG5l
dF9zZXRfZmVhdHVyZXNfZGVmZXJyZWQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIG5ldGRldl9mZWF0dXJlc190IGZlYXR1cmVzKQo+ICB7
Cj4gICAgICAgICBzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IG5ldGRldl9wcml2KGRldik7Cj4g
ICAgICAgICB1NjQgb2ZmbG9hZHM7Cj4gQEAgLTM2NDQsNiArMzY1NSwxMyBAQCBzdGF0aWMgaW50
IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gIAo+ICAgICAgICAg
dmlydGlvX2RldmljZV9yZWFkeSh2ZGV2KTsKPiAgCj4gKyAgICAgICAvKiBEZWZlcnJlZCBmZWF0
dXJlIHNldCBhZnRlciBkZXZpY2UgcmVhZHkgKi8KPiArICAgICAgIGVyciA9IHZpcnRuZXRfc2V0
X2ZlYXR1cmVzX2RlZmVycmVkKGRldiwgdmktPmZlYXR1cmVzKTsKCgpJdCBzZWVtcyB0aGF0IGlm
IHRoaXMgaXMgY2FsbGVkIGUuZy4gZm9yIGEgZGV2aWNlIHdpdGhvdXQgYSBDVlEgYW5kCnRoZXJl
IGFyZSB0aGluZ3MgdGhhdCBhY3R1YWxseSBuZWVkIHRvIGNoYW5nZSB0aGVuIGl0IHdpbGwgQlVH
X09OLgoKCj4gKyAgICAgICBpZiAoZXJyKSB7Cj4gKyAgICAgICAgICAgICAgIHByX2RlYnVnKCJ2
aXJ0aW9fbmV0OiBzZXQgZmVhdHVyZXMgZmFpbGVkXG4iKTsKPiArICAgICAgICAgICAgICAgZ290
byBmcmVlX3VucmVnaXN0ZXJfbmV0ZGV2Owo+ICsgICAgICAgfQo+ICsKPiAgICAgICAgIGVyciA9
IHZpcnRuZXRfY3B1X25vdGlmX2FkZCh2aSk7Cj4gICAgICAgICBpZiAoZXJyKSB7Cj4gICAgICAg
ICAgICAgICAgIHByX2RlYnVnKCJ2aXJ0aW9fbmV0OiByZWdpc3RlcmluZyBjcHUgbm90aWZpZXIg
ZmFpbGVkXG4iKTsKPiAKCi0tIApNU1QKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
