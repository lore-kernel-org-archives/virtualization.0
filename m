Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DE2C433F5
	for <virtualization@archiver.kernel.org>; Wed, 15 Dec 2021 02:06:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6F01440156;
	Wed, 15 Dec 2021 02:06:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GOjf-cZsAbhR; Wed, 15 Dec 2021 02:06:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8EDC940297;
	Wed, 15 Dec 2021 02:06:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 615F3C002F;
	Wed, 15 Dec 2021 02:06:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D21BC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 02:06:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 57CCB40198
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 02:06:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Er8luFLhwhlx
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 02:06:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E3AB140151
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 02:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639534009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QODSBQnZr+XWtKCj7HvbR7L/HGQqXDayYtaMW50HzWc=;
 b=Uf4N26HY1PRlW0uC3B6VOTKcCm76jxUexYtPX9wr71qXsO8cZqouNPD15ScziV6QS8CRZv
 ejKRyYy3fwY0hOadU7jpAMQPiwGUrUPz+todBh3gdh3Cd2EjrQJzuqiW8Ncn3c1p2/mQxu
 OTfX/dH41RM2zAqqjTxYyDB+GMhWfuw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-hCrxtTRBOLiy-ExMW77yiQ-1; Tue, 14 Dec 2021 21:06:45 -0500
X-MC-Unique: hCrxtTRBOLiy-ExMW77yiQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 a7-20020a05651c210700b00219132ab503so6301060ljq.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 18:06:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QODSBQnZr+XWtKCj7HvbR7L/HGQqXDayYtaMW50HzWc=;
 b=LmpIA+PrmqhfDZB7HUFAzGwtorTJ6SLWnlJOcbQpBtMo7jPUDmF5JHgbRyTQ5gGWeC
 mXg2HMXHGXngeKV1feE7zwUI/TCcTAGt2/nr52k1Iws38Qdn1/bDg2RFKw0K1IMAruPn
 sAbiO2t3539mlzG5QJZAeX++ykn5D4YQuvSjP8CHlePGbPn2wL8PhuMZzksIUHMB099Q
 T0OTKm9zbmDnb1nXBSCeTzUKFzhTKXZFMT78zabAgYnZrYxmLiZ0JA4guiV5wHseSp2N
 f2B9lTsPTCfB6I3CO0obYrIZIeQ8IIY8XZVVornxTtI6c2AX/lOwO+4A/PD5AFJoT4ay
 6VCw==
X-Gm-Message-State: AOAM530RuSRq88WjtcjZWd/es83eqS5qJ9K2bo6T0Mgvjy/eeZ/XbrXq
 5aJ3ZJi4769QpQ+mLf+b+oEMM/ktsYNJaHH9R6oUvA/r0saac2b/sIGr/drmj3qXDX/Y3x6wnqc
 USvnHue19EfH+Q+P3PgOIrQ29BLiAcyjlLnpjTTjHMbzn8f9MtgNeyHpccA==
X-Received: by 2002:a05:6512:2081:: with SMTP id
 t1mr7811251lfr.348.1639534004147; 
 Tue, 14 Dec 2021 18:06:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzff15JaClCTTbqBtYFgf9IWZCMooVmps6g54UP0yHgNBnA/vqyebmqQsVhhxaD7DRl0w/c2Rq+y/uDDYbGKfI=
X-Received: by 2002:a05:6512:2081:: with SMTP id
 t1mr7811221lfr.348.1639534003798; 
 Tue, 14 Dec 2021 18:06:43 -0800 (PST)
MIME-Version: 1.0
References: <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
 <20210228163031-mutt-send-email-mst@kernel.org>
 <2cb51a6d-afa0-7cd1-d6f2-6b153186eaca@redhat.com>
 <20210302043419-mutt-send-email-mst@kernel.org>
 <178f8ea7-cebd-0e81-3dc7-10a058d22c07@redhat.com>
 <c9a0932f-a6d7-a9df-38ba-97e50f70c2b2@oracle.com>
 <20211212042311-mutt-send-email-mst@kernel.org>
 <ba9df703-29af-98a9-c554-f303ff045398@oracle.com>
 <20211214000245-mutt-send-email-mst@kernel.org>
 <4fc43d0f-da9e-ce16-1f26-9f0225239b75@oracle.com>
In-Reply-To: <4fc43d0f-da9e-ce16-1f26-9f0225239b75@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Dec 2021 10:06:32 +0800
Message-ID: <CACGkMEsttnFEKGK-aKdCZeXkUnZJg1uaqYzFqpv-g5TobHGSzQ@mail.gmail.com>
Subject: Re: vdpa legacy guest support (was Re: [PATCH] vdpa/mlx5:
 set_features should allow reset to zero)
To: Si-Wei Liu <si-wei.liu@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>, Eli Cohen <elic@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gV2VkLCBEZWMgMTUsIDIwMjEgYXQgOTowNSBBTSBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9y
YWNsZS5jb20+IHdyb3RlOgo+Cj4KPgo+IE9uIDEyLzEzLzIwMjEgOTowNiBQTSwgTWljaGFlbCBT
LiBUc2lya2luIHdyb3RlOgo+ID4gT24gTW9uLCBEZWMgMTMsIDIwMjEgYXQgMDU6NTk6NDVQTSAt
MDgwMCwgU2ktV2VpIExpdSB3cm90ZToKPiA+Pgo+ID4+IE9uIDEyLzEyLzIwMjEgMToyNiBBTSwg
TWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4+PiBPbiBGcmksIERlYyAxMCwgMjAyMSBhdCAw
NTo0NDoxNVBNIC0wODAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+ID4+Pj4gU29ycnkgZm9yIHJldml2
aW5nIHRoaXMgYW5jaWVudCB0aHJlYWQuIEkgd2FzIGtpbmRhIGxvc3QgZm9yIHRoZSBjb25jbHVz
aW9uCj4gPj4+PiBpdCBlbmRlZCB1cCB3aXRoLiBJIGhhdmUgdGhlIGZvbGxvd2luZyBxdWVzdGlv
bnMsCj4gPj4+Pgo+ID4+Pj4gMS4gbGVnYWN5IGd1ZXN0IHN1cHBvcnQ6IGZyb20gdGhlIHBhc3Qg
Y29udmVyc2F0aW9ucyBpdCBkb2Vzbid0IHNlZW0gdGhlCj4gPj4+PiBzdXBwb3J0IHdpbGwgYmUg
Y29tcGxldGVseSBkcm9wcGVkIGZyb20gdGhlIHRhYmxlLCBpcyBteSB1bmRlcnN0YW5kaW5nCj4g
Pj4+PiBjb3JyZWN0PyBBY3R1YWxseSB3ZSdyZSBpbnRlcmVzdGVkIGluIHN1cHBvcnRpbmcgdmly
dGlvIHYwLjk1IGd1ZXN0IGZvciB4ODYsCj4gPj4+PiB3aGljaCBpcyBiYWNrZWQgYnkgdGhlIHNw
ZWMgYXQKPiA+Pj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL296bGFicy5v
cmcvKnJ1c3R5L3ZpcnRpby1zcGVjL3ZpcnRpby0wLjkuNS5wZGZfXztmZyEhQUNXVjVOOU0yUlY5
OWhRIWRUS216Snd3UnNGTTdCdFN1VER1MWNObHk1bjRYQ290SDBXWW1pZHpHcUhTWHQ0MGk3WlU0
M1VjTmc3R1l4WmckIC4gVGhvdWdoIEknbSBub3Qgc3VyZQo+ID4+Pj4gaWYgdGhlcmUncyByZXF1
ZXN0L25lZWQgdG8gc3VwcG9ydCB3aWxkZXIgbGVnYWN5IHZpcnRpbyB2ZXJzaW9ucyBlYXJsaWVy
Cj4gPj4+PiBiZXlvbmQuCj4gPj4+IEkgcGVyc29uYWxseSBmZWVsIGl0J3MgbGVzcyB3b3JrIHRv
IGFkZCBpbiBrZXJuZWwgdGhhbiB0cnkgdG8KPiA+Pj4gd29yayBhcm91bmQgaXQgaW4gdXNlcnNw
YWNlLiBKYXNvbiBmZWVscyBkaWZmZXJlbnRseS4KPiA+Pj4gTWF5YmUgcG9zdCB0aGUgcGF0Y2hl
cyBhbmQgdGhpcyB3aWxsIHByb3ZlIHRvIEphc29uIGl0J3Mgbm90Cj4gPj4+IHRvbyB0ZXJyaWJs
ZT8KPiA+PiBJIHN1cHBvc2UgaWYgdGhlIHZkcGEgdmVuZG9yIGRvZXMgc3VwcG9ydCAwLjk1IGlu
IHRoZSBkYXRhcGF0aCBhbmQgcmluZwo+ID4+IGxheW91dCBsZXZlbCBhbmQgaXMgbGltaXRlZCB0
byB4ODYgb25seSwgdGhlcmUgc2hvdWxkIGJlIGVhc3kgd2F5IG91dC4KPiA+IE5vdGUgYSBzdWJ0
bGUgZGlmZmVyZW5jZTogd2hhdCBtYXR0ZXJzIGlzIHRoYXQgZ3Vlc3QsIG5vdCBob3N0IGlzIHg4
Ni4KPiA+IE1hdHRlcnMgZm9yIGVtdWxhdG9ycyB3aGljaCBtaWdodCByZW9yZGVyIG1lbW9yeSBh
Y2Nlc3Nlcy4KPiA+IEkgZ3Vlc3MgdGhpcyBlbmZvcmNlbWVudCBiZWxvbmdzIGluIFFFTVUgdGhl
bj8KPiBSaWdodCwgSSBtZWFuIHRvIGdldCBzdGFydGVkLCB0aGUgaW5pdGlhbCBndWVzdCBkcml2
ZXIgc3VwcG9ydCBhbmQgdGhlCj4gY29ycmVzcG9uZGluZyBRRU1VIHN1cHBvcnQgZm9yIHRyYW5z
aXRpb25hbCB2ZHBhIGJhY2tlbmQgY2FuIGJlIGxpbWl0ZWQKPiB0byB4ODYgZ3Vlc3QvaG9zdCBv
bmx5LiBTaW5jZSB0aGUgY29uZmlnIHNwYWNlIGlzIGVtdWxhdGVkIGluIFFFTVUsIEkKPiBzdXBw
b3NlIGl0J3Mgbm90IGhhcmQgdG8gZW5mb3JjZSBpbiBRRU1VLgoKSXQncyBtb3JlIHRoYW4ganVz
dCBjb25maWcgc3BhY2UsIG1vc3QgZGV2aWNlcyBoYXZlIGhlYWRlcnMgYmVmb3JlIHRoZSBidWZm
ZXIuCgo+IFFFTVUgY2FuIGRyaXZlIEdFVF9MRUdBQ1ksCj4gR0VUX0VORElBTiBldCBhbCBpb2N0
bHMgaW4gYWR2YW5jZSB0byBnZXQgdGhlIGNhcGFiaWxpdHkgZnJvbSB0aGUKPiBpbmRpdmlkdWFs
IHZlbmRvciBkcml2ZXIuIEZvciB0aGF0LCB3ZSBuZWVkIGFub3RoZXIgbmVnb3RpYXRpb24gcHJv
dG9jb2wKPiBzaW1pbGFyIHRvIHZob3N0X3VzZXIncyBwcm90b2NvbF9mZWF0dXJlcyBiZXR3ZWVu
IHRoZSB2ZHBhIGtlcm5lbCBhbmQKPiBRRU1VLCB3YXkgYmVmb3JlIHRoZSBndWVzdCBkcml2ZXIg
aXMgZXZlciBwcm9iZWQgYW5kIGl0cyBmZWF0dXJlCj4gbmVnb3RpYXRpb24ga2lja3MgaW4uIE5v
dCBzdXJlIHdlIG5lZWQgYSBHRVRfTUVNT1JZX09SREVSIGlvY3RsIGNhbGwKPiBmcm9tIHRoZSBk
ZXZpY2UsIGJ1dCB3ZSBjYW4gYXNzdW1lIHdlYWsgb3JkZXJpbmcgZm9yIGxlZ2FjeSBhdCB0aGlz
Cj4gcG9pbnQgKHg4NiBvbmx5KT8KCkknbSBsb3N0IGhlcmUsIHdlIGhhdmUgZ2V0X2ZlYXR1cmVz
KCkgc286CgoxKSBWRVJTSU9OXzEgbWVhbnMgdGhlIGRldmljZSB1c2VzIExFIGlmIHByb3ZpZGVk
LCBvdGhlcndpc2UgbmF0dmllCjIpIE9SREVSX1BMQVRGT1JNIG1lYW5zIGRldmljZSByZXF1aXJl
cyBwbGF0Zm9ybSBvcmRlcmluZwoKQW55IHJlYXNvbiBmb3IgaGF2aW5nIGEgbmV3IEFQSSBmb3Ig
dGhpcz8KCj4KPiA+Cj4gPj4gSQo+ID4+IGNoZWNrZWQgd2l0aCBFbGkgYW5kIG90aGVyIE1lbGxh
bm94L05WRElBIGZvbGtzIGZvciBoYXJkd2FyZS9maXJtd2FyZSBsZXZlbAo+ID4+IDAuOTUgc3Vw
cG9ydCwgaXQgc2VlbXMgYWxsIHRoZSBpbmdyZWRpZW50IGhhZCBiZWVuIHRoZXJlIGFscmVhZHkg
ZGF0ZWQgYmFjawo+ID4+IHRvIHRoZSBEUERLIGRheXMuIFRoZSBvbmx5IG1ham9yIHRoaW5nIGxp
bWl0aW5nIGlzIGluIHRoZSB2RFBBIHNvZnR3YXJlIHRoYXQKPiA+PiB0aGUgY3VycmVudCB2ZHBh
IGNvcmUgaGFzIHRoZSBhc3N1bXB0aW9uIGFyb3VuZCBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0g
Zm9yCj4gPj4gYSBmZXcgRE1BIHNldHVwIG9wcywgd2hpY2ggaXMgdmlydGlvIDEuMCBvbmx5Lgo+
ID4+Cj4gPj4+PiAyLiBzdXBwb3NlIHNvbWUgZm9ybSBvZiBsZWdhY3kgZ3Vlc3Qgc3VwcG9ydCBu
ZWVkcyB0byBiZSB0aGVyZSwgaG93IGRvIHdlCj4gPj4+PiBkZWFsIHdpdGggdGhlIGJvZ3VzIGFz
c3VtcHRpb24gYmVsb3cgaW4gdmRwYV9nZXRfY29uZmlnKCkgaW4gdGhlIHNob3J0IHRlcm0/Cj4g
Pj4+PiBJdCBsb29rcyBvbmUgb2YgdGhlIGludHVpdGl2ZSBmaXggaXMgdG8gbW92ZSB0aGUgdmRw
YV9zZXRfZmVhdHVyZXMgY2FsbCBvdXQKPiA+Pj4+IG9mIHZkcGFfZ2V0X2NvbmZpZygpIHRvIHZk
cGFfc2V0X2NvbmZpZygpLgo+ID4+Pj4KPiA+Pj4+ICAgICAgICAgICAvKgo+ID4+Pj4gICAgICAg
ICAgICAqIENvbmZpZyBhY2Nlc3NlcyBhcmVuJ3Qgc3VwcG9zZWQgdG8gdHJpZ2dlciBiZWZvcmUg
ZmVhdHVyZXMgYXJlCj4gPj4+PiBzZXQuCj4gPj4+PiAgICAgICAgICAgICogSWYgaXQgZG9lcyBo
YXBwZW4gd2UgYXNzdW1lIGEgbGVnYWN5IGd1ZXN0Lgo+ID4+Pj4gICAgICAgICAgICAqLwo+ID4+
Pj4gICAgICAgICAgIGlmICghdmRldi0+ZmVhdHVyZXNfdmFsaWQpCj4gPj4+PiAgICAgICAgICAg
ICAgICAgICB2ZHBhX3NldF9mZWF0dXJlcyh2ZGV2LCAwKTsKPiA+Pj4+ICAgICAgICAgICBvcHMt
PmdldF9jb25maWcodmRldiwgb2Zmc2V0LCBidWYsIGxlbik7Cj4gPj4+Pgo+ID4+Pj4gSSBjYW4g
cG9zdCBhIHBhdGNoIHRvIGZpeCAyKSBpZiB0aGVyZSdzIGNvbnNlbnN1cyBhbHJlYWR5IHJlYWNo
ZWQuCj4gPj4+Pgo+ID4+Pj4gVGhhbmtzLAo+ID4+Pj4gLVNpd2VpCj4gPj4+IEknbSBub3Qgc3Vy
ZSBob3cgaW1wb3J0YW50IGl0IGlzIHRvIGNoYW5nZSB0aGF0Lgo+ID4+PiBJbiBhbnkgY2FzZSBp
dCBvbmx5IGFmZmVjdHMgdHJhbnNpdGlvbmFsIGRldmljZXMsIHJpZ2h0Pwo+ID4+PiBMZWdhY3kg
b25seSBzaG91bGQgbm90IGNhcmUgLi4uCj4gPj4gWWVzIEknZCBsaWtlIHRvIGRpc3Rpbmd1aXNo
IGxlZ2FjeSBkcml2ZXIgKHN1cHBvc2UgaXQgaXMgMC45NSkgYWdhaW5zdCB0aGUKPiA+PiBtb2Rl
cm4gb25lIGluIGEgdHJhbnNpdGlvbmFsIGRldmljZSBtb2RlbCByYXRoZXIgdGhhbiBiZWluZyBs
ZWdhY3kgb25seS4KPiA+PiBUaGF0IHdheSBhIHYwLjk1IGFuZCB2MS4wIHN1cHBvcnRpbmcgdmRw
YSBwYXJlbnQgY2FuIHN1cHBvcnQgYm90aCB0eXBlcyBvZgo+ID4+IGd1ZXN0cyB3aXRob3V0IGhh
dmluZyB0byByZWNvbmZpZ3VyZS4gT3IgYXJlIHlvdSBzdWdnZXN0aW5nIGxpbWl0IHRvIGxlZ2Fj
eQo+ID4+IG9ubHkgYXQgdGhlIHRpbWUgb2YgdmRwYSBjcmVhdGlvbiB3b3VsZCBzaW1wbGlmeSB0
aGUgaW1wbGVtZW50YXRpb24gYSBsb3Q/Cj4gPj4KPiA+PiBUaGFua3MsCj4gPj4gLVNpd2VpCj4g
Pgo+ID4gSSBkb24ndCBrbm93IGZvciBzdXJlLiBUYWtlIGEgbG9vayBhdCB0aGUgd29yayBIYWxp
bCB3YXMgZG9pbmcKPiA+IHRvIHRyeSBhbmQgc3VwcG9ydCB0cmFuc2l0aW9uYWwgZGV2aWNlcyB3
aXRoIEJFIGd1ZXN0cy4KPiBIbW1tLCB3ZSBjYW4gaGF2ZSB0aG9zZSBlbmRpYW5uZXNzIGlvY3Rs
cyBkZWZpbmVkIGJ1dCB0aGUgaW5pdGlhbCBRRU1VCj4gaW1wbGVtZW50YXRpb24gY2FuIGJlIHN0
YXJ0ZWQgdG8gc3VwcG9ydCB4ODYgZ3Vlc3QvaG9zdCB3aXRoIGxpdHRsZQo+IGVuZGlhbiBhbmQg
d2VhayBtZW1vcnkgb3JkZXJpbmcgZmlyc3QuIFRoZSByZWFsIHRyaWNrIGlzIHRvIGRldGVjdAo+
IGxlZ2FjeSBndWVzdCAtIEkgYW0gbm90IHN1cmUgaWYgaXQncyBmZWFzaWJsZSB0byBzaGlmdCBh
bGwgdGhlIGxlZ2FjeQo+IGRldGVjdGlvbiB3b3JrIHRvIFFFTVUsIG9yIHRoZSBrZXJuZWwgaGFz
IHRvIGJlIHBhcnQgb2YgdGhlIGRldGVjdGlvbgo+IChlLmcuIHRoZSBraWNrIGJlZm9yZSBEUklW
RVJfT0sgdGhpbmcgd2UgaGF2ZSB0byBkdXBsaWNhdGUgdGhlIHRyYWNraW5nCj4gZWZmb3J0IGlu
IFFFTVUpIGFzIHdlbGwuIExldCBtZSB0YWtlIGEgZnVydGhlciBsb29rIGFuZCBnZXQgYmFjay4K
Ck1pY2hhZWwgbWF5IHRoaW5rIGRpZmZlcmVudGx5IGJ1dCBJIHRoaW5rIGRvaW5nIHRoaXMgaW4g
UWVtdSBpcyBtdWNoIGVhc2llci4KClRoYW5rcwoKCgo+Cj4gTWVhbndoaWxlLCBJJ2xsIGNoZWNr
IGludGVybmFsbHkgdG8gc2VlIGlmIGEgbGVnYWN5IG9ubHkgbW9kZWwgd291bGQKPiB3b3JrLiBU
aGFua3MuCj4KPiBUaGFua3MsCj4gLVNpd2VpCj4KPgo+ID4KPiA+Cj4gPj4+PiBPbiAzLzIvMjAy
MSAyOjUzIEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4+Pj4+IE9uIDIwMjEvMy8yIDU6NDcg5LiL
5Y2ILCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPj4+Pj4+IE9uIE1vbiwgTWFyIDAxLCAy
MDIxIGF0IDExOjU2OjUwQU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPj4+Pj4+PiBPbiAy
MDIxLzMvMSA1OjM0IOS4iuWNiCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4+Pj4+Pj4+
IE9uIFdlZCwgRmViIDI0LCAyMDIxIGF0IDEwOjI0OjQxQU0gLTA4MDAsIFNpLVdlaSBMaXUgd3Jv
dGU6Cj4gPj4+Pj4+Pj4+PiBEZXRlY3RpbmcgaXQgaXNuJ3QgZW5vdWdoIHRob3VnaCwgd2Ugd2ls
bCBuZWVkIGEgbmV3IGlvY3RsIHRvIG5vdGlmeQo+ID4+Pj4+Pj4+Pj4gdGhlIGtlcm5lbCB0aGF0
IGl0J3MgYSBsZWdhY3kgZ3Vlc3QuIFVnaCA6KAo+ID4+Pj4+Pj4+PiBXZWxsLCBhbHRob3VnaCBJ
IHRoaW5rIGFkZGluZyBhbiBpb2N0bCBpcyBkb2FibGUsIG1heSBJCj4gPj4+Pj4+Pj4+IGtub3cg
d2hhdCB0aGUgdXNlCj4gPj4+Pj4+Pj4+IGNhc2UgdGhlcmUgd2lsbCBiZSBmb3Iga2VybmVsIHRv
IGxldmVyYWdlIHN1Y2ggaW5mbwo+ID4+Pj4+Pj4+PiBkaXJlY3RseT8gSXMgdGhlcmUgYQo+ID4+
Pj4+Pj4+PiBjYXNlIFFFTVUgY2FuJ3QgZG8gd2l0aCBkZWRpY2F0ZSBpb2N0bHMgbGF0ZXIgaWYg
dGhlcmUncyBpbmRlZWQKPiA+Pj4+Pj4+Pj4gZGlmZmVyZW50aWF0aW9uIChsZWdhY3kgdi5zLiBt
b2Rlcm4pIG5lZWRlZD8KPiA+Pj4+Pj4+PiBCVFcgYSBnb29kIEFQSSBjb3VsZCBiZQo+ID4+Pj4+
Pj4+Cj4gPj4+Pj4+Pj4gI2RlZmluZSBWSE9TVF9TRVRfRU5ESUFOIF9JT1coVkhPU1RfVklSVElP
LCA/LCBpbnQpCj4gPj4+Pj4+Pj4gI2RlZmluZSBWSE9TVF9HRVRfRU5ESUFOIF9JT1coVkhPU1Rf
VklSVElPLCA/LCBpbnQpCj4gPj4+Pj4+Pj4KPiA+Pj4+Pj4+PiB3ZSBkaWQgaXQgcGVyIHZyaW5n
IGJ1dCBtYXliZSB0aGF0IHdhcyBhIG1pc3Rha2UgLi4uCj4gPj4+Pj4+PiBBY3R1YWxseSwgSSB3
b25kZXIgd2hldGhlciBpdCdzIGdvb2QgdGltZSB0byBqdXN0IG5vdCBzdXBwb3J0Cj4gPj4+Pj4+
PiBsZWdhY3kgZHJpdmVyCj4gPj4+Pj4+PiBmb3IgdkRQQS4gQ29uc2lkZXI6Cj4gPj4+Pj4+Pgo+
ID4+Pj4+Pj4gMSkgSXQncyBkZWZpbml0aW9uIGlzIG5vLW5vcm1hdGl2ZQo+ID4+Pj4+Pj4gMikg
QSBsb3Qgb2YgYnVkcmVuIG9mIGNvZGVzCj4gPj4+Pj4+Pgo+ID4+Pj4+Pj4gU28gcWVtdSBjYW4g
c3RpbGwgcHJlc2VudCB0aGUgbGVnYWN5IGRldmljZSBzaW5jZSB0aGUgY29uZmlnCj4gPj4+Pj4+
PiBzcGFjZSBvciBvdGhlcgo+ID4+Pj4+Pj4gc3R1ZmZzIHRoYXQgaXMgcHJlc2VudGVkIGJ5IHZo
b3N0LXZEUEEgaXMgbm90IGV4cGVjdGVkIHRvIGJlCj4gPj4+Pj4+PiBhY2Nlc3NlZCBieQo+ID4+
Pj4+Pj4gZ3Vlc3QgZGlyZWN0bHkuIFFlbXUgY2FuIGRvIHRoZSBlbmRpYW4gY29udmVyc2lvbiB3
aGVuIG5lY2Vzc2FyeQo+ID4+Pj4+Pj4gaW4gdGhpcwo+ID4+Pj4+Pj4gY2FzZT8KPiA+Pj4+Pj4+
Cj4gPj4+Pj4+PiBUaGFua3MKPiA+Pj4+Pj4+Cj4gPj4+Pj4+IE92ZXJhbGwgSSB3b3VsZCBiZSBm
aW5lIHdpdGggdGhpcyBhcHByb2FjaCBidXQgd2UgbmVlZCB0byBhdm9pZCBicmVha2luZwo+ID4+
Pj4+PiB3b3JraW5nIHVzZXJzcGFjZSwgcWVtdSByZWxlYXNlcyB3aXRoIHZkcGEgc3VwcG9ydCBh
cmUgb3V0IHRoZXJlIGFuZAo+ID4+Pj4+PiBzZWVtIHRvIHdvcmsgZm9yIHBlb3BsZS4gQW55IGNo
YW5nZXMgbmVlZCB0byB0YWtlIHRoYXQgaW50byBhY2NvdW50Cj4gPj4+Pj4+IGFuZCBkb2N1bWVu
dCBjb21wYXRpYmlsaXR5IGNvbmNlcm5zLgo+ID4+Pj4+IEFncmVlLCBsZXQgbWUgY2hlY2suCj4g
Pj4+Pj4KPiA+Pj4+Pgo+ID4+Pj4+PiAgICAgSSBub3RlIHRoYXQgYW55IGhhcmR3YXJlCj4gPj4+
Pj4+IGltcGxlbWVudGF0aW9uIGlzIGFscmVhZHkgYnJva2VuIGZvciBsZWdhY3kgZXhjZXB0IG9u
IHBsYXRmb3JtcyB3aXRoCj4gPj4+Pj4+IHN0cm9uZyBvcmRlcmluZyB3aGljaCBtaWdodCBiZSBo
ZWxwZnVsIGluIHJlZHVjaW5nIHRoZSBzY29wZS4KPiA+Pj4+PiBZZXMuCj4gPj4+Pj4KPiA+Pj4+
PiBUaGFua3MKPiA+Pj4+Pgo+ID4+Pj4+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
