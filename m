Return-Path: <SRS0=fQeB=ET=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376DFC388F7
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 17:26:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF89F20A8B
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 17:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="atiEmWMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF89F20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 626C6876FC;
	Fri, 13 Nov 2020 17:26:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oxn-+36CWWvk; Fri, 13 Nov 2020 17:26:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 306BA875D8;
	Fri, 13 Nov 2020 17:26:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10083C088E;
	Fri, 13 Nov 2020 17:26:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6E43C0800
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 17:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8E225875B5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 17:26:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a0ONicseNbmd
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 17:26:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7D09D875B1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 17:26:31 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id r17so10795041wrw.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 09:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=I6d3jSkC1hU0cnS7i864/TOOI7vCdKCw/L4z/MuHQVA=;
 b=atiEmWMBKI1b2ZuktbWSBqA97QxTaEtHG30JijdkfiCQmQbGE9lxAkM8dT81lStT4x
 mmnjX/YymLL7WYY57bpBgLP4uwc7xmQqTJ86zT2I1ssRIRaA5+PGBoBPGB/Ua9TwR+VZ
 SPYOHtm7tOoBxHUOL4GwUb2dWvq9RzguY99VSQT4GySm+6YvAV1jAL4zOeXege6tMUhc
 Po+Jy4I2DDjW3+RR9oBUMw6FWR/GE7oav3mTxVuDmO5qVDxHu1SSvtjgqZ1kvnyvz4VK
 nThEDvugrfTaJUKGiFXl/V/ZqXy781cS5Gmt2gVcc3E/DlsxQuHpBvyon9okjiK0XkzD
 CxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=I6d3jSkC1hU0cnS7i864/TOOI7vCdKCw/L4z/MuHQVA=;
 b=C9uhpPFUxp4mCGD/xDEeaKEOAlyaq+4ijiFJzR+NPtGWkUvaW951OyXHU7vwvq8ar3
 pPj/7LvkQVNujJvfCEp27viHIx2oRW88o0OtTLAI4YvGyMeGB80vvkYmFv/zmntY1Bpo
 imzo2bfvf/JfyVn53IP50ZWLI8pec5B0yTkFqGjxN7Hb3NKGoTmGsJjbIYVe1SHWdy9/
 xnwKAgmMz5geClKuo6rca9wnGPUZliHI5XDSPYHITSBeXGc8Elyftwg7xddi80XhYnB0
 zkeT8LYgWccMeYhjd5axUH4miT1EBeoMGwQ+7h0suQyz3St+CUBW4QXBhwBh2wGRWuwv
 pRZQ==
X-Gm-Message-State: AOAM533S+wwEm67L7c0Qhd+e1KvfxjtMhgf5+itiCOQsQGPlsEBBRIrP
 2lHSE86ClSz9+ZX87OGTfnQR44iRH7hL5qEii8HQwg==
X-Google-Smtp-Source: ABdhPJwwP1Ogqs1X8VRzF4U6XH4gVvhlkQoEjKS9TCHNsCoKz5A9oZAr+Y5MU+DLHxTN/saHAMAvN8BNp8DxHgpD8AA=
X-Received: by 2002:adf:e60e:: with SMTP id p14mr4953570wrm.188.1605288387711; 
 Fri, 13 Nov 2020 09:26:27 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 13 Nov 2020 18:26:16 +0100
Message-ID: <CAG_fn=WwQ29akxY1Eq=N_=HCF3t7z+T2obh9aRVUDFy1FSA3-Q@mail.gmail.com>
Subject: Use of uninitialized memory with CONFIG_HW_RANDOM_VIRTIO
To: akong@redhat.com, rusty@rustcorp.com.au, 
 "Michael S. Tsirkin" <mst@redhat.com>, amit@kernel.org
Cc: syzkaller <syzkaller@googlegroups.com>, Dmitriy Vyukov <dvyukov@google.com>,
 virtualization@lists.linux-foundation.org
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
From: Alexander Potapenko via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SGkgQW1vcywgUnVzdHksIEFtaXQsIE1pY2hhZWwsCgpJIGFtIGhpdHRpbmcgc29tZXRoaW5nIHRo
YXQgSSBiZWxpZXZlIHRvIGJlIGEgbWlub3IgcHJvYmxlbSBpbiB0aGUKdmlydGlvIFJORyBkcml2
ZXIuCldoZW4gcnVubmluZyB0aGUga2VybmVsIHVuZGVyIEtNU0FOIHdpdGggIi1kZXZpY2Ugdmly
dGlvLXJuZy1wY2kiCnBhc3NlZCB0byBRRU1VLCBJIGFtIHNlZWluZyByZXBvcnRzIGFib3V0IHJu
Z19maWxsYnVmIGluCmRyaXZlcnMvY2hhci9od19yYW5kb20vY29yZS5jIGJlaW5nIHVzZWQgYmVm
b3JlIGluaXRpYWxpemF0aW9uIChzZWUKdGhlIHJlcG9ydCBiZWxvdykuCgpUaGlzIGNhbiBiZSB2
ZXJpZmllZCBieSBpbml0aWFsaXppbmcgcm5nX2ZpbGxidWYgd2l0aCAnQScgYXMgZm9sbG93czoK
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CmRpZmYgLS1naXQgYS9k
cml2ZXJzL2NoYXIvaHdfcmFuZG9tL2NvcmUuYyBiL2RyaXZlcnMvY2hhci9od19yYW5kb20vY29y
ZS5jCmluZGV4IDhjMWM0N2RkOWY0Ni4uNDRkNjA5YTU3OTZhIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2NoYXIvaHdfcmFuZG9tL2NvcmUuYworKysgYi9kcml2ZXJzL2NoYXIvaHdfcmFuZG9tL2NvcmUu
YwpAQCAtNDM5LDggKzQzOSwxMSBAQCBzdGF0aWMgaW50IGh3cm5nX2ZpbGxmbih2b2lkICp1bnVz
ZWQpCiAgICAgICAgICAgICAgICBpZiAoSVNfRVJSKHJuZykgfHwgIXJuZykKICAgICAgICAgICAg
ICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgICAgICAgICBtdXRleF9sb2NrKCZyZWFkaW5nX211
dGV4KTsKKyAgICAgICAgICAgICAgIG1lbXNldChybmdfZmlsbGJ1ZiwgJ0EnLCBybmdfYnVmZmVy
X3NpemUoKSk7CisgICAgICAgICAgICAgICBybmdfZmlsbGJ1ZltybmdfYnVmZmVyX3NpemUoKS0x
XSA9IDA7CiAgICAgICAgICAgICAgICByYyA9IHJuZ19nZXRfZGF0YShybmcsIHJuZ19maWxsYnVm
LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcm5nX2J1ZmZlcl9zaXplKCksIDEp
OworICAgICAgICAgICAgICAgcHJfZXJyKCJybmdfZmlsbGJ1ZjogJXNcbiIsIHJuZ19maWxsYnVm
KTsKICAgICAgICAgICAgICAgIG11dGV4X3VubG9jaygmcmVhZGluZ19tdXRleCk7CiAgICAgICAg
ICAgICAgICBwdXRfcm5nKHJuZyk7CiAgICAgICAgICAgICAgICBpZiAocmMgPD0gMCkgewo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KCmFuZCBib290aW5nIHRoZSBr
ZXJuZWw6IHRoZSBmaXJzdCBjYWxsIG9mIGh3cm5nX2ZpbGxmbigpIHdpbGwgcHJpbnQKIkFBQUFB
QUEuLiIgaW5zdGVhZCBvZiByYW5kb20gZGF0YS4KCkZvciBzb21lIHJlYXNvbiBvbiB0aGF0IGZp
cnN0IGl0ZXJhdGlvbiB2aS0+YnVzeSBpcyB0cnVlIGhlcmU6Cmh0dHBzOi8vZWxpeGlyLmJvb3Rs
aW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvZHJpdmVycy9jaGFyL2h3X3JhbmRvbS92aXJ0aW8t
cm5nLmMjTDYyLAp0aGVyZWZvcmUgdGhlIGJ1ZmZlciBpcyBub3QgYmVpbmcgc2VudCB0byB2aXJ0
aW8gcmluZy4KCldoaWxlIHByb2JhYmx5IGJlaW5nIGJlbmlnbiwgdGhpcyBidWcgaXMgcHJldmVu
dGluZyBzeXprYWxsZXIgZnJvbQpmaW5kaW5nIG1vcmUgYnVncywgc28gaXQgd291bGQgYmUgbmlj
ZSB0byBmaXggaXQuClBlcmhhcHMgdGhlIGVhc2llc3Qgc29sdXRpb24gaXMgdG8ga3phbGxvYyBy
bmdfZmlsbGJ1ZiwgYnV0IGlmIGl0J3MKY3JpdGljYWwgZm9yIHRoaXMgZHJpdmVyIHRvIG5vdCBz
a2lwIGV2ZW4gdGhlIGZpcnN0IHJlYWQsIHRoZW4gbWF5YmUKeW91IGhhdmUgYmV0dGVyIGlkZWFz
PwoKS01TQU4gcmVwb3J0IGZvbGxvd3M6Cgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQpCVUc6IEtNU0FOOiB1bmluaXQtdmFsdWUgaW4gX21peF9w
b29sX2J5dGVzKzB4N2QyLzB4OTUwCmRyaXZlcnMvY2hhci9yYW5kb20uYzo1NzAKQ1BVOiAwIFBJ
RDogMjcxMSBDb21tOiBod3JuZyBOb3QgdGFpbnRlZCA1LjkuMC1yYzgtc3l6a2FsbGVyICMwCkhh
cmR3YXJlIG5hbWU6IEdvb2dsZSBHb29nbGUgQ29tcHV0ZSBFbmdpbmUvR29vZ2xlIENvbXB1dGUg
RW5naW5lLApCSU9TIEdvb2dsZSAwMS8wMS8yMDExCkNhbGwgVHJhY2U6CiBfX2R1bXBfc3RhY2sg
bGliL2R1bXBfc3RhY2suYzo3NyBbaW5saW5lXQogZHVtcF9zdGFjaysweDIxYy8weDI4MCBsaWIv
ZHVtcF9zdGFjay5jOjExOAoga21zYW5fcmVwb3J0KzB4ZjcvMHgxZTAgbW0va21zYW4va21zYW5f
cmVwb3J0LmM6MTIyCiBfX21zYW5fd2FybmluZysweDVmLzB4YTAgbW0va21zYW4va21zYW5faW5z
dHIuYzoyMDEKIF9taXhfcG9vbF9ieXRlcysweDdkMi8weDk1MCBkcml2ZXJzL2NoYXIvcmFuZG9t
LmM6NTcwCiBtaXhfcG9vbF9ieXRlcysweGNhLzB4MmEwIGRyaXZlcnMvY2hhci9yYW5kb20uYzo1
OTkKIGFkZF9od2dlbmVyYXRvcl9yYW5kb21uZXNzKzB4NGFjLzB4NTAwIGRyaXZlcnMvY2hhci9y
YW5kb20uYzoyMzE5CiBod3JuZ19maWxsZm4rMHg2YWUvMHg5NDAgZHJpdmVycy9jaGFyL2h3X3Jh
bmRvbS9jb3JlLmM6NDUyCiBrdGhyZWFkKzB4NTFjLzB4NTYwIGtlcm5lbC9rdGhyZWFkLmM6Mjkz
CiByZXRfZnJvbV9mb3JrKzB4MWYvMHgzMCBhcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjI5NAoK
VW5pbml0IHdhcyBjcmVhdGVkIGF0Ogoga21zYW5fc2F2ZV9zdGFja193aXRoX2ZsYWdzIG1tL2tt
c2FuL2ttc2FuLmM6MTI5IFtpbmxpbmVdCiBrbXNhbl9pbnRlcm5hbF9wb2lzb25fc2hhZG93KzB4
NWMvMHhmMCBtbS9rbXNhbi9rbXNhbi5jOjExMgoga21zYW5fc2xhYl9hbGxvYysweDhkLzB4ZTAg
bW0va21zYW4va21zYW5faG9va3MuYzo4MAogc2xhYl9hbGxvY19ub2RlIG1tL3NsdWIuYzoyOTAz
IFtpbmxpbmVdCiBzbGFiX2FsbG9jIG1tL3NsdWIuYzoyOTEyIFtpbmxpbmVdCiBrbWVtX2NhY2hl
X2FsbG9jX3RyYWNlKzB4NjFlLzB4YzkwIG1tL3NsdWIuYzoyOTI5CiBrbWFsbG9jIGluY2x1ZGUv
bGludXgvc2xhYi5oOjU1NCBbaW5saW5lXQogaHdybmdfbW9kaW5pdCsweDEwMy8weDJlZiBkcml2
ZXJzL2NoYXIvaHdfcmFuZG9tL2NvcmUuYzo2MjEKIGRvX29uZV9pbml0Y2FsbCsweDM3MS8weDlj
MCBpbml0L21haW4uYzoxMjA4CiBkb19pbml0Y2FsbF9sZXZlbCsweDFlNS8weDNjNiBpbml0L21h
aW4uYzoxMjgxCiBkb19pbml0Y2FsbHMrMHgxMjcvMHgxY2IgaW5pdC9tYWluLmM6MTI5NwogZG9f
YmFzaWNfc2V0dXArMHgzMy8weDM2IGluaXQvbWFpbi5jOjEzMTcKIGtlcm5lbF9pbml0X2ZyZWVh
YmxlKzB4MjM4LzB4MzhiIGluaXQvbWFpbi5jOjE1MTcKIGtlcm5lbF9pbml0KzB4MWYvMHg4NDAg
aW5pdC9tYWluLmM6MTQwNgogcmV0X2Zyb21fZm9yaysweDFmLzB4MzAgYXJjaC94ODYvZW50cnkv
ZW50cnlfNjQuUzoyOTQKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0KClRoYW5rcywKQWxleAoKLS0gCkFsZXhhbmRlciBQb3RhcGVua28KU29mdHdh
cmUgRW5naW5lZXIKCkdvb2dsZSBHZXJtYW55IEdtYkgKRXJpa2EtTWFubi1TdHJhw59lLCAzMwo4
MDYzNiBNw7xuY2hlbgoKR2VzY2jDpGZ0c2bDvGhyZXI6IFBhdWwgTWFuaWNsZSwgSGFsaW1haCBE
ZUxhaW5lIFByYWRvClJlZ2lzdGVyZ2VyaWNodCB1bmQgLW51bW1lcjogSGFtYnVyZywgSFJCIDg2
ODkxClNpdHogZGVyIEdlc2VsbHNjaGFmdDogSGFtYnVyZwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
