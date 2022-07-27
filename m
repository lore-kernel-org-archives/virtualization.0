Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07118C19F21
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 06:01:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 675514025E;
	Wed, 27 Jul 2022 06:01:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 675514025E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gnddv+wa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gtDbXJEhBzMv; Wed, 27 Jul 2022 06:01:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5914B40131;
	Wed, 27 Jul 2022 06:01:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5914B40131
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F06AC0033;
	Wed, 27 Jul 2022 06:01:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6617FC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 06:01:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 405A2403AA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 06:01:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 405A2403AA
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gnddv+wa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ONIPfF2dMeso
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 06:01:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 72B2E40132
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 72B2E40132
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 06:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658901684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8xtXdluvgXBSpfS+jXxthX445YwgzUazMcxwBGlNiPo=;
 b=Gnddv+waQTykhZpK65Qiyv44AaxsodPt0eERf78FbvXMxKHr47gVYMMG20WDwfqrbqOs6Q
 9RDp2XMquhryfdggWOb0mGETM1O6N4q5qPdwrCkPZjRomwbKcPxRgSIdxam7pd5yQKbSzJ
 bl6l6q0EnE6tEr7Ms8sEmLxOq5CAUto=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-OVJ99ciXM-2NYQuYCUcp2w-1; Wed, 27 Jul 2022 02:01:22 -0400
X-MC-Unique: OVJ99ciXM-2NYQuYCUcp2w-1
Received: by mail-wm1-f72.google.com with SMTP id
 t25-20020a1c7719000000b003a3564fa721so4369506wmi.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 23:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=8xtXdluvgXBSpfS+jXxthX445YwgzUazMcxwBGlNiPo=;
 b=t4B+cSUL5Hjv23MipCnVL7hwgXnaHrImKqlYhPLngP7rf+fyPQFjRArNFbKgX2YvNV
 iSDs3zPX74QNmJcwEZuB1twjYcsHYCEgy1QhEdPqKxxiEJIeSb6qYUWAD9SN4iLULWK8
 d9gLWHPGdZwdHtNMUKSfaO9iO7R6VKY0yuA8xCasc9w4/fs7Uzx3KvZf3StoXUYDlb4l
 k2n0PwYEyM6TIvPW0a0joUpJXKvee3K1bgxk0+rYT2im3AAKAC+RDKLB80f9HUtOaMfY
 REzsKqhbDHbIOcsoM2hg3rm27teA8DOlp+fUhlHdG7u0LuS5QSQRV9bGjklQZxDkVjSF
 ViwA==
X-Gm-Message-State: AJIora+0CXMTFU7KxLixD701GA/aLqRklOO5FwXpZLYvGgbR39eDyC1g
 zO/Ta/4slqprD02qVpPaDY5VWfZtSr/FpZw+4ELfBkrd5+q1RhL3FJRZyHaL8qVawrl+2X+n8hl
 AdXdFi4EGrJjjAXrCc+rHDQyHWAmIuLEz1HVGaKgnOw==
X-Received: by 2002:a5d:4650:0:b0:21e:9ddc:12c with SMTP id
 j16-20020a5d4650000000b0021e9ddc012cmr4689278wrs.596.1658901681370; 
 Tue, 26 Jul 2022 23:01:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vOTbqWpRU/40fypnlbnuUalUXC628tK3i1DrsZNBw0v1zxLs5MSuXJ/M5aG8OlYITs8NAf9w==
X-Received: by 2002:a5d:4650:0:b0:21e:9ddc:12c with SMTP id
 j16-20020a5d4650000000b0021e9ddc012cmr4689262wrs.596.1658901681084; 
 Tue, 26 Jul 2022 23:01:21 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7424:0:3d16:86dc:de54:5671])
 by smtp.gmail.com with ESMTPSA id
 q2-20020adff502000000b0021ece43e1besm690698wro.114.2022.07.26.23.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jul 2022 23:01:20 -0700 (PDT)
Date: Wed, 27 Jul 2022 02:01:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Message-ID: <20220727015626-mutt-send-email-mst@kernel.org>
References: <00c1f5e8-e58d-5af7-cc6b-b29398e17c8b@intel.com>
 <PH0PR12MB54817863E7BA89D6BB5A5F8CDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <c7c8f49c-484f-f5b3-39e6-0d17f396cca7@intel.com>
 <PH0PR12MB5481E65037E0B4F6F583193BDC899@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1246d2f1-2822-0edb-cd57-efc4015f05a2@intel.com>
 <PH0PR12MB54815985C202E81122459DFFDC949@PH0PR12MB5481.namprd12.prod.outlook.com>
 <19681358-fc81-be5b-c20b-7394a549f0be@intel.com>
 <PH0PR12MB54818158D4F7F9F556022857DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e98fc062-021b-848b-5cf4-15bd63a11c5c@intel.com>
 <PH0PR12MB54815AD7D0674FEB1D63EB61DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54815AD7D0674FEB1D63EB61DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
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

T24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMDM6NDc6MzVBTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdy
b3RlOgo+IAo+ID4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4K
PiA+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjYsIDIwMjIgMTA6NTMgUE0KPiA+IAo+ID4gT24gNy8y
Ny8yMDIyIDEwOjE3IEFNLCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4gPiA+PiBGcm9tOiBaaHUsIExp
bmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+ID4gPj4gU2VudDogVHVlc2RheSwgSnVs
eSAyNiwgMjAyMiAxMDoxNSBQTQo+ID4gPj4KPiA+ID4+IE9uIDcvMjYvMjAyMiAxMTo1NiBQTSwg
UGFyYXYgUGFuZGl0IHdyb3RlOgo+ID4gPj4+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hh
bi56aHVAaW50ZWwuY29tPgo+ID4gPj4+PiBTZW50OiBUdWVzZGF5LCBKdWx5IDEyLCAyMDIyIDEx
OjQ2IFBNCj4gPiA+Pj4+PiBXaGVuIHRoZSB1c2VyIHNwYWNlIHdoaWNoIGludm9rZXMgbmV0bGlu
ayBjb21tYW5kcywgZGV0ZWN0cyB0aGF0Cj4gPiA+PiBfTVEKPiA+ID4+Pj4gaXMgbm90IHN1cHBv
cnRlZCwgaGVuY2UgaXQgdGFrZXMgbWF4X3F1ZXVlX3BhaXIgPSAxIGJ5IGl0c2VsZi4KPiA+ID4+
Pj4gSSB0aGluayB0aGUga2VybmVsIG1vZHVsZSBoYXZlIGFsbCBuZWNlc3NhcnkgaW5mb3JtYXRp
b24gYW5kIGl0IGlzCj4gPiA+Pj4+IHRoZSBvbmx5IG9uZSB3aGljaCBoYXZlIHByZWNpc2UgaW5m
b3JtYXRpb24gb2YgYSBkZXZpY2UsIHNvIGl0Cj4gPiA+Pj4+IHNob3VsZCBhbnN3ZXIgcHJlY2lz
ZWx5IHRoYW4gbGV0IHRoZSB1c2VyIHNwYWNlIGd1ZXNzLiBUaGUga2VybmVsCj4gPiA+Pj4+IG1v
ZHVsZSBzaG91bGQgYmUgcmVsaWFibGUgdGhhbiBzdGF5IHNpbGVudCwgbGVhdmUgdGhlIHF1ZXN0
aW9uIHRvCj4gPiA+Pj4+IHRoZSB1c2VyIHNwYWNlCj4gPiA+PiB0b29sLgo+ID4gPj4+IEtlcm5l
bCBpcyByZWxpYWJsZS4gSXQgZG9lc27igJl0IGV4cG9zZSBhIGNvbmZpZyBzcGFjZSBmaWVsZCBp
ZiB0aGUKPiA+ID4+PiBmaWVsZCBkb2VzbuKAmXQKPiA+ID4+IGV4aXN0IHJlZ2FyZGxlc3Mgb2Yg
ZmllbGQgc2hvdWxkIGhhdmUgZGVmYXVsdCBvciBubyBkZWZhdWx0Lgo+ID4gPj4gc28gd2hlbiB5
b3Uga25vdyBpdCBpcyBvbmUgcXVldWUgcGFpciwgeW91IHNob3VsZCBhbnN3ZXIgb25lLCBub3Qg
dHJ5Cj4gPiA+PiB0byBndWVzcy4KPiA+ID4+PiBVc2VyIHNwYWNlIHNob3VsZCBub3QgZ3Vlc3Mg
ZWl0aGVyLiBVc2VyIHNwYWNlIGdldHMgdG8gc2VlIGlmIF9NUQo+ID4gPj4gcHJlc2VudC9ub3Qg
cHJlc2VudC4gSWYgX01RIHByZXNlbnQgdGhhbiBnZXQgcmVsaWFibGUgZGF0YSBmcm9tIGtlcm5l
bC4KPiA+ID4+PiBJZiBfTVEgbm90IHByZXNlbnQsIGl0IG1lYW5zIHRoaXMgZGV2aWNlIGhhcyBv
bmUgVlEgcGFpci4KPiA+ID4+IGl0IGlzIHN0aWxsIGEgZ3Vlc3MsIHJpZ2h0PyBBbmQgYWxsIHVz
ZXIgc3BhY2UgdG9vbHMgaW1wbGVtZW50ZWQgdGhpcwo+ID4gPj4gZmVhdHVyZSBuZWVkIHRvIGd1
ZXNzCj4gPiA+IE5vLiBpdCBpcyBub3QgYSBndWVzcy4KPiA+ID4gSXQgaXMgZXhwbGljaXRseSBj
aGVja2luZyB0aGUgX01RIGZlYXR1cmUgYW5kIGRlcml2aW5nIHRoZSB2YWx1ZS4KPiA+ID4gVGhl
IGNvZGUgeW91IHByb3Bvc2VkIHdpbGwgYmUgcHJlc2VudCBpbiB0aGUgdXNlciBzcGFjZS4KPiA+
ID4gSXQgd2lsbCBiZSB1bmlmb3JtIGZvciBfTVEgYW5kIDEwIG90aGVyIGZlYXR1cmVzIHRoYXQg
YXJlIHByZXNlbnQgbm93IGFuZAo+ID4gaW4gdGhlIGZ1dHVyZS4KPiA+IE1RIGFuZCBvdGhlciBm
ZWF0dXJlcyBsaWtlIFJTUyBhcmUgZGlmZmVyZW50LiBJZiB0aGVyZSBpcyBubyBfUlNTX1hYLCB0
aGVyZQo+ID4gYXJlIG5vIGF0dHJpYnV0ZXMgbGlrZSBtYXhfcnNzX2tleV9zaXplLCBhbmQgdGhl
cmUgaXMgbm90IGEgZGVmYXVsdCB2YWx1ZS4KPiA+IEJ1dCBmb3IgTVEsIHdlIGtub3cgaXQgaGFz
IHRvIGJlIDEgd2lodG91dCBfTVEuCj4gIndlIiA9IHVzZXIgc3BhY2UuCj4gVG8ga2VlcCB0aGUg
Y29uc2lzdGVuY3kgYW1vbmcgYWxsIHRoZSBjb25maWcgc3BhY2UgZmllbGRzLgoKQWN0dWFsbHkg
SSBsb29rZWQgYW5kIHRoZSBjb2RlIHNvbWUgbW9yZSBhbmQgSSdtIHB1enpsZWQ6CgoKCXN0cnVj
dCB2aXJ0aW9fbmV0X2NvbmZpZyBjb25maWcgPSB7fTsKCXU2NCBmZWF0dXJlczsKCXUxNiB2YWxf
dTE2OwoKCXZkcGFfZ2V0X2NvbmZpZ191bmxvY2tlZCh2ZGV2LCAwLCAmY29uZmlnLCBzaXplb2Yo
Y29uZmlnKSk7CgoJaWYgKG5sYV9wdXQobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFDQURE
Uiwgc2l6ZW9mKGNvbmZpZy5tYWMpLAoJCSAgICBjb25maWcubWFjKSkKCQlyZXR1cm4gLUVNU0dT
SVpFOwoKCk1hYyByZXR1cm5lZCBldmVuIHdpdGhvdXQgVklSVElPX05FVF9GX01BQwoKCgl2YWxf
dTE2ID0gbGUxNl90b19jcHUoY29uZmlnLnN0YXR1cyk7CglpZiAobmxhX3B1dF91MTYobXNnLCBW
RFBBX0FUVFJfREVWX05FVF9TVEFUVVMsIHZhbF91MTYpKQoJCXJldHVybiAtRU1TR1NJWkU7CgoK
c3RhdHVzIHJldHVybmVkIGV2ZW4gd2l0aG91dCBWSVJUSU9fTkVUX0ZfU1RBVFVTCgoJdmFsX3Ux
NiA9IGxlMTZfdG9fY3B1KGNvbmZpZy5tdHUpOwoJaWYgKG5sYV9wdXRfdTE2KG1zZywgVkRQQV9B
VFRSX0RFVl9ORVRfQ0ZHX01UVSwgdmFsX3UxNikpCgkJcmV0dXJuIC1FTVNHU0laRTsKCgpNVFUg
cmV0dXJuZWQgZXZlbiB3aXRob3V0IFZJUlRJT19ORVRfRl9NVFUKCgpXaGF0J3MgZ29pbmcgb24g
aGVyZT8KCgotLSAKTVNUCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
