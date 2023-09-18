Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4E1C46CA1
	for <virtualization@archiver.kernel.org>; Mon, 18 Sep 2023 11:26:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E0E01405EB;
	Mon, 18 Sep 2023 11:26:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E0E01405EB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=etbvnY8F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qnZJ7XXGwAFI; Mon, 18 Sep 2023 11:26:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 68E2540590;
	Mon, 18 Sep 2023 11:26:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68E2540590
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E682C0071;
	Mon, 18 Sep 2023 11:26:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A080DC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 11:26:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D3DF812F1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 11:26:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D3DF812F1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=etbvnY8F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eBL6-gG_K8y7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 11:26:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E55E181DEE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 11:26:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E55E181DEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695036402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJ7BoBZN9LUb0RT6bjzaqnZSnRVm8LvjKIFfYqfKexU=;
 b=etbvnY8FBHFA+pJOltS/NjX0z3GasxWiCJwK4Sqqg9sjW7uRCoFc+5b3sHJOohAA4TNV4a
 +AgHTxsMUGNUxrqx48uJxB/pS2fpy0a4iyeX/pkb5Cb9QIBFKO3m3hOOeOov8h8mFA45WT
 1Umqfo6D3ueCAT3Q+Zc30S+oXsS9bVc=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-CzYW2iO4PEKdpTa6t9m9Gw-1; Mon, 18 Sep 2023 07:26:41 -0400
X-MC-Unique: CzYW2iO4PEKdpTa6t9m9Gw-1
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-496a6ccaa8aso181703e0c.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 04:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695036401; x=1695641201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WJ7BoBZN9LUb0RT6bjzaqnZSnRVm8LvjKIFfYqfKexU=;
 b=p4QOAMV1iZxgg//EFA5TMl3tDfqrxodJDUGgetGtbGa8QYmwiZEVB51ygPQmta7nOG
 8WNxTgNchSjGRWQ/XhycbD/6B7YM5TBHZZ4764imw5P/mbRCh7F9p7Dv5ihPLHXJCx3B
 F18kxVuwRjc6YcM2RVBnOPTJ2ih1PRdqVVWbqD8GhKQ+HmDomDiYvVpHcWt6+Jb4b8LW
 c80/UrzUjEmWPO/H1PJ4czp5I5Fsa/NsHssv1KBp8VdIRyMiP3tjzR4I3hRrQWB+S/Gx
 Zx6rSGj4hC46bV9SO5UHljYmmQ0XaPpV3ppQD36fBIP0WWzNn9L+ozdYEz7r91zTFkqe
 LP4g==
X-Gm-Message-State: AOJu0YwcFVXkrPbvzsK7kYc9X7hdmEr4QsrzJtWNj6YPm5re/6Qq80Dq
 llSboInXujAw5Ilcc0yoz+DPVkrwajqxG4uwcZZOi7p8LVmvqxACOqm84Et3jE+xJlDnI746iNu
 RgIYadfu+WSCoHkTWWl9mWVVFZVjwcS4QWMc1TMUOnic5SWfAE00OkeXExg==
X-Received: by 2002:a05:6102:ecc:b0:452:7601:e80b with SMTP id
 m12-20020a0561020ecc00b004527601e80bmr737485vst.35.1695036400821; 
 Mon, 18 Sep 2023 04:26:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNCWcywyIXv7Y3LrOm5D3fU8hdQ+F+t/4dVoHOizyxfivsLUDxqoZ/xj2wSTnbF1jJNQB1+fQQQsN8kBq0PAA=
X-Received: by 2002:a05:6102:ecc:b0:452:7601:e80b with SMTP id
 m12-20020a0561020ecc00b004527601e80bmr737475vst.35.1695036400586; Mon, 18 Sep
 2023 04:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <ZQHPeD0fds9sYzHO@pc-79.home>
 <CABgObfbXsHN6=ZmL0s+mtCypXs11LNECECO3Uud_J6PMr+JwNA@mail.gmail.com>
 <ZQgwzAgIdjyWn5nE@fedora>
In-Reply-To: <ZQgwzAgIdjyWn5nE@fedora>
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Date: Mon, 18 Sep 2023 13:26:29 +0200
Message-ID: <CAHYGQ0w5OUcBL+wPxn7uR6TvB1AUs=fcwRvRxtUOZikKk18byg@mail.gmail.com>
Subject: Re: [virtio-comment] virtio-sound linux driver conformance to spec
To: Paolo Bonzini <pbonzini@redhat.com>
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

T24gTW9uLCBTZXAgMTgsIDIwMjMgYXQgMToxM+KAr1BNIE1hdGlhcyBFemVxdWllbCBWYXJhIExh
cnNlbgo8bXZhcmFsYXJAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIFNlcCAxMywgMjAy
MyBhdCAwNTo1MDo0OFBNICswMjAwLCBQYW9sbyBCb256aW5pIHdyb3RlOgo+ID4gT24gV2VkLCBT
ZXAgMTMsIDIwMjMgYXQgNTowNeKAr1BNIE1hdGlhcyBFemVxdWllbCBWYXJhIExhcnNlbgo+ID4g
PG12YXJhbGFyQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBIZWxsbywKPiA+ID4KPiA+
ID4gVGhpcyBlbWFpbCBpcyB0byByZXBvcnQgYSBiZWhhdmlvciBvZiB0aGUgTGludXggdmlydGlv
LXNvdW5kIGRyaXZlciB0aGF0Cj4gPiA+IGxvb2tzIGxpa2UgaXQgaXMgbm90IGNvbmZvcm1pbmcg
dG8gdGhlIFZpcnRJTyBzcGVjaWZpY2F0aW9uLiBUaGUga2VybmVsCj4gPiA+IGRyaXZlciBpcyBt
b3ZpbmcgYnVmZmVycyBmcm9tIHRoZSB1c2VkIHJpbmcgdG8gdGhlIGF2YWlsYWJsZSByaW5nCj4g
PiA+IHdpdGhvdXQga25vd2luZyBpZiB0aGUgY29udGVudCBoYXMgYmVlbiB1cGRhdGVkIGZyb20g
dGhlIHVzZXIuIElmIHRoZQo+ID4gPiBkZXZpY2UgcGlja3MgdXAgYnVmZmVycyBmcm9tIHRoZSBh
dmFpbGFibGUgcmluZyBqdXN0IGFmdGVyIGl0IGlzCj4gPiA+IG5vdGlmaWVkLCBpdCBoYXBwZW5z
IHRoYXQgdGhlIGNvbnRlbnQgaXMgb2xkLiBUaGlzIHByb2JsZW0gY2FuIGJlIGZpeGVkCj4gPiA+
IGJ5IHdhaXRpbmcgYSBwZXJpb2Qgb2YgdGltZSBhZnRlciB0aGUgZGV2aWNlIGRlcXVldWVzIGEg
YnVmZmVyIGZyb20gdGhlCj4gPiA+IGF2YWlsYWJsZSByaW5nLiBUaGUgZHJpdmVyIHNob3VsZCBu
b3QgYmUgYWxsb3dlZCB0byBjaGFuZ2UgdGhlIGNvbnRlbnQKPiA+ID4gb2YgYSBidWZmZXIgaW4g
dGhlIGF2YWlsYWJsZSByaW5nLiBXaGVuIGJ1ZmZlcnMgYXJlIGVucXVldWVkIGluIHRoZQo+ID4g
PiBhdmFpbGFibGUgcmluZywgdGhlIGRldmljZSBjYW4gY29uc3VtZSB0aGVtIGltbWVkaWF0ZWx5
Lgo+ID4gPgo+ID4gPiAxLiBJcyB0aGUgYWN0dWFsIGRyaXZlciBpbXBsZW1lbnRhdGlvbiBmb2xs
b3dpbmcgdGhlIHNwZWM/Cj4gPgo+ID4gSWYgSSB1bmRlcnN0YW5kIHRoZSBpc3N1ZSBjb3JyZWN0
bHksIGl0J3Mgbm90LiBBcyB5b3Ugc2F5LCBhYnNlbnQgYW55Cj4gPiBjbGFyaWZpY2F0aW9uIGEg
YnVmZmVyIHRoYXQgaGFzIGJlZW4gcGxhY2VkIGluIHRoZSBhdmFpbGFibGUgcmluZwo+ID4gc2hv
dWxkIGJlIHVubW9kaWZpYWJsZTsgdGhlIGRyaXZlciBzaG91bGQgb3BlcmF0ZSBhcyBpZiB0aGUg
ZGF0YSBpbgo+ID4gdGhlIGF2YWlsYWJsZSByaW5nIGlzIGNvcGllZCB0byBhbiBpbnRlcm5hbCBi
dWZmZXIgaW5zdGFudGx5IHdoZW4gdGhlCj4gPiBidWZmZXIgaWQgaXMgYWRkZWQgdG8gdGhlIHJp
bmcuCj4gPgo+ID4gSSBhbSBhc3N1bWluZyB0aGlzIGlzIGEgcGxheWJhY2sgYnVmZmVyLiBUbyBj
bGFyaWZ5LCBkb2VzIHRoZSBkcml2ZXIKPiA+IGV4cGVjdCBidWZmZXJzIHRvIGJlIHJlYWQgb25s
eSBhcyBuZWVkZWQsIHdoaWNoIGlzIGEgZnJhY3Rpb24gb2YgYQo+ID4gc2Vjb25kIGJlZm9yZSB0
aGUgZGF0YSBpcyBwbGF5ZWQgYmFjaz8KPiA+Cj4gVGhlIGRyaXZlciBleHBlY3RzIHRoYXQgZGV2
aWNlIHRvIHJlYWQgYnVmZmVycyBhIGZyYWN0aW9uIG9mIGEgc2Vjb25kCj4gYmVmb3JlIHBsYXlp
bmcgdGhlbSBiYWNrLiBJZiB0aGUgZGV2aWNlIHJlYWRzIGl0IGp1c3Qgd2hlbiB0aGV5IGFyZQo+
IGV4cG9zZWQgaW4gdGhlIGF2YWlsYWJsZSByaW5nLCB0aGUgY29udGVudCBpcyBvbGQuIFRoZSBk
ZXZpY2UgaGFzIHRvCj4gcmVhZCBpdCBqdXN0IHdoZW4gdGhlIGF1ZGlvIGVuZ2luZSBpcyBnb2lu
ZyB0byBjb25zdW1lIGl0Lgo+Cj4gPiA+IDIuIFNoYWxsIHRoZSBzcGVjIGJlIGV4dGVuZGVkIHRv
IHN1cHBvcnQgc3VjaCBhIHVzZS1jYXNlPwo+ID4KPiA+IElmIGl0IHBsYWNlcyBOIGJ1ZmZlcnMs
IEkgdGhpbmsgaXQncyBhIHJlYXNvbmFibGUgZXhwZWN0YXRpb24gKGZvciB0aGUKPiA+IHNvdW5k
IGRldmljZSBvbmx5ISkgdGhhdCB0aGUgTnRoIGlzbid0IHJlYWQgdW50aWwgdGhlIChOLTEpdGgg
aGFzCj4gPiBzdGFydGVkIHBsYXlpbmcuIFdpdGggdHdvIGJ1ZmZlcnMgb25seSwgdGhlIGJlaGF2
aW9yIHlvdSBzcGVjaWZ5IHdvdWxkCj4gPiBub3QgYmUgcGVybWlzc2libGUgKGJlY2F1c2UgYXMg
c29vbiBhcyBidWZmZXIgMSBzdGFydHMgcGxheWluZywgdGhlCj4gPiBkZXZpY2UgY2FuIHJlYWQg
YnVmZmVyIDI7IHRoZXJlIGlzIG5ldmVyIGFuIGlkbGUgYnVmZmVyKS4gV2l0aCB0aHJlZQo+ID4g
YnVmZmVycywgeW91IGNvdWxkIHdyaXRlIGJ1ZmZlciAzIHdoaWxlIGJ1ZmZlciAxIHBsYXlzOyB3
cml0ZSBidWZmZXIgMQo+ID4gd2hpbGUgYnVmZmVyIDIgcGxheXM7IGFuZCB3cml0ZSBidWZmZXIg
MiB3aGlsZSBidWZmZXIgMyBwbGF5cy4gSXMgdGhpcwo+ID4gZW5vdWdoPwo+ID4KPiA+IFRoYXQg
c2FpZCwgYmVpbmcgcmVhc29uYWJsZSBpc24ndCBlbm91Z2ggZm9yIHZpcnRpby1zb3VuZCB0byBk
byBpdCBhbmQKPiA+IGRldmlhdGUgZnJvbSBvdGhlciB2aXJ0aW8gZGV2aWNlcy4gV2h5IGRvZXMg
dGhlIExpbnV4IGRyaXZlciBiZWhhdmUKPiA+IGxpa2UgdGhpcz8gSXMgaXQgc29tZWhvdyBjb25z
dHJhaW5lZCBieSB0aGUga2VybmVsLT51c2Vyc3BhY2UgQVBJcz8KPiA+Cj4gQUZBSVUsIHRoZSBk
cml2ZXIgc2VuZHMgZm91ciByZXF1ZXN0cyBiZWZvcmUgc3RhcnRpbmcgcGxheWluZywgZS5nLiwK
PiBhcGxheSAnRnJvbnRMZWZ0LndhdicsIGVhY2ggd2l0aCBQRVJJT0RfU0laRSBieXRlcy4gUEVS
SU9EX1NJWkUgaXMKPiBuZWdvdGlhdGVkIGJldHdlZW4gdGhlIGRldmljZSBhbmQgdGhlIGRyaXZl
ciBiZWZvcmUgcGxheWJhY2sgYmVnaW5zLgo+IFRoZSByZXF1ZXN0cyBhcmUgc3BsaXQgaW50byBt
dWx0aXBsZSBidWZmZXJzLiAgQWZ0ZXIgYSBQRVJJT0RfU0laRSBpcwo+IHBsYXllZCwgdGhlIGRl
dmljZSBub3RpZmllcyB0aGUgZ3Vlc3QuICBUaGVzZSBidWZmZXJzIGFyZSBwYXJ0IG9mIGEgcmlu
Zwo+IGJ1ZmZlciBzaGFyZWQgd2l0aCB0aGUgdXNlciBhcHBsaWNhdGlvbi4KCkkgbWVhbiB0aGUg
dXNlciBhcHBsaWNhdGlvbiBpbiB0aGUgZ3Vlc3QuCgo+IFRoZSBkZXZpY2UganVzdCBwaWNrcyB0
aGUgbGFzdAo+IHVzZWQgc2V0IG9mIGJ1ZmZlcnMgYW5kIGVucXVldWVzIGFnYWluIGluIHRoZSBh
dmFpbGFibGUgcmluZy4gRm9yCgpJbiB0aGlzIHNlbnRlbmNlLCBJIG1lYW4gdGhlIGRyaXZlciwg
bm90IHRoZSBkZXZpY2UuCgpNYXRpYXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
