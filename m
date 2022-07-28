Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C199EC04A68
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 02:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5398B82BF4;
	Thu, 28 Jul 2022 02:06:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5398B82BF4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X8359Wdp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0VRCIv83FL1d; Thu, 28 Jul 2022 02:06:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4E9FC828A5;
	Thu, 28 Jul 2022 02:06:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E9FC828A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1628AC0033;
	Thu, 28 Jul 2022 02:06:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CEE6C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 02:06:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 036884170B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 02:06:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 036884170B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=X8359Wdp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hykkhzSzM79J
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 02:06:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE828416EB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE828416EB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 02:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658973981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eCY1EoVQoU5KC7LUlytquyO2gcpF+E49noICdTq3U8o=;
 b=X8359Wdp24WvZ2tkfND6y1vN/ijCqD0AkAOFYJED9ywiKwsISFNrmmjdMSh9ior5mN8URj
 SuGs26ykVS+BdXzFoTqYyVpDeVC5nIpZq8YhImRXneJ1sYQz4NJr7p4U7FnvvsDi2GCVST
 3qlb1nFrx/TBEDV0kh52DVPPFlSOajE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-j5cyOVObPs6QsWOzclkLXg-1; Wed, 27 Jul 2022 22:06:19 -0400
X-MC-Unique: j5cyOVObPs6QsWOzclkLXg-1
Received: by mail-pl1-f200.google.com with SMTP id
 n15-20020a170902d2cf00b0016d68b4fcc0so382930plc.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 19:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=eCY1EoVQoU5KC7LUlytquyO2gcpF+E49noICdTq3U8o=;
 b=g3gl5Ws8D5YQIWY35JjZR1lEqxm0E+N9DACwoWyLraY2Go6SSI9nP/EbefONyBM3ml
 4/exUkh9OV/vvGFJKW7irCmpMReJoPH2sCnruFF+x+bvPK9yu9lXAXJTombsk8z/iygu
 v3Zl97NAZYW0QSciBtew6u2xRx3D1QS7iUcAV/IQyBTxJhQMh6AR6447WNfUb3vsqjN2
 iwGxdr0+6u2bh3EWA/e0WU+/8NZFgDyj7TAlSHUBx61TifhEvMYG7BvOtrIBiE1+aEcu
 CTBzdGY+uSBXxx0uZlNN4u/sTwBBjM+DvBQ2iuMPlv9DpzwReZcwoDxvfBqH7MaoTry1
 Ebhg==
X-Gm-Message-State: AJIora8t+YDox5aoGCxrbYbg1IjsTPsTPgwrnVMDJQYFBjJC57I+g6X3
 d2nc8+eh0886R5LR5E4yrGHCZFZo239EX8Ai2Uk/Ql4ofwwqFFlLBfVl4AMxmqustmZ2d7Nk9cx
 d4vpMAtPVcod4tElp5njakALkLLdWw/zm9uQYj4IUog==
X-Received: by 2002:a17:902:f68e:b0:16d:784f:ba with SMTP id
 l14-20020a170902f68e00b0016d784f00bamr16741080plg.174.1658973978778; 
 Wed, 27 Jul 2022 19:06:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v75WMjcHX73GY0Nw7gRf1j3Pxyub0ev6gdUf/jIzZl8+S0YnXKpq/SsihBZz6VYBnq0CpOpw==
X-Received: by 2002:a17:902:f68e:b0:16d:784f:ba with SMTP id
 l14-20020a170902f68e00b0016d784f00bamr16741052plg.174.1658973978312; 
 Wed, 27 Jul 2022 19:06:18 -0700 (PDT)
Received: from [10.72.12.210] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a170903234300b0016be5f24aaesm12347377plh.163.2022.07.27.19.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Jul 2022 19:06:17 -0700 (PDT)
Message-ID: <c8bd5396-84f2-e782-79d7-f493aca95781@redhat.com>
Date: Thu, 28 Jul 2022 10:06:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH V3 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
To: Si-Wei Liu <si-wei.liu@oracle.com>, "Zhu, Lingshan"
 <lingshan.zhu@intel.com>, Parav Pandit <parav@nvidia.com>,
 "mst@redhat.com" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-5-lingshan.zhu@intel.com>
 <PH0PR12MB548190DE76CC64E56DA2DF13DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <00889067-50ac-d2cd-675f-748f171e5c83@oracle.com>
 <63242254-ba84-6810-dad8-34f900b97f2f@intel.com>
 <8002554a-a77c-7b25-8f99-8d68248a741d@oracle.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <8002554a-a77c-7b25-8f99-8d68248a741d@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzcvMjggMDg6NTYsIFNpLVdlaSBMaXUg5YaZ6YGTOgo+Cj4KPiBPbiA3LzI3LzIw
MjIgNDo0NyBBTSwgWmh1LCBMaW5nc2hhbiB3cm90ZToKPj4KPj4KPj4gT24gNy8yNy8yMDIyIDU6
NDMgUE0sIFNpLVdlaSBMaXUgd3JvdGU6Cj4+PiBTb3JyeSB0byBjaGltZSBpbiBsYXRlIGluIHRo
ZSBnYW1lLiBGb3Igc29tZSByZWFzb24gSSBjb3VsZG4ndCBnZXQgCj4+PiB0byBtb3N0IGVtYWls
cyBmb3IgdGhpcyBkaXNjdXNzaW9uIChJIG9ubHkgc3Vic2NyaWJlZCB0byB0aGUgCj4+PiB2aXJ0
dWFsaXphdGlvbiBsaXN0KSwgd2hpbGUgSSB3YXMgdGFraW5nIG9mZiBhbW9uZ3N0IHRoZSBwYXN0
IGZldyAKPj4+IHdlZWtzLgo+Pj4KPj4+IEl0IGxvb2tzIHRvIG1lIHRoaXMgcGF0Y2ggaXMgaW5j
b21wbGV0ZS4gTm90ZWQgZG93biB0aGUgd2F5IGluIAo+Pj4gdmRwYV9kZXZfbmV0X2NvbmZpZ19m
aWxsKCksIHdlIGhhdmUgdGhlIGZvbGxvd2luZzoKPj4+ICAgICAgICAgIGZlYXR1cmVzID0gdmRl
di0+Y29uZmlnLT5nZXRfZHJpdmVyX2ZlYXR1cmVzKHZkZXYpOwo+Pj4gICAgICAgICAgaWYgKG5s
YV9wdXRfdTY0XzY0Yml0KG1zZywgVkRQQV9BVFRSX0RFVl9ORUdPVElBVEVEX0ZFQVRVUkVTLCBm
ZWF0dXJlcywKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWRFBBX0FUVFJfUEFE
KSkKPj4+ICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTVNHU0laRTsKPj4+Cj4+PiBNYWtpbmcg
Y2FsbCB0byAuZ2V0X2RyaXZlcl9mZWF0dXJlcygpIGRvZXNuJ3QgbWFrZSBzZW5zZSB3aGVuIAo+
Pj4gZmVhdHVyZSBuZWdvdGlhdGlvbiBpc24ndCBjb21wbGV0ZS4gTmVpdGhlciBzaG91bGQgcHJl
c2VudCAKPj4+IG5lZ290aWF0ZWRfZmVhdHVyZXMgdG8gdXNlcnNwYWNlIGJlZm9yZSBuZWdvdGlh
dGlvbiBpcyBkb25lLgo+Pj4KPj4+IFNpbWlsYXJseSwgbWF4X3ZxcCB0aHJvdWdoIHZkcGFfZGV2
X25ldF9tcV9jb25maWdfZmlsbCgpIHByb2JhYmx5IAo+Pj4gc2hvdWxkIG5vdCBzaG93IGJlZm9y
ZSBuZWdvdGlhdGlvbiBpcyBkb25lIC0gaXQgZGVwZW5kcyBvbiBkcml2ZXIgCj4+PiBmZWF0dXJl
cyBuZWdvdGlhdGVkLgo+PiBJIGhhdmUgYW5vdGhlciBwYXRjaCBpbiB0aGlzIHNlcmllcyBpbnRy
b2R1Y2VzIGRldmljZV9mZWF0dXJlcyBhbmQgCj4+IHdpbGwgcmVwb3J0IGRldmljZV9mZWF0dXJl
cyB0byB0aGUgdXNlcnNwYWNlIGV2ZW4gZmVhdHVyZXMgCj4+IG5lZ290aWF0aW9uIG5vdCBkb25l
LiBCZWNhdXNlIHRoZSBzcGVjIHNheXMgd2Ugc2hvdWxkIGFsbG93IGRyaXZlciAKPj4gYWNjZXNz
IHRoZSBjb25maWcgc3BhY2UgYmVmb3JlIEZFQVRVUkVTX09LLgo+IFRoZSBjb25maWcgc3BhY2Ug
Y2FuIGJlIGFjY2Vzc2VkIGJ5IGd1ZXN0IGJlZm9yZSBmZWF0dXJlc19vayBkb2Vzbid0IAo+IG5l
Y2Vzc2FyaWx5IG1lYW4gdGhlIHZhbHVlIGlzIHZhbGlkLiAKCgpJdCdzIHZhbGlkIGFzIGxvbmcg
YXMgdGhlIGRldmljZSBvZmZlcnMgdGhlIGZlYXR1cmU6CgoiVGhlIGRldmljZSBNVVNUIGFsbG93
IHJlYWRpbmcgb2YgYW55IGRldmljZS1zcGVjaWZpYyBjb25maWd1cmF0aW9uIApmaWVsZCBiZWZv
cmUgRkVBVFVSRVNfT0sgaXMgc2V0IGJ5IHRoZSBkcml2ZXIuIFRoaXMgaW5jbHVkZXMgZmllbGRz
IAp3aGljaCBhcmUgY29uZGl0aW9uYWwgb24gZmVhdHVyZSBiaXRzLCBhcyBsb25nIGFzIHRob3Nl
IGZlYXR1cmUgYml0cyBhcmUgCm9mZmVyZWQgYnkgdGhlIGRldmljZS4iCgoKPiBZb3UgbWF5IHdh
bnQgdG8gZG91YmxlIGNoZWNrIHdpdGggTWljaGFlbCBmb3Igd2hhdCBoZSBxdW90ZWQgZWFybGll
cjoKPj4gTm9wZToKPj4KPj4gMi41LjEgIERyaXZlciBSZXF1aXJlbWVudHM6IERldmljZSBDb25m
aWd1cmF0aW9uIFNwYWNlCj4+Cj4+IC4uLgo+Pgo+PiBGb3Igb3B0aW9uYWwgY29uZmlndXJhdGlv
biBzcGFjZSBmaWVsZHMsIHRoZSBkcml2ZXIgTVVTVCBjaGVjayB0aGF0IHRoZSBjb3JyZXNwb25k
aW5nIGZlYXR1cmUgaXMgb2ZmZXJlZAo+PiBiZWZvcmUgYWNjZXNzaW5nIHRoYXQgcGFydCBvZiB0
aGUgY29uZmlndXJhdGlvbiBzcGFjZS4KPgo+IGFuZCBob3cgbWFueSBkcml2ZXIgYnVncyB0YWtp
bmcgd3JvbmcgYXNzdW1wdGlvbiBvZiB0aGUgdmFsaWRpdHkgb2YgCj4gY29uZmlnIHNwYWNlIGZp
ZWxkIHdpdGhvdXQgZmVhdHVyZXNfb2suIEkgYW0gbm90IHN1cmUgd2hhdCB1c2UgY2FzZSAKPiB5
b3Ugd2FudCB0byBleHBvc2UgY29uZmlnIHJlc2lzdGVyIHZhbHVlcyBmb3IgYmVmb3JlIGZlYXR1
cmVzX29rLCBpZiAKPiBpdCdzIG1vc3RseSBmb3IgbGl2ZSBtaWdyYXRpb24gSSBndWVzcyBpdCdz
IHByb2JhYmx5IGhlYWRpbmcgYSB3cm9uZyAKPiBkaXJlY3Rpb24uCgoKSSBndWVzcyBpdCdzIG5v
dCBmb3IgbWlncmF0aW9uLiBGb3IgbWlncmF0aW9uLCBhIHByb3Zpc2lvbiB3aXRoIHRoZSAKY29y
cmVjdCBmZWF0dXJlcy9jYXBhYmlsaXR5IHdvdWxkIGJlIHN1ZmZpY2llbnQuCgpUaGFua3MKCgo+
Cj4KPj4+Cj4+Pgo+Pj4gTGFzdCBidXQgbm90IHRoZSBsZWFzdCwgdGhpcyAidmRwYSBkZXYgY29u
ZmlnIiBjb21tYW5kIHdhcyBub3QgCj4+PiBkZXNpZ25lZCB0byBkaXNwbGF5IHRoZSByZWFsIGNv
bmZpZyBzcGFjZSByZWdpc3RlciB2YWx1ZXMgaW4gdGhlIAo+Pj4gZmlyc3QgcGxhY2UuIFF1b3Rp
bmcgdGhlIHZkcGEtZGV2KDgpIG1hbiBwYWdlOgo+Pj4KPj4+PiB2ZHBhIGRldiBjb25maWcgc2hv
dyAtIFNob3cgY29uZmlndXJhdGlvbiBvZiBzcGVjaWZpYyBkZXZpY2Ugb3IgYWxsIAo+Pj4+IGRl
dmljZXMuCj4+Pj4gREVWIC0gc3BlY2lmaWVzIHRoZSB2ZHBhIGRldmljZSB0byBzaG93IGl0cyBj
b25maWd1cmF0aW9uLiBJZiB0aGlzIAo+Pj4+IGFyZ3VtZW50IGlzIG9taXR0ZWQgYWxsIGRldmlj
ZXMgY29uZmlndXJhdGlvbiBpcyBsaXN0ZWQuCj4+PiBJdCBkb2Vzbid0IHNheSBhbnl0aGluZyBh
Ym91dCBjb25maWd1cmF0aW9uIHNwYWNlIG9yIHJlZ2lzdGVyIHZhbHVlcyAKPj4+IGluIGNvbmZp
ZyBzcGFjZS4gQXMgbG9uZyBhcyBpdCBjYW4gY29udmV5IHRoZSBjb25maWcgYXR0cmlidXRlIHdo
ZW4gCj4+PiBpbnN0YW50aWF0aW5nIHZEUEEgZGV2aWNlIGluc3RhbmNlLCBhbmQgbW9yZSBpbXBv
cnRhbnRseSwgdGhlIGNvbmZpZyAKPj4+IGNhbiBiZSBlYXNpbHkgaW1wb3J0ZWQgZnJvbSBvciBl
eHBvcnRlZCB0byB1c2Vyc3BhY2UgdG9vbHMgd2hlbiAKPj4+IHRyeWluZyB0byByZWNvbnN0cnVj
dCB2ZHBhIGluc3RhbmNlIGludGFjdCBvbiBkZXN0aW5hdGlvbiBob3N0IGZvciAKPj4+IGxpdmUg
bWlncmF0aW9uLCBJTUhPIGluIG15IHBlcnNvbmFsIGludGVycHJldGF0aW9uIGl0IGRvZXNuJ3Qg
bWF0dGVyIAo+Pj4gd2hhdCB0aGUgY29uZmlnIHNwYWNlIG1heSBwcmVzZW50LiBJdCBtYXkgYmUg
d29ydGggd2hpbGUgYWRkaW5nIGEgCj4+PiBuZXcgZGVidWcgY29tbWFuZCB0byBleHBvc2UgdGhl
IHJlYWwgcmVnaXN0ZXIgdmFsdWUsIGJ1dCB0aGF0J3MgCj4+PiBhbm90aGVyIHN0b3J5Lgo+PiBJ
IGFtIG5vdCBzdXJlIGdldHRpbmcgeW91ciBwb2ludHMuIHZEUEEgbm93IHJlcG9ydHMgZGV2aWNl
IGZlYXR1cmUgCj4+IGJpdHMoZGV2aWNlX2ZlYXR1cmVzKSBhbmQgbmVnb3RpYXRlZCBmZWF0dXJl
IGJpdHMoZHJpdmVyX2ZlYXR1cmVzKSwgCj4+IGFuZCB5ZXMsIHRoZSBkcml2ZXJzIGZlYXR1cmVz
IGNhbiBiZSBhIHN1YnNldCBvZiB0aGUgZGV2aWNlIGZlYXR1cmVzOyAKPj4gYW5kIHRoZSB2RFBB
IGRldmljZSBmZWF0dXJlcyBjYW4gYmUgYSBzdWJzZXQgb2YgdGhlIG1hbmFnZW1lbnQgZGV2aWNl
IAo+PiBmZWF0dXJlcy4KPiBXaGF0IEkgc2FpZCBpcyBhZnRlciB1bmJsb2NraW5nIHRoZSBjb25k
aXRpb25hbCBjaGVjaywgeW91J2QgaGF2ZSB0byAKPiBoYW5kbGUgdGhlIGNhc2UgZm9yIGVhY2gg
b2YgdGhlIHZkcGEgYXR0cmlidXRlIHdoZW4gZmVhdHVyZSAKPiBuZWdvdGlhdGlvbiBpcyBub3Qg
eWV0IGRvbmU6IGJhc2ljYWxseSB0aGUgcmVnaXN0ZXIgdmFsdWVzIHlvdSBnb3QgCj4gZnJvbSBj
b25maWcgc3BhY2UgdmlhIHRoZSB2ZHBhX2dldF9jb25maWdfdW5sb2NrZWQoKSBjYWxsIGlzIG5v
dCAKPiBjb25zaWRlcmVkIHRvIGJlIHZhbGlkIGJlZm9yZSBmZWF0dXJlc19vayAocGVyLXNwZWMp
LiBBbHRob3VnaCBpbiBzb21lIAo+IGNhc2UgeW91IG1heSBnZXQgc2FuZSB2YWx1ZSwgc3VjaCBi
ZWhhdmlvciBpcyBnZW5lcmFsbHkgdW5kZWZpbmVkLiBJZiAKPiB5b3UgZGVzaXJlIHRvIHNob3cg
anVzdCB0aGUgZGV2aWNlX2ZlYXR1cmVzIGFsb25lIHdpdGhvdXQgYW55IGNvbmZpZyAKPiBzcGFj
ZSBmaWVsZCwgd2hpY2ggdGhlIGRldmljZSBoYWQgYWR2ZXJ0aXNlZCAqYmVmb3JlIGZlYXR1cmUg
Cj4gbmVnb3RpYXRpb24gaXMgY29tcGxldGUqLCB0aGF0J2xsIGJlIGZpbmUuIEJ1dCBsb29rcyB0
byBtZSB0aGlzIGlzIG5vdCAKPiBob3cgcGF0Y2ggaGFzIGJlZW4gaW1wbGVtZW50ZWQuIFByb2Jh
Ymx5IG5lZWQgc29tZSBtb3JlIHdvcms/Cj4KPiBSZWdhcmRzLAo+IC1TaXdlaQo+Cj4+Pgo+Pj4g
SGF2aW5nIHNhaWQsIHBsZWFzZSBjb25zaWRlciB0byBkcm9wIHRoZSBGaXhlcyB0YWcsIGFzIGFw
cGVhcnMgdG8gbWUgCj4+PiB5b3UncmUgcHJvcG9zaW5nIGEgbmV3IGZlYXR1cmUgcmF0aGVyIHRo
YW4gZml4aW5nIGEgcmVhbCBpc3N1ZS4KPj4gaXQncyBhIG5ldyBmZWF0dXJlIHRvIHJlcG9ydCB0
aGUgZGV2aWNlIGZlYXR1cmUgYml0cyB0aGFuIG9ubHkgCj4+IG5lZ290aWF0ZWQgZmVhdHVyZXMs
IGhvd2V2ZXIgdGhpcyBwYXRjaCBpcyBhIG11c3QsIG9yIGl0IHdpbGwgYmxvY2sgCj4+IHRoZSBk
ZXZpY2UgZmVhdHVyZSBiaXRzIHJlcG9ydGluZy4gYnV0IEkgYWdyZWUsIHRoZSBmaXggdGFnIGlz
IG5vdCBhIAo+PiBtdXN0Lgo+Pj4KPj4+IFRoYW5rcywKPj4+IC1TaXdlaQo+Pj4KPj4+IE9uIDcv
MS8yMDIyIDM6MTIgUE0sIFBhcmF2IFBhbmRpdCB2aWEgVmlydHVhbGl6YXRpb24gd3JvdGU6Cj4+
Pj4+IEZyb206IFpodSBMaW5nc2hhbjxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+Pj4+PiBTZW50
OiBGcmlkYXksIEp1bHkgMSwgMjAyMiA5OjI4IEFNCj4+Pj4+Cj4+Pj4+IFVzZXJzIG1heSB3YW50
IHRvIHF1ZXJ5IHRoZSBjb25maWcgc3BhY2Ugb2YgYSB2RFBBIGRldmljZSwgdG8gY2hvb3NlIGEK
Pj4+Pj4gYXBwcm9wcmlhdGUgb25lIGZvciBhIGNlcnRhaW4gZ3Vlc3QuIFRoaXMgbWVhbnMgdGhl
IHVzZXJzIG5lZWQgdG8gcmVhZCB0aGUKPj4+Pj4gY29uZmlnIHNwYWNlIGJlZm9yZSBGRUFUVVJF
U19PSywgYW5kIHRoZSBleGlzdGVuY2Ugb2YgY29uZmlnIHNwYWNlCj4+Pj4+IGNvbnRlbnRzIGRv
ZXMgbm90IGRlcGVuZCBvbiBGRUFUVVJFU19PSy4KPj4+Pj4KPj4+Pj4gVGhlIHNwZWMgc2F5czoK
Pj4+Pj4gVGhlIGRldmljZSBNVVNUIGFsbG93IHJlYWRpbmcgb2YgYW55IGRldmljZS1zcGVjaWZp
YyBjb25maWd1cmF0aW9uIGZpZWxkCj4+Pj4+IGJlZm9yZSBGRUFUVVJFU19PSyBpcyBzZXQgYnkg
dGhlIGRyaXZlci4gVGhpcyBpbmNsdWRlcyBmaWVsZHMgd2hpY2ggYXJlCj4+Pj4+IGNvbmRpdGlv
bmFsIG9uIGZlYXR1cmUgYml0cywgYXMgbG9uZyBhcyB0aG9zZSBmZWF0dXJlIGJpdHMgYXJlIG9m
ZmVyZWQgYnkgdGhlCj4+Pj4+IGRldmljZS4KPj4+Pj4KPj4+Pj4gRml4ZXM6IDMwZWY3YThhYzhh
MDcgKHZkcGE6IFJlYWQgZGV2aWNlIGNvbmZpZ3VyYXRpb24gb25seSBpZiBGRUFUVVJFU19PSykK
Pj4+PiBGaXggaXMgZmluZSwgYnV0IGZpeGVzIHRhZyBuZWVkcyBjb3JyZWN0aW9uIGRlc2NyaWJl
ZCBiZWxvdy4KPj4+Pgo+Pj4+IEFib3ZlIGNvbW1pdCBpZCBpcyAxMyBsZXR0ZXJzIHNob3VsZCBi
ZSAxMi4KPj4+PiBBbmQKPj4+PiBJdCBzaG91bGQgYmUgaW4gZm9ybWF0Cj4+Pj4gRml4ZXM6IDMw
ZWY3YThhYzhhMCAoInZkcGE6IFJlYWQgZGV2aWNlIGNvbmZpZ3VyYXRpb24gb25seSBpZiBGRUFU
VVJFU19PSyIpCj4+Pj4KPj4+PiBQbGVhc2UgdXNlIGNoZWNrcGF0Y2gucGwgc2NyaXB0IGJlZm9y
ZSBwb3N0aW5nIHRoZSBwYXRjaGVzIHRvIGNhdGNoIHRoZXNlIGVycm9ycy4KPj4+PiBUaGVyZSBp
cyBhIGJvdCB0aGF0IGxvb2tzIGF0IHRoZSBmaXhlcyB0YWcgYW5kIGlkZW50aWZpZXMgdGhlIHJp
Z2h0IGtlcm5lbCB2ZXJzaW9uIHRvIGFwcGx5IHRoaXMgZml4Lgo+Pj4+Cj4+Pj4+IFNpZ25lZC1v
ZmYtYnk6IFpodSBMaW5nc2hhbjxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+Pj4+PiAtLS0KPj4+
Pj4gICBkcml2ZXJzL3ZkcGEvdmRwYS5jIHwgOCAtLS0tLS0tLQo+Pj4+PiAgIDEgZmlsZSBjaGFu
Z2VkLCA4IGRlbGV0aW9ucygtKQo+Pj4+Pgo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBh
L3ZkcGEuYyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMgaW5kZXgKPj4+Pj4gOWIwZTM5YjJmMDIyLi5k
NzZiMjJiMmY3YWUgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4+Pj4g
KysrIGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+Pj4+PiBAQCAtODUxLDE3ICs4NTEsOSBAQCB2ZHBh
X2Rldl9jb25maWdfZmlsbChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsCj4+Pj4+IHN0cnVjdCBz
a19idWZmICptc2csIHUzMiBwb3J0aWQsICB7Cj4+Pj4+ICAgCXUzMiBkZXZpY2VfaWQ7Cj4+Pj4+
ICAgCXZvaWQgKmhkcjsKPj4+Pj4gLQl1OCBzdGF0dXM7Cj4+Pj4+ICAgCWludCBlcnI7Cj4+Pj4+
Cj4+Pj4+ICAgCWRvd25fcmVhZCgmdmRldi0+Y2ZfbG9jayk7Cj4+Pj4+IC0Jc3RhdHVzID0gdmRl
di0+Y29uZmlnLT5nZXRfc3RhdHVzKHZkZXYpOwo+Pj4+PiAtCWlmICghKHN0YXR1cyAmIFZJUlRJ
T19DT05GSUdfU19GRUFUVVJFU19PSykpIHsKPj4+Pj4gLQkJTkxfU0VUX0VSUl9NU0dfTU9EKGV4
dGFjaywgIkZlYXR1cmVzIG5lZ290aWF0aW9uIG5vdAo+Pj4+PiBjb21wbGV0ZWQiKTsKPj4+Pj4g
LQkJZXJyID0gLUVBR0FJTjsKPj4+Pj4gLQkJZ290byBvdXQ7Cj4+Pj4+IC0JfQo+Pj4+PiAtCj4+
Pj4+ICAgCWhkciA9IGdlbmxtc2dfcHV0KG1zZywgcG9ydGlkLCBzZXEsICZ2ZHBhX25sX2ZhbWls
eSwgZmxhZ3MsCj4+Pj4+ICAgCQkJICBWRFBBX0NNRF9ERVZfQ09ORklHX0dFVCk7Cj4+Pj4+ICAg
CWlmICghaGRyKSB7Cj4+Pj4+IC0tCj4+Pj4+IDIuMzEuMQo+Pj4+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+Pj4gVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0Cj4+Pj4gVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPj4+
PiBodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbgo+Pj4KPj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
