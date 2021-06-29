Return-Path: <SRS0=tbjA=LX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE65DC11F67
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 20:01:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8980761D9A
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 20:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8980761D9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 47474402BA;
	Tue, 29 Jun 2021 20:01:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bsOBimsC-nmC; Tue, 29 Jun 2021 20:01:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EBB6340105;
	Tue, 29 Jun 2021 20:01:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEDCBC001A;
	Tue, 29 Jun 2021 20:01:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77521C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 20:01:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 51BB540523
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 20:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lZ8gljDePd25
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 20:01:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4B92640514
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 20:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624996906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hH0/dYQECcvxhkXpXSxVFWy0bB8kyAz8Jrojg/dudIQ=;
 b=Ed/tA2Q/mW6yXhTycm+BTdamfjmWdIrgIVyHNPcCDAcO/1RXc+ROkyCbLxmBJiU6Q31EXE
 vQviY3pkuzo55Dl+rvGSYi0857ks+aHouEeZ79nBoOanJbx+QQszzvaX0iHscYOOjgHFKZ
 QLOWLIUJxR2SSYJqChFhifQgA7/TGTA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-5LLLag64PlGyyqkCqboC-g-1; Tue, 29 Jun 2021 16:01:44 -0400
X-MC-Unique: 5LLLag64PlGyyqkCqboC-g-1
Received: by mail-ej1-f72.google.com with SMTP id
 l6-20020a1709062a86b029046ec0ceaf5cso6188314eje.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 13:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=hH0/dYQECcvxhkXpXSxVFWy0bB8kyAz8Jrojg/dudIQ=;
 b=NaQ5lTYP61A6i9q5eYY3wtLLoMCziGYxuJ1PigU6HvPmCkNeCRS3SAFX/93BRIU5l9
 hF100FkaJWJfFPBlSfi4qF74E21oKwfmg3e1je1VvgjLPwG2pcZj8e/qKmCpbRKMi2J6
 uKMqYCHbqBafpisj938SPNGPxm7zFuZBNAJc1hGS0JPDYuBBGV/FStB5oO9wMuWOjM+x
 b0QxUa+PM2nt9hza7uMBNTXKrpGG2H8/P73c9Yjnnb3OoID0qpk7r2HtUKG552RKE0iz
 Q7mXuvwtht/h9MgLP7YJ/vZd3rnBH3vRC6FHUACIxE80qrDfjTq81pD1ZJuiyD4FZqZ2
 vt+g==
X-Gm-Message-State: AOAM532X5kvlRl7dq3lpd3BWyAcoTrzytNCbJDWXAu3Ge5kCZwHwmq41
 +0f/lTodGJ/5aaAAC5hM1xOzT9BfYf8kJcpRpLTtFxq3LsLHqhocwkg6jnJ2dkaUo7w5cMJO03+
 H5IyL/nVuEFjekl8kub2xAzA+W1XmYgH4esQ+LgVWkg==
X-Received: by 2002:aa7:d853:: with SMTP id f19mr42226478eds.1.1624996903419; 
 Tue, 29 Jun 2021 13:01:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybMqeHbL36dOlC25yXsY8CeU+UY/iNz9g9hd3R48b866fEbuBHhvt+nvyBAkZgZ5p+DPhfXA==
X-Received: by 2002:aa7:d853:: with SMTP id f19mr42226464eds.1.1624996903290; 
 Tue, 29 Jun 2021 13:01:43 -0700 (PDT)
Received: from redhat.com ([77.126.198.14])
 by smtp.gmail.com with ESMTPSA id ar14sm8510919ejc.108.2021.06.29.13.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jun 2021 13:01:42 -0700 (PDT)
Date: Tue, 29 Jun 2021 16:01:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Message-ID: <20210629153540-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB548147BE1B95CB294785470CDC089@PH0PR12MB5481.namprd12.prod.outlook.com>
 <d361bd10-3967-8844-1457-48e7e9422fb2@redhat.com>
 <PH0PR12MB54812DD2DADAD0897E24CFA7DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4e0708fb-34e3-471d-ca98-44c75f693b32@redhat.com>
 <PH0PR12MB54811C39B86AC8D6BECA9E05DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7a0a8bdf-4cd2-2fc2-73a5-53fb2ab432b6@redhat.com>
 <PH0PR12MB54819F782D5D7E6F9DCDF5FEDC069@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5350f5c0-c707-c3ec-8ed8-16c884467ffa@redhat.com>
 <20210628183831-mutt-send-email-mst@kernel.org>
 <80b42ef6-b8ba-c0f6-3a6f-30f9125ebd35@redhat.com>
MIME-Version: 1.0
In-Reply-To: <80b42ef6-b8ba-c0f6-3a6f-30f9125ebd35@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

T24gVHVlLCBKdW4gMjksIDIwMjEgYXQgMTE6NDE6NTRBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS82LzI5IOS4iuWNiDY6MzksIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnp
gZM6Cj4gPiBPbiBNb24sIEp1biAyOCwgMjAyMSBhdCAwMTowMzoyMFBNICswODAwLCBKYXNvbiBX
YW5nIHdyb3RlOgo+ID4gPiBTbyBJIHRoaW5rIHdlIG5lZWQgc29sdmUgdGhlbSBhbGwsIGJ1dCBu
ZXRsaW5rIGlzIHByb2JhYmx5IHRoZSB3cm9uZyBsYXllciwKPiA+ID4gd2UgbmVlZCB0byBzb2x2
ZSB0aGVtIGF0IHZpcnRpbyBsZXZlbCBhbmQgbGV0IG5ldGxpbmsgYSB0cmFuc3BvcnQgZm9yIHRo
ZW0KPiA+ID4gdmlydGlvIHVBUEkvQUJJLgo+ID4gSSdtIG5vdCBzdXJlIEkgZm9sbG93LiB2aXJ0
aW8gZGVmaW5lcyBWRiB0byBkcml2ZXIgY29tbXVuaWNhdGlvbi4KPiA+IFRoaXMgaXMgUEYgdG8g
aHlwZXJ2aXNvci4gdmlydGlvIHNpbXBseSBkb2VzIG5vdCBjb3ZlciBpdCBBVE0uCj4gCj4gCj4g
Tm90ZSB0aGF0IHRoaXMgaXMgbm90IFBGIHRvIGh5cGVydmlzb3IgYnV0IHRoZSB1QVBJIGZyb20g
dXNlcnNwYWNlICh2RFBBCj4gdG9vbCkgdG8gdkRQQSBjb3JlLgo+IAo+IFdlIGhhZCB0d28gY2hv
aWNlcy4KPiAKPiAxKSB0d2VhayB2aXJ0aW8gdUFQSXMKPiAyKSBpbnZlbnQgdmlydGlvIHNwZWNp
ZmljIHVBUEkgaW4gbmV0bGluawo+IAo+IDEpIHNlZW1zIGJldHRlci4KPiAKPiBUaGFua3MKPiAK
CldlbGwgdGhpbmdzIGxpa2Ugc2V0dGluZyBtYWMgYXJlbid0IHZpcnRpbyBzcGVjaWZpYy4KV2hh
dCBhcmUgdGhlIHZpcnRpbyBzcGVjaWZpYyB0aGluZ3MgeW91IGhhdmUgaW4gbWluZD8KCj4gPiAK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
