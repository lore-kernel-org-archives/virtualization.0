Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B517DC07E9C
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 03:36:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55337610E6
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 03:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55337610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 150B0607E3;
	Mon,  5 Jul 2021 03:36:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JmPXGhRiRekU; Mon,  5 Jul 2021 03:36:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B012F605EB;
	Mon,  5 Jul 2021 03:36:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 793EAC001D;
	Mon,  5 Jul 2021 03:36:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C9A3C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 392CB839DD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:36:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OY890n1atBnV
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:36:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8BD18839DB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625456192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PNRaRFhxCfnbw9LvPZ80acVFOHmYfRIDpgg4dy1jTTw=;
 b=Jm6V8izceJAUQCCstomzgHXd76VIUr8hJ8V8A9P5GwkvSw5mnxQOAVitAVgCBRzuHoeLoS
 YwE3PR8lMYOeShDX84DjYFs0btf7viGpj5dBW1vvszdSMahMnSJpGsxyT6BE1xtM4FWZKP
 e9qvECiIp7L7SEm57MyiE8tkRZVx8Xw=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-XnZdtj9zMpqVD1OYyOFPJQ-1; Sun, 04 Jul 2021 23:36:28 -0400
X-MC-Unique: XnZdtj9zMpqVD1OYyOFPJQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 p42-20020a056a000a2ab02902f33d81f23fso11106755pfh.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Jul 2021 20:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=PNRaRFhxCfnbw9LvPZ80acVFOHmYfRIDpgg4dy1jTTw=;
 b=HlYwBrlvgu3Vay/VOhIC5hOZ2cA4HB42J83Sodzxb2bTiRVgyAjnmto+46Pk0lvlq4
 cSMiczA3koXUyQ7I80RDg8028yVIod8P/R2sO4CQ1dhomVMvhgfAyqjFF/hpWdkgJwD3
 d38KxykIU/sam9ZcXj2LtP19YCKNYMzOUQFwLGR4YuebQtHiyRfTWgZNAamQ87Q+l8QZ
 cPdSth1uFKKlgbFcVaBV1BUO8WPy1Fq+mneRzv9I8gpJ2X6mUUlfdPfWALvVUhvwwoxV
 6AgyOm8Lx5aYPPxFRRggmM2Mp24OC71D0orBXHPU+os7fp+YjYvOBUp9unDPX5WdwUvG
 WjBg==
X-Gm-Message-State: AOAM531ZMCf/5ZCX3ozf2OOUYPmbj2niuZHz0TaA+lkAfWYs8hXVHJZk
 GRx9Z419isH7v3Ycjop6EuWxTK+ZyADShkVxrs5TDB5u1PVLczb+NlX6eydMBmYRukW+V9Y19Ur
 aD3oOLkbnEZfxaYDUFUC1CGYHAtK4C1sJ+oeA6Y6xWQ==
X-Received: by 2002:a62:b502:0:b029:2ec:a539:e29b with SMTP id
 y2-20020a62b5020000b02902eca539e29bmr12907032pfe.37.1625456187864; 
 Sun, 04 Jul 2021 20:36:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxU1ORvJgRFvEdcSUoAIpBbFs4fUYC6vc+xVQFL1exU5Y4g4vdf/8e25LPd+joB4XFQ5Hj+PQ==
X-Received: by 2002:a62:b502:0:b029:2ec:a539:e29b with SMTP id
 y2-20020a62b5020000b02902eca539e29bmr12907014pfe.37.1625456187646; 
 Sun, 04 Jul 2021 20:36:27 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u13sm10509834pfi.54.2021.07.04.20.36.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jul 2021 20:36:27 -0700 (PDT)
Subject: Re: [PATCH v8 10/10] Documentation: Add documentation for VDUSE
To: Yongji Xie <xieyongji@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-11-xieyongji@bytedance.com>
 <YNSCH6l31zwPxBjL@stefanha-x1.localdomain>
 <CACycT3uxnQmXWsgmNVxQtiRhz1UXXTAJFY3OiAJqokbJH6ifMA@mail.gmail.com>
 <YNxCDpM3bO5cPjqi@stefanha-x1.localdomain>
 <CACycT3taKhf1cWp3Jd0aSVekAZvpbR-_fkyPLQ=B+jZBB5H=8Q@mail.gmail.com>
 <YN3ABqCMLQf7ejOm@stefanha-x1.localdomain>
 <CACycT3vo-diHgTSLw_FS2E+5ia5VjihE3qw7JmZR7JT55P-wQA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8320d26d-6637-85c6-8773-49553dfa502d@redhat.com>
Date: Mon, 5 Jul 2021 11:36:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3vo-diHgTSLw_FS2E+5ia5VjihE3qw7JmZR7JT55P-wQA@mail.gmail.com>
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
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
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

CuWcqCAyMDIxLzcvNCDkuIvljYg1OjQ5LCBZb25namkgWGllIOWGmemBkzoKPj4+IE9LLCBJIGdl
dCB5b3Ugbm93LiBTaW5jZSB0aGUgVklSVElPIHNwZWNpZmljYXRpb24gc2F5cyAiRGV2aWNlCj4+
PiBjb25maWd1cmF0aW9uIHNwYWNlIGlzIGdlbmVyYWxseSB1c2VkIGZvciByYXJlbHktY2hhbmdp
bmcgb3IKPj4+IGluaXRpYWxpemF0aW9uLXRpbWUgcGFyYW1ldGVycyIuIEkgYXNzdW1lIHRoZSBW
RFVTRV9ERVZfU0VUX0NPTkZJRwo+Pj4gaW9jdGwgc2hvdWxkIG5vdCBiZSBjYWxsZWQgZnJlcXVl
bnRseS4KPj4gVGhlIHNwZWMgdXNlcyBNVVNUIGFuZCBvdGhlciB0ZXJtcyB0byBkZWZpbmUgdGhl
IHByZWNpc2UgcmVxdWlyZW1lbnRzLgo+PiBIZXJlIHRoZSBsYW5ndWFnZSAoZXNwZWNpYWxseSB0
aGUgd29yZCAiZ2VuZXJhbGx5IikgaXMgd2Vha2VyIGFuZCBtZWFucwo+PiB0aGVyZSBtYXkgYmUg
ZXhjZXB0aW9ucy4KPj4KPj4gQW5vdGhlciB0eXBlIG9mIGFjY2VzcyB0aGF0IGRvZXNuJ3Qgd29y
ayB3aXRoIHRoZSBWRFVTRV9ERVZfU0VUX0NPTkZJRwo+PiBhcHByb2FjaCBpcyByZWFkcyB0aGF0
IGhhdmUgc2lkZS1lZmZlY3RzLiBGb3IgZXhhbXBsZSwgaW1hZ2luZSBhIGZpZWxkCj4+IGNvbnRh
aW5pbmcgYW4gZXJyb3IgY29kZSBpZiB0aGUgZGV2aWNlIGVuY291bnRlcnMgYSBwcm9ibGVtIHVu
cmVsYXRlZCB0bwo+PiBhIHNwZWNpZmljIHZpcnRxdWV1ZSByZXF1ZXN0LiBSZWFkaW5nIGZyb20g
dGhpcyBmaWVsZCByZXNldHMgdGhlIGVycm9yCj4+IGNvZGUgdG8gMCwgc2F2aW5nIHRoZSBkcml2
ZXIgYW4gZXh0cmEgY29uZmlndXJhdGlvbiBzcGFjZSB3cml0ZSBhY2Nlc3MKPj4gYW5kIHBvc3Np
Ymx5IHJhY2UgY29uZGl0aW9ucy4gSXQgaXNuJ3QgcG9zc2libGUgdG8gaW1wbGVtZW50IHRob3Nl
Cj4+IHNlbWFudGljcyBzdWluZyBWRFVTRV9ERVZfU0VUX0NPTkZJRy4gSXQncyBhbm90aGVyIGNv
cm5lciBjYXNlLCBidXQgaXQKPj4gbWFrZXMgbWUgdGhpbmsgdGhhdCB0aGUgaW50ZXJmYWNlIGRv
ZXMgbm90IGFsbG93IGZ1bGwgVklSVElPIHNlbWFudGljcy4KCgpOb3RlIHRoYXQgdGhvdWdoIHlv
dSdyZSBjb3JyZWN0LCBteSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgY29uZmlnIHNwYWNlIAppcyBu
b3Qgc3VpdGFibGUgZm9yIHRoaXMga2luZCBvZiBlcnJvciBwcm9wYWdhdGluZy4gQW5kIGl0IHdv
dWxkIGJlIHZlcnkgCmhhcmQgdG8gaW1wbGVtZW50IHN1Y2gga2luZCBvZiBzZW1hbnRpYyBpbiBz
b21lIHRyYW5zcG9ydHMuwqAgVmlydHF1ZXVlIApzaG91bGQgYmUgbXVjaCBiZXR0ZXIuIEFzIFlv
bmcgSmkgcXVvdGVkLCB0aGUgY29uZmlnIHNwYWNlIGlzIHVzZWQgZm9yIAoicmFyZWx5LWNoYW5n
aW5nIG9yIGludGlhbGl6YXRpb24tdGltZSBwYXJhbWV0ZXJzIi4KCgo+IEFncmVlZC4gSSB3aWxs
IHVzZSBWRFVTRV9ERVZfR0VUX0NPTkZJRyBpbiB0aGUgbmV4dCB2ZXJzaW9uLiBBbmQgdG8KPiBo
YW5kbGUgdGhlIG1lc3NhZ2UgZmFpbHVyZSwgSSdtIGdvaW5nIHRvIGFkZCBhIHJldHVybiB2YWx1
ZSB0bwo+IHZpcnRpb19jb25maWdfb3BzLmdldCgpIGFuZCB2aXJ0aW9fY3JlYWRfKiBBUEkgc28g
dGhhdCB0aGUgZXJyb3IgY2FuCj4gYmUgcHJvcGFnYXRlZCB0byB0aGUgdmlydGlvIGRldmljZSBk
cml2ZXIuIFRoZW4gdGhlIHZpcnRpby1ibGsgZGV2aWNlCj4gZHJpdmVyIGNhbiBiZSBtb2RpZmll
ZCB0byBoYW5kbGUgdGhhdC4KPgo+IEphc29uIGFuZCBTdGVmYW4sIHdoYXQgZG8geW91IHRoaW5r
IG9mIHRoaXMgd2F5PwoKCkknZCBsaWtlIHRvIHN0aWNrIHRvIHRoZSBjdXJyZW50IGFzc3VtcHRp
b24gdGhpY2ggZ2V0X2NvbmZpZyB3b24ndCBmYWlsLiAKVGhhdCBpcyB0byBzYXksCgoxKSBtYWlu
dGFpbiBhIGNvbmZpZyBpbiB0aGUga2VybmVsLCBtYWtlIHN1cmUgdGhlIGNvbmZpZyBzcGFjZSBy
ZWFkIGNhbiAKYWx3YXlzIHN1Y2NlZWQKMikgaW50cm9kdWNlIGFuIGlvY3RsIGZvciB0aGUgdmR1
c2UgdXNlcnNhcGNlIHRvIHVwZGF0ZSB0aGUgY29uZmlnIHNwYWNlLgozKSB3ZSBjYW4gc3luY2hy
b25pemUgd2l0aCB0aGUgdmR1c2UgdXNlcnNwYWNlIGR1cmluZyBzZXRfY29uZmlnCgpEb2VzIHRo
aXMgd29yaz8KClRoYW5rcwoKCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
