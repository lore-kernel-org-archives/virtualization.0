Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5E9C4332F
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 09:59:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D58610EA
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 09:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 84D58610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F37D40391;
	Thu, 21 Oct 2021 09:59:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6C1JlUNS3b_k; Thu, 21 Oct 2021 09:59:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CE6FE40284;
	Thu, 21 Oct 2021 09:59:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1B9FC001C;
	Thu, 21 Oct 2021 09:59:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 649A2C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4294C60ECB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:59:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bFiSeHW9Ksvn
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:59:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A85160EC8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:59:24 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id r4so2675742edi.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 02:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=f1lAHZpbTINEGGOzg3KvBrzQHfCd9hUnr+Z5eklsu4I=;
 b=cFFPatN176idTJdu0RK5l+kgO+3oCC5KaWLjea3KK5xjWay26jR7SEKg+PSa/La44d
 RHlgGG86uVG48vXTwBYdRy/JDoMbGoxGz/VcgV+6hsyKfySMymh2V96Lmcr7s5HHzqQo
 BxKzexJQbqOgYTZrpyb6DYYHgJ+WTL4wgijIM/J3VVRqnKyvl1CevIaf6oyJ+jpvgYMz
 kektjeiL9LDJUTuWPVhsMibZT8ZwQrliI0QwsudkrLnqw/Y15n3d+eZ4wjGFfGUVD1pk
 ODw6DVhJuOoWFp1uKqszNKrOjO2ZraNxYJfPxY5Qu2NY2F1bMzkWVShW1RtGX+vdn851
 AL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=f1lAHZpbTINEGGOzg3KvBrzQHfCd9hUnr+Z5eklsu4I=;
 b=PegG3foCTb4tQLu0qQBY1MXRwXvrkQl8MPOcJSaF/6Yt4/0TqRIEq+PwJGsKRfnEFZ
 GYR3gLpJmHM+hXFhVx5qd07W3OTbM3BIWdK2pwWXw4fhNgfDz5/L0dfwraPMFnvHGT8T
 I/lgMUFYgFWcjDvBL3TV+FFtTsEICYQbdIx410RnmpHVgYze/ga3oUKbiTlV7No6egKZ
 1Tkp7vA6tyRgebe1KnvL27kwPEuF2D4m9mxWFrvKiAtePJyboOTJe6aTV4CTj/8mNVwD
 2r7Cxp7rL+J5jTGEiII+wC50TvcVCAOrNjFbeOQZPyoKJGGQk5KgT54VE/430G59lNtr
 a60Q==
X-Gm-Message-State: AOAM533ntWnbnvCxhv0NQrllHQnGrzrd4GBKHE/iacOyh/LI4g1CMDJK
 ngoHSl3TehBzGR2ZY1np982MeriCCeHCml73/Qg=
X-Google-Smtp-Source: ABdhPJyDCgSTt3/IAgVwU9WSF3RqG/zAQBAURKsmJcGNhL738ts5nX0FRkRfgucOXR1U7//HXc+3nGoarGxBgTv5X38=
X-Received: by 2002:aa7:c0d2:: with SMTP id j18mr6461565edp.107.1634810358797; 
 Thu, 21 Oct 2021 02:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <8ca87330fd348fc5199ad08904ec90cc6a91a1bf.1634723848.git.viresh.kumar@linaro.org>
 <CAHp75Vctj-v8W+LgdVpYgRVL3fLdcFnOFRFg74LeCc=xLD+w4w@mail.gmail.com>
 <20211021043443.snhqpac5ofmxfb7k@vireshk-i7>
 <CAHp75VdKn7Sze9HxN0gBgbuQS2K6oB+SQsufw576Rkfg4-osOw@mail.gmail.com>
 <20211021095229.lqeb7dtxv4ix2vc5@vireshk-i7>
In-Reply-To: <20211021095229.lqeb7dtxv4ix2vc5@vireshk-i7>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 21 Oct 2021 12:58:25 +0300
Message-ID: <CAHp75VcBowxFoseXKwU2VjNcu75ttvHW_sno9MihHL88+oP1ew@mail.gmail.com>
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

T24gVGh1LCBPY3QgMjEsIDIwMjEgYXQgMTI6NTIgUE0gVmlyZXNoIEt1bWFyIDx2aXJlc2gua3Vt
YXJAbGluYXJvLm9yZz4gd3JvdGU6Cj4gT24gMjEtMTAtMjEsIDEyOjQyLCBBbmR5IFNoZXZjaGVu
a28gd3JvdGU6Cj4gPiBPbiBUaHUsIE9jdCAyMSwgMjAyMSBhdCA3OjM0IEFNIFZpcmVzaCBLdW1h
ciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+IHdyb3RlOgo+ID4gPiBPbiAyMC0xMC0yMSwgMTg6
MTAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToKCi4uLgoKPiA+ID4gPiA+ICBzdHJ1Y3QgdmlydGlv
X2dwaW9fY29uZmlnIHsKPiA+ID4gPiA+ICAgICAgICAgX19sZTE2IG5ncGlvOwo+ID4gPiA+ID4g
ICAgICAgICBfX3U4IHBhZGRpbmdbMl07Cj4gPiA+ID4gPiBAQCAtNDQsNCArNTYsMTcgQEAgc3Ry
dWN0IHZpcnRpb19ncGlvX3Jlc3BvbnNlX2dldF9uYW1lcyB7Cj4gPiA+ID4gPiAgICAgICAgIF9f
dTggdmFsdWVbXTsKPiA+ID4gPiA+ICB9Owo+ID4gPiA+ID4KPiA+ID4gPiA+ICsvKiBWaXJ0aW8g
R1BJTyBJUlEgUmVxdWVzdCAvIFJlc3BvbnNlICovCj4gPiA+ID4gPiArc3RydWN0IHZpcnRpb19n
cGlvX2lycV9yZXF1ZXN0IHsKPiA+ID4gPiA+ICsgICAgICAgX19sZTE2IGdwaW87Cj4gPiA+ID4g
PiArfTsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICtzdHJ1Y3QgdmlydGlvX2dwaW9faXJxX3Jlc3Bv
bnNlIHsKPiA+ID4gPiA+ICsgICAgICAgX191OCBzdGF0dXM7Cj4gPiA+ID4gPiArfTsKPiA+ID4g
PiA+Cj4gPiA+ID4gSeKAmW0gd29uZGVyaW5nIGlmIHRob3NlIGFib3ZlIHNob3VsZCBiZSBwYWNr
ZWQuCj4gPiA+Cj4gPiA+IFlvdSBhcmUgdGFsa2luZyBhYm91dCB0aGUgbmV3bHkgYWRkZWQgb25l
cyBvciB0aGUgb25lcyBiZWZvcmUgPwo+ID4gPgo+ID4gPiBJbiBhbnkgY2FzZSwgdGhleSBhcmUg
YWxsIGFscmVhZHkgcGFja2VkIChpLmUuIHRoZXkgaGF2ZSBleHBsaWNpdAo+ID4gPiBwYWRkaW5n
IHdoZXJldmVyIHJlcXVpcmVkKSBhbmQgcHJvcGVybHkgYWxpZ25lZC4gQ29tcGlsZXIgd29uJ3Qg
YWRkCj4gPiA+IGFueSBvdGhlciBwYWRkaW5nIHRvIHRoZW0uCj4gPgo+ID4gSXMgaXQgb25seSBm
b3IgNjQtYml0IHRvIDY0LWJpdCBjb21tdW5pY2F0aW9ucz8KPgo+IFRoYXQncyB3aGF0IEkgaGF2
ZSBiZWVuIGxvb2tpbmcgYXQuCj4KPiA+IElmIHRoZXJlIGlzIGEgcG9zc2liaWxpdHkgdG8gaGF2
ZSAzMi1iaXQgdG8gNjQtYml0IG9yIHZpY2UgdmVyc2EKPiA+IGNvbW11bmljYXRpb24geW91IGhh
dmUgYSBwcm9ibGVtLgo+Cj4gVGhpcyBzaG91bGQgd29yayBhcyB3ZWxsLgo+Cj4gVGhlIHN0cnVj
dHVyZSB3aWxsIGdldCBhbGlnbmVkIHRvIHRoZSBzaXplIG9mIGxhcmdlc3QgZWxlbWVudCBhbmQg
ZWFjaAo+IGVsZW1lbnQgd2lsbCBiZSBhbGlnbmVkIHRvIGl0c2VsZi4gSSBkb24ndCBzZWUgaG93
IHRoaXMgd2lsbCBicmVhawo+IGV2ZW4gaW4gY2FzZSBvZiAzMi82NCBiaXQgY29tbXVuaWNhdGlv
bi4KCkkgYWRtaXQgSSBoYXZlbid0IGxvb2tlZCBpbnRvIHRoZSBzcGVjaWZpY2F0aW9uLCBidXQg
aW4gdGhlIHBhc3Qgd2UKaGFkIGhhZCBxdWl0ZSBhbiBpc3N1ZSBleGFjdGx5IGluIEdQSU8gb24g
a2VybmVsIHNpZGUgYmVjYXVzZSBvZiB0aGlzCmtpbmQgb2YgZGVzaWduIG1pc3Rha2UuIFRoZSBw
cm9ibGVtIGhlcmUgaWYgaW4gdGhlIGZ1dHVyZSBvbmUgd2FudHMgdG8Kc3VwcGx5IG1vcmUgdGhh
biBvbmUgaXRlbSBhdCBhIHRpbWUsIGl0IHdpbGwgYmUgbm90IHBvc3NpYmxlIHdpdGggdGhpcwpp
bnRlcmZhY2UuIFllcywgSSB1bmRlcnN0YW5kIHRoYXQgaW4gY3VycmVudCBkZXNpZ24gaXQncyBy
YXRoZXIgbWlzc2VkCnNjYWxhYmlsaXR5LCBidXQgaGV5LCBJIGJlbGlldmUgaW4gdGhlIGZ1dHVy
ZSB3ZSBtYXkgbmVlZApwZXJmb3JtYW5jZS13aXNlIGNhbGxzLgoKLS0gCldpdGggQmVzdCBSZWdh
cmRzLApBbmR5IFNoZXZjaGVua28KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
