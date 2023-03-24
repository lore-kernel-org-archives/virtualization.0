Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DA2C6FD20
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 15:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E76A80BE6;
	Fri, 24 Mar 2023 15:33:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E76A80BE6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AeOGusE0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vj8h-9mwo_Jt; Fri, 24 Mar 2023 15:33:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8201880B7D;
	Fri, 24 Mar 2023 15:33:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8201880B7D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E7ACC0035;
	Fri, 24 Mar 2023 15:33:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5C23C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AF8B54016C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:33:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AF8B54016C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AeOGusE0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QLK1PJ-q-RvW
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:33:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B42D400B8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9B42D400B8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679672001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nwmpDcIRdezP7czdw9rZEPq2A0ddkt+6nhj7OJ5xz8=;
 b=AeOGusE0s1vTZSw3mQMxrC2CLvCMxxlqfP2oGNLl0/E6uWM+OA8GCz24ZKc0pdQlzy8oJA
 ibmbuoFSx/DZJRX19A/uZ9GetrgDXSr0oRVNx77ZGqQD0t/FTOp+ZX5kUlWo8IsUPguFaJ
 jHKzU3oeA+leXww77NMMrlMq2dwePuk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-YuDzT8eUNB2RXM5AYaMFGg-1; Fri, 24 Mar 2023 11:33:20 -0400
X-MC-Unique: YuDzT8eUNB2RXM5AYaMFGg-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5458dde029bso22184687b3.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 08:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679671997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1nwmpDcIRdezP7czdw9rZEPq2A0ddkt+6nhj7OJ5xz8=;
 b=DwXtivC9cJ2TPNRFk18P2BwlHQ/JtYaw+P6J2vqFxrxYlMTuX+dIpw22tQbwsbJ4wg
 MS2lE7hoFYB+t+YH4djiyxIrB7dBj59JUp9minuBI059yFg0GgkMgqAyp/yXSTNIXCBb
 QQS8NvtzWS1CCbdTBvNLZTZvSze48XrqogM0uGZVWct6HbLxsBU/L6Lvc1aNiu14SdRt
 98w5yKSi7Drw6stEBhIhcLEVU+dBiid0drDbTzM9awZ6AhyRcndjtWVx1Is6rUW7/1vs
 FFNVaRouGqxipF+VDLwXJspHuSnO9Sc0jsIDRu3MIe4uU9Prk/mkPyQ/8HCXvEs9DSVe
 LVqg==
X-Gm-Message-State: AAQBX9ev3tyccVvr4xEOm+O3YEx6FnLrcBa97jtU3xcROIhikwJ4DUqR
 7pBegZvkhD218h/3d0RoYGJHhwU3iyr81SKosQfmrWRidaQM9z+OsDOOqJQ+qCeiimWW4MCg42Y
 dV+ftCmvQHyg9qVUH0iff9PPQC5EAy34yVvLUFsUv/57JM/f47AccHYNtKA==
X-Received: by 2002:a05:690c:298d:b0:542:927b:1c79 with SMTP id
 eh13-20020a05690c298d00b00542927b1c79mr4493857ywb.3.1679671997282; 
 Fri, 24 Mar 2023 08:33:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350axSseOYGZVaoae4ffdh9HEDtW8lZ2RalvnCpXRfyuMSMHUSaaLIhse5Fh/4JSBAkJ+6QXkQ8DPJpDEIMOl87o=
X-Received: by 2002:a05:690c:298d:b0:542:927b:1c79 with SMTP id
 eh13-20020a05690c298d00b00542927b1c79mr4493846ywb.3.1679671997029; Fri, 24
 Mar 2023 08:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000075bebb05f79acfde@google.com>
In-Reply-To: <00000000000075bebb05f79acfde@google.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 24 Mar 2023 16:33:05 +0100
Message-ID: <CAGxU2F7L-EJAVwCivJ3MsY8E6w909ebWhz-s8qtP4NmN7h6gpQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] [virt?] [io-uring?] [kvm?] BUG: soft lockup in
 vsock_connect
To: syzbot <syzbot+0bc015ebddc291a97116@syzkaller.appspotmail.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Cc: axboe@kernel.dk, kvm@vger.kernel.org, netdev@vger.kernel.org,
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

I3N5eiBkdXAgZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0IGluIHZpcnRpb190cmFuc3BvcnRfcHVy
Z2Vfc2ticwoKT24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgMTo1MuKAr0FNIHN5emJvdAo8c3l6Ym90
KzBiYzAxNWViZGRjMjkxYTk3MTE2QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20+IHdyb3RlOgo+
Cj4gSGVsbG8sCj4KPiBzeXpib3QgZm91bmQgdGhlIGZvbGxvd2luZyBpc3N1ZSBvbjoKPgo+IEhF
QUQgY29tbWl0OiAgICBmZTE1YzI2ZWUyNmUgTGludXggNi4zLXJjMQo+IGdpdCB0cmVlOiAgICAg
ICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYXJtNjQvbGlu
dXguZ2l0IGZvci1rZXJuZWxjaQo+IGNvbnNvbGUgb3V0cHV0OiBodHRwczovL3N5emthbGxlci5h
cHBzcG90LmNvbS94L2xvZy50eHQ/eD0xNTc3Yzk3ZWM4MDAwMAo+IGtlcm5lbCBjb25maWc6ICBo
dHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94Ly5jb25maWc/eD03NTczY2JjZDg4MWE4OGM5
Cj4gZGFzaGJvYXJkIGxpbms6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRp
ZD0wYmMwMTVlYmRkYzI5MWE5NzExNgo+IGNvbXBpbGVyOiAgICAgICBEZWJpYW4gY2xhbmcgdmVy
c2lvbiAxNS4wLjcsIEdOVSBsZCAoR05VIEJpbnV0aWxzIGZvciBEZWJpYW4pIDIuMzUuMgo+IHVz
ZXJzcGFjZSBhcmNoOiBhcm02NAo+IHN5eiByZXBybzogICAgICBodHRwczovL3N5emthbGxlci5h
cHBzcG90LmNvbS94L3JlcHJvLnN5ej94PTEwNzdjOTk2YzgwMDAwCj4gQyByZXByb2R1Y2VyOiAg
IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVwcm8uYz94PTE3ZTM4OTI5YzgwMDAw
Cj4KPiBEb3dubG9hZGFibGUgYXNzZXRzOgo+IGRpc2sgaW1hZ2U6IGh0dHBzOi8vc3RvcmFnZS5n
b29nbGVhcGlzLmNvbS9zeXpib3QtYXNzZXRzLzg5ZDQxYWJkMDdiZC9kaXNrLWZlMTVjMjZlLnJh
dy54ego+IHZtbGludXg6IGh0dHBzOi8vc3RvcmFnZS5nb29nbGVhcGlzLmNvbS9zeXpib3QtYXNz
ZXRzL2ZhNzVmNTAzMGFkZS92bWxpbnV4LWZlMTVjMjZlLnh6Cj4ga2VybmVsIGltYWdlOiBodHRw
czovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vc3l6Ym90LWFzc2V0cy81OTBkMGY1OTAzZWUvSW1h
Z2UtZmUxNWMyNmUuZ3oueHoKPgo+IElNUE9SVEFOVDogaWYgeW91IGZpeCB0aGUgaXNzdWUsIHBs
ZWFzZSBhZGQgdGhlIGZvbGxvd2luZyB0YWcgdG8gdGhlIGNvbW1pdDoKPiBSZXBvcnRlZC1ieTog
c3l6Ym90KzBiYzAxNWViZGRjMjkxYTk3MTE2QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KPgo+
IHdhdGNoZG9nOiBCVUc6IHNvZnQgbG9ja3VwIC0gQ1BVIzAgc3R1Y2sgZm9yIDI3cyEgW3N5ei1l
eGVjdXRvcjI0NDo2NzQ3XQo+IE1vZHVsZXMgbGlua2VkIGluOgo+IGlycSBldmVudCBzdGFtcDog
NjAzMwo+IGhhcmRpcnFzIGxhc3QgIGVuYWJsZWQgYXQgKDYwMzIpOiBbPGZmZmY4MDAwMTI0NjA0
YWM+XSBfX2V4aXRfdG9fa2VybmVsX21vZGUgYXJjaC9hcm02NC9rZXJuZWwvZW50cnktY29tbW9u
LmM6ODQgW2lubGluZV0KPiBoYXJkaXJxcyBsYXN0ICBlbmFibGVkIGF0ICg2MDMyKTogWzxmZmZm
ODAwMDEyNDYwNGFjPl0gZXhpdF90b19rZXJuZWxfbW9kZSsweGU4LzB4MTE4IGFyY2gvYXJtNjQv
a2VybmVsL2VudHJ5LWNvbW1vbi5jOjk0Cj4gaGFyZGlycXMgbGFzdCBkaXNhYmxlZCBhdCAoNjAz
Myk6IFs8ZmZmZjgwMDAxMjQ1ZTE4OD5dIF9fZWwxX2lycSBhcmNoL2FybTY0L2tlcm5lbC9lbnRy
eS1jb21tb24uYzo0NjggW2lubGluZV0KPiBoYXJkaXJxcyBsYXN0IGRpc2FibGVkIGF0ICg2MDMz
KTogWzxmZmZmODAwMDEyNDVlMTg4Pl0gZWwxX2ludGVycnVwdCsweDI0LzB4NjggYXJjaC9hcm02
NC9rZXJuZWwvZW50cnktY29tbW9uLmM6NDg2Cj4gc29mdGlycXMgbGFzdCAgZW5hYmxlZCBhdCAo
NjE2KTogWzxmZmZmODAwMDEwNjZjYTgwPl0gc3Bpbl91bmxvY2tfYmggaW5jbHVkZS9saW51eC9z
cGlubG9jay5oOjM5NSBbaW5saW5lXQo+IHNvZnRpcnFzIGxhc3QgIGVuYWJsZWQgYXQgKDYxNik6
IFs8ZmZmZjgwMDAxMDY2Y2E4MD5dIGxvY2tfc29ja19uZXN0ZWQrMHhlOC8weDEzOCBuZXQvY29y
ZS9zb2NrLmM6MzQ4MAo+IHNvZnRpcnFzIGxhc3QgZGlzYWJsZWQgYXQgKDYxOCk6IFs8ZmZmZjgw
MDAxMjJkYmNmYz5dIHNwaW5fbG9ja19iaCBpbmNsdWRlL2xpbnV4L3NwaW5sb2NrLmg6MzU1IFtp
bmxpbmVdCj4gc29mdGlycXMgbGFzdCBkaXNhYmxlZCBhdCAoNjE4KTogWzxmZmZmODAwMDEyMmRi
Y2ZjPl0gdmlydGlvX3RyYW5zcG9ydF9wdXJnZV9za2JzKzB4MTFjLzB4NTAwIG5ldC92bXdfdnNv
Y2svdmlydGlvX3RyYW5zcG9ydF9jb21tb24uYzoxMzcyCj4gQ1BVOiAwIFBJRDogNjc0NyBDb21t
OiBzeXotZXhlY3V0b3IyNDQgTm90IHRhaW50ZWQgNi4zLjAtcmMxLXN5emthbGxlci1nZmUxNWMy
NmVlMjZlICMwCj4gSGFyZHdhcmUgbmFtZTogR29vZ2xlIEdvb2dsZSBDb21wdXRlIEVuZ2luZS9H
b29nbGUgQ29tcHV0ZSBFbmdpbmUsIEJJT1MgR29vZ2xlIDAzLzAyLzIwMjMKPiBwc3RhdGU6IDgw
NDAwMDA1IChOemN2IGRhaWYgK1BBTiAtVUFPIC1UQ08gLURJVCAtU1NCUyBCVFlQRT0tLSkKPiBw
YyA6IF9fc2FuaXRpemVyX2Nvdl90cmFjZV9wYysweGMvMHg4YyBrZXJuZWwva2Nvdi5jOjIwMwo+
IGxyIDogdmlydGlvX3RyYW5zcG9ydF9wdXJnZV9za2JzKzB4MTljLzB4NTAwIG5ldC92bXdfdnNv
Y2svdmlydGlvX3RyYW5zcG9ydF9jb21tb24uYzoxMzc0Cj4gc3AgOiBmZmZmODAwMDFlNzg3ODkw
Cj4geDI5OiBmZmZmODAwMDFlNzg3OWUwIHgyODogMWZmZmYwMDAwM2NmMGYyYSB4Mjc6IGZmZmY4
MDAwMWE0ODdhNjAKPiB4MjY6IGZmZmY4MDAwMWU3ODc5NTAgeDI1OiBmZmZmMDAwMGNlMmQzYjgw
IHgyNDogZmZmZjgwMDAxYTQ4N2E3OAo+IHgyMzogMWZmZmYwMDAwMzQ5MGY0YyB4MjI6IGZmZmY4
MDAwMWEyOWMxYTggeDIxOiBkZmZmODAwMDAwMDAwMDAwCj4geDIwOiBmZmZmODAwMDFhNDg3YTYw
IHgxOTogZmZmZjgwMDAxZTc4Nzk0MCB4MTg6IDFmZmZlMDAwMzY4OTUxYjYKPiB4MTc6IGZmZmY4
MDAwMTVjZGQwMDAgeDE2OiBmZmZmODAwMDA4NTExMGIwIHgxNTogMDAwMDAwMDAwMDAwMDAwMAo+
IHgxNDogMWZmZmYwMDAwMmI5YzBiMiB4MTM6IGRmZmY4MDAwMDAwMDAwMDAgeDEyOiBmZmZmNzAw
MDAzY2YwZWZjCj4geDExOiBmZjgwODAwMDEyMmRiZWU4IHgxMDogMDAwMDAwMDAwMDAwMDAwMCB4
OSA6IGZmZmY4MDAwMTIyZGJlZTgKPiB4OCA6IGZmZmYwMDAwY2U1MTFiNDAgeDcgOiBmZmZmODAw
MDEyMmRiY2ZjIHg2IDogMDAwMDAwMDAwMDAwMDAwMAo+IHg1IDogMDAwMDAwMDAwMDAwMDAwMCB4
NCA6IDAwMDAwMDAwMDAwMDAwMDEgeDMgOiBmZmZmODAwMDA4MzJkNzU4Cj4geDIgOiAwMDAwMDAw
MDAwMDAwMDAxIHgxIDogMDAwMDAwMDAwMDAwMDAwMCB4MCA6IDAwMDAwMDAwMDAwMDAwMDAKPiBD
YWxsIHRyYWNlOgo+ICBnZXRfY3VycmVudCBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL2N1cnJlbnQu
aDoxOSBbaW5saW5lXQo+ICBfX3Nhbml0aXplcl9jb3ZfdHJhY2VfcGMrMHhjLzB4OGMga2VybmVs
L2tjb3YuYzoyMDYKPiAgdnNvY2tfbG9vcGJhY2tfY2FuY2VsX3BrdCsweDI4LzB4M2MgbmV0L3Zt
d192c29jay92c29ja19sb29wYmFjay5jOjQ4Cj4gIHZzb2NrX3RyYW5zcG9ydF9jYW5jZWxfcGt0
IG5ldC92bXdfdnNvY2svYWZfdnNvY2suYzoxMjg0IFtpbmxpbmVdCj4gIHZzb2NrX2Nvbm5lY3Qr
MHg2YjgvMHhhZWMgbmV0L3Ztd192c29jay9hZl92c29jay5jOjE0MjYKPiAgX19zeXNfY29ubmVj
dF9maWxlIG5ldC9zb2NrZXQuYzoyMDA0IFtpbmxpbmVdCj4gIF9fc3lzX2Nvbm5lY3QrMHgyNjgv
MHgyOTAgbmV0L3NvY2tldC5jOjIwMjEKPiAgX19kb19zeXNfY29ubmVjdCBuZXQvc29ja2V0LmM6
MjAzMSBbaW5saW5lXQo+ICBfX3NlX3N5c19jb25uZWN0IG5ldC9zb2NrZXQuYzoyMDI4IFtpbmxp
bmVdCj4gIF9fYXJtNjRfc3lzX2Nvbm5lY3QrMHg3Yy8weDk0IG5ldC9zb2NrZXQuYzoyMDI4Cj4g
IF9faW52b2tlX3N5c2NhbGwgYXJjaC9hcm02NC9rZXJuZWwvc3lzY2FsbC5jOjM4IFtpbmxpbmVd
Cj4gIGludm9rZV9zeXNjYWxsKzB4OTgvMHgyYzAgYXJjaC9hcm02NC9rZXJuZWwvc3lzY2FsbC5j
OjUyCj4gIGVsMF9zdmNfY29tbW9uKzB4MTM4LzB4MjU4IGFyY2gvYXJtNjQva2VybmVsL3N5c2Nh
bGwuYzoxNDIKPiAgZG9fZWwwX3N2YysweDY0LzB4MTk4IGFyY2gvYXJtNjQva2VybmVsL3N5c2Nh
bGwuYzoxOTMKPiAgZWwwX3N2YysweDU4LzB4MTY4IGFyY2gvYXJtNjQva2VybmVsL2VudHJ5LWNv
bW1vbi5jOjYzNwo+ICBlbDB0XzY0X3N5bmNfaGFuZGxlcisweDg0LzB4ZjAgYXJjaC9hcm02NC9r
ZXJuZWwvZW50cnktY29tbW9uLmM6NjU1Cj4gIGVsMHRfNjRfc3luYysweDE5MC8weDE5NCBhcmNo
L2FybTY0L2tlcm5lbC9lbnRyeS5TOjU5MQo+Cj4KPiAtLS0KPiBUaGlzIHJlcG9ydCBpcyBnZW5l
cmF0ZWQgYnkgYSBib3QuIEl0IG1heSBjb250YWluIGVycm9ycy4KPiBTZWUgaHR0cHM6Ly9nb28u
Z2wvdHBzbUVKIGZvciBtb3JlIGluZm9ybWF0aW9uIGFib3V0IHN5emJvdC4KPiBzeXpib3QgZW5n
aW5lZXJzIGNhbiBiZSByZWFjaGVkIGF0IHN5emthbGxlckBnb29nbGVncm91cHMuY29tLgo+Cj4g
c3l6Ym90IHdpbGwga2VlcCB0cmFjayBvZiB0aGlzIGlzc3VlLiBTZWU6Cj4gaHR0cHM6Ly9nb28u
Z2wvdHBzbUVKI3N0YXR1cyBmb3IgaG93IHRvIGNvbW11bmljYXRlIHdpdGggc3l6Ym90Lgo+IHN5
emJvdCBjYW4gdGVzdCBwYXRjaGVzIGZvciB0aGlzIGlzc3VlLCBmb3IgZGV0YWlscyBzZWU6Cj4g
aHR0cHM6Ly9nb28uZ2wvdHBzbUVKI3Rlc3RpbmctcGF0Y2hlcwo+CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
