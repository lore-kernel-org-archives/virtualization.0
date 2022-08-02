Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E00C00140
	for <virtualization@archiver.kernel.org>; Tue,  2 Aug 2022 13:48:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBCA780D3D;
	Tue,  2 Aug 2022 13:48:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DBCA780D3D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e1U0xpB1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e6lULoXlJCnE; Tue,  2 Aug 2022 13:48:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4C80280C3B;
	Tue,  2 Aug 2022 13:48:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C80280C3B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09D75C0032;
	Tue,  2 Aug 2022 13:48:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3B42C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Aug 2022 13:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CA8340281
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Aug 2022 13:48:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7CA8340281
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=e1U0xpB1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oCIxJAVU4fAo
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Aug 2022 13:48:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EAB734027C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EAB734027C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Aug 2022 13:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659448110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OrwE3Ag22dL3OQ2ksEp1YwraLinA6Mssgv+fkDSYVVA=;
 b=e1U0xpB1dZv8LxjSHyZzuw3oBphow7sG6otpOWgyF31GqwnLbpQ1T3UzI//FIb9VRMCI01
 1MhIfrXVZLxfTfy6BxvgBe31F4MuOjiFjfEaAAfyb6f0Cnxy6nrBa8JztGQVzcdQVgQAfD
 LiNhqVhbpnL8lsFQ9P5KpzOVVV0wCzk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-wgggcz1RPZCHDeckBLJ38Q-1; Tue, 02 Aug 2022 09:48:29 -0400
X-MC-Unique: wgggcz1RPZCHDeckBLJ38Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 v130-20020a1cac88000000b003a4f057ed9fso344098wme.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Aug 2022 06:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=OrwE3Ag22dL3OQ2ksEp1YwraLinA6Mssgv+fkDSYVVA=;
 b=Ka8esUYm1bCocG7qpT7hQrf+203kkm3eDlCsCZs8KXS5Wna9x6KNXYOe1ToVozBg/V
 MMT6d581olr1dFO7p3l4cZiUYb5X45NCxBW53/Hyk+4bx5oTRL9cE0YrUW8d8rvmXHLH
 Mg0gfZLy4tny6CdRLYKPb9e1s3x/Eqou0M3/hJ9EYsuet6zQ+Mj8sGXCulbTdBPrVZV/
 +Rb0AN4EIjKB8OqBssPlOHkyOOhfi/LiPSM7jpZ9VRMzkNCLeL7bQW3swiOX/x9KbObn
 u/8DTZtbsIFBknfPHntO054qTjtVXFPtJ2CMWrCsZwkNRa8E1oyQyUh8rT1jTrGUqNlb
 2okQ==
X-Gm-Message-State: AJIora8XTwi4yOk2LHBKuT7YTglRSJ1TfhwDWejbjvT/mCnmBcuUgSt6
 EnJnMfO6qdaIbtkyzlmbxbWXIvPs2hBABhpwTLa39sdOt4XT9fChI0oBbg0+JfekdGgSQBpelQy
 BHbhF86Nmicn1GF1ljK5Sx7ltkHIoV+lA2NwuHXH4pA==
X-Received: by 2002:a1c:f710:0:b0:394:1960:e8a1 with SMTP id
 v16-20020a1cf710000000b003941960e8a1mr14360937wmh.154.1659448108425; 
 Tue, 02 Aug 2022 06:48:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v9Dgd3H45ZrMwAMcmmB5W4HzBAT4j3DZORAVdakwAplU9KXQO2uIkeIGZbm3F6/tcCZdIByg==
X-Received: by 2002:a1c:f710:0:b0:394:1960:e8a1 with SMTP id
 v16-20020a1cf710000000b003941960e8a1mr14360915wmh.154.1659448108091; 
 Tue, 02 Aug 2022 06:48:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3800:8435:659e:f80:9b3d?
 (p200300cbc70738008435659e0f809b3d.dip0.t-ipconnect.de.
 [2003:cb:c707:3800:8435:659e:f80:9b3d])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a5d4fc3000000b0021eba590ad1sm17427218wrw.90.2022.08.02.06.48.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Aug 2022 06:48:27 -0700 (PDT)
Message-ID: <f0f12c84-a62e-5f8b-46ab-a651fe8f8589@redhat.com>
Date: Tue, 2 Aug 2022 15:48:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <55016ed9-7b3c-c4eb-f5f4-02cfce2191e4@redhat.com>
 <20220726140831.72816-1-alexander.atanasov@virtuozzo.com>
 <2d0703da-ae89-7002-f500-300a4b5d206b@redhat.com>
 <3a5e60e8-a0d2-a1f1-28e9-e0b45069029a@virtuozzo.com>
 <71e73194-1683-b65f-7b84-c0c719010aef@redhat.com>
 <2dfad5c8-59d2-69a1-cc4c-d530c12ceea9@virtuozzo.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] how the ballooned memory should be accounted by the drivers
 inside the guests? (was:[PATCH v6 1/2] Create debugfs file with virtio
 balloon usage information)
In-Reply-To: <2dfad5c8-59d2-69a1-cc4c-d530c12ceea9@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Juergen Gross <jgross@suse.com>, Wei Liu <wei.liu@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Haiyang Zhang <haiyangz@microsoft.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kernel@openvz.org,
 stevensd@chromium.org, Johannes Weiner <hannes@cmpxchg.org>,
 Nadav Amit <namit@vmware.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
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

Pj4KPj4gSW4gY2FzZSBvZiBIeXBlci1WIEkgcmVtZW1iZXIgYSBjdXN0b21lciBCVUcgcmVwb3J0
IHRoYXQgcmVxdWVzdGVkIHRoYXQKPj4gZXhhY3QgYmVoYXZpb3IsIGhvd2V2ZXIsIEknbSBub3Qg
YWJsZSB0byBsb2NhdGUgdGhlIEJaIHF1aWNrbHkuCj4+IFsxXSBodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvcGlwZXJtYWlsL3ZpcnR1YWxpemF0aW9uLzIwMjEtTm92ZW1iZXIvMDU3
NzY3Lmh0bWwKPj4gKG5vdGUgdGhhdCBJIGNhbid0IGVhc2lseSBmaW5kIHRoZSBvcmlnaW5hbCBt
YWlsIGluIHRoZSBhcmNoaXZlcykKPiAKPiBWTVdhcmUgZG9lcyBub3QsIFhlbiBkbywgSFYgZG8g
KGJ1dCBpdCBkaWRuJ3QpIC0gVmlydGlvIGRvZXMgYm90aC4KPiAKPiBGb3IgbWUgdGhlIGNvbmZ1
c2lvbiBjb21lcyBmcm9tIG1peGluZyBiYWxsb29uaW5nIGFuZCBob3QgcGx1Zy4KCkZvciBleGFt
cGxlLCBRRU1VIChhbmQgZXZlbiBsaWJ2aXJ0KSBkb2Vzbid0IGV2ZW4gaGF2ZSBidWlsdCBpbiBz
dXBwb3J0CmZvciBhbnkga2luZCBvZiBhdXRvbWF0aWMgYmFsbG9vbiByZXNpemluZyBvbiBndWVz
dCBtZW1vcnkgcHJlc3N1cmUgKGFuZApJJ20gaGFwcHkgdGhhdCB3ZSBkb24ndCBpbXBsZW1lbnQg
YW55IHN1Y2ggaGV1cmlzdGljcykuIEFzIGEgdXNlci9hZG1pbiwKYWxsIHlvdSBjYW4gZG8gaXMg
bWFudWFsbHkgYWRqdXN0IHRoZSBsb2dpY2FsIFZNIHNpemUgYnkgcmVxdWVzdGluZyB0bwppbmZs
YXRlL2RlZmxhdGUgdGhlIGJhbGxvb24uIEZvciB2aXJ0aW8tYmFsbG9vbiwgd2UgY2Fubm90IGRl
cml2ZSB3aGF0CnRoZSBoeXBlcnZpc29yL2FkbWluIG1pZ2h0IG9yIG1pZ2h0IG5vdCBkbyAtLSBh
bmQgd2hldGhlciB0aGUgYWRtaW4KaW50ZW5kcyB0byB1c2UgbWVtb3J5IGJhbGxvb25pbmcgZm9y
IG1lbW9yeSBob3R1bnBsdWcgb3IgZm9yIG9wdGltaXppbmcKbWVtb3J5IG92ZXJjb21taXQuCgpB
cyBhbm90aGVyIGV4YW1wbGUsIEhWIGR5bmFtaWMgbWVtb3J5IGFjdHVhbGx5IGNvbWJpbmVzIG1l
bW9yeSBob3RwbHVnCndpdGggbWVtb3J5IGJhbGxvb25pbmc6IHVzZSBtZW1vcnkgaG90cGx1ZyB0
byBhZGQgbW9yZSBtZW1vcnkgb24gZGVtYW5kCmFuZCB1c2UgbWVtb3J5IGJhbGxvb25pbmcgdG8g
bG9naWNhbGx5IHVucGx1ZyBtZW1vcnkgYWdhaW4uCgpUaGUgVk1XYXJlIGJhbGxvb24gaXMgYSBi
aXQgc3BlY2lhbCwgYmVjYXVzZSBpdCBhY3R1YWxseSB1c3VhbGx5CmltcGxlbWVudHMgZGVmbGF0
ZS1vbi1vb20gc2VtYW50aWNzIGluIHRoZSBoeXBlcnZpc29yLiBJSVJDLCB0aGUKaHlwZXJ2aXNv
ciB3aWxsIGFjdHVhbGx5IGFkanVzdCB0aGUgYmFsbG9vbiBzaXplIGJhc2VkIG9uIGd1ZXN0IG1l
bW9yeQpzdGF0cywgYW5kIHRoZXJlIGlzbid0IHJlYWxseSBhbiBpbnRlcmZhY2UgdG8gbWFudWFs
bHkgc2V0IHRoZSBiYWxsb29uCnNpemUgZm9yIGFuIGFkbWluLiBCdXQgSSBtaWdodCBiZSB3cm9u
ZyByZWdhcmRpbmcgdGhlIGxhdHRlci4KCj4gCj4gQmFsbG9vbmluZyBpcyBsaWtlIGEgaGVhcCBp
bnNpZGUgdGhlIGd1ZXN0IGZyb20gd2hpY2ggdGhlIGhvc3QgY2FuIAo+IGFsbG9jYXRlL2RlYWxs
b2NhdGUgcGFnZXMsIGlmIHRoZXJlIGlzIGEgbWVjaGFuaXNtIGZvciB0aGUgZ3Vlc3QgdG8gYXNr
IAo+IHRoZSBob3N0IGZvciBtb3JlL3RvIGZyZWUvIHBhZ2VzIG9yIHRoZSBob3N0IGhhdmUgYSBo
ZXVyaXN0aWMgdG8gbW9uaXRvciAKPiB0aGUgZ3Vlc3QgYW5kIGluZmxhdGUvZGVmbGF0ZSB0aGUg
Z3Vlc3QgaXQgaXMgYSBtYXR0ZXIgb2YgaW1wbGVtZW50YXRpb24uCgpQbGVhc2UgZG9uJ3QgYXNz
dW1lIHRoYXQgdGhlIHVzZSBjYXNlIGZvciBtZW1vcnkgYmFsbG9vbmluZyBpcyBvbmx5Cm9wdGlt
aXppbmcgbWVtb3J5IG92ZXJjb21taXQgaW4gdGhlIGh5cGVydmlzb3IgdW5kZXIgbWVtb3J5IHBy
ZXNzdXJlLgoKPiAKPiBIb3QgcGx1ZyBpcyBhZGRpbmfCoCB0byBNZW1Ub3RhbCBhbmQgaXQgaXMg
bm90IGEgcmFuZG9tIGV2ZW50IGVpdGhlciBpbiAKPiByZWFsIG9yIHZpcnR1YWwgZW52aXJvbm1l
bnQgLcKgIHNvIHlvdSBjYW4gYWN0IHVwb24gaXQuIE1lbVRvdGFswqAgZ29lcyAKPiBkb3duIG9u
IGhvdCB1bnBsdWcgYW5kIGlmIHBhZ2VzIGdldCBtYXJrZWQgYXMgZmF1bHR5IFJBTS4KCiJub3Qg
YSByYW5kb20gZXZlbnQgZWl0aGVyIiAtLSBzdXJlLCB3aXRoIHBwYyBkbHBhciwgeGVuIGJhbGxv
b24sIGh2CmJhbGxvb24gb3IgdmlydGlvLW1lbSAuLi4gd2hpY2ggYWxsIGFyZSBhYmxlIHRvIGhv
dHBsdWcgbWVtb3J5IGZhaXJseQpyYW5kb21seSBiYXNlZCBvbiBoeXBlcnZpc29yIGRlY2lzaW9u
cy4KCkluIHBoeXNpY2FsIGVudmlyb25tZW50cywgaXQncyBub3QgcmVhbGx5IGEgcmFuZG9tIGV2
ZW50LCBJIGFncmVlLgoKPiAKPiBIaXN0b3JpY2FsbHkgTWVtVG90YWwgaXMgYSBzdGFibGUgdmFs
dWUgKCBpIGFncmVlIHdpdGggbW9zdCBvZiBEYXZpZCAKPiBTdGV2ZW5zIHBvaW50cykgYW5kIHVz
ZXIgc3BhY2UgaXMgZXhwZWN0aW5nIGl0IHRvIGJlIHN0YWJsZSAsIAo+IGluaXRpYWxpemVkIGF0
IHN0YXJ0dXAgYW5kIGl0IGRvZXMgbm90IGV4cGVjdCBpdCB0byBjaGFuZ2UuCgpKdXN0IGxpa2Ug
c29tZSBhcHBzIGFyZSBub3QgcHJlcGFyZWQgZm9yIG1lbW9yeSBob3QodW4pcGx1Zy4gU29tZSBh
cHBzCmp1c3QgZG9uJ3Qgd29yayBpbiBlbnZpcm9ubWVudHMgd2l0aCB2YXJpYWJsZSBwaHlzaWNh
bCBtZW1vcnkgc2l6ZXM6CmV4YW1wbGVzIGluY2x1ZGUgZGF0YWJhc2VzLCB3aGVyZSBtZW1vcnkg
YmFsbG9vbmluZyBtaWdodCBlc3NlbnRpYWxseSBiZQpjb21wbGV0ZWx5IHVzZWxlc3MgKHRoZXJl
IGlzIGEgcGFwZXIgYWJvdXQgYXBwbGljYXRpb24tYXdhcmUgbWVtb3J5CmJhbGxvb25pbmcgZm9y
IHRoYXQgZXhhY3QgdXNlIGNhc2UpLgoKPiAKPiBVc2VkIGlzIHdoYXQgY2hhbmdlcyBhbmQgdGhh
dCBpcyB3aGF0IHVzZXIgc3BhY2UgZXhwZWN0cyB0byBjaGFuZ2UuCj4gCj4gRGVsZmF0ZSBvbiBv
b20gbWlnaHQgaGF2ZSBiZWVuIGEgbWlzdGFrZSBidXQgaXQgaXMgdGhlcmUgYW5kIGlmIGFueXRo
aW5nIAo+IGRlcGVuZHMgb24gY2hhbmdpbmcgTWVtVG90YWzCoCBpdCB3aWxsIGJlIGJyb2tlbiBi
eSB0aGF0IG9wdGlvbi7CoCBIb3cgCj4gdGhhdCBjYW4gYmUgZml4ZWQ/CgpJIGRpZG4ndCBxdWl0
ZSBnZXQgeW91ciBjb25jZXJuIGhlcmUuIERlZmxhdGUtb24tb29tIGluIHZpcnRpby1iYWxsb29u
Cndvbid0IGFkanVzdCBNZW1Ub3RhbCwgc28gdW5kZXIgd2hpY2ggY29uZGl0aW9uIHdvdWxkIGJl
IHNvbWV0aGluZyBicm9rZW4/Cgo+IAo+IEkgYWdyZWUgdGhhdCB0aGUgaG9zdCBjYW4gbm90IHJl
Y2xhaW0gd2hhdCBpcyBtYXJrZWQgYXMgdXNlZMKgIGJ1dCBzaG91bGQgCj4gaXQgYmUgYWJsZSB0
byA/IE1heSBiZSBpdCB3aWxsIGJlIGdvb2QgdG8gdGVhY2ggb29tIGtpbGxlciB0aGF0IHRoZXJl
IAo+IGNhbiBiZSBzdWNoIHJhbSB0aGF0IGNhbiBub3QgYmUgcmVjbGFpbWVkLgo+IAo+PiBOb3Rl
OiBJIHN1Z2dlc3RlZCB1bmRlciBbMV0gdG8gZXhwb3NlIGluZmxhdGVkIHBhZ2VzIHZpYSAvcHJv
Yy9tZW1pbmZvCj4+IGRpcmVjdGx5LiBXZSBjb3VsZCBkbyB0aGF0IGNvbnNpc3RlbnRseSBvdmVy
IGFsbCBiYWxsb29uIGRyaXZlcnMgLi4uCj4+IGRvZXNuJ3Qgc291bmQgdG9vIGNyYXp5Lgo+IAo+
IEluaXRhbGx5IGkgd2FudGVkIHRvIGRvIGV4YWN0bHkgdGhpcyBCVVQ6Cj4gLSBzb21lIGRyaXZl
cnMgcHJlZmVyIHRvIGV4cG9zZSBzb21lIG1vcmUgaW50ZXJuYWwgaW5mb3JtYXRpb24gaW4gdGhl
IGZpbGUuCgpUaGV5IGFsd2F5cyBjYW4gaGF2ZSBhbiBleHRlbmRlZCBkZWJ1Z2ZzIGludGVyZmFj
ZSBpbiBhZGRpdGlvbi4KCj4gLSBhIGxvdCBvZiB1c2VyIHNwYWNlIGlzIHVzaW5nIG1lbWluZm8g
c28gYmV0dGVyIGtlZXAgaXQgYXMgaXMgdG8gYXZvaWQgYnJlYWtpbmcgc29tZXRoaW5nLCBiYWxs
b29uaW5nIGlzIG5vdCB2ZXJ5IGZyZXF1ZW50bHkgdXNlZC4KCldlIGNhbiBhbHdheXMgZXh0ZW5k
LiBKdXN0IHJlY2VudGx5LCB3ZSBleHBvc2VkIFpzd2FwIGRhdGE6Cgpjb21taXQgZjY0OThiNzc2
ZDI4MGIzMGE0NjE0ZDgyNjE4NDA5NjFlOTkzYzJjOApBdXRob3I6IEpvaGFubmVzIFdlaW5lciA8
aGFubmVzQGNtcHhjaGcub3JnPgpEYXRlOiAgIFRodSBNYXkgMTkgMTQ6MDg6NTMgMjAyMiAtMDcw
MAoKICAgIG1tOiB6c3dhcDogYWRkIGJhc2ljIG1lbWluZm8gYW5kIHZtc3RhdCBjb3ZlcmFnZQoK
CkV4cG9zaW5nIGluZm9ybWF0aW9uIGFib3V0IGluZmxhdGVkIHBhZ2VzIGluIGEgZ2VuZXJpYyB3
YXkgZG9lc24ndCBzb3VuZApjb21wbGV0ZWx5IHdyb25nIHRvIG1lLCBidXQgdGhlcmUgbWlnaHQg
YmUgcGVvcGxlIHRoYXQgb2JqZWN0LgoKPiAKPiAKPiBQbGVhc2UsIHNoYXJlIHlvdXIgdmlldyBv
biBob3cgdGhlIGJhbGxvb25lZCBtZW1vcnkgc2hvdWxkIGJlIGFjY291bnRlZCBieSB0aGUgZHJp
dmVycyBpbnNpZGUgdGhlIGd1ZXN0cyBzbyB3ZSBjYW4gd29yayB0b3dhcmRzIGNvbnNpc3RlbnQg
YmVoYXZpb3VyOgo+IAo+IFNob3VsZCB0aGUgaW5mbGF0ZWQgbWVtb3J5IGJlIGFjY291bnRlZCBh
cyBVc2VkIG9yIE1lbVRvdGFsIGJlIGFkanVzdGVkPwoKSSBob3BlIEkgd2FzIGFibGUgdG8gbWFr
ZSBpdCBjbGVhciB0aGF0IGl0IGNvbXBsZXRlbHkgZGVwZW5kcyBvbiBob3cKbWVtb3J5IGJhbGxv
b25pbmcgaXMgYWN0dWFsbHkgaW50ZW5kZWQgdG8gYmUgdXNlZC4gSXQncyBub3QgdW5jb21tb24g
dG8KdXNlIGl0IGFzIGZvcm0gb2YgZmFrZSBtZW1vcnkgaG90dW5wbHVnLCB3aGVyZSB0aGF0IG1l
bW9yeSBpcyBhY3R1YWxseQpnb25lIGZvciBnb29kIGFuZCB3b24ndCBzaW1wbHkgY29tZSBiYWNr
IHdoZW4gdW5kZXIgbWVtb3J5IHByZXNzdXJlLgoKPiAKPiBTaG91bGQgdGhlIGluZmxhdGVkIG1l
bW9yeSBiZSBhZGRlZCB0byAvcHJvYy9tZW1pbmZvID8KCk15IGd1dCBmZWVsaW5nIGlzIHllcy4g
VGhlIGludGVyZXN0aW5nIHF1ZXN0aW9uIHJlbWFpbnMsIGhvdyB0bwpkaXN0aW5ndWlzaCB0aGUg
dHdvIHVzZSBjYXNlcyAoaW5mbGF0ZWQgbWVtb3J5IHN1YnRyYWN0ZWQgZnJvbSBNZW1Ub3RhbApv
ciBzdWJ0cmFjdGVkIGZyb20gTWVtRnJlZSkuCgpJJ20gbm90IHN1cmUgaWYgd2UgZXZlbiB3YW50
IHRvIHVuaWZ5IGJhbGxvb24gaGFuZGxpbmcgcmVhZ3JkaW5nCmFkanVzdGluZyBtYW5hZ2VkIHBh
Z2VzLiBJTUhPLCB0aGVyZSBhcmUgZ29vZCByZWFzb25zIHRvIGRvIGl0IGVpdGhlciB3YXkuCgot
LSAKVGhhbmtzLAoKRGF2aWQgLyBkaGlsZGVuYgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
