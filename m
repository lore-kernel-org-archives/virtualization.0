Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B371C47094
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 17:04:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E8C613C9
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 17:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E8C613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6F7A041D45;
	Thu, 10 Jun 2021 17:03:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 98pbtTOt67X9; Thu, 10 Jun 2021 17:03:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DFE3E41D34;
	Thu, 10 Jun 2021 17:03:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF7A6C000E;
	Thu, 10 Jun 2021 17:03:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CCFFC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 17:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 679A183D4F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 17:03:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IBCv0Sve140S
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 17:03:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4718D83D4A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 17:03:54 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id b205so1890088wmb.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 10:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=bXhxyKfILOtbokM8zhO9ev3eR2f27dRG5A7af/C4DQw=;
 b=DMyaY3PS/UuBOCcAv0WKwICkJXkmfeM1e89x3xj9HxEmJIz6oMmNdMb5eAxBcJE0Ys
 bBYF6hJmSOu1r9AXjTt02A+9yWHb2AUNUR5G68af8Izv9M/m9oQ+7um/mBKwUI+Oj8jY
 uFZavM16DaPHRWGnWxm8xL8lk3c2OR+yJKUuHP6C21C2wlGRBlUfkopWVLIIZeEv9Zoo
 DuMiThPgXP3rTj7udUcSIJRmiJcB1D3p8tjJvPngix5g94LRqb3vPJubGySqimN2h/qh
 sthYQNqh7TJB6t+6mhomwCA7RYVht4W0QLKOtvLb4Txkoesmu75s7JE07l+BFw7aq4u8
 cDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bXhxyKfILOtbokM8zhO9ev3eR2f27dRG5A7af/C4DQw=;
 b=beuXGYCAPpMQyDvteho3HrEsxZhGJwYy9/W3PLvy4yBwNSbYHpodzkdlHi3354B4ZP
 YAK9qzMaE+UZw8/F1KbAdBSaXFkQ9be9qGFiKG5zki1wYYn4vNP+XoYS5V6c5k3AEIQX
 MlS7S792fgqpE4ql5MKFQen/QwNyC2WiSddvAlGKbBvfSrt2njLCqze5vJOOS60wbo94
 rcPJ1u1yohqNS5DECUoG9pHNyzZ1/roJvTeSLk/tpafD+Nv2d/NUnJlwa6ISTdqw1y6V
 xoSSyyfmnuy0pM5petThreJjB5CEMd6pZ9dnkN7xGEes+IHFNcLu52id5C5awjGmRPPW
 tJKw==
X-Gm-Message-State: AOAM533iGhlhISRff9gUaqoAjKmzH4zHJk5ru9gv8rh69oNd5oFOcdxI
 Otgd0EchqqFrAcSo1iJ/nI/dIg==
X-Google-Smtp-Source: ABdhPJxKsTVP9wK9UsF+G/NtCMnej7AiNjRbbyOwhC+0A8plqOW12aHey11nmX6sZiUmWulu0ZQt1Q==
X-Received: by 2002:a05:600c:b50:: with SMTP id
 k16mr6024505wmr.137.1623344632456; 
 Thu, 10 Jun 2021 10:03:52 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id 4sm3823543wry.74.2021.06.10.10.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 10:03:51 -0700 (PDT)
Date: Thu, 10 Jun 2021 19:03:33 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [Stratos-dev] [PATCH V3 1/3] gpio: Add virtio-gpio driver
Message-ID: <YMJF5fF31ksmSdiq@myrica>
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CAK8P3a11YhcEOjauWc872BQv+SO-E5+gnz7Lk6UK42iVw7Oyfg@mail.gmail.com>
 <01000179f6a7715c-cd106846-7770-4088-bb7c-a696bfcbf83e-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <01000179f6a7715c-cd106846-7770-4088-bb7c-a696bfcbf83e-000000@email.amazonses.com>
Cc: Arnd Bergmann <arnd@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Stratos Mailing List <stratos-dev@op-lists.linaro.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>
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

T24gVGh1LCBKdW4gMTAsIDIwMjEgYXQgMDQ6MDA6MzlQTSArMDAwMCwgRW5yaWNvIFdlaWdlbHQs
IG1ldHV4IElUIGNvbnN1bHQgdmlhIFN0cmF0b3MtZGV2IHdyb3RlOgo+IE9uIDEwLjA2LjIxIDE1
OjIyLCBBcm5kIEJlcmdtYW5uIHdyb3RlOgo+IAo+ID4gQ2FuIHlvdSBnaXZlIGFuIGV4YW1wbGUg
b2YgaG93IHRoaXMgd291bGQgYmUgaG9va2VkIHVwIHRvIG90aGVyIGRyaXZlcnMKPiA+IHVzaW5n
IHRob3NlIGdwaW9zLiBDYW4geW91IGdpdmUgYW4gZXhhbXBsZSBvZiBob3cgdXNpbmcgdGhlICJn
cGlvLWtleXMiIG9yCj4gPiAiZ3Bpby1sZWRzIiBkcml2ZXJzIGluIGNvbWJpbmF0aW9uIHdpdGgg
dmlydGlvLWdwaW8gbG9va3MgbGlrZSBpbiB0aGUgRFQ/Cj4gCj4gQ29ubmVjdGluZyBiZXR3ZWVu
IHNlbGYtcHJvYmluZyBidXMnZXMgYW5kIERUIGlzIGdlbmVyYWxseSB0cmlja3kuIElNSE8KPiB3
ZSBkb24ndCBoYXZlIGFueSBnZW5lcmljIG1lY2hhbmlzbSBmb3IgdGhhdC4KCkRUIGRvZXMgaGF2
ZSBhIGdlbmVyaWMgZGVzY3JpcHRpb24gb2YgUENJIGVuZHBvaW50cywgd2hpY2ggdmlydGlvLWlv
bW11CnJlbGllcyBvbiB0byBleHByZXNzIHRoZSByZWxhdGlvbiBiZXR3ZWVuIElPTU1VIGFuZCBl
bmRwb2ludCBub2RlcyBbMV0uCkkgdGhpbmsgdGhlIHByb2JsZW0gaGVyZSBpcyBzaW1pbGFyOiB0
aGUgY2xpZW50IG5vZGUgbmVlZHMgYSBwaGFuZGxlIHRvCnRoZSBHUElPIGNvbnRyb2xsZXIgd2hp
Y2ggbWF5IHVzZSB2aXJ0aW8tcGNpIHRyYW5zcG9ydD8KCk5vdGUgdGhhdCBpdCBtb3N0bHkgd29y
a3MgaWYgdGhlIGRldmljZSBpcyBvbiB0aGUgcm9vdCBQQ0kgYnVzLiBCZWhpbmQgYQpicmlkZ2Ug
dGhlIE9TIG1heSBjaGFuZ2UgdGhlIGRldmljZSdzIGJ1cyBudW1iZXIgYXMgbmVlZGVkLCBzbyB0
aGUgQkRGCnJlZmVyZW5jZSBpbiBEVCBpcyBvbmx5IHZhbGlkIGlmIHRoZSBzb2Z0d2FyZSBwcm92
aWRpbmcgdGhlIERUIGRlc2NyaXB0aW9uCihWTU0gb3IgZmlybXdhcmUpIGluaXRpYWxpemVzIGJ1
cyBudW1iZXJzIGFjY29yZGluZ2x5IChhbmQgSSBkb24ndApyZW1lbWJlciBpZiBMaW51eCBzdXBw
b3J0cyB0aGlzIGNhc2Ugd2VsbCkuCgpUaGFua3MsCkplYW4KClsxXSBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvdmlydGlvL2lvbW11LnR4dAoKPiAKPiBJJ3ZlIG1hZGUgYSBmZXcg
YXR0ZW1wdHMsIGJ1dCBub3RoaW5nIHByYWN0aWNhbGx5IHVzZWZ1bCwgd2hpY2ggd291bGQgYmUK
PiBhY2NlcHRlZCBieSB0aGUgY29ycmVzcG9uZGluZyBtYWludGFpbmVycywgeWV0LiBXZSdkIGVp
dGhlciBuZWVkIHNvbWUKPiB2ZXJ5IHNwZWNpYWwgbG9naWMgaW4gRFQgcHJvYmluZyBvciBwc2V1
ZG8tYnVzJ2VzIGZvciB0aGUgbWFwcGluZy4KPiAoRFQgd2FudHMgdG8gZG8gdGhvc2UgY29ubmVj
dGlvbnMgdmlhIHBoYW5kbGUncywgd2hpY2ggaW4gdHVybiBuZWVkIHRoZQo+IHJlZmVyZW5jZWQg
bm9kZXMgdG8gYmUgcHJlc2VudCBpbiB0aGUgRFQpLgo+IAo+ID4gIEZyb20gd2hhdCBJIGNhbiB0
ZWxsLCBib3RoIHRoZSBtbWlvIGFuZCBwY2kgdmFyaWFudHMgb2YgdmlydGlvIGNhbiBoYXZlIHRo
ZWlyCj4gPiBkZXYtPm9mX25vZGUgcG9wdWxhdGVkLCBidXQgSSBkb24ndCBzZWUgdGhlIGxvZ2lj
IGluIHJlZ2lzdGVyX3ZpcnRpb19kZXZpY2UoKQo+ID4gdGhhdCBsb29rcyB1cCB0aGUgb2Zfbm9k
ZSBvZiB0aGUgdmlydGlvX2RldmljZSB0aGF0IHRoZSBvZl9ncGlvIGNvZGUgdGhlbgo+ID4gdHJp
ZXMgdG8gcmVmZXIgdG8uCj4gCj4gSGF2ZSB5b3UgZXZlciBzdWNjZXNzZnVsbHkgYm91bmQgYSB2
aXJ0aW8gZGV2aWNlIHZpYSBEVCA/Cj4gCj4gCj4gLS1tdHgKPiAKPiAtLSAKPiAtLS0KPiBIaW53
ZWlzOiB1bnZlcnNjaGzDvHNzZWx0ZSBFLU1haWxzIGvDtm5uZW4gbGVpY2h0IGFiZ2Vow7ZydCB1
bmQgbWFuaXB1bGllcnQKPiB3ZXJkZW4gISBGw7xyIGVpbmUgdmVydHJhdWxpY2hlIEtvbW11bmlr
YXRpb24gc2VuZGVuIFNpZSBiaXR0ZSBpaHJlbgo+IEdQRy9QR1AtU2NobMO8c3NlbCB6dS4KPiAt
LS0KPiBFbnJpY28gV2VpZ2VsdCwgbWV0dXggSVQgY29uc3VsdAo+IEZyZWUgc29mdHdhcmUgYW5k
IExpbnV4IGVtYmVkZGVkIGVuZ2luZWVyaW5nCj4gaW5mb0BtZXR1eC5uZXQgLS0gKzQ5LTE1MS0y
NzU2NTI4Nwo+IC0tIAo+IFN0cmF0b3MtZGV2IG1haWxpbmcgbGlzdAo+IFN0cmF0b3MtZGV2QG9w
LWxpc3RzLmxpbmFyby5vcmcKPiBodHRwczovL29wLWxpc3RzLmxpbmFyby5vcmcvbWFpbG1hbi9s
aXN0aW5mby9zdHJhdG9zLWRldgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
