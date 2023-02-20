Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35CFC05027
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 10:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4003F81E9A;
	Mon, 20 Feb 2023 10:02:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4003F81E9A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=GCfttIV+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kh3caJCbEZ3o; Mon, 20 Feb 2023 10:02:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 573E881E69;
	Mon, 20 Feb 2023 10:02:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 573E881E69
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25545C0033;
	Mon, 20 Feb 2023 10:02:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36E15C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 10:02:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0494F60D78
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 10:02:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0494F60D78
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=GCfttIV+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CzHkvu7WU58x
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 10:01:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8166060BF2
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8166060BF2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 10:01:59 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id g1so2124141edz.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 02:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=swEqgYB8OsNnxvBfnmM7hvaPOz1vuvKhnnv203lT0+M=;
 b=GCfttIV+nMaPwVQ3v8ZPiT2Oj2+08RJ47wU2YBC1bSh/SrLJXaomCmeNuizbB3G9RQ
 rL4lUdz0Od1aKPfBC3LJmZIOE+9qCYoaiErCUQvRYRVSMKsMil/cyl0Zr2t2uqJsUJLI
 nwVvBS/D0vOIxp3mIZgcseFUTCKaTBwMCsjyf3LEcmwhraJsuGwRqiMDOej8qkeLmFt9
 QOngW/qUc5tKOgN7nwFoR0TKxCghR2DFoXsLjo3p3O155mt3gEsv8+tZ7yOQ/mvLx+Di
 E42b1FFTS4gEwz4AJWQfr2LXixKsHxv/W/zFM/PXSBmk2IMFTs8OKyZfhlwDJfgzc2QO
 Xtnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=swEqgYB8OsNnxvBfnmM7hvaPOz1vuvKhnnv203lT0+M=;
 b=iHWJfCNkIxOOBQLxHhCVfeeCsjrVehnKkpTX1c3BrcrpuyGEmehhRT6kHf0ZyZgkWP
 WY7/W1DHUSILFoM45Kzy/CVkptsopt6X2TSTmeFe4a9u0H5cB5G1zIuNpEENeYNvOYzJ
 6I5LZ0tAxj0Jk6uwMkzRXksjV7DhZTHqKpQiiojgQXcWSuy0apmFEcMmSMm/eBg9OHs7
 jYzDYaygnefL9SDPWSj4spGzGzsXVTNnnQaDkQEm216DmxYLkRAIJdTGZjLxX72IkhcW
 RFIorXPk8/QWBMUIaAhwBTW8hPhW67OEDxBj98JV1YxhMhEfftAmDIQkedU7Lnju09XR
 oCUA==
X-Gm-Message-State: AO0yUKU0upPGOcyQxmxjhDwcRAyAAIVRbpk75AET3AjxxGxorRv0N2wX
 1YiI2cKDzACJt9VJavR6W3o=
X-Google-Smtp-Source: AK7set9PXlhBlinVM8SD6OFXl4L66YhrGLYQ9r16IxLLAcMibSwgUl/W+0GRd/4MMwadGTKl53l5bA==
X-Received: by 2002:a17:907:a42a:b0:8b1:730b:a296 with SMTP id
 sg42-20020a170907a42a00b008b1730ba296mr16455985ejc.15.1676887317563; 
 Mon, 20 Feb 2023 02:01:57 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:dede:81be:2cf1:ada5?
 ([2a02:908:1256:79a0:dede:81be:2cf1:ada5])
 by smtp.gmail.com with ESMTPSA id
 my22-20020a1709065a5600b008bc2c2134c5sm3099224ejc.216.2023.02.20.02.01.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Feb 2023 02:01:56 -0800 (PST)
Message-ID: <b7bb9888-b1d3-0d89-1e4f-bc25475b0071@gmail.com>
Date: Mon, 20 Feb 2023 11:01:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/gem: Expose the buffer object handle to userspace last
Content-Language: en-US
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
References: <20230214125050.1205394-1-tvrtko.ursulin@linux.intel.com>
 <f1256a51-5c4d-ab44-3867-931f7d2c0695@amd.com>
 <767620c4-385f-c0e8-dcb1-513ef4402ad0@linux.intel.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <767620c4-385f-c0e8-dcb1-513ef4402ad0@linux.intel.com>
Cc: Rob Clark <robdclark@chromium.org>, lima@lists.freedesktop.org,
 Tvrtko Ursulin <tvrtko.ursulin@intel.com>, nouveau@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
 Ben Skeggs <bskeggs@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
 David Herrmann <dh.herrmann@gmail.com>, spice-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, David Airlie <airlied@gmail.com>,
 Zack Rusin <zackr@vmware.com>
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

QW0gMjAuMDIuMjMgdW0gMTA6NTUgc2NocmllYiBUdnJ0a28gVXJzdWxpbjoKPgo+IEhpLAo+Cj4g
T24gMTQvMDIvMjAyMyAxMzo1OSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMTQuMDIu
MjMgdW0gMTM6NTAgc2NocmllYiBUdnJ0a28gVXJzdWxpbjoKPj4+IEZyb206IFR2cnRrbyBVcnN1
bGluIDx0dnJ0a28udXJzdWxpbkBpbnRlbC5jb20+Cj4+Pgo+Pj4gQ3VycmVudGx5IGRybV9nZW1f
aGFuZGxlX2NyZWF0ZV90YWlsIGV4cG9zZXMgdGhlIGhhbmRsZSB0byB1c2Vyc3BhY2UKPj4+IGJl
Zm9yZSB0aGUgYnVmZmVyIG9iamVjdCBjb25zdHJ1Y3Rpb25zIGlzIGNvbXBsZXRlLiBUaGlzIGFs
bG93aW5nCj4+PiBvZiB3b3JraW5nIGFnYWluc3QgYSBwYXJ0aWFsbHkgY29uc3RydWN0ZWQgb2Jq
ZWN0LCB3aGljaCBtYXkgYWxzbyBiZSBpbgo+Pj4gdGhlIHByb2Nlc3Mgb2YgaGF2aW5nIGl0cyBj
cmVhdGlvbiBmYWlsLCBjYW4gaGF2ZSBhIHJhbmdlIG9mIG5lZ2F0aXZlCj4+PiBvdXRjb21lcy4K
Pj4+Cj4+PiBBIGxvdCBvZiB0aG9zZSB3aWxsIGRlcGVuZCBvbiB3aGF0IHRoZSBpbmRpdmlkdWFs
IGRyaXZlcnMgYXJlIGRvaW5nIGluCj4+PiB0aGVpciBvYmotPmZ1bmNzLT5vcGVuKCkgY2FsbGJh
Y2tzLCBhbmQgYWxzbyB3aXRoIGEgY29tbW9uIGZhaWx1cmUgbW9kZQo+Pj4gYmVpbmcgLUVOT01F
TSBmcm9tIGRybV92bWFfbm9kZV9hbGxvdy4KPj4+Cj4+PiBXZSBjYW4gbWFrZSBzdXJlIG5vbmUg
b2YgdGhpcyBjYW4gaGFwcGVuIGJ5IGFsbG9jYXRpbmcgYSBoYW5kbGUgbGFzdCwKPj4+IGFsdGhv
dWdoIHdpdGggYSBkb3duc2lkZSB0aGF0IG1vcmUgb2YgdGhlIGZ1bmN0aW9uIG5vdyBydW5zIHVu
ZGVyIHRoZQo+Pj4gZGV2LT5vYmplY3RfbmFtZV9sb2NrLgo+Pj4KPj4+IExvb2tpbmcgaW50byB0
aGUgaW5kaXZpZHVhbCBkcml2ZXJzIG9wZW4oKSBob29rcywgd2UgaGF2ZQo+Pj4gYW1kZ3B1X2dl
bV9vYmplY3Rfb3BlbiB3aGljaCBzZWVtcyBsaWtlIGl0IGNvdWxkIGhhdmUgYSBwb3RlbnRpYWwg
Cj4+PiBzZWN1cml0eQo+Pj4gaXNzdWUgd2l0aG91dCB0aGlzIGNoYW5nZS4KPj4+Cj4+PiBBIGNv
dXBsZSBkcml2ZXJzIGxpa2UgcXhsX2dlbV9vYmplY3Rfb3BlbiBhbmQgdm13X2dlbV9vYmplY3Rf
b3Blbgo+Pj4gaW1wbGVtZW50IG5vLW9wIGhvb2tzIHNvIG5vIGltcGFjdCBmb3IgdGhlbS4KPj4+
Cj4+PiBBIGJ1bmNoIG9mIG90aGVyIHJlcXVpcmUgYSBkZWVwZXIgbG9vayBieSBpbmRpdmlkdWFs
IG93bmVycyB0byBhc3NlcyAKPj4+IGZvcgo+Pj4gaW1wYWN0LiBUaG9zZSBhcmUgbGltYV9nZW1f
b2JqZWN0X29wZW4sIG5vdXZlYXVfZ2VtX29iamVjdF9vcGVuLAo+Pj4gcGFuZnJvc3RfZ2VtX29w
ZW4sIHJhZGVvbl9nZW1fb2JqZWN0X29wZW4gYW5kIAo+Pj4gdmlydGlvX2dwdV9nZW1fb2JqZWN0
X29wZW4uCj4+Pgo+Pj4gUHV0dGluZyBhc2lkZSB0aGUgcmlzayBhc3Nlc21lbnQgb2YgdGhlIGFi
b3ZlLCBzb21lIGNvbW1vbiBzY2VuYXJpb3MgdG8KPj4+IHRoaW5rIGFib3V0IGFyZSBhbG9uZyB0
aGVzZSBsaW5lczoKPj4+Cj4+PiAxKQo+Pj4gVXNlcnNwYWNlIGNsb3NlcyBhIGhhbmRsZSBieSBz
cGVjdWxhdGl2ZWx5ICJndWVzc2luZyIgaXQgZnJvbSBhIHNlY29uZAo+Pj4gdGhyZWFkLgo+Pj4K
Pj4+IFRoaXMgcmVzdWx0cyBpbiBhbiB1bnJlYWNoYWJsZSBidWZmZXIgb2JqZWN0IHNvLCBhIG1l
bW9yeSBsZWFrLgo+Pj4KPj4+IDIpCj4+PiBTYW1lIGFzIDEpLCBidXQgb2JqZWN0IGlzIGluIHRo
ZSBwcm9jZXNzIG9mIGdldHRpbmcgY2xvc2VkIChmYWlsZWQKPj4+IGNyZWF0aW9uKS4KPj4+Cj4+
PiBUaGUgc2Vjb25kIHRocmVhZCBpcyB0aGVuIGFibGUgdG8gcmUtY3ljbGUgdGhlIGhhbmRsZSBh
bmQgaWRyX3JlbW92ZSAKPj4+IHdvdWxkCj4+PiBpbiB0aGUgZmlyc3QgdGhyZWFkIHdvdWxkIHRo
ZW4gcmVtb3ZlIHRoZSBoYW5kbGUgaXQgZG9lcyBub3Qgb3duIAo+Pj4gZnJvbSB0aGUKPj4+IGlk
ci4KPj4+Cj4+PiAzKQo+Pj4gR29pbmcgYmFjayB0byB0aGUgZWFybGllciBwZXIgZHJpdmVyIHBy
b2JsZW0gc3BhY2UgLSBpbmRpdmlkdWFsIGltcGFjdAo+Pj4gYXNzZXNtZW50IG9mIGFsbG93aW5n
IGEgc2Vjb25kIHRocmVhZCB0byBhY2Nlc3MgYW5kIG9wZXJhdGUgb24gYSAKPj4+IHBhcnRpYWxs
eQo+Pj4gY29uc3RydWN0ZWQgaGFuZGxlIC8gb2JqZWN0LiAoQ2FuIHNvbWV0aGluZyBjcmFzaD8g
TGVhayBpbmZvcm1hdGlvbj8pCj4+Pgo+Pj4gSW4gdGVybXMgb2YgaWRlbnRpZnlpbmcgd2hlbiB0
aGUgcHJvYmxlbSBzdGFydGVkIEkgd2lsbCB0YWcgc29tZSAKPj4+IHBhdGNoZXMKPj4+IGFzIHJl
ZmVyZW5jZXMsIGJ1dCBub3QgYWxsLCBpZiBldmVuIGFueSwgb2YgdGhlbSBhY3R1YWxseSBwb2lu
dCB0byBhCj4+PiBicm9rZW4gc3RhdGUuIEkgYW0ganVzdCBpZGVudGlmeWluZyBwb2ludHMgYXQg
d2hpY2ggbW9yZSBvcHBvcnR1bml0eSAKPj4+IGZvcgo+Pj4gaXNzdWVzIHRvIGFyaXNlIHdhcyBh
ZGRlZC4KPj4KPj4gWWVzIEkndmUgbG9va2VkIGludG8gdGhpcyBvbmNlIGFzIHdlbGwsIGJ1dCBj
b3VsZG4ndCBjb21wbGV0ZWx5IHNvbHZlIAo+PiBpdCBmb3Igc29tZSByZWFzb24uCj4+Cj4+IEdp
dmUgbWUgYSBkYXkgb3IgdHdvIHRvIGdldCB0aGlzIHRlc3RlZCBhbmQgYWxsIHRoZSBsb2dpYyBz
d2FwcGVkIAo+PiBiYWNrIGludG8gbXkgaGVhZCBhZ2Fpbi4KPgo+IE1hbmFnZWQgdG8gcmVjb2xs
ZWN0IHdoYXQgdGhlIHByb2JsZW0gd2l0aCBlYXJsaWVyIGF0dGVtcHRzIHdhcz8KCk5vcGUsIHRo
YXQncyB3YXkgdG8gbG9uZyBhZ28uIEkgY2FuIG9ubHkgYXNzdW1lIHRoYXQgSSByYW4gaW50byBw
cm9ibGVtcyAKd2l0aCB0aGUgb2JqZWN0X25hbWVfbG9jay4KClByb2JhYmx5IGJlc3QgdG8gZG91
YmxlIGNoZWNrIGlmIHRoYXQgZG9lc24ndCByZXN1bHQgaW4gYSBsb2NrIGludmVyc2lvbiAKd2hl
biBzb21lYm9keSBncmFicyB0aGUgcmVzZXJ2YXRpb24gbG9jayBpbiB0aGVpciAtPmxvYWQoKSBj
YWxsYmFjay4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPiBSZWdhcmRzLAo+Cj4gVHZydGtvCj4K
Pj4gQ2hyaXN0aWFuLgo+Pgo+Pj4KPj4+IFJlZmVyZW5jZXM6IDMwNGVkYTMyOTIwYiAoImRybS9n
ZW06IGFkZCBob29rcyB0byBub3RpZnkgZHJpdmVyIHdoZW4gCj4+PiBvYmplY3QgaGFuZGxlIGlz
IGNyZWF0ZWQvZGVzdHJveWVkIikKPj4+IFJlZmVyZW5jZXM6IGNhNDgxYzliMmEzYSAoImRybS9n
ZW06IGltcGxlbWVudCB2bWEgYWNjZXNzIG1hbmFnZW1lbnQiKQo+Pj4gUmVmZXJlbmNlczogYjM5
YjUzOTRmYWJjICgiZHJtL2dlbTogQWRkIGRybV9nZW1fb2JqZWN0X2Z1bmNzIikKPj4+IENjOiBk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+PiBDYzogUm9iIENsYXJrIDxyb2JkY2xh
cmtAY2hyb21pdW0ub3JnPgo+Pj4gQ2M6IEJlbiBTa2VnZ3MgPGJza2VnZ3NAcmVkaGF0LmNvbT4K
Pj4+IENjOiBEYXZpZCBIZXJybWFubiA8ZGguaGVycm1hbm5AZ21haWwuY29tPgo+Pj4gQ2M6IE5v
cmFsZiBUcsO4bm5lcyA8bm9yYWxmQHRyb25uZXMub3JnPgo+Pj4gQ2M6IERhdmlkIEFpcmxpZSA8
YWlybGllZEBnbWFpbC5jb20+Cj4+PiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNo
Pgo+Pj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+PiBDYzogbGltYUBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPj4+IENjOiBub3V2ZWF1QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
Pj4gQ2M6IFN0ZXZlbiBQcmljZSA8c3RldmVuLnByaWNlQGFybS5jb20+Cj4+PiBDYzogdmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPj4+IENjOiBzcGljZS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+IENjOiBaYWNrIFJ1c2luIDx6YWNrckB2bXdhcmUuY29t
Pgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vZHJtX2dlbS5jIHwgNDggCj4+PiArKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4+IMKgIDEgZmlsZSBjaGFuZ2Vk
LCAyNCBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtLmMKPj4+
IGluZGV4IGFhMTVjNTJhZTE4Mi4uZTNkODk3YmNhMGYyIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2RybV9nZW0uYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYwo+
Pj4gQEAgLTM1Niw1MiArMzU2LDUyIEBAIGRybV9nZW1faGFuZGxlX2NyZWF0ZV90YWlsKHN0cnVj
dCBkcm1fZmlsZSAKPj4+ICpmaWxlX3ByaXYsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB1MzIgKmhhbmRsZXApCj4+PiDCoCB7Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBkcm1f
ZGV2aWNlICpkZXYgPSBvYmotPmRldjsKPj4+IC3CoMKgwqAgdTMyIGhhbmRsZTsKPj4+IMKgwqDC
oMKgwqAgaW50IHJldDsKPj4+IFdBUk5fT04oIW11dGV4X2lzX2xvY2tlZCgmZGV2LT5vYmplY3Rf
bmFtZV9sb2NrKSk7Cj4+PiDCoMKgwqDCoMKgIGlmIChvYmotPmhhbmRsZV9jb3VudCsrID09IDAp
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZHJtX2dlbV9vYmplY3RfZ2V0KG9iaik7Cj4+PiArwqDC
oMKgIHJldCA9IGRybV92bWFfbm9kZV9hbGxvdygmb2JqLT52bWFfbm9kZSwgZmlsZV9wcml2KTsK
Pj4+ICvCoMKgwqAgaWYgKHJldCkKPj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9wdXQ7Cj4+
PiArCj4+PiArwqDCoMKgIGlmIChvYmotPmZ1bmNzLT5vcGVuKSB7Cj4+PiArwqDCoMKgwqDCoMKg
wqAgcmV0ID0gb2JqLT5mdW5jcy0+b3BlbihvYmosIGZpbGVfcHJpdik7Cj4+PiArwqDCoMKgwqDC
oMKgwqAgaWYgKHJldCkKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyX3Jldm9r
ZTsKPj4+ICvCoMKgwqAgfQo+Pj4gKwo+Pj4gwqDCoMKgwqDCoCAvKgo+Pj4gLcKgwqDCoMKgICog
R2V0IHRoZSB1c2VyLXZpc2libGUgaGFuZGxlIHVzaW5nIGlkci7CoCBQcmVsb2FkIGFuZCBwZXJm
b3JtCj4+PiAtwqDCoMKgwqAgKiBhbGxvY2F0aW9uIHVuZGVyIG91ciBzcGlubG9jay4KPj4+ICvC
oMKgwqDCoCAqIEdldCB0aGUgdXNlci12aXNpYmxlIGhhbmRsZSB1c2luZyBpZHIgYXMgdGhlIF9s
YXN0XyBzdGVwLgo+Pj4gK8KgwqDCoMKgICogUHJlbG9hZCBhbmQgcGVyZm9ybSBhbGxvY2F0aW9u
IHVuZGVyIG91ciBzcGlubG9jay4KPj4+IMKgwqDCoMKgwqDCoCAqLwo+Pj4gwqDCoMKgwqDCoCBp
ZHJfcHJlbG9hZChHRlBfS0VSTkVMKTsKPj4+IMKgwqDCoMKgwqAgc3Bpbl9sb2NrKCZmaWxlX3By
aXYtPnRhYmxlX2xvY2spOwo+Pj4gLQo+Pj4gwqDCoMKgwqDCoCByZXQgPSBpZHJfYWxsb2MoJmZp
bGVfcHJpdi0+b2JqZWN0X2lkciwgb2JqLCAxLCAwLCBHRlBfTk9XQUlUKTsKPj4+IC0KPj4+IMKg
wqDCoMKgwqAgc3Bpbl91bmxvY2soJmZpbGVfcHJpdi0+dGFibGVfbG9jayk7Cj4+PiDCoMKgwqDC
oMKgIGlkcl9wcmVsb2FkX2VuZCgpOwo+Pj4gLcKgwqDCoCBtdXRleF91bmxvY2soJmRldi0+b2Jq
ZWN0X25hbWVfbG9jayk7Cj4+PiDCoMKgwqDCoMKgIGlmIChyZXQgPCAwKQo+Pj4gLcKgwqDCoMKg
wqDCoMKgIGdvdG8gZXJyX3VucmVmOwo+Pj4gLQo+Pj4gLcKgwqDCoCBoYW5kbGUgPSByZXQ7Cj4+
PiArwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfY2xvc2U7Cj4+PiAtwqDCoMKgIHJldCA9IGRybV92
bWFfbm9kZV9hbGxvdygmb2JqLT52bWFfbm9kZSwgZmlsZV9wcml2KTsKPj4+IC3CoMKgwqAgaWYg
KHJldCkKPj4+IC3CoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9yZW1vdmU7Cj4+PiArwqDCoMKgIG11
dGV4X3VubG9jaygmZGV2LT5vYmplY3RfbmFtZV9sb2NrKTsKPj4+IC3CoMKgwqAgaWYgKG9iai0+
ZnVuY3MtPm9wZW4pIHsKPj4+IC3CoMKgwqDCoMKgwqDCoCByZXQgPSBvYmotPmZ1bmNzLT5vcGVu
KG9iaiwgZmlsZV9wcml2KTsKPj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+Pj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfcmV2b2tlOwo+Pj4gLcKgwqDCoCB9Cj4+PiArwqDC
oMKgICpoYW5kbGVwID0gcmV0Owo+Pj4gLcKgwqDCoCAqaGFuZGxlcCA9IGhhbmRsZTsKPj4+IMKg
wqDCoMKgwqAgcmV0dXJuIDA7Cj4+PiArZXJyX2Nsb3NlOgo+Pj4gK8KgwqDCoCBpZiAob2JqLT5m
dW5jcy0+Y2xvc2UpCj4+PiArwqDCoMKgwqDCoMKgwqAgb2JqLT5mdW5jcy0+Y2xvc2Uob2JqLCBm
aWxlX3ByaXYpOwo+Pj4gwqAgZXJyX3Jldm9rZToKPj4+IMKgwqDCoMKgwqAgZHJtX3ZtYV9ub2Rl
X3Jldm9rZSgmb2JqLT52bWFfbm9kZSwgZmlsZV9wcml2KTsKPj4+IC1lcnJfcmVtb3ZlOgo+Pj4g
LcKgwqDCoCBzcGluX2xvY2soJmZpbGVfcHJpdi0+dGFibGVfbG9jayk7Cj4+PiAtwqDCoMKgIGlk
cl9yZW1vdmUoJmZpbGVfcHJpdi0+b2JqZWN0X2lkciwgaGFuZGxlKTsKPj4+IC3CoMKgwqAgc3Bp
bl91bmxvY2soJmZpbGVfcHJpdi0+dGFibGVfbG9jayk7Cj4+PiAtZXJyX3VucmVmOgo+Pj4gLcKg
wqDCoCBkcm1fZ2VtX29iamVjdF9oYW5kbGVfcHV0X3VubG9ja2VkKG9iaik7Cj4+PiArZXJyX3B1
dDoKPj4+ICvCoMKgwqAgaWYgKC0tb2JqLT5oYW5kbGVfY291bnQgPT0gMCkKPj4+ICvCoMKgwqDC
oMKgwqDCoCBkcm1fZ2VtX29iamVjdF9wdXQob2JqKTsKPj4+ICsKPj4+ICvCoMKgwqAgbXV0ZXhf
dW5sb2NrKCZkZXYtPm9iamVjdF9uYW1lX2xvY2spOwo+Pj4gKwo+Pj4gwqDCoMKgwqDCoCByZXR1
cm4gcmV0Owo+Pj4gwqAgfQo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
