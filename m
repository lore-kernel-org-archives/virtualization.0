Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EE4C433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 09:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F5B8831B0;
	Thu, 28 Apr 2022 09:55:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LFgQq_NAWXwr; Thu, 28 Apr 2022 09:55:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0399B83168;
	Thu, 28 Apr 2022 09:55:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC935C0039;
	Thu, 28 Apr 2022 09:55:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF6F2C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:55:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD80E60E2B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:55:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hNIzRO7pDpj9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:55:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DEDED60D89
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651139737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5aP1Q+8JfmpUFNd6dkQwSZRR+uZhHUFIETa06hclr9Q=;
 b=C6Xoi1vO40rUH2f6EZhQJqsLiHibNUO/gPwa3a8LDUtv6l6zG+p7xzbLIuxAIs37KDQAyj
 sDt1lr7G1QQsY+5YC/k3djv1I43CLcQFUiKxtuJ9QDVRqNgC34uHmSK9iW6ws90E7wp5uz
 EC5qMPhtU5kco53mltqmef41EpMePmk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-vuTrbZejND-mAi01K8tuHQ-1; Thu, 28 Apr 2022 05:55:34 -0400
X-MC-Unique: vuTrbZejND-mAi01K8tuHQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 n37-20020a05600c502500b0038fdc1394c6so1732264wmr.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 02:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=LAMPVNdq/kHZXC36MFoCnFQzkvkEzOW9H33jASJaclo=;
 b=1Gpw/ZToTI7P/dnKaeeKI+KPLVdbsw8n9HeSRZSvJ4+eJ32KMt6W0gQEBRiIXjwcv5
 VbvaGlNW41MTG/aKPl4t2KLwUZjw6uz+K98B2tV6sPloNp/6NB1EKWG6YTGkWlNkCtAd
 zw8R42eO03D07GImY9yKyaf7S3mido5Tm3xgm+oAQf8c5ivzFaGKndt17JKZMU3NsOw8
 aOpsKoKA96LwQ0lzWdafyd9ZhJrAoWo4LFNz+BoyznTuwxwS++2GFxwQz6rgjGYKp+lp
 z3UC/kFoDyJh6MJhgZw+9QRvSKIfwqMa5zOblPMc91uFBMNCGxHGtyTmwFIxluDSREeu
 ZmBQ==
X-Gm-Message-State: AOAM530bwE2vE/ogymZu66QJh4U1soTgzZ2YADFzJvyq1E0pncIDmR4W
 OSkTVhyoe5B8eAavCXCGYCSIhMqeYIuBuG6y7y11lSI4j2CHSGK6j1rewViP/WUyF5TSB7E49nM
 XYSp1YQRP4fmL7MSSdPfwuoiaQQWLvSfJ8N0p9IS5lA==
X-Received: by 2002:a05:6000:186a:b0:20a:e94c:8e68 with SMTP id
 d10-20020a056000186a00b0020ae94c8e68mr8644364wri.458.1651139733304; 
 Thu, 28 Apr 2022 02:55:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpPWxFqbdOW5KvLd6q7JL2LVTng4bvaGwfGBgZ2h4Lj1HrF2PRW5cw7a2EJu5Te3nDqhXhaw==
X-Received: by 2002:a05:6000:186a:b0:20a:e94c:8e68 with SMTP id
 d10-20020a056000186a00b0020ae94c8e68mr8644352wri.458.1651139733021; 
 Thu, 28 Apr 2022 02:55:33 -0700 (PDT)
Received: from smtpclient.apple ([2a01:e0a:834:5aa0:80d7:8022:3692:b311])
 by smtp.gmail.com with ESMTPSA id
 w12-20020adfbacc000000b0020aeed10962sm3557316wrg.61.2022.04.28.02.55.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 28 Apr 2022 02:55:32 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] virtio-pci: Remove wrong address verification in
 vp_del_vqs()
From: Christophe Marie Francois Dupont de Dinechin <cdupontd@redhat.com>
In-Reply-To: <B954A683-EE43-4469-B57A-EB8C6B671BEC@redhat.com>
Date: Thu, 28 Apr 2022 11:55:31 +0200
Message-Id: <2F2EFFE9-5174-49A8-A71F-EE134D387E07@redhat.com>
References: <20220415023002.49805-1-muriloo@linux.ibm.com>
 <e8620e70-16bb-639c-9446-68dcd199253f@linux.ibm.com>
 <A5CD1C91-F5D0-4109-9894-824184362B5C@redhat.com>
 <B954A683-EE43-4469-B57A-EB8C6B671BEC@redhat.com>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cdupontd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, mopsfelder@gmail.com,
 Christophe de Dinechin <dinechin@redhat.com>
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

Cgo+IE9uIDI4IEFwciAyMDIyLCBhdCAxMTo1MSwgQ2hyaXN0b3BoZSBNYXJpZSBGcmFuY29pcyBE
dXBvbnQgZGUgRGluZWNoaW4gPGNkdXBvbnRkQHJlZGhhdC5jb20+IHdyb3RlOgo+IAo+IAo+IAo+
PiBPbiAyOCBBcHIgMjAyMiwgYXQgMTE6NDYsIENocmlzdG9waGUgTWFyaWUgRnJhbmNvaXMgRHVw
b250IGRlIERpbmVjaGluIDxjZHVwb250ZEByZWRoYXQuY29tPiB3cm90ZToKPj4gCj4+IAo+PiAK
Pj4+IE9uIDE1IEFwciAyMDIyLCBhdCAwNTo1MSwgTXVyaWxvIE9wc2ZlbGRlciBBcmHDumpvIDxt
dXJpbG9vQGxpbnV4LmlibS5jb20+IHdyb3RlOgo+Pj4gCj4+PiBPbiA0LzE0LzIyIDIzOjMwLCBN
dXJpbG8gT3BzZmVsZGVyIEFyYXVqbyB3cm90ZToKPj4+PiBHQ0MgMTIgZW5oYW5jZWQgLVdhZGRy
ZXNzIHdoZW4gY29tcGFyaW5nIGFycmF5IGFkZHJlc3MgdG8gbnVsbCBbMF0sCj4+Pj4gd2hpY2gg
d2FybnM6Cj4+Pj4gZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYzogSW4gZnVuY3Rp
b24g4oCYdnBfZGVsX3Zxc+KAmToKPj4+PiBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1v
bi5jOjI1NzoyOTogd2FybmluZzogdGhlIGNvbXBhcmlzb24gd2lsbCBhbHdheXMgZXZhbHVhdGUg
YXMg4oCYdHJ1ZeKAmSBmb3IgdGhlIHBvaW50ZXIgb3BlcmFuZCBpbiDigJh2cF9kZXYtPm1zaXhf
YWZmaW5pdHlfbWFza3MgKyAoc2l6ZXR5cGUpKChsb25nIHVuc2lnbmVkIGludClpICogMjU2KeKA
mSBtdXN0IG5vdCBiZSBOVUxMIFstV2FkZHJlc3NdCj4+Pj4gMjU3IHwgaWYgKHZwX2Rldi0+bXNp
eF9hZmZpbml0eV9tYXNrc1tpXSkKPj4+PiB8IF5+fn5+fgo+Pj4+IEluIGZhY3QsIHRoZSB2ZXJp
ZmljYXRpb24gaXMgY29tcGFyaW5nIHRoZSByZXN1bHQgb2YgYSBwb2ludGVyCj4+Pj4gYXJpdGht
ZXRpYywgdGhlIGFkZHJlc3MgIm1zaXhfYWZmaW5pdHlfbWFza3MgKyBpIiwgd2hpY2ggd2lsbCBh
bHdheXMKPj4+PiBldmFsdWF0ZSB0byB0cnVlLgo+Pj4+IFVuZGVyIHRoZSBob29kLCBmcmVlX2Nw
dW1hc2tfdmFyKCkgY2FsbHMga2ZyZWUoKSwgd2hpY2ggaXMgc2FmZSB0byBwYXNzCj4+Pj4gTlVM
TCwgbm90IHJlcXVpcmluZyBub24tbnVsbCB2ZXJpZmljYXRpb24uIFNvIHJlbW92ZSB0aGUgdmVy
aWZpY2F0aW9uCj4+Pj4gdG8gbWFrZSBjb21waWxlciBoYXBweSAoaGFwcHkgY29tcGlsZXIsIGhh
cHB5IGxpZmUpLgo+Pj4+IFswXSBodHRwczovL2djYy5nbnUub3JnL2J1Z3ppbGxhL3Nob3dfYnVn
LmNnaT9pZD0xMDIxMDMKPj4+PiBTaWduZWQtb2ZmLWJ5OiBNdXJpbG8gT3BzZmVsZGVyIEFyYXVq
byA8bXVyaWxvb0BsaW51eC5pYm0uY29tPgo+Pj4+IC0tLQo+Pj4+IGRyaXZlcnMvdmlydGlvL3Zp
cnRpb19wY2lfY29tbW9uLmMgfCAzICstLQo+Pj4+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMiBkZWxldGlvbnMoLSkKPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3BjaV9jb21tb24uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPj4+
PiBpbmRleCBkNzI0ZjY3NjYwOGIuLjUwNDZlZmNmZmI0YyAxMDA2NDQKPj4+PiAtLS0gYS9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jCj4+Pj4gKysrIGIvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3BjaV9jb21tb24uYwo+Pj4+IEBAIC0yNTQsOCArMjU0LDcgQEAgdm9pZCB2cF9kZWxf
dnFzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+Pj4+IAlpZiAodnBfZGV2LT5tc2l4X2Fm
ZmluaXR5X21hc2tzKSB7Cj4+Pj4gCQlmb3IgKGkgPSAwOyBpIDwgdnBfZGV2LT5tc2l4X3ZlY3Rv
cnM7IGkrKykKPj4+PiAtCQkJaWYgKHZwX2Rldi0+bXNpeF9hZmZpbml0eV9tYXNrc1tpXSkKPj4+
PiAtCQkJCWZyZWVfY3B1bWFza192YXIodnBfZGV2LT5tc2l4X2FmZmluaXR5X21hc2tzW2ldKTsK
Pj4+PiArCQkJZnJlZV9jcHVtYXNrX3Zhcih2cF9kZXYtPm1zaXhfYWZmaW5pdHlfbWFza3NbaV0p
Owo+Pj4+IAl9Cj4+Pj4gCWlmICh2cF9kZXYtPm1zaXhfZW5hYmxlZCkgewo+Pj4gCj4+PiBBZnRl
ciBJIHNlbnQgdGhpcyBtZXNzYWdlLCBJIHJlYWxpemVkIHRoYXQgQ2hyaXN0b3BoZSAoY29waWVk
IGhlcmUpCj4+PiBoYWQgYWxyZWFkeSBwcm9wb3NlZCBhIGZpeDoKPj4+IAo+Pj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDQxNDE1MDg1NS4yNDA3MTM3LTQtZGluZWNoaW5AcmVk
aGF0LmNvbS8KPj4+IAo+Pj4gQ2hyaXN0b3BoZSwKPj4+IAo+Pj4gU2luY2UgZnJlZV9jcHVtYXNr
X3ZhcigpIGNhbGxzIGtmcmVlKCkgYW5kIGtmcmVlKCkgaXMgbnVsbC1zYWZlLAo+Pj4gY2FuIHdl
IGp1c3QgZHJvcCB0aGlzIG51bGwgdmVyaWZpY2F0aW9uIGFuZCBjYWxsIGZyZWVfY3B1bWFza192
YXIoKSByaWdodCBhd2F5Pwo+PiAKPj4gQXBvbG9naWVzIGZvciB0aGUgZGVsYXkgaW4gcmVzcG9u
ZGluZywgYnJva2VuIGxhcHRvcOKApgo+PiAKPj4gSW4gdGhlIGNhc2Ugd2hlcmUgQ09ORklHX0NQ
VU1BU0tfT0ZGU1RBQ0sgaXMgbm90IGRlZmluZWQsIHdlIGhhdmU6Cj4+IAo+PiAJdHlwZWRlZiBz
dHJ1Y3QgY3B1bWFzayBjcHVtYXNrX3Zhcl90WzFdOwo+PiAKPj4gU28gdGhhdCB2cF9kZXYtPm1z
aXhfYWZmaW5pdHlfbWFza3NbaV0gaXMgc3RhdGljYWxseSBub3QgbnVsbCAodGhhdOKAmXMgdGhl
IHdhcm5pbmcpCj4+IGJ1dCBhbHNvIGEgc3RhdGljIHBvaW50ZXIsIHNvIG5vdCBrZnJlZS1zYWZl
IElNTy4KPiAKPiDigKYgd2hpY2ggYWxzbyByZW5kZXJzIG15IG93biBwYXRjaCBpbnZhbGlkIDot
Lwo+IAo+IENvbXBpbGVyIHdhcm5pbmdzIGFyZSBnb29kLiBDbGVhcmx5IG5vdCBzdWZmaWNpZW50
LgoKQWgsIEkganVzdCBub3RpY2VkIHRoYXQgZnJlZV9jcHVtYXNrX3ZhciBpcyBhIG5vb3AgaW4g
dGhhdCBjYXNlLgoKU28geWVzLCB5b3VyIGZpeCBpcyBiZXR0ZXIgOi0pCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
