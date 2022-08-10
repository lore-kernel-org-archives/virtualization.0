Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CACBC19F2D
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 01:24:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A6B2C40AF0;
	Wed, 10 Aug 2022 01:24:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A6B2C40AF0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hPCuzVrM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yKk5cwsY0CjZ; Wed, 10 Aug 2022 01:24:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1D79B40AB6;
	Wed, 10 Aug 2022 01:24:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1D79B40AB6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2DE5C0032;
	Wed, 10 Aug 2022 01:24:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8AF9C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 01:24:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 94A968126C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 01:24:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 94A968126C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hPCuzVrM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XXE88cvhT04U
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 01:24:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A4F8980C62
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A4F8980C62
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 01:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660094657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QX2ZBUywNUVM3LCgT4qFy+TbAtlE8DlkkuQOfo8MTcQ=;
 b=hPCuzVrM6CYSyWOgxSlGRdSBhc+pW1jOcx5HVtZXtUepCi9KgAOj+8PP6/9Vr/q+UPSwux
 sHaGFi44PvVHDyCYlJrizKdFLZzMcII72FNVH0qaAIg7zW68cuDxmEwfwqCEtCIJfE7Qzh
 eZaPPlSpD5Sm/MGQAwbEg91Krz37fXU=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-61-ch7IxNSePzqSa_Q3O1JHYw-1; Tue, 09 Aug 2022 21:24:16 -0400
X-MC-Unique: ch7IxNSePzqSa_Q3O1JHYw-1
Received: by mail-pg1-f199.google.com with SMTP id
 z22-20020a630a56000000b0041b98176de9so5092711pgk.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 18:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=QX2ZBUywNUVM3LCgT4qFy+TbAtlE8DlkkuQOfo8MTcQ=;
 b=yy8kWZZMLTuj/QtLWsmnm69CsNotSPYoWc264zcQQHXo8GZ6/w0Ohe7VJnpYbUhCn/
 SHMsEuNl0pnpujpSMt8VsI68MLVK0bR4j0TeagDQGUI0KDJP1RRqmsFF/ZSDDIwTLa2d
 jj4V6AW6wELS7tUg0FbB+BJ/0IFHJu2redlqJ3Hh/UXqVIps5Pq3fY4lBmuWcpXN+eUg
 QFu5Qf9v9Pb55r9aMmnCGF9V9ZcASATkopQVzmfOEq2Zi1+b8xyFrqD6nNUvxOXdtc/8
 8lHBpf+wWFVW/MPszedYOfA3bW3oMr+TAwN8M9ctZB8loJfDc9YI5kFJBttitGlsZZHi
 QNLg==
X-Gm-Message-State: ACgBeo1sihqsJ208RW3xuOlRAP2jNo/SYEE3xXuIjdekdVgCl0ZYwO2O
 ig4TD8KhPBMvU84VGmInz5lY1gzJbPeYyIf28PkCu1GLAOPwG1qIKCgYlijN8AZAGry6iAVyn8j
 XCq14v5XWZLUbINaGg/9fzbUqDwqgwePJXMO3iWr95w==
X-Received: by 2002:a17:90a:e616:b0:1f5:35a6:6008 with SMTP id
 j22-20020a17090ae61600b001f535a66008mr1177054pjy.134.1660094655455; 
 Tue, 09 Aug 2022 18:24:15 -0700 (PDT)
X-Google-Smtp-Source: AA6agR71QTLlGO34ZPoCOiROVuFH6O15jD2Nd61b0Lgrj+WVQUCvoTll1SLPXEWAouY6jV7f17Co4Q==
X-Received: by 2002:a17:90a:e616:b0:1f5:35a6:6008 with SMTP id
 j22-20020a17090ae61600b001f535a66008mr1177036pjy.134.1660094655192; 
 Tue, 09 Aug 2022 18:24:15 -0700 (PDT)
Received: from [10.72.12.152] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a170902e75000b0016dc2153f54sm11549018plf.299.2022.08.09.18.24.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Aug 2022 18:24:14 -0700 (PDT)
Message-ID: <36a5bcab-4595-1679-2389-758150ea5767@redhat.com>
Date: Wed, 10 Aug 2022 09:24:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
To: Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809173542-mutt-send-email-mst@kernel.org>
 <19a564f0-d90c-1264-ba20-dcdfec887051@oracle.com>
 <20220809183516-mutt-send-email-mst@kernel.org>
 <0c6c876b-1d52-bfc8-87d4-edbe6b8581bc@oracle.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <0c6c876b-1d52-bfc8-87d4-edbe6b8581bc@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
 Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 "kubakici@wp.pl" <kubakici@wp.pl>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>, davem <davem@davemloft.net>,
 Gavin Li <gavinl@nvidia.com>
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

CuWcqCAyMDIyLzgvMTAgMDY6NTQsIFNpLVdlaSBMaXUg5YaZ6YGTOgo+Cj4KPiBPbiA4LzkvMjAy
MiAzOjM3IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+IE9uIFR1ZSwgQXVnIDA5LCAy
MDIyIGF0IDAzOjMyOjI2UE0gLTA3MDAsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pgo+Pj4gT24gOC85
LzIwMjIgMjozNyBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4+IE9uIFR1ZSwgQXVn
IDA5LCAyMDIyIGF0IDA3OjE4OjMwUE0gKzAwMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToKPj4+Pj4+
IEZyb206IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KPj4+Pj4+IFNlbnQ6IFR1
ZXNkYXksIEF1Z3VzdCA5LCAyMDIyIDM6MDkgUE0KPj4+Pj4+Pj4gRnJvbTogU2ktV2VpIExpdSA8
c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+Pj4+Pj4+PiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgOSwg
MjAyMiAyOjM5IFBNIEN1cnJlbnRseSBpdCBpcyBub3QuIE5vdCBhCj4+Pj4+Pj4+IHNpbmdsZSBw
YXRjaCBub3IgdGhpcyBwYXRjaCwgYnV0IHRoZSBjb250ZXh0IGZvciB0aGUgZXZlbnR1YWwgCj4+
Pj4+Pj4+IGdvYWwgaXMKPj4+Pj4+Pj4gdG8gYWxsb3cgWERQIG9uIGEgTVRVPTkwMDAgbGluayB3
aGVuIGd1ZXN0IHVzZXJzIGludGVudGlvbmFsbHkgCj4+Pj4+Pj4+IGxvd2VyCj4+Pj4+Pj4+IGRv
d24gTVRVIHRvIDE1MDAuCj4+Pj4+Pj4gV2hpY2ggYXBwbGljYXRpb24gYmVuZWZpdCBieSBoYXZp
bmcgYXN5bW1ldHJ5IGJ5IGxvd2VyaW5nIG10dSB0byAKPj4+Pj4+PiAxNTAwCj4+Pj4+PiB0byBz
ZW5kIHBhY2tldHMgYnV0IHdhbnQgdG8gcmVjZWl2ZSA5SyBwYWNrZXRzPwo+Pj4+PiBCZWxvdyBk
ZXRhaWxzIGRvZXNu4oCZdCBhbnN3ZXIgdGhlIHF1ZXN0aW9uIG9mIGFzeW1tZXRyeS4gOikKPj4+
Pj4KPj4+Pj4+IEkgdGhpbmsgdmlydGlvLW5ldCBkcml2ZXIgZG9lc24ndCBkaWZmZXJlbnRpYXRl
IE1UVSBhbmQgTVJVLCBpbiAKPj4+Pj4+IHdoaWNoIGNhc2UKPj4+Pj4+IHRoZSByZWNlaXZlIGJ1
ZmZlciB3aWxsIGJlIHJlZHVjZWQgdG8gZml0IHRoZSAxNTAwQiBwYXlsb2FkIHNpemUgCj4+Pj4+
PiB3aGVuIG10dSBpcwo+Pj4+Pj4gbG93ZXJlZCBkb3duIHRvIDE1MDAgZnJvbSA5MDAwLgo+Pj4+
PiBIb3c/IERyaXZlciByZWR1Y2VkIHRoZSBtWHUgdG8gMTUwMCwgc2F5IGl0IGlzIGltcHJvdmVk
IHRvIHBvc3QgCj4+Pj4+IGJ1ZmZlcnMgb2YgMTUwMCBieXRlcy4KPj4+Pj4KPj4+Pj4gRGV2aWNl
IGRvZXNuJ3Qga25vdyBhYm91dCBpdCBiZWNhdXNlIG10dSBpbiBjb25maWcgc3BhY2UgaXMgUk8g
ZmllbGQuCj4+Pj4+IERldmljZSBrZWVwIGRyb3BwaW5nIDlLIHBhY2tldHMgYmVjYXVzZSBidWZm
ZXJzIHBvc3RlZCBhcmUgMTUwMCAKPj4+Pj4gYnl0ZXMuCj4+Pj4+IFRoaXMgaXMgYmVjYXVzZSBk
ZXZpY2UgZm9sbG93cyB0aGUgc3BlYyAiIFRoZSBkZXZpY2UgTVVTVCBOT1QgcGFzcyAKPj4+Pj4g
cmVjZWl2ZWQgcGFja2V0cyB0aGF0IGV4Y2VlZCBtdHUiLgo+Pj4+IFRoZSAibXR1IiBoZXJlIGlz
IHRoZSBkZXZpY2UgY29uZmlnIGZpZWxkLCB3aGljaCBpcwo+Pj4+Cj4+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgIC8qIERlZmF1bHQgbWF4aW11bSB0cmFuc21pdCB1bml0IGFkdmljZSAqLwo+Pj4+Cj4+
Pj4gdGhlcmUgaXMgbm8gZ3VhcmFudGVlIGRldmljZSB3aWxsIG5vdCBnZXQgYSBiaWdnZXIgcGFj
a2V0Lgo+Pj4+IEFuZCB0aGVyZSBpcyBubyBndWFyYW50ZWUgc3VjaCBhIHBhY2tldCB3aWxsIGJl
IGRyb3BwZWQKPj4+PiBhcyBvcHBvc2VkIHRvIHdlZGdpbmcgdGhlIGRldmljZSBpZiB1c2Vyc3Bh
Y2UgaW5zaXN0cyBvbgo+Pj4+IGFkZGluZyBzbWFsbGVyIGJ1ZmZlcnMuCj4+PiBJdCdkIGJlIG5p
Y2UgdG8gZG9jdW1lbnQgdGhpcyByZXF1aXJlbWVudCBvciBzdGF0ZW1lbnQgdG8gdGhlIHNwZWMg
Zm9yCj4+PiBjbGFyaXR5IHB1cnBvc2UuCj4+IEl0J3Mgbm90IGEgcmVxdWlyZW1lbnQsIG1vcmUg
b2YgYSBidWcuIEJ1dCBpdCdzIGJlZW4gbGlrZSB0aGlzIGZvcgo+PiB5ZWFycy4KPiBXZWxsLCBJ
J20gbm90IHN1cmUgaG93IGl0IG1heSB3ZWRnZSB0aGUgZGV2aWNlIGlmIG5vdCBjYXBhYmxlIG9m
IAo+IHBvc3RpbmcgdG8gc21hbGxlciBidWZmZXJzLCBpcyB0aGVyZSBvdGhlciBvcHRpb24gdGhh
biBkcm9wPyBUcnVuY2F0ZSAKPiB0byB3aGF0IHRoZSBidWZmZXIgc2l6ZSBtYXkgZml0IGFuZCBk
ZWxpdmVyIHVwPyBTZWVtcyBldmVuIHdvcnNlIHRoYW4gCj4gZHJvcC4uLgo+Cj4+Cj4+PiBPdGhl
cndpc2UgdmFyaW91cyBkZXZpY2UgaW1wbGVtZW50YXRpb25zIGFyZSBoYXJkIHRvCj4+PiBmb2xs
b3cuIFRoZSBjYXB0dXJlIGlzIHRoYXQgdmhvc3QtbmV0IGRyb3BzIGJpZ2dlciBwYWNrZXRzIHdo
aWxlIHRoZSAKPj4+IGRyaXZlcgo+Pj4gb25seSBzdXBwbGllZCBzbWFsbGVyIGJ1ZmZlcnMuIFRo
aXMgaXMgdGhlIHN0YXR1cyBxdW8sIGFuZCB1c2VycyAKPj4+IHNlZW1pbmdseQo+Pj4gaGF2ZSBy
ZWxpZWQgb24gdGhpcyBiZWhhdmlvciBmb3Igc29tZSB3aGlsZS4KPj4+Cj4+PiAtU2l3ZWkKPj4g
V2VpcmQgd2hlcmUgZG8geW91IHNlZSB0aGlzIGluIGNvZGU/IEkgc2VlCj4+Cj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNvY2tfbGVuID0gdmhvc3RfbmV0X3J4X3BlZWtfaGVh
ZF9sZW4obmV0LCBzb2NrLT5zaywKPj4gJmJ1c3lsb29wX2ludHIpOwo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXNvY2tfbGVuKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHNvY2tfbGVuICs9IHNvY2tfaGxlbjsKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdmhvc3RfbGVuID0gc29ja19sZW4gKyB2aG9zdF9obGVuOwo+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBoZWFkY291bnQgPSBnZXRfcnhfYnVmcyh2
cSwgdnEtPmhlYWRzICsgbnZxLT5kb25lX2lkeCwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dmhvc3RfbGVuLCAmaW4sIHZxX2xvZywgJmxvZywKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bGlrZWx5KG1lcmdlYWJsZSkgPyAKPj4gVUlPX01BWElPViA6IDEpOwo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBPbiBlcnJvciwgc3RvcCBoYW5kbGluZyB1bnRpbCB0aGUg
bmV4dCBraWNrLiAqLwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAodW5s
aWtlbHkoaGVhZGNvdW50IDwgMCkpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsKPj4KPj4KPj4gc28gaXQgZG9lcyBub3QgZHJvcCBh
IHBhY2tldCwgaXQganVzdCBzdG9wcyBwcm9jZXNzaW5nIHRoZSBxdWV1ZS4KPiBIZXJlCj4KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogT24gb3ZlcnJ1biwgdHJ1bmNhdGUgYW5k
IGRpc2NhcmQgKi8KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHVubGlrZWx5
KGhlYWRjb3VudCA+IFVJT19NQVhJT1YpKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpb3ZfaXRlcl9pbml0KCZtc2cubXNnX2l0ZXIsIFJFQUQsIHZx
LT5pb3YsIDEsIAo+IDEpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZXJyID0gc29jay0+b3BzLT5yZWN2bXNnKHNvY2ssICZtc2csCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDEsIE1TR19ET05UV0FJVCB8IAo+IE1TR19U
UlVOQyk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBw
cl9kZWJ1ZygiRGlzY2FyZGVkIHJ4IHBhY2tldDogbGVuICV6ZFxuIiwgCj4gc29ja19sZW4pOwo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPgo+IHJlY3Ztc2coLCAsIDEsICkg
aXMgZXNzZW50aWFsbHkgdG8gZHJvcCB0aGUgb3ZlcnNpemVkIHBhY2tldC4KCgpJdCdzIG5vdCBu
ZWNlc3NhcmlseSB0aGUgb3ZlcnNpemVkIHBhY2tldCBidXQgdGhlIHBhY2tldCB0aGF0IGhhcyB0
b28gCm1hbnkgc2dzLgoKVGhpcyBpc3N1ZXMgaGFzIGJlZW4gZGlzY3Vzc2VkIGluIHRoZSBwYXN0
LCAoZm9yIGV4YW1wbGUgd2UgZGlzYWJsZSAKbGFyZ2UgcnggcXVldWUgc2l6ZSBmb3Igdmhvc3Qt
bmV0IGluIFFlbXUpLiBXaGVyZSBpdCBjb3VsZCBiZSBzb2x2ZWQgYnkgCmRvaW5nIHBpZWNlLXdp
c2UgY29weQoKVGhhbmtzCgoKPgo+Cj4gSW4gZ2V0X3J4X2J1ZnMoKSwgb3ZlcnJ1biBkZXRlY3Rp
b24gd2lsbCByZXR1cm4gc29tZXRoaW5nIGxhcmdlciB0aGFuIAo+IFVJT19NQVhJT1YgYXMgaW5k
aWNhdG9yOgo+Cj4gc3RhdGljIGludCBnZXRfcnhfYnVmcygpCj4gewo+IDoKPiA7Cj4gwqDCoMKg
wqDCoMKgwqAgLyogRGV0ZWN0IG92ZXJydW4gKi8KPiDCoMKgwqDCoMKgwqDCoCBpZiAodW5saWtl
bHkoZGF0YWxlbiA+IDApKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHIgPSBV
SU9fTUFYSU9WICsgMTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnI7
Cj4gwqDCoMKgwqDCoMKgwqAgfQo+IDoKPiA6Cj4KPgo+IC1TaXdlaQo+Cj4+Cj4+Cj4+Pj4KPj4+
Pj4gU28sIEkgYW0gbG9zdCB3aGF0IHZpcnRpbyBuZXQgZGV2aWNlIHVzZXIgYXBwbGljYXRpb24g
aXMgdHJ5aW5nIHRvIAo+Pj4+PiBhY2hpZXZlIGJ5IHNlbmRpbmcgc21hbGxlciBwYWNrZXRzIGFu
ZCBkcm9wcGluZyBhbGwgcmVjZWl2ZSBwYWNrZXRzLgo+Pj4+PiAoaXQgZG9lc27igJl0IGhhdmUg
YW55IHJlbGF0aW9uIHRvIG1lcmdlYWJsZSBvciBvdGhlcndpc2UpLgo+Pj4+IC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQo+Pj4+IFRvIHVuc3Vic2NyaWJlLCBlLW1haWw6IHZpcnRpby1kZXYtdW5zdWJzY3JpYmVAbGlz
dHMub2FzaXMtb3Blbi5vcmcKPj4+PiBGb3IgYWRkaXRpb25hbCBjb21tYW5kcywgZS1tYWlsOiB2
aXJ0aW8tZGV2LWhlbHBAbGlzdHMub2FzaXMtb3Blbi5vcmcKPj4+Pgo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
