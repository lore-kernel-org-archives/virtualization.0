Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D40AC19F2D
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 01:15:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83A9681A0D;
	Wed, 10 Aug 2022 01:15:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 83A9681A0D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eTm3dyEO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O902GwN_NZ09; Wed, 10 Aug 2022 01:15:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B1C2D8149A;
	Wed, 10 Aug 2022 01:15:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1C2D8149A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73CF9C0032;
	Wed, 10 Aug 2022 01:15:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84355C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 01:15:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A62E40AA9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 01:15:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4A62E40AA9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eTm3dyEO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8Eb7hEIVdBMP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 01:15:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F3C2D40546
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F3C2D40546
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 01:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660094121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/7s8KSJaNlVs7F22dHqhvwQsVV2/D49ZEbn+V6jAg4=;
 b=eTm3dyEODs696hbP2rcEJC2AMDsSLf/ZZAPWRJMdz8REah4oqWvZsiG3gvHSNKWPfcbKWR
 tjjZEtiKqNR6MSgejXBRqVkmzdpjxO0HLDv/rD+ixupaqoDaEK3l7EwNDq5wzNDsUfuTkr
 DXsoOwUeIIlSewjPdt2mJn7r782CECg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-l3fc-xiHOeC92hhsnwnQ0Q-1; Tue, 09 Aug 2022 21:15:20 -0400
X-MC-Unique: l3fc-xiHOeC92hhsnwnQ0Q-1
Received: by mail-pg1-f198.google.com with SMTP id
 f128-20020a636a86000000b0041a4b07b039so5004606pgc.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 18:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=9/7s8KSJaNlVs7F22dHqhvwQsVV2/D49ZEbn+V6jAg4=;
 b=Q0M+BG3m2hM1C2tFZPbxMmBgTWqin7w6eB8tF1RYqCCQ7k9SAwVM2w3DU+g292m7YA
 ZNJsQ131ai5/N5540LYr0KVfiNwyBa54m/Qun1dFt3DR1/bbEfCpD/Z/fNGN02+RRwBR
 EGJHedTV2Vbyq5XXFrcI5H7pOaE5LJu2yKlL5AHpd8rCnw4u7UyS2dCCbNF3uYL+EUAs
 npm5/PAa+DNjpqmS+2bldZMnFVc989wJcHo5kw7A8Z1HWlwEuGlkJ5CSiMpjN3yQ2bUu
 PUdycWgWGtgC9QvpBWXoqqzSHx/+Una6QQhVvfmYcfU1o4bssMey/zqmvspdVH7so4bm
 kv3w==
X-Gm-Message-State: ACgBeo3Hq7CzYmqDK7LU0ze+5kpO7zCq8k/XU6K0g/onGfGpj6cxmUxS
 nUlWmy7jKVHk3JhKff7czfPENKDRAye/wSkoIYhh8KbGmoFJzrxCmVUE3CG7BObuytydj2BbUxz
 MmaGfdHV0Ty2i61Bub655kKnurQsKtWs7U8jJIblkpg==
X-Received: by 2002:a63:1726:0:b0:41d:b30:46d4 with SMTP id
 x38-20020a631726000000b0041d0b3046d4mr17317189pgl.27.1660094119203; 
 Tue, 09 Aug 2022 18:15:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6929Emprq9lBZ+yE3HazsHgV57rI2xdvPJsFwlhzRO3DW1/pc0ugboBtmqkVhgVs4YTWG2Gg==
X-Received: by 2002:a63:1726:0:b0:41d:b30:46d4 with SMTP id
 x38-20020a631726000000b0041d0b3046d4mr17317165pgl.27.1660094118883; 
 Tue, 09 Aug 2022 18:15:18 -0700 (PDT)
Received: from [10.72.12.152] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 t188-20020a625fc5000000b0052de4886706sm561542pfb.10.2022.08.09.18.15.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Aug 2022 18:15:18 -0700 (PDT)
Message-ID: <4a5e2438-9ba7-0e62-4ec6-f2f81ddbfa11@redhat.com>
Date: Wed, 10 Aug 2022 09:15:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
To: Si-Wei Liu <si-wei.liu@oracle.com>, Gavin Li <gavinl@nvidia.com>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: alexander.h.duyck@intel.com, Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 mst <mst@redhat.com>, kubakici@wp.pl, sridhar.samudrala@intel.com,
 jesse.brandeburg@intel.com, gavi@nvidia.com,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>, loseweigh@gmail.com,
 davem <davem@davemloft.net>
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

CuWcqCAyMDIyLzgvMTAgMDI6MzgsIFNpLVdlaSBMaXUg5YaZ6YGTOgo+Cj4KPiBPbiA4LzkvMjAy
MiAxMjo0NCBBTSwgSmFzb24gV2FuZyB3cm90ZToKPj4gT24gVHVlLCBBdWcgOSwgMjAyMiBhdCAz
OjA3IFBNIEdhdmluIExpIDxnYXZpbmxAbnZpZGlhLmNvbT4gd3JvdGU6Cj4+Pgo+Pj4gT24gOC85
LzIwMjIgNzo1NiBBTSwgU2ktV2VpIExpdSB3cm90ZToKPj4+Cj4+PiBFeHRlcm5hbCBlbWFpbDog
VXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+Pj4KPj4+Cj4+PiBPbiA4
LzgvMjAyMiAxMjozMSBBTSwgR2F2aW4gTGkgd3JvdGU6Cj4+Pgo+Pj4KPj4+IE9uIDgvNi8yMDIy
IDY6MTEgQU0sIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pgo+Pj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBj
YXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMKPj4+Cj4+Pgo+Pj4gT24gOC8xLzIw
MjIgOTo0NSBQTSwgR2F2aW4gTGkgd3JvdGU6Cj4+Pgo+Pj4gQ3VycmVudGx5IGFkZF9yZWN2YnVm
X2JpZygpIGFsbG9jYXRlcyBNQVhfU0tCX0ZSQUdTIHNlZ21lbnRzIGZvciBiaWcKPj4+IHBhY2tl
dHMgZXZlbiB3aGVuIEdVRVNUXyogb2ZmbG9hZHMgYXJlIG5vdCBwcmVzZW50IG9uIHRoZSBkZXZp
Y2UuCj4+PiBIb3dldmVyLCBpZiBHU08gaXMgbm90IHN1cHBvcnRlZCwKPj4+Cj4+PiBHVUVTVCBH
U08gKHZpcnRpbyB0ZXJtKSwgb3IgR1JPIEhXIChuZXRkZXYgY29yZSB0ZXJtKSBpdCBzaG91bGQg
aGF2ZQo+Pj4gYmVlbiBiZSBjYWxsZWQuCj4+Pgo+Pj4gQUNLCj4+Pgo+Pj4KPj4+IMKgwqAgaXQg
d291bGQgYmUgc3VmZmljaWVudCB0byBhbGxvY2F0ZQo+Pj4gc2VnbWVudHMgdG8gY292ZXIganVz
dCB1cCB0aGUgTVRVIHNpemUgYW5kIG5vIGZ1cnRoZXIuIEFsbG9jYXRpbmcgdGhlCj4+PiBtYXhp
bXVtIGFtb3VudCBvZiBzZWdtZW50cyByZXN1bHRzIGluIGEgbGFyZ2Ugd2FzdGUgb2YgYnVmZmVy
IHNwYWNlIGluCj4+PiB0aGUgcXVldWUsIHdoaWNoIGxpbWl0cyB0aGUgbnVtYmVyIG9mIHBhY2tl
dHMgdGhhdCBjYW4gYmUgYnVmZmVyZWQgYW5kCj4+PiBjYW4gcmVzdWx0IGluIHJlZHVjZWQgcGVy
Zm9ybWFuY2UuCj4+Pgo+Pj4gVGhlcmVmb3JlLCBpZiBHU08gaXMgbm90IHN1cHBvcnRlZCwKPj4+
Cj4+PiBEaXR0by4KPj4+Cj4+PiBBQ0sKPj4+Cj4+Pgo+Pj4gdXNlIHRoZSBNVFUgdG8gY2FsY3Vs
YXRlIHRoZQo+Pj4gb3B0aW1hbCBhbW91bnQgb2Ygc2VnbWVudHMgcmVxdWlyZWQuCj4+Pgo+Pj4g
QmVsb3cgaXMgdGhlIGlwZXJmIFRDUCB0ZXN0IHJlc3VsdHMgb3ZlciBhIE1lbGxhbm94IE5JQywg
dXNpbmcgdkRQQSBmb3IKPj4+IDEgVlEsIHF1ZXVlIHNpemUgMTAyNCwgYmVmb3JlIGFuZCBhZnRl
ciB0aGUgY2hhbmdlLCB3aXRoIHRoZSBpcGVyZgo+Pj4gc2VydmVyIHJ1bm5pbmcgb3ZlciB0aGUg
dmlydGlvLW5ldCBpbnRlcmZhY2UuCj4+Pgo+Pj4gTVRVKEJ5dGVzKS9CYW5kd2lkdGggKEdiaXQv
cykKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQmVmb3JlwqDCoCBBZnRlcgo+Pj4g
wqDCoMKgIDE1MDDCoMKgwqDCoMKgwqDCoCAyMi41wqDCoMKgwqAgMjIuNAo+Pj4gwqDCoMKgIDkw
MDDCoMKgwqDCoMKgwqDCoCAxMi44wqDCoMKgwqAgMjUuOQo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6
IEdhdmluIExpIDxnYXZpbmxAbnZpZGlhLmNvbT4KPj4+IFJldmlld2VkLWJ5OiBHYXZpIFRlaXR6
IDxnYXZpQG52aWRpYS5jb20+Cj4+PiBSZXZpZXdlZC1ieTogUGFyYXYgUGFuZGl0IDxwYXJhdkBu
dmlkaWEuY29tPgo+Pj4gLS0tCj4+PiDCoMKgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDIw
ICsrKysrKysrKysrKysrKystLS0tCj4+PiDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+IGluZGV4IGVjOGUxYjMx
MDhjMy4uZDM2OTE4YzE4MDlkIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+IEBAIC0yMjIsNiArMjIy
LDkgQEAgc3RydWN0IHZpcnRuZXRfaW5mbyB7Cj4+PiDCoMKgwqDCoMKgwqAgLyogSSBsaWtlLi4u
IGJpZyBwYWNrZXRzIGFuZCBJIGNhbm5vdCBsaWUhICovCj4+PiDCoMKgwqDCoMKgwqAgYm9vbCBi
aWdfcGFja2V0czsKPj4+Cj4+PiArwqDCoMKgwqAgLyogSW5kaWNhdGVzIEdTTyBzdXBwb3J0ICov
Cj4+PiArwqDCoMKgwqAgYm9vbCBnc29faXNfc3VwcG9ydGVkOwo+Pj4gKwo+Pj4gwqDCoMKgwqDC
oMKgIC8qIEhvc3Qgd2lsbCBtZXJnZSByeCBidWZmZXJzIGZvciBiaWcgcGFja2V0cyAoc2hha2Ug
aXQhIHNoYWtlCj4+PiBpdCEpICovCj4+PiDCoMKgwqDCoMKgwqAgYm9vbCBtZXJnZWFibGVfcnhf
YnVmczsKPj4+Cj4+PiBAQCAtMTMxMiwxNCArMTMxNSwyMSBAQCBzdGF0aWMgaW50IGFkZF9yZWN2
YnVmX3NtYWxsKHN0cnVjdAo+Pj4gdmlydG5ldF9pbmZvICp2aSwgc3RydWN0IHJlY2VpdmVfcXVl
dWUgKnJxLAo+Pj4gwqDCoCBzdGF0aWMgaW50IGFkZF9yZWN2YnVmX2JpZyhzdHJ1Y3QgdmlydG5l
dF9pbmZvICp2aSwgc3RydWN0Cj4+PiByZWNlaXZlX3F1ZXVlICpycSwKPj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdmcF90IGdmcCkKPj4+IMKg
wqAgewo+Pj4gK8KgwqDCoMKgIHVuc2lnbmVkIGludCBzZ19udW0gPSBNQVhfU0tCX0ZSQUdTOwo+
Pj4gwqDCoMKgwqDCoMKgIHN0cnVjdCBwYWdlICpmaXJzdCwgKmxpc3QgPSBOVUxMOwo+Pj4gwqDC
oMKgwqDCoMKgIGNoYXIgKnA7Cj4+PiDCoMKgwqDCoMKgwqAgaW50IGksIGVyciwgb2Zmc2V0Owo+
Pj4KPj4+IC3CoMKgwqDCoCBzZ19pbml0X3RhYmxlKHJxLT5zZywgTUFYX1NLQl9GUkFHUyArIDIp
Owo+Pj4gK8KgwqDCoMKgIGlmICghdmktPmdzb19pc19zdXBwb3J0ZWQpIHsKPj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IG10dSA9IHZpLT5kZXYtPm10dTsKPj4+ICsK
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2dfbnVtID0gKG10dSAlIFBBR0VfU0laRSkg
PyBtdHUgLyBQQUdFX1NJWkUgKyAxIDogbXR1Cj4+PiAvIFBBR0VfU0laRTsKPj4+Cj4+PiBESVZf
Uk9VTkRfVVAoKSBjYW4gYmUgdXNlZD8KPj4+Cj4+PiBBQ0sKPj4+Cj4+Pgo+Pj4gU2luY2UgdGhp
cyBicmFuY2ggc2xpZ2h0bHkgYWRkcyB1cCBjb3N0IHRvIHRoZSBkYXRhcGF0aCwgSSB3b25kZXIg
aWYKPj4+IHRoaXMgc2dfbnVtIGNhbiBiZSBzYXZlZCBhbmQgc2V0IG9ubHkgb25jZSAoZ2VuZXJh
bGx5IGluIHZpcnRuZXRfcHJvYmUKPj4+IHRpbWUpIGluIHN0cnVjdCB2aXJ0bmV0X2luZm8/Cj4+
Pgo+Pj4gTm90IHN1cmUgaG93IHRvIGRvIGl0IGFuZCBhbGlnbiBpdCB3aXRoIGFsaWduIHdpdGgg
bmV3IG10dSBkdXJpbmcKPj4+IC5uZG9fY2hhbmdlX210dSgpLS0tYXMgeW91IG1lbnRpb25lZCBp
biB0aGUgZm9sbG93aW5nIG1haWwuIEFueSBpZGVhPwo+Pj4gbmRvX2NoYW5nZV9tdHUgbWlnaHQg
YmUgaW4gdmVuZG9yIHNwZWNpZmljIGNvZGUgYW5kIHVubWFuYWdlYWJsZS4gSW4KPj4+IG15IGNh
c2UsIHRoZSBtdHUgY2FuIG9ubHkgYmUgY2hhbmdlZCBpbiB0aGUgeG1sIG9mIHRoZSBndWVzdCB2
bS4KPj4+Cj4+PiBOb3BlLCBmb3IgZS5nLiAiaXAgbGluayBkZXYgZXRoMCBzZXQgbXR1IDE1MDAi
IGNhbiBiZSBkb25lIGZyb20gCj4+PiBndWVzdCBvbgo+Pj4gYSB2aXJ0aW8tbmV0IGRldmljZSB3
aXRoIDkwMDAgTVRVIChhcyBkZWZpbmVkIGluIGd1ZXN0IHhtbCkuIEJhc2ljYWxseQo+Pj4gZ3Vl
c3QgdXNlciBjYW4gc2V0IE1UVSB0byBhbnkgdmFsaWQgdmFsdWUgbG93ZXIgdGhhbiB0aGUgb3Jp
Z2luYWwKPj4+IEhPU1RfTVRVLiBJbiB0aGUgdmVuZG9yIGRlZmluZWQgLm5kb19jaGFuZ2VfbXR1
KCkgb3AsIAo+Pj4gZGV2X3ZhbGlkYXRlX210dSgpCj4+PiBzaG91bGQgaGF2ZSB2YWxpZGF0ZWQg
dGhlIE1UVSB2YWx1ZSBiZWZvcmUgY29taW5nIGRvd24gdG8gaXQuIEFuZCBJCj4+PiBzdXNwZWN0
IHlvdSBtaWdodCB3YW50IHRvIGRvIHZpcnRuZXRfY2xvc2UoKSBhbmQgdmlydG5ldF9vcGVuKCkK
Pj4+IGJlZm9yZS9hZnRlciBjaGFuZ2luZyB0aGUgYnVmZmVyIHNpemUgb24gdGhlIGZseSAodGhl
IG5ldGlmX3J1bm5pbmcoKQo+Pj4gY2FzZSksIGltcGxlbWVudGluZyAubmRvX2NoYW5nZV9tdHUo
KSB3aWxsIGJlIG5lZWRlZCBhbnl3YXkuCj4+Pgo+Pj4gYSBndWVzdCBWTSBkcml2ZXIgY2hhbmdp
bmcgbXR1IHRvIHNtYWxsZXIgb25lIGlzIHZhbGlkIHVzZSBjYXNlLiAKPj4+IEhvd2V2ZXIsIGN1
cnJlbnQgb3B0aW1pemF0aW9uIHN1Z2dlc3RlZCBpbiB0aGUgcGF0Y2ggZG9lc24ndCBkZWdyYWRl
IAo+Pj4gYW55IHBlcmZvcm1hbmNlLiBQZXJmb3JtaW5nIGNsb3NlKCkgYW5kIG9wZW4oKSBzZXF1
ZW5jZSBpcyBnb29kIAo+Pj4gaWRlYSwgdGhhdCBJIHdvdWxkIGxpa2UgdG8gdGFrZSB1cCBuZXh0
IGFmdGVyIHRoaXMgcGF0Y2ggYXMgaXRzIAo+Pj4gZ29pbmcgdG8gYmUgbW9yZSB0aGFuIG9uZSBw
YXRjaCB0byBhY2hpZXZlIGl0Lgo+PiBSaWdodCwgaXQgY291bGQgYmUgZG9uZSBvbiB0b3AuCj4+
Cj4+IEJ1dCBhbm90aGVyIG5vdGUgaXMgdGhhdCwgaXQgd291bGQgc3RpbGwgYmUgYmV0dGVyIHRv
IHN1cHBvcnQgR1VFU1QgCj4+IEdTTyBmZWF0dXJlOgo+Pgo+PiAxKSBjYW4gd29yayBmb3IgdGhl
IGNhc2UgZm9yIHBhdGggTVRVCj4+IDIpIChtaWdyYXRpb24pY29tcGF0aWJpbGl0eSB3aXRoIHNv
ZnR3YXJlIGJhY2tlbmRzCj4+Cj4+Pgo+Pj4gK8KgwqDCoMKgIH0KPj4+ICsKPj4+ICvCoMKgwqDC
oCBzZ19pbml0X3RhYmxlKHJxLT5zZywgc2dfbnVtICsgMik7Cj4+Pgo+Pj4gwqDCoMKgwqDCoMKg
IC8qIHBhZ2UgaW4gcnEtPnNnW01BWF9TS0JfRlJBR1MgKyAxXSBpcyBsaXN0IHRhaWwgKi8KPj4+
Cj4+PiBDb21tZW50IGRvZXNuJ3QgbWF0Y2ggY29kZS4KPj4+Cj4+PiBBQ0sKPj4+Cj4+PiAtwqDC
oMKgwqAgZm9yIChpID0gTUFYX1NLQl9GUkFHUyArIDE7IGkgPiAxOyAtLWkpIHsKPj4+ICvCoMKg
wqDCoCBmb3IgKGkgPSBzZ19udW0gKyAxOyBpID4gMTsgLS1pKSB7Cj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGZpcnN0ID0gZ2V0X2FfcGFnZShycSwgZ2ZwKTsKPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFmaXJzdCkgewo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGxpc3QpCj4+PiBAQCAtMTM1MCw3ICsxMzYw
LDcgQEAgc3RhdGljIGludCBhZGRfcmVjdmJ1Zl9iaWcoc3RydWN0IHZpcnRuZXRfaW5mbwo+Pj4g
KnZpLCBzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsCj4+Pgo+Pj4gwqDCoMKgwqDCoMKgIC8qIGNo
YWluIGZpcnN0IGluIGxpc3QgaGVhZCAqLwo+Pj4gwqDCoMKgwqDCoMKgIGZpcnN0LT5wcml2YXRl
ID0gKHVuc2lnbmVkIGxvbmcpbGlzdDsKPj4+IC3CoMKgwqDCoCBlcnIgPSB2aXJ0cXVldWVfYWRk
X2luYnVmKHJxLT52cSwgcnEtPnNnLCBNQVhfU0tCX0ZSQUdTICsgMiwKPj4+ICvCoMKgwqDCoCBl
cnIgPSB2aXJ0cXVldWVfYWRkX2luYnVmKHJxLT52cSwgcnEtPnNnLCBzZ19udW0gKyAyLAo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBmaXJzdCwgZ2ZwKTsKPj4+IMKgwqDCoMKgwqDCoCBpZiAoZXJyIDwgMCkKPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2l2ZV9wYWdlcyhycSwgZmlyc3QpOwo+Pj4gQEAg
LTM1NzEsOCArMzU4MSwxMCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZpcnRp
b19kZXZpY2UKPj4+ICp2ZGV2KQo+Pj4gwqDCoMKgwqDCoMKgIGlmICh2aXJ0aW9faGFzX2ZlYXR1
cmUodmRldiwgVklSVElPX05FVF9GX0dVRVNUX1RTTzQpIHx8Cj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX0dVRVNUX1RTTzYpIHx8
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElP
X05FVF9GX0dVRVNUX0VDTikgfHwKPj4+IC3CoMKgwqDCoMKgwqDCoMKgIHZpcnRpb19oYXNfZmVh
dHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVUZPKSkKPj4+ICvCoMKgwqDCoMKgwqDCoMKg
IHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVUZPKSkgewo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2aS0+YmlnX3BhY2tldHMgPSB0cnVlOwo+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2aS0+Z3NvX2lzX3N1cHBvcnRlZCA9IHRydWU7Cj4+
Pgo+Pj4gUGxlYXNlIGRvIHRoZSBzYW1lIGZvciB2aXJ0bmV0X2NsZWFyX2d1ZXN0X29mZmxvYWRz
KCksIGFuZAo+Pj4gY29ycmVzcG9uZGluZ2x5IHZpcnRuZXRfcmVzdG9yZV9ndWVzdF9vZmZsb2Fk
cygpIGFzIHdlbGwuIE5vdCBzdXJlIHdoeQo+Pj4gdmlydG5ldF9jbGVhcl9ndWVzdF9vZmZsb2Fk
cygpIG9yIHRoZSBjYWxsZXIgZG9lc24ndCB1bnNldCAKPj4+IGJpZ19wYWNrZXQgb24KPj4+IHN1
Y2Nlc3NmdWwgcmV0dXJuLCBzZWVtcyBsaWtlIGEgYnVnIHRvIG1lLgo+PiBJdCBpcyBmaW5lIGFz
IGxvbmcgYXMKPj4KPj4gMSkgd2UgZG9uJ3QgaW1wbGVtZW50IGV0aHRvb2wgQVBJIGZvciBjaGFu
Z2luZyBndWVzdCBvZmZsb2Fkcwo+IE5vdCBzdXJlIGlmIEkgbWlzc2VkIHNvbWV0aGluZywgYnV0
IGl0IGxvb2tzIHRoZSBjdXJyZW50IAo+IHZpcnRuZXRfc2V0X2ZlYXR1cmVzKCkgYWxyZWFkeSBz
dXBwb3J0cyB0b2dnbGluZyBvbi9vZmYgR1JPIEhXIHRocm91Z2ggCj4gY29tbWl0IGEwMmU4OTY0
ZWFmOTI3MWE4YTVmY2MwYzU1YmQxM2Y5MzNiYWZjNTYgKGZvcm1lcmx5IG1pc25hbWVkIGFzIAo+
IExSTykuIFNvcnJ5LCBJIHJlYWxpemVkIEkgaGFkIGEgdHlwbyBpbiBlbWFpbDogCj4gInZpcnRu
ZXRfc2V0X2d1ZXN0X29mZmxvYWRzKCkgb3IgdGhlIGNhbGxlciBkb2Vzbid0IHVuc2V0IGJpZ19w
YWNrZXQgCj4gLi4uIi4KCgpZZXMsIEkgbWlzcyB0aGF0LgoKCj4KPj4gMikgYmlnIG1vZGUgWERQ
IGlzIG5vdCBlbmFibGVkCj4gQ3VycmVudGx5IGl0IGlzIG5vdC4gTm90IGEgc2luZ2xlIHBhdGNo
IG5vciB0aGlzIHBhdGNoLCBidXQgdGhlIAo+IGNvbnRleHQgZm9yIHRoZSBldmVudHVhbCBnb2Fs
IGlzIHRvIGFsbG93IFhEUCBvbiBhIE1UVT05MDAwIGxpbmsgd2hlbiAKPiBndWVzdCB1c2VycyBp
bnRlbnRpb25hbGx5IGxvd2VyIGRvd24gTVRVIHRvIDE1MDAuCgoKQUZBSUssIHRoaXMgcmVxdWly
ZXMgbW9yZSBjaGFuZ2VzIHNpbmNlIG1lcmdlYWJsZSBwYXRoIGFsbG9jYXRlcyAKUEFHRV9TSVpF
IHdoaWxlIHNtYWxsIHBhdGggYWxsb2NhdGVzIH4xNTAwLiBUaGlzIGlzIHNvbWV0aGluZyB0aGF0
IG5lZWRzIAp0byBiZSBmaXhlZC4KClRoYW5rcwoKCj4KPiBSZWdhcmRzLAo+IC1TaXdlaQo+Pgo+
PiBTbyB0aGF0IGNvZGUgd29ya3Mgb25seSBmb3IgWERQIGJ1dCB3ZSBmb3JiaWQgYmlnIHBhY2tl
dHMgaW4gdGhlIGNhc2UKPj4gb2YgWERQIHJpZ2h0IG5vdy4KPj4KPj4gVGhhbmtzCj4+Cj4+PiBB
Q0suIFRoZSB0d28gY2FsbHMgdmlydG5ldF9zZXRfZ3Vlc3Rfb2ZmbG9hZHMgYW5kCj4+PiB2aXJ0
bmV0X3NldF9ndWVzdF9vZmZsb2FkcyBpcyBhbHNvIGNhbGxlZCBieSB2aXJ0bmV0X3NldF9mZWF0
dXJlcy4gRG8KPj4+IHlvdSB0aGluayBpZiBJIGNhbiBkbyB0aGlzIGluIHZpcnRuZXRfc2V0X2d1
ZXN0X29mZmxvYWRzPwo+Pj4KPj4+IEkgdGhpbmsgdGhhdCBpdCBzaG91bGQgYmUgZmluZSwgdGhv
dWdoIHlvdSBtYXkgd2FudCB0byBkZWFsIHdpdGggdGhlIAo+Pj4gWERQCj4+PiBwYXRoIG5vdCB0
byByZWdyZXNzIGl0Lgo+Pj4KPj4+IC1TaXdlaQo+Pj4KPj4+Cj4+Pgo+Pj4gVGhhbmtzLAo+Pj4g
LVNpd2VpCj4+Pgo+Pj4gK8KgwqDCoMKgIH0KPj4+Cj4+PiDCoMKgwqDCoMKgwqAgaWYgKHZpcnRp
b19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfTVJHX1JYQlVGKSkKPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdmktPm1lcmdlYWJsZV9yeF9idWZzID0gdHJ1ZTsKPj4+Cj4+
Pgo+Pj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
