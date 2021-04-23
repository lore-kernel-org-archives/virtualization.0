Return-Path: <SRS0=bReq=JU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA238C433B4
	for <virtualization@archiver.kernel.org>; Fri, 23 Apr 2021 20:14:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D9C96145F
	for <virtualization@archiver.kernel.org>; Fri, 23 Apr 2021 20:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9C96145F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42BAB6064E;
	Fri, 23 Apr 2021 20:14:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZjbVp9ty_4fo; Fri, 23 Apr 2021 20:14:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF22E605DE;
	Fri, 23 Apr 2021 20:14:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C40A4C000E;
	Fri, 23 Apr 2021 20:14:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DF57C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 20:14:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 36ED3605E6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 20:14:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VpVDj_svK_Il
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 20:14:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE2B0605DE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 20:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619208882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kPiSTsL8TiObPGwF4YH7BB+/X0Qk9VUlPRyHxvfkG+U=;
 b=BCd5P5e5uuIrNOoNkM+7wrepI1tyv5bblCsI+TvMzz86eEckPzqw0zfkCcaPweKF27iUix
 zh/9S/3A3td8b4Kydx44DORJS/c8eWqNJr/RJNMvSXCSRNy5ybO2kw0P9aFV689B05hpGq
 /LmSUREOpEk7jOrjPFD9Wfaee9spe+0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-NtCHZ9v8PDqfxJmX4jEEBg-1; Fri, 23 Apr 2021 16:14:37 -0400
X-MC-Unique: NtCHZ9v8PDqfxJmX4jEEBg-1
Received: by mail-wr1-f71.google.com with SMTP id
 t14-20020a5d6a4e0000b029010277dcae0fso15401841wrw.22
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 13:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=kPiSTsL8TiObPGwF4YH7BB+/X0Qk9VUlPRyHxvfkG+U=;
 b=TAszd6/jYEgaUkvHCV572BvbjfbWfYEFcyELau5kVZsnuDfiBEEVZJHe9XQTrV7eS2
 ZeNt3y3hamiAQ1/hWH/FlvIMc8fiiaN38rBa6BNnLSO5a0CbI6bqUueodY/2WNVGXw5H
 XZDdgCBbXviz/1180Ne6b5iApGHTasAs4678TUq9f02F+y0eYKqoAIKnHY9RtI2aUX7d
 T5hEmrRUheLyyniIuuqGCvZTjFcE1CAyAbSVL/qQY8MGmW1o1+Qx1glIOkzW6grgOyxr
 62mr5FYg794dJqAnTs+wM3kNVMH77zM4j2p2xka6g2U3GipkJT5AhPm2W794hVpx+H+P
 mxVg==
X-Gm-Message-State: AOAM533uNlnOhMkGu4dg8ucP+1wi8jPqVjnkVS5LlRtygiuexMafpgKI
 xutkt8ZHgBgHwjPxs9h2MR6EqeIJHgAKz20+fH36DVh4v3K0XyU6KKn5VslZz3YwYJiHhS0ZyOB
 PUL6r8ngmcX4yXnOLLULVIKH0aFJp891cUOS+4ZCHgA==
X-Received: by 2002:adf:f0cc:: with SMTP id x12mr6889803wro.16.1619208876781; 
 Fri, 23 Apr 2021 13:14:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxS1qAa/j7zcr+DtFN+X2GWOzkZj3CTy5jb00vUo5xDAoIFKiSI5gTfVmMkq6tnjXpLfUWn/g==
X-Received: by 2002:adf:f0cc:: with SMTP id x12mr6889783wro.16.1619208876551; 
 Fri, 23 Apr 2021 13:14:36 -0700 (PDT)
Received: from redhat.com (212.116.168.114.static.012.net.il.
 [212.116.168.114])
 by smtp.gmail.com with ESMTPSA id s14sm9819112wrm.51.2021.04.23.13.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Apr 2021 13:14:35 -0700 (PDT)
Date: Fri, 23 Apr 2021 16:14:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 0/7] Untrusted device support for virtio
Message-ID: <20210423161114-mutt-send-email-mst@kernel.org>
References: <20210421032117.5177-1-jasowang@redhat.com>
 <20210422063128.GB4176641@infradead.org>
 <0c61dcbb-ac5b-9815-a4a1-5f93ae640011@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0c61dcbb-ac5b-9815-a4a1-5f93ae640011@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: ashish.kalra@amd.com, file@sect.tu-berlin.de,
 martin.radev@aisec.fraunhofer.de, kvm@vger.kernel.org, konrad.wilk@oracle.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, xieyongji@bytedance.com,
 stefanha@redhat.com
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

T24gVGh1LCBBcHIgMjIsIDIwMjEgYXQgMDQ6MTk6MTZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS80LzIyIOS4i+WNiDI6MzEsIENocmlzdG9waCBIZWxsd2lnIOWGmemB
kzoKPiA+IE9uIFdlZCwgQXByIDIxLCAyMDIxIGF0IDExOjIxOjEwQU0gKzA4MDAsIEphc29uIFdh
bmcgd3JvdGU6Cj4gPiA+IFRoZSBiZWhhaXZvciBmb3Igbm9uIERNQSBBUEkgaXMga2VwdCBmb3Ig
bWluaW1pemluZyB0aGUgcGVyZm9ybWFuY2UKPiA+ID4gaW1wYWN0Lgo+ID4gTkFLLiAgRXZlcnlv
bmUgc2hvdWxkIGJlIHVzaW5nIHRoZSBETUEgQVBJIGluIGEgbW9kZXJuIHdvcmxkLiAgU28KPiA+
IHRyZWF0aW5nIHRoZSBETUEgQVBJIHBhdGggd29yc2UgdGhhbiB0aGUgYnJva2VuIGxlZ2FjeSBw
YXRoIGRvZXMgbm90Cj4gPiBtYWtlIGFueSBzZW5zZSB3aGF0c29ldmVyLgo+IAo+IAo+IEkgdGhp
bmsgdGhlIGdvYWwgaXMgbm90IHRyZWF0IERNQSBBUEkgcGF0aCB3b3JzZSB0aGFuIGxlZ2FjeS4g
VGhlIGlzc3VlIGlzCj4gdGhhdCB0aGUgbWFuYWdlbWVudCBsYXllciBzaG91bGQgZ3VhcmFudGVl
IHRoYXQgQUNDRVNTX1BMQVRGT1JNIGlzIHNldCBzbwo+IERNQSBBUEkgaXMgZ3VhcmFudGVlZCB0
byBiZSB1c2VkIGJ5IHRoZSBkcml2ZXIuIFNvIEknbSBub3Qgc3VyZSBob3cgbXVjaAo+IHZhbHVl
IHdlIGNhbiBnYWluIGZyb20gdHJ5aW5nIHRvICdmaXgnIHRoZSBsZWdhY3kgcGF0aC4gQnV0IEkg
Y2FuIGNoYW5nZSB0aGUKPiBiZWhhdmlvciBvZiBsZWdhY3kgcGF0aCB0byBtYXRjaCBETUEgQVBJ
IHBhdGguCj4gCj4gVGhhbmtzCgpJIHRoaW5rIGJlZm9yZSB3ZSBtYWludGFpbiBkaWZmZXJlbnQg
cGF0aHMgd2l0aC93aXRob3V0IEFDQ0VTU19QTEFURk9STQppdCdzIHdvcnRoIGNoZWNraW5nIHdo
ZXRoZXIgaXQncyBldmVuIGEgbmV0IGdhaW4uIEF2b2lkaW5nIHNoYXJpbmcKYnkgc3RvcmluZyBk
YXRhIGluIHByaXZhdGUgbWVtb3J5IGNhbiBhY3R1YWxseSB0dXJuIG91dCB0byBiZQphIG5ldCBn
YWluIGV2ZW4gd2l0aG91dCBETUEgQVBJLgoKSXQgaXMgd29ydGggY2hlY2tpbmcgd2hhdCBpcyB0
aGUgcGVyZm9ybWFuY2UgZWZmZWN0IG9mIHRoaXMgcGF0Y2guCgoKLS0gCk1TVAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
