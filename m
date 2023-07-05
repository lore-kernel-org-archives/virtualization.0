Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6614BEB64DD
	for <virtualization@archiver.kernel.org>; Wed,  5 Jul 2023 08:42:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DE0EC40A9F;
	Wed,  5 Jul 2023 08:42:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE0EC40A9F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XJPA9ZmH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y4sC4767v1da; Wed,  5 Jul 2023 08:42:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5152040526;
	Wed,  5 Jul 2023 08:42:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5152040526
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2210DC0072;
	Wed,  5 Jul 2023 08:42:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB823C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 08:42:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C305240ACD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 08:42:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C305240ACD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id erQzLWYbKwn2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 08:42:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ABEFC40A1C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ABEFC40A1C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 08:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688546529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zOQW6ytwkNKpldl4Gwcyl0hiPfFRDq2NpyrhoTMoIf4=;
 b=XJPA9ZmH8A4eOi+qx/ffqpXuYjw8dTZ44lUMl00odgT/yz0V/Y7CFgoWhXFqld+91+meqp
 rD2T0XaFmNvD7lMf4Q6m8IQtV3gbglAa2zzdjEX+4jFLl8dpHuA+MbHdGy3VrVShgRhmVG
 sz4K1IQPIklkmdzR9DhLTo05jx4cUG0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-KMjEFHPHPqaQYq-d4wYusA-1; Wed, 05 Jul 2023 04:42:08 -0400
X-MC-Unique: KMjEFHPHPqaQYq-d4wYusA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fb89482cd6so6436601e87.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Jul 2023 01:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688546527; x=1691138527;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zOQW6ytwkNKpldl4Gwcyl0hiPfFRDq2NpyrhoTMoIf4=;
 b=ejIjLNvvYzGP13awIlq9PkP15LgBFY08Hjj4mb1rcP2Lh8Onlo0Z4XpkWvxn4RhzFg
 L/mx60k/b0JUITnAQZGKXNLshUpUo9d4astBKaGNAb6nW3oksrTrGlta19eAYr24Jn5c
 s2+jLyvqxk+PfE8sP8R2UKVeE+aG1orgdcZ6yB8tz6tUa+dhuH83nOPFF2Jo9Ibgxq4c
 E+ML1rb5dNASwhMC3XXZ67p+P9l5tHhYRsJxljQHeM8c/EvC8jZZMFDw6XVQsJM5d7Pc
 AI8mwElIPtJsUjstRFdUJS7EmgAJCwlcof/MpQA2ghN2+PDvspM28vBvviA74pV1xvML
 wkQw==
X-Gm-Message-State: ABy/qLZTGxMAuLTY95LQSv9kjfZBQuqksU7lQwHdHsAdWpmY/X0O4n1C
 Qj1tq+siUQIOYWTlsTmeyzEvx8lqLNXyLrn7A6GwHRxGZWOxmzG7ulL/qjujmqcE+FsHE2aVAIo
 WANOb5piVt5FZQPaJfAuwvsN0NHyPY5gh/CuNAQr+Tw==
X-Received: by 2002:a05:6512:3b9c:b0:4f8:5960:49a9 with SMTP id
 g28-20020a0565123b9c00b004f8596049a9mr14003104lfv.23.1688546527016; 
 Wed, 05 Jul 2023 01:42:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG/H5pfmSsFn72wPJaF6gCY5W2vcZpPs+es/4FECw46OZpiDrini6ap0HCP3FDgbIRy+g5z/A==
X-Received: by 2002:a05:6512:3b9c:b0:4f8:5960:49a9 with SMTP id
 g28-20020a0565123b9c00b004f8596049a9mr14003085lfv.23.1688546526663; 
 Wed, 05 Jul 2023 01:42:06 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 p23-20020a1c7417000000b003fbb5506e54sm1460129wmc.29.2023.07.05.01.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 01:42:06 -0700 (PDT)
Date: Wed, 5 Jul 2023 04:42:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does
 not support it
Message-ID: <20230705044151-mutt-send-email-mst@kernel.org>
References: <20230703142218.362549-1-eperezma@redhat.com>
 <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org>
 <CACGkMEvT4Y+-wfhyi324Y5hhAtn+ZF7cP9d=omdH-ZgdJ-4SOQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvT4Y+-wfhyi324Y5hhAtn+ZF7cP9d=omdH-ZgdJ-4SOQ@mail.gmail.com>
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

T24gV2VkLCBKdWwgMDUsIDIwMjMgYXQgMDM6NTU6MjNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUdWUsIEp1bCA0LCAyMDIzIGF0IDY6MzjigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBUdWUsIEp1bCAwNCwgMjAyMyBhdCAx
MjoyNTozMlBNICswMjAwLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3cm90ZToKPiA+ID4gT24gTW9u
LCBKdWwgMywgMjAyMyBhdCA0OjUy4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiBPbiBNb24sIEp1bCAwMywgMjAyMyBhdCAwNDoy
MjoxOFBNICswMjAwLCBFdWdlbmlvIFDDqXJleiB3cm90ZToKPiA+ID4gPiA+IFdpdGggdGhlIGN1
cnJlbnQgY29kZSBpdCBpcyBhY2NlcHRlZCBhcyBsb25nIGFzIHVzZXJsYW5kIHNlbmQgaXQuCj4g
PiA+ID4gPgo+ID4gPiA+ID4gQWx0aG91Z2ggdXNlcmxhbmQgc2hvdWxkIG5vdCBzZXQgYSBmZWF0
dXJlIGZsYWcgdGhhdCBoYXMgbm90IGJlZW4KPiA+ID4gPiA+IG9mZmVyZWQgdG8gaXQgd2l0aCBW
SE9TVF9HRVRfQkFDS0VORF9GRUFUVVJFUywgdGhlIGN1cnJlbnQgY29kZSB3aWxsIG5vdAo+ID4g
PiA+ID4gY29tcGxhaW4gZm9yIGl0Lgo+ID4gPiA+ID4KPiA+ID4gPiA+IFNpbmNlIHRoZXJlIGlz
IG5vIHNwZWNpZmljIHJlYXNvbiBmb3IgYW55IHBhcmVudCB0byByZWplY3QgdGhhdCBiYWNrZW5k
Cj4gPiA+ID4gPiBmZWF0dXJlIGJpdCB3aGVuIGl0IGhhcyBiZWVuIHByb3Bvc2VkLCBsZXQncyBj
b250cm9sIGl0IGF0IHZkcGEgZnJvbnRlbmQKPiA+ID4gPiA+IGxldmVsLiBGdXR1cmUgcGF0Y2hl
cyBtYXkgbW92ZSB0aGlzIGNvbnRyb2wgdG8gdGhlIHBhcmVudCBkcml2ZXIuCj4gPiA+ID4gPgo+
ID4gPiA+ID4gRml4ZXM6IDk2NzgwMGQyZDUyZSAoInZkcGE6IGFjY2VwdCBWSE9TVF9CQUNLRU5E
X0ZfRU5BQkxFX0FGVEVSX0RSSVZFUl9PSyBiYWNrZW5kIGZlYXR1cmUiKQo+ID4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gPiA+ID4K
PiA+ID4gPiBQbGVhc2UgZG8gc2VuZCB2My4gQW5kIGFnYWluLCBJIGRvbid0IHdhbnQgdG8gc2Vu
ZCAiYWZ0ZXIgZHJpdmVyIG9rIiBoYWNrCj4gPiA+ID4gdXBzdHJlYW0gYXQgYWxsLCBJIG1lcmdl
ZCBpdCBpbiBuZXh0IGp1c3QgdG8gZ2l2ZSBpdCBzb21lIHRlc3RpbmcuCj4gPiA+ID4gV2Ugd2Fu
dCBSSU5HX0FDQ0VTU19BRlRFUl9LSUNLIG9yIHNvbWUgc3VjaC4KPiA+ID4gPgo+ID4gPgo+ID4g
PiBDdXJyZW50IGRldmljZXMgZG8gbm90IHN1cHBvcnQgdGhhdCBzZW1hbnRpYy4KPiA+Cj4gPiBX
aGljaCBkZXZpY2VzIHNwZWNpZmljYWxseSBhY2Nlc3MgdGhlIHJpbmcgYWZ0ZXIgRFJJVkVSX09L
IGJ1dCBiZWZvcmUKPiA+IGEga2ljaz8KPiAKPiBWaG9zdC1uZXQgaXMgb25lIGV4YW1wbGUgYXQg
bGFzdC4gSXQgcG9sbHMgYSBzb2NrZXQgYXMgd2VsbCwgc28gaXQKPiBzdGFydHMgdG8gYWNjZXNz
IHRoZSByaW5nIGltbWVkaWF0ZWx5IGFmdGVyIERSSVZFUl9PSy4KPiAKPiBUaGFua3MKCgpGb3Ig
c3VyZSBidXQgdGhhdCBpcyBub3QgdmRwYS4KCj4gPgo+ID4gPiBNeSBwbGFuIHdhcyB0byBjb252
ZXJ0Cj4gPiA+IGl0IGluIHZwX3ZkcGEgaWYgbmVlZGVkLCBhbmQgcmV1c2UgdGhlIGN1cnJlbnQg
dmRwYSBvcHMuIFNvcnJ5IGlmIEkKPiA+ID4gd2FzIG5vdCBleHBsaWNpdCBlbm91Z2guCj4gPiA+
Cj4gPiA+IFRoZSBvbmx5IHNvbHV0aW9uIEkgY2FuIHNlZSB0byB0aGF0IGlzIHRvIHRyYXAgJiBl
bXVsYXRlIGluIHRoZSB2ZHBhCj4gPiA+IChwYXJlbnQ/KSBkcml2ZXIsIGFzIHRhbGtlZCBpbiB2
aXJ0aW8tY29tbWVudC4gQnV0IHRoYXQgY29tcGxpY2F0ZXMKPiA+ID4gdGhlIGFyY2hpdGVjdHVy
ZToKPiA+ID4gKiBPZmZlciBWSE9TVF9CQUNLRU5EX0ZfUklOR19BQ0NFU1NfQUZURVJfS0lDSwo+
ID4gPiAqIFN0b3JlIHZxIGVuYWJsZSBzdGF0ZSBzZXBhcmF0ZWx5LCBhdAo+ID4gPiB2ZHBhLT5j
b25maWctPnNldF92cV9yZWFkeSh0cnVlKSwgYnV0IG5vdCB0cmFuc21pdCB0aGF0IGVuYWJsZSB0
byBodwo+ID4gPiAqIFN0b3JlIHRoZSBkb29yYmVsbCBzdGF0ZSBzZXBhcmF0ZWx5LCBidXQgZG8g
bm90IGNvbmZpZ3VyZSBpdCB0byB0aGUKPiA+ID4gZGV2aWNlIGRpcmVjdGx5Lgo+ID4gPgo+ID4g
PiBCdXQgaG93IHRvIHJlY292ZXIgaWYgdGhlIGRldmljZSBjYW5ub3QgY29uZmlndXJlIHRoZW0g
YXQga2ljayB0aW1lLAo+ID4gPiBmb3IgZXhhbXBsZT8KPiA+ID4KPiA+ID4gTWF5YmUgd2UgY2Fu
IGp1c3QgZmFpbCBpZiB0aGUgcGFyZW50IGRyaXZlciBkb2VzIG5vdCBzdXBwb3J0IGVuYWJsaW5n
Cj4gPiA+IHRoZSB2cSBhZnRlciBEUklWRVJfT0s/IFRoYXQgd2F5IG5vIG5ldyBmZWF0dXJlIGZs
YWcgaXMgbmVlZGVkLgo+ID4gPgo+ID4gPiBUaGFua3MhCj4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+
IC0tLQo+ID4gPiA+ID4gU2VudCB3aXRoIEZpeGVzOiB0YWcgcG9pbnRpbmcgdG8gZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21zdAo+ID4gPiA+ID4gY29tbWl0LiBQbGVh
c2UgbGV0IG1lIGtub3cgaWYgSSBzaG91bGQgc2VuZCBhIHYzIG9mIFsxXSBpbnN0ZWFkLgo+ID4g
PiA+ID4KPiA+ID4gPiA+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMwNjA5
MTIxMjQ0LW11dHQtc2VuZC1lbWFpbC1tc3RAa2VybmVsLm9yZy9ULwo+ID4gPiA+ID4gLS0tCj4g
PiA+ID4gPiAgZHJpdmVycy92aG9zdC92ZHBhLmMgfCA3ICsrKysrLS0KPiA+ID4gPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4gPiA+ID4KPiA+
ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jCj4gPiA+ID4gPiBpbmRleCBlMWFiZjI5ZmVkNWIuLmE3ZTU1NDM1MjM1MSAxMDA2NDQK
PiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPiA+ID4gPiArKysgYi9kcml2
ZXJzL3Zob3N0L3ZkcGEuYwo+ID4gPiA+ID4gQEAgLTY4MSwxOCArNjgxLDIxIEBAIHN0YXRpYyBs
b25nIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGVwLAo+ID4gPiA+
ID4gIHsKPiA+ID4gPiA+ICAgICAgIHN0cnVjdCB2aG9zdF92ZHBhICp2ID0gZmlsZXAtPnByaXZh
dGVfZGF0YTsKPiA+ID4gPiA+ICAgICAgIHN0cnVjdCB2aG9zdF9kZXYgKmQgPSAmdi0+dmRldjsK
PiA+ID4gPiA+ICsgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHYtPnZk
cGEtPmNvbmZpZzsKPiA+ID4gPiA+ICAgICAgIHZvaWQgX191c2VyICphcmdwID0gKHZvaWQgX191
c2VyICopYXJnOwo+ID4gPiA+ID4gICAgICAgdTY0IF9fdXNlciAqZmVhdHVyZXAgPSBhcmdwOwo+
ID4gPiA+ID4gLSAgICAgdTY0IGZlYXR1cmVzOwo+ID4gPiA+ID4gKyAgICAgdTY0IGZlYXR1cmVz
LCBwYXJlbnRfZmVhdHVyZXMgPSAwOwo+ID4gPiA+ID4gICAgICAgbG9uZyByID0gMDsKPiA+ID4g
PiA+Cj4gPiA+ID4gPiAgICAgICBpZiAoY21kID09IFZIT1NUX1NFVF9CQUNLRU5EX0ZFQVRVUkVT
KSB7Cj4gPiA+ID4gPiAgICAgICAgICAgICAgIGlmIChjb3B5X2Zyb21fdXNlcigmZmVhdHVyZXMs
IGZlYXR1cmVwLCBzaXplb2YoZmVhdHVyZXMpKSkKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVGQVVMVDsKPiA+ID4gPiA+ICsgICAgICAgICAgICAgaWYgKG9wcy0+Z2V0
X2JhY2tlbmRfZmVhdHVyZXMpCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgcGFyZW50
X2ZlYXR1cmVzID0gb3BzLT5nZXRfYmFja2VuZF9mZWF0dXJlcyh2LT52ZHBhKTsKPiA+ID4gPiA+
ICAgICAgICAgICAgICAgaWYgKGZlYXR1cmVzICYgfihWSE9TVF9WRFBBX0JBQ0tFTkRfRkVBVFVS
RVMgfAo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJJVF9VTEwoVkhP
U1RfQkFDS0VORF9GX1NVU1BFTkQpIHwKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9SRVNVTUUpIHwKPiA+ID4gPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9FTkFCTEVf
QUZURVJfRFJJVkVSX09LKSkpCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcGFyZW50X2ZlYXR1cmVzKSkKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gLUVPUE5PVFNVUFA7Cj4gPiA+ID4gPiAgICAgICAgICAgICAgIGlmICgoZmVhdHVyZXMgJiBC
SVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9TVVNQRU5EKSkgJiYKPiA+ID4gPiA+ICAgICAgICAgICAg
ICAgICAgICAhdmhvc3RfdmRwYV9jYW5fc3VzcGVuZCh2KSkKPiA+ID4gPiA+IC0tCj4gPiA+ID4g
PiAyLjM5LjMKPiA+ID4gPgo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
