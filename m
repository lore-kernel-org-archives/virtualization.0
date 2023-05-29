Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22C9C77B7A
	for <virtualization@archiver.kernel.org>; Mon, 29 May 2023 07:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 818D86120D;
	Mon, 29 May 2023 07:28:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 818D86120D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=noQYYPR5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6GWSxl6XjK06; Mon, 29 May 2023 07:28:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E59A961203;
	Mon, 29 May 2023 07:28:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E59A961203
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3EC1C0035;
	Mon, 29 May 2023 07:28:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DE1BC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 07:28:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1886F61204
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 07:28:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1886F61204
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H-fKdADvSS0f
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 07:28:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 022D061203
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 022D061203
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 07:28:18 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2af29b37bd7so30874031fa.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 00:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685345297; x=1687937297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pf4+1Iwu9vGygJo1X8C8/omiMMYvUuiv7Xu9BAspAOo=;
 b=noQYYPR5OLpTz67+derlxgYugG8q6CoOqE+qaM1z4ytstzOmfjKtDqygKby6xpEVZ/
 IBJNv5hP9WbZ+cLQBs8vC5ed8CGeS0CW5R0CWHeB4uN00UcwTeRg0dS4HS9T34hzC44S
 0repHUz8wvkrRm9OlIYAdpRJVnwqqZB8TkaqNq4Kh6mhgSDjmVlcd1NVPuoYYFC2qOYp
 TyfXzn2L3GlQBATK/wsVLBOAVBO31qWB4MNP5SMcnbUIC29apjGhyGSnlNV7a2xYxYPC
 QT522EmiRRS2Z0ztfqe2fzBqfeXZRWE9t07eVjJ1bPNhmnoREeCcyyBxJ6LFWvPpuH4o
 Pibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685345297; x=1687937297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pf4+1Iwu9vGygJo1X8C8/omiMMYvUuiv7Xu9BAspAOo=;
 b=UUy6EFuEo2s2/EBZATNz4Ew+2d0rzSUvdzaBD4HSiz6dKdsJBHBy8tOQBUr0PzifCy
 lIs/+1vzwKu3DQ9rs3VaApgWyA8lBp6umTPFOTlJGhRse6dpicAOnf+sy5fuQqqcgQk6
 ACGWlw+keNxQiQbk/QD8dcQbHSwUJ6fh4wspOATmr/9357GLQqcifQ9lHV3PRNSnUYvP
 W48baUingJ4ukXYsrLvrLdcxPQjmViUAtIgwgmZvbH/EhyQR5H3H0dFXkNRSzeO0dDUP
 zUr/DESKwpCEw1G/WQ7dG6EVdbfXAnJ18/SSkNIFSJE0ct3INe2qVky937EjJzfGVLw0
 e2iQ==
X-Gm-Message-State: AC+VfDxsCKTxjSthNJFoULxhMrwhaejmaEJ0QNjZZiIosta99WSzWSxs
 N9CXeua8L9spm+ycstIdlRnvbrxH1cMvd39afOY=
X-Google-Smtp-Source: ACHHUZ4NJPrBbzGRi2yeX0XLSDCJVY0qYpIUysxYUiTQv/oUtl2JS5BF724ts8ybo0i6AelWPdtd2oetH/M81Nigecw=
X-Received: by 2002:a2e:9108:0:b0:2af:1eee:84af with SMTP id
 m8-20020a2e9108000000b002af1eee84afmr3458498ljg.26.1685345296774; Mon, 29 May
 2023 00:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230526054621.18371-2-liangchen.linux@gmail.com>
 <202305262334.GiFQ3wpG-lkp@intel.com>
 <20230528022658-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230528022658-mutt-send-email-mst@kernel.org>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Mon, 29 May 2023 15:28:04 +0800
Message-ID: <CAKhg4t+xof9LiFbd2bJX03X=RL0uVZAxYbM5FQb106HgqWVYFA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/5] virtio_net: Add page_pool support to improve
 performance
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, kernel test robot <lkp@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org,
 edumazet@google.com, oe-kbuild-all@lists.linux.dev, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

T24gU3VuLCBNYXkgMjgsIDIwMjMgYXQgMjoyN+KAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gU2F0LCBNYXkgMjcsIDIwMjMgYXQgMTI6MTE6MjVB
TSArMDgwMCwga2VybmVsIHRlc3Qgcm9ib3Qgd3JvdGU6Cj4gPiBIaSBMaWFuZywKPiA+Cj4gPiBr
ZXJuZWwgdGVzdCByb2JvdCBub3RpY2VkIHRoZSBmb2xsb3dpbmcgYnVpbGQgZXJyb3JzOgo+ID4K
PiA+IFthdXRvIGJ1aWxkIHRlc3QgRVJST1Igb24gbmV0LW5leHQvbWFpbl0KPiA+Cj4gPiB1cmw6
ICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC1sYWItbGtwL2xpbnV4L2NvbW1pdHMvTGlhbmct
Q2hlbi92aXJ0aW9fbmV0LUFkZC1wYWdlX3Bvb2wtc3VwcG9ydC10by1pbXByb3ZlLXBlcmZvcm1h
bmNlLzIwMjMwNTI2LTEzNTgwNQo+ID4gYmFzZTogICBuZXQtbmV4dC9tYWluCj4gPiBwYXRjaCBs
aW5rOiAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMwNTI2MDU0NjIxLjE4MzcxLTIt
bGlhbmdjaGVuLmxpbnV4JTQwZ21haWwuY29tCj4gPiBwYXRjaCBzdWJqZWN0OiBbUEFUQ0ggbmV0
LW5leHQgMi81XSB2aXJ0aW9fbmV0OiBBZGQgcGFnZV9wb29sIHN1cHBvcnQgdG8gaW1wcm92ZSBw
ZXJmb3JtYW5jZQo+ID4gY29uZmlnOiB4ODZfNjQtZGVmY29uZmlnIChodHRwczovL2Rvd25sb2Fk
LjAxLm9yZy8wZGF5LWNpL2FyY2hpdmUvMjAyMzA1MjYvMjAyMzA1MjYyMzM0LkdpRlEzd3BHLWxr
cEBpbnRlbC5jb20vY29uZmlnKQo+ID4gY29tcGlsZXI6IGdjYy0xMSAoRGViaWFuIDExLjMuMC0x
MikgMTEuMy4wCj4gPiByZXByb2R1Y2UgKHRoaXMgaXMgYSBXPTEgYnVpbGQpOgo+ID4gICAgICAg
ICAjIGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC1sYWItbGtwL2xpbnV4L2NvbW1pdC9iZmJhNTYz
ZjQzYmJhMzcxODFkODUwMmNiMmU1NjZjMzJmOTZlYzllCj4gPiAgICAgICAgIGdpdCByZW1vdGUg
YWRkIGxpbnV4LXJldmlldyBodHRwczovL2dpdGh1Yi5jb20vaW50ZWwtbGFiLWxrcC9saW51eAo+
ID4gICAgICAgICBnaXQgZmV0Y2ggLS1uby10YWdzIGxpbnV4LXJldmlldyBMaWFuZy1DaGVuL3Zp
cnRpb19uZXQtQWRkLXBhZ2VfcG9vbC1zdXBwb3J0LXRvLWltcHJvdmUtcGVyZm9ybWFuY2UvMjAy
MzA1MjYtMTM1ODA1Cj4gPiAgICAgICAgIGdpdCBjaGVja291dCBiZmJhNTYzZjQzYmJhMzcxODFk
ODUwMmNiMmU1NjZjMzJmOTZlYzllCj4gPiAgICAgICAgICMgc2F2ZSB0aGUgY29uZmlnIGZpbGUK
PiA+ICAgICAgICAgbWtkaXIgYnVpbGRfZGlyICYmIGNwIGNvbmZpZyBidWlsZF9kaXIvLmNvbmZp
Zwo+ID4gICAgICAgICBtYWtlIFc9MSBPPWJ1aWxkX2RpciBBUkNIPXg4Nl82NCBvbGRkZWZjb25m
aWcKPiA+ICAgICAgICAgbWFrZSBXPTEgTz1idWlsZF9kaXIgQVJDSD14ODZfNjQgU0hFTEw9L2Jp
bi9iYXNoCj4gPgo+ID4gSWYgeW91IGZpeCB0aGUgaXNzdWUsIGtpbmRseSBhZGQgZm9sbG93aW5n
IHRhZyB3aGVyZSBhcHBsaWNhYmxlCj4gPiB8IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2Jv
dCA8bGtwQGludGVsLmNvbT4KPiA+IHwgQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9v
ZS1rYnVpbGQtYWxsLzIwMjMwNTI2MjMzNC5HaUZRM3dwRy1sa3BAaW50ZWwuY29tLwo+ID4KPiA+
IEFsbCBlcnJvcnMgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KToKPiA+Cj4gPiAgICBsZDogdm1s
aW51eC5vOiBpbiBmdW5jdGlvbiBgdmlydG5ldF9maW5kX3Zxcyc6Cj4gPiA+PiB2aXJ0aW9fbmV0
LmM6KC50ZXh0KzB4OTAxZmI1KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgcGFnZV9wb29sX2Ny
ZWF0ZScKPiA+ICAgIGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGBhZGRfcmVjdmJ1Zl9tZXJn
ZWFibGUuaXNyYS4wJzoKPiA+ID4+IHZpcnRpb19uZXQuYzooLnRleHQrMHg5MDU2MTgpOiB1bmRl
ZmluZWQgcmVmZXJlbmNlIHRvIGBwYWdlX3Bvb2xfYWxsb2NfcGFnZXMnCj4gPiAgICBsZDogdm1s
aW51eC5vOiBpbiBmdW5jdGlvbiBgeGRwX2xpbmVhcml6ZV9wYWdlJzoKPiA+ICAgIHZpcnRpb19u
ZXQuYzooLnRleHQrMHg5MDZiNmIpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBwYWdlX3Bvb2xf
YWxsb2NfcGFnZXMnCj4gPiAgICBsZDogdm1saW51eC5vOiBpbiBmdW5jdGlvbiBgbWVyZ2VhYmxl
X3hkcF9nZXRfYnVmLmlzcmEuMCc6Cj4gPiAgICB2aXJ0aW9fbmV0LmM6KC50ZXh0KzB4OTA3Mjhm
KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgcGFnZV9wb29sX2FsbG9jX3BhZ2VzJwo+Cj4KPiB5
b3UgbmVlZCB0byB0d2VhayBLY29uZmlnIHRvIHNlbGVjdCBQQUdFX1BPT0wgSSB0aGluay4KPgoK
U3VyZSwgdGhhbmtzIQoKCj4gPiAtLQo+ID4gMC1EQVkgQ0kgS2VybmVsIFRlc3QgU2VydmljZQo+
ID4gaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL2xrcC10ZXN0cy93aWtpCj4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
