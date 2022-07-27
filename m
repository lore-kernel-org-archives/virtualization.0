Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA0EC04A68
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 09:03:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 913B340480;
	Wed, 27 Jul 2022 09:03:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 913B340480
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YZf2cgM0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HVVJS8HL1usU; Wed, 27 Jul 2022 09:03:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 194B240151;
	Wed, 27 Jul 2022 09:03:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 194B240151
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E16FCC0033;
	Wed, 27 Jul 2022 09:03:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E0DAC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:03:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D5E381A27
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:03:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D5E381A27
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YZf2cgM0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dYudrTgG1kzf
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:03:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDC2281A0D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EDC2281A0D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658912578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gtC1Kngdj/9ZAtLMhB4yQ8VboNXr6FhpxFuZ9/lFO2o=;
 b=YZf2cgM0ilaTrD2EstFp6o7x03wb7MUFyoQ4FSmUG2XmW13oMj3tCFnUcu5Y5Il5ftq/gj
 WNIoLeZmCa+aCvhh2NxnSuMWYzk/J6FwHkwqN/36/ow+kxOqWxPoLmllrh8VvwiKgo10vu
 dwI5lrHefvP0d3E3sRCMfkbjdn1fQec=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-46Fu7SSgNkWPgzNtzLKElw-1; Wed, 27 Jul 2022 05:02:57 -0400
X-MC-Unique: 46Fu7SSgNkWPgzNtzLKElw-1
Received: by mail-wm1-f70.google.com with SMTP id
 v132-20020a1cac8a000000b003a34081050bso883219wme.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 02:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=gtC1Kngdj/9ZAtLMhB4yQ8VboNXr6FhpxFuZ9/lFO2o=;
 b=C8d06W8U1uSJtTU/KOxJoSmJa8IzemkYv9PBiC7IzaRMdpUKF4h8MuPrBNvOG4N7zx
 J50YMs+IwVEKs3TJi21S3hDpI008HIz1eJ/UEzfX+D4q1MUq3B41ZxpNNy/5NIlQF6/Z
 /pXmCBNOqMghotBFM0lPN1WzKFbKei2o8cpBiIecOMUOsl/BA8WsbZvYlGglhLk/4PPJ
 4vndR3rzQOM5fMy7pcOjVrwtcK9TqWQfJ3Uhi59k952imGJ+eyFG+A0SUxnHkQ+BVtqS
 Y07u4C6XfY+N+GSrSWyV3tLwM3x9eXZZpXBx5+vQqSEWLYBhl9VGRyHa9nkVdR+tUsHz
 1wgg==
X-Gm-Message-State: AJIora81T1V/F2V3loyHxDmI56hIxYJWoSQ2uY0+cbTp4PPXHFe+HSaY
 4qgTqj/+XLHHZckG+w+179CDQukna/1G1ATVl41gWfEGMr09KwhzU0ecDDyobdc4FKFba9XfTD2
 nFQFRIKaUfzyT/NKG0keXLAZz8eM7H6IZCXFzIoA/Wg==
X-Received: by 2002:a05:6000:80b:b0:21e:d62e:b282 with SMTP id
 bt11-20020a056000080b00b0021ed62eb282mr946124wrb.557.1658912576251; 
 Wed, 27 Jul 2022 02:02:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uW9fV+cMip2PTPTYKXcapQCJhkF7jhW8fg6kDZV7A60tEtWN8sMyjbcVt8iYSWS8fR3A9+3w==
X-Received: by 2002:a05:6000:80b:b0:21e:d62e:b282 with SMTP id
 bt11-20020a056000080b00b0021ed62eb282mr946104wrb.557.1658912576019; 
 Wed, 27 Jul 2022 02:02:56 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7424:0:3d16:86dc:de54:5671])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a5d4dc8000000b0021dd8e1309asm16828404wru.75.2022.07.27.02.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jul 2022 02:02:55 -0700 (PDT)
Date: Wed, 27 Jul 2022 05:02:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Message-ID: <20220727050222-mutt-send-email-mst@kernel.org>
References: <c7c8f49c-484f-f5b3-39e6-0d17f396cca7@intel.com>
 <PH0PR12MB5481E65037E0B4F6F583193BDC899@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1246d2f1-2822-0edb-cd57-efc4015f05a2@intel.com>
 <PH0PR12MB54815985C202E81122459DFFDC949@PH0PR12MB5481.namprd12.prod.outlook.com>
 <19681358-fc81-be5b-c20b-7394a549f0be@intel.com>
 <PH0PR12MB54818158D4F7F9F556022857DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e98fc062-021b-848b-5cf4-15bd63a11c5c@intel.com>
 <PH0PR12MB54815AD7D0674FEB1D63EB61DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220727015626-mutt-send-email-mst@kernel.org>
 <CACGkMEv62tuOP3ra0GBhjCH=syFWxP+GVfGL_i0Ce0iD4uMY=Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv62tuOP3ra0GBhjCH=syFWxP+GVfGL_i0Ce0iD4uMY=Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

T24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMDI6NTQ6MTNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBXZWQsIEp1bCAyNywgMjAyMiBhdCAyOjAxIFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFdlZCwgSnVsIDI3LCAyMDIyIGF0IDAz
OjQ3OjM1QU0gKzAwMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToKPiA+ID4KPiA+ID4gPiBGcm9tOiBa
aHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+ID4gPiA+IFNlbnQ6IFR1ZXNk
YXksIEp1bHkgMjYsIDIwMjIgMTA6NTMgUE0KPiA+ID4gPgo+ID4gPiA+IE9uIDcvMjcvMjAyMiAx
MDoxNyBBTSwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+ID4gPiA+ID4+IEZyb206IFpodSwgTGluZ3No
YW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4gPiA+ID4gPj4gU2VudDogVHVlc2RheSwgSnVs
eSAyNiwgMjAyMiAxMDoxNSBQTQo+ID4gPiA+ID4+Cj4gPiA+ID4gPj4gT24gNy8yNi8yMDIyIDEx
OjU2IFBNLCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4gPiA+ID4gPj4+PiBGcm9tOiBaaHUsIExpbmdz
aGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+ID4gPiA+ID4+Pj4gU2VudDogVHVlc2RheSwg
SnVseSAxMiwgMjAyMiAxMTo0NiBQTQo+ID4gPiA+ID4+Pj4+IFdoZW4gdGhlIHVzZXIgc3BhY2Ug
d2hpY2ggaW52b2tlcyBuZXRsaW5rIGNvbW1hbmRzLCBkZXRlY3RzIHRoYXQKPiA+ID4gPiA+PiBf
TVEKPiA+ID4gPiA+Pj4+IGlzIG5vdCBzdXBwb3J0ZWQsIGhlbmNlIGl0IHRha2VzIG1heF9xdWV1
ZV9wYWlyID0gMSBieSBpdHNlbGYuCj4gPiA+ID4gPj4+PiBJIHRoaW5rIHRoZSBrZXJuZWwgbW9k
dWxlIGhhdmUgYWxsIG5lY2Vzc2FyeSBpbmZvcm1hdGlvbiBhbmQgaXQgaXMKPiA+ID4gPiA+Pj4+
IHRoZSBvbmx5IG9uZSB3aGljaCBoYXZlIHByZWNpc2UgaW5mb3JtYXRpb24gb2YgYSBkZXZpY2Us
IHNvIGl0Cj4gPiA+ID4gPj4+PiBzaG91bGQgYW5zd2VyIHByZWNpc2VseSB0aGFuIGxldCB0aGUg
dXNlciBzcGFjZSBndWVzcy4gVGhlIGtlcm5lbAo+ID4gPiA+ID4+Pj4gbW9kdWxlIHNob3VsZCBi
ZSByZWxpYWJsZSB0aGFuIHN0YXkgc2lsZW50LCBsZWF2ZSB0aGUgcXVlc3Rpb24gdG8KPiA+ID4g
PiA+Pj4+IHRoZSB1c2VyIHNwYWNlCj4gPiA+ID4gPj4gdG9vbC4KPiA+ID4gPiA+Pj4gS2VybmVs
IGlzIHJlbGlhYmxlLiBJdCBkb2VzbuKAmXQgZXhwb3NlIGEgY29uZmlnIHNwYWNlIGZpZWxkIGlm
IHRoZQo+ID4gPiA+ID4+PiBmaWVsZCBkb2VzbuKAmXQKPiA+ID4gPiA+PiBleGlzdCByZWdhcmRs
ZXNzIG9mIGZpZWxkIHNob3VsZCBoYXZlIGRlZmF1bHQgb3Igbm8gZGVmYXVsdC4KPiA+ID4gPiA+
PiBzbyB3aGVuIHlvdSBrbm93IGl0IGlzIG9uZSBxdWV1ZSBwYWlyLCB5b3Ugc2hvdWxkIGFuc3dl
ciBvbmUsIG5vdCB0cnkKPiA+ID4gPiA+PiB0byBndWVzcy4KPiA+ID4gPiA+Pj4gVXNlciBzcGFj
ZSBzaG91bGQgbm90IGd1ZXNzIGVpdGhlci4gVXNlciBzcGFjZSBnZXRzIHRvIHNlZSBpZiBfTVEK
PiA+ID4gPiA+PiBwcmVzZW50L25vdCBwcmVzZW50LiBJZiBfTVEgcHJlc2VudCB0aGFuIGdldCBy
ZWxpYWJsZSBkYXRhIGZyb20ga2VybmVsLgo+ID4gPiA+ID4+PiBJZiBfTVEgbm90IHByZXNlbnQs
IGl0IG1lYW5zIHRoaXMgZGV2aWNlIGhhcyBvbmUgVlEgcGFpci4KPiA+ID4gPiA+PiBpdCBpcyBz
dGlsbCBhIGd1ZXNzLCByaWdodD8gQW5kIGFsbCB1c2VyIHNwYWNlIHRvb2xzIGltcGxlbWVudGVk
IHRoaXMKPiA+ID4gPiA+PiBmZWF0dXJlIG5lZWQgdG8gZ3Vlc3MKPiA+ID4gPiA+IE5vLiBpdCBp
cyBub3QgYSBndWVzcy4KPiA+ID4gPiA+IEl0IGlzIGV4cGxpY2l0bHkgY2hlY2tpbmcgdGhlIF9N
USBmZWF0dXJlIGFuZCBkZXJpdmluZyB0aGUgdmFsdWUuCj4gPiA+ID4gPiBUaGUgY29kZSB5b3Ug
cHJvcG9zZWQgd2lsbCBiZSBwcmVzZW50IGluIHRoZSB1c2VyIHNwYWNlLgo+ID4gPiA+ID4gSXQg
d2lsbCBiZSB1bmlmb3JtIGZvciBfTVEgYW5kIDEwIG90aGVyIGZlYXR1cmVzIHRoYXQgYXJlIHBy
ZXNlbnQgbm93IGFuZAo+ID4gPiA+IGluIHRoZSBmdXR1cmUuCj4gPiA+ID4gTVEgYW5kIG90aGVy
IGZlYXR1cmVzIGxpa2UgUlNTIGFyZSBkaWZmZXJlbnQuIElmIHRoZXJlIGlzIG5vIF9SU1NfWFgs
IHRoZXJlCj4gPiA+ID4gYXJlIG5vIGF0dHJpYnV0ZXMgbGlrZSBtYXhfcnNzX2tleV9zaXplLCBh
bmQgdGhlcmUgaXMgbm90IGEgZGVmYXVsdCB2YWx1ZS4KPiA+ID4gPiBCdXQgZm9yIE1RLCB3ZSBr
bm93IGl0IGhhcyB0byBiZSAxIHdpaHRvdXQgX01RLgo+ID4gPiAid2UiID0gdXNlciBzcGFjZS4K
PiA+ID4gVG8ga2VlcCB0aGUgY29uc2lzdGVuY3kgYW1vbmcgYWxsIHRoZSBjb25maWcgc3BhY2Ug
ZmllbGRzLgo+ID4KPiA+IEFjdHVhbGx5IEkgbG9va2VkIGFuZCB0aGUgY29kZSBzb21lIG1vcmUg
YW5kIEknbSBwdXp6bGVkOgo+ID4KPiA+Cj4gPiAgICAgICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2Nv
bmZpZyBjb25maWcgPSB7fTsKPiA+ICAgICAgICAgdTY0IGZlYXR1cmVzOwo+ID4gICAgICAgICB1
MTYgdmFsX3UxNjsKPiA+Cj4gPiAgICAgICAgIHZkcGFfZ2V0X2NvbmZpZ191bmxvY2tlZCh2ZGV2
LCAwLCAmY29uZmlnLCBzaXplb2YoY29uZmlnKSk7Cj4gPgo+ID4gICAgICAgICBpZiAobmxhX3B1
dChtc2csIFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQUNBRERSLCBzaXplb2YoY29uZmlnLm1hYyks
Cj4gPiAgICAgICAgICAgICAgICAgICAgIGNvbmZpZy5tYWMpKQo+ID4gICAgICAgICAgICAgICAg
IHJldHVybiAtRU1TR1NJWkU7Cj4gPgo+ID4KPiA+IE1hYyByZXR1cm5lZCBldmVuIHdpdGhvdXQg
VklSVElPX05FVF9GX01BQwo+ID4KPiA+Cj4gPiAgICAgICAgIHZhbF91MTYgPSBsZTE2X3RvX2Nw
dShjb25maWcuc3RhdHVzKTsKPiA+ICAgICAgICAgaWYgKG5sYV9wdXRfdTE2KG1zZywgVkRQQV9B
VFRSX0RFVl9ORVRfU1RBVFVTLCB2YWxfdTE2KSkKPiA+ICAgICAgICAgICAgICAgICByZXR1cm4g
LUVNU0dTSVpFOwo+ID4KPiA+Cj4gPiBzdGF0dXMgcmV0dXJuZWQgZXZlbiB3aXRob3V0IFZJUlRJ
T19ORVRfRl9TVEFUVVMKPiA+Cj4gPiAgICAgICAgIHZhbF91MTYgPSBsZTE2X3RvX2NwdShjb25m
aWcubXR1KTsKPiA+ICAgICAgICAgaWYgKG5sYV9wdXRfdTE2KG1zZywgVkRQQV9BVFRSX0RFVl9O
RVRfQ0ZHX01UVSwgdmFsX3UxNikpCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTVNHU0la
RTsKPiA+Cj4gPgo+ID4gTVRVIHJldHVybmVkIGV2ZW4gd2l0aG91dCBWSVJUSU9fTkVUX0ZfTVRV
Cj4gPgo+ID4KPiA+IFdoYXQncyBnb2luZyBvbiBoZXJlPwo+IAo+IFByb2JhYmx5IHRvbyBsYXRl
IHRvIGZpeCwgYnV0IHRoaXMgc2hvdWxkIGJlIGZpbmUgYXMgbG9uZyBhcyBhbGwKPiBwYXJlbnRz
IHN1cHBvcnQgU1RBVFVTL01UVS9NQUMuCgpXaHkgaXMgdGhpcyB0b28gbGF0ZSB0byBmaXguCgo+
IEkgd29uZGVyIGlmIHdlIGNhbiBhZGQgYSBjaGVjayBpbiB0aGUgY29yZSBhbmQgZmFpbCB0aGUg
ZGV2aWNlCj4gcmVnaXN0cmF0aW9uIGluIHRoaXMgY2FzZS4KPiAKPiBUaGFua3MKPiAKPiA+Cj4g
Pgo+ID4gLS0KPiA+IE1TVAo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
