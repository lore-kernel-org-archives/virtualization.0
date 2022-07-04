Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0102CC43334
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 04:47:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 87E1640165;
	Mon,  4 Jul 2022 04:47:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 87E1640165
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CxKOLk7+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vuIEYpFm19hU; Mon,  4 Jul 2022 04:47:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E528540114;
	Mon,  4 Jul 2022 04:46:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E528540114
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC375C0032;
	Mon,  4 Jul 2022 04:46:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2A6DC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 04:46:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8AED3409B1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 04:46:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8AED3409B1
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CxKOLk7+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ehKSWporbxjw
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 04:46:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 57BCB409AD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 57BCB409AD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 04:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656910016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eVLTlK2cLdRIb6wwURVfoHDHENc0Sq+A4u8ZtgUepwk=;
 b=CxKOLk7+VybXy5T/KA1iAB+82MQqxY6zwuO5/qVw01D+IMpK7MpRy+nghZYpS+iF6GJAaO
 6mEOP9AyGXTspk0Nq7X+iDCKEFlQ6Qm4NQETTaCn9zq3bHW4uv5QeRQykcxRABakCP5ZDu
 B80L44pXVTxyFqfc1FQY9DaqqwE1WAU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-e5mlDqhrOB-_ojB3x5hk5Q-1; Mon, 04 Jul 2022 00:46:47 -0400
X-MC-Unique: e5mlDqhrOB-_ojB3x5hk5Q-1
Received: by mail-pj1-f72.google.com with SMTP id
 i15-20020a17090a2a0f00b001ef826b921dso1770794pjd.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 03 Jul 2022 21:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=eVLTlK2cLdRIb6wwURVfoHDHENc0Sq+A4u8ZtgUepwk=;
 b=ft8dX4ZRjL/xcdjl6EeTdq3stG/WsnNn9rQvGG8qZzUBfrTzbVci8t/mPz57CVDpwt
 TJ8f3b19dTdmu3EeQFyI/RJa0SO/lvFzpMlz8hwVFuMUvj61Q/C210wTE4EpB0XFbz6n
 HxU3JMJH3QDles0TblOCkeoxRF+HI+Hc0IRwUyXbe+QsW7nmnd20Kj4w0D5y/458DVPp
 PnV4g4pkbN9DYSLM7z4JCncvJWltBkpZgoIAdSPIF7M0mMePUrJgOAbzVipq0xbhBH8F
 A0cxStw5Cw4QBuPyJnkhxuppV3xC+ZJgoDMGzPgLHRWeW8SHpGU0kY5VYiwgW/W8UoxL
 V2IQ==
X-Gm-Message-State: AJIora9imcMYOu0UMxfFznrFaFqjq6XZqGf4N7gpo6hNnJ4/5WUKgdov
 VR8ikhtX4L7pDZ4DyFvt3ldOccyl0nSuvuO0ssWi3YWrixEwHMCo6lFIhB/ataycK/YPWPIU9ZS
 Hie9NQI82fQbSONtBlDsqONJx1ke9FHB3fjiogI1F/A==
X-Received: by 2002:a17:90a:408f:b0:1e3:23a:2370 with SMTP id
 l15-20020a17090a408f00b001e3023a2370mr32620807pjg.84.1656910006577; 
 Sun, 03 Jul 2022 21:46:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v6hfJy7wsXAEMzEbQxIUAgQMSBvJ5aR8WrcJqPjNTC/a9X/urokyGR00sXwPo5/IcLXxDHNg==
X-Received: by 2002:a17:90a:408f:b0:1e3:23a:2370 with SMTP id
 l15-20020a17090a408f00b001e3023a2370mr32620777pjg.84.1656910006218; 
 Sun, 03 Jul 2022 21:46:46 -0700 (PDT)
Received: from [10.72.13.251] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 g194-20020a6252cb000000b00527d84df6a6sm10937482pfb.208.2022.07.03.21.46.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Jul 2022 21:46:45 -0700 (PDT)
Message-ID: <e8479441-78d2-8b39-c5ad-6729b79a2f35@redhat.com>
Date: Mon, 4 Jul 2022 12:46:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH V3 3/6] vDPA: allow userspace to query features of a vDPA
 device
To: Parav Pandit <parav@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 "mst@redhat.com" <mst@redhat.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-4-lingshan.zhu@intel.com>
 <PH0PR12MB5481AEB53864F35A79AAD7F5DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <PH0PR12MB5481AEB53864F35A79AAD7F5DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
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

CuWcqCAyMDIyLzcvMiAwNjowMiwgUGFyYXYgUGFuZGl0IOWGmemBkzoKPgo+PiBGcm9tOiBaaHUg
TGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4+IFNlbnQ6IEZyaWRheSwgSnVseSAx
LCAyMDIyIDk6MjggQU0KPj4KPj4gVGhpcyBjb21taXQgYWRkcyBhIG5ldyB2RFBBIG5ldGxpbmsg
YXR0cmlidXRpb24KPj4gVkRQQV9BVFRSX1ZEUEFfREVWX1NVUFBPUlRFRF9GRUFUVVJFUy4gVXNl
cnNwYWNlIGNhbiBxdWVyeQo+PiBmZWF0dXJlcyBvZiB2RFBBIGRldmljZXMgdGhyb3VnaCB0aGlz
IG5ldyBhdHRyLgo+Pgo+PiBGaXhlczogYTY0OTE3YmMyZTliIHZkcGE6IChQcm92aWRlIGludGVy
ZmFjZSB0byByZWFkIGRyaXZlciBmZWF0dXJlKQo+IE1pc3NpbmcgdGhlICIiIGluIHRoZSBsaW5l
Lgo+IEkgcmV2aWV3ZWQgdGhlIHBhdGNoZXMgYWdhaW4uCj4KPiBIb3dldmVyLCB0aGlzIGlzIG5v
dCB0aGUgZml4Lgo+IEEgZml4IGNhbm5vdCBhZGQgYSBuZXcgVUFQSS4KPgo+IENvZGUgaXMgYWxy
ZWFkeSBjb25zaWRlcmluZyBuZWdvdGlhdGVkIGRyaXZlciBmZWF0dXJlcyB0byByZXR1cm4gdGhl
IGRldmljZSBjb25maWcgc3BhY2UuCj4gSGVuY2UgaXQgaXMgZmluZS4KPgo+IFRoaXMgcGF0Y2gg
aW50ZW50cyB0byBwcm92aWRlIGRldmljZSBmZWF0dXJlcyB0byB1c2VyIHNwYWNlLgo+IEZpcnN0
IHdoYXQgdmRwYSBkZXZpY2UgYXJlIGNhcGFibGUgb2YsIGFyZSBhbHJlYWR5IHJldHVybmVkIGJ5
IGZlYXR1cmVzIGF0dHJpYnV0ZSBvbiB0aGUgbWFuYWdlbWVudCBkZXZpY2UuCj4gVGhpcyBpcyBk
b25lIGluIGNvbW1pdCBbMV0uCj4KPiBUaGUgb25seSByZWFzb24gdG8gaGF2ZSBpdCBpcywgd2hl
biBvbmUgbWFuYWdlbWVudCBkZXZpY2UgaW5kaWNhdGVzIHRoYXQgZmVhdHVyZSBpcyBzdXBwb3J0
ZWQsIGJ1dCBkZXZpY2UgbWF5IGVuZCB1cCBub3Qgc3VwcG9ydGluZyB0aGlzIGZlYXR1cmUgaWYg
c3VjaCBmZWF0dXJlIGlzIHNoYXJlZCB3aXRoIG90aGVyIGRldmljZXMgb24gc2FtZSBwaHlzaWNh
bCBkZXZpY2UuCj4gRm9yIGV4YW1wbGUgYWxsIFZGcyBtYXkgbm90IGJlIHN5bW1ldHJpYyBhZnRl
ciBsYXJnZSBudW1iZXIgb2YgdGhlbSBhcmUgaW4gdXNlLiBJbiBzdWNoIGNhc2UgZmVhdHVyZXMg
Yml0IG9mIG1hbmFnZW1lbnQgZGV2aWNlIGNhbiBkaWZmZXIgKG1vcmUgZmVhdHVyZXMpIHRoYW4g
dGhlIHZkcGEgZGV2aWNlIG9mIHRoaXMgVkYuCj4gSGVuY2UsIHNob3dpbmcgb24gdGhlIGRldmlj
ZSBpcyB1c2VmdWwuCj4KPiBBcyBtZW50aW9uZWQgYmVmb3JlIGluIFYyLCBjb21taXQgWzFdIGhh
cyB3cm9uZ2x5IG5hbWVkIHRoZSBhdHRyaWJ1dGUgdG8gVkRQQV9BVFRSX0RFVl9TVVBQT1JURURf
RkVBVFVSRVMuCj4gSXQgc2hvdWxkIGhhdmUgYmVlbiwgVkRQQV9BVFRSX0RFVl9NR01UREVWX1NV
UFBPUlRFRF9GRUFUVVJFUy4KPiBCZWNhdXNlIGl0IGlzIGluIFVBUEksIGFuZCBzaW5jZSB3ZSBk
b24ndCB3YW50IHRvIGJyZWFrIGNvbXBpbGF0aW9uIG9mIGlwcm91dGUyLAo+IEl0IGNhbm5vdCBi
ZSByZW5hbWVkIGFueW1vcmUuCj4KPiBHaXZlbiB0aGF0LCB3ZSBkbyBub3Qgd2FudCB0byBzdGFy
dCB0cmVuZCBvZiBuYW1pbmcgZGV2aWNlIGF0dHJpYnV0ZXMgd2l0aCBhZGRpdGlvbmFsIF9WRFBB
XyB0byBpdCBhcyBkb25lIGluIHRoaXMgcGF0Y2guCj4gRXJyb3IgaW4gY29tbWl0IFsxXSB3YXMg
ZXhjZXB0aW9uLgo+Cj4gSGVuY2UsIHBsZWFzZSByZXVzZSBWRFBBX0FUVFJfREVWX1NVUFBPUlRF
RF9GRUFUVVJFUyB0byByZXR1cm4gZm9yIGRldmljZSBmZWF0dXJlcyB0b28uCgoKVGhpcyB3aWxs
IHByb2JhYmx5IGJyZWFrIG9yIGNvbmZ1c2UgdGhlIGV4aXN0aW5nIHVzZXJzcGFjZT8KClRoYW5r
cwoKCj4KPiBTZWNvbmRseSwgeW91IG5lZWQgb3V0cHV0IGV4YW1wbGUgZm9yIHNob3dpbmcgZGV2
aWNlIGZlYXR1cmVzIGluIHRoZSBjb21taXQgbG9nLgo+Cj4gM3JkLCBwbGVhc2UgZHJvcCB0aGUg
Zml4ZXMgdGFnIGFzIG5ldyBjYXBhYmlsaXR5IGlzIG5vdCBhIGZpeC4KPgo+IFsxXSBjZDI2Mjlm
NmRmMWMgKCJ2ZHBhOiBTdXBwb3J0IHJlcG9ydGluZyBtYXggZGV2aWNlIGNhcGFiaWxpdGllcyAi
KQo+Cj4+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNv
bT4KPj4gLS0tCj4+ICAgZHJpdmVycy92ZHBhL3ZkcGEuYyAgICAgICB8IDEzICsrKysrKysrKy0t
LS0KPj4gICBpbmNsdWRlL3VhcGkvbGludXgvdmRwYS5oIHwgIDEgKwo+PiAgIDIgZmlsZXMgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmRwYS92ZHBhLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYS5jIGluZGV4Cj4+IGViZjJm
MzYzZmJlNy4uOWIwZTM5YjJmMDIyIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYS5j
Cj4+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4gQEAgLTgxNSw3ICs4MTUsNyBAQCBzdGF0
aWMgaW50IHZkcGFfZGV2X25ldF9tcV9jb25maWdfZmlsbChzdHJ1Y3QKPj4gdmRwYV9kZXZpY2Ug
KnZkZXYsICBzdGF0aWMgaW50IHZkcGFfZGV2X25ldF9jb25maWdfZmlsbChzdHJ1Y3QgdmRwYV9k
ZXZpY2UKPj4gKnZkZXYsIHN0cnVjdCBza19idWZmICptc2cpICB7Cj4+ICAgCXN0cnVjdCB2aXJ0
aW9fbmV0X2NvbmZpZyBjb25maWcgPSB7fTsKPj4gLQl1NjQgZmVhdHVyZXM7Cj4+ICsJdTY0IGZl
YXR1cmVzX2RldmljZSwgZmVhdHVyZXNfZHJpdmVyOwo+PiAgIAl1MTYgdmFsX3UxNjsKPj4KPj4g
ICAJdmRwYV9nZXRfY29uZmlnX3VubG9ja2VkKHZkZXYsIDAsICZjb25maWcsIHNpemVvZihjb25m
aWcpKTsgQEAgLQo+PiA4MzIsMTIgKzgzMiwxNyBAQCBzdGF0aWMgaW50IHZkcGFfZGV2X25ldF9j
b25maWdfZmlsbChzdHJ1Y3QgdmRwYV9kZXZpY2UKPj4gKnZkZXYsIHN0cnVjdCBza19idWZmICpt
cwo+PiAgIAlpZiAobmxhX3B1dF91MTYobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTVRVLCB2
YWxfdTE2KSkKPj4gICAJCXJldHVybiAtRU1TR1NJWkU7Cj4+Cj4+IC0JZmVhdHVyZXMgPSB2ZGV2
LT5jb25maWctPmdldF9kcml2ZXJfZmVhdHVyZXModmRldik7Cj4+IC0JaWYgKG5sYV9wdXRfdTY0
XzY0Yml0KG1zZywKPj4gVkRQQV9BVFRSX0RFVl9ORUdPVElBVEVEX0ZFQVRVUkVTLCBmZWF0dXJl
cywKPj4gKwlmZWF0dXJlc19kcml2ZXIgPSB2ZGV2LT5jb25maWctPmdldF9kcml2ZXJfZmVhdHVy
ZXModmRldik7Cj4+ICsJaWYgKG5sYV9wdXRfdTY0XzY0Yml0KG1zZywKPj4gVkRQQV9BVFRSX0RF
Vl9ORUdPVElBVEVEX0ZFQVRVUkVTLCBmZWF0dXJlc19kcml2ZXIsCj4+ICsJCQkgICAgICBWRFBB
X0FUVFJfUEFEKSkKPj4gKwkJcmV0dXJuIC1FTVNHU0laRTsKPj4gKwo+PiArCWZlYXR1cmVzX2Rl
dmljZSA9IHZkZXYtPmNvbmZpZy0+Z2V0X2RldmljZV9mZWF0dXJlcyh2ZGV2KTsKPj4gKwlpZiAo
bmxhX3B1dF91NjRfNjRiaXQobXNnLAo+PiBWRFBBX0FUVFJfVkRQQV9ERVZfU1VQUE9SVEVEX0ZF
QVRVUkVTLAo+PiArZmVhdHVyZXNfZGV2aWNlLAo+PiAgIAkJCSAgICAgIFZEUEFfQVRUUl9QQUQp
KQo+PiAgIAkJcmV0dXJuIC1FTVNHU0laRTsKPj4KPj4gLQlyZXR1cm4gdmRwYV9kZXZfbmV0X21x
X2NvbmZpZ19maWxsKHZkZXYsIG1zZywgZmVhdHVyZXMsICZjb25maWcpOwo+PiArCXJldHVybiB2
ZHBhX2Rldl9uZXRfbXFfY29uZmlnX2ZpbGwodmRldiwgbXNnLCBmZWF0dXJlc19kcml2ZXIsCj4+
ICsmY29uZmlnKTsKPj4gICB9Cj4+Cj4+ICAgc3RhdGljIGludAo+PiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS91YXBpL2xpbnV4L3ZkcGEuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92ZHBhLmggaW5kZXgK
Pj4gMjVjNTVjYWIzZDdjLi4zOWYxYzNkN2MxMTIgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvdWFw
aS9saW51eC92ZHBhLmgKPj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZkcGEuaAo+PiBAQCAt
NDcsNiArNDcsNyBAQCBlbnVtIHZkcGFfYXR0ciB7Cj4+ICAgCVZEUEFfQVRUUl9ERVZfTkVHT1RJ
QVRFRF9GRUFUVVJFUywJLyogdTY0ICovCj4+ICAgCVZEUEFfQVRUUl9ERVZfTUdNVERFVl9NQVhf
VlFTLAkJLyogdTMyICovCj4+ICAgCVZEUEFfQVRUUl9ERVZfU1VQUE9SVEVEX0ZFQVRVUkVTLAkv
KiB1NjQgKi8KPj4gKwlWRFBBX0FUVFJfVkRQQV9ERVZfU1VQUE9SVEVEX0ZFQVRVUkVTLAkvKiB1
NjQgKi8KPj4KPj4gICAJVkRQQV9BVFRSX0RFVl9RVUVVRV9JTkRFWCwgICAgICAgICAgICAgIC8q
IHUzMiAqLwo+PiAgIAlWRFBBX0FUVFJfREVWX1ZFTkRPUl9BVFRSX05BTUUsCQkvKiBzdHJpbmcg
Ki8KPj4gLS0KPj4gMi4zMS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
