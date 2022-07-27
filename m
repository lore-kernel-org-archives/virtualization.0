Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC706C04A68
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 06:54:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 742F7402B7;
	Wed, 27 Jul 2022 06:54:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 742F7402B7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WJUaf7CF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id id-vHQ3m1nDk; Wed, 27 Jul 2022 06:54:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BCD8E402BA;
	Wed, 27 Jul 2022 06:54:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BCD8E402BA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D818C0035;
	Wed, 27 Jul 2022 06:54:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55212C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 06:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 29D5181429
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 06:54:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29D5181429
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WJUaf7CF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bzVvkzQr80fx
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 06:54:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C814E81390
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C814E81390
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 06:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658904871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L0RBiYqbTKOmiNtSdg/JY0oqdCuNT1JWvGzLzPojPqE=;
 b=WJUaf7CFImSfm9MRDj++zfvN53fbxpKe1qhZlkNhnvkGBRA7FAV5pBL09c0pJ4TUX5mABf
 kFdslDzYPYHFjAfedAjikP5RVxbqQ7CSifyVBfsW3IVtkI1pcLUv3OHEfSN7Ga6KqDPowI
 03PdPFRUZktE2mjBciYtE/mv4Ko7/Lo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-08BC__kvMpGbbnBJ99EBXA-1; Wed, 27 Jul 2022 02:54:26 -0400
X-MC-Unique: 08BC__kvMpGbbnBJ99EBXA-1
Received: by mail-ej1-f69.google.com with SMTP id
 ne36-20020a1709077ba400b0072b64ce28aaso4786999ejc.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 23:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=L0RBiYqbTKOmiNtSdg/JY0oqdCuNT1JWvGzLzPojPqE=;
 b=k87i1VeImZk4mJOEm+CKHMR5EYM0erqOCeT8j+0uRJjSbtmFXBEvjjHHCFetXdgMNB
 5oDvOFAgnxEKW5v6RP5dXU3rWYYUJukeiADFYhFISGvw9VVhpe5+oidC3ggv3PWzEDrq
 FyMlKGDg5Z9jqxlkVEEmfWLDxP9f03TLr3dS8JZu61tr3DG2GEqUc7JjdVUbkBnJxiJ7
 VyaFYEu+6Z+J5z9OTwMRUHm5CMy87iemyWD3oJegFpoxCw/v3DXYl9rvPGkqb6utJ76d
 gnEySUaS5nnSnAAgLyg8xP4XfmSFI7WXhRYnbVWdztkPR7JuqWDqDLXAv6J2Q44i3lRw
 ulDw==
X-Gm-Message-State: AJIora/gjcl4qKWi9q3sx3dJ/MZHjmSMV143dIfsDjB+hoq+pAJvu/pd
 UuUmAxpTUfatbo3J81xdpXYFTyiulG6xmjyqE3jEV7aIogvSqT0gydqaMVQZ0gPNKSYCHrl6TlI
 piOQrrwQsHK00JsCLejOva4DMnOYU2W/0967CfN4mR6PkyEXzZRINuIREcg==
X-Received: by 2002:a17:907:2e01:b0:72b:764f:ea1a with SMTP id
 ig1-20020a1709072e0100b0072b764fea1amr16740658ejc.666.1658904865299; 
 Tue, 26 Jul 2022 23:54:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ttURj45GmcmCgoN2FKc6GWCz8LkXqzyZdtKzxRJrMdQxqQdaeJO3NTVt7BKYcs5Xma4dyLVruOhUvtrT/gPDo=
X-Received: by 2002:a17:907:2e01:b0:72b:764f:ea1a with SMTP id
 ig1-20020a1709072e0100b0072b764fea1amr16740638ejc.666.1658904864824; Tue, 26
 Jul 2022 23:54:24 -0700 (PDT)
MIME-Version: 1.0
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
 <20220727015626-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220727015626-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Jul 2022 14:54:13 +0800
Message-ID: <CACGkMEv62tuOP3ra0GBhjCH=syFWxP+GVfGL_i0Ce0iD4uMY=Q@mail.gmail.com>
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

T24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMjowMSBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgSnVsIDI3LCAyMDIyIGF0IDAzOjQ3OjM1QU0g
KzAwMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToKPiA+Cj4gPiA+IEZyb206IFpodSwgTGluZ3NoYW4g
PGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4gPiA+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjYsIDIw
MjIgMTA6NTMgUE0KPiA+ID4KPiA+ID4gT24gNy8yNy8yMDIyIDEwOjE3IEFNLCBQYXJhdiBQYW5k
aXQgd3JvdGU6Cj4gPiA+ID4+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRl
bC5jb20+Cj4gPiA+ID4+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjYsIDIwMjIgMTA6MTUgUE0KPiA+
ID4gPj4KPiA+ID4gPj4gT24gNy8yNi8yMDIyIDExOjU2IFBNLCBQYXJhdiBQYW5kaXQgd3JvdGU6
Cj4gPiA+ID4+Pj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4K
PiA+ID4gPj4+PiBTZW50OiBUdWVzZGF5LCBKdWx5IDEyLCAyMDIyIDExOjQ2IFBNCj4gPiA+ID4+
Pj4+IFdoZW4gdGhlIHVzZXIgc3BhY2Ugd2hpY2ggaW52b2tlcyBuZXRsaW5rIGNvbW1hbmRzLCBk
ZXRlY3RzIHRoYXQKPiA+ID4gPj4gX01RCj4gPiA+ID4+Pj4gaXMgbm90IHN1cHBvcnRlZCwgaGVu
Y2UgaXQgdGFrZXMgbWF4X3F1ZXVlX3BhaXIgPSAxIGJ5IGl0c2VsZi4KPiA+ID4gPj4+PiBJIHRo
aW5rIHRoZSBrZXJuZWwgbW9kdWxlIGhhdmUgYWxsIG5lY2Vzc2FyeSBpbmZvcm1hdGlvbiBhbmQg
aXQgaXMKPiA+ID4gPj4+PiB0aGUgb25seSBvbmUgd2hpY2ggaGF2ZSBwcmVjaXNlIGluZm9ybWF0
aW9uIG9mIGEgZGV2aWNlLCBzbyBpdAo+ID4gPiA+Pj4+IHNob3VsZCBhbnN3ZXIgcHJlY2lzZWx5
IHRoYW4gbGV0IHRoZSB1c2VyIHNwYWNlIGd1ZXNzLiBUaGUga2VybmVsCj4gPiA+ID4+Pj4gbW9k
dWxlIHNob3VsZCBiZSByZWxpYWJsZSB0aGFuIHN0YXkgc2lsZW50LCBsZWF2ZSB0aGUgcXVlc3Rp
b24gdG8KPiA+ID4gPj4+PiB0aGUgdXNlciBzcGFjZQo+ID4gPiA+PiB0b29sLgo+ID4gPiA+Pj4g
S2VybmVsIGlzIHJlbGlhYmxlLiBJdCBkb2VzbuKAmXQgZXhwb3NlIGEgY29uZmlnIHNwYWNlIGZp
ZWxkIGlmIHRoZQo+ID4gPiA+Pj4gZmllbGQgZG9lc27igJl0Cj4gPiA+ID4+IGV4aXN0IHJlZ2Fy
ZGxlc3Mgb2YgZmllbGQgc2hvdWxkIGhhdmUgZGVmYXVsdCBvciBubyBkZWZhdWx0Lgo+ID4gPiA+
PiBzbyB3aGVuIHlvdSBrbm93IGl0IGlzIG9uZSBxdWV1ZSBwYWlyLCB5b3Ugc2hvdWxkIGFuc3dl
ciBvbmUsIG5vdCB0cnkKPiA+ID4gPj4gdG8gZ3Vlc3MuCj4gPiA+ID4+PiBVc2VyIHNwYWNlIHNo
b3VsZCBub3QgZ3Vlc3MgZWl0aGVyLiBVc2VyIHNwYWNlIGdldHMgdG8gc2VlIGlmIF9NUQo+ID4g
PiA+PiBwcmVzZW50L25vdCBwcmVzZW50LiBJZiBfTVEgcHJlc2VudCB0aGFuIGdldCByZWxpYWJs
ZSBkYXRhIGZyb20ga2VybmVsLgo+ID4gPiA+Pj4gSWYgX01RIG5vdCBwcmVzZW50LCBpdCBtZWFu
cyB0aGlzIGRldmljZSBoYXMgb25lIFZRIHBhaXIuCj4gPiA+ID4+IGl0IGlzIHN0aWxsIGEgZ3Vl
c3MsIHJpZ2h0PyBBbmQgYWxsIHVzZXIgc3BhY2UgdG9vbHMgaW1wbGVtZW50ZWQgdGhpcwo+ID4g
PiA+PiBmZWF0dXJlIG5lZWQgdG8gZ3Vlc3MKPiA+ID4gPiBOby4gaXQgaXMgbm90IGEgZ3Vlc3Mu
Cj4gPiA+ID4gSXQgaXMgZXhwbGljaXRseSBjaGVja2luZyB0aGUgX01RIGZlYXR1cmUgYW5kIGRl
cml2aW5nIHRoZSB2YWx1ZS4KPiA+ID4gPiBUaGUgY29kZSB5b3UgcHJvcG9zZWQgd2lsbCBiZSBw
cmVzZW50IGluIHRoZSB1c2VyIHNwYWNlLgo+ID4gPiA+IEl0IHdpbGwgYmUgdW5pZm9ybSBmb3Ig
X01RIGFuZCAxMCBvdGhlciBmZWF0dXJlcyB0aGF0IGFyZSBwcmVzZW50IG5vdyBhbmQKPiA+ID4g
aW4gdGhlIGZ1dHVyZS4KPiA+ID4gTVEgYW5kIG90aGVyIGZlYXR1cmVzIGxpa2UgUlNTIGFyZSBk
aWZmZXJlbnQuIElmIHRoZXJlIGlzIG5vIF9SU1NfWFgsIHRoZXJlCj4gPiA+IGFyZSBubyBhdHRy
aWJ1dGVzIGxpa2UgbWF4X3Jzc19rZXlfc2l6ZSwgYW5kIHRoZXJlIGlzIG5vdCBhIGRlZmF1bHQg
dmFsdWUuCj4gPiA+IEJ1dCBmb3IgTVEsIHdlIGtub3cgaXQgaGFzIHRvIGJlIDEgd2lodG91dCBf
TVEuCj4gPiAid2UiID0gdXNlciBzcGFjZS4KPiA+IFRvIGtlZXAgdGhlIGNvbnNpc3RlbmN5IGFt
b25nIGFsbCB0aGUgY29uZmlnIHNwYWNlIGZpZWxkcy4KPgo+IEFjdHVhbGx5IEkgbG9va2VkIGFu
ZCB0aGUgY29kZSBzb21lIG1vcmUgYW5kIEknbSBwdXp6bGVkOgo+Cj4KPiAgICAgICAgIHN0cnVj
dCB2aXJ0aW9fbmV0X2NvbmZpZyBjb25maWcgPSB7fTsKPiAgICAgICAgIHU2NCBmZWF0dXJlczsK
PiAgICAgICAgIHUxNiB2YWxfdTE2Owo+Cj4gICAgICAgICB2ZHBhX2dldF9jb25maWdfdW5sb2Nr
ZWQodmRldiwgMCwgJmNvbmZpZywgc2l6ZW9mKGNvbmZpZykpOwo+Cj4gICAgICAgICBpZiAobmxh
X3B1dChtc2csIFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQUNBRERSLCBzaXplb2YoY29uZmlnLm1h
YyksCj4gICAgICAgICAgICAgICAgICAgICBjb25maWcubWFjKSkKPiAgICAgICAgICAgICAgICAg
cmV0dXJuIC1FTVNHU0laRTsKPgo+Cj4gTWFjIHJldHVybmVkIGV2ZW4gd2l0aG91dCBWSVJUSU9f
TkVUX0ZfTUFDCj4KPgo+ICAgICAgICAgdmFsX3UxNiA9IGxlMTZfdG9fY3B1KGNvbmZpZy5zdGF0
dXMpOwo+ICAgICAgICAgaWYgKG5sYV9wdXRfdTE2KG1zZywgVkRQQV9BVFRSX0RFVl9ORVRfU1RB
VFVTLCB2YWxfdTE2KSkKPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTVNHU0laRTsKPgo+Cj4g
c3RhdHVzIHJldHVybmVkIGV2ZW4gd2l0aG91dCBWSVJUSU9fTkVUX0ZfU1RBVFVTCj4KPiAgICAg
ICAgIHZhbF91MTYgPSBsZTE2X3RvX2NwdShjb25maWcubXR1KTsKPiAgICAgICAgIGlmIChubGFf
cHV0X3UxNihtc2csIFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NVFUsIHZhbF91MTYpKQo+ICAgICAg
ICAgICAgICAgICByZXR1cm4gLUVNU0dTSVpFOwo+Cj4KPiBNVFUgcmV0dXJuZWQgZXZlbiB3aXRo
b3V0IFZJUlRJT19ORVRfRl9NVFUKPgo+Cj4gV2hhdCdzIGdvaW5nIG9uIGhlcmU/CgpQcm9iYWJs
eSB0b28gbGF0ZSB0byBmaXgsIGJ1dCB0aGlzIHNob3VsZCBiZSBmaW5lIGFzIGxvbmcgYXMgYWxs
CnBhcmVudHMgc3VwcG9ydCBTVEFUVVMvTVRVL01BQy4KCkkgd29uZGVyIGlmIHdlIGNhbiBhZGQg
YSBjaGVjayBpbiB0aGUgY29yZSBhbmQgZmFpbCB0aGUgZGV2aWNlCnJlZ2lzdHJhdGlvbiBpbiB0
aGlzIGNhc2UuCgpUaGFua3MKCj4KPgo+IC0tCj4gTVNUCj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
