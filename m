Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F91C00140
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 20:08:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEE3360768;
	Mon,  8 Aug 2022 20:08:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AEE3360768
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.a=rsa-sha256 header.s=ds202112 header.b=jq2HrWKI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6wyIDFT45ipo; Mon,  8 Aug 2022 20:08:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0CA2F6059F;
	Mon,  8 Aug 2022 20:08:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0CA2F6059F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D54EDC0033;
	Mon,  8 Aug 2022 20:08:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5F7CC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 20:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7ABB1402B8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 20:08:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7ABB1402B8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org
 header.a=rsa-sha256 header.s=ds202112 header.b=jq2HrWKI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rAVrhAQjlJaD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 20:08:33 +0000 (UTC)
X-Greylist: delayed 00:07:31 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 21680402A1
Received: from smtp.domeneshop.no (smtp.domeneshop.no
 [IPv6:2a01:5b40:0:3005::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 21680402A1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 20:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
 ; s=ds202112;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c7Zd4O0W+WvPJ2kFFhB/D//vEX5vQtcJh1hMBR2QZy4=; b=jq2HrWKIWNi9tUpohTPdrWD786
 fOtUK4PsKHgnYx3UQRr2zPHRRNDw1rusFYbzEnWNjl3Nh793tU+5QZvTrpSbh9MGsyGpZreI5Bye4
 xMjMlw3aP4qHr0hqFjg/VSu6htf3E31LbqEWUFN11QYLd3949gITYETlKm+Z4bBaSrFhFIMGqnoWS
 5MDtw8qksvaOy6rB96K0rqWVpGQbwcLtUV6TFgeQWIIoglOg5MhSZ4FRmrirvZkgfACeIy1tq5g8f
 Ex9nuiM9rwDmrpxyehB/Yv+NHUZLu8CAuDHbBVSpS0FP/KZwBj0co8HbJOCX8B5CsBtrTtdo/nvwa
 E0q2+umw==;
Received: from [2a01:799:961:d200:c193:6d77:c9c8:8] (port=62215)
 by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <noralf@tronnes.org>)
 id 1oL8vq-0002K0-NE; Mon, 08 Aug 2022 22:00:58 +0200
Message-ID: <3ecad8dc-5fcf-c63a-ce3c-aa4c3ef22850@tronnes.org>
Date: Mon, 8 Aug 2022 22:00:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 00/14] drm/format-helper: Move to struct iosys_map
To: Thomas Zimmermann <tzimmermann@suse.de>, sam@ravnborg.org,
 jose.exposito89@gmail.com, javierm@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@linux.ie,
 daniel@ffwll.ch, drawat.floss@gmail.com, lucas.demarchi@intel.com,
 david@lechnology.com, kraxel@redhat.com
References: <20220808125406.20752-1-tzimmermann@suse.de>
From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220808125406.20752-1-tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org,
 =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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

CgpEZW4gMDguMDguMjAyMiAxNC41Mywgc2tyZXYgVGhvbWFzIFppbW1lcm1hbm46Cj4gQ2hhbmdl
IGZvcm1hdC1jb252ZXJzaW9uIGhlbHBlcnMgdG8gdXNlIHN0cnVjdCBpb3N5c19tYXAgZm9yIHNv
dXJjZQo+IGFuZCBkZXN0aW5hdGlvbiBidWZmZXJzLiBVcGRhdGUgYWxsIHVzZXJzLiBBbHNvIHBy
ZXBhcmUgaW50ZXJmYWNlIGZvcgo+IG11bHRpLXBsYW5lIGNvbG9yIGZvcm1hdHMuCj4gCj4gVGhl
IGZvcm1hdC1jb252ZXJzaW9uIGhlbHBlcnMgbW9zdGx5IHVzZWQgdG8gY29udmVydCB0byBJL08g
bWVtb3J5Cj4gb3Igc3lzdGVtIG1lbW9yeS4gVG8gYWN0dWFsIG1lbW9yeSB0eXBlIGRlcGVuZGVk
IG9uIHRoZSB1c2VjYXNlLiBXZQo+IG5vdyBoYXZlIGRyaXZlcnMgdXBjb21taW5nIHRoYXQgZG8g
dGhlIGNvbnZlcnNpb24gZW50aXJlbHkgaW4gc3lzdGVtCj4gbWVtb3J5LiBJdCdzIGEgZ29vZCBv
cHBvcnR1bml0eSB0byBzdHJlYW0tbGluZSB0aGUgaW50ZXJmYWNlIG9mIHRoZQo+IGNvbnZlcnNp
b24gaGVscGVycyB0byB1c2Ugc3RydWN0IGlvc3lzX21hcC4gU291cmNlIGFuZCBkZXN0aW5hdGlv
bgo+IGJ1ZmZlcnMgY2FuIG5vdyBiZSBlaXRoZXIgaW4gc3lzdGVtIG9yIGluIEkvTyBtZW1vcnku
IE5vdGUgdGhhdCB0aGUKPiBpbXBsZW1lbnRhdGlvbiBzdGlsbCBvbmx5IHN1cHBvcnRzIHNvdXJj
ZSBidWZmZXJzIGluIHN5c3RlbSBtZW1vcnkuCj4gCj4gVGhpcyBwYXRjaHNldCBhbHNvIGNoYW5n
ZXMgdGhlIGludGVyZmFjZSB0byBzdXBwb3J0IG11bHRpLXBsYW5lCj4gY29sb3IgZm9ybWF0cywg
d2hlcmUgdGhlIHZhbHVlcyBmb3IgZWFjaCBjb21wb25lbnQgYXJlIHN0b3JlZCBpbgo+IGRpc3Rp
bmN0IG1lbW9yeSBsb2NhdGlvbnMuIENvbnZlcnRpbmcgZnJvbSBSR0JSR0JSR0IgdG8gUlJSR0dH
QkJCCj4gd291bGQgcmVxdWlyZSBhIHNpbmdsZSBzb3VyY2UgYnVmZmVyIHdpdGggUkdCIHZhbHVl
cyBhbmQgMyBkZXN0aW5hdGlvbgo+IGJ1ZmZlcnMgZm9yIHRoZSBSLCBHIGFuZCBCIHZhbHVlcy4g
Q29udmVyc2lvbi1oZWxwZXIgaW50ZXJmYWNlcyBub3cKPiBzdXBwb3J0IHRoaXMuCj4gCj4gdjI6
Cj4gCSogYWRkIElPU1lTX01BUF9JTklUX1ZBRERSX0lPTUVNIChTYW0pCj4gCSogdXNlIGRybV9m
b3JtYXRfaW5mb19icHAoKSAoU2FtKQo+IAkqIHVwZGF0ZSBkb2N1bWVudGF0aW9uIChTYW0pCj4g
CSogcmVuYW1lICd2bWFwJyB0byAnc3JjJyAoU2FtKQo+IAkqIG1hbnkgc21hbGxlciBjbGVhbnVw
cyBhbmQgZml4ZXMgKFNhbSwgSm9zZSkKPiAKPiBUaG9tYXMgWmltbWVybWFubiAoMTQpOgo+ICAg
aW9zeXMtbWFwOiBBZGQgSU9TWVNfTUFQX0lOSVRfVkFERFJfSU9NRU0oKQo+ICAgZHJtL2Zvcm1h
dC1oZWxwZXI6IFByb3ZpZGUgZHJtX2ZiX2JsaXQoKQo+ICAgZHJtL2Zvcm1hdC1oZWxwZXI6IE1l
cmdlIGRybV9mYl9tZW1jcHkoKSBhbmQgZHJtX2ZiX21lbWNweV90b2lvKCkKPiAgIGRybS9mb3Jt
YXQtaGVscGVyOiBDb252ZXJ0IGRybV9mYl9zd2FiKCkgdG8gc3RydWN0IGlvc3lzX21hcAo+ICAg
ZHJtL2Zvcm1hdC1oZWxwZXI6IFJld29yayBYUkdCODg4OC10by1SR0JHMzMyIGNvbnZlcnNpb24K
PiAgIGRybS9mb3JtYXQtaGVscGVyOiBSZXdvcmsgWFJHQjg4ODgtdG8tUkdCRzU2NSBjb252ZXJz
aW9uCj4gICBkcm0vZm9ybWF0LWhlbHBlcjogUmV3b3JrIFhSR0I4ODg4LXRvLVJHQjg4OCBjb252
ZXJzaW9uCj4gICBkcm0vZm9ybWF0LWhlbHBlcjogUmV3b3JrIFJHQjU2NS10by1YUkdCODg4OCBj
b252ZXJzaW9uCj4gICBkcm0vZm9ybWF0LWhlbHBlcjogUmV3b3JrIFJHQjg4OC10by1YUkdCODg4
OCBjb252ZXJzaW9uCj4gICBkcm0vZm9ybWF0LWhlbHBlcjogUmV3b3JrIFhSR0I4ODg4LXRvLVhS
R0IyMTAxMDEwIGNvbnZlcnNpb24KPiAgIGRybS9mb3JtYXQtaGVscGVyOiBSZXdvcmsgWFJHQjg4
ODgtdG8tR1JBWTggY29udmVyc2lvbgo+ICAgZHJtL2Zvcm1hdC1oZWxwZXI6IFJld29yayBYUkdC
ODg4OC10by1NT05PIGNvbnZlcnNpb24KPiAgIGRybS9mb3JtYXQtaGVscGVyOiBNb3ZlIGRlc3Rp
bmF0aW9uLWJ1ZmZlciBoYW5kbGluZyBpbnRvIGludGVybmFsCj4gICAgIGhlbHBlcgo+ICAgZHJt
L2Zvcm1hdC1oZWxwZXI6IFJlbmFtZSBwYXJhbWV0ZXIgdm1hcCB0byBzcmMKPiAKClRlc3RlZC1i
eTogTm9yYWxmIFRyw7hubmVzIDxub3JhbGZAdHJvbm5lcy5vcmc+CgoqIGd1ZDogWFJHQjg4ODgt
dG8te01PTk8sR1JBWTgsUkdCMzMyLFJHQjU2NX0KKiBtaTAyODNxdCAoZHJtX21pcGlfZGJpKTog
WFJHQjg4ODgtdG8tUkdCNTY1IHdpdGggc3dhcD10cnVlLApkcm1fZmJfbWVtY3B5LCBkcm1fZmJf
c3dhYgoKPiAgZHJpdmVycy9ncHUvZHJtL2RybV9mb3JtYXRfaGVscGVyLmMgICAgICAgICAgIHwg
NTA5ICsrKysrKysrKystLS0tLS0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vZHJtX21pcGlfZGJpLmMg
ICAgICAgICAgICAgICAgfCAgIDkgKy0KPiAgZHJpdmVycy9ncHUvZHJtL2d1ZC9ndWRfcGlwZS5j
ICAgICAgICAgICAgICAgIHwgIDIwICstCj4gIGRyaXZlcnMvZ3B1L2RybS9oeXBlcnYvaHlwZXJ2
X2RybV9tb2Rlc2V0LmMgICB8ICAgOSArLQo+ICBkcml2ZXJzL2dwdS9kcm0vbWdhZzIwMC9tZ2Fn
MjAwX21vZGUuYyAgICAgICAgfCAgIDkgKy0KPiAgZHJpdmVycy9ncHUvZHJtL3NvbG9tb24vc3Nk
MTMweC5jICAgICAgICAgICAgIHwgICA3ICstCj4gIC4uLi9ncHUvZHJtL3Rlc3RzL2RybV9mb3Jt
YXRfaGVscGVyX3Rlc3QuYyAgICB8ICA0NSArLQo+ICBkcml2ZXJzL2dwdS9kcm0vdGlueS9jaXJy
dXMuYyAgICAgICAgICAgICAgICAgfCAgMTkgKy0KPiAgZHJpdmVycy9ncHUvZHJtL3RpbnkvcmVw
YXBlci5jICAgICAgICAgICAgICAgIHwgICA2ICstCj4gIGRyaXZlcnMvZ3B1L2RybS90aW55L3Np
bXBsZWRybS5jICAgICAgICAgICAgICB8ICAgOCArLQo+ICBkcml2ZXJzL2dwdS9kcm0vdGlueS9z
dDc1ODYuYyAgICAgICAgICAgICAgICAgfCAgIDUgKy0KPiAgaW5jbHVkZS9kcm0vZHJtX2Zvcm1h
dF9oZWxwZXIuaCAgICAgICAgICAgICAgIHwgIDU2ICstCj4gIGluY2x1ZGUvbGludXgvaW9zeXMt
bWFwLmggICAgICAgICAgICAgICAgICAgICB8ICAxNSArLQo+ICAxMyBmaWxlcyBjaGFuZ2VkLCA0
MTYgaW5zZXJ0aW9ucygrKSwgMzAxIGRlbGV0aW9ucygtKQo+IAo+IAo+IGJhc2UtY29tbWl0OiAy
YmRhZTY2Yzk5ODhkZDBmMDc2MzM2MjljMGE4NTM4M2NmYzA1OTQwCj4gcHJlcmVxdWlzaXRlLXBh
dGNoLWlkOiBjMmIyZjA4ZjBlY2NjOWY1ZGYwYzBkYTQ5ZmExZDM2MjY3ZGViMTFkCj4gcHJlcmVx
dWlzaXRlLXBhdGNoLWlkOiBjNjdlNWQ4ODZhNDdiN2QwMjY2ZDgxMTAwODM3NTU3ZmRhMzRjYjI0
Cj4gcHJlcmVxdWlzaXRlLXBhdGNoLWlkOiAzZjIwNDUxMGZjYmY5NTMwZDY1NDBiZDhlNjEyOGNj
ZTU5ODk4OGI2Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
