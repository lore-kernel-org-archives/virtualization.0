Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC731CDB482
	for <virtualization@archiver.kernel.org>; Sun, 15 Oct 2023 16:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12DD44094F;
	Sun, 15 Oct 2023 16:08:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12DD44094F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AoXkozxf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rr3k0Jurouhp; Sun, 15 Oct 2023 16:08:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 65B4040946;
	Sun, 15 Oct 2023 16:08:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 65B4040946
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3491AC0039;
	Sun, 15 Oct 2023 16:08:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DF6EC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Oct 2023 16:08:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D0B8860A84
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Oct 2023 16:08:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D0B8860A84
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=AoXkozxf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kut5YgmGdbLo
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Oct 2023 16:08:03 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F003260804
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Oct 2023 16:08:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F003260804
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-405361bb9f7so37616645e9.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Oct 2023 09:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697386081; x=1697990881;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XujhMv/8pwB8H+Ij7K6MZPspXyDbpmJ+2p7uc4kDFNk=;
 b=AoXkozxfWPbMfUHk7cavctNKAUHB92OLR1BRtQwvi1q1AlS5zkS4zpPJg9rYCILx73
 eYP7Pen6kRlRuj04toxqU6A3Qz/quJ1hUIvyrudYGHg1lGrdw1no0HbQLcp5aH1o3F8U
 UxCdw11d8CWpMvBZ2xHVrjk9NeF8uIj7+eG9VN8NmSwUuVVqwIWSidupZk8RHjrQa1+Q
 DSWT3WuFV1DCGSfAulG6uSWLQeCz3NwZMoZ53Q9/8gFbpyjVCcewOlkKuaYovfeQTfdZ
 S5Jy4OiMoJVn3qMhc3mYK24UoN75Tu4YBKHbM93yIc1asrnMIwtX3izQS7oeiMy2gH1R
 DD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697386081; x=1697990881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XujhMv/8pwB8H+Ij7K6MZPspXyDbpmJ+2p7uc4kDFNk=;
 b=E+TYafWMzfvCbbI7PqwUUjsyAeg27lYIedgjefTgdXcy9mpnaZByQRkLf2QJlgkuXr
 yJt62IOjXlVH2N0utjj3l/HQ311YfH1XTS2rJNR0WtSX+ka7UvUWAljI+FT8ZUC6zUG/
 Yscd63BEKuGe+ByXwhS87UOmxGyacVB2flNRF/xpQdVT0LAmotDesARyOosmj0gDbx9Y
 6plq2X19GYDMhtwTS+dhC4nWgX45exQJXkhTm/3OWSNlHWuWopr8ureMiCwApl8kbhtD
 8NCxRlG/ptMzQ9B9vg8tpqsY4QuxR8/MK/IohPZmd9JN1fdtr8EsVOJ17iDjqaxNUygi
 s+OQ==
X-Gm-Message-State: AOJu0YyHJdbOGH7ROR8IU7lpZ3ZcoGk20QjzLu0ZaqN7076/Nb0xGcMS
 WuMyK22R2tvWfmfxwLZNZ3aC+9OnzEVwf5BYT5A=
X-Google-Smtp-Source: AGHT+IHRwQ5bE3hW1waPm3vlZF7IYRIPl+hr17w3AEC3uTMy8O1jLNp9Skrcd0Po7vdFsljBETR6eKnURnRLMkMbVyQ=
X-Received: by 2002:a05:600c:21d1:b0:405:3ae6:2413 with SMTP id
 x17-20020a05600c21d100b004053ae62413mr28009964wmj.25.1697386080580; Sun, 15
 Oct 2023 09:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
 <20231015141644.260646-2-akihiko.odaki@daynix.com>
In-Reply-To: <20231015141644.260646-2-akihiko.odaki@daynix.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 15 Oct 2023 09:07:49 -0700
Message-ID: <CAADnVQLfUDmgYng8Cw1hiZOMfWNWLjbn7ZGc4yOEz-XmeFEz5Q@mail.gmail.com>
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

T24gU3VuLCBPY3QgMTUsIDIwMjMgYXQgNzoxN+KAr0FNIEFraWhpa28gT2Rha2kgPGFraWhpa28u
b2Rha2lAZGF5bml4LmNvbT4gd3JvdGU6Cj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xp
bnV4L2JwZi5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oCj4gaW5kZXggMDQ0ODcwMDg5MGY3
Li4yOTg2MzQ1NTZmYWIgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oCj4g
KysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oCj4gQEAgLTk4OCw2ICs5ODgsNyBAQCBlbnVt
IGJwZl9wcm9nX3R5cGUgewo+ICAgICAgICAgQlBGX1BST0dfVFlQRV9TS19MT09LVVAsCj4gICAg
ICAgICBCUEZfUFJPR19UWVBFX1NZU0NBTEwsIC8qIGEgcHJvZ3JhbSB0aGF0IGNhbiBleGVjdXRl
IHN5c2NhbGxzICovCj4gICAgICAgICBCUEZfUFJPR19UWVBFX05FVEZJTFRFUiwKPiArICAgICAg
IEJQRl9QUk9HX1RZUEVfVk5FVF9IQVNILAoKU29ycnksIHdlIGRvIG5vdCBhZGQgbmV3IHN0YWJs
ZSBwcm9ncmFtIHR5cGVzIGFueW1vcmUuCgo+IEBAIC02MTExLDYgKzYxMTIsMTAgQEAgc3RydWN0
IF9fc2tfYnVmZiB7Cj4gICAgICAgICBfX3U4ICB0c3RhbXBfdHlwZTsKPiAgICAgICAgIF9fdTMy
IDoyNDsgICAgICAgICAgICAgIC8qIFBhZGRpbmcsIGZ1dHVyZSB1c2UuICovCj4gICAgICAgICBf
X3U2NCBod3RzdGFtcDsKPiArCj4gKyAgICAgICBfX3UzMiB2bmV0X2hhc2hfdmFsdWU7Cj4gKyAg
ICAgICBfX3UxNiB2bmV0X2hhc2hfcmVwb3J0Owo+ICsgICAgICAgX191MTYgdm5ldF9yc3NfcXVl
dWU7Cj4gIH07Cgp3ZSBhbHNvIGRvIG5vdCBhZGQgYW55dGhpbmcgdG8gdWFwaSBfX3NrX2J1ZmYu
Cgo+ICtjb25zdCBzdHJ1Y3QgYnBmX3ZlcmlmaWVyX29wcyB2bmV0X2hhc2hfdmVyaWZpZXJfb3Bz
ID0gewo+ICsgICAgICAgLmdldF9mdW5jX3Byb3RvICAgICAgICAgPSBza19maWx0ZXJfZnVuY19w
cm90bywKPiArICAgICAgIC5pc192YWxpZF9hY2Nlc3MgICAgICAgID0gc2tfZmlsdGVyX2lzX3Zh
bGlkX2FjY2VzcywKPiArICAgICAgIC5jb252ZXJ0X2N0eF9hY2Nlc3MgICAgID0gYnBmX2NvbnZl
cnRfY3R4X2FjY2VzcywKPiArICAgICAgIC5nZW5fbGRfYWJzICAgICAgICAgICAgID0gYnBmX2dl
bl9sZF9hYnMsCj4gK307CgphbmQgd2UgZG9uJ3QgZG8gY3R4IHJld3JpdGVzIGxpa2UgdGhpcyBl
aXRoZXIuCgpQbGVhc2Ugc2VlIGhvdyBoaWQtYnBmIGFuZCBjZ3JvdXAgcnN0YXQgYXJlIGhvb2tp
bmcgdXAgYnBmCmluIF91bnN0YWJsZV8gd2F5LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
