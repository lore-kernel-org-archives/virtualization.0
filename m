Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCCBCDB465
	for <virtualization@archiver.kernel.org>; Tue, 17 Oct 2023 02:38:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0991418DE;
	Tue, 17 Oct 2023 02:38:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A0991418DE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O14ZU/Zu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LSHJzLvt9LCu; Tue, 17 Oct 2023 02:38:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2570141900;
	Tue, 17 Oct 2023 02:38:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2570141900
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E55A4C0039;
	Tue, 17 Oct 2023 02:38:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42C4AC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 02:38:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 16E0D404B4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 02:38:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16E0D404B4
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=O14ZU/Zu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TOftX5Pr1QdH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 02:38:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC6DD416AE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 02:38:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC6DD416AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697510294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jLFBGnIpAzynaCLSWbQnRiqRNf9pByil8XHxQ2oSj4w=;
 b=O14ZU/Zu6BtObD+2rnQx/5V//1K153uv84JhUMyYAT+ORGIskx/1p97Mk7vvV82PnFIDyB
 q58Mla8Wr6OgJNDgXZzysPCVl1V3Ro9lqLtiSUYbneoTfhc62S9sBToKcUgm5cgBrEPkCU
 rW0ZrhDjvHn7ZdWaK6sW4/TdbTBNqmw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-lQu-7T5nPs-jMZO9DAwUHA-1; Mon, 16 Oct 2023 22:38:13 -0400
X-MC-Unique: lQu-7T5nPs-jMZO9DAwUHA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507bd5f4b2dso179356e87.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 19:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697510292; x=1698115092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jLFBGnIpAzynaCLSWbQnRiqRNf9pByil8XHxQ2oSj4w=;
 b=jtM/WpngUEoKwfgoohnqzNkjU/W9ikE+vf4ZevKj/Q5RKyQIuDnZR+cBOAiNzIqYLL
 NAafMJ6wk3Ae+rsa2G5XXoa5vgumwQHW3e8h4qbrVPGtHUyN0AGdn6w6MymrTQGHHmWw
 5m24A+AXah8pkNwp8x29gtmdgD16vY9PecaJHXJ3PwoavRcIOzhtna30eqnk3Y5fSZkF
 HnSNP08gBrKe6rFLXJZGkT/o3nP0UAAoTMEkDYxcv7aYh4ALkgmtFVVY4zm/bJt/bWkO
 w+gRuHOTiLbMKNJHlbZmIFVgDRtXwId+7B76199xfcjNt2U+8mnzb8K5cmJkg4vZPsZZ
 7kOA==
X-Gm-Message-State: AOJu0YxJ9GU9QM8poWii3DeObC8AUR8//2iu0JsXeQXPfp7UAOVz8/8Q
 Nuy+uUsS1YGkuWeShqv+mFozR9d8vlIN8P27DJWAcq3MM7yvbUGlPyX8GI0SFrCM9m6bfuCuzhY
 C/fhoAyxDTKPVGXgEEMOqUBT5aSHTV6ImoSmiMyn82WzzMzBNsTUnWpxfPg==
X-Received: by 2002:a19:7616:0:b0:506:8e27:7ce9 with SMTP id
 c22-20020a197616000000b005068e277ce9mr773824lff.16.1697510292106; 
 Mon, 16 Oct 2023 19:38:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwD5883Y6d40R7U3CghOpbHBfm9xN2dxJWP8byeoC8zFnDP5U2UV48wLUupwqJd40JvPd+TfwSf9k5qjsrlt4=
X-Received: by 2002:a19:7616:0:b0:506:8e27:7ce9 with SMTP id
 c22-20020a197616000000b005068e277ce9mr773811lff.16.1697510291790; Mon, 16 Oct
 2023 19:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
 <20231015141644.260646-2-akihiko.odaki@daynix.com>
 <CAADnVQLfUDmgYng8Cw1hiZOMfWNWLjbn7ZGc4yOEz-XmeFEz5Q@mail.gmail.com>
 <2594bb24-74dc-4785-b46d-e1bffcc3e7ed@daynix.com>
 <CAADnVQ+J+bOtvEfdvgUse_Rr07rM5KOZ5DtAmHDgRmi70W68+g@mail.gmail.com>
In-Reply-To: <CAADnVQ+J+bOtvEfdvgUse_Rr07rM5KOZ5DtAmHDgRmi70W68+g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Oct 2023 10:38:00 +0800
Message-ID: <CACGkMEs22078F7rSLEz6eQabkZZ=kujSONUNMThZz5Gp=YiidQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/7] bpf: Introduce BPF_PROG_TYPE_VNET_HASH
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrew Melnychenko <andrew@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
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

T24gVHVlLCBPY3QgMTcsIDIwMjMgYXQgNzo1M+KAr0FNIEFsZXhlaSBTdGFyb3ZvaXRvdgo8YWxl
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
dCBhZGQgc3RhYmxlIGJwZiBwcm9ncmFtIHR5cGVzIG9yIGhvb2tzIGFueSBtb3JlLgoKRG9lcyB0
aGlzIG1lYW4gZUJQRiBjb3VsZCBub3QgYmUgdXNlZCBmb3IgYW55IG5ldyB1c2UgY2FzZXMgb3Ro
ZXIgdGhhbgp0aGUgZXhpc3Rpbmcgb25lcz8KCj4gSWYgYSBrZXJuZWwgc3Vic3lzdGVtIHdhbnRz
IHRvIHVzZSBicGYgaXQgbmVlZHMgdG8gYWNjZXB0IHRoZSBmYWN0Cj4gdGhhdCBzdWNoIGJwZiBl
eHRlbnNpYmlsaXR5IHdpbGwgYmUgdW5zdGFibGUgYW5kIHN1YnN5c3RlbSBtYWludGFpbmVycwo+
IGNhbiBkZWNpZGUgdG8gcmVtb3ZlIHN1Y2ggYnBmIHN1cHBvcnQgaW4gdGhlIGZ1dHVyZS4KCkkg
ZG9uJ3Qgc2VlIGhvdyBpdCBpcyBkaWZmZXJlbnQgZnJvbSB0aGUgZXhpc3Rpbmcgb25lcy4KClRo
YW5rcwoKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
