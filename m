Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C20C433EF
	for <virtualization@archiver.kernel.org>; Thu, 14 Jul 2022 02:59:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1799C400CE;
	Thu, 14 Jul 2022 02:59:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1799C400CE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZPdBsENV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hFShpGo4qwJv; Thu, 14 Jul 2022 02:59:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8A7FF40103;
	Thu, 14 Jul 2022 02:59:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A7FF40103
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DACEC0035;
	Thu, 14 Jul 2022 02:59:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08FF0C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 02:59:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D6B2884228
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 02:59:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D6B2884228
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZPdBsENV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ym-2rtyGZHSI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 02:59:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0322E841DB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0322E841DB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 02:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657767568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vljCPqfS4JXAdqfuKpPVeX86cFMumauaVcfGL80nUUY=;
 b=ZPdBsENVBL4XMA3LEXNS2UAZgu9/H5AcR/MmfPG5g6cM4UMBu0c3mtWQWJwkESAxM4xKJe
 4mzIaSoMlPQ8pwn2tiTac6vSgofH00c6V0hByj8V0yjaH1nUuYm+YCPJGc6wLmXRd/YG7S
 m55ojJNTtFGJe8ryCOatxpYhPNgErEQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-l809oYLwP8uOpv1bedT61g-1; Wed, 13 Jul 2022 22:59:27 -0400
X-MC-Unique: l809oYLwP8uOpv1bedT61g-1
Received: by mail-pj1-f71.google.com with SMTP id
 k7-20020a17090a62c700b001ef9c16ba10so2793521pjs.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 19:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=vljCPqfS4JXAdqfuKpPVeX86cFMumauaVcfGL80nUUY=;
 b=TaQsZHV1hjk7keEglourFM8cEFrCLQSdzOT8io0rgH1iKUYjH/vle6zXPgqglgY3Xr
 JeAWnNvByRgZpE4LwKEbinZjZma2bmDGKysc4R5MC8T4ijgR/9iUErSnL8eG4h5wWftK
 Iqmb2GUAHUbLQyGVp6lcubf58B0kx3s//uImVfLQOjAajpYY+dAxeCeVwcdAiKlI2BVL
 yBLoftb59TAnjRMr8OB94WLj521Ii5V+2EwQB+0QTXMsepHNFz4Sz71U7qtY9RnFWmOd
 Gxt4nzBuxHLgcYpRMBn8FIqIKrX3AUgqW6VZilNdfGP8b9E1lUdtcJma1R8DUFP1CW4B
 bBkw==
X-Gm-Message-State: AJIora8R7x7pyUpbXXa/OTQPJcmptSL2lnEZbAxTdNTliCtQN3ym6hX4
 XpFZk3Pzo4d3EH+0XtUtcj+6Mbr2tAYLW354MGtJ+JqhOKJ1pr5IGepZm7xxB+An57+K/j9pCzC
 PGgbyokpaDHp1LPGoH74Lgl2/3GYEhqopVdNo9PF0Xw==
X-Received: by 2002:a17:903:22c4:b0:16c:6a72:12b7 with SMTP id
 y4-20020a17090322c400b0016c6a7212b7mr6303413plg.10.1657767566438; 
 Wed, 13 Jul 2022 19:59:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uK4DAlZpD0zNK9Y+KrDKvumOJ7i3EGJ+/6C3HLY/3v2p4iYXHOzlayl5RJDUAfh2Tq370tKg==
X-Received: by 2002:a17:903:22c4:b0:16c:6a72:12b7 with SMTP id
 y4-20020a17090322c400b0016c6a7212b7mr6303385plg.10.1657767566196; 
 Wed, 13 Jul 2022 19:59:26 -0700 (PDT)
Received: from [10.72.12.153] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 i11-20020a170902cf0b00b0016c06a10861sm161638plg.74.2022.07.13.19.59.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jul 2022 19:59:25 -0700 (PDT)
Message-ID: <07a8e952-1347-8920-3a78-0200b865e0e9@redhat.com>
Date: Thu, 14 Jul 2022 10:59:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/5] VDUSE: Support registering userspace memory as
 bounce buffer
To: Yongji Xie <xieyongji@bytedance.com>
References: <20220706050503.171-1-xieyongji@bytedance.com>
 <CACGkMEv1tzenaGSUvYXEuxdmXyaZxQ24QspXRRA_95mMp4PWSg@mail.gmail.com>
 <CACycT3u3kOzzQjKBYNAB5vtpgcmPg7FjJ5yTYMtQo0SJVrBmZg@mail.gmail.com>
 <CACGkMEvtC1VmGjhV6QpEeu+nUikGj5eT79hhyS59rpK1s31TUg@mail.gmail.com>
 <CACycT3sNnmV8jrnjFkft6oST_6SGLc43f8Y4ZpomkPeOsvsorQ@mail.gmail.com>
 <CACGkMEsuGif+X4Maa-qSNYLzfkvBKV9ZkVEUFgYnjsUUwS4Dkw@mail.gmail.com>
 <CACycT3vgaOrLVq+GDRK1PqqBRCkUAU0bYH=2CDvudsX0F9FBDA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CACycT3vgaOrLVq+GDRK1PqqBRCkUAU0bYH=2CDvudsX0F9FBDA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com
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

CuWcqCAyMDIyLzcvMTEgMTU6MjQsIFlvbmdqaSBYaWUg5YaZ6YGTOgo+IE9uIE1vbiwgSnVsIDEx
LCAyMDIyIGF0IDI6MDIgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4+IE9uIEZyaSwgSnVsIDgsIDIwMjIgYXQgNTo1MyBQTSBZb25namkgWGllIDx4aWV5b25namlA
Ynl0ZWRhbmNlLmNvbT4gd3JvdGU6Cj4+PiBPbiBGcmksIEp1bCA4LCAyMDIyIGF0IDQ6MzggUE0g
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4gT24gV2VkLCBKdWwg
NiwgMjAyMiBhdCA2OjE2IFBNIFlvbmdqaSBYaWUgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPiB3
cm90ZToKPj4+Pj4gT24gV2VkLCBKdWwgNiwgMjAyMiBhdCA1OjMwIFBNIEphc29uIFdhbmcgPGph
c293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+Pj4gT24gV2VkLCBKdWwgNiwgMjAyMiBhdCAx
OjA1IFBNIFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPiB3cm90ZToKPj4+Pj4+
PiBIaSBhbGwsCj4+Pj4+Pj4KPj4+Pj4+PiBUaGlzIHNlcmllcyBpbnRyb2R1Y2VzIHNvbWUgbmV3
IGlvY3RsczogVkRVU0VfSU9UTEJfR0VUX0lORk8sCj4+Pj4+Pj4gVkRVU0VfSU9UTEJfUkVHX1VN
RU0gYW5kIFZEVVNFX0lPVExCX0RFUkVHX1VNRU0gdG8gc3VwcG9ydAo+Pj4+Pj4+IHJlZ2lzdGVy
aW5nIGFuZCBkZS1yZWdpc3RlcmluZyB1c2Vyc3BhY2UgbWVtb3J5IGZvciBJT1RMQgo+Pj4+Pj4+
IGFzIGJvdW5jZSBidWZmZXIgaW4gdmlydGlvLXZkcGEgY2FzZS4KPj4+Pj4+Pgo+Pj4+Pj4+IFRo
ZSBWRFVTRV9JT1RMQl9HRVRfSU5GTyBpb2N0bCBjYW4gaGVscCB1c2VyIHRvIHF1ZXJ5IElPTFRC
Cj4+Pj4+Pj4gaW5mb3JtYXRpb24gc3VjaCBhcyBib3VuY2UgYnVmZmVyIHNpemUuIFRoZW4gdXNl
ciBjYW4gdXNlCj4+Pj4+Pj4gdGhvc2UgaW5mb3JtYXRpb24gb24gVkRVU0VfSU9UTEJfUkVHX1VN
RU0gYW5kCj4+Pj4+Pj4gVkRVU0VfSU9UTEJfREVSRUdfVU1FTSBpb2N0bHMgdG8gcmVnaXN0ZXIg
YW5kIGRlLXJlZ2lzdGVyCj4+Pj4+Pj4gdXNlcnNwYWNlIG1lbW9yeSBmb3IgSU9UTEIuCj4+Pj4+
Pj4KPj4+Pj4+PiBEdXJpbmcgcmVnaXN0ZXJpbmcgYW5kIGRlLXJlZ2lzdGVyaW5nLCB0aGUgRE1B
IGRhdGEgaW4gdXNlCj4+Pj4+Pj4gd291bGQgYmUgY29waWVkIGZyb20ga2VybmVsIGJvdW5jZSBw
YWdlcyB0byB1c2Vyc3BhY2UgYm91bmNlCj4+Pj4+Pj4gcGFnZXMgYW5kIGJhY2suCj4+Pj4+Pj4K
Pj4+Pj4+PiBXaXRoIHRoaXMgZmVhdHVyZSwgc29tZSBleGlzdGluZyBhcHBsaWNhdGlvbiBzdWNo
IGFzIFNQREsKPj4+Pj4+PiBhbmQgRFBESyBjYW4gbGV2ZXJhZ2UgdGhlIGRhdGFwYXRoIG9mIFZE
VVNFIGRpcmVjdGx5IGFuZAo+Pj4+Pj4+IGVmZmljaWVudGx5IGFzIGRpc2N1c3NlZCBiZWZvcmUg
WzFdWzJdLiBUaGV5IGNhbiByZWdpc3Rlcgo+Pj4+Pj4+IHNvbWUgcHJlYWxsb2NhdGVkIGh1Z2Vw
YWdlcyB0byBWRFVTRSB0byBhdm9pZCBhbiBleHRyYQo+Pj4+Pj4+IG1lbWNweSBmcm9tIGJvdW5j
ZS1idWZmZXIgdG8gaHVnZXBhZ2VzLgo+Pj4+Pj4gVGhpcyBpcyByZWFsbHkgaW50ZXJlc3Rpbmcu
Cj4+Pj4+Pgo+Pj4+Pj4gQnV0IGEgc21hbGwgY29uY2VybiBvbiB1QVBJIGlzIHRoYXQgdGhpcyBz
ZWVtcyB0byBleHBvc2UgdGhlIFZEVVNFCj4+Pj4+PiBpbnRlcm5hbCBpbXBsZW1lbnRhdGlvbiAo
Ym91bmNlIGJ1ZmZlcikgdG8gdXNlcnNwYWNlLiBXZSB0cmllZCBoYXJkIHRvCj4+Pj4+PiBoaWRl
IGl0IHZpYSB0aGUgR0VUX0ZEIGJlZm9yZS4gQW55d2F5IGNhbiB3ZSBrZWVwIGl0Pwo+Pj4+Pj4K
Pj4+Pj4gQW5vdGhlciB3YXkgaXMgY2hhbmdpbmcgR0VUX0ZEIGlvY3RsIHRvIGFkZCBhIGZsYWcg
b3IgcmV1c2UgJ3Blcm0nCj4+Pj4+IGZpZWxkIHRvIGluZGljYXRlIHdoZXRoZXIgYSBJT1ZBIHJl
Z2lvbiBzdXBwb3J0cyB1c2Vyc3BhY2UgbWVtb3J5Cj4+Pj4+IHJlZ2lzdHJhdGlvbi4gVGhlbiB1
c2Vyc3BhY2UgY2FuIHVzZQo+Pj4+PiBWRFVTRV9JT1RMQl9SRUdfVU1FTS9WRFVTRV9JT1RMQl9E
RVJFR19VTUVNIHRvIHJlZ2lzdGVyL2RlcmVnaXN0ZXIKPj4+Pj4gdXNlcnNwYWNlIG1lbW9yeSBm
b3IgdGhpcyBJT1ZBIHJlZ2lvbi4KPj4+PiBMb29rcyBiZXR0ZXIuCj4+Pj4KPj4+IE9LLgo+Pj4K
Pj4+Pj4gQW55IHN1Z2dlc3Rpb25zPwo+Pj4+IEkgd29uZGVyIHdoYXQncyB0aGUgdmFsdWUgb2Yg
a2VlcGluZyB0aGUgY29tcGF0aWJpbGl0eSB3aXRoIHRoZSBrZXJuZWwKPj4+PiBtbWFwZWQgYm91
bmNlIGJ1ZmZlci4gSXQgbWVhbnMgd2UgbmVlZCB0byB0YWtlIGV4dHJhIGNhcmUgb24gZS5nIGRh
dGEKPj4+PiBjb3B5aW5nIHdoZW4gcmVnL3JlZyB1c2VyIHNwYWNlIG1lbW9yeS4KPj4+Pgo+Pj4g
SSdtIG5vdCBzdXJlIEkgZ2V0IHlvdXIgcG9pbnQgb24gdGhlIGNvbXBhdGliaWxpdHkgd2l0aCB0
aGUga2VybmVsCj4+PiBib3VuY2UgYnVmZmVyLiBEbyB5b3UgbWVhbiB0aGV5IHVzZSB0aGUgc2Ft
ZSBpb3ZhIHJlZ2lvbj8KPj4gWWVzLgo+Pgo+Pj4gVGhlIHVzZXJzcGFjZSBkYWVtb24gbWlnaHQg
Y3Jhc2ggb3IgcmVib290LiBJbiB0aG9zZSBjYXNlcywgd2Ugc3RpbGwKPj4+IG5lZWQgYSBrZXJu
ZWwgYnVmZmVyIHRvIHN0b3JlL3JlY292ZXIgdGhlIGRhdGEuCj4+IFllcywgdGhpcyBzaG91bGQg
YmUgYSBnb29kIHBvaW50Lgo+Pgo+Pj4+IENhbiB3ZSBzaW1wbHkgYWxsb3cgdGhlIHRoaXJkIGtp
bmQgb2YgZmQgdGhhdCBvbmx5IHdvcmtzIGZvciB1bWVtIHJlZ2lzdHJhdGlvbj8KPj4+Pgo+Pj4g
RG8geW91IG1lYW4gdXNpbmcgYW5vdGhlciBpb3ZhIHJlZ2lvbiBmb3IgdW1lbT8KPj4gSSBtZWFu
dCBoYXZpbmcgYSBuZXcga2luZCBvZiBmZCB0aGF0IG9ubHkgYWxsb3dzIHVtZW0gcmVnaXN0cmF0
aW9uLgo+Pgo+IE9LLiBJdCBzZWVtcyB0byBiZSBhIGxpdHRsZSBjb21wbGljYXRlZCB0byBhbGxv
dyBtYXBwaW5nIGEgcmVnaXN0ZXJlZAo+IHVzZXIgbWVtb3J5IHZpYSBhIG5ldyBmZCwgZS5nLiBo
b3cgdG8gaGFuZGxlIHRoZSBtYXBwaW5nIGlmIHRoZQo+IHVzZXJzcGFjZSBkYWVtb24gZXhpdHMg
YnV0IHRoZSBmZCBpcyBhbHJlYWR5IHBhc3NlZCB0byBhbm90aGVyCj4gcHJvY2Vzcy4KPgo+Pj4g
SSB0aGluayB3ZSBkb24ndCBuZWVkCj4+PiBhIGZkIGluIHVtZW0gY2FzZSBzaW5jZSB0aGUgdXNl
cnNwYWNlIGRhZW1vbiBjYW4gYWNjZXNzIHRoZSBtZW1vcnkKPj4+IGRpcmVjdGx5IHdpdGhvdXQg
dXNpbmcgbW1hcCgpIHRvIG1hcCBpdCBpbnRvIHRoZSBhZGRyZXNzIHNwYWNlIGluCj4+PiBhZHZh
bmNlLgo+PiBPaywgSSB3aWxsIGhhdmUgYSBsb29rIGF0IHRoZSBjb2RlIGFuZCBnZXQgYmFjay4K
Pj4KPiBPSy4gTG9va2luZyBmb3J3YXJkIHRvIHlvdXIgcmVwbHkuCgoKTG9va3MgZ29vZCBvdmVy
YWxsLgoKSnVzdCBmZXcgY29tbWVudHMuCgpUaGFua3MKCgo+Cj4gVGhhbmtzLAo+IFlvbmdqaQo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
