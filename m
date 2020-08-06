Return-Path: <SRS0=OwTx=BQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4EFC433DF
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 11:08:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D5C221E2
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 11:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXnF2OTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D5C221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EC7CD86D16;
	Thu,  6 Aug 2020 05:58:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v8gqd7SHHxqY; Thu,  6 Aug 2020 05:58:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5BA8186BB1;
	Thu,  6 Aug 2020 05:58:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41AB7C0050;
	Thu,  6 Aug 2020 05:58:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7595FC004C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 05:58:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6E73B881B8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 05:58:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n-SLgR+fw+be
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 05:58:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D0A318819C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 05:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596693512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROash10duIpE/uRw8Y0foDvQjeHUSzvvXlunxpzl8MY=;
 b=eXnF2OTUlgY2XiovbugF45y5c1a2WFs3iZwo827UPde16znJGKaoX/UAYx99hUrbkb+mgF
 ZXpfKEN1Bu3UIRz5QUIaTUha6PfD2bYK5Zmhy9hEBWuAxXF/3X6we1NAXCkHHvsSem2GOU
 7knIj93w2NKYzEm2Qgj3SLYMz2mtf5c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-IeVa4Pq1P-ypDJZ7TR_NNw-1; Thu, 06 Aug 2020 01:58:31 -0400
X-MC-Unique: IeVa4Pq1P-ypDJZ7TR_NNw-1
Received: by mail-wr1-f72.google.com with SMTP id z1so14295822wrn.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 22:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ROash10duIpE/uRw8Y0foDvQjeHUSzvvXlunxpzl8MY=;
 b=mUfWTFPt1z+ib6pnCrUjT1PFCLqLOnCQlOBD9YqXJWLX/8SbGPl4ybWtOj8eZDuEc4
 DW2kD2MT5eRm9pUVGhcDYgMG8XMr/PwQYbkPqcOrNnwHGgbpJVuUuLVEYQ3VIKLA1NHm
 vjfh+v4YXOT9Z+h5f56FjdA+3XjzFhGNi8FFBUFjTRg213XoDU1tgyYbPXZxjqKlrTOq
 +OfOcQ8EpHc65H8CKqnfke8Ak+iKvCQlyMVBIuMfPJX56BCLVp5E6TW4UWDhWS5UfpnZ
 5NHXAM+FWgbTfb+afF0cZ4aOvnQZkyIbODLf1DYLy4cuJ95FvRexl6G4m98+fkA9tBF3
 OWkQ==
X-Gm-Message-State: AOAM531BMGM7VGxPnOrrRBUPLRy9kEMpNBaQy28f53nvnSyZAD+fpVfG
 MfpFCQoZzi8WGATcoWS1d9h0sRlCyZwMVyoP6t27fFrp3yV2ocTb8fDaWqWuG6gPmtwBRuEijI0
 V98GWZ+7QPI3iTaMqHVvJ5S1BG7QdOiVFdW3WQ7USOA==
X-Received: by 2002:a1c:59c2:: with SMTP id n185mr6644725wmb.104.1596693510110; 
 Wed, 05 Aug 2020 22:58:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMfTd+fQO/qWYVB46EsFXyAOA5C3DoglabIcYVWxoQ2qa+aefyPe9WQJEOfgniTDRJwIeZog==
X-Received: by 2002:a1c:59c2:: with SMTP id n185mr6644711wmb.104.1596693509935; 
 Wed, 05 Aug 2020 22:58:29 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id y17sm5492967wrh.63.2020.08.05.22.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 22:58:29 -0700 (PDT)
Date: Thu, 6 Aug 2020 01:58:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 03/24] virtio: allow __virtioXX, __leXX in config space
Message-ID: <20200806015604-mutt-send-email-mst@kernel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-4-mst@redhat.com>
 <ce85a206-45a6-da3d-45a7-06f068f3bad7@redhat.com>
 <20200805074434-mutt-send-email-mst@kernel.org>
 <4aa65ad6-5324-0a8c-0fa6-0d8e680f0706@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4aa65ad6-5324-0a8c-0fa6-0d8e680f0706@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gVGh1LCBBdWcgMDYsIDIwMjAgYXQgMTE6Mzc6MzhBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzgvNSDkuIvljYg3OjQ1LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6
Cj4gPiA+ID4gICAgI2RlZmluZSB2aXJ0aW9fY3JlYWQodmRldiwgc3RydWN0bmFtZSwgbWVtYmVy
LCBwdHIpCQkJXAo+ID4gPiA+ICAgIAlkbyB7CQkJCQkJCQlcCj4gPiA+ID4gICAgCQltaWdodF9z
bGVlcCgpOwkJCQkJCVwKPiA+ID4gPiAgICAJCS8qIE11c3QgbWF0Y2ggdGhlIG1lbWJlcidzIHR5
cGUsIGFuZCBiZSBpbnRlZ2VyICovCVwKPiA+ID4gPiAtCQlpZiAoIXR5cGVjaGVjayh0eXBlb2Yo
KCgoc3RydWN0bmFtZSopMCktPm1lbWJlcikpLCAqKHB0cikpKSBcCj4gPiA+ID4gKwkJaWYgKCFf
X3ZpcnRpb190eXBlY2hlY2soc3RydWN0bmFtZSwgbWVtYmVyLCAqKHB0cikpKQlcCj4gPiA+ID4g
ICAgCQkJKCpwdHIpID0gMTsJCQkJCVwKPiA+ID4gQSBzaWxseSBxdWVzdGlvbizCoCBjb21wYXJl
IHRvIHVzaW5nIHNldCgpL2dldCgpIGRpcmVjdGx5LCB3aGF0J3MgdGhlIHZhbHVlCj4gPiA+IG9m
IHRoZSBhY2Nlc3NvcnMgbWFjcm8gaGVyZT8KPiA+ID4gCj4gPiA+IFRoYW5rcwo+ID4gZ2V0L3Nl
dCBkb24ndCBjb252ZXJ0IHRvIHRoZSBuYXRpdmUgZW5kaWFuLCBJIGd1ZXNzIHRoYXQncyB3aHkK
PiA+IGRyaXZlcnMgdXNlIGNyZWFkL2N3cml0ZS4gSXQgaXMgYWxzbyBuaWNlIHRoYXQgdGhlcmUn
cyB0eXBlCj4gPiBzYWZldHksIGNoZWNraW5nIHRoZSBjb3JyZWN0IGludGVnZXIgd2lkdGggaXMg
dXNlZC4KPiAKPiAKPiBZZXMsIGJ1dCB0aGlzIGlzIHNpbXBseSBiZWNhdXNlIGEgbWFjcm8gaXMg
dXNlZCBoZXJlLCBob3cgYWJvdXQganVzdCBkb2luZwo+IHRoaW5ncyBzaW1pbGFyIGxpa2Ugdmly
dGlvX2NyZWFkX2J5dGVzKCk6Cj4gCj4gc3RhdGljIGlubGluZSB2b2lkIHZpcnRpb19jcmVhZChz
dHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwKPiDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAg
wqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+IMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKg
wqDCoCDCoMKgwqDCoMKgIHZvaWQgKmJ1Ziwgc2l6ZV90IGxlbikKPiAKPiAKPiBBbmQgZG8gdGhl
IGVuZGlhbiBjb252ZXJzaW9uIGluc2lkZT8KPiAKPiBUaGFua3MKPiAKClRoZW4geW91IGxvc2Ug
dHlwZSBzYWZldHkuIEl0J3MgdmVyeSBlYXN5IHRvIGhhdmUgYW4gbGUzMiBmaWVsZAphbmQgdHJ5
IHRvIHJlYWQgaXQgaW50byBhIHUxNiBieSBtaXN0YWtlLgoKVGhlc2UgbWFjcm9zIGFyZSBhbGwg
YWJvdXQgcHJldmVudGluZyBidWdzOiBhbmQgdGhlIHdob2xlIHBhdGNoc2V0CmlzIGFib3V0IHNl
dmVyYWwgYnVncyBzcGFyc2UgZm91bmQgLSB0aGF0IGlzIHdoYXQgcHJvbXB0ZWQgbWUgdG8gbWFr
ZQp0eXBlIGNoZWNrcyBtb3JlIHN0cmljdC4KCgo+ID4gCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
