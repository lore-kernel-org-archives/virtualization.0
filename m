Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A094C7EE25
	for <virtualization@archiver.kernel.org>; Thu,  8 Jun 2023 09:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E0E8839A4;
	Thu,  8 Jun 2023 09:00:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E0E8839A4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QyK6Wq2Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tUlzWh1E7BT9; Thu,  8 Jun 2023 09:00:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8E18C83521;
	Thu,  8 Jun 2023 09:00:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E18C83521
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63F91C0037;
	Thu,  8 Jun 2023 09:00:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13569C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 09:00:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D47ED613E7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 09:00:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D47ED613E7
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QyK6Wq2Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XCXg2iEht7lx
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 09:00:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF02160AD6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF02160AD6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 09:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686214814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mzyYfOnKsXJhWqka2GXPTRk+SfXQjoxgzRvBZSqF8t0=;
 b=QyK6Wq2ZiINiVLxIFJGNOVxTMs8hN/xD7RNi7LumkB5hAnHl8qSWpb96eLM8TgCJLGZ/nv
 0RYDp1QpJSrah0UXwI8q0J0U5ctp+LtmK3fUIbEFpe4QeovEA1g5DvtlGPC2E/bm/LzPsD
 p3hiyvWYhO4qDOWWjqRz/11Kr9/AUaE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-XcEP5zOoPrCANXFt7n7yVg-1; Thu, 08 Jun 2023 05:00:13 -0400
X-MC-Unique: XcEP5zOoPrCANXFt7n7yVg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b1a69f1442so1834031fa.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jun 2023 02:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686214811; x=1688806811;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mzyYfOnKsXJhWqka2GXPTRk+SfXQjoxgzRvBZSqF8t0=;
 b=OEEyl+egbv2qOlAqocijfh6oYKtxvqw7amfzxDEDZxdqEiSAJscxt7DVeLCTRaANCW
 v0uGZB79hXjX2DcAEpTb4DbrdSw9Bmz/QaJ8kApst+Q2PpT1jxCaPUYjlGbOmiFkco8x
 keV/2bzgl3IUyYWuCYzIR6khiwj9vN80CcsZzvbe1GwiyPbM/OKEnB4CMhbTNqoPisxs
 /luemDEHa9qq9LPlwdCqfSg1anPwdIqzikjL4gQwUbo6tfo21z6+Tg36q5fla7VXnOm4
 O+6t3nDWYI6kYrPgWXnO+cM3MznY6xYWbpnAPISgWTF7kuZITegyQZQ1g5KbPh0lZVKM
 5nPg==
X-Gm-Message-State: AC+VfDz4kVrYt5uTOGxwpIHHBFug6Qj2yOYEtxuazj+l6TMAKZpQ/23e
 WUeakT1zu5oPnVFuY9my3Wu1vNUFwstznX7xfwtDkiOO4Nx3JvVNq293e/E9sX71E557lHbeslL
 TcKLNPbjZEWKGL3h+K948C2IoGq4ua018Vz94zlFr9PDXKn1e6rK/ZI5Vkw==
X-Received: by 2002:a2e:9d92:0:b0:2b1:d5d0:f164 with SMTP id
 c18-20020a2e9d92000000b002b1d5d0f164mr2990817ljj.13.1686214811727; 
 Thu, 08 Jun 2023 02:00:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ42dp9oFqMNjmtk9ygZJuGKFls2xB2ZcerVr0s54Zb6HoT4b2b1dnhsynIrpNgW2uczqKVvzmVSMmlHN19CWwE=
X-Received: by 2002:a2e:9d92:0:b0:2b1:d5d0:f164 with SMTP id
 c18-20020a2e9d92000000b002b1d5d0f164mr2990804ljj.13.1686214811397; Thu, 08
 Jun 2023 02:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
 <20230605095404-mutt-send-email-mst@kernel.org>
 <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
 <CACGkMEu3PqQ99UoKF5NHgVADD3q=BF6jhLiyumeT4S1QCqN1tw@mail.gmail.com>
 <20230606085643-mutt-send-email-mst@kernel.org>
 <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
 <20230607054246-mutt-send-email-mst@kernel.org>
 <CACGkMEuUapKvUYiJiLwtsN+x941jafDKS9tuSkiNrvkrrSmQkg@mail.gmail.com>
 <20230608020111-mutt-send-email-mst@kernel.org>
 <CACGkMEt4=3BRVNX38AD+mJU8v3bmqO-CdNj5NkFP-SSvsuy2Hg@mail.gmail.com>
 <5giudxjp6siucr4l3i4tggrh2dpqiqhhihmdd34w3mq2pm5dlo@mrqpbwckpxai>
In-Reply-To: <5giudxjp6siucr4l3i4tggrh2dpqiqhhihmdd34w3mq2pm5dlo@mrqpbwckpxai>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Jun 2023 17:00:00 +0800
Message-ID: <CACGkMEtqn1dbrQZn3i-W_7sVikY4sQjwLRC5xAhMnyqkc3jwOw@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
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

T24gVGh1LCBKdW4gOCwgMjAyMyBhdCA0OjAw4oCvUE0gU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2Fy
emFyZUByZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgSnVuIDA4LCAyMDIzIGF0IDAzOjQ2
OjAwUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4KPiBbLi4uXQo+Cj4gPj4gPiA+ID4gPiBJ
IGhhdmUgYSBxdWVzdGlvbiB0aG91Z2gsIHdoYXQgaWYgZG93biB0aGUgcm9hZCB0aGVyZQo+ID4+
ID4gPiA+ID4gaXMgYSBuZXcgZmVhdHVyZSB0aGF0IG5lZWRzIG1vcmUgY2hhbmdlcz8gSXQgd2ls
bCBiZQo+ID4+ID4gPiA+ID4gYnJva2VuIHRvbyBqdXN0IGxpa2UgUEFDS0VEIG5vPwo+ID4+ID4g
PiA+ID4gU2hvdWxkbid0IHZkcGEgaGF2ZSBhbiBhbGxvd2xpc3Qgb2YgZmVhdHVyZXMgaXQga25v
d3MgaG93Cj4gPj4gPiA+ID4gPiB0byBzdXBwb3J0Pwo+ID4+ID4gPiA+Cj4gPj4gPiA+ID4gSXQg
bG9va3MgbGlrZSB3ZSBoYWQgaXQsIGJ1dCB3ZSB0b29rIGl0IG91dCAoYnkgdGhlIHdheSwgd2Ug
d2VyZQo+ID4+ID4gPiA+IGVuYWJsaW5nIHBhY2tlZCBldmVuIHRob3VnaCB3ZSBkaWRuJ3Qgc3Vw
cG9ydCBpdCk6Cj4gPj4gPiA+ID4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9NjIzNGY4MDU3NGQ3NTY5
NDQ0ZDg3MTgzNTVmYTI4MzhlOTJiMTU4Ygo+ID4+ID4gPiA+Cj4gPj4gPiA+ID4gVGhlIG9ubHkg
cHJvYmxlbSBJIHNlZSBpcyB0aGF0IGZvciBlYWNoIG5ldyBmZWF0dXJlIHdlIGhhdmUgdG8gbW9k
aWZ5Cj4gPj4gPiA+ID4gdGhlIGtlcm5lbC4KPiA+PiA+ID4gPiBDb3VsZCB3ZSBoYXZlIG5ldyBm
ZWF0dXJlcyB0aGF0IGRvbid0IHJlcXVpcmUgaGFuZGxpbmcgYnkgdmhvc3QtdmRwYT8KPiA+PiA+
ID4gPgo+ID4+ID4gPiA+IFRoYW5rcywKPiA+PiA+ID4gPiBTdGVmYW5vCj4gPj4gPiA+Cj4gPj4g
PiA+IEphc29uIHdoYXQgZG8geW91IHNheSB0byByZXZlcnRpbmcgdGhpcz8KPiA+PiA+Cj4gPj4g
PiBJIG1heSBtaXNzIHNvbWV0aGluZyBidXQgSSBkb24ndCBzZWUgYW55IHByb2JsZW0gd2l0aCB2
RFBBIGNvcmUuCj4gPj4gPgo+ID4+ID4gSXQncyB0aGUgZHV0eSBvZiB0aGUgcGFyZW50cyB0byBh
ZHZlcnRpc2UgdGhlIGZlYXR1cmVzIGl0IGhhcy4gRm9yIGV4YW1wbGUsCj4gPj4gPgo+ID4+ID4g
MSkgSWYgc29tZSBrZXJuZWwgdmVyc2lvbiB0aGF0IGlzIHBhY2tlZCBpcyBub3Qgc3VwcG9ydGVk
IHZpYQo+ID4+ID4gc2V0X3ZxX3N0YXRlLCBwYXJlbnRzIHNob3VsZCBub3QgYWR2ZXJ0aXNlIFBB
Q0tFRCBmZWF0dXJlcyBpbiB0aGlzCj4gPj4gPiBjYXNlLgo+ID4+ID4gMikgSWYgdGhlIGtlcm5l
bCBoYXMgc3VwcG9ydCBwYWNrZWQgc2V0X3ZxX3N0YXRlKCksIGJ1dCBpdCdzIGVtdWxhdGVkCj4g
Pj4gPiBjdnEgZG9lc24ndCBzdXBwb3J0LCBwYXJlbnRzIHNob3VsZCBub3QgYWR2ZXJ0aXNlIFBB
Q0tFRCBhcyB3ZWxsCj4gPj4gPgo+ID4+ID4gSWYgYSBwYXJlbnQgdmlvbGF0ZXMgdGhlIGFib3Zl
IDIsIGl0IGxvb2tzIGxpa2UgYSBidWcgb2YgdGhlIHBhcmVudHMuCj4gPj4gPgo+ID4+ID4gVGhh
bmtzCj4gPj4KPiA+PiBZZXMgYnV0IHdoYXQgYWJvdXQgdmhvc3RfdmRwYT8gVGFsa2luZyBhYm91
dCB0aGF0IG5vdCB0aGUgY29yZS4KPiA+Cj4gPk5vdCBzdXJlIGl0J3MgYSBnb29kIGlkZWEgdG8g
d29ya2Fyb3VuZCBwYXJlbnQgYnVncyB2aWEgdmhvc3QtdkRQQS4KPgo+IFNvcnJ5LCBJJ20gZ2V0
dGluZyBsb3N0Li4uCj4gV2Ugd2VyZSB0YWxraW5nIGFib3V0IHRoZSBmYWN0IHRoYXQgdmhvc3Qt
dmRwYSBkb2Vzbid0IGhhbmRsZQo+IFNFVF9WUklOR19CQVNFL0dFVF9WUklOR19CQVNFIGlvY3Rs
cyB3ZWxsIGZvciBwYWNrZWQgdmlydHF1ZXVlIGJlZm9yZQo+IHRoYXQgc2VyaWVzIFsxXSwgbm8/
Cj4KPiBUaGUgcGFyZW50cyBzZWVtIG9rYXksIGJ1dCBtYXliZSBJIG1pc3NlZCBhIGZldyB0aGlu
Z3MuCj4KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdmlydHVhbGl6YXRpb24vMjAyMzA0
MjQyMjUwMzEuMTg5NDctMS1zaGFubm9uLm5lbHNvbkBhbWQuY29tLwoKWWVzLCBtb3JlIGJlbG93
LgoKPgo+ID4KPiA+PiBTaG91bGQgdGhhdCBub3QgaGF2ZSBhIHdoaXRlbGlzdCBvZiBmZWF0dXJl
cwo+ID4+IHNpbmNlIGl0IGludGVycHJldHMgaW9jdGxzIGRpZmZlcmVudGx5IGRlcGVuZGluZyBv
biB0aGlzPwo+ID4KPiA+SWYgdGhlcmUncyBhIGJ1ZywgaXQgbWlnaHQgb25seSBtYXR0ZXIgdGhl
IGZvbGxvd2luZyBzZXR1cDoKPiA+Cj4gPlNFVF9WUklOR19CQVNFL0dFVF9WUklOR19CQVNFICsg
VkRVU0UuCj4gPgo+ID5UaGlzIHNlZW1zIHRvIGJlIGJyb2tlbiBzaW5jZSBWRFVTRSB3YXMgaW50
cm9kdWNlZC4gSWYgd2UgcmVhbGx5IHdhbnQKPiA+dG8gYmFja3BvcnQgc29tZXRoaW5nLCBpdCBj
b3VsZCBiZSBhIGZpeCB0byBmaWx0ZXIgb3V0IFBBQ0tFRCBpbgo+ID5WRFVTRT8KPgo+IG1tbSBp
dCBkb2Vzbid0IHNlZW0gdG8gYmUgYSBwcm9ibGVtIGluIFZEVVNFLCBidXQgaW4gdmhvc3QtdmRw
YS4KPiBJIHRoaW5rIFZEVVNFIHdvcmtzIGZpbmUgd2l0aCBwYWNrZWQgdmlydHF1ZXVlIHVzaW5n
IHZpcnRpby12ZHBhCj4gKEkgaGF2ZW4ndCB0cmllZCksIHNvIHdoeSBzaG91bGQgd2UgZmlsdGVy
IFBBQ0tFRCBpbiBWRFVTRT8KCkkgZG9uJ3QgdGhpbmsgd2UgbmVlZCBhbnkgZmlsdGVyaW5nIHNp
bmNlOgoKUEFDS0VEIGZlYXR1cmVzIGhhcyBiZWVuIGFkdmVydGlzZWQgdG8gdXNlcnNwYWNlIHZp
YSB1QVBJIHNpbmNlCjYyMzRmODA1NzRkNzU2OTQ0NGQ4NzE4MzU1ZmEyODM4ZTkyYjE1OGIuIE9u
Y2Ugd2UgcmVsYXggaW4gdUFQSSwgaXQKd291bGQgYmUgdmVyeSBoYXJkIHRvIHJlc3RyaWN0IGl0
IGFnYWluLiBGb3IgdGhlIHVzZXJzcGFjZSB0aGF0IHRyaWVzCnRvIG5lZ290aWF0ZSBQQUNLRUQ6
CgoxKSBpZiBpdCBkb2Vzbid0IHVzZSBTRVRfVlJJTkdfQkFTRS9HRVRfVlJJTkdfQkFTRSwgZXZl
cnl0aGluZyB3b3JrcyB3ZWxsCjIpIGlmIGl0IHVzZXMgU0VUX1ZSSU5HX0JBU0UvR0VUX1ZSSU5H
X0JBU0UuIGl0IG1pZ2h0IGZhaWwgb3IgYnJlYWsgc2lsZW50bHkKCklmIHdlIGJhY2twb3J0IHRo
ZSBmaXhlcyB0byAtc3RhYmxlLCB3ZSBtYXkgYnJlYWsgdGhlIGFwcGxpY2F0aW9uIGF0CmxlYXN0
IGluIHRoZSBjYXNlIDEpLgoKVGhhbmtzCgo+Cj4gVGhhbmtzLAo+IFN0ZWZhbm8KPgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
