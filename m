Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A283C04A68
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 09:05:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BF44B4047C;
	Wed, 27 Jul 2022 09:05:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF44B4047C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IxraX1Ub
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ghLoyuSIV9s8; Wed, 27 Jul 2022 09:05:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 367B040151;
	Wed, 27 Jul 2022 09:05:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 367B040151
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BE6FC0033;
	Wed, 27 Jul 2022 09:05:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 508F8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:05:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2AA9A60B19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:05:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2AA9A60B19
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IxraX1Ub
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uwonH_09UL1l
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:05:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E6F160B0B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3E6F160B0B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658912745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/VD2gv6Dn4KXXGjihjcL4YQf94dggu8ChImRGCTJ+EA=;
 b=IxraX1UbDNUwN5MpE/Bh69KLtYlfFzima2/MC/rGIjV2MXFThCZEM2mJBT/xPZ05jOEHCK
 +5MSQSRCKeC2czANByhYkx07YHLBYM6wDA8k1xzL+Qd+Q2+B4dr8Qjxd09G1JgXYiZ3ifm
 Jr7ZShrN0sQKVZ1yE42kNpSvdq3FWdI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-djpt0o5cNTm5jDvg6DASHw-1; Wed, 27 Jul 2022 05:05:44 -0400
X-MC-Unique: djpt0o5cNTm5jDvg6DASHw-1
Received: by mail-wm1-f69.google.com with SMTP id
 130-20020a1c0288000000b003a3497306a8so872807wmc.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 02:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=/VD2gv6Dn4KXXGjihjcL4YQf94dggu8ChImRGCTJ+EA=;
 b=hVn/5r4X3PLqA2HRbj+4pWSDnPCwNYrmH/3Y35H3CGi3ZutubXh2/YYVf5poQaVhK4
 ibM5BEpSSJVqHJm3faFUJZx5hfsMfJgUk9ArJAp12JRm/chBOJcGFYOUXOrLKR9VQLj9
 EQKZrS3Tk5rRESSaeuDCl6hgbxbNNUq92HOc7VTG5iuNsuuIq+GbGYdM53TYVzxrQbtS
 CFPNZ6qh3gwsD/yRf62q70gi5gVm6FXj30VrQ+Rz7RTDpdqPXgkGOKNzyKA/XaQzBXNM
 yGWER9cnqyXHCjBYRr9/gWTVyKL56RBBnnw1i3MyaRt0asKvk8WixWsb1Fn6lBANdV3+
 stAw==
X-Gm-Message-State: AJIora/p7YOukWGLWKMBUWVxvZmDTw2vzueg4seP5gLeD4icSsKb/r+i
 YDe7DqFBgsgFMjf2E3zw2yt05woNO/smR+1WNywV/CTbBloy+yzQo45FkqpL3l5IQXXiDWUGMbE
 uf339OK6E5OCX5o1cM+qf35xC6n+QAng3f3k1UdCanQ==
X-Received: by 2002:a05:6000:144d:b0:21d:8109:701d with SMTP id
 v13-20020a056000144d00b0021d8109701dmr12896131wrx.443.1658912743285; 
 Wed, 27 Jul 2022 02:05:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vFKCXGo7+tmPkeoN5oTHI8IVd+EWSmGixxPDJeK0M/yGU8GSgKKeLGqKrvSu3ZcnK2nIFrYA==
X-Received: by 2002:a05:6000:144d:b0:21d:8109:701d with SMTP id
 v13-20020a056000144d00b0021d8109701dmr12896092wrx.443.1658912742634; 
 Wed, 27 Jul 2022 02:05:42 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7424:0:3d16:86dc:de54:5671])
 by smtp.gmail.com with ESMTPSA id
 b12-20020a5d550c000000b0021e4fd8e10bsm9990696wrv.11.2022.07.27.02.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jul 2022 02:05:42 -0700 (PDT)
Date: Wed, 27 Jul 2022 05:05:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Message-ID: <20220727050342-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481E65037E0B4F6F583193BDC899@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1246d2f1-2822-0edb-cd57-efc4015f05a2@intel.com>
 <PH0PR12MB54815985C202E81122459DFFDC949@PH0PR12MB5481.namprd12.prod.outlook.com>
 <19681358-fc81-be5b-c20b-7394a549f0be@intel.com>
 <PH0PR12MB54818158D4F7F9F556022857DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e98fc062-021b-848b-5cf4-15bd63a11c5c@intel.com>
 <PH0PR12MB54815AD7D0674FEB1D63EB61DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220727015626-mutt-send-email-mst@kernel.org>
 <4925d1db-51d1-148a-72e0-2347b20e82f4@intel.com>
 <CACGkMEsXLhhLhyfPwc=Sif=iy1wE3zm6sKWQxvO3cyuM547+zw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsXLhhLhyfPwc=Sif=iy1wE3zm6sKWQxvO3cyuM547+zw@mail.gmail.com>
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

T24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMDI6NTY6MjBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBXZWQsIEp1bCAyNywgMjAyMiBhdCAyOjI2IFBNIFpodSwgTGluZ3NoYW4gPGxpbmdz
aGFuLnpodUBpbnRlbC5jb20+IHdyb3RlOgo+ID4KPiA+Cj4gPgo+ID4gT24gNy8yNy8yMDIyIDI6
MDEgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gT24gV2VkLCBKdWwgMjcsIDIw
MjIgYXQgMDM6NDc6MzVBTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+ID4gPj4+IEZyb206
IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4gPiA+Pj4gU2VudDogVHVl
c2RheSwgSnVseSAyNiwgMjAyMiAxMDo1MyBQTQo+ID4gPj4+Cj4gPiA+Pj4gT24gNy8yNy8yMDIy
IDEwOjE3IEFNLCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4gPiA+Pj4+PiBGcm9tOiBaaHUsIExpbmdz
aGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+ID4gPj4+Pj4gU2VudDogVHVlc2RheSwgSnVs
eSAyNiwgMjAyMiAxMDoxNSBQTQo+ID4gPj4+Pj4KPiA+ID4+Pj4+IE9uIDcvMjYvMjAyMiAxMTo1
NiBQTSwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+ID4gPj4+Pj4+PiBGcm9tOiBaaHUsIExpbmdzaGFu
IDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+ID4gPj4+Pj4+PiBTZW50OiBUdWVzZGF5LCBKdWx5
IDEyLCAyMDIyIDExOjQ2IFBNCj4gPiA+Pj4+Pj4+PiBXaGVuIHRoZSB1c2VyIHNwYWNlIHdoaWNo
IGludm9rZXMgbmV0bGluayBjb21tYW5kcywgZGV0ZWN0cyB0aGF0Cj4gPiA+Pj4+PiBfTVEKPiA+
ID4+Pj4+Pj4gaXMgbm90IHN1cHBvcnRlZCwgaGVuY2UgaXQgdGFrZXMgbWF4X3F1ZXVlX3BhaXIg
PSAxIGJ5IGl0c2VsZi4KPiA+ID4+Pj4+Pj4gSSB0aGluayB0aGUga2VybmVsIG1vZHVsZSBoYXZl
IGFsbCBuZWNlc3NhcnkgaW5mb3JtYXRpb24gYW5kIGl0IGlzCj4gPiA+Pj4+Pj4+IHRoZSBvbmx5
IG9uZSB3aGljaCBoYXZlIHByZWNpc2UgaW5mb3JtYXRpb24gb2YgYSBkZXZpY2UsIHNvIGl0Cj4g
PiA+Pj4+Pj4+IHNob3VsZCBhbnN3ZXIgcHJlY2lzZWx5IHRoYW4gbGV0IHRoZSB1c2VyIHNwYWNl
IGd1ZXNzLiBUaGUga2VybmVsCj4gPiA+Pj4+Pj4+IG1vZHVsZSBzaG91bGQgYmUgcmVsaWFibGUg
dGhhbiBzdGF5IHNpbGVudCwgbGVhdmUgdGhlIHF1ZXN0aW9uIHRvCj4gPiA+Pj4+Pj4+IHRoZSB1
c2VyIHNwYWNlCj4gPiA+Pj4+PiB0b29sLgo+ID4gPj4+Pj4+IEtlcm5lbCBpcyByZWxpYWJsZS4g
SXQgZG9lc27igJl0IGV4cG9zZSBhIGNvbmZpZyBzcGFjZSBmaWVsZCBpZiB0aGUKPiA+ID4+Pj4+
PiBmaWVsZCBkb2VzbuKAmXQKPiA+ID4+Pj4+IGV4aXN0IHJlZ2FyZGxlc3Mgb2YgZmllbGQgc2hv
dWxkIGhhdmUgZGVmYXVsdCBvciBubyBkZWZhdWx0Lgo+ID4gPj4+Pj4gc28gd2hlbiB5b3Uga25v
dyBpdCBpcyBvbmUgcXVldWUgcGFpciwgeW91IHNob3VsZCBhbnN3ZXIgb25lLCBub3QgdHJ5Cj4g
PiA+Pj4+PiB0byBndWVzcy4KPiA+ID4+Pj4+PiBVc2VyIHNwYWNlIHNob3VsZCBub3QgZ3Vlc3Mg
ZWl0aGVyLiBVc2VyIHNwYWNlIGdldHMgdG8gc2VlIGlmIF9NUQo+ID4gPj4+Pj4gcHJlc2VudC9u
b3QgcHJlc2VudC4gSWYgX01RIHByZXNlbnQgdGhhbiBnZXQgcmVsaWFibGUgZGF0YSBmcm9tIGtl
cm5lbC4KPiA+ID4+Pj4+PiBJZiBfTVEgbm90IHByZXNlbnQsIGl0IG1lYW5zIHRoaXMgZGV2aWNl
IGhhcyBvbmUgVlEgcGFpci4KPiA+ID4+Pj4+IGl0IGlzIHN0aWxsIGEgZ3Vlc3MsIHJpZ2h0PyBB
bmQgYWxsIHVzZXIgc3BhY2UgdG9vbHMgaW1wbGVtZW50ZWQgdGhpcwo+ID4gPj4+Pj4gZmVhdHVy
ZSBuZWVkIHRvIGd1ZXNzCj4gPiA+Pj4+IE5vLiBpdCBpcyBub3QgYSBndWVzcy4KPiA+ID4+Pj4g
SXQgaXMgZXhwbGljaXRseSBjaGVja2luZyB0aGUgX01RIGZlYXR1cmUgYW5kIGRlcml2aW5nIHRo
ZSB2YWx1ZS4KPiA+ID4+Pj4gVGhlIGNvZGUgeW91IHByb3Bvc2VkIHdpbGwgYmUgcHJlc2VudCBp
biB0aGUgdXNlciBzcGFjZS4KPiA+ID4+Pj4gSXQgd2lsbCBiZSB1bmlmb3JtIGZvciBfTVEgYW5k
IDEwIG90aGVyIGZlYXR1cmVzIHRoYXQgYXJlIHByZXNlbnQgbm93IGFuZAo+ID4gPj4+IGluIHRo
ZSBmdXR1cmUuCj4gPiA+Pj4gTVEgYW5kIG90aGVyIGZlYXR1cmVzIGxpa2UgUlNTIGFyZSBkaWZm
ZXJlbnQuIElmIHRoZXJlIGlzIG5vIF9SU1NfWFgsIHRoZXJlCj4gPiA+Pj4gYXJlIG5vIGF0dHJp
YnV0ZXMgbGlrZSBtYXhfcnNzX2tleV9zaXplLCBhbmQgdGhlcmUgaXMgbm90IGEgZGVmYXVsdCB2
YWx1ZS4KPiA+ID4+PiBCdXQgZm9yIE1RLCB3ZSBrbm93IGl0IGhhcyB0byBiZSAxIHdpaHRvdXQg
X01RLgo+ID4gPj4gIndlIiA9IHVzZXIgc3BhY2UuCj4gPiA+PiBUbyBrZWVwIHRoZSBjb25zaXN0
ZW5jeSBhbW9uZyBhbGwgdGhlIGNvbmZpZyBzcGFjZSBmaWVsZHMuCj4gPiA+IEFjdHVhbGx5IEkg
bG9va2VkIGFuZCB0aGUgY29kZSBzb21lIG1vcmUgYW5kIEknbSBwdXp6bGVkOgo+ID4gSSBjYW4g
c3VibWl0IGEgZml4IGluIG15IG5leHQgdmVyc2lvbiBwYXRjaCBmb3IgdGhlc2UgaXNzdWUuCj4g
PiA+Cj4gPiA+Cj4gPiA+ICAgICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyBjb25maWcgPSB7
fTsKPiA+ID4gICAgICAgdTY0IGZlYXR1cmVzOwo+ID4gPiAgICAgICB1MTYgdmFsX3UxNjsKPiA+
ID4KPiA+ID4gICAgICAgdmRwYV9nZXRfY29uZmlnX3VubG9ja2VkKHZkZXYsIDAsICZjb25maWcs
IHNpemVvZihjb25maWcpKTsKPiA+ID4KPiA+ID4gICAgICAgaWYgKG5sYV9wdXQobXNnLCBWRFBB
X0FUVFJfREVWX05FVF9DRkdfTUFDQUREUiwgc2l6ZW9mKGNvbmZpZy5tYWMpLAo+ID4gPiAgICAg
ICAgICAgICAgICAgICBjb25maWcubWFjKSkKPiA+ID4gICAgICAgICAgICAgICByZXR1cm4gLUVN
U0dTSVpFOwo+ID4gPgo+ID4gPgo+ID4gPiBNYWMgcmV0dXJuZWQgZXZlbiB3aXRob3V0IFZJUlRJ
T19ORVRfRl9NQUMKPiA+IGlmIG5vIFZJUlRJT19ORVRfRl9NQUMsIHdlIHNob3VsZCBub3Qgbmxh
X3B1dAo+ID4gVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ19BRERSLCB0aGUgc3BlYyBzYXlzIHRo
ZSBkcml2ZXIgc2hvdWxkIGdlbmVyYXRlCj4gPiBhIHJhbmRvbSBtYWMuCj4gCj4gSXQncyBwcm9i
YWJseSB0b28gbGF0ZSB0byBkbyB0aGlzLgoKTm90IHN1cmUgd2h5LgoKPiBNb3N0IG9mIHRoZSBw
YXJlbnRzIGhhdmUgdGhpcwo+IGZlYXR1cmUgc3VwcG9ydCwgc28gcHJvYmFibHkgbm90IGEgcmVh
bCBpc3N1ZS4KCkkgZ3Vlc3Mgbm90IHJlcG9ydGluZyBNVFUgaXMgbm90IHdvcnNlIHRoYW4gZmFp
bGluZyBpbml0aWFsaXphdGlvbi4KCj4gPiA+Cj4gPiA+Cj4gPiA+ICAgICAgIHZhbF91MTYgPSBs
ZTE2X3RvX2NwdShjb25maWcuc3RhdHVzKTsKPiA+ID4gICAgICAgaWYgKG5sYV9wdXRfdTE2KG1z
ZywgVkRQQV9BVFRSX0RFVl9ORVRfU1RBVFVTLCB2YWxfdTE2KSkKPiA+ID4gICAgICAgICAgICAg
ICByZXR1cm4gLUVNU0dTSVpFOwo+ID4gPgo+ID4gPgo+ID4gPiBzdGF0dXMgcmV0dXJuZWQgZXZl
biB3aXRob3V0IFZJUlRJT19ORVRfRl9TVEFUVVMKPiA+IGlmIG5vIFZJUlRJT19ORVRfRl9TVEFU
VVMsIHdlIHNob3VsZCBub3QgbmxhX3B1dAo+ID4gVkRQQV9BVFRSX0RFVl9ORVRfU1RBVFVTLCB0
aGUgc3BlYyBzYXlzIHRoZSBkcml2ZXIgc2hvdWxkIGFzc3VtZSB0aGUKPiA+IGxpbmsgaXMgYWN0
aXZlLgo+IAo+IFNvbWVob3cgc2ltaWxhciB0byBGX01BQy4gQnV0IHdlIGNhbiByZXBvcnQgaWYg
Rl9NQUMgaXMgbm90IG5lZ290aWF0ZWQuCj4gCj4gCj4gPiA+Cj4gPiA+ICAgICAgIHZhbF91MTYg
PSBsZTE2X3RvX2NwdShjb25maWcubXR1KTsKPiA+ID4gICAgICAgaWYgKG5sYV9wdXRfdTE2KG1z
ZywgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01UVSwgdmFsX3UxNikpCj4gPiA+ICAgICAgICAgICAg
ICAgcmV0dXJuIC1FTVNHU0laRTsKPiA+ID4KPiA+ID4KPiA+ID4gTVRVIHJldHVybmVkIGV2ZW4g
d2l0aG91dCBWSVJUSU9fTkVUX0ZfTVRVCj4gPiBzYW1lIGFzIGFib3ZlLCB0aGUgc3BlYyBzYXlz
IGNvbmZpZy5tdHUgZGVwZW5kcyBvbiBWSVJUSU9fTkVUX0ZfTVRVLCBzbwo+ID4gd2l0aG91dCB0
aGlzIGZlYXR1cmUgYml0LCB3ZSBzaG91bGQgbm90IHJldHVybiBNVFUgdG8gdGhlIHVzZXJzcGFj
ZS4KPiAKPiBOb3QgYSBiaWcgaXNzdWUsIHdlIGp1c3QgbmVlZCB0byBtYWtlIHN1cmUgdGhlIHBh
cmVudCBjYW4gcmVwb3J0IGEKPiBjb3JyZWN0IE1UVSBoZXJlLgo+IAo+IFRoYW5rcwo+IAo+ID4K
PiA+IERvZXMgdGhlc2UgZml4IGxvb2sgZ29vZCB0byB5b3U/Cj4gPgo+ID4gQW5kIEkgdGhpbmsg
d2UgbWF5IG5lZWQgeW91ciBhZGp1ZGljYXRpb24gZm9yIHRoZSB0d28gaXNzdWVzOgo+ID4gKDEp
IFNoYWxsIHdlIGFuc3dlciBtYXhfdnFfcGFyaXMgPSAxIHdoZW4gX01RIG5vdCBleGlzdCwgSSBr
bm93IHlvdSBoYXZlCj4gPiBhZ3JlZWQgb24gdGhpcyBpbiBhIHByZXZpb3VzIHRocmVhZCwgaXRz
IG5pY2UgdG8gY2xhcmlmeQo+ID4gKDIpIEkgdGhpbmsgd2Ugc2hvdWxkIG5vdCByZS11c2UgdGhl
IG5ldGxpbmsgYXR0ciB0byByZXBvcnQgZmVhdHVyZSBiaXRzCj4gPiBvZiBib3RoIHRoZSBtYW5h
Z2VtZW50IGRldmljZSBhbmQgdGhlIHZEUEEgZGV2aWNlLAo+ID4gdGhpcyBjYW4gbGVhZCB0byBh
IG5ldyByYWNlIGNvbmRpdGlvbiwgdGhlcmUgYXJlIG5vIGxvY2tzKGVzcGVjaWFsbHkKPiA+IGRp
c3RyaWJ1dGVkIGxvY2tzIGZvciBrZXJuZWxfc3BhY2UgYW5kIHVzZXJfc3BhY2UpIGluIHRoZSBu
bGFfcHV0Cj4gPiBmdW5jdGlvbnMuIFJlLXVzaW5nIHRoZSBhdHRyIGlzIHNvbWUga2luZCBvZiBi
cmVha2luZyB0aGUgbmV0bGluawo+ID4gbG9ja2xlc3MgZGVzaWduLgo+ID4KPiA+IFRoYW5rcywK
PiA+IFpodSBMaW5nc2hhbgo+ID4gPgo+ID4gPgo+ID4gPiBXaGF0J3MgZ29pbmcgb24gaGVyZT8K
PiA+ID4KPiA+ID4KPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
