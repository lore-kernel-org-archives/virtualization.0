Return-Path: <SRS0=dJY/=FV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC42C4361B
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 07:58:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA7123434
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 07:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA7123434
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3D0748754E;
	Thu, 17 Dec 2020 07:58:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H4sJF5EDMe1p; Thu, 17 Dec 2020 07:58:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5BFC187542;
	Thu, 17 Dec 2020 07:58:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CFF8C088E;
	Thu, 17 Dec 2020 07:58:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69E94C013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 07:58:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5320087547
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 07:58:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z-3KRrlo0AW7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 07:58:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B9DE987542
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 07:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608191926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JmBCaUjbHLpjmsXXP5mR8OruWxjhXsJuZma5+OS6WPo=;
 b=cDNDsBFZVz9tcpTaqeS6JCotEBO+KadpvJXNNlXc9Eu0ibrHnP+U5vHVuaW0NaIuaz3kb2
 cKKsGy1hl9KkfN2Jo3uDhrFsqyTgX5aHZa1296ohEkFDwpW8jQk/eqWJCpdPN2ILd1MtOb
 ovfV/De/9xRPlMmRNIogCtQC3uJ11FI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-5j0XCnVFNfKNhPr95cE4QA-1; Thu, 17 Dec 2020 02:58:44 -0500
X-MC-Unique: 5j0XCnVFNfKNhPr95cE4QA-1
Received: by mail-wm1-f72.google.com with SMTP id w204so2747231wmb.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 23:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=JmBCaUjbHLpjmsXXP5mR8OruWxjhXsJuZma5+OS6WPo=;
 b=Vr0lC01bAJmolibcJ3Nq+D4LrwjJjZlCe7cjP/qCfYn9PtBW59LRbE6xYPJcCbg4I9
 rL9GA+una92U4sRRPyL2uEup5EvR11c0MOWgherwW1ZPwXHbADOULq3e35NsqArbpQOj
 pcEBrMz8zFM2SG3P/U0jycu1VlOz0+Ei2TG5K+Kx4zFTUY8VzmSbuUq8BFXxrfQKupZr
 squfcutgaqYU/WpZXoU1fnVnACLLHxz+RA41de8oXZk6RuwXx9INBLhXHtacmrhaR7CC
 zTj5fvlIJgwxv2q9lk4DFZESliUNCveNoRz540wWSMrG/Mmp2WO5UnrzJ6CqYDDkZpCq
 VHNQ==
X-Gm-Message-State: AOAM5311xfisZuMeYvF1WBla7Wy7kMo8wcmu+wvGO4LAM0cCaNd49Wgx
 EyELOKy1jlxtoZwSepvZ9StuuQyiDi4SNCyRBK1a45zhocQbKKlIA3vwT+PCubk5/Moi0QgVDbT
 glFrqFfdrr51yxPmHdoMpSoLP7EA/fc6Uwx6xEKfCKw==
X-Received: by 2002:a1c:2155:: with SMTP id h82mr7121031wmh.132.1608191923188; 
 Wed, 16 Dec 2020 23:58:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhEUK8QeXERK5SumhSOpAygm9J8Ze/SsCUqZ/IdpzrStxMOOBC7oYG4r9hpI2MahKfIwFPxg==
X-Received: by 2002:a1c:2155:: with SMTP id h82mr7121011wmh.132.1608191922870; 
 Wed, 16 Dec 2020 23:58:42 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id a65sm6701518wmc.35.2020.12.16.23.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Dec 2020 23:58:41 -0800 (PST)
Date: Thu, 17 Dec 2020 02:58:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 00/21] Control VQ support in vDPA
Message-ID: <20201217025410-mutt-send-email-mst@kernel.org>
References: <20201216064818.48239-1-jasowang@redhat.com>
 <20201216044051-mutt-send-email-mst@kernel.org>
 <aa061fcb-9395-3a1b-5d6e-76b5454dfb6c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <aa061fcb-9395-3a1b-5d6e-76b5454dfb6c@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, lulu@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com, eli@mellanox.com,
 lingshan.zhu@intel.com, rob.miller@broadcom.com
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

T24gVGh1LCBEZWMgMTcsIDIwMjAgYXQgMTE6MzA6MThBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzEyLzE2IOS4i+WNiDU6NDcsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90
ZToKPiA+IE9uIFdlZCwgRGVjIDE2LCAyMDIwIGF0IDAyOjQ3OjU3UE0gKzA4MDAsIEphc29uIFdh
bmcgd3JvdGU6Cj4gPiA+IEhpIEFsbDoKPiA+ID4gCj4gPiA+IFRoaXMgc2VyaWVzIHRyaWVzIHRv
IGFkZCB0aGUgc3VwcG9ydCBmb3IgY29udHJvbCB2aXJ0cXVldWUgaW4gdkRQQS4KPiA+ID4gCj4g
PiA+IENvbnRyb2wgdmlydHF1ZXVlIGlzIHVzZWQgYnkgbmV0d29ya2luZyBkZXZpY2UgZm9yIGFj
Y2VwdGluZyB2YXJpb3VzCj4gPiA+IGNvbW1hbmRzIGZyb20gdGhlIGRyaXZlci4gSXQncyBhIG11
c3QgdG8gc3VwcG9ydCBtdWx0aXF1ZXVlIGFuZCBvdGhlcgo+ID4gPiBjb25maWd1cmF0aW9ucy4K
PiA+ID4gCj4gPiA+IFdoZW4gdXNlZCBieSB2aG9zdC12RFBBIGJ1cyBkcml2ZXIgZm9yIFZNLCB0
aGUgY29udHJvbCB2aXJ0cXVldWUKPiA+ID4gc2hvdWxkIGJlIHNoYWRvd2VkIHZpYSB1c2Vyc3Bh
Y2UgVk1NIChRZW11KSBpbnN0ZWFkIG9mIGJlaW5nIGFzc2lnbmVkCj4gPiA+IGRpcmVjdGx5IHRv
IEd1ZXN0LiBUaGlzIGlzIGJlY2F1c2UgUWVtdSBuZWVkcyB0byBrbm93IHRoZSBkZXZpY2Ugc3Rh
dGUKPiA+ID4gaW4gb3JkZXIgdG8gc3RhcnQgYW5kIHN0b3AgZGV2aWNlIGNvcnJlY3RseSAoZS5n
IGZvciBMaXZlIE1pZ3JhdGlvbikuCj4gPiA+IAo+ID4gPiBUaGlzIHJlcXVpZXMgdG8gaXNvbGF0
ZSB0aGUgbWVtb3J5IG1hcHBpbmcgZm9yIGNvbnRyb2wgdmlydHF1ZXVlCj4gPiA+IHByZXNlbnRl
ZCBieSB2aG9zdC12RFBBIHRvIHByZXZlbnQgZ3Vlc3QgZnJvbSBhY2Nlc2luZyBpdCBkaXJlY3Rs
eS4KPiA+ID4gVG8gYWNoaWV2ZSB0aGlzLCB2RFBBIGludHJvZHVjZSB0d28gbmV3IGFic3RyYWN0
aW9uczoKPiA+ID4gCj4gPiA+IC0gYWRkcmVzcyBzcGFjZTogaWRlbnRpZmllZCB0aHJvdWdoIGFk
ZHJlc3Mgc3BhY2UgaWQgKEFTSUQpIGFuZCBhIHNldAo+ID4gPiAgICAgICAgICAgICAgICAgICBv
ZiBtZW1vcnkgbWFwcGluZyBpbiBtYWludGFpbmVkCj4gPiA+IC0gdmlydHF1ZXVlIGdyb3VwOiB0
aGUgbWluaW1hbCBzZXQgb2YgdmlydHF1ZXVlcyB0aGF0IG11c3Qgc2hhcmUgYW4KPiA+ID4gICAg
ICAgICAgICAgICAgICAgYWRkcmVzcyBzcGFjZQo+ID4gSG93IHdpbGwgdGhpcyBzdXBwb3J0IHRo
ZSBwcmV0dHkgY29tbW9uIGNhc2Ugd2hlcmUgY29udHJvbCB2cQo+ID4gaXMgcHJvZ3JhbW1lZCBi
eSB0aGUga2VybmVsIHRocm91Z2ggdGhlIFBGLCBhbmQgb3RoZXJzIGJ5IHRoZSBWRnM/Cj4gCj4g
Cj4gSW4gdGhpcyBjYXNlLCB0aGUgVkYgcGFyZW50IG5lZWQgdG8gcHJvdmlkZSBhIHNvZnR3YXJl
IGNvbnRyb2wgdnEgYW5kIGRlY29kZQo+IHRoZSBjb21tYW5kIHRoZW4gc2VuZCB0aGVtIHRvIFZG
LgoKCkJ1dCBob3cgZG9lcyB0aGF0IHRpZSB0byB0aGUgYWRkcmVzcyBzcGFjZSBpbmZyYXN0cnVj
dHVyZT8KCgoKPiAKPiA+IAo+ID4gCj4gPiBJIGFjdHVhbGx5IHRob3VnaHQgdGhlIHdheSB0byBz
dXBwb3J0IGl0IGlzIGJ5IGV4cG9zaW5nCj4gPiBzb21ldGhpbmcgbGlrZSBhbiAiaW5qZWN0IGJ1
ZmZlcnMiIEFQSSB3aGljaCBzZW5kcyBkYXRhIHRvIGEgZ2l2ZW4gVlEuCj4gPiBNYXliZSBhbiBp
b2N0bCwgYW5kIG1heWJlIGRvd24gdGhlIHJvYWQgdWlvIHJpbmcgY2FuIHN1cHBvcnQgYmF0Y2hp
bmcKPiA+IHRoZXNlIC4uLi4KPiAKPiAKPiBTbyB0aGUgdmlydHVxdWV1ZSBhbGxvd3MgdGhlIHJl
cXVlc3QgdG8gYmUgcHJvY2Vzc2VkIGFzeW5jaHJvbm91c2x5IChlLmcKPiBkcml2ZXIgbWF5IGNo
b29zZSB0byB1c2UgaW50ZXJydXB0IGZvciBjb250cm9sIHZxKS4gVGhpcyBtZWFucyB3ZSBuZWVk
IHRvCj4gc3VwcG9ydCB0aGF0IGluIHVBUEkgbGV2ZWwuCgpJIGRvbid0IHRoaW5rIHdlIG5lZWQg
dG8gbWFrZSBpdCBhc3luYywganVzdCBhIHJlZ3VsYXIgaW9jdGwgd2lsbCBkby4KSW4gZmFjdCBu
byBndWVzdCB1c2VzIHRoZSBhc3luY2hyb25vdXMgcHJvcGVydHkuCgoKPiBBbmQgaWYgd2UgbWFu
YWdlIHRvIGRvIHRoYXQsIGl0J3MganVzdCBhbm90aGVyCj4gdHlwZSBvZiB2aXJ0cXVldWUuCj4g
Cj4gRm9yIHZpcnRpby12RFBBLCB0aGlzIGFsc28gbWVhbnMgdGhlIGV4dGVuc2lvbnMgZm9yIHF1
ZXVlIHByb2Nlc3Npbmcgd2hpY2gKPiBpcyBhIGZ1bmN0aW9uYWwgZHVwbGljYXRpb24uCgpJIGRv
bid0IHNlZSB3aHksIGp1c3Qgc2VuZCBpdCB0byB0aGUgYWN0dWFsIGNvbnRyb2wgdnEgOikKCj4g
VXNpbmcgd2hhdCBwcm9wb3NlZCBpbiB0aGlzIHNlcmllcywgd2UgZG9uJ3QKPiBuZWVkIGFueSBj
aGFuZ2VzIGZvciBrZXJuZWwgdmlydGlvIGRyaXZlcnMuCj4gCj4gV2hhdCdzIG1vcmUgaW1wb3J0
YW50LCB0aGlzIHNlcmllcyBjb3VsZCBiZSB1c2VkIGZvciBmdXR1cmUgZmVhdHVyZXMgdGhhdAo+
IHJlcXVpcmVzIERNQSBpc29sYXRpb24gYmV0d2VlbiB2aXJ0cXVldWVzOgo+IAo+IC0gcmVwb3J0
IGRpcnR5IHBhZ2VzIHZpYSB2aXJ0cXVldWUKPiAtIHN1YiBmdW5jdGlvbiBsZXZlbCBkZXZpY2Ug
c2xpY2luZwoKCkkgYWdyZWUgdGhlc2UgYXJlIG5pY2UgdG8gaGF2ZSwgYnV0IEkgYW0gbm90IHN1
cmUgYmFzaWMgY29udHJvbCB2cSBtdXN0CmJlIHRpZWQgdG8gdGhhdC4KCj4gLi4uCj4gCj4gVGhh
bmtzCj4gCj4gCj4gPiAKPiA+IAo+ID4gPiBEZXZpY2UgbmVlZHMgdG8gYWR2ZXJ0aXNlIHRoZSBm
b2xsb3dpbmcgYXR0cmlidXRlcyB0byB2RFBBOgo+ID4gPiAKPiA+ID4gLSB0aGUgbnVtYmVyIG9m
IGFkZHJlc3Mgc3BhY2VzIHN1cHBvcnRlZCBpbiB0aGUgZGV2aWNlCj4gPiA+IC0gdGhlIG51bWJl
ciBvZiB2aXJ0cXVldWUgZ3JvdXBzIHN1cHBvcnRlZCBpbiB0aGUgZGV2aWNlCj4gPiA+IC0gdGhl
IG1hcHBpbmdzIGZyb20gYSBzcGVjaWZpYyB2aXJ0cXVldWUgdG8gaXRzIHZpcnRxdWV1ZSBncm91
cHMKPiA+ID4gCj4gPiA+IFRoZSBtYXBwaW5ncyBmcm9tIHZpcnRxdWV1ZSB0byB2aXJ0cXVldWUg
Z3JvdXBzIGlzIGZpeGVkIGFuZCBkZWZpbmVkCj4gPiA+IGJ5IHZEUEEgZGV2aWNlIGRyaXZlci4g
RS5nOgo+ID4gPiAKPiA+ID4gLSBGb3IgdGhlIGRldmljZSB0aGF0IGhhcyBoYXJkd2FyZSBBU0lE
IHN1cHBvcnQsIGl0IGNhbiBzaW1wbHkKPiA+ID4gICAgYWR2ZXJ0aXNlIGEgcGVyIHZpcnRxdWV1
ZSB2aXJ0cXVldWUgZ3JvdXAuCj4gPiA+IC0gRm9yIHRoZSBkZXZpY2UgdGhhdCBkb2VzIG5vdCBo
YXZlIGhhcmR3YXJlIEFTSUQgc3VwcG9ydCwgaXQgY2FuCj4gPiA+ICAgIHNpbXBseSBhZHZlcnRp
c2UgYSBzaW5nbGUgdmlydHF1ZXVlIGdyb3VwIHRoYXQgY29udGFpbnMgYWxsCj4gPiA+ICAgIHZp
cnRxdWV1ZXMuIE9yIGlmIGl0IHdhbnRzIGEgc29mdHdhcmUgZW11bGF0ZWQgY29udHJvbCB2aXJ0
cXVldWUsIGl0Cj4gPiA+ICAgIGNhbiBhZHZlcnRpc2UgdHdvIHZpcnRxdWV1ZSBncm91cHMsIG9u
ZSBpcyBmb3IgY3ZxLCBhbm90aGVyIGlzIGZvcgo+ID4gPiAgICB0aGUgcmVzdCB2aXJ0cXVldWVz
Lgo+ID4gPiAKPiA+ID4gdkRQQSBhbHNvIGFsbG93IHRvIGNoYW5nZSB0aGUgYXNzb2NpYXRpb24g
YmV0d2VlbiB2aXJ0cXVldWUgZ3JvdXAgYW5kCj4gPiA+IGFkZHJlc3Mgc3BhY2UuIFNvIGluIHRo
ZSBjYXNlIG9mIGNvbnRyb2wgdmlydHF1ZXVlLCB1c2Vyc3BhY2UKPiA+ID4gVk1NKFFlbXUpIG1h
eSB1c2UgYSBkZWRpY2F0ZWQgYWRkcmVzcyBzcGFjZSBmb3IgdGhlIGNvbnRyb2wgdmlydHF1ZXVl
Cj4gPiA+IGdyb3VwIHRvIGlzb2xhdGUgdGhlIG1lbW9yeSBtYXBwaW5nLgo+ID4gPiAKPiA+ID4g
VGhlIHZob3N0L3Zob3N0LXZEUEEgaXMgYWxzbyBleHRlbmQgZm9yIHRoZSB1c2Vyc3BhY2UgdG86
Cj4gPiA+IAo+ID4gPiAtIHF1ZXJ5IHRoZSBudW1iZXIgb2YgdmlydHF1ZXVlIGdyb3VwcyBhbmQg
YWRkcmVzcyBzcGFjZXMgc3VwcG9ydGVkIGJ5Cj4gPiA+ICAgIHRoZSBkZXZpY2UKPiA+ID4gLSBx
dWVyeSB0aGUgdmlydHF1ZXVlIGdyb3VwIGZvciBhIHNwZWNpZmljIHZpcnRxdWV1ZQo+ID4gPiAt
IGFzc29jYWl0ZSBhIHZpcnRxdWV1ZSBncm91cCB3aXRoIGFuIGFkZHJlc3Mgc3BhY2UKPiA+ID4g
LSBzZW5kIEFTSUQgYmFzZWQgSU9UTEIgY29tbWFuZHMKPiA+ID4gCj4gPiA+IFRoaXMgd2lsbCBo
ZWxwIHVzZXJzcGFjZSBWTU0oUWVtdSkgdG8gZGV0ZWN0IHdoZXRoZXIgdGhlIGNvbnRyb2wgdnEK
PiA+ID4gY291bGQgYmUgc3VwcG9ydGVkIGFuZCBpc29sYXRlIG1lbW9yeSBtYXBwaW5ncyBvZiBj
b250cm9sIHZpcnRxdWV1ZQo+ID4gPiBmcm9tIHRoZSBvdGhlcnMuCj4gPiA+IAo+ID4gPiBUbyBk
ZW1vbnN0cmF0ZSB0aGUgdXNhZ2UsIHZEUEEgc2ltdWxhdG9yIGlzIGV4dGVuZGVkIHRvIHN1cHBv
cnQKPiA+ID4gc2V0dGluZyBNQUMgYWRkcmVzcyB2aWEgYSBlbXVsYXRlZCBjb250cm9sIHZpcnRx
dWV1ZS4KPiA+ID4gCj4gPiA+IFBsZWFzZSByZXZpZXcuCj4gPiA+IAo+ID4gPiBDaGFuZ2VzIHNp
bmNlIFJGQzoKPiA+ID4gCj4gPiA+IC0gdHdlYWsgdmhvc3QgdUFQSSBkb2N1bWVudGF0aW9uCj4g
PiA+IC0gc3dpdGNoIHRvIHVzZSBkZXZpY2Ugc3BlY2lmaWMgSU9UTEIgcmVhbGx5IGluIHBhdGNo
IDQKPiA+ID4gLSB0d2VhayB0aGUgY29tbWl0IGxvZwo+ID4gPiAtIGZpeCB0aGF0IEFTSUQgaW4g
dmhvc3QgaXMgY2xhaW1lZCB0byBiZSAzMiBhY3R1YWxseSBidXQgMTZiaXQKPiA+ID4gICAgYWN0
dWFsbHkKPiA+ID4gLSBmaXggdXNlIGFmdGVyIGZyZWUgd2hlbiB1c2luZyBBU0lEIHdpdGggSU9U
TEIgYmF0Y2hpbmcgcmVxdWVzdHMKPiA+ID4gLSBzd2l0Y2ggdG8gdXNlIFN0ZWZhbm8ncyBwYXRj
aCBmb3IgaGF2aW5nIHNlcGFyYXRlZCBpb3YKPiA+ID4gLSByZW1vdmUgdW51c2VkICJ1c2VkX2Fz
IiB2YXJpYWJsZQo+ID4gPiAtIGZpeCB0aGUgaW90bGIvYXNpZCBjaGVja2luZyBpbiB2aG9zdF92
ZHBhX3VubWFwKCkKPiA+ID4gCj4gPiA+IFRoYW5rcwo+ID4gPiAKPiA+ID4gSmFzb24gV2FuZyAo
MjApOgo+ID4gPiAgICB2aG9zdDogbW92ZSB0aGUgYmFja2VuZCBmZWF0dXJlIGJpdHMgdG8gdmhv
c3RfdHlwZXMuaAo+ID4gPiAgICB2aXJ0aW8tdmRwYTogZG9uJ3Qgc2V0IGNhbGxiYWNrIGlmIHZp
cnRpbyBkb2Vzbid0IG5lZWQgaXQKPiA+ID4gICAgdmhvc3QtdmRwYTogcGFzc2luZyBpb3RsYiB0
byBJT01NVSBtYXBwaW5nIGhlbHBlcnMKPiA+ID4gICAgdmhvc3QtdmRwYTogc3dpdGNoIHRvIHVz
ZSB2aG9zdC12ZHBhIHNwZWNpZmljIElPVExCCj4gPiA+ICAgIHZkcGE6IGFkZCB0aGUgbWlzc2lu
ZyBjb21tZW50IGZvciBudnFzIGluIHN0cnVjdCB2ZHBhX2RldmljZQo+ID4gPiAgICB2ZHBhOiBp
bnRyb2R1Y2UgdmlydHF1ZXVlIGdyb3Vwcwo+ID4gPiAgICB2ZHBhOiBtdWx0aXBsZSBhZGRyZXNz
IHNwYWNlcyBzdXBwb3J0Cj4gPiA+ICAgIHZkcGE6IGludHJvZHVjZSBjb25maWcgb3BlcmF0aW9u
cyBmb3IgYXNzb2NpYXRpbmcgQVNJRCB0byBhIHZpcnRxdWV1ZQo+ID4gPiAgICAgIGdyb3VwCj4g
PiA+ICAgIHZob3N0X2lvdGxiOiBzcGxpdCBvdXQgSU9UTEIgaW5pdGlhbGl6YXRpb24KPiA+ID4g
ICAgdmhvc3Q6IHN1cHBvcnQgQVNJRCBpbiBJT1RMQiBBUEkKPiA+ID4gICAgdmhvc3QtdmRwYTog
aW50cm9kdWNlIGFzaWQgYmFzZWQgSU9UTEIKPiA+ID4gICAgdmhvc3QtdmRwYTogaW50cm9kdWNl
IHVBUEkgdG8gZ2V0IHRoZSBudW1iZXIgb2YgdmlydHF1ZXVlIGdyb3Vwcwo+ID4gPiAgICB2aG9z
dC12ZHBhOiBpbnRyb2R1Y2UgdUFQSSB0byBnZXQgdGhlIG51bWJlciBvZiBhZGRyZXNzIHNwYWNl
cwo+ID4gPiAgICB2aG9zdC12ZHBhOiB1QVBJIHRvIGdldCB2aXJ0cXVldWUgZ3JvdXAgaWQKPiA+
ID4gICAgdmhvc3QtdmRwYTogaW50cm9kdWNlIHVBUEkgdG8gc2V0IGdyb3VwIEFTSUQKPiA+ID4g
ICAgdmhvc3QtdmRwYTogc3VwcG9ydCBBU0lEIGJhc2VkIElPVExCIEFQSQo+ID4gPiAgICB2ZHBh
X3NpbTogYWR2ZXJ0aXNlIFZJUlRJT19ORVRfRl9NVFUKPiA+ID4gICAgdmRwYV9zaW06IGZhY3Rv
ciBvdXQgYnVmZmVyIGNvbXBsZXRpb24gbG9naWMKPiA+ID4gICAgdmRwYV9zaW06IGZpbHRlciBk
ZXN0aW5hdGlvbiBtYWMgYWRkcmVzcwo+ID4gPiAgICB2ZHBhc2ltOiBjb250cm9sIHZpcnRxdWV1
ZSBzdXBwb3J0Cj4gPiA+IAo+ID4gPiBTdGVmYW5vIEdhcnphcmVsbGEgKDEpOgo+ID4gPiAgICB2
ZHBhX3NpbTogc3BsaXQgdmRwYXNpbV92aXJ0cXVldWUncyBpb3YgZmllbGQgaW4gb3V0X2lvdiBh
bmQgaW5faW92Cj4gPiA+IAo+ID4gPiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMg
ICB8ICAgOSArLQo+ID4gPiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8ICAx
MSArLQo+ID4gPiAgIGRyaXZlcnMvdmRwYS92ZHBhLmMgICAgICAgICAgICAgICB8ICAgOCArLQo+
ID4gPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jICB8IDI5MiArKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0KPiA+ID4gICBkcml2ZXJzL3Zob3N0L2lvdGxiLmMgICAgICAg
ICAgICAgfCAgMjMgKystCj4gPiA+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgICAgICAgICAgICAg
IHwgMjQ2ICsrKysrKysrKysrKysrKysrKysrLS0tLS0KPiA+ID4gICBkcml2ZXJzL3Zob3N0L3Zo
b3N0LmMgICAgICAgICAgICAgfCAgMjMgKystCj4gPiA+ICAgZHJpdmVycy92aG9zdC92aG9zdC5o
ICAgICAgICAgICAgIHwgICA0ICstCj4gPiA+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEu
YyAgICAgIHwgICAyICstCj4gPiA+ICAgaW5jbHVkZS9saW51eC92ZHBhLmggICAgICAgICAgICAg
IHwgIDQyICsrKystCj4gPiA+ICAgaW5jbHVkZS9saW51eC92aG9zdF9pb3RsYi5oICAgICAgIHwg
ICAyICsKPiA+ID4gICBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaCAgICAgICAgfCAgMjUgKyst
Cj4gPiA+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmggIHwgIDEwICstCj4gPiA+
ICAgMTMgZmlsZXMgY2hhbmdlZCwgNTYxIGluc2VydGlvbnMoKyksIDEzNiBkZWxldGlvbnMoLSkK
PiA+ID4gCj4gPiA+IC0tIAo+ID4gPiAyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
