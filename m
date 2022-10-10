Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAD1C433FE
	for <virtualization@archiver.kernel.org>; Mon, 10 Oct 2022 18:56:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E90D882611;
	Mon, 10 Oct 2022 18:56:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E90D882611
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Y1FJnNxK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kw8a9ni82bxl; Mon, 10 Oct 2022 18:56:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6777881429;
	Mon, 10 Oct 2022 18:56:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6777881429
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21835C0033;
	Mon, 10 Oct 2022 18:56:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F34C2C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 18:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C6EB04018A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 18:56:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C6EB04018A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca
 header.a=rsa-sha256 header.s=google header.b=Y1FJnNxK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bJYgun9AA8zh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 18:56:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 38D1C40012
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 38D1C40012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 18:56:40 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id o22so6808861qkl.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 11:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mfdinePb/h+FQryCI1VnJk1iVMwwW9XbS8GRZ1SXnEM=;
 b=Y1FJnNxKCCmUeBjERypSSpOT5hLZIa3B6ZfL7TmeBlDcYn7G53u+wzaqGztD4xstS6
 H56NjZrTnnAs/mwbv/53uHY1GhzxoFxOLWj+6+255TR+XIgzukZ2wrhnTPfXH4rpl0ll
 x20RYa7gkPKPOAB+2GjUbYRf86UKilK/+RP5mPzo1iTwxgbIcI/NL1hAwcQva+CI+c58
 wXQg1m452/c0qjzqE/xGhDgd9xycIGhUX5tiX7SJhqTWnYftDSAsnXqQ0qceqqSNwxFf
 a0gsQbHVGj7OQXKVN8LpCmOTHmcWT/lMPoHErC7k7GBXJjyyytJ8h/nDzI7STIfMcpme
 CGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mfdinePb/h+FQryCI1VnJk1iVMwwW9XbS8GRZ1SXnEM=;
 b=MnNAunAxJ+HriHIY8SND5mjKjpLy6ISXNj3hZniW1FYXUicPblrB0uywF8dse1kTcy
 6sSWYC6MJc8h/Tz4GHu4Cgo5lNjuSVcHiW01XU9SL/6FHq7HLohw2SY33QKkkq2UTTGk
 3ABxplZnpo4OgLfIiiBbXGN3LBRD6qY86fbz3cmt5/MI7pbAuiHz4uEC5tmjjfosyyV7
 3qQu5KejRzDA/gqkGmSwZWuuNO2gJNczGEAz271q3Gc/OuB6iJWXjyriqzZAOv5ZUmjN
 4FyDSdUD/QVZc5lt7XbBB9KTi8cDKS3zi95/YVMTCWYih33CguBoPRB4PwR5yEFwgS5U
 Hh5Q==
X-Gm-Message-State: ACrzQf3PlV3K7/4r71Zb5H6wZOlI8BPlobcuNhPPyrlvnbeJaqedaT9m
 dLbnVayRp9rJZ6ZSdrPlHzRliA==
X-Google-Smtp-Source: AMsMyM4cq1ZiSompu2ffs6ddf24dPwkk/2Lnq1GVt1O6/KQn3scUPTnTqdwZ/uWcjL7riJrPyy9iDQ==
X-Received: by 2002:a05:620a:4397:b0:6e1:345a:e080 with SMTP id
 a23-20020a05620a439700b006e1345ae080mr13783062qkp.677.1665428198984; 
 Mon, 10 Oct 2022 11:56:38 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.122.23]) by smtp.gmail.com with ESMTPSA id
 j8-20020a05620a288800b006bb2cd2f6d1sm10684472qkp.127.2022.10.10.11.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Oct 2022 11:56:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1ohxx7-0012V5-CO;
 Mon, 10 Oct 2022 15:56:37 -0300
Date: Mon, 10 Oct 2022 15:56:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v6 10/21] RDMA/umem: Prepare to dynamic dma-buf locking
 specification
Message-ID: <Y0Rq5Zb9+63++2z/@ziepe.ca>
References: <20220928191600.5874-1-dmitry.osipenko@collabora.com>
 <20220928191600.5874-11-dmitry.osipenko@collabora.com>
 <e3ba146d-8153-add5-2cf4-02fe6519abee@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e3ba146d-8153-add5-2cf4-02fe6519abee@collabora.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Ruhl Michael J <michael.j.ruhl@intel.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
 Russell King <linux@armlinux.org.uk>, Daniel Stone <daniel@fooishbar.org>,
 Gustavo Padovan <gustavo.padovan@collabora.com>, Chia-I Wu <olvaffe@gmail.com>,
 linux-media@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, linaro-mm-sig@lists.linaro.org,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Juergen Gross <jgross@suse.com>,
 David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
 Tomi Valkeinen <tomba@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Rob Clark <robdclark@gmail.com>, Qiang Yu <yuq825@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Lucas Stach <l.stach@pengutronix.de>
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

T24gU3VuLCBPY3QgMDksIDIwMjIgYXQgMDM6MDg6NTZBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IE9uIDkvMjgvMjIgMjI6MTUsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPiA+IFBy
ZXBhcmUgSW5maW5pQmFuZCBkcml2ZXJzIHRvIHRoZSBjb21tb24gZHluYW1pYyBkbWEtYnVmIGxv
Y2tpbmcKPiA+IGNvbnZlbnRpb24gYnkgc3RhcnRpbmcgdG8gdXNlIHRoZSB1bmxvY2tlZCB2ZXJz
aW9ucyBvZiBkbWEtYnVmIEFQSQo+ID4gZnVuY3Rpb25zLgo+ID4gCj4gPiBBY2tlZC1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+ID4gU2lnbmVkLW9mZi1i
eTogRG1pdHJ5IE9zaXBlbmtvIDxkbWl0cnkub3NpcGVua29AY29sbGFib3JhLmNvbT4KPiA+IC0t
LQo+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3VtZW1fZG1hYnVmLmMgfCA3ICsrKystLS0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+ID4g
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvdW1lbV9kbWFidWYuYyBi
L2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3VtZW1fZG1hYnVmLmMKPiA+IGluZGV4IDA0YzA0ZTZk
MjRjMy4uNDNiMjZiYzEyMjg4IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2Nv
cmUvdW1lbV9kbWFidWYuYwo+ID4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvdW1lbV9k
bWFidWYuYwo+ID4gQEAgLTI2LDcgKzI2LDggQEAgaW50IGliX3VtZW1fZG1hYnVmX21hcF9wYWdl
cyhzdHJ1Y3QgaWJfdW1lbV9kbWFidWYgKnVtZW1fZG1hYnVmKQo+ID4gIAlpZiAodW1lbV9kbWFi
dWYtPnNndCkKPiA+ICAJCWdvdG8gd2FpdF9mZW5jZTsKPiA+ICAKPiA+IC0Jc2d0ID0gZG1hX2J1
Zl9tYXBfYXR0YWNobWVudCh1bWVtX2RtYWJ1Zi0+YXR0YWNoLCBETUFfQklESVJFQ1RJT05BTCk7
Cj4gPiArCXNndCA9IGRtYV9idWZfbWFwX2F0dGFjaG1lbnRfdW5sb2NrZWQodW1lbV9kbWFidWYt
PmF0dGFjaCwKPiA+ICsJCQkJCSAgICAgIERNQV9CSURJUkVDVElPTkFMKTsKPiA+ICAJaWYgKElT
X0VSUihzZ3QpKQo+ID4gIAkJcmV0dXJuIFBUUl9FUlIoc2d0KTsKPiA+ICAKPiA+IEBAIC0xMDIs
OCArMTAzLDggQEAgdm9pZCBpYl91bWVtX2RtYWJ1Zl91bm1hcF9wYWdlcyhzdHJ1Y3QgaWJfdW1l
bV9kbWFidWYgKnVtZW1fZG1hYnVmKQo+ID4gIAkJdW1lbV9kbWFidWYtPmxhc3Rfc2dfdHJpbSA9
IDA7Cj4gPiAgCX0KPiA+ICAKPiA+IC0JZG1hX2J1Zl91bm1hcF9hdHRhY2htZW50KHVtZW1fZG1h
YnVmLT5hdHRhY2gsIHVtZW1fZG1hYnVmLT5zZ3QsCj4gPiAtCQkJCSBETUFfQklESVJFQ1RJT05B
TCk7Cj4gPiArCWRtYV9idWZfdW5tYXBfYXR0YWNobWVudF91bmxvY2tlZCh1bWVtX2RtYWJ1Zi0+
YXR0YWNoLCB1bWVtX2RtYWJ1Zi0+c2d0LAo+ID4gKwkJCQkJICBETUFfQklESVJFQ1RJT05BTCk7
Cj4gPiAgCj4gPiAgCXVtZW1fZG1hYnVmLT5zZ3QgPSBOVUxMOwo+ID4gIH0KPiAKPiBKYXNvbiAv
IExlb24sCj4gCj4gQ291bGQgeW91IHBsZWFzZSBhY2sgdGhpcyBwYXRjaD8KCllvdSBwcm9iYWJs
eSBkb24ndCBuZWVkIGl0LCBmb3Igc29tZXRoaW5nIHNvIHNpbXBsZSwgYnV0IHN1cmUKCkFja2Vk
LWJ5OiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPgoKSmFzb24KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
