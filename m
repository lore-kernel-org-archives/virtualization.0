Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846F9C2BB41
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 21:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F078581445;
	Tue, 16 Aug 2022 21:10:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F078581445
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hoyd0dBW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8jPXDV4C-3Gj; Tue, 16 Aug 2022 21:10:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4398581446;
	Tue, 16 Aug 2022 21:10:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4398581446
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19FC1C0032;
	Tue, 16 Aug 2022 21:10:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA6DEC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 21:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A1FAA81446
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 21:10:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A1FAA81446
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j9j4bXkm58Wi
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 21:10:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7BC0781445
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7BC0781445
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 21:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660684200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xae14lVeh2kNhNnwg1cZQHDZVItFs4GvsbtmRqUK8w=;
 b=Hoyd0dBWhbq7nhURAv6sFmQaDmCkcvrgGysin13/l1GnwjSyL//InFa5NeMqySmm9Kxu0K
 iXqBUrrVVaYe61NhbJmQN0B0VwlBJSXj2V4FUaUIRPCqVCE9htaKgP8SMLZfMS04stkCWr
 zM4I2rpeMIjyqpZGJrQNiRrjhq/BC+Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-_vCQrjGDMdi8XiBsow0kkw-1; Tue, 16 Aug 2022 17:09:59 -0400
X-MC-Unique: _vCQrjGDMdi8XiBsow0kkw-1
Received: by mail-wm1-f72.google.com with SMTP id
 v24-20020a7bcb58000000b003a37681b861so2352886wmj.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 14:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=0xae14lVeh2kNhNnwg1cZQHDZVItFs4GvsbtmRqUK8w=;
 b=3ofO4y9UW7xmHCWmc2bHbWIyTWtj2BC1PDtaE5VpsL2BoYvC+biNdLeZv1zfSMhURT
 OX3panSjwU7lEb0PBQGoqxj/Es8SkAL4InItPAUqsYNHgBymr9PV0k86WMou2Qu9tjxU
 jLkF5kj3Q0PQl/L1VlYfTyp1vPTOGSD77qBuKyFhNAkQY6UzkXGRWlJ0XBtJ25xo8pep
 TB3Fv+4coTxszy6tFOr9hzfKtuj6cWjooZfiKLvwUp5JL5zdbKQE5JK17ewdtkY0RVoa
 5/mBXaQChnUfybpOFRTFq21U5VT9wgos0PUumpknh9wQMOLy6LEPnWsAUna9ANTqovv/
 2r+g==
X-Gm-Message-State: ACgBeo2sv9/DWJCqjO+XmqWoQgMFbVoHux8O8nXDlJORY17/peNBaSdj
 hQVtFyo0H5LA+kAgVbjTDUOou6SuZ4V0K7bzv5dlV8NS82HuE6DNaIA7r9S6BwJGl6xF9634mgx
 NBMlRAZP0Q2xVtDRwH8rRRTFxwQ0q9cbK8+rJUMoVPw==
X-Received: by 2002:a05:6000:178e:b0:220:635f:eb13 with SMTP id
 e14-20020a056000178e00b00220635feb13mr12680074wrg.634.1660684197864; 
 Tue, 16 Aug 2022 14:09:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR61GD6vmCsdhe0o/qF+vr5ZjerDcFyH4c3E/BWOKkmWXYXsvQWoq7RyRXoltM0F4/hZDJyhVA==
X-Received: by 2002:a05:6000:178e:b0:220:635f:eb13 with SMTP id
 e14-20020a056000178e00b00220635feb13mr12680061wrg.634.1660684197625; 
 Tue, 16 Aug 2022 14:09:57 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 m17-20020a05600c3b1100b003a319b67f64sm5902435wms.0.2022.08.16.14.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Aug 2022 14:09:56 -0700 (PDT)
Date: Tue, 16 Aug 2022 17:09:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH 2/2] vDPA: conditionally read fields in virtio-net dev
Message-ID: <20220816170753-mutt-send-email-mst@kernel.org>
References: <20220815092638.504528-1-lingshan.zhu@intel.com>
 <20220815092638.504528-3-lingshan.zhu@intel.com>
 <PH0PR12MB54815EF8C19F70072169FA56DC6B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4184a943-f1c0-a57b-6411-bdd21e0bc710@intel.com>
 <PH0PR12MB5481EBA9E08963DEF0743063DC6B9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481EBA9E08963DEF0743063DC6B9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
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

T24gVHVlLCBBdWcgMTYsIDIwMjIgYXQgMDk6MDI6MTdQTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdy
b3RlOgo+IAo+ID4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4K
PiA+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAxNiwgMjAyMiAxMjoxOSBBTQo+ID4gCj4gPiAKPiA+
IE9uIDgvMTYvMjAyMiAxMDozMiBBTSwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+ID4gPj4gRnJvbTog
Wmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+ID4gPj4gU2VudDogTW9uZGF5
LCBBdWd1c3QgMTUsIDIwMjIgNToyNyBBTQo+ID4gPj4KPiA+ID4+IFNvbWUgZmllbGRzIG9mIHZp
cnRpby1uZXQgZGV2aWNlIGNvbmZpZyBzcGFjZSBhcmUgY29uZGl0aW9uYWwgb24gdGhlCj4gPiA+
PiBmZWF0dXJlIGJpdHMsIHRoZSBzcGVjIHNheXM6Cj4gPiA+Pgo+ID4gPj4gIlRoZSBtYWMgYWRk
cmVzcyBmaWVsZCBhbHdheXMgZXhpc3RzCj4gPiA+PiAodGhvdWdoIGlzIG9ubHkgdmFsaWQgaWYg
VklSVElPX05FVF9GX01BQyBpcyBzZXQpIgo+ID4gPj4KPiA+ID4+ICJtYXhfdmlydHF1ZXVlX3Bh
aXJzIG9ubHkgZXhpc3RzIGlmIFZJUlRJT19ORVRfRl9NUSBvcgo+ID4gPj4gVklSVElPX05FVF9G
X1JTUyBpcyBzZXQiCj4gPiA+Pgo+ID4gPj4gIm10dSBvbmx5IGV4aXN0cyBpZiBWSVJUSU9fTkVU
X0ZfTVRVIGlzIHNldCIKPiA+ID4+Cj4gPiA+PiBzbyB3ZSBzaG91bGQgcmVhZCBNVFUsIE1BQyBh
bmQgTVEgaW4gdGhlIGRldmljZSBjb25maWcgc3BhY2Ugb25seQo+ID4gPj4gd2hlbiB0aGVzZSBm
ZWF0dXJlIGJpdHMgYXJlIG9mZmVyZWQuCj4gPiA+IFllcy4KPiA+ID4KPiA+ID4+IEZvciBNUSwg
aWYgYm90aCBWSVJUSU9fTkVUX0ZfTVEgYW5kIFZJUlRJT19ORVRfRl9SU1MgYXJlIG5vdCBzZXQs
Cj4gPiB0aGUKPiA+ID4+IHZpcnRpbyBkZXZpY2Ugc2hvdWxkIGhhdmUgb25lIHF1ZXVlIHBhaXIg
YXMgZGVmYXVsdCB2YWx1ZSwgc28gd2hlbgo+ID4gPj4gdXNlcnNwYWNlIHF1ZXJ5aW5nIHF1ZXVl
IHBhaXIgbnVtYmVycywgaXQgc2hvdWxkIHJldHVybiBtcT0xIHRoYW4gemVyby4KPiA+ID4gTm8u
Cj4gPiA+IE5vIG5lZWQgdG8gdHJlYXQgbWFjIGFuZCBtYXhfcXBzIGRpZmZlcmVudGx5Lgo+ID4g
PiBJdCBpcyBtZWFuaW5nbGVzcyB0byBkaWZmZXJlbnRpYXRlIHdoZW4gZmllbGQgZXhpc3Qvbm90
LWV4aXN0cyB2cyB2YWx1ZQo+ID4gdmFsaWQvbm90IHZhbGlkLgo+ID4gYXMgd2UgZGlzY3Vzc2Vk
IGJlZm9yZSwgTVEgaGFzIGEgZGVmYXVsdCB2YWx1ZSAxLCB0byBiZSBhIGZ1bmN0aW9uYWwgdmly
dGlvLQo+ID4gbmV0IGRldmljZSwgd2hpbGUgTUFDIGhhcyBubyBkZWZhdWx0IHZhbHVlLCBpZiBu
byBWSVJUSU9fTkVUX0ZfTUFDIHNldCwKPiA+IHRoZSBkcml2ZXIgc2hvdWxkIGdlbmVyYXRlIGEg
cmFuZG9tIE1BQy4KPiA+ID4KPiA+ID4+IEZvciBNVFUsIGlmIFZJUlRJT19ORVRfRl9NVFUgaXMg
bm90IHNldCwgd2Ugc2hvdWxkIG5vdCByZWFkIE1UVSBmcm9tCj4gPiA+PiB0aGUgZGV2aWNlIGNv
bmZpZyBzYXBjZS4KPiA+ID4+IFJGQzg5NCA8QSBTdGFuZGFyZCBmb3IgdGhlIFRyYW5zbWlzc2lv
biBvZiBJUCBEYXRhZ3JhbXMgb3ZlciBFdGhlcm5ldAo+ID4gPj4gTmV0d29ya3M+IHNheXM6IlRo
ZSBtaW5pbXVtIGxlbmd0aCBvZiB0aGUgZGF0YSBmaWVsZCBvZiBhIHBhY2tldCBzZW50Cj4gPiA+
PiBOZXR3b3Jrcz4gb3Zlcgo+ID4gPj4gYW4gRXRoZXJuZXQgaXMgMTUwMCBvY3RldHMsIHRodXMg
dGhlIG1heGltdW0gbGVuZ3RoIG9mIGFuIElQIGRhdGFncmFtCj4gPiA+PiBzZW50IG92ZXIgYW4g
RXRoZXJuZXQgaXMgMTUwMCBvY3RldHMuICBJbXBsZW1lbnRhdGlvbnMgYXJlIGVuY291cmFnZWQK
PiA+ID4+IHRvIHN1cHBvcnQgZnVsbC1sZW5ndGggcGFja2V0cyIKPiA+ID4gVGhpcyBsaW5lIGlu
IHRoZSBSRkMgODk0IG9mIDE5ODQgaXMgd3JvbmcuCj4gPiA+IEVycmF0YSBhbHJlYWR5IGV4aXN0
cyBmb3IgaXQgYXQgWzFdLgo+ID4gPgo+ID4gPiBbMV0gaHR0cHM6Ly93d3cucmZjLWVkaXRvci5v
cmcvZXJyYXRhX3NlYXJjaC5waHA/cmZjPTg5NCZyZWNfc3RhdHVzPTAKPiA+IE9LLCBzbyBJIHRo
aW5rIHdlIHNob3VsZCByZXR1cm4gbm90aGluZyBpZiBfRl9NVFUgbm90IHNldCwgbGlrZSBoYW5k
bGluZyB0aGUKPiA+IE1BQwo+ID4gPgo+ID4gPj4gdmlydGlvIHNwZWMgc2F5czoiVGhlIHZpcnRp
byBuZXR3b3JrIGRldmljZSBpcyBhIHZpcnR1YWwgZXRoZXJuZXQKPiA+ID4+IGNhcmQiLCBzbyB0
aGUgZGVmYXVsdCBNVFUgdmFsdWUgc2hvdWxkIGJlIDE1MDAgZm9yIHZpcnRpby1uZXQuCj4gPiA+
Pgo+ID4gPiBQcmFjdGljYWxseSBJIGhhdmUgc2VlbiAxNTAwIGFuZCBoaWdoZSBtdHUuCj4gPiA+
IEFuZCB0aGlzIGRlcml2YXRpb24gaXMgbm90IGdvb2Qgb2Ygd2hhdCBzaG91bGQgYmUgdGhlIGRl
ZmF1bHQgbXR1IGFzIGFib3ZlCj4gPiBlcnJhdGEgZXhpc3RzLgo+ID4gPgo+ID4gPiBBbmQgSSBz
ZWUgdGhlIGNvZGUgYmVsb3cgd2h5IHlvdSBuZWVkIHRvIHdvcmsgc28gaGFyZCB0byBkZWZpbmUg
YSBkZWZhdWx0Cj4gPiB2YWx1ZSBzbyB0aGF0IF9NUSBhbmQgX01UVSBjYW4gcmVwb3J0IGRlZmF1
bHQgdmFsdWVzLgo+ID4gPgo+ID4gPiBUaGVyZSBpcyByZWFsbHkgbm8gbmVlZCBmb3IgdGhpcyBj
b21wbGV4aXR5IGFuZCBzdWNoIGEgbG9uZyBjb21taXQKPiA+IG1lc3NhZ2UuCj4gPiA+Cj4gPiA+
IENhbiB3ZSBwbGVhc2UgZXhwb3NlIGZlYXR1cmUgYml0cyBhcy1pcyBhbmQgcmVwb3J0IGNvbmZp
ZyBzcGFjZSBmaWVsZCB3aGljaAo+ID4gYXJlIHZhbGlkPwo+ID4gPgo+ID4gPiBVc2VyIHNwYWNl
IHdpbGwgYmUgcXVlcnlpbmcgYm90aC4KPiA+IEkgdGhpbmsgTUFDIGFuZCBNVFUgZG9uJ3QgaGF2
ZSBkZWZhdWx0IHZhbHVlcywgc28gcmV0dXJuIG5vdGhpbmcgaWYgdGhlCj4gPiBmZWF0dXJlIGJp
dHMgbm90IHNldCwgCj4gCj4gPiBmb3IgTVEsIGl0IGlzIHN0aWxsIG1heF92cV9wYXJpcyA9PSAx
IGJ5IGRlZmF1bHQuCj4gCj4gSSBoYXZlIHN0cmVzc2VkIGVub3VnaCB0byBoaWdobGlnaHQgdGhl
IGZhY3QgdGhhdCB3ZSBkb27igJl0IHdhbnQgdG8gc3RhcnQgZGlnZ2luZyBkZWZhdWx0L25vIGRl
ZmF1bHQsIHZhbGlkL25vLXZhbGlkIHBhcnQgb2YgdGhlIHNwZWMuCj4gSSBwcmVmZXIga2VybmVs
IHRvIHJlcG9ydGluZyBmaWVsZHMgdGhhdCBfZXhpc3RzXyBpbiB0aGUgY29uZmlnIHNwYWNlIGFu
ZCBhcmUgdmFsaWQuCj4gSSB3aWxsIGxldCBNU1QgdG8gaGFuZGxlIHRoZSBtYWludGVuYW5jZSBu
aWdodG1hcmUgdGhhdCB0aGlzIGtpbmQgb2YgcGF0Y2ggYnJpbmdzIGluIHdpdGhvdXQgYW55IHZp
c2libGUgZ2FpbiB0byB1c2VyIHNwYWNlL29yY2hlc3RyYXRpb24gYXBwcy4KPiAKPiBBIGxvZ2lj
IHRoYXQgY2FuIGJlIGVhc2lseSBidWlsZCBpbiB1c2VyIHNwYWNlLCBzaG91bGQgYmUgd3JpdHRl
biBpbiB1c2VyIHNwYWNlLgo+IEkgY29uY2x1ZGUgbXkgdGhvdWdodHMgaGVyZSBmb3IgdGhpcyBk
aXNjdXNzaW9uLgo+IAo+IEkgd2lsbCBsZXQgTVNUIHRvIGRlY2lkZSBob3cgaGUgcHJlZmVycyB0
byBwcm9jZWVkLgo+IAo+ID4KPiA+ID4+ICsJaWYgKChmZWF0dXJlcyAmIEJJVF9VTEwoVklSVElP
X05FVF9GX01UVSkpID09IDApCj4gPiA+PiArCQl2YWxfdTE2ID0gMTUwMDsKPiA+ID4+ICsJZWxz
ZQo+ID4gPj4gKwkJdmFsX3UxNiA9IF9fdmlydGlvMTZfdG9fY3B1KHRydWUsIGNvbmZpZy0+bXR1
KTsKPiA+ID4+ICsKPiA+ID4gTmVlZCB0byB3b3JrIGhhcmQgdG8gZmluZCBkZWZhdWx0IHZhbHVl
cyBhbmQgdGhhdCB0b28gdHVybmVkIG91dCBoYWQKPiA+IGVycmF0YS4KPiA+ID4gVGhlcmUgYXJl
IG1vcmUgZmllbGRzIHRoYXQgZG9lc27igJl0IGhhdmUgZGVmYXVsdCB2YWx1ZXMuCj4gPiA+Cj4g
PiA+IFRoZXJlIGlzIG5vIHBvaW50IGluIGtlcm5lbCBkb2luZyB0aGlzIGd1ZXNzIHdvcmssIHRo
YXQgdXNlciBzcGFjZSBjYW4gZmlndXJlCj4gPiBvdXQgb2Ygd2hhdCBpcyB2YWxpZC9pbnZhbGlk
Lgo+ID4gSXQncyBub3QgZ3Vlc3Qgd29yaywgd2hlbiBndWVzdCBmaW5kcyBubyBmZWF0dXJlIGJp
dHMgc2V0LCBpdCBjYW4gZGVjaWRlIHdoYXQKPiA+IHRvIGRvLiAKPiAKPiBBYm92ZSBjb2RlIG9m
IGRvaW5nIDE1MDAgd2FzIHByb2JhYmx5IGFuIGhvbmVzdCBhdHRlbXB0IHRvIGZpbmQgYSBsZWdp
dGltYXRlIGRlZmF1bHQgdmFsdWUsIGFuZCB3ZSBzYXcgdGhhdCBpdCBkb2VzbuKAmXQgd29yay4K
PiBUaGlzIGlzIHNlY29uZCBleGFtcGxlIGFmdGVyIF9NUSB0aGF0IHdlIGJvdGggYWdyZWUgc2hv
dWxkIG5vdCByZXR1cm4gZGVmYXVsdC4KPiAKPiBBbmQgdGhlcmUgYXJlIG1vcmUgZmllbGRzIGNv
bWluZyBpbiB0aGlzIGFyZWEuCj4gSGVuY2UsIEkgcHJlZmVyIHRvIG5vdCBhdm9pZCByZXR1cm5p
bmcgc3VjaCBkZWZhdWx0cyBmb3IgTUFDLCBNVFUsIE1RIGFuZCByZXN0IGFsbCBmaWVsZHMgd2hp
Y2ggZG9lc27igJl0IF9leGlzdHNfLgo+IAo+IEkgd2lsbCBsZXQgTVNUIHRvIGRlY2lkZSBob3cg
aGUgcHJlZmVycyB0byBwcm9jZWVkIGZvciBldmVyeSBmaWVsZCB0byBjb21lIG5leHQuCj4gVGhh
bmtzLgo+IAoKCklmIE1UVSBkb2VzIG5vdCByZXR1cm4gYSB2YWx1ZSB3aXRob3V0IF9GX01UVSwg
YW5kIE1BQyBkb2VzIG5vdCByZXR1cm4KYSB2YWx1ZSB3aXRob3V0IF9GX01BQyB0aGVuIElNTyB5
ZXMsIG51bWJlciBvZiBxdWV1ZXMgc2hvdWxkIG5vdCByZXR1cm4KYSB2YWx1ZSB3aXRob3V0IF9G
X01RLgoKCi0tIApNU1QKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
