Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEADC001DE
	for <virtualization@archiver.kernel.org>; Tue,  8 Aug 2023 05:59:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 97FFD40584;
	Tue,  8 Aug 2023 05:59:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 97FFD40584
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rt/jNem7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IIUlgsNN3Qux; Tue,  8 Aug 2023 05:59:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 215BD40102;
	Tue,  8 Aug 2023 05:59:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 215BD40102
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0B5CC0071;
	Tue,  8 Aug 2023 05:59:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B61ABC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 05:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91131402D7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 05:59:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 91131402D7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jCdSGf8My-uo
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 05:59:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FAAA40102
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 05:59:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3FAAA40102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691474391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CaNxduUzRSkEkmX7HiHWwqeoccgo57TFbEHYFZdEoFM=;
 b=Rt/jNem7KNk/P2gTjDb7+Zu/4AcaAPVPm5dkSZI6FuA/eESy/K/Xq+V8qCC3twAAaAsUc4
 02XMinqY+edriJxP2Tl71i3SYCexGV9V8vtt2DzfKE+k7w+Iik4MGFJqbVFM5a4Q4aIz4P
 ZRSNJ3j84Bw13IWc/jtDd2A8sOJL8Ns=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-OuTcbn95NEGNay8lXNkX-g-1; Tue, 08 Aug 2023 01:59:49 -0400
X-MC-Unique: OuTcbn95NEGNay8lXNkX-g-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5234996e490so111745a12.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Aug 2023 22:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691474388; x=1692079188;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CaNxduUzRSkEkmX7HiHWwqeoccgo57TFbEHYFZdEoFM=;
 b=H4RlCKMnOgKX8VsyWeRaRJ8jMAiQo/xxi1Bn/f8CotZECDzlLNItzq1jGn3KDqcfLJ
 Wdnt8Dws1iERuMeQ44c1rtCppuJCJvPKsj3nRMWkF97mDKgzhnMzN0Db1vy9Msez2lIa
 oOFyoWC3Kc0S2bwu7DZx0Thg8xGTx5oCmSHTMe9g6et9rzRivWbk59YZvyssaIFpKfqS
 ZJ+VLB1YHvbmy0/MvTQg0dGKx0pJnjgvFRWqqYCr8SwnObTZZtfu/rLMfJR8yytawc2Z
 N70ALXSGvlRM1NLWQXXJR74PMqW7l9WXPP9KT81kKsbDULDibB/iqy8h2YJpBFAMeVos
 ylUA==
X-Gm-Message-State: AOJu0Ywlxu2UEwzDDFYl8DlNxiR2w10VL1mERrZ/wTDL0fd0YwGierru
 fuA+72xKCRvOl+zQxz0BoZ9JeFQVPhKSghMTb9zXsyzjxsE1vu7DXgyAo883ChTzpoKLqKjdi3m
 NO4XCJkHqqUBlIJ2uiqlSTgbuew92y39rg5g6ize5yg==
X-Received: by 2002:a17:906:c5:b0:994:555a:e49f with SMTP id
 5-20020a17090600c500b00994555ae49fmr12096096eji.31.1691474388698; 
 Mon, 07 Aug 2023 22:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEApHOhFAZ65Oxm7XRuMfki27ofUpBb0cMuKVVThf/GyD90Va1/Fgc59MtyRqqiqvMTfE+qWg==
X-Received: by 2002:a17:906:c5:b0:994:555a:e49f with SMTP id
 5-20020a17090600c500b00994555ae49fmr12096083eji.31.1691474388390; 
 Mon, 07 Aug 2023 22:59:48 -0700 (PDT)
Received: from redhat.com ([2.52.159.103]) by smtp.gmail.com with ESMTPSA id
 f25-20020a170906139900b0098d2d219649sm6214805ejc.174.2023.08.07.22.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 22:59:47 -0700 (PDT)
Date: Tue, 8 Aug 2023 01:59:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_ring: fix avail_wrap_counter in
 virtqueue_add_packed
Message-ID: <20230808015921-mutt-send-email-mst@kernel.org>
References: <20230808051110.3492693-1-yuanyaogoog@chromium.org>
 <CACGkMEt53ziY_bmgJHVdJ6pkppTyVqKX3=Czygv+yhJR8_KiFA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt53ziY_bmgJHVdJ6pkppTyVqKX3=Czygv+yhJR8_KiFA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Tiwei Bie <tiwei.bie@intel.com>, Junichi Uekawa <uekawa@chromium.org>,
 LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org,
 Yuan Yao <yuanyaogoog@chromium.org>, Takaya Saeki <takayas@chromium.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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

T24gVHVlLCBBdWcgMDgsIDIwMjMgYXQgMDE6NDM6MDJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUdWUsIEF1ZyA4LCAyMDIzIGF0IDE6MTHigK9QTSBZdWFuIFlhbyA8eXVhbnlhb2dv
b2dAY2hyb21pdW0ub3JnPiB3cm90ZToKPiA+Cj4gPiBJbiBjdXJyZW50IHBhY2tlZCB2aXJ0cXVl
dWUgaW1wbGVtZW50YXRpb24sIHRoZSBhdmFpbF93cmFwX2NvdW50ZXIgd29uJ3QKPiA+IGZsaXAs
IGluIHRoZSBjYXNlIHdoZW4gdGhlIGRyaXZlciBzdXBwbGllcyBhIGRlc2NyaXB0b3IgY2hhaW4g
d2l0aCBhCj4gPiBsZW5ndGggZXF1YWxzIHRvIHRoZSBxdWV1ZSBzaXplOyB0b3RhbF9zZyA9PSB2
cS0+cGFja2VkLnZyaW5nLm51bS4KPiA+Cj4gPiBMZXTigJlzIGFzc3VtZSB0aGUgZm9sbG93aW5n
IHNpdHVhdGlvbjoKPiA+IHZxLT5wYWNrZWQudnJpbmcubnVtPTQKPiA+IHZxLT5wYWNrZWQubmV4
dF9hdmFpbF9pZHg6IDEKPiA+IHZxLT5wYWNrZWQuYXZhaWxfd3JhcF9jb3VudGVyOiAwCj4gPgo+
ID4gVGhlbiB0aGUgZHJpdmVyIGFkZHMgYSBkZXNjcmlwdG9yIGNoYWluIGNvbnRhaW5pbmcgNCBk
ZXNjcmlwdG9ycy4KPiA+Cj4gPiBXZSBleHBlY3QgdGhlIGZvbGxvd2luZyByZXN1bHQgd2l0aCBh
dmFpbF93cmFwX2NvdW50ZXIgZmxpcHBlZDoKPiA+IHZxLT5wYWNrZWQubmV4dF9hdmFpbF9pZHg6
IDEKPiA+IHZxLT5wYWNrZWQuYXZhaWxfd3JhcF9jb3VudGVyOiAxCj4gPgo+ID4gQnV0LCB0aGUg
Y3VycmVudCBpbXBsZW1lbnRhdGlvbiBnaXZlcyB0aGUgZm9sbG93aW5nIHJlc3VsdDoKPiA+IHZx
LT5wYWNrZWQubmV4dF9hdmFpbF9pZHg6IDEKPiA+IHZxLT5wYWNrZWQuYXZhaWxfd3JhcF9jb3Vu
dGVyOiAwCj4gPgo+ID4gVG8gcmVwcm9kdWNlIHRoZSBidWcsIHlvdSBjYW4gc2V0IGEgcGFja2Vk
IHF1ZXVlIHNpemUgYXMgc21hbGwgYXMKPiA+IHBvc3NpYmxlLCBzbyB0aGF0IHRoZSBkcml2ZXIg
aXMgbW9yZSBsaWtlbHkgdG8gcHJvdmlkZSBhIGRlc2NyaXB0b3IKPiA+IGNoYWluIHdpdGggYSBs
ZW5ndGggZXF1YWwgdG8gdGhlIHBhY2tlZCBxdWV1ZSBzaXplLiBGb3IgZXhhbXBsZSwgaW4KPiA+
IHFlbXUgcnVuIGZvbGxvd2luZyBjb21tYW5kczoKPiA+IHN1ZG8gcWVtdS1zeXN0ZW0teDg2XzY0
IFwKPiA+IC1lbmFibGUta3ZtIFwKPiA+IC1ub2dyYXBoaWMgXAo+ID4gLWtlcm5lbCAicGF0aC90
by9rZXJuZWxfaW1hZ2UiIFwKPiA+IC1tIDFHIFwKPiA+IC1kcml2ZSBmaWxlPSJwYXRoL3RvL3Jv
b3RmcyIsaWY9bm9uZSxpZD1kaXNrIFwKPiA+IC1kZXZpY2UgdmlydGlvLWJsayxkcml2ZT1kaXNr
IFwKPiA+IC1kcml2ZSBmaWxlPSJwYXRoL3RvL2Rpc2tfaW1hZ2UiLGlmPW5vbmUsaWQ9cndkaXNr
IFwKPiA+IC1kZXZpY2UgdmlydGlvLWJsayxkcml2ZT1yd2Rpc2sscGFja2VkPW9uLHF1ZXVlLXNp
emU9NCxcCj4gPiBpbmRpcmVjdF9kZXNjPW9mZiBcCj4gPiAtYXBwZW5kICJjb25zb2xlPXR0eVMw
IHJvb3Q9L2Rldi92ZGEgcncgaW5pdD0vYmluL2Jhc2giCj4gPgo+ID4gSW5zaWRlIHRoZSBWTSwg
Y3JlYXRlIGEgZGlyZWN0b3J5IGFuZCBtb3VudCB0aGUgcndkaXNrIGRldmljZSBvbiBpdC4gVGhl
Cj4gPiByd2Rpc2sgd2lsbCBoYW5nIGFuZCBtb3VudCBvcGVyYXRpb24gd2lsbCBub3QgY29tcGxl
dGUuCj4gPgo+ID4gVGhpcyBjb21taXQgZml4ZXMgdGhlIHdyYXAgY291bnRlciBlcnJvciBieSBm
bGlwcGluZyB0aGUKPiA+IHBhY2tlZC5hdmFpbF93cmFwX2NvdW50ZXIsIHdoZW4gc3RhcnQgb2Yg
ZGVzY3JpcHRvciBjaGFpbiBlcXVhbHMgdG8gdGhlCj4gPiBlbmQgb2YgZGVzY3JpcHRvciBjaGFp
biAoaGVhZCA9PSBpKS4KPiA+Cj4gPiBGaXhlczogMWNlOWU2MDU1ZmEwICgidmlydGlvX3Jpbmc6
IGludHJvZHVjZSBwYWNrZWQgcmluZyBzdXBwb3J0IikKPiA+IFNpZ25lZC1vZmYtYnk6IFl1YW4g
WWFvIDx5dWFueWFvZ29vZ0BjaHJvbWl1bS5vcmc+Cj4gPiAtLS0KPiA+Cj4gPiAgZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDIgKy0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+IGluZGV4IGM1
MzEwZWFmOGI0Ni4uZGExMTUwZDEyN2MyIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYwo+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4g
QEAgLTE0NjEsNyArMTQ2MSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfcGFj
a2VkKHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiA+ICAgICAgICAgICAgICAgICB9Cj4gPiAgICAg
ICAgIH0KPiA+Cj4gPiAtICAgICAgIGlmIChpIDwgaGVhZCkKPiA+ICsgICAgICAgaWYgKGkgPD0g
aGVhZCkKPiA+ICAgICAgICAgICAgICAgICB2cS0+cGFja2VkLmF2YWlsX3dyYXBfY291bnRlciBe
PSAxOwo+IAo+IFdvdWxkIGl0IGJlIGJldHRlciB0byBtb3ZlIHRoZSBmbGlwcGluZyB0byB0aGUg
cGxhY2Ugd2hlcmUgd2UgZmxpcAo+IGF2YWlsX3VzZWRfZmxhZ3M/CgpJIHRoaW5rIEkgcHJlZmVy
IHRoaXMgcGF0Y2ggZm9yIHN0YWJsZSwgcmVmYWN0b3JpbmcgY2FuCmJlIGRvbmUgb24gdG9wLgoK
PiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoKHVubGlrZWx5KCsraSA+PSB2cS0+cGFja2Vk
LnZyaW5nLm51bSkpKSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpID0gMDsK
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZxLT5wYWNrZWQuYXZhaWxfdXNlZF9m
bGFncyBePQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxIDw8IFZS
SU5HX1BBQ0tFRF9ERVNDX0ZfQVZBSUwgfAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAxIDw8IFZSSU5HX1BBQ0tFRF9ERVNDX0ZfVVNFRDsKPiAgICAgICAgICAgICAg
ICAgICAgICAgICB9Cj4gCj4gVGhhbmtzCj4gCj4gPgo+ID4gICAgICAgICAvKiBXZSdyZSB1c2lu
ZyBzb21lIGJ1ZmZlcnMgZnJvbSB0aGUgZnJlZSBsaXN0LiAqLwo+ID4gLS0KPiA+IDIuNDEuMC42
NDAuZ2E5NWRlZjU1ZDAtZ29vZwo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
