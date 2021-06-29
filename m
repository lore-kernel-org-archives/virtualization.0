Return-Path: <SRS0=tbjA=LX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7D4C11F68
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 03:52:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15EB61D45
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 03:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15EB61D45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BADD681BC5;
	Tue, 29 Jun 2021 03:52:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NoW1LyGWYuvW; Tue, 29 Jun 2021 03:52:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3B96E81AF4;
	Tue, 29 Jun 2021 03:52:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F1BBC0010;
	Tue, 29 Jun 2021 03:52:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0992BC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 03:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DB1224028A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 03:52:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rgz1TIO1k-PH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 03:52:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE23940287
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 03:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624938753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2buCFHQm6cdcR4pSiR+XWIRELoRMnm4TFpB0hkzjxE=;
 b=JsRQ3bb5Z9baClo7MjvOulBEateUMD+ckOxKmZoO6h8aTj0ZssYtgoR0IMTpNz6dEBvHsw
 cIru23xrAcMVlR2yUtk1V1lVmGIktID3g3iu5JFXbbOOlYP52pXb/XsnNG0Vg8C9ww1ku+
 R/c5sT0XtiNoRkZiWZ/dlc4b5Kg3VhU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-OrljWGfbNZaEfd0rQRKiGA-1; Mon, 28 Jun 2021 23:52:30 -0400
X-MC-Unique: OrljWGfbNZaEfd0rQRKiGA-1
Received: by mail-pj1-f71.google.com with SMTP id
 t5-20020a17090a4485b029016f7fcb8a3dso1360169pjg.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 20:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=G2buCFHQm6cdcR4pSiR+XWIRELoRMnm4TFpB0hkzjxE=;
 b=aGv+BARxK/BjGZZVEyIlCEqoZoW0Q2TpGP86PQ2+WqgitprccUQaw6FPTxggLiFeea
 GYVbA1Jd3DIKNMGMfTKT2zmb2rXBC5jjoP77ZFShJnBrd6+Ci1WtRUgAnd3PHVxRfKgJ
 u0VXS3dMlWBtIHgz7meNaPOESloewzDZoWgmd4lneWwCSS76GG338VGjEbqdD7ui7/d4
 Gj7M94pZZ+89nuuKqbXngfudXg+2ZM3Ty6QALaCPnK6B4M+vag4pqy1mH0ryJAAxjlCB
 evtjWZm2przNwOKHLHsEl+MfLGe+b08iDJpEsJzk1ZepLlOmvnR4f4gsJuPvc5623TkU
 FB9g==
X-Gm-Message-State: AOAM531KTdUUemE8rJbZsDDNoI3u1XbLw/zzS+mjUlENxA3VVEyDyEfO
 Q5zeXGgN1EgbKpnnyvR2BINQZott5xc1Fxl9PJXnfMg/7VSd3uxh5XojMbPVZFt5Zo4C6lJne1V
 lXj9mYgNI+evwHPPdb3Bsc/hJCvAG0yoNxGeYz8i/oA==
X-Received: by 2002:a63:1215:: with SMTP id h21mr25972109pgl.173.1624938749588; 
 Mon, 28 Jun 2021 20:52:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFQl7+KgawoAiXs+cHpWEn/IdiniKnjReF89g47vXS0f+Y5GvLCtHisFRRaSxNexV+kwCP2w==
X-Received: by 2002:a63:1215:: with SMTP id h21mr25972084pgl.173.1624938749320; 
 Mon, 28 Jun 2021 20:52:29 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id n6sm16410565pgt.7.2021.06.28.20.52.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jun 2021 20:52:28 -0700 (PDT)
Subject: Re: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
To: Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210616191155.102303-3-parav@nvidia.com>
 <aa7899c0-4b6b-dee3-a175-91e0394bc999@redhat.com>
 <PH0PR12MB5481AE651E0E9BFA6A1839EEDC099@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0434617e-f960-eb1a-a682-49b6a754413f@redhat.com>
 <PH0PR12MB548147BE1B95CB294785470CDC089@PH0PR12MB5481.namprd12.prod.outlook.com>
 <d361bd10-3967-8844-1457-48e7e9422fb2@redhat.com>
 <PH0PR12MB54812DD2DADAD0897E24CFA7DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4e0708fb-34e3-471d-ca98-44c75f693b32@redhat.com>
 <PH0PR12MB54811C39B86AC8D6BECA9E05DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7a0a8bdf-4cd2-2fc2-73a5-53fb2ab432b6@redhat.com>
 <PH0PR12MB54819F782D5D7E6F9DCDF5FEDC069@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5350f5c0-c707-c3ec-8ed8-16c884467ffa@redhat.com>
 <PH0PR12MB5481030671D848D951477571DC039@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bf6ec662-b53d-174f-53e2-735589f83d3d@redhat.com>
Date: Tue, 29 Jun 2021 11:52:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481030671D848D951477571DC039@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
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

CuWcqCAyMDIxLzYvMjgg5LiL5Y2INjo1NiwgUGFyYXYgUGFuZGl0IOWGmemBkzoKPj4gRnJvbTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4gU2VudDogTW9uZGF5LCBKdW5lIDI4
LCAyMDIxIDEwOjMzIEFNCj4+Cj4gWy4uXQo+Cj4+Pj4gSSBkb24ndCBzZWUgd2h5IGl0IG5lZWRz
IHR5cGVjYXN0LCB2aXJ0aW9fbmV0X2NvbmZpZyBpcyBhbHNvIHVBQkksCj4+Pj4geW91IGNhbiBk
ZWZlcmVuY2UgdGhlIGZpZWxkcyBkaXJlY3RseS4KPj4+Pgo+Pj4gVXNlciB3YW50cyBzZXQgb25s
eSB0aGUgbWFjIGFkZHJlc3Mgb2YgdGhlIGNvbmZpZyBzcGFjZS4gSG93IGRvIHVzZXIKPj4gc3Bh
Y2UgdGVsbCB0aGlzPwo+Pgo+Pgo+PiBHb29kIHF1ZXN0aW9uLCBidXQgd2UgbmVlZCBmaXJzdCBh
bnN3ZXI6Cj4+Cj4+ICJEbyB3ZSBhbGxvdyB1c2Vyc3BhY2Ugc3BhY2UgdG8gbW9kaWZ5IG9uZSBz
cGVjaWZpYyBmaWVsZCBvZiBhbGwgdGhlIGNvbmZpZz8iCj4+Cj4gRXZlbiBpZiB3ZSByZXN0cmlj
dCB0byBzcGVjaWZ5IGNvbmZpZyBwYXJhbXMgYXQgY3JlYXRpb24gdGltZSwgcXVlc3Rpb24gc3Rp
bGwgcmVtYWlucyBvcGVuIGhvdyB0byBwYXNzLCBlaXRoZXIgYXMgd2hvbGUgc3RydWN0ICsgc2lk
ZV9iYXNlZCBpbmZvIG9yIGFzIGluZGl2aWR1YWwgZmllbGRzLgo+IE1vcmUgYmVsb3cuCgoKUmln
aHQuCgoKPgo+Pj4gUGFzcyB0aGUgd2hvbGUgdmlydGlvX25ldF9jb25maWcgYW5kIGluZm9ybSB2
aWEgc2lkZSBjaGFubmVsPwo+Pgo+PiBUaGF0IGNvdWxkIGJlIGEgbWV0aG9kLgo+IEkgcHJlZmVy
IHRoZSBtZXRob2QgdG8gcGFzcyBpbmRpdmlkdWFsIGZpZWxkcyB3aGljaCBoYXMgdGhlIGNsZWFu
IGNvZGUgYXBwcm9hY2ggYW5kIGZ1bGwgZmxleGliaWxpdHkuCj4gQ2xlYW4gY29kZSA9Cj4gMS4g
bm8gdHlwZWNhc3RpbmcgYmFzZWQgb24gbGVuZ3RoCj4gMi4gc2VsZi1kZXNjcmliaW5nIGZpZWxk
cywgZG8gbm90IGRlcGVuZHMgb24gZmVhdHVyZSBiaXRzIHBhcnNpbmcKPiAzLiBwcm9vZiBhZ2Fp
bnN0IHN0cnVjdHVyZSBzaXplIGluY3JlYXNlcyBpbiBmdWxseSBiYWNrd2FyZC9mb3J3YXJkIGNv
bXBhdGliaWxpdHkgd2l0aG91dCBjb2RlIGNoYW5nZXMKCgpTbyBJIHRoaW5rIEkgYWdyZWUuIEJ1
dCBJIHRoaW5rIHdlJ2QgYmV0dGVyIHRvIHRoYXQgaW4gdGhlIHZpcml0byB1QVBJIAooaW5jbHVk
ZS91YXBpL2xpbnV4L3Zpcml0b194eHguaCkKCgo+Pgo+Pj4gT3IgdmVuZG9yIGRyaXZlciBpcyBl
eHBlY3RlZCB0byBjb21wYXJlIHdoYXQgZmllbGRzIGNoYW5nZWQgZnJvbSBvbGQKPj4gY29uZmln
IHNwYWNlPwo+Pgo+Pgo+PiBTbyBJIHRoaW5rIHdlIG5lZWQgc29sdmUgdGhlbSBhbGwsIGJ1dCBu
ZXRsaW5rIGlzIHByb2JhYmx5IHRoZSB3cm9uZwo+PiBsYXllciwgd2UgbmVlZCB0byBzb2x2ZSB0
aGVtIGF0IHZpcnRpbyBsZXZlbCBhbmQgbGV0IG5ldGxpbmsgYSB0cmFuc3BvcnQKPj4gZm9yIHRo
ZW0gdmlydGlvIHVBUEkvQUJJLgo+IEluIHNwaXJpdCBvZiB1c2luZyB0aGUgdmlydGlvIFVBUEkg
c3RydWN0dXJlLCB3ZSBjcmVhdGluZyBvdGhlciBzaWRlIGJhbmQgZmllbGRzLCB0aGF0IHJlc3Vs
dHMgaW50byBjb2RlIHRoYXTigJlzIG5vdCBjb21tb24gdG8gbmV0bGluayBtZXRob2QuCgoKSSB0
aGluayBtYXliZSB3ZSBjYW4gc3RhcnQgZnJvbSBpbnZlbnRpbmcgbmV3IHZpcnRpbyB1QVBJIGFu
ZCBzZWUgaWYgaXQgCmhhcyBzb21lIGNvbnRyYWRpY3Qgd2l0aCBuZXRsaW5rLiBPciBtYXliZSB5
b3UgY2FuIGdpdmUgbWUgc29tZSBleGFtcGxlPwoKCj4gSW9jdGwoKSBpbnRlcmZhY2Ugb2YgUUVN
VS92aG9zdCBkaWRuJ3QgaGF2ZSBhbnkgb3RoZXIgY2hvaWNlIHdpdGggaW9jdGwoKS4KPgo+PiBB
bmQgd2UgbmVlZCB0byBmaWd1cmUgb3V0IGlmIHdlIHdhbnQgdG8gYWxsb3cgdGhlIHVzZXJzcGFj
ZSB0byBtb2RpZnkKPj4gdGhlIGNvbmZpZyBhZnRlciB0aGUgZGV2aWNlIGlzIGNyZWF0ZWQuIElm
IG5vdCwgc2ltcGx5IGJ1aWxkIHRoZQo+PiB2aXJ0aW9fbmV0X2NvbmZpZyBhbmQgcGFzcyBpdCB0
byB0aGUgdkRQQSBwYXJlbnQgZHVyaW5nIGRldmljZSBjcmVhdGlvbi4KPiBJIGxpa2UgdGhpcyBp
ZGVhIHRvIHBhc3MgZmllbGRzIGF0IGNyZWF0aW9uIHRpbWUuCj4KPj4gSWYgbm90LCBpbnZlbnQg
bmV3IHVBUEkgYXQgdmlydGlvIGxldmVsIHRvIHBhc3NpbmcgdGhlIGNvbmZpZyBmaWVsZHMuCj4+
IFZpcnRpbyBvciB2RFBBIGNvcmUgY2FuIHByb3ZpZGUgdGhlIGxpYnJhcnkgdG8gY29tcGFyZSB0
aGUgZGlmZmVyZW5jZS4KPj4KPj4gTXkgZmVlbGluZyBpcyB0aGF0LCBpZiB3ZSByZXN0cmljdCB0
byBvbmx5IHN1cHBvcnQgYnVpbGQgdGhlIGNvbmZpZwo+PiBkdXJpbmcgdGhlIGNyZWF0aW9uLCBp
dCB3b3VsZCBzaW1wbHkgYSBsb3Qgb2YgdGhpbmdzLiBBbmQgSSBkaWRuJ3QKPj4gbm90aWNlIGEg
dXNlIGNhc2UgdGhhdCB3ZSBuZWVkIHRvIGNoYW5nZSB0aGUgY29uZmlnIGZpZWxkcyBpbiB0aGUg
bWlkZGxlCj4+IHZpYSB0aGUgbWFuYWdlbWVudCBBUEkvdG9vbC4KPj4KPiBTdXJlIHllcy4gV2hp
Y2hldmVyIGNvbmZpZyBmaWVsZHMgdXNlciB3YW50cyB0byBwYXNzLCB1c2VyIHNwYWNlIHBhc3Nl
cyBpdC4KPgo+Pj4+IEZvciB2aXJpdG9fbmV0X2NvbmZpZywgd2h5IG5vdCBzaW1wbHk6Cj4+Pj4K
Pj4+PiBsZW4gPSBvcHMtPmdldF9jb25maWdfbGVuKCk7Cj4+Pj4gY29uZmlnID0ga21hbGxvYyhs
ZW4sIEdGUF9LRVJORUwpOwo+Pj4+IG9wcy0+Z2V0X2NvbmZpZyh2ZGV2LCAwLCBjb25maWcsIGxl
bik7Cj4+Pj4gbmxhX3B1dChza2IsIFZJUlRJT19DT05GSUcsIGNvbmZpZywgbGVuKTsKPj4+IFVz
ZXIgc3BhY2UgbmVlZCB0byBwYXJzZSBjb250ZW50IGJhc2VkIG9uIHRoaXMgbGVuZ3RoIGFzIGl0
IGNhbiBjaGFuZ2UgaW4KPj4gZnV0dXJlLgo+Pj4gTGVuZ3RoIHRlbGxpbmcgaG93IHRvIHR5cGVj
YXN0IGlzIHdhbnQgSSB3YW50IHRvIGF2b2lkIGhlcmUuCj4+Cj4+IFNvIHRoZXJlJ3Mgbm8gcmVh
bCBkaWZmZXJlbmNlLCB1c2luZyB4eHhfaXNfdmFsaWQsIGlzIGp1c3QgYSBpbXBsaWNpdAo+PiBs
ZW5ndGggY2hlY2tpbmcgYXMgd2hhdCBpcyBkb25lIHZpYSBjb25maWdfbGVuOgo+Pgo+PiBpZiAo
YV9pc192YWxpZCkgewo+PiAgIMKgwqDCoCAvKiBkdW1wIGEgKi8KPj4gfSBlbHNlIGlmIChiX2lz
X3ZhbGlkKSB7Cj4+ICAgwqDCoMKgIC8qIGR1bXAgYiAqLwo+PiB9Cj4+Cj4+IHZzLgo+Pgo+PiBp
ZiAobGVuZ3RoIDwgb2Zmc2V0b2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnLCBuZXh0IGZpZWxk
IG9mIGEpKSB7Cj4+ICAgwqDCoMKgIC8qIGR1bXAgYSovCj4gKyB0aGUgZmVhdHVyZSBwYXJzaW5n
IGNvZGUsIGZvciBlYWNoIGZpZWxkLgo+Cj4+IH0KPj4KPj4gQWN0dWFsbHksIFFlbXUgaGFzIHNv
bHZlZCB0aGUgc2ltaWxhciBpc3N1ZXMgdmlhIHRoZSB1QVBJOgo+Pgo+PiBodHRwczovL2dpdC5x
ZW11Lm9yZy8/cD1xZW11LmdpdDthPWJsb2I7Zj1ody9uZXQvdmlydGlvLQo+PiBuZXQuYztoPWJk
Nzk1OGI5ZjBlZWQyNzA1ZTBkNmEyZmVhZWFlZmI1ZTYzYmQ2YTQ7aGI9SEVBRCNsOTIKPj4KPj4g
SWYgdGhlIGN1cnJlbnQgdUFQSSBpcyBub3Qgc3VmZmljaWVudCwgbGV0J3MgdHdlYWsgaXQuCj4g
SSBhbSB1bmFibGUgdG8gY29udmluY2UgbXkgc2VsZiB0byBidWlsZCBzaWRlIGJpdG1hc2sgZm9y
IGNvbmZpZyBmaWVsZHMsIHR5cGUgY2FzdGluZyBjb2RlIGluIHNwaXJpdCBvZiB1c2luZyBleGlz
dGluZyBzdHJ1Y3R1cmUgVUFQSS4KPiBUaGlzIGNyZWF0ZXMgbWVzc3kgY29kZSBmb3IgZnV0dXJl
LgoKCkp1c3QgYSBxdWljayB0aG91Z2h0LCBob3cgYWJvdXQgc2ltcGx5IHNvbWV0aGluZyBsaWtl
OgoKc3RydWN0IHZpcnRpb19uZXRfY29uZmlnX2J1aWxkIHsKIMKgwqDCoMKgwqDCoMKgIF9fdTgg
bWFjW0VUSF9BTEVOXTsKIMKgwqDCoMKgwqDCoMKgIF9fdmlydGlvMTYgbWF4X3ZpcnRxdWV1ZV9w
YWlyczsKIMKgwqDCoCDCoMKgwqAgX192aXJ0aW8xNiByZXNlcnZlZFszXTsKfTsKCkl0IGxvb2tz
IHRvIHdlIGRvbid0IG5lZWQgdGhlIHJlc3Qgb2YgZmllbGRzIGluIHRoZSB2aXJ0aW9fbmV0X2Nv
bmZpZyB0byAKYnVpbGQgdGhlIGNvbmZpZyBzaW5jZSB0aGV5IGFyZSBhbGwgaGFyZHdhcmUgYXR0
cmlidXRlcy4KClNvIGl0IGxvb2tzIHNlbGYtY29udGFpbmVkIGFuZCBjYW4gYmUgdHJhbnNwb3J0
ZWQgdmlhIG5ldGxpbmsuCgpUaGFua3MKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
