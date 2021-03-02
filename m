Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0446AC433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 11:24:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6390D64F0B
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 11:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6390D64F0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1342F4EE09;
	Tue,  2 Mar 2021 11:24:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mvpU8bxG8MuW; Tue,  2 Mar 2021 11:24:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8825E4EDF6;
	Tue,  2 Mar 2021 11:24:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 583CEC000B;
	Tue,  2 Mar 2021 11:24:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F21C0C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 11:24:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC7DD6F5FC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 11:24:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rd3Gqm5DOniB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 11:24:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0B6A76F59F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 11:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614684269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1BhNztqEgWGMx7kPW5f0CLvD2WsnR/6LZwBjGCJ0xrE=;
 b=ardvb+BvflQ2gHEyODVaPXkqNkab62wr5r6zc0Pm4eTMcraA42jOkyIJDZ2lNEfjJ7tfOi
 bROQ9hzJsmkza1oi/Yb4tptj4wCZViapv9ZcZfRCRVhUmZ2wwMIXmgq4fqbL1QoOAhuy63
 M1WkKrGcl6V+vNfyeL+fk8UB6uiIDQc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-nBCQyNwdNfiL0ZaWlc7pXQ-1; Tue, 02 Mar 2021 06:24:28 -0500
X-MC-Unique: nBCQyNwdNfiL0ZaWlc7pXQ-1
Received: by mail-ej1-f71.google.com with SMTP id p6so8323425ejw.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Mar 2021 03:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=1BhNztqEgWGMx7kPW5f0CLvD2WsnR/6LZwBjGCJ0xrE=;
 b=Y4p9k2rL5vq7oHqiwX2fgblIXCG0jeRvn6o2kxXrmx64LvGtBVlueQCw+/x5XnzdYc
 fFEQcWlYWdZuMhSYNomrySFr2KxnjTsJKMwjncrVxwV9EdqmfOaXYknyD4TgOLmjgt0q
 4dIAOWJwLY1SaID7L/x5/D/6rENgr4Vt8mIuQ8Yv11I9WwJrpi+8Lvn6fS/lnTUz95O6
 taBV/KyeTFZ/wL2Hq6Z1Vt7blf6Cf/Z122r/SVjMNURjx3tTiL14qYstOtecw1IgzkfY
 kTi0qwGmzjL64VhRM9hn/KbXxd2soF+/IbofDyX1AvEKip8dvrtS+ep6lX7MAmgyS5U3
 4rYA==
X-Gm-Message-State: AOAM5307Dnpyayc+mxSJ9gp8miiynLv2iqkYHdkQhbv7On0B/uHQ9vGv
 8L8a1T6FgbToQuhkPiB60WX5PtsReuOfno1B3yxHu8sqxoumYeU8NJkt+C7zDLw1n1/Hzv1vZ0H
 47fDXvrZJwJQNVOWp6CfGbKVmWk7B13u013nOCnSAZA==
X-Received: by 2002:a17:906:f296:: with SMTP id
 gu22mr19228815ejb.20.1614684263044; 
 Tue, 02 Mar 2021 03:24:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGGNSokqgK/5RqqfSY3ERKl9lVWR62FSA4uJr14s6tOqkDbPKgW29y+nDnUA6mto+6bIvZew==
X-Received: by 2002:a17:906:f296:: with SMTP id
 gu22mr19228806ejb.20.1614684262901; 
 Tue, 02 Mar 2021 03:24:22 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id h2sm15994879ejk.32.2021.03.02.03.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Mar 2021 03:24:22 -0800 (PST)
Date: Tue, 2 Mar 2021 06:24:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix wrong use of bit numbers
Message-ID: <20210302062405-mutt-send-email-mst@kernel.org>
References: <20210301062817.39331-1-elic@nvidia.com>
 <959916f2-5fc9-bdb4-31ca-632fe0d98979@redhat.com>
 <20210301103214-mutt-send-email-mst@kernel.org>
 <20210302052306.GA227464@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210302052306.GA227464@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

T24gVHVlLCBNYXIgMDIsIDIwMjEgYXQgMDc6MjM6MDZBTSArMDIwMCwgRWxpIENvaGVuIHdyb3Rl
Ogo+IE9uIE1vbiwgTWFyIDAxLCAyMDIxIGF0IDEwOjMzOjE0QU0gLTA1MDAsIE1pY2hhZWwgUy4g
VHNpcmtpbiB3cm90ZToKPiA+IE9uIE1vbiwgTWFyIDAxLCAyMDIxIGF0IDAzOjUyOjQ1UE0gKzA4
MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IAo+ID4gPiBPbiAyMDIxLzMvMSAyOjI4IOS4i+WN
iCwgRWxpIENvaGVuIHdyb3RlOgo+ID4gPiA+IFZJUlRJT19GX1ZFUlNJT05fMSBpcyBhIGJpdCBu
dW1iZXIuIFVzZSBCSVRfVUxMKCkgd2l0aCBtYXNrCj4gPiA+ID4gY29uZGl0aW9uYWxzLgo+ID4g
PiA+IAo+ID4gPiA+IEFsc28sIGluIG1seDVfdmRwYV9pc19saXR0bGVfZW5kaWFuKCkgdXNlIEJJ
VF9VTEwgZm9yIGNvbnNpc3RlbmN5IHdpdGgKPiA+ID4gPiB0aGUgcmVzdCBvZiB0aGUgY29kZS4K
PiA+ID4gPiAKPiA+ID4gPiBGaXhlczogMWE4NmIzNzdhYTIxICgidmRwYS9tbHg1OiBBZGQgVkRQ
QSBkcml2ZXIgZm9yIHN1cHBvcnRlZCBtbHg1IGRldmljZXMiKQo+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+ID4gPiAKPiA+ID4gCj4gPiA+IEFja2Vk
LWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gCj4gPiBBbmQgQ0Mgc3Rh
YmxlIEkgZ3Vlc3M/Cj4gCj4gSXMgdGhpcyBhIHF1ZXN0aW9uIG9yIGEgcmVxdWVzdD8gOi0pCgpB
IHF1ZXN0aW9uLiBuZXQgcGF0Y2hlcyBhcmUgY2MnZCBieSBuZXQgbWFpbnRhaW5lci4KCj4gPiAK
PiA+ID4gCj4gPiA+ID4gLS0tCj4gPiA+ID4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMgfCA0ICsrLS0KPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCj4gPiA+ID4gCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
Ywo+ID4gPiA+IGluZGV4IGRjNzAzMTEzMmZmZi4uN2QyMWI4NTdhOTRhIDEwMDY0NAo+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+ICsrKyBiL2Ry
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+IEBAIC04MjEsNyArODIxLDcg
QEAgc3RhdGljIGludCBjcmVhdGVfdmlydHF1ZXVlKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2
LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWUKPiA+ID4gPiAgIAlNTFg1X1NFVCh2aXJ0aW9fcSwg
dnFfY3R4LCBldmVudF9xcG5fb3JfbXNpeCwgbXZxLT5md3FwLm1xcC5xcG4pOwo+ID4gPiA+ICAg
CU1MWDVfU0VUKHZpcnRpb19xLCB2cV9jdHgsIHF1ZXVlX3NpemUsIG12cS0+bnVtX2VudCk7Cj4g
PiA+ID4gICAJTUxYNV9TRVQodmlydGlvX3EsIHZxX2N0eCwgdmlydGlvX3ZlcnNpb25fMV8wLAo+
ID4gPiA+IC0JCSAhIShuZGV2LT5tdmRldi5hY3R1YWxfZmVhdHVyZXMgJiBWSVJUSU9fRl9WRVJT
SU9OXzEpKTsKPiA+ID4gPiArCQkgISEobmRldi0+bXZkZXYuYWN0dWFsX2ZlYXR1cmVzICYgQklU
X1VMTChWSVJUSU9fRl9WRVJTSU9OXzEpKSk7Cj4gPiA+ID4gICAJTUxYNV9TRVQ2NCh2aXJ0aW9f
cSwgdnFfY3R4LCBkZXNjX2FkZHIsIG12cS0+ZGVzY19hZGRyKTsKPiA+ID4gPiAgIAlNTFg1X1NF
VDY0KHZpcnRpb19xLCB2cV9jdHgsIHVzZWRfYWRkciwgbXZxLT5kZXZpY2VfYWRkcik7Cj4gPiA+
ID4gICAJTUxYNV9TRVQ2NCh2aXJ0aW9fcSwgdnFfY3R4LCBhdmFpbGFibGVfYWRkciwgbXZxLT5k
cml2ZXJfYWRkcik7Cj4gPiA+ID4gQEAgLTE1NzgsNyArMTU3OCw3IEBAIHN0YXRpYyB2b2lkIHRl
YXJkb3duX3ZpcnRxdWV1ZXMoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4gPiA+ID4gICBz
dGF0aWMgaW5saW5lIGJvb2wgbWx4NV92ZHBhX2lzX2xpdHRsZV9lbmRpYW4oc3RydWN0IG1seDVf
dmRwYV9kZXYgKm12ZGV2KQo+ID4gPiA+ICAgewo+ID4gPiA+ICAgCXJldHVybiB2aXJ0aW9fbGVn
YWN5X2lzX2xpdHRsZV9lbmRpYW4oKSB8fAo+ID4gPiA+IC0JCShtdmRldi0+YWN0dWFsX2ZlYXR1
cmVzICYgKDFVTEwgPDwgVklSVElPX0ZfVkVSU0lPTl8xKSk7Cj4gPiA+ID4gKwkJKG12ZGV2LT5h
Y3R1YWxfZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19GX1ZFUlNJT05fMSkpOwo+ID4gPiA+ICAg
fQo+ID4gPiA+ICAgc3RhdGljIF9fdmlydGlvMTYgY3B1X3RvX21seDV2ZHBhMTYoc3RydWN0IG1s
eDVfdmRwYV9kZXYgKm12ZGV2LCB1MTYgdmFsKQo+ID4gCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
