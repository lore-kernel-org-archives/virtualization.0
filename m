Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B70C04A68
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 05:54:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B9F4827F0;
	Thu, 28 Jul 2022 05:54:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1B9F4827F0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FtO4mOqg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AfO0ar1HwFRd; Thu, 28 Jul 2022 05:54:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2DF3F82662;
	Thu, 28 Jul 2022 05:54:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2DF3F82662
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEF88C0033;
	Thu, 28 Jul 2022 05:54:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 726D5C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 05:54:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D7E9417AB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 05:54:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3D7E9417AB
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FtO4mOqg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id thpNDwsMm5KX
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 05:54:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CA2C4417A7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA2C4417A7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 05:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658987645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qgQE2wM2FNpAW3eLmrmpqpr9v/ElGZjhWnf6p3EUXkg=;
 b=FtO4mOqgLZFI66EYm5VKpNSSfVbWgV6wQtAPTOE1qZXUrItsz0ZWwJ5MD0+ss5pJxk//Sy
 gVJ9CKdk9iVPM1ZgC8ci78D7jXPYvWJYzi2S+Bwz0dcqwZ5NJhgGiylCyz8Tc8eiAhNE2x
 Fxt9tzk/kp/vTG0OXmcM3oYz5qVBdFM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-26mdRePlOe-a39dFhppmEw-1; Thu, 28 Jul 2022 01:54:04 -0400
X-MC-Unique: 26mdRePlOe-a39dFhppmEw-1
Received: by mail-lj1-f200.google.com with SMTP id
 d4-20020a2e9284000000b0025e0f56d216so105168ljh.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 22:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qgQE2wM2FNpAW3eLmrmpqpr9v/ElGZjhWnf6p3EUXkg=;
 b=O8fe+Flux1rjgTTVYTbYw0SQt0rZ9VK5KkLgKA6la68eWEnrqOR25qoOybO7gOGpx0
 3YTD0RBvi35QnBYUsIu9zi64R8+/A2efoI5FNl56N9ieyrIOdrHJbiCD3lx8pD43Dydq
 DR/59jENhB6+m0En6GVgeA43mCzq4v8lYex3m6N/bj/LRsB3tncs80mnXVGYv+XWYxfm
 yLwp4Y5U1DmJ9/Wa7m7yYQXv0venV7UHXDy8WtnlBkxbdO+Kl0Z/bY+YC901OW0NxZxa
 M7iiswqJGONeyxvzO8iZzipycfsX+uuMv5Fly+JLPPnsgf/pa2+E4vmco8ZDTc+PUbwD
 MJ0A==
X-Gm-Message-State: AJIora+3neRNaQFtCtPR0SHVthx0iBXA8Knjjj7FxYlYZGDYtmRv69Oy
 NBWUSjo2I+LP4d174/FoEg4qBcIrzWek6aH5yHKDXVN/nmhsxfPPVSTbebFjh5P7xGRf6XkuFyI
 q41/PwJPep6qVoCevFoq+qviAzhMP+lu3D4UBvvhtW+F0JeD2MzvzMoVo4A==
X-Received: by 2002:ac2:4205:0:b0:48a:95e6:395c with SMTP id
 y5-20020ac24205000000b0048a95e6395cmr6100307lfh.238.1658987642848; 
 Wed, 27 Jul 2022 22:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vXULqUEcG2w64dv5lL3Eo8TCtb9NC34nQdWZaMo4wsxGOGb29yK9YhpV+MyRyYkjtF18VkuSCV/NG7fMIGM3k=
X-Received: by 2002:ac2:4205:0:b0:48a:95e6:395c with SMTP id
 y5-20020ac24205000000b0048a95e6395cmr6100299lfh.238.1658987642385; Wed, 27
 Jul 2022 22:54:02 -0700 (PDT)
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
 <CACGkMEv80RTtuyw5RtwgTHUphS1s2oTeb94tc6Tx7LbJWKsEBw@mail.gmail.com>
 <459524bc-0e21-422b-31c1-39745fd25fac@intel.com>
In-Reply-To: <459524bc-0e21-422b-31c1-39745fd25fac@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Jul 2022 13:53:51 +0800
Message-ID: <CACGkMEu76TtzXRkv_daoHCY9gZ0ikbFBHD+gRz8KNMdeKiGArg@mail.gmail.com>
Subject: Re: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>
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

T24gVGh1LCBKdWwgMjgsIDIwMjIgYXQgMTE6NDcgQU0gWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4u
emh1QGludGVsLmNvbT4gd3JvdGU6Cj4KPgo+Cj4gT24gNy8yOC8yMDIyIDk6MjEgQU0sIEphc29u
IFdhbmcgd3JvdGU6Cj4gPiBPbiBXZWQsIEp1bCAyNywgMjAyMiBhdCAxMTo0NSBQTSBNaWNoYWVs
IFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+PiBPbiBXZWQsIEp1bCAyNywg
MjAyMiBhdCAwNTo1MDo1OVBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4+PiBPbiBXZWQs
IEp1bCAyNywgMjAyMiBhdCA1OjAzIFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5j
b20+IHdyb3RlOgo+ID4+Pj4gT24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMDI6NTQ6MTNQTSArMDgw
MCwgSmFzb24gV2FuZyB3cm90ZToKPiA+Pj4+PiBPbiBXZWQsIEp1bCAyNywgMjAyMiBhdCAyOjAx
IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4+Pj4+PiBP
biBXZWQsIEp1bCAyNywgMjAyMiBhdCAwMzo0NzozNUFNICswMDAwLCBQYXJhdiBQYW5kaXQgd3Jv
dGU6Cj4gPj4+Pj4+Pj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNv
bT4KPiA+Pj4+Pj4+PiBTZW50OiBUdWVzZGF5LCBKdWx5IDI2LCAyMDIyIDEwOjUzIFBNCj4gPj4+
Pj4+Pj4KPiA+Pj4+Pj4+PiBPbiA3LzI3LzIwMjIgMTA6MTcgQU0sIFBhcmF2IFBhbmRpdCB3cm90
ZToKPiA+Pj4+Pj4+Pj4+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5j
b20+Cj4gPj4+Pj4+Pj4+PiBTZW50OiBUdWVzZGF5LCBKdWx5IDI2LCAyMDIyIDEwOjE1IFBNCj4g
Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4gT24gNy8yNi8yMDIyIDExOjU2IFBNLCBQYXJhdiBQYW5k
aXQgd3JvdGU6Cj4gPj4+Pj4+Pj4+Pj4+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpo
dUBpbnRlbC5jb20+Cj4gPj4+Pj4+Pj4+Pj4+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMTIsIDIwMjIg
MTE6NDYgUE0KPiA+Pj4+Pj4+Pj4+Pj4+IFdoZW4gdGhlIHVzZXIgc3BhY2Ugd2hpY2ggaW52b2tl
cyBuZXRsaW5rIGNvbW1hbmRzLCBkZXRlY3RzIHRoYXQKPiA+Pj4+Pj4+Pj4+IF9NUQo+ID4+Pj4+
Pj4+Pj4+PiBpcyBub3Qgc3VwcG9ydGVkLCBoZW5jZSBpdCB0YWtlcyBtYXhfcXVldWVfcGFpciA9
IDEgYnkgaXRzZWxmLgo+ID4+Pj4+Pj4+Pj4+PiBJIHRoaW5rIHRoZSBrZXJuZWwgbW9kdWxlIGhh
dmUgYWxsIG5lY2Vzc2FyeSBpbmZvcm1hdGlvbiBhbmQgaXQgaXMKPiA+Pj4+Pj4+Pj4+Pj4gdGhl
IG9ubHkgb25lIHdoaWNoIGhhdmUgcHJlY2lzZSBpbmZvcm1hdGlvbiBvZiBhIGRldmljZSwgc28g
aXQKPiA+Pj4+Pj4+Pj4+Pj4gc2hvdWxkIGFuc3dlciBwcmVjaXNlbHkgdGhhbiBsZXQgdGhlIHVz
ZXIgc3BhY2UgZ3Vlc3MuIFRoZSBrZXJuZWwKPiA+Pj4+Pj4+Pj4+Pj4gbW9kdWxlIHNob3VsZCBi
ZSByZWxpYWJsZSB0aGFuIHN0YXkgc2lsZW50LCBsZWF2ZSB0aGUgcXVlc3Rpb24gdG8KPiA+Pj4+
Pj4+Pj4+Pj4gdGhlIHVzZXIgc3BhY2UKPiA+Pj4+Pj4+Pj4+IHRvb2wuCj4gPj4+Pj4+Pj4+Pj4g
S2VybmVsIGlzIHJlbGlhYmxlLiBJdCBkb2VzbuKAmXQgZXhwb3NlIGEgY29uZmlnIHNwYWNlIGZp
ZWxkIGlmIHRoZQo+ID4+Pj4+Pj4+Pj4+IGZpZWxkIGRvZXNu4oCZdAo+ID4+Pj4+Pj4+Pj4gZXhp
c3QgcmVnYXJkbGVzcyBvZiBmaWVsZCBzaG91bGQgaGF2ZSBkZWZhdWx0IG9yIG5vIGRlZmF1bHQu
Cj4gPj4+Pj4+Pj4+PiBzbyB3aGVuIHlvdSBrbm93IGl0IGlzIG9uZSBxdWV1ZSBwYWlyLCB5b3Ug
c2hvdWxkIGFuc3dlciBvbmUsIG5vdCB0cnkKPiA+Pj4+Pj4+Pj4+IHRvIGd1ZXNzLgo+ID4+Pj4+
Pj4+Pj4+IFVzZXIgc3BhY2Ugc2hvdWxkIG5vdCBndWVzcyBlaXRoZXIuIFVzZXIgc3BhY2UgZ2V0
cyB0byBzZWUgaWYgX01RCj4gPj4+Pj4+Pj4+PiBwcmVzZW50L25vdCBwcmVzZW50LiBJZiBfTVEg
cHJlc2VudCB0aGFuIGdldCByZWxpYWJsZSBkYXRhIGZyb20ga2VybmVsLgo+ID4+Pj4+Pj4+Pj4+
IElmIF9NUSBub3QgcHJlc2VudCwgaXQgbWVhbnMgdGhpcyBkZXZpY2UgaGFzIG9uZSBWUSBwYWly
Lgo+ID4+Pj4+Pj4+Pj4gaXQgaXMgc3RpbGwgYSBndWVzcywgcmlnaHQ/IEFuZCBhbGwgdXNlciBz
cGFjZSB0b29scyBpbXBsZW1lbnRlZCB0aGlzCj4gPj4+Pj4+Pj4+PiBmZWF0dXJlIG5lZWQgdG8g
Z3Vlc3MKPiA+Pj4+Pj4+Pj4gTm8uIGl0IGlzIG5vdCBhIGd1ZXNzLgo+ID4+Pj4+Pj4+PiBJdCBp
cyBleHBsaWNpdGx5IGNoZWNraW5nIHRoZSBfTVEgZmVhdHVyZSBhbmQgZGVyaXZpbmcgdGhlIHZh
bHVlLgo+ID4+Pj4+Pj4+PiBUaGUgY29kZSB5b3UgcHJvcG9zZWQgd2lsbCBiZSBwcmVzZW50IGlu
IHRoZSB1c2VyIHNwYWNlLgo+ID4+Pj4+Pj4+PiBJdCB3aWxsIGJlIHVuaWZvcm0gZm9yIF9NUSBh
bmQgMTAgb3RoZXIgZmVhdHVyZXMgdGhhdCBhcmUgcHJlc2VudCBub3cgYW5kCj4gPj4+Pj4+Pj4g
aW4gdGhlIGZ1dHVyZS4KPiA+Pj4+Pj4+PiBNUSBhbmQgb3RoZXIgZmVhdHVyZXMgbGlrZSBSU1Mg
YXJlIGRpZmZlcmVudC4gSWYgdGhlcmUgaXMgbm8gX1JTU19YWCwgdGhlcmUKPiA+Pj4+Pj4+PiBh
cmUgbm8gYXR0cmlidXRlcyBsaWtlIG1heF9yc3Nfa2V5X3NpemUsIGFuZCB0aGVyZSBpcyBub3Qg
YSBkZWZhdWx0IHZhbHVlLgo+ID4+Pj4+Pj4+IEJ1dCBmb3IgTVEsIHdlIGtub3cgaXQgaGFzIHRv
IGJlIDEgd2lodG91dCBfTVEuCj4gPj4+Pj4+PiAid2UiID0gdXNlciBzcGFjZS4KPiA+Pj4+Pj4+
IFRvIGtlZXAgdGhlIGNvbnNpc3RlbmN5IGFtb25nIGFsbCB0aGUgY29uZmlnIHNwYWNlIGZpZWxk
cy4KPiA+Pj4+Pj4gQWN0dWFsbHkgSSBsb29rZWQgYW5kIHRoZSBjb2RlIHNvbWUgbW9yZSBhbmQg
SSdtIHB1enpsZWQ6Cj4gPj4+Pj4+Cj4gPj4+Pj4+Cj4gPj4+Pj4+ICAgICAgICAgIHN0cnVjdCB2
aXJ0aW9fbmV0X2NvbmZpZyBjb25maWcgPSB7fTsKPiA+Pj4+Pj4gICAgICAgICAgdTY0IGZlYXR1
cmVzOwo+ID4+Pj4+PiAgICAgICAgICB1MTYgdmFsX3UxNjsKPiA+Pj4+Pj4KPiA+Pj4+Pj4gICAg
ICAgICAgdmRwYV9nZXRfY29uZmlnX3VubG9ja2VkKHZkZXYsIDAsICZjb25maWcsIHNpemVvZihj
b25maWcpKTsKPiA+Pj4+Pj4KPiA+Pj4+Pj4gICAgICAgICAgaWYgKG5sYV9wdXQobXNnLCBWRFBB
X0FUVFJfREVWX05FVF9DRkdfTUFDQUREUiwgc2l6ZW9mKGNvbmZpZy5tYWMpLAo+ID4+Pj4+PiAg
ICAgICAgICAgICAgICAgICAgICBjb25maWcubWFjKSkKPiA+Pj4+Pj4gICAgICAgICAgICAgICAg
ICByZXR1cm4gLUVNU0dTSVpFOwo+ID4+Pj4+Pgo+ID4+Pj4+Pgo+ID4+Pj4+PiBNYWMgcmV0dXJu
ZWQgZXZlbiB3aXRob3V0IFZJUlRJT19ORVRfRl9NQUMKPiA+Pj4+Pj4KPiA+Pj4+Pj4KPiA+Pj4+
Pj4gICAgICAgICAgdmFsX3UxNiA9IGxlMTZfdG9fY3B1KGNvbmZpZy5zdGF0dXMpOwo+ID4+Pj4+
PiAgICAgICAgICBpZiAobmxhX3B1dF91MTYobXNnLCBWRFBBX0FUVFJfREVWX05FVF9TVEFUVVMs
IHZhbF91MTYpKQo+ID4+Pj4+PiAgICAgICAgICAgICAgICAgIHJldHVybiAtRU1TR1NJWkU7Cj4g
Pj4+Pj4+Cj4gPj4+Pj4+Cj4gPj4+Pj4+IHN0YXR1cyByZXR1cm5lZCBldmVuIHdpdGhvdXQgVklS
VElPX05FVF9GX1NUQVRVUwo+ID4+Pj4+Pgo+ID4+Pj4+PiAgICAgICAgICB2YWxfdTE2ID0gbGUx
Nl90b19jcHUoY29uZmlnLm10dSk7Cj4gPj4+Pj4+ICAgICAgICAgIGlmIChubGFfcHV0X3UxNiht
c2csIFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NVFUsIHZhbF91MTYpKQo+ID4+Pj4+PiAgICAgICAg
ICAgICAgICAgIHJldHVybiAtRU1TR1NJWkU7Cj4gPj4+Pj4+Cj4gPj4+Pj4+Cj4gPj4+Pj4+IE1U
VSByZXR1cm5lZCBldmVuIHdpdGhvdXQgVklSVElPX05FVF9GX01UVQo+ID4+Pj4+Pgo+ID4+Pj4+
Pgo+ID4+Pj4+PiBXaGF0J3MgZ29pbmcgb24gaGVyZT8KPiA+Pj4+PiBQcm9iYWJseSB0b28gbGF0
ZSB0byBmaXgsIGJ1dCB0aGlzIHNob3VsZCBiZSBmaW5lIGFzIGxvbmcgYXMgYWxsCj4gPj4+Pj4g
cGFyZW50cyBzdXBwb3J0IFNUQVRVUy9NVFUvTUFDLgo+ID4+Pj4gV2h5IGlzIHRoaXMgdG9vIGxh
dGUgdG8gZml4Lgo+ID4+PiBJZiB3ZSBtYWtlIHRoaXMgY29uZGl0aW9uYWwgb24gdGhlIGZlYXR1
cmVzLiBUaGlzIG1heSBicmVhayB0aGUKPiA+Pj4gdXNlcnNwYWNlIHRoYXQgYWx3YXlzIGV4cGVj
dHMgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01UVT8KPiA+Pj4KPiA+Pj4gVGhhbmtzCj4gPj4gV2Vs
bCBvbmx5IG9uIGRldmljZXMgd2l0aG91dCBNVFUuIEknbSBzYXlpbmcgc2FpZCB1c2Vyc3BhY2UK
PiA+PiB3YXMgcmVhZGluZyB0cmFzaCBvbiBzdWNoIGRldmljZXMgYW55d2F5Lgo+ID4gSXQgZGVw
ZW5kcyBvbiB0aGUgcGFyZW50IGFjdHVhbGx5LiBGb3IgZXhhbXBsZSwgbWx4NSBxdWVyeSB0aGUg
bG93ZXIKPiA+IG10dSB1bmNvbmRpdGlvbmFsbHk6Cj4gPgo+ID4gICAgICAgICAgZXJyID0gcXVl
cnlfbXR1KG1kZXYsICZtdHUpOwo+ID4gICAgICAgICAgaWYgKGVycikKPiA+ICAgICAgICAgICAg
ICAgICAgZ290byBlcnJfYWxsb2M7Cj4gPgo+ID4gICAgICAgICAgbmRldi0+Y29uZmlnLm10dSA9
IGNwdV90b19tbHg1dmRwYTE2KG12ZGV2LCBtdHUpOwo+ID4KPiA+IFN1cHBvcnRpbmcgTVRVIGZl
YXR1cmVzIHNlZW1zIHRvIGJlIGEgbXVzdCBmb3IgcmVhbCBoYXJkd2FyZS4KPiA+IE90aGVyd2lz
ZSB0aGUgZHJpdmVyIG1heSBub3Qgd29yayBjb3JyZWN0bHkuCj4gPgo+ID4+IFdlIGRvbid0IGdl
bmVyYWxseSBtYWludGFpbiBidWcgZm9yIGJ1ZyBjb21wYXRpYmxpdHkgb24gYSB3aGltLAo+ID4+
IG9ubHkgaWYgdXNlcnNwYWNlIGlzIGFjdHVhbGx5IGtub3duIHRvIGJyZWFrIGlmIHdlIGZpeCBh
IGJ1Zy4KPiA+ICAgU28gSSB0aGluayBpdCBzaG91bGQgYmUgZmluZSB0byBtYWtlIHRoaXMgY29u
ZGl0aW9uYWwgdGhlbiB3ZSBzaG91bGQKPiA+IGhhdmUgYSBjb25zaXN0ZW50IGhhbmRsaW5nIG9m
IG90aGVyIGZpZWxkcyBsaWtlIE1RLgo+IEZvciBzb21lIGZpZWxkcyB0aGF0IGhhdmUgYSBkZWZh
dWx0IHZhbHVlLCBsaWtlIE1RID0xLCB3ZSBjYW4gcmV0dXJuIHRoZQo+IGRlZmF1bHQgdmFsdWUu
Cj4gRm9yIG90aGVyIGZpZWxkcyB3aXRob3V0IGEgZGVmYXVsdCB2YWx1ZSwgbGlrZSBNQUMsIHdl
IHJldHVybiBub3RoaW5nLgo+Cj4gRG9lcyB0aGlzIHNvdW5kcyBnb29kPyBTbywgZm9yIE1UVSwg
aWYgd2l0aG91dCBfRl9NVFUsIEkgdGhpbmsgd2UgY2FuCj4gcmV0dXJuIDE1MDAgYnkgZGVmYXVs
dC4KCk9yIHdlIGNhbiBqdXN0IHJlYWQgTVRVIGZyb20gdGhlIGRldmljZS4KCkJ1dCBJdCBsb29r
cyB0byBtZSBNaWNoYWVsIHdhbnRzIGl0IGNvbmRpdGlvbmFsLgoKVGhhbmtzCgo+Cj4gVGhhbmtz
LAo+IFpodSBMaW5nc2hhbgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+Pgo+ID4+Pj4+IEkgd29uZGVy
IGlmIHdlIGNhbiBhZGQgYSBjaGVjayBpbiB0aGUgY29yZSBhbmQgZmFpbCB0aGUgZGV2aWNlCj4g
Pj4+Pj4gcmVnaXN0cmF0aW9uIGluIHRoaXMgY2FzZS4KPiA+Pj4+Pgo+ID4+Pj4+IFRoYW5rcwo+
ID4+Pj4+Cj4gPj4+Pj4+Cj4gPj4+Pj4+IC0tCj4gPj4+Pj4+IE1TVAo+ID4+Pj4+Pgo+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
