Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE54C433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 04:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 121314188E;
	Thu, 28 Apr 2022 04:13:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RGrCDPiI1bkR; Thu, 28 Apr 2022 04:13:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ED6A5417AA;
	Thu, 28 Apr 2022 04:13:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C30C5C0039;
	Thu, 28 Apr 2022 04:13:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5EEAC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 04:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BFD2741868
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 04:13:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jk2DWsBXURKx
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 04:13:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 26F97417AA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 04:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651119187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZVZ9sUaSJWjUHSw9f04r5KVucc3jL3AUKVcKmJ3NAL4=;
 b=gb5jY+Ym8EF118m8FTpRasmS/5X9SKaLWlLdPE6D9tLSxMvA+0SK/zU4gSevgnHnG87zvD
 fweMDROl8x4bp0txHV1e/k8+z7a5a+rk3Sd/LV3/esnFhiTAnRtN1UWzjI61IMO2VRawom
 Iq+fOScV2HJe3fZnGKzahepQUWcPYBw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-h-KqcrD-P0exsc-aLqj3Ng-1; Thu, 28 Apr 2022 00:13:05 -0400
X-MC-Unique: h-KqcrD-P0exsc-aLqj3Ng-1
Received: by mail-wr1-f72.google.com with SMTP id
 h61-20020adf9043000000b002079bbaa5d3so1413993wrh.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 21:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ZVZ9sUaSJWjUHSw9f04r5KVucc3jL3AUKVcKmJ3NAL4=;
 b=LajpwXhajJ6Lq+AugyQegGQ2Z3tFv/8qA0zU/0HkVhSDkgqEUqtSZELssLyW/P237F
 Sg+HaCE/NQ9YSOD08R1w5sEwzm1qPoGjgDyFxEYHN4A9fDG4jRjn4YkxdIsAS5T+kete
 y0hD2fdfXE5pnPMOjp03PQ+quQsGvYUK7f3F9dVZXQdLRk/HIiGzOHedP9axkDu3GeoD
 vRqoq1IqyyQmFwqRGnVGxu9lFI/UXe7aQoELS5Phi4lV4LIU4zVnc8I1PUx2c7n9HiXr
 JyYKtEWZaH9j3+l+2ymh8gG6D8ldD1w3EeuTp5PcXu4hskTz73vMfqa0fz7tywe43mqb
 2aQw==
X-Gm-Message-State: AOAM533BykiXC35iRi3u3G1bmnXB49jkZqE+i/jibJQz0Ohpkd2egR/1
 TjStHCcOZZ2skWqDdYnMPPyJSYkWBd6+dK+zJvWUOk9Bz/yOOEu5P9QLT2s3M7r4Lz7GlF81LTj
 T54mAMQrh7it6fDHOd2k9pktL7+fxcvAd80vyQeLSsQ==
X-Received: by 2002:adf:ed05:0:b0:20a:f2ce:d751 with SMTP id
 a5-20020adfed05000000b0020af2ced751mr3382061wro.515.1651119184118; 
 Wed, 27 Apr 2022 21:13:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx916KYb7PiWtad59cylkJTg5tmthcpImGSNLGfOqocrPqE+hsRsFMdJbnz0W3wzYtGgvFY3A==
X-Received: by 2002:adf:ed05:0:b0:20a:f2ce:d751 with SMTP id
 a5-20020adfed05000000b0020af2ced751mr3382047wro.515.1651119183898; 
 Wed, 27 Apr 2022 21:13:03 -0700 (PDT)
Received: from redhat.com ([2.53.18.16]) by smtp.gmail.com with ESMTPSA id
 j8-20020a05600c190800b00393e80a7970sm3029021wmq.7.2022.04.27.21.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Apr 2022 21:12:59 -0700 (PDT)
Date: Thu, 28 Apr 2022 00:12:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220428001142-mutt-send-email-mst@kernel.org>
References: <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <87o80n7soq.fsf@redhat.com>
 <20220426124243-mutt-send-email-mst@kernel.org>
 <87ilqu7u6w.fsf@redhat.com>
 <20220428044315.3945e660.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20220428044315.3945e660.pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: paulmck@kernel.org, lulu@redhat.com, peterz@infradead.org, maz@kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 tglx@linutronix.de
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

T24gVGh1LCBBcHIgMjgsIDIwMjIgYXQgMDQ6NDM6MTVBTSArMDIwMCwgSGFsaWwgUGFzaWMgd3Jv
dGU6Cj4gT24gV2VkLCAyNyBBcHIgMjAyMiAxMToyNzowMyArMDIwMAo+IENvcm5lbGlhIEh1Y2sg
PGNvaHVja0ByZWRoYXQuY29tPiB3cm90ZToKPiAKPiA+IE9uIFR1ZSwgQXByIDI2IDIwMjIsICJN
aWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiAKPiA+ID4gT24g
VHVlLCBBcHIgMjYsIDIwMjIgYXQgMDU6NDc6MTdQTSArMDIwMCwgQ29ybmVsaWEgSHVjayB3cm90
ZTogIAo+ID4gPj4gT24gTW9uLCBBcHIgMjUgMjAyMiwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1z
dEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4+ICAgCj4gPiA+PiA+IE9uIE1vbiwgQXByIDI1LCAy
MDIyIGF0IDExOjUzOjI0UE0gLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZTogIAo+ID4g
Pj4gPj4gT24gVHVlLCBBcHIgMjYsIDIwMjIgYXQgMTE6NDI6NDVBTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZTogIAo+ID4gPj4gPj4gPiAKPiA+ID4+ID4+ID4g5ZyoIDIwMjIvNC8yNiAxMTozOCwg
TWljaGFlbCBTLiBUc2lya2luIOWGmemBkzogIAo+ID4gPj4gPj4gPiA+IE9uIE1vbiwgQXByIDI1
LCAyMDIyIGF0IDExOjM1OjQxUE0gLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZTogIAo+
ID4gPj4gPj4gPiA+ID4gT24gVHVlLCBBcHIgMjYsIDIwMjIgYXQgMDQ6Mjk6MTFBTSArMDIwMCwg
SGFsaWwgUGFzaWMgd3JvdGU6ICAKPiA+ID4+ID4+ID4gPiA+ID4gT24gTW9uLCAyNSBBcHIgMjAy
MiAwOTo1OTo1NSAtMDQwMAo+ID4gPj4gPj4gPiA+ID4gPiAiTWljaGFlbCBTLiBUc2lya2luIiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPj4gPj4gPiA+ID4gPiAgIAo+ID4gPj4gPj4gPiA+
ID4gPiA+IE9uIE1vbiwgQXByIDI1LCAyMDIyIGF0IDEwOjU0OjI0QU0gKzAyMDAsIENvcm5lbGlh
IEh1Y2sgd3JvdGU6ICAKPiA+ID4+ID4+ID4gPiA+ID4gPiA+IE9uIE1vbiwgQXByIDI1IDIwMjIs
ICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6ICAKPiA+ID4+ID4+
ID4gPiA+ID4gPiA+ID4gT24gTW9uLCBBcHIgMjUsIDIwMjIgYXQgMTA6NDQ6MTVBTSArMDgwMCwg
SmFzb24gV2FuZyB3cm90ZTogIAo+ID4gPj4gPj4gPiA+ID4gPiA+ID4gPiA+IFRoaXMgcGF0Y2gg
dHJpZXMgdG8gaW1wbGVtZW50IHRoZSBzeW5jaHJvbml6ZV9jYnMoKSBmb3IgY2N3LiBGb3IgdGhl
Cj4gPiA+PiA+PiA+ID4gPiA+ID4gPiA+ID4gdnJpbmdfaW50ZXJydXB0KCkgdGhhdCBpcyBjYWxs
ZWQgdmlhIHZpcnRpb19haXJxX2hhbmRsZXIoKSwgdGhlCj4gPiA+PiA+PiA+ID4gPiA+ID4gPiA+
ID4gc3luY2hyb25pemF0aW9uIGlzIHNpbXBseSBkb25lIHZpYSB0aGUgYWlycV9pbmZvJ3MgbG9j
ay4gRm9yIHRoZQo+ID4gPj4gPj4gPiA+ID4gPiA+ID4gPiA+IHZyaW5nX2ludGVycnVwdCgpIHRo
YXQgaXMgY2FsbGVkIHZpYSB2aXJ0aW9fY2N3X2ludF9oYW5kbGVyKCksIGEgcGVyCj4gPiA+PiA+
PiA+ID4gPiA+ID4gPiA+ID4gZGV2aWNlIHNwaW5sb2NrIGZvciBpcnEgaXMgaW50cm9kdWNlZCBh
bnMgdXNlZCBpbiB0aGUgc3luY2hyb25pemF0aW9uCj4gPiA+PiA+PiA+ID4gPiA+ID4gPiA+ID4g
bWV0aG9kLgo+ID4gPj4gPj4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPj4gPj4gPiA+ID4gPiA+ID4g
PiA+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4KPiA+ID4+ID4+ID4g
PiA+ID4gPiA+ID4gPiBDYzogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPgo+
ID4gPj4gPj4gPiA+ID4gPiA+ID4gPiA+IENjOiAiUGF1bCBFLiBNY0tlbm5leSIgPHBhdWxtY2tA
a2VybmVsLm9yZz4KPiA+ID4+ID4+ID4gPiA+ID4gPiA+ID4gPiBDYzogTWFyYyBaeW5naWVyIDxt
YXpAa2VybmVsLm9yZz4KPiA+ID4+ID4+ID4gPiA+ID4gPiA+ID4gPiBDYzogSGFsaWwgUGFzaWMg
PHBhc2ljQGxpbnV4LmlibS5jb20+Cj4gPiA+PiA+PiA+ID4gPiA+ID4gPiA+ID4gQ2M6IENvcm5l
bGlhIEh1Y2sgPGNvaHVja0ByZWRoYXQuY29tPgo+ID4gPj4gPj4gPiA+ID4gPiA+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+ICAKPiA+ID4+ID4+
ID4gPiA+ID4gPiA+ID4gCj4gPiA+PiA+PiA+ID4gPiA+ID4gPiA+IFRoaXMgaXMgdGhlIG9ubHkg
b25lIHRoYXQgaXMgZ2l2aW5nIG1lIHBhdXNlLiBIYWxpbCwgQ29ybmVsaWEsCj4gPiA+PiA+PiA+
ID4gPiA+ID4gPiA+IHNob3VsZCB3ZSBiZSBjb25jZXJuZWQgYWJvdXQgdGhlIHBlcmZvcm1hbmNl
IGltcGFjdCBoZXJlPwo+ID4gPj4gPj4gPiA+ID4gPiA+ID4gPiBBbnkgY2hhbmNlIGl0IGNhbiBi
ZSB0ZXN0ZWQ/ICAKPiA+ID4+ID4+ID4gPiA+ID4gPiA+IFdlIGNhbiBoYXZlIGEgYnVuY2ggb2Yg
ZGV2aWNlcyB1c2luZyB0aGUgc2FtZSBhaXJxIHN0cnVjdHVyZSwgYW5kIHRoZQo+ID4gPj4gPj4g
PiA+ID4gPiA+ID4gc3luYyBjYiBjcmVhdGVzIGEgY2hva2UgcG9pbnQsIHNhbWUgYXMgcmVnaXN0
ZXJpbmcvdW5yZWdpc3RlcmluZy4gIAo+ID4gPj4gPj4gPiA+ID4gPiA+IEJUVyBjYW4gY2FsbGJh
Y2tzIGZvciBtdWx0aXBsZSBWUXMgcnVuIG9uIG11bHRpcGxlIENQVXMgYXQgdGhlIG1vbWVudD8g
IAo+ID4gPj4gPj4gPiA+ID4gPiBJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5kIHRoZSBxdWVzdGlv
bi4KPiA+ID4+ID4+ID4gPiA+ID4gCj4gPiA+PiA+PiA+ID4gPiA+IEkgZG8gdGhpbmsgd2UgY2Fu
IGhhdmUgbXVsdGlwbGUgQ1BVcyB0aGF0IGFyZSBleGVjdXRpbmcgc29tZSBwb3J0aW9uIG9mCj4g
PiA+PiA+PiA+ID4gPiA+IHZpcnRpb19jY3dfaW50X2hhbmRsZXIoKS4gU28gSSBndWVzcyB0aGUg
YW5zd2VyIGlzIHllcy4gQ29ubmllIHdoYXQgZG8geW91IHRoaW5rPwo+ID4gPj4gPj4gPiA+ID4g
PiAKPiA+ID4+ID4+ID4gPiA+ID4gT24gdGhlIG90aGVyIGhhbmQgd2UgY291bGQgYWxzbyBlbmQg
dXAgc2VyaWFsaXppbmcgc3luY2hyb25pemVfY2JzKCkKPiA+ID4+ID4+ID4gPiA+ID4gY2FsbHMg
Zm9yIGRpZmZlcmVudCBkZXZpY2VzIGlmIHRoZXkgaGFwcGVuIHRvIHVzZSB0aGUgc2FtZSBhaXJx
X2luZm8uIEJ1dAo+ID4gPj4gPj4gPiA+ID4gPiB0aGlzIHByb2JhYmx5IHdhcyBub3QgeW91ciBx
dWVzdGlvbiAgCj4gPiA+PiA+PiA+ID4gPiAKPiA+ID4+ID4+ID4gPiA+IEkgYW0gbGVzcyBjb25j
ZXJuZWQgYWJvdXQgIHN5bmNocm9uaXplX2NicyBiZWluZyBzbG93IGFuZCBtb3JlIGFib3V0Cj4g
PiA+PiA+PiA+ID4gPiB0aGUgc2xvd2Rvd24gaW4gaW50ZXJydXB0IHByb2Nlc3NpbmcgaXRzZWxm
Lgo+ID4gPj4gPj4gPiA+ID4gICAKPiA+ID4+ID4+ID4gPiA+ID4gPiB0aGlzIHBhdGNoIHNlcmlh
bGl6ZXMgdGhlbSBvbiBhIHNwaW5sb2NrLgo+ID4gPj4gPj4gPiA+ID4gPiA+ICAgCj4gPiA+PiA+
PiA+ID4gPiA+IFRob3NlIGNvdWxkIHRoZW4gcGlsZSB1cCBvbiB0aGUgbmV3bHkgaW50cm9kdWNl
ZCBzcGlubG9jay4gIAo+ID4gPj4gCj4gPiA+PiBIb3cgYmFkIHdvdWxkIHRoYXQgYmUgaW4gcHJh
Y3RpY2U/IElJVUMsIHdlIGhpdCBvbiB0aGUgc3BpbmxvY2sgd2hlbgo+ID4gPj4gLSBkb2luZyBz
eW5jaHJvbml6ZV9jYnMgKHNob3VsZCBiZSByYXJlKQo+ID4gPj4gLSBwcm9jZXNzaW5nIHF1ZXVl
IGludGVycnVwdHMgZm9yIGRldmljZXMgdXNpbmcgcGVyLWRldmljZSBpbmRpY2F0b3JzCj4gPiA+
PiAgICh3aGljaCBpcyB0aGUgbm9uLXByZWZlcnJlZCBwYXRoLCB3aGljaCBJIHdvdWxkIGJhc2lj
YWxseSBvbmx5IGV4cGVjdAo+ID4gPj4gICB3aGVuIHJ1bm5pbmcgb24gYW4gYW5jaWVudCBvciBu
b24tc3RhbmRhcmQgaHlwZXJ2aXNvcikgIAo+ID4gPgo+ID4gPiB0aGlzIG9uZSBpcyBteSBjb25j
ZXJuLiBJIGFtIHdvcnJpZWQgc2VyaWFsaXppbmcgZXZlcnl0aGluZyBvbiBhIHNpbmdsZSBsb2Nr
Cj4gPiA+IHdpbGwgZHJhc3RpY2FsbHkgcmVncmVzcyBwZXJmb3JtYW5jZSBoZXJlLiAgCj4gPiAK
PiA+IFllYWgsIHRoYXQgY2FzZSBjb3VsZCBnZXQgbXVjaCB3b3JzZS4gT1RPSCwgaG93IGxpa2Vs
eSBpcyBpdCB0aGF0IGFueQo+ID4gc2V0dXAgdGhhdCBydW5zIGEgcmVjZW50IGtlcm5lbCB3aWxs
IGFjdHVhbGx5IGVuZCB1cCB3aXRoIGRldmljZXMgdXNpbmcKPiA+IHBlci1kZXZpY2UgaW5kaWNh
dG9ycz8gQW55dGhpbmcgcnVubmluZyB1bmRlciBhIFFFTVUgcmVsZWFzZWQgaW4gdGhlCj4gPiBs
YXN0IGNvdXBsZSBvZiB5ZWFycyBpcyB1bmxpa2VseSB0byBub3QgdXNlIGFpcnFzLCBJIHRoaW5r
LiBIYWxpbCwgZG8KPiA+IHlvdSB0aGluayB0aGF0IHRoZSBjbGFzc2ljIGluZGljYXRvciBzZXR1
cCB3b3VsZCBiZSBtb3JlIGNvbW1vbiBvbiBhbnkKPiA+IG5vbi1RRU1VIGh5cGVydmlzb3JzPwo+
ID4gCj4gCj4gSSByZWFsbHkgZG9uJ3Qga25vdy4gTXkgb3BpbmlvbiBpcyB0aGF0LCB0d28gc3Rh
Z2VzIGluZGljYXRvcnMgYXJlIGtpbmQKPiBvZiByZWNvbW1lbmRlZCBmb3IgYW55Ym9keSB3aG8g
Y2FyZXMgYWJvdXQgbm90aWZpY2F0aW9ucyBwZXJmb3JtYW5jZS4KPiAKPiA+IElPVywgaG93IG11
Y2ggZWZmb3J0IGlzIGl0IHdvcnRoIHNwZW5kaW5nIG9uIG9wdGltaXppbmcgdGhpcyBjYXNlPyBX
ZQo+ID4gY2VydGFpbmx5IHNob3VsZCBleHBsb3JlIGFueSBzaW1wbGUgc29sdXRpb25zLCBidXQg
SSBkb24ndCB0aGluayB3ZSBuZWVkCj4gPiB0byB0d2lzdCBvdXJzZWx2ZXMgaW50byBwcmV0emVs
cyB0byBzb2x2ZSBpdC4KPiA+IAo+IAo+IEZyYW5rbHksIEkgd291bGQgYmUgZmluZSB3aXRoIGFu
IHJ3bG9jayBiYXNlZCBzb2x1dGlvbiBhcyBwcm9wb3NlZCBieQo+IEphc29uLiBNeSByYXRpb25h
bGUgaXM6IHdlIHJlY29tbWVuZCB0d28gc3RhZ2UgaW5kaWNhdG9ycywgYW5kIHRoZSB0d28KPiBz
dGFnZSBpbmRpY2F0b3JzIGFyZSBhbHJlYWR5IGVuY3VtYmVyZWQgYnkgYW4gcndsb2NrIG9uIHRo
ZSBpbnRlcnJ1cHQKPiBwYXRoLgoKV2hpY2ggbG9jayBpcyBpdD8gQ2FuIHdlIHRha2UgdGhhdCBs
b2NrIHRvIHN5bmNocm9uaXplPwoKPiBZZXMsIHRoZSBjb2FsZXNjZW5jZSBvZiBhZGFwdGVyIGlu
dGVycnVwdHMgaXMgYXJjaGl0ZWN0dXJhbGx5Cj4gZGlmZmVyZW50LCBhbmQgc28gaXQgaXMgd2l0
aCBHSVNBICh3aXRob3V0IEdJU0EsIEknbSBub3QgZXZlbiBzdXJlKSwgc28KPiB0aGlzIHJ3bG9j
ayBlbmQgdXAgYmVpbmcgd29yc2UgdGhhbiB0aGUgb25lIGZvciAyIHN0YWdlLiBCdXQgbXkgZmVl
bGluZwo+IGlzLCB0aGF0IGl0IHNob3VsZCBiZSBmaW5lLiBPbiB0aGUgb3RoZXIgaGFuZCwgSSBk
b24ndCBmZWVsIGNvbWZvcnRhYmxlCj4gd2l0aCBwbGFpbiBzcGlubG9jaywgYW5kIEkgYW0gY3Vy
aW91cyBhYm91dCBhIG1vcmUgYWR2YW5jZWQgc29sdXRpb24uCj4gQnV0IG15IGd1ZXNzIGlzIHRo
YXQgcndsb2NrICsgc29tZSB0ZXN0aW5nIGZvciB0aGUgbGVnYWN5IGluZGljYXRvciBjYXNlCj4g
anVzdCB0byBkb3VibGUgY2hlY2sgaWYgdGhlcmUgaXMgYSBoZWF2eSByZWdyZXNzaW9uIGRlc3Bp
dGUgb2Ygb3VyCj4gZXhwZWN0YXRpb25zIHRvIHNlZSBub25lIHNob3VsZCBkbyB0aGUgdHJpY2su
Cj4gCj4gUmVnYXJkcywKPiBIYWxpbAoKTWFrZXMgc2Vuc2UuCgo+ID4gPgo+ID4gPiAgCj4gPiA+
PiAtIGNvbmZpZ3VyYXRpb24gY2hhbmdlIGludGVycnVwdHMgKHNob3VsZCBiZSByYXJlKQo+ID4g
Pj4gLSBkdXJpbmcgc2V0dXAsIHJlc2V0LCBldGMuIChzaG91bGQgbm90IGJlIGEgY29uY2Vybikg
IAo+ID4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
