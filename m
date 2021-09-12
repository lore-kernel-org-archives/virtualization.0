Return-Path: <SRS0=fv7C=OC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221ACC433EF
	for <virtualization@archiver.kernel.org>; Sun, 12 Sep 2021 17:06:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9158A60FE3
	for <virtualization@archiver.kernel.org>; Sun, 12 Sep 2021 17:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9158A60FE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 465AD60639;
	Sun, 12 Sep 2021 17:06:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wWA5zFDP80iQ; Sun, 12 Sep 2021 17:06:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AC99E605F5;
	Sun, 12 Sep 2021 17:06:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8459AC000F;
	Sun, 12 Sep 2021 17:06:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 877F7C000D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 17:06:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E46260609
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 17:06:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pWV7M_PRCN15
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 17:06:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E077605F5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 17:06:37 +0000 (UTC)
Received: by mail-qk1-x72b.google.com with SMTP id t4so7992048qkb.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Yc8/eVDLWuaLuu6jQN/20x4CRwpCukX6gU/dh4RDWB4=;
 b=oktCZBmzHLqgmGGbwKkFfLmxdM4yW7NiY2sJ/qCurPbVAdSvdHAXCwATIdehSnvB3y
 ppqDJ9BrXMwr1P4Jw5xrknYSHShBQMPqWXjrbo23XM5temt7iOhFWY2Dim7lFnzDQDkJ
 DPq0+4rWwXLZj/T/6oyCOp6NzgTM47SBs5kiCbw0muo/YHD7PAqDheFvl1A74Kek8Hax
 d1BnNmHbJdm54KLK0GtVsWfC0FwiO3D1jTo+/kjqhU/+nMet3K87uLsCvQNu2ULNLeT5
 LKiokwIzusUCUEJQo7bnGch0xSKFLVtueOKEsWImGpOI3FgnjrtPBljCyksRcIxeT7Aa
 mn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Yc8/eVDLWuaLuu6jQN/20x4CRwpCukX6gU/dh4RDWB4=;
 b=wkKHKu5SsyfQ2C6i3eRoX6mWxYUvKfxhaj4BUDNQiTK1eUZ+KiLzWYjM+5OUF2++1H
 5ok3bY6f7k6H2/6z6b/ZGi+QKz7obk83J7eOZmlm0dsCilodOMd3/aZO78S+S9KQUfHv
 2/a/b/vyEdxjI/TcGZscT/68Ar7nvP/K3xhX6PSzAor3aeFvjVswnf+aOYwLNE9vaGHE
 M8+7NAxohd5l/x2nLVgW5V/0icr0HTbRi0rrzHqgKoHOAFSDpe01faDGh4FQ1is1Q2pV
 6pScYlKMyBRw04kLIgWaA4clj5Y8yWvJ00rxcYFE3psdTripahY2zIaICmBHUVheP86L
 aLzQ==
X-Gm-Message-State: AOAM532WFeQS9eD6TbiqXHHvo+Hy3X3ujsvLpUAfXvZ6Yr6bmtkE3F1b
 FzZkdnBs12ZljXqkYtNoSPaDj5v+dunRlSueBkHWwg==
X-Google-Smtp-Source: ABdhPJwKk0AK8jKkuwI/1IYJV+dt0j7bYScKgM819ls2GX672BYA89y9Ud/rre5G9nsysC/iv18YAsPk+tTyeovBJs4=
X-Received: by 2002:a37:8044:: with SMTP id b65mr6541700qkd.150.1631466395928; 
 Sun, 12 Sep 2021 10:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAG_fn=WwQ29akxY1Eq=N_=HCF3t7z+T2obh9aRVUDFy1FSA3-Q@mail.gmail.com>
 <20210819165742-mutt-send-email-mst@kernel.org>
 <d0d232ab-5222-5eef-60de-e8cc0f2a0791@redhat.com>
In-Reply-To: <d0d232ab-5222-5eef-60de-e8cc0f2a0791@redhat.com>
Date: Sun, 12 Sep 2021 19:05:59 +0200
Message-ID: <CAG_fn=Um3Up2VyGOC0ezJ51N8AWZfGcWz+98cvwpBrJkby3+NA@mail.gmail.com>
Subject: Re: Use of uninitialized memory with CONFIG_HW_RANDOM_VIRTIO
To: Laurent Vivier <lvivier@redhat.com>
Cc: amit@kernel.org, rusty@rustcorp.com.au,
 virtualization@lists.linux-foundation.org,
 syzkaller <syzkaller@googlegroups.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 akong@redhat.com, Dmitriy Vyukov <dvyukov@google.com>
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

SGkgTGF1cmVudCwKCkRvIHlvdSBieSBhbnkgY2hhbmNlIGhhdmUgYW4gdXBkYXRlIG9uIHRoaXM/
CgpUaGFua3MsCkFsZXgKCk9uIEZyaSwgQXVnIDIwLCAyMDIxIGF0IDY6MTUgUE0gTGF1cmVudCBW
aXZpZXIgPGx2aXZpZXJAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiAxOS8wOC8yMDIxIDIyOjU4
LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiBPbiBGcmksIE5vdiAxMywgMjAyMCBhdCAw
NjoyNjoxNlBNICswMTAwLCBBbGV4YW5kZXIgUG90YXBlbmtvIHdyb3RlOgo+ID4+IEhpIEFtb3Ms
IFJ1c3R5LCBBbWl0LCBNaWNoYWVsLAo+ID4+Cj4gPj4gSSBhbSBoaXR0aW5nIHNvbWV0aGluZyB0
aGF0IEkgYmVsaWV2ZSB0byBiZSBhIG1pbm9yIHByb2JsZW0gaW4gdGhlCj4gPj4gdmlydGlvIFJO
RyBkcml2ZXIuCj4gPj4gV2hlbiBydW5uaW5nIHRoZSBrZXJuZWwgdW5kZXIgS01TQU4gd2l0aCAi
LWRldmljZSB2aXJ0aW8tcm5nLXBjaSIKPiA+PiBwYXNzZWQgdG8gUUVNVSwgSSBhbSBzZWVpbmcg
cmVwb3J0cyBhYm91dCBybmdfZmlsbGJ1ZiBpbgo+ID4+IGRyaXZlcnMvY2hhci9od19yYW5kb20v
Y29yZS5jIGJlaW5nIHVzZWQgYmVmb3JlIGluaXRpYWxpemF0aW9uIChzZWUKPiA+PiB0aGUgcmVw
b3J0IGJlbG93KS4KPiA+Pgo+ID4+IFRoaXMgY2FuIGJlIHZlcmlmaWVkIGJ5IGluaXRpYWxpemlu
ZyBybmdfZmlsbGJ1ZiB3aXRoICdBJyBhcyBmb2xsb3dzOgo+ID4+ID09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIv
aHdfcmFuZG9tL2NvcmUuYyBiL2RyaXZlcnMvY2hhci9od19yYW5kb20vY29yZS5jCj4gPj4gaW5k
ZXggOGMxYzQ3ZGQ5ZjQ2Li40NGQ2MDlhNTc5NmEgMTAwNjQ0Cj4gPj4gLS0tIGEvZHJpdmVycy9j
aGFyL2h3X3JhbmRvbS9jb3JlLmMKPiA+PiArKysgYi9kcml2ZXJzL2NoYXIvaHdfcmFuZG9tL2Nv
cmUuYwo+ID4+IEBAIC00MzksOCArNDM5LDExIEBAIHN0YXRpYyBpbnQgaHdybmdfZmlsbGZuKHZv
aWQgKnVudXNlZCkKPiA+PiAgICAgICAgICAgICAgICAgaWYgKElTX0VSUihybmcpIHx8ICFybmcp
Cj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gPj4gICAgICAgICAgICAgICAg
IG11dGV4X2xvY2soJnJlYWRpbmdfbXV0ZXgpOwo+ID4+ICsgICAgICAgICAgICAgICBtZW1zZXQo
cm5nX2ZpbGxidWYsICdBJywgcm5nX2J1ZmZlcl9zaXplKCkpOwo+ID4+ICsgICAgICAgICAgICAg
ICBybmdfZmlsbGJ1ZltybmdfYnVmZmVyX3NpemUoKS0xXSA9IDA7Cj4gPj4gICAgICAgICAgICAg
ICAgIHJjID0gcm5nX2dldF9kYXRhKHJuZywgcm5nX2ZpbGxidWYsCj4gPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJuZ19idWZmZXJfc2l6ZSgpLCAxKTsKPiA+PiArICAgICAg
ICAgICAgICAgcHJfZXJyKCJybmdfZmlsbGJ1ZjogJXNcbiIsIHJuZ19maWxsYnVmKTsKPiA+PiAg
ICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZyZWFkaW5nX211dGV4KTsKPiA+PiAgICAgICAg
ICAgICAgICAgcHV0X3JuZyhybmcpOwo+ID4+ICAgICAgICAgICAgICAgICBpZiAocmMgPD0gMCkg
ewo+ID4+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+ID4+Cj4g
Pj4gYW5kIGJvb3RpbmcgdGhlIGtlcm5lbDogdGhlIGZpcnN0IGNhbGwgb2YgaHdybmdfZmlsbGZu
KCkgd2lsbCBwcmludAo+ID4+ICJBQUFBQUFBLi4iIGluc3RlYWQgb2YgcmFuZG9tIGRhdGEuCj4g
Pj4KPiA+PiBGb3Igc29tZSByZWFzb24gb24gdGhhdCBmaXJzdCBpdGVyYXRpb24gdmktPmJ1c3kg
aXMgdHJ1ZSBoZXJlOgo+ID4+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVz
dC9zb3VyY2UvZHJpdmVycy9jaGFyL2h3X3JhbmRvbS92aXJ0aW8tcm5nLmMjTDYyLAo+ID4+IHRo
ZXJlZm9yZSB0aGUgYnVmZmVyIGlzIG5vdCBiZWluZyBzZW50IHRvIHZpcnRpbyByaW5nLgo+ID4+
Cj4gPj4gV2hpbGUgcHJvYmFibHkgYmVpbmcgYmVuaWduLCB0aGlzIGJ1ZyBpcyBwcmV2ZW50aW5n
IHN5emthbGxlciBmcm9tCj4gPj4gZmluZGluZyBtb3JlIGJ1Z3MsIHNvIGl0IHdvdWxkIGJlIG5p
Y2UgdG8gZml4IGl0Lgo+ID4+IFBlcmhhcHMgdGhlIGVhc2llc3Qgc29sdXRpb24gaXMgdG8ga3ph
bGxvYyBybmdfZmlsbGJ1ZiwgYnV0IGlmIGl0J3MKPiA+PiBjcml0aWNhbCBmb3IgdGhpcyBkcml2
ZXIgdG8gbm90IHNraXAgZXZlbiB0aGUgZmlyc3QgcmVhZCwgdGhlbiBtYXliZQo+ID4+IHlvdSBo
YXZlIGJldHRlciBpZGVhcz8KPiA+Pgo+ID4+IEtNU0FOIHJlcG9ydCBmb2xsb3dzOgo+ID4+Cj4g
Pj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
PiA+PiBCVUc6IEtNU0FOOiB1bmluaXQtdmFsdWUgaW4gX21peF9wb29sX2J5dGVzKzB4N2QyLzB4
OTUwCj4gPj4gZHJpdmVycy9jaGFyL3JhbmRvbS5jOjU3MAo+ID4+IENQVTogMCBQSUQ6IDI3MTEg
Q29tbTogaHdybmcgTm90IHRhaW50ZWQgNS45LjAtcmM4LXN5emthbGxlciAjMAo+ID4+IEhhcmR3
YXJlIG5hbWU6IEdvb2dsZSBHb29nbGUgQ29tcHV0ZSBFbmdpbmUvR29vZ2xlIENvbXB1dGUgRW5n
aW5lLAo+ID4+IEJJT1MgR29vZ2xlIDAxLzAxLzIwMTEKPiA+PiBDYWxsIFRyYWNlOgo+ID4+ICBf
X2R1bXBfc3RhY2sgbGliL2R1bXBfc3RhY2suYzo3NyBbaW5saW5lXQo+ID4+ICBkdW1wX3N0YWNr
KzB4MjFjLzB4MjgwIGxpYi9kdW1wX3N0YWNrLmM6MTE4Cj4gPj4gIGttc2FuX3JlcG9ydCsweGY3
LzB4MWUwIG1tL2ttc2FuL2ttc2FuX3JlcG9ydC5jOjEyMgo+ID4+ICBfX21zYW5fd2FybmluZysw
eDVmLzB4YTAgbW0va21zYW4va21zYW5faW5zdHIuYzoyMDEKPiA+PiAgX21peF9wb29sX2J5dGVz
KzB4N2QyLzB4OTUwIGRyaXZlcnMvY2hhci9yYW5kb20uYzo1NzAKPiA+PiAgbWl4X3Bvb2xfYnl0
ZXMrMHhjYS8weDJhMCBkcml2ZXJzL2NoYXIvcmFuZG9tLmM6NTk5Cj4gPj4gIGFkZF9od2dlbmVy
YXRvcl9yYW5kb21uZXNzKzB4NGFjLzB4NTAwIGRyaXZlcnMvY2hhci9yYW5kb20uYzoyMzE5Cj4g
Pj4gIGh3cm5nX2ZpbGxmbisweDZhZS8weDk0MCBkcml2ZXJzL2NoYXIvaHdfcmFuZG9tL2NvcmUu
Yzo0NTIKPiA+PiAga3RocmVhZCsweDUxYy8weDU2MCBrZXJuZWwva3RocmVhZC5jOjI5Mwo+ID4+
ICByZXRfZnJvbV9mb3JrKzB4MWYvMHgzMCBhcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjI5NAo+
ID4+Cj4gPj4gVW5pbml0IHdhcyBjcmVhdGVkIGF0Ogo+ID4+ICBrbXNhbl9zYXZlX3N0YWNrX3dp
dGhfZmxhZ3MgbW0va21zYW4va21zYW4uYzoxMjkgW2lubGluZV0KPiA+PiAga21zYW5faW50ZXJu
YWxfcG9pc29uX3NoYWRvdysweDVjLzB4ZjAgbW0va21zYW4va21zYW4uYzoxMTIKPiA+PiAga21z
YW5fc2xhYl9hbGxvYysweDhkLzB4ZTAgbW0va21zYW4va21zYW5faG9va3MuYzo4MAo+ID4+ICBz
bGFiX2FsbG9jX25vZGUgbW0vc2x1Yi5jOjI5MDMgW2lubGluZV0KPiA+PiAgc2xhYl9hbGxvYyBt
bS9zbHViLmM6MjkxMiBbaW5saW5lXQo+ID4+ICBrbWVtX2NhY2hlX2FsbG9jX3RyYWNlKzB4NjFl
LzB4YzkwIG1tL3NsdWIuYzoyOTI5Cj4gPj4gIGttYWxsb2MgaW5jbHVkZS9saW51eC9zbGFiLmg6
NTU0IFtpbmxpbmVdCj4gPj4gIGh3cm5nX21vZGluaXQrMHgxMDMvMHgyZWYgZHJpdmVycy9jaGFy
L2h3X3JhbmRvbS9jb3JlLmM6NjIxCj4gPj4gIGRvX29uZV9pbml0Y2FsbCsweDM3MS8weDljMCBp
bml0L21haW4uYzoxMjA4Cj4gPj4gIGRvX2luaXRjYWxsX2xldmVsKzB4MWU1LzB4M2M2IGluaXQv
bWFpbi5jOjEyODEKPiA+PiAgZG9faW5pdGNhbGxzKzB4MTI3LzB4MWNiIGluaXQvbWFpbi5jOjEy
OTcKPiA+PiAgZG9fYmFzaWNfc2V0dXArMHgzMy8weDM2IGluaXQvbWFpbi5jOjEzMTcKPiA+PiAg
a2VybmVsX2luaXRfZnJlZWFibGUrMHgyMzgvMHgzOGIgaW5pdC9tYWluLmM6MTUxNwo+ID4+ICBr
ZXJuZWxfaW5pdCsweDFmLzB4ODQwIGluaXQvbWFpbi5jOjE0MDYKPiA+PiAgcmV0X2Zyb21fZm9y
aysweDFmLzB4MzAgYXJjaC94ODYvZW50cnkvZW50cnlfNjQuUzoyOTQKPiA+PiA9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+ID4+Cj4gPj4gVGhh
bmtzLAo+ID4+IEFsZXgKPiA+Cj4gPgo+ID4gQ2MgTGF1cmVudCAtIEkgdGhpbmsgaGUgc2FpZCBo
ZSB3YXMgZ29pbmcgdG8gbG9vayBhdCB2aXJ0aW8gcm5nLgo+Cj4gSSB3aWxsIGhhdmUgbG9vayBu
ZXh0IHdlZWsuCj4KPiBUaGFua3MsCj4gTGF1cmVudAo+CgoKLS0gCkFsZXhhbmRlciBQb3RhcGVu
a28KU29mdHdhcmUgRW5naW5lZXIKCkdvb2dsZSBHZXJtYW55IEdtYkgKRXJpa2EtTWFubi1TdHJh
w59lLCAzMwo4MDYzNiBNw7xuY2hlbgoKR2VzY2jDpGZ0c2bDvGhyZXI6IFBhdWwgTWFuaWNsZSwg
SGFsaW1haCBEZUxhaW5lIFByYWRvClJlZ2lzdGVyZ2VyaWNodCB1bmQgLW51bW1lcjogSGFtYnVy
ZywgSFJCIDg2ODkxClNpdHogZGVyIEdlc2VsbHNjaGFmdDogSGFtYnVyZwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
