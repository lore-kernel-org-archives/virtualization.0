Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34093C001DB
	for <virtualization@archiver.kernel.org>; Tue,  8 Aug 2023 06:05:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1DC161067;
	Tue,  8 Aug 2023 06:05:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C1DC161067
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OWxA6odO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oY30QiwMso8v; Tue,  8 Aug 2023 06:05:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 39FBA60BF9;
	Tue,  8 Aug 2023 06:05:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 39FBA60BF9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17E8DC0071;
	Tue,  8 Aug 2023 06:05:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62480C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 06:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2FCC7405F5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 06:05:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2FCC7405F5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OWxA6odO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W1pQy-zrjmfx
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 06:05:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 613E0405EC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 06:05:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 613E0405EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691474751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOP3UCdxdZwBEyv5Fh6IklPdndMr9NfHjbDsFfTyZxg=;
 b=OWxA6odOkqkXcaG2uMuaS/cc/x2h8gx0G8ZhMqP+m97UmrlOuI3uw0H39HNUkNpOqU6r2q
 s/jo1kPA2gkbvVoIDxaw7JyX67kC6xeBIkqIHi4rpZvey3e65ybN5FJq6ECWv/oXBU5EZM
 P7fKW5gVUPQ1Y3XlxVRYpKU3HVlgG6c=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-WdVGzTLjNS-smUIklUlZ9g-1; Tue, 08 Aug 2023 02:05:47 -0400
X-MC-Unique: WdVGzTLjNS-smUIklUlZ9g-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b9fa64db5cso55390251fa.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Aug 2023 23:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691474745; x=1692079545;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qOP3UCdxdZwBEyv5Fh6IklPdndMr9NfHjbDsFfTyZxg=;
 b=fQ/ig7s9G4vmn7qIAwMK/cXyvjoxq++CfeQXqA7tkA+T4af8VlnKI9dynec9pFeq3J
 EI9dPwRVoEWAEfxrR+YBfnk2UiQv1WC7vpZJRZpCGVJ7HIYp2k82O+zRWqFSHUPG56CM
 VZNE2d7H4QtVKipQKenXbFckiCijQitVC3RuzeQ2WUCPt/41BhR9TEZDIIJ0icsr/UMo
 QE0XLZxAlnPS+ojEcePgzztHMfdpClxoDocbnsiH86/TGaeEhUtbZ3+b7jNtMAuH/+LJ
 LMFbvQHTXkf8eCioDQLX111azBOOTxkRxGKrIIMkioe5oxkDHE8kR+Rn2CiVlKLhVteL
 f5jw==
X-Gm-Message-State: AOJu0YxaGXkEilAyEhrObkp8gl/Uyelmf3GDmyTPZghTwiwTaEGCN6GR
 UeTxfjJjb3/VK0JDU7tx27Zfojs6gXF19y0I4Am3kwNnfAf4NAHOPX3aGazYcvPwqbGgzWhITtZ
 kwW0lNzS3O6NCtPb8vnhCaCdn1rTvVMuiGm//h//ur3YbfC4+x+J0Ribyjw==
X-Received: by 2002:a2e:8706:0:b0:2b9:35ae:c9ac with SMTP id
 m6-20020a2e8706000000b002b935aec9acmr8985887lji.2.1691474745527; 
 Mon, 07 Aug 2023 23:05:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB4FPK57NJCdoZAr7GH4lSTDvxl2Rj2fwo8dADkTNUUpuVR63YX0D/XhSN8Y3+/z7/PQBLD/VqAsN3jEoWoXA=
X-Received: by 2002:a2e:8706:0:b0:2b9:35ae:c9ac with SMTP id
 m6-20020a2e8706000000b002b935aec9acmr8985864lji.2.1691474745305; Mon, 07 Aug
 2023 23:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230808051110.3492693-1-yuanyaogoog@chromium.org>
 <CACGkMEt53ziY_bmgJHVdJ6pkppTyVqKX3=Czygv+yhJR8_KiFA@mail.gmail.com>
 <CAOJyEHaXqmHStJnHrT0H4QsTJBxjBxVe+33EuWm9H3wApPKtxQ@mail.gmail.com>
In-Reply-To: <CAOJyEHaXqmHStJnHrT0H4QsTJBxjBxVe+33EuWm9H3wApPKtxQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Aug 2023 14:05:34 +0800
Message-ID: <CACGkMEuiVnLFRRDHaTH3Jnpr+znU9L33gLyRynbBabVqumN2ug@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: fix avail_wrap_counter in
 virtqueue_add_packed
To: Yuan Yao <yuanyaogoog@chromium.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Tiwei Bie <tiwei.bie@intel.com>, Junichi Uekawa <uekawa@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Takaya Saeki <takayas@chromium.org>,
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

T24gVHVlLCBBdWcgOCwgMjAyMyBhdCAxOjU54oCvUE0gWXVhbiBZYW8gPHl1YW55YW9nb29nQGNo
cm9taXVtLm9yZz4gd3JvdGU6Cj4KPiBTaW5jZSB0aGVyZSBpcyBhIGNoZWNrIGZvciAwLWxlbmd0
aCBjaGFpbiBpbiBjb2RlO0JVR19PTih0b3RhbF9zZyA9PSAwKSwgd2Ugd29u4oCZdCBnZXQgYSAw
LWxlbmd0aCBjaGFpbiBpbiBwcmFjdGljZS4gU28sIEkgdGhpbmsgdXNlIChpIDw9IGhlYWQpIG1h
a2VzIHRoZSBjb21taXQgYXMgc21hbGwgYXMgcG9zc2libGUuCgpPaywgb2ZmZXJlZCBhY2sgaW4g
b3RoZXIgbWFpbC4KClRoYW5rcwoKPgo+Cj4gQmVzdCByZWdhcmRzCj4KPgo+Cj4gT24gVHVlLCBB
dWcgOCwgMjAyMyBhdCAyOjQz4oCvUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4+Cj4+IE9uIFR1ZSwgQXVnIDgsIDIwMjMgYXQgMToxMeKAr1BNIFl1YW4gWWFvIDx5
dWFueWFvZ29vZ0BjaHJvbWl1bS5vcmc+IHdyb3RlOgo+PiA+Cj4+ID4gSW4gY3VycmVudCBwYWNr
ZWQgdmlydHF1ZXVlIGltcGxlbWVudGF0aW9uLCB0aGUgYXZhaWxfd3JhcF9jb3VudGVyIHdvbid0
Cj4+ID4gZmxpcCwgaW4gdGhlIGNhc2Ugd2hlbiB0aGUgZHJpdmVyIHN1cHBsaWVzIGEgZGVzY3Jp
cHRvciBjaGFpbiB3aXRoIGEKPj4gPiBsZW5ndGggZXF1YWxzIHRvIHRoZSBxdWV1ZSBzaXplOyB0
b3RhbF9zZyA9PSB2cS0+cGFja2VkLnZyaW5nLm51bS4KPj4gPgo+PiA+IExldOKAmXMgYXNzdW1l
IHRoZSBmb2xsb3dpbmcgc2l0dWF0aW9uOgo+PiA+IHZxLT5wYWNrZWQudnJpbmcubnVtPTQKPj4g
PiB2cS0+cGFja2VkLm5leHRfYXZhaWxfaWR4OiAxCj4+ID4gdnEtPnBhY2tlZC5hdmFpbF93cmFw
X2NvdW50ZXI6IDAKPj4gPgo+PiA+IFRoZW4gdGhlIGRyaXZlciBhZGRzIGEgZGVzY3JpcHRvciBj
aGFpbiBjb250YWluaW5nIDQgZGVzY3JpcHRvcnMuCj4+ID4KPj4gPiBXZSBleHBlY3QgdGhlIGZv
bGxvd2luZyByZXN1bHQgd2l0aCBhdmFpbF93cmFwX2NvdW50ZXIgZmxpcHBlZDoKPj4gPiB2cS0+
cGFja2VkLm5leHRfYXZhaWxfaWR4OiAxCj4+ID4gdnEtPnBhY2tlZC5hdmFpbF93cmFwX2NvdW50
ZXI6IDEKPj4gPgo+PiA+IEJ1dCwgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gZ2l2ZXMgdGhl
IGZvbGxvd2luZyByZXN1bHQ6Cj4+ID4gdnEtPnBhY2tlZC5uZXh0X2F2YWlsX2lkeDogMQo+PiA+
IHZxLT5wYWNrZWQuYXZhaWxfd3JhcF9jb3VudGVyOiAwCj4+ID4KPj4gPiBUbyByZXByb2R1Y2Ug
dGhlIGJ1ZywgeW91IGNhbiBzZXQgYSBwYWNrZWQgcXVldWUgc2l6ZSBhcyBzbWFsbCBhcwo+PiA+
IHBvc3NpYmxlLCBzbyB0aGF0IHRoZSBkcml2ZXIgaXMgbW9yZSBsaWtlbHkgdG8gcHJvdmlkZSBh
IGRlc2NyaXB0b3IKPj4gPiBjaGFpbiB3aXRoIGEgbGVuZ3RoIGVxdWFsIHRvIHRoZSBwYWNrZWQg
cXVldWUgc2l6ZS4gRm9yIGV4YW1wbGUsIGluCj4+ID4gcWVtdSBydW4gZm9sbG93aW5nIGNvbW1h
bmRzOgo+PiA+IHN1ZG8gcWVtdS1zeXN0ZW0teDg2XzY0IFwKPj4gPiAtZW5hYmxlLWt2bSBcCj4+
ID4gLW5vZ3JhcGhpYyBcCj4+ID4gLWtlcm5lbCAicGF0aC90by9rZXJuZWxfaW1hZ2UiIFwKPj4g
PiAtbSAxRyBcCj4+ID4gLWRyaXZlIGZpbGU9InBhdGgvdG8vcm9vdGZzIixpZj1ub25lLGlkPWRp
c2sgXAo+PiA+IC1kZXZpY2UgdmlydGlvLWJsayxkcml2ZT1kaXNrIFwKPj4gPiAtZHJpdmUgZmls
ZT0icGF0aC90by9kaXNrX2ltYWdlIixpZj1ub25lLGlkPXJ3ZGlzayBcCj4+ID4gLWRldmljZSB2
aXJ0aW8tYmxrLGRyaXZlPXJ3ZGlzayxwYWNrZWQ9b24scXVldWUtc2l6ZT00LFwKPj4gPiBpbmRp
cmVjdF9kZXNjPW9mZiBcCj4+ID4gLWFwcGVuZCAiY29uc29sZT10dHlTMCByb290PS9kZXYvdmRh
IHJ3IGluaXQ9L2Jpbi9iYXNoIgo+PiA+Cj4+ID4gSW5zaWRlIHRoZSBWTSwgY3JlYXRlIGEgZGly
ZWN0b3J5IGFuZCBtb3VudCB0aGUgcndkaXNrIGRldmljZSBvbiBpdC4gVGhlCj4+ID4gcndkaXNr
IHdpbGwgaGFuZyBhbmQgbW91bnQgb3BlcmF0aW9uIHdpbGwgbm90IGNvbXBsZXRlLgo+PiA+Cj4+
ID4gVGhpcyBjb21taXQgZml4ZXMgdGhlIHdyYXAgY291bnRlciBlcnJvciBieSBmbGlwcGluZyB0
aGUKPj4gPiBwYWNrZWQuYXZhaWxfd3JhcF9jb3VudGVyLCB3aGVuIHN0YXJ0IG9mIGRlc2NyaXB0
b3IgY2hhaW4gZXF1YWxzIHRvIHRoZQo+PiA+IGVuZCBvZiBkZXNjcmlwdG9yIGNoYWluIChoZWFk
ID09IGkpLgo+PiA+Cj4+ID4gRml4ZXM6IDFjZTllNjA1NWZhMCAoInZpcnRpb19yaW5nOiBpbnRy
b2R1Y2UgcGFja2VkIHJpbmcgc3VwcG9ydCIpCj4+ID4gU2lnbmVkLW9mZi1ieTogWXVhbiBZYW8g
PHl1YW55YW9nb29nQGNocm9taXVtLm9yZz4KPj4gPiAtLS0KPj4gPgo+PiA+ICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jIHwgMiArLQo+PiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKPj4gPgo+PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+PiA+IGluZGV4
IGM1MzEwZWFmOGI0Ni4uZGExMTUwZDEyN2MyIDEwMDY0NAo+PiA+IC0tLSBhL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMKPj4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
Cj4+ID4gQEAgLTE0NjEsNyArMTQ2MSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9h
ZGRfcGFja2VkKHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPj4gPiAgICAgICAgICAgICAgICAgfQo+
PiA+ICAgICAgICAgfQo+PiA+Cj4+ID4gLSAgICAgICBpZiAoaSA8IGhlYWQpCj4+ID4gKyAgICAg
ICBpZiAoaSA8PSBoZWFkKQo+PiA+ICAgICAgICAgICAgICAgICB2cS0+cGFja2VkLmF2YWlsX3dy
YXBfY291bnRlciBePSAxOwo+Pgo+PiBXb3VsZCBpdCBiZSBiZXR0ZXIgdG8gbW92ZSB0aGUgZmxp
cHBpbmcgdG8gdGhlIHBsYWNlIHdoZXJlIHdlIGZsaXAKPj4gYXZhaWxfdXNlZF9mbGFncz8KPj4K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCh1bmxpa2VseSgrK2kgPj0gdnEtPnBhY2tl
ZC52cmluZy5udW0pKSkgewo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGkgPSAw
Owo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZxLT5wYWNrZWQuYXZhaWxfdXNl
ZF9mbGFncyBePQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMSA8
PCBWUklOR19QQUNLRURfREVTQ19GX0FWQUlMIHwKPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDEgPDwgVlJJTkdfUEFDS0VEX0RFU0NfRl9VU0VEOwo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICB9Cj4+Cj4+IFRoYW5rcwo+Pgo+PiA+Cj4+ID4gICAgICAgICAvKiBX
ZSdyZSB1c2luZyBzb21lIGJ1ZmZlcnMgZnJvbSB0aGUgZnJlZSBsaXN0LiAqLwo+PiA+IC0tCj4+
ID4gMi40MS4wLjY0MC5nYTk1ZGVmNTVkMC1nb29nCj4+ID4KPj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
