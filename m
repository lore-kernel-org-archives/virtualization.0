Return-Path: <SRS0=5nkl=M3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF49C4338F
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 08:54:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588CE60EBC
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 08:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 588CE60EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17BC1405B4;
	Wed,  4 Aug 2021 08:54:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IqhZyPOtxhev; Wed,  4 Aug 2021 08:54:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C11244059B;
	Wed,  4 Aug 2021 08:54:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AEB1C001A;
	Wed,  4 Aug 2021 08:54:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25DD5C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 08:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 07B7E405B3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 08:54:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vB2pSicLXWtl
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 08:54:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 34F864059B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 08:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628067256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JEJS6wNFWZnl108KgJLIgK1xlv8/2mIWHkixRJuOciE=;
 b=Wo5qFjv0u9tOkMLMyNtL2c+4IssMP9Ag1pmD1uc4wuJ01tW5M+zQox/7cbeWh0K5SNEZ5G
 MCr1DlbiJvdOh4H5dckTj7s6BZY+T5795+JJXjFd9yspD+PHlc9sRS8rOOkDCk4l3kfJhp
 ijdG4agsLMOE3Zr/yqFM13qmJ01cvTg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-ynT9707qMyiczcFh79Zxkg-1; Wed, 04 Aug 2021 04:54:12 -0400
X-MC-Unique: ynT9707qMyiczcFh79Zxkg-1
Received: by mail-pl1-f199.google.com with SMTP id
 p21-20020a1709028a95b029012c31764588so1642887plo.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Aug 2021 01:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=JEJS6wNFWZnl108KgJLIgK1xlv8/2mIWHkixRJuOciE=;
 b=gt4vXQ8sdNDIKPqcXlXnNf2mYIYvGdWX2BolHgice/nPa0c2tIBEIzgeq4qXaCNUp/
 TwG0D32v8xbPAOiGHY3w6aeBqSqlM66vYxAqkQASsqBUxOcpVq+HNyPPI34CwhssljQF
 0Y0587TbakgIgWxaU45PLCwk1fn/BXyuUr/XhX1YVY4axK6buCXgrCcQqu+znrkc3JCj
 syRR43M2PjsUigRVTvt02NQrOXQbjqSOnp8H0ezDuIFhNDmeKhvLXOJBhVZBRB8htzv3
 WJGaDLopyScaJ2cK/gQjn8zBEsVJOUNiIoW19nR5dE/35LzLqf+vaPE3C0SXbfOpz5Wr
 20Bg==
X-Gm-Message-State: AOAM531LZBa04FmsgpfSvO9+W0WX2G1OlZLFp/rqVWVbxHmkXE7vzkTQ
 iPUY+tpYIFJyWP9Izyu/ALS+tG8phu5WIr0/SVDOU0gRuFsJVbRBlfLQzPIewSl2ZPP9aL+QJb+
 5ueLl+jcOIa7cuZ9YYeRb/ONLQFXNdtB8T4J239UKtA==
X-Received: by 2002:a17:90a:f486:: with SMTP id
 bx6mr26967690pjb.26.1628067251873; 
 Wed, 04 Aug 2021 01:54:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdg7DPc1fVvfeRYsMAj9zuHXHxH4WMFyt0BnuNiFR52VmL83Bg8evPgUiXWSZNAPGcbnx9HQ==
X-Received: by 2002:a17:90a:f486:: with SMTP id
 bx6mr26967649pjb.26.1628067251626; 
 Wed, 04 Aug 2021 01:54:11 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 6sm1963202pfg.108.2021.08.04.01.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Aug 2021 01:54:11 -0700 (PDT)
Subject: Re: [PATCH v10 10/17] virtio: Handle device reset failure in
 register_virtio_device()
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-11-xieyongji@bytedance.com>
 <6bb6c689-e6dd-cfa2-094b-a0ca4258aded@redhat.com>
 <CACycT3v7BHxYY0OFYJRFU41Bz1=_v8iMRwzYKgX6cJM-SiNH+A@mail.gmail.com>
 <fdcb0224-11f9-caf2-a44e-e6406087fd50@redhat.com>
 <CACycT3v0EQVrv_A1K1bKmiYu0q5aFE=t+0yRaWKC7T3_H3oB-Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bd48ec76-0d5c-2efb-8406-894286b28f6b@redhat.com>
Date: Wed, 4 Aug 2021 16:54:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACycT3v0EQVrv_A1K1bKmiYu0q5aFE=t+0yRaWKC7T3_H3oB-Q@mail.gmail.com>
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
 Dan Carpenter <dan.carpenter@oracle.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 He Zhe <zhe.he@windriver.com>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, Joe Perches <joe@perches.com>,
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

CuWcqCAyMDIxLzgvNCDkuIvljYg0OjUwLCBZb25namkgWGllIOWGmemBkzoKPiBPbiBXZWQsIEF1
ZyA0LCAyMDIxIGF0IDQ6MzIgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4+Cj4+IOWcqCAyMDIxLzgvMyDkuIvljYg1OjM4LCBZb25namkgWGllIOWGmemBkzoKPj4+
IE9uIFR1ZSwgQXVnIDMsIDIwMjEgYXQgNDowOSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPj4+PiDlnKggMjAyMS83LzI5IOS4i+WNiDM6MzQsIFhpZSBZb25namkg
5YaZ6YGTOgo+Pj4+PiBUaGUgZGV2aWNlIHJlc2V0IG1heSBmYWlsIGluIHZpcnRpby12ZHBhIGNh
c2Ugbm93LCBzbyBhZGQgY2hlY2tzIHRvCj4+Pj4+IGl0cyByZXR1cm4gdmFsdWUgYW5kIGZhaWwg
dGhlIHJlZ2lzdGVyX3ZpcnRpb19kZXZpY2UoKS4KPj4+PiBTbyB0aGUgcmVzZXQoKSB3b3VsZCBi
ZSBjYWxsZWQgYnkgdGhlIGRyaXZlciBkdXJpbmcgcmVtb3ZlIGFzIHdlbGwsIG9yCj4+Pj4gaXMg
aXQgc3VmZmljaWVudCB0byBkZWFsIG9ubHkgd2l0aCB0aGUgcmVzZXQgZHVyaW5nIHByb2JlPwo+
Pj4+Cj4+PiBBY3R1YWxseSB0aGVyZSBpcyBubyB3YXkgdG8gaGFuZGxlIGZhaWx1cmUgZHVyaW5n
IHJlbW92YWwuIEFuZCBpdAo+Pj4gc2hvdWxkIGJlIHNhZmUgd2l0aCB0aGUgcHJvdGVjdGlvbiBv
ZiBzb2Z0d2FyZSBJT1RMQiBldmVuIGlmIHRoZQo+Pj4gcmVzZXQoKSBmYWlscy4KPj4+Cj4+PiBU
aGFua3MsCj4+PiBZb25namkKPj4KPj4gSWYgdGhpcyBpcyB0cnVlLCBkb2VzIGl0IG1lYW4gd2Ug
ZG9uJ3QgZXZlbiBuZWVkIHRvIGNhcmUgYWJvdXQgcmVzZXQKPj4gZmFpbHVyZT8KPj4KPiBCdXQg
d2UgbmVlZCB0byBoYW5kbGUgdGhlIGZhaWx1cmUgaW4gdGhlIHZob3N0LXZkcGEgY2FzZSwgaXNu
J3QgaXQ/CgoKWWVzLCBidXQ6CgotIFRoaXMgcGF0Y2ggaXMgZm9yIHZpcnRpbyBub3QgZm9yIHZo
b3N0LCBpZiB3ZSBkb24ndCBjYXJlIHZpcnRpbywgd2UgCmNhbiBhdm9pZCB0aGUgY2hhbmdlcwot
IEZvciB2aG9zdCwgdGhlcmUgY291bGQgYmUgdHdvIHdheXMgcHJvYmFibHk6CgoxKSBsZXQgdGhl
IHNldF9zdGF0dXMgdG8gcmVwb3J0IGVycm9yCjIpIHJlcXVpcmUgdXNlcnNwYWNlIHRvIHJlLXJl
YWQgZm9yIHN0YXR1cwoKSXQgbG9va3MgdG8gbWUgeW91IHdhbnQgdG8gZ28gd2l0aCAxKSBhbmQg
SSdtIG5vdCBzdXJlIHdoZXRoZXIgb3Igbm90IAppdCdzIHRvbyBsYXRlIHRvIGdvIHdpdGggMiku
CgpUaGFua3MKCgo+Cj4gVGhhbmtzLAo+IFlvbmdqaQo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
