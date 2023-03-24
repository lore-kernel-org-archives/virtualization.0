Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3D2C6FD20
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 08:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32517610B8;
	Fri, 24 Mar 2023 08:39:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 32517610B8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XL5814zg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Yc1B3xjgXdw; Fri, 24 Mar 2023 08:38:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8D8D860E90;
	Fri, 24 Mar 2023 08:38:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D8D860E90
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51BC6C0071;
	Fri, 24 Mar 2023 08:38:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3B50C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 08:38:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B14E740914
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 08:38:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B14E740914
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XL5814zg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8_yu4eUXm4-a
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 08:38:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5443A40236
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5443A40236
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 08:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679647133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h1D7m14P56RNT5JGoAPdQmecs24aXusOMR+kHr7Nd7Q=;
 b=XL5814zg03imHmctSTlzBBM6QDKAAsAFyFI2S9uxA+RPdP2LfNPt7rM+vFuPqQR/a7FJEq
 xVMAjZOS1MzQfyJw/XUqfudzUaztR75ktag5WalZ7y4U2nWUKaE4FsUHKYJiStd+xV9W3F
 /GSSDM9wP7pmTSj7yjc5uMs8EWIAyHE=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-sSc5I9rbMV2gqxv4XRcz4w-1; Fri, 24 Mar 2023 04:38:52 -0400
X-MC-Unique: sSc5I9rbMV2gqxv4XRcz4w-1
Received: by mail-yb1-f200.google.com with SMTP id
 x15-20020a25accf000000b00b3b4535c48dso1220575ybd.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 01:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679647130;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1D7m14P56RNT5JGoAPdQmecs24aXusOMR+kHr7Nd7Q=;
 b=fXKADxmSz7hhAuCaju3iwyqFPYPnfJRvgQGtx9Ph1jjhiBBGJieZLOmEr/dlacvnVl
 oCPHU8O0ID0vOUNHGx+YhAfDus4IE0rmuo3Q8e7GngFSOQYrSM+M6c+IG1+65rRM97+4
 DOiNyQ26wCtYOGocabbHLqfT/cSGpR4Hs/57ibsY43FqaTLADVJX7hW59QmCG+Xc7qwE
 3GJQQrsDeoPB3zv2Lq/0pU6TLpcCxAxzsrZsm4400jdU+wzJg3NEfziULe/cB4EtPinU
 KlSkNIF2yKX0LhgOYirr9DlTCkpcNjRqfwmEcaWLl1h6obPcRCRXc4OXYfAW3lzeYaNg
 +W4Q==
X-Gm-Message-State: AAQBX9d/GwnkoAX0p38pBUZlxsHRRDNGi0lIuPxzoW/Z559YIroOUOpe
 FDL7tEPkAxUPrqHkKC9LkYG2Zl9ThrfSRWeZC1uemcfcKvjuGrqC8xPiOc35Ym/bYc8YSgPtb7b
 iC+5uKY5YLG1a1ZOriUaKG4SuwRGHWsixKwTpZy3UshFVmjiTPleiIpCIoA==
X-Received: by 2002:a25:b948:0:b0:acd:7374:f154 with SMTP id
 s8-20020a25b948000000b00acd7374f154mr902976ybm.7.1679647130011; 
 Fri, 24 Mar 2023 01:38:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350bJUkE56r+OXAAnA3zX4sKtvZzf+/cqdiByb/Kp2K9FLab9w7761QG8IjcA/36OfL1v2BkST2kJZovF/6N6wps=
X-Received: by 2002:a25:b948:0:b0:acd:7374:f154 with SMTP id
 s8-20020a25b948000000b00acd7374f154mr902969ybm.7.1679647129774; Fri, 24 Mar
 2023 01:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000075bebb05f79acfde@google.com>
In-Reply-To: <00000000000075bebb05f79acfde@google.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 24 Mar 2023 09:38:38 +0100
Message-ID: <CAGxU2F4jxdzK8Y-jaoKRaX_bDhoMtomOT6TyMek+un-Bp8RX3g@mail.gmail.com>
Subject: Re: [syzbot] [net?] [virt?] [io-uring?] [kvm?] BUG: soft lockup in
 vsock_connect
To: Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Bobby Eshleman <bobby.eshleman@gmail.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Cc: axboe@kernel.dk, Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>,
 Krasnov Arseniy <oxffffaa@gmail.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org,
 syzbot <syzbot+0bc015ebddc291a97116@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org, edumazet@google.com, stefanha@redhat.com,
 kuba@kernel.org, pabeni@redhat.com, virtualization@lists.linux-foundation.org,
 davem@davemloft.net
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

SGkgQm9iYnksCkZZSSB3ZSBoYXZlIGFsc28gdGhpcyBvbmUsIGJ1dCBpdCBzZWVtcyByZWxhdGVk
IHRvCnN5emJvdCtiZWZmZjBhOTUzNjA0OWU3OTAyZUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29t
CgpUaGFua3MsClN0ZWZhbm8KCgpPbiBGcmksIE1hciAyNCwgMjAyMyBhdCAxOjUy4oCvQU0gc3l6
Ym90CjxzeXpib3QrMGJjMDE1ZWJkZGMyOTFhOTcxMTZAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNv
bT4gd3JvdGU6Cj4KPiBIZWxsbywKPgo+IHN5emJvdCBmb3VuZCB0aGUgZm9sbG93aW5nIGlzc3Vl
IG9uOgo+Cj4gSEVBRCBjb21taXQ6ICAgIGZlMTVjMjZlZTI2ZSBMaW51eCA2LjMtcmMxCj4gZ2l0
IHRyZWU6ICAgICAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9hcm02NC9saW51eC5naXQgZm9yLWtlcm5lbGNpCj4gY29uc29sZSBvdXRwdXQ6IGh0dHBzOi8v
c3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvbG9nLnR4dD94PTE1NzdjOTdlYzgwMDAwCj4ga2VybmVs
IGNvbmZpZzogIGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvLmNvbmZpZz94PTc1NzNj
YmNkODgxYTg4YzkKPiBkYXNoYm9hcmQgbGluazogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5j
b20vYnVnP2V4dGlkPTBiYzAxNWViZGRjMjkxYTk3MTE2Cj4gY29tcGlsZXI6ICAgICAgIERlYmlh
biBjbGFuZyB2ZXJzaW9uIDE1LjAuNywgR05VIGxkIChHTlUgQmludXRpbHMgZm9yIERlYmlhbikg
Mi4zNS4yCj4gdXNlcnNwYWNlIGFyY2g6IGFybTY0Cj4gc3l6IHJlcHJvOiAgICAgIGh0dHBzOi8v
c3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVwcm8uc3l6P3g9MTA3N2M5OTZjODAwMDAKPiBDIHJl
cHJvZHVjZXI6ICAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9yZXByby5jP3g9MTdl
Mzg5MjljODAwMDAKPgo+IERvd25sb2FkYWJsZSBhc3NldHM6Cj4gZGlzayBpbWFnZTogaHR0cHM6
Ly9zdG9yYWdlLmdvb2dsZWFwaXMuY29tL3N5emJvdC1hc3NldHMvODlkNDFhYmQwN2JkL2Rpc2st
ZmUxNWMyNmUucmF3Lnh6Cj4gdm1saW51eDogaHR0cHM6Ly9zdG9yYWdlLmdvb2dsZWFwaXMuY29t
L3N5emJvdC1hc3NldHMvZmE3NWY1MDMwYWRlL3ZtbGludXgtZmUxNWMyNmUueHoKPiBrZXJuZWwg
aW1hZ2U6IGh0dHBzOi8vc3RvcmFnZS5nb29nbGVhcGlzLmNvbS9zeXpib3QtYXNzZXRzLzU5MGQw
ZjU5MDNlZS9JbWFnZS1mZTE1YzI2ZS5nei54ego+Cj4gSU1QT1JUQU5UOiBpZiB5b3UgZml4IHRo
ZSBpc3N1ZSwgcGxlYXNlIGFkZCB0aGUgZm9sbG93aW5nIHRhZyB0byB0aGUgY29tbWl0Ogo+IFJl
cG9ydGVkLWJ5OiBzeXpib3QrMGJjMDE1ZWJkZGMyOTFhOTcxMTZAc3l6a2FsbGVyLmFwcHNwb3Rt
YWlsLmNvbQo+Cj4gd2F0Y2hkb2c6IEJVRzogc29mdCBsb2NrdXAgLSBDUFUjMCBzdHVjayBmb3Ig
MjdzISBbc3l6LWV4ZWN1dG9yMjQ0OjY3NDddCj4gTW9kdWxlcyBsaW5rZWQgaW46Cj4gaXJxIGV2
ZW50IHN0YW1wOiA2MDMzCj4gaGFyZGlycXMgbGFzdCAgZW5hYmxlZCBhdCAoNjAzMik6IFs8ZmZm
ZjgwMDAxMjQ2MDRhYz5dIF9fZXhpdF90b19rZXJuZWxfbW9kZSBhcmNoL2FybTY0L2tlcm5lbC9l
bnRyeS1jb21tb24uYzo4NCBbaW5saW5lXQo+IGhhcmRpcnFzIGxhc3QgIGVuYWJsZWQgYXQgKDYw
MzIpOiBbPGZmZmY4MDAwMTI0NjA0YWM+XSBleGl0X3RvX2tlcm5lbF9tb2RlKzB4ZTgvMHgxMTgg
YXJjaC9hcm02NC9rZXJuZWwvZW50cnktY29tbW9uLmM6OTQKPiBoYXJkaXJxcyBsYXN0IGRpc2Fi
bGVkIGF0ICg2MDMzKTogWzxmZmZmODAwMDEyNDVlMTg4Pl0gX19lbDFfaXJxIGFyY2gvYXJtNjQv
a2VybmVsL2VudHJ5LWNvbW1vbi5jOjQ2OCBbaW5saW5lXQo+IGhhcmRpcnFzIGxhc3QgZGlzYWJs
ZWQgYXQgKDYwMzMpOiBbPGZmZmY4MDAwMTI0NWUxODg+XSBlbDFfaW50ZXJydXB0KzB4MjQvMHg2
OCBhcmNoL2FybTY0L2tlcm5lbC9lbnRyeS1jb21tb24uYzo0ODYKPiBzb2Z0aXJxcyBsYXN0ICBl
bmFibGVkIGF0ICg2MTYpOiBbPGZmZmY4MDAwMTA2NmNhODA+XSBzcGluX3VubG9ja19iaCBpbmNs
dWRlL2xpbnV4L3NwaW5sb2NrLmg6Mzk1IFtpbmxpbmVdCj4gc29mdGlycXMgbGFzdCAgZW5hYmxl
ZCBhdCAoNjE2KTogWzxmZmZmODAwMDEwNjZjYTgwPl0gbG9ja19zb2NrX25lc3RlZCsweGU4LzB4
MTM4IG5ldC9jb3JlL3NvY2suYzozNDgwCj4gc29mdGlycXMgbGFzdCBkaXNhYmxlZCBhdCAoNjE4
KTogWzxmZmZmODAwMDEyMmRiY2ZjPl0gc3Bpbl9sb2NrX2JoIGluY2x1ZGUvbGludXgvc3Bpbmxv
Y2suaDozNTUgW2lubGluZV0KPiBzb2Z0aXJxcyBsYXN0IGRpc2FibGVkIGF0ICg2MTgpOiBbPGZm
ZmY4MDAwMTIyZGJjZmM+XSB2aXJ0aW9fdHJhbnNwb3J0X3B1cmdlX3NrYnMrMHgxMWMvMHg1MDAg
bmV0L3Ztd192c29jay92aXJ0aW9fdHJhbnNwb3J0X2NvbW1vbi5jOjEzNzIKPiBDUFU6IDAgUElE
OiA2NzQ3IENvbW06IHN5ei1leGVjdXRvcjI0NCBOb3QgdGFpbnRlZCA2LjMuMC1yYzEtc3l6a2Fs
bGVyLWdmZTE1YzI2ZWUyNmUgIzAKPiBIYXJkd2FyZSBuYW1lOiBHb29nbGUgR29vZ2xlIENvbXB1
dGUgRW5naW5lL0dvb2dsZSBDb21wdXRlIEVuZ2luZSwgQklPUyBHb29nbGUgMDMvMDIvMjAyMwo+
IHBzdGF0ZTogODA0MDAwMDUgKE56Y3YgZGFpZiArUEFOIC1VQU8gLVRDTyAtRElUIC1TU0JTIEJU
WVBFPS0tKQo+IHBjIDogX19zYW5pdGl6ZXJfY292X3RyYWNlX3BjKzB4Yy8weDhjIGtlcm5lbC9r
Y292LmM6MjAzCj4gbHIgOiB2aXJ0aW9fdHJhbnNwb3J0X3B1cmdlX3NrYnMrMHgxOWMvMHg1MDAg
bmV0L3Ztd192c29jay92aXJ0aW9fdHJhbnNwb3J0X2NvbW1vbi5jOjEzNzQKPiBzcCA6IGZmZmY4
MDAwMWU3ODc4OTAKPiB4Mjk6IGZmZmY4MDAwMWU3ODc5ZTAgeDI4OiAxZmZmZjAwMDAzY2YwZjJh
IHgyNzogZmZmZjgwMDAxYTQ4N2E2MAo+IHgyNjogZmZmZjgwMDAxZTc4Nzk1MCB4MjU6IGZmZmYw
MDAwY2UyZDNiODAgeDI0OiBmZmZmODAwMDFhNDg3YTc4Cj4geDIzOiAxZmZmZjAwMDAzNDkwZjRj
IHgyMjogZmZmZjgwMDAxYTI5YzFhOCB4MjE6IGRmZmY4MDAwMDAwMDAwMDAKPiB4MjA6IGZmZmY4
MDAwMWE0ODdhNjAgeDE5OiBmZmZmODAwMDFlNzg3OTQwIHgxODogMWZmZmUwMDAzNjg5NTFiNgo+
IHgxNzogZmZmZjgwMDAxNWNkZDAwMCB4MTY6IGZmZmY4MDAwMDg1MTEwYjAgeDE1OiAwMDAwMDAw
MDAwMDAwMDAwCj4geDE0OiAxZmZmZjAwMDAyYjljMGIyIHgxMzogZGZmZjgwMDAwMDAwMDAwMCB4
MTI6IGZmZmY3MDAwMDNjZjBlZmMKPiB4MTE6IGZmODA4MDAwMTIyZGJlZTggeDEwOiAwMDAwMDAw
MDAwMDAwMDAwIHg5IDogZmZmZjgwMDAxMjJkYmVlOAo+IHg4IDogZmZmZjAwMDBjZTUxMWI0MCB4
NyA6IGZmZmY4MDAwMTIyZGJjZmMgeDYgOiAwMDAwMDAwMDAwMDAwMDAwCj4geDUgOiAwMDAwMDAw
MDAwMDAwMDAwIHg0IDogMDAwMDAwMDAwMDAwMDAwMSB4MyA6IGZmZmY4MDAwMDgzMmQ3NTgKPiB4
MiA6IDAwMDAwMDAwMDAwMDAwMDEgeDEgOiAwMDAwMDAwMDAwMDAwMDAwIHgwIDogMDAwMDAwMDAw
MDAwMDAwMAo+IENhbGwgdHJhY2U6Cj4gIGdldF9jdXJyZW50IGFyY2gvYXJtNjQvaW5jbHVkZS9h
c20vY3VycmVudC5oOjE5IFtpbmxpbmVdCj4gIF9fc2FuaXRpemVyX2Nvdl90cmFjZV9wYysweGMv
MHg4YyBrZXJuZWwva2Nvdi5jOjIwNgo+ICB2c29ja19sb29wYmFja19jYW5jZWxfcGt0KzB4Mjgv
MHgzYyBuZXQvdm13X3Zzb2NrL3Zzb2NrX2xvb3BiYWNrLmM6NDgKPiAgdnNvY2tfdHJhbnNwb3J0
X2NhbmNlbF9wa3QgbmV0L3Ztd192c29jay9hZl92c29jay5jOjEyODQgW2lubGluZV0KPiAgdnNv
Y2tfY29ubmVjdCsweDZiOC8weGFlYyBuZXQvdm13X3Zzb2NrL2FmX3Zzb2NrLmM6MTQyNgo+ICBf
X3N5c19jb25uZWN0X2ZpbGUgbmV0L3NvY2tldC5jOjIwMDQgW2lubGluZV0KPiAgX19zeXNfY29u
bmVjdCsweDI2OC8weDI5MCBuZXQvc29ja2V0LmM6MjAyMQo+ICBfX2RvX3N5c19jb25uZWN0IG5l
dC9zb2NrZXQuYzoyMDMxIFtpbmxpbmVdCj4gIF9fc2Vfc3lzX2Nvbm5lY3QgbmV0L3NvY2tldC5j
OjIwMjggW2lubGluZV0KPiAgX19hcm02NF9zeXNfY29ubmVjdCsweDdjLzB4OTQgbmV0L3NvY2tl
dC5jOjIwMjgKPiAgX19pbnZva2Vfc3lzY2FsbCBhcmNoL2FybTY0L2tlcm5lbC9zeXNjYWxsLmM6
MzggW2lubGluZV0KPiAgaW52b2tlX3N5c2NhbGwrMHg5OC8weDJjMCBhcmNoL2FybTY0L2tlcm5l
bC9zeXNjYWxsLmM6NTIKPiAgZWwwX3N2Y19jb21tb24rMHgxMzgvMHgyNTggYXJjaC9hcm02NC9r
ZXJuZWwvc3lzY2FsbC5jOjE0Mgo+ICBkb19lbDBfc3ZjKzB4NjQvMHgxOTggYXJjaC9hcm02NC9r
ZXJuZWwvc3lzY2FsbC5jOjE5Mwo+ICBlbDBfc3ZjKzB4NTgvMHgxNjggYXJjaC9hcm02NC9rZXJu
ZWwvZW50cnktY29tbW9uLmM6NjM3Cj4gIGVsMHRfNjRfc3luY19oYW5kbGVyKzB4ODQvMHhmMCBh
cmNoL2FybTY0L2tlcm5lbC9lbnRyeS1jb21tb24uYzo2NTUKPiAgZWwwdF82NF9zeW5jKzB4MTkw
LzB4MTk0IGFyY2gvYXJtNjQva2VybmVsL2VudHJ5LlM6NTkxCj4KPgo+IC0tLQo+IFRoaXMgcmVw
b3J0IGlzIGdlbmVyYXRlZCBieSBhIGJvdC4gSXQgbWF5IGNvbnRhaW4gZXJyb3JzLgo+IFNlZSBo
dHRwczovL2dvby5nbC90cHNtRUogZm9yIG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgc3l6Ym90Lgo+
IHN5emJvdCBlbmdpbmVlcnMgY2FuIGJlIHJlYWNoZWQgYXQgc3l6a2FsbGVyQGdvb2dsZWdyb3Vw
cy5jb20uCj4KPiBzeXpib3Qgd2lsbCBrZWVwIHRyYWNrIG9mIHRoaXMgaXNzdWUuIFNlZToKPiBo
dHRwczovL2dvby5nbC90cHNtRUojc3RhdHVzIGZvciBob3cgdG8gY29tbXVuaWNhdGUgd2l0aCBz
eXpib3QuCj4gc3l6Ym90IGNhbiB0ZXN0IHBhdGNoZXMgZm9yIHRoaXMgaXNzdWUsIGZvciBkZXRh
aWxzIHNlZToKPiBodHRwczovL2dvby5nbC90cHNtRUojdGVzdGluZy1wYXRjaGVzCj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
