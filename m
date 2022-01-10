Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C251BC433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 15:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 476DD8148F;
	Mon, 10 Jan 2022 15:44:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pfrYWalsXs3C; Mon, 10 Jan 2022 15:44:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CD263813E0;
	Mon, 10 Jan 2022 15:44:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A522CC002F;
	Mon, 10 Jan 2022 15:44:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E91D9C001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 15:44:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C0C62813F8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 15:44:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3igCf0xbgXkZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 15:44:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CCBF8813E0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 15:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641829464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GwsjTdK6v2LnBFhWI+JJOy9OQSY+yI1I9CwqbFn3SQ=;
 b=DvnUYEvpnzTAeUwOpuyl1FA4lSU6D58bvsSauGti+BwmRcfx32Tvyqesnmx6aqQ2Rkiuzf
 GUVZ0bLMiFlQfXXw4YZpepIPoYc9QsC8EMiv3lyYaIW5msmujJ+K9YhVp2m25ZKHl2bqwp
 b6kq25ecLpJnhNVjJmKrdvVrMIm1ucs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-qq18qusGPmK1sPW0hMucZg-1; Mon, 10 Jan 2022 10:44:21 -0500
X-MC-Unique: qq18qusGPmK1sPW0hMucZg-1
Received: by mail-wm1-f72.google.com with SMTP id
 az9-20020a05600c600900b0034692565ca8so8069932wmb.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=1GwsjTdK6v2LnBFhWI+JJOy9OQSY+yI1I9CwqbFn3SQ=;
 b=AXu77wIGJN1H8H9yu7o+I6dHfMOihRDuzQOc4twBcvNDvHDaSypsl/Who4Mn8iZZ5a
 9GBdYt33YEHluM+6Ypv4P8RLSg6ChCWS1R0s6QWJkV2BffpoFKBYO150Jp+AauO5K7uq
 L9I5zkwUZw+W8YNlfLoMclXrE9n7UH/7Dbtyx9YMsahVb+R1c7yU3+nSjNswv8zEoa5y
 njdaqQ6RshYRbP3dIz0EsaBx+brGGGq6xAxqhBPNhpUs96QJGTXDGqTfy/YUraGb2EjR
 6RKoNvGNh1+0fuJx8pgtXEvuPnsgpKRDrHg25vIJ+fBiGvXFt43BjipC1u2BZlcLfSQ/
 Zu4A==
X-Gm-Message-State: AOAM530TVVlo/orNHeFuUZvRmr78ba+Zq3P4J706pBLEVIz3URX7jI13
 xKEcLBPeWhOS5Vzd0GOQDRbWqkOLV/2o74Vc5VU6ocOwn8m3M+tCOE94POTU9E9bwVttkrg/EPs
 BqZawxdnuu7Xs7d6nLGeGCs2Ka84UEyxp5hVGmMDw8A==
X-Received: by 2002:adf:f807:: with SMTP id s7mr184299wrp.638.1641829460435;
 Mon, 10 Jan 2022 07:44:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwGlziNjGEYg/AKCCVR6dHJcBIW6ndhJ3HU0fYXJaw1aGDnRw1EG3ab/feKEGmla/24mvGOMw==
X-Received: by 2002:adf:f807:: with SMTP id s7mr184278wrp.638.1641829460157;
 Mon, 10 Jan 2022 07:44:20 -0800 (PST)
Received: from redhat.com ([2.55.148.228])
 by smtp.gmail.com with ESMTPSA id s1sm6891060wmh.35.2022.01.10.07.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jan 2022 07:44:19 -0800 (PST)
Date: Mon, 10 Jan 2022 10:44:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v12 00/13] Introduce VDUSE - vDPA Device in Userspace
Message-ID: <20220110103938-mutt-send-email-mst@kernel.org>
References: <20210830141737.181-1-xieyongji@bytedance.com>
 <20220110075546-mutt-send-email-mst@kernel.org>
 <CACycT3v1aEViw7vV4x5qeGVPrSrO-BTDvQshEX35rx_X0Au2vw@mail.gmail.com>
 <20220110100911-mutt-send-email-mst@kernel.org>
 <CACycT3v6jo3-8ATWUzf659vV94a2oRrm-zQtGNDZd6OQr-MENA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3v6jo3-8ATWUzf659vV94a2oRrm-zQtGNDZd6OQr-MENA@mail.gmail.com>
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

T24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgMTE6MjQ6NDBQTSArMDgwMCwgWW9uZ2ppIFhpZSB3cm90
ZToKPiBPbiBNb24sIEphbiAxMCwgMjAyMiBhdCAxMToxMCBQTSBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBNb24sIEphbiAxMCwgMjAyMiBhdCAw
OTo1NDowOFBNICswODAwLCBZb25namkgWGllIHdyb3RlOgo+ID4gPiBPbiBNb24sIEphbiAxMCwg
MjAyMiBhdCA4OjU3IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3Rl
Ogo+ID4gPiA+Cj4gPiA+ID4gT24gTW9uLCBBdWcgMzAsIDIwMjEgYXQgMTA6MTc6MjRQTSArMDgw
MCwgWGllIFlvbmdqaSB3cm90ZToKPiA+ID4gPiA+IFRoaXMgc2VyaWVzIGludHJvZHVjZXMgYSBm
cmFtZXdvcmsgdGhhdCBtYWtlcyBpdCBwb3NzaWJsZSB0byBpbXBsZW1lbnQKPiA+ID4gPiA+IHNv
ZnR3YXJlLWVtdWxhdGVkIHZEUEEgZGV2aWNlcyBpbiB1c2Vyc3BhY2UuIEFuZCB0byBtYWtlIHRo
ZSBkZXZpY2UKPiA+ID4gPiA+IGVtdWxhdGlvbiBtb3JlIHNlY3VyZSwgdGhlIGVtdWxhdGVkIHZE
UEEgZGV2aWNlJ3MgY29udHJvbCBwYXRoIGlzIGhhbmRsZWQKPiA+ID4gPiA+IGluIHRoZSBrZXJu
ZWwgYW5kIG9ubHkgdGhlIGRhdGEgcGF0aCBpcyBpbXBsZW1lbnRlZCBpbiB0aGUgdXNlcnNwYWNl
Lgo+ID4gPiA+ID4KPiA+ID4gPiA+IFNpbmNlIHRoZSBlbXVsZGF0ZWQgdkRQQSBkZXZpY2UncyBj
b250cm9sIHBhdGggaXMgaGFuZGxlZCBpbiB0aGUga2VybmVsLAo+ID4gPiA+ID4gYSBtZXNzYWdl
IG1lY2huaXNtIGlzIGludHJvZHVjZWQgdG8gbWFrZSB1c2Vyc3BhY2UgYmUgYXdhcmUgb2YgdGhl
IGRhdGEKPiA+ID4gPiA+IHBhdGggcmVsYXRlZCBjaGFuZ2VzLiBVc2Vyc3BhY2UgY2FuIHVzZSBy
ZWFkKCkvd3JpdGUoKSB0byByZWNlaXZlL3JlcGx5Cj4gPiA+ID4gPiB0aGUgY29udHJvbCBtZXNz
YWdlcy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBJbiB0aGUgZGF0YSBwYXRoLCB0aGUgY29yZSBpcyBt
YXBwaW5nIGRtYSBidWZmZXIgaW50byBWRFVTRSBkYWVtb24ncwo+ID4gPiA+ID4gYWRkcmVzcyBz
cGFjZSwgd2hpY2ggY2FuIGJlIGltcGxlbWVudGVkIGluIGRpZmZlcmVudCB3YXlzIGRlcGVuZGlu
ZyBvbgo+ID4gPiA+ID4gdGhlIHZkcGEgYnVzIHRvIHdoaWNoIHRoZSB2RFBBIGRldmljZSBpcyBh
dHRhY2hlZC4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBJbiB2aXJ0aW8tdmRwYSBjYXNlLCB3ZSBpbXBs
ZW1lbnRzIGEgTU1VLWJhc2VkIHNvZnR3YXJlIElPVExCIHdpdGgKPiA+ID4gPiA+IGJvdW5jZS1i
dWZmZXJpbmcgbWVjaGFuaXNtIHRvIGFjaGlldmUgdGhhdC4gQW5kIGluIHZob3N0LXZkcGEgY2Fz
ZSwgdGhlIGRtYQo+ID4gPiA+ID4gYnVmZmVyIGlzIHJlc2lkZSBpbiBhIHVzZXJzcGFjZSBtZW1v
cnkgcmVnaW9uIHdoaWNoIGNhbiBiZSBzaGFyZWQgdG8gdGhlCj4gPiA+ID4gPiBWRFVTRSB1c2Vy
c3BhY2UgcHJvY2Vzc3MgdmlhIHRyYW5zZmVycmluZyB0aGUgc2htZmQuCj4gPiA+ID4gPgo+ID4g
PiA+ID4gVGhlIGRldGFpbHMgYW5kIG91ciB1c2VyIGNhc2UgaXMgc2hvd24gYmVsb3c6Cj4gPiA+
ID4gPgo+ID4gPiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICAgIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0gICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4gPiA+ID4gPiB8ICAgICAgICAgICAgQ29udGFpbmVyIHwgICAgfCAgICAgICAgICAgICAg
UUVNVShWTSkgfCAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVkRVU0UgZGFlbW9u
IHwKPiA+ID4gPiA+IHwgICAgICAgLS0tLS0tLS0tICAgICAgfCAgICB8ICAtLS0tLS0tLS0tLS0t
LS0tLS0tICB8ICAgfCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIC0tLS0tLS0tLS0tLS0tLS0g
fAo+ID4gPiA+ID4gfCAgICAgICB8ZGV2L3ZkeHwgICAgICB8ICAgIHwgIHwvZGV2L3Zob3N0LXZk
cGEteHwgIHwgICB8IHwgdkRQQSBkZXZpY2UgZW11bGF0aW9uIHwgfCBibG9jayBkcml2ZXIgfCB8
Cj4gPiA+ID4gPiAtLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0gICAgIC0tLS0tLS0tLS0tKy0tLS0t
LS0tLS0tLSAgIC0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0K
PiA+ID4gPiA+ICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgfAo+ID4gPiA+ID4g
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICB8Cj4gPiA+ID4gPiAtLS0tLS0tLS0t
LS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0KPiA+ID4gPiA+IHwgICAgfCBibG9j
ayBkZXZpY2UgfCAgICAgICAgICAgfCAgdmhvc3QgZGV2aWNlIHwgICAgICAgICAgICB8IHZkdXNl
IGRyaXZlciB8ICAgICAgICAgIHwgVENQL0lQIHwgICAgfAo+ID4gPiA+ID4gfCAgICAtLS0tLS0t
Ky0tLS0tLS0tICAgICAgICAgICAtLS0tLS0tLSstLS0tLS0tLSAgICAgICAgICAgIC0tLS0tLS0r
LS0tLS0tLS0gICAgICAgICAgLS0tLS0rLS0tLSAgICB8Cj4gPiA+ID4gPiB8ICAgICAgICAgICB8
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgIHwKPiA+ID4gPiA+IHwgLS0tLS0tLS0tLSst
LS0tLS0tLS0tICAgICAgIC0tLS0tLS0tLS0rLS0tLS0tLS0tLS0gICAgICAgICAtLS0tLS0tKy0t
LS0tLS0gICAgICAgICAgICAgICAgfCAgICAgICAgfAo+ID4gPiA+ID4gfCB8IHZpcnRpby1ibGsg
ZHJpdmVyIHwgICAgICAgfCAgdmhvc3QtdmRwYSBkcml2ZXIgfCAgICAgICAgIHwgdmRwYSBkZXZp
Y2UgfCAgICAgICAgICAgICAgICB8ICAgICAgICB8Cj4gPiA+ID4gPiB8IC0tLS0tLS0tLS0rLS0t
LS0tLS0tLSAgICAgICAtLS0tLS0tLS0tKy0tLS0tLS0tLS0tICAgICAgICAgLS0tLS0tLSstLS0t
LS0tICAgICAgICAgICAgICAgIHwgICAgICAgIHwKPiA+ID4gPiA+IHwgICAgICAgICAgIHwgICAg
ICB2aXJ0aW8gYnVzICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgfCAgICAgICAgfAo+ID4gPiA+ID4gfCAgIC0tLS0tLS0tKy0tLS0r
LS0tLS0tLS0tLS0gICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgICAgICB8Cj4gPiA+ID4gPiB8ICAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAgICAgIHwKPiA+ID4gPiA+IHwgICAgICAtLS0tLS0tLS0tKy0t
LS0tLS0tLS0gICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgfCAgICAgICAgfAo+ID4gPiA+ID4gfCAgICAgIHwgdmlydGlvLWJsayBk
ZXZpY2UgfCAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgICAgICB8Cj4gPiA+ID4gPiB8ICAgICAgLS0tLS0tLS0tLSstLS0t
LS0tLS0tICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAgICAgIHwKPiA+ID4gPiA+IHwgICAgICAgICAgICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgICAgfCAgICAgICAgfAo+ID4gPiA+ID4gfCAgICAgLS0tLS0tLS0tLS0rLS0tLS0t
LS0tLS0gICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgICAgICB8Cj4gPiA+ID4gPiB8ICAgICB8ICB2aXJ0aW8tdmRwYSBkcml2
ZXIgfCAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAg
ICAgICAgICAgIHwgICAgICAgIHwKPiA+ID4gPiA+IHwgICAgIC0tLS0tLS0tLS0tKy0tLS0tLS0t
LS0tICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgfCAgICAgICAgfAo+ID4gPiA+ID4gfCAgICAgICAgICAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIHZkcGEgYnVzICAg
ICAgICAgICB8ICAgICAgICB8Cj4gPiA+ID4gPiB8ICAgICAtLS0tLS0tLS0tLSstLS0tLS0tLS0t
LS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0gICAg
ICAgICAgIHwgICAgICAgIHwKPiA+ID4gPiA+IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLS0tKy0tLSAgICAgfAo+ID4gPiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS18IE5JQyB8LS0tLS0tCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC0tLSstLS0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfAo+
ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLS0tLS0tLS0rLS0tLS0tLS0tCj4g
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgUmVtb3RlIFN0b3JhZ2VzIHwKPiA+
ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4g
PiA+ID4KPiA+ID4gPiA+IFdlIG1ha2UgdXNlIG9mIGl0IHRvIGltcGxlbWVudCBhIGJsb2NrIGRl
dmljZSBjb25uZWN0aW5nIHRvCj4gPiA+ID4gPiBvdXIgZGlzdHJpYnV0ZWQgc3RvcmFnZSwgd2hp
Y2ggY2FuIGJlIHVzZWQgYm90aCBpbiBjb250YWluZXJzIGFuZAo+ID4gPiA+ID4gVk1zLiBUaHVz
LCB3ZSBjYW4gaGF2ZSBhbiB1bmlmaWVkIHRlY2hub2xvZ3kgc3RhY2sgaW4gdGhpcyB0d28gY2Fz
ZXMuCj4gPiA+ID4gPgo+ID4gPiA+ID4gVG8gdGVzdCBpdCB3aXRoIG51bGwtYmxrOgo+ID4gPiA+
ID4KPiA+ID4gPiA+ICAgJCBxZW11LXN0b3JhZ2UtZGFlbW9uIFwKPiA+ID4gPiA+ICAgICAgIC0t
Y2hhcmRldiBzb2NrZXQsaWQ9Y2hhcm1vbml0b3IscGF0aD0vdG1wL3FtcC5zb2NrLHNlcnZlcixu
b3dhaXQgXAo+ID4gPiA+ID4gICAgICAgLS1tb25pdG9yIGNoYXJkZXY9Y2hhcm1vbml0b3IgXAo+
ID4gPiA+ID4gICAgICAgLS1ibG9ja2RldiBkcml2ZXI9aG9zdF9kZXZpY2UsY2FjaGUuZGlyZWN0
PW9uLGFpbz1uYXRpdmUsZmlsZW5hbWU9L2Rldi9udWxsYjAsbm9kZS1uYW1lPWRpc2swIFwKPiA+
ID4gPiA+ICAgICAgIC0tZXhwb3J0IHR5cGU9dmR1c2UtYmxrLGlkPXRlc3Qsbm9kZS1uYW1lPWRp
c2swLHdyaXRhYmxlPW9uLG5hbWU9dmR1c2UtbnVsbCxudW0tcXVldWVzPTE2LHF1ZXVlLXNpemU9
MTI4Cj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhlIHFlbXUtc3RvcmFnZS1kYWVtb24gY2FuIGJlIGZv
dW5kIGF0IGh0dHBzOi8vZ2l0aHViLmNvbS9ieXRlZGFuY2UvcWVtdS90cmVlL3ZkdXNlCj4gPiA+
ID4KPiA+ID4gPiBJdCdzIGJlZW4gaGFsZiBhIHllYXIgLSBhbnkgcGxhbnMgdG8gdXBzdHJlYW0g
dGhpcz8KPiA+ID4KPiA+ID4gWWVhaCwgdGhpcyBpcyBvbiBteSB0by1kbyBsaXN0IHRoaXMgbW9u
dGguCj4gPiA+Cj4gPiA+IFNvcnJ5IGZvciB0YWtpbmcgc28gbG9uZy4uLiBJJ3ZlIGJlZW4gd29y
a2luZyBvbiBhbm90aGVyIHByb2plY3QKPiA+ID4gZW5hYmxpbmcgdXNlcnNwYWNlIFJETUEgd2l0
aCBWRFVTRSBmb3IgdGhlIHBhc3QgZmV3IG1vbnRocy4gU28gSQo+ID4gPiBkaWRuJ3QgaGF2ZSBt
dWNoIHRpbWUgZm9yIHRoaXMuIEFueXdheSwgSSB3aWxsIHN1Ym1pdCB0aGUgZmlyc3QKPiA+ID4g
dmVyc2lvbiBhcyBzb29uIGFzIHBvc3NpYmxlLgo+ID4gPgo+ID4gPiBUaGFua3MsCj4gPiA+IFlv
bmdqaQo+ID4KPiA+IE9oIGZ1bi4gWW91IG1lYW4gbGlrZSB2aXJ0aW8tcmRtYT8gT3IgUkRNQSBh
cyBhIGJhY2tlbmQgZm9yIHJlZ3VsYXIKPiA+IHZpcnRpbz8KPiA+Cj4gCj4gWWVzLCBsaWtlIHZp
cnRpby1yZG1hLiBUaGVuIHdlIGNhbiBkZXZlbG9wIHNvbWV0aGluZyBsaWtlIHVzZXJzcGFjZQo+
IHJ4ZeOAgXNpdyBvciBjdXN0b20gcHJvdG9jb2wgd2l0aCBWRFVTRS4KPiAKPiBUaGFua3MsCj4g
WW9uZ2ppCgpXb3VsZCBiZSBpbnRlcmVzdGluZyB0byBzZWUgdGhlIHNwZWMgZm9yIHRoYXQuClRo
ZSBpc3N1ZXMgd2l0aCBSRE1BIHJldm9sdmVkIGFyb3VuZCB0aGUgZmFjdCB0aGF0IGN1cnJlbnQK
YXBwcyB0ZW5kIHRvIGVpdGhlciB1c2Ugbm9uLXN0YW5kYXJkIHByb3BvY29scyBmb3IgY29ubmVj
dGlvbgplc3RhYmxpc2htZW50IG9yIHVzZSBVRCB3aGVyZSB0aGVyZSdzIElJUkMgbm8gc3RhbmRh
cmQKYXQgYWxsLiBTbyBRUCBudW1iZXJzIGFyZSBoYXJkIHRvIHZpcnR1YWxpemUuClNpbWlsYXJs
eSBtYW55IHVzZSBMSURzIGRpcmVjdGx5IHdpdGggdGhlIHNhbWUgZWZmZWN0LgpHVUlEcyBtaWdo
dCBiZSB2aXJ0dWFsaXplYWJsZSBidXQgbm8gb25lIHdlbnQgdG8gdGhlIGVmZm9ydC4KClRvIHNh
eSBub3RoaW5nIGFib3V0IHRoZSBpbnRlcmFjdGlvbiB3aXRoIG1lbW9yeSBvdmVyY29tbWl0LgoK
LS0gCk1TVAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
