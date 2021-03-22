Return-Path: <SRS0=byTZ=IU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E900C433C1
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 08:17:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 742126192D
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 08:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742126192D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 18B7F40299;
	Mon, 22 Mar 2021 08:17:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6jGdLfogU-OY; Mon, 22 Mar 2021 08:17:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9FBA1400A9;
	Mon, 22 Mar 2021 08:17:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73580C000A;
	Mon, 22 Mar 2021 08:17:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72D40C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 08:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5A54A60692
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 08:17:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bo4toHTW3dD1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 08:17:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 75C4960666
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 08:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616401060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PsZodVPsWs6YP/fF4pvWwqUUa+rr5N0r5iTqRaFVfOc=;
 b=BewU5VbKrORLE5g/udttKpgTNVG8KPm7CEqyETnDNzYAAniACWLVJjjBFJR9HIh0Ardyts
 w6ixXegh1EgafXGFzpHNiREd2sU24qQa/i1ZH+0VPGIb7hll706iTAvWdR4hEn9RUoRI2/
 M2BAtruWT3fi5qeElQ/MN6AOsx972mg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-Fw8iaDLiNTqlfSj8MjWl0w-1; Mon, 22 Mar 2021 04:17:38 -0400
X-MC-Unique: Fw8iaDLiNTqlfSj8MjWl0w-1
Received: by mail-wr1-f71.google.com with SMTP id m23so20582634wrh.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 01:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=PsZodVPsWs6YP/fF4pvWwqUUa+rr5N0r5iTqRaFVfOc=;
 b=UDw5WObFjNiuXRAboDZqEp/KhA7F/cQNLT+rbiU4ndbCUR/8RVMTFu+s7Lcy6pGAcA
 eojSD/fmXuFbv/ZDDtsqfVmYbkPpIz67RkdJbg3EbBYwqKNfzUS07kN7oBuaISZXaRaK
 ye63Y+ExutYncwGWVdtforQ1Yyr6/XWmG/U9jlX1F2ligq8EbtM0OcECH4qC8iznQRMG
 m54DQ7+wZvx1sOt/qDrxVHaEyMXwka+3FJ5ezS7ZM9OB9eMpSc+2zZKnwJHJmoF5q0eC
 LViaI3MsM3RfAR6hfo1tHlD3LC3w5ym/GgtO62OeYB5UkIMS00RtY/XWdDWnibVtrNvQ
 +sgA==
X-Gm-Message-State: AOAM531mXmpZp00fPZwj6bp1NH1OufBVYBYMUuNyMyyO42ql7dslLm0U
 /Q+dTB883zxn076m9kfHIcZlbQk5aODFU1lpviESWiv0hpRDrdqteVTTQT6K17NcWEk5GyF891g
 ec6IGaeWW2TRbb4iv0637R0aKCw7MigbDioApyXAt8A==
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr17188156wrv.222.1616401057445; 
 Mon, 22 Mar 2021 01:17:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylZqhTCHG8w045DowIsxunwGOileNP81Z98LrDX9nf428OhlNQeHBKBDDVXpT/YRj5Vf8BjA==
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr17188137wrv.222.1616401057261; 
 Mon, 22 Mar 2021 01:17:37 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
 by smtp.gmail.com with ESMTPSA id a14sm20018493wrg.84.2021.03.22.01.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Mar 2021 01:17:36 -0700 (PDT)
Date: Mon, 22 Mar 2021 04:17:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] virtio_ring: always warn when descriptor chain
 exceeds queue size
Message-ID: <20210322041414-mutt-send-email-mst@kernel.org>
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-2-ckuehl@redhat.com>
 <fa4988fa-a671-0abf-f922-6b362faf10d5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fa4988fa-a671-0abf-f922-6b362faf10d5@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: miklos@szeredi.hu, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
 stefanha@redhat.com, linux-fsdevel@vger.kernel.org, vgoyal@redhat.com
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

T24gTW9uLCBNYXIgMjIsIDIwMjEgYXQgMTE6MjI6MTVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS8zLzE4IOS4i+WNiDk6NTIsIENvbm5vciBLdWVobCDlhpnpgZM6Cj4g
PiAgRnJvbSBzZWN0aW9uIDIuNi41LjMuMSAoRHJpdmVyIFJlcXVpcmVtZW50czogSW5kaXJlY3Qg
RGVzY3JpcHRvcnMpCj4gPiBvZiB0aGUgdmlydGlvIHNwZWM6Cj4gPiAKPiA+ICAgICJBIGRyaXZl
ciBNVVNUIE5PVCBjcmVhdGUgYSBkZXNjcmlwdG9yIGNoYWluIGxvbmdlciB0aGFuIHRoZSBRdWV1
ZQo+ID4gICAgU2l6ZSBvZiB0aGUgZGV2aWNlLiIKPiA+IAo+ID4gVGhpcyB0ZXh0IHN1Z2dlc3Rz
IHRoYXQgdGhlIHdhcm5pbmcgc2hvdWxkIHRyaWdnZXIgZXZlbiBpZgo+ID4gaW5kaXJlY3QgZGVz
Y3JpcHRvcnMgYXJlIGluIHVzZS4KPiAKPiAKPiBTbyBJIHRoaW5rIGF0IGxlYXN0IHRoZSBjb21t
aXQgbG9nIG5lZWRzIHNvbWUgdHdlYWsuCj4gCj4gRm9yIHNwbGl0IHZpcnRxdWV1ZS4gV2UgaGFk
Ogo+IAo+IDIuNi41LjIgRHJpdmVyIFJlcXVpcmVtZW50czogVGhlIFZpcnRxdWV1ZSBEZXNjcmlw
dG9yIFRhYmxlCj4gCj4gRHJpdmVycyBNVVNUIE5PVCBhZGQgYSBkZXNjcmlwdG9yIGNoYWluIGxv
bmdlciB0aGFuIDJeMzIgYnl0ZXMgaW4gdG90YWw7Cj4gdGhpcyBpbXBsaWVzIHRoYXQgbG9vcHMg
aW4gdGhlIGRlc2NyaXB0b3IgY2hhaW4gYXJlIGZvcmJpZGRlbiEKPiAKPiAyLjYuNS4zLjEgRHJp
dmVyIFJlcXVpcmVtZW50czogSW5kaXJlY3QgRGVzY3JpcHRvcnMKPiAKPiBBIGRyaXZlciBNVVNU
IE5PVCBjcmVhdGUgYSBkZXNjcmlwdG9yIGNoYWluIGxvbmdlciB0aGFuIHRoZSBRdWV1ZSBTaXpl
IG9mCj4gdGhlIGRldmljZS4KPiAKPiBJZiBJIHVuZGVyc3RhbmQgdGhlIHNwZWMgY29ycmVjdGx5
LCB0aGUgY2hlY2sgaXMgb25seSBuZWVkZWQgZm9yIGEgc2luZ2xlCj4gaW5kaXJlY3QgZGVzY3Jp
cHRvciB0YWJsZT8KPiAKPiBGb3IgcGFja2VkIHZpcnRxdWV1ZS4gV2UgaGFkOgo+IAo+IDIuNy4x
NyBEcml2ZXIgUmVxdWlyZW1lbnRzOiBTY2F0dGVyLUdhdGhlciBTdXBwb3J0Cj4gCj4gQSBkcml2
ZXIgTVVTVCBOT1QgY3JlYXRlIGEgZGVzY3JpcHRvciBsaXN0IGxvbmdlciB0aGFuIGFsbG93ZWQg
YnkgdGhlCj4gZGV2aWNlLgo+IAo+IEEgZHJpdmVyIE1VU1QgTk9UIGNyZWF0ZSBhIGRlc2NyaXB0
b3IgbGlzdCBsb25nZXIgdGhhbiB0aGUgUXVldWUgU2l6ZS4KPiAKPiAyLjcuMTkgRHJpdmVyIFJl
cXVpcmVtZW50czogSW5kaXJlY3QgRGVzY3JpcHRvcnMKPiAKPiBBIGRyaXZlciBNVVNUIE5PVCBj
cmVhdGUgYSBkZXNjcmlwdG9yIGNoYWluIGxvbmdlciB0aGFuIGFsbG93ZWQgYnkgdGhlCj4gZGV2
aWNlLgo+IAo+IFNvIGl0IGxvb2tzIHRvIG1lIHRoZSBwYWNrZWQgcGFydCBpcyBmaW5lLgo+IAo+
IE5vdGUgdGhhdCBpZiBJIHVuZGVyc3RhbmQgdGhlIHNwZWMgY29ycmVjdGx5IDIuNy4xNyBpbXBs
aWVzIDIuNy4xOS4KPiAKPiBUaGFua3MKCkl0IHdvdWxkIGJlIHF1aXRlIHN0cmFuZ2UgZm9yIHBh
Y2tlZCBhbmQgc3BsaXQgdG8gZGlmZmVyIGhlcmU6CnNvIGZvciBwYWNrZWQgd291bGQgeW91IHNh
eSB0aGVyZSdzIG5vIGxpbWl0IG9uICMgb2YgZGVzY3JpcHRvcnMgYXQgYWxsPwoKSSBhbSBndWVz
c2luZyBJIGp1c3QgZm9yZ290IHRvIG1vdmUgdGhpcyBwYXJ0IGZyb20KdGhlIGZvcm1hdCBzcGVj
aWZpYyB0byB0aGUgY29tbW9uIHBhcnQgb2YgdGhlIHNwZWMuCgpUaGlzIG5lZWRzIGRpc2N1c3Np
b24gaW4gdGhlIFRDIG1haWxpbmcgbGlzdCAtIHdhbnQgdG8gc3RhcnQgYSB0aHJlYWQKdGhlcmU/
CgoKCj4gCj4gPiAKPiA+IFJlcG9ydGVkLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJl
ZGhhdC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBDb25ub3IgS3VlaGwgPGNrdWVobEByZWRoYXQu
Y29tPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCA3ICsrKyst
LS0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkK
PiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiBpbmRleCA3MWUxNmI1M2U5YzEuLjFiYzI5MGY5
YmExMyAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ICsr
KyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+IEBAIC00NDQsMTEgKzQ0NCwxMiBA
QCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUg
Kl92cSwKPiA+ICAgCWhlYWQgPSB2cS0+ZnJlZV9oZWFkOwo+ID4gKwlXQVJOX09OX09OQ0UodG90
YWxfc2cgPiB2cS0+c3BsaXQudnJpbmcubnVtKTsKPiA+ICsKPiA+ICAgCWlmICh2aXJ0cXVldWVf
dXNlX2luZGlyZWN0KF92cSwgdG90YWxfc2cpKQo+ID4gICAJCWRlc2MgPSBhbGxvY19pbmRpcmVj
dF9zcGxpdChfdnEsIHRvdGFsX3NnLCBnZnApOwo+ID4gICAJZWxzZSB7Cj4gPiAgIAkJZGVzYyA9
IE5VTEw7Cj4gPiAtCQlXQVJOX09OX09OQ0UodG90YWxfc2cgPiB2cS0+c3BsaXQudnJpbmcubnVt
ICYmICF2cS0+aW5kaXJlY3QpOwo+ID4gICAJfQo+ID4gICAJaWYgKGRlc2MpIHsKPiA+IEBAIC0x
MTE4LDYgKzExMTksOCBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3BhY2tlZChz
dHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gPiAgIAlCVUdfT04odG90YWxfc2cgPT0gMCk7Cj4gPiAr
CVdBUk5fT05fT05DRSh0b3RhbF9zZyA+IHZxLT5wYWNrZWQudnJpbmcubnVtKTsKPiA+ICsKPiA+
ICAgCWlmICh2aXJ0cXVldWVfdXNlX2luZGlyZWN0KF92cSwgdG90YWxfc2cpKQo+ID4gICAJCXJl
dHVybiB2aXJ0cXVldWVfYWRkX2luZGlyZWN0X3BhY2tlZCh2cSwgc2dzLCB0b3RhbF9zZywKPiA+
ICAgCQkJCW91dF9zZ3MsIGluX3NncywgZGF0YSwgZ2ZwKTsKPiA+IEBAIC0xMTI1LDggKzExMjgs
NiBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3BhY2tlZChzdHJ1Y3QgdmlydHF1
ZXVlICpfdnEsCj4gPiAgIAloZWFkID0gdnEtPnBhY2tlZC5uZXh0X2F2YWlsX2lkeDsKPiA+ICAg
CWF2YWlsX3VzZWRfZmxhZ3MgPSB2cS0+cGFja2VkLmF2YWlsX3VzZWRfZmxhZ3M7Cj4gPiAtCVdB
Uk5fT05fT05DRSh0b3RhbF9zZyA+IHZxLT5wYWNrZWQudnJpbmcubnVtICYmICF2cS0+aW5kaXJl
Y3QpOwo+ID4gLQo+ID4gICAJZGVzYyA9IHZxLT5wYWNrZWQudnJpbmcuZGVzYzsKPiA+ICAgCWkg
PSBoZWFkOwo+ID4gICAJZGVzY3NfdXNlZCA9IHRvdGFsX3NnOwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
