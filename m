Return-Path: <SRS0=EPK4=D2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6362C433DF
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 16:42:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C5321D81
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 16:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgsct9nV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C5321D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 857538740C;
	Mon, 19 Oct 2020 16:42:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2BKJIGvlFynb; Mon, 19 Oct 2020 16:41:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E42A687132;
	Mon, 19 Oct 2020 16:41:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4B00C088B;
	Mon, 19 Oct 2020 16:41:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C01AEC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 16:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AE0318740C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 16:41:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f2DLZiiyfk11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 16:41:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A9A4287132
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 16:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603125714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2P0pw/kzhOqfVzEX3jZqFUZx91Pd6FC/rbDYJMSaPTM=;
 b=dgsct9nVv8+RZ6mTNzlvuTVrXGrNJ3KGCO97MWdBMC5GDzbtxQAeNPj4TkGXNnhooIV7Nn
 97ArvGfY0RiA3xOMk1YxRAQzfUREz+g+igZVG1EcqC8LqmOJ0HOeByCvPjiYRW4l6G4veG
 Cb7DxrYO1woY+3ndtTB8BCl7qeOTl2Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-gevb6m6hOMS7wmLQ5Fv1vw-1; Mon, 19 Oct 2020 12:41:52 -0400
X-MC-Unique: gevb6m6hOMS7wmLQ5Fv1vw-1
Received: by mail-wm1-f72.google.com with SMTP id w23so48679wmi.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 09:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=2P0pw/kzhOqfVzEX3jZqFUZx91Pd6FC/rbDYJMSaPTM=;
 b=fsTdR5mPTKA2YbLA79G05Q+TxM+2omRRLKwfyA8dgbMjcJB6vwXI31h9FwqiXIRRTh
 1MjQtBWIgeHPsFCJXiUE214RsyjBEWx/j6xnaZe1kS7Nx0hUnHNNYhCqUCvEyvdCLG1R
 /yQ/YZUgD7v8NSZb+pbUid41ENEdMWTSu19iYiTREe4qWRpjNMkoUAfk3RIdpesmArz7
 vL5o7EcP3msFT2t0i2Kefy+MMuqexAcaWpJ/bz/q2+cit05lydOIUs/qF7/Fz0WQ48qv
 d+SGNwUWUD0WxZOFtxeb1E8pECS6BQXF34IQ8eBK8H6uSAGOtG/lp8kntTs4C3Ddvqy8
 wEQg==
X-Gm-Message-State: AOAM533GfPtJnAxutQ3TufrJm7Cv/t+xLJlaHQh7lZ1X0Bkr0ksB48/2
 W0BmrJi91ba1irgybWOwBjsX1sV4rgsE9xVUnVDNEWrVKi/Go3VVWsZDy5jsx9wWpqKqjLFcuVH
 aora/gCMeazsRJd1RIX3JCzDpzLbTtNVw8ZjLNXoqVw==
X-Received: by 2002:a7b:c10c:: with SMTP id w12mr53137wmi.175.1603125711224;
 Mon, 19 Oct 2020 09:41:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjcPNvNqsWyP0ZXdUmTiirpahsBYEQJjj/jdob5g+omUBG5HGzG6dUx96aoOXSZVVV9sNK5Q==
X-Received: by 2002:a7b:c10c:: with SMTP id w12mr53127wmi.175.1603125711047;
 Mon, 19 Oct 2020 09:41:51 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id 4sm324356wrp.58.2020.10.19.09.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 09:41:49 -0700 (PDT)
Date: Mon, 19 Oct 2020 12:41:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?6LCi5rC45ZCJ?= <xieyongji@bytedance.com>
Subject: Re: [External] Re: [RFC 3/4] vduse: grab the module's references
 until there is no vduse device
Message-ID: <20201019123835-mutt-send-email-mst@kernel.org>
References: <20201019145623.671-1-xieyongji@bytedance.com>
 <20201019145623.671-4-xieyongji@bytedance.com>
 <20201019110359-mutt-send-email-mst@kernel.org>
 <CACycT3sQ-rw+weEktyK5jQTfMNWYR6qSaD1vAUEyCP6x7C9rRQ@mail.gmail.com>
 <20201019114701-mutt-send-email-mst@kernel.org>
 <CACycT3vG+ZEhn3SYy=7c5rkMz4XRbQZL21NdpPozPnH_x6Srhg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3vG+ZEhn3SYy=7c5rkMz4XRbQZL21NdpPozPnH_x6Srhg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
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

T24gTW9uLCBPY3QgMTksIDIwMjAgYXQgMTE6NTY6MzVQTSArMDgwMCwg6LCi5rC45ZCJIHdyb3Rl
Ogo+IAo+IAo+IAo+IE9uIE1vbiwgT2N0IDE5LCAyMDIwIGF0IDExOjQ3IFBNIE1pY2hhZWwgUy4g
VHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+IAo+ICAgICBPbiBNb24sIE9jdCAxOSwg
MjAyMCBhdCAxMTo0NDozNlBNICswODAwLCDosKLmsLjlkIkgd3JvdGU6Cj4gICAgID4KPiAgICAg
Pgo+ICAgICA+IE9uIE1vbiwgT2N0IDE5LCAyMDIwIGF0IDExOjA1IFBNIE1pY2hhZWwgUy4gVHNp
cmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4gICAgIHdyb3RlOgo+ICAgICA+Cj4gICAgID7CoCDCoCDC
oE9uIE1vbiwgT2N0IDE5LCAyMDIwIGF0IDEwOjU2OjIyUE0gKzA4MDAsIFhpZSBZb25namkgd3Jv
dGU6Cj4gICAgID7CoCDCoCDCoD4gVGhlIG1vZHVsZSBzaG91bGQgbm90IGJlIHVubG9hZGVkIGlm
IGFueSB2ZHVzZSBkZXZpY2UgZXhpc3RzLgo+ICAgICA+wqAgwqAgwqA+IFNvIGluY3JlYXNlIHRo
ZSBtb2R1bGUncyByZWZlcmVuY2UgY291bnQgd2hlbiBjcmVhdGluZyB2ZHVzZQo+ICAgICA+wqAg
wqAgwqA+IGRldmljZS4gQW5kIHRoZSByZWZlcmVuY2UgY291bnQgaXMga2VwdCB1bnRpbCB0aGUg
ZGV2aWNlIGlzCj4gICAgID7CoCDCoCDCoD4gZGVzdHJveWVkLgo+ICAgICA+wqAgwqAgwqA+Cj4g
ICAgID7CoCDCoCDCoD4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8eGlleW9uZ2ppQGJ5dGVk
YW5jZS5jb20+Cj4gICAgID7CoCDCoCDCoD4gLS0tCj4gICAgID7CoCDCoCDCoD7CoCBkcml2ZXJz
L3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jIHwgMiArKwo+ICAgICA+wqAgwqAgwqA+wqAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+ICAgICA+wqAgwqAgwqA+Cj4gICAgID7CoCDC
oCDCoD4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMgYi9k
cml2ZXJzL3ZkcGEvCj4gICAgIHZkcGFfdXNlci8KPiAgICAgPsKgIMKgIMKgdmR1c2VfZGV2LmMK
PiAgICAgPsKgIMKgIMKgPiBpbmRleCA2Nzg3YmE2NjcyNWMuLmYwNGFhMDJkZThjMSAxMDA2NDQK
PiAgICAgPsKgIMKgIMKgPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5j
Cj4gICAgID7CoCDCoCDCoD4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYu
Ywo+ICAgICA+wqAgwqAgwqA+IEBAIC04ODcsNiArODg3LDcgQEAgc3RhdGljIGludCB2ZHVzZV9k
ZXN0cm95X2Rldih1MzIgaWQpCj4gICAgID7CoCDCoCDCoD7CoCDCoCDCoCDCoGtmcmVlKGRldi0+
dnFzKTsKPiAgICAgPsKgIMKgIMKgPsKgIMKgIMKgIMKgdmR1c2VfaW92YV9kb21haW5fZGVzdHJv
eShkZXYtPmRvbWFpbik7Cj4gICAgID7CoCDCoCDCoD7CoCDCoCDCoCDCoHZkdXNlX2Rldl9kZXN0
cm95KGRldik7Cj4gICAgID7CoCDCoCDCoD4gK8KgIMKgIMKgbW9kdWxlX3B1dChUSElTX01PRFVM
RSk7Cj4gICAgID7CoCDCoCDCoD7CoAo+ICAgICA+wqAgwqAgwqA+wqAgwqAgwqAgwqByZXR1cm4g
MDsKPiAgICAgPsKgIMKgIMKgPsKgIH0KPiAgICAgPsKgIMKgIMKgPiBAQCAtOTMxLDYgKzkzMiw3
IEBAIHN0YXRpYyBpbnQgdmR1c2VfY3JlYXRlX2RldihzdHJ1Y3QKPiAgICAgdmR1c2VfZGV2X2Nv
bmZpZwo+ICAgICA+wqAgwqAgwqAqY29uZmlnKQo+ICAgICA+wqAgwqAgwqA+wqAKPiAgICAgPsKg
IMKgIMKgPsKgIMKgIMKgIMKgZGV2LT5jb25uZWN0ZWQgPSB0cnVlOwo+ICAgICA+wqAgwqAgwqA+
wqAgwqAgwqAgwqBsaXN0X2FkZCgmZGV2LT5saXN0LCAmdmR1c2VfZGV2cyk7Cj4gICAgID7CoCDC
oCDCoD4gK8KgIMKgIMKgX19tb2R1bGVfZ2V0KFRISVNfTU9EVUxFKTsKPiAgICAgPsKgIMKgIMKg
PsKgCj4gICAgID7CoCDCoCDCoD7CoCDCoCDCoCDCoHJldHVybiBmZDsKPiAgICAgPsKgIMKgIMKg
PsKgIGVycl9mZDoKPiAgICAgPgo+ICAgICA+wqAgwqAgwqBUaGlzIGtpbmQgb2YgdGhpbmcgaXMg
dXN1YWxseSBhbiBpbmRpY2F0b3Igb2YgYSBidWcuIEUuZy4KPiAgICAgPsKgIMKgIMKgaWYgdGhl
IHJlZmNvdW50IGRyb3BzIHRvIDAgb24gbW9kdWxlX3B1dChUSElTX01PRFVMRSkgaXQKPiAgICAg
PsKgIMKgIMKgd2lsbCBiZSB1bmxvYWRlZCBhbmQgdGhlIGZvbGxvd2luZyByZXR1cm4gd2lsbCBu
b3QgcnVuLgo+ICAgICA+Cj4gICAgID4KPiAgICAgPgo+ICAgICA+IFNob3VsZCB0aGlzIGhhcHBl
bj/CoCBUaGUgcmVmY291bnQgc2hvdWxkIGJlIG9ubHkgZGVjcmVhc2VkIHRvIDAgYWZ0ZXIgdGhl
Cj4gICAgID4gbWlzY19kZXZpY2UgaXMgY2xvc2VkPwo+ICAgICA+Cj4gICAgID4gVGhhbmtzLAo+
ICAgICA+IFlvbmdqaQo+ICAgICA+Cj4gCj4gICAgIE9UT0ggaWYgaXQgbmV2ZXIgZHJvcHMgdG8g
MCBhbnl3YXkgdGhlbiB3aHkgZG8geW91IG5lZWQgdG8gaW5jcmVhc2UgaXQ/Cj4gCj4gCj4gCj4g
VG8gcHJldmVudCB1bmxvYWRpbmcgdGhlIG1vZHVsZSBpbiB0aGUgY2FzZSB0aGF0IHRoZSBkZXZp
Y2UgaXMgY3JlYXRlZCwgYnV0IG5vCj4gdXNlciBwcm9jZXNzIHVzaW5nIGl0IChlLmcuIHRoZSB1
c2VyIHByb2Nlc3MgY3Jhc2hlZCkuwqAKPiAKPiBUaGFua3MsCj4gWW9uZ2ppCgpMb29rcyBsaWtl
IGl0IGNhbiBkcm9wIHRvIDAgaWYgdGhhdCBpcyB0aGUgY2FzZSB0aGVuPwoKCj4gCj4gICAgID4K
PiAgICAgPgo+ICAgICA+wqAgwqAgwqA+IC0tCj4gICAgID7CoCDCoCDCoD4gMi4yNS4xCj4gICAg
ID4KPiAgICAgPgo+IAo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
