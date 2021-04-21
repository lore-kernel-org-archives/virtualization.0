Return-Path: <SRS0=p2bm=JS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CD5C433ED
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 08:17:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C7A6140C
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 08:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C7A6140C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E581E40634;
	Wed, 21 Apr 2021 08:17:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hzG6E_o7JZVO; Wed, 21 Apr 2021 08:17:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 294B040670;
	Wed, 21 Apr 2021 08:17:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA76EC000E;
	Wed, 21 Apr 2021 08:17:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2BAFC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 08:17:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B7CD40386
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 08:17:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zuI95a98Lumk
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 08:17:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9778440249
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 08:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618993039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P0FbeJ53aKVzlQQGzIJrlpdNfqU7q4WOuEBNdaNenu8=;
 b=fzSOzhdS6FKlSXk+jKOeTWwuiHEksQQHZys8wo/y5uc/26TdV4rkeMHwCkKsGNiU0wxpGF
 ++MVaU+pDrHlE4q8LZfDDT74GVmBTNjXLHi8tegSyUpCQAyGK5PpTkxF96TM0Uofy1SPCC
 IX66EgUo/I1230y/rzHvA4qGst5qq+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-BkXkWc7QOw6372n4GTzxVA-1; Wed, 21 Apr 2021 04:17:17 -0400
X-MC-Unique: BkXkWc7QOw6372n4GTzxVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C74A2107ACC7;
 Wed, 21 Apr 2021 08:17:15 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-189.pek2.redhat.com
 [10.72.13.189])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C8F060C05;
 Wed, 21 Apr 2021 08:17:09 +0000 (UTC)
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210408082648.20145-1-jasowang@redhat.com>
 <20210408115834-mutt-send-email-mst@kernel.org>
 <a6a4ab68-c958-7266-c67c-142960222b67@redhat.com>
 <20210409115343-mutt-send-email-mst@kernel.org>
 <42891807-cb24-5352-f8cb-798e9d1a1854@redhat.com>
 <20210412050730-mutt-send-email-mst@kernel.org>
 <01918e14-7f7a-abf2-5864-292a32f0233c@redhat.com>
 <d5632a4d-4d0b-b08d-06f9-c56f16734607@redhat.com>
 <20210421035331-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3d5754f3-c012-67ad-5f01-fc16ec53df4e@redhat.com>
Date: Wed, 21 Apr 2021 16:17:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210421035331-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: elic@nvidia.com, linux-kernel@vger.kernel.org, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>, virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzQvMjEg5LiL5Y2INDowMywgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiBP
biBXZWQsIEFwciAyMSwgMjAyMSBhdCAwMzo0MTozNlBNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+PiDlnKggMjAyMS80LzEyIOS4i+WNiDU6MjMsIEphc29uIFdhbmcg5YaZ6YGTOgo+Pj4g5Zyo
IDIwMjEvNC8xMiDkuIvljYg1OjA5LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+Pj4+IE9u
IE1vbiwgQXByIDEyLCAyMDIxIGF0IDAyOjM1OjA3UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+Pj4+IOWcqCAyMDIxLzQvMTAg5LiK5Y2IMTI6MDQsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnp
gZM6Cj4+Pj4+PiBPbiBGcmksIEFwciAwOSwgMjAyMSBhdCAxMjo0Nzo1NVBNICswODAwLCBKYXNv
biBXYW5nIHdyb3RlOgo+Pj4+Pj4+IOWcqCAyMDIxLzQvOCDkuIvljYgxMTo1OSwgTWljaGFlbCBT
LiBUc2lya2luIOWGmemBkzoKPj4+Pj4+Pj4gT24gVGh1LCBBcHIgMDgsIDIwMjEgYXQgMDQ6MjY6
NDhQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+Pj4+IFRoaXMgcGF0Y2ggbWFuZGF0
ZXMgMS4wIGZvciB2RFBBIGRldmljZXMuIFRoZSBnb2FsIGlzIHRvIGhhdmUgdGhlCj4+Pj4+Pj4+
PiBzZW1hbnRpYyBvZiBub3JtYXRpdmUgc3RhdGVtZW50IGluIHRoZSB2aXJ0aW8KPj4+Pj4+Pj4+
IHNwZWMgYW5kIGVsaW1pbmF0ZSB0aGUKPj4+Pj4+Pj4+IGJ1cmRlbiBvZiB0cmFuc2l0aW9uYWwg
ZGV2aWNlIGZvciBib3RoIHZEUEEgYnVzIGFuZCB2RFBBIHBhcmVudC4KPj4+Pj4+Pj4+Cj4+Pj4+
Pj4+PiB1QVBJIHNlZW1zIGZpbmUgc2luY2UgYWxsIHRoZSB2RFBBIHBhcmVudCBtYW5kYXRlcwo+
Pj4+Pj4+Pj4gVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIHdoaWNoIGltcGxpZXMgMS4wIGRldmlj
ZXMuCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gRm9yIGxlZ2FjeSBndWVzdHMsIGl0IGNhbiBzdGlsbCB3
b3JrIHNpbmNlIFFlbXUgd2lsbCBtZWRpYXRlIHdoZW4KPj4+Pj4+Pj4+IG5lY2Vzc2FyeSAoZS5n
IGRvaW5nIHRoZSBlbmRpYW4gY29udmVyc2lvbikuCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gU2lnbmVk
LW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4+Pj4+Pj4gSG1tLiBJ
ZiB3ZSBkbyB0aGlzLCBkb24ndCB3ZSBzdGlsbCBoYXZlIGEgcHJvYmxlbSB3aXRoCj4+Pj4+Pj4+
IGxlZ2FjeSBkcml2ZXJzIHdoaWNoIGRvbid0IGFjayAxLjA/Cj4+Pj4+Pj4gWWVzLCBidXQgaXQn
cyBub3Qgc29tZXRoaW5nIHRoYXQgaXMgaW50cm9kdWNlZCBpbiB0aGlzCj4+Pj4+Pj4gY29tbWl0
LiBUaGUgbGVnYWN5Cj4+Pj4+Pj4gZHJpdmVyIG5ldmVyIHdvcmsgLi4uCj4+Pj4+PiBNeSBwb2lu
dCBpcyB0aGlzIG5laXRoZXIgZml4ZXMgb3IgcHJldmVudHMgdGhpcy4KPj4+Pj4+Cj4+Pj4+PiBT
byBteSBzdWdnZXN0aW9uIGlzIHRvIGZpbmFsbHkgYWRkIGlvY3RscyBhbG9uZyB0aGUgbGluZXMK
Pj4+Pj4+IG9mIFBST1RPQ09MX0ZFQVRVUkVTIG9mIHZob3N0LXVzZXIuCj4+Pj4+Pgo+Pj4+Pj4g
VGhlbiB0aGF0IG9uZSBjYW4gaGF2ZSBiaXRzIGZvciBsZWdhY3kgbGUsIGxlZ2FjeSBiZSBhbmQg
bW9kZXJuLgo+Pj4+Pj4KPj4+Pj4+IEJUVyBJIGxvb2tlZCBhdCB2aG9zdC11c2VyIGFuZCBpdCBk
b2VzIG5vdCBsb29rIGxpa2UgdGhhdAo+Pj4+Pj4gaGFzIGEgc29sdXRpb24gZm9yIHRoaXMgcHJv
YmxlbSBlaXRoZXIsIHJpZ2h0Pwo+Pj4+PiBSaWdodC4KPj4+Pj4KPj4+Pj4KPj4+Pj4+Pj4gTm90
ZSAxLjAgYWZmZWN0cyByaW5nIGVuZGlhbm5lc3Mgd2hpY2ggaXMgbm90IG1lZGlhdGVkIGluIFFF
TVUKPj4+Pj4+Pj4gc28gUUVNVSBjYW4ndCBwcmV0ZW5kIHRvIGRldmljZSBndWVzdCBpcyAxLjAu
Cj4+Pj4+Pj4gUmlnaHQsIEkgcGxhbiB0byBzZW5kIHBhdGNoZXMgdG8gZG8gbWVkaWF0aW9uIGlu
IHRoZQo+Pj4+Pj4+IFFlbXUgdG8gdW5icmVhayBsZWdhY3kKPj4+Pj4+PiBkcml2ZXJzLgo+Pj4+
Pj4+Cj4+Pj4+Pj4gVGhhbmtzCj4+Pj4+PiBJIGZyYW5rbHkgdGhpbmsgd2UnbGwgbmVlZCBQUk9U
T0NPTF9GRUFUVVJFUyBhbnl3YXksIGl0J3MKPj4+Pj4+IHRvbyB1c2VmdWwgLi4uCj4+Pj4+PiBz
byB3aHkgbm90IHRlYWNoIGRyaXZlcnMgYWJvdXQgaXQgYW5kIGJlIGRvbmUgd2l0aCBpdD8gWW91
Cj4+Pj4+PiBjYW4ndCBlbXVsYXRlCj4+Pj4+PiBsZWdhY3kgb24gbW9kZXJuIGluIGEgY3Jvc3Mg
ZW5kaWFuIHNpdHVhdGlvbiBiZWNhdXNlIG9mIHZyaW5nCj4+Pj4+PiBlbmRpYW4tbmVzcyAuLi4K
Pj4+Pj4gU28gdGhlIHByb2JsZW0gc3RpbGwuIFRoaXMgY2FuIG9ubHkgd29yayB3aGVuIHRoZSBo
YXJkd2FyZSBjYW4gc3VwcG9ydAo+Pj4+PiBsZWdhY3kgdnJpbmcgZW5kaWFuLW5lc3MuCj4+Pj4+
Cj4+Pj4+IENvbnNpZGVyOgo+Pj4+Pgo+Pj4+PiAxKSB0aGUgbGVhZ2N5IGRyaXZlciBzdXBwb3J0
IGlzIG5vbi1ub3JtYXRpdmUgaW4gdGhlIHNwZWMKPj4+Pj4gMikgc3VwcG9ydCBhIHRyYW5zaXRp
b25hbCBkZXZpY2UgaW4gdGhlIGtlbnJlbCBtYXkgcmVxdWlyZXMgdGhlCj4+Pj4+IGhhcmR3YXJl
Cj4+Pj4+IHN1cHBvcnQgYW5kIGEgYnVyZGVuIG9mIGtlcm5lbCBjb2Rlcwo+Pj4+Pgo+Pj4+PiBJ
J2QgcmF0aGVyIHNpbXBseSBkcm9wIHRoZSBsZWdhY3kgZHJpdmVyIHN1cHBvcnQKPj4+PiBNeSBw
b2ludCBpcyB0aGlzIHBhdGNoIGRvZXMgbm90IGRyb3AgbGVnYWN5IHN1cHBvcnQuIEl0IG1lcmVs
eSBtYW5kYXRlcwo+Pj4+IG1vZGVybiBzdXBwb3J0Lgo+Pj4KPj4+IEkgYW0gbm90IHN1cmUgSSBn
ZXQgaGVyZS4gVGhpcyBwYXRjaCBmYWlscyB0aGUgc2V0X2ZlYXR1cmUgaWYgVkVSU0lPTl8xCj4+
PiBpcyBub3QgbmVnb3RpYXRlZC4gVGhpcyBtZWFuczoKPj4+Cj4+PiAxKSB2RFBBIHByZXNlbnRz
IGEgbW9kZXJuIGRldmljZSBpbnN0ZWFkIG9mIHRyYW5zaXRvbmFsIGRldmljZQo+Pj4gMikgbGVn
YWN5IGRyaXZlciBjYW4ndCBiZSBwcm9iZWQKPj4+Cj4+PiBXaGF0IEknbSBtaXNzaW5nPwo+Pgo+
PiBIaSBNaWNoYWVsOgo+Pgo+PiBEbyB5b3UgYWdyZWUgdG8gZmluZCB0aGUgd2F5IHRvIHByZXNl
bnQgbW9kZXJuIGRldmljZT8gV2UgbmVlZCBhIGNvbmNsdXNpb24KPj4gdG8gbWFrZSB0aGUgbmV0
bGluayBBUEkgd29yayB0byBtb3ZlIGZvcndhcmQuCj4+Cj4+IFRoYW5rcwo+IEkgdGhpbmsgd2Ug
bmVlZCBhIHdheSB0byBzdXBwb3J0IGxlZ2FjeSB3aXRoIG5vIGRhdGEgcGF0aCBvdmVyaGVhZC4g
cWVtdQo+IHNldHRpbmcgVkVSU0lPTl8xIGZvciBhIGxlZ2FjeSBndWVzdCBhZmZlY3RzIHRoZSBy
aW5nIGZvcm1hdCBzbyBpdCBkb2VzCj4gbm90IHJlYWxseSB3b3JrLiBUaGlzIHNlZW1zIHRvIHJ1
bGUgb3V0IGVtdWxhdGluZyBjb25maWcgc3BhY2UgZW50aXJlbHkKPiBpbiB1c2Vyc3BhY2UuCgoK
U28gSSdkIHJhdGhlciBkcm9wIHRoZSBsZWdhY3kgc3VwcG9ydCBpbiB0aGlzIGNhc2UuIEl0IG5l
dmVyIHdvcmsgZm9yIAp2RFBBIGluIHRoZSBwYXN0IGFuZCB2aXJ0aW8tdkRQQSBkb2Vzbid0IGV2
ZW4gbmVlZCB0aGF0LiBOb3RlIHRoYXQgCkFDQ0VTU19QTEFURk9STSBpcyBtYW5kYXRlZCBmb3Ig
YWxsIHRoZSB2RFBBIHBhcmVudHMgcmlnaHQgbm93IHdoaWNoIAppbXBsaWVzIG1vZGVybiBkZXZp
Y2UgYW5kIExFLiBJIHdvbmRlciB3aGF0J3MgdGhlIHZhbHVlIGZvciBzdXBwb3J0aW5nIApsZWdh
Y3kgaW4gdGhpcyBjYXNlIG9yIGRvIHdlIHJlYWxseSBlbmNvdXJhZ2UgdmVuZG9ycyB0byBzaGlw
IGNhcmQgd2l0aCAKbGVnYWN5IHN1cHBvcnQgKGUuZyBlbmRpYW4gc3VwcG9ydCBpbiB0aGUgaGFy
ZHdhcmUpPwoKCj4KPiBTbyBJIHRoaW5rIHdlIHNob3VsZCBhZGQgYW4gaW9jdGwgYWxvbmcgdGhl
IGxpbmVzIG9mCj4gcHJvdG9jb2wgZmVhdHVyZXMuIFRoZW4gSSB0aGluayB3ZSBjYW4gcmVzZXJ2
ZSBmZWF0dXJlIGJpdHMKPiBmb3IgY29uZmlnIHNwYWNlIGZvcm1hdDogbGVnYWN5IExFLCBsZWdh
Y3kgQkUsIG1vZGVybi4KCgpXZSBoYWQgVkhPU1RfU0VUX1ZSSU5HX0VORElBTiBidXQgdGhpcyB3
aWxsIGNvbXBsaWNhdGVzIGJvdGggdGhlIHZEUEEgCnBhcmVudCBhbmQgbWFuYWdlbWVudC4gV2hh
dCdzIG1vcmUgaW1wb3J0YW50LCBsZWdhY3kgYmVoYXZpb3VyIGlzIG5vdCAKcmVzdHJpY3RpZWQg
YnkgdGhlIHNwZWMuCgoKPgo+IFF1ZXJ5aW5nIHRoZSBmZWF0dXJlIGJpdHMgd2lsbCBwcm92aWRl
IHVzIHdpdGggaW5mbyBhYm91dAo+IHdoYXQgZG9lcyB0aGUgZGV2aWNlIHN1cHBvcnQuIEFja2lu
ZyB0aGVtIHdpbGwgdGVsbCBkZXZpY2UKPiB3aGF0IGRvZXMgZ3Vlc3QgbmVlZC4KCgpJIHRoaW5r
IHRoaXMgY2FuIHdvcmssIGJ1dCBJIHdvbmRlciBob3cgbXVjaCB3ZSBjYW4gZ2FpbiBmcm9tIHN1
Y2ggCmNvbXBsZXhpdGl5LgoKVGhhbmtzCgoKPgo+Cj4KPgo+Cj4+Pgo+Pj4+PiB0byBoYXZlIGEg
c2ltcGxlIGFuZCBlYXN5Cj4+Pj4+IGFic3RhcmN0aW9uIGluIHRoZSBrZW5yZWwuIEZvciBsZWdh
Y3kgZHJpdmVyIGluIHRoZSBndWVzdCwKPj4+Pj4gaHlwZXJ2aXNvciBpcyBpbgo+Pj4+PiBjaGFy
Z2Ugb2YgdGhlIG1lZGlhdGlvbjoKPj4+Pj4KPj4+Pj4gMSkgY29uZmlnIHNwYWNlIGFjY2VzcyBl
bmRpYW4gY29udmVyc2lvbgo+Pj4+PiAyKSB1c2luZyBzaGFkb3cgdmlydHF1ZXVlIHRvIGNoYW5n
ZSB0aGUgZW5kaWFuIGluIHRoZSB2cmluZwo+Pj4+Pgo+Pj4+PiBUaGFua3MKPj4+PiBJJ2QgbGlr
ZSB0byBhdm9pZCBzaGFkb3cgdmlydHF1ZXVlIGhhY2tzIGlmIGF0IGFsbCBwb3NzaWJsZS4KPj4+
PiBMYXN0IEkgY2hlY2tlZCBwZXJmb3JtYW5jZSB3YXNuJ3QgbXVjaCBiZXR0ZXIgdGhhbiBqdXN0
IGVtdWxhdGluZwo+Pj4+IHZpcnRpbyBpbiBzb2Z0d2FyZS4KPj4+Cj4+PiBJIHRoaW5rIHRoZSBs
ZWdhY3kgZHJpdmVyIHN1cHBvcnQgaXMganVzdCBhIG5pY2UgdG8gaGF2ZS4gT3IgZG8geW91IHNl
ZQo+Pj4gYW55IHZhbHVlIHRvIHRoYXQ/IEkgZ3Vlc3MgZm9yIG1lbGxhbm94IGFuZCBpbnRlbCwg
b25seSBtb2Rlcm4gZGV2aWNlIGlzCj4+PiBzdXBwb3J0ZWQgaW4gdGhlIGhhcmR3YXJlLgo+Pj4K
Pj4+IFRoYW5rcwo+Pj4KPj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiAtLS0KPj4+Pj4+
Pj4+ICDCoMKgwqAgaW5jbHVkZS9saW51eC92ZHBhLmggfCA2ICsrKysrKwo+Pj4+Pj4+Pj4gIMKg
wqDCoCAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92ZHBhLmgK
Pj4+Pj4+Pj4+IGluZGV4IDBmZWZlYjk3Njg3Ny4uY2ZkZTRlYzk5OWI0IDEwMDY0NAo+Pj4+Pj4+
Pj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4+Pj4+Pj4+ICsrKyBiL2luY2x1ZGUvbGlu
dXgvdmRwYS5oCj4+Pj4+Pj4+PiBAQCAtNiw2ICs2LDcgQEAKPj4+Pj4+Pj4+ICDCoMKgwqAgI2lu
Y2x1ZGUgPGxpbnV4L2RldmljZS5oPgo+Pj4+Pj4+Pj4gIMKgwqDCoCAjaW5jbHVkZSA8bGludXgv
aW50ZXJydXB0Lmg+Cj4+Pj4+Pj4+PiAgwqDCoMKgICNpbmNsdWRlIDxsaW51eC92aG9zdF9pb3Rs
Yi5oPgo+Pj4+Pj4+Pj4gKyNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19jb25maWcuaD4KPj4+
Pj4+Pj4+ICDCoMKgwqAgLyoqCj4+Pj4+Pj4+PiAgwqDCoMKgwqAgKiB2RFBBIGNhbGxiYWNrIGRl
ZmluaXRpb24uCj4+Pj4+Pj4+PiBAQCAtMzE3LDYgKzMxOCwxMSBAQCBzdGF0aWMgaW5saW5lIGlu
dAo+Pj4+Pj4+Pj4gdmRwYV9zZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1
NjQKPj4+Pj4+Pj4+IGZlYXR1cmVzKQo+Pj4+Pj4+Pj4gIMKgwqDCoCB7Cj4+Pj4+Pj4+PiAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2
ZGV2LT5jb25maWc7Cj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgLyogTWFuZGF0aW5nIDEuMCB0
byBoYXZlIHNlbWFudGljcyBvZgo+Pj4+Pj4+Pj4gbm9ybWF0aXZlIHN0YXRlbWVudHMgaW4KPj4+
Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogdGhlIHNwZWMuICovCj4+Pj4+Pj4+PiArwqDCoMKg
wqDCoMKgwqAgaWYgKCEoZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19GX1ZFUlNJT05fMSkpKQo+
Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+Pj4+Pj4+Pj4gKwo+Pj4+
Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgIHZkZXYtPmZlYXR1cmVzX3ZhbGlkID0gdHJ1ZTsKPj4+Pj4+
Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBvcHMtPnNldF9mZWF0dXJlcyh2ZGV2
LCBmZWF0dXJlcyk7Cj4+Pj4+Pj4+PiAgwqDCoMKgIH0KPj4+Pj4+Pj4+IC0tIAo+Pj4+Pj4+Pj4g
Mi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
