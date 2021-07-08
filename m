Return-Path: <SRS0=uZMz=MA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F17C07E9E
	for <virtualization@archiver.kernel.org>; Thu,  8 Jul 2021 04:18:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00CD861CE2
	for <virtualization@archiver.kernel.org>; Thu,  8 Jul 2021 04:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CD861CE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7DD983163;
	Thu,  8 Jul 2021 04:18:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A9MjVyZLTP5z; Thu,  8 Jul 2021 04:18:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 24F9782BED;
	Thu,  8 Jul 2021 04:18:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98908C0020;
	Thu,  8 Jul 2021 04:18:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3032C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 04:18:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EDD0540687
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 04:18:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cN2G-EkmlKag
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 04:18:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3FC3240678
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 04:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625717890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DNu1zHrcXhgpVSSnQcgsiGwDGO6YEQsjo75QjE9guwc=;
 b=fYyH6w/eIBwqjX1SKGqb/LccQle0nQ76DZy2PYdekPwT38XXK39moNSFiBrVBOOVbE+J+H
 K83AH5gqsHE2DqTPPtw/Xv8Qi0PZnp/1dZ5SgzdL4KL/grJPW5z8BaKU77FAKrLPozCPUy
 hsfK+R5SflQNIJuUo+/QNpozqj9h2sg=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-fZC_2hXQNLS0msfkbuJF5Q-1; Thu, 08 Jul 2021 00:18:09 -0400
X-MC-Unique: fZC_2hXQNLS0msfkbuJF5Q-1
Received: by mail-pg1-f197.google.com with SMTP id
 29-20020a63105d0000b029022c245c3492so2320435pgq.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Jul 2021 21:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=DNu1zHrcXhgpVSSnQcgsiGwDGO6YEQsjo75QjE9guwc=;
 b=mCU9+XEbN79eRIZ6tLeL6tl+SKwRS19LZKMdNq1l+ggyPZM5ropWywX9naf5tZgu8W
 9ytPOYXFN9J4Mb+dUNkSjjqsQ7ijJxwganPa1dl+VxOr6zBKxbDLQR9ztZO3CWbyljSv
 TG0z+To9Nov9MLOviHFcS/adywc+CbrwUW367LM/6G1J7DQ2+wVQFlHE8wwLqxOoIyTu
 +dIY9rh/W61CBWjFpiCksNd00d0srWvWDkYlOej4aNnbFploSLaThImbq78F8A0aBQWi
 fdQuNOKrjt84r09HGUK7pFqFHoYCZ285yB+zP1Xz61SkwQDGmDvYhxXIyVfkYVjK5Ma1
 WpQQ==
X-Gm-Message-State: AOAM532fyfCcbX655mlCl1lMVKX1hHgxw1TRmoAJx1Y6DJc/5rjzj6bR
 skB0dj4Xjg63/+INvvHLTttN6t9jlHzwG6f5YcuVWKxcRV9qEIST2zfYyLBddF5i2wQ1N8DE9hf
 8DcAyMX8R3rtoAKnkp7ae8pJVPNydaj1e8OhyEfiKuQ==
X-Received: by 2002:a17:902:aa86:b029:116:3e3a:2051 with SMTP id
 d6-20020a170902aa86b02901163e3a2051mr24239022plr.38.1625717888673; 
 Wed, 07 Jul 2021 21:18:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgPpvaVl8Rg4KqU5dAGuQXgjQhnKK5qnVXzUgmrqEO0suxCn8aS1zG54MnxoNvIGvMzyvnlw==
X-Received: by 2002:a17:902:aa86:b029:116:3e3a:2051 with SMTP id
 d6-20020a170902aa86b02901163e3a2051mr24238978plr.38.1625717888336; 
 Wed, 07 Jul 2021 21:18:08 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c64sm792630pfb.166.2021.07.07.21.18.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jul 2021 21:18:07 -0700 (PDT)
Subject: Re: [PATCH v8 10/10] Documentation: Add documentation for VDUSE
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <CACycT3vo-diHgTSLw_FS2E+5ia5VjihE3qw7JmZR7JT55P-wQA@mail.gmail.com>
 <8320d26d-6637-85c6-8773-49553dfa502d@redhat.com>
 <YOL/9mxkJaokKDHc@stefanha-x1.localdomain>
 <5b5107fa-3b32-8a3b-720d-eee6b2a84ace@redhat.com>
 <YOQtG3gDOhHDO5CQ@stefanha-x1.localdomain>
 <CACGkMEs2HHbUfarum8uQ6wuXoDwLQUSXTsa-huJFiqr__4cwRg@mail.gmail.com>
 <YOSOsrQWySr0andk@stefanha-x1.localdomain>
 <100e6788-7fdf-1505-d69c-bc28a8bc7a78@redhat.com>
 <YOVr801d01YOPzLL@stefanha-x1.localdomain>
 <a03c8627-7dac-2255-a2d9-603fc623b618@redhat.com>
 <YOXOMiPl7mKd7FoM@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d5aef112-0828-6b79-4bce-753d3cd496c1@redhat.com>
Date: Thu, 8 Jul 2021 12:17:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOXOMiPl7mKd7FoM@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, joro@8bytes.org,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Xie Yongji <xieyongji@bytedance.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
 Jens Axboe <axboe@kernel.dk>, gregkh@linuxfoundation.org,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "bcrl@kvack.org" <bcrl@kvack.org>, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
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

CuWcqCAyMDIxLzcvNyDkuIvljYgxMTo1NCwgU3RlZmFuIEhham5vY3ppIOWGmemBkzoKPiBPbiBX
ZWQsIEp1bCAwNywgMjAyMSBhdCAwNToyNDowOFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
PiDlnKggMjAyMS83Lzcg5LiL5Y2INDo1NSwgU3RlZmFuIEhham5vY3ppIOWGmemBkzoKPj4+IE9u
IFdlZCwgSnVsIDA3LCAyMDIxIGF0IDExOjQzOjI4QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+Pj4g5ZyoIDIwMjEvNy83IOS4iuWNiDE6MTEsIFN0ZWZhbiBIYWpub2N6aSDlhpnpgZM6Cj4+
Pj4+IE9uIFR1ZSwgSnVsIDA2LCAyMDIxIGF0IDA5OjA4OjI2UE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4+Pj4+PiBPbiBUdWUsIEp1bCA2LCAyMDIxIGF0IDY6MTUgUE0gU3RlZmFuIEhham5v
Y3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+PiBPbiBUdWUsIEp1bCAwNiwg
MjAyMSBhdCAxMDozNDozM0FNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4+PiDlnKgg
MjAyMS83LzUg5LiL5Y2IODo0OSwgU3RlZmFuIEhham5vY3ppIOWGmemBkzoKPj4+Pj4+Pj4+IE9u
IE1vbiwgSnVsIDA1LCAyMDIxIGF0IDExOjM2OjE1QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+Pj4+Pj4+Pj4g5ZyoIDIwMjEvNy80IOS4i+WNiDU6NDksIFlvbmdqaSBYaWUg5YaZ6YGTOgo+
Pj4+Pj4+Pj4+Pj4+IE9LLCBJIGdldCB5b3Ugbm93LiBTaW5jZSB0aGUgVklSVElPIHNwZWNpZmlj
YXRpb24gc2F5cyAiRGV2aWNlCj4+Pj4+Pj4+Pj4+Pj4gY29uZmlndXJhdGlvbiBzcGFjZSBpcyBn
ZW5lcmFsbHkgdXNlZCBmb3IgcmFyZWx5LWNoYW5naW5nIG9yCj4+Pj4+Pj4+Pj4+Pj4gaW5pdGlh
bGl6YXRpb24tdGltZSBwYXJhbWV0ZXJzIi4gSSBhc3N1bWUgdGhlIFZEVVNFX0RFVl9TRVRfQ09O
RklHCj4+Pj4+Pj4+Pj4+Pj4gaW9jdGwgc2hvdWxkIG5vdCBiZSBjYWxsZWQgZnJlcXVlbnRseS4K
Pj4+Pj4+Pj4+Pj4+IFRoZSBzcGVjIHVzZXMgTVVTVCBhbmQgb3RoZXIgdGVybXMgdG8gZGVmaW5l
IHRoZSBwcmVjaXNlIHJlcXVpcmVtZW50cy4KPj4+Pj4+Pj4+Pj4+IEhlcmUgdGhlIGxhbmd1YWdl
IChlc3BlY2lhbGx5IHRoZSB3b3JkICJnZW5lcmFsbHkiKSBpcyB3ZWFrZXIgYW5kIG1lYW5zCj4+
Pj4+Pj4+Pj4+PiB0aGVyZSBtYXkgYmUgZXhjZXB0aW9ucy4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4+PiBBbm90aGVyIHR5cGUgb2YgYWNjZXNzIHRoYXQgZG9lc24ndCB3b3JrIHdpdGggdGhlIFZE
VVNFX0RFVl9TRVRfQ09ORklHCj4+Pj4+Pj4+Pj4+PiBhcHByb2FjaCBpcyByZWFkcyB0aGF0IGhh
dmUgc2lkZS1lZmZlY3RzLiBGb3IgZXhhbXBsZSwgaW1hZ2luZSBhIGZpZWxkCj4+Pj4+Pj4+Pj4+
PiBjb250YWluaW5nIGFuIGVycm9yIGNvZGUgaWYgdGhlIGRldmljZSBlbmNvdW50ZXJzIGEgcHJv
YmxlbSB1bnJlbGF0ZWQgdG8KPj4+Pj4+Pj4+Pj4+IGEgc3BlY2lmaWMgdmlydHF1ZXVlIHJlcXVl
c3QuIFJlYWRpbmcgZnJvbSB0aGlzIGZpZWxkIHJlc2V0cyB0aGUgZXJyb3IKPj4+Pj4+Pj4+Pj4+
IGNvZGUgdG8gMCwgc2F2aW5nIHRoZSBkcml2ZXIgYW4gZXh0cmEgY29uZmlndXJhdGlvbiBzcGFj
ZSB3cml0ZSBhY2Nlc3MKPj4+Pj4+Pj4+Pj4+IGFuZCBwb3NzaWJseSByYWNlIGNvbmRpdGlvbnMu
IEl0IGlzbid0IHBvc3NpYmxlIHRvIGltcGxlbWVudCB0aG9zZQo+Pj4+Pj4+Pj4+Pj4gc2VtYW50
aWNzIHN1aW5nIFZEVVNFX0RFVl9TRVRfQ09ORklHLiBJdCdzIGFub3RoZXIgY29ybmVyIGNhc2Us
IGJ1dCBpdAo+Pj4+Pj4+Pj4+Pj4gbWFrZXMgbWUgdGhpbmsgdGhhdCB0aGUgaW50ZXJmYWNlIGRv
ZXMgbm90IGFsbG93IGZ1bGwgVklSVElPIHNlbWFudGljcy4KPj4+Pj4+Pj4+PiBOb3RlIHRoYXQg
dGhvdWdoIHlvdSdyZSBjb3JyZWN0LCBteSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgY29uZmlnIHNw
YWNlIGlzCj4+Pj4+Pj4+Pj4gbm90IHN1aXRhYmxlIGZvciB0aGlzIGtpbmQgb2YgZXJyb3IgcHJv
cGFnYXRpbmcuIEFuZCBpdCB3b3VsZCBiZSB2ZXJ5IGhhcmQKPj4+Pj4+Pj4+PiB0byBpbXBsZW1l
bnQgc3VjaCBraW5kIG9mIHNlbWFudGljIGluIHNvbWUgdHJhbnNwb3J0cy4gIFZpcnRxdWV1ZSBz
aG91bGQgYmUKPj4+Pj4+Pj4+PiBtdWNoIGJldHRlci4gQXMgWW9uZyBKaSBxdW90ZWQsIHRoZSBj
b25maWcgc3BhY2UgaXMgdXNlZCBmb3IKPj4+Pj4+Pj4+PiAicmFyZWx5LWNoYW5naW5nIG9yIGlu
dGlhbGl6YXRpb24tdGltZSBwYXJhbWV0ZXJzIi4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+IEFncmVlZC4gSSB3aWxsIHVzZSBWRFVTRV9ERVZfR0VUX0NPTkZJRyBpbiB0aGUgbmV4
dCB2ZXJzaW9uLiBBbmQgdG8KPj4+Pj4+Pj4+Pj4gaGFuZGxlIHRoZSBtZXNzYWdlIGZhaWx1cmUs
IEknbSBnb2luZyB0byBhZGQgYSByZXR1cm4gdmFsdWUgdG8KPj4+Pj4+Pj4+Pj4gdmlydGlvX2Nv
bmZpZ19vcHMuZ2V0KCkgYW5kIHZpcnRpb19jcmVhZF8qIEFQSSBzbyB0aGF0IHRoZSBlcnJvciBj
YW4KPj4+Pj4+Pj4+Pj4gYmUgcHJvcGFnYXRlZCB0byB0aGUgdmlydGlvIGRldmljZSBkcml2ZXIu
IFRoZW4gdGhlIHZpcnRpby1ibGsgZGV2aWNlCj4+Pj4+Pj4+Pj4+IGRyaXZlciBjYW4gYmUgbW9k
aWZpZWQgdG8gaGFuZGxlIHRoYXQuCj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+IEphc29uIGFuZCBT
dGVmYW4sIHdoYXQgZG8geW91IHRoaW5rIG9mIHRoaXMgd2F5Pwo+Pj4+Pj4+Pj4gV2h5IGRvZXMg
VkRVU0VfREVWX0dFVF9DT05GSUcgbmVlZCB0byBzdXBwb3J0IGFuIGVycm9yIHJldHVybiB2YWx1
ZT8KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBUaGUgVklSVElPIHNwZWMgcHJvdmlkZXMgbm8gd2F5IGZv
ciB0aGUgZGV2aWNlIHRvIHJlcG9ydCBlcnJvcnMgZnJvbQo+Pj4+Pj4+Pj4gY29uZmlnIHNwYWNl
IGFjY2Vzc2VzLgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IFRoZSBRRU1VIHZpcnRpby1wY2kgaW1wbGVt
ZW50YXRpb24gcmV0dXJucyAtMSBmcm9tIGludmFsaWQKPj4+Pj4+Pj4+IHZpcnRpb19jb25maWdf
cmVhZCooKSBhbmQgc2lsZW50bHkgZGlzY2FyZHMgdmlydGlvX2NvbmZpZ193cml0ZSooKQo+Pj4+
Pj4+Pj4gYWNjZXNzZXMuCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gVkRVU0UgY2FuIHRha2UgdGhlIHNh
bWUgYXBwcm9hY2ggd2l0aAo+Pj4+Pj4+Pj4gVkRVU0VfREVWX0dFVF9DT05GSUcvVkRVU0VfREVW
X1NFVF9DT05GSUcuCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IEknZCBsaWtlIHRvIHN0aWNrIHRvIHRo
ZSBjdXJyZW50IGFzc3VtcHRpb24gdGhpY2ggZ2V0X2NvbmZpZyB3b24ndCBmYWlsLgo+Pj4+Pj4+
Pj4+IFRoYXQgaXMgdG8gc2F5LAo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gMSkgbWFpbnRhaW4gYSBj
b25maWcgaW4gdGhlIGtlcm5lbCwgbWFrZSBzdXJlIHRoZSBjb25maWcgc3BhY2UgcmVhZCBjYW4K
Pj4+Pj4+Pj4+PiBhbHdheXMgc3VjY2VlZAo+Pj4+Pj4+Pj4+IDIpIGludHJvZHVjZSBhbiBpb2N0
bCBmb3IgdGhlIHZkdXNlIHVzZXJzYXBjZSB0byB1cGRhdGUgdGhlIGNvbmZpZyBzcGFjZS4KPj4+
Pj4+Pj4+PiAzKSB3ZSBjYW4gc3luY2hyb25pemUgd2l0aCB0aGUgdmR1c2UgdXNlcnNwYWNlIGR1
cmluZyBzZXRfY29uZmlnCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBEb2VzIHRoaXMgd29yaz8KPj4+
Pj4+Pj4+IEkgbm90aWNlZCB0aGF0IGNhY2hpbmcgaXMgYWxzbyBhbGxvd2VkIGJ5IHRoZSB2aG9z
dC11c2VyIHByb3RvY29sCj4+Pj4+Pj4+PiBtZXNzYWdlcyAoUUVNVSdzIGRvY3MvaW50ZXJvcC92
aG9zdC11c2VyLnJzdCksIGJ1dCB0aGUgZGV2aWNlIGRvZXNuJ3QKPj4+Pj4+Pj4+IGtub3cgd2hl
dGhlciBvciBub3QgY2FjaGluZyBpcyBpbiBlZmZlY3QuIFRoZSBpbnRlcmZhY2UgeW91IG91dGxp
bmVkCj4+Pj4+Pj4+PiBhYm92ZSByZXF1aXJlcyBjYWNoaW5nLgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
IElzIHRoZXJlIGEgcmVhc29uIHdoeSB0aGUgaG9zdCBrZXJuZWwgdkRQQSBjb2RlIG5lZWRzIHRv
IGNhY2hlIHRoZQo+Pj4+Pj4+Pj4gY29uZmlndXJhdGlvbiBzcGFjZT8KPj4+Pj4+Pj4gQmVjYXVz
ZToKPj4+Pj4+Pj4KPj4+Pj4+Pj4gMSkgS2VybmVsIGNhbiBub3Qgd2FpdCBmb3JldmVyIGluIGdl
dF9jb25maWcoKSwgdGhpcyBpcyB0aGUgbWFqb3IgZGlmZmVyZW5jZQo+Pj4+Pj4+PiB3aXRoIHZo
b3N0LXVzZXIuCj4+Pj4+Pj4gdmlydGlvX2NyZWFkKCkgY2FuIHNsZWVwOgo+Pj4+Pj4+Cj4+Pj4+
Pj4gICAgICAjZGVmaW5lIHZpcnRpb19jcmVhZCh2ZGV2LCBzdHJ1Y3RuYW1lLCBtZW1iZXIsIHB0
cikgICAgICAgICAgICAgICAgICAgICBcCj4+Pj4+Pj4gICAgICAgICAgICAgIGRvIHsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCj4+
Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgdHlwZW9mKCgoc3RydWN0bmFtZSopMCktPm1lbWJl
cikgdmlydGlvX2NyZWFkX3Y7ICAgICAgICBcCj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
Cj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgbWlnaHRfc2xlZXAoKTsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAg
ICAgXl5eXl5eXl5eXl5eXl4KPj4+Pj4+Pgo+Pj4+Pj4+IFdoaWNoIGNvZGUgcGF0aCBjYW5ub3Qg
c2xlZXA/Cj4+Pj4+PiBXZWxsLCBpdCBjYW4gc2xlZXAgYnV0IGl0IGNhbid0IHNsZWVwIGZvcmV2
ZXIuIEZvciBWRFVTRSwgYQo+Pj4+Pj4gYnVnZ3kvbWFsaWNpb3VzIHVzZXJzcGFjZSBtYXkgcmVm
dXNlIHRvIHJlc3BvbmQgdG8gdGhlIGdldF9jb25maWcuCj4+Pj4+Pgo+Pj4+Pj4gSXQgbG9va3Mg
dG8gbWUgdGhlIGlkZWFsIGNhc2UsIHdpdGggdGhlIGN1cnJlbnQgdmlydGlvIHNwZWMsIGZvciBW
RFVTRSBpcyB0bwo+Pj4+Pj4KPj4+Pj4+IDEpIG1haW50YWluIHRoZSBkZXZpY2UgYW5kIGl0cyBz
dGF0ZSBpbiB0aGUga2VybmVsLCB1c2Vyc3BhY2UgbWF5IHN5bmMKPj4+Pj4+IHdpdGggdGhlIGtl
cm5lbCBkZXZpY2UgdmlhIGlvY3Rscwo+Pj4+Pj4gMikgb2ZmbG9hZCB0aGUgZGF0YXBhdGggKHZp
cnRxdWV1ZSkgdG8gdGhlIHVzZXJzcGFjZQo+Pj4+Pj4KPj4+Pj4+IFRoaXMgc2VlbXMgbW9yZSBy
b2J1c3QgYW5kIHNhZmUgdGhhbiBzaW1wbHkgcmVsYXlpbmcgZXZlcnl0aGluZyB0bwo+Pj4+Pj4g
dXNlcnNwYWNlIGFuZCB3YWl0aW5nIGZvciBpdHMgcmVzcG9uc2UuCj4+Pj4+Pgo+Pj4+Pj4gQW5k
IHdlIGtub3cgZm9yIHN1cmUgdGhpcyBtb2RlbCBjYW4gd29yaywgYW4gZXhhbXBsZSBpcyBUVU4v
VEFQOgo+Pj4+Pj4gbmV0ZGV2aWNlIGlzIGFic3RyYWN0ZWQgaW4gdGhlIGtlcm5lbCBhbmQgZGF0
YXBhdGggaXMgZG9uZSB2aWEKPj4+Pj4+IHNlbmRtc2coKS9yZWN2bXNnKCkuCj4+Pj4+Pgo+Pj4+
Pj4gTWFpbnRhaW5pbmcgdGhlIGNvbmZpZyBpbiB0aGUga2VybmVsIGZvbGxvd3MgdGhpcyBtb2Rl
bCBhbmQgaXQgY2FuCj4+Pj4+PiBzaW1wbGlmeSB0aGUgZGV2aWNlIGdlbmVyYXRpb24gaW1wbGVt
ZW50YXRpb24uCj4+Pj4+Pgo+Pj4+Pj4gRm9yIGNvbmZpZyBzcGFjZSB3cml0ZSwgaXQgcmVxdWly
ZXMgbW9yZSB0aG91Z2h0IGJ1dCBmb3J0dW5hdGVseSBpdCdzCj4+Pj4+PiBub3QgY29tbW9ubHkg
dXNlZC4gU28gVkRVU0UgY2FuIGNob29zZSB0byBmaWx0ZXIgb3V0IHRoZQo+Pj4+Pj4gZGV2aWNl
L2ZlYXR1cmVzIHRoYXQgZGVwZW5kcyBvbiB0aGUgY29uZmlnIHdyaXRlLgo+Pj4+PiBUaGlzIGlz
IHRoZSBwcm9ibGVtLiBUaGVyZSBhcmUgb3RoZXIgbWVzc2FnZXMgbGlrZSBTRVRfRkVBVFVSRVMg
d2hlcmUgSQo+Pj4+PiBndWVzcyB3ZSdsbCBmYWNlIHRoZSBzYW1lIGNoYWxsZW5nZS4KPj4+PiBQ
cm9iYWJseSBub3QsIHVzZXJzcGFjZSBkZXZpY2UgY2FuIHRlbGwgdGhlIGtlcm5lbCBhYm91dCB0
aGUgZGV2aWNlX2ZlYXR1cmVzCj4+Pj4gYW5kIG1hbmRhdGVkX2ZlYXR1cmVzIGR1cmluZyBjcmVh
dGlvbiwgYW5kIHRoZSBmZWF0dXJlIG5lZ290aWF0aW9uIGNvdWxkIGJlCj4+Pj4gZG9uZSBwdXJl
bHkgaW4gdGhlIGtlcm5lbCB3aXRob3V0IGJvdGhlcmluZyB0aGUgdXNlcnNwYWNlLgo+Pgo+PiAo
Rm9yIHNvbWUgcmVhc29uIEkgZHJvcCB0aGUgbGlzdCBhY2NpZGVudGFsbHksIGFkZGluZyB0aGVt
IGJhY2ssIHNvcnJ5KQo+Pgo+Pgo+Pj4gU29ycnksIEkgY29uZnVzZWQgdGhlIG1lc3NhZ2VzLiBJ
IG1lYW50IFNFVF9TVEFUVVMuIEl0J3MgYSBzeW5jaHJvbm91cwo+Pj4gaW50ZXJmYWNlIHdoZXJl
IHRoZSBkcml2ZXIgd2FpdHMgZm9yIHRoZSBkZXZpY2UuCj4+Cj4+IEl0IGRlcGVuZHMgb24gaG93
IHdlIGRlZmluZSAic3luY2hyb25vdXMiIGhlcmUuIElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHks
Cj4+IHRoZSBzcGVjIGRvZXNuJ3QgZXhwZWN0IHRoZXJlIHdpbGwgYmUgYW55IGtpbmQgb2YgZmFp
bHVyZSBmb3IgdGhlIG9wZXJhdGlvbgo+PiBvZiBzZXRfc3RhdHVzIGl0c2VsZi4KPj4KPj4gSW5z
dGVhZCwgYW55dGltZSBpdCB3YW50IGFueSBzeW5jaHJvbml6YXRpb24sIGl0IHNob3VsZCBiZSBk
b25lIHZpYQo+PiBnZXRfc3RhdHVzKCk6Cj4+Cj4+IDEpIHJlLXJlYWQgZGV2aWNlIHN0YXR1cyB0
byBtYWtlIHN1cmUgRkVBVFVSRVNfT0sgaXMgc2V0IGR1cmluZyBmZWF0dXJlCj4+IG5lZ290aWF0
aW9uCj4+IDIpIHJlLXJlYWQgZGV2aWNlIHN0YXR1cyB0byBiZSAwIHRvIG1ha2Ugc3VyZSB0aGUg
ZGV2aWNlIGhhcyBmaW5pc2ggdGhlCj4+IHJlc2V0Cj4+Cj4+Cj4+PiBWRFVTRSBjdXJyZW50bHkg
ZG9lc24ndCB3YWl0IGZvciB0aGUgZGV2aWNlIGVtdWxhdGlvbiBwcm9jZXNzIHRvIGhhbmRsZQo+
Pj4gdGhpcyBtZXNzYWdlIChubyByZXBseSBpcyBuZWVkZWQpIGJ1dCBJIHRoaW5rIHRoaXMgaXMg
YSBtaXN0YWtlIGJlY2F1c2UKPj4+IFZEVVNFIGlzIG5vdCBmb2xsb3dpbmcgdGhlIFZJUlRJTyBk
ZXZpY2UgbW9kZWwuCj4+Cj4+IFdpdGggdGhlIHRyaWNrIHRoYXQgaXMgZG9uZSBmb3IgRkVBVFVS
RVNfT0sgYWJvdmUsIEkgdGhpbmsgd2UgZG9uJ3QgbmVlZCB0bwo+PiB3YWl0IGZvciB0aGUgcmVw
bHkuCj4+Cj4+IElmIHVzZXJzcGFjZSB0YWtlcyB0b28gbG9uZyB0byByZXNwb25kLCBpdCBjYW4g
YmUgZGV0ZWN0ZWQgc2luY2UKPj4gZ2V0X3N0YXR1cygpIGRvZXNuJ3QgcmV0dXJuIHRoZSBleHBl
Y3RlZCB2YWx1ZSBmb3IgbG9uZyB0aW1lLgo+Pgo+PiBBbmQgZm9yIHRoZSBjYXNlIHRoYXQgbmVl
ZHMgYSB0aW1lb3V0LCB3ZSBwcm9iYWJseSBjYW4gdXNlIE5FRURTX1JFU0VULgo+IEkgdGhpbmsg
eW91J3JlIHJpZ2h0LiBnZXRfc3RhdHVzIGlzIHRoZSBzeW5jaHJvbml6YXRpb24gcG9pbnQsIG5v
dAo+IHNldF9zdGF0dXMuCj4KPiBDdXJyZW50bHkgdGhlcmUgaXMgbm8gVkRVU0UgR0VUX1NUQVRV
UyBtZXNzYWdlLiBUaGUKPiBWRFVTRV9TVEFSVC9TVE9QX0RBVEFQTEFORSBtZXNzYWdlcyBjb3Vs
ZCBiZSBjaGFuZ2VkIHRvIFNFVF9TVEFUVVMgc28KPiB0aGF0IHRoZSBkZXZpY2UgZW11bGF0aW9u
IHByb2dyYW0gY2FuIHBhcnRpY2lwYXRlIGluIGVtdWxhdGluZyB0aGUKPiBEZXZpY2UgU3RhdHVz
IGZpZWxkLgoKCkknbSBub3Qgc3VyZSBJIGdldCB0aGlzLCBidXQgaXQgaXMgd2hhdCBoYXMgYmVl
biBkb25lPwoKK3N0YXRpYyB2b2lkIHZkdXNlX3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3QgdmRwYV9k
ZXZpY2UgKnZkcGEsIHU4IHN0YXR1cykKK3sKK8KgwqDCoCBzdHJ1Y3QgdmR1c2VfZGV2ICpkZXYg
PSB2ZHBhX3RvX3ZkdXNlKHZkcGEpOworwqDCoMKgIGJvb2wgc3RhcnRlZCA9ICEhKHN0YXR1cyAm
IFZJUlRJT19DT05GSUdfU19EUklWRVJfT0spOworCivCoMKgwqAgZGV2LT5zdGF0dXMgPSBzdGF0
dXM7CisKK8KgwqDCoCBpZiAoZGV2LT5zdGFydGVkID09IHN0YXJ0ZWQpCivCoMKgwqAgwqDCoMKg
IHJldHVybjsKKworwqDCoMKgIGRldi0+c3RhcnRlZCA9IHN0YXJ0ZWQ7CivCoMKgwqAgaWYgKGRl
di0+c3RhcnRlZCkgeworwqDCoMKgIMKgwqDCoCB2ZHVzZV9kZXZfc3RhcnRfZGF0YXBsYW5lKGRl
dik7CivCoMKgwqAgfSBlbHNlIHsKK8KgwqDCoCDCoMKgwqAgdmR1c2VfZGV2X3Jlc2V0KGRldik7
CivCoMKgwqAgwqDCoMKgIHZkdXNlX2Rldl9zdG9wX2RhdGFwbGFuZShkZXYpOworwqDCoMKgIH0K
K30KCgpCdXQgdGhlIGxvb2tzIG5vdCBjb3JyZWN0OgoKMSkgIURSSVZFUl9PSyBkb2Vzbid0IG1l
YW5zIGEgcmVzZXQ/CjIpIE5lZWQgdG8gZGVhbCB3aXRoIEZFQVRVUkVTX09LCgpUaGFua3MKCgo+
ICAgVGhpcyBjaGFuZ2UgY291bGQgYWZmZWN0IFZEVVNFJ3MgVklSVElPIGZlYXR1cmUKPiBpbnRl
cmZhY2Ugc2luY2UgdGhlIGRldmljZSBlbXVsYXRpb24gcHJvZ3JhbSBjYW4gcmVqZWN0IGZlYXR1
cmVzIGJ5IG5vdAo+IHNldHRpbmcgRkVBVFVSRVNfT0suCj4KPiBTdGVmYW4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
