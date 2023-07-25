Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348D5C0015E
	for <virtualization@archiver.kernel.org>; Tue, 25 Jul 2023 07:36:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B39BD40960;
	Tue, 25 Jul 2023 07:36:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B39BD40960
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NBAoZzSX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ssj3i-C9Od6S; Tue, 25 Jul 2023 07:36:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9831C40937;
	Tue, 25 Jul 2023 07:36:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9831C40937
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68947C0071;
	Tue, 25 Jul 2023 07:36:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99012C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 07:36:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65EB0817F2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 07:36:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 65EB0817F2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NBAoZzSX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bb1O5FHvup1C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 07:36:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44EF8817BA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 07:36:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44EF8817BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690270581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4VEG98KIvt8LRb8tcIeahsb2VtaKO2Trib+565MxI7U=;
 b=NBAoZzSXiQqKhoOLB8CXUmhpEGjXuq2k5EA6cyvSYK+RKIko3uap8m7hCuZiGTQxZ+qRZc
 JZd/Xym7edPJxsJcuezhFVr2+P1jgczccCJ4PsrYL5erZ4h7NMGPQyvUvXWy4LiWvU1i5t
 tVLY6myiftTkCafekvGIv5Vh1rVirMM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-iYd_bCCIMkGxZC4lsOtxyQ-1; Tue, 25 Jul 2023 03:36:19 -0400
X-MC-Unique: iYd_bCCIMkGxZC4lsOtxyQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-993e73a4c4fso421141066b.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 00:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690270578; x=1690875378;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4VEG98KIvt8LRb8tcIeahsb2VtaKO2Trib+565MxI7U=;
 b=NG2G/suq6BQpuVdkYyR82IqBXTRf0JCH42Wt1ptt7/PjPNLy57FnrNAhhIovH1i7Wt
 usQRZ3swsBZBz9eIWuP2oTMIOybRa6JpAR6X1P27aBh7z2EvW/QccdcMFJQ0rLhvuKQq
 /5Iks5CHiLH4vZXKri/c+4gqJxbDlNq6Zg5kfreA2NlyjToubGm2bPyWWKrhCG/7s3KZ
 W9PionXRfQMWHcx1+M3z0Kn4ALXUFyB/tQVtVxpwk7sdSFE9EnPasMNkEg0zqBq9SZt1
 /ywqoUM6Dy9CyJFrzDmswudAfmJk3M6NzUlBRI/aWAQaySVVAA5fOejAaC/mFcd0J4Yv
 Xn+w==
X-Gm-Message-State: ABy/qLbhmAkIOFybePYLXONVkHIE50fRryxPjYQime+r9w4yZB/X0eOG
 /UJ4KAh9hwsPlMN/G4h6Y70hb9lJQn7MGXnWldk2HQ5FwtVMA17z3/RsXiJovEGBou+tTAVnF58
 ATpjrl+Cks3CDFihIjNrW3EKBTg0gTrw0gOxV6xPJbQ==
X-Received: by 2002:a17:907:7750:b0:992:4250:5462 with SMTP id
 kx16-20020a170907775000b0099242505462mr11927148ejc.50.1690270578556; 
 Tue, 25 Jul 2023 00:36:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEbuQ+B36ExWOmlZ5PK0JXR3LiRI6TjSV+5qKRE6dIJffKcs1oJ2j/QzHg1GhN52TQxfOi1cg==
X-Received: by 2002:a17:907:7750:b0:992:4250:5462 with SMTP id
 kx16-20020a170907775000b0099242505462mr11927135ejc.50.1690270578169; 
 Tue, 25 Jul 2023 00:36:18 -0700 (PDT)
Received: from redhat.com ([2.55.164.187]) by smtp.gmail.com with ESMTPSA id
 p26-20020a170906a01a00b00992f81122e1sm7750226ejy.21.2023.07.25.00.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 00:36:17 -0700 (PDT)
Date: Tue, 25 Jul 2023 03:36:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230725033506-mutt-send-email-mst@kernel.org>
References: <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org>
 <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, edumazet@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

T24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgMTE6MDc6NDBBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBNb24sIEp1bCAyNCwgMjAyMyBhdCAzOjE34oCvUE0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gTW9uLCBKdWwgMjQsIDIwMjMgYXQg
MDI6NTI6MDVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gT24gU2F0LCBKdWwgMjIs
IDIwMjMgYXQgNDoxOOKAr0FNIE1heGltZSBDb3F1ZWxpbgo+ID4gPiA8bWF4aW1lLmNvcXVlbGlu
QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IE9uIDcv
MjEvMjMgMTc6MTAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+IE9uIEZyaSwg
SnVsIDIxLCAyMDIzIGF0IDA0OjU4OjA0UE0gKzAyMDAsIE1heGltZSBDb3F1ZWxpbiB3cm90ZToK
PiA+ID4gPiA+Pgo+ID4gPiA+ID4+Cj4gPiA+ID4gPj4gT24gNy8yMS8yMyAxNjo0NSwgTWljaGFl
bCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+ID4+PiBPbiBGcmksIEp1bCAyMSwgMjAyMyBhdCAw
NDozNzowMFBNICswMjAwLCBNYXhpbWUgQ29xdWVsaW4gd3JvdGU6Cj4gPiA+ID4gPj4+Pgo+ID4g
PiA+ID4+Pj4KPiA+ID4gPiA+Pj4+IE9uIDcvMjAvMjMgMjM6MDIsIE1pY2hhZWwgUy4gVHNpcmtp
biB3cm90ZToKPiA+ID4gPiA+Pj4+PiBPbiBUaHUsIEp1bCAyMCwgMjAyMyBhdCAwMToyNjoyMFBN
IC0wNzAwLCBTaGFubm9uIE5lbHNvbiB3cm90ZToKPiA+ID4gPiA+Pj4+Pj4gT24gNy8yMC8yMyAx
OjM4IEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4+Pj4+Pj4KPiA+ID4gPiA+Pj4+Pj4+
IEFkZGluZyBjb25kX3Jlc2NoZWQoKSB0byB0aGUgY29tbWFuZCB3YWl0aW5nIGxvb3AgZm9yIGEg
YmV0dGVyCj4gPiA+ID4gPj4+Pj4+PiBjby1vcGVyYXRpb24gd2l0aCB0aGUgc2NoZWR1bGVyLiBU
aGlzIGFsbG93cyB0byBnaXZlIENQVSBhIGJyZWF0aCB0bwo+ID4gPiA+ID4+Pj4+Pj4gcnVuIG90
aGVyIHRhc2sod29ya3F1ZXVlKSBpbnN0ZWFkIG9mIGJ1c3kgbG9vcGluZyB3aGVuIHByZWVtcHRp
b24gaXMKPiA+ID4gPiA+Pj4+Pj4+IG5vdCBhbGxvd2VkIG9uIGEgZGV2aWNlIHdob3NlIENWUSBt
aWdodCBiZSBzbG93Lgo+ID4gPiA+ID4+Pj4+Pj4KPiA+ID4gPiA+Pj4+Pj4+IFNpZ25lZC1vZmYt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPiA+ID4gPj4+Pj4+Cj4gPiA+
ID4gPj4+Pj4+IFRoaXMgc3RpbGwgbGVhdmVzIGh1bmcgcHJvY2Vzc2VzLCBidXQgYXQgbGVhc3Qg
aXQgZG9lc24ndCBwaW4gdGhlIENQVSBhbnkKPiA+ID4gPiA+Pj4+Pj4gbW9yZS4gIFRoYW5rcy4K
PiA+ID4gPiA+Pj4+Pj4gUmV2aWV3ZWQtYnk6IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNv
bkBhbWQuY29tPgo+ID4gPiA+ID4+Pj4+Pgo+ID4gPiA+ID4+Pj4+Cj4gPiA+ID4gPj4+Pj4gSSdk
IGxpa2UgdG8gc2VlIGEgZnVsbCBzb2x1dGlvbgo+ID4gPiA+ID4+Pj4+IDEtIGJsb2NrIHVudGls
IGludGVycnVwdAo+ID4gPgo+ID4gPiBJIHJlbWVtYmVyIGluIHByZXZpb3VzIHZlcnNpb25zLCB5
b3Ugd29ycmllZCBhYm91dCB0aGUgZXh0cmEgTVNJCj4gPiA+IHZlY3Rvci4gKE1heWJlIEkgd2Fz
IHdyb25nKS4KPiA+ID4KPiA+ID4gPiA+Pj4+Cj4gPiA+ID4gPj4+PiBXb3VsZCBpdCBtYWtlIHNl
bnNlIHRvIGFsc28gaGF2ZSBhIHRpbWVvdXQ/Cj4gPiA+ID4gPj4+PiBBbmQgd2hlbiB0aW1lb3V0
IGV4cGlyZXMsIHNldCBGQUlMRUQgYml0IGluIGRldmljZSBzdGF0dXM/Cj4gPiA+ID4gPj4+Cj4g
PiA+ID4gPj4+IHZpcnRpbyBzcGVjIGRvZXMgbm90IHNldCBhbnkgbGltaXRzIG9uIHRoZSB0aW1p
bmcgb2YgdnEKPiA+ID4gPiA+Pj4gcHJvY2Vzc2luZy4KPiA+ID4gPiA+Pgo+ID4gPiA+ID4+IElu
ZGVlZCwgYnV0IEkgdGhvdWdodCB0aGUgZHJpdmVyIGNvdWxkIGRlY2lkZSBpdCBpcyB0b28gbG9u
ZyBmb3IgaXQuCj4gPiA+ID4gPj4KPiA+ID4gPiA+PiBUaGUgaXNzdWUgaXMgd2Uga2VlcCB3YWl0
aW5nIHdpdGggcnRubCBsb2NrZWQsIGl0IGNhbiBxdWlja2x5IG1ha2UgdGhlCj4gPiA+ID4gPj4g
c3lzdGVtIHVudXNhYmxlLgo+ID4gPiA+ID4KPiA+ID4gPiA+IGlmIHRoaXMgaXMgYSBwcm9ibGVt
IHdlIHNob3VsZCBmaW5kIGEgd2F5IG5vdCB0byBrZWVwIHJ0bmwKPiA+ID4gPiA+IGxvY2tlZCBp
bmRlZmluaXRlbHkuCj4gPiA+Cj4gPiA+IEFueSBpZGVhcyBvbiB0aGlzIGRpcmVjdGlvbj8gU2lt
cGx5IGRyb3BwaW5nIHJ0bmwgZHVyaW5nIHRoZSBidXN5IGxvb3AKPiA+ID4gd2lsbCByZXN1bHQg
aW4gYSBsb3Qgb2YgcmFjZXMuIFRoaXMgc2VlbXMgdG8gcmVxdWlyZSBub24tdHJpdmlhbAo+ID4g
PiBjaGFuZ2VzIGluIHRoZSBuZXR3b3JraW5nIGNvcmUuCj4gPiA+Cj4gPiA+ID4KPiA+ID4gPiAg
RnJvbSB0aGUgdGVzdHMgSSBoYXZlIGRvbmUsIEkgdGhpbmsgaXQgaXMuIFdpdGggT1ZTLCBhIHJl
Y29uZmlndXJhdGlvbgo+ID4gPiA+IGlzIHBlcmZvcm1lZCB3aGVuIHRoZSBWRFVTRSBkZXZpY2Ug
aXMgYWRkZWQsIGFuZCB3aGVuIGEgTUxYNSBkZXZpY2UgaXMKPiA+ID4gPiBpbiB0aGUgc2FtZSBi
cmlkZ2UsIGl0IGVuZHMgdXAgZG9pbmcgYW4gaW9jdGwoKSB0aGF0IHRyaWVzIHRvIHRha2UgdGhl
Cj4gPiA+ID4gcnRubCBsb2NrLiBJbiB0aGlzIGNvbmZpZ3VyYXRpb24sIGl0IGlzIG5vdCBwb3Nz
aWJsZSB0byBraWxsIE9WUyBiZWNhdXNlCj4gPiA+ID4gaXQgaXMgc3R1Y2sgdHJ5aW5nIHRvIGFj
cXVpcmUgcnRubCBsb2NrIGZvciBtbHg1IHRoYXQgaXMgaGVsZCBieSB2aXJ0aW8tCj4gPiA+ID4g
bmV0Lgo+ID4gPgo+ID4gPiBZZWFoLCBiYXNpY2FsbHksIGFueSBSVE5MIHVzZXJzIHdvdWxkIGJl
IGJsb2NrZWQgZm9yZXZlci4KPiA+ID4KPiA+ID4gQW5kIHRoZSBpbmZpbml0ZSBsb29wIGhhcyBv
dGhlciBzaWRlIGVmZmVjdHMgbGlrZSBpdCBibG9ja3MgdGhlIGZyZWV6ZXIgdG8gd29yay4KPiA+
ID4KPiA+ID4gVG8gc3VtbWFyaXplLCB0aGVyZSBhcmUgdGhyZWUgaXNzdWVzCj4gPiA+Cj4gPiA+
IDEpIGJ1c3kgcG9sbGluZwo+ID4gPiAyKSBicmVha3MgZnJlZXplcgo+ID4gPiAzKSBob2xkIFJU
TkwgZHVyaW5nIHRoZSBsb29wCj4gPiA+Cj4gPiA+IFNvbHZpbmcgMyBtYXkgaGVscCBzb21laG93
IGZvciAyIGUuZyBzb21lIHBtIHJvdXRpbmUgZS5nIHdpcmVndWFyZCBvcgo+ID4gPiBldmVuIHZp
cnRuZXRfcmVzdG9yZSgpIGl0c2VsZiBtYXkgdHJ5IHRvIGhvbGQgdGhlIGxvY2suCj4gPgo+ID4g
WWVwLiBTbyBteSBmZWVsaW5nIGN1cnJlbnRseSBpcywgdGhlIG9ubHkgcmVhbCBmaXggaXMgdG8g
YWN0dWFsbHkKPiA+IHF1ZXVlIHVwIHRoZSB3b3JrIGluIHNvZnR3YXJlLgo+IAo+IERvIHlvdSBt
ZWFuIHNvbWV0aGluZyBsaWtlOgo+IAo+IHJ0bmxfbG9jaygpOwo+IHF1ZXVlIHVwIHRoZSB3b3Jr
Cj4gcnRubF91bmxvY2soKTsKPiByZXR1cm4gc3VjY2VzczsKPiAKPiA/Cgp5ZXMKCgo+ID4gSXQn
cyBtb3N0bHkgdHJpdmlhbCB0byBsaW1pdAo+ID4gbWVtb3J5IGNvbnN1bXB0aW9uLCB2aWQncyBp
cyB0aGUKPiA+IG9ubHkgb25lIHdoZXJlIGl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8gaGF2ZSBtb3Jl
IHRoYW4KPiA+IDEgY29tbWFuZCBvZiBhIGdpdmVuIHR5cGUgb3V0c3RhbmRpbmcuCj4gCj4gQW5k
IHJ4IG1vZGUgc28gdGhpcyBpbXBsaWVzIHdlIHdpbGwgZmFpbCBhbnkgY29tbWFuZCBpZiB0aGUg
cHJldmlvdXMKPiB3b3JrIGlzIG5vdCBmaW5pc2hlZC4KCmRvbid0IGZhaWwgaXQsIHN0b3JlIGl0
LgoKPiA+IGhhdmUgYSB0cmVlCj4gPiBvciBhIGJpdG1hcCB3aXRoIHZpZHMgdG8gYWRkL3JlbW92
ZT8KPiAKPiBQcm9iYWJseS4KPiAKPiBUaGFua3MKPiAKPiA+Cj4gPgo+ID4KPiA+ID4gPgo+ID4g
PiA+ID4KPiA+ID4gPiA+Pj4+PiAyLSBzdGlsbCBoYW5kbGUgc3VycHJpc2UgcmVtb3ZhbCBjb3Jy
ZWN0bHkgYnkgd2FraW5nIGluIHRoYXQgY2FzZQo+ID4gPgo+ID4gPiBUaGlzIGlzIGJhc2ljYWxs
eSB3aGF0IHZlcnNpb24gMSBkaWQ/Cj4gPiA+Cj4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xrbWwvNjAyNmU4MDEtNmZkYS1mZWU5LWE2OWItZDA2YTgwMzY4NjIxQHJlZGhhdC5jb20vdC8K
PiA+ID4KPiA+ID4gVGhhbmtzCj4gPgo+ID4gWWVzIC0gZXhjZXB0IHRoZSB0aW1lb3V0IHBhcnQu
Cj4gPgo+ID4KPiA+ID4gPiA+Pj4+Pgo+ID4gPiA+ID4+Pj4+Cj4gPiA+ID4gPj4+Pj4KPiA+ID4g
PiA+Pj4+Pj4+IC0tLQo+ID4gPiA+ID4+Pj4+Pj4gICAgICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMgfCA0ICsrKy0KPiA+ID4gPiA+Pj4+Pj4+ICAgICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4gPiA+ID4+Pj4+Pj4KPiA+ID4gPiA+Pj4+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMKPiA+ID4gPiA+Pj4+Pj4+IGluZGV4IDlmM2IxZDZhYzMzZC4uZTc1MzNmMjliMjE5IDEw
MDY0NAo+ID4gPiA+ID4+Pj4+Pj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+
ID4gPj4+Pj4+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+Pj4+Pj4+
IEBAIC0yMzE0LDggKzIzMTQsMTAgQEAgc3RhdGljIGJvb2wgdmlydG5ldF9zZW5kX2NvbW1hbmQo
c3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIHU4IGNsYXNzLCB1OCBjbWQsCj4gPiA+ID4gPj4+Pj4+
PiAgICAgICAgICAgICAgKiBpbnRvIHRoZSBoeXBlcnZpc29yLCBzbyB0aGUgcmVxdWVzdCBzaG91
bGQgYmUgaGFuZGxlZCBpbW1lZGlhdGVseS4KPiA+ID4gPiA+Pj4+Pj4+ICAgICAgICAgICAgICAq
Lwo+ID4gPiA+ID4+Pj4+Pj4gICAgICAgICAgICAgd2hpbGUgKCF2aXJ0cXVldWVfZ2V0X2J1Zih2
aS0+Y3ZxLCAmdG1wKSAmJgo+ID4gPiA+ID4+Pj4+Pj4gLSAgICAgICAgICAgICAgIXZpcnRxdWV1
ZV9pc19icm9rZW4odmktPmN2cSkpCj4gPiA+ID4gPj4+Pj4+PiArICAgICAgICAgICAgICAhdmly
dHF1ZXVlX2lzX2Jyb2tlbih2aS0+Y3ZxKSkgewo+ID4gPiA+ID4+Pj4+Pj4gKyAgICAgICAgICAg
ICAgIGNvbmRfcmVzY2hlZCgpOwo+ID4gPiA+ID4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICBj
cHVfcmVsYXgoKTsKPiA+ID4gPiA+Pj4+Pj4+ICsgICAgICAgfQo+ID4gPiA+ID4+Pj4+Pj4KPiA+
ID4gPiA+Pj4+Pj4+ICAgICAgICAgICAgIHJldHVybiB2aS0+Y3RybC0+c3RhdHVzID09IFZJUlRJ
T19ORVRfT0s7Cj4gPiA+ID4gPj4+Pj4+PiAgICAgIH0KPiA+ID4gPiA+Pj4+Pj4+IC0tCj4gPiA+
ID4gPj4+Pj4+PiAyLjM5LjMKPiA+ID4gPiA+Pj4+Pj4+Cj4gPiA+ID4gPj4+Pj4+PiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4gPiA+ID4+Pj4+Pj4g
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0Cj4gPiA+ID4gPj4+Pj4+PiBWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+ID4gPiA+ID4+Pj4+Pj4gaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24KPiA+
ID4gPiA+Pj4+Pgo+ID4gPiA+ID4+Pgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
