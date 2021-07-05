Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35198C07E98
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 04:35:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B37613D1
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 04:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B37613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B39F40436;
	Mon,  5 Jul 2021 04:35:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KHbQ4vq5NF-o; Mon,  5 Jul 2021 04:35:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8B4DA4045C;
	Mon,  5 Jul 2021 04:35:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E5D5C0010;
	Mon,  5 Jul 2021 04:35:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0D97C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 04:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDDAE83A0A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 04:35:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RKmjz9fztfH0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 04:35:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EEDA2839DD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 04:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625459727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S4C4ni8EGwQNHqsVwfxpPHMxjLOfCQ5lrgYT6qpkokE=;
 b=dQ1ap0SaxpzcQI5PfcS8ZygzzDmWbDs2Ij7BrgFdQp4/G7Twjr0n+3qD5lKU0IPjV3drpH
 i5OYFyMxFJAM5js2toYJ6gZ/wgj1s8xchsOJ5bO1i4Dw8mOnDVTcV51dTZu1bJmUKiuTOk
 3NFuS7jB9pvjzynF7/OhkfVsrxLJ1zg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-hSNQsrrvOUe_d03DvkXjMg-1; Mon, 05 Jul 2021 00:35:26 -0400
X-MC-Unique: hSNQsrrvOUe_d03DvkXjMg-1
Received: by mail-pl1-f197.google.com with SMTP id
 k6-20020a1709027606b0290104f319bb01so217648pll.13
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Jul 2021 21:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=S4C4ni8EGwQNHqsVwfxpPHMxjLOfCQ5lrgYT6qpkokE=;
 b=dU5W8yBKD9pwg1P+FDH07JYv5r47J1Z/7yGNzIuHWzYoH6AaPoEr698kunOEcySzTE
 CqIfiMzaqxoK0kpOaksmqejIpPhs7yNz4cR7u2X9i6mNClw4AtUbwXTbx46bbjSjzJZ+
 aJbZbod333vPhLZKIlRwEnlX40ifwOuy3BN+lZPyuUGiSgAT8efOKnTOOZt70B5lcFtp
 rSDkYYmiG19aGyTFGRxZBA9m0mEACTRThxESkZsLeQjRQbnAp2PuabCIkw/LZr8r728y
 JWELAZweazv7kqv4opMbTOc6mLaFCeNim/yrI+wKK4sPcVVegJ7irhBShS8J7wMDyd0M
 JftQ==
X-Gm-Message-State: AOAM530qlD/a283AHBSHCvaUaeTXHWW/pMVm6oDAESnSrWwhZ+TuCYmv
 4NQp0sy+mbuDgm6WsPrJDIsDr7siMVdqQuXQr4YXak5M2eRi1D77vHgOy0t4lSTYRkomWZTGw1M
 Xi5kSK4NT2R1bA30bVHQDz2MfzfknnDQjvwO9NOj1Dg==
X-Received: by 2002:a63:d213:: with SMTP id a19mr13724458pgg.28.1625459725436; 
 Sun, 04 Jul 2021 21:35:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqWwzjuoR8vxlAxEdIoYQEy5J2WRCxVYfCe+F+lx71XEa6tjGK0NPAMwML0mb2OEqg6Obn9Q==
X-Received: by 2002:a63:d213:: with SMTP id a19mr13724441pgg.28.1625459725220; 
 Sun, 04 Jul 2021 21:35:25 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id n26sm12118795pgd.15.2021.07.04.21.35.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jul 2021 21:35:24 -0700 (PDT)
Subject: Re: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
To: Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20210616191155.102303-1-parav@nvidia.com>
 <4e0708fb-34e3-471d-ca98-44c75f693b32@redhat.com>
 <PH0PR12MB54811C39B86AC8D6BECA9E05DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7a0a8bdf-4cd2-2fc2-73a5-53fb2ab432b6@redhat.com>
 <PH0PR12MB54819F782D5D7E6F9DCDF5FEDC069@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5350f5c0-c707-c3ec-8ed8-16c884467ffa@redhat.com>
 <PH0PR12MB5481030671D848D951477571DC039@PH0PR12MB5481.namprd12.prod.outlook.com>
 <bf6ec662-b53d-174f-53e2-735589f83d3d@redhat.com>
 <PH0PR12MB548115ACBDA9D76526C370B3DC029@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8c78b8ed-e16c-31dd-7c1c-abd2bef6bb12@redhat.com>
 <PH0PR12MB5481737F058FDE9B947C1ECFDC019@PH0PR12MB5481.namprd12.prod.outlook.com>
 <a23cdc3a-80cb-f5aa-e77c-4b897c8456af@redhat.com>
 <PH0PR12MB5481AC0B0D9D0AC3A62A5EB1DC009@PH0PR12MB5481.namprd12.prod.outlook.com>
 <da0c4e7f-8b59-51ed-f694-04fe5a9ed0b9@redhat.com>
 <PH0PR12MB548102128B368BBE47F5F000DC1F9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <386cf5c8-2f1f-8891-2448-5b6e98f51ea2@redhat.com>
Date: Mon, 5 Jul 2021 12:35:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548102128B368BBE47F5F000DC1F9@PH0PR12MB5481.namprd12.prod.outlook.com>
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

CuWcqCAyMDIxLzcvMiDkuIvljYgyOjA0LCBQYXJhdiBQYW5kaXQg5YaZ6YGTOgo+Cj4+IEZyb206
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+IFNlbnQ6IFRodXJzZGF5LCBKdWx5
IDEsIDIwMjEgMToxMyBQTQo+Pgo+Pgo+PiBBY3R1YWxseSBpdCBkZXBlbmRzIG9uIHdoYXQgYXR0
cmlidXRlcyBpcyByZXF1aXJlZCBmb3IgYnVpbGRpbmcgdGhlIGNvbmZpZy4KPj4KPj4gV2UgY2Fu
IHNpbXBseSByZXVzZSB0aGUgZXhpc3RpbmcgdmlydGlvX25ldF9jb25maWcsIGlmIG1vc3Qgb2Yg
dGhlIGZpZWxkcyBhcmUKPj4gcmVxdWlyZWQuCj4+Cj4+IHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZp
Z19zZXQgewo+PiAgIMKgwqDCoCDCoMKgwqAgX192aXJ0aW82NCBmZWF0dXJlczsKPj4gICDCoMKg
wqAgwqDCoMKgIHVuaW9uIHsKPj4gICDCoMKgwqAgwqDCoMKgIMKgwqDCoCBzdHJ1Y3QgdmlydGlv
X25ldF9jb25maWc7Cj4+ICAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgX192aXJ0aW82NCByZXNlcnZl
ZFs2NF07Cj4+ICAgwqDCoMKgIMKgwqDCoCB9Cj4+IH07Cj4+Cj4+IElmIG9ubHkgZmV3IG9mIHRo
ZSBpcyByZXF1aXJlZCwgd2UgY2FuIGp1c3QgcGljayB0aGVtIGFuZCB1c2UgYW5vdGhlcgo+PiBz
dHJ1Y3R1cmUuCj4gVGhlIHBvaW50IGlzIHdlIGRlZmluZSBzdHJ1Y3R1cmUgYmFzZWQgb24gY3Vy
cmVudCBmaWVsZHMuIFRvbW9ycm93IGEgbmV3IFJTUyBvciByeCBzY2FsaW5nIHNjaGVtZSBhcHBl
YXJzLCBhbmQgc3RydWN0dXJlIHNpemUgbWlnaHQgbmVlZCBjaGFuZ2UuCj4gQW5kIGl0IGRlbWFu
ZHMgdXMgdG8gZ28gYmFjayB0byBsZW5ndGggYmFzZWQgdHlwZWNhc3RpbmcgY29kZS4KPiBhbmQg
dG8gYXZvaWQgc29tZSBsZW5ndGggY2hlY2sgd2UgcGljayBzb21lIGFyYml0cmFyeSBzaXplIHJl
c2VydmVkIHdvcmRzLgo+IEFuZCBJIGRvIG5vdCBrbm93IHdoYXQgbmV0d29yayByZXNlYXJjaCBn
cm91cCB3aWxsIGNvbWUgdXAgZm9yIG5ldyByc3MgYWxnb3JpdGhtIGFuZCBuZWVkZWQgcGx1bWJp
bmcuCgoKWWVzLCBidXQgYXMgZGlzY3Vzc2VkLCB3ZSBtYXkgc3VmZmVyIHRoZSBzaW1pbGFyIGlz
c3VlIGF0IHRoZSBkZXZpY2UgCmxldmVsLiBFLmcgd2UgbmVlZCBhIGNvbW1hbmQgdG8gbGV0IFBG
IHRvICJidWlsZCIgdGhlIGNvbmZpZyBmb3IgYSBWRiBvciBTRi4KCgo+Cj4+IEFjdHVhbGx5LCBJ
IHRoaW5rIGp1c3QgcGFzcyB0aGUgd2hvbGUgY29uZmlnIHdpdGggdGhlIGRldmljZV9mZWF0dXJl
cyBkdXJpbmcKPj4gZGV2aWNlIGNyZWF0aW9uIGlzIGEgZ29vZCBjaG9pY2UgdGhhdCBjYW4gc2lt
cGxpZnkgYSBsb3Qgb2YgdGhpbmdzLgo+IFllcy4gSSB0b3RhbGx5IGFncmVlIHRvIHRoaXMuCj4K
Pj4gV2UgY2FuIGRlZmluZSB3aGF0IGlzIG5lZWRlZCBhbmQgaWdub3JlIHRoZSBvdGhlcnMgaW4g
dGhlIHZpcnRpbyBzcGVjLgo+PiBUaGVuIHRoZXJlJ3Mgbm8gbmVlZCB0byB3b3JyeSBhYm91dCBh
bnkgb3RoZXIgdGhpbmdzLiB2RFBBIGNvcmUgY2FuIGp1c3QgZG8KPj4gc2FudGl5IHRlc3QgbGlr
ZSBjaGVja2luZyBzaXplIHZzIGZlYXR1cmVzLgo+IFllcywgd2UgYXJlIHRyeWluZyB0byBoYXZl
IGNvZGUgdGhhdCBhdm9pZHMgc3VjaCBzYW5pdHkgY2hlY2tzIGJhc2VkIG9uIHN0cnVjdHVyZSBz
aXplLCBsZW5ndGggZXRjIGZpZWxkcy4gOi0pCj4KPj4KPj4+IEluc3RlYWQgb2YgZG9pbmcgdGhl
bSBhcyBpbmRpdmlkdWFsIG5ldGxpbmsgYXR0cmlidXRlcywgaXRzIGx1bXBlZCB0b2dldGhlcgo+
PiBpbiBhIHN0cnVjdCBvZiBhcmJpdHJhcnkgbGVuZ3RoLiA6LSkKPj4KPj4KPj4gSSB0aGluayBu
b3Q/IFdlIHdhbnQgdG8gaGF2ZSBhIGZpeGVkIGxlbmd0aCBvZiB0aGUgc3RydWN0dXJlIHdoaWNo
IG5ldmVyCj4+IGdyb3cuCj4+Cj4gSSBhbSBub3Qgc3VyZSBkZWZpbmluZyB0aGF0IGZ1dHVyZSBu
b3cgaXMgcmlnaHQgY2hvaWNlLCBhdCBsZWFzdCBmb3IgbWUuCj4KPj4gU28gdGhlIGRpZmZlcmVu
dCBpczoKPj4KPj4gMSkgdXNpbmcgbmV0bGluayBkZWRpY2F0ZWQgZmllbGRzCj4+Cj4+IGlmIChu
bF9hdHRyc1tWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFDQUREUl0pCj4+Cj4+IDIpIHVzaW5nIG5l
dGxpbmsgYXMgdHJhbnNwb3J0Cj4+Cj4+IGlmIChmZWF0dXJlcyAmIFZJUlRJT19ORVRfRl9NQUMp
Cj4+Cj4+Cj4+PiBJIG5vdGljZSBzZXZlcmFsIGZpZWxkcyBvZiB0aGUgdmR1c2UgZGV2aWNlIGlz
IHNldHVwIHZpYSBpb2N0bCwgd2hpY2ggSSB0aGluawo+PiBzaG91bGQgYmUgc2V0dXAgdmlhIHRo
aXMgdmRwYSBkZXZpY2UgYWRkIGludGVyZmFjZS4KPj4+IEFsc28gd2UgY2FuIGFsd2F5cyB3cmFw
IGFib3ZlIG5sX2F0dHIgY29kZSBpbiBhIGhlbHBlciBBUEkgc28gdGhhdCBkcml2ZXJzCj4+IHRv
IG5vdCBoYW5kLWNvZGUgaXQuCj4+Cj4+Cj4+IFRoZW4gaXQgd291bGQgYmUgc3RpbGwgbW9yZSBs
aWtlIDIpIGFib3ZlICh3cmFwIG5ldGxpbmsgYmFjayB0bwo+PiBzb21ldGhpbmcgbGlrZSB2aXJ0
aW9fbmV0X2NvbmZpZyk/Cj4+Cj4+Cj4+Pj4gV2UgbWF5IG1lZXQgc2ltaWxhciBpc3N1ZSB3aGVu
IHByb3Zpc2lvbiBWRi9TRiBpbnN0YW5jZSBhdCB0aGUKPj4gaGFyZHdhcmUKPj4+PiBsZXZlbC4g
U28gSSB0aGluayB3ZSBtYXkgbmVlZCBzb21ldGhpbmcgaW4gdGhlIHZpcnRpbyBzcGVjIGluIHRo
ZSBuZWFyCj4+IGZ1dHVyZS4KPiBHaXZlbiB0aGUgZGV2aWNlIGNvbmZpZyBpcyBub3Qgc3BlbGxl
ZCBvdXQgaW4gdGhlIHZpcnRpbyBzcGVjLCBtYXkgYmUgd2UgY2FuIHdhaXQgZm9yIGl0IHRvIGRl
ZmluZSB2aXJ0aW8gbWFuYWdlbWVudCBpbnRlcmZhY2UuCgoKWWVzLgoKCj4KPj4gSSBkb24ndCBv
YmplY3QgYnV0IGl0IG5lZWRzIHRvIGJlIGRvbmUgaW4gdmlydGlvIHVBUEkgaW5zdGVhZCBvZgo+
PiBuZXRsaW5rLCBzaW5jZSBpdCdzIHRoZSBkZXZpY2UgQUJJLgo+IERldmljZSBjb25maWcgY2Fu
IHN1cmVseSBiZSBwYXJ0IG9mIHRoZSB2aXJ0aW8gdUFQSS4KPiBXZSBuZWVkIG5vdCBoYXZlIHB1
dCB0aGF0IGluIFVBUEkuCj4gTW9yZSBiZWxvdy4KPgo+Pj4gVGhpcyBpcyB0aGUgcmV2ZXJzZSBv
ZiBuZXRsaW5rIHdoaWNoIG9mZmVycyB0byBub3QgcmVzZXJ2ZSBhbnkgYXJiaXRyYXJ5IHNpemUK
Pj4gc3RydWN0dXJlLgo+Pgo+Pgo+PiBJdCdzIG5vdCBhcmJpdHJhcnkgYnV0IHdpdGggZml4ZWQg
bGVuZ3RoLgo+IEl0cyBmaXhlZCwgYnV0IGRlY2lkZWQgYXJiaXRyYXJpbHkgbGFyZ2UgaW4gYW50
aWNpcGF0aW9uIHRoYXQgd2UgbGlrZWx5IG5lZWQgdG8gZ3Jvdy4KPiBBbmQgc29tZXRpbWVzIHRo
YXQgZmFsbCBzaG9ydCB3aGVuIG5leHQgcmVzZWFyY2ggY29tZXMgdXAgd2l0aCBtb3JlIGNyZWF0
aXZlIHRob3VnaHRzLgoKCkhvdyBhYm91dCBzb21ldGhpbmcgbGlrZSBUTFZzIGluIHRoZSB2aXJ0
aW8gc3BlYyB0aGVuPwoKCj4KPj4gSXQgbWF5IG9ubHkgd29yayBmb3IgbmV0bGluayAod2l0aCBz
b21lIGR1cGxpY2F0aW9uIHdpdGggdGhlIGV4aXN0aW5nCj4+IHZpcnRpbyB1QVBJKS4gSWYgd2Ug
Y2FuIHNvbHZlIGl0IGF0IGdlbmVyYWwgdmlydGlvIGxheWVyLCBpdCB3b3VsZCBiZQo+PiBiZXR0
ZXIuIE90aGVyd2lzZSB3ZSBuZWVkIHRvIGludmVudCB0aGVtIGFnYWluIGluIHRoZSB2aXJ0aW8g
c3BlYy4KPj4KPiBWaXJ0aW8gc3BlYyB3aWxsIGxpa2VseSBkZWZpbmUgd2hhdCBzaG91bGQgYmUg
Y29uZmlnIGZpZWxkcyB0byBwcm9ncmFtIGFuZCBpdHMgbGF5b3V0Lgo+IEtlcm5lbCBjYW4gYWx3
YXlzIGZpbGwgdXAgdGhlIGZvcm1hdCB0aGF0IHZpcnRpbyBzcGVjIGRlbWFuZHMuCgoKWWVzLCBJ
IHdvbmRlciBpZiB5b3UgaGF2ZSB0aGUgaW50ZXJlc3QgdG8gd29yayBvbiB0aGUgc3BlYyB0byBz
dXBwb3J0IHRoaXMuCgoKPgo+PiBJIHRoaW5rIGV2ZW4gZm9yIHRoZSBjdXJyZW50IG1seDVlIHZE
UEEgaXQgd291bGQgYmUgYmV0dGVyLCBvdGhlcndpc2Ugd2UKPj4gbWF5IGhhdmU6Cj4+Cj4+IHZE
UEEgdG9vbCAtPiBbbmV0bGluayBzcGVjaWZpYyB2RFBBIGF0dHJpYnV0ZXMoMSldIC0+IHZEUEEg
Y29yZSAtPiBbdkRQQQo+PiBjb3JlIHNwZWNpZmljIFZEUEEgYXR0cmlidXRlcygyKV0gLT4gbWx4
NWVfdkRQQSAtPiBbbWx4NWUgc3BlY2lmaWMgdkRQQQo+PiBhdHRyaWJ1dGVzKDMpXSAtPiBtbHg1
ZV9jb3JlCj4+Cj4+IFdlIG5lZWQgdG8gdXNlIGEgc2luZ2xlIGFuZCB1bmlmaWVkIHZpcnRpbyBz
dHJ1Y3R1cmUgaW4gYWxsIHRoZSAoMSksICgyKQo+PiBhbmQgKDMpLgo+IFRoaXMgaXMgd2hlcmUg
SSBkaWZmZXIuCj4gSXRzIG9ubHkgdmRwYSB0b29sIC0+IHZkcGEgY29yZSAtPiB2ZW5kb3JfZHJp
dmVyCj4KPiBWZHBhIHRvb2wgLT4gdmRwYSBjb3JlID0gbmV0bGluayBhdHRyaWJ1dGUKPiBWZHBh
IGNvcmUgLT4gdmVuZG9yIGRyaXZlciA9IHN0cnVjdF9mb28uIChpbnRlcm5hbCBpbnNpZGUgdGhl
IGxpbnV4IGtlcm5lbCkKPgo+IElmIHRvbW9ycm93IHZpcnRpbyBzcGVjIGRlZmluZXMgc3RydWN0
X2ZvbyB0byBiZSBzb21ldGhpbmcgZWxzZSwga2VybmVsIGNhbiBhbHdheXMgdXBncmFkZSB0byBz
dHJ1Y3RfYmFyIHdpdGhvdXQgdXBncmFkaW5nIFVBUEkgbmV0bGluayBhdHRyaWJ1dGVzLgoKClRo
YXQncyBmaW5lLiBOb3RlIHRoYXQgYWN0dWFsbHkgaGF2ZSBhbiBleHRyYSBsZXZlbCBpZiB2ZW5k
b3JfZHJpdmVyIGlzIAp2aXJ0aW8tcGNpIHZEUEEgZHJpdmVyICh2cF92ZHBhKS4KClRoZW4gd2Ug
aGF2ZQoKdmRwYSB0b29sIC0+IHZkcGEgY29yZSAtPiB2cF92ZHBhIC0+IHZpcnRpby1wY2kgZGV2
aWNlCgpTbyB3ZSBzdGlsbCBuZWVkIGludmVudCBjb21tYW5kcyB0byBjb25maWd1cmUvYnVpbGQg
VkYvU0YgY29uZmlnIHNwYWNlIApiZXR3ZWVuIHZwX3ZkcGEgYW5kIHZpcnRpby1wY2kgZGV2aWNl
LiBBbmQgSSB0aGluayB3ZSBtYXkgc3VmZmVyIHRoZSAKc2ltaWxhciBpc3N1ZSBhcyB3ZSBtZXQg
aGVyZSAodmRwYSB0b29sIC0+IHZkcGEgY29yZSkuCgoKPiBOZXRsaW5rIGF0dHJpYnV0ZXMgYWRk
aXRpb24gd2lsbCBiZSBuZWVkZWQgb25seSB3aGVuIHN0cnVjdF9mb28gaGFzIG5ld2VyIGZpZWxk
cy4KPiBUaGlzIHdpbGwgYmUgc3RpbGwgZm9yd2FyZC9iYWNrd2FyZCBjb21wYXRpYmxlLgo+Cj4g
QW4gZXhhY3QgZXhhbXBsZSBvZiB0aGlzIGlzIGRyaXZlcnMvbmV0L3Z4bGFuLmMKPiB2eGxhbl9u
bDJjb25mKCkuCj4gQSB2eGxhbiBkZXZpY2UgbmVlZHMgVk5JLCBzcmMgaXAsIGRzdCBpcCwgdG9z
LCBhbmQgbW9yZS4KPiBJbnN0ZWFkIG9mIHB1dHRpbmcgYWxsIGluIHNpbmdsZSBzdHJ1Y3R1cmUg
dnhsYW5fY29uZmlnIGFzIFVBUEksIHRob3NlIG9wdGlvbmFsIGZpZWxkcyBhcmUgbmV0bGluayBh
dHRyaWJ1dGVzLgo+IEFuZCB2eGxhbiBkcml2ZXIgaW50ZXJuYWxseSBmaWxscyB1cCB0aGUgY29u
ZmlnIHN0cnVjdHVyZS4KPgo+IEkgYW0gdmVyeSBtdWNoIGNvbnZpbmNlZCB3aXRoIHRoZSBhYm92
ZSB2eGxhbiBhcHByb2FjaCB0aGF0IGVuYWJsZXMgYWxsIGZ1bmN0aW9uYWxpdHkgbmVlZGVkIHdp
dGhvdXQgdHlwZWNhc3RpbmcgY29kZSBhbmQgd2l0aG91dCBkZWZpbmluZyBhcmJpdHJhcnkgbGVu
Z3RoIHN0cnVjdHMuCgoKUmlnaHQsIGJ1dCB3ZSBoYWQgc29tZSBzbWFsbCBkaWZmZXJlbmNlcyBo
ZXJlOgoKMSkgdnhsYW4gZG9lc24ndCBoYXZlIGEgZXhpc3RpbmcgdUFQSQoyKSB2eGxhbiBjb25m
aWd1cmF0aW9uIGlzIG5vdCB1c2VkIGZvciBoYXJkd2FyZQoKQmFzaWNhbGx5LCBJJ20gbm90IGFn
YWluc3QgdGhpcyBhcHByb2FjaCwgSSBqdXN0IHdvbmRlciBpZiBpdCdzIApiZXR0ZXIvc2ltcGxl
ciB0byBzb2x2ZSBpdCBhdCB2aXJ0aW8gbGF5ZXIgYmVjYXVzZSB0aGUgc2VtYW50aWMgaXMgCmRl
ZmluZWQgYnkgdGhlIHNwZWMgbm90IG5ldGxpbmsuCgpUaGFua3MKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
