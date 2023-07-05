Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AEEEB64DA
	for <virtualization@archiver.kernel.org>; Wed,  5 Jul 2023 07:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 40B4F4031E;
	Wed,  5 Jul 2023 07:55:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 40B4F4031E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KVFtlfKy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FwoEYcn6Q0mA; Wed,  5 Jul 2023 07:55:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8E450400D9;
	Wed,  5 Jul 2023 07:55:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E450400D9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63992C0071;
	Wed,  5 Jul 2023 07:55:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E028C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 07:55:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 388B68148E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 07:55:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 388B68148E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KVFtlfKy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NJuCu8pYMlWP
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 07:55:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2B2D8146D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C2B2D8146D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 07:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688543737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JchDhPT3KR3iSA029I0+obQ1cLL2Ob33e0q6YR+m51M=;
 b=KVFtlfKyzJ8BK1tFY9Qr16Ohv1eJmgceI8JOMgPXYpM2mTwE27y2wiHFizeonqCy7EtpK1
 x475V/nW/k+cEya98XMeVdiL2I4l0Cg7KH0Y4GghMdlrgCmxlfP3bPVBzuZ2hGIsfbK6u5
 4RQeMXRN1LRNI2wJdjWSU7ob/PEr1do=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-HMqN8Gv-NBy9-YuyqRUfiA-1; Wed, 05 Jul 2023 03:55:36 -0400
X-MC-Unique: HMqN8Gv-NBy9-YuyqRUfiA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-635e0889cc5so64670716d6.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Jul 2023 00:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688543736; x=1691135736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JchDhPT3KR3iSA029I0+obQ1cLL2Ob33e0q6YR+m51M=;
 b=UbWIlg9T8wkIFg1jFtJboTgrsOcoVqe1WgceSWyazMwX8TKZAmeWSr451V35LYXZf/
 B2hcv9rnbsmC70lG7YJApADXQ0YUuk3rLCScVeZUuLaHkLF2ITQ5dg6QTXEkFE/pA/CO
 wjHeOm0HfUHTFCNrWhydcZq18elymZRWf1gMUhnxQVyn6z2CaQ3ounVjkcJ70FDE2bkn
 BpKdD9kbs+Z+JfCeGwWy0y3MirOo3vJ90HFaDi6Xh2zylY4Z4/IJh+WICGAr8dtVJDuk
 bMPKL3JmZVZX4Tu2dFBLlxEJlxwgMMtoDrSg3j65B88neZoO0bTrv9J65eocI7tByvm0
 fW3A==
X-Gm-Message-State: ABy/qLZA6wHulPozMrzXaPRfXOW8TaPha5GI6hy9o80Sih++VwnnZQo7
 z9vJfu9ohnUXaUYxqY05z8YVUbev/0QdhjrZZOoch3bqCSGrb6ExR3r0rc55eMBjPtL7hRRFsgR
 g8u0gRAkWzlaZiGWxvfuOa4+vhxJTxX4dWqqQfuEAeYpKnp35MlacDdY1Kw==
X-Received: by 2002:a0c:e9c7:0:b0:632:301e:62fc with SMTP id
 q7-20020a0ce9c7000000b00632301e62fcmr14553357qvo.35.1688543736083; 
 Wed, 05 Jul 2023 00:55:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFqduiWcmunoNBMAdWzr6PpWjNwv7fXWO8C6/ME3RHNm2xO9+3sdoOnnjp1VMMQRCem4bpXAtZUe/vemaJ32+g=
X-Received: by 2002:a0c:e9c7:0:b0:632:301e:62fc with SMTP id
 q7-20020a0ce9c7000000b00632301e62fcmr14553352qvo.35.1688543735859; Wed, 05
 Jul 2023 00:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142218.362549-1-eperezma@redhat.com>
 <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230704063646-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Jul 2023 15:55:23 +0800
Message-ID: <CACGkMEvT4Y+-wfhyi324Y5hhAtn+ZF7cP9d=omdH-ZgdJ-4SOQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does not
 support it
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio Perez Martin <eperezma@redhat.com>
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

T24gVHVlLCBKdWwgNCwgMjAyMyBhdCA2OjM44oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEp1bCAwNCwgMjAyMyBhdCAxMjoyNTozMlBN
ICswMjAwLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3cm90ZToKPiA+IE9uIE1vbiwgSnVsIDMsIDIw
MjMgYXQgNDo1MuKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3Rl
Ogo+ID4gPgo+ID4gPiBPbiBNb24sIEp1bCAwMywgMjAyMyBhdCAwNDoyMjoxOFBNICswMjAwLCBF
dWdlbmlvIFDDqXJleiB3cm90ZToKPiA+ID4gPiBXaXRoIHRoZSBjdXJyZW50IGNvZGUgaXQgaXMg
YWNjZXB0ZWQgYXMgbG9uZyBhcyB1c2VybGFuZCBzZW5kIGl0Lgo+ID4gPiA+Cj4gPiA+ID4gQWx0
aG91Z2ggdXNlcmxhbmQgc2hvdWxkIG5vdCBzZXQgYSBmZWF0dXJlIGZsYWcgdGhhdCBoYXMgbm90
IGJlZW4KPiA+ID4gPiBvZmZlcmVkIHRvIGl0IHdpdGggVkhPU1RfR0VUX0JBQ0tFTkRfRkVBVFVS
RVMsIHRoZSBjdXJyZW50IGNvZGUgd2lsbCBub3QKPiA+ID4gPiBjb21wbGFpbiBmb3IgaXQuCj4g
PiA+ID4KPiA+ID4gPiBTaW5jZSB0aGVyZSBpcyBubyBzcGVjaWZpYyByZWFzb24gZm9yIGFueSBw
YXJlbnQgdG8gcmVqZWN0IHRoYXQgYmFja2VuZAo+ID4gPiA+IGZlYXR1cmUgYml0IHdoZW4gaXQg
aGFzIGJlZW4gcHJvcG9zZWQsIGxldCdzIGNvbnRyb2wgaXQgYXQgdmRwYSBmcm9udGVuZAo+ID4g
PiA+IGxldmVsLiBGdXR1cmUgcGF0Y2hlcyBtYXkgbW92ZSB0aGlzIGNvbnRyb2wgdG8gdGhlIHBh
cmVudCBkcml2ZXIuCj4gPiA+ID4KPiA+ID4gPiBGaXhlczogOTY3ODAwZDJkNTJlICgidmRwYTog
YWNjZXB0IFZIT1NUX0JBQ0tFTkRfRl9FTkFCTEVfQUZURVJfRFJJVkVSX09LIGJhY2tlbmQgZmVh
dHVyZSIpCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJl
ZGhhdC5jb20+Cj4gPiA+Cj4gPiA+IFBsZWFzZSBkbyBzZW5kIHYzLiBBbmQgYWdhaW4sIEkgZG9u
J3Qgd2FudCB0byBzZW5kICJhZnRlciBkcml2ZXIgb2siIGhhY2sKPiA+ID4gdXBzdHJlYW0gYXQg
YWxsLCBJIG1lcmdlZCBpdCBpbiBuZXh0IGp1c3QgdG8gZ2l2ZSBpdCBzb21lIHRlc3RpbmcuCj4g
PiA+IFdlIHdhbnQgUklOR19BQ0NFU1NfQUZURVJfS0lDSyBvciBzb21lIHN1Y2guCj4gPiA+Cj4g
Pgo+ID4gQ3VycmVudCBkZXZpY2VzIGRvIG5vdCBzdXBwb3J0IHRoYXQgc2VtYW50aWMuCj4KPiBX
aGljaCBkZXZpY2VzIHNwZWNpZmljYWxseSBhY2Nlc3MgdGhlIHJpbmcgYWZ0ZXIgRFJJVkVSX09L
IGJ1dCBiZWZvcmUKPiBhIGtpY2s/CgpWaG9zdC1uZXQgaXMgb25lIGV4YW1wbGUgYXQgbGFzdC4g
SXQgcG9sbHMgYSBzb2NrZXQgYXMgd2VsbCwgc28gaXQKc3RhcnRzIHRvIGFjY2VzcyB0aGUgcmlu
ZyBpbW1lZGlhdGVseSBhZnRlciBEUklWRVJfT0suCgpUaGFua3MKCj4KPiA+IE15IHBsYW4gd2Fz
IHRvIGNvbnZlcnQKPiA+IGl0IGluIHZwX3ZkcGEgaWYgbmVlZGVkLCBhbmQgcmV1c2UgdGhlIGN1
cnJlbnQgdmRwYSBvcHMuIFNvcnJ5IGlmIEkKPiA+IHdhcyBub3QgZXhwbGljaXQgZW5vdWdoLgo+
ID4KPiA+IFRoZSBvbmx5IHNvbHV0aW9uIEkgY2FuIHNlZSB0byB0aGF0IGlzIHRvIHRyYXAgJiBl
bXVsYXRlIGluIHRoZSB2ZHBhCj4gPiAocGFyZW50PykgZHJpdmVyLCBhcyB0YWxrZWQgaW4gdmly
dGlvLWNvbW1lbnQuIEJ1dCB0aGF0IGNvbXBsaWNhdGVzCj4gPiB0aGUgYXJjaGl0ZWN0dXJlOgo+
ID4gKiBPZmZlciBWSE9TVF9CQUNLRU5EX0ZfUklOR19BQ0NFU1NfQUZURVJfS0lDSwo+ID4gKiBT
dG9yZSB2cSBlbmFibGUgc3RhdGUgc2VwYXJhdGVseSwgYXQKPiA+IHZkcGEtPmNvbmZpZy0+c2V0
X3ZxX3JlYWR5KHRydWUpLCBidXQgbm90IHRyYW5zbWl0IHRoYXQgZW5hYmxlIHRvIGh3Cj4gPiAq
IFN0b3JlIHRoZSBkb29yYmVsbCBzdGF0ZSBzZXBhcmF0ZWx5LCBidXQgZG8gbm90IGNvbmZpZ3Vy
ZSBpdCB0byB0aGUKPiA+IGRldmljZSBkaXJlY3RseS4KPiA+Cj4gPiBCdXQgaG93IHRvIHJlY292
ZXIgaWYgdGhlIGRldmljZSBjYW5ub3QgY29uZmlndXJlIHRoZW0gYXQga2ljayB0aW1lLAo+ID4g
Zm9yIGV4YW1wbGU/Cj4gPgo+ID4gTWF5YmUgd2UgY2FuIGp1c3QgZmFpbCBpZiB0aGUgcGFyZW50
IGRyaXZlciBkb2VzIG5vdCBzdXBwb3J0IGVuYWJsaW5nCj4gPiB0aGUgdnEgYWZ0ZXIgRFJJVkVS
X09LPyBUaGF0IHdheSBubyBuZXcgZmVhdHVyZSBmbGFnIGlzIG5lZWRlZC4KPiA+Cj4gPiBUaGFu
a3MhCj4gPgo+ID4gPgo+ID4gPiA+IC0tLQo+ID4gPiA+IFNlbnQgd2l0aCBGaXhlczogdGFnIHBv
aW50aW5nIHRvIGdpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tc3QKPiA+
ID4gPiBjb21taXQuIFBsZWFzZSBsZXQgbWUga25vdyBpZiBJIHNob3VsZCBzZW5kIGEgdjMgb2Yg
WzFdIGluc3RlYWQuCj4gPiA+ID4KPiA+ID4gPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC8yMDIzMDYwOTEyMTI0NC1tdXR0LXNlbmQtZW1haWwtbXN0QGtlcm5lbC5vcmcvVC8KPiA+
ID4gPiAtLS0KPiA+ID4gPiAgZHJpdmVycy92aG9zdC92ZHBhLmMgfCA3ICsrKysrLS0KPiA+ID4g
PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+ID4g
Pgo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhv
c3QvdmRwYS5jCj4gPiA+ID4gaW5kZXggZTFhYmYyOWZlZDViLi5hN2U1NTQzNTIzNTEgMTAwNjQ0
Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+ID4gPiArKysgYi9kcml2ZXJz
L3Zob3N0L3ZkcGEuYwo+ID4gPiA+IEBAIC02ODEsMTggKzY4MSwyMSBAQCBzdGF0aWMgbG9uZyB2
aG9zdF92ZHBhX3VubG9ja2VkX2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlcCwKPiA+ID4gPiAgewo+
ID4gPiA+ICAgICAgIHN0cnVjdCB2aG9zdF92ZHBhICp2ID0gZmlsZXAtPnByaXZhdGVfZGF0YTsK
PiA+ID4gPiAgICAgICBzdHJ1Y3Qgdmhvc3RfZGV2ICpkID0gJnYtPnZkZXY7Cj4gPiA+ID4gKyAg
ICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdi0+dmRwYS0+Y29uZmlnOwo+
ID4gPiA+ICAgICAgIHZvaWQgX191c2VyICphcmdwID0gKHZvaWQgX191c2VyICopYXJnOwo+ID4g
PiA+ICAgICAgIHU2NCBfX3VzZXIgKmZlYXR1cmVwID0gYXJncDsKPiA+ID4gPiAtICAgICB1NjQg
ZmVhdHVyZXM7Cj4gPiA+ID4gKyAgICAgdTY0IGZlYXR1cmVzLCBwYXJlbnRfZmVhdHVyZXMgPSAw
Owo+ID4gPiA+ICAgICAgIGxvbmcgciA9IDA7Cj4gPiA+ID4KPiA+ID4gPiAgICAgICBpZiAoY21k
ID09IFZIT1NUX1NFVF9CQUNLRU5EX0ZFQVRVUkVTKSB7Cj4gPiA+ID4gICAgICAgICAgICAgICBp
ZiAoY29weV9mcm9tX3VzZXIoJmZlYXR1cmVzLCBmZWF0dXJlcCwgc2l6ZW9mKGZlYXR1cmVzKSkp
Cj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOwo+ID4gPiA+ICsg
ICAgICAgICAgICAgaWYgKG9wcy0+Z2V0X2JhY2tlbmRfZmVhdHVyZXMpCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgIHBhcmVudF9mZWF0dXJlcyA9IG9wcy0+Z2V0X2JhY2tlbmRfZmVhdHVy
ZXModi0+dmRwYSk7Cj4gPiA+ID4gICAgICAgICAgICAgICBpZiAoZmVhdHVyZXMgJiB+KFZIT1NU
X1ZEUEFfQkFDS0VORF9GRUFUVVJFUyB8Cj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1NVU1BFTkQpIHwKPiA+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfUkVTVU1FKSB8
Cj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJJVF9VTEwoVkhPU1RfQkFD
S0VORF9GX0VOQUJMRV9BRlRFUl9EUklWRVJfT0spKSkKPiA+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcGFyZW50X2ZlYXR1cmVzKSkKPiA+ID4gPiAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOwo+ID4gPiA+ICAgICAgICAgICAgICAgaWYgKChmZWF0
dXJlcyAmIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1NVU1BFTkQpKSAmJgo+ID4gPiA+ICAgICAg
ICAgICAgICAgICAgICAhdmhvc3RfdmRwYV9jYW5fc3VzcGVuZCh2KSkKPiA+ID4gPiAtLQo+ID4g
PiA+IDIuMzkuMwo+ID4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
