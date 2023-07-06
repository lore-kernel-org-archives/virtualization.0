Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61CBEB64DC
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 06:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 122C6405A2;
	Thu,  6 Jul 2023 06:06:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 122C6405A2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EK6hDm2u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C08IePGDJn-p; Thu,  6 Jul 2023 06:06:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E735B40591;
	Thu,  6 Jul 2023 06:06:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E735B40591
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B613EC0072;
	Thu,  6 Jul 2023 06:06:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E306AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 06:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AEA8E400DC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 06:06:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AEA8E400DC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EK6hDm2u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sJ3uAOrTQj1b
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 06:06:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65A37400D7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 65A37400D7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 06:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688623559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7F1kuoBVvdilDrsKXZBNZrXBfxZI6rHyhY9EwQm6NA=;
 b=EK6hDm2ud2awj/rjHODTtKm1qhZVxFJ+4Vqzkpjp4fcm5THBy3/GkTR+66VV/eTi51sp1L
 s4CrVXAoPpxSTYis0vQQm8Zmnvo7dDP/7MjanYtuZ9ooGTKtVV99dwQ2gN8NxEUPno8LCD
 VBGMmcMC5vshe04felWlGGJCDF0WECk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-hMZ6e00APRqXzhZKXeKLbA-1; Thu, 06 Jul 2023 02:05:57 -0400
X-MC-Unique: hMZ6e00APRqXzhZKXeKLbA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbefe1b402so1894825e9.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Jul 2023 23:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688623556; x=1691215556;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c7F1kuoBVvdilDrsKXZBNZrXBfxZI6rHyhY9EwQm6NA=;
 b=fthF7JDsu1jJUB4FH4IqWnuQdf7yXnKrkZbPAY6NoPcpC/Uwk0z4Zdc8eePCvFArwd
 6z0qnEXMGSLRxY4keV9JFq0JFRNyoOCsYz2NuKl157pbkIMZr2uEQkJAA/pqlxHXQYgp
 w3cJ7Lp7K7mBS+86ck0vmw+vQVYIhBqhtsnEzAXJn082F3i4fQF06AUAQ2Pb6bEgOIyG
 JnltHZMBWnWXHyWxroWuH98rWDckNVm4wv29i5PQhsMM7L5Sjs4eBQV0XC1/XD1yKZe1
 X4WwagwxZS5cCGg16NyCjaYcS5i6Oy4hW3lTxIVv9nRO2fLGaWp6x7Sh2EAb00Fep/vy
 XVgA==
X-Gm-Message-State: ABy/qLbSNJ4iEEPK8GrCSC0POqsMvBDFbXfea5UO/d3Npu5/MmlAu6gG
 o0RABGKXH2uppFKoAriVD5euZv7vZXdNx0+GH1uT9DwYRVK6pP6smq7Mk4YTYBDhq+PotQF54U/
 e0BLnjxjh5+IpcIaLhrFxOGAHbdbcz41LZevuUUwO0A==
X-Received: by 2002:a7b:c7d8:0:b0:3f8:c9a4:4998 with SMTP id
 z24-20020a7bc7d8000000b003f8c9a44998mr463684wmk.28.1688623556610; 
 Wed, 05 Jul 2023 23:05:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGrouu/voEFMZNR/vXdUDZFJea9gZ8LyKhI9fqFldR83BbNhMWMgOYIuYvluurNHedhv9Ps+A==
X-Received: by 2002:a7b:c7d8:0:b0:3f8:c9a4:4998 with SMTP id
 z24-20020a7bc7d8000000b003f8c9a44998mr463673wmk.28.1688623556315; 
 Wed, 05 Jul 2023 23:05:56 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e5:9a00:6cb0:ad0c:4846:6126])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c228100b003fa8dbb7b5dsm1020276wmf.25.2023.07.05.23.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 23:05:55 -0700 (PDT)
Date: Thu, 6 Jul 2023 02:05:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does
 not support it
Message-ID: <20230706020310-mutt-send-email-mst@kernel.org>
References: <20230703142218.362549-1-eperezma@redhat.com>
 <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org>
 <CACGkMEvT4Y+-wfhyi324Y5hhAtn+ZF7cP9d=omdH-ZgdJ-4SOQ@mail.gmail.com>
 <20230705044151-mutt-send-email-mst@kernel.org>
 <CACGkMEu0MhQqNbrg9WkyGBboFU5RSqCs1W8LpksW4mO7hGxd7g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEu0MhQqNbrg9WkyGBboFU5RSqCs1W8LpksW4mO7hGxd7g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

T24gVGh1LCBKdWwgMDYsIDIwMjMgYXQgMDk6NTY6MjlBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBXZWQsIEp1bCA1LCAyMDIzIGF0IDQ6NDLigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBXZWQsIEp1bCAwNSwgMjAyMyBhdCAw
Mzo1NToyM1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiBPbiBUdWUsIEp1bCA0LCAy
MDIzIGF0IDY6MzjigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90
ZToKPiA+ID4gPgo+ID4gPiA+IE9uIFR1ZSwgSnVsIDA0LCAyMDIzIGF0IDEyOjI1OjMyUE0gKzAy
MDAsIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3RlOgo+ID4gPiA+ID4gT24gTW9uLCBKdWwgMywg
MjAyMyBhdCA0OjUy4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE9uIE1vbiwgSnVsIDAzLCAyMDIzIGF0IDA0OjIy
OjE4UE0gKzAyMDAsIEV1Z2VuaW8gUMOpcmV6IHdyb3RlOgo+ID4gPiA+ID4gPiA+IFdpdGggdGhl
IGN1cnJlbnQgY29kZSBpdCBpcyBhY2NlcHRlZCBhcyBsb25nIGFzIHVzZXJsYW5kIHNlbmQgaXQu
Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBBbHRob3VnaCB1c2VybGFuZCBzaG91bGQgbm90
IHNldCBhIGZlYXR1cmUgZmxhZyB0aGF0IGhhcyBub3QgYmVlbgo+ID4gPiA+ID4gPiA+IG9mZmVy
ZWQgdG8gaXQgd2l0aCBWSE9TVF9HRVRfQkFDS0VORF9GRUFUVVJFUywgdGhlIGN1cnJlbnQgY29k
ZSB3aWxsIG5vdAo+ID4gPiA+ID4gPiA+IGNvbXBsYWluIGZvciBpdC4KPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+IFNpbmNlIHRoZXJlIGlzIG5vIHNwZWNpZmljIHJlYXNvbiBmb3IgYW55IHBh
cmVudCB0byByZWplY3QgdGhhdCBiYWNrZW5kCj4gPiA+ID4gPiA+ID4gZmVhdHVyZSBiaXQgd2hl
biBpdCBoYXMgYmVlbiBwcm9wb3NlZCwgbGV0J3MgY29udHJvbCBpdCBhdCB2ZHBhIGZyb250ZW5k
Cj4gPiA+ID4gPiA+ID4gbGV2ZWwuIEZ1dHVyZSBwYXRjaGVzIG1heSBtb3ZlIHRoaXMgY29udHJv
bCB0byB0aGUgcGFyZW50IGRyaXZlci4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEZpeGVz
OiA5Njc4MDBkMmQ1MmUgKCJ2ZHBhOiBhY2NlcHQgVkhPU1RfQkFDS0VORF9GX0VOQUJMRV9BRlRF
Ul9EUklWRVJfT0sgYmFja2VuZCBmZWF0dXJlIikKPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gUGxlYXNlIGRvIHNlbmQgdjMuIEFuZCBhZ2FpbiwgSSBkb24ndCB3YW50IHRvIHNlbmQg
ImFmdGVyIGRyaXZlciBvayIgaGFjawo+ID4gPiA+ID4gPiB1cHN0cmVhbSBhdCBhbGwsIEkgbWVy
Z2VkIGl0IGluIG5leHQganVzdCB0byBnaXZlIGl0IHNvbWUgdGVzdGluZy4KPiA+ID4gPiA+ID4g
V2Ugd2FudCBSSU5HX0FDQ0VTU19BRlRFUl9LSUNLIG9yIHNvbWUgc3VjaC4KPiA+ID4gPiA+ID4K
PiA+ID4gPiA+Cj4gPiA+ID4gPiBDdXJyZW50IGRldmljZXMgZG8gbm90IHN1cHBvcnQgdGhhdCBz
ZW1hbnRpYy4KPiA+ID4gPgo+ID4gPiA+IFdoaWNoIGRldmljZXMgc3BlY2lmaWNhbGx5IGFjY2Vz
cyB0aGUgcmluZyBhZnRlciBEUklWRVJfT0sgYnV0IGJlZm9yZQo+ID4gPiA+IGEga2ljaz8KPiA+
ID4KPiA+ID4gVmhvc3QtbmV0IGlzIG9uZSBleGFtcGxlIGF0IGxhc3QuIEl0IHBvbGxzIGEgc29j
a2V0IGFzIHdlbGwsIHNvIGl0Cj4gPiA+IHN0YXJ0cyB0byBhY2Nlc3MgdGhlIHJpbmcgaW1tZWRp
YXRlbHkgYWZ0ZXIgRFJJVkVSX09LLgo+ID4gPgo+ID4gPiBUaGFua3MKPiA+Cj4gPgo+ID4gRm9y
IHN1cmUgYnV0IHRoYXQgaXMgbm90IHZkcGEuCj4gCj4gU29tZWhvdyB2aWEgdnBfdmRwYSB0aGF0
IEknbSB1c3VhbGx5IHRlc3RpbmcgdkRQQSBwYXRjaGVzLgo+IAo+IFRoZSBwcm9ibGVtIGlzIHRo
YXQgaXQncyB2ZXJ5IGhhcmQgdG8gYXVkaXQgYWxsIHZEUEEgZGV2aWNlcyBub3cgaWYgaXQKPiBp
cyBub3QgZGVmaW5lZCBpbiB0aGUgc3BlYyBiZWZvcmUgdGhleSBhcmUgaW52ZW50ZWQuCj4gCj4g
VGhhbmtzCgp2cF92ZHBhIGlzIGV4YWN0bHkgdGhlIHBhcnQgdGhhdCBib3RoZXJzIG1lLiBJZiBv
biB0aGUgaG9zdCBpdCBpcyBiYWNrZWQKYnkgZS5nLiB2aG9zdC11c2VyIHRoZW4gaXQgZG9lcyBu
b3Qgd29yay4gQW5kIHlvdSBkb24ndCBrbm93IHdoYXQgaXMKYmFja2luZyBpdC4KCk9UT0ggaXQg
c3VwcG9ydHMgUklOR19SRVNFVCAuLi4KClNvLCBwcm9wb3NhbDogaW5jbHVkZSBib3RoIHRoaXMg
c29sdXRpb24gYW5kIGZvciBkcml2ZXJzCnZwX3ZkcGEgdGhlIFJJTkdfUkVTRVQgdHJpY2suCgoK
SG1tPwoKCgo+ID4KPiA+ID4gPgo+ID4gPiA+ID4gTXkgcGxhbiB3YXMgdG8gY29udmVydAo+ID4g
PiA+ID4gaXQgaW4gdnBfdmRwYSBpZiBuZWVkZWQsIGFuZCByZXVzZSB0aGUgY3VycmVudCB2ZHBh
IG9wcy4gU29ycnkgaWYgSQo+ID4gPiA+ID4gd2FzIG5vdCBleHBsaWNpdCBlbm91Z2guCj4gPiA+
ID4gPgo+ID4gPiA+ID4gVGhlIG9ubHkgc29sdXRpb24gSSBjYW4gc2VlIHRvIHRoYXQgaXMgdG8g
dHJhcCAmIGVtdWxhdGUgaW4gdGhlIHZkcGEKPiA+ID4gPiA+IChwYXJlbnQ/KSBkcml2ZXIsIGFz
IHRhbGtlZCBpbiB2aXJ0aW8tY29tbWVudC4gQnV0IHRoYXQgY29tcGxpY2F0ZXMKPiA+ID4gPiA+
IHRoZSBhcmNoaXRlY3R1cmU6Cj4gPiA+ID4gPiAqIE9mZmVyIFZIT1NUX0JBQ0tFTkRfRl9SSU5H
X0FDQ0VTU19BRlRFUl9LSUNLCj4gPiA+ID4gPiAqIFN0b3JlIHZxIGVuYWJsZSBzdGF0ZSBzZXBh
cmF0ZWx5LCBhdAo+ID4gPiA+ID4gdmRwYS0+Y29uZmlnLT5zZXRfdnFfcmVhZHkodHJ1ZSksIGJ1
dCBub3QgdHJhbnNtaXQgdGhhdCBlbmFibGUgdG8gaHcKPiA+ID4gPiA+ICogU3RvcmUgdGhlIGRv
b3JiZWxsIHN0YXRlIHNlcGFyYXRlbHksIGJ1dCBkbyBub3QgY29uZmlndXJlIGl0IHRvIHRoZQo+
ID4gPiA+ID4gZGV2aWNlIGRpcmVjdGx5Lgo+ID4gPiA+ID4KPiA+ID4gPiA+IEJ1dCBob3cgdG8g
cmVjb3ZlciBpZiB0aGUgZGV2aWNlIGNhbm5vdCBjb25maWd1cmUgdGhlbSBhdCBraWNrIHRpbWUs
Cj4gPiA+ID4gPiBmb3IgZXhhbXBsZT8KPiA+ID4gPiA+Cj4gPiA+ID4gPiBNYXliZSB3ZSBjYW4g
anVzdCBmYWlsIGlmIHRoZSBwYXJlbnQgZHJpdmVyIGRvZXMgbm90IHN1cHBvcnQgZW5hYmxpbmcK
PiA+ID4gPiA+IHRoZSB2cSBhZnRlciBEUklWRVJfT0s/IFRoYXQgd2F5IG5vIG5ldyBmZWF0dXJl
IGZsYWcgaXMgbmVlZGVkLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcyEKPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+ID4gU2VudCB3aXRoIEZpeGVz
OiB0YWcgcG9pbnRpbmcgdG8gZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L21zdAo+ID4gPiA+ID4gPiA+IGNvbW1pdC4gUGxlYXNlIGxldCBtZSBrbm93IGlmIEkgc2hvdWxk
IHNlbmQgYSB2MyBvZiBbMV0gaW5zdGVhZC4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFsx
XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMwNjA5MTIxMjQ0LW11dHQtc2VuZC1l
bWFpbC1tc3RAa2VybmVsLm9yZy9ULwo+ID4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiA+ICBk
cml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDcgKysrKystLQo+ID4gPiA+ID4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9z
dC92ZHBhLmMKPiA+ID4gPiA+ID4gPiBpbmRleCBlMWFiZjI5ZmVkNWIuLmE3ZTU1NDM1MjM1MSAx
MDA2NDQKPiA+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4gPiA+ID4g
PiA+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPiA+ID4gPiA+ID4gQEAgLTY4MSwxOCAr
NjgxLDIxIEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZp
bGUgKmZpbGVwLAo+ID4gPiA+ID4gPiA+ICB7Cj4gPiA+ID4gPiA+ID4gICAgICAgc3RydWN0IHZo
b3N0X3ZkcGEgKnYgPSBmaWxlcC0+cHJpdmF0ZV9kYXRhOwo+ID4gPiA+ID4gPiA+ICAgICAgIHN0
cnVjdCB2aG9zdF9kZXYgKmQgPSAmdi0+dmRldjsKPiA+ID4gPiA+ID4gPiArICAgICBjb25zdCBz
dHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2LT52ZHBhLT5jb25maWc7Cj4gPiA+ID4gPiA+
ID4gICAgICAgdm9pZCBfX3VzZXIgKmFyZ3AgPSAodm9pZCBfX3VzZXIgKilhcmc7Cj4gPiA+ID4g
PiA+ID4gICAgICAgdTY0IF9fdXNlciAqZmVhdHVyZXAgPSBhcmdwOwo+ID4gPiA+ID4gPiA+IC0g
ICAgIHU2NCBmZWF0dXJlczsKPiA+ID4gPiA+ID4gPiArICAgICB1NjQgZmVhdHVyZXMsIHBhcmVu
dF9mZWF0dXJlcyA9IDA7Cj4gPiA+ID4gPiA+ID4gICAgICAgbG9uZyByID0gMDsKPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ICAgICAgIGlmIChjbWQgPT0gVkhPU1RfU0VUX0JBQ0tFTkRfRkVB
VFVSRVMpIHsKPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgIGlmIChjb3B5X2Zyb21fdXNlcigm
ZmVhdHVyZXMsIGZlYXR1cmVwLCBzaXplb2YoZmVhdHVyZXMpKSkKPiA+ID4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FRkFVTFQ7Cj4gPiA+ID4gPiA+ID4gKyAgICAgICAg
ICAgICBpZiAob3BzLT5nZXRfYmFja2VuZF9mZWF0dXJlcykKPiA+ID4gPiA+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgcGFyZW50X2ZlYXR1cmVzID0gb3BzLT5nZXRfYmFja2VuZF9mZWF0dXJl
cyh2LT52ZHBhKTsKPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgIGlmIChmZWF0dXJlcyAmIH4o
VkhPU1RfVkRQQV9CQUNLRU5EX0ZFQVRVUkVTIHwKPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfU1VTUEVORCkgfAo+ID4g
PiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZIT1NUX0JB
Q0tFTkRfRl9SRVNVTUUpIHwKPiA+ID4gPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfRU5BQkxFX0FGVEVSX0RSSVZFUl9PSykpKQo+
ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYXJlbnRfZmVhdHVy
ZXMpKQo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNV
UFA7Cj4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICBpZiAoKGZlYXR1cmVzICYgQklUX1VMTChW
SE9TVF9CQUNLRU5EX0ZfU1VTUEVORCkpICYmCj4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAg
ICAgICF2aG9zdF92ZHBhX2Nhbl9zdXNwZW5kKHYpKQo+ID4gPiA+ID4gPiA+IC0tCj4gPiA+ID4g
PiA+ID4gMi4zOS4zCj4gPiA+ID4gPiA+Cj4gPiA+ID4KPiA+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
