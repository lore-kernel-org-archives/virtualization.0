Return-Path: <SRS0=k93m=FM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC2BC4361B
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 13:53:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A05823AA9
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 13:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A05823AA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D9D3E231CB;
	Tue,  8 Dec 2020 13:53:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ydMyHASFmTA; Tue,  8 Dec 2020 13:53:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 436AD272A1;
	Tue,  8 Dec 2020 13:53:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3327CC0FA7;
	Tue,  8 Dec 2020 13:53:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD71BC013B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 13:53:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C7EB286D8D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 13:53:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s3txnvebh97B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 13:53:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CCF4A867B7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 13:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607435590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xgttXohI58ly0IwuQFIF9zckHLyniRrGoi9yyh9birA=;
 b=bwaG4jQwmx5q7JcYFm99CUk1Ro7NoswyOfiHeeBCf+dfRRvsXx/yrqgx++kJ8ngIbmlNI3
 AtFkAJXYGrkma6GYARCEY3O+/E9LtcBPPJQiToi8gJ2/bL09z3PekX/Ny5rc1xSUbim5q7
 K3pYoACryn3vz4vvwFGo9xnk/r2p014=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-4agCMSObPSiVVEXZuq3uUg-1; Tue, 08 Dec 2020 08:53:08 -0500
X-MC-Unique: 4agCMSObPSiVVEXZuq3uUg-1
Received: by mail-wm1-f72.google.com with SMTP id r1so897705wmn.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Dec 2020 05:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=xgttXohI58ly0IwuQFIF9zckHLyniRrGoi9yyh9birA=;
 b=ca0B2w18cpn2fPnxxSAXScT+gTBnAoiZ/qWhvlexdlmQAkL86U0bASrexY0or/dDSb
 JX8xrCpwPGKc2iyv7B961UsyyQdymmM8/uJrre+gWsb8hQRuAYyNGVoC1Nb2YNYYjBpH
 5T4X7yL2eKLtnf//B+FZR3IwIVPd8YJEZJoV2QQWbbbCTHVtzVrQE2EojTMrceunOMUY
 qeqiIq6KOJm7ggk2cH221Kck3UuDcqpmSPcU8wK27AxcEQ6ZpznvJuYIhCuLpLdVM86O
 FFkDpey2WBuiwM7P0wGSyolBcIVxFiVM9eVhCUcz5JvkLSee2s+KSqvhewvivIqX+lsP
 QkoA==
X-Gm-Message-State: AOAM533/WXRQYv6sqsCwwMQBZS+Pa8/UxZMxFmtHfD+pCNNvtrZ4vSSA
 Tchc90Dl6cZqmCSlNhiTHIX/HG6hj7hPjcAm3CwzIWqdOZ8aPIsaznaY1OWDIusG0ZL3VH3rYnk
 joAJq5dlgQkbcLhXGRV1vRFt7ZXfp8OkY6isHQgI3JQ==
X-Received: by 2002:adf:d082:: with SMTP id y2mr25455650wrh.301.1607435587160; 
 Tue, 08 Dec 2020 05:53:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyAfIXTZJCRf/Q3bbTBapHs82MJ7TFf6yBgLCgiqWbVjBm2eGDCt/dMwlmmDGlBu3CRVjaXDg==
X-Received: by 2002:adf:d082:: with SMTP id y2mr25455634wrh.301.1607435586953; 
 Tue, 08 Dec 2020 05:53:06 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id n189sm3573019wmf.20.2020.12.08.05.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 05:53:05 -0800 (PST)
Date: Tue, 8 Dec 2020 08:53:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Use write memory barrier after updating CQ
 index
Message-ID: <20201208085255-mutt-send-email-mst@kernel.org>
References: <20201206105719.123753-1-elic@nvidia.com>
 <dd7cde10-2e75-1bd3-68ad-f4988274b37d@redhat.com>
 <20201208091500.GA17763@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20201208091500.GA17763@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, lulu@redhat.com,
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

T24gVHVlLCBEZWMgMDgsIDIwMjAgYXQgMTE6MTU6MDBBTSArMDIwMCwgRWxpIENvaGVuIHdyb3Rl
Ogo+IE9uIE1vbiwgRGVjIDA3LCAyMDIwIGF0IDEwOjUxOjQ0QU0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPiAKPiA+IE9uIDIwMjAvMTIvNiDkuIvljYg2OjU3LCBFbGkgQ29oZW4gd3JvdGU6
Cj4gPiA+IE1ha2Ugc3VyZSB0byBwdXQgd3JpdGUgbWVtb3J5IGJhcnJpZXIgYWZ0ZXIgdXBkYXRp
bmcgQ1EgY29uc3VtZXIgaW5kZXgKPiA+ID4gc28gdGhlIGhhcmR3YXJlIGtub3dzIHRoYXQgdGhl
cmUgYXJlIGF2YWlsYWJsZSBDUUUgc2xvdHMgaW4gdGhlIHF1ZXVlLgo+ID4gPiAKPiA+ID4gRmFp
bHVyZSB0byBkbyB0aGlzIGNhbiBjYXVzZSB0aGUgdXBkYXRlIG9mIHRoZSBSWCBkb29yYmVsbCBy
ZWNvcmQgdG8gZ2V0Cj4gPiA+IHVwZGF0ZWQgYmVmb3JlIHRoZSBDUSBjb25zdW1lciBpbmRleCBy
ZXN1bHRpbmcgaW4gQ1Egb3ZlcnJ1bi4KPiA+ID4gCj4gPiA+IENoYW5nZS1JZDogSWIwYWU0YzEx
OGNjZTUyNGM5ZjQ5MmIzMjU2OTE3OWYzYzFmMDRjYzEKPiAKPiBNaWNoYWVsLCBJIGxlZnQgdGhp
cyBnZXJyaXQgSUQgYnkgbWlzdGFrZS4gQ2FuIHlvdSByZW1vdmUgaXQgYmVmb3JlCj4gbWVyZ2lu
Zz8KCk5vIHByb2JsZW0uCgo+ID4gPiBGaXhlczogMWE4NmIzNzdhYTIxICgidmRwYS9tbHg1OiBB
ZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBvcnRlZCBtbHg1IGRldmljZXMiKQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPiA+ID4gLS0tCj4gPiA+ICAgZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgNSArKysrKwo+ID4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKykKPiA+ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMKPiA+ID4gaW5kZXggMWY0MDg5YzZmOWQ3Li4yOTVmNDZlZWEyYTUgMTAwNjQ0Cj4gPiA+
IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiArKysgYi9kcml2
ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gQEAgLTQ3OCw2ICs0NzgsMTEgQEAg
c3RhdGljIGludCBtbHg1X3ZkcGFfcG9sbF9vbmUoc3RydWN0IG1seDVfdmRwYV9jcSAqdmNxKQo+
ID4gPiAgIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9oYW5kbGVfY29tcGxldGlvbnMoc3RydWN0IG1s
eDVfdmRwYV92aXJ0cXVldWUgKm12cSwgaW50IG51bSkKPiA+ID4gICB7Cj4gPiA+ICAgCW1seDVf
Y3Ffc2V0X2NpKCZtdnEtPmNxLm1jcSk7Cj4gPiA+ICsKPiA+ID4gKwkvKiBtYWtlIHN1cmUgQ1Eg
Y29zdW1lciB1cGRhdGUgaXMgdmlzaWJsZSB0byB0aGUgaGFyZHdhcmUgYmVmb3JlIHVwZGF0aW5n
Cj4gPiA+ICsJICogUlggZG9vcmJlbGwgcmVjb3JkLgo+ID4gPiArCSAqLwo+ID4gPiArCXdtYigp
Owo+ID4gPiAgIAlyeF9wb3N0KCZtdnEtPnZxcXAsIG51bSk7Cj4gPiA+ICAgCWlmIChtdnEtPmV2
ZW50X2NiLmNhbGxiYWNrKQo+ID4gPiAgIAkJbXZxLT5ldmVudF9jYi5jYWxsYmFjayhtdnEtPmV2
ZW50X2NiLnByaXZhdGUpOwo+ID4gCj4gPiAKPiA+IEFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPgo+ID4gCj4gPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
