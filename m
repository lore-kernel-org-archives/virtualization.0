Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF6BC00144
	for <virtualization@archiver.kernel.org>; Mon,  1 Aug 2022 04:51:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A163960A47;
	Mon,  1 Aug 2022 04:51:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A163960A47
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TTMFXMeM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VQzgDH92u0Md; Mon,  1 Aug 2022 04:51:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C8FE4607E1;
	Mon,  1 Aug 2022 04:51:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8FE4607E1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAFF8C0032;
	Mon,  1 Aug 2022 04:51:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB1D3C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 04:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5C7140192
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 04:51:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B5C7140192
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TTMFXMeM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xU-fktUlGgX0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 04:51:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD6734017C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD6734017C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 04:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659329462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Ryt5J3yzqqdOrexOVDqNu+Le5htlDEXM2+NHWY7KGo=;
 b=TTMFXMeM9+elIDQ13UDEA6IFiVyRA007wCDlff46c6xIQTdjBkCCnKee+jgCXnNBeC/t7c
 SqXN4TmpH0wPRyodsSj8FNQPuV5mMXakDfJs8/bZ2u5qZDkRPMzNEMAfIMtuYhMRlH0T48
 RMJ7kaGPQvxKZnie+91twNxYQLlinto=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-_Ggiwzj9Px2p5QqA9nojsg-1; Mon, 01 Aug 2022 00:50:55 -0400
X-MC-Unique: _Ggiwzj9Px2p5QqA9nojsg-1
Received: by mail-ej1-f69.google.com with SMTP id
 sb15-20020a1709076d8f00b0072b692d938cso2492727ejc.10
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Jul 2022 21:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4Ryt5J3yzqqdOrexOVDqNu+Le5htlDEXM2+NHWY7KGo=;
 b=c1iFcuZDVBOSnmbJYIiSSqtvePaSZHNH28BTWf6ZPrwV0H6nrCy2L+UGTCktxFLqoV
 5jDNAN7FWEV609DrEsRKUp2S6gS8+HJocYv/LbSrjifM/66oK/FGInUGJgHDwMHJ0Qfk
 j85cq+QLKNCUb0OpqJa39mMnuffi1X2ZQdnj0KbhJCa8g+mPUaf7M5aRi67JboiQunWT
 hOaLCQRaGKW/Y5wRTPlTRBu4Tc1oGnAm6wsOqomW1z++wLuCAK+6Ht7FI6GwLrCtS7uj
 +ShXvqQ8PRGFNbXBtyYj+6G5J9kmFR51Z4sT9vj8fiU4YE/CL2V43sPWmpvDvBTw5f12
 oY6g==
X-Gm-Message-State: AJIora+2dLQXFqKC8sN9Jr//Jk60s58tqCx4mVoVGtun1pUfbeBYTGSV
 Fsin6nWF4Ea+xrX9VHX9UssLQxT1jbKz33tbHokz0ktP2WJbHVNjykxVJhcRoOymNbUAKUmuIeN
 DrOxPqCRpDeoe+6uaxz8TzcgLZpA4s3mDWp+G9+KGu06GPORmzdAoaVkdpQ==
X-Received: by 2002:a17:907:2d23:b0:72b:7c6a:24c with SMTP id
 gs35-20020a1709072d2300b0072b7c6a024cmr10844655ejc.44.1659329454288; 
 Sun, 31 Jul 2022 21:50:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sH+lIhZOpB9lCfREfJb6x/jvL61IYF2r9RdXMJRwFw2D9Yw+ehqNVuBnTCBa3NE3A2B6EQoIiHm09d++CQhbQ=
X-Received: by 2002:a17:907:2d23:b0:72b:7c6a:24c with SMTP id
 gs35-20020a1709072d2300b0072b7c6a024cmr10844644ejc.44.1659329454070; Sun, 31
 Jul 2022 21:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <e98fc062-021b-848b-5cf4-15bd63a11c5c@intel.com>
 <PH0PR12MB54815AD7D0674FEB1D63EB61DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220727015626-mutt-send-email-mst@kernel.org>
 <CACGkMEv62tuOP3ra0GBhjCH=syFWxP+GVfGL_i0Ce0iD4uMY=Q@mail.gmail.com>
 <20220727050222-mutt-send-email-mst@kernel.org>
 <CACGkMEtDFUGX17giwYdF58QJ1ccZJDJg1nFVDkSeB27sfZz28g@mail.gmail.com>
 <20220727114419-mutt-send-email-mst@kernel.org>
 <CACGkMEv80RTtuyw5RtwgTHUphS1s2oTeb94tc6Tx7LbJWKsEBw@mail.gmail.com>
 <459524bc-0e21-422b-31c1-39745fd25fac@intel.com>
 <CACGkMEu76TtzXRkv_daoHCY9gZ0ikbFBHD+gRz8KNMdeKiGArg@mail.gmail.com>
 <20220728024111-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220728024111-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 1 Aug 2022 12:50:42 +0800
Message-ID: <CACGkMEvO4cHE-_0nvT6oe6GmXukcpT=yZGM9SGpVGhjuxnTvTQ@mail.gmail.com>
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

T24gVGh1LCBKdWwgMjgsIDIwMjIgYXQgMjo0MSBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgSnVsIDI4LCAyMDIyIGF0IDAxOjUzOjUxUE0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBUaHUsIEp1bCAyOCwgMjAyMiBhdCAxMTo0
NyBBTSBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPiB3cm90ZToKPiA+ID4K
PiA+ID4KPiA+ID4KPiA+ID4gT24gNy8yOC8yMDIyIDk6MjEgQU0sIEphc29uIFdhbmcgd3JvdGU6
Cj4gPiA+ID4gT24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMTE6NDUgUE0gTWljaGFlbCBTLiBUc2ly
a2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4+IE9uIFdlZCwgSnVsIDI3LCAyMDIy
IGF0IDA1OjUwOjU5UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4+PiBPbiBXZWQs
IEp1bCAyNywgMjAyMiBhdCA1OjAzIFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5j
b20+IHdyb3RlOgo+ID4gPiA+Pj4+IE9uIFdlZCwgSnVsIDI3LCAyMDIyIGF0IDAyOjU0OjEzUE0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4+Pj4+IE9uIFdlZCwgSnVsIDI3LCAyMDIy
IGF0IDI6MDEgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4g
PiA+ID4+Pj4+PiBPbiBXZWQsIEp1bCAyNywgMjAyMiBhdCAwMzo0NzozNUFNICswMDAwLCBQYXJh
diBQYW5kaXQgd3JvdGU6Cj4gPiA+ID4+Pj4+Pj4+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdz
aGFuLnpodUBpbnRlbC5jb20+Cj4gPiA+ID4+Pj4+Pj4+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjYs
IDIwMjIgMTA6NTMgUE0KPiA+ID4gPj4+Pj4+Pj4KPiA+ID4gPj4+Pj4+Pj4gT24gNy8yNy8yMDIy
IDEwOjE3IEFNLCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4gPiA+ID4+Pj4+Pj4+Pj4gRnJvbTogWmh1
LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPiA+ID4gPj4+Pj4+Pj4+PiBTZW50
OiBUdWVzZGF5LCBKdWx5IDI2LCAyMDIyIDEwOjE1IFBNCj4gPiA+ID4+Pj4+Pj4+Pj4KPiA+ID4g
Pj4+Pj4+Pj4+PiBPbiA3LzI2LzIwMjIgMTE6NTYgUE0sIFBhcmF2IFBhbmRpdCB3cm90ZToKPiA+
ID4gPj4+Pj4+Pj4+Pj4+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5j
b20+Cj4gPiA+ID4+Pj4+Pj4+Pj4+PiBTZW50OiBUdWVzZGF5LCBKdWx5IDEyLCAyMDIyIDExOjQ2
IFBNCj4gPiA+ID4+Pj4+Pj4+Pj4+Pj4gV2hlbiB0aGUgdXNlciBzcGFjZSB3aGljaCBpbnZva2Vz
IG5ldGxpbmsgY29tbWFuZHMsIGRldGVjdHMgdGhhdAo+ID4gPiA+Pj4+Pj4+Pj4+IF9NUQo+ID4g
PiA+Pj4+Pj4+Pj4+Pj4gaXMgbm90IHN1cHBvcnRlZCwgaGVuY2UgaXQgdGFrZXMgbWF4X3F1ZXVl
X3BhaXIgPSAxIGJ5IGl0c2VsZi4KPiA+ID4gPj4+Pj4+Pj4+Pj4+IEkgdGhpbmsgdGhlIGtlcm5l
bCBtb2R1bGUgaGF2ZSBhbGwgbmVjZXNzYXJ5IGluZm9ybWF0aW9uIGFuZCBpdCBpcwo+ID4gPiA+
Pj4+Pj4+Pj4+Pj4gdGhlIG9ubHkgb25lIHdoaWNoIGhhdmUgcHJlY2lzZSBpbmZvcm1hdGlvbiBv
ZiBhIGRldmljZSwgc28gaXQKPiA+ID4gPj4+Pj4+Pj4+Pj4+IHNob3VsZCBhbnN3ZXIgcHJlY2lz
ZWx5IHRoYW4gbGV0IHRoZSB1c2VyIHNwYWNlIGd1ZXNzLiBUaGUga2VybmVsCj4gPiA+ID4+Pj4+
Pj4+Pj4+PiBtb2R1bGUgc2hvdWxkIGJlIHJlbGlhYmxlIHRoYW4gc3RheSBzaWxlbnQsIGxlYXZl
IHRoZSBxdWVzdGlvbiB0bwo+ID4gPiA+Pj4+Pj4+Pj4+Pj4gdGhlIHVzZXIgc3BhY2UKPiA+ID4g
Pj4+Pj4+Pj4+PiB0b29sLgo+ID4gPiA+Pj4+Pj4+Pj4+PiBLZXJuZWwgaXMgcmVsaWFibGUuIEl0
IGRvZXNu4oCZdCBleHBvc2UgYSBjb25maWcgc3BhY2UgZmllbGQgaWYgdGhlCj4gPiA+ID4+Pj4+
Pj4+Pj4+IGZpZWxkIGRvZXNu4oCZdAo+ID4gPiA+Pj4+Pj4+Pj4+IGV4aXN0IHJlZ2FyZGxlc3Mg
b2YgZmllbGQgc2hvdWxkIGhhdmUgZGVmYXVsdCBvciBubyBkZWZhdWx0Lgo+ID4gPiA+Pj4+Pj4+
Pj4+IHNvIHdoZW4geW91IGtub3cgaXQgaXMgb25lIHF1ZXVlIHBhaXIsIHlvdSBzaG91bGQgYW5z
d2VyIG9uZSwgbm90IHRyeQo+ID4gPiA+Pj4+Pj4+Pj4+IHRvIGd1ZXNzLgo+ID4gPiA+Pj4+Pj4+
Pj4+PiBVc2VyIHNwYWNlIHNob3VsZCBub3QgZ3Vlc3MgZWl0aGVyLiBVc2VyIHNwYWNlIGdldHMg
dG8gc2VlIGlmIF9NUQo+ID4gPiA+Pj4+Pj4+Pj4+IHByZXNlbnQvbm90IHByZXNlbnQuIElmIF9N
USBwcmVzZW50IHRoYW4gZ2V0IHJlbGlhYmxlIGRhdGEgZnJvbSBrZXJuZWwuCj4gPiA+ID4+Pj4+
Pj4+Pj4+IElmIF9NUSBub3QgcHJlc2VudCwgaXQgbWVhbnMgdGhpcyBkZXZpY2UgaGFzIG9uZSBW
USBwYWlyLgo+ID4gPiA+Pj4+Pj4+Pj4+IGl0IGlzIHN0aWxsIGEgZ3Vlc3MsIHJpZ2h0PyBBbmQg
YWxsIHVzZXIgc3BhY2UgdG9vbHMgaW1wbGVtZW50ZWQgdGhpcwo+ID4gPiA+Pj4+Pj4+Pj4+IGZl
YXR1cmUgbmVlZCB0byBndWVzcwo+ID4gPiA+Pj4+Pj4+Pj4gTm8uIGl0IGlzIG5vdCBhIGd1ZXNz
Lgo+ID4gPiA+Pj4+Pj4+Pj4gSXQgaXMgZXhwbGljaXRseSBjaGVja2luZyB0aGUgX01RIGZlYXR1
cmUgYW5kIGRlcml2aW5nIHRoZSB2YWx1ZS4KPiA+ID4gPj4+Pj4+Pj4+IFRoZSBjb2RlIHlvdSBw
cm9wb3NlZCB3aWxsIGJlIHByZXNlbnQgaW4gdGhlIHVzZXIgc3BhY2UuCj4gPiA+ID4+Pj4+Pj4+
PiBJdCB3aWxsIGJlIHVuaWZvcm0gZm9yIF9NUSBhbmQgMTAgb3RoZXIgZmVhdHVyZXMgdGhhdCBh
cmUgcHJlc2VudCBub3cgYW5kCj4gPiA+ID4+Pj4+Pj4+IGluIHRoZSBmdXR1cmUuCj4gPiA+ID4+
Pj4+Pj4+IE1RIGFuZCBvdGhlciBmZWF0dXJlcyBsaWtlIFJTUyBhcmUgZGlmZmVyZW50LiBJZiB0
aGVyZSBpcyBubyBfUlNTX1hYLCB0aGVyZQo+ID4gPiA+Pj4+Pj4+PiBhcmUgbm8gYXR0cmlidXRl
cyBsaWtlIG1heF9yc3Nfa2V5X3NpemUsIGFuZCB0aGVyZSBpcyBub3QgYSBkZWZhdWx0IHZhbHVl
Lgo+ID4gPiA+Pj4+Pj4+PiBCdXQgZm9yIE1RLCB3ZSBrbm93IGl0IGhhcyB0byBiZSAxIHdpaHRv
dXQgX01RLgo+ID4gPiA+Pj4+Pj4+ICJ3ZSIgPSB1c2VyIHNwYWNlLgo+ID4gPiA+Pj4+Pj4+IFRv
IGtlZXAgdGhlIGNvbnNpc3RlbmN5IGFtb25nIGFsbCB0aGUgY29uZmlnIHNwYWNlIGZpZWxkcy4K
PiA+ID4gPj4+Pj4+IEFjdHVhbGx5IEkgbG9va2VkIGFuZCB0aGUgY29kZSBzb21lIG1vcmUgYW5k
IEknbSBwdXp6bGVkOgo+ID4gPiA+Pj4+Pj4KPiA+ID4gPj4+Pj4+Cj4gPiA+ID4+Pj4+PiAgICAg
ICAgICBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcgY29uZmlnID0ge307Cj4gPiA+ID4+Pj4+PiAg
ICAgICAgICB1NjQgZmVhdHVyZXM7Cj4gPiA+ID4+Pj4+PiAgICAgICAgICB1MTYgdmFsX3UxNjsK
PiA+ID4gPj4+Pj4+Cj4gPiA+ID4+Pj4+PiAgICAgICAgICB2ZHBhX2dldF9jb25maWdfdW5sb2Nr
ZWQodmRldiwgMCwgJmNvbmZpZywgc2l6ZW9mKGNvbmZpZykpOwo+ID4gPiA+Pj4+Pj4KPiA+ID4g
Pj4+Pj4+ICAgICAgICAgIGlmIChubGFfcHV0KG1zZywgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01B
Q0FERFIsIHNpemVvZihjb25maWcubWFjKSwKPiA+ID4gPj4+Pj4+ICAgICAgICAgICAgICAgICAg
ICAgIGNvbmZpZy5tYWMpKQo+ID4gPiA+Pj4+Pj4gICAgICAgICAgICAgICAgICByZXR1cm4gLUVN
U0dTSVpFOwo+ID4gPiA+Pj4+Pj4KPiA+ID4gPj4+Pj4+Cj4gPiA+ID4+Pj4+PiBNYWMgcmV0dXJu
ZWQgZXZlbiB3aXRob3V0IFZJUlRJT19ORVRfRl9NQUMKPiA+ID4gPj4+Pj4+Cj4gPiA+ID4+Pj4+
Pgo+ID4gPiA+Pj4+Pj4gICAgICAgICAgdmFsX3UxNiA9IGxlMTZfdG9fY3B1KGNvbmZpZy5zdGF0
dXMpOwo+ID4gPiA+Pj4+Pj4gICAgICAgICAgaWYgKG5sYV9wdXRfdTE2KG1zZywgVkRQQV9BVFRS
X0RFVl9ORVRfU1RBVFVTLCB2YWxfdTE2KSkKPiA+ID4gPj4+Pj4+ICAgICAgICAgICAgICAgICAg
cmV0dXJuIC1FTVNHU0laRTsKPiA+ID4gPj4+Pj4+Cj4gPiA+ID4+Pj4+Pgo+ID4gPiA+Pj4+Pj4g
c3RhdHVzIHJldHVybmVkIGV2ZW4gd2l0aG91dCBWSVJUSU9fTkVUX0ZfU1RBVFVTCj4gPiA+ID4+
Pj4+Pgo+ID4gPiA+Pj4+Pj4gICAgICAgICAgdmFsX3UxNiA9IGxlMTZfdG9fY3B1KGNvbmZpZy5t
dHUpOwo+ID4gPiA+Pj4+Pj4gICAgICAgICAgaWYgKG5sYV9wdXRfdTE2KG1zZywgVkRQQV9BVFRS
X0RFVl9ORVRfQ0ZHX01UVSwgdmFsX3UxNikpCj4gPiA+ID4+Pj4+PiAgICAgICAgICAgICAgICAg
IHJldHVybiAtRU1TR1NJWkU7Cj4gPiA+ID4+Pj4+Pgo+ID4gPiA+Pj4+Pj4KPiA+ID4gPj4+Pj4+
IE1UVSByZXR1cm5lZCBldmVuIHdpdGhvdXQgVklSVElPX05FVF9GX01UVQo+ID4gPiA+Pj4+Pj4K
PiA+ID4gPj4+Pj4+Cj4gPiA+ID4+Pj4+PiBXaGF0J3MgZ29pbmcgb24gaGVyZT8KPiA+ID4gPj4+
Pj4gUHJvYmFibHkgdG9vIGxhdGUgdG8gZml4LCBidXQgdGhpcyBzaG91bGQgYmUgZmluZSBhcyBs
b25nIGFzIGFsbAo+ID4gPiA+Pj4+PiBwYXJlbnRzIHN1cHBvcnQgU1RBVFVTL01UVS9NQUMuCj4g
PiA+ID4+Pj4gV2h5IGlzIHRoaXMgdG9vIGxhdGUgdG8gZml4Lgo+ID4gPiA+Pj4gSWYgd2UgbWFr
ZSB0aGlzIGNvbmRpdGlvbmFsIG9uIHRoZSBmZWF0dXJlcy4gVGhpcyBtYXkgYnJlYWsgdGhlCj4g
PiA+ID4+PiB1c2Vyc3BhY2UgdGhhdCBhbHdheXMgZXhwZWN0cyBWRFBBX0FUVFJfREVWX05FVF9D
RkdfTVRVPwo+ID4gPiA+Pj4KPiA+ID4gPj4+IFRoYW5rcwo+ID4gPiA+PiBXZWxsIG9ubHkgb24g
ZGV2aWNlcyB3aXRob3V0IE1UVS4gSSdtIHNheWluZyBzYWlkIHVzZXJzcGFjZQo+ID4gPiA+PiB3
YXMgcmVhZGluZyB0cmFzaCBvbiBzdWNoIGRldmljZXMgYW55d2F5Lgo+ID4gPiA+IEl0IGRlcGVu
ZHMgb24gdGhlIHBhcmVudCBhY3R1YWxseS4gRm9yIGV4YW1wbGUsIG1seDUgcXVlcnkgdGhlIGxv
d2VyCj4gPiA+ID4gbXR1IHVuY29uZGl0aW9uYWxseToKPiA+ID4gPgo+ID4gPiA+ICAgICAgICAg
IGVyciA9IHF1ZXJ5X210dShtZGV2LCAmbXR1KTsKPiA+ID4gPiAgICAgICAgICBpZiAoZXJyKQo+
ID4gPiA+ICAgICAgICAgICAgICAgICAgZ290byBlcnJfYWxsb2M7Cj4gPiA+ID4KPiA+ID4gPiAg
ICAgICAgICBuZGV2LT5jb25maWcubXR1ID0gY3B1X3RvX21seDV2ZHBhMTYobXZkZXYsIG10dSk7
Cj4gPiA+ID4KPiA+ID4gPiBTdXBwb3J0aW5nIE1UVSBmZWF0dXJlcyBzZWVtcyB0byBiZSBhIG11
c3QgZm9yIHJlYWwgaGFyZHdhcmUuCj4gPiA+ID4gT3RoZXJ3aXNlIHRoZSBkcml2ZXIgbWF5IG5v
dCB3b3JrIGNvcnJlY3RseS4KPiA+ID4gPgo+ID4gPiA+PiBXZSBkb24ndCBnZW5lcmFsbHkgbWFp
bnRhaW4gYnVnIGZvciBidWcgY29tcGF0aWJsaXR5IG9uIGEgd2hpbSwKPiA+ID4gPj4gb25seSBp
ZiB1c2Vyc3BhY2UgaXMgYWN0dWFsbHkga25vd24gdG8gYnJlYWsgaWYgd2UgZml4IGEgYnVnLgo+
ID4gPiA+ICAgU28gSSB0aGluayBpdCBzaG91bGQgYmUgZmluZSB0byBtYWtlIHRoaXMgY29uZGl0
aW9uYWwgdGhlbiB3ZSBzaG91bGQKPiA+ID4gPiBoYXZlIGEgY29uc2lzdGVudCBoYW5kbGluZyBv
ZiBvdGhlciBmaWVsZHMgbGlrZSBNUS4KPiA+ID4gRm9yIHNvbWUgZmllbGRzIHRoYXQgaGF2ZSBh
IGRlZmF1bHQgdmFsdWUsIGxpa2UgTVEgPTEsIHdlIGNhbiByZXR1cm4gdGhlCj4gPiA+IGRlZmF1
bHQgdmFsdWUuCj4gPiA+IEZvciBvdGhlciBmaWVsZHMgd2l0aG91dCBhIGRlZmF1bHQgdmFsdWUs
IGxpa2UgTUFDLCB3ZSByZXR1cm4gbm90aGluZy4KPiA+ID4KPiA+ID4gRG9lcyB0aGlzIHNvdW5k
cyBnb29kPyBTbywgZm9yIE1UVSwgaWYgd2l0aG91dCBfRl9NVFUsIEkgdGhpbmsgd2UgY2FuCj4g
PiA+IHJldHVybiAxNTAwIGJ5IGRlZmF1bHQuCj4gPgo+ID4gT3Igd2UgY2FuIGp1c3QgcmVhZCBN
VFUgZnJvbSB0aGUgZGV2aWNlLgo+ID4KPiA+IEJ1dCBJdCBsb29rcyB0byBtZSBNaWNoYWVsIHdh
bnRzIGl0IGNvbmRpdGlvbmFsLgo+ID4KPiA+IFRoYW5rcwo+Cj4gSSdtIGZpbmUgZWl0aGVyIHdh
eSBidXQgbGV0J3Mga2VlcCBpdCBjb25zaXN0ZW50LiBBbmQgSSB0aGluawo+IFBhcmF2IHdhbnRz
IGl0IGNvbmRpdGlvbmFsLgoKUGFyYXYsIHdoYXQncyB5b3VyIG9waW5pb24gaGVyZT8KCk1pY2hh
bGUgc3BvdHMgc29tZSBpbi1jb25zaXN0ZW50IHN0dWZmcywgc28gSSB0aGluayB3ZSBzaG91bGQg
ZWl0aGVyCgoxKSBtYWtlIGFsbCBjb25kaXRpb25hbCwgc28gd2Ugc2hvdWxkIGNoYW5nZSBib3Ro
IE1UVSBhbmQgTUFDCgpvcgoKMikgbWFrZSB0aGVtIHVuY29uZGl0aW9uYWwsIHNvIHdlIHNob3Vs
ZCBvbmx5IGNoYW5nZSBNUQoKVGhhbmtzCgo+Cj4gPiA+Cj4gPiA+IFRoYW5rcywKPiA+ID4gWmh1
IExpbmdzaGFuCj4gPiA+ID4KPiA+ID4gPiBUaGFua3MKPiA+ID4gPgo+ID4gPiA+Pgo+ID4gPiA+
Pj4+PiBJIHdvbmRlciBpZiB3ZSBjYW4gYWRkIGEgY2hlY2sgaW4gdGhlIGNvcmUgYW5kIGZhaWwg
dGhlIGRldmljZQo+ID4gPiA+Pj4+PiByZWdpc3RyYXRpb24gaW4gdGhpcyBjYXNlLgo+ID4gPiA+
Pj4+Pgo+ID4gPiA+Pj4+PiBUaGFua3MKPiA+ID4gPj4+Pj4KPiA+ID4gPj4+Pj4+Cj4gPiA+ID4+
Pj4+PiAtLQo+ID4gPiA+Pj4+Pj4gTVNUCj4gPiA+ID4+Pj4+Pgo+ID4gPgo+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
