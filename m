Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB09CCA479
	for <virtualization@archiver.kernel.org>; Tue, 28 Jun 2022 18:06:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99AA941969;
	Tue, 28 Jun 2022 18:05:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 99AA941969
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=F/CZTCTD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lnSMNHpGQ9t8; Tue, 28 Jun 2022 18:05:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C4555410BB;
	Tue, 28 Jun 2022 18:05:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4555410BB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0840C0032;
	Tue, 28 Jun 2022 18:05:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2583EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 18:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED83B409DE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 18:05:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ED83B409DE
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=F/CZTCTD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2h_bGnm5Bs7o
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 18:05:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3EDBC4058D
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3EDBC4058D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 18:05:55 +0000 (UTC)
Received: by mail-pf1-x42a.google.com with SMTP id 65so12673725pfw.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 11:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=pTcGgtfSu6n7KkCWKQ4ciWe5XeKK5S4riO8KfNVW7Ig=;
 b=F/CZTCTDOlhkWqZ+vOzW0DaoZ/EZ1dOhoCSSJ2RrwBNwuY7CCyvEtaLLk8DO+FYVI8
 oY1bh2Rw2NH/e7uwuajkABgxQQynq/vb9wDrQT1ziurYSmeBDoqa9s9XGmGLyXXXVu1m
 Ptj/OKkdrLcBprdD9gQ9RffSNU26yKh9HCJiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=pTcGgtfSu6n7KkCWKQ4ciWe5XeKK5S4riO8KfNVW7Ig=;
 b=uiVdq2ztVqiwyj1GmT0gWWRDsUBrdhuQuEYg50oS1GxrquaPulZW+Bf8e1JI2P1nLj
 BHZYIJp48UKBPHH8wMOCDHsZzBCS5HUeSlJpB5fdyadPaHoWKshKUvInDQQELAO8S9jo
 OsFTfSQWzXXWAjv+QADk9Eq0I9UniREHWRYHB+STCj26iR/1FKbBfeoWIKbGJsBnlcsl
 WicdV4TZyazCkoDYtU5WvTcDZuOt2vYrMLCRycT1IC/iN32NoHE2tTOz1FwrbcH/7dEV
 xzlGjqPW+oMLVP4tHwedonRrdsLb3Hw9HyvOgextsUbqUIBPQleiblwhH41tHVhpB7wF
 SaPw==
X-Gm-Message-State: AJIora+53f0lYzbAHln6T3HpDD2h+fbCExWi27xZVDHTYC22da8Y23As
 2EOiVqF8iUi//bK9H8lLwb0bOQ==
X-Google-Smtp-Source: AGRyM1v6cdnwBfGpeB2JnkCbahQ14YUYaqjRd3VUKbR8YPBigZjfWVkzlvmFIFzfbBj+r2XqbA+86w==
X-Received: by 2002:a63:7412:0:b0:40c:fa27:9d07 with SMTP id
 p18-20020a637412000000b0040cfa279d07mr18441815pgc.27.1656439554674; 
 Tue, 28 Jun 2022 11:05:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id
 i3-20020a170902cf0300b0016a0ac06424sm9669985plg.51.2022.06.28.11.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jun 2022 11:05:54 -0700 (PDT)
Date: Tue, 28 Jun 2022 11:05:53 -0700
From: Kees Cook <keescook@chromium.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH][next] treewide: uapi: Replace zero-length arrays with
 flexible-array members
Message-ID: <202206281104.7CC3935@keescook>
References: <20220627180432.GA136081@embeddedor>
 <CAMuHMdU27TG_rpd=WTRPRcY22A4j4aN-6d_8OmK2aNpX06G3ig@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdU27TG_rpd=WTRPRcY22A4j4aN-6d_8OmK2aNpX06G3ig@mail.gmail.com>
Cc: nvdimm@lists.linux.dev,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, KVM list <kvm@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 dm-devel@redhat.com, target-devel <target-devel@vger.kernel.org>,
 MTD Maling List <linux-mtd@lists.infradead.org>,
 linux-hardening@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-s390 <linux-s390@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 kasan-dev <kasan-dev@googlegroups.com>, lvs-devel@vger.kernel.org,
 coreteam@netfilter.org, V9FS Developers <v9fs-developer@lists.sourceforge.net>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 linux-can@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 virtualization@lists.linux-foundation.org, io-uring@vger.kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 netdev <netdev@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org, linux-sctp@vger.kernel.org,
 NetFilter <netfilter-devel@vger.kernel.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
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

T24gVHVlLCBKdW4gMjgsIDIwMjIgYXQgMDk6Mjc6MjFBTSArMDIwMCwgR2VlcnQgVXl0dGVyaG9l
dmVuIHdyb3RlOgo+IEhpIEd1c3Rhdm8sCj4gCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQo+IAo+
IE9uIE1vbiwgSnVuIDI3LCAyMDIyIGF0IDg6MDQgUE0gR3VzdGF2byBBLiBSLiBTaWx2YQo+IDxn
dXN0YXZvYXJzQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4gVGhlcmUgaXMgYSByZWd1bGFyIG5lZWQg
aW4gdGhlIGtlcm5lbCB0byBwcm92aWRlIGEgd2F5IHRvIGRlY2xhcmUKPiA+IGhhdmluZyBhIGR5
bmFtaWNhbGx5IHNpemVkIHNldCBvZiB0cmFpbGluZyBlbGVtZW50cyBpbiBhIHN0cnVjdHVyZS4K
PiA+IEtlcm5lbCBjb2RlIHNob3VsZCBhbHdheXMgdXNlIOKAnGZsZXhpYmxlIGFycmF5IG1lbWJl
cnPigJ1bMV0gZm9yIHRoZXNlCj4gPiBjYXNlcy4gVGhlIG9sZGVyIHN0eWxlIG9mIG9uZS1lbGVt
ZW50IG9yIHplcm8tbGVuZ3RoIGFycmF5cyBzaG91bGQKPiA+IG5vIGxvbmdlciBiZSB1c2VkWzJd
Lgo+IAo+IFRoZXNlIHJ1bGVzIGFwcGx5IHRvIHRoZSBrZXJuZWwsIGJ1dCB1YXBpIGlzIG5vdCBj
b25zaWRlcmVkIHBhcnQgb2YgdGhlCj4ga2VybmVsLCBzbyBkaWZmZXJlbnQgcnVsZXMgYXBwbHku
ICBVYXBpIGhlYWRlciBmaWxlcyBzaG91bGQgd29yayB3aXRoCj4gd2hhdGV2ZXIgY29tcGlsZXIg
dGhhdCBjYW4gYmUgdXNlZCBmb3IgY29tcGlsaW5nIHVzZXJzcGFjZS4KClJpZ2h0LCB1c2Vyc3Bh
Y2UgaXNuJ3QgYm91bmQgYnkgdGhlc2UgcnVsZXMsIGJ1dCB0aGUga2VybmVsIGVuZHMgdXAKY29u
c3VtaW5nIHRoZXNlIHN0cnVjdHVyZXMsIHNvIHdlIG5lZWQgdG8gZml4IHRoZW0uIFRoZSBbMF0g
LT4gW10KY2hhbmdlcyAod2hlbiB0aGV5IGFyZSBub3QgZXJyb25lb3VzbHkgYmVpbmcgdXNlZCB3
aXRoaW4gb3RoZXIKc3RydWN0dXJlcykgaXMgdmFsaWQgZm9yIGFsbCBjb21waWxlcnMuIEZsZXhp
YmxlIGFycmF5cyBhcmUgQzk5OyBpdCdzCmJlZW4gMjMgeWVhcnMuIDopCgpCdXQsIHllcywgd2hl
cmUgd2UgRE8gYnJlYWsgc3R1ZmYgd2UgbmVlZCB0byB3b3JrYXJvdW5kIGl0LCBldGMuCgotLSAK
S2VlcyBDb29rCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
