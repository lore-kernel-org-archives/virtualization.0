Return-Path: <SRS0=vMKq=G7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967B4C433DB
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 04:52:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9274B60235
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 04:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9274B60235
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E65B7204D9;
	Thu, 28 Jan 2021 04:52:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kMvtEe1G85w1; Thu, 28 Jan 2021 04:52:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6580F20458;
	Thu, 28 Jan 2021 04:52:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46BD1C08A1;
	Thu, 28 Jan 2021 04:52:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A5F8C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 04:52:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2CC1486448
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 04:52:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5ZtZpSc_PiXR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 04:52:52 +0000 (UTC)
X-Greylist: delayed 01:44:28 by SQLgrey-1.7.6
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E240B86442
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 04:52:52 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id g15so3557234pjd.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 20:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OCdNhPJmC7cEUrAyAfKOn/wAW4PdZZrXFG/4tQQjPQ4=;
 b=P0Pd/oygpSt0zWxZCgkQGjNJxdKVF4iYlO0Ejjn+1jmy7UK7n1XhmLRo8SRQzQY45P
 AXa+UvkRIah/fiznL3X4ctGvEcvS/5o0+wc/chu8WnLomKzr5wGQJz2ZxQt1eTD43xIH
 Q/0VFiFYAtcUzAV6YRnyip21HoWMGsvQiOMLUqT4xpcKGkarV3NJIi+cyLjMi90mrTjR
 ylpt5eE54Brihm2k9p1yMc/5/DJtS8nJlxO0dkdLDk5fVy0o+gSehIjHTN6uoyk5TPII
 Dyy5AtOC0KNkkLxJCpyLZ6HHd5LUVAmqQ8cAbS/kgiD41mPUSk/I2OlNu2TWP48/AxpU
 fFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OCdNhPJmC7cEUrAyAfKOn/wAW4PdZZrXFG/4tQQjPQ4=;
 b=J6DfPJ7kNYEeUhUbzqhO81qhfC/7Le6TAxa1yQ59k5VyRo7FIpclrrwv8tPNCJSESW
 YWMvhmWJTYQPq7HDMrLkKuQnn1ZqzKOLMZDayf7m0jtIrhhD7qR5ecII/RUPZrVZt47q
 ZCG4jQar/uAVFSMQRZXJyCLY+Zlclf1Hrs/0g2N4bWLKTi1royugcunTGd6XqyypMln4
 Ag+rVt1lfLeFr7Xxt1SpUY3UKdpLM+kTpbxZ/PuIS2nb2DDOHBIh/avOwYLVbLByW8j8
 vns4ddOuxkOEaHrS58XeZBmE5gFc5nLphlR+Ve+rAFaPAoT5Aq5Bp6CN1ZbzlDz5gerV
 46CA==
X-Gm-Message-State: AOAM531luJVbEvRp/gCZEb3YsYXSlpI5pVKTRQr8PwOe4BZJw413kC+F
 P64H4KYZCWyD0GORPXO8t6lBUoYgc61nRw==
X-Google-Smtp-Source: ABdhPJxKR7pCfxkcWkrPDHtoewg+dp+t9SIM2saaxXm86W9VBkJRdcBlBOukcAb5b9tgGsj7UoeFZA==
X-Received: by 2002:a17:902:59c1:b029:df:fd49:f08d with SMTP id
 d1-20020a17090259c1b02900dffd49f08dmr14313148plj.76.1611803302240; 
 Wed, 27 Jan 2021 19:08:22 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 b26sm3821272pfo.202.2021.01.27.19.08.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Jan 2021 19:08:21 -0800 (PST)
Subject: Re: [RFC v3 01/11] eventfd: track eventfd_signal() recursion depth
 separately in different cases
To: Jason Wang <jasowang@redhat.com>, Yongji Xie <xieyongji@bytedance.com>
References: <20210119045920.447-1-xieyongji@bytedance.com>
 <20210119045920.447-2-xieyongji@bytedance.com>
 <e8a2cc15-80f5-01e0-75ec-ea6281fda0eb@redhat.com>
 <CACycT3sN0+dg-NubAK+N-DWf3UDXwWh=RyRX-qC9fwdg3QaLWA@mail.gmail.com>
 <6a5f0186-c2e3-4603-9826-50d5c68a3fda@redhat.com>
 <CACycT3sqDgccOfNcY_FNcHDqJ2DeMbigdFuHYm9DxWWMjkL7CQ@mail.gmail.com>
 <b5c9f2d4-5b95-4552-3886-f5cbcb7de232@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4e482f00-163a-f957-4665-141502cf4dff@kernel.dk>
Date: Wed, 27 Jan 2021 20:08:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b5c9f2d4-5b95-4552-3886-f5cbcb7de232@redhat.com>
Content-Language: en-US
Cc: Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-aio@kvack.org,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Bob Liu <bob.liu@oracle.com>,
 bcrl@kvack.org, viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org
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

T24gMS8yNy8yMSA4OjA0IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+IAo+IE9uIDIwMjEvMS8yNyDk
uIvljYg1OjExLCBZb25namkgWGllIHdyb3RlOgo+PiBPbiBXZWQsIEphbiAyNywgMjAyMSBhdCAx
MTozOCBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Cj4+PiBP
biAyMDIxLzEvMjAg5LiL5Y2IMjo1MiwgWW9uZ2ppIFhpZSB3cm90ZToKPj4+PiBPbiBXZWQsIEph
biAyMCwgMjAyMSBhdCAxMjoyNCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPj4+Pj4gT24gMjAyMS8xLzE5IOS4i+WNiDEyOjU5LCBYaWUgWW9uZ2ppIHdyb3RlOgo+
Pj4+Pj4gTm93IHdlIGhhdmUgYSBnbG9iYWwgcGVyY3B1IGNvdW50ZXIgdG8gbGltaXQgdGhlIHJl
Y3Vyc2lvbiBkZXB0aAo+Pj4+Pj4gb2YgZXZlbnRmZF9zaWduYWwoKS4gVGhpcyBjYW4gYXZvaWQg
ZGVhZGxvY2sgb3Igc3RhY2sgb3ZlcmZsb3cuCj4+Pj4+PiBCdXQgaW4gc3RhY2sgb3ZlcmZsb3cg
Y2FzZSwgaXQgc2hvdWxkIGJlIE9LIHRvIGluY3JlYXNlIHRoZQo+Pj4+Pj4gcmVjdXJzaW9uIGRl
cHRoIGlmIG5lZWRlZC4gU28gd2UgYWRkIGEgcGVyY3B1IGNvdW50ZXIgaW4gZXZlbnRmZF9jdHgK
Pj4+Pj4+IHRvIGxpbWl0IHRoZSByZWN1cnNpb24gZGVwdGggZm9yIGRlYWRsb2NrIGNhc2UuIFRo
ZW4gaXQgY291bGQgYmUKPj4+Pj4+IGZpbmUgdG8gaW5jcmVhc2UgdGhlIGdsb2JhbCBwZXJjcHUg
Y291bnRlciBsYXRlci4KPj4+Pj4gSSB3b25kZXIgd2hldGhlciBvciBub3QgaXQncyB3b3J0aCB0
byBpbnRyb2R1Y2UgcGVyY3B1IGZvciBlYWNoIGV2ZW50ZmQuCj4+Pj4+Cj4+Pj4+IEhvdyBhYm91
dCBzaW1wbHkgY2hlY2sgaWYgZXZlbnRmZF9zaWduYWxfY291bnQoKSBpcyBncmVhdGVyIHRoYW4g
Mj8KPj4+Pj4KPj4+PiBJdCBjYW4ndCBhdm9pZCBkZWFkbG9jayBpbiB0aGlzIHdheS4KPj4+Cj4+
PiBJIG1heSBtaXNzIHNvbWV0aGluZyBidXQgdGhlIGNvdW50IGlzIHRvIGF2b2lkIHJlY3Vyc2l2
ZSBldmVudGZkIGNhbGwuCj4+PiBTbyBmb3IgVkRVU0Ugd2hhdCB3ZSBzdWZmZXJzIGlzIGUuZyB0
aGUgaW50ZXJydXB0IGluamVjdGlvbiBwYXRoOgo+Pj4KPj4+IHVzZXJzcGFjZSB3cml0ZSBJUlFG
RCAtPiB2cS0+Y2IoKSAtPiBhbm90aGVyIElSUUZELgo+Pj4KPj4+IEl0IGxvb2tzIGxpa2UgaW5j
cmVhc2luZyBFVkVOVEZEX1dBS0VVUF9ERVBUSCBzaG91bGQgYmUgc3VmZmljaWVudD8KPj4+Cj4+
IEFjdHVhbGx5IEkgbWVhbiB0aGUgZGVhZGxvY2sgZGVzY3JpYmVkIGluIGNvbW1pdCBmMGI0OTNl
ICgiaW9fdXJpbmc6Cj4+IHByZXZlbnQgcG90ZW50aWFsIGV2ZW50ZmQgcmVjdXJzaW9uIG9uIHBv
bGwiKS4gSXQgY2FuIGJyZWFrIHRoaXMgYnVnCj4+IGZpeCBpZiB3ZSBqdXN0IGluY3JlYXNlIEVW
RU5URkRfV0FLRVVQX0RFUFRILgo+IAo+IAo+IE9rLCBzbyBjYW4gd2FpdCBkbyBzb21ldGhpbmcg
c2ltaWxhciBpbiB0aGF0IGNvbW1pdD8gKHVzaW5nIGFzeW5jIHN0dWZmcyAKPiBsaWtlIHdxKS4K
CmlvX3VyaW5nIHNob3VsZCBiZSBmaW5lIGluIGN1cnJlbnQga2VybmVscywgYnV0IGFpbyB3b3Vs
ZCBzdGlsbCBiZQphZmZlY3RlZCBieSB0aGlzLiBCdXQganVzdCBpbiB0ZXJtcyBvZiByZWN1cnNp
b24sIGJ1bXBpbmcgaXQgb25lIG1vcmUKc2hvdWxkIHByb2JhYmx5IHN0aWxsIGJlIGZpbmUuCgot
LSAKSmVucyBBeGJvZQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
