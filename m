Return-Path: <SRS0=GMN+=KG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11089C433B4
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 08:50:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE3661921
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 08:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE3661921
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2373240E84;
	Tue, 11 May 2021 08:50:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wigVSvPha5We; Tue, 11 May 2021 08:50:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8475040E85;
	Tue, 11 May 2021 08:50:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AB63C0025;
	Tue, 11 May 2021 08:50:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5406C0001;
 Tue, 11 May 2021 08:50:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9FE8140E7D;
 Tue, 11 May 2021 08:50:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XbzQaMJ1LDhM; Tue, 11 May 2021 08:50:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D58EE405F8;
 Tue, 11 May 2021 08:50:17 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1D90C67373; Tue, 11 May 2021 10:50:12 +0200 (CEST)
Date: Tue, 11 May 2021 10:50:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/ttm: use dma_alloc_pages for the page pool
Message-ID: <20210511085011.GA14477@lst.de>
References: <20210511060514.3956745-1-hch@lst.de>
 <20210511060514.3956745-2-hch@lst.de>
 <d2a72848-8273-d0b6-0250-3fe88122246a@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d2a72848-8273-d0b6-0250-3fe88122246a@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@linux.ie>, Roland Scheidegger <sroland@vmware.com>,
 dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, Huang Rui <ray.huang@amd.com>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
 nouveau@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Dave Airlie <airlied@redhat.com>, spice-devel@lists.freedesktop.org,
 Christoph Hellwig <hch@lst.de>, Zack Rusin <zackr@vmware.com>
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

T24gVHVlLCBNYXkgMTEsIDIwMjEgYXQgMDk6MzU6MjBBTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBXZSBjZXJ0YWlubHkgZ29pbmcgdG8gbmVlZCB0aGUgZHJtX25lZWRfc3dpb3Rs
YigpIGZvciB1c2VycHRyIHN1cHBvcnQgCj4gKHVubGVzcyB3ZSBhZGQgc29tZSBhcHByb2FjaCBm
b3IgZHJpdmVycyB0byBvcHQgb3V0IG9mIHN3aW90bGIpLgoKc3dpb3RsYiB1c2UgaXMgZHJpdmVu
IGJ5IHRocmVlIHRoaW5nczoKCiAxKSBhZGRyZXNzaW5nIGxpbWl0YXRpb25zIG9mIHRoZSBkZXZp
Y2UKIDIpIGFkZHJlc3NpbmcgbGltaXRhdGlvbnMgb2YgdGhlIGludGVyY29ubmVjdAogMykgdmly
dHVhbGl6dGlvbiBtb2RlcyB0aGF0IHJlcXVpcmUgaXQKCm5vdCBzdXJlIGhvdyB0aGUgZHJpdmVy
IGNvdWxkIG9wdCBvdXQuICBXaGF0IGlzIHRoZSBwcm9ibGVtIHdpdGggdXNlcnB0cgpzdXBwb3J0
PwoKPiBUaGVuIHdoaWxlIEkgcmVhbGx5IHdhbnQgdG8gZ2V0IHJpZCBvZiBHRlBfRE1BMzIgYXMg
d2VsbCBJJ20gbm90IDEwMCUgc3VyZSAKPiBpZiB3ZSBjYW4gaGFuZGxlIHRoaXMgd2l0aG91dCB0
aGUgZmxhZy4KCk5vdGUgdGhhdCB0aGlzIGlzIHN0aWxsIHVzaW5nIEdGUF9ETUEzMiB1bmRlcm5l
YXRoIHdoZXJlIHJlcXVpcmVkLApqdXN0IGluIGEgbGF5ZXIgdGhhdCBjYW4gZGVjaWRlIHRoYXQg
0ZVlbnNpYmx5LgoKPiBBbmQgbGFzdCB3ZSBuZWVkIHNvbWV0aGluZyBiZXR0ZXIgdG8gc3RvcmUg
dGhlIERNQSBhZGRyZXNzIGFuZCBvcmRlciB0aGFuIAo+IGFsbG9jYXRpbmcgYSBzZXBhcmF0ZSBt
ZW1vcnkgb2JqZWN0IGZvciBlYWNoIHBhZ2UuCgpZZWFoLiAgSWYgeW91IHVzZSBfX0dGUF9DT01Q
IGZvciB0aGUgYWxsb2NhdGlvbnMgd2UgY2FuIGZpbmQgdGhlIG9yZGVyCmZyb20gdGhlIHBhZ2Ug
aXRzZWxmLCB3aGljaCBtaWdodCBiZSB1c2VmdWwuICBGb3IgNjQtYml0IHBsYXRmb3Jtcwp0aGUg
ZG1hIGFkZHJlc3MgY291bGQgYmUgc3RvcmUgaW4gcGFnZS0+cHJpdmF0ZSwgb3IgZGVwZW5kaW5n
IG9uIGhvdwp0aGUgcGFnZSBnZXRzIHVzZWQgdGhlIGRtYV9hZGRyIGZpZWxkIGluIHN0cnVjdCBw
YWdlIHRoYXQgb3ZlcmxvYWRzCnRoZSBscnUgZmllbGQgYW5kIGlzIHVzZWQgYnkgdGhlIG5ldHdv
cmtpbmcgcGFnZSBwb29sIGNvdWxkIGJlIHVzZWQuCgpNYXliZSB3ZSBjb3VsZCBldmVuIGhhdmUg
YSBjb21tb24gcGFnZSBwb29sIGJldHdlZW4gbmV0IGFuZCBkcm0sIGJ1dApJIGRvbid0IHdhbnQg
dG8gZ28gdGhlcmUgbXlzZWxmLCBub3QgYmVpbmcgYW4gZXhwZXJ0IG9uIGVpdGhlciBzdWJzeXN0
ZW0uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
