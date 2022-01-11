Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AC2C433EF
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 13:04:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6B81410D3;
	Tue, 11 Jan 2022 13:04:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ehYrAb78Y_lM; Tue, 11 Jan 2022 13:04:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 469FB40248;
	Tue, 11 Jan 2022 13:04:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18A83C002F;
	Tue, 11 Jan 2022 13:04:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4172C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 13:04:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D25928191E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 13:04:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TR6FDiyOGOgO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 13:04:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AED17818AC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 13:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641906276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CnoXRZzxHpYZJCWWJWjQzv34cSxRuBzuUNROP7tocqU=;
 b=AyX2gQYEMBlGHWNCW2H5SkG5gZQ62780GJ5XOqIR8PGCax49+G+twa9Q5xP7DC81+HinyC
 1TbigK76XIGzg39yrjTTlMMrzABGMC0fHKLzPiYumcPoT5vZzmy2OzEHhNudBMYSoHXnN0
 jb1qhpvyW8/nhtlWWHwP9JMg8rHRm9g=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-hbWTMHm4OYu3pxVYNtxp4w-1; Tue, 11 Jan 2022 08:04:20 -0500
X-MC-Unique: hbWTMHm4OYu3pxVYNtxp4w-1
Received: by mail-ed1-f70.google.com with SMTP id
 ec25-20020a0564020d5900b003fc074c5d21so8844299edb.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 05:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=CnoXRZzxHpYZJCWWJWjQzv34cSxRuBzuUNROP7tocqU=;
 b=744KPRlbtw0FaT0HFjYRdI4AlKCE3H/cy82Qt5C63c1mgFT1OpBZn4pNA4NFYZKLF2
 EiU7bcehhiBmoH4S7r4jCCWUAzKwuSmYSNFEukrYDgretm1cuEMUbs66BV9yp/IUpQlN
 S0fNSCdcdabqB0A53Rfqd5nsQVSJCpaEn2n0j4I6b1aiHSWidKwU6VIbDrLFuL3ghSgA
 G6nPL6WMA9UnZJzmtLGmqByzHqolRhTcSYGyXFG8QbVTjiNx97YjEExnZmjKV7I+Rve6
 5NAsh78OLLawxSd+UIvEzrMOHsW7RovgipQWTMvRO4d1+D8DBN89ySunjvayuvz1rc1f
 nlpw==
X-Gm-Message-State: AOAM531RVjWrIY0Sv/C8tp5XHLhceFD9SHq2vnFnGPPahTU+9kHJsRHy
 tvs7E6aPfxoQKPjj7f9mGRmv/IXPdO8R9KHNM1Dbx6glD4uxRHf7VWA2s4zlx24VUjIY0BaCbHp
 zXVVbrL+r8TQVSFclNt02nMEqlurlcq48bmEW2uL0JA==
X-Received: by 2002:a17:906:3707:: with SMTP id
 d7mr3673151ejc.688.1641906259356; 
 Tue, 11 Jan 2022 05:04:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyufWlr/Lw1gvdqS0EUpwg1gh0cWIzsXPiLkrC7aOl+Vt8tOWZrM6glrUNIyzIuktDWyNcriw==
X-Received: by 2002:a17:906:3707:: with SMTP id
 d7mr3673099ejc.688.1641906259017; 
 Tue, 11 Jan 2022 05:04:19 -0800 (PST)
Received: from redhat.com ([2.55.5.100])
 by smtp.gmail.com with ESMTPSA id j5sm3591214ejo.171.2022.01.11.05.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jan 2022 05:04:18 -0800 (PST)
Date: Tue, 11 Jan 2022 08:04:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v12 00/13] Introduce VDUSE - vDPA Device in Userspace
Message-ID: <20220111080359-mutt-send-email-mst@kernel.org>
References: <20210830141737.181-1-xieyongji@bytedance.com>
 <20220110075546-mutt-send-email-mst@kernel.org>
 <CACycT3v1aEViw7vV4x5qeGVPrSrO-BTDvQshEX35rx_X0Au2vw@mail.gmail.com>
 <20220110100911-mutt-send-email-mst@kernel.org>
 <CACycT3v6jo3-8ATWUzf659vV94a2oRrm-zQtGNDZd6OQr-MENA@mail.gmail.com>
 <20220110103938-mutt-send-email-mst@kernel.org>
 <CACycT3sbJC1Jn7NeWk_ccQ_2_YgKybjugfxmKpfgCP3Ayoju4w@mail.gmail.com>
 <20220111065301-mutt-send-email-mst@kernel.org>
 <CACycT3sdfAbdByKJwg8N-Jb2qVDdgfSqprp_aOp5fpYz4LxmgA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3sdfAbdByKJwg8N-Jb2qVDdgfSqprp_aOp5fpYz4LxmgA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm <kvm@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 joro@8bytes.org, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, John Garry <john.garry@huawei.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 He Zhe <zhe.he@windriver.com>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, Netdev <netdev@vger.kernel.org>, Joe Perches <joe@perches.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>
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

T24gVHVlLCBKYW4gMTEsIDIwMjIgYXQgMDg6NTc6NDlQTSArMDgwMCwgWW9uZ2ppIFhpZSB3cm90
ZToKPiBPbiBUdWUsIEphbiAxMSwgMjAyMiBhdCA3OjU0IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFR1ZSwgSmFuIDExLCAyMDIyIGF0IDEx
OjMxOjM3QU0gKzA4MDAsIFlvbmdqaSBYaWUgd3JvdGU6Cj4gPiA+IE9uIE1vbiwgSmFuIDEwLCAy
MDIyIGF0IDExOjQ0IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3Rl
Ogo+ID4gPiA+Cj4gPiA+ID4gT24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgMTE6MjQ6NDBQTSArMDgw
MCwgWW9uZ2ppIFhpZSB3cm90ZToKPiA+ID4gPiA+IE9uIE1vbiwgSmFuIDEwLCAyMDIyIGF0IDEx
OjEwIFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiBPbiBNb24sIEphbiAxMCwgMjAyMiBhdCAwOTo1NDowOFBNICswODAw
LCBZb25namkgWGllIHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9uIE1vbiwgSmFuIDEwLCAyMDIyIGF0
IDg6NTcgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gT24gTW9uLCBBdWcgMzAsIDIwMjEgYXQgMTA6MTc6
MjRQTSArMDgwMCwgWGllIFlvbmdqaSB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gVGhpcyBzZXJp
ZXMgaW50cm9kdWNlcyBhIGZyYW1ld29yayB0aGF0IG1ha2VzIGl0IHBvc3NpYmxlIHRvIGltcGxl
bWVudAo+ID4gPiA+ID4gPiA+ID4gPiBzb2Z0d2FyZS1lbXVsYXRlZCB2RFBBIGRldmljZXMgaW4g
dXNlcnNwYWNlLiBBbmQgdG8gbWFrZSB0aGUgZGV2aWNlCj4gPiA+ID4gPiA+ID4gPiA+IGVtdWxh
dGlvbiBtb3JlIHNlY3VyZSwgdGhlIGVtdWxhdGVkIHZEUEEgZGV2aWNlJ3MgY29udHJvbCBwYXRo
IGlzIGhhbmRsZWQKPiA+ID4gPiA+ID4gPiA+ID4gaW4gdGhlIGtlcm5lbCBhbmQgb25seSB0aGUg
ZGF0YSBwYXRoIGlzIGltcGxlbWVudGVkIGluIHRoZSB1c2Vyc3BhY2UuCj4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+IFNpbmNlIHRoZSBlbXVsZGF0ZWQgdkRQQSBkZXZpY2UncyBj
b250cm9sIHBhdGggaXMgaGFuZGxlZCBpbiB0aGUga2VybmVsLAo+ID4gPiA+ID4gPiA+ID4gPiBh
IG1lc3NhZ2UgbWVjaG5pc20gaXMgaW50cm9kdWNlZCB0byBtYWtlIHVzZXJzcGFjZSBiZSBhd2Fy
ZSBvZiB0aGUgZGF0YQo+ID4gPiA+ID4gPiA+ID4gPiBwYXRoIHJlbGF0ZWQgY2hhbmdlcy4gVXNl
cnNwYWNlIGNhbiB1c2UgcmVhZCgpL3dyaXRlKCkgdG8gcmVjZWl2ZS9yZXBseQo+ID4gPiA+ID4g
PiA+ID4gPiB0aGUgY29udHJvbCBtZXNzYWdlcy4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+ID4gSW4gdGhlIGRhdGEgcGF0aCwgdGhlIGNvcmUgaXMgbWFwcGluZyBkbWEgYnVmZmVy
IGludG8gVkRVU0UgZGFlbW9uJ3MKPiA+ID4gPiA+ID4gPiA+ID4gYWRkcmVzcyBzcGFjZSwgd2hp
Y2ggY2FuIGJlIGltcGxlbWVudGVkIGluIGRpZmZlcmVudCB3YXlzIGRlcGVuZGluZyBvbgo+ID4g
PiA+ID4gPiA+ID4gPiB0aGUgdmRwYSBidXMgdG8gd2hpY2ggdGhlIHZEUEEgZGV2aWNlIGlzIGF0
dGFjaGVkLgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBJbiB2aXJ0aW8tdmRw
YSBjYXNlLCB3ZSBpbXBsZW1lbnRzIGEgTU1VLWJhc2VkIHNvZnR3YXJlIElPVExCIHdpdGgKPiA+
ID4gPiA+ID4gPiA+ID4gYm91bmNlLWJ1ZmZlcmluZyBtZWNoYW5pc20gdG8gYWNoaWV2ZSB0aGF0
LiBBbmQgaW4gdmhvc3QtdmRwYSBjYXNlLCB0aGUgZG1hCj4gPiA+ID4gPiA+ID4gPiA+IGJ1ZmZl
ciBpcyByZXNpZGUgaW4gYSB1c2Vyc3BhY2UgbWVtb3J5IHJlZ2lvbiB3aGljaCBjYW4gYmUgc2hh
cmVkIHRvIHRoZQo+ID4gPiA+ID4gPiA+ID4gPiBWRFVTRSB1c2Vyc3BhY2UgcHJvY2Vzc3Mgdmlh
IHRyYW5zZmVycmluZyB0aGUgc2htZmQuCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
PiA+IFRoZSBkZXRhaWxzIGFuZCBvdXIgdXNlciBjYXNlIGlzIHNob3duIGJlbG93Ogo+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gICAg
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KPiA+ID4gPiA+ID4gPiA+ID4gfCAgICAgICAgICAgIENvbnRhaW5l
ciB8ICAgIHwgICAgICAgICAgICAgIFFFTVUoVk0pIHwgICB8ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFZEVVNFIGRhZW1vbiB8Cj4gPiA+ID4gPiA+ID4gPiA+IHwgICAgICAgLS0tLS0t
LS0tICAgICAgfCAgICB8ICAtLS0tLS0tLS0tLS0tLS0tLS0tICB8ICAgfCAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tIC0tLS0tLS0tLS0tLS0tLS0gfAo+ID4gPiA+ID4gPiA+ID4gPiB8ICAgICAg
IHxkZXYvdmR4fCAgICAgIHwgICAgfCAgfC9kZXYvdmhvc3QtdmRwYS14fCAgfCAgIHwgfCB2RFBB
IGRldmljZSBlbXVsYXRpb24gfCB8IGJsb2NrIGRyaXZlciB8IHwKPiA+ID4gPiA+ID4gPiA+ID4g
LS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tICAgICAtLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0gICAt
LS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tCj4gPiA+ID4gPiA+
ID4gPiA+ICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgfAo+ID4gPiA+ID4gPiA+
ID4gPiAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgIHwKPiA+ID4gPiA+ID4gPiA+
ID4gLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tCj4gPiA+ID4g
PiA+ID4gPiA+IHwgICAgfCBibG9jayBkZXZpY2UgfCAgICAgICAgICAgfCAgdmhvc3QgZGV2aWNl
IHwgICAgICAgICAgICB8IHZkdXNlIGRyaXZlciB8ICAgICAgICAgIHwgVENQL0lQIHwgICAgfAo+
ID4gPiA+ID4gPiA+ID4gPiB8ICAgIC0tLS0tLS0rLS0tLS0tLS0gICAgICAgICAgIC0tLS0tLS0t
Ky0tLS0tLS0tICAgICAgICAgICAgLS0tLS0tLSstLS0tLS0tLSAgICAgICAgICAtLS0tLSstLS0t
ICAgIHwKPiA+ID4gPiA+ID4gPiA+ID4gfCAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgICAgICB8Cj4gPiA+ID4gPiA+ID4gPiA+IHwgLS0tLS0tLS0tLSstLS0tLS0tLS0tICAg
ICAgIC0tLS0tLS0tLS0rLS0tLS0tLS0tLS0gICAgICAgICAtLS0tLS0tKy0tLS0tLS0gICAgICAg
ICAgICAgICAgfCAgICAgICAgfAo+ID4gPiA+ID4gPiA+ID4gPiB8IHwgdmlydGlvLWJsayBkcml2
ZXIgfCAgICAgICB8ICB2aG9zdC12ZHBhIGRyaXZlciB8ICAgICAgICAgfCB2ZHBhIGRldmljZSB8
ICAgICAgICAgICAgICAgIHwgICAgICAgIHwKPiA+ID4gPiA+ID4gPiA+ID4gfCAtLS0tLS0tLS0t
Ky0tLS0tLS0tLS0gICAgICAgLS0tLS0tLS0tLSstLS0tLS0tLS0tLSAgICAgICAgIC0tLS0tLS0r
LS0tLS0tLSAgICAgICAgICAgICAgICB8ICAgICAgICB8Cj4gPiA+ID4gPiA+ID4gPiA+IHwgICAg
ICAgICAgIHwgICAgICB2aXJ0aW8gYnVzICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgfAo+ID4gPiA+ID4gPiA+ID4g
PiB8ICAgLS0tLS0tLS0rLS0tLSstLS0tLS0tLS0tLSAgICAgICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgIHwKPiA+ID4gPiA+
ID4gPiA+ID4gfCAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICB8Cj4g
PiA+ID4gPiA+ID4gPiA+IHwgICAgICAtLS0tLS0tLS0tKy0tLS0tLS0tLS0gICAgICAgICAgICB8
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgfCAgICAg
ICAgfAo+ID4gPiA+ID4gPiA+ID4gPiB8ICAgICAgfCB2aXJ0aW8tYmxrIGRldmljZSB8ICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
IHwgICAgICAgIHwKPiA+ID4gPiA+ID4gPiA+ID4gfCAgICAgIC0tLS0tLS0tLS0rLS0tLS0tLS0t
LSAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgICAgICB8Cj4gPiA+ID4gPiA+ID4gPiA+IHwgICAgICAgICAgICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgfCAgICAgICAgfAo+ID4gPiA+ID4gPiA+ID4gPiB8ICAgICAtLS0tLS0t
LS0tLSstLS0tLS0tLS0tLSAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgIHwKPiA+ID4gPiA+ID4gPiA+ID4gfCAgICAg
fCAgdmlydGlvLXZkcGEgZHJpdmVyIHwgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICB8Cj4gPiA+ID4gPiA+ID4gPiA+
IHwgICAgIC0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tICAgICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgfAo+ID4gPiA+ID4g
PiA+ID4gPiB8ICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAgdmRwYSBidXMgICAgICAgICAgIHwgICAgICAgIHwKPiA+
ID4gPiA+ID4gPiA+ID4gfCAgICAgLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tICAgICAgICAgICB8ICAgICAg
ICB8Cj4gPiA+ID4gPiA+ID4gPiA+IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0t
Ky0tLSAgICAgfAo+ID4gPiA+ID4gPiA+ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLXwgTklDIHwtLS0tLS0KPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAtLS0rLS0tCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfAo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIC0tLS0tLS0tLSstLS0tLS0tLS0KPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8IFJlbW90ZSBTdG9yYWdlcyB8Cj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4gPiBXZSBtYWtlIHVzZSBvZiBpdCB0byBpbXBsZW1lbnQgYSBibG9jayBk
ZXZpY2UgY29ubmVjdGluZyB0bwo+ID4gPiA+ID4gPiA+ID4gPiBvdXIgZGlzdHJpYnV0ZWQgc3Rv
cmFnZSwgd2hpY2ggY2FuIGJlIHVzZWQgYm90aCBpbiBjb250YWluZXJzIGFuZAo+ID4gPiA+ID4g
PiA+ID4gPiBWTXMuIFRodXMsIHdlIGNhbiBoYXZlIGFuIHVuaWZpZWQgdGVjaG5vbG9neSBzdGFj
ayBpbiB0aGlzIHR3byBjYXNlcy4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
VG8gdGVzdCBpdCB3aXRoIG51bGwtYmxrOgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4gPiAgICQgcWVtdS1zdG9yYWdlLWRhZW1vbiBcCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgIC0t
Y2hhcmRldiBzb2NrZXQsaWQ9Y2hhcm1vbml0b3IscGF0aD0vdG1wL3FtcC5zb2NrLHNlcnZlcixu
b3dhaXQgXAo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAtLW1vbml0b3IgY2hhcmRldj1jaGFybW9u
aXRvciBcCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgIC0tYmxvY2tkZXYgZHJpdmVyPWhvc3RfZGV2
aWNlLGNhY2hlLmRpcmVjdD1vbixhaW89bmF0aXZlLGZpbGVuYW1lPS9kZXYvbnVsbGIwLG5vZGUt
bmFtZT1kaXNrMCBcCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgIC0tZXhwb3J0IHR5cGU9dmR1c2Ut
YmxrLGlkPXRlc3Qsbm9kZS1uYW1lPWRpc2swLHdyaXRhYmxlPW9uLG5hbWU9dmR1c2UtbnVsbCxu
dW0tcXVldWVzPTE2LHF1ZXVlLXNpemU9MTI4Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiA+IFRoZSBxZW11LXN0b3JhZ2UtZGFlbW9uIGNhbiBiZSBmb3VuZCBhdCBodHRwczovL2dp
dGh1Yi5jb20vYnl0ZWRhbmNlL3FlbXUvdHJlZS92ZHVzZQo+ID4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiA+IEl0J3MgYmVlbiBoYWxmIGEgeWVhciAtIGFueSBwbGFucyB0byB1cHN0cmVhbSB0
aGlzPwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gWWVhaCwgdGhpcyBpcyBvbiBteSB0by1k
byBsaXN0IHRoaXMgbW9udGguCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBTb3JyeSBmb3Ig
dGFraW5nIHNvIGxvbmcuLi4gSSd2ZSBiZWVuIHdvcmtpbmcgb24gYW5vdGhlciBwcm9qZWN0Cj4g
PiA+ID4gPiA+ID4gZW5hYmxpbmcgdXNlcnNwYWNlIFJETUEgd2l0aCBWRFVTRSBmb3IgdGhlIHBh
c3QgZmV3IG1vbnRocy4gU28gSQo+ID4gPiA+ID4gPiA+IGRpZG4ndCBoYXZlIG11Y2ggdGltZSBm
b3IgdGhpcy4gQW55d2F5LCBJIHdpbGwgc3VibWl0IHRoZSBmaXJzdAo+ID4gPiA+ID4gPiA+IHZl
cnNpb24gYXMgc29vbiBhcyBwb3NzaWJsZS4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFRo
YW5rcywKPiA+ID4gPiA+ID4gPiBZb25namkKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gT2ggZnVu
LiBZb3UgbWVhbiBsaWtlIHZpcnRpby1yZG1hPyBPciBSRE1BIGFzIGEgYmFja2VuZCBmb3IgcmVn
dWxhcgo+ID4gPiA+ID4gPiB2aXJ0aW8/Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4g
WWVzLCBsaWtlIHZpcnRpby1yZG1hLiBUaGVuIHdlIGNhbiBkZXZlbG9wIHNvbWV0aGluZyBsaWtl
IHVzZXJzcGFjZQo+ID4gPiA+ID4gcnhl44CBc2l3IG9yIGN1c3RvbSBwcm90b2NvbCB3aXRoIFZE
VVNFLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcywKPiA+ID4gPiA+IFlvbmdqaQo+ID4gPiA+
Cj4gPiA+ID4gV291bGQgYmUgaW50ZXJlc3RpbmcgdG8gc2VlIHRoZSBzcGVjIGZvciB0aGF0Lgo+
ID4gPgo+ID4gPiBXaWxsIHNlbmQgaXQgQVNBUC4KPiA+ID4KPiA+ID4gPiBUaGUgaXNzdWVzIHdp
dGggUkRNQSByZXZvbHZlZCBhcm91bmQgdGhlIGZhY3QgdGhhdCBjdXJyZW50Cj4gPiA+ID4gYXBw
cyB0ZW5kIHRvIGVpdGhlciB1c2Ugbm9uLXN0YW5kYXJkIHByb3BvY29scyBmb3IgY29ubmVjdGlv
bgo+ID4gPiA+IGVzdGFibGlzaG1lbnQgb3IgdXNlIFVEIHdoZXJlIHRoZXJlJ3MgSUlSQyBubyBz
dGFuZGFyZAo+ID4gPiA+IGF0IGFsbC4gU28gUVAgbnVtYmVycyBhcmUgaGFyZCB0byB2aXJ0dWFs
aXplLgo+ID4gPiA+IFNpbWlsYXJseSBtYW55IHVzZSBMSURzIGRpcmVjdGx5IHdpdGggdGhlIHNh
bWUgZWZmZWN0Lgo+ID4gPiA+IEdVSURzIG1pZ2h0IGJlIHZpcnR1YWxpemVhYmxlIGJ1dCBubyBv
bmUgd2VudCB0byB0aGUgZWZmb3J0Lgo+ID4gPiA+Cj4gPiA+Cj4gPiA+IEFjdHVhbGx5IHdlIGFp
bWVkIGF0IGVtdWxhdGluZyBhIHNvZnQgUkRNQSB3aXRoIG5vcm1hbCBOSUMgKG5vdCB1c2UKPiA+
ID4gUkRNQSBjYXBhYmlsaXR5KSByYXRoZXIgdGhhbiB2aXJ0dWFsaXppbmcgYSBwaHlzaWNhbCBS
RE1BIE5JQyBpbnRvCj4gPiA+IHNldmVyYWwgdlJETUEgZGV2aWNlcy4gSWYgc28sIEkgdGhpbmsg
d2Ugd29uJ3QgaGF2ZSB0aG9zZSBpc3N1ZXMsCj4gPiA+IHJpZ2h0Pwo+ID4KPiA+IFJpZ2h0LCBt
YXliZSB5b3Ugd29uJ3QuCj4gPgo+ID4gPiA+IFRvIHNheSBub3RoaW5nIGFib3V0IHRoZSBpbnRl
cmFjdGlvbiB3aXRoIG1lbW9yeSBvdmVyY29tbWl0Lgo+ID4gPiA+Cj4gPiA+Cj4gPiA+IEkgZG9u
J3QgZ2V0IHlvdSBoZXJlLiBDb3VsZCB5b3UgZ2l2ZSBtZSBtb3JlIGRldGFpbHM/Cj4gPiA+Cj4g
PiA+IFRoYW5rcywKPiA+ID4gWW9uZ2ppCj4gPgo+ID4gUkRNQSBkZXZpY2VzIHRlbmQgdG8gd2Fu
dCB0byBwaW4gdGhlIG1lbW9yeSB1bmRlciBETUEuCj4gPgo+IAo+IEkgc2VlLiBNYXliZSBzb21l
dGhpbmcgbGlrZSBkbSBvciBvZHAgY291bGQgYmUgaGVscGZ1bC4KPiAKPiBUaGFua3MsCj4gWW9u
Z2ppCgpZZXMgc3VyZS4KCi0tIApNU1QKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
