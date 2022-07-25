Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF57C43334
	for <virtualization@archiver.kernel.org>; Mon, 25 Jul 2022 11:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C6F961B81;
	Mon, 25 Jul 2022 11:37:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C6F961B81
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OyXFB3Mq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WtglXJPJ_uVc; Mon, 25 Jul 2022 11:37:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 59C3D6105B;
	Mon, 25 Jul 2022 11:37:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 59C3D6105B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27F7AC0033;
	Mon, 25 Jul 2022 11:37:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16B07C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 11:37:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D09F640586
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 11:37:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D09F640586
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OyXFB3Mq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HhhnxTV3Kmy9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 11:37:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A27AD404C2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A27AD404C2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 11:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658749019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t3DEzKG6tvVsHWaP5dFq4DXrdAEnDuBtMJb3V6pCFU0=;
 b=OyXFB3MqSimMqrNbaQ2ZNuj2RgUDMe5yz6NswOPeUOg/nwThe1/8vbicj2qTOHVT8J4Jiy
 X2DhQ9Qk5UwLGlIWKhUPnYhVN5SbDk2UgS780VBqHyQH555PA5FAFi1qSuQ8+nyJRrfvHb
 NzlGOCdnRl3A7IXEa3fbgcTqiq/Ovic=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-Y723cUQvMWmaO-VKlGanLw-1; Mon, 25 Jul 2022 07:36:58 -0400
X-MC-Unique: Y723cUQvMWmaO-VKlGanLw-1
Received: by mail-wm1-f72.google.com with SMTP id
 i184-20020a1c3bc1000000b003a026f48333so6052391wma.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 04:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=t3DEzKG6tvVsHWaP5dFq4DXrdAEnDuBtMJb3V6pCFU0=;
 b=Yla814nnvuEwhRaDoOlkNtGVio9/SBd16CSssINqKnbL6Kk10MHE1rW3QFhR+3s/ry
 1rd1B1ZD/FxSJvoUzDCXh+gJD+mcQJmGwZOV+LmpSvlfGcNcpQB4Xz5/YnKrDb2BATaA
 lAFiZGSI9+q9KElnQcNjsyexUr8DXUIzakaWR8GFKvrMbAJDdHIkSkinlmt4a4q/V4J5
 9YCt+QFrNsdW6VhuMhTwuCtOTsR56cuu0mhklLqZv+himP1h4xucX2PPCGLXSPdvgCs+
 UkMfp+oXiC9bkadqaYF+Hw+d+lMXsQo36FRJ3ZaAulZO869IEIBD0rFEU54A1jQFiUdl
 m/8g==
X-Gm-Message-State: AJIora+NHdkBxFAUUNoE7UD0Lb59gfQ1XZRcccfDt1DIgCw3ofoDJ5rT
 rKWY30MHKsNHxBaOa6GPa17BzlzWOIrWQp0QMzT0PtppmGVR5uPDoHQt9LEPiO+WmmZxjynYxms
 GAfw4IfBZR4BpXrUbrDbpbBLH45MigrSLkaWd23BNXg==
X-Received: by 2002:a05:600c:1993:b0:3a3:3eb0:9102 with SMTP id
 t19-20020a05600c199300b003a33eb09102mr11540524wmq.72.1658749016789; 
 Mon, 25 Jul 2022 04:36:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vL9EjkwMZINzUqlk5EeL4tBf44YYFF4pa31k6djksa8I6JbHuBxCEjg70v7EZ4h3lsCoHonQ==
X-Received: by 2002:a05:600c:1993:b0:3a3:3eb0:9102 with SMTP id
 t19-20020a05600c199300b003a33eb09102mr11540508wmq.72.1658749016489; 
 Mon, 25 Jul 2022 04:36:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:8c00:eee4:63f0:cef2:5ac0?
 (p200300cbc7048c00eee463f0cef25ac0.dip0.t-ipconnect.de.
 [2003:cb:c704:8c00:eee4:63f0:cef2:5ac0])
 by smtp.gmail.com with ESMTPSA id
 i24-20020a1c5418000000b003a3187a2d4csm17892774wmb.22.2022.07.25.04.36.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Jul 2022 04:36:56 -0700 (PDT)
Message-ID: <55016ed9-7b3c-c4eb-f5f4-02cfce2191e4@redhat.com>
Date: Mon, 25 Jul 2022 13:36:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 1/1] Create debugfs file with virtio balloon usage
 information
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <7fd5e645-3892-6e0d-de80-08728e29b150@redhat.com>
 <20220714132053.56323-1-alexander.atanasov@virtuozzo.com>
 <0b660226-28dc-1f1d-e22e-34805dc5b25d@redhat.com>
 <865e4da3-94fe-95dc-cbe3-161fa8c2146d@virtuozzo.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <865e4da3-94fe-95dc-cbe3-161fa8c2146d@virtuozzo.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kernel@openvz.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

T24gMjUuMDcuMjIgMTM6MjcsIEFsZXhhbmRlciBBdGFuYXNvdiB3cm90ZToKPiBIaSwKPiAKPiBP
biAxOC8wNy8yMDIyIDE0OjM1LCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToKPj4gT24gMTQuMDcu
MjIgMTU6MjAsIEFsZXhhbmRlciBBdGFuYXNvdiB3cm90ZToKPj4+IEFsbG93IHRoZSBndWVzdCB0
byBrbm93IGhvdyBtdWNoIGl0IGlzIGJhbGxvb25lZCBieSB0aGUgaG9zdC4KPj4+IEl0IGlzIHVz
ZWZ1bCB3aGVuIGRlYnVnZ2luZyBvdXQgb2YgbWVtb3J5IGNvbmRpdGlvbnMuCj4+Pgo+Pj4gV2hl
biBob3N0IGdldHMgYmFjayBtZW1vcnkgZnJvbSB0aGUgZ3Vlc3QgaXQgaXMgYWNjb3VudGVkCj4+
PiBhcyB1c2VkIG1lbW9yeSBpbiB0aGUgZ3Vlc3QgYnV0IHRoZSBndWVzdCBoYXZlIG5vIHdheSB0
byBrbm93Cj4+PiBob3cgbXVjaCBpdCBpcyBhY3R1YWxseSBiYWxsb29uZWQuCj4+Pgo+Pj4gU2ln
bmVkLW9mZi1ieTogQWxleGFuZGVyIEF0YW5hc292IDxhbGV4YW5kZXIuYXRhbmFzb3ZAdmlydHVv
enpvLmNvbT4KPj4+IC0tLQo+Pj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fYmFsbG9vbi5jICAg
ICB8IDc5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+PiAgIGluY2x1ZGUvdWFwaS9s
aW51eC92aXJ0aW9fYmFsbG9vbi5oIHwgIDEgKwo+Pj4gICAyIGZpbGVzIGNoYW5nZWQsIDgwIGlu
c2VydGlvbnMoKykKPj4+Cj4+PiBWMjoKPj4+ICAgLSBmaXhlZCBjb2Rpbmcgc3R5bGUKPj4+ICAg
LSByZW1vdmVkIHByZXR0eSBwcmludAo+Pj4gVjM6Cj4+PiAgIC0gcmVtb3ZlZCBkdWJsaWNhdGUg
b2YgZmVhdHVyZXMKPj4+ICAgLSBjb21tZW50IGFib3V0IGJhbG9vbmVkX3BhZ2VzIG1vcmUgY2xl
YXIKPj4+ICAgLSBjb252ZXJ0IGhvc3QgcGFnZXMgdG8gYmFsbG9vbiBwYWdlcwo+Pj4gVjQ6Cj4+
PiAgIC0gYWRkZWQgYSBkZWZpbmUgZm9yIEJBTExPT05fUEFHRV9TSVpFIHRvIG1ha2UgdGhpbmdz
IGNsZWFyCj4+PiBWNToKPj4+ICAgLSBNYWRlIHRoZSBjYWxjdWxhdG9ucyB3b3JrIHByb3Blcmx5
IGZvciBib3RoIHdheXMgb2YgbWVtb3J5IGFjY291bnRpbmcKPj4+ICAgICB3aXRoIG9yIHdpdGhv
dXQgZGVmbGF0ZV9vbl9vb20KPj4+ICAgLSBkcm9wcGVkIGNvbW1lbnQKPj4+Cj4gWy4uLi5dCj4+
PiArCXUzMiBudW1fcGFnZXMsIHRvdGFsX3BhZ2VzLCBjdXJyZW50X3BhZ2VzOwo+Pj4gKwlzdHJ1
Y3Qgc3lzaW5mbyBpOwo+Pj4gKwo+Pj4gKwlzaV9tZW1pbmZvKCZpKTsKPj4+ICsKPj4+ICsJc2Vx
X3ByaW50ZihmLCAiJS0yMnM6ICVkXG4iLCAicGFnZV9zaXplIiwgVklSVElPX0JBTExPT05fUEFH
RV9TSVpFKTsKPj4gV2h5PyBFaXRoZXIgZXhwb3J0IGFsbCBpbiBvcmRpbmFyeSBwYWdlIHNpemUg
b3IgaW4ga0IuIE5vIG5lZWQgdG8KPj4gb3Zlci1jb21wbGljYXRlIHRoZSBpbnRlcmZhY2Ugd2l0
aCBhIGRpZmZlcmVudCBwYWdlIHNpemUgdGhhdCB1c2Vycwo+PiBkb24ndCBhY3R1YWxseSBjYXJl
IGFib3V0Lgo+Pgo+PiBJJ2QganVzdCBzdGljayB0byAvcHJvYy9tZW1pbmZvIGFuZCB1c2Uga0Iu
Cj4gCj4gVGhlIHBvaW50IGlzIHRvIGV4cG9zZSBzb21lIGludGVybmFsIGJhbGxvb24gZGF0YS4g
QmFsbG9vbiB3b3JrcyB3aXRoIAo+IHBhZ2VzIG5vdCB3aXRoIGtCwqAgYW5kIHVzZXJzIGNhbiBl
YXNpbHkgY2FsY3VsYXRlIGtCLgoKUGFnZXMgdHJhbnNsYXRlIHRvIEtCLiBrQiBhcmUgZWFzeSB0
byBjb25zdW1lIGJ5IGh1bWFucyBpbnN0ZWFkIG9mIHBhZ2VzCndpdGggdmFyaWFibGUgYXBnZSBz
aXplcwoKPiAKPj4+ICsKPj4+ICsJc2VxX3ByaW50ZihmLCAiJS0yMnM6ICV1XG4iLCAiYmFsbG9v
bmVkX3BhZ2VzIiwgbnVtX3BhZ2VzKTsKPj4+ICsKPj4+ICsJaWYgKHZpcnRpb19oYXNfZmVhdHVy
ZShiLT52ZGV2LCBWSVJUSU9fQkFMTE9PTl9GX0RFRkxBVEVfT05fT09NKSkgewo+Pj4gKwkJdG90
YWxfcGFnZXMgPSBndWVzdF90b19iYWxsb29uX3BhZ2VzKGkudG90YWxyYW0pOwo+Pj4gKwkJY3Vy
cmVudF9wYWdlcyA9IGd1ZXN0X3RvX2JhbGxvb25fcGFnZXMoaS50b3RhbHJhbSkgLSBudW1fcGFn
ZXM7Cj4+PiArCX0gZWxzZSB7Cj4+PiArCQl0b3RhbF9wYWdlcyA9IGd1ZXN0X3RvX2JhbGxvb25f
cGFnZXMoaS50b3RhbHJhbSkgKyAgbnVtX3BhZ2VzOwo+Pj4gKwkJY3VycmVudF9wYWdlcyA9IGd1
ZXN0X3RvX2JhbGxvb25fcGFnZXMoaS50b3RhbHJhbSk7Cj4+PiArCX0KPj4+ICsKPj4+ICsJLyog
VG90YWwgTWVtb3J5IGZvciB0aGUgZ3Vlc3QgZnJvbSBob3N0ICovCj4+PiArCXNlcV9wcmludGYo
ZiwgIiUtMjJzOiAldVxuIiwgInRvdGFsX3BhZ2VzIiwgdG90YWxfcGFnZXMpOwo+Pj4gKwo+Pj4g
KwkvKiBDdXJyZW50IG1lbW9yeSBmb3IgdGhlIGd1ZXN0ICovCj4+PiArCXNlcV9wcmludGYoZiwg
IiUtMjJzOiAldVxuIiwgImN1cnJlbnRfcGFnZXMiLCBjdXJyZW50X3BhZ2VzKTsKPj4gVGhlIHRo
aW5rIEkgZGV0ZXN0IGFib3V0IHRoYXQgaW50ZXJmYWNlICh0b3RhbC9jdXJyZW50KSBpcyB0aGF0
IGl0J3MKPj4gc2ltcGx5IG5vdCBjb3JyZWN0IC0tIGJlY2F1c2UgaS50b3RhbHJhbSBmb3IgZXhh
bXBsZSBkb2Vzbid0IGluY2x1ZGUKPj4gdGhpbmdzIGxpa2UgKHNpbWlsYXIgdG8gTWVtVG90YWwg
aW4gL3Byb2MvbWVtaW5mbykKPj4KPj4gYSkgY3Jhc2hrZXJuZWwKPj4gYikgZWFybHkgYm9vdCBh
bGxvY2F0aW9ucyAoZS5nLiwgbWVtbWFwKQo+PiBjKSBhbnkga2luZCBvZiBwb3NzaWJsZSBtZW1v
cnkgKHVuKWhvdHBsdWcgaW4gdGhlIGZ1dHVyZQo+Pgo+PiBJJ2QgcmVhbGx5IHN1Z2dlc3QgdG8g
anVzdCBLSVMgYW5kIG5vdCBtZXNzIHdpdGggaS50b3RhbHJhbS4KPj4KPj4gRXhwb3NpbmcgaG93
IG11Y2ggbWVtb3J5IGlzIGluZmxhdGVkIGFuZCBzb21lIHdheSB0byBpZGVudGlmeSBob3cgdGhh
dAo+PiBtZW1vcnkgaXMgYWNjb3VudGVkIGluIC9wcm9jL21lbWluZm8gc2hvdWxkIGJlIGdvb2Qg
ZW5vdWdoLgo+Pgo+PiBFLmcuLCB0aGUgb3V0cHV0IGhlcmUgY291bGQgc2ltcGx5IGJlCj4+Cj4+
ICJJbmZsYXRlZDogMTAyNCBrQiIKPj4gIk1lbVRvdGFsUmVkdWNlZDogMTAyNCBrQiIKPj4KPj4g
VGhhdCB3b3VsZCBldmVuIGFsbG93IGluIHRoZSBmdXR1cmUgZm9yIGZsZXhpYmlsaXR5IHdoZW4g
aXQgY29tZXMgdG8gaG93Cj4+IG11Y2gvd2hhdCB3YXMgYWN0dWFsbHkgc3VidHJhY3RlZCBmcm9t
IE1lbVRvdGFsLgo+IAo+IAo+IFRoZSBwb2ludCBvZiB0aGUgZGVidWcgaW50ZXJmYWNlIGlzIHRv
IGV4cG9zZSBzb21lIG9mIHRoZSBiYWxsb29uIGRyaXZlciAKPiBpbnRlcm5hbHMgdG8gdGhlIGd1
ZXN0Lgo+IAo+IFRoZSB1c2VycyBvZiB0aGlzIGFyZSB1c2VyIHNwYWNlIHByb2Nlc3NlcyB0aGF0
IHRyeSB0byB3b3JrIGFjY29yZGluZyB0byAKPiB0aGUgbWVtb3J5IHByZXNzdXJlIGFuZCBuZXN0
ZWQgdmlydHVhbGl6YXRpb24uCj4gCj4gSSBoYXZlbid0IHNlZW4gb25lIHVzZXJzcGFjZSBzb2Z0
d2FyZSB0aGF0IGV4cGVjdHMgdG90YWwgcmFtIHRvIGNoYW5nZSwgCj4gaXQgc2hvdWxkIGJlIGNv
bnN0YW50IHdpdGggb25lIGV4Y2VwdGlvbiBob3RwbHVnLiBCdXQgaWYgeW91IGRvwqAgaG90cGx1
ZyAKPiBSQU0geW91IGtub3cgdGhhdCBhbmQgeW91IGNhbiByZXN0YXJ0IHdoYXQgeW91IG5lZWQg
dG8gcmVzdGFydC4KPiAKPiBTbyBpbnN0ZWFkIG9mIG1lc3Npbmcgd2l0aCB0b3RhbHJhbSB3aXRo
IGFkZGluZyBvciByZW1vdmluZyBwYWdlcyAvaXQgCj4gd291bGQgZXZlbiBiZSBvcHRpbWl6YXRp
b24gc2luY2Ugbm93IGl0IGlzIGRvbmUgcGFnZSBieSBwYWdlLyBpIHN1Z2dlc3QgCj4gdG8ganVz
dCBhY2NvdW50IHRoZSBpbmZsYXRlZCBtZW1vcnkgYXMgdXNlZCBhcyBpbiB0aGUgZGVmbGF0ZV9v
bl9vb20gCj4gY2FzZSBub3cuIEl0IGlzIGNvbmZ1c2luZyBhbmQgaW5jb25zaXN0ZW50IGFzIGl0
IGlzIG5vdy4gSG93IHRvwqAgZXhwbGFpbiAKPiB0byBhIHZwcyB1c2VyIHdoeSBoaXMgUkFNIGlz
IGNvbnN0YW50bHkgY2hhbmdpbmc/Cj4gCj4gQW5kIHRoZSBmaWxlIGNhbiBnbyBqdXN0IHRvCj4g
Cj4gaW5mbGF0ZWQ6IDxwYWdlcz4KPiAKPiBiYWxsb25fcGFnZV9zaXplOsKgIDQwOTYKPiAKPiBv
cgo+IAo+IGluZmxhdGVkOiBrQgo+IAo+IEkgcHJlZmVyIHBhZ2VzIGJlY2F1c2Ugb24gdGhlb3J5
IGd1ZXN0IGFuZCBob3N0IGNhbiBkaWZmZXJlbnQgc2l6ZSBhbmQgCj4gaWYgYXQgc29tZSBwb2lu
dCBndWVzdCBzdGFydHMgdG8gbWFrZSByZXF1ZXN0cyB0byB0aGUgaG9zdCBmb3IgcGFnZXMgaXQg
Cj4gbXVzdCBzb21laG93IGtub3cgd2hhdCB0aGUgaG9zdC9iYWxsb29uIHBhZ2UgaXMuIFNpbmNl
IHlvdSBoYXZlIGFsbCB0aGUgCj4gaW5mb3JtYXRpb24gYXQgb25lIHBsYWNlIGl0IGlzIGVhc3kg
dG8gY2FsY3VsYXRlIGtCLiBCdXQgeW91IGNhbiBub3QgCj4gY2FsY3VsYXRlIHBhZ2VzIGZyb20g
b25seSBrQi4KClRoZSBob3N0IGNhbiBvbmx5IGluZmxhdGUgaW4gZ3Vlc3QtcGFnZSBiYXNlIHNp
emVzLiBIb3cgdGhhdCB0cmFuc2xhdGVzCnRvIGhvc3QtcGFnZSBiYXNlIHNpemVzIGlzIGFic29s
dXRlbHkgaXJyZWxldmFudC4KCldobyBzaG91bGQgY2FyZSBhYm91dCBwYWdlcz8gQWJzb2x1dGVs
eSBpcnJlbGV2YW50LgoKR3Vlc3QgcGFnZXM6IGtCIC8gZ2V0cGFnZXNpemUoKQpMb2dpY2FsIGJh
bGxvb24gcGFnZXM6IGtCIC8gNGsKSG9zdCBwYWdlczogPz8/Cgo+IAo+IExhdGVyIG9uIHdoZW4g
aG90cGx1ZyBjb21lcyBpdCBjYW4gYWRkIGl0J3Mgb3duIGRhdGEgdG8gdGhlIGZpbGUgc28gaXQg
Cj4gY2FuIGJlIHVzZWQgdG8gc2VlIHRoZSBhbW91bnQgdGhhdCBpcyBhZGRlZCB0byB0aGUgdG90
YWwgcmFtLgo+IAo+IEl0IGNhbiBhZGQKPiAKPiBob3RwbHVnZ2VkOiA8cGFnZXM+Cj4gCj4gCj4g
V2hhdCBkbyB5b3UgdGhpbms/CgpMZXQncyBrZWVwIHRoaXMgaW50ZXJmYWNlIHNpbXBsZSwgcGxl
YXNlLgoKLS0gClRoYW5rcywKCkRhdmlkIC8gZGhpbGRlbmIKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
