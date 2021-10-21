Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD30C433F5
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 04:34:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0B560F5D
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 04:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD0B560F5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6D8FD400C6;
	Thu, 21 Oct 2021 04:34:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qvny7-UwLb6Z; Thu, 21 Oct 2021 04:34:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CA35C4012E;
	Thu, 21 Oct 2021 04:34:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C2A9C0011;
	Thu, 21 Oct 2021 04:34:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0D62C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 04:34:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA5E1606D6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 04:34:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hd5Vb2QDMLdY
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 04:34:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 50514606A3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 04:34:49 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id d9so4796921pfl.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 21:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=jaiLtlV833/Xq50ZtlkoTbBz4JFSnmlv9NeQfSfgHg4=;
 b=h0F95M0PrLk7D8QgNTB2BqUYk0J4hCY6SU0hpopoSa06OV3nxdYJX/bVam2+2+Lzl5
 p7qONW7e707xdv8XGXGWaUhExXHHlnvrNFFDBvwatduMlZQE47wE4JrSo/z4DMqJrTJP
 iljR1qxZPKcfPDCFIBUW7scAiHAMrb1gpHaaebd9bH6ZhbycqkKNfTZHdH18hMKnUqVr
 WoX5YdCw/UiEuuLbiVP8IvdFzrzLE/0BhhF0ycwlXo/aBB3oIbjikEcZllI3MM7fN3xP
 ZXIMey9d63vQXS++XKqh3fkDwLQ66LYdoAbEXIJdvbofBUyyNZTcC5kR+bIg+09ryaD6
 iKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=jaiLtlV833/Xq50ZtlkoTbBz4JFSnmlv9NeQfSfgHg4=;
 b=rH1eWE6bhDwxyv/0WGjKEmUTeZTgqpi5TxzAplGKUvaIWTV/HnCiB1M1Kf+ykwLGcf
 +b/NvAHBtj5CYDjYT7xEy0EaC4NUy1SQOHPNEQgyyN8dmq/oSJ/ckemodH98qdGzKieP
 RLUl6McIhj4gB/pCUQsMbyzQM+9vPbr25nIO8mEILvtKeUuQgOlFZashCOOHXw1+lJbS
 3Dy5r2DF4QAnEQqd3dFQPeVB1GlKovGg6+t97nAyh5zYIBd4LzqtCkiR/Zl9aJe6hZ/A
 RjkjWXioz+KI5qFn916kUtsmeKlLf8n/8GGOLh9SFeh3K2kFMZ5uTjgjtT+QSPCWpE5a
 LmzA==
X-Gm-Message-State: AOAM5328nyz005dbLa4fIMPn7ZRCKnzOCptU9rHePW9FohTNkFlXjlZg
 mbOdG1JQacWGEsxWJE9/qPDkDA==
X-Google-Smtp-Source: ABdhPJxy9sXJSpJeIDOujmjVoM00QXmZAzl/1qhqh2gyKuCmbib7G8Elu0hey3Nb4TAbQDYpK762Pg==
X-Received: by 2002:a62:15c6:0:b0:44c:74b7:14f5 with SMTP id
 189-20020a6215c6000000b0044c74b714f5mr2970346pfv.80.1634790888730; 
 Wed, 20 Oct 2021 21:34:48 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id x22sm4068322pjd.47.2021.10.20.21.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Oct 2021 21:34:48 -0700 (PDT)
Date: Thu, 21 Oct 2021 10:04:43 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V6] gpio: virtio: Add IRQ support
Message-ID: <20211021043443.snhqpac5ofmxfb7k@vireshk-i7>
References: <8ca87330fd348fc5199ad08904ec90cc6a91a1bf.1634723848.git.viresh.kumar@linaro.org>
 <CAHp75Vctj-v8W+LgdVpYgRVL3fLdcFnOFRFg74LeCc=xLD+w4w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHp75Vctj-v8W+LgdVpYgRVL3fLdcFnOFRFg74LeCc=xLD+w4w@mail.gmail.com>
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

T24gMjAtMTAtMjEsIDE4OjEwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6Cj4gT24gV2VkbmVzZGF5
LCBPY3RvYmVyIDIwLCAyMDIxLCBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3Jn
Pgo+IHdyb3RlOgo+ID4gK3N0YXRpYyBpbnQgdmlydGlvX2dwaW9faXJxX3NldF90eXBlKHN0cnVj
dCBpcnFfZGF0YSAqZCwgdW5zaWduZWQgaW50Cj4gPiB0eXBlKQo+ID4gK3sKPiA+ICsgICAgICAg
c3RydWN0IGdwaW9fY2hpcCAqZ2MgPSBpcnFfZGF0YV9nZXRfaXJxX2NoaXBfZGF0YShkKTsKPiA+
ICsgICAgICAgc3RydWN0IHZpcnRpb19ncGlvICp2Z3BpbyA9IGdwaW9jaGlwX2dldF9kYXRhKGdj
KTsKPiA+ICsgICAgICAgc3RydWN0IHZncGlvX2lycV9saW5lICppcnFfbGluZSA9ICZ2Z3Bpby0+
aXJxX2xpbmVzW2QtPmh3aXJxXTsKPiA+ICsKPiA+ICsgICAgICAgc3dpdGNoICh0eXBlKSB7Cj4g
PiArICAgICAgIGNhc2UgSVJRX1RZUEVfTk9ORToKPiA+ICsgICAgICAgICAgICAgICB0eXBlID0g
VklSVElPX0dQSU9fSVJRX1RZUEVfTk9ORTsKPiA+ICsgICAgICAgICAgICAgICBicmVhazsKPiAK
PiAKPiBJSVJDIHlvdSBhZGQgZGVhZCBjb2RlLiBJUlEgZnJhbWV3b3JrIG5ldmVyIGNhbGxzIHRo
aXMgaWYgdHlwZSBpcyBub3Qgc2V0LgoKWWVzLCBidXQgaXQgaXMgYWxsb3dlZCB0byBjYWxsCgpp
cnFfc2V0X2lycV90eXBlKGlycSwgSVJRX1RZUEVfTk9ORSk7CgphbmQgdGhlIGlycSBmcmFtZXdv
cmsgd29uJ3QgZGlzYWxsb3cgaXQgQUZBSUNULgoKPiA+ICtzdGF0aWMgdm9pZCB2aXJ0aW9fZ3Bp
b19ldmVudF92cShzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPiA+ICt7Cgo+ID4gKyAgICAgICAgICAg
ICAgIGlycSA9IGlycV9maW5kX21hcHBpbmcodmdwaW8tPmdjLmlycS5kb21haW4sIGdwaW8pOwo+
ID4gKyAgICAgICAgICAgICAgIFdBUk5fT04oIWlycSk7Cj4gPiArCj4gPiArICAgICAgICAgICAg
ICAgcmV0ID0gZ2VuZXJpY19oYW5kbGVfaXJxKGlycSk7Cj4gCj4gCj4gSUlSQyB0aGVyZSBpcyBh
IG5ldyBBUEkgdGhhdCBiYXNpY2FsbHkgY29tYmluZXMgdGhlIHR3byBhYm92ZS4KCmdlbmVyaWNf
aGFuZGxlX2RvbWFpbl9pcnEoKSwgdGhhbmtzLgoKPiA+ICBzdHJ1Y3QgdmlydGlvX2dwaW9fY29u
ZmlnIHsKPiA+ICAgICAgICAgX19sZTE2IG5ncGlvOwo+ID4gICAgICAgICBfX3U4IHBhZGRpbmdb
Ml07Cj4gPiBAQCAtNDQsNCArNTYsMTcgQEAgc3RydWN0IHZpcnRpb19ncGlvX3Jlc3BvbnNlX2dl
dF9uYW1lcyB7Cj4gPiAgICAgICAgIF9fdTggdmFsdWVbXTsKPiA+ICB9Owo+ID4KPiA+ICsvKiBW
aXJ0aW8gR1BJTyBJUlEgUmVxdWVzdCAvIFJlc3BvbnNlICovCj4gPiArc3RydWN0IHZpcnRpb19n
cGlvX2lycV9yZXF1ZXN0IHsKPiA+ICsgICAgICAgX19sZTE2IGdwaW87Cj4gPiArfTsKPiA+ICsK
PiA+ICtzdHJ1Y3QgdmlydGlvX2dwaW9faXJxX3Jlc3BvbnNlIHsKPiA+ICsgICAgICAgX191OCBz
dGF0dXM7Cj4gPiArfTsKPiA+Cj4gPgo+IEnigJltIHdvbmRlcmluZyBpZiB0aG9zZSBhYm92ZSBz
aG91bGQgYmUgcGFja2VkLgoKWW91IGFyZSB0YWxraW5nIGFib3V0IHRoZSBuZXdseSBhZGRlZCBv
bmVzIG9yIHRoZSBvbmVzIGJlZm9yZSA/CgpJbiBhbnkgY2FzZSwgdGhleSBhcmUgYWxsIGFscmVh
ZHkgcGFja2VkIChpLmUuIHRoZXkgaGF2ZSBleHBsaWNpdApwYWRkaW5nIHdoZXJldmVyIHJlcXVp
cmVkKSBhbmQgcHJvcGVybHkgYWxpZ25lZC4gQ29tcGlsZXIgd29uJ3QgYWRkCmFueSBvdGhlciBw
YWRkaW5nIHRvIHRoZW0uCiAKLS0gCnZpcmVzaApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
