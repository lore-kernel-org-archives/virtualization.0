Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743C9CDB465
	for <virtualization@archiver.kernel.org>; Tue, 17 Oct 2023 00:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF6F760E4F;
	Tue, 17 Oct 2023 00:37:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF6F760E4F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BNl20NEE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZIVnhJGlvgG0; Tue, 17 Oct 2023 00:37:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 321DB60ED6;
	Tue, 17 Oct 2023 00:37:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 321DB60ED6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11841C0039;
	Tue, 17 Oct 2023 00:37:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81650C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 00:37:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4CAED401A1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 00:37:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4CAED401A1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=BNl20NEE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D9P8GIUwffMs
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 00:37:22 +0000 (UTC)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2E754011C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 00:37:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B2E754011C
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7a7e11a53c3so4131785241.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 17:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697503040; x=1698107840;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hCBpBFy0sL3kGgajsg5bL9lp51r5jSArJUZNS83IHhs=;
 b=BNl20NEET0Wg9UTz1979doLfOQVEqV6eczfavC7nHGHvbrdniHfAS+zn/VZch4efon
 UvRGlSAu4y/XODCvzJbIn4rEHSiqF4OtTPSkY9evnZUdNr4AYBEugVnTDPXHRTA/uMyC
 zXFILYKUXIIk6IKfKsyQK8Zk/Cylom1faKhQpwfdZ9UOX26crVL9cU7VOQ46E4uYsemV
 xCSWJ6Krn2VRR6zl/Tw83ZtOIpL3JS6LmkPJeuRjOi2YmLNybHNI9CiE/j91iXQUFYs8
 t70BAKcvTeZrAcmOQPHA9xH9HZ+2cvTlYO7xsXlZf/U4PSXCv1MTOoTpZrDH/HI9thSN
 bMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697503040; x=1698107840;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hCBpBFy0sL3kGgajsg5bL9lp51r5jSArJUZNS83IHhs=;
 b=nb8nAJqWQ049ZekDqaBnCDlxoNYgwigk0Rd/aX2vlmWfnqw6FLGMP5yN2C5qgrURXs
 Qdz+79NBwW/HUNJitoF9pCf7U9eb9bqjkjjYZDST1ZoNvTzndpk62riX5Ok1BTNYrWrl
 yYH3XrqsIR/7GhJ/6OzPAKm2Wocpv5JOlrDNjbMxHqkiy9IJ1C4c99JyNmgm2t8vgZ6O
 C2Oj/fHdv3aE74DNh0bai5zr6B/Dfj7FZww1gBqPBkbcbBGB7gDSgxFoyZ21kj0fE+Zk
 Odo6CFw82ROovovJSkGL0VOLRaM+XzomlcodoGNCt6WvNgtt1aWXsKGWYWXtc4JCUmRE
 5Z1w==
X-Gm-Message-State: AOJu0YyAN43vhfkgOag8Jcc3YgnZBfVXoirpi5dZxknWk/DFB5uFy7Uj
 wr9qckj6rqHKhBQc2WWUA5toFuQ2qATlJEsXa08=
X-Google-Smtp-Source: AGHT+IGTFKrIo3DX3VTBrldf07y90mT9ODR4qoemWSfmdES5n+WGptKeaXQi892QmMn5GqvVYCmrHCk1YdrE8z97v4I=
X-Received: by 2002:a67:ac4a:0:b0:457:cbde:603d with SMTP id
 n10-20020a67ac4a000000b00457cbde603dmr189013vsh.14.1697503040429; Mon, 16 Oct
 2023 17:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
 <20231015141644.260646-2-akihiko.odaki@daynix.com>
 <CAADnVQLfUDmgYng8Cw1hiZOMfWNWLjbn7ZGc4yOEz-XmeFEz5Q@mail.gmail.com>
 <2594bb24-74dc-4785-b46d-e1bffcc3e7ed@daynix.com>
 <CAADnVQ+J+bOtvEfdvgUse_Rr07rM5KOZ5DtAmHDgRmi70W68+g@mail.gmail.com>
In-Reply-To: <CAADnVQ+J+bOtvEfdvgUse_Rr07rM5KOZ5DtAmHDgRmi70W68+g@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 16 Oct 2023 20:36:43 -0400
Message-ID: <CAF=yD-Jr1wKo6viUGWTcXsT5b9e1NkuemuvjN988qSyNmheM2A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/7] bpf: Introduce BPF_PROG_TYPE_VNET_HASH
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Melnychenko <andrew@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Song Liu <song@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Stanislav Fomichev <sdf@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Shuah Khan <shuah@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Mykola Lysenko <mykolal@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 KP Singh <kpsingh@kernel.org>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Hao Luo <haoluo@google.com>, Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 "David S. Miller" <davem@davemloft.net>
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

T24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgNzo1M+KAr1BNIEFsZXhlaSBTdGFyb3ZvaXRvdgo8YWxl
eGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBPbiBTdW4sIE9jdCAxNSwgMjAy
MyBhdCAxMDoxMOKAr0FNIEFraWhpa28gT2Rha2kgPGFraWhpa28ub2Rha2lAZGF5bml4LmNvbT4g
d3JvdGU6Cj4gPgo+ID4gT24gMjAyMy8xMC8xNiAxOjA3LCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6Cj4gPiA+IE9uIFN1biwgT2N0IDE1LCAyMDIzIGF0IDc6MTfigK9BTSBBa2loaWtvIE9kYWtp
IDxha2loaWtvLm9kYWtpQGRheW5peC5jb20+IHdyb3RlOgo+ID4gPj4KPiA+ID4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmggYi9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgK
PiA+ID4+IGluZGV4IDA0NDg3MDA4OTBmNy4uMjk4NjM0NTU2ZmFiIDEwMDY0NAo+ID4gPj4gLS0t
IGEvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oCj4gPiA+PiArKysgYi9pbmNsdWRlL3VhcGkvbGlu
dXgvYnBmLmgKPiA+ID4+IEBAIC05ODgsNiArOTg4LDcgQEAgZW51bSBicGZfcHJvZ190eXBlIHsK
PiA+ID4+ICAgICAgICAgIEJQRl9QUk9HX1RZUEVfU0tfTE9PS1VQLAo+ID4gPj4gICAgICAgICAg
QlBGX1BST0dfVFlQRV9TWVNDQUxMLCAvKiBhIHByb2dyYW0gdGhhdCBjYW4gZXhlY3V0ZSBzeXNj
YWxscyAqLwo+ID4gPj4gICAgICAgICAgQlBGX1BST0dfVFlQRV9ORVRGSUxURVIsCj4gPiA+PiAr
ICAgICAgIEJQRl9QUk9HX1RZUEVfVk5FVF9IQVNILAo+ID4gPgo+ID4gPiBTb3JyeSwgd2UgZG8g
bm90IGFkZCBuZXcgc3RhYmxlIHByb2dyYW0gdHlwZXMgYW55bW9yZS4KPiA+ID4KPiA+ID4+IEBA
IC02MTExLDYgKzYxMTIsMTAgQEAgc3RydWN0IF9fc2tfYnVmZiB7Cj4gPiA+PiAgICAgICAgICBf
X3U4ICB0c3RhbXBfdHlwZTsKPiA+ID4+ICAgICAgICAgIF9fdTMyIDoyNDsgICAgICAgICAgICAg
IC8qIFBhZGRpbmcsIGZ1dHVyZSB1c2UuICovCj4gPiA+PiAgICAgICAgICBfX3U2NCBod3RzdGFt
cDsKPiA+ID4+ICsKPiA+ID4+ICsgICAgICAgX191MzIgdm5ldF9oYXNoX3ZhbHVlOwo+ID4gPj4g
KyAgICAgICBfX3UxNiB2bmV0X2hhc2hfcmVwb3J0Owo+ID4gPj4gKyAgICAgICBfX3UxNiB2bmV0
X3Jzc19xdWV1ZTsKPiA+ID4+ICAgfTsKPiA+ID4KPiA+ID4gd2UgYWxzbyBkbyBub3QgYWRkIGFu
eXRoaW5nIHRvIHVhcGkgX19za19idWZmLgo+ID4gPgo+ID4gPj4gK2NvbnN0IHN0cnVjdCBicGZf
dmVyaWZpZXJfb3BzIHZuZXRfaGFzaF92ZXJpZmllcl9vcHMgPSB7Cj4gPiA+PiArICAgICAgIC5n
ZXRfZnVuY19wcm90byAgICAgICAgID0gc2tfZmlsdGVyX2Z1bmNfcHJvdG8sCj4gPiA+PiArICAg
ICAgIC5pc192YWxpZF9hY2Nlc3MgICAgICAgID0gc2tfZmlsdGVyX2lzX3ZhbGlkX2FjY2VzcywK
PiA+ID4+ICsgICAgICAgLmNvbnZlcnRfY3R4X2FjY2VzcyAgICAgPSBicGZfY29udmVydF9jdHhf
YWNjZXNzLAo+ID4gPj4gKyAgICAgICAuZ2VuX2xkX2FicyAgICAgICAgICAgICA9IGJwZl9nZW5f
bGRfYWJzLAo+ID4gPj4gK307Cj4gPiA+Cj4gPiA+IGFuZCB3ZSBkb24ndCBkbyBjdHggcmV3cml0
ZXMgbGlrZSB0aGlzIGVpdGhlci4KPiA+ID4KPiA+ID4gUGxlYXNlIHNlZSBob3cgaGlkLWJwZiBh
bmQgY2dyb3VwIHJzdGF0IGFyZSBob29raW5nIHVwIGJwZgo+ID4gPiBpbiBfdW5zdGFibGVfIHdh
eS4KPiA+Cj4gPiBDYW4geW91IGRlc2NyaWJlIHdoYXQgInN0YWJsZSIgYW5kICJ1bnN0YWJsZSIg
bWVhbiBoZXJlPyBJJ20gbmV3IHRvIEJQRgo+ID4gYW5kIEknbSB3b3JyaWVkIGlmIGl0IG1heSBt
ZWFuIHRoZSBpbnRlcmZhY2Ugc3RhYmlsaXR5Lgo+ID4KPiA+IExldCBtZSBkZXNjcmliZSB0aGUg
Y29udGV4dC4gUUVNVSBidW5kbGVzIGFuIGVCUEYgcHJvZ3JhbSB0aGF0IGlzIHVzZWQKPiA+IGZv
ciB0aGUgImVCUEYgc3RlZXJpbmcgcHJvZ3JhbSIgZmVhdHVyZSBvZiB0dW4uIE5vdyBJJ20gcHJv
cG9zaW5nIHRvCj4gPiBleHRlbmQgdGhlIGZlYXR1cmUgdG8gYWxsb3cgdG8gcmV0dXJuIHNvbWUg
dmFsdWVzIHRvIHRoZSB1c2Vyc3BhY2UgYW5kCj4gPiB2aG9zdF9uZXQuIEFzIHN1Y2gsIHRoZSBl
eHRlbnNpb24gbmVlZHMgdG8gYmUgZG9uZSBpbiBhIHdheSB0aGF0IGVuc3VyZXMKPiA+IGludGVy
ZmFjZSBzdGFiaWxpdHkuCj4KPiBicGYgaXMgbm90IGFuIG9wdGlvbiB0aGVuLgo+IHdlIGRvIG5v
dCBhZGQgc3RhYmxlIGJwZiBwcm9ncmFtIHR5cGVzIG9yIGhvb2tzIGFueSBtb3JlLgo+IElmIGEg
a2VybmVsIHN1YnN5c3RlbSB3YW50cyB0byB1c2UgYnBmIGl0IG5lZWRzIHRvIGFjY2VwdCB0aGUg
ZmFjdAo+IHRoYXQgc3VjaCBicGYgZXh0ZW5zaWJpbGl0eSB3aWxsIGJlIHVuc3RhYmxlIGFuZCBz
dWJzeXN0ZW0gbWFpbnRhaW5lcnMKPiBjYW4gZGVjaWRlIHRvIHJlbW92ZSBzdWNoIGJwZiBzdXBw
b3J0IGluIHRoZSBmdXR1cmUuCgpCYXNlZCBvbiBob29rcyBmb3IgdHJhY2Vwb2ludHMgYW5kIGtm
dW5jcywgY29ycmVjdD8KClBlcmhhcHMgdGhlIGV4aXN0aW5nIHN0YWJsZSBmbG93IGRpc3NlY3Rv
ciB0eXBlIGlzIGV4dGVuc2libGUgdG8Kb3B0aW9uYWxseSBjb21wdXRlIHRoZSBoYXNoIGFuZCBy
ZXBvcnQgaGFzaCBhbmQgaGFzaCB0eXBlLiBFbHNlIHdlCnByb2JhYmx5IHNob3VsZCByZXZpc2l0
IHRoZSBwcmV2aW91cyB2ZXJzaW9uIG9mIHRoaXMgc2VyaWVzLgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
