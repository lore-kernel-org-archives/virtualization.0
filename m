Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2D0C001DB
	for <virtualization@archiver.kernel.org>; Tue,  8 Aug 2023 06:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A03660BC5;
	Tue,  8 Aug 2023 06:05:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A03660BC5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GWXIECwY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tOASngUnHA2N; Tue,  8 Aug 2023 06:05:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 06FB260BF9;
	Tue,  8 Aug 2023 06:05:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06FB260BF9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCC54C0071;
	Tue,  8 Aug 2023 06:05:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF1E7C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 06:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D0FAD405EC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 06:05:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D0FAD405EC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GWXIECwY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w6s7UOugg6jO
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 06:05:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 76F2640102
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 06:05:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 76F2640102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691474727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9kc7HdgyVBlkH2G96tmXBgYeeZK+6xmO5vsQNUcbsFM=;
 b=GWXIECwYqNW/yfORJLO3RaceUTVkARwW1I3D1JEvvFMA8ysYzTcLZuE1GwvVB5tzGRLheT
 7+IgYlX/Nax0DHORp31fDLFY8dS9b24LnSqnqGcofXDid2MQqcwpNOcgc7bDnopng7GzAu
 Ppu9HbdQLc/1FGxJWfbkknD1IKwvE14=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-o6MrD-WbPS6l17WVgMwbxA-1; Tue, 08 Aug 2023 02:05:22 -0400
X-MC-Unique: o6MrD-WbPS6l17WVgMwbxA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ba37b5519fso20999661fa.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Aug 2023 23:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691474721; x=1692079521;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9kc7HdgyVBlkH2G96tmXBgYeeZK+6xmO5vsQNUcbsFM=;
 b=a8/nBjQlLg0/NcB7f4FLPBpIJp8q2jB0JCEPyiXBfsngoiPF2Z7SwRLo3JIhYKLUwM
 dwVgMPzT+CCTBM3mN6HtqO9ZLghHax50t6OYhV+wizskxVin2xFKHC5wvdjrbaH/LF6A
 LnGgiK+GPCJPvMS8uOu36NQcKg7la0w7t4CK6AMhJumC0LyZqTpkte1fszZ3ECP0mucv
 ikwTXq40wrQ6Av3W27BIITiXgtUPRCGRfJn5Ciw0eyq5od9c0lkQp7Rdr1huk/7QwU7w
 fVb5PCB1INIKB7ijkSLEKPFu0QOs2FpL8IjkAQ/mcZa/OgrsQ3XTeQ1dvks9U0zeNWx6
 T1Vw==
X-Gm-Message-State: AOJu0YxZPjtXbkcVI8Atz5o+ZAOesg5OwOWbcbhpmvn2HDLuFOzPlED8
 I721qlWWFnmHcMHn2dazWQH9kHGgOr1sT/+ObLMmmwnfaejiL+ZFb6ek7Qj3Aj4+JOZGnlV798m
 Db1DI4wK89ZgxNKkdlAYU71mKR6JjE372tKALFL6opIVASmbYi7xNLsY03Q==
X-Received: by 2002:a2e:95cf:0:b0:2b6:a763:5d13 with SMTP id
 y15-20020a2e95cf000000b002b6a7635d13mr8050841ljh.27.1691474721200; 
 Mon, 07 Aug 2023 23:05:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiP1K3KaY4fH3OT7fEtJD+5UYQiOzlccf24StuAMCOgCgXaVL9bF0+CUaBC+LBT9HuQ1Po/V2Z3r5eXRjphbk=
X-Received: by 2002:a2e:95cf:0:b0:2b6:a763:5d13 with SMTP id
 y15-20020a2e95cf000000b002b6a7635d13mr8050828ljh.27.1691474720898; Mon, 07
 Aug 2023 23:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230808051110.3492693-1-yuanyaogoog@chromium.org>
 <CACGkMEt53ziY_bmgJHVdJ6pkppTyVqKX3=Czygv+yhJR8_KiFA@mail.gmail.com>
 <20230808015921-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230808015921-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Aug 2023 14:05:09 +0800
Message-ID: <CACGkMEtmLi97_6HjcSe9Wuo-BuEZTG3ZRxTHsbt8OUMgNNvwTg@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: fix avail_wrap_counter in
 virtqueue_add_packed
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

T24gVHVlLCBBdWcgOCwgMjAyMyBhdCAxOjU54oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEF1ZyAwOCwgMjAyMyBhdCAwMTo0MzowMlBN
ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gT24gVHVlLCBBdWcgOCwgMjAyMyBhdCAxOjEx
4oCvUE0gWXVhbiBZYW8gPHl1YW55YW9nb29nQGNocm9taXVtLm9yZz4gd3JvdGU6Cj4gPiA+Cj4g
PiA+IEluIGN1cnJlbnQgcGFja2VkIHZpcnRxdWV1ZSBpbXBsZW1lbnRhdGlvbiwgdGhlIGF2YWls
X3dyYXBfY291bnRlciB3b24ndAo+ID4gPiBmbGlwLCBpbiB0aGUgY2FzZSB3aGVuIHRoZSBkcml2
ZXIgc3VwcGxpZXMgYSBkZXNjcmlwdG9yIGNoYWluIHdpdGggYQo+ID4gPiBsZW5ndGggZXF1YWxz
IHRvIHRoZSBxdWV1ZSBzaXplOyB0b3RhbF9zZyA9PSB2cS0+cGFja2VkLnZyaW5nLm51bS4KPiA+
ID4KPiA+ID4gTGV04oCZcyBhc3N1bWUgdGhlIGZvbGxvd2luZyBzaXR1YXRpb246Cj4gPiA+IHZx
LT5wYWNrZWQudnJpbmcubnVtPTQKPiA+ID4gdnEtPnBhY2tlZC5uZXh0X2F2YWlsX2lkeDogMQo+
ID4gPiB2cS0+cGFja2VkLmF2YWlsX3dyYXBfY291bnRlcjogMAo+ID4gPgo+ID4gPiBUaGVuIHRo
ZSBkcml2ZXIgYWRkcyBhIGRlc2NyaXB0b3IgY2hhaW4gY29udGFpbmluZyA0IGRlc2NyaXB0b3Jz
Lgo+ID4gPgo+ID4gPiBXZSBleHBlY3QgdGhlIGZvbGxvd2luZyByZXN1bHQgd2l0aCBhdmFpbF93
cmFwX2NvdW50ZXIgZmxpcHBlZDoKPiA+ID4gdnEtPnBhY2tlZC5uZXh0X2F2YWlsX2lkeDogMQo+
ID4gPiB2cS0+cGFja2VkLmF2YWlsX3dyYXBfY291bnRlcjogMQo+ID4gPgo+ID4gPiBCdXQsIHRo
ZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGdpdmVzIHRoZSBmb2xsb3dpbmcgcmVzdWx0Ogo+ID4g
PiB2cS0+cGFja2VkLm5leHRfYXZhaWxfaWR4OiAxCj4gPiA+IHZxLT5wYWNrZWQuYXZhaWxfd3Jh
cF9jb3VudGVyOiAwCj4gPiA+Cj4gPiA+IFRvIHJlcHJvZHVjZSB0aGUgYnVnLCB5b3UgY2FuIHNl
dCBhIHBhY2tlZCBxdWV1ZSBzaXplIGFzIHNtYWxsIGFzCj4gPiA+IHBvc3NpYmxlLCBzbyB0aGF0
IHRoZSBkcml2ZXIgaXMgbW9yZSBsaWtlbHkgdG8gcHJvdmlkZSBhIGRlc2NyaXB0b3IKPiA+ID4g
Y2hhaW4gd2l0aCBhIGxlbmd0aCBlcXVhbCB0byB0aGUgcGFja2VkIHF1ZXVlIHNpemUuIEZvciBl
eGFtcGxlLCBpbgo+ID4gPiBxZW11IHJ1biBmb2xsb3dpbmcgY29tbWFuZHM6Cj4gPiA+IHN1ZG8g
cWVtdS1zeXN0ZW0teDg2XzY0IFwKPiA+ID4gLWVuYWJsZS1rdm0gXAo+ID4gPiAtbm9ncmFwaGlj
IFwKPiA+ID4gLWtlcm5lbCAicGF0aC90by9rZXJuZWxfaW1hZ2UiIFwKPiA+ID4gLW0gMUcgXAo+
ID4gPiAtZHJpdmUgZmlsZT0icGF0aC90by9yb290ZnMiLGlmPW5vbmUsaWQ9ZGlzayBcCj4gPiA+
IC1kZXZpY2UgdmlydGlvLWJsayxkcml2ZT1kaXNrIFwKPiA+ID4gLWRyaXZlIGZpbGU9InBhdGgv
dG8vZGlza19pbWFnZSIsaWY9bm9uZSxpZD1yd2Rpc2sgXAo+ID4gPiAtZGV2aWNlIHZpcnRpby1i
bGssZHJpdmU9cndkaXNrLHBhY2tlZD1vbixxdWV1ZS1zaXplPTQsXAo+ID4gPiBpbmRpcmVjdF9k
ZXNjPW9mZiBcCj4gPiA+IC1hcHBlbmQgImNvbnNvbGU9dHR5UzAgcm9vdD0vZGV2L3ZkYSBydyBp
bml0PS9iaW4vYmFzaCIKPiA+ID4KPiA+ID4gSW5zaWRlIHRoZSBWTSwgY3JlYXRlIGEgZGlyZWN0
b3J5IGFuZCBtb3VudCB0aGUgcndkaXNrIGRldmljZSBvbiBpdC4gVGhlCj4gPiA+IHJ3ZGlzayB3
aWxsIGhhbmcgYW5kIG1vdW50IG9wZXJhdGlvbiB3aWxsIG5vdCBjb21wbGV0ZS4KPiA+ID4KPiA+
ID4gVGhpcyBjb21taXQgZml4ZXMgdGhlIHdyYXAgY291bnRlciBlcnJvciBieSBmbGlwcGluZyB0
aGUKPiA+ID4gcGFja2VkLmF2YWlsX3dyYXBfY291bnRlciwgd2hlbiBzdGFydCBvZiBkZXNjcmlw
dG9yIGNoYWluIGVxdWFscyB0byB0aGUKPiA+ID4gZW5kIG9mIGRlc2NyaXB0b3IgY2hhaW4gKGhl
YWQgPT0gaSkuCj4gPiA+Cj4gPiA+IEZpeGVzOiAxY2U5ZTYwNTVmYTAgKCJ2aXJ0aW9fcmluZzog
aW50cm9kdWNlIHBhY2tlZCByaW5nIHN1cHBvcnQiKQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZdWFu
IFlhbyA8eXVhbnlhb2dvb2dAY2hyb21pdW0ub3JnPgo+ID4gPiAtLS0KPiA+ID4KPiA+ID4gIGRy
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAyICstCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
Cj4gPiA+IGluZGV4IGM1MzEwZWFmOGI0Ni4uZGExMTUwZDEyN2MyIDEwMDY0NAo+ID4gPiAtLS0g
YS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmMKPiA+ID4gQEAgLTE0NjEsNyArMTQ2MSw3IEBAIHN0YXRpYyBpbmxpbmUg
aW50IHZpcnRxdWV1ZV9hZGRfcGFja2VkKHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiA+ID4gICAg
ICAgICAgICAgICAgIH0KPiA+ID4gICAgICAgICB9Cj4gPiA+Cj4gPiA+IC0gICAgICAgaWYgKGkg
PCBoZWFkKQo+ID4gPiArICAgICAgIGlmIChpIDw9IGhlYWQpCj4gPiA+ICAgICAgICAgICAgICAg
ICB2cS0+cGFja2VkLmF2YWlsX3dyYXBfY291bnRlciBePSAxOwo+ID4KPiA+IFdvdWxkIGl0IGJl
IGJldHRlciB0byBtb3ZlIHRoZSBmbGlwcGluZyB0byB0aGUgcGxhY2Ugd2hlcmUgd2UgZmxpcAo+
ID4gYXZhaWxfdXNlZF9mbGFncz8KPgo+IEkgdGhpbmsgSSBwcmVmZXIgdGhpcyBwYXRjaCBmb3Ig
c3RhYmxlLCByZWZhY3RvcmluZyBjYW4KPiBiZSBkb25lIG9uIHRvcC4KCk9rLiBTbwoKQWNrZWQt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGlmICgodW5saWtlbHkoKytpID49IHZxLT5wYWNrZWQudnJpbmcu
bnVtKSkpIHsKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaSA9IDA7Cj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZxLT5wYWNrZWQuYXZhaWxfdXNlZF9mbGFn
cyBePQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEgPDwgVlJJ
TkdfUEFDS0VEX0RFU0NfRl9BVkFJTCB8Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgMSA8PCBWUklOR19QQUNLRURfREVTQ19GX1VTRUQ7Cj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICB9Cj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4gPgo+ID4gPiAgICAgICAgIC8q
IFdlJ3JlIHVzaW5nIHNvbWUgYnVmZmVycyBmcm9tIHRoZSBmcmVlIGxpc3QuICovCj4gPiA+IC0t
Cj4gPiA+IDIuNDEuMC42NDAuZ2E5NWRlZjU1ZDAtZ29vZwo+ID4gPgo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
