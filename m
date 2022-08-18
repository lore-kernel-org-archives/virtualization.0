Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E31C00140
	for <virtualization@archiver.kernel.org>; Thu, 18 Aug 2022 04:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9C61140184;
	Thu, 18 Aug 2022 04:19:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9C61140184
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ENfJ9qQW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hYGArLqEDG-5; Thu, 18 Aug 2022 04:19:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E89424061F;
	Thu, 18 Aug 2022 04:19:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E89424061F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF9AEC0032;
	Thu, 18 Aug 2022 04:19:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A169C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 04:18:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4AB7F4061F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 04:18:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4AB7F4061F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZorbYBrkFrRf
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 04:18:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD1E440184
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD1E440184
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 04:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660796336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uYWlkkzE7xxMeYBh4itiv4iOWQQiRrOeuKQlAfKIHV0=;
 b=ENfJ9qQWA0JFTkb24jEopFv4utjBV/AQMyndtH1gG+5nvgLOb6QawC2iqgbsd9g1YyYJtj
 1JCTH3JnAz6KgVCFnaWOE4X5S40x+UI5CamHgQm5rPrUO63pFDkMyOtCMGTXUF0wE9xMbi
 QCoYZ9SvXVF2fxhHONZvA4XCRapgWHw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-157-knrrl5hPMSuE2NqCeluKRg-1; Thu, 18 Aug 2022 00:18:55 -0400
X-MC-Unique: knrrl5hPMSuE2NqCeluKRg-1
Received: by mail-pl1-f197.google.com with SMTP id
 p18-20020a170902a41200b00172b0dc71e0so442293plq.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 21:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=uYWlkkzE7xxMeYBh4itiv4iOWQQiRrOeuKQlAfKIHV0=;
 b=cbGq98PaNz5lm0bx2k0XBSDN2ibIdR2Rpi6xVdNXJ4CRG5FGl3MepaZ5+6sBFi/ICH
 9/B+O9NZhM1WvXEKmWcbIAX8esI2OgFxGFZbMcfdsCaAISqgw0wWtBG7rWizCtgO4KxJ
 tDNQ/CBLJUicnduSkyahj4flJbGhrjNhxEysThHGjlIhTfzzXnwRGwtwl40m/V4ApO8J
 prOaGf67a31xgB6y7dIjHTeNlOkxqOE0TBNIVjvrhUTYYcNopDrmiu7bqwKrr6CAlLrp
 wBKoObko5TYK3SOj8386faU4RhrirmJfqBppcSc0yXLoqTL+uFtrODORQ6Xfg2mHUaOV
 sg/g==
X-Gm-Message-State: ACgBeo36eANmbK0G+Qyn7e7gH4Mb+7eIwbEoZgT0wyz6t4GEr/mEcHjE
 7tPOp3ZrhMCnKvh4dW1ym+wIolpqCodaaK83fbO8m5xqg4mnxXpgF2ryfsLmo9bvCB/hW1oJKFl
 ATi9deSDQcKM4kEjG1v1OR+yaJFO6nBo0EhC/kBux1Q==
X-Received: by 2002:a65:6e49:0:b0:429:cae6:aac6 with SMTP id
 be9-20020a656e49000000b00429cae6aac6mr1107529pgb.268.1660796334396; 
 Wed, 17 Aug 2022 21:18:54 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7utG6cFgFfhElFJDW75wYZfFPKrrZXbuG793cuXP6Cp63b+DOuExLDT7LDHhIbNR2mtvrGQA==
X-Received: by 2002:a65:6e49:0:b0:429:cae6:aac6 with SMTP id
 be9-20020a656e49000000b00429cae6aac6mr1107511pgb.268.1660796334091; 
 Wed, 17 Aug 2022 21:18:54 -0700 (PDT)
Received: from [10.72.13.223] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 bn20-20020a056a02031400b00419ab8f8d2csm322046pgb.20.2022.08.17.21.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Aug 2022 21:18:53 -0700 (PDT)
Message-ID: <df2bab2d-2bc1-c3c2-f87c-dcc6bdc5737d@redhat.com>
Date: Thu, 18 Aug 2022 12:18:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] vDPA: conditionally read fields in virtio-net dev
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
References: <20220815092638.504528-1-lingshan.zhu@intel.com>
 <20220815092638.504528-3-lingshan.zhu@intel.com>
 <PH0PR12MB54815EF8C19F70072169FA56DC6B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4184a943-f1c0-a57b-6411-bdd21e0bc710@intel.com>
 <PH0PR12MB5481EBA9E08963DEF0743063DC6B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220816170753-mutt-send-email-mst@kernel.org>
 <352e9533-8ab1-cec0-0141-ce0735ee39f5@intel.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <352e9533-8ab1-cec0-0141-ce0735ee39f5@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

CuWcqCAyMDIyLzgvMTcgMTA6MDMsIFpodSwgTGluZ3NoYW4g5YaZ6YGTOgo+Cj4KPiBPbiA4LzE3
LzIwMjIgNTowOSBBTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+PiBPbiBUdWUsIEF1ZyAx
NiwgMjAyMiBhdCAwOTowMjoxN1BNICswMDAwLCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4+Pj4gRnJv
bTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPj4+PiBTZW50OiBUdWVz
ZGF5LCBBdWd1c3QgMTYsIDIwMjIgMTI6MTkgQU0KPj4+Pgo+Pj4+Cj4+Pj4gT24gOC8xNi8yMDIy
IDEwOjMyIEFNLCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4+Pj4+PiBGcm9tOiBaaHUgTGluZ3NoYW4g
PGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4+Pj4+PiBTZW50OiBNb25kYXksIEF1Z3VzdCAxNSwg
MjAyMiA1OjI3IEFNCj4+Pj4+Pgo+Pj4+Pj4gU29tZSBmaWVsZHMgb2YgdmlydGlvLW5ldCBkZXZp
Y2UgY29uZmlnIHNwYWNlIGFyZSBjb25kaXRpb25hbCBvbiB0aGUKPj4+Pj4+IGZlYXR1cmUgYml0
cywgdGhlIHNwZWMgc2F5czoKPj4+Pj4+Cj4+Pj4+PiAiVGhlIG1hYyBhZGRyZXNzIGZpZWxkIGFs
d2F5cyBleGlzdHMKPj4+Pj4+ICh0aG91Z2ggaXMgb25seSB2YWxpZCBpZiBWSVJUSU9fTkVUX0Zf
TUFDIGlzIHNldCkiCj4+Pj4+Pgo+Pj4+Pj4gIm1heF92aXJ0cXVldWVfcGFpcnMgb25seSBleGlz
dHMgaWYgVklSVElPX05FVF9GX01RIG9yCj4+Pj4+PiBWSVJUSU9fTkVUX0ZfUlNTIGlzIHNldCIK
Pj4+Pj4+Cj4+Pj4+PiAibXR1IG9ubHkgZXhpc3RzIGlmIFZJUlRJT19ORVRfRl9NVFUgaXMgc2V0
Igo+Pj4+Pj4KPj4+Pj4+IHNvIHdlIHNob3VsZCByZWFkIE1UVSwgTUFDIGFuZCBNUSBpbiB0aGUg
ZGV2aWNlIGNvbmZpZyBzcGFjZSBvbmx5Cj4+Pj4+PiB3aGVuIHRoZXNlIGZlYXR1cmUgYml0cyBh
cmUgb2ZmZXJlZC4KPj4+Pj4gWWVzLgo+Pj4+Pgo+Pj4+Pj4gRm9yIE1RLCBpZiBib3RoIFZJUlRJ
T19ORVRfRl9NUSBhbmQgVklSVElPX05FVF9GX1JTUyBhcmUgbm90IHNldCwKPj4+PiB0aGUKPj4+
Pj4+IHZpcnRpbyBkZXZpY2Ugc2hvdWxkIGhhdmUgb25lIHF1ZXVlIHBhaXIgYXMgZGVmYXVsdCB2
YWx1ZSwgc28gd2hlbgo+Pj4+Pj4gdXNlcnNwYWNlIHF1ZXJ5aW5nIHF1ZXVlIHBhaXIgbnVtYmVy
cywgaXQgc2hvdWxkIHJldHVybiBtcT0xIHRoYW4gCj4+Pj4+PiB6ZXJvLgo+Pj4+PiBOby4KPj4+
Pj4gTm8gbmVlZCB0byB0cmVhdCBtYWMgYW5kIG1heF9xcHMgZGlmZmVyZW50bHkuCj4+Pj4+IEl0
IGlzIG1lYW5pbmdsZXNzIHRvIGRpZmZlcmVudGlhdGUgd2hlbiBmaWVsZCBleGlzdC9ub3QtZXhp
c3RzIHZzIAo+Pj4+PiB2YWx1ZQo+Pj4+IHZhbGlkL25vdCB2YWxpZC4KPj4+PiBhcyB3ZSBkaXNj
dXNzZWQgYmVmb3JlLCBNUSBoYXMgYSBkZWZhdWx0IHZhbHVlIDEsIHRvIGJlIGEgCj4+Pj4gZnVu
Y3Rpb25hbCB2aXJ0aW8tCj4+Pj4gbmV0IGRldmljZSwgd2hpbGUgTUFDIGhhcyBubyBkZWZhdWx0
IHZhbHVlLCBpZiBubyBWSVJUSU9fTkVUX0ZfTUFDIAo+Pj4+IHNldCwKPj4+PiB0aGUgZHJpdmVy
IHNob3VsZCBnZW5lcmF0ZSBhIHJhbmRvbSBNQUMuCj4+Pj4+PiBGb3IgTVRVLCBpZiBWSVJUSU9f
TkVUX0ZfTVRVIGlzIG5vdCBzZXQsIHdlIHNob3VsZCBub3QgcmVhZCBNVFUgZnJvbQo+Pj4+Pj4g
dGhlIGRldmljZSBjb25maWcgc2FwY2UuCj4+Pj4+PiBSRkM4OTQgPEEgU3RhbmRhcmQgZm9yIHRo
ZSBUcmFuc21pc3Npb24gb2YgSVAgRGF0YWdyYW1zIG92ZXIgCj4+Pj4+PiBFdGhlcm5ldAo+Pj4+
Pj4gTmV0d29ya3M+IHNheXM6IlRoZSBtaW5pbXVtIGxlbmd0aCBvZiB0aGUgZGF0YSBmaWVsZCBv
ZiBhIHBhY2tldCAKPj4+Pj4+IHNlbnQKPj4+Pj4+IE5ldHdvcmtzPiBvdmVyCj4+Pj4+PiBhbiBF
dGhlcm5ldCBpcyAxNTAwIG9jdGV0cywgdGh1cyB0aGUgbWF4aW11bSBsZW5ndGggb2YgYW4gSVAg
Cj4+Pj4+PiBkYXRhZ3JhbQo+Pj4+Pj4gc2VudCBvdmVyIGFuIEV0aGVybmV0IGlzIDE1MDAgb2N0
ZXRzLsKgIEltcGxlbWVudGF0aW9ucyBhcmUgCj4+Pj4+PiBlbmNvdXJhZ2VkCj4+Pj4+PiB0byBz
dXBwb3J0IGZ1bGwtbGVuZ3RoIHBhY2tldHMiCj4+Pj4+IFRoaXMgbGluZSBpbiB0aGUgUkZDIDg5
NCBvZiAxOTg0IGlzIHdyb25nLgo+Pj4+PiBFcnJhdGEgYWxyZWFkeSBleGlzdHMgZm9yIGl0IGF0
IFsxXS4KPj4+Pj4KPj4+Pj4gWzFdIGh0dHBzOi8vd3d3LnJmYy1lZGl0b3Iub3JnL2VycmF0YV9z
ZWFyY2gucGhwP3JmYz04OTQmcmVjX3N0YXR1cz0wCj4+Pj4gT0ssIHNvIEkgdGhpbmsgd2Ugc2hv
dWxkIHJldHVybiBub3RoaW5nIGlmIF9GX01UVSBub3Qgc2V0LCBsaWtlIAo+Pj4+IGhhbmRsaW5n
IHRoZQo+Pj4+IE1BQwo+Pj4+Pj4gdmlydGlvIHNwZWMgc2F5czoiVGhlIHZpcnRpbyBuZXR3b3Jr
IGRldmljZSBpcyBhIHZpcnR1YWwgZXRoZXJuZXQKPj4+Pj4+IGNhcmQiLCBzbyB0aGUgZGVmYXVs
dCBNVFUgdmFsdWUgc2hvdWxkIGJlIDE1MDAgZm9yIHZpcnRpby1uZXQuCj4+Pj4+Pgo+Pj4+PiBQ
cmFjdGljYWxseSBJIGhhdmUgc2VlbiAxNTAwIGFuZCBoaWdoZSBtdHUuCj4+Pj4+IEFuZCB0aGlz
IGRlcml2YXRpb24gaXMgbm90IGdvb2Qgb2Ygd2hhdCBzaG91bGQgYmUgdGhlIGRlZmF1bHQgbXR1
IAo+Pj4+PiBhcyBhYm92ZQo+Pj4+IGVycmF0YSBleGlzdHMuCj4+Pj4+IEFuZCBJIHNlZSB0aGUg
Y29kZSBiZWxvdyB3aHkgeW91IG5lZWQgdG8gd29yayBzbyBoYXJkIHRvIGRlZmluZSBhIAo+Pj4+
PiBkZWZhdWx0Cj4+Pj4gdmFsdWUgc28gdGhhdCBfTVEgYW5kIF9NVFUgY2FuIHJlcG9ydCBkZWZh
dWx0IHZhbHVlcy4KPj4+Pj4gVGhlcmUgaXMgcmVhbGx5IG5vIG5lZWQgZm9yIHRoaXMgY29tcGxl
eGl0eSBhbmQgc3VjaCBhIGxvbmcgY29tbWl0Cj4+Pj4gbWVzc2FnZS4KPj4+Pj4gQ2FuIHdlIHBs
ZWFzZSBleHBvc2UgZmVhdHVyZSBiaXRzIGFzLWlzIGFuZCByZXBvcnQgY29uZmlnIHNwYWNlIAo+
Pj4+PiBmaWVsZCB3aGljaAo+Pj4+IGFyZSB2YWxpZD8KPj4+Pj4gVXNlciBzcGFjZSB3aWxsIGJl
IHF1ZXJ5aW5nIGJvdGguCj4+Pj4gSSB0aGluayBNQUMgYW5kIE1UVSBkb24ndCBoYXZlIGRlZmF1
bHQgdmFsdWVzLCBzbyByZXR1cm4gbm90aGluZyBpZiAKPj4+PiB0aGUKPj4+PiBmZWF0dXJlIGJp
dHMgbm90IHNldCwKPj4+PiBmb3IgTVEsIGl0IGlzIHN0aWxsIG1heF92cV9wYXJpcyA9PSAxIGJ5
IGRlZmF1bHQuCj4+PiBJIGhhdmUgc3RyZXNzZWQgZW5vdWdoIHRvIGhpZ2hsaWdodCB0aGUgZmFj
dCB0aGF0IHdlIGRvbuKAmXQgd2FudCB0byAKPj4+IHN0YXJ0IGRpZ2dpbmcgZGVmYXVsdC9ubyBk
ZWZhdWx0LCB2YWxpZC9uby12YWxpZCBwYXJ0IG9mIHRoZSBzcGVjLgo+Pj4gSSBwcmVmZXIga2Vy
bmVsIHRvIHJlcG9ydGluZyBmaWVsZHMgdGhhdCBfZXhpc3RzXyBpbiB0aGUgY29uZmlnIAo+Pj4g
c3BhY2UgYW5kIGFyZSB2YWxpZC4KPj4+IEkgd2lsbCBsZXQgTVNUIHRvIGhhbmRsZSB0aGUgbWFp
bnRlbmFuY2UgbmlnaHRtYXJlIHRoYXQgdGhpcyBraW5kIG9mIAo+Pj4gcGF0Y2ggYnJpbmdzIGlu
IHdpdGhvdXQgYW55IHZpc2libGUgZ2FpbiB0byB1c2VyIHNwYWNlL29yY2hlc3RyYXRpb24gCj4+
PiBhcHBzLgo+Pj4KPj4+IEEgbG9naWMgdGhhdCBjYW4gYmUgZWFzaWx5IGJ1aWxkIGluIHVzZXIg
c3BhY2UsIHNob3VsZCBiZSB3cml0dGVuIGluIAo+Pj4gdXNlciBzcGFjZS4KPj4+IEkgY29uY2x1
ZGUgbXkgdGhvdWdodHMgaGVyZSBmb3IgdGhpcyBkaXNjdXNzaW9uLgo+Pj4KPj4+IEkgd2lsbCBs
ZXQgTVNUIHRvIGRlY2lkZSBob3cgaGUgcHJlZmVycyB0byBwcm9jZWVkLgo+Pj4KPj4+Pj4+ICvC
oMKgwqAgaWYgKChmZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX05FVF9GX01UVSkpID09IDApCj4+
Pj4+PiArwqDCoMKgwqDCoMKgwqAgdmFsX3UxNiA9IDE1MDA7Cj4+Pj4+PiArwqDCoMKgIGVsc2UK
Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB2YWxfdTE2ID0gX192aXJ0aW8xNl90b19jcHUodHJ1ZSwg
Y29uZmlnLT5tdHUpOwo+Pj4+Pj4gKwo+Pj4+PiBOZWVkIHRvIHdvcmsgaGFyZCB0byBmaW5kIGRl
ZmF1bHQgdmFsdWVzIGFuZCB0aGF0IHRvbyB0dXJuZWQgb3V0IGhhZAo+Pj4+IGVycmF0YS4KPj4+
Pj4gVGhlcmUgYXJlIG1vcmUgZmllbGRzIHRoYXQgZG9lc27igJl0IGhhdmUgZGVmYXVsdCB2YWx1
ZXMuCj4+Pj4+Cj4+Pj4+IFRoZXJlIGlzIG5vIHBvaW50IGluIGtlcm5lbCBkb2luZyB0aGlzIGd1
ZXNzIHdvcmssIHRoYXQgdXNlciBzcGFjZSAKPj4+Pj4gY2FuIGZpZ3VyZQo+Pj4+IG91dCBvZiB3
aGF0IGlzIHZhbGlkL2ludmFsaWQuCj4+Pj4gSXQncyBub3QgZ3Vlc3Qgd29yaywgd2hlbiBndWVz
dCBmaW5kcyBubyBmZWF0dXJlIGJpdHMgc2V0LCBpdCBjYW4gCj4+Pj4gZGVjaWRlIHdoYXQKPj4+
PiB0byBkby4KPj4+IEFib3ZlIGNvZGUgb2YgZG9pbmcgMTUwMCB3YXMgcHJvYmFibHkgYW4gaG9u
ZXN0IGF0dGVtcHQgdG8gZmluZCBhIAo+Pj4gbGVnaXRpbWF0ZSBkZWZhdWx0IHZhbHVlLCBhbmQg
d2Ugc2F3IHRoYXQgaXQgZG9lc27igJl0IHdvcmsuCj4+PiBUaGlzIGlzIHNlY29uZCBleGFtcGxl
IGFmdGVyIF9NUSB0aGF0IHdlIGJvdGggYWdyZWUgc2hvdWxkIG5vdCAKPj4+IHJldHVybiBkZWZh
dWx0Lgo+Pj4KPj4+IEFuZCB0aGVyZSBhcmUgbW9yZSBmaWVsZHMgY29taW5nIGluIHRoaXMgYXJl
YS4KPj4+IEhlbmNlLCBJIHByZWZlciB0byBub3QgYXZvaWQgcmV0dXJuaW5nIHN1Y2ggZGVmYXVs
dHMgZm9yIE1BQywgTVRVLCAKPj4+IE1RIGFuZCByZXN0IGFsbCBmaWVsZHMgd2hpY2ggZG9lc27i
gJl0IF9leGlzdHNfLgo+Pj4KPj4+IEkgd2lsbCBsZXQgTVNUIHRvIGRlY2lkZSBob3cgaGUgcHJl
ZmVycyB0byBwcm9jZWVkIGZvciBldmVyeSBmaWVsZCAKPj4+IHRvIGNvbWUgbmV4dC4KPj4+IFRo
YW5rcy4KPj4+Cj4+Cj4+IElmIE1UVSBkb2VzIG5vdCByZXR1cm4gYSB2YWx1ZSB3aXRob3V0IF9G
X01UVSwgYW5kIE1BQyBkb2VzIG5vdCByZXR1cm4KPj4gYSB2YWx1ZSB3aXRob3V0IF9GX01BQyB0
aGVuIElNTyB5ZXMsIG51bWJlciBvZiBxdWV1ZXMgc2hvdWxkIG5vdCByZXR1cm4KPj4gYSB2YWx1
ZSB3aXRob3V0IF9GX01RLgo+IHN1cmUgSSBjYW4gZG8gdGhpcywgYnV0IG1heSBJIGFzayB3aGV0
aGVyIGl0IGlzIGEgZmluYWwgZGVjaXNpb24sIEkgCj4gcmVtZW1iZXIgeW91IHN1cHBvcnRlZCBt
YXhfcXVldWVfcGFyaXMgPSAxIHdpdGhvdXQgX0ZfTVEgYmVmb3JlCgoKSSB0aGluayB3ZSBqdXN0
IG5lZWQgdG8gYmUgY29uc2lzdGVudDoKCkVpdGhlcgoKMSkgbWFrZSBmaWVsZCBjb25kaXRpb25h
bCB0byBhbGlnbiB3aXRoIHNwZWMKCm9yCgoyKSBhbHdheXMgcmV0dXJuIGEgdmFsdWUgZXZlbiBp
ZiB0aGUgZmVhdHVyZSBpcyBub3Qgc2V0CgpJdCBzZWVtcyB0byBtZSAxKSBpcyBlYXNpZXIuCgpU
aGFua3MKCgo+Cj4gVGhhbmtzCj4+Cj4+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
