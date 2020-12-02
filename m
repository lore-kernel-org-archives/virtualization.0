Return-Path: <SRS0=DI2N=FG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97761C64E8A
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 09:31:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB97020C56
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 09:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB97020C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3AE102E25E;
	Wed,  2 Dec 2020 09:30:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gJse743nd9Ua; Wed,  2 Dec 2020 09:30:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DD08120031;
	Wed,  2 Dec 2020 09:30:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D23C9C1833;
	Wed,  2 Dec 2020 09:30:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 116FDC0052
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 09:30:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E2AC987907
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 09:30:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GEqy02Z25Ihk
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 09:30:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3EB7F87922
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 09:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606901448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TjLPsFcz+WE8TE1ZBhguoh9wGhwjdViuzdkm34Mwo5I=;
 b=Rumcl0+nl9xoSwO09lV8oz+ixDyWuSGkBbX2fb8QdTtgidp9y8tvTC6Lhn4Dgfsi82gcPU
 ryJ6BczQWTRLOQtl5u7NCtk1vUo53RPUH4oRzvsdpDYU6TguEyVbMsVog3rsb6Enf8wlL9
 B/1dat9bFhidVzs32CKvqViipEOF2ic=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-MQdIuNdhPUqv6yhGgfCrNg-1; Wed, 02 Dec 2020 04:30:46 -0500
X-MC-Unique: MQdIuNdhPUqv6yhGgfCrNg-1
Received: by mail-wm1-f71.google.com with SMTP id v5so2355054wmj.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Dec 2020 01:30:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=TjLPsFcz+WE8TE1ZBhguoh9wGhwjdViuzdkm34Mwo5I=;
 b=Q+9whcAU4c92Q4YE0T9B8KNEtvF7MUJRBCzfZa8imS/4Pm5IlAfBecKnH+sBfz/aOd
 kMtUAeAxiqiBtDLl2GRYCgzb7eK+lQw8SVcyqjGAHh5uYA56p15I5p0tV4PVaeDjPEK6
 Dg5EwOql073ZqUgKLECfiXWrjFE8G3nsF0TguSbviCgGC02ArAjM9uGr0RQtXFc/nZkM
 tMcIv5CkdvoRCg3L4wRDrrqo8nokwgS6O1spZoRqNLe+ZuYgPkN+k+7oinxD3Hl9UxxY
 pQfabuAgZryeT+4IhgYmoThfpzEEYBriLoTxKiqU3uyOQzAdDgJkmN0GEA+9uEr0PdxU
 UlhA==
X-Gm-Message-State: AOAM531p88PLteqJFK2DTeIutSSzCJMBR23/qWT+qYc1h6gXMSf/66dl
 Cz0mFb+070RmpD1U04xQ5dSbIzNOMT/VIU600PReyK1yj3JTEOmSyBKfd1v7gspD/WvYnT9VJlx
 xcsYKlPhPguEsZFqdimZjCiSjOTgl7clHYxl6Z8bedA==
X-Received: by 2002:a1c:f315:: with SMTP id q21mr2131566wmq.1.1606901444205;
 Wed, 02 Dec 2020 01:30:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwiN9dR4+IEDrtLl07mPw2UeRQRRZOaQE8rDS63WCD6y/aKRT8sOvM3gsGCsPgJH+6xDh6f6w==
X-Received: by 2002:a1c:f315:: with SMTP id q21mr2131544wmq.1.1606901443937;
 Wed, 02 Dec 2020 01:30:43 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id r13sm1309831wrs.6.2020.12.02.01.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Dec 2020 01:30:42 -0800 (PST)
Date: Wed, 2 Dec 2020 04:30:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201202042328-mutt-send-email-mst@kernel.org>
References: <20201129064351.63618-1-elic@nvidia.com>
 <20201129150505-mutt-send-email-mst@kernel.org>
 <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
 <20201130103142-mutt-send-email-mst@kernel.org>
 <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
 <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
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

T24gV2VkLCBEZWMgMDIsIDIwMjAgYXQgMTI6MTg6MzZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzEyLzEg5LiL5Y2INToyMywgQ2luZHkgTHUgd3JvdGU6Cj4gPiBPbiBN
b24sIE5vdiAzMCwgMjAyMCBhdCAxMTozMyBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRo
YXQuY29tPiB3cm90ZToKPiA+ID4gT24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgMDY6NDE6NDVQTSAr
MDgwMCwgQ2luZHkgTHUgd3JvdGU6Cj4gPiA+ID4gT24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgNToz
MyBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+
IE9uIE1vbiwgTm92IDMwLCAyMDIwIGF0IDExOjI3OjU5QU0gKzAyMDAsIEVsaSBDb2hlbiB3cm90
ZToKPiA+ID4gPiA+ID4gT24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgMDQ6MDA6NTFBTSAtMDUwMCwg
TWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9uIE1vbiwgTm92IDMwLCAy
MDIwIGF0IDA4OjI3OjQ2QU0gKzAyMDAsIEVsaSBDb2hlbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+
IE9uIFN1biwgTm92IDI5LCAyMDIwIGF0IDAzOjA4OjIyUE0gLTA1MDAsIE1pY2hhZWwgUy4gVHNp
cmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gT24gU3VuLCBOb3YgMjksIDIwMjAgYXQgMDg6
NDM6NTFBTSArMDIwMCwgRWxpIENvaGVuIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+IFdlIHNo
b3VsZCBub3QgdHJ5IHRvIHVzZSB0aGUgVkYgTUFDIGFkZHJlc3MgYXMgdGhhdCBpcyB1c2VkIGJ5
IHRoZQo+ID4gPiA+ID4gPiA+ID4gPiA+IHJlZ3VsYXIgKGUuZy4gbWx4NV9jb3JlKSBOSUMgaW1w
bGVtZW50YXRpb24uIEluc3RlYWQsIHVzZSBhIHJhbmRvbQo+ID4gPiA+ID4gPiA+ID4gPiA+IGdl
bmVyYXRlZCBNQUMgYWRkcmVzcy4KPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+
ID4gPiBTdWdnZXN0ZWQgYnk6IENpbmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gRml4ZXM6IDFhODZiMzc3YWEyMSAoInZkcGEvbWx4NTogQWRkIFZEUEEgZHJpdmVy
IGZvciBzdXBwb3J0ZWQgbWx4NSBkZXZpY2VzIikKPiA+ID4gPiA+ID4gPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPiA+ID4gPiA+ID4gPiA+ID4gSSBk
aWRuJ3QgcmVhbGlzZSBpdCdzIHBvc3NpYmxlIHRvIHVzZSBWRiBpbiB0d28gd2F5cwo+ID4gPiA+
ID4gPiA+ID4gPiB3aXRoIGFuZCB3aXRob3V0IHZkcGEuCj4gPiA+ID4gPiA+ID4gPiBVc2luZyBh
IFZGIHlvdSBjYW4gY3JlYXRlIHF1aXRlIGEgZmV3IHJlc291cmNlcywgZS5nLiBzZW5kIHF1ZXVl
cwo+ID4gPiA+ID4gPiA+ID4gcmVjaWV2ZSBxdWV1ZXMsIHZpcnRpb19uZXQgcXVldWVzIGV0Yy4g
U28geW91IGNhbiBwb3NzaWJseSBjcmVhdGUKPiA+ID4gPiA+ID4gPiA+IHNldmVyYWwgaW5zdGFu
Y2VzIG9mIHZkcGEgbmV0IGRldmljZXMgYW5kIG5pYyBuZXQgZGV2aWNlcy4KPiA+ID4gPiA+ID4g
PiA+IAo+ID4gPiA+ID4gPiA+ID4gPiBDb3VsZCB5b3UgaW5jbHVkZSBhIGJpdCBtb3JlIGRlc2Ny
aXB0aW9uIG9uIHRoZSBmYWlsdXJlCj4gPiA+ID4gPiA+ID4gPiA+IG1vZGU/Cj4gPiA+ID4gPiA+
ID4gPiBXZWxsLCB1c2luZyB0aGUgTUFDIGFkZHJlc3Mgb2YgdGhlIG5pYyB2cG9ydCBpcyB3cm9u
ZyBzaW5jZSB0aGF0IGlzIHRoZQo+ID4gPiA+ID4gPiA+ID4gTUFDIG9mIHRoZSByZWd1bGFyIE5J
QyBpbXBsZW1lbnRhdGlvbiBvZiBtbHg1X2NvcmUuCj4gPiA+ID4gPiA+ID4gUmlnaHQgYnV0IEFU
TSBpdCBkb2Vzbid0IGNvZXhpc3Qgd2l0aCB2ZHBhIHNvIHdoYXQncyB0aGUgcHJvYmxlbT8KPiA+
ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gVGhpcyBjYWxsIGlzIHdyb25nOiAgbWx4NV9xdWVyeV9u
aWNfdnBvcnRfbWFjX2FkZHJlc3MoKQo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gSXMg
c3dpdGNoaW5nIHRvIGEgcmFuZG9tIG1hYyBmb3Igc3VjaCBhbiB1bnVzdWFsCj4gPiA+ID4gPiA+
ID4gPiA+IGNvbmZpZ3VyYXRpb24gcmVhbGx5IGp1c3RpZmllZD8KPiA+ID4gPiA+ID4gPiA+IFNp
bmNlIEkgY2FuJ3QgdXNlIHRoZSBOSUMncyBNQUMgYWRkcmVzcywgSSBoYXZlIHR3byBvcHRpb25z
Ogo+ID4gPiA+ID4gPiA+ID4gMS4gVG8gZ2V0IHRoZSBNQUMgYWRkcmVzcyBhcyB3YXMgY2hvc2Vu
IGJ5IHRoZSB1c2VyIGFkbWluaXN0ZXJpbmcgdGhlCj4gPiA+ID4gPiA+ID4gPiAgICAgTklDLiBU
aGlzIHNob3VsZCBpbnZva2UgdGhlIHNldF9jb25maWcgY2FsbGJhY2suIFVuZm9ydHVuYXRlbHkg
dGhpcwo+ID4gPiA+ID4gPiA+ID4gICAgIGlzIG5vdCBpbXBsZW1lbnRlZCB5ZXQuCj4gPiA+ID4g
PiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+IDIuIFVzZSBhIHJhbmRvbSBNQUMgYWRkcmVzcy4gVGhp
cyBpcyBPSyBzaW5jZSBpZiAoMSkgaXMgaW1wbGVtZW50ZWQgaXQKPiA+ID4gPiA+ID4gPiA+ICAg
ICBjYW4gYWx3YXlzIG92ZXJyaWRlIHRoaXMgcmFuZG9tIGNvbmZpZ3VyYXRpb24uCj4gPiA+ID4g
PiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gSXQgbG9va3MgbGlrZSBjaGFuZ2luZyBhIE1BQyBj
b3VsZCBicmVhayBzb21lIGd1ZXN0cywKPiA+ID4gPiA+ID4gPiA+ID4gY2FuIGl0IG5vdD8KPiA+
ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiBObywgaXQgd2lsbCBub3QuIFRoZSBjdXJy
ZW50IHZlcnNpb24gb2YgbWx4NSBWRFBBIGRvZXMgbm90IGFsbG93IHJlZ3VsYXIKPiA+ID4gPiA+
ID4gPiA+IE5JQyBkcml2ZXIgYW5kIFZEUEEgdG8gY28tZXhpc3QuIEkgaGF2ZSBwYXRjaGVzIHJl
YWR5IHRoYXQgZW5hYmxlIHRoYXQKPiA+ID4gPiA+ID4gPiA+IGZyb20gc3RlZXJpbmcgcG9pbnQg
b2Ygdmlldy4gSSB3aWxsIHBvc3QgdGhlbSBoZXJlIG9uY2Ugb3RoZXIgcGF0Y2hlcyBvbgo+ID4g
PiA+ID4gPiA+ID4gd2hpY2ggdGhleSBkZXBlbmQgd2lsbCBiZSBtZXJnZWQuCj4gPiA+ID4gPiA+
ID4gPiAKPiA+ID4gPiA+ID4gPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVj
dC9uZXRkZXYvcGF0Y2gvMjAyMDExMjAyMzAzMzkuNjUxNjA5LTEyLXNhZWVkbUBudmlkaWEuY29t
Lwo+ID4gPiA+ID4gPiA+IENvdWxkIHlvdSBiZSBtb3JlIGV4cGxpY2l0IG9uIHRoZSBmb2xsb3dp
bmcgcG9pbnRzOgo+ID4gPiA+ID4gPiA+IC0gd2hpY2ggY29uZmlndXJhdGlvbiBpcyBicm9rZW4g
QVRNIChhcyBpbiwgdHdvIGRldmljZSBoYXZlIGlkZW50aWNhbAo+ID4gPiA+ID4gPiA+ICAgIG1h
Y3M/IGFueSBvdGhlciBpc3N1ZXMpPwo+ID4gPiA+ID4gPiBUaGUgb25seSB3cm9uZyB0aGluZyBp
cyB0aGUgY2FsbCB0byAgbWx4NV9xdWVyeV9uaWNfdnBvcnRfbWFjX2FkZHJlc3MoKS4KPiA+ID4g
PiA+ID4gSXQncyBub3QgYnJlYWtpbmcgYW55dGhpbmcgeWV0IGlzIHdyb25nLiBUaGUgcmFuZG9t
IE1BQyBhZGRyZXNzIHNldHRpbmcKPiA+ID4gPiA+ID4gaXMgcmVxdWlyZWQgZm9yIHRoZSBzdGVl
cmluZyBwYXRjaGVzLgo+ID4gPiA+ID4gT2theSBzbyBJJ20gbm90IHN1cmUgdGhlIEZpeGVzIHRh
ZyBhdCBsZWFzdCBpcyBhcHByb3ByaWF0ZSBpZiBpdCdzIGEKPiA+ID4gPiA+IGRlcGVuZGVuY3kg
b2YgYSBuZXcgZmVhdHVyZS4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IC0gd2h5IHdvbid0IGRl
dmljZSBNQUMgY2hhbmdlIGZyb20gZ3Vlc3QgcG9pbnQgb2Ygdmlldz8KPiA+ID4gPiA+ID4gPiAK
PiA+ID4gPiA+ID4gSXQncyBsYWNrIG9mIGltcGxlbWVudGF0aW9uIGluIHFlbXUgYXMgZmFyIGFz
IEkga25vdy4KPiA+ID4gPiA+IFNvcnJ5IG5vdCBzdXJlIEkgdW5kZXJzdGFuZC4gV2hhdCdzIG5v
dCBpbXBsZW1lbnRlZCBpbiBRRU1VPwo+ID4gPiA+ID4gCj4gPiA+ID4gSEkgTWljaGFlbCwgdGhl
cmUgYXJlIHNvbWUgYnVnIGluIHFlbXUgdG8gc2V0X2NvbmZpZywgdGhpcyB3aWxsIGZpeCBpbiBm
dXR1cmUsCj4gPiA+ID4gQnV0IHRoaXMgcGF0Y2ggaXMgc3RpbGwgbmVlZGVkLCBiZWNhdXNlIHdp
dGhvdXQgdGhpcyBwYXRjaCB0aGUgbWx4Cj4gPiA+ID4gZHJpdmVyIHdpbGwgZ2l2ZSBhbiAwIG1h
YyBhZGRyZXNzIHRvIHFlbXUKPiA+ID4gPiBhbmQgcWVtdSB3aWxsIG92ZXJ3cml0ZSB0aGUgZGVm
YXVsdCBtYWMgYWRkcmVzcy4gIFRoaXMgd2lsbCBjYXVzZSB0cmFmZmljIGRvd24uCj4gPiA+IEht
bSB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gc2F5cyBWRiBtYWMgYWRkcmVzcywgbm90IDAgYWRkcmVz
cy4gQ29uZnVzZWQuCj4gPiA+IElmIHRoZXJlJ3Mgbm8gbWFjIHdlIGNhbiBjbGVhciBWSVJUSU9f
TkVUX0ZfTUFDIGFuZCBoYXZlIGd1ZXN0Cj4gPiA+IHVzZSBhIHJhbmRvbSB2YWx1ZSAuLi4KPiAK
PiAKPiBJJ20gbm90IHN1cmUgdGhpcyBjYW4gd29yayBmb3IgYWxsIHR5cGVzIG9mIHZEUEEgKGUu
ZyBpdCBjb3VsZCBub3QgYmUgYQo+IGxlYXJuaW5nIGJyaWRnZSBpbiB0aGUgc3d0aWNoKS4KPiAK
PiAKPiA+ID4gCj4gPiBoaSBNaWNoYWVs77yMCj4gPiBJIGhhdmUgdHJpZWQgYXMgeW91ciBzdWdn
ZXN0aW9uLCBzZWVtcyBldmVuIHJlbW92ZSB0aGUKPiA+IFZJUlRJT19ORVRfRl9NQUMgdGhlIHFl
bXUgd2lsbCBzdGlsbCBjYWxsIGdldF9jaW5maWcgYW5kIG92ZXJ3cml0ZSB0aGUKPiA+IGRlZmF1
bHQgYWRkcmVzcyBpbiAgVk0sCj4gCj4gCj4gVGhpcyBsb29rcyBhIGJ1ZyBpbiBxZW11LCBpbiBn
dWVzdCBkcml2ZXIgd2UgaGFkOgo+IAo+IMKgwqDCoCAvKiBDb25maWd1cmF0aW9uIG1heSBzcGVj
aWZ5IHdoYXQgTUFDIHRvIHVzZS7CoCBPdGhlcndpc2UgcmFuZG9tLiAqLwo+IMKgwqDCoCBpZiAo
dmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9NQUMpKQo+IMKgwqDCoCDCoMKg
wqAgdmlydGlvX2NyZWFkX2J5dGVzKHZkZXYsCj4gwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKg
IMKgwqAgb2Zmc2V0b2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnLCBtYWMpLAo+IMKgwqDCoCDC
oMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgIGRldi0+ZGV2X2FkZHIsIGRldi0+YWRkcl9sZW4pOwo+
IMKgwqDCoCBlbHNlCj4gwqDCoMKgIMKgwqDCoCBldGhfaHdfYWRkcl9yYW5kb20oZGV2KTsKPiAK
PiAKPiA+IHRoaXMgcHJvY2VzcyBpcyBsaWtlCj4gPiB2ZHBhIF9pbml0IC0tPnFlbXUgY2FsbCBn
ZXRfY29uZmlnIC0+bWx4IGRyaXZlciB3aWxsIGdpdmUgIGFuIG1hYwo+ID4gYWRkcmVzcyB3aXRo
IGFsbCAwLS0+Cj4gPiBxZW11IHdpbGwgbm90IGNoZWNrIHRoaXMgbWFjIGFkZHJlc3MgYW5kIHVz
ZSBpdCAtLT4gb3ZlcndyaXRlIHRoZSBtYWMKPiA+IGFkZHJlc3MgaW4gcWVtdQo+ID4gCj4gPiBT
byBmb3IgbXkgdW5kZXJzdGFuZGluZyB0aGVyZSBhcmUgc2V2ZXJhbCBtZXRob2QgdG8gZml4IHRo
aXMgcHJvYmxlbQo+ID4gCj4gPiAxLCBxZW11IGNoZWNrIHRoZSBtYWMgYWRkcmVzcywgaWYgdGhl
IG1hYyBhZGRyZXNzIGlzIGFsbCAwLCBxZW11IHdpbGwKPiA+IGlnbm9yZSBpdCBhbmQgc2V0IHRo
ZSByYW5kb20gbWFjIGFkZHJlc3MgdG8gbWx4IGRyaXZlci4KPiAKPiAKPiBTbyBteSB1bmRlcnN0
YW5kaW5nIGlzIHRoYXQsIGlmIG1hYyBhZGRyZXNzIGlzIGFsbCAwLCB2RFBBIHBhcmVudCBzaG91
bGQgbm90Cj4gYWR2ZXJ0aXNlIFZJUlRJT19ORVRfRl9NQUMuIEFuZCBxZW11IHNob3VsZCBlbXVs
YXRlIHRoaXMgZmVhdHVyZSBhcyB5b3UgZGlkOgo+IAo+IDEpIGdldCBhIHJhbmRvbSBtYWMKClRv
IG1lIHRoaXMgbG9va3MgbGlrZSBhIHNwZWMgdmlvbGF0aW9uLgoKSWYgdGhlIGRyaXZlciBuZWdv
dGlhdGVzIHRoZSBWSVJUSU9fTkVUX0ZfTUFDIGZlYXR1cmUsIHRoZSBkcml2ZXIgTVVTVCBzZXQK
dGhlIHBoeXNpY2FsIGFkZHJlc3Mgb2YgdGhlIE5JQyB0byBcZmllbGR7bWFjfS4gIE90aGVyd2lz
ZSwgaXQgU0hPVUxECnVzZSBhIGxvY2FsbHktYWRtaW5pc3RlcmVkIE1BQyBhZGRyZXNzIChzZWUg
XGh5cGVycmVmW2ludHJvOklFRUUgODAyXXtJRUVFIDgwMn0sCmBgOS4yIDQ4LWJpdCB1bml2ZXJz
YWwgTEFOIE1BQyBhZGRyZXNzZXMnJykuCgpXaGlsZSBub3Qgc2FpZCBleHBsaWNpdGx5LCB0aGUg
YXNzdW1wdGlvbiBJIHRoaW5rIGlzIHRoYXQgdGhlIGxvY2FsCk1BQyBpcyBub3QgYSBsb2NhbCBv
bmUuCgoKPiAyKSBhZHZlcnRpc2UgVklSVElPX05FVF9GX01BQwo+IDMpIHNldCB0aGUgcmFuZG9t
IG1hYyB0byB2RFBBIHRocm91Z2ggc2V0X2NvbmZpZwoKdGhhdCBwYXJ0IGxvb2tzIHdyb25nIHRv
IG1lLiBTZXR0aW5nIG1hYyB0aHJvdWdoIHNldF9jb25maWcgd2FzCmEgcHJlLXZpcnRpby0xLjAg
d2F5IHRvIHNlbmQgbWFjIHRvIGRldmljZS4gSW4gMS4wIHdlIGhhdmUKVklSVElPX05FVF9DVFJM
X01BQ19BRERSX1NFVCBmb3IgdGhhdDoKCgoJV2hlbiB1c2luZyB0aGUgbGVnYWN5IGludGVyZmFj
ZSwgXGZpZWxke21hY30gaXMgZHJpdmVyLXdyaXRhYmxlCgl3aGljaCBwcm92aWRlZCBhIHdheSBm
b3IgZHJpdmVycyB0byB1cGRhdGUgdGhlIE1BQyB3aXRob3V0CgluZWdvdGlhdGluZyBWSVJUSU9f
TkVUX0ZfQ1RSTF9NQUNfQUREUi4KCgoKCj4gNCkgYWR2ZXJ0aXNlIHRoZSByYW5kb20gbWFjIHRv
IGVtdWxhdGVkIGNvbmZpZyB0byBndWVzdAo+IAo+IAo+ID4gMi4gbWx4IGRyaXZlciBjaGVja3Mg
dGhlIG1hYyBhZGRyZXNzIGFuZCBpZiB0aGlzIG1hYyBpcyAwLCByZXR1cm4gZmFpbAo+ID4gdG8g
cWVtdSwgYnV0IHRoaXMgbmVlZCB0byBjaGFuZ2UgdGhlIFVBUEkuCj4gCj4gCj4gdUFQSSBpcyBw
cm9iYWJseSBmaW5lIHNpbmNlIGlvY3RsIGNhbiBmYWlsLsKgIFdlIGNhbiBjaGFuZ2UgdGhlIHRv
IGFsbG93IHRoZQo+IHNldF9jb25maWcgdG8gZmFpbCBidXQgdmlyaXRvIHNwZWMgZG9lc24ndCBo
YXZlIGEgd2F5IHRvIGFkdmVydGlzZSB0aGUgZXJyb3IKPiBpbiB0aGlzIGNhc2UuIEFueXdheSwg
dGhlIGRyaXZlciBvbmx5IHJpc2sgaXRzZWxmIGZvciBzZXR0aW5nIGEgd3JvbmcgdmFsdWUsCj4g
c28gd2UncmUgcHJvYmFibHkgZmluZS4KPiAKPiBUaGFua3MKPiAKPiAKPiA+IDMuIG1seCBkcml2
ZXIgaXQgc2hlbGYgc2hvdWxkIGdldCBhbiBjb3JyZWN0IG1hYyBhZGRyZXNzIHdoaWxlIGl0IGlu
aXQuCj4gPiA0LiBhZGQgY2hlY2sgaW4gcWVtdSBnZXRfY29uZmlnIGZ1bmN0aW9uICAsIGlmIHRo
ZXJlIGlzIG5vdCBGX01BQyBUaGVuCj4gPiBpZ25vcmUgdGhlIG1hYyBhZGRyZXNzIGZyb20gbWx4
IGRyaXZlcgo+ID4gCj4gPiBub3Qgc3VyZSB3aGljaCBtZXRob2QgaXMgbW9yZSBzdWl0YWJsZSA/
Cj4gPiAKPiA+IFRoYW5rcwo+ID4gQ2luZHkKPiA+IAo+ID4gCj4gPiAKPiA+ID4gPiA+ID4gPiA+
ID4gPiAtLS0KPiA+ID4gPiA+ID4gPiA+ID4gPiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1
X3ZuZXQuYyB8IDUgKy0tLS0KPiA+ID4gPiA+ID4gPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgNCBkZWxldGlvbnMoLSkKPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4g
PiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiA+ID4gPiA+
ID4gaW5kZXggMWZhNmZjYWM4Mjk5Li44MGQwNmQ5NThiOGIgMTAwNjQ0Cj4gPiA+ID4gPiA+ID4g
PiA+ID4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiA+
ID4gPiA+ID4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4g
PiA+ID4gPiA+ID4gQEAgLTE5NTUsMTAgKzE5NTUsNyBAQCB2b2lkICptbHg1X3ZkcGFfYWRkX2Rl
dihzdHJ1Y3QgbWx4NV9jb3JlX2RldiAqbWRldikKPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAg
aWYgKGVycikKPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICBnb3RvIGVycl9tdHU7
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+ID4gLSAgICAgZXJyID0gbWx4
NV9xdWVyeV9uaWNfdnBvcnRfbWFjX2FkZHJlc3MobWRldiwgMCwgMCwgY29uZmlnLT5tYWMpOwo+
ID4gPiA+ID4gPiA+ID4gPiA+IC0gICAgIGlmIChlcnIpCj4gPiA+ID4gPiA+ID4gPiA+ID4gLSAg
ICAgICAgICAgICBnb3RvIGVycl9tdHU7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gLQo+ID4gPiA+ID4g
PiA+ID4gPiA+ICsgICAgIGV0aF9yYW5kb21fYWRkcihjb25maWctPm1hYyk7Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gICAgICAgIG12ZGV2LT52ZGV2LmRtYV9kZXYgPSBtZGV2LT5kZXZpY2U7Cj4gPiA+
ID4gPiA+ID4gPiA+ID4gICAgICAgIGVyciA9IG1seDVfdmRwYV9hbGxvY19yZXNvdXJjZXMoJm5k
ZXYtPm12ZGV2KTsKPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgaWYgKGVycikKPiA+ID4gPiA+
ID4gPiA+ID4gPiAtLQo+ID4gPiA+ID4gPiA+ID4gPiA+IDIuMjYuMgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
