Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DDFC74A5B
	for <virtualization@archiver.kernel.org>; Thu, 30 Mar 2023 00:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E73B841AF;
	Thu, 30 Mar 2023 00:27:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E73B841AF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=R1M/CIP/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tLIvvCg67p9k; Thu, 30 Mar 2023 00:27:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 148578419A;
	Thu, 30 Mar 2023 00:27:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 148578419A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD5EAC0037;
	Thu, 30 Mar 2023 00:27:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C1A9C002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 00:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6497B8419C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 00:27:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6497B8419C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IUxI9KcAhglg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 00:27:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B80708419A
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B80708419A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 00:27:14 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id u38so11424296pfg.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 17:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112; t=1680136034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i7VcmXdqZtNcPeKWqqyIJTPXJmEo1KcutXG7+M0aesE=;
 b=R1M/CIP/JQFpeVL8E0F5bZ0UWFsJqCCz8R59Fiw3Tk3q9Wrlr2N61iOMQ2JnulyEF4
 0GArupJYHX8F4t5Yd0a1Upgj1llOuYx/0F1qixzjDBvgiIgXctf1+t8AMK+Q8Dr380lR
 jJNnJYB/Mk4Wl/yYtmIfVdlHGdHgNWnyS8daheiEgOgxJedfOaJeOn0IRS2NmW8OjgUn
 67K+50TfZRp1Q0T+xEsxrqxFe29fx/0+X0mOE8q5EbsAWf89Xb/HG+dJzmHzdGqU/bsO
 b44XzdgRmN3fFFisVB65b4/XIiJWDkkE4/tBicItHVydnFQHvRoiqWt7Gb2JG5JCfC8H
 fztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680136034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i7VcmXdqZtNcPeKWqqyIJTPXJmEo1KcutXG7+M0aesE=;
 b=Ov8DAcVKnwILVat1PiXCcJ/HF6qFsUJPE1iYwNxrFXoBP21eUHrRRamXVoTlkfX5Tl
 XJr9jvEEOuBX/uNuVD5YQLt9qY+XyMwhBoKbA9dX7XEUsEks/YT4WSIpCZxtFu91Pshl
 4OP3RQ7eSWX2gmjTnso5FckMZfUqie18MTzRIpLnf3MEf60PouVvLLDntgiUeIlcmtlo
 x5oN9tXqi+eC0+dsSWq9UsgFDU0urUYRbOPpP5bsWgMPV6WEQFxTKnkrv6tc+6N+2sq3
 VB059IrnjKXBG0/pk5Ear5GBylpWgukiDKoZcoRE7DTkLLiED51Wp/Fmq2J90+CXKBt7
 kMMQ==
X-Gm-Message-State: AAQBX9fPDykXlE9ehXdH6ayyfGRsDc8TYatnchxU72+Cfjq36+XJSb1e
 hoQakt/Jcva/zB0Q1UJvU7gM/w3qrDwXzIkSk4cpZg==
X-Google-Smtp-Source: AKy350ZNgBTk/Bl4y/6vvaNgvZiKUvk17nRG9kMC7zx9X0sp3nTZlxV9bWZ4SpbZLulQWGN39+CX3JMU46PBItELf1Q=
X-Received: by 2002:a05:6a00:2385:b0:5aa:310c:e65b with SMTP id
 f5-20020a056a00238500b005aa310ce65bmr10810754pfc.2.1680136033965; Wed, 29 Mar
 2023 17:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230329104546.108016-1-andrew@daynix.com>
 <1680090663.603155-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1680090663.603155-2-xuanzhuo@linux.alibaba.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Thu, 30 Mar 2023 03:09:22 +0300
Message-ID: <CABcq3pFGhGpRmOBQEaCWhW89ANPqvnDJoSQrPn4O0SmGPGnaKQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] eBPF RSS through QMP support.
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: mst@redhat.com, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
 dsahern@kernel.org, linux-kernel@vger.kernel.org, yuri.benditovich@daynix.com,
 edumazet@google.com, yan@daynix.com, kuba@kernel.org, pabeni@redhat.com,
 virtualization@lists.linux-foundation.org, davem@davemloft.net
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

T2ggeWVhaCwgSSdsbCBmaXggdGhhdC4gVGhhbmsgeW91IQoKT24gV2VkLCBNYXIgMjksIDIwMjMg
YXQgMjo1MuKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3Rl
Ogo+Cj4gSXMgdGhpcyBhIHBhdGNoLXNldCBvZiBRRU1VPyBJZiB5ZXMsIHdoeSBhcmUgdGhlIGVt
YWlsIGxpc3RzIGFsbCBrZXJuZWwgbWFpbAo+IGxpc3Qgd2l0aG91dCBRRU1VIG1haWwgbGlzdD8K
Pgo+IFRoYW5rcy4KPgo+IE9uIFdlZCwgMjkgTWFyIDIwMjMgMTM6NDU6NDEgKzAzMDAsIEFuZHJl
dyBNZWxueWNoZW5rbyA8YW5kcmV3QGRheW5peC5jb20+IHdyb3RlOgo+ID4gVGhpcyBzZXJpZXMg
b2YgcGF0Y2hlcyBwcm92aWRlcyB0aGUgYWJpbGl0eSB0byByZXRyaWV2ZSBlQlBGIHByb2dyYW0K
PiA+IHRocm91Z2ggcW1wLCBzbyBtYW5hZ2VtZW50IGFwcGxpY2F0aW9uIG1heSBsb2FkIGJwZiBi
bG9iIHdpdGggcHJvcGVyIGNhcGFiaWxpdGllcy4KPiA+IE5vdywgdmlydGlvLW5ldCBkZXZpY2Vz
IGNhbiBhY2NlcHQgZUJQRiBwcm9ncmFtcyBhbmQgbWFwcyB0aHJvdWdoIHByb3BlcnRpZXMKPiA+
IGFzIGV4dGVybmFsIGZpbGUgZGVzY3JpcHRvcnMuIEFjY2VzcyB0byB0aGUgZUJQRiBtYXAgaXMg
ZGlyZWN0IHRocm91Z2ggbW1hcCgpCj4gPiBjYWxsLCBzbyBpdCBzaG91bGQgbm90IHJlcXVpcmUg
YWRkaXRpb25hbCBjYXBhYmlsaXRpZXMgdG8gYnBmKiBjYWxscy4KPiA+IGVCUEYgZmlsZSBkZXNj
cmlwdG9ycyBjYW4gYmUgcGFzc2VkIHRvIFFFTVUgZnJvbSBwYXJlbnQgcHJvY2VzcyBvciBieSB1
bml4Cj4gPiBzb2NrZXQgd2l0aCBzZW5kZmQoKSBxbXAgY29tbWFuZC4KPiA+Cj4gPiBPdmVyYWxs
LCB0aGUgYmFzaWMgc2NlbmFyaW8gb2YgdXNpbmcgdGhlIGhlbHBlciBsb29rcyBsaWtlIHRoaXM6
Cj4gPiAgKiBMaWJ2aXJ0IGNoZWNrcyBmb3IgZWJwZl9mZHMgcHJvcGVydHkuCj4gPiAgKiBMaWJ2
aXJ0IHJlcXVlc3RzIGVCUEYgYmxvYiB0aHJvdWdoIFFNUC4KPiA+ICAqIExpYnZpcnQgbG9hZHMg
YmxvYiBmb3IgdmlydGlvLW5ldC4KPiA+ICAqIExpYnZpcnQgbGF1bmNoZXMgdGhlIFFFTVUgd2l0
aCBlQlBGIGZkcyBwYXNzZWQuCj4gPgo+ID4gQW5kcmV3IE1lbG55Y2hlbmtvICg0KToKPiA+ICAg
ZWJwZjogQWRkZWQgZUJQRiBpbml0aWFsaXphdGlvbiBieSBmZHMgYW5kIG1hcCB1cGRhdGUuCj4g
PiAgIHZpcnRpby1uZXQ6IEFkZGVkIHByb3BlcnR5IHRvIGxvYWQgZUJQRiBSU1Mgd2l0aCBmZHMu
Cj4gPiAgIGVicGY6IEFkZGVkIGRlY2xhcmF0aW9uL2luaXRpYWxpemF0aW9uIHJvdXRpbmVzLgo+
ID4gICBxbXA6IEFkZGVkIG5ldyBjb21tYW5kIHRvIHJldHJpZXZlIGVCUEYgYmxvYi4KPiA+Cj4g
PiAgZWJwZi9lYnBmLmMgICAgICAgICAgICAgICAgICAgIHwgIDQ4ICsrKysrKysrKysrKysKPiA+
ICBlYnBmL2VicGYuaCAgICAgICAgICAgICAgICAgICAgfCAgMjUgKysrKysrKwo+ID4gIGVicGYv
ZWJwZl9yc3Mtc3R1Yi5jICAgICAgICAgICB8ICAgNiArKwo+ID4gIGVicGYvZWJwZl9yc3MuYyAg
ICAgICAgICAgICAgICB8IDEyNCArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0KPiA+
ICBlYnBmL2VicGZfcnNzLmggICAgICAgICAgICAgICAgfCAgMTAgKysrCj4gPiAgZWJwZi9tZXNv
bi5idWlsZCAgICAgICAgICAgICAgIHwgICAxICsKPiA+ICBody9uZXQvdmlydGlvLW5ldC5jICAg
ICAgICAgICAgfCAgNzcgKysrKysrKysrKysrKysrKysrLS0KPiA+ICBpbmNsdWRlL2h3L3ZpcnRp
by92aXJ0aW8tbmV0LmggfCAgIDEgKwo+ID4gIG1vbml0b3IvcW1wLWNtZHMuYyAgICAgICAgICAg
ICB8ICAxNyArKysrKwo+ID4gIHFhcGkvbWlzYy5qc29uICAgICAgICAgICAgICAgICB8ICAyNSAr
KysrKysrCj4gPiAgMTAgZmlsZXMgY2hhbmdlZCwgMzA3IGluc2VydGlvbnMoKyksIDI3IGRlbGV0
aW9ucygtKQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBlYnBmL2VicGYuYwo+ID4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBlYnBmL2VicGYuaAo+ID4KPiA+IC0tCj4gPiAyLjM5LjEKPiA+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
