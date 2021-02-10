Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D608AC433E0
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 10:08:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6636F60235
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 10:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6636F60235
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1D8B68598A;
	Wed, 10 Feb 2021 10:08:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f18u8sU6mDzD; Wed, 10 Feb 2021 10:08:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7EF41847DE;
	Wed, 10 Feb 2021 10:08:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5484BC0891;
	Wed, 10 Feb 2021 10:08:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D703C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 10:08:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5B7E6858B3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 10:08:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id satZ5doL-yCn
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 10:08:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 90AB5847DE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 10:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612951710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ontaDL3XvHswihYEf1iBGmLwX9Q6quQQDImWbCzSgjA=;
 b=W+ZtDtESJ/g+SlT2S3JO4cKESIlpec5YEZUPEMZQLVZj/x49m/Uw9OOERlOjXgP+MdzPmb
 gJLAXq0VJkgkfeucGWFnrGIgQDAc6gsaaVXj0XnvJWv9RZa4ZdE9jfV9mBRRD9uAO56hUA
 iULKrDU0qUPNbqZlv3Rg6VAg6FjquLM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-xBw1u_saNlKIb185zB_FEQ-1; Wed, 10 Feb 2021 05:08:26 -0500
X-MC-Unique: xBw1u_saNlKIb185zB_FEQ-1
Received: by mail-ej1-f69.google.com with SMTP id eb5so2214950ejc.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 02:08:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ontaDL3XvHswihYEf1iBGmLwX9Q6quQQDImWbCzSgjA=;
 b=p7q/bCR62P1N+BPnxztTE8gIbcQSJraBX91SjwgyGEdy8bHupCKVjlM3MYXiCpzEEp
 oSv3Rmevo9xyVUYxTWzh+G4uzWy5qjoo0FVqWFYMPphczGEleQJ0JcUqyzSUuKMe6iFa
 txN/659PkSC9Lsp+oZkXkud3fN9fnq7UY3m+WkJ09krC8+M7HnjX2HFIr5WW9ywZzRIP
 kHzOMH9lVelgz5Rre6APcaKrbLUSbysIRwuQUd4BuL3YvFzKB3c1rhtVBrPdFNCj1wCW
 sxuvPxQg63QMGctp9UAglZGV5wKh6Y6eDr2daoPtLGQYAY4KBl1szHBdU3zZf2VvrF4z
 nrdA==
X-Gm-Message-State: AOAM531a0soFm8ZwpASOxDhF8udgibm5UiwWt13D0f0Rg0lkdoPgLX30
 9PHq0HLgl/1FPS6It8wfBLSFt9GAHa+A7AGiKIaQwSCAr79ngHnezN2sDr0DUoWWsJXE0Mb6P8H
 tmcOkzFPes1rAmI4YVrP/VrH5bRWNOWYTwu0s6GLElQ==
X-Received: by 2002:a05:6402:702:: with SMTP id
 w2mr2511044edx.78.1612951705281; 
 Wed, 10 Feb 2021 02:08:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0LU/mdAflFnADXNKIn3t7DOly8D6XltpB9BIjATe9vPTcbrofZaI6VVEMbq9k9xFmYLXzuA==
X-Received: by 2002:a05:6402:702:: with SMTP id
 w2mr2511028edx.78.1612951705069; 
 Wed, 10 Feb 2021 02:08:25 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id g9sm777753ejp.55.2021.02.10.02.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Feb 2021 02:08:24 -0800 (PST)
Date: Wed, 10 Feb 2021 11:08:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
Message-ID: <20210210100821.aaye2cgmrpwhhzgn@steredhat>
References: <20210208161741.104939-1-sgarzare@redhat.com>
 <20210208133312-mutt-send-email-mst@kernel.org>
 <fc523fbe-b742-0ebe-84d1-2b7e5529f00b@redhat.com>
 <20210209042530-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210209042530-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCBGZWIgMDksIDIwMjEgYXQgMDQ6MzE6MjNBTSAtMDUwMCwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+T24gVHVlLCBGZWIgMDksIDIwMjEgYXQgMTE6MjQ6MDNBTSArMDgwMCwgSmFz
b24gV2FuZyB3cm90ZToKPj4KPj4gT24gMjAyMS8yLzkg5LiK5Y2IMjozOCwgTWljaGFlbCBTLiBU
c2lya2luIHdyb3RlOgo+PiA+IE9uIE1vbiwgRmViIDA4LCAyMDIxIGF0IDA1OjE3OjQxUE0gKzAx
MDAsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPj4gPiA+IEl0J3MgbGVnYWwgdG8gaGF2ZSAn
b2Zmc2V0ICsgbGVuJyBlcXVhbCB0bwo+PiA+ID4gc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fbmV0X2Nv
bmZpZyksIHNpbmNlICduZGV2LT5jb25maWcnIGlzIGEKPj4gPiA+ICdzdHJ1Y3QgdmlydGlvX25l
dF9jb25maWcnLCBzbyB3ZSBjYW4gc2FmZWx5IGNvcHkgaXRzIGNvbnRlbnQgdW5kZXIKPj4gPiA+
IHRoaXMgY29uZGl0aW9uLgo+PiA+ID4KPj4gPiA+IEZpeGVzOiAxYTg2YjM3N2FhMjEgKCJ2ZHBh
L21seDU6IEFkZCBWRFBBIGRyaXZlciBmb3Igc3VwcG9ydGVkIG1seDUgZGV2aWNlcyIpCj4+ID4g
PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+PiA+ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFu
byBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+PiA+ID4gLS0tCj4+ID4gPiAgIGRy
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDIgKy0KPj4gPiA+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+ID4gPgo+PiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9t
bHg1L25ldC9tbHg1X3ZuZXQuYwo+PiA+ID4gaW5kZXggZGM4ODU1OWE4ZDQ5Li4xMGU5YjA5OTMy
ZWIgMTAwNjQ0Cj4+ID4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMK
Pj4gPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+PiA+ID4gQEAg
LTE4MjAsNyArMTgyMCw3IEBAIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9nZXRfY29uZmlnKHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50IG9mZnNldCwKPj4gPiA+ICAgCXN0cnVj
dCBtbHg1X3ZkcGFfZGV2ICptdmRldiA9IHRvX212ZGV2KHZkZXYpOwo+PiA+ID4gICAJc3RydWN0
IG1seDVfdmRwYV9uZXQgKm5kZXYgPSB0b19tbHg1X3ZkcGFfbmRldihtdmRldik7Cj4+ID4gPiAt
CWlmIChvZmZzZXQgKyBsZW4gPCBzaXplb2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnKSkKPj4g
PiA+ICsJaWYgKG9mZnNldCArIGxlbiA8PSBzaXplb2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmln
KSkKPj4gPiA+ICAgCQltZW1jcHkoYnVmLCAodTggKikmbmRldi0+Y29uZmlnICsgb2Zmc2V0LCBs
ZW4pOwo+PiA+ID4gICB9Cj4+ID4gQWN0dWFsbHkgZmlyc3QgSSBhbSBub3Qgc3VyZSB3ZSBuZWVk
IHRoZXNlIGNoZWNrcyBhdCBhbGwuCj4+ID4gdmhvc3RfdmRwYV9jb25maWdfdmFsaWRhdGUgYWxy
ZWFkeSB2YWxpZGF0ZXMgdGhlIHZhbHVlcywgcmlnaHQ/Cj4+Cj4+Cj4+IEkgdGhpbmsgdGhleSdy
ZSB3b3JraW5nIGF0IGRpZmZlcmVudCBsZXZlbHMuIFRoZXJlJ3Mgbm8gZ3VhcmFudGVlIHRoYXQK
Pj4gdmhvc3QtdmRwYSBpcyB0aGUgZHJpdmVyIGZvciB0aGlzIHZkcGEgZGV2aWNlLgo+Cj5JbiBm
YWN0LCBnZXRfY29uZmlnIHJldHVybnMgdm9pZCwgc28gdXNlcnNwYWNlIGNhbiBlYXNpbHkgZ2V0
Cj50cmFzaCBpZiBpdCBwYXNzZXMgaW5jb3JyZWN0IHBhcmFtZXRlcnMgYnkgbWlzdGFrZSwgdGhl
cmUgaXMKPm5vIHdheSBmb3IgdXNlcnNwYWNlIHRvIGZpbmQgb3V0IHdoZXRoZXIgdGhhdCBpcyB0
aGUgY2FzZSA6KAo+Cj5Bbnkgb2JqZWN0aW9ucyB0byByZXR1cm5pbmcgdGhlICMgb2YgYnl0ZXMg
Y29waWVkLCBvciAtMQo+b24gZXJyb3I/CgpNYWtlIHNlbnNlIGZvciBtZSwgYnV0IGFyZSB3ZSBz
dXJlIHdlIGRvbid0IGJyZWFrIHVzZXJzcGFjZSBpZiB3ZSByZXR1cm4gCnRoZSBudW1iZXIgb2Yg
Ynl0ZXMgaW5zdGVhZCBvZiAwIG9uIHN1Y2Nlc3M/CgpJIGhhZCBhIHF1aWNrIGxvb2sgYXQgUUVN
VSBhbmQgaXQgbG9va3MgbGlrZSB3ZSBjb25zaWRlciBzdWNjZXNzIGlmIHRoZSAKcmV0dXJuIHZh
bHVlIGlzID49IDAsIGJ1dCBJIG5lZWQgdG8gY2hlY2sgZnVydGhlci4KCj4KPj4KPj4gPgo+PiA+
IFNlY29uZCwgd2hhdCB3aWxsIGhhcHBlbiB3aGVuIHdlIGV4dGVuZCB0aGUgc3RydWN0IGFuZCB0
aGVuCj4+ID4gcnVuIG5ldyB1c2Vyc3BhY2Ugb24gYW4gb2xkIGtlcm5lbD8gTG9va3MgbGlrZSBp
dCB3aWxsIGp1c3QKPj4gPiBmYWlsIHJpZ2h0PyBTbyB3aGF0IGlzIHRoZSBwbGFuPwo+Pgo+Pgo+
PiBJbiB0aGlzIGNhc2UsIGdldF9jb25maWcoKSBzaG91bGQgbWF0Y2ggdGhlIHNwZWMgYmVoYXZp
b3VyLiBUaGF0IGlzIHRvIHNheQo+PiB0aGUgc2l6ZSBvZiBjb25maWcgc3BhY2UgZGVwZW5kcyBv
biB0aGUgZmVhdHVyZSBuZWdvdGlhdGVkLgo+Pgo+PiBUaGFua3MKPgo+WWVzIGJ1dCBzcGVjIHNh
eXMgY29uZmlnIHNwYWNlIGNhbiBiZSBiaWdnZXIgdGhhbiBzcGVjaWZpZWQgYnkgZmVhdHVyZXM6
Cj4KPglEcml2ZXJzIE1VU1QgTk9UIGxpbWl0IHN0cnVjdHVyZSBzaXplIGFuZCBkZXZpY2UgY29u
ZmlndXJhdGlvbiBzcGFjZSBzaXplLiBJbnN0ZWFkLCBkcml2ZXJzIFNIT1VMRCBvbmx5Cj4JY2hl
Y2sgdGhhdCBkZXZpY2UgY29uZmlndXJhdGlvbiBzcGFjZSBpcyBsYXJnZSBlbm91Z2ggdG8gY29u
dGFpbiB0aGUgZmllbGRzIG5lY2Vzc2FyeSBmb3IgZGV2aWNlIG9wZXJhdGlvbi4KPgoKU28gSUlV
QyBpbiB0aGUgZHJpdmVyIHdlIHNob3VsZCBjb3B5IGFzIG11Y2ggYXMgd2UgY2FuLgoKSWYgeW91
IGFncmVlLCBJIGNhbiBzZW5kIGFuIFJGQyBzZXJpZXMgYW5kIHdlIGNhbiBjb250aW51ZSB0aGUg
CmRpc2N1c3Npb24gb24gaXQsIGJ1dCBJIHRoaW5rIHdlIHNob3VsZCBxdWV1ZSB0aGlzIHBhdGNo
IGZvciBzdGFibGUgCmJyYW5jaGVzLgoKVGhhbmtzLApTdGVmYW5vCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
