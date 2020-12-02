Return-Path: <SRS0=DI2N=FG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8702C6369E
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 22:00:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05D8C22203
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 22:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D8C22203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4665587377;
	Wed,  2 Dec 2020 22:00:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W5WIzP-twNep; Wed,  2 Dec 2020 22:00:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 669878730F;
	Wed,  2 Dec 2020 22:00:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49EA7C0FA8;
	Wed,  2 Dec 2020 22:00:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EC63C0FA7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 22:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3031B8730F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 22:00:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BkoJbXjcR2fk
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 22:00:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4B91686E5C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606946433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+mgQhA2o4decZhuJk4kraIyyghNyU3KxHcdGPG8L0FI=;
 b=Hpyj+UUAKMG2wOkLPKJ3EmXJlvutgG2Y3Ct30rNPv8r/uRgPDVoOKaTqvzg48NeV9OO3Fb
 qAtEkG4u0S5RbN2CtGuMATlxBaYjckQhQPDty9HU7SRlhIxhQ9MHK5A7xuta137ZUXqAsg
 rAvRfkbuk+8pZi4VAdznd9dpg74K8BY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-cBPS2IihOyGVKmPGzMWRRw-1; Wed, 02 Dec 2020 17:00:28 -0500
X-MC-Unique: cBPS2IihOyGVKmPGzMWRRw-1
Received: by mail-wm1-f72.google.com with SMTP id r5so273283wma.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Dec 2020 14:00:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=+mgQhA2o4decZhuJk4kraIyyghNyU3KxHcdGPG8L0FI=;
 b=Ud8W8ffoSJihw2Zr6HRz2mS+HOzrzh/uA0awovtvHETS9IaKpDwOoZQwt123Hg2MJ2
 5p3PM9gLWsUEMDMwZIYlQa0lXJ7j2RfK0uQe7C8fyTBZ231IAddbZXvRDdzUu+M2eqQz
 BBXVIkCH4D9cleDKd9upqvfI8fLTHK5bUJmN8DPUblwzES7vTFBomjqZaYfogj6KC78k
 pr+ZJ7ndz4iK22zdk/vyoJcs4nCKI/53TskNraVCswAEOp4QviJr3u05au83yZhnXrzA
 dN2uMc9QxAd8x39TFGEkzAVRA6N0GCOspcxRK5mVVxmGoRtfcd56/HJg0MjeQPU4wxsl
 XxrQ==
X-Gm-Message-State: AOAM532yEbkSUb5hBCsysIeyg2iE79vmUwsj/wHMQNURGseSPVmzsZ59
 VFft9FQNa59pmW8GjPs5xPjTAjwDq2Hjo19t7DnKrvuKLWWQQOEVOuu3MVbLXoEer9NIcI7pJ4Q
 UbAHWiFqppboCnNi0wid9yy3+v1lWlE4NOmkvvjFZeA==
X-Received: by 2002:a1c:9ecf:: with SMTP id h198mr57196wme.104.1606946427221; 
 Wed, 02 Dec 2020 14:00:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxF95JQh5iC1sPJmk3A5wyLf0qbaVlCIvoCNnL7gkjsiBsLQdflO0b44GTd0LEtQu/64S8AbA==
X-Received: by 2002:a1c:9ecf:: with SMTP id h198mr57179wme.104.1606946426950; 
 Wed, 02 Dec 2020 14:00:26 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id q17sm10042wro.36.2020.12.02.14.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Dec 2020 14:00:25 -0800 (PST)
Date: Wed, 2 Dec 2020 17:00:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201202165932-mutt-send-email-mst@kernel.org>
References: <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
 <20201130103142-mutt-send-email-mst@kernel.org>
 <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
 <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
 <20201202055714.GA224423@mtl-vdi-166.wap.labs.mlnx>
 <20201202041518-mutt-send-email-mst@kernel.org>
 <3e32ef6d-83c9-5866-30e5-f6eeacd5044d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3e32ef6d-83c9-5866-30e5-f6eeacd5044d@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>, linux-kernel@vger.kernel.org,
 Cindy Lu <lulu@redhat.com>, virtualization@lists.linux-foundation.org
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

T24gV2VkLCBEZWMgMDIsIDIwMjAgYXQgMDk6NDg6MjVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzEyLzIg5LiL5Y2INToyMywgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gV2VkLCBEZWMgMDIsIDIwMjAgYXQgMDc6NTc6MTRBTSArMDIwMCwgRWxpIENvaGVu
IHdyb3RlOgo+ID4gPiBPbiBXZWQsIERlYyAwMiwgMjAyMCBhdCAxMjoxODozNlBNICswODAwLCBK
YXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+IE9uIDIwMjAvMTIvMSDkuIvljYg1OjIzLCBDaW5keSBM
dSB3cm90ZToKPiA+ID4gPiA+IE9uIE1vbiwgTm92IDMwLCAyMDIwIGF0IDExOjMzIFBNIE1pY2hh
ZWwgUy4gVHNpcmtpbjxtc3RAcmVkaGF0LmNvbT4gIHdyb3RlOgo+ID4gPiA+ID4gPiBPbiBNb24s
IE5vdiAzMCwgMjAyMCBhdCAwNjo0MTo0NVBNICswODAwLCBDaW5keSBMdSB3cm90ZToKPiA+ID4g
PiA+ID4gPiBPbiBNb24sIE5vdiAzMCwgMjAyMCBhdCA1OjMzIFBNIE1pY2hhZWwgUy4gVHNpcmtp
bjxtc3RAcmVkaGF0LmNvbT4gIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gT24gTW9uLCBOb3YgMzAs
IDIwMjAgYXQgMTE6Mjc6NTlBTSArMDIwMCwgRWxpIENvaGVuIHdyb3RlOgo+ID4gPiA+ID4gPiA+
ID4gPiBPbiBNb24sIE5vdiAzMCwgMjAyMCBhdCAwNDowMDo1MUFNIC0wNTAwLCBNaWNoYWVsIFMu
IFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gT24gTW9uLCBOb3YgMzAsIDIwMjAg
YXQgMDg6Mjc6NDZBTSArMDIwMCwgRWxpIENvaGVuIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gT24gU3VuLCBOb3YgMjksIDIwMjAgYXQgMDM6MDg6MjJQTSAtMDUwMCwgTWljaGFlbCBTLiBU
c2lya2luIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBTdW4sIE5vdiAyOSwgMjAy
MCBhdCAwODo0Mzo1MUFNICswMjAwLCBFbGkgQ29oZW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gV2Ugc2hvdWxkIG5vdCB0cnkgdG8gdXNlIHRoZSBWRiBNQUMgYWRkcmVzcyBhcyB0
aGF0IGlzIHVzZWQgYnkgdGhlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gcmVndWxhciAoZS5n
LiBtbHg1X2NvcmUpIE5JQyBpbXBsZW1lbnRhdGlvbi4gSW5zdGVhZCwgdXNlIGEgcmFuZG9tCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gZ2VuZXJhdGVkIE1BQyBhZGRyZXNzLgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFN1Z2dlc3RlZCBieTog
Q2luZHkgTHU8bHVsdUByZWRoYXQuY29tPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEZpeGVz
OiAxYTg2YjM3N2FhMjEgKCJ2ZHBhL21seDU6IEFkZCBWRFBBIGRyaXZlciBmb3Igc3VwcG9ydGVk
IG1seDUgZGV2aWNlcyIpCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
RWxpIENvaGVuPGVsaWNAbnZpZGlhLmNvbT4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gSSBkaWRu
J3QgcmVhbGlzZSBpdCdzIHBvc3NpYmxlIHRvIHVzZSBWRiBpbiB0d28gd2F5cwo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiB3aXRoIGFuZCB3aXRob3V0IHZkcGEuCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiBVc2luZyBhIFZGIHlvdSBjYW4gY3JlYXRlIHF1aXRlIGEgZmV3IHJlc291cmNlcywgZS5nLiBz
ZW5kIHF1ZXVlcwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gcmVjaWV2ZSBxdWV1ZXMsIHZpcnRpb19u
ZXQgcXVldWVzIGV0Yy4gU28geW91IGNhbiBwb3NzaWJseSBjcmVhdGUKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IHNldmVyYWwgaW5zdGFuY2VzIG9mIHZkcGEgbmV0IGRldmljZXMgYW5kIG5pYyBuZXQg
ZGV2aWNlcy4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBD
b3VsZCB5b3UgaW5jbHVkZSBhIGJpdCBtb3JlIGRlc2NyaXB0aW9uIG9uIHRoZSBmYWlsdXJlCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IG1vZGU/Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBXZWxsLCB1
c2luZyB0aGUgTUFDIGFkZHJlc3Mgb2YgdGhlIG5pYyB2cG9ydCBpcyB3cm9uZyBzaW5jZSB0aGF0
IGlzIHRoZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gTUFDIG9mIHRoZSByZWd1bGFyIE5JQyBpbXBs
ZW1lbnRhdGlvbiBvZiBtbHg1X2NvcmUuCj4gPiA+ID4gPiA+ID4gPiA+ID4gUmlnaHQgYnV0IEFU
TSBpdCBkb2Vzbid0IGNvZXhpc3Qgd2l0aCB2ZHBhIHNvIHdoYXQncyB0aGUgcHJvYmxlbT8KPiA+
ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gVGhpcyBjYWxsIGlzIHdyb25nOiAg
bWx4NV9xdWVyeV9uaWNfdnBvcnRfbWFjX2FkZHJlc3MoKQo+ID4gPiA+ID4gPiA+ID4gPiAKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gSXMgc3dpdGNoaW5nIHRvIGEgcmFuZG9tIG1hYyBmb3Igc3Vj
aCBhbiB1bnVzdWFsCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGNvbmZpZ3VyYXRpb24gcmVhbGx5
IGp1c3RpZmllZD8KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNpbmNlIEkgY2FuJ3QgdXNlIHRoZSBO
SUMncyBNQUMgYWRkcmVzcywgSSBoYXZlIHR3byBvcHRpb25zOgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gMS4gVG8gZ2V0IHRoZSBNQUMgYWRkcmVzcyBhcyB3YXMgY2hvc2VuIGJ5IHRoZSB1c2VyIGFk
bWluaXN0ZXJpbmcgdGhlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgIE5JQy4gVGhpcyBzaG91
bGQgaW52b2tlIHRoZSBzZXRfY29uZmlnIGNhbGxiYWNrLiBVbmZvcnR1bmF0ZWx5IHRoaXMKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgaXMgbm90IGltcGxlbWVudGVkIHlldC4KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gMi4gVXNlIGEgcmFuZG9tIE1BQyBh
ZGRyZXNzLiBUaGlzIGlzIE9LIHNpbmNlIGlmICgxKSBpcyBpbXBsZW1lbnRlZCBpdAo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gICAgICBjYW4gYWx3YXlzIG92ZXJyaWRlIHRoaXMgcmFuZG9tIGNvbmZp
Z3VyYXRpb24uCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
SXQgbG9va3MgbGlrZSBjaGFuZ2luZyBhIE1BQyBjb3VsZCBicmVhayBzb21lIGd1ZXN0cywKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gY2FuIGl0IG5vdD8KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBObywgaXQgd2lsbCBub3QuIFRoZSBjdXJyZW50IHZlcnNp
b24gb2YgbWx4NSBWRFBBIGRvZXMgbm90IGFsbG93IHJlZ3VsYXIKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IE5JQyBkcml2ZXIgYW5kIFZEUEEgdG8gY28tZXhpc3QuIEkgaGF2ZSBwYXRjaGVzIHJlYWR5
IHRoYXQgZW5hYmxlIHRoYXQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGZyb20gc3RlZXJpbmcgcG9p
bnQgb2Ygdmlldy4gSSB3aWxsIHBvc3QgdGhlbSBoZXJlIG9uY2Ugb3RoZXIgcGF0Y2hlcyBvbgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gd2hpY2ggdGhleSBkZXBlbmQgd2lsbCBiZSBtZXJnZWQuCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGh0dHBzOi8vcGF0Y2h3
b3JrLm96bGFicy5vcmcvcHJvamVjdC9uZXRkZXYvcGF0Y2gvMjAyMDExMjAyMzAzMzkuNjUxNjA5
LTEyLXNhZWVkbUBudmlkaWEuY29tLwo+ID4gPiA+ID4gPiA+ID4gPiA+IENvdWxkIHlvdSBiZSBt
b3JlIGV4cGxpY2l0IG9uIHRoZSBmb2xsb3dpbmcgcG9pbnRzOgo+ID4gPiA+ID4gPiA+ID4gPiA+
IC0gd2hpY2ggY29uZmlndXJhdGlvbiBpcyBicm9rZW4gQVRNIChhcyBpbiwgdHdvIGRldmljZSBo
YXZlIGlkZW50aWNhbAo+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICBtYWNzPyBhbnkgb3RoZXIgaXNz
dWVzKT8KPiA+ID4gPiA+ID4gPiA+ID4gVGhlIG9ubHkgd3JvbmcgdGhpbmcgaXMgdGhlIGNhbGwg
dG8gIG1seDVfcXVlcnlfbmljX3Zwb3J0X21hY19hZGRyZXNzKCkuCj4gPiA+ID4gPiA+ID4gPiA+
IEl0J3Mgbm90IGJyZWFraW5nIGFueXRoaW5nIHlldCBpcyB3cm9uZy4gVGhlIHJhbmRvbSBNQUMg
YWRkcmVzcyBzZXR0aW5nCj4gPiA+ID4gPiA+ID4gPiA+IGlzIHJlcXVpcmVkIGZvciB0aGUgc3Rl
ZXJpbmcgcGF0Y2hlcy4KPiA+ID4gPiA+ID4gPiA+IE9rYXkgc28gSSdtIG5vdCBzdXJlIHRoZSBG
aXhlcyB0YWcgYXQgbGVhc3QgaXMgYXBwcm9wcmlhdGUgaWYgaXQncyBhCj4gPiA+ID4gPiA+ID4g
PiBkZXBlbmRlbmN5IG9mIGEgbmV3IGZlYXR1cmUuCj4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+
ID4gPiA+ID4gPiAtIHdoeSB3b24ndCBkZXZpY2UgTUFDIGNoYW5nZSBmcm9tIGd1ZXN0IHBvaW50
IG9mIHZpZXc/Cj4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+IEl0J3MgbGFj
ayBvZiBpbXBsZW1lbnRhdGlvbiBpbiBxZW11IGFzIGZhciBhcyBJIGtub3cuCj4gPiA+ID4gPiA+
ID4gPiBTb3JyeSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQuIFdoYXQncyBub3QgaW1wbGVtZW50ZWQg
aW4gUUVNVT8KPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IEhJIE1pY2hhZWwsIHRoZXJl
IGFyZSBzb21lIGJ1ZyBpbiBxZW11IHRvIHNldF9jb25maWcsIHRoaXMgd2lsbCBmaXggaW4gZnV0
dXJlLAo+ID4gPiA+ID4gPiA+IEJ1dCB0aGlzIHBhdGNoIGlzIHN0aWxsIG5lZWRlZCwgYmVjYXVz
ZSB3aXRob3V0IHRoaXMgcGF0Y2ggdGhlIG1seAo+ID4gPiA+ID4gPiA+IGRyaXZlciB3aWxsIGdp
dmUgYW4gMCBtYWMgYWRkcmVzcyB0byBxZW11Cj4gPiA+ID4gPiA+ID4gYW5kIHFlbXUgd2lsbCBv
dmVyd3JpdGUgdGhlIGRlZmF1bHQgbWFjIGFkZHJlc3MuICBUaGlzIHdpbGwgY2F1c2UgdHJhZmZp
YyBkb3duLgo+ID4gPiA+ID4gPiBIbW0gdGhlIHBhdGNoIGRlc2NyaXB0aW9uIHNheXMgVkYgbWFj
IGFkZHJlc3MsIG5vdCAwIGFkZHJlc3MuIENvbmZ1c2VkLgo+ID4gPiA+ID4gPiBJZiB0aGVyZSdz
IG5vIG1hYyB3ZSBjYW4gY2xlYXIgVklSVElPX05FVF9GX01BQyBhbmQgaGF2ZSBndWVzdAo+ID4g
PiA+ID4gPiB1c2UgYSByYW5kb20gdmFsdWUgLi4uCj4gPiA+ID4gSSdtIG5vdCBzdXJlIHRoaXMg
Y2FuIHdvcmsgZm9yIGFsbCB0eXBlcyBvZiB2RFBBIChlLmcgaXQgY291bGQgbm90IGJlIGEKPiA+
ID4gPiBsZWFybmluZyBicmlkZ2UgaW4gdGhlIHN3dGljaCkuCj4gPiA+ID4gCj4gPiA+ID4gCj4g
PiA+ID4gPiBoaSBNaWNoYWVs77yMCj4gPiA+ID4gPiBJIGhhdmUgdHJpZWQgYXMgeW91ciBzdWdn
ZXN0aW9uLCBzZWVtcyBldmVuIHJlbW92ZSB0aGUKPiA+ID4gPiA+IFZJUlRJT19ORVRfRl9NQUMg
dGhlIHFlbXUgd2lsbCBzdGlsbCBjYWxsIGdldF9jaW5maWcgYW5kIG92ZXJ3cml0ZSB0aGUKPiA+
ID4gPiA+IGRlZmF1bHQgYWRkcmVzcyBpbiAgVk0sCj4gPiA+ID4gVGhpcyBsb29rcyBhIGJ1ZyBp
biBxZW11LCBpbiBndWVzdCBkcml2ZXIgd2UgaGFkOgo+ID4gPiA+IAo+ID4gPiA+ICDCoMKgwqAg
LyogQ29uZmlndXJhdGlvbiBtYXkgc3BlY2lmeSB3aGF0IE1BQyB0byB1c2UuwqAgT3RoZXJ3aXNl
IHJhbmRvbS4gKi8KPiA+ID4gPiAgwqDCoMKgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwg
VklSVElPX05FVF9GX01BQykpCj4gPiA+ID4gIMKgwqDCoCDCoMKgwqAgdmlydGlvX2NyZWFkX2J5
dGVzKHZkZXYsCj4gPiA+ID4gIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgIG9mZnNl
dG9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZywgbWFjKSwKPiA+ID4gPiAgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIMKgwqAgZGV2LT5kZXZfYWRkciwgZGV2LT5hZGRyX2xlbik7Cj4gPiA+
ID4gIMKgwqDCoCBlbHNlCj4gPiA+ID4gIMKgwqDCoCDCoMKgwqAgZXRoX2h3X2FkZHJfcmFuZG9t
KGRldik7Cj4gPiA+ID4gCj4gPiA+ID4gCj4gPiA+ID4gPiB0aGlzIHByb2Nlc3MgaXMgbGlrZQo+
ID4gPiA+ID4gdmRwYSBfaW5pdCAtLT5xZW11IGNhbGwgZ2V0X2NvbmZpZyAtPm1seCBkcml2ZXIg
d2lsbCBnaXZlICBhbiBtYWMKPiA+ID4gPiA+IGFkZHJlc3Mgd2l0aCBhbGwgMC0tPgo+ID4gPiA+
ID4gcWVtdSB3aWxsIG5vdCBjaGVjayB0aGlzIG1hYyBhZGRyZXNzIGFuZCB1c2UgaXQgLS0+IG92
ZXJ3cml0ZSB0aGUgbWFjCj4gPiA+ID4gPiBhZGRyZXNzIGluIHFlbXUKPiA+ID4gPiA+IAo+ID4g
PiA+ID4gU28gZm9yIG15IHVuZGVyc3RhbmRpbmcgdGhlcmUgYXJlIHNldmVyYWwgbWV0aG9kIHRv
IGZpeCB0aGlzIHByb2JsZW0KPiA+ID4gPiA+IAo+ID4gPiA+ID4gMSwgcWVtdSBjaGVjayB0aGUg
bWFjIGFkZHJlc3MsIGlmIHRoZSBtYWMgYWRkcmVzcyBpcyBhbGwgMCwgcWVtdSB3aWxsCj4gPiA+
ID4gPiBpZ25vcmUgaXQgYW5kIHNldCB0aGUgcmFuZG9tIG1hYyBhZGRyZXNzIHRvIG1seCBkcml2
ZXIuCj4gPiA+ID4gU28gbXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0LCBpZiBtYWMgYWRkcmVzcyBp
cyBhbGwgMCwgdkRQQSBwYXJlbnQgc2hvdWxkIG5vdAo+ID4gPiA+IGFkdmVydGlzZSBWSVJUSU9f
TkVUX0ZfTUFDLiBBbmQgcWVtdSBzaG91bGQgZW11bGF0ZSB0aGlzIGZlYXR1cmUgYXMgeW91IGRp
ZDoKPiA+ID4gVGhpbmtpbmcgaXQgb3ZlciwgYXQgbGVhc3QgaW4gbWx4NSwgSSBzaG91bGQgYWx3
YXlzIGFkdmVydGlzZQo+ID4gPiBWSVJUSU9fTkVUX0ZfTUFDIGFuZCBzZXQgYSBub24gemVybyBN
QUMgdmFsdWUuIFRoZSBzb3VyY2Ugb2YgdGhlIE1BQyBjYW4KPiA+ID4gYmUgZWl0aGVyIHJhbmRv
bWx5IGdlbmVyYXRlZCB2YWx1ZSBieSBtbHg1X3ZkcGEgb3IgYnkgYSBtYW5hZ2VtZW50IHRvb2wu
Cj4gPiA+IFRoaXMgaXMgaW1wb3J0YW50IGJlY2F1YXNlIHdlIHNob3VsZCBub3QgbGV0IHRoZSBW
TSBtb2RpZnkgdGhlIE1BQy4gSWYKPiA+ID4gd2UgZG8gaXQgY2FuIHNldCBhIE1BQyB2YWx1ZSBp
ZGVudGljYWwgdG8gdGhlIG1seDUgTklDIGRyaXZlciBhbmQgY2FuCj4gPiA+IGtpZG5hcCB0cmFm
ZmljIHRoYXQgd2FzIG5vdCBkZXN0aW5lZCB0byBpdC4KPiA+ID4gCj4gPiA+IEluIGFkZGl0aW9u
LCB3aGVuIFZJUlRJT19ORVRfRl9NQUMgaXMgcHVibGlzaGVkLCBhdHRlbXB0cyB0byBjaGFuZ2Ug
dGhlCj4gPiA+IE1BQyBhZGRyZXNzIGZyb20gdGhlIFZNIHNob3VsZCByZXN1bHQgaW4gZXJyb3Iu
Cj4gPiBUaGF0IGlzIG5vdCB3aGF0IHRoZSBzcGVjIHNheXMgdGhvdWdoLgo+ID4gVklSVElPX05F
VF9GX01BQyBvbmx5IHNheXMgd2hldGhlciBtYWMgaXMgdmFsaWQgaW4gdGhlIGNvbmZpZyBzcGFj
ZS4KPiA+IFdoZXRoZXIgZ3Vlc3QgY2FuIGNvbnRyb2wgdGhhdCBkZXBlbmRzIG9uIFZJUlRJT19O
RVRfRl9DVFJMX01BQ19BRERSOgo+ID4gCj4gPiAJVGhlIFZJUlRJT19ORVRfQ1RSTF9NQUNfQURE
Ul9TRVQgY29tbWFuZCBpcyB1c2VkIHRvIHNldCB0aGUgZGVmYXVsdCBNQUMgYWRkcmVzcyB3aGlj
aCByeAo+ID4gCWZpbHRlcmluZyBhY2NlcHRzIChhbmQgaWYgVklSVElPX05FVF9GX01BQ19BRERS
IGhhcyBiZWVuIG5lZ290aWF0ZWQsIHRoaXMgd2lsbCBiZSByZWZsZWN0ZWQgaW4gbWFjIGluCj4g
PiAJY29uZmlnIHNwYWNlKS4KPiA+IAlUaGUgY29tbWFuZC1zcGVjaWZpYy1kYXRhIGZvciBWSVJU
SU9fTkVUX0NUUkxfTUFDX0FERFJfU0VUIGlzIHRoZSA2LWJ5dGUgTUFDIGFkZHJlc3MuCj4gCj4g
Cj4gQ29uc2lkZXIgVklSVElPX05FVF9DVFJMX01BQ19BRERSX1NFVCBpcyBub3Qgc3VwcG9ydGVk
IG5vdy4gV2hhdCBFbGkKPiBwcm9wb3NlZCBoZXJlIHNob3VsZCB3b3JrPwo+IAo+IFRoYW5rcwo+
IAoKV2UgY2FuIGhhdmUgbWFuYWdlbWVudCBzZXQgYSBNQUMgYWRkcmVzcy4gUmFuZG9taXppbmcg
aXQgaW4ga2VybmVsCmRvZXMgbm90IHNlZW0gbGlrZSBhIHJlYXNvbmFibGUgcG9saWN5IHRvIG1l
IC4uLgoKCj4gPiAKPiA+IAo+ID4gCj4gPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
