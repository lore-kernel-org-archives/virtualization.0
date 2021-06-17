Return-Path: <SRS0=fqYQ=LL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E548C48BE5
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 02:37:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC3E613E2
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 02:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC3E613E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9002E83D12;
	Thu, 17 Jun 2021 02:37:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NUuDZoH0u4Uf; Thu, 17 Jun 2021 02:37:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 479D1839D8;
	Thu, 17 Jun 2021 02:37:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFB03C000E;
	Thu, 17 Jun 2021 02:37:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F812C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 02:37:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0760983C8B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 02:37:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wFtbDgTFEVsZ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 02:37:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED39B839D8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 02:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623897421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z5SUgRme5vfSn2M+kLpJuyGRMNfwStTHpMTYk3YD170=;
 b=azGhS5y2Ka9+eGXOz5c7OVVX4zyxo+f/GtqYgXsMwG1ClW4V9/kGvlscZT7k1jLzeArCdd
 Gurw9CjRnUuBpgZ+ly4AwJ2iUM/QdgFis6bbteff7doqFRxIQKx+sp1TLIe3I3yGnvW2a9
 d7yCn54DKbuGiWUN/nId2+tBqPpmK48=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-ccZH72yJPm6jA-585QQvVw-1; Wed, 16 Jun 2021 22:36:58 -0400
X-MC-Unique: ccZH72yJPm6jA-585QQvVw-1
Received: by mail-pg1-f198.google.com with SMTP id
 t28-20020a63461c0000b0290221e90ef795so2813459pga.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=z5SUgRme5vfSn2M+kLpJuyGRMNfwStTHpMTYk3YD170=;
 b=UPQWgmDEH66SUszizMQqADNRjjq2EQFzOPv1/z/J1lBB5vnkdk5CjIxSsh2wMK7E3y
 QYO9VViqkzSyXpyBA0KZ15YSJT0kPlivdBSjktFIvLplAPDdzvYAQ2fFbYytOlpLw8m6
 A386c/qO1tR4CTJrOyR+9Q6Ib+OZhIs/R0EY3afYAo/I1ruFKPvCJEFJbEzj/2/TjA7T
 XHmFFmcdZYMuSVq30eNfCGODdIx9aJ8ZZEUdl2PA6O6WP6ijNorlrlp1YQzTYEc/NKAG
 pDGdrXQ5JV5t/JI9shKhE5bDLFn9Mh+hQvKDx+oiKPetp3ft1i0slTpZEMsQYeZg6wM1
 PXcQ==
X-Gm-Message-State: AOAM532t9IExR3cqFMySWjmmirofuMtGYSDITb/20GhfTz15qsV6uSSD
 a47JybAvNSxmv3H52BK7BhsT8r2rwVUQtXJ3+PyvKGYd+o19F6QdFvnYAJNGwm4ZttuyIB27nVg
 zm251c+5EXeaB2oTjkpTFGX7AqV10A+yaqjXeZ4ucAw==
X-Received: by 2002:aa7:8886:0:b029:2fe:8eee:4a69 with SMTP id
 z6-20020aa788860000b02902fe8eee4a69mr1172975pfe.73.1623897417215; 
 Wed, 16 Jun 2021 19:36:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJlUPCOW72eixcxEQwNs9jI/9nypgEKYTM8JVt54OOata6jZKvX0oDhYusW5wvm4F8OwAFgw==
X-Received: by 2002:aa7:8886:0:b029:2fe:8eee:4a69 with SMTP id
 z6-20020aa788860000b02902fe8eee4a69mr1172955pfe.73.1623897416935; 
 Wed, 16 Jun 2021 19:36:56 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b1sm3342472pjh.4.2021.06.16.19.36.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 19:36:56 -0700 (PDT)
Subject: Re: [PATCH net-next v5 12/15] virtio-net: support AF_XDP zc tx
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1623848265.175296-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <be83fe73-cdde-6905-6e56-5b220cf302fd@redhat.com>
Date: Thu, 17 Jun 2021 10:36:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623848265.175296-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 netdev@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "dust.li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

CuWcqCAyMDIxLzYvMTYg5LiL5Y2IODo1NywgWHVhbiBaaHVvIOWGmemBkzoKPiBPbiBXZWQsIDE2
IEp1biAyMDIxIDIwOjUxOjQxICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PiB3cm90ZToKPj4g5ZyoIDIwMjEvNi8xNiDkuIvljYg2OjE5LCBYdWFuIFpodW8g5YaZ6YGTOgo+
Pj4+PiArICogSW4gdGhpcyB3YXksIGV2ZW4gaWYgeHNrIGhhcyBiZWVuIHVuYnVuZGxlZCB3aXRo
IHJxL3NxLCBvciBhIG5ldyB4c2sgYW5kCj4+Pj4+ICsgKiBycS9zcSAgYXJlIGJvdW5kLCBhbmQg
YSBuZXcgdmlydG5ldF94c2tfY3R4X2hlYWQgaXMgY3JlYXRlZC4gSXQgd2lsbCBub3QKPj4+Pj4g
KyAqIGFmZmVjdCB0aGUgb2xkIHZpcnRuZXRfeHNrX2N0eCB0byBiZSByZWN5Y2xlZC4gQW5kIGZy
ZWUgYWxsIGhlYWQgYW5kIGN0eCB3aGVuCj4+Pj4+ICsgKiByZWYgaXMgMC4KPj4+PiBUaGlzIGxv
b2tzIGNvbXBsaWNhdGVkIGFuZCBpdCB3aWxsIGluY3JlYXNlIHRoZSBmb290cHJpbnQuIENvbnNp
ZGVyIHRoZQo+Pj4+IHBlcmZvcm1hbmNlIHBlbmFsdHkgYW5kIHRoZSBjb21wbGV4aXR5LCBJIHdv
dWxkIHN1Z2dlc3QgdG8gdXNlIHJlc2V0Cj4+Pj4gaW5zdGVhZC4KPj4+Pgo+Pj4+IFRoZW4gd2Ug
ZG9uJ3QgbmVlZCB0byBpbnRyb2R1Y2Ugc3VjaCBjb250ZXh0Lgo+Pj4gSSBkb24ndCBsaWtlIHRo
aXMgZWl0aGVyLiBJdCBpcyBiZXN0IGlmIHdlIGNhbiByZXNldCB0aGUgcXVldWUsIGJ1dCB0aGVu
LAo+Pj4gYWNjb3JkaW5nIHRvIG15IHVuZGVyc3RhbmRpbmcsIHRoZSBiYWNrZW5kIHNob3VsZCBh
bHNvIGJlIHN1cHBvcnRlZAo+Pj4gc3luY2hyb25vdXNseSwgc28gaWYgeW91IGRvbid0IHVwZGF0
ZSB0aGUgYmFja2VuZCBzeW5jaHJvbm91c2x5LCB5b3UgY2FuJ3QgdXNlCj4+PiB4c2suCj4+Cj4+
IFllcywgYWN0dWFsbHksIHZob3N0LW5ldCBzdXBwb3J0IHBlciB2cSBzdXNwZW5kaW5nLiBUaGUg
cHJvYmxlbSBpcyB0aGF0Cj4+IHdlJ3JlIGxhY2tpbmcgYSBwcm9wZXIgQVBJIGF0IHZpcnRpbyBs
ZXZlbC4KPj4KPj4gVmlydGlvLXBjaSBoYXMgcXVldWVfZW5hYmxlIGJ1dCBpdCBmb3JiaWRzIHdy
aXRpbmcgemVybyB0byB0aGF0Lgo+Pgo+Pgo+Pj4gSSBkb27igJl0IHRoaW5rIHJlc2V0dGluZyB0
aGUgZW50aXJlIGRldiBpcyBhIGdvb2Qgc29sdXRpb24uIElmIHlvdSB3YW50IHRvIGJpbmQKPj4+
IHhzayB0byAxMCBxdWV1ZXMsIHlvdSBtYXkgaGF2ZSB0byByZXNldCB0aGUgZW50aXJlIGRldmlj
ZSAxMCB0aW1lcy4gSSBkb27igJl0Cj4+PiB0aGluayB0aGlzIGlzIGEgZ29vZCB3YXkuIEJ1dCB0
aGUgY3VycmVudCBzcGVjIGRvZXMgbm90IHN1cHBvcnQgcmVzZXQgc2luZ2xlCj4+PiBxdWV1ZSwg
c28gSSBjaG9zZSB0aGUgY3VycmVudCBzb2x1dGlvbi4KPj4+Cj4+PiBKYXNvbiwgd2hhdCBkbyB5
b3UgdGhpbmsgd2UgYXJlIGdvaW5nIHRvIGRvPyBSZWFsaXplIHRoZSByZXNldCBmdW5jdGlvbiBv
ZiBhCj4+PiBzaW5nbGUgcXVldWU/Cj4+Cj4+IFllcywgaXQncyB0aGUgYmVzdCB3YXkuIERvIHlv
dSB3YW50IHRvIHdvcmsgb24gdGhhdD8KPiBPZiBjb3Vyc2UsIEkgYW0gdmVyeSB3aWxsaW5nIHRv
IGNvbnRpbnVlIHRoaXMgd29yay4gQWx0aG91Z2ggdXNlcnMgbXVzdCB1cGdyYWRlCj4gdGhlIGJh
Y2tlbmQgdG8gdXNlIHZpcnRpby1uZXQgKyB4c2sgaW4gdGhlIGZ1dHVyZSwgdGhpcyBtYWtlcyB0
aGUgc2l0dWF0aW9uIGEKPiBiaXQgdHJvdWJsZXNvbWUuCj4KPiBJIHdpbGwgY29tcGxldGUgdGhl
IGtlcm5lbCBtb2RpZmljYXRpb24gYXMgc29vbiBhcyBwb3NzaWJsZSwgYnV0IEkgYW0gbm90Cj4g
ZmFtaWxpYXIgd2l0aCB0aGUgcHJvY2VzcyBvZiBzdWJtaXR0aW5nIHRoZSBzcGVjIHBhdGNoLiBD
YW4geW91IGdpdmUgbWUgc29tZQo+IGd1aWRhbmNlIGFuZCB3aGVyZSBzaG91bGQgSSBzZW5kIHRo
ZSBzcGVjIHBhdGNoLgoKClN1YnNjcmliZSB0aGUgdmlydGlvIGRldiBtYWlsaW5nIGxpc3QgWzFd
IGFuZCBzZW5kIHRoZSBzcGVjIHBhdGggdGhlcmUuCgpUaGFua3MKClsxXSAKaHR0cHM6Ly93d3cu
b2FzaXMtb3Blbi5vcmcvY29tbWl0dGVlcy90Y19ob21lLnBocD93Z19hYmJyZXY9dmlydGlvI2Zl
ZWRiYWNrCgoKPgo+IFRoYW5rcy4KPgo+PiBXZSBjYW4gc3RhcnQgZnJvbSB0aGUgc3BlYyBwYXRj
aCwgYW5kIGludHJvZHVjZSBpdCBhcyBiYXNpYyBmYWNpbGl0eSBhbmQKPj4gaW1wbGVtZW50IGl0
IGluIHRoZSBQQ0kgdHJhbnNwb3J0IGZpcnN0Lgo+Pgo+PiBUaGFua3MKPj4KPj4KPj4+IExvb2tp
bmcgZm9yd2FyZCB0byB5b3VyIHJlcGx5ISEhCj4+Pgo+Pj4gVGhhbmtzCj4+PgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
