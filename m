Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3CACDB465
	for <virtualization@archiver.kernel.org>; Mon, 16 Oct 2023 23:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFB02418E2;
	Mon, 16 Oct 2023 23:53:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFB02418E2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BO3KJToG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nhIqqmyZIfJT; Mon, 16 Oct 2023 23:53:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E5B22418E3;
	Mon, 16 Oct 2023 23:53:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E5B22418E3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8F8EC0071;
	Mon, 16 Oct 2023 23:53:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B0B6C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 23:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F26440467
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 23:53:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F26440467
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=BO3KJToG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mpq3OLL_WhGw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 23:53:26 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B1014031F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 23:53:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B1014031F
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32d8c2c6dfdso4944360f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 16:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697500404; x=1698105204;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0VEVqtbhTZ62Wt4BNsx/63ghGB/h6YT4GupgB+U3dfc=;
 b=BO3KJToGQRrFWPJHyIK3iUw6ck5WEA142xES0HbSxAm1+zYPxbhwD6Ja8B+DjcT1z5
 vWTZ8g7MmE3jHcYMYHMO91ZcPq43nE9sb4+bZ/RuYXxHOjVm10hARyiPdAVLsKeH67WY
 xBioDjvAkkCiMdXP8uvyCa910Vkm75X1wfCj6R74orl9/wcx/FvX7U+6EIR7PseCN8KG
 aJhFVJust8pme0PblfsAkvIOdCFXEPBjDYPoiTqngD0OR+tU5QR+fKJKYojeiXnixvJu
 cg8Dmo4pjX+4qczGRr5+KGtZ1BIHCeYK9QlPmoztUyeGMpL3OzGSKILowpiZc9X6oA+f
 P5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697500404; x=1698105204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0VEVqtbhTZ62Wt4BNsx/63ghGB/h6YT4GupgB+U3dfc=;
 b=leJWdHBGahIPcQd3idSJBSdJtisQ0Q8zrKkt0iIHUkGf6I+G/6/FmdJMENZdMib6hm
 TOrja2aWXtLeDBg6nC1cGvyy6rkPqf3xB3f5wwq9uFpTbS4XqeQKsKlkGUnwVteHssZr
 X6m+eHLmEc6uk8X1DuWnQa8dKae+yzWjGd8412mN4jpyykx4OLgj/5DLKQj6D8cwKiaX
 ANDAKiL2tHhNujV81skNB++Mvbum6FWb5VE2FTiuoQyw8LIThuLnA3kopifXi9tWM6g5
 cVDvrxAlZEyZ8Fy4qBoEcSthYVvtHInAkUkNDC4FURAs6uCWNb1FXA7g+Krjuy3ZjGO1
 7tvQ==
X-Gm-Message-State: AOJu0YzHpWRz4lLTmeFLprRu5ibmxl/FFD4FJysNXyxi3mN2jEOMFXKD
 SLg1QTQo7END2XVux5caFuQ/y5Dmqe9LnuRLGIE=
X-Google-Smtp-Source: AGHT+IF1BuNjnsWI6nItlbieev+STDfI8LZWyBbAFr7V6O8+/fhS7AV6KvGufUNVb5YGTQIWA1gzYmteJZKw5LQ/Qio=
X-Received: by 2002:a5d:63cc:0:b0:32d:b8f8:2b18 with SMTP id
 c12-20020a5d63cc000000b0032db8f82b18mr715262wrw.32.1697500403744; Mon, 16 Oct
 2023 16:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
 <20231015141644.260646-2-akihiko.odaki@daynix.com>
 <CAADnVQLfUDmgYng8Cw1hiZOMfWNWLjbn7ZGc4yOEz-XmeFEz5Q@mail.gmail.com>
 <2594bb24-74dc-4785-b46d-e1bffcc3e7ed@daynix.com>
In-Reply-To: <2594bb24-74dc-4785-b46d-e1bffcc3e7ed@daynix.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 16 Oct 2023 16:53:11 -0700
Message-ID: <CAADnVQ+J+bOtvEfdvgUse_Rr07rM5KOZ5DtAmHDgRmi70W68+g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/7] bpf: Introduce BPF_PROG_TYPE_VNET_HASH
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Andrew Melnychenko <andrew@daynix.com>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Song Liu <song@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Stanislav Fomichev <sdf@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Shuah Khan <shuah@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Mykola Lysenko <mykolal@fb.com>, KP Singh <kpsingh@kernel.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, Hao Luo <haoluo@google.com>,
 Network Development <netdev@vger.kernel.org>,
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

T24gU3VuLCBPY3QgMTUsIDIwMjMgYXQgMTA6MTDigK9BTSBBa2loaWtvIE9kYWtpIDxha2loaWtv
Lm9kYWtpQGRheW5peC5jb20+IHdyb3RlOgo+Cj4gT24gMjAyMy8xMC8xNiAxOjA3LCBBbGV4ZWkg
U3Rhcm92b2l0b3Ygd3JvdGU6Cj4gPiBPbiBTdW4sIE9jdCAxNSwgMjAyMyBhdCA3OjE34oCvQU0g
QWtpaGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXluaXguY29tPiB3cm90ZToKPiA+Pgo+ID4+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmggYi9pbmNsdWRlL3VhcGkvbGlu
dXgvYnBmLmgKPiA+PiBpbmRleCAwNDQ4NzAwODkwZjcuLjI5ODYzNDU1NmZhYiAxMDA2NDQKPiA+
PiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgKPiA+PiArKysgYi9pbmNsdWRlL3VhcGkv
bGludXgvYnBmLmgKPiA+PiBAQCAtOTg4LDYgKzk4OCw3IEBAIGVudW0gYnBmX3Byb2dfdHlwZSB7
Cj4gPj4gICAgICAgICAgQlBGX1BST0dfVFlQRV9TS19MT09LVVAsCj4gPj4gICAgICAgICAgQlBG
X1BST0dfVFlQRV9TWVNDQUxMLCAvKiBhIHByb2dyYW0gdGhhdCBjYW4gZXhlY3V0ZSBzeXNjYWxs
cyAqLwo+ID4+ICAgICAgICAgIEJQRl9QUk9HX1RZUEVfTkVURklMVEVSLAo+ID4+ICsgICAgICAg
QlBGX1BST0dfVFlQRV9WTkVUX0hBU0gsCj4gPgo+ID4gU29ycnksIHdlIGRvIG5vdCBhZGQgbmV3
IHN0YWJsZSBwcm9ncmFtIHR5cGVzIGFueW1vcmUuCj4gPgo+ID4+IEBAIC02MTExLDYgKzYxMTIs
MTAgQEAgc3RydWN0IF9fc2tfYnVmZiB7Cj4gPj4gICAgICAgICAgX191OCAgdHN0YW1wX3R5cGU7
Cj4gPj4gICAgICAgICAgX191MzIgOjI0OyAgICAgICAgICAgICAgLyogUGFkZGluZywgZnV0dXJl
IHVzZS4gKi8KPiA+PiAgICAgICAgICBfX3U2NCBod3RzdGFtcDsKPiA+PiArCj4gPj4gKyAgICAg
ICBfX3UzMiB2bmV0X2hhc2hfdmFsdWU7Cj4gPj4gKyAgICAgICBfX3UxNiB2bmV0X2hhc2hfcmVw
b3J0Owo+ID4+ICsgICAgICAgX191MTYgdm5ldF9yc3NfcXVldWU7Cj4gPj4gICB9Owo+ID4KPiA+
IHdlIGFsc28gZG8gbm90IGFkZCBhbnl0aGluZyB0byB1YXBpIF9fc2tfYnVmZi4KPiA+Cj4gPj4g
K2NvbnN0IHN0cnVjdCBicGZfdmVyaWZpZXJfb3BzIHZuZXRfaGFzaF92ZXJpZmllcl9vcHMgPSB7
Cj4gPj4gKyAgICAgICAuZ2V0X2Z1bmNfcHJvdG8gICAgICAgICA9IHNrX2ZpbHRlcl9mdW5jX3By
b3RvLAo+ID4+ICsgICAgICAgLmlzX3ZhbGlkX2FjY2VzcyAgICAgICAgPSBza19maWx0ZXJfaXNf
dmFsaWRfYWNjZXNzLAo+ID4+ICsgICAgICAgLmNvbnZlcnRfY3R4X2FjY2VzcyAgICAgPSBicGZf
Y29udmVydF9jdHhfYWNjZXNzLAo+ID4+ICsgICAgICAgLmdlbl9sZF9hYnMgICAgICAgICAgICAg
PSBicGZfZ2VuX2xkX2FicywKPiA+PiArfTsKPiA+Cj4gPiBhbmQgd2UgZG9uJ3QgZG8gY3R4IHJl
d3JpdGVzIGxpa2UgdGhpcyBlaXRoZXIuCj4gPgo+ID4gUGxlYXNlIHNlZSBob3cgaGlkLWJwZiBh
bmQgY2dyb3VwIHJzdGF0IGFyZSBob29raW5nIHVwIGJwZgo+ID4gaW4gX3Vuc3RhYmxlXyB3YXku
Cj4KPiBDYW4geW91IGRlc2NyaWJlIHdoYXQgInN0YWJsZSIgYW5kICJ1bnN0YWJsZSIgbWVhbiBo
ZXJlPyBJJ20gbmV3IHRvIEJQRgo+IGFuZCBJJ20gd29ycmllZCBpZiBpdCBtYXkgbWVhbiB0aGUg
aW50ZXJmYWNlIHN0YWJpbGl0eS4KPgo+IExldCBtZSBkZXNjcmliZSB0aGUgY29udGV4dC4gUUVN
VSBidW5kbGVzIGFuIGVCUEYgcHJvZ3JhbSB0aGF0IGlzIHVzZWQKPiBmb3IgdGhlICJlQlBGIHN0
ZWVyaW5nIHByb2dyYW0iIGZlYXR1cmUgb2YgdHVuLiBOb3cgSSdtIHByb3Bvc2luZyB0bwo+IGV4
dGVuZCB0aGUgZmVhdHVyZSB0byBhbGxvdyB0byByZXR1cm4gc29tZSB2YWx1ZXMgdG8gdGhlIHVz
ZXJzcGFjZSBhbmQKPiB2aG9zdF9uZXQuIEFzIHN1Y2gsIHRoZSBleHRlbnNpb24gbmVlZHMgdG8g
YmUgZG9uZSBpbiBhIHdheSB0aGF0IGVuc3VyZXMKPiBpbnRlcmZhY2Ugc3RhYmlsaXR5LgoKYnBm
IGlzIG5vdCBhbiBvcHRpb24gdGhlbi4Kd2UgZG8gbm90IGFkZCBzdGFibGUgYnBmIHByb2dyYW0g
dHlwZXMgb3IgaG9va3MgYW55IG1vcmUuCklmIGEga2VybmVsIHN1YnN5c3RlbSB3YW50cyB0byB1
c2UgYnBmIGl0IG5lZWRzIHRvIGFjY2VwdCB0aGUgZmFjdAp0aGF0IHN1Y2ggYnBmIGV4dGVuc2li
aWxpdHkgd2lsbCBiZSB1bnN0YWJsZSBhbmQgc3Vic3lzdGVtIG1haW50YWluZXJzCmNhbiBkZWNp
ZGUgdG8gcmVtb3ZlIHN1Y2ggYnBmIHN1cHBvcnQgaW4gdGhlIGZ1dHVyZS4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
