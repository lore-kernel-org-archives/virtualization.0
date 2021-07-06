Return-Path: <SRS0=EgWE=L6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D58C07E96
	for <virtualization@archiver.kernel.org>; Tue,  6 Jul 2021 11:42:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A787A61E4A
	for <virtualization@archiver.kernel.org>; Tue,  6 Jul 2021 11:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A787A61E4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 721B240122;
	Tue,  6 Jul 2021 11:42:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NRHWkmL4uus6; Tue,  6 Jul 2021 11:42:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 00B26400CD;
	Tue,  6 Jul 2021 11:42:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C51FAC0010;
	Tue,  6 Jul 2021 11:42:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7B3EC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 11:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A02F640122
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 11:42:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZXiTQ3ch-d-r
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 11:42:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5B57C400CD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 11:42:09 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id t17so37857554lfq.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Jul 2021 04:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=6xuYHcNFKOKQBrKUFUDH+4OX/ZzxgolWWFVCDDtB2Y0=;
 b=Yt+wwRbDrooYfJ07+RIOcvlbNAmDArbrvJ7r1S0Vf2cjg/rLU7fAYgPxXpkS/Es1c/
 LcGWWFOVsEF/0XQJw8Ic4i6Dtc59Y/PIazeWXS81o/I5/ykvg7NDoqtNhU6ZQY0qgpts
 hX13gyhgO6x+I73AAGb4ZN/+qaseZR6quq5U1fL8NFgVa2YoJXURs1gKcClPP7oowGFt
 CUO7YRn27lhbGlEADkw/xBbGzLYaM6sE1cZhR+vatbGDVqfyXQOHsgSlmcoOTDifCPOm
 ISHjTYrtj1Tj6vkK+FyowiPdLCC1ljyYKvKt5eTXHZu+z0mb6AF50iygoibOaTtpwXde
 Om/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=6xuYHcNFKOKQBrKUFUDH+4OX/ZzxgolWWFVCDDtB2Y0=;
 b=sPziunPYwRQ3E1RYBtJr/oMY45BUXdWQlRJ1lK3EjLwPLg0/T5lQaezlB3gB7+Wl6l
 7G0JFQkBag72jkSsuvt9m+/14eAw0ii9KJgZQim8l7AKDP5xDOyhfV3cFBb4FNDTmRsY
 DwjtNWEkpTPbt/ic8nEfDaUHPUK99XMGhVEEB62GGbmFxxpr2SYkZDxpVbQEJyqcQm36
 O1OXaZm+vmYRn9+M3L/7r6ZeYfcCJQ3F+UCiT7076XxSdAK3uaa8VLByahQFESHaobUC
 Zs4NMNOh/3SfHVvoK/8sXIcJPdQ9TP4S6Qj3MGSOvsAcewxuVfgRVtOXv8Q6IhH+04/E
 NGtw==
X-Gm-Message-State: AOAM533O2mkSkZZiYe+vA+4zcUObX6Ss+IRge+8rw0HWYJ/vpU70Ol5A
 W3ih8M3WrW/EvfxRDGQxCN8+ZO7+KMYz9g==
X-Google-Smtp-Source: ABdhPJxx+Xr4AcuLpRSkCC4EtytSRujE0SZ0zcPphvKN4FEK+8OpQKjY5aHg/Lctw2KdmVZr98nK+A==
X-Received: by 2002:a05:6000:12d0:: with SMTP id
 l16mr21397024wrx.189.1625567755049; 
 Tue, 06 Jul 2021 03:35:55 -0700 (PDT)
Received: from dell ([109.180.115.218])
 by smtp.gmail.com with ESMTPSA id l9sm16428319wrp.14.2021.07.06.03.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jul 2021 03:35:54 -0700 (PDT)
Date: Tue, 6 Jul 2021 11:35:52 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] bus: Make remove callback return void
Message-ID: <YOQxRS8HLTYthWNn@dell>
References: <20210706095037.1425211-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210706095037.1425211-1-u.kleine-koenig@pengutronix.de>
Cc: nvdimm@lists.linux.dev, linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fpga@vger.kernel.org,
 linux-pci@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-cxl@vger.kernel.org, linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 target-devel@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-i3c@lists.infradead.org, linux1394-devel@lists.sourceforge.net,
 linux-scsi@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
 Russell King <linux@armlinux.org.uk>, linux-acpi@vger.kernel.org,
 industrypack-devel@lists.sourceforge.net, linux-input@vger.kernel.org,
 linux-mmc@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, greybus-dev@lists.linaro.org,
 xen-devel@lists.xenproject.org, platform-driver-x86@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Geoff Levand <geoff@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, kernel@pengutronix.de, netdev@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-ntb@googlegroups.com,
 linuxppc-dev@lists.ozlabs.org
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

T24gVHVlLCAwNiBKdWwgMjAyMSwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6Cgo+IFRoZSBkcml2
ZXIgY29yZSBpZ25vcmVzIHRoZSByZXR1cm4gdmFsdWUgb2YgdGhpcyBjYWxsYmFjayBiZWNhdXNl
IHRoZXJlCj4gaXMgb25seSBsaXR0bGUgaXQgY2FuIGRvIHdoZW4gYSBkZXZpY2UgZGlzYXBwZWFy
cy4KPiAKPiBUaGlzIGlzIHRoZSBmaW5hbCBiaXQgb2YgYSBsb25nIGxhc3RpbmcgY2xlYW51cCBx
dWVzdCB3aGVyZSBzZXZlcmFsCj4gYnVzZXMgd2VyZSBjb252ZXJ0ZWQgdG8gYWxzbyByZXR1cm4g
dm9pZCBmcm9tIHRoZWlyIHJlbW92ZSBjYWxsYmFjay4KPiBBZGRpdGlvbmFsbHkgc29tZSByZXNv
dXJjZSBsZWFrcyB3ZXJlIGZpeGVkIHRoYXQgd2VyZSBjYXVzZWQgYnkgZHJpdmVycwo+IHJldHVy
bmluZyBhbiBlcnJvciBjb2RlIGluIHRoZSBleHBlY3RhdGlvbiB0aGF0IHRoZSBkcml2ZXIgd29u
J3QgZ28KPiBhd2F5Lgo+IAo+IFdpdGggc3RydWN0IGJ1c190eXBlOjpyZW1vdmUgcmV0dXJuaW5n
IHZvaWQgaXQncyBwcmV2ZW50ZWQgdGhhdCBuZXdseQo+IGltcGxlbWVudGVkIGJ1c2VzIHJldHVy
biBhbiBpZ25vcmVkIGVycm9yIGNvZGUgYW5kIHNvIGRvbid0IGFudGljaXBhdGUKPiB3cm9uZyBl
eHBlY3RhdGlvbnMgZm9yIGRyaXZlciBhdXRob3JzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFV3ZSBL
bGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+Cj4gLS0tCj4gSGVs
bG8sCj4gCj4gdGhpcyBwYXRjaCBkZXBlbmRzIG9uICJQQ0k6IGVuZHBvaW50OiBNYWtlIHN0cnVj
dCBwY2lfZXBmX2RyaXZlcjo6cmVtb3ZlCj4gcmV0dXJuIHZvaWQiIHRoYXQgaXMgbm90IHlldCBh
cHBsaWVkLCBzZWUKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjEwMjIzMDkwNzU3LjU3
NjA0LTEtdS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlLgo+IAo+IEkgdGVzdGVkIGl0IHVz
aW5nIGFsbG1vZGNvbmZpZyBvbiBhbWQ2NCBhbmQgYXJtLCBidXQgSSB3b3VsZG4ndCBiZQo+IHN1
cnByaXNlZCBpZiBJIHN0aWxsIG1pc3NlZCB0byBjb252ZXJ0IGEgZHJpdmVyLiBTbyBpdCB3b3Vs
ZCBiZSBncmVhdCB0bwo+IGdldCB0aGlzIGludG8gbmV4dCBlYXJseSBhZnRlciB0aGUgbWVyZ2Ug
d2luZG93IGNsb3Nlcy4KPiAKPiBJIHNlbmQgdGhpcyBtYWlsIHRvIGFsbCBwZW9wbGUgdGhhdCBn
ZXRfbWFpbnRhaW5lci5wbCBlbWl0cyBmb3IgdGhpcwo+IHBhdGNoLiBJIHdvbmRlciBob3cgbWFu
eSByZWNpcGVudHMgd2lsbCByZWZ1c2UgdGhpcyBtYWlsIGJlY2F1c2Ugb2YgdGhlCj4gbG9uZyBD
YzogbGlzdCA6LSkKPiAKPiBCZXN0IHJlZ2FyZHMKPiBVd2UKPiAKPiAgYXJjaC9hcm0vY29tbW9u
L2xvY29tby5jICAgICAgICAgICAgICAgICAgfCAzICstLQo+ICBhcmNoL2FybS9jb21tb24vc2Ex
MTExLmMgICAgICAgICAgICAgICAgICB8IDQgKy0tLQo+ICBhcmNoL2FybS9tYWNoLXJwYy9lY2Fy
ZC5jICAgICAgICAgICAgICAgICB8IDQgKy0tLQo+ICBhcmNoL21pcHMvc2dpLWlwMjIvaXAyMi1n
aW8uYyAgICAgICAgICAgICB8IDMgKy0tCj4gIGFyY2gvcGFyaXNjL2tlcm5lbC9kcml2ZXJzLmMg
ICAgICAgICAgICAgIHwgNSArKy0tLQo+ICBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzMy9zeXN0
ZW0tYnVzLmMgICB8IDMgKy0tCj4gIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9pYm1l
YnVzLmMgIHwgMyArLS0KPiAgYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2VyaWVzL3Zpby5jICAg
ICAgfCAzICstLQo+ICBkcml2ZXJzL2FjcGkvYnVzLmMgICAgICAgICAgICAgICAgICAgICAgICB8
IDMgKy0tCj4gIGRyaXZlcnMvYW1iYS9idXMuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgNCAr
LS0tCj4gIGRyaXZlcnMvYmFzZS9hdXhpbGlhcnkuYyAgICAgICAgICAgICAgICAgIHwgNCArLS0t
Cj4gIGRyaXZlcnMvYmFzZS9pc2EuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgNCArLS0tCj4g
IGRyaXZlcnMvYmFzZS9wbGF0Zm9ybS5jICAgICAgICAgICAgICAgICAgIHwgNCArLS0tCj4gIGRy
aXZlcnMvYmNtYS9tYWluLmMgICAgICAgICAgICAgICAgICAgICAgIHwgNiArKy0tLS0KPiAgZHJp
dmVycy9idXMvc3VueGktcnNiLmMgICAgICAgICAgICAgICAgICAgfCA0ICstLS0KPiAgZHJpdmVy
cy9jeGwvY29yZS5jICAgICAgICAgICAgICAgICAgICAgICAgfCAzICstLQo+ICBkcml2ZXJzL2Rh
eC9idXMuYyAgICAgICAgICAgICAgICAgICAgICAgICB8IDQgKy0tLQo+ICBkcml2ZXJzL2RtYS9p
ZHhkL3N5c2ZzLmMgICAgICAgICAgICAgICAgICB8IDQgKy0tLQo+ICBkcml2ZXJzL2ZpcmV3aXJl
L2NvcmUtZGV2aWNlLmMgICAgICAgICAgICB8IDQgKy0tLQo+ICBkcml2ZXJzL2Zpcm13YXJlL2Fy
bV9zY21pL2J1cy5jICAgICAgICAgICB8IDQgKy0tLQo+ICBkcml2ZXJzL2Zpcm13YXJlL2dvb2ds
ZS9jb3JlYm9vdF90YWJsZS5jICB8IDQgKy0tLQo+ICBkcml2ZXJzL2ZwZ2EvZGZsLmMgICAgICAg
ICAgICAgICAgICAgICAgICB8IDQgKy0tLQo+ICBkcml2ZXJzL2hpZC9oaWQtY29yZS5jICAgICAg
ICAgICAgICAgICAgICB8IDQgKy0tLQo+ICBkcml2ZXJzL2hpZC9pbnRlbC1pc2gtaGlkL2lzaHRw
L2J1cy5jICAgICB8IDQgKy0tLQo+ICBkcml2ZXJzL2h2L3ZtYnVzX2Rydi5jICAgICAgICAgICAg
ICAgICAgICB8IDUgKy0tLS0KPiAgZHJpdmVycy9od3RyYWNpbmcvaW50ZWxfdGgvY29yZS5jICAg
ICAgICAgfCA0ICstLS0KPiAgZHJpdmVycy9pMmMvaTJjLWNvcmUtYmFzZS5jICAgICAgICAgICAg
ICAgfCA1ICstLS0tCj4gIGRyaXZlcnMvaTNjL21hc3Rlci5jICAgICAgICAgICAgICAgICAgICAg
IHwgNCArLS0tCj4gIGRyaXZlcnMvaW5wdXQvZ2FtZXBvcnQvZ2FtZXBvcnQuYyAgICAgICAgIHwg
MyArLS0KPiAgZHJpdmVycy9pbnB1dC9zZXJpby9zZXJpby5jICAgICAgICAgICAgICAgfCAzICst
LQo+ICBkcml2ZXJzL2lwYWNrL2lwYWNrLmMgICAgICAgICAgICAgICAgICAgICB8IDQgKy0tLQo+
ICBkcml2ZXJzL21hY2ludG9zaC9tYWNpb19hc2ljLmMgICAgICAgICAgICB8IDQgKy0tLQo+ICBk
cml2ZXJzL21jYi9tY2ItY29yZS5jICAgICAgICAgICAgICAgICAgICB8IDQgKy0tLQo+ICBkcml2
ZXJzL21lZGlhL3BjaS9idDh4eC9idHR2LWdwaW8uYyAgICAgICB8IDMgKy0tCj4gIGRyaXZlcnMv
bWVtc3RpY2svY29yZS9tZW1zdGljay5jICAgICAgICAgIHwgMyArLS0KCj4gIGRyaXZlcnMvbWZk
L21jcC1jb3JlLmMgICAgICAgICAgICAgICAgICAgIHwgMyArLS0KCkFja2VkLWJ5OiBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgoKLS0gCkxlZSBKb25lcyBb5p2O55C85pavXQpTZW5p
b3IgVGVjaG5pY2FsIExlYWQgLSBEZXZlbG9wZXIgU2VydmljZXMKTGluYXJvLm9yZyDilIIgT3Bl
biBzb3VyY2Ugc29mdHdhcmUgZm9yIEFybSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwg
VHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
