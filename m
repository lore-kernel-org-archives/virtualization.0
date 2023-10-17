Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79FACDB474
	for <virtualization@archiver.kernel.org>; Tue, 17 Oct 2023 19:04:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BDAD61400;
	Tue, 17 Oct 2023 19:04:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1BDAD61400
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LDtE07/I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XhkUBKiBSA3M; Tue, 17 Oct 2023 19:04:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7696760FF6;
	Tue, 17 Oct 2023 19:04:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7696760FF6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3578BC0071;
	Tue, 17 Oct 2023 19:04:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F21CBC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 19:04:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C70BA41D85
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 19:04:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C70BA41D85
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=LDtE07/I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DQ8lSsFEHbrr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 19:04:03 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AF46341D19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 19:04:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF46341D19
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40651a726acso53876615e9.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 12:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697569440; x=1698174240;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3URO8PfjgnFnifpX9a/pgxt4rV16Mqdk8BmJm6wrjEE=;
 b=LDtE07/IRWngi/knF83ARSgmkg7pEvA4dC+UD1pJUjcG6I4u6AGiSw/EwOqt6eDyyf
 WzNHOVa0n5d3srDYBc3rGp6GPv0Ig6L6bzAoRA6/8cYt9IkeD7uuaHsh3Rm80QXrCSwE
 dSnR6I5NaGpTnnYR6l+W4fiGTxDG2sS9Hh+1bkdQPHUzeXPEr6RTkPtud3D/iuJmWHcP
 ujU+osmk5awirENU35J2Z5JIM6Twr/7+Ng+/Ex9u+sGI0sdY6qM28m3Z1OAh2cHJlBo3
 uxW9OJniGLrZfmegyYrc2hpVimPs/RqLcMS1XfYkhRKh3khEG0yaT3pAwguVoc4Syo9w
 2rOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697569440; x=1698174240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3URO8PfjgnFnifpX9a/pgxt4rV16Mqdk8BmJm6wrjEE=;
 b=EdMjku2ugBPAUNZad/wYJLRZzlnwMnYtPTxFLwlT3XxP2a6cXK2aq77ioIakBqFugB
 Gy8GZPhO6dyk4ZaCH0Cc6fNsTrY0nv2j0fhi9JCU24ljNKF7LNtKAbsxxuR4bQBmPUUe
 nTH49a54TO09D61hx+WjLwqsCw6O41g9ecDaFt+bgFYPfrACyBJHVMt4aGeaqWfSsIr6
 0wm4V0Zo8WP1R0mkCeAoX88C3My+3WzfmrM3EMH+rBVus21TICfuIfpMlwUKrJ2j6ydF
 InwR/O3P61SnUdf7z+B7yyvIWRRKvz19pGizudAE5/2yolFbvLfEKcU11mCttForO/LV
 nFew==
X-Gm-Message-State: AOJu0YyQW3/paxD0V06eMrptlVkxITz0gpWCN2+6OLmkg+gg3YMYg71c
 ujJwK5rIs2GVeSAec9TPwkJPTPxEW/DMhkffbIk=
X-Google-Smtp-Source: AGHT+IEqUCfXV01nbzvJAQDYMt9/bfI3+Cy97/1wLOR9HsrauveAzt0KnETONmK639Tj5oEfXeeZKSha0vPN++YdkEI=
X-Received: by 2002:a5d:4e47:0:b0:32d:65ab:2228 with SMTP id
 r7-20020a5d4e47000000b0032d65ab2228mr2493781wrt.11.1697569440390; Tue, 17 Oct
 2023 12:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
 <20231015141644.260646-2-akihiko.odaki@daynix.com>
 <CAADnVQLfUDmgYng8Cw1hiZOMfWNWLjbn7ZGc4yOEz-XmeFEz5Q@mail.gmail.com>
 <2594bb24-74dc-4785-b46d-e1bffcc3e7ed@daynix.com>
 <CAADnVQ+J+bOtvEfdvgUse_Rr07rM5KOZ5DtAmHDgRmi70W68+g@mail.gmail.com>
 <CACGkMEs22078F7rSLEz6eQabkZZ=kujSONUNMThZz5Gp=YiidQ@mail.gmail.com>
In-Reply-To: <CACGkMEs22078F7rSLEz6eQabkZZ=kujSONUNMThZz5Gp=YiidQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Oct 2023 12:03:48 -0700
Message-ID: <CAADnVQLt8NWvP8qGWMPx=12PwWWE69P7aS2dbm=khAJkCnJEoQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/7] bpf: Introduce BPF_PROG_TYPE_VNET_HASH
To: Jason Wang <jasowang@redhat.com>
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

T24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgNzozOOKAr1BNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCBPY3QgMTcsIDIwMjMgYXQgNzo1M+KAr0FNIEFs
ZXhlaSBTdGFyb3ZvaXRvdgo+IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToK
PiA+Cj4gPiBPbiBTdW4sIE9jdCAxNSwgMjAyMyBhdCAxMDoxMOKAr0FNIEFraWhpa28gT2Rha2kg
PGFraWhpa28ub2Rha2lAZGF5bml4LmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IE9uIDIwMjMvMTAv
MTYgMTowNywgQWxleGVpIFN0YXJvdm9pdG92IHdyb3RlOgo+ID4gPiA+IE9uIFN1biwgT2N0IDE1
LCAyMDIzIGF0IDc6MTfigK9BTSBBa2loaWtvIE9kYWtpIDxha2loaWtvLm9kYWtpQGRheW5peC5j
b20+IHdyb3RlOgo+ID4gPiA+Pgo+ID4gPiA+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xp
bnV4L2JwZi5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oCj4gPiA+ID4+IGluZGV4IDA0NDg3
MDA4OTBmNy4uMjk4NjM0NTU2ZmFiIDEwMDY0NAo+ID4gPiA+PiAtLS0gYS9pbmNsdWRlL3VhcGkv
bGludXgvYnBmLmgKPiA+ID4gPj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oCj4gPiA+
ID4+IEBAIC05ODgsNiArOTg4LDcgQEAgZW51bSBicGZfcHJvZ190eXBlIHsKPiA+ID4gPj4gICAg
ICAgICAgQlBGX1BST0dfVFlQRV9TS19MT09LVVAsCj4gPiA+ID4+ICAgICAgICAgIEJQRl9QUk9H
X1RZUEVfU1lTQ0FMTCwgLyogYSBwcm9ncmFtIHRoYXQgY2FuIGV4ZWN1dGUgc3lzY2FsbHMgKi8K
PiA+ID4gPj4gICAgICAgICAgQlBGX1BST0dfVFlQRV9ORVRGSUxURVIsCj4gPiA+ID4+ICsgICAg
ICAgQlBGX1BST0dfVFlQRV9WTkVUX0hBU0gsCj4gPiA+ID4KPiA+ID4gPiBTb3JyeSwgd2UgZG8g
bm90IGFkZCBuZXcgc3RhYmxlIHByb2dyYW0gdHlwZXMgYW55bW9yZS4KPiA+ID4gPgo+ID4gPiA+
PiBAQCAtNjExMSw2ICs2MTEyLDEwIEBAIHN0cnVjdCBfX3NrX2J1ZmYgewo+ID4gPiA+PiAgICAg
ICAgICBfX3U4ICB0c3RhbXBfdHlwZTsKPiA+ID4gPj4gICAgICAgICAgX191MzIgOjI0OyAgICAg
ICAgICAgICAgLyogUGFkZGluZywgZnV0dXJlIHVzZS4gKi8KPiA+ID4gPj4gICAgICAgICAgX191
NjQgaHd0c3RhbXA7Cj4gPiA+ID4+ICsKPiA+ID4gPj4gKyAgICAgICBfX3UzMiB2bmV0X2hhc2hf
dmFsdWU7Cj4gPiA+ID4+ICsgICAgICAgX191MTYgdm5ldF9oYXNoX3JlcG9ydDsKPiA+ID4gPj4g
KyAgICAgICBfX3UxNiB2bmV0X3Jzc19xdWV1ZTsKPiA+ID4gPj4gICB9Owo+ID4gPiA+Cj4gPiA+
ID4gd2UgYWxzbyBkbyBub3QgYWRkIGFueXRoaW5nIHRvIHVhcGkgX19za19idWZmLgo+ID4gPiA+
Cj4gPiA+ID4+ICtjb25zdCBzdHJ1Y3QgYnBmX3ZlcmlmaWVyX29wcyB2bmV0X2hhc2hfdmVyaWZp
ZXJfb3BzID0gewo+ID4gPiA+PiArICAgICAgIC5nZXRfZnVuY19wcm90byAgICAgICAgID0gc2tf
ZmlsdGVyX2Z1bmNfcHJvdG8sCj4gPiA+ID4+ICsgICAgICAgLmlzX3ZhbGlkX2FjY2VzcyAgICAg
ICAgPSBza19maWx0ZXJfaXNfdmFsaWRfYWNjZXNzLAo+ID4gPiA+PiArICAgICAgIC5jb252ZXJ0
X2N0eF9hY2Nlc3MgICAgID0gYnBmX2NvbnZlcnRfY3R4X2FjY2VzcywKPiA+ID4gPj4gKyAgICAg
ICAuZ2VuX2xkX2FicyAgICAgICAgICAgICA9IGJwZl9nZW5fbGRfYWJzLAo+ID4gPiA+PiArfTsK
PiA+ID4gPgo+ID4gPiA+IGFuZCB3ZSBkb24ndCBkbyBjdHggcmV3cml0ZXMgbGlrZSB0aGlzIGVp
dGhlci4KPiA+ID4gPgo+ID4gPiA+IFBsZWFzZSBzZWUgaG93IGhpZC1icGYgYW5kIGNncm91cCBy
c3RhdCBhcmUgaG9va2luZyB1cCBicGYKPiA+ID4gPiBpbiBfdW5zdGFibGVfIHdheS4KPiA+ID4K
PiA+ID4gQ2FuIHlvdSBkZXNjcmliZSB3aGF0ICJzdGFibGUiIGFuZCAidW5zdGFibGUiIG1lYW4g
aGVyZT8gSSdtIG5ldyB0byBCUEYKPiA+ID4gYW5kIEknbSB3b3JyaWVkIGlmIGl0IG1heSBtZWFu
IHRoZSBpbnRlcmZhY2Ugc3RhYmlsaXR5Lgo+ID4gPgo+ID4gPiBMZXQgbWUgZGVzY3JpYmUgdGhl
IGNvbnRleHQuIFFFTVUgYnVuZGxlcyBhbiBlQlBGIHByb2dyYW0gdGhhdCBpcyB1c2VkCj4gPiA+
IGZvciB0aGUgImVCUEYgc3RlZXJpbmcgcHJvZ3JhbSIgZmVhdHVyZSBvZiB0dW4uIE5vdyBJJ20g
cHJvcG9zaW5nIHRvCj4gPiA+IGV4dGVuZCB0aGUgZmVhdHVyZSB0byBhbGxvdyB0byByZXR1cm4g
c29tZSB2YWx1ZXMgdG8gdGhlIHVzZXJzcGFjZSBhbmQKPiA+ID4gdmhvc3RfbmV0LiBBcyBzdWNo
LCB0aGUgZXh0ZW5zaW9uIG5lZWRzIHRvIGJlIGRvbmUgaW4gYSB3YXkgdGhhdCBlbnN1cmVzCj4g
PiA+IGludGVyZmFjZSBzdGFiaWxpdHkuCj4gPgo+ID4gYnBmIGlzIG5vdCBhbiBvcHRpb24gdGhl
bi4KPiA+IHdlIGRvIG5vdCBhZGQgc3RhYmxlIGJwZiBwcm9ncmFtIHR5cGVzIG9yIGhvb2tzIGFu
eSBtb3JlLgo+Cj4gRG9lcyB0aGlzIG1lYW4gZUJQRiBjb3VsZCBub3QgYmUgdXNlZCBmb3IgYW55
IG5ldyB1c2UgY2FzZXMgb3RoZXIgdGhhbgo+IHRoZSBleGlzdGluZyBvbmVzPwoKSXQgbWVhbnMg
dGhhdCBhbnkgbmV3IHVzZSBvZiBicGYgaGFzIHRvIGJlIHVuc3RhYmxlIGZvciB0aGUgdGltZSBi
ZWluZy4KCj4gPiBJZiBhIGtlcm5lbCBzdWJzeXN0ZW0gd2FudHMgdG8gdXNlIGJwZiBpdCBuZWVk
cyB0byBhY2NlcHQgdGhlIGZhY3QKPiA+IHRoYXQgc3VjaCBicGYgZXh0ZW5zaWJpbGl0eSB3aWxs
IGJlIHVuc3RhYmxlIGFuZCBzdWJzeXN0ZW0gbWFpbnRhaW5lcnMKPiA+IGNhbiBkZWNpZGUgdG8g
cmVtb3ZlIHN1Y2ggYnBmIHN1cHBvcnQgaW4gdGhlIGZ1dHVyZS4KPgo+IEkgZG9uJ3Qgc2VlIGhv
dyBpdCBpcyBkaWZmZXJlbnQgZnJvbSB0aGUgZXhpc3Rpbmcgb25lcy4KCkNhbiB3ZSByZW1vdmUg
QlBGX0NHUk9VUF9SVU5fUFJPR19JTkVUX0lOR1JFU1MgaG9vayBhbG9uZwp3aXRoIEJQRl9QUk9H
X1RZUEVfQ0dST1VQX1NLQiBwcm9ncmFtIHR5cGU/Ck9idmlvdXNseSBub3QuCldlIGNhbiByZWZh
Y3RvciBpdC4gV2UgY2FuIG1vdmUgaXQgYXJvdW5kLCBidXQgbm90IHJlbW92ZS4KVGhhdCdzIHRo
ZSBkaWZmZXJlbmNlIGluIHN0YWJsZSB2cyB1bnN0YWJsZS4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
