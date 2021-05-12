Return-Path: <SRS0=tDXz=KH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0780AC433B4
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 09:24:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7310561353
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 09:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7310561353
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06E51608DC;
	Wed, 12 May 2021 09:24:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L9xifbw3CeTT; Wed, 12 May 2021 09:24:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 481D6608D6;
	Wed, 12 May 2021 09:24:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 117D1C000E;
	Wed, 12 May 2021 09:24:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91731C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 09:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6ED23404E2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 09:24:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lJA8XJERmhpM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 09:24:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2387404A3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 09:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620811479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Je1KS7YOVHavoIfQ7KtY7zo/B1WdAVPfu1SGQbtiGY8=;
 b=QsiXQtT1tqwI6YxWC/hz7FfwPGv/IMF/8GO5ftIkPxi2+vbmyZJ14+4EEqU8fGYPLZu3BE
 IGp9VS1cJlijL/DZZDAHVQ8L/naO4CkWfMigOgOG7wrfLLSCeO7x4/zAv4Qe6ALFkTGlgV
 Qa8xXGjw7X1hA+ssL5TnWW+szNqnCaE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-vWPBnt4UMjG3Cn8YFUDYhg-1; Wed, 12 May 2021 05:24:37 -0400
X-MC-Unique: vWPBnt4UMjG3Cn8YFUDYhg-1
Received: by mail-pj1-f71.google.com with SMTP id
 f15-20020a17090aa78fb029015c411f061bso3320087pjq.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 02:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Je1KS7YOVHavoIfQ7KtY7zo/B1WdAVPfu1SGQbtiGY8=;
 b=cAGnS1ut75GmJWKiXZIoG3A1eE3ZJckpRk/hgv2WEzq1mWu7fZ/2LJe2xZ/Rfs6saq
 SGq86aKwWW/1BnySW8NXJRApZss0fALbZNbmr96MNqJveDzf9nLOhTqGmOQSRYxo2kOa
 tTJqrz96CUq7NWCZPe2UJsdjd1HBOvGSm9DoFokf/p6NhZ1bqm+pDjtzTxNGExVw4HWe
 iFcbFABb5pw6+K9HG4hHe3d2HvXuwX9bS00HZ10BZACCF01ArX9xqYcBpGGTX3InfI0r
 Nwzlcnm6Y5QRBfw571x43LWBEI3hRh52zaVFkVhxzaRhA98eXmIexFQGtfqkVfW39E7E
 p/yA==
X-Gm-Message-State: AOAM531vgohaX8HjZknDc0Z5GPguE6GTt9JYQDCsY46sndvWqbXJ4s0n
 RPeQkyipIDMetVBx5FgGFrDjtza6ArL02v1DyYh+LFhQdnWR9c7D57LeBPsJmDhHFEiLyrpLlqH
 HwzF+HBf5vLm8gAfZ3rUhb2qV66I0nyHfPGI/tticVzaMb6eFwA+uaZ3dlA==
X-Received: by 2002:a17:902:c211:b029:ed:7a6b:d4bf with SMTP id
 17-20020a170902c211b02900ed7a6bd4bfmr34388970pll.63.1620811476414; 
 Wed, 12 May 2021 02:24:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwp7t4oeA7z4E29TZxB0ETdgquSHL87LpVC0igXsRjg2A9wiZeFn/i7AV+3FbTEtsIJ/UcsQpCgZn71OZpTMTs=
X-Received: by 2002:a17:902:c211:b029:ed:7a6b:d4bf with SMTP id
 17-20020a170902c211b02900ed7a6bd4bfmr34388944pll.63.1620811476008; Wed, 12
 May 2021 02:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210408082648.20145-1-jasowang@redhat.com>
 <20210409115343-mutt-send-email-mst@kernel.org>
 <42891807-cb24-5352-f8cb-798e9d1a1854@redhat.com>
 <20210412050730-mutt-send-email-mst@kernel.org>
 <01918e14-7f7a-abf2-5864-292a32f0233c@redhat.com>
 <d5632a4d-4d0b-b08d-06f9-c56f16734607@redhat.com>
 <20210421035331-mutt-send-email-mst@kernel.org>
 <3d5754f3-c012-67ad-5f01-fc16ec53df4e@redhat.com>
 <529543956.24692551.1620722593826.JavaMail.zimbra@redhat.com>
 <20210511061740-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210511061740-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 May 2021 17:24:21 +0800
Message-ID: <CACGkMEuvqUL04_wHqSKPUufu5O6ydhytHAx0NryLODNHkEO+Fw@mail.gmail.com>
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mapfelba@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <elic@nvidia.com>, Lingshan Zhu <lingshan.zhu@intel.com>
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

T24gV2VkLCBNYXkgMTIsIDIwMjEgYXQgMzo1NCBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgTWF5IDExLCAyMDIxIGF0IDA0OjQzOjEzQU0g
LTA0MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPgo+ID4KPiA+IC0tLS0tIOWOn+Wni+mCruS7tiAt
LS0tLQo+ID4gPgo+ID4gPiDlnKggMjAyMS80LzIxIOS4i+WNiDQ6MDMsIE1pY2hhZWwgUy4gVHNp
cmtpbiDlhpnpgZM6Cj4gPiA+ID4gT24gV2VkLCBBcHIgMjEsIDIwMjEgYXQgMDM6NDE6MzZQTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPj4g5ZyoIDIwMjEvNC8xMiDkuIvljYg1OjIz
LCBKYXNvbiBXYW5nIOWGmemBkzoKPiA+ID4gPj4+IOWcqCAyMDIxLzQvMTIg5LiL5Y2INTowOSwg
TWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiA+ID4gPj4+PiBPbiBNb24sIEFwciAxMiwgMjAy
MSBhdCAwMjozNTowN1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+Pj4+PiDlnKgg
MjAyMS80LzEwIOS4iuWNiDEyOjA0LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+ID4gPiA+
Pj4+Pj4gT24gRnJpLCBBcHIgMDksIDIwMjEgYXQgMTI6NDc6NTVQTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gPj4+Pj4+PiDlnKggMjAyMS80Lzgg5LiL5Y2IMTE6NTksIE1pY2hhZWwg
Uy4gVHNpcmtpbiDlhpnpgZM6Cj4gPiA+ID4+Pj4+Pj4+IE9uIFRodSwgQXByIDA4LCAyMDIxIGF0
IDA0OjI2OjQ4UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4+Pj4+Pj4+PiBUaGlz
IHBhdGNoIG1hbmRhdGVzIDEuMCBmb3IgdkRQQSBkZXZpY2VzLiBUaGUgZ29hbCBpcyB0byBoYXZl
IHRoZQo+ID4gPiA+Pj4+Pj4+Pj4gc2VtYW50aWMgb2Ygbm9ybWF0aXZlIHN0YXRlbWVudCBpbiB0
aGUgdmlydGlvCj4gPiA+ID4+Pj4+Pj4+PiBzcGVjIGFuZCBlbGltaW5hdGUgdGhlCj4gPiA+ID4+
Pj4+Pj4+PiBidXJkZW4gb2YgdHJhbnNpdGlvbmFsIGRldmljZSBmb3IgYm90aCB2RFBBIGJ1cyBh
bmQgdkRQQSBwYXJlbnQuCj4gPiA+ID4+Pj4+Pj4+Pgo+ID4gPiA+Pj4+Pj4+Pj4gdUFQSSBzZWVt
cyBmaW5lIHNpbmNlIGFsbCB0aGUgdkRQQSBwYXJlbnQgbWFuZGF0ZXMKPiA+ID4gPj4+Pj4+Pj4+
IFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSB3aGljaCBpbXBsaWVzIDEuMCBkZXZpY2VzLgo+ID4g
PiA+Pj4+Pj4+Pj4KPiA+ID4gPj4+Pj4+Pj4+IEZvciBsZWdhY3kgZ3Vlc3RzLCBpdCBjYW4gc3Rp
bGwgd29yayBzaW5jZSBRZW11IHdpbGwgbWVkaWF0ZSB3aGVuCj4gPiA+ID4+Pj4+Pj4+PiBuZWNl
c3NhcnkgKGUuZyBkb2luZyB0aGUgZW5kaWFuIGNvbnZlcnNpb24pLgo+ID4gPiA+Pj4+Pj4+Pj4K
PiA+ID4gPj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+Cj4gPiA+ID4+Pj4+Pj4+IEhtbS4gSWYgd2UgZG8gdGhpcywgZG9uJ3Qgd2Ugc3RpbGwg
aGF2ZSBhIHByb2JsZW0gd2l0aAo+ID4gPiA+Pj4+Pj4+PiBsZWdhY3kgZHJpdmVycyB3aGljaCBk
b24ndCBhY2sgMS4wPwo+ID4gPiA+Pj4+Pj4+IFllcywgYnV0IGl0J3Mgbm90IHNvbWV0aGluZyB0
aGF0IGlzIGludHJvZHVjZWQgaW4gdGhpcwo+ID4gPiA+Pj4+Pj4+IGNvbW1pdC4gVGhlIGxlZ2Fj
eQo+ID4gPiA+Pj4+Pj4+IGRyaXZlciBuZXZlciB3b3JrIC4uLgo+ID4gPiA+Pj4+Pj4gTXkgcG9p
bnQgaXMgdGhpcyBuZWl0aGVyIGZpeGVzIG9yIHByZXZlbnRzIHRoaXMuCj4gPiA+ID4+Pj4+Pgo+
ID4gPiA+Pj4+Pj4gU28gbXkgc3VnZ2VzdGlvbiBpcyB0byBmaW5hbGx5IGFkZCBpb2N0bHMgYWxv
bmcgdGhlIGxpbmVzCj4gPiA+ID4+Pj4+PiBvZiBQUk9UT0NPTF9GRUFUVVJFUyBvZiB2aG9zdC11
c2VyLgo+ID4gPiA+Pj4+Pj4KPiA+ID4gPj4+Pj4+IFRoZW4gdGhhdCBvbmUgY2FuIGhhdmUgYml0
cyBmb3IgbGVnYWN5IGxlLCBsZWdhY3kgYmUgYW5kIG1vZGVybi4KPiA+ID4gPj4+Pj4+Cj4gPiA+
ID4+Pj4+PiBCVFcgSSBsb29rZWQgYXQgdmhvc3QtdXNlciBhbmQgaXQgZG9lcyBub3QgbG9vayBs
aWtlIHRoYXQKPiA+ID4gPj4+Pj4+IGhhcyBhIHNvbHV0aW9uIGZvciB0aGlzIHByb2JsZW0gZWl0
aGVyLCByaWdodD8KPiA+ID4gPj4+Pj4gUmlnaHQuCj4gPiA+ID4+Pj4+Cj4gPiA+ID4+Pj4+Cj4g
PiA+ID4+Pj4+Pj4+IE5vdGUgMS4wIGFmZmVjdHMgcmluZyBlbmRpYW5uZXNzIHdoaWNoIGlzIG5v
dCBtZWRpYXRlZCBpbiBRRU1VCj4gPiA+ID4+Pj4+Pj4+IHNvIFFFTVUgY2FuJ3QgcHJldGVuZCB0
byBkZXZpY2UgZ3Vlc3QgaXMgMS4wLgo+ID4gPiA+Pj4+Pj4+IFJpZ2h0LCBJIHBsYW4gdG8gc2Vu
ZCBwYXRjaGVzIHRvIGRvIG1lZGlhdGlvbiBpbiB0aGUKPiA+ID4gPj4+Pj4+PiBRZW11IHRvIHVu
YnJlYWsgbGVnYWN5Cj4gPiA+ID4+Pj4+Pj4gZHJpdmVycy4KPiA+ID4gPj4+Pj4+Pgo+ID4gPiA+
Pj4+Pj4+IFRoYW5rcwo+ID4gPiA+Pj4+Pj4gSSBmcmFua2x5IHRoaW5rIHdlJ2xsIG5lZWQgUFJP
VE9DT0xfRkVBVFVSRVMgYW55d2F5LCBpdCdzCj4gPiA+ID4+Pj4+PiB0b28gdXNlZnVsIC4uLgo+
ID4gPiA+Pj4+Pj4gc28gd2h5IG5vdCB0ZWFjaCBkcml2ZXJzIGFib3V0IGl0IGFuZCBiZSBkb25l
IHdpdGggaXQ/IFlvdQo+ID4gPiA+Pj4+Pj4gY2FuJ3QgZW11bGF0ZQo+ID4gPiA+Pj4+Pj4gbGVn
YWN5IG9uIG1vZGVybiBpbiBhIGNyb3NzIGVuZGlhbiBzaXR1YXRpb24gYmVjYXVzZSBvZiB2cmlu
Zwo+ID4gPiA+Pj4+Pj4gZW5kaWFuLW5lc3MgLi4uCj4gPiA+ID4+Pj4+IFNvIHRoZSBwcm9ibGVt
IHN0aWxsLiBUaGlzIGNhbiBvbmx5IHdvcmsgd2hlbiB0aGUgaGFyZHdhcmUgY2FuIHN1cHBvcnQK
PiA+ID4gPj4+Pj4gbGVnYWN5IHZyaW5nIGVuZGlhbi1uZXNzLgo+ID4gPiA+Pj4+Pgo+ID4gPiA+
Pj4+PiBDb25zaWRlcjoKPiA+ID4gPj4+Pj4KPiA+ID4gPj4+Pj4gMSkgdGhlIGxlYWdjeSBkcml2
ZXIgc3VwcG9ydCBpcyBub24tbm9ybWF0aXZlIGluIHRoZSBzcGVjCj4gPiA+ID4+Pj4+IDIpIHN1
cHBvcnQgYSB0cmFuc2l0aW9uYWwgZGV2aWNlIGluIHRoZSBrZW5yZWwgbWF5IHJlcXVpcmVzIHRo
ZQo+ID4gPiA+Pj4+PiBoYXJkd2FyZQo+ID4gPiA+Pj4+PiBzdXBwb3J0IGFuZCBhIGJ1cmRlbiBv
ZiBrZXJuZWwgY29kZXMKPiA+ID4gPj4+Pj4KPiA+ID4gPj4+Pj4gSSdkIHJhdGhlciBzaW1wbHkg
ZHJvcCB0aGUgbGVnYWN5IGRyaXZlciBzdXBwb3J0Cj4gPiA+ID4+Pj4gTXkgcG9pbnQgaXMgdGhp
cyBwYXRjaCBkb2VzIG5vdCBkcm9wIGxlZ2FjeSBzdXBwb3J0LiBJdCBtZXJlbHkgbWFuZGF0ZXMK
PiA+ID4gPj4+PiBtb2Rlcm4gc3VwcG9ydC4KPiA+ID4gPj4+Cj4gPiA+ID4+PiBJIGFtIG5vdCBz
dXJlIEkgZ2V0IGhlcmUuIFRoaXMgcGF0Y2ggZmFpbHMgdGhlIHNldF9mZWF0dXJlIGlmIFZFUlNJ
T05fMQo+ID4gPiA+Pj4gaXMgbm90IG5lZ290aWF0ZWQuIFRoaXMgbWVhbnM6Cj4gPiA+ID4+Pgo+
ID4gPiA+Pj4gMSkgdkRQQSBwcmVzZW50cyBhIG1vZGVybiBkZXZpY2UgaW5zdGVhZCBvZiB0cmFu
c2l0b25hbCBkZXZpY2UKPiA+ID4gPj4+IDIpIGxlZ2FjeSBkcml2ZXIgY2FuJ3QgYmUgcHJvYmVk
Cj4gPiA+ID4+Pgo+ID4gPiA+Pj4gV2hhdCBJJ20gbWlzc2luZz8KPiA+ID4gPj4KPiA+ID4gPj4g
SGkgTWljaGFlbDoKPiA+ID4gPj4KPiA+ID4gPj4gRG8geW91IGFncmVlIHRvIGZpbmQgdGhlIHdh
eSB0byBwcmVzZW50IG1vZGVybiBkZXZpY2U/IFdlIG5lZWQgYQo+ID4gPiA+PiBjb25jbHVzaW9u
Cj4gPiA+ID4+IHRvIG1ha2UgdGhlIG5ldGxpbmsgQVBJIHdvcmsgdG8gbW92ZSBmb3J3YXJkLgo+
ID4gPiA+Pgo+ID4gPiA+PiBUaGFua3MKPiA+ID4gPiBJIHRoaW5rIHdlIG5lZWQgYSB3YXkgdG8g
c3VwcG9ydCBsZWdhY3kgd2l0aCBubyBkYXRhIHBhdGggb3ZlcmhlYWQuIHFlbXUKPiA+ID4gPiBz
ZXR0aW5nIFZFUlNJT05fMSBmb3IgYSBsZWdhY3kgZ3Vlc3QgYWZmZWN0cyB0aGUgcmluZyBmb3Jt
YXQgc28gaXQgZG9lcwo+ID4gPiA+IG5vdCByZWFsbHkgd29yay4gVGhpcyBzZWVtcyB0byBydWxl
IG91dCBlbXVsYXRpbmcgY29uZmlnIHNwYWNlIGVudGlyZWx5Cj4gPiA+ID4gaW4gdXNlcnNwYWNl
Lgo+ID4gPgo+ID4gPgo+ID4gPiBTbyBJJ2QgcmF0aGVyIGRyb3AgdGhlIGxlZ2FjeSBzdXBwb3J0
IGluIHRoaXMgY2FzZS4gSXQgbmV2ZXIgd29yayBmb3IKPiA+ID4gdkRQQSBpbiB0aGUgcGFzdCBh
bmQgdmlydGlvLXZEUEEgZG9lc24ndCBldmVuIG5lZWQgdGhhdC4gTm90ZSB0aGF0Cj4gPiA+IEFD
Q0VTU19QTEFURk9STSBpcyBtYW5kYXRlZCBmb3IgYWxsIHRoZSB2RFBBIHBhcmVudHMgcmlnaHQg
bm93IHdoaWNoCj4gPiA+IGltcGxpZXMgbW9kZXJuIGRldmljZSBhbmQgTEUuIEkgd29uZGVyIHdo
YXQncyB0aGUgdmFsdWUgZm9yIHN1cHBvcnRpbmcKPiA+ID4gbGVnYWN5IGluIHRoaXMgY2FzZSBv
ciBkbyB3ZSByZWFsbHkgZW5jb3VyYWdlIHZlbmRvcnMgdG8gc2hpcCBjYXJkIHdpdGgKPiA+ID4g
bGVnYWN5IHN1cHBvcnQgKGUuZyBlbmRpYW4gc3VwcG9ydCBpbiB0aGUgaGFyZHdhcmUpPwo+ID4K
PiA+IEhpIE1pY2hhZWw6Cj4gPgo+ID4gQW55IHRob3VnaHRzIG9uIHRoaXMgYXBwcm9hY2g/Cj4g
Pgo+ID4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGRyb3BwaW5nIGxlZ2FjeSBzdXBwb3J0IHdp
bGwgc2ltcGxpZnkgYSBsb3Qgb2Ygc3R1ZmZzLgo+ID4KPiA+IFRoYW5rcwo+Cj4gU28gYmFzaWNh
bGx5IHRoZSBtYWluIGNvbmRpdGlvbiBpcyB0aGF0IHN0cm9uZyBtZW1vcnkgYmFycmllcnMgYXJl
bid0Cj4gbmVlZGVkIGZvciB2aXJ0aW8sIHNtcCBiYXJyaWVycyBhcmUgZW5vdWdoLgo+IEFyZSB0
aGVyZSBhcmNoaXRlY3R1cmVzIGJlc2lkZXMgeDg2ICh3aGVyZSBpdCdzIGtpbmQgb2YgdHJ1ZSAt
IGFzIGxvbmcgYXMKPiBvbmUgZG9lcyBub3QgdXNlIG5vbi10ZW1wb3JhbHMpIHdoZXJlIHRoYXQg
aXMgdHJ1ZT8KPiBJZiBhbGwgdGhlc2UgYXJjaGl0ZWN0dXJlcyBhcmUgTEUgdGhlbiB3ZSBkb24n
dCBuZWVkIHRvIHdvcnJ5Cj4gYWJvdXQgZW5kaWFuIHN1cHBvcnQgaW4gdGhlIGhhcmR3YXJlLgoK
U28gSSBhZ3JlZSBpdCdzIGJldHRlciBub3QgdG8gYWRkIHRob3NlIHN0dWZmcyBpbiBlaXRoZXIg
cWVtdSBvcgprZXJuZWwuIFNlZSBiZWxvdy4KCj4KPiBJbiBvdGhlciB3b3JkcyBJIGd1ZXNzIHll
cyB3ZSBjb3VsZCBoYXZlIHFlbXUgbGltaXQgdGhpbmdzIHRvIHg4NiBhbmQKPiB0aGVuIGp1c3Qg
cHJldGVuZCB0byB0aGUgY2FyZCB0aGF0IGl0J3MgdmlydGlvIDEuCj4gU28gZW5kaWFuLW5lc3Mg
d2UgY2FuIGFkZHJlc3MuCj4KPiBQcm9ibGVtIGlzIHZpcnRpbyAxIGhhcyBlZmZlY3RzIGJleW9u
ZCB0aGlzLiB0aGluZ3MgbGlrZSBoZWFkZXIgc2l6ZQo+IHdpdGggbWVyZ2VhYmxlIGJ1ZmZlcnMg
b2ZmIGZvciB2aXJ0aW8gbmV0Lgo+Cj4gU28gSSBhbSBpbmNsaW5lZCB0byBzYXkgbGV0IHVzIG5v
dCBkbyB0aGUgInByZXRlbmQgaXQncyB2aXJ0aW8gMSIgZ2FtZQo+IGluIHFlbXUuCgpJIGZ1bGx5
IGFncmVlLgoKICBMZXQgdXMgYmUgaG9uZXN0IHRvIHRoZSBjYXJkIGFib3V0IHdoYXQgaGFwcGVu
cy4KPiBCdXQgaWYgeW91IHdhbnQgdG8gbGltaXQgdGhpbmdzIHRvIHg4NiBlaXRoZXIgaW4ga2Vy
bmVsIG9yIGluIHFlbXUsCj4gdGhhdCdzIG9rIGJ5IG1lLgoKU28gd2hhdCBJIHdhbnQgdG8gZG8g
aXM6CgoxKSBtYW5kYXRlIDEuMCBkZXZpY2Ugb24gdGhlIGtlcm5lbAoyKSBkb24ndCB0cnkgdG8g
cHJldGVuZCB0cmFuc2l0aW9uYWwgb3IgbGVnYWN5IGRldmljZSBvbiB0b3Agb2YgbW9kZXJuCmRl
dmljZSBpbiBRZW11LCBzbyBxZW11IHdpbGwgZmFpbCB0byBzdGFydCBpZiB2aG9zdC12RFBBIGlz
IHN0YXJ0ZWQKd2l0aCBhIGxlZ2FjeSBvciB0cmFuc2l0aW9uYWwgZGV2aWNlCgpBbmQgdGhpcyBz
aW1wbHkgdGhlIG1hbmFnZW1lbnQgQVBJIHdoaWNoIGNhbiBhc3N1bWUgTEUgZm9yCnByZS1jb25m
aWd1cmF0aW9uIHZpYSBjb25maWcgc3BhY2UuCgpTbyBpZiBJJ20gbm90IG1pc3VuZGVyc3RhbmRp
bmcsIHdlIGNhbiBtZXJnZSB0aGlzIHBhdGNoIGFuZCBJIGNhbiBkbwp0aGUgUWVtdSB3b3JrIG9u
IHRvcD8KClRoYW5rcwoKPgo+ID4KPiA+ID4KPiA+ID4KPiA+ID4gPgo+ID4gPiA+IFNvIEkgdGhp
bmsgd2Ugc2hvdWxkIGFkZCBhbiBpb2N0bCBhbG9uZyB0aGUgbGluZXMgb2YKPiA+ID4gPiBwcm90
b2NvbCBmZWF0dXJlcy4gVGhlbiBJIHRoaW5rIHdlIGNhbiByZXNlcnZlIGZlYXR1cmUgYml0cwo+
ID4gPiA+IGZvciBjb25maWcgc3BhY2UgZm9ybWF0OiBsZWdhY3kgTEUsIGxlZ2FjeSBCRSwgbW9k
ZXJuLgo+ID4gPgo+ID4gPgo+ID4gPiBXZSBoYWQgVkhPU1RfU0VUX1ZSSU5HX0VORElBTiBidXQg
dGhpcyB3aWxsIGNvbXBsaWNhdGVzIGJvdGggdGhlIHZEUEEKPiA+ID4gcGFyZW50IGFuZCBtYW5h
Z2VtZW50LiBXaGF0J3MgbW9yZSBpbXBvcnRhbnQsIGxlZ2FjeSBiZWhhdmlvdXIgaXMgbm90Cj4g
PiA+IHJlc3RyaWN0aWVkIGJ5IHRoZSBzcGVjLgo+ID4gPgo+ID4gPgo+ID4gPiA+Cj4gPiA+ID4g
UXVlcnlpbmcgdGhlIGZlYXR1cmUgYml0cyB3aWxsIHByb3ZpZGUgdXMgd2l0aCBpbmZvIGFib3V0
Cj4gPiA+ID4gd2hhdCBkb2VzIHRoZSBkZXZpY2Ugc3VwcG9ydC4gQWNraW5nIHRoZW0gd2lsbCB0
ZWxsIGRldmljZQo+ID4gPiA+IHdoYXQgZG9lcyBndWVzdCBuZWVkLgo+ID4gPgo+ID4gPgo+ID4g
PiBJIHRoaW5rIHRoaXMgY2FuIHdvcmssIGJ1dCBJIHdvbmRlciBob3cgbXVjaCB3ZSBjYW4gZ2Fp
biBmcm9tIHN1Y2gKPiA+ID4gY29tcGxleGl0aXkuCj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4gPgo+
ID4gPgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPj4+Cj4g
PiA+ID4+Pj4+IHRvIGhhdmUgYSBzaW1wbGUgYW5kIGVhc3kKPiA+ID4gPj4+Pj4gYWJzdGFyY3Rp
b24gaW4gdGhlIGtlbnJlbC4gRm9yIGxlZ2FjeSBkcml2ZXIgaW4gdGhlIGd1ZXN0LAo+ID4gPiA+
Pj4+PiBoeXBlcnZpc29yIGlzIGluCj4gPiA+ID4+Pj4+IGNoYXJnZSBvZiB0aGUgbWVkaWF0aW9u
Ogo+ID4gPiA+Pj4+Pgo+ID4gPiA+Pj4+PiAxKSBjb25maWcgc3BhY2UgYWNjZXNzIGVuZGlhbiBj
b252ZXJzaW9uCj4gPiA+ID4+Pj4+IDIpIHVzaW5nIHNoYWRvdyB2aXJ0cXVldWUgdG8gY2hhbmdl
IHRoZSBlbmRpYW4gaW4gdGhlIHZyaW5nCj4gPiA+ID4+Pj4+Cj4gPiA+ID4+Pj4+IFRoYW5rcwo+
ID4gPiA+Pj4+IEknZCBsaWtlIHRvIGF2b2lkIHNoYWRvdyB2aXJ0cXVldWUgaGFja3MgaWYgYXQg
YWxsIHBvc3NpYmxlLgo+ID4gPiA+Pj4+IExhc3QgSSBjaGVja2VkIHBlcmZvcm1hbmNlIHdhc24n
dCBtdWNoIGJldHRlciB0aGFuIGp1c3QgZW11bGF0aW5nCj4gPiA+ID4+Pj4gdmlydGlvIGluIHNv
ZnR3YXJlLgo+ID4gPiA+Pj4KPiA+ID4gPj4+IEkgdGhpbmsgdGhlIGxlZ2FjeSBkcml2ZXIgc3Vw
cG9ydCBpcyBqdXN0IGEgbmljZSB0byBoYXZlLiBPciBkbyB5b3Ugc2VlCj4gPiA+ID4+PiBhbnkg
dmFsdWUgdG8gdGhhdD8gSSBndWVzcyBmb3IgbWVsbGFub3ggYW5kIGludGVsLCBvbmx5IG1vZGVy
biBkZXZpY2UgaXMKPiA+ID4gPj4+IHN1cHBvcnRlZCBpbiB0aGUgaGFyZHdhcmUuCj4gPiA+ID4+
Pgo+ID4gPiA+Pj4gVGhhbmtzCj4gPiA+ID4+Pgo+ID4gPiA+Pj4KPiA+ID4gPj4+Pj4+Pj4KPiA+
ID4gPj4+Pj4+Pj4KPiA+ID4gPj4+Pj4+Pj4+IC0tLQo+ID4gPiA+Pj4+Pj4+Pj4gICAgICBpbmNs
dWRlL2xpbnV4L3ZkcGEuaCB8IDYgKysrKysrCj4gPiA+ID4+Pj4+Pj4+PiAgICAgIDEgZmlsZSBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPiA+ID4gPj4+Pj4+Pj4+Cj4gPiA+ID4+Pj4+Pj4+PiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+
ID4gPiA+Pj4+Pj4+Pj4gaW5kZXggMGZlZmViOTc2ODc3Li5jZmRlNGVjOTk5YjQgMTAwNjQ0Cj4g
PiA+ID4+Pj4+Pj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ID4gPiA+Pj4+Pj4+Pj4g
KysrIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiA+ID4gPj4+Pj4+Pj4+IEBAIC02LDYgKzYsNyBA
QAo+ID4gPiA+Pj4+Pj4+Pj4gICAgICAjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+Cj4gPiA+ID4+
Pj4+Pj4+PiAgICAgICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KPiA+ID4gPj4+Pj4+Pj4+
ICAgICAgI2luY2x1ZGUgPGxpbnV4L3Zob3N0X2lvdGxiLmg+Cj4gPiA+ID4+Pj4+Pj4+PiArI2lu
Y2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX2NvbmZpZy5oPgo+ID4gPiA+Pj4+Pj4+Pj4gICAgICAv
KioKPiA+ID4gPj4+Pj4+Pj4+ICAgICAgICogdkRQQSBjYWxsYmFjayBkZWZpbml0aW9uLgo+ID4g
PiA+Pj4+Pj4+Pj4gQEAgLTMxNyw2ICszMTgsMTEgQEAgc3RhdGljIGlubGluZSBpbnQKPiA+ID4g
Pj4+Pj4+Pj4+IHZkcGFfc2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTY0
Cj4gPiA+ID4+Pj4+Pj4+PiBmZWF0dXJlcykKPiA+ID4gPj4+Pj4+Pj4+ICAgICAgewo+ID4gPiA+
Pj4+Pj4+Pj4gICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9
IHZkZXYtPmNvbmZpZzsKPiA+ID4gPj4+Pj4+Pj4+ICsgICAgICAgIC8qIE1hbmRhdGluZyAxLjAg
dG8gaGF2ZSBzZW1hbnRpY3Mgb2YKPiA+ID4gPj4+Pj4+Pj4+IG5vcm1hdGl2ZSBzdGF0ZW1lbnRz
IGluCj4gPiA+ID4+Pj4+Pj4+PiArICAgICAgICAgKiB0aGUgc3BlYy4gKi8KPiA+ID4gPj4+Pj4+
Pj4+ICsgICAgICAgIGlmICghKGZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fRl9WRVJTSU9OXzEp
KSkKPiA+ID4gPj4+Pj4+Pj4+ICsgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ID4gPiA+Pj4+Pj4+
Pj4gKwo+ID4gPiA+Pj4+Pj4+Pj4gICAgICAgICAgdmRldi0+ZmVhdHVyZXNfdmFsaWQgPSB0cnVl
Owo+ID4gPiA+Pj4+Pj4+Pj4gICAgICAgICAgICAgIHJldHVybiBvcHMtPnNldF9mZWF0dXJlcyh2
ZGV2LCBmZWF0dXJlcyk7Cj4gPiA+ID4+Pj4+Pj4+PiAgICAgIH0KPiA+ID4gPj4+Pj4+Pj4+IC0t
Cj4gPiA+ID4+Pj4+Pj4+PiAyLjI1LjEKPiA+ID4KPiA+ID4KPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
