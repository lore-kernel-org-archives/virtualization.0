Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2028EDEC7C
	for <virtualization@archiver.kernel.org>; Wed, 13 Sep 2023 15:51:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7626E41DC5;
	Wed, 13 Sep 2023 15:51:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7626E41DC5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=av9VidDp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EJ2rPgx9qTh9; Wed, 13 Sep 2023 15:51:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EA84C41862;
	Wed, 13 Sep 2023 15:51:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA84C41862
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2E11C0071;
	Wed, 13 Sep 2023 15:51:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B0AEC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 15:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F08F822EA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 15:51:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F08F822EA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=av9VidDp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cPZ92DM0km6w
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 15:51:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 97308822E0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 15:51:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 97308822E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694620262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3o7E166TQmYuEbLduCtQffKyw+M6tARG2eEx2M8sZN4=;
 b=av9VidDpmCTaJmTS1ftEH0KlA1ml8SaVOcJYHPQf7J0WtZy/nWF9mFEoS8mJN+6e/H7W4T
 lh/CkvuX2atVdemCPaUoEGp6AbHyc4LScVRfe5M/LthslKdK0ULoIcJAPQlMDkw0xWr9+E
 Y+nnnqaQugX2EdIUZNl2a9VurHpjACw=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-JkxtV0_gM-WUokRnuV-WSw-1; Wed, 13 Sep 2023 11:51:00 -0400
X-MC-Unique: JkxtV0_gM-WUokRnuV-WSw-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-44e88955a58so5263137.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 08:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694620260; x=1695225060;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3o7E166TQmYuEbLduCtQffKyw+M6tARG2eEx2M8sZN4=;
 b=D5GCfpE5Tnk3bGNC3ZUpnRVOqs3gK8a2/sYi1vifG9FynF51kn1WBiQGT8JBHMni+F
 GiVGY95gBYG2HmgCgQrOEh+MoJI/KSK5n0rxtFRFmiCzIPbDu3jHSBYFiVJxSJ7jYsP3
 5GVd9nCWr71t+e8qz6wcvzC6ze8CEzYYzF7q1sth6Gt99sc8CSfOZFm/XD+ij13ccaNq
 Pc+1mYCJvuBop39fONG8OpGZgjHio4oqiFErmUkccsdtlFNz/gcnN3WI2S///R0586IX
 ZYpT4UqOnqEJp8dD891rjswZjeoswTBNX2bRo1k4hEf3ZdwRAnRF5EWK51LkI/437Lim
 snuA==
X-Gm-Message-State: AOJu0YxTVUc0vhFMAOGyOiz6Imc8UAoSblXjbzMyP92lY2gvaqepDYJ7
 kGSJr/p2zFhfsCCA3aDno6krzL9lV2pyVZCK4ga3qKY70b4idVAZtzHtEukGnbmazBjzxXeRAxE
 DdgNNICRzgeDJTQWceRjoajUGfby2RAgbrMzFTMRHah6TBY6jP/17FzvFAg==
X-Received: by 2002:a67:e359:0:b0:44e:d729:2a04 with SMTP id
 s25-20020a67e359000000b0044ed7292a04mr2558162vsm.19.1694620260289; 
 Wed, 13 Sep 2023 08:51:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbeLeQ3wYqoN2w95BnQoUbNi5ishPbz07VHpPLT+US55Vn8zpZMYdjEtUPjE3D1Fgjn66DURgo4KhNCziH3Eo=
X-Received: by 2002:a67:e359:0:b0:44e:d729:2a04 with SMTP id
 s25-20020a67e359000000b0044ed7292a04mr2558147vsm.19.1694620260047; Wed, 13
 Sep 2023 08:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <ZQHPeD0fds9sYzHO@pc-79.home>
In-Reply-To: <ZQHPeD0fds9sYzHO@pc-79.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 13 Sep 2023 17:50:48 +0200
Message-ID: <CABgObfbXsHN6=ZmL0s+mtCypXs11LNECECO3Uud_J6PMr+JwNA@mail.gmail.com>
Subject: Re: [virtio-comment] virtio-sound linux driver conformance to spec
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, virtio-comment@lists.oasis-open.org
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

T24gV2VkLCBTZXAgMTMsIDIwMjMgYXQgNTowNeKAr1BNIE1hdGlhcyBFemVxdWllbCBWYXJhIExh
cnNlbgo8bXZhcmFsYXJAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBIZWxsbywKPgo+IFRoaXMgZW1h
aWwgaXMgdG8gcmVwb3J0IGEgYmVoYXZpb3Igb2YgdGhlIExpbnV4IHZpcnRpby1zb3VuZCBkcml2
ZXIgdGhhdAo+IGxvb2tzIGxpa2UgaXQgaXMgbm90IGNvbmZvcm1pbmcgdG8gdGhlIFZpcnRJTyBz
cGVjaWZpY2F0aW9uLiBUaGUga2VybmVsCj4gZHJpdmVyIGlzIG1vdmluZyBidWZmZXJzIGZyb20g
dGhlIHVzZWQgcmluZyB0byB0aGUgYXZhaWxhYmxlIHJpbmcKPiB3aXRob3V0IGtub3dpbmcgaWYg
dGhlIGNvbnRlbnQgaGFzIGJlZW4gdXBkYXRlZCBmcm9tIHRoZSB1c2VyLiBJZiB0aGUKPiBkZXZp
Y2UgcGlja3MgdXAgYnVmZmVycyBmcm9tIHRoZSBhdmFpbGFibGUgcmluZyBqdXN0IGFmdGVyIGl0
IGlzCj4gbm90aWZpZWQsIGl0IGhhcHBlbnMgdGhhdCB0aGUgY29udGVudCBpcyBvbGQuIFRoaXMg
cHJvYmxlbSBjYW4gYmUgZml4ZWQKPiBieSB3YWl0aW5nIGEgcGVyaW9kIG9mIHRpbWUgYWZ0ZXIg
dGhlIGRldmljZSBkZXF1ZXVlcyBhIGJ1ZmZlciBmcm9tIHRoZQo+IGF2YWlsYWJsZSByaW5nLiBU
aGUgZHJpdmVyIHNob3VsZCBub3QgYmUgYWxsb3dlZCB0byBjaGFuZ2UgdGhlIGNvbnRlbnQKPiBv
ZiBhIGJ1ZmZlciBpbiB0aGUgYXZhaWxhYmxlIHJpbmcuIFdoZW4gYnVmZmVycyBhcmUgZW5xdWV1
ZWQgaW4gdGhlCj4gYXZhaWxhYmxlIHJpbmcsIHRoZSBkZXZpY2UgY2FuIGNvbnN1bWUgdGhlbSBp
bW1lZGlhdGVseS4KPgo+IDEuIElzIHRoZSBhY3R1YWwgZHJpdmVyIGltcGxlbWVudGF0aW9uIGZv
bGxvd2luZyB0aGUgc3BlYz8KCklmIEkgdW5kZXJzdGFuZCB0aGUgaXNzdWUgY29ycmVjdGx5LCBp
dCdzIG5vdC4gQXMgeW91IHNheSwgYWJzZW50IGFueQpjbGFyaWZpY2F0aW9uIGEgYnVmZmVyIHRo
YXQgaGFzIGJlZW4gcGxhY2VkIGluIHRoZSBhdmFpbGFibGUgcmluZwpzaG91bGQgYmUgdW5tb2Rp
ZmlhYmxlOyB0aGUgZHJpdmVyIHNob3VsZCBvcGVyYXRlIGFzIGlmIHRoZSBkYXRhIGluCnRoZSBh
dmFpbGFibGUgcmluZyBpcyBjb3BpZWQgdG8gYW4gaW50ZXJuYWwgYnVmZmVyIGluc3RhbnRseSB3
aGVuIHRoZQpidWZmZXIgaWQgaXMgYWRkZWQgdG8gdGhlIHJpbmcuCgpJIGFtIGFzc3VtaW5nIHRo
aXMgaXMgYSBwbGF5YmFjayBidWZmZXIuIFRvIGNsYXJpZnksIGRvZXMgdGhlIGRyaXZlcgpleHBl
Y3QgYnVmZmVycyB0byBiZSByZWFkIG9ubHkgYXMgbmVlZGVkLCB3aGljaCBpcyBhIGZyYWN0aW9u
IG9mIGEKc2Vjb25kIGJlZm9yZSB0aGUgZGF0YSBpcyBwbGF5ZWQgYmFjaz8KCj4gMi4gU2hhbGwg
dGhlIHNwZWMgYmUgZXh0ZW5kZWQgdG8gc3VwcG9ydCBzdWNoIGEgdXNlLWNhc2U/CgpJZiBpdCBw
bGFjZXMgTiBidWZmZXJzLCBJIHRoaW5rIGl0J3MgYSByZWFzb25hYmxlIGV4cGVjdGF0aW9uIChm
b3IgdGhlCnNvdW5kIGRldmljZSBvbmx5ISkgdGhhdCB0aGUgTnRoIGlzbid0IHJlYWQgdW50aWwg
dGhlIChOLTEpdGggaGFzCnN0YXJ0ZWQgcGxheWluZy4gV2l0aCB0d28gYnVmZmVycyBvbmx5LCB0
aGUgYmVoYXZpb3IgeW91IHNwZWNpZnkgd291bGQKbm90IGJlIHBlcm1pc3NpYmxlIChiZWNhdXNl
IGFzIHNvb24gYXMgYnVmZmVyIDEgc3RhcnRzIHBsYXlpbmcsIHRoZQpkZXZpY2UgY2FuIHJlYWQg
YnVmZmVyIDI7IHRoZXJlIGlzIG5ldmVyIGFuIGlkbGUgYnVmZmVyKS4gV2l0aCB0aHJlZQpidWZm
ZXJzLCB5b3UgY291bGQgd3JpdGUgYnVmZmVyIDMgd2hpbGUgYnVmZmVyIDEgcGxheXM7IHdyaXRl
IGJ1ZmZlciAxCndoaWxlIGJ1ZmZlciAyIHBsYXlzOyBhbmQgd3JpdGUgYnVmZmVyIDIgd2hpbGUg
YnVmZmVyIDMgcGxheXMuIElzIHRoaXMKZW5vdWdoPwoKVGhhdCBzYWlkLCBiZWluZyByZWFzb25h
YmxlIGlzbid0IGVub3VnaCBmb3IgdmlydGlvLXNvdW5kIHRvIGRvIGl0IGFuZApkZXZpYXRlIGZy
b20gb3RoZXIgdmlydGlvIGRldmljZXMuIFdoeSBkb2VzIHRoZSBMaW51eCBkcml2ZXIgYmVoYXZl
Cmxpa2UgdGhpcz8gSXMgaXQgc29tZWhvdyBjb25zdHJhaW5lZCBieSB0aGUga2VybmVsLT51c2Vy
c3BhY2UgQVBJcz8KClBhb2xvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
