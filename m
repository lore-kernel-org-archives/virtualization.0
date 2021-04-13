Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A60C433ED
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 19:38:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A08D8610FC
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 19:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08D8610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 697216073C;
	Tue, 13 Apr 2021 19:38:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dXn2-ipURBdU; Tue, 13 Apr 2021 19:38:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 126BB605A8;
	Tue, 13 Apr 2021 19:38:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAAA1C000B;
	Tue, 13 Apr 2021 19:38:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46266C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 19:38:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F98C40603
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 19:38:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4ZXLk7yutCcV
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 19:38:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 581B14012E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 19:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618342706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5KnGoDFAv6bKDXPJG6SYr7UZf9+Lclu6UjzMKtgboCI=;
 b=dyhqAEnBOxl2hiWZrfMCjfsQkLLI/kDYoaoaEJhpM33Mu7HQaxqSINqCJZvy65RuxIify4
 fNYtP+KPHgDwHEe+Rntv/cghCvSzNmeEeE3VVhCgA93KZDM++AEucDn+saKTsd/iQPWJ2J
 cPNIjdidSr3DFBSZGpdg67zlTnypaNA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-anBzyI32OfWLHinOrghEFw-1; Tue, 13 Apr 2021 15:38:24 -0400
X-MC-Unique: anBzyI32OfWLHinOrghEFw-1
Received: by mail-wm1-f71.google.com with SMTP id
 m3-20020a05600c4f43b029010f13f509a4so1544660wmq.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 12:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=5KnGoDFAv6bKDXPJG6SYr7UZf9+Lclu6UjzMKtgboCI=;
 b=GUBwtUrczY6mp/md15QK5yb9Va7g61yLn6+/pjoF2a16WyD47cf1XdQYLXNO0ZSH1e
 aXRDLlG/D+Vm3ld8GetyHBqEfjvi1fN9vK6ObR74baVCaSVj/EtZ+MqF038SRkojnFeM
 0JHehex2i9tmtoLhafUfZAaZrLvm1ujheALaDwtOXRHvwd+Z8h7NGJGutoAYscVQRKr5
 DAJMNPCavJNOMIvjKhSDuRh4A/aCEDrr5LgoCZ+F2cB1gD7sFUPvFRUBDaJIthcG01rL
 9ENr7c7i9VjgnJgxVX7BP6Y3U2AUMgQ3H+DRI14ECoRZDadU/2GeIAI/93cbMY63lKFm
 tmFg==
X-Gm-Message-State: AOAM531wgeBVKJCPtsx71DZwmvHk20Bq4fO9n3LdAqTYztf7lvp36atr
 y4R2W09tCVNytFVAW2iCXs/k6AoojaqLv7pLB+JZATGJSOAmjwUS6pj16YIjwSN2NzaGF2lnfS5
 fxFkqKRwFQ6J1JGcWIA+rlVbAq/gyK4jZ+XIdS7AHdw==
X-Received: by 2002:a1c:bb46:: with SMTP id l67mr1483570wmf.103.1618342703114; 
 Tue, 13 Apr 2021 12:38:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsyBoIOrK8jLYHlfy//zbHQzTjiDZw65hyrrkhQTF1B81u43o0GIascvITlEoglSzyEJwJ+A==
X-Received: by 2002:a1c:bb46:: with SMTP id l67mr1483554wmf.103.1618342702959; 
 Tue, 13 Apr 2021 12:38:22 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id u4sm3188906wml.0.2021.04.13.12.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Apr 2021 12:38:22 -0700 (PDT)
Date: Tue, 13 Apr 2021 15:38:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH RFC v2 3/4] virtio_net: move tx vq operation under tx
 queue lock
Message-ID: <20210413153619-mutt-send-email-mst@kernel.org>
References: <20210413054733.36363-1-mst@redhat.com>
 <20210413054733.36363-4-mst@redhat.com>
 <805053bf-960f-3c34-ce23-012d121ca937@redhat.com>
 <20210413100222-mutt-send-email-mst@kernel.org>
 <CA+FuTSe=3cAkhwjSDDt1U8mSiVj5BKgJ7DJGxAAoF22kac3CMQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+FuTSe=3cAkhwjSDDt1U8mSiVj5BKgJ7DJGxAAoF22kac3CMQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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

T24gVHVlLCBBcHIgMTMsIDIwMjEgYXQgMTA6MjA6MzlBTSAtMDQwMCwgV2lsbGVtIGRlIEJydWlq
biB3cm90ZToKPiBPbiBUdWUsIEFwciAxMywgMjAyMSBhdCAxMDowMyBBTSBNaWNoYWVsIFMuIFRz
aXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBUdWUsIEFwciAxMywgMjAy
MSBhdCAwNDo1NDo0MlBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPgo+ID4gPiDlnKgg
MjAyMS80LzEzIOS4i+WNiDE6NDcsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gPiA+ID4g
SXQncyB1bnNhZmUgdG8gb3BlcmF0ZSBhIHZxIGZyb20gbXVsdGlwbGUgdGhyZWFkcy4KPiA+ID4g
PiBVbmZvcnR1bmF0ZWx5IHRoaXMgaXMgZXhhY3RseSB3aGF0IHdlIGRvIHdoZW4gaW52b2tpbmcK
PiA+ID4gPiBjbGVhbiB0eCBwb2xsIGZyb20gcnggbmFwaS4KPiAKPiBBY3R1YWxseSwgdGhlIGlz
c3VlIGdvZXMgYmFjayB0byB0aGUgbmFwaS10eCBldmVuIHdpdGhvdXQgdGhlCj4gb3Bwb3J0dW5p
c3RpYyBjbGVhbmluZyBmcm9tIHRoZSByZWNlaXZlIGludGVycnVwdCwgSSB0aGluaz8gVGhhdCBy
YWNlcwo+IHdpdGggcHJvY2Vzc2luZyB0aGUgdnEgaW4gc3RhcnRfeG1pdC4KPiAKPiA+ID4gPiBB
cyBhIGZpeCBtb3ZlIGV2ZXJ5dGhpbmcgdGhhdCBkZWFscyB3aXRoIHRoZSB2cSB0byB1bmRlciB0
eCBsb2NrLgo+ID4gPiA+Cj4gCj4gSWYgdGhlIGFib3ZlIGlzIGNvcnJlY3Q6Cj4gCj4gRml4ZXM6
IGI5MmYxZTY3NTFhNiAoInZpcnRpby1uZXQ6IHRyYW5zbWl0IG5hcGkiKQo+IAo+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4gPiA+ID4g
LS0tCj4gPiA+ID4gICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAyMiArKysrKysrKysrKysr
KysrKysrKystCj4gPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQo+ID4gPiA+Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRp
b19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+IGluZGV4IDE2ZDVhYmVk
NTgyYy4uNDYwY2NkYmI4NDBlIDEwMDY0NAo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRp
b19uZXQuYwo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+IEBA
IC0xNTA1LDYgKzE1MDUsOCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcG9sbF90eChzdHJ1Y3QgbmFw
aV9zdHJ1Y3QgKm5hcGksIGludCBidWRnZXQpCj4gPiA+ID4gICAgIHN0cnVjdCB2aXJ0bmV0X2lu
Zm8gKnZpID0gc3EtPnZxLT52ZGV2LT5wcml2Owo+ID4gPiA+ICAgICB1bnNpZ25lZCBpbnQgaW5k
ZXggPSB2cTJ0eHEoc3EtPnZxKTsKPiA+ID4gPiAgICAgc3RydWN0IG5ldGRldl9xdWV1ZSAqdHhx
Owo+ID4gPiA+ICsgICBpbnQgb3BhcXVlOwo+IAo+IG5pdDogdmlydHF1ZXVlX25hcGlfY29tcGxl
dGUgYWxzbyBzdG9yZXMgYXMgaW50IG9wYXF1ZSwgYnV0Cj4gdmlydHF1ZXVlX2VuYWJsZV9jYl9w
cmVwYXJlIGFjdHVhbGx5IHJldHVybnMsIGFuZCB2aXJ0cXVldWVfcG9sbAo+IGV4cGVjdHMsIGFu
IHVuc2lnbmVkIGludC4gSW4gdGhlIGVuZCwgY29udmVyc2lvbiB3b3JrcyBjb3JyZWN0bHkuIEJ1
dAo+IGNsZWFuZXIgdG8gdXNlIHRoZSByZWFsIHR5cGUuCj4gCj4gPiA+ID4gKyAgIGJvb2wgZG9u
ZTsKPiA+ID4gPiAgICAgaWYgKHVubGlrZWx5KGlzX3hkcF9yYXdfYnVmZmVyX3F1ZXVlKHZpLCBp
bmRleCkpKSB7Cj4gPiA+ID4gICAgICAgICAgICAgLyogV2UgZG9uJ3QgbmVlZCB0byBlbmFibGUg
Y2IgZm9yIFhEUCAqLwo+ID4gPiA+IEBAIC0xNTE0LDEwICsxNTE2LDI4IEBAIHN0YXRpYyBpbnQg
dmlydG5ldF9wb2xsX3R4KHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1ZGdldCkKPiA+
ID4gPiAgICAgdHhxID0gbmV0ZGV2X2dldF90eF9xdWV1ZSh2aS0+ZGV2LCBpbmRleCk7Cj4gPiA+
ID4gICAgIF9fbmV0aWZfdHhfbG9jayh0eHEsIHJhd19zbXBfcHJvY2Vzc29yX2lkKCkpOwo+ID4g
PiA+ICsgICB2aXJ0cXVldWVfZGlzYWJsZV9jYihzcS0+dnEpOwo+ID4gPiA+ICAgICBmcmVlX29s
ZF94bWl0X3NrYnMoc3EsIHRydWUpOwo+ID4gPiA+ICsKPiA+ID4gPiArICAgb3BhcXVlID0gdmly
dHF1ZXVlX2VuYWJsZV9jYl9wcmVwYXJlKHNxLT52cSk7Cj4gPiA+ID4gKwo+ID4gPiA+ICsgICBk
b25lID0gbmFwaV9jb21wbGV0ZV9kb25lKG5hcGksIDApOwo+ID4gPiA+ICsKPiA+ID4gPiArICAg
aWYgKCFkb25lKQo+ID4gPiA+ICsgICAgICAgICAgIHZpcnRxdWV1ZV9kaXNhYmxlX2NiKHNxLT52
cSk7Cj4gPiA+ID4gKwo+ID4gPiA+ICAgICBfX25ldGlmX3R4X3VubG9jayh0eHEpOwo+ID4gPiA+
IC0gICB2aXJ0cXVldWVfbmFwaV9jb21wbGV0ZShuYXBpLCBzcS0+dnEsIDApOwo+ID4gPgo+ID4g
Pgo+ID4gPiBTbyBJIHdvbmRlciB3aHkgbm90IHNpbXBseSBtb3ZlIF9fbmV0aWZfdHhfdW5sb2Nr
KCkgYWZ0ZXIKPiA+ID4gdmlydHF1ZXVlX25hcGlfY29tcGxldGUoKT8KPiA+ID4KPiA+ID4gVGhh
bmtzCj4gPiA+Cj4gPgo+ID4KPiA+IEJlY2F1c2UgdGhhdCBjYWxscyB0eCBwb2xsIHdoaWNoIGFs
c28gdGFrZXMgdHggbG9jayBpbnRlcm5hbGx5IC4uLgo+IAo+IHdoaWNoIHR4IHBvbGw/CgpPaC4g
SXQncyB2aXJ0cXVldWVfcG9sbCBhY3R1YWxseS4gSSBjb25mdXNlZCBpdCB3aXRoCnZpcnRuZXRf
cG9sbF90eC4gUmlnaHQuIFdlIGNhbiBwdXQgaXQgYmFjayB0aGUgd2F5IGl0IHdhcy4KCi0tIApN
U1QKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
