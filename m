Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C8CC04A68
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 01:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 164A940A37;
	Thu, 28 Jul 2022 01:22:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 164A940A37
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ERfqxfit
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3lRtJLQk3d2e; Thu, 28 Jul 2022 01:22:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6718540462;
	Thu, 28 Jul 2022 01:22:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6718540462
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27050C0035;
	Thu, 28 Jul 2022 01:22:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0636C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 01:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76F3E404BA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 01:22:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 76F3E404BA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YbidRn4D41Lb
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 01:22:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 809B840462
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 809B840462
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 01:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658971326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1Znmlu63Erey1IsixFqUUX+KxOGTKzA8el4/bq2d5M=;
 b=ERfqxfitgWBY16Whj/8WUiyflcQojOQPR9CvtF7OstC/9a2CGCGpVD0Gwu2U8n/qGK3Tpn
 OVFnR/BhhwfT59HlOezyTNi14Zb+7/7+D6DawH2MmBnPdif2HPm11wKQLA1iNUrAKVykKe
 v5gDO8SRvyqbWrrum8xyU8D9Ufpn/i4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-Zf3jdL06N1Cj02rShuZlTg-1; Wed, 27 Jul 2022 21:22:04 -0400
X-MC-Unique: Zf3jdL06N1Cj02rShuZlTg-1
Received: by mail-lf1-f72.google.com with SMTP id
 c19-20020a056512325300b0048a81ce21c9so165575lfr.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 18:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=J1Znmlu63Erey1IsixFqUUX+KxOGTKzA8el4/bq2d5M=;
 b=obZ3lbmDDHFPpbUKWERee46OVcq3M+z6DQ4lIFAX2+MK9K0ySYS94s/YG+m/6gJgJq
 GEu1O0016WVs5MEzDRuFGBY6dNFTGVcx49CTLnk4W4Sg8ammcdzkkZp8oaKkbwwkJ/79
 qBrST3SDuc4tEUCA4bzlOBjCvTuHT+Z9U8EvvmGuNQEouvUwfR7eSITZpaoWbp95EE69
 f1UB6tzHfcfUld0vga13GqwIJvzaMmCNWndXIUrbr8uniY3BK42iAUntuuMon0j/qZg3
 eqpFpP1iwmokK1aQbQJFO31UsqYKS9JlfzV3rnmnCn9b3xukyHfhPhze+BiTL4qH2E16
 wMGQ==
X-Gm-Message-State: AJIora8cWssyt00P+p7eb9ctZzw2a8ikuad2qKL+V2TGpWZArgUShSRE
 okei9XsKWAIRx2mVxOnRJFTqPcxlbn3hK/k2j+JsRtgXMnli/cxojOLfG1EhGX7k7cvvphMFUJD
 EOBwiTosAfoWDl8EONNzEDlma/sRcJVA81udd6QuizLxCtU2TR7mdkX67iQ==
X-Received: by 2002:a05:6512:b0d:b0:481:5cb4:cf1e with SMTP id
 w13-20020a0565120b0d00b004815cb4cf1emr8766411lfu.442.1658971322974; 
 Wed, 27 Jul 2022 18:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t5yxyiTp0u/B4D6tJQ9YC9z6eOVv3G44gn3eTDZDSpBH6d3EYrhhZbn+OQ28uEDHkdipKpVfwdWTOZZhVPwD4=
X-Received: by 2002:a05:6512:b0d:b0:481:5cb4:cf1e with SMTP id
 w13-20020a0565120b0d00b004815cb4cf1emr8766401lfu.442.1658971322340; Wed, 27
 Jul 2022 18:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <1246d2f1-2822-0edb-cd57-efc4015f05a2@intel.com>
 <PH0PR12MB54815985C202E81122459DFFDC949@PH0PR12MB5481.namprd12.prod.outlook.com>
 <19681358-fc81-be5b-c20b-7394a549f0be@intel.com>
 <PH0PR12MB54818158D4F7F9F556022857DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e98fc062-021b-848b-5cf4-15bd63a11c5c@intel.com>
 <PH0PR12MB54815AD7D0674FEB1D63EB61DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220727015626-mutt-send-email-mst@kernel.org>
 <CACGkMEv62tuOP3ra0GBhjCH=syFWxP+GVfGL_i0Ce0iD4uMY=Q@mail.gmail.com>
 <20220727050222-mutt-send-email-mst@kernel.org>
 <CACGkMEtDFUGX17giwYdF58QJ1ccZJDJg1nFVDkSeB27sfZz28g@mail.gmail.com>
 <20220727114419-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220727114419-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Jul 2022 09:21:51 +0800
Message-ID: <CACGkMEv80RTtuyw5RtwgTHUphS1s2oTeb94tc6Tx7LbJWKsEBw@mail.gmail.com>
Subject: Re: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
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

T24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMTE6NDUgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIEp1bCAyNywgMjAyMiBhdCAwNTo1MDo1OVBN
ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gT24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgNTow
MyBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4KPiA+
ID4gT24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMDI6NTQ6MTNQTSArMDgwMCwgSmFzb24gV2FuZyB3
cm90ZToKPiA+ID4gPiBPbiBXZWQsIEp1bCAyNywgMjAyMiBhdCAyOjAxIFBNIE1pY2hhZWwgUy4g
VHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+IE9uIFdl
ZCwgSnVsIDI3LCAyMDIyIGF0IDAzOjQ3OjM1QU0gKzAwMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToK
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56
aHVAaW50ZWwuY29tPgo+ID4gPiA+ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjYsIDIwMjIg
MTA6NTMgUE0KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IE9uIDcvMjcvMjAyMiAxMDoxNyBB
TSwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4+IEZyb206IFpodSwgTGluZ3No
YW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4gPiA+ID4gPiA+ID4gPj4gU2VudDogVHVlc2Rh
eSwgSnVseSAyNiwgMjAyMiAxMDoxNSBQTQo+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4g
Pj4gT24gNy8yNi8yMDIyIDExOjU2IFBNLCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4gPiA+ID4gPiA+
ID4gPj4+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+ID4g
PiA+ID4gPiA+ID4+Pj4gU2VudDogVHVlc2RheSwgSnVseSAxMiwgMjAyMiAxMTo0NiBQTQo+ID4g
PiA+ID4gPiA+ID4+Pj4+IFdoZW4gdGhlIHVzZXIgc3BhY2Ugd2hpY2ggaW52b2tlcyBuZXRsaW5r
IGNvbW1hbmRzLCBkZXRlY3RzIHRoYXQKPiA+ID4gPiA+ID4gPiA+PiBfTVEKPiA+ID4gPiA+ID4g
PiA+Pj4+IGlzIG5vdCBzdXBwb3J0ZWQsIGhlbmNlIGl0IHRha2VzIG1heF9xdWV1ZV9wYWlyID0g
MSBieSBpdHNlbGYuCj4gPiA+ID4gPiA+ID4gPj4+PiBJIHRoaW5rIHRoZSBrZXJuZWwgbW9kdWxl
IGhhdmUgYWxsIG5lY2Vzc2FyeSBpbmZvcm1hdGlvbiBhbmQgaXQgaXMKPiA+ID4gPiA+ID4gPiA+
Pj4+IHRoZSBvbmx5IG9uZSB3aGljaCBoYXZlIHByZWNpc2UgaW5mb3JtYXRpb24gb2YgYSBkZXZp
Y2UsIHNvIGl0Cj4gPiA+ID4gPiA+ID4gPj4+PiBzaG91bGQgYW5zd2VyIHByZWNpc2VseSB0aGFu
IGxldCB0aGUgdXNlciBzcGFjZSBndWVzcy4gVGhlIGtlcm5lbAo+ID4gPiA+ID4gPiA+ID4+Pj4g
bW9kdWxlIHNob3VsZCBiZSByZWxpYWJsZSB0aGFuIHN0YXkgc2lsZW50LCBsZWF2ZSB0aGUgcXVl
c3Rpb24gdG8KPiA+ID4gPiA+ID4gPiA+Pj4+IHRoZSB1c2VyIHNwYWNlCj4gPiA+ID4gPiA+ID4g
Pj4gdG9vbC4KPiA+ID4gPiA+ID4gPiA+Pj4gS2VybmVsIGlzIHJlbGlhYmxlLiBJdCBkb2VzbuKA
mXQgZXhwb3NlIGEgY29uZmlnIHNwYWNlIGZpZWxkIGlmIHRoZQo+ID4gPiA+ID4gPiA+ID4+PiBm
aWVsZCBkb2VzbuKAmXQKPiA+ID4gPiA+ID4gPiA+PiBleGlzdCByZWdhcmRsZXNzIG9mIGZpZWxk
IHNob3VsZCBoYXZlIGRlZmF1bHQgb3Igbm8gZGVmYXVsdC4KPiA+ID4gPiA+ID4gPiA+PiBzbyB3
aGVuIHlvdSBrbm93IGl0IGlzIG9uZSBxdWV1ZSBwYWlyLCB5b3Ugc2hvdWxkIGFuc3dlciBvbmUs
IG5vdCB0cnkKPiA+ID4gPiA+ID4gPiA+PiB0byBndWVzcy4KPiA+ID4gPiA+ID4gPiA+Pj4gVXNl
ciBzcGFjZSBzaG91bGQgbm90IGd1ZXNzIGVpdGhlci4gVXNlciBzcGFjZSBnZXRzIHRvIHNlZSBp
ZiBfTVEKPiA+ID4gPiA+ID4gPiA+PiBwcmVzZW50L25vdCBwcmVzZW50LiBJZiBfTVEgcHJlc2Vu
dCB0aGFuIGdldCByZWxpYWJsZSBkYXRhIGZyb20ga2VybmVsLgo+ID4gPiA+ID4gPiA+ID4+PiBJ
ZiBfTVEgbm90IHByZXNlbnQsIGl0IG1lYW5zIHRoaXMgZGV2aWNlIGhhcyBvbmUgVlEgcGFpci4K
PiA+ID4gPiA+ID4gPiA+PiBpdCBpcyBzdGlsbCBhIGd1ZXNzLCByaWdodD8gQW5kIGFsbCB1c2Vy
IHNwYWNlIHRvb2xzIGltcGxlbWVudGVkIHRoaXMKPiA+ID4gPiA+ID4gPiA+PiBmZWF0dXJlIG5l
ZWQgdG8gZ3Vlc3MKPiA+ID4gPiA+ID4gPiA+IE5vLiBpdCBpcyBub3QgYSBndWVzcy4KPiA+ID4g
PiA+ID4gPiA+IEl0IGlzIGV4cGxpY2l0bHkgY2hlY2tpbmcgdGhlIF9NUSBmZWF0dXJlIGFuZCBk
ZXJpdmluZyB0aGUgdmFsdWUuCj4gPiA+ID4gPiA+ID4gPiBUaGUgY29kZSB5b3UgcHJvcG9zZWQg
d2lsbCBiZSBwcmVzZW50IGluIHRoZSB1c2VyIHNwYWNlLgo+ID4gPiA+ID4gPiA+ID4gSXQgd2ls
bCBiZSB1bmlmb3JtIGZvciBfTVEgYW5kIDEwIG90aGVyIGZlYXR1cmVzIHRoYXQgYXJlIHByZXNl
bnQgbm93IGFuZAo+ID4gPiA+ID4gPiA+IGluIHRoZSBmdXR1cmUuCj4gPiA+ID4gPiA+ID4gTVEg
YW5kIG90aGVyIGZlYXR1cmVzIGxpa2UgUlNTIGFyZSBkaWZmZXJlbnQuIElmIHRoZXJlIGlzIG5v
IF9SU1NfWFgsIHRoZXJlCj4gPiA+ID4gPiA+ID4gYXJlIG5vIGF0dHJpYnV0ZXMgbGlrZSBtYXhf
cnNzX2tleV9zaXplLCBhbmQgdGhlcmUgaXMgbm90IGEgZGVmYXVsdCB2YWx1ZS4KPiA+ID4gPiA+
ID4gPiBCdXQgZm9yIE1RLCB3ZSBrbm93IGl0IGhhcyB0byBiZSAxIHdpaHRvdXQgX01RLgo+ID4g
PiA+ID4gPiAid2UiID0gdXNlciBzcGFjZS4KPiA+ID4gPiA+ID4gVG8ga2VlcCB0aGUgY29uc2lz
dGVuY3kgYW1vbmcgYWxsIHRoZSBjb25maWcgc3BhY2UgZmllbGRzLgo+ID4gPiA+ID4KPiA+ID4g
PiA+IEFjdHVhbGx5IEkgbG9va2VkIGFuZCB0aGUgY29kZSBzb21lIG1vcmUgYW5kIEknbSBwdXp6
bGVkOgo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAgIHN0cnVjdCB2aXJ0aW9f
bmV0X2NvbmZpZyBjb25maWcgPSB7fTsKPiA+ID4gPiA+ICAgICAgICAgdTY0IGZlYXR1cmVzOwo+
ID4gPiA+ID4gICAgICAgICB1MTYgdmFsX3UxNjsKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAg
IHZkcGFfZ2V0X2NvbmZpZ191bmxvY2tlZCh2ZGV2LCAwLCAmY29uZmlnLCBzaXplb2YoY29uZmln
KSk7Cj4gPiA+ID4gPgo+ID4gPiA+ID4gICAgICAgICBpZiAobmxhX3B1dChtc2csIFZEUEFfQVRU
Ul9ERVZfTkVUX0NGR19NQUNBRERSLCBzaXplb2YoY29uZmlnLm1hYyksCj4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgIGNvbmZpZy5tYWMpKQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgIHJl
dHVybiAtRU1TR1NJWkU7Cj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IE1hYyByZXR1cm5l
ZCBldmVuIHdpdGhvdXQgVklSVElPX05FVF9GX01BQwo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+
ID4gPiAgICAgICAgIHZhbF91MTYgPSBsZTE2X3RvX2NwdShjb25maWcuc3RhdHVzKTsKPiA+ID4g
PiA+ICAgICAgICAgaWYgKG5sYV9wdXRfdTE2KG1zZywgVkRQQV9BVFRSX0RFVl9ORVRfU1RBVFVT
LCB2YWxfdTE2KSkKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVNU0dTSVpFOwo+
ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBzdGF0dXMgcmV0dXJuZWQgZXZlbiB3aXRob3V0
IFZJUlRJT19ORVRfRl9TVEFUVVMKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAgIHZhbF91MTYg
PSBsZTE2X3RvX2NwdShjb25maWcubXR1KTsKPiA+ID4gPiA+ICAgICAgICAgaWYgKG5sYV9wdXRf
dTE2KG1zZywgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01UVSwgdmFsX3UxNikpCj4gPiA+ID4gPiAg
ICAgICAgICAgICAgICAgcmV0dXJuIC1FTVNHU0laRTsKPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4g
PiA+ID4gTVRVIHJldHVybmVkIGV2ZW4gd2l0aG91dCBWSVJUSU9fTkVUX0ZfTVRVCj4gPiA+ID4g
Pgo+ID4gPiA+ID4KPiA+ID4gPiA+IFdoYXQncyBnb2luZyBvbiBoZXJlPwo+ID4gPiA+Cj4gPiA+
ID4gUHJvYmFibHkgdG9vIGxhdGUgdG8gZml4LCBidXQgdGhpcyBzaG91bGQgYmUgZmluZSBhcyBs
b25nIGFzIGFsbAo+ID4gPiA+IHBhcmVudHMgc3VwcG9ydCBTVEFUVVMvTVRVL01BQy4KPiA+ID4K
PiA+ID4gV2h5IGlzIHRoaXMgdG9vIGxhdGUgdG8gZml4Lgo+ID4KPiA+IElmIHdlIG1ha2UgdGhp
cyBjb25kaXRpb25hbCBvbiB0aGUgZmVhdHVyZXMuIFRoaXMgbWF5IGJyZWFrIHRoZQo+ID4gdXNl
cnNwYWNlIHRoYXQgYWx3YXlzIGV4cGVjdHMgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01UVT8KPiA+
Cj4gPiBUaGFua3MKPgo+IFdlbGwgb25seSBvbiBkZXZpY2VzIHdpdGhvdXQgTVRVLiBJJ20gc2F5
aW5nIHNhaWQgdXNlcnNwYWNlCj4gd2FzIHJlYWRpbmcgdHJhc2ggb24gc3VjaCBkZXZpY2VzIGFu
eXdheS4KCkl0IGRlcGVuZHMgb24gdGhlIHBhcmVudCBhY3R1YWxseS4gRm9yIGV4YW1wbGUsIG1s
eDUgcXVlcnkgdGhlIGxvd2VyCm10dSB1bmNvbmRpdGlvbmFsbHk6CgogICAgICAgIGVyciA9IHF1
ZXJ5X210dShtZGV2LCAmbXR1KTsKICAgICAgICBpZiAoZXJyKQogICAgICAgICAgICAgICAgZ290
byBlcnJfYWxsb2M7CgogICAgICAgIG5kZXYtPmNvbmZpZy5tdHUgPSBjcHVfdG9fbWx4NXZkcGEx
NihtdmRldiwgbXR1KTsKClN1cHBvcnRpbmcgTVRVIGZlYXR1cmVzIHNlZW1zIHRvIGJlIGEgbXVz
dCBmb3IgcmVhbCBoYXJkd2FyZS4KT3RoZXJ3aXNlIHRoZSBkcml2ZXIgbWF5IG5vdCB3b3JrIGNv
cnJlY3RseS4KCj4gV2UgZG9uJ3QgZ2VuZXJhbGx5IG1haW50YWluIGJ1ZyBmb3IgYnVnIGNvbXBh
dGlibGl0eSBvbiBhIHdoaW0sCj4gb25seSBpZiB1c2Vyc3BhY2UgaXMgYWN0dWFsbHkga25vd24g
dG8gYnJlYWsgaWYgd2UgZml4IGEgYnVnLgoKIFNvIEkgdGhpbmsgaXQgc2hvdWxkIGJlIGZpbmUg
dG8gbWFrZSB0aGlzIGNvbmRpdGlvbmFsIHRoZW4gd2Ugc2hvdWxkCmhhdmUgYSBjb25zaXN0ZW50
IGhhbmRsaW5nIG9mIG90aGVyIGZpZWxkcyBsaWtlIE1RLgoKVGhhbmtzCgo+Cj4KPiA+ID4KPiA+
ID4gPiBJIHdvbmRlciBpZiB3ZSBjYW4gYWRkIGEgY2hlY2sgaW4gdGhlIGNvcmUgYW5kIGZhaWwg
dGhlIGRldmljZQo+ID4gPiA+IHJlZ2lzdHJhdGlvbiBpbiB0aGlzIGNhc2UuCj4gPiA+ID4KPiA+
ID4gPiBUaGFua3MKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiAtLQo+ID4g
PiA+ID4gTVNUCj4gPiA+ID4gPgo+ID4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
