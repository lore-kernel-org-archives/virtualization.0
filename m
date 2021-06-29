Return-Path: <SRS0=tbjA=LX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C181C11F66
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 03:29:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3332261D22
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 03:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3332261D22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7F38606C0;
	Tue, 29 Jun 2021 03:29:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GFeST63NgaGn; Tue, 29 Jun 2021 03:29:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8AA0960817;
	Tue, 29 Jun 2021 03:29:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B4ACC0010;
	Tue, 29 Jun 2021 03:29:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63BCFC001F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 03:29:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 529A38318C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 03:29:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lJGyQlmW0ZHT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 03:29:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16D42830DE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 03:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624937383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Pa1pOlVAvZjnb70QATIYkocaWNNRWiFDRdCDmMIsd8=;
 b=YZOR1thOTkzEXVyPep5BZunN9Su/dBoWZE+w/mnaU3AGeqTaWg8LfLPr76p1O5s4xQF7kH
 sRSzxyMiZm/Z/Jhje1/PpP+azxtNw8Xzu1b4BBR/BCcQnGOPSubKjF9FAfkCYlp+2Ztnqr
 W8QCA3sls5pj/4wykHJVSvYE/Yep83E=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-WZ27DbmUOCWDf8G4Au5oVg-1; Mon, 28 Jun 2021 23:29:39 -0400
X-MC-Unique: WZ27DbmUOCWDf8G4Au5oVg-1
Received: by mail-pg1-f200.google.com with SMTP id
 o9-20020a6561490000b0290226fc371410so12217286pgv.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 20:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2Pa1pOlVAvZjnb70QATIYkocaWNNRWiFDRdCDmMIsd8=;
 b=l3xUqrMhysapUJZRSP6O+unJCraxlFB7606Ika8Umovii7FEEpoeGG/7o3zIwfwEi7
 qn+02iZdYQIHZ6ywF2AbiYZCK4xHdELl42W/JijPFsBCvlEdDM83SiXMLOjHlYYWJd/L
 2DkPHpbWqLOiMkUM0byUBsaG7xZmnTrYVvuoJ/PPXpYJ7GIzVIJZNoJ9eDXwangyNylr
 HguDuQxezl80VtAwWkU3B4WQX0JFWc47LhbbqepASV7qodMiM8Bw18Saex2M/+MvMohS
 swV2iUvWpvSt4iNlbI6mkbgo62cY/DDL4jQYBLavJl7zA/yiEdyfd2I5vZJd4YXxGXZl
 ANiw==
X-Gm-Message-State: AOAM532qS+V1FOx0HAzYTA562nz8X/Ljjwks2qGgDnHdWFnx/SpTkOvX
 xwWj6g1Jzkn/UKCiJKoppemeMXOiCgaxz1k73aywz2cF0iqg4K8SePXlB+nCTGJz86K8j+2qqbS
 QVAjPpzKwnu5A3s2YdXabbIzHw7LRJdzkYbN6O5xBKQ==
X-Received: by 2002:a05:6a00:1742:b029:308:add4:e844 with SMTP id
 j2-20020a056a001742b0290308add4e844mr24162920pfc.18.1624937378554; 
 Mon, 28 Jun 2021 20:29:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwry9N+QCFjvNGydIUFQnfZliYwOwU3q6M/FQals9i/JHLqA6RP5KnmC4UjhvxUQDox0iXaLQ==
X-Received: by 2002:a05:6a00:1742:b029:308:add4:e844 with SMTP id
 j2-20020a056a001742b0290308add4e844mr24162907pfc.18.1624937378357; 
 Mon, 28 Jun 2021 20:29:38 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w21sm1920153pge.30.2021.06.28.20.29.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jun 2021 20:29:37 -0700 (PDT)
Subject: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <CACycT3tAON+-qZev+9EqyL2XbgH5HDspOqNt3ohQLQ8GqVK=EA@mail.gmail.com>
 <1bba439f-ffc8-c20e-e8a4-ac73e890c592@redhat.com>
 <CACycT3uzMJS7vw6MVMOgY4rb=SPfT2srV+8DPdwUVeELEiJgbA@mail.gmail.com>
 <0aeb7cb7-58e5-1a95-d830-68edd7e8ec2e@redhat.com>
 <CACycT3uuooKLNnpPHewGZ=q46Fap2P4XCFirdxxn=FxK+X1ECg@mail.gmail.com>
 <e4cdee72-b6b4-d055-9aac-3beae0e5e3e1@redhat.com>
 <CACycT3u8=_D3hCtJR+d5BgeUQMce6S7c_6P3CVfvWfYhCQeXFA@mail.gmail.com>
 <d2334f66-907c-2e9c-ea4f-f912008e9be8@redhat.com>
 <CACycT3uCSLUDVpQHdrmuxSuoBDg-4n22t+N-Jm2GoNNp9JYB2w@mail.gmail.com>
 <48cab125-093b-2299-ff9c-3de8c7c5ed3d@redhat.com>
 <CACycT3tS=10kcUCNGYm=dUZsK+vrHzDvB3FSwAzuJCu3t+QuUQ@mail.gmail.com>
 <b10b3916-74d4-3171-db92-be0afb479a1c@redhat.com>
 <CACycT3vpMFbc9Fzuo9oksMaA-pVb1dEVTEgjNoft16voryPSWQ@mail.gmail.com>
 <d7e42109-0ba6-3e1a-c42a-898b6f33c089@redhat.com>
 <CACycT3u9-id2DxPpuVLtyg4tzrUF9xCAGr7nBm=21HfUJJasaQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e82766ff-dc6b-2cbb-3504-0ef618d538e2@redhat.com>
Date: Tue, 29 Jun 2021 11:29:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3u9-id2DxPpuVLtyg4tzrUF9xCAGr7nBm=21HfUJJasaQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, joro@8bytes.org,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com,
 Jens Axboe <axboe@kernel.dk>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
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

CuWcqCAyMDIxLzYvMjkg5LiK5Y2IMTA6MjYsIFlvbmdqaSBYaWUg5YaZ6YGTOgo+IE9uIE1vbiwg
SnVuIDI4LCAyMDIxIGF0IDEyOjQwIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
IHdyb3RlOgo+Pgo+PiDlnKggMjAyMS82LzI1IOS4i+WNiDEyOjE5LCBZb25namkgWGllIOWGmemB
kzoKPj4+PiAyYikgZm9yIHNldF9zdGF0dXMoKTogc2ltcGx5IHJlbGF5IHRoZSBtZXNzYWdlIHRv
IHVzZXJzcGFjZSwgcmVwbHkgaXMgbm8KPj4+PiBuZWVkZWQuIFVzZXJzcGFjZSB3aWxsIHVzZSBh
IGNvbW1hbmQgdG8gdXBkYXRlIHRoZSBzdGF0dXMgd2hlbiB0aGUKPj4+PiBkYXRhcGF0aCBpcyBz
dG9wLiBUaGUgdGhlIHN0YXR1cyBjb3VsZCBiZSBmZXRjaGVkIHZpYSBnZXRfc3RhdHMoKS4KPj4+
Pgo+Pj4+IDJiIGxvb2tzIG1vcmUgc3BlYyBjb21wbGFpbnQuCj4+Pj4KPj4+IExvb2tzIGdvb2Qg
dG8gbWUuIEFuZCBJIHRoaW5rIHdlIGNhbiB1c2UgdGhlIHJlcGx5IG9mIHRoZSBtZXNzYWdlIHRv
Cj4+PiB1cGRhdGUgdGhlIHN0YXR1cyBpbnN0ZWFkIG9mIGludHJvZHVjaW5nIGEgbmV3IGNvbW1h
bmQuCj4+Pgo+PiBKdXN0IG5vdGljZSB0aGlzIHBhcnQgaW4gdmlydGlvX2ZpbmFsaXplX2ZlYXR1
cmVzKCk6Cj4+Cj4+ICAgICAgICAgICB2aXJ0aW9fYWRkX3N0YXR1cyhkZXYsIFZJUlRJT19DT05G
SUdfU19GRUFUVVJFU19PSyk7Cj4+ICAgICAgICAgICBzdGF0dXMgPSBkZXYtPmNvbmZpZy0+Z2V0
X3N0YXR1cyhkZXYpOwo+PiAgICAgICAgICAgaWYgKCEoc3RhdHVzICYgVklSVElPX0NPTkZJR19T
X0ZFQVRVUkVTX09LKSkgewo+Pgo+PiBTbyB3ZSBubyByZXBseSBkb2Vzbid0IHdvcmsgZm9yIEZF
QVRVUkVTX09LLgo+Pgo+PiBTbyBteSB1bmRlcnN0YW5kaW5nIGlzOgo+Pgo+PiAxKSBXZSBtdXN0
IG5vdCB1c2Ugbm9yZXBseSBmb3Igc2V0X3N0YXR1cygpCj4+IDIpIFdlIGNhbiB1c2Ugbm9yZXBs
eSBmb3IgZ2V0X3N0YXR1cygpLCBidXQgaXQgcmVxdWlyZXMgYSBuZXcgaW9jdGwgdG8KPj4gdXBk
YXRlIHRoZSBzdGF0dXMuCj4+Cj4+IFNvIGl0IGxvb2tzIHRvIG1lIHdlIG5lZWQgc3luY2hyb25p
emUgZm9yIGJvdGggZ2V0X3N0YXR1cygpIGFuZAo+PiBzZXRfc3RhdHVzKCkuCj4+Cj4gV2Ugc2hv
dWxkIG5vdCBzZW5kIG1lc3NhZ2VzIHRvIHVzZXJzcGFjZSBpbiB0aGUgRkVBVFVSRVNfT0sgY2Fz
ZS4gU28KPiB0aGUgc3luY2hyb25pemF0aW9uIGlzIG5vdCBuZWNlc3NhcnkuCgoKQXMgZGlzY3Vz
c2VkIHByZXZpb3VzbHksIHRoZXJlIGNvdWxkIGJlIGEgZGV2aWNlIHRoYXQgbWFuZGF0ZXMgc29t
ZSAKZmVhdHVyZXMgKFZJUlRJT19GX1JJTkdfUEFDS0VEKS4gU28gaXQgY2FuIGNob29zZSB0byBu
b3QgYWNjZXB0IApGRUFUVVJFU19PSyBpcyBwYWNrZWQgdmlydHF1ZXVlIGlzIG5vdCBuZWdvdGlh
dGVkLgoKSW4gdGhpcyBjYXNlIHdlIG5lZWQgdG8gcmVsYXkgdGhlIG1lc3NhZ2UgdG8gdXNlcnNw
YWNlLgoKVGhhbmtzCgoKPgo+IFRoYW5rcywKPiBZb25namkKPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
