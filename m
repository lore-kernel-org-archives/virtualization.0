Return-Path: <SRS0=fqYQ=LL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6928C2B9F4
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 06:03:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7218961245
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 06:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7218961245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3ED414056A;
	Thu, 17 Jun 2021 06:03:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bM-lppcKDTIn; Thu, 17 Jun 2021 06:03:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D982940566;
	Thu, 17 Jun 2021 06:03:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC3FAC000D;
	Thu, 17 Jun 2021 06:03:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1E4FC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:03:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A8514606F5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:03:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jWci4GpXPAlV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:03:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 76221606DD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623909822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1zTTNZzldcOXcFO81FD+YymNMfG6CM1iqsPxo2zJvk=;
 b=JNBtwtAAy8vaQdUuB6uDCNxoMbLAbg5zER3c3awYHf44/O7Kv4s/Prt75EBR0/ZZAAw+rf
 jyMUDM/rkFJ0d9XiL6U9ONvMNr39HFVMzejeIVmow+ICkc83Pe1xWVLad67HILuEqPCWzm
 qhjXH4vV0Zetd4EW9NIK+A3G0JKvP7U=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-uYJY5KzsONKCWMNmchRk2Q-1; Thu, 17 Jun 2021 02:03:39 -0400
X-MC-Unique: uYJY5KzsONKCWMNmchRk2Q-1
Received: by mail-pl1-f200.google.com with SMTP id
 n10-20020a170902e54ab029011af95458e3so1297461plf.15
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 23:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=b1zTTNZzldcOXcFO81FD+YymNMfG6CM1iqsPxo2zJvk=;
 b=hkIUFjTAzkMZE5le9jSSJbBU/BOgqPwP1d3sMhqQsZoRJK/59Urw9xRH5CN2sanN1U
 sQaLQH0esy7bqAcdH1MLFE7BoKMKle62BuEVmBG4DZ0tJLfObBmyR7DBP07YVlXzJ4ju
 0W0AyPU1c9I3QR7yDxXTaIdBdWg/84fY4nMP4wF7uU3Ax+//FuSrfUlrvOihU6fBotpB
 9kC0/BySVYncIdxoTa5H5sS5LZ7/Sk/q49y+cdZVqcTqUQEnTfRVgOF1eGFF3DwsQMdU
 74viy2/Sy6v8GiKgyI00mTSxDAP6W+OW8Ew5VRjGUzD0qIgm9TYZCGuSoXPhAtfRGigz
 MWYQ==
X-Gm-Message-State: AOAM531BGWpFseXO95nx8mHNNK7rSbG7xHGs3xi6HPq0xF1Crdnp4pUj
 1ru/HVlPptj2Mfxgi9PjehNh9Vb1O1bDUJJVezOsOs8mol641vqW7UHMc02L50bSUdushBEN6Z/
 2tkAqxtZ0/buemoi53i6dD5oTXdK6ob9PS8yfcBuERA==
X-Received: by 2002:aa7:80d9:0:b029:2ed:49fa:6dc5 with SMTP id
 a25-20020aa780d90000b02902ed49fa6dc5mr3578817pfn.3.1623909818189; 
 Wed, 16 Jun 2021 23:03:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyneNziveW3pKM2kixvqEMieLDf93TnaHSdn5/1L0tRwaQ6XNsum8Lh4E+DvP8zwQ3nj76oZg==
X-Received: by 2002:aa7:80d9:0:b029:2ed:49fa:6dc5 with SMTP id
 a25-20020aa780d90000b02902ed49fa6dc5mr3578783pfn.3.1623909817981; 
 Wed, 16 Jun 2021 23:03:37 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 125sm3731545pfg.52.2021.06.16.23.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 23:03:37 -0700 (PDT)
Subject: Re: [PATCH net-next v5 13/15] virtio-net: support AF_XDP zc rx
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1623909234.193789-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0d4c5ff5-2b53-6b55-b5aa-bd943af98bb7@redhat.com>
Date: Thu, 17 Jun 2021 14:03:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623909234.193789-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrew Melnychenko <andrew@daynix.com>,
 Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
 yuri Benditovich <yuri.benditovich@daynix.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
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

CuWcqCAyMDIxLzYvMTcg5LiL5Y2IMTo1MywgWHVhbiBaaHVvIOWGmemBkzoKPiBPbiBUaHUsIDE3
IEp1biAyMDIxIDExOjIzOjUyICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PiB3cm90ZToKPj4g5ZyoIDIwMjEvNi8xMCDkuIvljYg0OjIyLCBYdWFuIFpodW8g5YaZ6YGTOgo+
Pj4gQ29tcGFyZWQgdG8gdGhlIGNhc2Ugb2YgeHNrIHR4LCB0aGUgY2FzZSBvZiB4c2sgemMgcngg
aXMgbW9yZQo+Pj4gY29tcGxpY2F0ZWQuCj4+Pgo+Pj4gV2hlbiB3ZSBwcm9jZXNzIHRoZSBidWYg
cmVjZWl2ZWQgYnkgdnEsIHdlIG1heSBlbmNvdW50ZXIgb3JkaW5hcnkKPj4+IGJ1ZmZlcnMsIG9y
IHhzayBidWZmZXJzLiBXaGF0IG1ha2VzIHRoZSBzaXR1YXRpb24gbW9yZSBjb21wbGljYXRlZCBp
cwo+Pj4gdGhhdCBpbiB0aGUgY2FzZSBvZiBtZXJnZWFibGUsIHdoZW4gbnVtX2J1ZmZlciA+IDEs
IHdlIG1heSBzdGlsbAo+Pj4gZW5jb3VudGVyIHRoZSBjYXNlIHdoZXJlIHhzayBidWZmZXIgaXMg
bWl4ZWQgd2l0aCBvcmRpbmFyeSBidWZmZXIuCj4+Pgo+Pj4gQW5vdGhlciB0aGluZyB0aGF0IG1h
a2VzIHRoZSBzaXR1YXRpb24gbW9yZSBjb21wbGljYXRlZCBpcyB0aGF0IHdoZW4gd2UKPj4+IGdl
dCBhbiB4c2sgYnVmZmVyIGZyb20gdnEsIHRoZSB4c2sgYm91bmQgdG8gdGhpcyB4c2sgYnVmZmVy
IG1heSBoYXZlCj4+PiBiZWVuIHVuYm91bmQuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogWHVhbiBa
aHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPj4KPj4gVGhpcyBpcyBzb21laG93IHNp
bWlsYXIgdG8gdGhlIGNhc2Ugb2YgdHggd2hlcmUgd2UgZG9uJ3QgaGF2ZSBwZXIgdnEgcmVzZXQu
Cj4+Cj4+IFsuLi5dCj4+Cj4+PiAtCWlmICh2aS0+bWVyZ2VhYmxlX3J4X2J1ZnMpCj4+PiArCWlm
IChpc194c2tfY3R4KGN0eCkpCj4+PiArCQlza2IgPSByZWNlaXZlX3hzayhkZXYsIHZpLCBycSwg
YnVmLCBsZW4sIHhkcF94bWl0LCBzdGF0cyk7Cj4+PiArCWVsc2UgaWYgKHZpLT5tZXJnZWFibGVf
cnhfYnVmcykKPj4+ICAgIAkJc2tiID0gcmVjZWl2ZV9tZXJnZWFibGUoZGV2LCB2aSwgcnEsIGJ1
ZiwgY3R4LCBsZW4sIHhkcF94bWl0LAo+Pj4gICAgCQkJCQlzdGF0cyk7Cj4+PiAgICAJZWxzZSBp
ZiAodmktPmJpZ19wYWNrZXRzKQo+Pj4gQEAgLTExNzUsNiArMTI5NiwxNCBAQCBzdGF0aWMgYm9v
bCB0cnlfZmlsbF9yZWN2KHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCBzdHJ1Y3QgcmVjZWl2ZV9x
dWV1ZSAqcnEsCj4+PiAgICAJaW50IGVycjsKPj4+ICAgIAlib29sIG9vbTsKPj4+Cj4+PiArCS8q
IEJlY2F1c2UgdmlydGlvLW5ldCBkb2VzIG5vdCB5ZXQgc3VwcG9ydCBmbG93IGRpcmVjdCwKPj4K
Pj4gTm90ZSB0aGF0IHRoaXMgaXMgbm90IHRoZSBjYXNlIGFueSBtb3JlLiBSU1MgaGFzIGJlZW4g
c3VwcG9ydGVkIGJ5Cj4+IHZpcnRpbyBzcGVjIGFuZCBxZW11L3Zob3N0L3RhcCBub3cuIFdlIGp1
c3QgbmVlZCBzb21lIHdvcmsgb24gdGhlCj4+IHZpcnRpby1uZXQgZHJpdmVyIHBhcnQgKGUuZyB0
aGUgZXRob29sIGludGVyZmFjZSkuCj4gT2gsIGFyZSB0aGVyZSBhbnkgcGxhbnM/IFdobyBpcyBk
b2luZyB0aGlzIHdvcmssIGNhbiBJIGhlbHA/CgoKUWVtdSBhbmQgc3BlYyBoYXMgc3VwcG9ydCBS
U1MuCgpUQVAgc3VwcG9ydCBpcyByZWFkeSB2aWEgc3RlZXJpbmcgZUJQRiBwcm9ncmFtLCB5b3Ug
Y2FuIHRyeSB0byBwbGF5IGl0IAp3aXRoIGN1cnJlbnQgcWVtdSBtYXN0ZXIuCgpUaGUgb25seSB0
aGluZyBtaXNzZWQgaXMgdGhlIExpbnV4IGRyaXZlciwgSSB0aGluayBZdXJpIG9yIEFuZHJldyBp
cyAKd29ya2luZyBvbiB0aGlzLgoKVGhhbmtzCgoKPgo+IFRoYW5rcy4KPgo+PiBUaGFua3MKPj4K
Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
