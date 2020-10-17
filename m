Return-Path: <SRS0=x5ns=DY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3782FC43457
	for <virtualization@archiver.kernel.org>; Sat, 17 Oct 2020 07:39:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B61332072D
	for <virtualization@archiver.kernel.org>; Sat, 17 Oct 2020 07:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVqK2DYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61332072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3FAD0884D4;
	Sat, 17 Oct 2020 07:39:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AvC-G5gspdS6; Sat, 17 Oct 2020 07:39:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 67214884BD;
	Sat, 17 Oct 2020 07:39:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5155FC07FF;
	Sat, 17 Oct 2020 07:39:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEE88C0051
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 07:39:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AD2B488787
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 07:39:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id foYhRPFISy-w
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 07:39:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BB7BA88764
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 07:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602920383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5MeCjrpvVPuoqozCgtaDTsobybvBVrl2Tx3ew0mfpH8=;
 b=NVqK2DYZSp7tGMsDS/c4XDybwtjCoMcIgH9/3bUakmzXJTsvozTBH/oNoS1mBCzzB08Vzs
 d9V4QGx26U4VvD55WqKC1JCVV96RePDHKtihv34DkC8G/vWgXDZNy5grtomZS8jVN3Gwg0
 hGdFVEQy0L+PEI0nJWptKEsXFwlTKvY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-8uJStDguOf-v-ycGHvLY1g-1; Sat, 17 Oct 2020 03:39:41 -0400
X-MC-Unique: 8uJStDguOf-v-ycGHvLY1g-1
Received: by mail-ed1-f71.google.com with SMTP id a73so2924211edf.16
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 00:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=nlE7mWs+OHbEhLBW5Ti9CXDUCrj0uRPZ3Ruggfy/J74=;
 b=E9GoOYs3rvZU7WxQT7aQJZAPyeMAFc5/NjO9oaEBEjLu+DoiwWnio+Z5enFsemI5LP
 nf/VGLwwGOdB4Ccn05lcb6VJeEqgzDh6zRTZza3juZjle+XKod9P1hyoNCkPvBXkzGAB
 WeDWjFvzyCSCjrc+Bm0wHpg3NiR55zwzGL3OeXgEGmkp1/i/ahFiaGU8NsqbJwvCIEvX
 Ybel9qo3HBfHnt6vroi72DHjTDbkkS7/OGr6QUPd/PGLqW+yaW93p235M6JHUXHWEo3s
 f3V3+KNPBQkVdMTSOS+2f8mytDeX8APc9PgrEuIQr3CJrxpg2+xl9UdTJR6ZnvvnCExv
 r6wg==
X-Gm-Message-State: AOAM530+gPlZKw4D9MG5yS7XeCSE0uwIzHYLBBgB82SjlriKr1yZTPrY
 h2G+9vQYl/9kLqkPwBneP35F87rnugw4eZIIe2raXcfmRCo60JHLGF0Ylc7qQbh7xuQkQfIZw0X
 Cwsepz04BTLKskIaiYnLjcs/Uxz3AbHmVHC/wvUyzjg==
X-Received: by 2002:aa7:dc16:: with SMTP id b22mr8068521edu.252.1602920379910; 
 Sat, 17 Oct 2020 00:39:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuZ1/FCI19jeTpRP2oGQpZx/HslqeOvnC2jgnpgIVRX1a6ZmQPIKyyDNb7ut4Lh1R/3tQAQA==
X-Received: by 2002:aa7:dc16:: with SMTP id b22mr8068509edu.252.1602920379651; 
 Sat, 17 Oct 2020 00:39:39 -0700 (PDT)
Received: from [192.168.3.114] (p4ff239ab.dip0.t-ipconnect.de. [79.242.57.171])
 by smtp.gmail.com with ESMTPSA id vr3sm4406332ejb.124.2020.10.17.00.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 00:39:39 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 05/29] virtio-mem: generalize check for added memory
Date: Sat, 17 Oct 2020 09:39:38 +0200
Message-Id: <2E12AC3C-872A-4B30-8FD7-12420FA1D14E@redhat.com>
References: <20201016223811.GJ44269@L-31X9LVDL-1304.local>
In-Reply-To: <20201016223811.GJ44269@L-31X9LVDL-1304.local>
To: Wei Yang <richard.weiyang@linux.alibaba.com>
X-Mailer: iPhone Mail (18A393)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
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

Cj4gQW0gMTcuMTAuMjAyMCB1bSAwMDozOCBzY2hyaWViIFdlaSBZYW5nIDxyaWNoYXJkLndlaXlh
bmdAbGludXguYWxpYmFiYS5jb20+Ogo+IAo+IO+7v09uIEZyaSwgT2N0IDE2LCAyMDIwIGF0IDEy
OjMyOjUwUE0gKzAyMDAsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOgo+Pj4+PiBPaywgSSBzZWVt
cyB0byB1bmRlcnN0YW5kIHRoZSBsb2dpYyBub3cuCj4+Pj4+IAo+Pj4+PiBCdXQgaG93IHdlIHBy
ZXZlbnQgT05MSU5FX1BBUlRJQUwgbWVtb3J5IGJsb2NrIGdldCBvZmZsaW5lZD8gVGhlcmUgYXJl
IHRocmVlCj4+Pj4+IGNhbGxzIGluIHZpcnRpb19tZW1fc2V0X2Zha2Vfb2ZmbGluZSgpLCB3aGls
ZSBhbGwgb2YgdGhlbSBhZGp1c3QgcGFnZSdzIGZsYWcuCj4+Pj4+IEhvdyB0aGV5IGhvbGQgcmVm
ZXJlbmNlIHRvIHN0cnVjdCBwYWdlPwo+Pj4+IAo+Pj4+IFNvcnJ5LCBJIHNob3VsZCBoYXZlIGdp
dmVuIHlvdSB0aGUgcmlnaHQgcG9pbnRlci4gKHNpbWlsYXIgdG8gbXkgb3RoZXIKPj4+PiByZXBs
eSkKPj4+PiAKPj4+PiBXZSBob2xkIGEgcmVmZXJlbmNlIGVpdGhlciB2aWEKPj4+PiAKPj4+PiAx
LiBhbGxvY19jb250aWdfcmFuZ2UoKQo+Pj4gCj4+PiBJIGFtIG5vdCBmYW1pbGlhciB3aXRoIHRo
aXMgb25lLCBuZWVkIHRvIHNwZW5kIHNvbWUgdGltZSB0byBsb29rIGludG8uCj4+IAo+PiBFYWNo
IGluZGl2aWR1YWwgcGFnZSB3aWxsIGhhdmUgYSBwYWdlY291bnQgb2YgMS4KPj4gCj4+PiAKPj4+
PiAyLiBtZW1tYXAgaW5pdCBjb2RlLCB3aGVuIG5vdCBjYWxsaW5nIGdlbmVyaWNfb25saW5lX3Bh
Z2UoKS4KPj4+IAo+Pj4gSSBtYXkgbWlzcyBzb21lIGNvZGUgaGVyZS4gQmVmb3JlIG9ubGluZSBw
YWdlcywgbWVtbWFwcyBhcmUgYWxsb2NhdGVkIGluCj4+PiBzZWN0aW9uX2FjdGl2YXRlKCkuIFRo
ZXkgYXJlIHN1cHBvc2VkIHRvIGJlIHplcm8tZWQuIChJIGRvbid0IGdldCB0aGUgZXhhY3QKPj4+
IGNvZGUgbGluZS4pIEkgYW0gbm90IHN1cmUgd2hlbiB3ZSBncmFiIGEgcmVmY291bnQgaGVyZS4K
Pj4gCj4+IEJlc3QgdG8gcmVmZXIgdG8gX19pbml0X3NpbmdsZV9wYWdlKCkgLT4gaW5pdF9wYWdl
X2NvdW50KCkuCj4+IAo+PiBFYWNoIHBhZ2UgdGhhdCB3YXNuJ3Qgb25saW5lZCB2aWEgZ2VuZXJp
Y19vbmxpbmVfcGFnZSgpIGhhcyBhIHJlZmNvdW50Cj4+IG9mIDEgYW5kIGxvb2tzIGxpa2UgYWxs
b2NhdGVkLgo+PiAKPiAKPiBUaGFua3MsIEkgc2VlIHRoZSBsb2dpYy4KPiAKPiAgICBvbmxpbmVf
cGFnZXMoKQo+ICAgICAgICBtb3ZlX3Bmbl9yYW5nZV90b196b25lKCkgIC0tLSAxKQo+ICAgIG9u
bGluZV9wYWdlc19yYW5nZSgpICAgICAgLS0tIDIpCj4gCj4gQXQgMSksIF9faW5pdF9zaW5nbGVf
cGFnZSgpIHdvdWxkIHNldCBwYWdlIGNvdW50IHRvIDEuIEF0IDIpLAo+IGdlbmVyaWNfb25saW5l
X3BhZ2UoKSB3b3VsZCBjbGVhciBwYWdlIGNvdW50LCB3aGlsZSB0aGUgY2FsbCBiYWNrIHdvdWxk
IG5vdC4KPiAKPiBUaGVuIEkgYW0gdHJ5aW5nIHRvIHNlYXJjaCB0aGUgcGxhY2Ugd2hlcmUgdW4t
emVybyBwYWdlIGNvdW50IHByZXZlbnQgb2ZmbGluZS4KPiBzY2FuX21vdmFibGVfcGFnZXMoKSB3
b3VsZCBmYWlsLCBzaW5jZSB0aGlzIGlzIGEgUGFnZU9mZmxpbmUoKSBhbmQgaGFzIDEgcGFnZQo+
IGNvdW50Lgo+IAo+IFNvIHRoZSBHVUFSRCB3ZSBwcmV2ZW50IG9mZmxpbmUgcGFydGlhbC1vbmxp
bmVkIHBhZ2VzIGlzCj4gCj4gICAgKFBhZ2VPZmZsaW5lICYmIHBhZ2VfY291bnQpCj4gCj4gQW5k
IHlvdXIgY29tbWl0IGFhMjE4Nzk1Y2I1ZmQ1ODNjOTRmCj4gCj4gbW06IEFsbG93IHRvIG9mZmxp
bmUgdW5tb3ZhYmxlIFBhZ2VPZmZsaW5lKCkgcGFnZXMgdmlhIE1FTV9HT0lOR19PRkZMSU5FCj4g
Cj4gaXMgaW50cm9kdWNlZCB0byBoYW5kbGUgdGhpcyBjYXNlLgo+IAo+IFRoYXQncyBwcmV0dHkg
Y2xlYXIgbm93Lgo+IAoKSeKAmG0gaGFwcHkgdG8gc2VlIHRoYXQgSSBhbSBubyBsb25nZXIgdGhl
IG9ubHkgcGVyc29uIHRoYXQgdW5kZXJzdGFuZHMgYWxsIHRoaXMgbWFnaWMgOikKClRoYW5rcyBm
b3IgaGF2aW5nIGEgbG9vayAvIHJldmlld2luZyEKCj4+IC0tIAo+PiBUaGFua3MsCj4+IAo+PiBE
YXZpZCAvIGRoaWxkZW5iCj4gCj4gLS0gCj4gV2VpIFlhbmcKPiBIZWxwIHlvdSwgSGVscCBtZQo+
IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
