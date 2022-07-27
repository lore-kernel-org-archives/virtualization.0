Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26502C04A68
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 09:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8613E4098D;
	Wed, 27 Jul 2022 09:02:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8613E4098D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W83m5QIt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1NbfqFvj9KR6; Wed, 27 Jul 2022 09:02:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9F8734098C;
	Wed, 27 Jul 2022 09:02:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F8734098C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 752EEC0033;
	Wed, 27 Jul 2022 09:02:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B969EC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:02:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8793281992
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:02:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8793281992
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=W83m5QIt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TXSUDWlSxiof
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:02:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9556C81991
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9556C81991
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658912526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fnz/l1vyI26hB+xzTJcH/see5OEfLpEz0rao0B1ZdFA=;
 b=W83m5QIt8nPdvXfuJ6nrDWSquIYOq7BLa4jUg3owXRwoy3+6E9JbtIRjM05LtlfLzVYiFO
 1pKhPd2PHftN8Cpcq7lcoPJWNErjcYzXjBUD92ilrfiO3SNMWEv+juX/exSuSKEHlpDI9M
 c0x9ZC8oCjyGzPY+f2OdCQfeGVnYgsg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-YsPE5vaeNyadf1tJq5ZlIg-1; Wed, 27 Jul 2022 05:01:59 -0400
X-MC-Unique: YsPE5vaeNyadf1tJq5ZlIg-1
Received: by mail-wm1-f72.google.com with SMTP id
 k27-20020a05600c1c9b00b003a2fee19a80so889239wms.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 02:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=fnz/l1vyI26hB+xzTJcH/see5OEfLpEz0rao0B1ZdFA=;
 b=gOVDnmtdQHwCmGaAmQYhuT6xocjCR6tWOxh0tZSbkKc1PkzxYj8mnkSMSsAMmFE2DI
 aRT84cgmtUqAMyJX9qpmIYuKBfUhdPiCkXmIR35jU8FF87b0H2tLbpYg0Wtvb3RoRCdK
 EGruGMygvYZoHSsqP44ZXvO91+LVqen4WRjwdu1kfb7UdLUPCve0OjUz3DIb2NgB/Ghc
 auNRdmPOcJ5A5CXV+GBnapPtDh2o5H0g1273qBNr2a5nsLlMBOfja8xChuS3J27htxmH
 r7qJMMXQRN4Xd+UY9ylR9ZKLKCO3WaGnr5s/+UOPNelpOerL7PBOmHcS5qpXxrkoO13q
 8nnw==
X-Gm-Message-State: AJIora+L84MKvPc1F5Ke9XJ7kJW/EZXYw6saJ5fXVW7gkqfxpca6+3M3
 L/eCucwm9fRypU93CoaZkOT/B4BNNcFvGyd4rlj//1J0gSh7smFNKva9v+7QTfelseiqf883Hhe
 Wzr8g8E03ECHB5wmG+ZGagRBiOuwuTtoyTouu1mQE8A==
X-Received: by 2002:adf:de0d:0:b0:21d:66a1:ad4d with SMTP id
 b13-20020adfde0d000000b0021d66a1ad4dmr13502459wrm.17.1658912518395; 
 Wed, 27 Jul 2022 02:01:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tVHx8Qq4yGkkemZ0F7sscnPqzddBsU8pEYcy1hR1jX0pHa/ArofkEzuzCBxPnilQlg8zqdGw==
X-Received: by 2002:adf:de0d:0:b0:21d:66a1:ad4d with SMTP id
 b13-20020adfde0d000000b0021d66a1ad4dmr13502441wrm.17.1658912518175; 
 Wed, 27 Jul 2022 02:01:58 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7424:0:3d16:86dc:de54:5671])
 by smtp.gmail.com with ESMTPSA id
 l25-20020a05600c1d1900b003a33227e49bsm1781904wms.4.2022.07.27.02.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jul 2022 02:01:57 -0700 (PDT)
Date: Wed, 27 Jul 2022 05:01:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Message-ID: <20220727050102-mutt-send-email-mst@kernel.org>
References: <c7c8f49c-484f-f5b3-39e6-0d17f396cca7@intel.com>
 <PH0PR12MB5481E65037E0B4F6F583193BDC899@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1246d2f1-2822-0edb-cd57-efc4015f05a2@intel.com>
 <PH0PR12MB54815985C202E81122459DFFDC949@PH0PR12MB5481.namprd12.prod.outlook.com>
 <19681358-fc81-be5b-c20b-7394a549f0be@intel.com>
 <PH0PR12MB54818158D4F7F9F556022857DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e98fc062-021b-848b-5cf4-15bd63a11c5c@intel.com>
 <PH0PR12MB54815AD7D0674FEB1D63EB61DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220727015626-mutt-send-email-mst@kernel.org>
 <66291287-fcb3-be8d-2c1b-dd44533ed8b3@oracle.com>
MIME-Version: 1.0
In-Reply-To: <66291287-fcb3-be8d-2c1b-dd44533ed8b3@oracle.com>
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

T24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMTI6NTA6MzNBTSAtMDcwMCwgU2ktV2VpIExpdSB3cm90
ZToKPiAKPiAKPiBPbiA3LzI2LzIwMjIgMTE6MDEgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90
ZToKPiA+IE9uIFdlZCwgSnVsIDI3LCAyMDIyIGF0IDAzOjQ3OjM1QU0gKzAwMDAsIFBhcmF2IFBh
bmRpdCB3cm90ZToKPiA+ID4gPiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50
ZWwuY29tPgo+ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjYsIDIwMjIgMTA6NTMgUE0KPiA+
ID4gPiAKPiA+ID4gPiBPbiA3LzI3LzIwMjIgMTA6MTcgQU0sIFBhcmF2IFBhbmRpdCB3cm90ZToK
PiA+ID4gPiA+ID4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4K
PiA+ID4gPiA+ID4gU2VudDogVHVlc2RheSwgSnVseSAyNiwgMjAyMiAxMDoxNSBQTQo+ID4gPiA+
ID4gPiAKPiA+ID4gPiA+ID4gT24gNy8yNi8yMDIyIDExOjU2IFBNLCBQYXJhdiBQYW5kaXQgd3Jv
dGU6Cj4gPiA+ID4gPiA+ID4gPiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50
ZWwuY29tPgo+ID4gPiA+ID4gPiA+ID4gU2VudDogVHVlc2RheSwgSnVseSAxMiwgMjAyMiAxMTo0
NiBQTQo+ID4gPiA+ID4gPiA+ID4gPiBXaGVuIHRoZSB1c2VyIHNwYWNlIHdoaWNoIGludm9rZXMg
bmV0bGluayBjb21tYW5kcywgZGV0ZWN0cyB0aGF0Cj4gPiA+ID4gPiA+IF9NUQo+ID4gPiA+ID4g
PiA+ID4gaXMgbm90IHN1cHBvcnRlZCwgaGVuY2UgaXQgdGFrZXMgbWF4X3F1ZXVlX3BhaXIgPSAx
IGJ5IGl0c2VsZi4KPiA+ID4gPiA+ID4gPiA+IEkgdGhpbmsgdGhlIGtlcm5lbCBtb2R1bGUgaGF2
ZSBhbGwgbmVjZXNzYXJ5IGluZm9ybWF0aW9uIGFuZCBpdCBpcwo+ID4gPiA+ID4gPiA+ID4gdGhl
IG9ubHkgb25lIHdoaWNoIGhhdmUgcHJlY2lzZSBpbmZvcm1hdGlvbiBvZiBhIGRldmljZSwgc28g
aXQKPiA+ID4gPiA+ID4gPiA+IHNob3VsZCBhbnN3ZXIgcHJlY2lzZWx5IHRoYW4gbGV0IHRoZSB1
c2VyIHNwYWNlIGd1ZXNzLiBUaGUga2VybmVsCj4gPiA+ID4gPiA+ID4gPiBtb2R1bGUgc2hvdWxk
IGJlIHJlbGlhYmxlIHRoYW4gc3RheSBzaWxlbnQsIGxlYXZlIHRoZSBxdWVzdGlvbiB0bwo+ID4g
PiA+ID4gPiA+ID4gdGhlIHVzZXIgc3BhY2UKPiA+ID4gPiA+ID4gdG9vbC4KPiA+ID4gPiA+ID4g
PiBLZXJuZWwgaXMgcmVsaWFibGUuIEl0IGRvZXNu4oCZdCBleHBvc2UgYSBjb25maWcgc3BhY2Ug
ZmllbGQgaWYgdGhlCj4gPiA+ID4gPiA+ID4gZmllbGQgZG9lc27igJl0Cj4gPiA+ID4gPiA+IGV4
aXN0IHJlZ2FyZGxlc3Mgb2YgZmllbGQgc2hvdWxkIGhhdmUgZGVmYXVsdCBvciBubyBkZWZhdWx0
Lgo+ID4gPiA+ID4gPiBzbyB3aGVuIHlvdSBrbm93IGl0IGlzIG9uZSBxdWV1ZSBwYWlyLCB5b3Ug
c2hvdWxkIGFuc3dlciBvbmUsIG5vdCB0cnkKPiA+ID4gPiA+ID4gdG8gZ3Vlc3MuCj4gPiA+ID4g
PiA+ID4gVXNlciBzcGFjZSBzaG91bGQgbm90IGd1ZXNzIGVpdGhlci4gVXNlciBzcGFjZSBnZXRz
IHRvIHNlZSBpZiBfTVEKPiA+ID4gPiA+ID4gcHJlc2VudC9ub3QgcHJlc2VudC4gSWYgX01RIHBy
ZXNlbnQgdGhhbiBnZXQgcmVsaWFibGUgZGF0YSBmcm9tIGtlcm5lbC4KPiA+ID4gPiA+ID4gPiBJ
ZiBfTVEgbm90IHByZXNlbnQsIGl0IG1lYW5zIHRoaXMgZGV2aWNlIGhhcyBvbmUgVlEgcGFpci4K
PiA+ID4gPiA+ID4gaXQgaXMgc3RpbGwgYSBndWVzcywgcmlnaHQ/IEFuZCBhbGwgdXNlciBzcGFj
ZSB0b29scyBpbXBsZW1lbnRlZCB0aGlzCj4gPiA+ID4gPiA+IGZlYXR1cmUgbmVlZCB0byBndWVz
cwo+ID4gPiA+ID4gTm8uIGl0IGlzIG5vdCBhIGd1ZXNzLgo+ID4gPiA+ID4gSXQgaXMgZXhwbGlj
aXRseSBjaGVja2luZyB0aGUgX01RIGZlYXR1cmUgYW5kIGRlcml2aW5nIHRoZSB2YWx1ZS4KPiA+
ID4gPiA+IFRoZSBjb2RlIHlvdSBwcm9wb3NlZCB3aWxsIGJlIHByZXNlbnQgaW4gdGhlIHVzZXIg
c3BhY2UuCj4gPiA+ID4gPiBJdCB3aWxsIGJlIHVuaWZvcm0gZm9yIF9NUSBhbmQgMTAgb3RoZXIg
ZmVhdHVyZXMgdGhhdCBhcmUgcHJlc2VudCBub3cgYW5kCj4gPiA+ID4gaW4gdGhlIGZ1dHVyZS4K
PiA+ID4gPiBNUSBhbmQgb3RoZXIgZmVhdHVyZXMgbGlrZSBSU1MgYXJlIGRpZmZlcmVudC4gSWYg
dGhlcmUgaXMgbm8gX1JTU19YWCwgdGhlcmUKPiA+ID4gPiBhcmUgbm8gYXR0cmlidXRlcyBsaWtl
IG1heF9yc3Nfa2V5X3NpemUsIGFuZCB0aGVyZSBpcyBub3QgYSBkZWZhdWx0IHZhbHVlLgo+ID4g
PiA+IEJ1dCBmb3IgTVEsIHdlIGtub3cgaXQgaGFzIHRvIGJlIDEgd2lodG91dCBfTVEuCj4gPiA+
ICJ3ZSIgPSB1c2VyIHNwYWNlLgo+ID4gPiBUbyBrZWVwIHRoZSBjb25zaXN0ZW5jeSBhbW9uZyBh
bGwgdGhlIGNvbmZpZyBzcGFjZSBmaWVsZHMuCj4gPiBBY3R1YWxseSBJIGxvb2tlZCBhbmQgdGhl
IGNvZGUgc29tZSBtb3JlIGFuZCBJJ20gcHV6emxlZDoKPiA+IAo+ID4gCj4gPiAJc3RydWN0IHZp
cnRpb19uZXRfY29uZmlnIGNvbmZpZyA9IHt9Owo+ID4gCXU2NCBmZWF0dXJlczsKPiA+IAl1MTYg
dmFsX3UxNjsKPiA+IAo+ID4gCXZkcGFfZ2V0X2NvbmZpZ191bmxvY2tlZCh2ZGV2LCAwLCAmY29u
ZmlnLCBzaXplb2YoY29uZmlnKSk7Cj4gPiAKPiA+IAlpZiAobmxhX3B1dChtc2csIFZEUEFfQVRU
Ul9ERVZfTkVUX0NGR19NQUNBRERSLCBzaXplb2YoY29uZmlnLm1hYyksCj4gPiAJCSAgICBjb25m
aWcubWFjKSkKPiA+IAkJcmV0dXJuIC1FTVNHU0laRTsKPiA+IAo+ID4gCj4gPiBNYWMgcmV0dXJu
ZWQgZXZlbiB3aXRob3V0IFZJUlRJT19ORVRfRl9NQUMKPiA+IAo+ID4gCj4gPiAJdmFsX3UxNiA9
IGxlMTZfdG9fY3B1KGNvbmZpZy5zdGF0dXMpOwo+ID4gCWlmIChubGFfcHV0X3UxNihtc2csIFZE
UEFfQVRUUl9ERVZfTkVUX1NUQVRVUywgdmFsX3UxNikpCj4gPiAJCXJldHVybiAtRU1TR1NJWkU7
Cj4gPiAKPiA+IAo+ID4gc3RhdHVzIHJldHVybmVkIGV2ZW4gd2l0aG91dCBWSVJUSU9fTkVUX0Zf
U1RBVFVTCj4gPiAKPiA+IAl2YWxfdTE2ID0gbGUxNl90b19jcHUoY29uZmlnLm10dSk7Cj4gPiAJ
aWYgKG5sYV9wdXRfdTE2KG1zZywgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01UVSwgdmFsX3UxNikp
Cj4gPiAJCXJldHVybiAtRU1TR1NJWkU7Cj4gPiAKPiA+IAo+ID4gTVRVIHJldHVybmVkIGV2ZW4g
d2l0aG91dCBWSVJUSU9fTkVUX0ZfTVRVCj4gPiAKPiA+IAo+ID4gV2hhdCdzIGdvaW5nIG9uIGhl
cmU/Cj4gPiAKPiA+IAo+IEkgZ3Vlc3MgdGhpcyBpcyBzcGVjIHRoaW5nIChoaXN0b3JpY2FsIGRl
YnQpLCBJIHZhZ3VlbHkgcmVjYWxsIHRoZXNlIGZpZWxkcwo+IGFyZSBhbHdheXMgcHJlc2VudCBp
biBjb25maWcgc3BhY2UgcmVnYXJkbGVzcyB0aGUgZXhpc3RlbmNlIG9mIGNvcnJlc3BvbmRpbmcK
PiBmZWF0dXJlIGJpdC4KPiAKPiAtU2l3ZWkKCk5vcGU6CgoyLjUuMSAgRHJpdmVyIFJlcXVpcmVt
ZW50czogRGV2aWNlIENvbmZpZ3VyYXRpb24gU3BhY2UKCi4uLgoKRm9yIG9wdGlvbmFsIGNvbmZp
Z3VyYXRpb24gc3BhY2UgZmllbGRzLCB0aGUgZHJpdmVyIE1VU1QgY2hlY2sgdGhhdCB0aGUgY29y
cmVzcG9uZGluZyBmZWF0dXJlIGlzIG9mZmVyZWQKYmVmb3JlIGFjY2Vzc2luZyB0aGF0IHBhcnQg
b2YgdGhlIGNvbmZpZ3VyYXRpb24gc3BhY2UuCgoKLS0gCk1TVAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
