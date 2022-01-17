Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06928C433F5
	for <virtualization@archiver.kernel.org>; Mon, 17 Jan 2022 10:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 55C1640585;
	Mon, 17 Jan 2022 10:25:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iFTpKqElGbQq; Mon, 17 Jan 2022 10:25:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 37E0A401DD;
	Mon, 17 Jan 2022 10:25:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDDFFC0031;
	Mon, 17 Jan 2022 10:25:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99885C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 10:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7622581416
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 10:25:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KS9oyVO6itUB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 10:25:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 396A081410
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 10:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642415116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bRTOEGKQdU6bW9SvqAbl8ZaW57LsRIIgasIMjL77UE4=;
 b=JmYd/6/siFUUB4pMnotQhRmpxtBWzCJ+vbtx9DOaszGY91lN4UlxOZkprbbKeZWsY6o7aQ
 syUh5RdwIT2lsjFxWiEPkOGNO/U3kD2LYFkd5u1q7VmABGtpxNGMHgrpDUfYqNjeqwnlHg
 RbJct60b4Q2+9CwD6JpTuA+k19ewkgs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45--vndIBuqNWe517AZGes9Dw-1; Mon, 17 Jan 2022 05:25:15 -0500
X-MC-Unique: -vndIBuqNWe517AZGes9Dw-1
Received: by mail-wm1-f72.google.com with SMTP id
 i81-20020a1c3b54000000b003467c58cbddso13620403wma.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 02:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=bRTOEGKQdU6bW9SvqAbl8ZaW57LsRIIgasIMjL77UE4=;
 b=CluchvV4RTKRf08FNYHrPhVNWezj2asGl4wVRp3FZib9Sl4C6QU/Tj/YlEuPnroqHs
 6/S3bagOuPYIwIa+NVrtG/jJTIGqn0F96LF+2QsMBJ51hgVNboWdBSrIQtvyjMNPxgKN
 P89rxLsh0y9xTeal/N4BUAy/z/WF4zr+Kct3kDzHP4clNeVBFECHS1m25C/afqRrgH9W
 oGQnFgZKifioQAthoia0WV1DoYqQZ+2lp2/OoOltlKzC0H7bCG4u5Nq3/+vrGp9oUP9O
 nxI8OJMHgF1pJzzpi72xX+61BqdfzTd2lMDRMf13jeTIy3gI14gBBxt4aoKVBvGPPJ5F
 Xhig==
X-Gm-Message-State: AOAM531sCAzJbJAeldWES+rF/ZEs1qjCXr+GknDFNCXPzQbvhlsO3ka3
 gqWSYTBE2bizZ90o1geA4iyFfXmOxRLhZ2/CYK6pF5P3bnWjXa1/Ue14UO5zIgL+ftXlAHVNnJJ
 4/sON1m7M3WYtD4/STvOFvsVvF1ZUdGwkpJs9vDXfuw==
X-Received: by 2002:a5d:4e4c:: with SMTP id r12mr18488124wrt.666.1642415114325; 
 Mon, 17 Jan 2022 02:25:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPl7bnqFISpEF/IIt3W1vtdnK3spv2RFZfeF9T3ymO2IE/CL/KSw+I3yjrleUpAezP6l+kbQ==
X-Received: by 2002:a5d:4e4c:: with SMTP id r12mr18488107wrt.666.1642415114112; 
 Mon, 17 Jan 2022 02:25:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:dd00:68a1:1bd:6733:bde9?
 (p200300cbc705dd0068a101bd6733bde9.dip0.t-ipconnect.de.
 [2003:cb:c705:dd00:68a1:1bd:6733:bde9])
 by smtp.gmail.com with ESMTPSA id p15sm11141294wrw.93.2022.01.17.02.25.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jan 2022 02:25:13 -0800 (PST)
Message-ID: <44f4ee97-562c-ce37-a5af-9f58e052f3a9@redhat.com>
Date: Mon, 17 Jan 2022 11:25:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] virtio_mem: break device on remove
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220114214324.239444-1-mst@redhat.com>
 <1f703ebf-0f78-e530-0fe1-163613397cad@redhat.com>
 <20220117025341-mutt-send-email-mst@kernel.org>
 <7ec8218e-9d76-a9b7-ccd0-b7c8ce257fe2@redhat.com>
 <20220117033644-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220117033644-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gMTcuMDEuMjIgMDk6NDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBNb24sIEph
biAxNywgMjAyMiBhdCAwOTozMTo1NkFNICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToK
Pj4gT24gMTcuMDEuMjIgMDg6NTUsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+IE9uIE1v
biwgSmFuIDE3LCAyMDIyIGF0IDAyOjQwOjExUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
Pj4KPj4+PiDlnKggMjAyMi8xLzE1IOS4iuWNiDU6NDMsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnp
gZM6Cj4+Pj4+IEEgY29tbW9uIHBhdHRlcm4gZm9yIGRldmljZSByZXNldCBpcyBjdXJyZW50bHk6
Cj4+Pj4+IHZkZXYtPmNvbmZpZy0+cmVzZXQodmRldik7Cj4+Pj4+IC4uIGNsZWFudXAgLi4KPj4+
Pj4KPj4+Pj4gcmVzZXQgcHJldmVudHMgbmV3IGludGVycnVwdHMgZnJvbSBhcnJpdmluZyBhbmQg
d2FpdHMgZm9yIGludGVycnVwdAo+Pj4+PiBoYW5kbGVycyB0byBmaW5pc2guCj4+Pj4+Cj4+Pj4+
IEhvd2V2ZXIgaWYgLSBhcyBpcyBjb21tb24gLSB0aGUgaGFuZGxlciBxdWV1ZXMgYSB3b3JrIHJl
cXVlc3Qgd2hpY2ggaXMKPj4+Pj4gZmx1c2hlZCBkdXJpbmcgdGhlIGNsZWFudXAgc3RhZ2UsIHdl
IGhhdmUgY29kZSBhZGRpbmcgYnVmZmVycyAvIHRyeWluZwo+Pj4+PiB0byBnZXQgYnVmZmVycyB3
aGlsZSBkZXZpY2UgaXMgcmVzZXQuIE5vdCBnb29kLgo+Pj4+Pgo+Pj4+PiBUaGlzIHdhcyByZXBy
b2R1Y2VkIGJ5IHJ1bm5pbmcKPj4+Pj4gCW1vZHByb2JlIHZpcnRpb19jb25zb2xlCj4+Pj4+IAlt
b2Rwcm9iZSAtciB2aXJ0aW9fY29uc29sZQo+Pj4+PiBpbiBhIGxvb3AsIGFuZCB0aGlzIHJlYXNv
bmluZyBzZWVtcyB0byBhcHBseSB0byB2aXJ0aW8gbWVtIHRob3VnaAo+Pj4+PiBJIGNvdWxkIG5v
dCByZXByb2R1Y2UgaXQgdGhlcmUuCj4+Pj4+Cj4+Pj4+IEZpeCB0aGlzIHVwIGJ5IGNhbGxpbmcg
dmlydGlvX2JyZWFrX2RldmljZSArIGZsdXNoIGJlZm9yZSByZXNldC4KPj4+Pj4KPj4+Pj4gU2ln
bmVkLW9mZi1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPj4+Pj4gLS0t
Cj4+Pj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX21lbS5jIHwgMiArKwo+Pj4+PiAgIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19tZW0uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19tZW0uYwo+Pj4+
PiBpbmRleCAzOGJlY2Q4ZDU3OGMuLjMzYjhhMTE4YTNhZSAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJp
dmVycy92aXJ0aW8vdmlydGlvX21lbS5jCj4+Pj4+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19tZW0uYwo+Pj4+PiBAQCAtMjg4OCw2ICsyODg4LDggQEAgc3RhdGljIHZvaWQgdmlydGlvX21l
bV9yZW1vdmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4+Pj4+ICAgCQl2aXJ0aW9fbWVt
X2RlaW5pdF9ob3RwbHVnKHZtKTsKPj4+Pj4gICAJLyogcmVzZXQgdGhlIGRldmljZSBhbmQgY2xl
YW51cCB0aGUgcXVldWVzICovCj4+Pj4+ICsJdmlydGlvX2JyZWFrX2RldmljZSh2ZGV2KTsKPj4+
Pj4gKwlmbHVzaF93b3JrKCZ2bS0+d3EpOwo+Pj4+Cj4+Pj4KPj4+PiBXZSBzZXQgdm0tPnJlbW92
aW5nIHRvIHRydWUgYW5kIGNhbGwgY2FuY2VsX3dvcmtfc3luYygpIGluCj4+Pj4gdmlydGlvX21l
bV9kZWluaXRfaG90cGx1ZygpLiBJc24ndCBpcyBzdWZmaWNpZW50Pwo+Pj4+Cj4+Pj4gVGhhbmtz
Cj4+Pgo+Pj4KPj4+IEhtbSBJIHRoaW5rIHlvdSBhcmUgcmlnaHQuIERhdmlkLCBJIHdpbGwgZHJv
cCB0aGlzIGZvciBub3cuCj4+PiBVcCB0byB5b3UgdG8gY29uc2lkZXIgd2hldGhlciBzb21lIGNl
bnRyYWwgY2FwYWJpbGl0eSB3aWxsIGJlCj4+PiBoZWxwZnVsIGFzIGEgcmVwbGFjZW1lbnQgZm9y
IHRoZSB2aXJ0aW8tbWVtIHNwZWNpZmljICJyZW1vdmluZyIgZmxhZy4KPj4KPj4gSXQncyBhbGwg
YSBiaXQgdHJpY2t5IGJlY2F1c2Ugd2UgYWxzbyBoYXZlIHRvIGhhbmRsZSBwZW5kaW5nIHRpbWVy
cyBhbmQKPj4gcGVuZGluZyBtZW1vcnkgb25saW5pbmcvb2ZmbGluaW5nIG9wZXJhdGlvbnMgaW4g
YSBjb250cm9sbGVkIHdheS4gTWF5YmUKPj4gd2UgY291bGQgY29udmVydCB0byB2aXJ0aW9fYnJl
YWtfZGV2aWNlKCkgYW5kIHVzZSB0aGUKPj4gJmRldi0+dnFzX2xpc3RfbG9jayBhcyBhIHJlcGxh
Y2VtZW50IGZvciB0aGUgcmVtb3ZhbF9sb2NrLiBIb3dldmVyLCBJJ20KPj4gbm90IDEwMCUgc3Vy
ZSBpZiBpdCdzIG5pY2UgdG8gdXNlIHRoYXQgbG9jayBmcm9tCj4+IGRyaXZlcnMvdmlydGlvL3Zp
cnRpb19tZW0uYyBkaXJlY3RseS4KPiAKPiBXZSBjb3VsZCBhZGQgYW4gQVBJIGlmIHlvdSBsaWtl
LiBPciBtYXliZSBpdCBtYWtlcyBzZW5zZSB0byBhZGQgYQo+IHNlcGFyYXRlIG9uZSB0aGF0IGxl
dHMgeW91IGZpbmQgb3V0IHRoYXQgcmVtb3ZhbCBzdGFydGVkLiBOZWVkIHRvIGZpZ3VyZQo+IG91
dCBob3cgdG8gaGFuZGxlIHN1c3BlbmQgdG9vIHRoZW4gLi4uCj4gR2VuZXJhbGx5IHdlIGhhdmUg
dGhlc2UgY2hlY2tzIHRoYXQgZGV2aWNlIGlzIG5vdCBnb2luZyBhd2F5Cj4gc3ByaW5rbGVkIG92
ZXIgYWxsIGRyaXZlcnMgYW5kIEkgZG9uJ3QgbGlrZSBpdCwgYnV0Cj4gaXQncyBub3QgZWFzeSB0
byBidWlsZCBhIHNhbmUgQVBJIHRvIGhhbmRsZSBpdCwgZXNwZWNpYWxseQo+IGZvciBoaWdoIHNw
ZWVkIHRoaW5ncyB3aGVuIHdlIGNhbid0IHRha2UgbG9ja3MgYmVjYXVzZSBwZXJmb3JtYW5jZS4K
ClRoZSBpbnRlcmVzdGluZyBjYXNlIG1pZ2h0IGJlIGhvdyB0byBoYW5kbGUgdmlydGlvX21lbV9y
ZXRyeSgpLCB3aGVyZWJ5CndlIGNvbmRpdGlvbmFsbHkgcXVldWUgd29yayBpZiAhcmVtb3Zpbmcu
CgpIYXZpbmcgdGhhdCBzYWlkLCBpbiBhbiBpZGVhbCB3b3JsZCB3ZSBjb3VsZCBkZW55IHJlbW92
YWwgcmVxdWVzdHMgZm9yCnZpcnRpb19tZW0gY29tcGxldGVseSBpZiB0aGVyZSBpcyBzdGlsbCBh
bnkgbWVtb3J5IGFkZGVkIHRvIHRoZSBzeXN0ZW0gLi4uCgoKLS0gClRoYW5rcywKCkRhdmlkIC8g
ZGhpbGRlbmIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
