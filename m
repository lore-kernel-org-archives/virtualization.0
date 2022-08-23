Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5377C32772
	for <virtualization@archiver.kernel.org>; Tue, 23 Aug 2022 10:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 604A1814B5;
	Tue, 23 Aug 2022 10:01:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 604A1814B5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=RzCIb3fC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 86vFkHjt1Xbp; Tue, 23 Aug 2022 10:01:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C72AB81447;
	Tue, 23 Aug 2022 10:01:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C72AB81447
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3417C0033;
	Tue, 23 Aug 2022 10:01:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 687D7C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 10:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4142E4071E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 10:01:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4142E4071E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=RzCIb3fC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gsZU-MK5g1QY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 10:01:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89F2F4048F
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89F2F4048F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 10:01:37 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id e21so12495645edc.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 03:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=PUA2nr1wioVzDta9NpRPg2RNm4EXbTJFLkDHu1Yc67I=;
 b=RzCIb3fC9rUen/D1vmmMtmBfn7tnb3I6i96gMc17FaP25sM1SPevjN8+ALMtmleeQd
 KDJ7c9FHmvtExIEV88nYFCoUz+7lmYOx6Q5PBAK2JxopOZ/UuX/flPl2VsgVyo8BRS1N
 c6lRfMcTeBKqlVrEuXPQN6G3d8B55D3Bq9CPE/GRCAn1qdny6TDPYunYwawt5OlNV1i5
 xFqtbha8jWjcHLh0NQoCE1hu5HXE0avTduoUTU4P7qfxOhvuALOcQeif1r/MzWYQSGfg
 OjaMQa/TToqTHy5jecXHAvaSs1ls+IQWnbmXznL508j+47EWZOZPn4xrsUlZSekBzrcT
 xRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=PUA2nr1wioVzDta9NpRPg2RNm4EXbTJFLkDHu1Yc67I=;
 b=sIAVEitQV4LXWH0+Rr6PuNuB32HwelHIeaOZrJMAimAP1mYeNbclHZ90wZeZZBKenu
 kAzXW9lyY1vP/6LExKmUYMpDVciCjIW6bsRMF7xKdFIWMG6CfuZXsEfP3ne7u2jVqWz3
 P3qvcoqPA4r4qMkrNcvAO3pij7iuT3cIbF5/utea+wONY4bS+ATlW9oujw2hWk991Osu
 Uk1+UTV6JPiz6s4qQlAvaNlZ4KFzHsvbPpAxAw5VNmFFZOfTvZoE9El0UBk32h06le3R
 SnTZtMFkv/A1YI8/tP5DOvex/hBQMRz2KFsBIIBHZbHpZOCWPkG+OhvrhKbs565z9MC2
 lcPA==
X-Gm-Message-State: ACgBeo0Jf5LqOaxW+QjO8vp7uRfZ6x1m0Dws72SWqfBRpKletDpH1Kh6
 IsRxcFmpHFYxpJFVOwmmOHY=
X-Google-Smtp-Source: AA6agR6VgNqPndRYRwLHtUJsMNlHsCu3V4eKUsxekz1ZbevLr3JDMUTpWtKAYsm/CRJbKE3ITlHyqA==
X-Received: by 2002:a05:6402:4021:b0:447:29f9:a881 with SMTP id
 d33-20020a056402402100b0044729f9a881mr1031970eda.391.1661248895466; 
 Tue, 23 Aug 2022 03:01:35 -0700 (PDT)
Received: from [192.168.178.21] (p4fc20ad4.dip0.t-ipconnect.de.
 [79.194.10.212]) by smtp.gmail.com with ESMTPSA id
 p16-20020a056402501000b0044625884285sm1184942eda.49.2022.08.23.03.01.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Aug 2022 03:01:34 -0700 (PDT)
Message-ID: <5988bf07-dd2e-a7ad-1ed9-831a402c3c5d@gmail.com>
Date: Tue, 23 Aug 2022 12:01:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 2/2] drm/gem: Don't map imported GEMs
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Rob Clark <robdclark@gmail.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <2bb95e80-b60a-36c0-76c8-a06833032c77@amd.com>
 <CAF6AEGtqPeF1DjmBKgzWK39Yi81YiNjTjDNn85TKx7uwicFTSA@mail.gmail.com>
 <2a646ce4-c2ec-3b11-77a0-cc720afd6fe1@collabora.com>
 <YvOav/vF2awVWIu0@phenom.ffwll.local>
 <CAF6AEGvfAJgwBe4+sK0gAkZ++MwH9x4=698C8XSnmfYNMFZqfA@mail.gmail.com>
 <9674d00e-c0d6-ceba-feab-5dc475bda694@collabora.com>
 <CAF6AEGv1cVC9ZNMwpwFOki5CrwD3kSAHM9EUFZGWY-y5zcQsCg@mail.gmail.com>
 <fc019528-7ec7-9e5b-1b6d-c44da14346cf@collabora.com>
 <CAF6AEGv8zSd0fEYB9hd2QOyTt53gFSQoL8JdZtCvtCdYfMfB2Q@mail.gmail.com>
 <73b51dde-689f-64ce-a1c8-0d7c84a2ed66@collabora.com>
 <CAF6AEGuR1cRQYaQBYGnMBzy=XJUcN2o2gzabZaGO2Dj62Uq1DA@mail.gmail.com>
 <CAF6AEGvvR1NUd_GKP=Bxp3VTDMBYT+OwTkkgOWxgYFijZaVVEQ@mail.gmail.com>
 <5f118e10-db7a-a128-1e87-c9dddb65b2ac@collabora.com>
 <2ce5ff0a-9ab2-d146-04db-487a64714fce@gmail.com>
 <cf8cd8da-08d2-5e70-a239-2a67da37c9ea@collabora.com>
 <e9bde303-6474-aa0b-7880-cf7d8b163983@collabora.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <e9bde303-6474-aa0b-7880-cf7d8b163983@collabora.com>
Cc: kernel@collabora.com, dri-devel <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>,
 =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-tegra@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, Dmitry Osipenko <digetx@gmail.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Chia-I Wu <olvaffe@gmail.com>
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

QW0gMjIuMDguMjIgdW0gMTk6MjYgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gT24gOC8xNi8y
MiAyMjo1NSwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiBPbiA4LzE2LzIyIDE1OjAzLCBDaHJp
c3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQW0gMTYuMDguMjIgdW0gMTM6NDQgc2NocmllYiBEbWl0
cnkgT3NpcGVua286Cj4+Pj4gW1NOSVBdCj4+Pj4+IFRoZSBvdGhlciBjb21wbGljYXRpb24gSSBu
b3RpY2VkIGlzIHRoYXQgd2UgZG9uJ3Qgc2VlbSB0byBrZWVwIGFyb3VuZAo+Pj4+PiB0aGUgZmQg
YWZ0ZXIgaW1wb3J0aW5nIHRvIGEgR0VNIGhhbmRsZS7CoCBBbmQgSSBjb3VsZCBpbWFnaW5lIHRo
YXQKPj4+Pj4gZG9pbmcgc28gY291bGQgY2F1c2UgaXNzdWVzIHdpdGggdG9vIG1hbnkgZmQncy7C
oCBTbyBJIGd1ZXNzIHRoZSBiZXN0Cj4+Pj4+IHRoaW5nIGlzIHRvIGtlZXAgdGhlIHN0YXR1cyBx
dW8gYW5kIGxldCBkcml2ZXJzIHRoYXQgY2Fubm90IG1tYXAKPj4+Pj4gaW1wb3J0ZWQgYnVmZmVy
cyBqdXN0IGZhaWwgbW1hcD8KPj4+PiBUaGF0IGFjdHVhbGx5IHNob3VsZCBiZSBhbGwgdGhlIGRy
aXZlcnMgZXhjbHVkaW5nIHRob3NlIHRoYXQgdXNlCj4+Pj4gRFJNLVNITUVNIGJlY2F1c2Ugb25s
eSBEUk0tU0hNRU0gdXNlcyBkbWFfYnVmX21tYXAoKSwgdGhhdCdzIHdoeSBpdAo+Pj4+IHdvcmtz
IGZvciBQYW5mcm9zdC4gSSdtIHByZXR0eSBzdXJlIG1tYXBpbmcgb2YgaW1wb3J0ZWQgR0VNcyBk
b2Vzbid0Cj4+Pj4gd29yayBmb3IgdGhlIE1TTSBkcml2ZXIsIGlzbid0IGl0Pwo+Pj4+Cj4+Pj4g
SW50ZWwgYW5kIEFNRCBkcml2ZXJzIGRvbid0IGFsbG93IHRvIG1hcCB0aGUgaW1wb3J0ZWQgZG1h
LWJ1ZnMuIEJvdGgKPj4+PiByZWZ1c2UgdG8gZG8gdGhlIG1hcHBpbmcuCj4+Pj4KPj4+PiBBbHRo
b3VnaCwgQU1ER1BVICJzdWNjZWVkcyIgdG8gZG8gdGhlIG1hcHBpbmcgdXNpbmcKPj4+PiBBTURH
UFVfR0VNX0RPTUFJTl9HVFQsIGJ1dCB0aGVuIHRvdWNoaW5nIHRoZSBtYXBwaW5nIGNhdXNlcyBi
dXMgZmF1bHQsCj4+Pj4gaGVuY2UgbWFwcGluZyBhY3R1YWxseSBmYWlscy4gSSB0aGluayBpdCBt
aWdodCBiZSB0aGUgQU1ER1BVCj4+Pj4gZHJpdmVyL2xpYmRybSBidWcsIGhhdmVuJ3QgY2hlY2tl
ZCB5ZXQuCj4+PiBUaGF0J3MgdGhlbiBjZXJ0YWlubHkgYnJva2VuIHNvbWVob3cuIEFtZGdwdSBz
aG91bGQgbmVydmUgZXZlciBoYXZlCj4+PiBhbGxvd2VkIHRvIG1tYXAoKSBpbXBvcnRlZCBETUEt
YnVmcyBhbmQgdGhlIGxhc3QgdGltZSBJIGNoZWNrIGl0IGRpZG4ndC4KPj4gSSdsbCB0YWtlIGEg
Y2xvc2VyIGxvb2suIFNvIGZhciBJIGNhbiBvbmx5IHRlbGwgdGhhdCBpdCdzIGEga2VybmVsCj4+
IGRyaXZlciBpc3N1ZSBiZWNhdXNlIG9uY2UgSSByZS1hcHBsaWVkIHRoaXMgIkRvbid0IG1hcCBp
bXBvcnRlZCBHRU1zIgo+PiBwYXRjaCwgQU1ER1BVIGJlZ2FuIHRvIHJlZnVzZSBtYXBwaW5nIEFN
REdQVV9HRU1fRE9NQUlOX0dUVC4KPj4KPj4+PiBTbyB3ZSdyZSBiYWNrIHRvIHRoZSBwb2ludCB0
aGF0IG5laXRoZXIgb2YgRFJNIGRyaXZlcnMgbmVlZCB0byBtYXAKPj4+PiBpbXBvcnRlZCBkbWEt
YnVmcyBhbmQgdGhpcyB3YXMgbmV2ZXIgdGVzdGVkLiBJbiB0aGlzIGNhc2UgdGhpcyBwYXRjaCBp
cwo+Pj4+IHZhbGlkLCBJTU8uCj4+IEFjdHVhbGx5LCBJJ20gbm93IGxvb2tpbmcgYXQgRXRuYXZp
diBhbmQgTm91dmVhdSBhbmQgc2VlbXMgdGhleSBzaG91bGQKPj4gbWFwIGltcG9ydGVkIGRtYS1i
dWYgcHJvcGVybHkuIEkga25vdyB0aGF0IHBlb3BsZSByYW4gQW5kcm9pZCBvbgo+PiBFdG5hdml2
LiBTbyBtYXliZSBkZXZpY2VzIHdpdGggYSBzZXBhcmF0ZWQgR1BVL2Rpc3BsYXkgbmVlZCB0byBt
YXAKPj4gaW1wb3J0ZWQgZGlzcGxheSBCTyBmb3IgQW5kcm9pZCBzdXBwb3J0LiBXaXNoIHNvbWVi
b2R5IHdobyByYW4gQW5kcm9pZAo+PiBvbiBvbmUgb2YgdGhlc2UgZGV2aWNlcyB1c2luZyB1cHN0
cmVhbSBkcml2ZXJzIGNvdWxkIGdpdmUgYSBkZWZpbml0aXZlCj4+IGFuc3dlci4gSSBtYXkgdHJ5
IHRvIHRlc3QgTm91dmVhdSBsYXRlciBvbi4KPj4KPiBOb3V2ZWF1K0ludGVsIGNvbWJvIGRvZXNu
J3Qgd29yayBiZWNhdXNlIG9mIFsxXSB0aGF0IHNheXM6Cj4KPiAiUmVmdXNlIHRvIGZhdWx0IGlt
cG9ydGVkIHBhZ2VzLiBUaGlzIHNob3VsZCBiZSBoYW5kbGVkIChpZiBhdCBhbGwpIGJ5Cj4gcmVk
aXJlY3RpbmcgbW1hcCB0byB0aGUgZXhwb3J0ZXIuIgo+Cj4gWzFdCj4gaHR0cHM6Ly9lbGl4aXIu
Ym9vdGxpbi5jb20vbGludXgvdjUuMTkvc291cmNlL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2Jv
X3ZtLmMjTDE1NAo+Cj4gSW50ZXJlc3RpbmdseSwgSSBub3RpY2VkIHRoYXQgdGhlcmUgYXJlIElH
VCB0ZXN0cyB3aGljaCBjaGVjayBwcmltZQo+IG1tYXBpbmcgb2YgTm91dmVhdStJbnRlbCBbMl0g
KGFkZGVkIDkgeWVhcnMgYWdvKSwgYnV0IHRoZXkgZmFpbCBhcyB3ZWxsLAo+IGFzIGV4cGVjdGVk
LiBUaGUgZmFjdCB0aGF0IElHVCBoYXMgc3VjaCB0ZXN0cyBpcyBpbnRlcmVzdGluZyBiZWNhdXNl
IGl0Cj4gc3VnZ2VzdHMgdGhhdCB0aGUgbWFwcGluZyB3b3JrZWQgaW4gdGhlIHBhc3QuIEl0J3Mg
YWxzbyBzdXJwcmlzaW5nIHRoYXQKPiBub2JvZHkgY2FyZWQgdG8gZml4IHRoZSBmYWlsaW5nIHRl
c3RzLiBGb3IgdGhlIHJlZmVyZW5jZSwgSSBjaGVja2VkCj4gdjUuMTggYW5kIHRvZGF5J3MgbGlu
dXgtbmV4dC4KPgo+IFsyXQo+IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vaWd0
LWdwdS10b29scy8tL2Jsb2IvbWFzdGVyL3Rlc3RzL3ByaW1lX252X3Rlc3QuYyNMMTMyCj4KPiBT
dGFydGluZyBzdWJ0ZXN0OiBudl93cml0ZV9pOTE1X2NwdV9tbWFwX3JlYWQKPiBSZWNlaXZlZCBz
aWduYWwgU0lHQlVTLgo+IFN0YWNrIHRyYWNlOgo+ICAgIzAgW2ZhdGFsX3NpZ19oYW5kbGVyKzB4
MTYzXQo+ICAgIzEgW19fc2lnYWN0aW9uKzB4NTBdCj4gICAjMiBbX19pZ3RfdW5pcXVlX19fX3Jl
YWxfbWFpbjM1NCsweDQwNl0KPiAgICMzIFttYWluKzB4MjNdCj4gICAjNCBbX19saWJjX3N0YXJ0
X2NhbGxfbWFpbisweDgwXQo+ICAgIzUgW19fbGliY19zdGFydF9tYWluKzB4ODldCj4gICAjNiBb
X3N0YXJ0KzB4MjVdCj4gU3VidGVzdCBudl93cml0ZV9pOTE1X2NwdV9tbWFwX3JlYWQ6IENSQVNI
ICgwLDAwNXMpCj4KPiBTdGFydGluZyBzdWJ0ZXN0OiBudl93cml0ZV9pOTE1X2d0dF9tbWFwX3Jl
YWQKPiBSZWNlaXZlZCBzaWduYWwgU0lHQlVTLgo+IFN0YWNrIHRyYWNlOgo+ICAgIzAgW2ZhdGFs
X3NpZ19oYW5kbGVyKzB4MTYzXQo+ICAgIzEgW19fc2lnYWN0aW9uKzB4NTBdCj4gICAjMiBbX19p
Z3RfdW5pcXVlX19fX3JlYWxfbWFpbjM1NCsweDMzZF0KPiAgICMzIFttYWluKzB4MjNdCj4gICAj
NCBbX19saWJjX3N0YXJ0X2NhbGxfbWFpbisweDgwXQo+ICAgIzUgW19fbGliY19zdGFydF9tYWlu
KzB4ODldCj4gICAjNiBbX3N0YXJ0KzB4MjVdCj4gU3VidGVzdCBudl93cml0ZV9pOTE1X2d0dF9t
bWFwX3JlYWQ6IENSQVNIICgwLDAwNHMpCj4KPiBJJ20gY3VyaW91cyBhYm91dCB0aGUgRXRuYXZp
diBkcml2ZXIgYmVjYXVzZSBpdCB1c2VzIG93biBzaG1lbQo+IGltcGxlbWVudGF0aW9uIGFuZCBt
YXliZSBpdCBoYXMgYSB3b3JraW5nIG1tYXBpbmcgb2YgaW1wb3J0ZWQgR0VNcyBzaW5jZQo+IGl0
IGltcG9ydHMgdGhlIGRtYS1idWYgcGFnZXMgaW50byBFbnRhdml2IEJPLiBBbHRob3VnaCwgaXQg
c2hvdWxkIGJlCj4gcmlza2luZyB0byBtYXAgcGFnZXMgdXNpbmcgYSBkaWZmZXJlbnQgY2FjaGlu
ZyBhdHRyaWJ1dGVzIChXQykgZnJvbSB0aGUKPiBleHBvcnRlciwgd2hpY2ggaXMgcHJvaGliaXRl
ZCBvbiBBUk0gYWQgdGhlbiBvbmUgbWF5IHRyeSB0byBtYXAgaW1wb3J0ZWQKPiB1ZG1hYnVmLgo+
Cj4gQXBwYXJlbnRseSwgdGhlIEludGVsIERHIFRUTSBkcml2ZXIgc2hvdWxkIGJlIGFibGUgdG8g
bWFwIGltcG9ydGVkCj4gZG1hLWJ1ZiBiZWNhdXNlIGl0IHNldHMgVFRNX1RUX0ZMQUdfRVhURVJO
QUxfTUFQUEFCTEUuCgpFdmVuIHdpdGggdGhhdCBmbGFnIHNldCBpdCBpcyBpbGxlZ2FsIHRvIG1h
cCB0aGUgcGFnZXMgZGlyZWN0bHkgYnkgYW4gCmltcG9ydGVyLgoKSWYgdGhhdCBldmVyIHdvcmtl
ZCB0aGVuIHRoZSBvbmx5IHJlYWwgc29sdXRpb24gaXMgdG8gcmVkaXJlY3QgbW1hcCgpIApjYWxs
cyBvbiBpbXBvcnRlciBCT3MgdG8gZG1hX2J1Zl9tbWFwKCkuCgpSZWdhcmRzLApDaHJpc3RpYW4u
Cgo+Cj4gT3ZlcmFsbCwgaXQgc3RpbGwgcXVlc3Rpb25hYmxlIHRvIG1lIHdoZXRoZXIgaXQncyB3
b3J0aHdoaWxlIHRvIGFsbG93Cj4gdGhlIG1tYXBpbmcgb2YgaW1wb3J0ZWQgR0VNcyBzaW5jZSBv
bmx5IFBhbmZyb3N0L0xpbWEgY2FuIGRvIGl0IG91dCBvZgo+IGFsbCBkcml2ZXJzIGFuZCBoL3cg
dGhhdCBJIHRlc3RlZC4gRmVlbHMgbGlrZSBkcml2ZXJzIHRoYXQgY2FuIGRvIHRoZQo+IG1hcHBp
bmcgaGF2ZSBpdCBqdXN0IGJlY2F1c2UgdGhleSBjYW4gYW5kIG5vdCBiZWNhdXNlIHRoZXkgbmVl
ZC4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
