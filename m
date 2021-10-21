Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA226C4332F
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 09:52:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7658361208
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 09:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7658361208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31D0980D18;
	Thu, 21 Oct 2021 09:52:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L9IQqLq42rdv; Thu, 21 Oct 2021 09:52:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CD98380D10;
	Thu, 21 Oct 2021 09:52:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AACA7C001C;
	Thu, 21 Oct 2021 09:52:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28D1EC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A722407BF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:52:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x5ZfPx_94xhT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:52:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6870D407A9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:52:32 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id t11so4990plq.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 02:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=s8GVDPZbs1ohxYG57S1dcGlrQ4Cx6gTTkx49YWQo1/c=;
 b=TwLcgLjgX9bYFD9eP5Ek3yEmNQwbBBbTuYbS0GCTt8UPoCz0WD0KO7lFf3pTynd0ZX
 JdEEMM371ajf16tU1ZPWxOdXpoBJr2TW7Hh/vgp2G5YdsCD/pVdqjdaDLGlufEgE9T8d
 Xs1rc1IaOEjBukh0YfYMNfZnaY0LCdnoXSsJg40grYzOZMkK5AzRKu8cAJQXnySYy0B2
 BpLHHgUAX/MVR1jvpvjpoW4K99fEUD2QXLeBVU4ft2b3gXILrxStHYdAQBHtZ/kdWi0l
 FMLSO9YsbotJp0Km+8WGH+isWZlJyY328MvcWT5DqOvMuz+zMurFvFK4usUKZsBt2lMh
 KuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=s8GVDPZbs1ohxYG57S1dcGlrQ4Cx6gTTkx49YWQo1/c=;
 b=5G6qp5iYoW1eIswX31obQDTrPLtUwXZcuQ/RsRb5xlyu3znmERh3lMXD6QMchiW19Z
 c9cQhN/TPDutDy3Vlbz2ffctKJ1PFlwAPdAv3tQ6G7crW0LVh+64vnPalE+lOhM+b27B
 vs80QPaqli9KVSZxmudPLu2Dwmu4H+zXuqhMFF/naZJo3nXtirDrcI405K3ZoMS6Ps04
 m2QtdrbMATtgUq9SDGPdhPf1RQWT25W81gyyDjoofxiaiMzGurpztqrgF4EGHPxAslG1
 kfKa1a0odTm+y/Q0eKuiXbbkQcT4PXWki8kMRdCMY+nakqMrBbP86rUj/Q0L0neuJ7ye
 HEWA==
X-Gm-Message-State: AOAM530w1BjzP1Uw1u6Me72jf64t1/7JXpWAp20/oQ7vzFPZDBL72UDG
 x1eKsaVC5X0hT91QhtHJMtI6OA==
X-Google-Smtp-Source: ABdhPJyeAs/gDABnfkFtqVaOrAQk5aInjWCwAYmhk/Ty1XhXPWQqE50SiTVAYX4TqbR1cqwh1gOSww==
X-Received: by 2002:a17:90a:e547:: with SMTP id
 ei7mr5538859pjb.169.1634809951794; 
 Thu, 21 Oct 2021 02:52:31 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id p8sm5923077pfo.112.2021.10.21.02.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Oct 2021 02:52:31 -0700 (PDT)
Date: Thu, 21 Oct 2021 15:22:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V6] gpio: virtio: Add IRQ support
Message-ID: <20211021095229.lqeb7dtxv4ix2vc5@vireshk-i7>
References: <8ca87330fd348fc5199ad08904ec90cc6a91a1bf.1634723848.git.viresh.kumar@linaro.org>
 <CAHp75Vctj-v8W+LgdVpYgRVL3fLdcFnOFRFg74LeCc=xLD+w4w@mail.gmail.com>
 <20211021043443.snhqpac5ofmxfb7k@vireshk-i7>
 <CAHp75VdKn7Sze9HxN0gBgbuQS2K6oB+SQsufw576Rkfg4-osOw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHp75VdKn7Sze9HxN0gBgbuQS2K6oB+SQsufw576Rkfg4-osOw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <vireshk@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "stratos-dev@op-lists.linaro.org" <stratos-dev@op-lists.linaro.org>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Bill Mills <bill.mills@linaro.org>
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

T24gMjEtMTAtMjEsIDEyOjQyLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6Cj4gT24gVGh1LCBPY3Qg
MjEsIDIwMjEgYXQgNzozNCBBTSBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3Jn
PiB3cm90ZToKPiA+IE9uIDIwLTEwLTIxLCAxODoxMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOgo+
ID4gPiBJSVJDIHlvdSBhZGQgZGVhZCBjb2RlLiBJUlEgZnJhbWV3b3JrIG5ldmVyIGNhbGxzIHRo
aXMgaWYgdHlwZSBpcyBub3Qgc2V0Lgo+ID4KPiA+IFllcywgYnV0IGl0IGlzIGFsbG93ZWQgdG8g
Y2FsbAo+ID4KPiA+IGlycV9zZXRfaXJxX3R5cGUoaXJxLCBJUlFfVFlQRV9OT05FKTsKPiA+Cj4g
PiBhbmQgdGhlIGlycSBmcmFtZXdvcmsgd29uJ3QgZGlzYWxsb3cgaXQgQUZBSUNULgo+IAo+IFRo
YXQncyB0cnVlLCBidXQgaG93IHlvdSBtYXkgZW5kIHVwIGluIHRoaXMgY2FsbGJhY2sgd2l0aCBh
IHN1Y2g/Cj4gV2hhdCB0aGUgbWVhbmluZyBvZiB0aGF0IGNhbGwgdG8gdGhlIHVzZXI/CiAKSSBj
YW4gc2VlIGZldyBjYWxscyBsaWtlIHRoaXMgaW4gdGhlIGtlcm5lbCAobW9zdGx5IGZyb20gaXJx
LXByb3ZpZGVycwpvbmx5KSwgYnV0IHllYWggc3VyZSBJIGNhbiBkcm9wIGl0LiBXZSB3aWxsIGVy
cm9yIG91dCBpZiBpdCBldmVyIGdldHMKY2FsbGVkIGFuZCBzbyBjYW4gZ2V0IGl0IGJhY2sgbGF0
ZXIgaWYgcmVxdWlyZWQuCiAKPiA+ID4gPiAgc3RydWN0IHZpcnRpb19ncGlvX2NvbmZpZyB7Cj4g
PiA+ID4gICAgICAgICBfX2xlMTYgbmdwaW87Cj4gPiA+ID4gICAgICAgICBfX3U4IHBhZGRpbmdb
Ml07Cj4gPiA+ID4gQEAgLTQ0LDQgKzU2LDE3IEBAIHN0cnVjdCB2aXJ0aW9fZ3Bpb19yZXNwb25z
ZV9nZXRfbmFtZXMgewo+ID4gPiA+ICAgICAgICAgX191OCB2YWx1ZVtdOwo+ID4gPiA+ICB9Owo+
ID4gPiA+Cj4gPiA+ID4gKy8qIFZpcnRpbyBHUElPIElSUSBSZXF1ZXN0IC8gUmVzcG9uc2UgKi8K
PiA+ID4gPiArc3RydWN0IHZpcnRpb19ncGlvX2lycV9yZXF1ZXN0IHsKPiA+ID4gPiArICAgICAg
IF9fbGUxNiBncGlvOwo+ID4gPiA+ICt9Owo+ID4gPiA+ICsKPiA+ID4gPiArc3RydWN0IHZpcnRp
b19ncGlvX2lycV9yZXNwb25zZSB7Cj4gPiA+ID4gKyAgICAgICBfX3U4IHN0YXR1czsKPiA+ID4g
PiArfTsKPiA+ID4gPgo+ID4gPiBJ4oCZbSB3b25kZXJpbmcgaWYgdGhvc2UgYWJvdmUgc2hvdWxk
IGJlIHBhY2tlZC4KPiA+Cj4gPiBZb3UgYXJlIHRhbGtpbmcgYWJvdXQgdGhlIG5ld2x5IGFkZGVk
IG9uZXMgb3IgdGhlIG9uZXMgYmVmb3JlID8KPiA+Cj4gPiBJbiBhbnkgY2FzZSwgdGhleSBhcmUg
YWxsIGFscmVhZHkgcGFja2VkIChpLmUuIHRoZXkgaGF2ZSBleHBsaWNpdAo+ID4gcGFkZGluZyB3
aGVyZXZlciByZXF1aXJlZCkgYW5kIHByb3Blcmx5IGFsaWduZWQuIENvbXBpbGVyIHdvbid0IGFk
ZAo+ID4gYW55IG90aGVyIHBhZGRpbmcgdG8gdGhlbS4KPiAKPiBJcyBpdCBvbmx5IGZvciA2NC1i
aXQgdG8gNjQtYml0IGNvbW11bmljYXRpb25zPwoKVGhhdCdzIHdoYXQgSSBoYXZlIGJlZW4gbG9v
a2luZyBhdC4KCj4gSWYgdGhlcmUgaXMgYSBwb3NzaWJpbGl0eSB0byBoYXZlIDMyLWJpdCB0byA2
NC1iaXQgb3IgdmljZSB2ZXJzYQo+IGNvbW11bmljYXRpb24geW91IGhhdmUgYSBwcm9ibGVtLgoK
VGhpcyBzaG91bGQgd29yayBhcyB3ZWxsLgoKVGhlIHN0cnVjdHVyZSB3aWxsIGdldCBhbGlnbmVk
IHRvIHRoZSBzaXplIG9mIGxhcmdlc3QgZWxlbWVudCBhbmQgZWFjaAplbGVtZW50IHdpbGwgYmUg
YWxpZ25lZCB0byBpdHNlbGYuIEkgZG9uJ3Qgc2VlIGhvdyB0aGlzIHdpbGwgYnJlYWsKZXZlbiBp
biBjYXNlIG9mIDMyLzY0IGJpdCBjb21tdW5pY2F0aW9uLgoKLS0gCnZpcmVzaApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
