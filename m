Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7155CC04A68
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 06:41:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBE6B417B7;
	Thu, 28 Jul 2022 06:41:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EBE6B417B7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MT35Ocwe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gmsu5O_WUBvR; Thu, 28 Jul 2022 06:41:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9D3704175D;
	Thu, 28 Jul 2022 06:41:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D3704175D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5270CC0035;
	Thu, 28 Jul 2022 06:41:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABFB6C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 06:41:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7401340159
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 06:41:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7401340159
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MT35Ocwe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vC6NMv1NsJam
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 06:41:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55C0040136
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 55C0040136
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 06:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658990498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g0nLqK3EsWc2TxymPgSpCGcvke66TRrVDQKW7puuQXU=;
 b=MT35OcwePGlPUz0wXJGpBbXWOK5OuyUGiYm6b92aEaHG4wy4NdFMGReCnY4xj0X/Pl/ciS
 iBiNt/eNFvmhpozs97AK6Q6E9Ty1J+8pIaVvCcfT1blg0psMCaP/foff1R64bI/Z1Sm2+B
 Jvnn9X6pLODEPpFZBhc33z5fq3VAMgw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-u5dwF9EUNqCtGRPu6tO4ew-1; Thu, 28 Jul 2022 02:41:37 -0400
X-MC-Unique: u5dwF9EUNqCtGRPu6tO4ew-1
Received: by mail-wr1-f69.google.com with SMTP id
 i15-20020adfa50f000000b0021ebd499de2so102233wrb.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 23:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=g0nLqK3EsWc2TxymPgSpCGcvke66TRrVDQKW7puuQXU=;
 b=Z3qWWLGHSX4rWB8cLXARvs33jRZLvICf7FfaBd6XZvIA/6WWu8Fnwz1EW+IuT0tOJd
 ReoxzKCh6tm+1S8kzOPk/EMs9KYjDvF173ucWTBsjiLsYOl5u4BgFd1S2DH9CU1jKojX
 DZAn92YGE8W+Cxd0BWAMFNCx89RAmWMo/NFh3StNj/pvoPaYPfEHHatQCmBw1JHrwAxZ
 VYB/SiZuPuxZJcED/Qrzm0woi6I5rxIYewa53CNR4Z16lu6EdGSwW0VtiFgbPuOXxH4O
 CGRznXWh/2F/6u6w3cDSWTja8/bTrN22pVpOO8XoQvU/jVnZP81j9t/z8BvopPfuImdp
 EzCg==
X-Gm-Message-State: AJIora9MUPMf2DdUr01JPTqc0+2PShVVDoMOfJC9HIM6eaCsIH5kWziY
 R3oy+Owc+78xXlzsdEv+huriTI7ltQzepMYcEcAlr7Ib5qGel1aTRWaXomIj038iYFyeqbN2uti
 8iT5O9kYXechJ4+Vbbk85Wv9FHUf9iWRb5iDrf9L8eg==
X-Received: by 2002:a05:6000:70d:b0:21e:62f1:532c with SMTP id
 bs13-20020a056000070d00b0021e62f1532cmr15838249wrb.689.1658990496307; 
 Wed, 27 Jul 2022 23:41:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t4ZbFr2xW+ouVOofJzRf07pj1wmzyAkg2f5rRKfrlNv7o0ME9aFNF8AdV0+fJKAI3EmoE38Q==
X-Received: by 2002:a05:6000:70d:b0:21e:62f1:532c with SMTP id
 bs13-20020a056000070d00b0021e62f1532cmr15838233wrb.689.1658990496036; 
 Wed, 27 Jul 2022 23:41:36 -0700 (PDT)
Received: from redhat.com ([2.54.183.236]) by smtp.gmail.com with ESMTPSA id
 d10-20020adffbca000000b0021e4f446d43sm18212wrs.58.2022.07.27.23.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jul 2022 23:41:35 -0700 (PDT)
Date: Thu, 28 Jul 2022 02:41:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Message-ID: <20220728024111-mutt-send-email-mst@kernel.org>
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
MIME-Version: 1.0
In-Reply-To: <CACGkMEu76TtzXRkv_daoHCY9gZ0ikbFBHD+gRz8KNMdeKiGArg@mail.gmail.com>
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

T24gVGh1LCBKdWwgMjgsIDIwMjIgYXQgMDE6NTM6NTFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUaHUsIEp1bCAyOCwgMjAyMiBhdCAxMTo0NyBBTSBaaHUsIExpbmdzaGFuIDxsaW5n
c2hhbi56aHVAaW50ZWwuY29tPiB3cm90ZToKPiA+Cj4gPgo+ID4KPiA+IE9uIDcvMjgvMjAyMiA5
OjIxIEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiBPbiBXZWQsIEp1bCAyNywgMjAyMiBhdCAx
MTo0NSBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4+
IE9uIFdlZCwgSnVsIDI3LCAyMDIyIGF0IDA1OjUwOjU5UE0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4gPiA+Pj4gT24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgNTowMyBQTSBNaWNoYWVsIFMuIFRz
aXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4+Pj4gT24gV2VkLCBKdWwgMjcsIDIw
MjIgYXQgMDI6NTQ6MTNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4+Pj4+IE9uIFdl
ZCwgSnVsIDI3LCAyMDIyIGF0IDI6MDEgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4gPiA+Pj4+Pj4gT24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMDM6NDc6MzVB
TSArMDAwMCwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+ID4gPj4+Pj4+Pj4gRnJvbTogWmh1LCBMaW5n
c2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPiA+ID4+Pj4+Pj4+IFNlbnQ6IFR1ZXNkYXks
IEp1bHkgMjYsIDIwMjIgMTA6NTMgUE0KPiA+ID4+Pj4+Pj4+Cj4gPiA+Pj4+Pj4+PiBPbiA3LzI3
LzIwMjIgMTA6MTcgQU0sIFBhcmF2IFBhbmRpdCB3cm90ZToKPiA+ID4+Pj4+Pj4+Pj4gRnJvbTog
Wmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPiA+ID4+Pj4+Pj4+Pj4gU2Vu
dDogVHVlc2RheSwgSnVseSAyNiwgMjAyMiAxMDoxNSBQTQo+ID4gPj4+Pj4+Pj4+Pgo+ID4gPj4+
Pj4+Pj4+PiBPbiA3LzI2LzIwMjIgMTE6NTYgUE0sIFBhcmF2IFBhbmRpdCB3cm90ZToKPiA+ID4+
Pj4+Pj4+Pj4+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+
ID4gPj4+Pj4+Pj4+Pj4+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMTIsIDIwMjIgMTE6NDYgUE0KPiA+
ID4+Pj4+Pj4+Pj4+Pj4gV2hlbiB0aGUgdXNlciBzcGFjZSB3aGljaCBpbnZva2VzIG5ldGxpbmsg
Y29tbWFuZHMsIGRldGVjdHMgdGhhdAo+ID4gPj4+Pj4+Pj4+PiBfTVEKPiA+ID4+Pj4+Pj4+Pj4+
PiBpcyBub3Qgc3VwcG9ydGVkLCBoZW5jZSBpdCB0YWtlcyBtYXhfcXVldWVfcGFpciA9IDEgYnkg
aXRzZWxmLgo+ID4gPj4+Pj4+Pj4+Pj4+IEkgdGhpbmsgdGhlIGtlcm5lbCBtb2R1bGUgaGF2ZSBh
bGwgbmVjZXNzYXJ5IGluZm9ybWF0aW9uIGFuZCBpdCBpcwo+ID4gPj4+Pj4+Pj4+Pj4+IHRoZSBv
bmx5IG9uZSB3aGljaCBoYXZlIHByZWNpc2UgaW5mb3JtYXRpb24gb2YgYSBkZXZpY2UsIHNvIGl0
Cj4gPiA+Pj4+Pj4+Pj4+Pj4gc2hvdWxkIGFuc3dlciBwcmVjaXNlbHkgdGhhbiBsZXQgdGhlIHVz
ZXIgc3BhY2UgZ3Vlc3MuIFRoZSBrZXJuZWwKPiA+ID4+Pj4+Pj4+Pj4+PiBtb2R1bGUgc2hvdWxk
IGJlIHJlbGlhYmxlIHRoYW4gc3RheSBzaWxlbnQsIGxlYXZlIHRoZSBxdWVzdGlvbiB0bwo+ID4g
Pj4+Pj4+Pj4+Pj4+IHRoZSB1c2VyIHNwYWNlCj4gPiA+Pj4+Pj4+Pj4+IHRvb2wuCj4gPiA+Pj4+
Pj4+Pj4+PiBLZXJuZWwgaXMgcmVsaWFibGUuIEl0IGRvZXNu4oCZdCBleHBvc2UgYSBjb25maWcg
c3BhY2UgZmllbGQgaWYgdGhlCj4gPiA+Pj4+Pj4+Pj4+PiBmaWVsZCBkb2VzbuKAmXQKPiA+ID4+
Pj4+Pj4+Pj4gZXhpc3QgcmVnYXJkbGVzcyBvZiBmaWVsZCBzaG91bGQgaGF2ZSBkZWZhdWx0IG9y
IG5vIGRlZmF1bHQuCj4gPiA+Pj4+Pj4+Pj4+IHNvIHdoZW4geW91IGtub3cgaXQgaXMgb25lIHF1
ZXVlIHBhaXIsIHlvdSBzaG91bGQgYW5zd2VyIG9uZSwgbm90IHRyeQo+ID4gPj4+Pj4+Pj4+PiB0
byBndWVzcy4KPiA+ID4+Pj4+Pj4+Pj4+IFVzZXIgc3BhY2Ugc2hvdWxkIG5vdCBndWVzcyBlaXRo
ZXIuIFVzZXIgc3BhY2UgZ2V0cyB0byBzZWUgaWYgX01RCj4gPiA+Pj4+Pj4+Pj4+IHByZXNlbnQv
bm90IHByZXNlbnQuIElmIF9NUSBwcmVzZW50IHRoYW4gZ2V0IHJlbGlhYmxlIGRhdGEgZnJvbSBr
ZXJuZWwuCj4gPiA+Pj4+Pj4+Pj4+PiBJZiBfTVEgbm90IHByZXNlbnQsIGl0IG1lYW5zIHRoaXMg
ZGV2aWNlIGhhcyBvbmUgVlEgcGFpci4KPiA+ID4+Pj4+Pj4+Pj4gaXQgaXMgc3RpbGwgYSBndWVz
cywgcmlnaHQ/IEFuZCBhbGwgdXNlciBzcGFjZSB0b29scyBpbXBsZW1lbnRlZCB0aGlzCj4gPiA+
Pj4+Pj4+Pj4+IGZlYXR1cmUgbmVlZCB0byBndWVzcwo+ID4gPj4+Pj4+Pj4+IE5vLiBpdCBpcyBu
b3QgYSBndWVzcy4KPiA+ID4+Pj4+Pj4+PiBJdCBpcyBleHBsaWNpdGx5IGNoZWNraW5nIHRoZSBf
TVEgZmVhdHVyZSBhbmQgZGVyaXZpbmcgdGhlIHZhbHVlLgo+ID4gPj4+Pj4+Pj4+IFRoZSBjb2Rl
IHlvdSBwcm9wb3NlZCB3aWxsIGJlIHByZXNlbnQgaW4gdGhlIHVzZXIgc3BhY2UuCj4gPiA+Pj4+
Pj4+Pj4gSXQgd2lsbCBiZSB1bmlmb3JtIGZvciBfTVEgYW5kIDEwIG90aGVyIGZlYXR1cmVzIHRo
YXQgYXJlIHByZXNlbnQgbm93IGFuZAo+ID4gPj4+Pj4+Pj4gaW4gdGhlIGZ1dHVyZS4KPiA+ID4+
Pj4+Pj4+IE1RIGFuZCBvdGhlciBmZWF0dXJlcyBsaWtlIFJTUyBhcmUgZGlmZmVyZW50LiBJZiB0
aGVyZSBpcyBubyBfUlNTX1hYLCB0aGVyZQo+ID4gPj4+Pj4+Pj4gYXJlIG5vIGF0dHJpYnV0ZXMg
bGlrZSBtYXhfcnNzX2tleV9zaXplLCBhbmQgdGhlcmUgaXMgbm90IGEgZGVmYXVsdCB2YWx1ZS4K
PiA+ID4+Pj4+Pj4+IEJ1dCBmb3IgTVEsIHdlIGtub3cgaXQgaGFzIHRvIGJlIDEgd2lodG91dCBf
TVEuCj4gPiA+Pj4+Pj4+ICJ3ZSIgPSB1c2VyIHNwYWNlLgo+ID4gPj4+Pj4+PiBUbyBrZWVwIHRo
ZSBjb25zaXN0ZW5jeSBhbW9uZyBhbGwgdGhlIGNvbmZpZyBzcGFjZSBmaWVsZHMuCj4gPiA+Pj4+
Pj4gQWN0dWFsbHkgSSBsb29rZWQgYW5kIHRoZSBjb2RlIHNvbWUgbW9yZSBhbmQgSSdtIHB1enps
ZWQ6Cj4gPiA+Pj4+Pj4KPiA+ID4+Pj4+Pgo+ID4gPj4+Pj4+ICAgICAgICAgIHN0cnVjdCB2aXJ0
aW9fbmV0X2NvbmZpZyBjb25maWcgPSB7fTsKPiA+ID4+Pj4+PiAgICAgICAgICB1NjQgZmVhdHVy
ZXM7Cj4gPiA+Pj4+Pj4gICAgICAgICAgdTE2IHZhbF91MTY7Cj4gPiA+Pj4+Pj4KPiA+ID4+Pj4+
PiAgICAgICAgICB2ZHBhX2dldF9jb25maWdfdW5sb2NrZWQodmRldiwgMCwgJmNvbmZpZywgc2l6
ZW9mKGNvbmZpZykpOwo+ID4gPj4+Pj4+Cj4gPiA+Pj4+Pj4gICAgICAgICAgaWYgKG5sYV9wdXQo
bXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFDQUREUiwgc2l6ZW9mKGNvbmZpZy5tYWMpLAo+
ID4gPj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgIGNvbmZpZy5tYWMpKQo+ID4gPj4+Pj4+ICAg
ICAgICAgICAgICAgICAgcmV0dXJuIC1FTVNHU0laRTsKPiA+ID4+Pj4+Pgo+ID4gPj4+Pj4+Cj4g
PiA+Pj4+Pj4gTWFjIHJldHVybmVkIGV2ZW4gd2l0aG91dCBWSVJUSU9fTkVUX0ZfTUFDCj4gPiA+
Pj4+Pj4KPiA+ID4+Pj4+Pgo+ID4gPj4+Pj4+ICAgICAgICAgIHZhbF91MTYgPSBsZTE2X3RvX2Nw
dShjb25maWcuc3RhdHVzKTsKPiA+ID4+Pj4+PiAgICAgICAgICBpZiAobmxhX3B1dF91MTYobXNn
LCBWRFBBX0FUVFJfREVWX05FVF9TVEFUVVMsIHZhbF91MTYpKQo+ID4gPj4+Pj4+ICAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1FTVNHU0laRTsKPiA+ID4+Pj4+Pgo+ID4gPj4+Pj4+Cj4gPiA+Pj4+
Pj4gc3RhdHVzIHJldHVybmVkIGV2ZW4gd2l0aG91dCBWSVJUSU9fTkVUX0ZfU1RBVFVTCj4gPiA+
Pj4+Pj4KPiA+ID4+Pj4+PiAgICAgICAgICB2YWxfdTE2ID0gbGUxNl90b19jcHUoY29uZmlnLm10
dSk7Cj4gPiA+Pj4+Pj4gICAgICAgICAgaWYgKG5sYV9wdXRfdTE2KG1zZywgVkRQQV9BVFRSX0RF
Vl9ORVRfQ0ZHX01UVSwgdmFsX3UxNikpCj4gPiA+Pj4+Pj4gICAgICAgICAgICAgICAgICByZXR1
cm4gLUVNU0dTSVpFOwo+ID4gPj4+Pj4+Cj4gPiA+Pj4+Pj4KPiA+ID4+Pj4+PiBNVFUgcmV0dXJu
ZWQgZXZlbiB3aXRob3V0IFZJUlRJT19ORVRfRl9NVFUKPiA+ID4+Pj4+Pgo+ID4gPj4+Pj4+Cj4g
PiA+Pj4+Pj4gV2hhdCdzIGdvaW5nIG9uIGhlcmU/Cj4gPiA+Pj4+PiBQcm9iYWJseSB0b28gbGF0
ZSB0byBmaXgsIGJ1dCB0aGlzIHNob3VsZCBiZSBmaW5lIGFzIGxvbmcgYXMgYWxsCj4gPiA+Pj4+
PiBwYXJlbnRzIHN1cHBvcnQgU1RBVFVTL01UVS9NQUMuCj4gPiA+Pj4+IFdoeSBpcyB0aGlzIHRv
byBsYXRlIHRvIGZpeC4KPiA+ID4+PiBJZiB3ZSBtYWtlIHRoaXMgY29uZGl0aW9uYWwgb24gdGhl
IGZlYXR1cmVzLiBUaGlzIG1heSBicmVhayB0aGUKPiA+ID4+PiB1c2Vyc3BhY2UgdGhhdCBhbHdh
eXMgZXhwZWN0cyBWRFBBX0FUVFJfREVWX05FVF9DRkdfTVRVPwo+ID4gPj4+Cj4gPiA+Pj4gVGhh
bmtzCj4gPiA+PiBXZWxsIG9ubHkgb24gZGV2aWNlcyB3aXRob3V0IE1UVS4gSSdtIHNheWluZyBz
YWlkIHVzZXJzcGFjZQo+ID4gPj4gd2FzIHJlYWRpbmcgdHJhc2ggb24gc3VjaCBkZXZpY2VzIGFu
eXdheS4KPiA+ID4gSXQgZGVwZW5kcyBvbiB0aGUgcGFyZW50IGFjdHVhbGx5LiBGb3IgZXhhbXBs
ZSwgbWx4NSBxdWVyeSB0aGUgbG93ZXIKPiA+ID4gbXR1IHVuY29uZGl0aW9uYWxseToKPiA+ID4K
PiA+ID4gICAgICAgICAgZXJyID0gcXVlcnlfbXR1KG1kZXYsICZtdHUpOwo+ID4gPiAgICAgICAg
ICBpZiAoZXJyKQo+ID4gPiAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX2FsbG9jOwo+ID4gPgo+
ID4gPiAgICAgICAgICBuZGV2LT5jb25maWcubXR1ID0gY3B1X3RvX21seDV2ZHBhMTYobXZkZXYs
IG10dSk7Cj4gPiA+Cj4gPiA+IFN1cHBvcnRpbmcgTVRVIGZlYXR1cmVzIHNlZW1zIHRvIGJlIGEg
bXVzdCBmb3IgcmVhbCBoYXJkd2FyZS4KPiA+ID4gT3RoZXJ3aXNlIHRoZSBkcml2ZXIgbWF5IG5v
dCB3b3JrIGNvcnJlY3RseS4KPiA+ID4KPiA+ID4+IFdlIGRvbid0IGdlbmVyYWxseSBtYWludGFp
biBidWcgZm9yIGJ1ZyBjb21wYXRpYmxpdHkgb24gYSB3aGltLAo+ID4gPj4gb25seSBpZiB1c2Vy
c3BhY2UgaXMgYWN0dWFsbHkga25vd24gdG8gYnJlYWsgaWYgd2UgZml4IGEgYnVnLgo+ID4gPiAg
IFNvIEkgdGhpbmsgaXQgc2hvdWxkIGJlIGZpbmUgdG8gbWFrZSB0aGlzIGNvbmRpdGlvbmFsIHRo
ZW4gd2Ugc2hvdWxkCj4gPiA+IGhhdmUgYSBjb25zaXN0ZW50IGhhbmRsaW5nIG9mIG90aGVyIGZp
ZWxkcyBsaWtlIE1RLgo+ID4gRm9yIHNvbWUgZmllbGRzIHRoYXQgaGF2ZSBhIGRlZmF1bHQgdmFs
dWUsIGxpa2UgTVEgPTEsIHdlIGNhbiByZXR1cm4gdGhlCj4gPiBkZWZhdWx0IHZhbHVlLgo+ID4g
Rm9yIG90aGVyIGZpZWxkcyB3aXRob3V0IGEgZGVmYXVsdCB2YWx1ZSwgbGlrZSBNQUMsIHdlIHJl
dHVybiBub3RoaW5nLgo+ID4KPiA+IERvZXMgdGhpcyBzb3VuZHMgZ29vZD8gU28sIGZvciBNVFUs
IGlmIHdpdGhvdXQgX0ZfTVRVLCBJIHRoaW5rIHdlIGNhbgo+ID4gcmV0dXJuIDE1MDAgYnkgZGVm
YXVsdC4KPiAKPiBPciB3ZSBjYW4ganVzdCByZWFkIE1UVSBmcm9tIHRoZSBkZXZpY2UuCj4gCj4g
QnV0IEl0IGxvb2tzIHRvIG1lIE1pY2hhZWwgd2FudHMgaXQgY29uZGl0aW9uYWwuCj4gCj4gVGhh
bmtzCgpJJ20gZmluZSBlaXRoZXIgd2F5IGJ1dCBsZXQncyBrZWVwIGl0IGNvbnNpc3RlbnQuIEFu
ZCBJIHRoaW5rClBhcmF2IHdhbnRzIGl0IGNvbmRpdGlvbmFsLgoKPiA+Cj4gPiBUaGFua3MsCj4g
PiBaaHUgTGluZ3NoYW4KPiA+ID4KPiA+ID4gVGhhbmtzCj4gPiA+Cj4gPiA+Pgo+ID4gPj4+Pj4g
SSB3b25kZXIgaWYgd2UgY2FuIGFkZCBhIGNoZWNrIGluIHRoZSBjb3JlIGFuZCBmYWlsIHRoZSBk
ZXZpY2UKPiA+ID4+Pj4+IHJlZ2lzdHJhdGlvbiBpbiB0aGlzIGNhc2UuCj4gPiA+Pj4+Pgo+ID4g
Pj4+Pj4gVGhhbmtzCj4gPiA+Pj4+Pgo+ID4gPj4+Pj4+Cj4gPiA+Pj4+Pj4gLS0KPiA+ID4+Pj4+
PiBNU1QKPiA+ID4+Pj4+Pgo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
