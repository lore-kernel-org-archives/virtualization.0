Return-Path: <SRS0=fSyG=FF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E725EC64E7A
	for <virtualization@archiver.kernel.org>; Tue,  1 Dec 2020 11:32:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26679206A5
	for <virtualization@archiver.kernel.org>; Tue,  1 Dec 2020 11:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzcgZGGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26679206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6624F87550;
	Tue,  1 Dec 2020 11:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8QkcpXfkIh5q; Tue,  1 Dec 2020 11:32:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3BB208753D;
	Tue,  1 Dec 2020 11:32:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 225B9C0859;
	Tue,  1 Dec 2020 11:32:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D44C0C0052
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 11:32:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C0B0686BB9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 11:32:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jx9HAFQJObzN
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 11:32:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C41A486BB3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 11:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606822341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Svz+1xyDUI6OILOu+XfjM4sFd1o5nMwo/UZKflYJ9Nc=;
 b=EzcgZGGMunoGV4Kf+FHydRu6AZK5tidqtZa4Tnx80HY/hGBAxrdGBNbovfKahqtAO41fwT
 bO5b9q33fIQt94tr1Ab2JB9BjfNYUYFYt497hdONWVIp3yVpftNqkLI7dDOnnw/o7dpRkP
 zbHRtobYGbe1elL+SssXwmX6o8c4uL8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-dhYNnQWHMRKfMSZmthSxQw-1; Tue, 01 Dec 2020 06:32:17 -0500
X-MC-Unique: dhYNnQWHMRKfMSZmthSxQw-1
Received: by mail-ej1-f71.google.com with SMTP id dx19so1065671ejb.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Dec 2020 03:32:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Svz+1xyDUI6OILOu+XfjM4sFd1o5nMwo/UZKflYJ9Nc=;
 b=K0wYxT6NPA+zmnDZfCFXst8kBx9o9/bUUeGiWniJhar51u6b17TW03XL7dv6BY7cfU
 ubAcco98U/708XtcycQ8CbETiqOqpyN36Oxr95hjzd7BlyQRJ7JJOYqezeB55fMqXubD
 gwKCOipVAdyIpbDZRiSMdwdz/IeF3VjkFBgTTKXtxtvG5aPCosbFBGc36yWj1lM4M1Xz
 IY3ML2xOSIrJTaPk+NCWpUsuqV+KPuAf3P3K1M8JgCFC7IYjxNFSdq3DfqbWLswIVr6t
 evV1CWjpoCMQP2O20hY3hulf0XNb4kTn4Yt8LCJYjVx4nm0hXjzqTv9oedrVq4ofNUt7
 bFEw==
X-Gm-Message-State: AOAM5308ApGusnvjIzprTBEIdZhEt8lq33TLIwQ710HlUa1UnrlrLiyr
 860Pm1guwOJhvbno/FvsJ0hxZRq5yTADzd0Wzx4UrFgu5t/oevQJRLoLBrImgEI05dN8DxTTPVO
 fp5XP/RRFc+aPA6ducOh6/zjod9H23jpP6E+1IrXssQ==
X-Received: by 2002:a17:906:7aca:: with SMTP id
 k10mr2445571ejo.215.1606822336240; 
 Tue, 01 Dec 2020 03:32:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwiPe9/KoxYRLDVWSQQVvL+gdJ6By20pYTiP3sMl7OyF7YkInMq7HsnWLqYI/1YenfxYufnBQ==
X-Received: by 2002:a17:906:7aca:: with SMTP id
 k10mr2445552ejo.215.1606822335923; 
 Tue, 01 Dec 2020 03:32:15 -0800 (PST)
Received: from redhat.com ([147.161.9.150])
 by smtp.gmail.com with ESMTPSA id i21sm676575edt.92.2020.12.01.03.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 03:32:15 -0800 (PST)
Date: Tue, 1 Dec 2020 06:32:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201201063124-mutt-send-email-mst@kernel.org>
References: <20201129064351.63618-1-elic@nvidia.com>
 <20201129150505-mutt-send-email-mst@kernel.org>
 <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
 <20201130103142-mutt-send-email-mst@kernel.org>
 <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
 virtualization@lists.linux-foundation.org
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

T24gVHVlLCBEZWMgMDEsIDIwMjAgYXQgMDU6MjM6MThQTSArMDgwMCwgQ2luZHkgTHUgd3JvdGU6
Cj4gT24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgMTE6MzMgUE0gTWljaGFlbCBTLiBUc2lya2luIDxt
c3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgMDY6
NDE6NDVQTSArMDgwMCwgQ2luZHkgTHUgd3JvdGU6Cj4gPiA+IE9uIE1vbiwgTm92IDMwLCAyMDIw
IGF0IDU6MzMgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4g
PiA+ID4KPiA+ID4gPiBPbiBNb24sIE5vdiAzMCwgMjAyMCBhdCAxMToyNzo1OUFNICswMjAwLCBF
bGkgQ29oZW4gd3JvdGU6Cj4gPiA+ID4gPiBPbiBNb24sIE5vdiAzMCwgMjAyMCBhdCAwNDowMDo1
MUFNIC0wNTAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gPiA+IE9uIE1vbiwg
Tm92IDMwLCAyMDIwIGF0IDA4OjI3OjQ2QU0gKzAyMDAsIEVsaSBDb2hlbiB3cm90ZToKPiA+ID4g
PiA+ID4gPiBPbiBTdW4sIE5vdiAyOSwgMjAyMCBhdCAwMzowODoyMlBNIC0wNTAwLCBNaWNoYWVs
IFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiBPbiBTdW4sIE5vdiAyOSwgMjAyMCBh
dCAwODo0Mzo1MUFNICswMjAwLCBFbGkgQ29oZW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+IFdl
IHNob3VsZCBub3QgdHJ5IHRvIHVzZSB0aGUgVkYgTUFDIGFkZHJlc3MgYXMgdGhhdCBpcyB1c2Vk
IGJ5IHRoZQo+ID4gPiA+ID4gPiA+ID4gPiByZWd1bGFyIChlLmcuIG1seDVfY29yZSkgTklDIGlt
cGxlbWVudGF0aW9uLiBJbnN0ZWFkLCB1c2UgYSByYW5kb20KPiA+ID4gPiA+ID4gPiA+ID4gZ2Vu
ZXJhdGVkIE1BQyBhZGRyZXNzLgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBT
dWdnZXN0ZWQgYnk6IENpbmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+ID4gPiA+
IEZpeGVzOiAxYTg2YjM3N2FhMjEgKCJ2ZHBhL21seDU6IEFkZCBWRFBBIGRyaXZlciBmb3Igc3Vw
cG9ydGVkIG1seDUgZGV2aWNlcyIpCj4gPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEVs
aSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+
IEkgZGlkbid0IHJlYWxpc2UgaXQncyBwb3NzaWJsZSB0byB1c2UgVkYgaW4gdHdvIHdheXMKPiA+
ID4gPiA+ID4gPiA+IHdpdGggYW5kIHdpdGhvdXQgdmRwYS4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+IFVzaW5nIGEgVkYgeW91IGNhbiBjcmVhdGUgcXVpdGUgYSBmZXcgcmVzb3VyY2VzLCBl
LmcuIHNlbmQgcXVldWVzCj4gPiA+ID4gPiA+ID4gcmVjaWV2ZSBxdWV1ZXMsIHZpcnRpb19uZXQg
cXVldWVzIGV0Yy4gU28geW91IGNhbiBwb3NzaWJseSBjcmVhdGUKPiA+ID4gPiA+ID4gPiBzZXZl
cmFsIGluc3RhbmNlcyBvZiB2ZHBhIG5ldCBkZXZpY2VzIGFuZCBuaWMgbmV0IGRldmljZXMuCj4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IENvdWxkIHlvdSBpbmNsdWRlIGEgYml0IG1vcmUg
ZGVzY3JpcHRpb24gb24gdGhlIGZhaWx1cmUKPiA+ID4gPiA+ID4gPiA+IG1vZGU/Cj4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiBXZWxsLCB1c2luZyB0aGUgTUFDIGFkZHJlc3Mgb2YgdGhlIG5p
YyB2cG9ydCBpcyB3cm9uZyBzaW5jZSB0aGF0IGlzIHRoZQo+ID4gPiA+ID4gPiA+IE1BQyBvZiB0
aGUgcmVndWxhciBOSUMgaW1wbGVtZW50YXRpb24gb2YgbWx4NV9jb3JlLgo+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiBSaWdodCBidXQgQVRNIGl0IGRvZXNuJ3QgY29leGlzdCB3aXRoIHZkcGEgc28g
d2hhdCdzIHRoZSBwcm9ibGVtPwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoaXMg
Y2FsbCBpcyB3cm9uZzogIG1seDVfcXVlcnlfbmljX3Zwb3J0X21hY19hZGRyZXNzKCkKPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiBJcyBzd2l0Y2hpbmcgdG8gYSByYW5kb20gbWFjIGZvciBzdWNo
IGFuIHVudXN1YWwKPiA+ID4gPiA+ID4gPiA+IGNvbmZpZ3VyYXRpb24gcmVhbGx5IGp1c3RpZmll
ZD8KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFNpbmNlIEkgY2FuJ3QgdXNlIHRoZSBOSUMn
cyBNQUMgYWRkcmVzcywgSSBoYXZlIHR3byBvcHRpb25zOgo+ID4gPiA+ID4gPiA+IDEuIFRvIGdl
dCB0aGUgTUFDIGFkZHJlc3MgYXMgd2FzIGNob3NlbiBieSB0aGUgdXNlciBhZG1pbmlzdGVyaW5n
IHRoZQo+ID4gPiA+ID4gPiA+ICAgIE5JQy4gVGhpcyBzaG91bGQgaW52b2tlIHRoZSBzZXRfY29u
ZmlnIGNhbGxiYWNrLiBVbmZvcnR1bmF0ZWx5IHRoaXMKPiA+ID4gPiA+ID4gPiAgICBpcyBub3Qg
aW1wbGVtZW50ZWQgeWV0Lgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gMi4gVXNlIGEgcmFu
ZG9tIE1BQyBhZGRyZXNzLiBUaGlzIGlzIE9LIHNpbmNlIGlmICgxKSBpcyBpbXBsZW1lbnRlZCBp
dAo+ID4gPiA+ID4gPiA+ICAgIGNhbiBhbHdheXMgb3ZlcnJpZGUgdGhpcyByYW5kb20gY29uZmln
dXJhdGlvbi4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gSXQgbG9va3MgbGlrZSBjaGFu
Z2luZyBhIE1BQyBjb3VsZCBicmVhayBzb21lIGd1ZXN0cywKPiA+ID4gPiA+ID4gPiA+IGNhbiBp
dCBub3Q/Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gTm8sIGl0
IHdpbGwgbm90LiBUaGUgY3VycmVudCB2ZXJzaW9uIG9mIG1seDUgVkRQQSBkb2VzIG5vdCBhbGxv
dyByZWd1bGFyCj4gPiA+ID4gPiA+ID4gTklDIGRyaXZlciBhbmQgVkRQQSB0byBjby1leGlzdC4g
SSBoYXZlIHBhdGNoZXMgcmVhZHkgdGhhdCBlbmFibGUgdGhhdAo+ID4gPiA+ID4gPiA+IGZyb20g
c3RlZXJpbmcgcG9pbnQgb2Ygdmlldy4gSSB3aWxsIHBvc3QgdGhlbSBoZXJlIG9uY2Ugb3RoZXIg
cGF0Y2hlcyBvbgo+ID4gPiA+ID4gPiA+IHdoaWNoIHRoZXkgZGVwZW5kIHdpbGwgYmUgbWVyZ2Vk
Lgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9y
Zy9wcm9qZWN0L25ldGRldi9wYXRjaC8yMDIwMTEyMDIzMDMzOS42NTE2MDktMTItc2FlZWRtQG52
aWRpYS5jb20vCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IENvdWxkIHlvdSBiZSBtb3JlIGV4cGxp
Y2l0IG9uIHRoZSBmb2xsb3dpbmcgcG9pbnRzOgo+ID4gPiA+ID4gPiAtIHdoaWNoIGNvbmZpZ3Vy
YXRpb24gaXMgYnJva2VuIEFUTSAoYXMgaW4sIHR3byBkZXZpY2UgaGF2ZSBpZGVudGljYWwKPiA+
ID4gPiA+ID4gICBtYWNzPyBhbnkgb3RoZXIgaXNzdWVzKT8KPiA+ID4gPiA+Cj4gPiA+ID4gPiBU
aGUgb25seSB3cm9uZyB0aGluZyBpcyB0aGUgY2FsbCB0byAgbWx4NV9xdWVyeV9uaWNfdnBvcnRf
bWFjX2FkZHJlc3MoKS4KPiA+ID4gPiA+IEl0J3Mgbm90IGJyZWFraW5nIGFueXRoaW5nIHlldCBp
cyB3cm9uZy4gVGhlIHJhbmRvbSBNQUMgYWRkcmVzcyBzZXR0aW5nCj4gPiA+ID4gPiBpcyByZXF1
aXJlZCBmb3IgdGhlIHN0ZWVyaW5nIHBhdGNoZXMuCj4gPiA+ID4KPiA+ID4gPiBPa2F5IHNvIEkn
bSBub3Qgc3VyZSB0aGUgRml4ZXMgdGFnIGF0IGxlYXN0IGlzIGFwcHJvcHJpYXRlIGlmIGl0J3Mg
YQo+ID4gPiA+IGRlcGVuZGVuY3kgb2YgYSBuZXcgZmVhdHVyZS4KPiA+ID4gPgo+ID4gPiA+ID4g
PiAtIHdoeSB3b24ndCBkZXZpY2UgTUFDIGNoYW5nZSBmcm9tIGd1ZXN0IHBvaW50IG9mIHZpZXc/
Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gSXQncyBsYWNrIG9mIGltcGxlbWVudGF0
aW9uIGluIHFlbXUgYXMgZmFyIGFzIEkga25vdy4KPiA+ID4gPgo+ID4gPiA+IFNvcnJ5IG5vdCBz
dXJlIEkgdW5kZXJzdGFuZC4gV2hhdCdzIG5vdCBpbXBsZW1lbnRlZCBpbiBRRU1VPwo+ID4gPiA+
Cj4gPiA+IEhJIE1pY2hhZWwsIHRoZXJlIGFyZSBzb21lIGJ1ZyBpbiBxZW11IHRvIHNldF9jb25m
aWcsIHRoaXMgd2lsbCBmaXggaW4gZnV0dXJlLAo+ID4gPiBCdXQgdGhpcyBwYXRjaCBpcyBzdGls
bCBuZWVkZWQsIGJlY2F1c2Ugd2l0aG91dCB0aGlzIHBhdGNoIHRoZSBtbHgKPiA+ID4gZHJpdmVy
IHdpbGwgZ2l2ZSBhbiAwIG1hYyBhZGRyZXNzIHRvIHFlbXUKPiA+ID4gYW5kIHFlbXUgd2lsbCBv
dmVyd3JpdGUgdGhlIGRlZmF1bHQgbWFjIGFkZHJlc3MuICBUaGlzIHdpbGwgY2F1c2UgdHJhZmZp
YyBkb3duLgo+ID4KPiA+IEhtbSB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gc2F5cyBWRiBtYWMgYWRk
cmVzcywgbm90IDAgYWRkcmVzcy4gQ29uZnVzZWQuCj4gPiBJZiB0aGVyZSdzIG5vIG1hYyB3ZSBj
YW4gY2xlYXIgVklSVElPX05FVF9GX01BQyBhbmQgaGF2ZSBndWVzdAo+ID4gdXNlIGEgcmFuZG9t
IHZhbHVlIC4uLgo+ID4KPiBoaSBNaWNoYWVs77yMCj4gSSBoYXZlIHRyaWVkIGFzIHlvdXIgc3Vn
Z2VzdGlvbiwgc2VlbXMgZXZlbiByZW1vdmUgdGhlCj4gVklSVElPX05FVF9GX01BQyB0aGUgcWVt
dSB3aWxsIHN0aWxsIGNhbGwgZ2V0X2NpbmZpZyBhbmQgb3ZlcndyaXRlIHRoZQo+IGRlZmF1bHQg
YWRkcmVzcyBpbiAgVk0sCj4gdGhpcyBwcm9jZXNzIGlzIGxpa2UKPiB2ZHBhIF9pbml0IC0tPnFl
bXUgY2FsbCBnZXRfY29uZmlnIC0+bWx4IGRyaXZlciB3aWxsIGdpdmUgIGFuIG1hYwo+IGFkZHJl
c3Mgd2l0aCBhbGwgMC0tPgo+IHFlbXUgd2lsbCBub3QgY2hlY2sgdGhpcyBtYWMgYWRkcmVzcyBh
bmQgdXNlIGl0IC0tPiBvdmVyd3JpdGUgdGhlIG1hYwo+IGFkZHJlc3MgaW4gcWVtdQoKUmlnaHQg
YnV0IGd1ZXN0IHdpbGwgaWdub3JlIGl0IHRoZW4sIHJpZ2h0PwoKPiBTbyBmb3IgbXkgdW5kZXJz
dGFuZGluZyB0aGVyZSBhcmUgc2V2ZXJhbCBtZXRob2QgdG8gZml4IHRoaXMgcHJvYmxlbQo+IAo+
IDEsIHFlbXUgY2hlY2sgdGhlIG1hYyBhZGRyZXNzLCBpZiB0aGUgbWFjIGFkZHJlc3MgaXMgYWxs
IDAsIHFlbXUgd2lsbAo+IGlnbm9yZSBpdCBhbmQgc2V0IHRoZSByYW5kb20gbWFjIGFkZHJlc3Mg
dG8gbWx4IGRyaXZlci4KPiAyLiBtbHggZHJpdmVyIGNoZWNrcyB0aGUgbWFjIGFkZHJlc3MgYW5k
IGlmIHRoaXMgbWFjIGlzIDAsIHJldHVybiBmYWlsCj4gdG8gcWVtdSwgYnV0IHRoaXMgbmVlZCB0
byBjaGFuZ2UgdGhlIFVBUEkuCj4gMy4gbWx4IGRyaXZlciBpdCBzaGVsZiBzaG91bGQgZ2V0IGFu
IGNvcnJlY3QgbWFjIGFkZHJlc3Mgd2hpbGUgaXQgaW5pdC4KPiA0LiBhZGQgY2hlY2sgaW4gcWVt
dSBnZXRfY29uZmlnIGZ1bmN0aW9uICAsIGlmIHRoZXJlIGlzIG5vdCBGX01BQyBUaGVuCj4gaWdu
b3JlIHRoZSBtYWMgYWRkcmVzcyBmcm9tIG1seCBkcml2ZXIKPiAKPiBub3Qgc3VyZSB3aGljaCBt
ZXRob2QgaXMgbW9yZSBzdWl0YWJsZSA/Cj4gCj4gVGhhbmtzCj4gQ2luZHkKPiAKPiAKPiAKPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+ID4gPiA+ICBkcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCA1ICstLS0tCj4gPiA+ID4gPiA+ID4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDQgZGVsZXRpb25zKC0pCj4gPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9u
ZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4g
PiA+ID4gPiA+ID4gaW5kZXggMWZhNmZjYWM4Mjk5Li44MGQwNmQ5NThiOGIgMTAwNjQ0Cj4gPiA+
ID4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4g
PiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+
ID4gPiA+ID4gPiA+ID4gQEAgLTE5NTUsMTAgKzE5NTUsNyBAQCB2b2lkICptbHg1X3ZkcGFfYWRk
X2RldihzdHJ1Y3QgbWx4NV9jb3JlX2RldiAqbWRldikKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAg
aWYgKGVycikKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICBnb3RvIGVycl9tdHU7Cj4g
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IC0gICAgIGVyciA9IG1seDVfcXVlcnlf
bmljX3Zwb3J0X21hY19hZGRyZXNzKG1kZXYsIDAsIDAsIGNvbmZpZy0+bWFjKTsKPiA+ID4gPiA+
ID4gPiA+ID4gLSAgICAgaWYgKGVycikKPiA+ID4gPiA+ID4gPiA+ID4gLSAgICAgICAgICAgICBn
b3RvIGVycl9tdHU7Cj4gPiA+ID4gPiA+ID4gPiA+IC0KPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAg
ZXRoX3JhbmRvbV9hZGRyKGNvbmZpZy0+bWFjKTsKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgbXZk
ZXYtPnZkZXYuZG1hX2RldiA9IG1kZXYtPmRldmljZTsKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAg
ZXJyID0gbWx4NV92ZHBhX2FsbG9jX3Jlc291cmNlcygmbmRldi0+bXZkZXYpOwo+ID4gPiA+ID4g
PiA+ID4gPiAgICAgICBpZiAoZXJyKQo+ID4gPiA+ID4gPiA+ID4gPiAtLQo+ID4gPiA+ID4gPiA+
ID4gPiAyLjI2LjIKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4KPiA+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
