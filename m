Return-Path: <SRS0=8N1b=MT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACCCC4338F
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 09:11:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3403361252
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 09:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3403361252
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E756A82E4C;
	Tue, 27 Jul 2021 09:11:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H3SqDp3cRTln; Tue, 27 Jul 2021 09:11:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 713D982C3E;
	Tue, 27 Jul 2021 09:11:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27CB1C0010;
	Tue, 27 Jul 2021 09:11:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 514F5C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 09:11:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2AA5082C8F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 09:11:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cBIvqdxhJ3yV
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 09:11:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0C65082C3E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 09:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627377089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o8iKH58H5ipoFb33Gh09VUrz5ad/Jv7wCA6+Pk32vtI=;
 b=O6df6v52tKmQDiRP15senpXzT3EZjlyo47nrUau4/2e4eAaKhkBcPaI5JP3j/gcLAfFtUW
 /Pdl3tLDRVp0TWsHzDb2xyBwYtsvK7ftDMOr9npbF9maTMj58KuLCPlLhYndIlye2CPQ1A
 E89RfGHE3d9LAotJMb7K3bv5t96K6XA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-LfEE8K_YPkK7CFPbCGbWow-1; Tue, 27 Jul 2021 05:11:27 -0400
X-MC-Unique: LfEE8K_YPkK7CFPbCGbWow-1
Received: by mail-ed1-f69.google.com with SMTP id
 b13-20020a056402278db029039c013d5b80so6279620ede.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 02:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=o8iKH58H5ipoFb33Gh09VUrz5ad/Jv7wCA6+Pk32vtI=;
 b=FDDBuMdF2B7yLRs0aJRyWdTF6TGXxvmFMvdsQULFk8PYhClYZQr9e3NnSKMNXy6RvC
 4ASn95i1HYgnvxORop7qSVvICArm6qdKoSZJyhgJHvFYm2OI+tZ+IrxOP8v8/Qxx1Bg4
 NiWa92NZ21dS1nblp5StskJxYQbBXx7X/+4w9AwQwxneIBcjmIrQVCvcyxyNgsWZbr3n
 keQNo+CYNVGnkDy19TwGlJ1OU5efFZ8D11m6FFxZBiOGL8r4mD/n/wEgPCX4BAJlgJ/3
 xSIDvHelrvSk2Xqsv45EipewlE/NTfSFIk3Ob17Yxl7Q3qbWAYt0ix71qxqtcQaqFoYi
 VL+g==
X-Gm-Message-State: AOAM531E+u5p31P8EcjMx6DKNgr7l1CMJF/6AqgUxgSm2VyZ/FA3fKgf
 q6llt95nlL9N8caEbk8Q73OOKwl75YDZ+qnAwar+mz86NZOCZmSYF56ZvmHBVo04zV1LEY9PLMz
 loNXfSNJjltLyF9y5IC2xzcS/AahhcJIcd6AabGHrZQ==
X-Received: by 2002:a50:ab1c:: with SMTP id s28mr18495971edc.214.1627377085976; 
 Tue, 27 Jul 2021 02:11:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9jLapuLuZEDCgBHw695t4KSrnQm7Jq/KQggZxxTimQ6IO2PS6StMUCC0xWCVYqP0gNHGxBQ==
X-Received: by 2002:a50:ab1c:: with SMTP id s28mr18495951edc.214.1627377085756; 
 Tue, 27 Jul 2021 02:11:25 -0700 (PDT)
Received: from redhat.com ([2.55.128.141])
 by smtp.gmail.com with ESMTPSA id a22sm398959ejk.35.2021.07.27.02.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jul 2021 02:11:25 -0700 (PDT)
Date: Tue, 27 Jul 2021 05:11:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ivan <ivan@prestigetransportation.com>
Subject: Re: PROBLEM: virtio_net LRO kernel panics
Message-ID: <20210727050944-mutt-send-email-mst@kernel.org>
References: <CACFia2eLCJuy=w1r20691s_cSYkBkPaY-Dbd-9CkrcpSAe7z6g@mail.gmail.com>
 <5fd9c67f-d900-7694-f0a8-62682c8a14c8@redhat.com>
 <CACFia2eH3eCZxtt70LB5zoPbhLXRv=crPh5oOhR=6mY3auDdQA@mail.gmail.com>
 <20210723035713-mutt-send-email-mst@kernel.org>
 <CACFia2fWhWKMGF3g8SfU++2-jQ1rCKtCJo3h08KmhGfMTuZaQQ@mail.gmail.com>
 <20210723080924-mutt-send-email-mst@kernel.org>
 <CACFia2en0JJDFyz3Umk-JTnMT=kjvRogt4PudED4kiLeMjcHFg@mail.gmail.com>
 <CACFia2fx7Lt-4o_uqDznvk-VgdsMtD64qv6RYkrCjKLu2yt8bg@mail.gmail.com>
 <CACFia2eUi4KNRC7MYktzUS9Nq2WcBiesX04Tbn2pTuvuGkY4qA@mail.gmail.com>
 <CACFia2dns1rTe5OQj4H-kpurVm2CTtGfAXz0aOUS0_cs0QUrsA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACFia2dns1rTe5OQj4H-kpurVm2CTtGfAXz0aOUS0_cs0QUrsA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "David S. Miller" <davem@davemloft.net>,
 virtualization@lists.linux-foundation.org,
 Willem de Bruijn <willemb@google.com>
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

T24gTW9uLCBKdWwgMjYsIDIwMjEgYXQgMDc6NDQ6NDNQTSAtMDUwMCwgSXZhbiB3cm90ZToKPiBP
biBTYXQsIEp1bCAyNCwgMjAyMSBhdCAxMToxOCBQTSBJdmFuIDxpdmFuQHByZXN0aWdldHJhbnNw
b3J0YXRpb24uY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBTYXQsIEp1bCAyNCwgMjAyMSBhdCA3OjE3
IFBNIEl2YW4gPGl2YW5AcHJlc3RpZ2V0cmFuc3BvcnRhdGlvbi5jb20+IHdyb3RlOgo+ID4gPgo+
ID4gPiBPbiBGcmksIEp1bCAyMywgMjAyMSBhdCA3OjMzIEFNIEl2YW4gPGl2YW5AcHJlc3RpZ2V0
cmFuc3BvcnRhdGlvbi5jb20+IHdyb3RlOgo+ID4gPj4KPiA+ID4+IE9uIEZyaSwgSnVsIDIzLCAy
MDIxIGF0IDc6MTAgQU0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4gPiA+Pj4KPiA+ID4+PiBPbiBGcmksIEp1bCAyMywgMjAyMSBhdCAwMzowNjowNEFNIC0wNTAw
LCBJdmFuIHdyb3RlOgo+ID4gPj4+ID4gT24gRnJpLCBKdWwgMjMsIDIwMjEgYXQgMjo1OSBBTSBN
aWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4+PiA+ID4KPiA+
ID4+PiA+ID4gT24gVGh1LCBKdWwgMjIsIDIwMjEgYXQgMTE6NTA6MTFQTSAtMDUwMCwgSXZhbiB3
cm90ZToKPiA+ID4+PiA+ID4gPiBPbiBUaHUsIEp1bCAyMiwgMjAyMSBhdCAxMToyNSBQTSBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4+PiA+ID4gPiA+IOWcqCAy
MDIxLzcvMjMg5LiK5Y2IMTA6NTQsIEl2YW4g5YaZ6YGTOgo+ID4gPj4+ID4gPiA+ID4gPiBPbiBU
aHUsIEp1bCAyMiwgMjAyMSBhdCA5OjM3IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+ID4gPj4+ID4gPiA+ID4gPj4gRG9lcyBpdCB3b3JrIGlmIHlvdSB0dXJuIG9m
ZiBscm8gYmVmb3JlIGVuYWJsaW5nIHRoZSBmb3J3YXJkaW5nPwo+ID4gPj4+ID4gPiA+ID4gPiAw
IHJvb3RATnVSYWlkOn4jIGV0aHRvb2wgLUsgZXRoMCBscm8gb2ZmCj4gPiA+Pj4gPiA+ID4gPiA+
IEFjdHVhbCBjaGFuZ2VzOgo+ID4gPj4+ID4gPiA+ID4gPiByeC1scm86IG9uIFtyZXF1ZXN0ZWQg
b2ZmXQo+ID4gPj4+ID4gPiA+ID4gPiBDb3VsZCBub3QgY2hhbmdlIGFueSBkZXZpY2UgZmVhdHVy
ZXMKPiA+ID4+PiA+ID4gPiA+Cj4gPiA+Pj4gPiA+ID4gPiBPaywgaXQgbG9va3MgbGlrZSB0aGUg
ZGV2aWNlIG1pc3NlcyB0aGUgVklSVElPX05FVF9GX0NUUkxfR1VFU1RfT0ZGTE9BRFMKPiA+ID4+
PiA+ID4gPiA+IHdoaWNoIG1ha2VzIGl0IGltcG9zc2libGUgdG8gY2hhbmdlIHRoZSBMUk8gc2V0
dGluZy4KPiA+ID4+PiA+ID4gPiA+Cj4gPiA+Pj4gPiA+ID4gPiBEaWQgeW91IHVzZSBxZW11PyBJ
ZiB5ZXMsIHdoYXQncyB0aGUgcWVtdSB2ZXJzaW9uIHlvdSd2ZSB1c2VkPwo+ID4gPj4+ID4gPiA+
Cj4gPiA+Pj4gPiA+ID4gVGhlc2UgYXJlIFZpcnR1YWxCb3ggbWFjaGluZXMsIHdoaWNoIEkndmUg
YmVlbiB1c2luZyBmb3IgeWVhcnMgd2l0aAo+ID4gPj4+ID4gPiA+IGxvbmd0ZXJtIGtlcm5lbHMg
NC4xOSwgYW5kIEkgbmV2ZXIgaGFkIHN1Y2ggYSBwcm9ibGVtLiAgQnV0IG5vdyB0aGF0IEkKPiA+
ID4+PiA+ID4gPiB0cmllZCB1cGdyYWRpbmcgdG8ga2VybmVscyA1LjEwIG9yIDUuMTMgLS0gdGhl
IHBhbmljcyBzdGFydGVkLiAgVGhlc2UKPiA+ID4+PiA+ID4gPiBhcmUganVzdCBnZW5lcmljIGtl
cm5lbCBidWlsZHMsIGFuZCBhIG1pbmltYWxpc3RpYyB1c2Vyc3BhY2UuCj4gPiA+Pj4gPiA+Cj4g
PiA+Pj4gPiA+IEkgd291bGQgYmUgdXNlZnVsIHRvIHNlZSB0aGUgZmVhdHVyZXMgeW91ciB2aXJ0
dWFsYm94IGluc3RhbmNlIHByb3ZpZGVzCj4gPiA+Pj4gPiA+Cj4gPiA+Pj4gPiA+IGNhdCAvc3lz
L2NsYXNzL25ldC9ldGgwL2RldmljZS9mZWF0dXJlcwo+ID4gPj4+ID4KPiA+ID4+PiA+ICMgY2F0
IC9zeXMvY2xhc3MvbmV0L2V0aDAvZGV2aWNlL2ZlYXR1cmVzCj4gPiA+Pj4gPiAxMTAwMDEwMTEw
MTExMDExMTExMTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwCj4g
PiA+Pj4KPiA+ID4+PiBJIHdhcyBhYmxlIHRvIHJlcHJvZHVjZSB0aGUgd2FybmluZyBidXQgbm90
IHRoZSBwYW5pYy4KPiA+ID4+PiBPVE9IIGlmIExSTyBzdGF5cyBvbiB3aGVuIGVuYWJsaW5nIGZv
cndhcmRpbmcgdGhhdAo+ID4gPj4+IGlzIGFscmVhZHkgYSBwcm9ibGVtLiBBbnkgY2hhbmNlIHlv
dSBjYW4gYmlzZWN0IHRvCj4gPiA+Pj4gZmluZCBvdXQgd2hpY2ggY2hhbmdlIGludHJvZHVjZWQg
dGhlIHBhbmljPwo+ID4gPj4KPiA+ID4+Cj4gPiA+PiBBbnkga2VybmVscyB1cCB0byA0LjE5LjE5
OCBkb24ndCBwYW5pYy4KPiA+ID4+IEFueSBrZXJuZWxzIDUuMTArIHBhbmljIGltbWVkaWF0ZWx5
IHVwb24gc3RhcnRpbmcgZm9yd2FyZGluZy4KPiA+ID4+IEkgaGF2ZSBub3QgdGVzdGVkIGFueSBr
ZXJuZWxzIGJldHdlZW4gNC4xOSBhbmQgNS4xMC4KPiA+ID4+IEkgZ3Vlc3MgSSBjYW4gYnVpbGQg
YSBmZXcga2VybmVscyBpbmJldHdlZW4sIGFuZCB0cnkgcGlucG9pbnQgd2hlcmUgaXQgc3RhcnRz
Lgo+ID4gPj4gVGhhdCBtYXkgdGFrZSBhIGRheSBvciBzby4gIEknbGwgZ2V0IG9uIHdpdGggaXQg
bm93LCBhbmQgcmVwb3J0IG15IGZpbmRpbmdzLgo+ID4gPgo+ID4gPiBTbywgSSBuYXJyb3dlZCAg
aXQgZG93bjogdGhlIHBhbmljcyBzdGFydCB3aXRoIGtlcm5lbCA1LjAtcmMuCj4gPgo+ID4gTW9y
ZSBuYXJvd2x5LCB0aGUgcHJvYmxlbSBzZWVtcyBiZSBjb21pbmcgZnJvbSBjb21taXQKPiA+IGEw
MmU4OTY0ZWFmOTI3MWE4YTVmY2MwYzU1YmQxM2Y5MzNiYWZjNTYuCj4gPiBKdXN0IHRvIHRlc3Qg
bXkgc3VzcGljaW9uLCBJIGRlbGV0ZWQgYSBmZXcgbGluZXMgZnJvbSB0aGF0IGNvZGUsCj4gPiBh
bmQgdGhlIHBhbmljIHdlbnQgYXdheS4gIEhvcGUgdGhhdCBoZWxwcyB5b3UgZ3V5cyBmaWd1cmUg
b3V0Cj4gPiB3aGF0IHRoZSBwcm9ibGVtIG1pZ2h0IGJlLgoKV2VsbCBpdCBkaXNhYmxlcyBMUk8g
YnV0IHdlIGtuZXcgdGhpcyA6KCBJJ2QgaGVscCBpZiB3ZSBrbmV3CndoZXJlIGRvZXMgaXQgcGFu
aWMsIGFsbCB3ZSBzZWUgaXQgdGhlIHdhcm5pbmcgd2hpY2ggaXMKcmVsYXRlZCBmb3Igc3VyZSBi
dXQgbm90IHRoZSBpbW1lZGlhdGUgcm9vdGNhdXNlIC4uLgoKPiA+Cj4gPiAtLS0gYS9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMKPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4g
QEAgLTI5NzgsMTEgKzI5NzgsNiBAQAo+ID4gICB9Cj4gPiAgIGlmICh2aXJ0aW9faGFzX2ZlYXR1
cmUodmRldiwgVklSVElPX05FVF9GX0dVRVNUX0NTVU0pKQo+ID4gICAgICBkZXYtPmZlYXR1cmVz
IHw9IE5FVElGX0ZfUlhDU1VNOwo+ID4gLSBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJ
UlRJT19ORVRfRl9HVUVTVF9UU080KSB8fAo+ID4gLSAgICB2aXJ0aW9faGFzX2ZlYXR1cmUodmRl
diwgVklSVElPX05FVF9GX0dVRVNUX1RTTzYpKQo+ID4gLSAgICBkZXYtPmZlYXR1cmVzIHw9IE5F
VElGX0ZfTFJPOwo+ID4gLSBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRf
Rl9DVFJMX0dVRVNUX09GRkxPQURTKSkKPiA+IC0gICAgZGV2LT5od19mZWF0dXJlcyB8PSBORVRJ
Rl9GX0xSTzsKPiA+Cj4gPiAgIGRldi0+dmxhbl9mZWF0dXJlcyA9IGRldi0+ZmVhdHVyZXM7Cj4g
Cj4gSnVzdCBGWUksIEdvb2dsZSB0dXJuZWQgdXAgdHdvIHNpbWlsYXIgYnVnIHJlcG9zdHMuLi4K
PiBBcHIgMTQsIDIwMjAgLS0gaHR0cHM6Ly9naXRodWIuY29tL2NvbnRhaW5lcnMvcG9kbWFuL2lz
c3Vlcy81ODE1Cj4gT2N0IDA5LiAyMDIwIC0tIGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9z
aG93X2J1Zy5jZ2k/aWQ9MjA5NTkzCj4gCj4gSXMgdGhlcmUgYW55IHNlbnNpYmxlIHRoaW5nIEkg
Y291bGQgZG8sIHRlbXBvcmFyaWx5LCB1bnRpbCB0aGlzCj4gcHJvYmxlbSBpcyBzb3J0ZWQgb3V0
Pwo+IE9yIGFtIEkgc2ltcGx5IHN0dWNrIHRvIGtlcm5lbHMgNC4xOSBvbiB0aGVzZSBtYWNoaW5l
cyBmb3Igbm93PwoKClNvbWV0aGluZyBsaWtlIHRoaXMgSSBndWVzczoKCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCmluZGV4
IDhhNThhMmYwMTNhZi4uY2M1OTgyMTkzYTQwIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCkBAIC0zMDYzLDYgKzMwNjMs
OCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfdmFsaWRhdGUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZk
ZXYpCiAJCQlfX3ZpcnRpb19jbGVhcl9iaXQodmRldiwgVklSVElPX05FVF9GX01UVSk7CiAJfQog
CisJX192aXJ0aW9fY2xlYXJfYml0KHZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9UU080KTsKKwlf
X3ZpcnRpb19jbGVhcl9iaXQodmRldiwgVklSVElPX05FVF9GX0dVRVNUX1RTTzYpOwogCXJldHVy
biAwOwogfQogCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
