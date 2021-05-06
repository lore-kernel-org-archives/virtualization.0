Return-Path: <SRS0=qSBX=KB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA9BC43460
	for <virtualization@archiver.kernel.org>; Thu,  6 May 2021 08:12:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CDD161132
	for <virtualization@archiver.kernel.org>; Thu,  6 May 2021 08:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDD161132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED25983B57;
	Thu,  6 May 2021 08:12:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5dNpSZXQk4kj; Thu,  6 May 2021 08:12:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87F8D83B41;
	Thu,  6 May 2021 08:12:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60B3EC000D;
	Thu,  6 May 2021 08:12:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91364C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 08:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B39E6086A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 08:12:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S0bu2WBOZIB4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 08:12:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 27F6560825
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 08:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620288745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UC82bAJniKzYDd1rr6hFdgedXUqInssRFspajndQMpU=;
 b=hr1/P0rvaGlaS0uurGGAdlm9WlbJwjG5wQwvAO7FqK4u3y1ultX9WLEcPRNEsTmmAMrk4I
 8DRblifTy1ij9490sfxv35YdsYkYZzWuCLOmhnDsuf644usH5mB33wWu4ReR1VTmdnAvEW
 VaSvfYzZzcVM7eBu4RFfYzqH++FlG+k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-NL9R7jAcOWiMIpLWXnFzZw-1; Thu, 06 May 2021 04:12:23 -0400
X-MC-Unique: NL9R7jAcOWiMIpLWXnFzZw-1
Received: by mail-wm1-f70.google.com with SMTP id
 o18-20020a1ca5120000b02901333a56d46eso2360144wme.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 May 2021 01:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=UC82bAJniKzYDd1rr6hFdgedXUqInssRFspajndQMpU=;
 b=ovO9D11g3o+fcTPcj+4GVK4q1fEhYMj5VJWBZhsYdqQZhwxn9LLkKnUTQ3rPmCVKKi
 4+C4rfAmRK8nKuClkO6OuXIi8TmYNmleW4LvivQE398hQL8jAuADOmQWcWwxVZK2armD
 siExjbRvdLr0E2vL0wSDV7heA6R+qr5FSYvuPYfX73YmnjHcOVz1qAkabzXg1Izu/NZ7
 sIzTvlJWBVdep2MUF2jOCLX3xmIrPbOUFmKqLkXcuTxyWXyIStDlGH2YKqEC6M/HQGt3
 5ede2FZ7DS6BpuOtTDy4Nh4sGMRObdN16uQVSYNKPJi3mYdWbj89ePtuzE1ImH4uzPFH
 MczA==
X-Gm-Message-State: AOAM533R8suBDBBoO5Uv1k57+Eei+ENlxTrLW3dIoYOBZU4hUroDpXx2
 QEv9uQo5ZSY1eCVMQ4RMHrrK9LkVFoeyPMKN6TO6EYsMYn02lq2QqQ/rD5ts/F4zvPdMMx2meIL
 lMAgeXSd9QQ3td2IyLsCUn7am3PWAAXDmPvGZu9ZcuQ==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr3541249wrv.83.1620288741816; 
 Thu, 06 May 2021 01:12:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYOEaMbdcz5IXpIt214SV5btSIHDzQM7uxpcmfvjwnZSCT2BWQX5LFXPNw221igJoGM2NA4Q==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr3541224wrv.83.1620288741611; 
 Thu, 06 May 2021 01:12:21 -0700 (PDT)
Received: from redhat.com ([2a10:8004:640e:0:d1db:1802:5043:7b85])
 by smtp.gmail.com with ESMTPSA id x65sm10637130wmg.36.2021.05.06.01.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 May 2021 01:12:20 -0700 (PDT)
Date: Thu, 6 May 2021 04:12:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH V2 0/7] Do not read from descripto ring
Message-ID: <20210506041057-mutt-send-email-mst@kernel.org>
References: <20210423080942.2997-1-jasowang@redhat.com>
 <0e9d70b7-6c8a-4ff5-1fa9-3c4f04885bb8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0e9d70b7-6c8a-4ff5-1fa9-3c4f04885bb8@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: ashish.kalra@amd.com, file@sect.tu-berlin.de, kvm@vger.kernel.org,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 xieyongji@bytedance.com, stefanha@redhat.com
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

T24gVGh1LCBNYXkgMDYsIDIwMjEgYXQgMTE6MjA6MzBBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS80LzIzIOS4i+WNiDQ6MDksIEphc29uIFdhbmcg5YaZ6YGTOgo+ID4g
SGk6Cj4gPiAKPiA+IFNvbWV0aW1lcywgdGhlIGRyaXZlciBkb2Vzbid0IHRydXN0IHRoZSBkZXZp
Y2UuIFRoaXMgaXMgdXN1YWxseQo+ID4gaGFwcGVucyBmb3IgdGhlIGVuY3J0cHllZCBWTSBvciBW
RFVTRVsxXS4gSW4gYm90aCBjYXNlcywgdGVjaG5vbG9neQo+ID4gbGlrZSBzd2lvdGxiIGlzIHVz
ZWQgdG8gcHJldmVudCB0aGUgcG9raW5nL21hbmdsaW5nIG9mIG1lbW9yeSBmcm9tIHRoZQo+ID4g
ZGV2aWNlLiBCdXQgdGhpcyBpcyBub3Qgc3VmZmljaWVudCBzaW5jZSBjdXJyZW50IHZpcnRpbyBk
cml2ZXIgbWF5Cj4gPiB0cnVzdCB3aGF0IGlzIHN0b3JlZCBpbiB0aGUgZGVzY3JpcHRvciB0YWJs
ZSAoY29oZXJlbnQgbWFwcGluZykgZm9yCj4gPiBwZXJmb3JtaW5nIHRoZSBETUEgb3BlcmF0aW9u
cyBsaWtlIHVubWFwIGFuZCBib3VuY2Ugc28gdGhlIGRldmljZSBtYXkKPiA+IGNob29zZSB0byB1
dGlsaXplIHRoZSBiZWhhdmlvdXIgb2Ygc3dpb3RsYiB0byBwZXJmb3JtIGF0dGFja3NbMl0uCj4g
PiAKPiA+IFRvIHByb3RlY3QgZnJvbSBhIG1hbGljb3VzIGRldmljZSwgdGhpcyBzZXJpZXMgc3Rv
cmUgYW5kIHVzZSB0aGUKPiA+IGRlc2NyaXB0b3IgbWV0YWRhdGEgaW4gYW4gYXV4aWxpYXkgc3Ry
dWN0dXJlIHdoaWNoIGNhbiBub3QgYmUgYWNjZXNzZWQKPiA+IHZpYSBzd2lvdGxiIGluc3RlYWQg
b2YgdGhlIG9uZXMgaW4gdGhlIGRlc2NyaXB0b3IgdGFibGUuIFRoaXMgbWVhbnMKPiA+IHRoZSBk
ZXNjcmlwdG9yIHRhYmxlIGlzIHdyaXRlLW9ubHkgZnJvbSB0aGUgdmlldyBvZiB0aGUgZHJpdmVy
Lgo+ID4gCj4gPiBBY3R1YWxseSwgd2UndmUgYWxtb3N0IGFjaGlldmVkIHRoYXQgdGhyb3VnaCBw
YWNrZWQgdmlydHF1ZXVlIGFuZCB3ZQo+ID4ganVzdCBuZWVkIHRvIGZpeCBhIGNvcm5lciBjYXNl
IG9mIGhhbmRsaW5nIG1hcHBpbmcgZXJyb3JzLiBGb3Igc3BsaXQKPiA+IHZpcnRxdWV1ZSB3ZSBq
dXN0IGZvbGxvdyB3aGF0J3MgZG9uZSBpbiB0aGUgcGFja2VkLgo+ID4gCj4gPiBOb3RlIHRoYXQg
d2UgZG9uJ3QgZHVwbGljYXRlIGRlc2NyaXB0b3IgbWVkYXRhIGZvciBpbmRpcmVjdAo+ID4gZGVz
Y3JpcHRvcnMgc2luY2UgaXQgdXNlcyBzdHJlYW0gbWFwcGluZyB3aGljaCBpcyByZWFkIG9ubHkg
c28gaXQncwo+ID4gc2FmZSBpZiB0aGUgbWV0YWRhdGEgb2Ygbm9uLWluZGlyZWN0IGRlc2NyaXB0
b3JzIGFyZSBjb3JyZWN0Lgo+ID4gCj4gPiBGb3Igc3BsaXQgdmlydHF1ZXVlLCB0aGUgY2hhbmdl
IGluY3JlYXNlIHRoZSBmb290cHJpbnQgZHVlIHRoZSB0aGUKPiA+IGF1eGlsaWFyeSBtZXRhZGF0
YSBidXQgaXQncyBhbG1vc3QgbmVnbGVjdGxhYmxlIGluIHRoZSBzaW1wbGUgdGVzdAo+ID4gbGlr
ZSBwa3RnZW4gb3IgbmV0cGVmLgo+ID4gCj4gPiBTbGlnaHRseSB0ZXN0ZWQgd2l0aCBwYWNrZWQg
b24vb2ZmLCBpb21tdSBvbi9vZiwgc3dpb3RsYiBmb3JjZS9vZmYgaW4KPiA+IHRoZSBndWVzdC4K
PiA+IAo+ID4gUGxlYXNlIHJldmlldy4KPiA+IAo+ID4gQ2hhbmdlcyBmcm9tIFYxOgo+ID4gLSBB
bHdheXMgdXNlIGF1eGlsaWFyeSBtZXRhZGF0YSBmb3Igc3BsaXQgdmlydHF1ZXVlCj4gPiAtIERv
bid0IHJlYWQgZnJvbSBkZXNjcmlwdG8gd2hlbiBkZXRhY2hpbmcgaW5kaXJlY3QgZGVzY3JpcHRv
cgo+IAo+IAo+IEhpIE1pY2hhZWw6Cj4gCj4gT3VyIFFFIHNlZSBubyByZWdyZXNzaW9uIG9uIHRo
ZSBwZXJmIHRlc3QgZm9yIDEwRyBidXQgc29tZSByZWdyZXNzaW9ucwo+ICg1JS0xMCUpIG9uIDQw
RyBjYXJkLgo+IAo+IEkgdGhpbmsgdGhpcyBpcyBleHBlY3RlZCBzaW5jZSB3ZSBpbmNyZWFzZSB0
aGUgZm9vdHByaW50LCBhcmUgeW91IE9LIHdpdGgKPiB0aGlzIGFuZCB3ZSBjYW4gdHJ5IHRvIG9w
dGltaXplIG9uIHRvcCBvciB5b3UgaGF2ZSBvdGhlciBpZGVhcz8KPiAKPiBUaGFua3MKCkxldCdz
IHRyeSBmb3IganVzdCBhIGJpdCwgd29uJ3QgbWFrZSB0aGlzIHdpbmRvdyBhbnl3YXk6CgpJIGhh
dmUgYW4gb2xkIGlkZWEuIEFkZCBhIHdheSB0byBmaW5kIG91dCB0aGF0IHVubWFwIGlzIGEgbm9w
CihvciBtb3JlIGV4YWN0bHkgZG9lcyBub3QgdXNlIHRoZSBhZGRyZXNzL2xlbmd0aCkuClRoZW4g
aW4gdGhhdCBjYXNlIGV2ZW4gd2l0aCBETUEgQVBJIHdlIGRvIG5vdCBuZWVkCnRoZSBleHRyYSBk
YXRhLiBIbW0/CgoKPiAKPiA+IAo+ID4gWzFdCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9u
ZXRkZXYvZmFiNjE1Y2UtNWUxMy1hM2IzLTM3MTUtYTQyMDNiNGFiMDEwQHJlZGhhdC5jb20vVC8K
PiA+IFsyXQo+ID4gaHR0cHM6Ly95aGJ0Lm5ldC9sb3JlL2FsbC9jMzYyOWEyNy0zNTkwLTFkOWYt
MjExYi1jMGI3YmUxNTJiMzJAcmVkaGF0LmNvbS9ULyNtYzZiNmUyMzQzY2JlZmZjYTY4Y2E3YTk3
ZTBmNDczYWFhODcxYzk1Ygo+ID4gCj4gPiBKYXNvbiBXYW5nICg3KToKPiA+ICAgIHZpcnRpby1y
aW5nOiBtYWludGFpbiBuZXh0IGluIGV4dHJhIHN0YXRlIGZvciBwYWNrZWQgdmlydHF1ZXVlCj4g
PiAgICB2aXJ0aW9fcmluZzogcmVuYW1lIHZyaW5nX2Rlc2NfZXh0cmFfcGFja2VkCj4gPiAgICB2
aXJ0aW8tcmluZzogZmFjdG9yIG91dCBkZXNjX2V4dHJhIGFsbG9jYXRpb24KPiA+ICAgIHZpcnRp
b19yaW5nOiBzZWN1cmUgaGFuZGxpbmcgb2YgbWFwcGluZyBlcnJvcnMKPiA+ICAgIHZpcnRpb19y
aW5nOiBpbnRyb2R1Y2UgdmlydHF1ZXVlX2Rlc2NfYWRkX3NwbGl0KCkKPiA+ICAgIHZpcnRpbzog
dXNlIGVyciBsYWJlbCBpbiBfX3ZyaW5nX25ld192aXJ0cXVldWUoKQo+ID4gICAgdmlydGlvLXJp
bmc6IHN0b3JlIERNQSBtZXRhZGF0YSBpbiBkZXNjX2V4dHJhIGZvciBzcGxpdCB2aXJ0cXVldWUK
PiA+IAo+ID4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMjAxICsrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNDQgaW5zZXJ0
aW9ucygrKSwgNTcgZGVsZXRpb25zKC0pCj4gPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
