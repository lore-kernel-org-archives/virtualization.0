Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D63C433F5
	for <virtualization@archiver.kernel.org>; Tue,  7 Dec 2021 08:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C888B60784;
	Tue,  7 Dec 2021 08:14:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pzo506tVFQAk; Tue,  7 Dec 2021 08:14:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9655E607C6;
	Tue,  7 Dec 2021 08:14:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77C37C002F;
	Tue,  7 Dec 2021 08:14:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44C28C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 08:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2F37382A7F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 08:14:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aA0yLnI-_nnf
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 08:13:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1190D80C71
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 08:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638864837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tfh+QsbeI8c1JR4COebwKOvc8pVH47OrkczPHaMTbLA=;
 b=gszwmyMGib3hY//sNNl8jI2bHpNVDq4WRMCUsiLIH5D1nVIlfBFJcXjutqgQcmMWvS9uOc
 x5spHxPzVsLYIfrqYt2qx8+TG8I9dUOGDNFarxi0qIfm+hP4G5H2nc2PEFdl2L8jKIKqQ0
 HEvKMy4v8YrhSJrzyVXwbFbAdsZRFoo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300--PqY36cENMqCmYJwkP7OLw-1; Tue, 07 Dec 2021 03:13:56 -0500
X-MC-Unique: -PqY36cENMqCmYJwkP7OLw-1
Received: by mail-ed1-f71.google.com with SMTP id
 l15-20020a056402124f00b003e57269ab87so10690330edw.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Dec 2021 00:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Tfh+QsbeI8c1JR4COebwKOvc8pVH47OrkczPHaMTbLA=;
 b=QlBkdgXME99xaqiUzXEynY5ZX+lBqcdkvsJ9pWZVoBvGxYEZjEQh5gzkM+d3dCJSXi
 KATCnJhGzBNaCP98MKbqCEle8bxJM3WAFjS+uzS0k1mDslQD3LfJIr1GHnprIok/2M/W
 f4IvBmxSFPJ7T2X+FBBtAjJE/IRstONX5s3Bnf2fCG5hfgoU4GoYzm7wfaRenbf+KFYT
 LyB0kGCWDUdIqZj+08SHvT/xhiMeCclci6z/oWvI3FXjpY1DCD0maK744R/VoutHj8L1
 qLo6P1AJtmjW7D2QK5NDR6Hf+eiYEO2O4AFc6AZjtFqWWPkmVeH83fJ8WcgP43akuSXp
 deYg==
X-Gm-Message-State: AOAM533ZoNdriLRnvytnpk7m73dnRFqsQsTBp80XysBSV+j2T1mphypY
 kSgU+EPpiuMcl/TS7NPpcWACM7LskIG86tBCZ4umHGkC34PE9T4/+nfyJIfzw0kM14EwNqyYLeO
 y5keY5ZMXRcZPAqhu77DtmWEpsTKPRJVKmbSJQ2UjjA==
X-Received: by 2002:a17:907:97cd:: with SMTP id
 js13mr49671354ejc.357.1638864835235; 
 Tue, 07 Dec 2021 00:13:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkLJFFjVjY3FRN1uhVjLJGZguhtCSutl5YZnvuynKj2YXvkZ7hKACHe+2K6EpHxaXmI2R1aQ==
X-Received: by 2002:a17:907:97cd:: with SMTP id
 js13mr49671335ejc.357.1638864835028; 
 Tue, 07 Dec 2021 00:13:55 -0800 (PST)
Received: from redhat.com ([2a0e:1c80:7::36])
 by smtp.gmail.com with ESMTPSA id a13sm9482177edk.29.2021.12.07.00.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Dec 2021 00:13:54 -0800 (PST)
Date: Tue, 7 Dec 2021 03:13:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Subject: Re: [RFC PATCH] virtio: make sure legacy pci device gain 32bit-pfn vq
Message-ID: <20211207031217-mutt-send-email-mst@kernel.org>
References: <b50fff4d-9f05-76b3-eba7-91241c351751@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <b50fff4d-9f05-76b3-eba7-91241c351751@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
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

T24gVHVlLCBEZWMgMDcsIDIwMjEgYXQgMDM6NTE6NDVQTSArMDgwMCwg546L6LSHIHdyb3RlOgo+
IFdlIG9ic2VydmVkIGlzc3VlcyBsaWtlOgo+ICAgdmlydGlvLXBjaSAwMDAwOjE0OjAwLjA6IHBs
YXRmb3JtIGJ1ZzogbGVnYWN5IHZpcnRpby1tbWlvIG11c3QKPiAgIG5vdCBiZSB1c2VkIHdpdGgg
UkFNIGFib3ZlIDB4NDAwMEdCCj4gCj4gd2hlbiB3ZSBoYXZlIGEgbGVnYWN5IHBjaSBkZXZpY2Ug
d2hpY2ggZGVzaXJlZCAzMmJpdC1wZm4gdnEKPiBidXQgZ2FpbiA2NGJpdC1wZm4gaW5zdGVhZCwg
bGVhZCBpbnRvIHRoZSBmYWlsdXJlIG9mIHByb2JlLgo+IAo+IHZyaW5nX3VzZV9kbWFfYXBpKCkg
aXMgcGxheWluZyB0aGUga2V5IHJvbGUgaW4gaGVyZSwgdG8gaGVscCB0aGUKPiBhbGxvY2F0aW9u
IHByb2Nlc3MgdW5kZXJzdGFuZCB3aGljaCBraW5kIG9mIHZxIGl0IHNob3VsZCBhbGxvYywKPiBo
b3dldmVyLCBpdCBmYWlsZWQgdG8gdGFrZSBjYXJlIHRoZSBsZWdhY3kgcGNpIGRldmljZSwgd2hp
Y2ggb25seQo+IGhhdmUgMzJiaXQgZmVhdHVyZSBmbGFnIGFuZCBjYW4gbmV2ZXIgaGF2ZSBWSVJU
SU9fRl9BQ0NFU1NfUExBVEZPUk0KPiBzZXR0ZWQuCj4gCj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2Ug
Zm9yY2VfZG1hIGZsYWcgdG8gaGVscCB2cmluZ191c2VfZG1hX2FwaSgpCj4gdW5kZXJzdGFuZGlu
ZyB0aGUgcmVxdWlyZW1lbnQgYmV0dGVyLCB0byBhdm9pZCB0aGUgZmFpbGluZy4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbmcgPHl1bi53YW5nQGxpbnV4LmFsaWJhYmEuY29tPgoKVGhp
cyB3aWxsIGJyZWFrIGNvbmZpZ3Mgd2hlcmUgdGhlIGRldmljZSBhcHBlYXJzIGJlaGluZAphIHZp
cnR1YWwgaW9tbXUsIHNvIHRoaXMgd29uJ3QgZmx5LgpKdXN0IG1ha2UgeW91ciBkZXZpY2Ugc3Vw
cG9ydCAxLjAsIGVoPwoKPiAtLS0KPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3ku
YyB8IDEwICsrKysrKysrKysKPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyAgICAgICB8
ICAzICsrKwo+ICBpbmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAgICAgICAgIHwgIDEgKwo+ICAz
IGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYwo+IGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Bj
aV9sZWdhY3kuYwo+IGluZGV4IGQ2MmU5ODMuLjExZjJlYmYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19wY2lfbGVnYWN5LmMKPiBAQCAtMjYzLDYgKzI2MywxNiBAQCBpbnQgdmlydGlvX3BjaV9sZWdh
Y3lfcHJvYmUoc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlCj4gKnZwX2RldikKPiAgCXZwX2Rldi0+
c2V0dXBfdnEgPSBzZXR1cF92cTsKPiAgCXZwX2Rldi0+ZGVsX3ZxID0gZGVsX3ZxOwo+IAo+ICsJ
LyoKPiArCSAqIFRoZSBsZWdhY3kgcGNpIGRldmljZSByZXF1cmUgMzJiaXQtcGZuIHZxLAo+ICsJ
ICogb3Igc2V0dXBfdnEoKSB3aWxsIGZhaWxlZC4KPiArCSAqCj4gKwkgKiBUaHVzIHdlIG1ha2Ug
c3VyZSB2cmluZ191c2VfZG1hX2FwaSgpIHdpbGwKPiArCSAqIHJldHVybiB0cnVlIGR1cmluZyB0
aGUgYWxsb2NhdGlvbiBieSBtYXJraW5nCj4gKwkgKiBmb3JjZV9kbWEgaGVyZS4KPiArCSAqLwo+
ICsJdnBfZGV2LT52ZGV2LmZvcmNlX2RtYSA9IHRydWU7Cj4gKwo+ICAJcmV0dXJuIDA7Cj4gCj4g
IGVycl9pb21hcDoKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCAzMDM1YmI2Li42NTYyZTAxIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTI0NSw2ICsyNDUsOSBAQCBzdGF0aWMgaW5saW5l
IGJvb2wgdmlydHF1ZXVlX3VzZV9pbmRpcmVjdChzdHJ1Y3QKPiB2aXJ0cXVldWUgKl92cSwKPiAK
PiAgc3RhdGljIGJvb2wgdnJpbmdfdXNlX2RtYV9hcGkoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZk
ZXYpCj4gIHsKPiArCWlmICh2ZGV2LT5mb3JjZV9kbWEpCj4gKwkJcmV0dXJuIHRydWU7Cj4gKwo+
ICAJaWYgKCF2aXJ0aW9faGFzX2RtYV9xdWlyayh2ZGV2KSkKPiAgCQlyZXR1cm4gdHJ1ZTsKPiAK
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW8uaCBiL2luY2x1ZGUvbGludXgvdmly
dGlvLmgKPiBpbmRleCA0MWVkYmMwLi5hNGViMjlkIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvdmlydGlvLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gQEAgLTEwOSw2ICsx
MDksNyBAQCBzdHJ1Y3QgdmlydGlvX2RldmljZSB7Cj4gIAlib29sIGZhaWxlZDsKPiAgCWJvb2wg
Y29uZmlnX2VuYWJsZWQ7Cj4gIAlib29sIGNvbmZpZ19jaGFuZ2VfcGVuZGluZzsKPiArCWJvb2wg
Zm9yY2VfZG1hOwo+ICAJc3BpbmxvY2tfdCBjb25maWdfbG9jazsKPiAgCXNwaW5sb2NrX3QgdnFz
X2xpc3RfbG9jazsgLyogUHJvdGVjdHMgVlFzIGxpc3QgYWNjZXNzICovCj4gIAlzdHJ1Y3QgZGV2
aWNlIGRldjsKPiAtLSAKPiAxLjguMy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
