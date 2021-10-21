Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F345CC433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 09:43:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9FD610CF
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 09:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F9FD610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 612BB60692;
	Thu, 21 Oct 2021 09:43:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dIq4RxCxmGyH; Thu, 21 Oct 2021 09:43:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 183A560EB3;
	Thu, 21 Oct 2021 09:43:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9690C001C;
	Thu, 21 Oct 2021 09:43:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA717C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A3EE1405C9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:43:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8ltG33JrVZTo
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:43:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BAD2C4044F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:43:01 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id g8so1377921edb.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 02:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7d9A19lddRW8irMmh+Mt66ZHeRLI+KZdHS1ByPMNTZA=;
 b=HeHRHIxxA8UavrLE5b8DPIXOG7Pxxaru8WIwBp2TIKbAw2VV2wvlI2Yy9XpqjeH129
 rHtHfBemKPWFqyVaHvnGyJCNA2GIPUPHGc4YzMg31Gr3HvJ7ecHjxPqF4oTL/JgU1m/a
 2iXbLL5grsqX+d3nM1wO+afmPTR/f0Mxy+q+JFaQWQCLbSu6JvQVsnzXiJCbI/MNNLPo
 0gq9CR39u/GCgVgxpTP5YgQsZrLQFgrsHRw3wYwhQcIDPfFOoQjDgB6JPRANkGQsUoZ9
 XxHti8bRkPTYkZDNHw8KtE8u2vH7FCMgoTx8Igk87tEJ+UG/C4AyHAeYDDC+jRfrXTUv
 rkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7d9A19lddRW8irMmh+Mt66ZHeRLI+KZdHS1ByPMNTZA=;
 b=kG6PM3PN7MxYU7Hp7+I48p11jGlrx9MWViwqoRxCh93oSR8MoFYTf/8ttt1VzLIYwd
 aJisDcmhpCIqRVUlGWpjTOf1tTDtjyqsQleIQJU2JubyXO0XXa5pc2D2UgJcsmmvnmR7
 LEBtwfmV9PsIbpqhIx/vA+Bn/cgqItNMlnm8AOdL3BIoXGbvXGL7n6xFUGL3QsXXWGOl
 noOr2Ot4sVTgZ2hPV9+2xH5cfBQUKfqvW7iHNm3xkHSWCgfnP4FWnr45RhLAbQcv20JT
 rMbmImh9xWiYd07KsvdWQCqY3+R4sNkPPR0i9vu3pCzd/deo+JdEE0JSm+ZJGJdCm9+p
 t0ww==
X-Gm-Message-State: AOAM532gathi2v+i5RPLU7JTyGT9Rx+ExGUy62F3aaJwfUYEt086JXg9
 nx32ObJ0z57QECf+5gfeIe940QagserYYW6fyQE=
X-Google-Smtp-Source: ABdhPJx00Jiy0O/uySthYcE3x9sIdkDX1n8r7Bnsji3a+Y4fd2EPOVRK3VPIF267F5EQ+BjxjNEsxoP0r30oQflszrs=
X-Received: by 2002:a17:907:8a27:: with SMTP id
 sc39mr5961020ejc.567.1634809379628; 
 Thu, 21 Oct 2021 02:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <8ca87330fd348fc5199ad08904ec90cc6a91a1bf.1634723848.git.viresh.kumar@linaro.org>
 <CAHp75Vctj-v8W+LgdVpYgRVL3fLdcFnOFRFg74LeCc=xLD+w4w@mail.gmail.com>
 <20211021043443.snhqpac5ofmxfb7k@vireshk-i7>
In-Reply-To: <20211021043443.snhqpac5ofmxfb7k@vireshk-i7>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 21 Oct 2021 12:42:05 +0300
Message-ID: <CAHp75VdKn7Sze9HxN0gBgbuQS2K6oB+SQsufw576Rkfg4-osOw@mail.gmail.com>
Subject: Re: [PATCH V6] gpio: virtio: Add IRQ support
To: Viresh Kumar <viresh.kumar@linaro.org>
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

T24gVGh1LCBPY3QgMjEsIDIwMjEgYXQgNzozNCBBTSBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1h
ckBsaW5hcm8ub3JnPiB3cm90ZToKPiBPbiAyMC0xMC0yMSwgMTg6MTAsIEFuZHkgU2hldmNoZW5r
byB3cm90ZToKPiA+IE9uIFdlZG5lc2RheSwgT2N0b2JlciAyMCwgMjAyMSwgVmlyZXNoIEt1bWFy
IDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KPiA+IHdyb3RlOgoKLi4uCgo+ID4gPiArICAgICAg
IGNhc2UgSVJRX1RZUEVfTk9ORToKPiA+ID4gKyAgICAgICAgICAgICAgIHR5cGUgPSBWSVJUSU9f
R1BJT19JUlFfVFlQRV9OT05FOwo+ID4gPiArICAgICAgICAgICAgICAgYnJlYWs7Cj4gPgo+ID4g
SUlSQyB5b3UgYWRkIGRlYWQgY29kZS4gSVJRIGZyYW1ld29yayBuZXZlciBjYWxscyB0aGlzIGlm
IHR5cGUgaXMgbm90IHNldC4KPgo+IFllcywgYnV0IGl0IGlzIGFsbG93ZWQgdG8gY2FsbAo+Cj4g
aXJxX3NldF9pcnFfdHlwZShpcnEsIElSUV9UWVBFX05PTkUpOwo+Cj4gYW5kIHRoZSBpcnEgZnJh
bWV3b3JrIHdvbid0IGRpc2FsbG93IGl0IEFGQUlDVC4KClRoYXQncyB0cnVlLCBidXQgaG93IHlv
dSBtYXkgZW5kIHVwIGluIHRoaXMgY2FsbGJhY2sgd2l0aCBhIHN1Y2g/CldoYXQgdGhlIG1lYW5p
bmcgb2YgdGhhdCBjYWxsIHRvIHRoZSB1c2VyPwoKLi4uCgo+ID4gPiAgc3RydWN0IHZpcnRpb19n
cGlvX2NvbmZpZyB7Cj4gPiA+ICAgICAgICAgX19sZTE2IG5ncGlvOwo+ID4gPiAgICAgICAgIF9f
dTggcGFkZGluZ1syXTsKPiA+ID4gQEAgLTQ0LDQgKzU2LDE3IEBAIHN0cnVjdCB2aXJ0aW9fZ3Bp
b19yZXNwb25zZV9nZXRfbmFtZXMgewo+ID4gPiAgICAgICAgIF9fdTggdmFsdWVbXTsKPiA+ID4g
IH07Cj4gPiA+Cj4gPiA+ICsvKiBWaXJ0aW8gR1BJTyBJUlEgUmVxdWVzdCAvIFJlc3BvbnNlICov
Cj4gPiA+ICtzdHJ1Y3QgdmlydGlvX2dwaW9faXJxX3JlcXVlc3Qgewo+ID4gPiArICAgICAgIF9f
bGUxNiBncGlvOwo+ID4gPiArfTsKPiA+ID4gKwo+ID4gPiArc3RydWN0IHZpcnRpb19ncGlvX2ly
cV9yZXNwb25zZSB7Cj4gPiA+ICsgICAgICAgX191OCBzdGF0dXM7Cj4gPiA+ICt9Owo+ID4gPgo+
ID4gSeKAmW0gd29uZGVyaW5nIGlmIHRob3NlIGFib3ZlIHNob3VsZCBiZSBwYWNrZWQuCj4KPiBZ
b3UgYXJlIHRhbGtpbmcgYWJvdXQgdGhlIG5ld2x5IGFkZGVkIG9uZXMgb3IgdGhlIG9uZXMgYmVm
b3JlID8KPgo+IEluIGFueSBjYXNlLCB0aGV5IGFyZSBhbGwgYWxyZWFkeSBwYWNrZWQgKGkuZS4g
dGhleSBoYXZlIGV4cGxpY2l0Cj4gcGFkZGluZyB3aGVyZXZlciByZXF1aXJlZCkgYW5kIHByb3Bl
cmx5IGFsaWduZWQuIENvbXBpbGVyIHdvbid0IGFkZAo+IGFueSBvdGhlciBwYWRkaW5nIHRvIHRo
ZW0uCgpJcyBpdCBvbmx5IGZvciA2NC1iaXQgdG8gNjQtYml0IGNvbW11bmljYXRpb25zPwpJZiB0
aGVyZSBpcyBhIHBvc3NpYmlsaXR5IHRvIGhhdmUgMzItYml0IHRvIDY0LWJpdCBvciB2aWNlIHZl
cnNhCmNvbW11bmljYXRpb24geW91IGhhdmUgYSBwcm9ibGVtLgoKLS0gCldpdGggQmVzdCBSZWdh
cmRzLApBbmR5IFNoZXZjaGVua28KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
