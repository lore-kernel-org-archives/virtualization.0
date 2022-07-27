Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72656C19F2B
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 15:48:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFFAD410C9;
	Wed, 27 Jul 2022 15:48:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFFAD410C9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JkDM3xC4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eL7IkC3FgBNn; Wed, 27 Jul 2022 15:48:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 21C26400C1;
	Wed, 27 Jul 2022 15:48:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 21C26400C1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2784C0035;
	Wed, 27 Jul 2022 15:48:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 269CFC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 15:48:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F405060E35
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 15:48:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F405060E35
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JkDM3xC4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gZatzNpQJXBX
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 15:48:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9CE360AA4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E9CE360AA4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 15:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658936930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NGWBRPKhQ0fhVaizU+EBcoZQesGUO5nyCUz66Nsm49c=;
 b=JkDM3xC409Nh3MnuW25ubmOIe3IgYjup17WIrNOsfiHFWcHtvOvuH/8O+cyw0yi0GRq5sn
 bcw7DbSb1SyLjkJ+8KYlDsWixS9zz4hm9XrMFEmC0/eq1KUumXxwpYWBqJE/YUNEyqAqg+
 QZz1n2wLODK8/ew/Ji+RskC+wHYy8Hk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-OdQXm50JPUuD6omPoNBL_Q-1; Wed, 27 Jul 2022 11:48:49 -0400
X-MC-Unique: OdQXm50JPUuD6omPoNBL_Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 h18-20020adfaa92000000b0021ec200d50fso949397wrc.14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 08:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=NGWBRPKhQ0fhVaizU+EBcoZQesGUO5nyCUz66Nsm49c=;
 b=rqYDRyFMZRinxGPcnl+LYTI95cb9uWCAXf92TBj7VzzcCiGfFT576AzJhPGxkvYy4B
 d6qJ+M6nsY/ahW79jwFQ1IofeCdMLgzqAbYvk464MN9TCY1Zo+gGkuPFRZwppxUi7huo
 d5AIRyICkB/xvbBPMLp5ne4zXKFRo3/eEbXhZpUt7eP/Kr1rretksmnObK+YvRLEMXZI
 P3YRoCHBlYxWpFSLc2xtzjjvTlmoERoctmDauP+u9+1S7X9HBApoWuMTzmzl79cm3V+h
 InImAz8KLOLoEvJue3RfY/wYv4NV1lc/yoaXibM6vUiByBax7YGyh6cUOzUs0liurwkQ
 PE7w==
X-Gm-Message-State: AJIora+c5JuykYA+fEC2gNn1OkaaJTqG87loHtC1FaVXAWX64rjP5IJz
 fVxT8fH7+zakkYURoYJFeQUoCG6lo51YdtKmpHQIf15+AYCdZdPdrHGvKJGYOgCj4U+UbOeZRAn
 9GUJak0dNTc2F/dEe8XcNzMYl8Kw3uZpLtsauORabFw==
X-Received: by 2002:a05:600c:410c:b0:3a3:2d78:f07f with SMTP id
 j12-20020a05600c410c00b003a32d78f07fmr3560387wmi.130.1658936928565; 
 Wed, 27 Jul 2022 08:48:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1utiKu7DvaK8PDHamMkME+2Z3wyhvX8bXVnILjhxBYs/vzPTAen9awZCX2/C526G81ZXCP6dw==
X-Received: by 2002:a05:600c:410c:b0:3a3:2d78:f07f with SMTP id
 j12-20020a05600c410c00b003a32d78f07fmr3560359wmi.130.1658936928113; 
 Wed, 27 Jul 2022 08:48:48 -0700 (PDT)
Received: from redhat.com ([2.52.132.243]) by smtp.gmail.com with ESMTPSA id
 e10-20020adfe38a000000b0021b970a68f9sm621502wrm.26.2022.07.27.08.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jul 2022 08:48:47 -0700 (PDT)
Date: Wed, 27 Jul 2022 11:48:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Message-ID: <20220727114602-mutt-send-email-mst@kernel.org>
References: <1246d2f1-2822-0edb-cd57-efc4015f05a2@intel.com>
 <PH0PR12MB54815985C202E81122459DFFDC949@PH0PR12MB5481.namprd12.prod.outlook.com>
 <19681358-fc81-be5b-c20b-7394a549f0be@intel.com>
 <PH0PR12MB54818158D4F7F9F556022857DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e98fc062-021b-848b-5cf4-15bd63a11c5c@intel.com>
 <PH0PR12MB54815AD7D0674FEB1D63EB61DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220727015626-mutt-send-email-mst@kernel.org>
 <66291287-fcb3-be8d-2c1b-dd44533ed8b3@oracle.com>
 <20220727050102-mutt-send-email-mst@kernel.org>
 <6d5b03ee-5362-8534-5881-a34c9ea626f0@oracle.com>
MIME-Version: 1.0
In-Reply-To: <6d5b03ee-5362-8534-5881-a34c9ea626f0@oracle.com>
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

T24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMDM6MDk6NDNBTSAtMDcwMCwgU2ktV2VpIExpdSB3cm90
ZToKPiAKPiAKPiBPbiA3LzI3LzIwMjIgMjowMSBBTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMTI6NTA6MzNBTSAtMDcwMCwgU2ktV2VpIExp
dSB3cm90ZToKPiA+ID4gCj4gPiA+IE9uIDcvMjYvMjAyMiAxMTowMSBQTSwgTWljaGFlbCBTLiBU
c2lya2luIHdyb3RlOgo+ID4gPiA+IE9uIFdlZCwgSnVsIDI3LCAyMDIyIGF0IDAzOjQ3OjM1QU0g
KzAwMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToKPiA+ID4gPiA+ID4gRnJvbTogWmh1LCBMaW5nc2hh
biA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPiA+ID4gPiA+ID4gU2VudDogVHVlc2RheSwgSnVs
eSAyNiwgMjAyMiAxMDo1MyBQTQo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gT24gNy8yNy8yMDIy
IDEwOjE3IEFNLCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiBGcm9tOiBaaHUs
IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+ID4gPiA+ID4gPiA+ID4gU2VudDog
VHVlc2RheSwgSnVseSAyNiwgMjAyMiAxMDoxNSBQTQo+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4g
PiA+ID4gPiBPbiA3LzI2LzIwMjIgMTE6NTYgUE0sIFBhcmF2IFBhbmRpdCB3cm90ZToKPiA+ID4g
PiA+ID4gPiA+ID4gPiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29t
Pgo+ID4gPiA+ID4gPiA+ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMTIsIDIwMjIgMTE6NDYg
UE0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFdoZW4gdGhlIHVzZXIgc3BhY2Ugd2hpY2ggaW52b2tl
cyBuZXRsaW5rIGNvbW1hbmRzLCBkZXRlY3RzIHRoYXQKPiA+ID4gPiA+ID4gPiA+IF9NUQo+ID4g
PiA+ID4gPiA+ID4gPiA+IGlzIG5vdCBzdXBwb3J0ZWQsIGhlbmNlIGl0IHRha2VzIG1heF9xdWV1
ZV9wYWlyID0gMSBieSBpdHNlbGYuCj4gPiA+ID4gPiA+ID4gPiA+ID4gSSB0aGluayB0aGUga2Vy
bmVsIG1vZHVsZSBoYXZlIGFsbCBuZWNlc3NhcnkgaW5mb3JtYXRpb24gYW5kIGl0IGlzCj4gPiA+
ID4gPiA+ID4gPiA+ID4gdGhlIG9ubHkgb25lIHdoaWNoIGhhdmUgcHJlY2lzZSBpbmZvcm1hdGlv
biBvZiBhIGRldmljZSwgc28gaXQKPiA+ID4gPiA+ID4gPiA+ID4gPiBzaG91bGQgYW5zd2VyIHBy
ZWNpc2VseSB0aGFuIGxldCB0aGUgdXNlciBzcGFjZSBndWVzcy4gVGhlIGtlcm5lbAo+ID4gPiA+
ID4gPiA+ID4gPiA+IG1vZHVsZSBzaG91bGQgYmUgcmVsaWFibGUgdGhhbiBzdGF5IHNpbGVudCwg
bGVhdmUgdGhlIHF1ZXN0aW9uIHRvCj4gPiA+ID4gPiA+ID4gPiA+ID4gdGhlIHVzZXIgc3BhY2UK
PiA+ID4gPiA+ID4gPiA+IHRvb2wuCj4gPiA+ID4gPiA+ID4gPiA+IEtlcm5lbCBpcyByZWxpYWJs
ZS4gSXQgZG9lc27igJl0IGV4cG9zZSBhIGNvbmZpZyBzcGFjZSBmaWVsZCBpZiB0aGUKPiA+ID4g
PiA+ID4gPiA+ID4gZmllbGQgZG9lc27igJl0Cj4gPiA+ID4gPiA+ID4gPiBleGlzdCByZWdhcmRs
ZXNzIG9mIGZpZWxkIHNob3VsZCBoYXZlIGRlZmF1bHQgb3Igbm8gZGVmYXVsdC4KPiA+ID4gPiA+
ID4gPiA+IHNvIHdoZW4geW91IGtub3cgaXQgaXMgb25lIHF1ZXVlIHBhaXIsIHlvdSBzaG91bGQg
YW5zd2VyIG9uZSwgbm90IHRyeQo+ID4gPiA+ID4gPiA+ID4gdG8gZ3Vlc3MuCj4gPiA+ID4gPiA+
ID4gPiA+IFVzZXIgc3BhY2Ugc2hvdWxkIG5vdCBndWVzcyBlaXRoZXIuIFVzZXIgc3BhY2UgZ2V0
cyB0byBzZWUgaWYgX01RCj4gPiA+ID4gPiA+ID4gPiBwcmVzZW50L25vdCBwcmVzZW50LiBJZiBf
TVEgcHJlc2VudCB0aGFuIGdldCByZWxpYWJsZSBkYXRhIGZyb20ga2VybmVsLgo+ID4gPiA+ID4g
PiA+ID4gPiBJZiBfTVEgbm90IHByZXNlbnQsIGl0IG1lYW5zIHRoaXMgZGV2aWNlIGhhcyBvbmUg
VlEgcGFpci4KPiA+ID4gPiA+ID4gPiA+IGl0IGlzIHN0aWxsIGEgZ3Vlc3MsIHJpZ2h0PyBBbmQg
YWxsIHVzZXIgc3BhY2UgdG9vbHMgaW1wbGVtZW50ZWQgdGhpcwo+ID4gPiA+ID4gPiA+ID4gZmVh
dHVyZSBuZWVkIHRvIGd1ZXNzCj4gPiA+ID4gPiA+ID4gTm8uIGl0IGlzIG5vdCBhIGd1ZXNzLgo+
ID4gPiA+ID4gPiA+IEl0IGlzIGV4cGxpY2l0bHkgY2hlY2tpbmcgdGhlIF9NUSBmZWF0dXJlIGFu
ZCBkZXJpdmluZyB0aGUgdmFsdWUuCj4gPiA+ID4gPiA+ID4gVGhlIGNvZGUgeW91IHByb3Bvc2Vk
IHdpbGwgYmUgcHJlc2VudCBpbiB0aGUgdXNlciBzcGFjZS4KPiA+ID4gPiA+ID4gPiBJdCB3aWxs
IGJlIHVuaWZvcm0gZm9yIF9NUSBhbmQgMTAgb3RoZXIgZmVhdHVyZXMgdGhhdCBhcmUgcHJlc2Vu
dCBub3cgYW5kCj4gPiA+ID4gPiA+IGluIHRoZSBmdXR1cmUuCj4gPiA+ID4gPiA+IE1RIGFuZCBv
dGhlciBmZWF0dXJlcyBsaWtlIFJTUyBhcmUgZGlmZmVyZW50LiBJZiB0aGVyZSBpcyBubyBfUlNT
X1hYLCB0aGVyZQo+ID4gPiA+ID4gPiBhcmUgbm8gYXR0cmlidXRlcyBsaWtlIG1heF9yc3Nfa2V5
X3NpemUsIGFuZCB0aGVyZSBpcyBub3QgYSBkZWZhdWx0IHZhbHVlLgo+ID4gPiA+ID4gPiBCdXQg
Zm9yIE1RLCB3ZSBrbm93IGl0IGhhcyB0byBiZSAxIHdpaHRvdXQgX01RLgo+ID4gPiA+ID4gIndl
IiA9IHVzZXIgc3BhY2UuCj4gPiA+ID4gPiBUbyBrZWVwIHRoZSBjb25zaXN0ZW5jeSBhbW9uZyBh
bGwgdGhlIGNvbmZpZyBzcGFjZSBmaWVsZHMuCj4gPiA+ID4gQWN0dWFsbHkgSSBsb29rZWQgYW5k
IHRoZSBjb2RlIHNvbWUgbW9yZSBhbmQgSSdtIHB1enpsZWQ6Cj4gPiA+ID4gCj4gPiA+ID4gCj4g
PiA+ID4gCXN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyBjb25maWcgPSB7fTsKPiA+ID4gPiAJdTY0
IGZlYXR1cmVzOwo+ID4gPiA+IAl1MTYgdmFsX3UxNjsKPiA+ID4gPiAKPiA+ID4gPiAJdmRwYV9n
ZXRfY29uZmlnX3VubG9ja2VkKHZkZXYsIDAsICZjb25maWcsIHNpemVvZihjb25maWcpKTsKPiA+
ID4gPiAKPiA+ID4gPiAJaWYgKG5sYV9wdXQobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFD
QUREUiwgc2l6ZW9mKGNvbmZpZy5tYWMpLAo+ID4gPiA+IAkJICAgIGNvbmZpZy5tYWMpKQo+ID4g
PiA+IAkJcmV0dXJuIC1FTVNHU0laRTsKPiA+ID4gPiAKPiA+ID4gPiAKPiA+ID4gPiBNYWMgcmV0
dXJuZWQgZXZlbiB3aXRob3V0IFZJUlRJT19ORVRfRl9NQUMKPiA+ID4gPiAKPiA+ID4gPiAKPiA+
ID4gPiAJdmFsX3UxNiA9IGxlMTZfdG9fY3B1KGNvbmZpZy5zdGF0dXMpOwo+ID4gPiA+IAlpZiAo
bmxhX3B1dF91MTYobXNnLCBWRFBBX0FUVFJfREVWX05FVF9TVEFUVVMsIHZhbF91MTYpKQo+ID4g
PiA+IAkJcmV0dXJuIC1FTVNHU0laRTsKPiA+ID4gPiAKPiA+ID4gPiAKPiA+ID4gPiBzdGF0dXMg
cmV0dXJuZWQgZXZlbiB3aXRob3V0IFZJUlRJT19ORVRfRl9TVEFUVVMKPiA+ID4gPiAKPiA+ID4g
PiAJdmFsX3UxNiA9IGxlMTZfdG9fY3B1KGNvbmZpZy5tdHUpOwo+ID4gPiA+IAlpZiAobmxhX3B1
dF91MTYobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTVRVLCB2YWxfdTE2KSkKPiA+ID4gPiAJ
CXJldHVybiAtRU1TR1NJWkU7Cj4gPiA+ID4gCj4gPiA+ID4gCj4gPiA+ID4gTVRVIHJldHVybmVk
IGV2ZW4gd2l0aG91dCBWSVJUSU9fTkVUX0ZfTVRVCj4gPiA+ID4gCj4gPiA+ID4gCj4gPiA+ID4g
V2hhdCdzIGdvaW5nIG9uIGhlcmU/Cj4gPiA+ID4gCj4gPiA+ID4gCj4gPiA+IEkgZ3Vlc3MgdGhp
cyBpcyBzcGVjIHRoaW5nIChoaXN0b3JpY2FsIGRlYnQpLCBJIHZhZ3VlbHkgcmVjYWxsIHRoZXNl
IGZpZWxkcwo+ID4gPiBhcmUgYWx3YXlzIHByZXNlbnQgaW4gY29uZmlnIHNwYWNlIHJlZ2FyZGxl
c3MgdGhlIGV4aXN0ZW5jZSBvZiBjb3JyZXNwb25kaW5nCj4gPiA+IGZlYXR1cmUgYml0Lgo+ID4g
PiAKPiA+ID4gLVNpd2VpCj4gPiBOb3BlOgo+ID4gCj4gPiAyLjUuMSAgRHJpdmVyIFJlcXVpcmVt
ZW50czogRGV2aWNlIENvbmZpZ3VyYXRpb24gU3BhY2UKPiA+IAo+ID4gLi4uCj4gPiAKPiA+IEZv
ciBvcHRpb25hbCBjb25maWd1cmF0aW9uIHNwYWNlIGZpZWxkcywgdGhlIGRyaXZlciBNVVNUIGNo
ZWNrIHRoYXQgdGhlIGNvcnJlc3BvbmRpbmcgZmVhdHVyZSBpcyBvZmZlcmVkCj4gPiBiZWZvcmUg
YWNjZXNzaW5nIHRoYXQgcGFydCBvZiB0aGUgY29uZmlndXJhdGlvbiBzcGFjZS4KPiBXZWxsLCB0
aGlzIGlzIGRyaXZlciBzaWRlIG9mIHJlcXVpcmVtZW50LgoKCldlbGwgZHJpdmVyIGFuZCBkZXZp
Y2UgYXJlIHRoZSBvbmx5IHR3byBlbnRpdGllcyBpbiB0aGUgc3BlYy4KCj4gQXMgdGhpcyBpbnRl
cmZhY2UgaXMgZm9yIGhvc3QKPiBhZG1pbiB0b29sIHRvIHF1ZXJ5IG9yIGNvbmZpZ3VyZSB2ZHBh
IGRldmljZSwgd2UgZG9uJ3QgaGF2ZSB0byB3YWl0IHVudGlsCj4gZmVhdHVyZSBuZWdvdGlhdGlv
biBpcyBkb25lIG9uIGd1ZXN0IGRyaXZlciB0byBleHRyYWN0IHZkcGEKPiBhdHRyaWJ1dGVzL3Bh
cmFtZXRlcnMsIHNheSBpZiB3ZSB3YW50IHRvIHJlcGxpY2F0ZSBhbm90aGVyIHZkcGEgZGV2aWNl
IHdpdGgKPiB0aGUgc2FtZSBjb25maWcgb24gbWlncmF0aW9uIGRlc3RpbmF0aW9uLiBJIHRoaW5r
IHdoYXQgbWF5IG5lZWQgdG8gYmUgZml4IGlzCj4gdG8gbW92ZSBvZmYgZnJvbSB1c2luZyAudmRw
YV9nZXRfY29uZmlnX3VubG9ja2VkKCkgd2hpY2ggZGVwZW5kcyBvbiBmZWF0dXJlCj4gbmVnb3Rp
YXRpb24uIEFuZC9vciBleHBvc2UgY29uZmlnIHNwYWNlIHJlZ2lzdGVyIHZhbHVlcyB0aHJvdWdo
IGFub3RoZXIgc2V0Cj4gb2YgYXR0cmlidXRlcy4KPiAKPiAtU2l3ZWkKPiAKPiAKClNvdW5kcyBs
aWtlIHNvbWV0aGluZyB0aGF0IG1pZ2h0IHVzZSB0aGUgcHJvcG9zZWQgYWRtaW4gcXVldWUgbWF5
YmUuCkhvcGUgdGhhdCBtYWtlcyBwcm9ncmVzcyAuLi4KCgotLSAKTVNUCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
