Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F7DC4332F
	for <virtualization@archiver.kernel.org>; Thu, 22 Dec 2022 04:18:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A743418B5;
	Thu, 22 Dec 2022 04:18:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A743418B5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jy7qT3z/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KgAUu9xCTkBe; Thu, 22 Dec 2022 04:18:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7CAEB4093A;
	Thu, 22 Dec 2022 04:18:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7CAEB4093A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E662C0071;
	Thu, 22 Dec 2022 04:18:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 357F3C0070
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 04:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0866E418B4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 04:18:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0866E418B4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8EGgnvWdBroC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 04:18:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 01C6B4093A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 01C6B4093A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 04:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671682702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Qy8hVVHmVV3a9aFahEig8gWF7+7mU2tU8B+FtzuZ9U=;
 b=Jy7qT3z/PwbhKypKPt92PhcRtA48MIj+0++LG6KkrOa1Q0PZRtmoYOgIdaergqhNBQy7Wu
 56aq8c4MPD0IxnR4HY4olA7gO7XCAO5/wbsaKlN3mlR+XTZyeuphz7MpBzoWs/za3RNd4R
 5kaGI7J/5I3uqYk4SOSoc3vUJigs+Jk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-175-Fu1vAvuXMM6qFtShja89Ag-1; Wed, 21 Dec 2022 23:18:21 -0500
X-MC-Unique: Fu1vAvuXMM6qFtShja89Ag-1
Received: by mail-pg1-f200.google.com with SMTP id
 f132-20020a636a8a000000b00473d0b600ebso537227pgc.14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 20:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Qy8hVVHmVV3a9aFahEig8gWF7+7mU2tU8B+FtzuZ9U=;
 b=PZSkj+zLW60k/GkeWggLl+40/VbgpMhfqASt9MPZue9fG2tBvdMTQjiu+cYz8LKuIR
 iHHlI0Oq5d8Mc2CxJ+EqzHvIx8A1DZ7R+x1Vzf6B7dbEUs5mns33MjURrE6NDkou63ge
 seOq05wuYNDC8W1ucgUvKbL7UXlxA3smMl0CG02TaMBWRIwM1Efe/aqGOwj1QmMk1YbZ
 2PSFwpltfZ+IIEI9W0qhdbYnI7Spd/dNt4+diOtvTbc/Y8j0Vbr/L5BY6Vgmhkebzhvx
 Fbpj0fH/BEyCuiqBgE/xV6NGgQAP+Cg2IACKEj0IZF1MYSX1+YkTHfekuPrIX0rGSvFE
 vlWA==
X-Gm-Message-State: AFqh2ko6X5Cx8QN65aHkw4AAlIZxozOPSdLZoYPqNK7Hp6RmUW0OWGxL
 yEqAK9I8Z5lXFXoN0dL1vWW6vB+YRf2foN1uaQKfBJe0zpgrWFBpPubu5rgD/lLqgFb2WuCg7yZ
 v/B8a/z44/ZBx1BfzM862ZXYmBzL32dHYFYtRea1Hqg==
X-Received: by 2002:a17:902:8693:b0:191:e0b0:f8df with SMTP id
 g19-20020a170902869300b00191e0b0f8dfmr4257964plo.58.1671682700266; 
 Wed, 21 Dec 2022 20:18:20 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvZKUVvz7e/snSM74hURYmadL6kaZsaTLi4j3NcrD1AHY0tQQj2CPhCtOvjsaEFfVjLLRP5tg==
X-Received: by 2002:a17:902:8693:b0:191:e0b0:f8df with SMTP id
 g19-20020a170902869300b00191e0b0f8dfmr4257947plo.58.1671682700005; 
 Wed, 21 Dec 2022 20:18:20 -0800 (PST)
Received: from [10.72.13.15] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a170902e54a00b0018b025d9a40sm12290654plf.256.2022.12.21.20.18.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Dec 2022 20:18:19 -0800 (PST)
Message-ID: <bd1c0fea-9934-1956-b3fe-0442d90b0477@redhat.com>
Date: Thu, 22 Dec 2022 12:18:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 1/6] vdpa: add bind_mm callback
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20221214163025.103075-1-sgarzare@redhat.com>
 <20221214163025.103075-2-sgarzare@redhat.com>
 <CACGkMEtB6uQ_6fKU5F-D0vG+gQz9mMdYWUQwre-yp1sVpGvKPQ@mail.gmail.com>
 <20221216081738.wlhevfmvzfs3rsrg@sgarzare-redhat>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221216081738.wlhevfmvzfs3rsrg@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

CuWcqCAyMDIyLzEyLzE2IDE2OjE3LCBTdGVmYW5vIEdhcnphcmVsbGEg5YaZ6YGTOgo+IE9uIEZy
aSwgRGVjIDE2LCAyMDIyIGF0IDAyOjM3OjQ1UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
IE9uIFRodSwgRGVjIDE1LCAyMDIyIGF0IDEyOjMwIEFNIFN0ZWZhbm8gR2FyemFyZWxsYSAKPj4g
PHNnYXJ6YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4KPj4+IFRoaXMgbmV3IG9wdGlvbmFsIGNh
bGxiYWNrIGlzIHVzZWQgdG8gYmluZCB0aGUgZGV2aWNlIHRvIGEgc3BlY2lmaWMKPj4+IGFkZHJl
c3Mgc3BhY2Ugc28gdGhlIHZEUEEgZnJhbWV3b3JrIGNhbiB1c2UgVkEgd2hlbiB0aGlzIGNhbGxi
YWNrCj4+PiBpcyBpbXBsZW1lbnRlZC4KPj4+Cj4+PiBTdWdnZXN0ZWQtYnk6IEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVs
bGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4+PiAtLS0KPj4+IMKgaW5jbHVkZS9saW51eC92ZHBh
LmggfCA4ICsrKysrKysrCj4+PiDCoDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKPj4+
Cj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3Zk
cGEuaAo+Pj4gaW5kZXggNmQwZjVlNGU4MmMyLi4zNDM4OGUyMWVmM2YgMTAwNjQ0Cj4+PiAtLS0g
YS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+Pj4gKysrIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4+
IEBAIC0yODIsNiArMjgyLDEyIEBAIHN0cnVjdCB2ZHBhX21hcF9maWxlIHsKPj4+IMKgICrCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBAaW92
YTogaW92YSB0byBiZSB1bm1hcHBlZAo+Pj4gwqAgKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEBzaXplOiBzaXplIG9mIHRoZSBhcmVhCj4+
PiDCoCAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgUmV0dXJucyBpbnRlZ2VyOiBzdWNjZXNzICgwKSBvciAKPj4+IGVycm9yICg8IDApCj4+
PiArICogQGJpbmRfbW06wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJpbmQg
dGhlIGRldmljZSB0byBhIHNwZWNpZmljIAo+Pj4gYWRkcmVzcyBzcGFjZQo+Pj4gKyAqwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc28gdGhl
IHZEUEEgZnJhbWV3b3JrIGNhbiB1c2UgVkEgCj4+PiB3aGVuIHRoaXMKPj4+ICsgKsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhbGxiYWNr
IGlzIGltcGxlbWVudGVkLiAob3B0aW9uYWwpCj4+PiArICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBAdmRldjogdmRwYSBkZXZpY2UKPj4+
ICsgKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIEBtbTogYWRkcmVzcyBzcGFjZSB0byBiaW5kCj4+Cj4+IERvIHdlIG5lZWQgYW4gdW5iaW5k
IG9yIGRpZCBhIE5VTEwgbW0gbWVhbiB1bmJpbmQ/Cj4KPiBZZXAsIHlvdXIgY29tbWVudCBpbiBw
YXRjaCA2IG1ha2VzIGl0IG5lY2Vzc2FyeS4gSSB3aWxsIGFkZCBpdCEKPgo+Pgo+Pj4gKyAqwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQG93
bmVyOiBwcm9jZXNzIHRoYXQgb3ducyB0aGUgCj4+PiBhZGRyZXNzIHNwYWNlCj4+Cj4+IEFueSBy
ZWFzb24gd2UgbmVlZCB0aGUgdGFza19zdHJ1Y3QgaGVyZT8KPgo+IE1haW5seSB0byBhdHRhY2gg
dG8ga3RocmVhZCB0byB0aGUgcHJvY2VzcyBjZ3JvdXBzLCBidXQgdGhhdCBwYXJ0IGlzIAo+IHN0
aWxsIGluIFRPRE8gc2luY2UgSSBuZWVkIHRvIHVuZGVyc3RhbmQgaXQgYmV0dGVyLgoKCk9rIEkg
c2VlLgoKCj4KPiBNYXliZSB3ZSBjYW4gcmVtb3ZlIHRoZSB0YXNrX3N0cnVjdCBoZXJlIGFuZCB1
c2UgYGN1cnJlbnRgIGRpcmVjdGx5IGluIAo+IHRoZSBjYWxsYmFjay4KCgpZZXMsIGl0J3MgZWFz
aWVyIHRvIHN0YXJ0IHdpdGhvdXQgY2dyb3VwIGFuZCB3ZSBjYW4gYWRkIGl0IG9uIHRvcC4KClRo
YW5rcwoKCj4KPiBUaGFua3MsCj4gU3RlZmFubwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
