Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC4EC6FD1C
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 09:06:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57A8460B36;
	Fri, 24 Mar 2023 09:06:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57A8460B36
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JcfmRJa7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cWJ3A6pzwk3G; Fri, 24 Mar 2023 09:06:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D111D60B33;
	Fri, 24 Mar 2023 09:06:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D111D60B33
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DFD5C0071;
	Fri, 24 Mar 2023 09:06:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EC0DC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 09:06:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0720460B36
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 09:06:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0720460B36
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BQ1ZrxaWw6yJ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 09:06:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 12CED60B33
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 12CED60B33
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 09:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679648787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QVH2oh9fpzLQkJXdwpUJ4533V1wJBPoDSclzcYbqRDs=;
 b=JcfmRJa7JAl5IOGs2Fi9/qCxnQQ19wBLpDhTmjjKU5JTespDVA6uTxkURoa2+8HWbmc+4x
 UhnF91etkOQqfB9UFp0awr9/BIlosexl1ChfIAqR1nAL/x594wG0KkgL8CtulEb0SIoifp
 MusLvpxQAtKIVpDurxRRwy5vE4ucgQY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-rUjiLIdANYOjivsUhEc_ng-1; Fri, 24 Mar 2023 05:06:25 -0400
X-MC-Unique: rUjiLIdANYOjivsUhEc_ng-1
Received: by mail-ed1-f71.google.com with SMTP id
 q13-20020a5085cd000000b004af50de0bcfso2272567edh.15
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 02:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679648784;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QVH2oh9fpzLQkJXdwpUJ4533V1wJBPoDSclzcYbqRDs=;
 b=zSg8vOtA2IHcs7efoHG4haxny5BVdgtoTvAA7AZKVaHbfxW/s0BwRxDG2xPQhkUpc2
 S6rsWAcp3TvFJx/dBAiexonsDEfaSR1xnuoGpOg/08cV/ATXtf2QUuwu+onlkX/KuuN0
 /WeJWVkmQEdXV+NE2Jc4qe6Z9iNFioNXA7s6yLVuF7C3msNivoiTnUE14z8oAMMhq1na
 qsMcnd5pcZ1V4neZfwT+KdciZ0hYIgS/zac8e3y4leb5OkgW+KvoSzhSkJb+kihZObku
 KrbQAmFNnaZ2hxhCAvpVcg/8V9QE1K9Vwk/BY16howR11mUAelVry4K6e2EJUi8lL73p
 /Zcw==
X-Gm-Message-State: AAQBX9ctNYzzv4UZj353uFAmJSK4mo7Axlk8/EOvpsJQwHAU7UPxQtVi
 Opy5ETaEncGzGifrRvilEDpROVY57hZh1bkkZiL20kasBXrLtD65r+uuoQJZ4fH3SvVImrKl4KM
 hpFO1YddYvvIbqTNex2MF/qM39WJZk0+oAtPYDp5dDA==
X-Received: by 2002:a17:906:fb08:b0:8b1:2d0e:281 with SMTP id
 lz8-20020a170906fb0800b008b12d0e0281mr2290894ejb.18.1679648784737; 
 Fri, 24 Mar 2023 02:06:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350bQ/0qtXsSzTfWFpJpLAd1O/C8EC/FjGUKHYcG4gtT7IHcXKxrUdWfr7rE+d1abTlAFPGEy4w==
X-Received: by 2002:a17:906:fb08:b0:8b1:2d0e:281 with SMTP id
 lz8-20020a170906fb0800b008b12d0e0281mr2290873ejb.18.1679648784448; 
 Fri, 24 Mar 2023 02:06:24 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it.
 [82.53.134.98]) by smtp.gmail.com with ESMTPSA id
 g8-20020a1709061e0800b0093bd173baa6sm3300977ejj.202.2023.03.24.02.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Mar 2023 02:06:23 -0700 (PDT)
Date: Fri, 24 Mar 2023 10:06:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: syzbot <syzbot+befff0a9536049e7902e@syzkaller.appspotmail.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Bobby Eshleman <bobby.eshleman@gmail.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] general protection fault in
 virtio_transport_purge_skbs
Message-ID: <CAGxU2F7XjdKgdKwfZMT-sdJ+JK10p_2zNdaQeGBwm3jpEe1Xaw@mail.gmail.com>
References: <000000000000708b1005f79acf5c@google.com>
 <CAGxU2F4ZiNEyrZzEJnYjYDz6CxniPGNW7AwyMLPLTxA2UbBWhA@mail.gmail.com>
 <CAGxU2F6m4KWXwOF8StjWbb=S6HRx=GhV_ONDcZxCZsDkvuaeUg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGxU2F6m4KWXwOF8StjWbb=S6HRx=GhV_ONDcZxCZsDkvuaeUg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>,
 Krasnov Arseniy <oxffffaa@gmail.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, stefanha@redhat.com, kuba@kernel.org, pabeni@redhat.com,
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

T24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgOTo1NeKAr0FNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dh
cnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBGcmksIE1hciAyNCwgMjAyMyBhdCA5OjMx
4oCvQU0gU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPiB3cm90ZToKPiA+
Cj4gPiBIaSBCb2JieSwKPiA+IGNhbiB5b3UgdGFrZSBhIGxvb2sgYXQgdGhpcyByZXBvcnQ/Cj4g
Pgo+ID4gSXQgc2VlbXMgcmVsYXRlZCB0byB0aGUgY2hhbmdlcyB3ZSBtYWRlIHRvIHN1cHBvcnQg
c2tidWZmLgo+Cj4gQ291bGQgaXQgYmUgYSBwcm9ibGVtIG9mIGNvbmN1cnJlbnQgYWNjZXNzIHRv
IHBrdF9xdWV1ZSA/Cj4KPiBJSVVDIHdlIHNob3VsZCBob2xkIHBrdF9xdWV1ZS5sb2NrIHdoZW4g
d2UgY2FsbCBza2JfcXVldWVfc3BsaWNlX2luaXQoKQo+IGFuZCByZW1vdmUgcGt0X2xpc3RfbG9j
ay4gKG9yIGhvbGQgcGt0X2xpc3RfbG9jayB3aGVuIGNhbGxpbmcKPiB2aXJ0aW9fdHJhbnNwb3J0
X3B1cmdlX3NrYnMsIGJ1dCBwa3RfbGlzdF9sb2NrIHNlZW1zIHVzZWxlc3Mgbm93IHRoYXQKPiB3
ZSB1c2Ugc2tidWZmKQo+CgpJbiB0aGUgcHJldmlvdXMgcGF0Y2ggd2FzIG1pc3NpbmcgYSBodW5r
LCBuZXcgb25lIGF0dGFjaGVkOgoKI3N5eiB0ZXN0IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdCBmZmY1YTVlN2Y1MjgKCi0t
LSBhL25ldC92bXdfdnNvY2svdnNvY2tfbG9vcGJhY2suYworKysgYi9uZXQvdm13X3Zzb2NrL3Zz
b2NrX2xvb3BiYWNrLmMKQEAgLTE1LDcgKzE1LDYgQEAKIHN0cnVjdCB2c29ja19sb29wYmFjayB7
CiAgICAgICAgc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKndvcmtxdWV1ZTsKCi0gICAgICAgc3Bp
bmxvY2tfdCBwa3RfbGlzdF9sb2NrOyAvKiBwcm90ZWN0cyBwa3RfbGlzdCAqLwogICAgICAgIHN0
cnVjdCBza19idWZmX2hlYWQgcGt0X3F1ZXVlOwogICAgICAgIHN0cnVjdCB3b3JrX3N0cnVjdCBw
a3Rfd29yazsKIH07CkBAIC0zMiw5ICszMSw3IEBAIHN0YXRpYyBpbnQgdnNvY2tfbG9vcGJhY2tf
c2VuZF9wa3Qoc3RydWN0IHNrX2J1ZmYgKnNrYikKICAgICAgICBzdHJ1Y3QgdnNvY2tfbG9vcGJh
Y2sgKnZzb2NrID0gJnRoZV92c29ja19sb29wYmFjazsKICAgICAgICBpbnQgbGVuID0gc2tiLT5s
ZW47CgotICAgICAgIHNwaW5fbG9ja19iaCgmdnNvY2stPnBrdF9saXN0X2xvY2spOwogICAgICAg
IHNrYl9xdWV1ZV90YWlsKCZ2c29jay0+cGt0X3F1ZXVlLCBza2IpOwotICAgICAgIHNwaW5fdW5s
b2NrX2JoKCZ2c29jay0+cGt0X2xpc3RfbG9jayk7CgogICAgICAgIHF1ZXVlX3dvcmsodnNvY2st
PndvcmtxdWV1ZSwgJnZzb2NrLT5wa3Rfd29yayk7CgpAQCAtMTEzLDkgKzExMCw5IEBAIHN0YXRp
YyB2b2lkIHZzb2NrX2xvb3BiYWNrX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQoKICAg
ICAgICBza2JfcXVldWVfaGVhZF9pbml0KCZwa3RzKTsKCi0gICAgICAgc3Bpbl9sb2NrX2JoKCZ2
c29jay0+cGt0X2xpc3RfbG9jayk7CisgICAgICAgc3Bpbl9sb2NrX2JoKCZ2c29jay0+cGt0X3F1
ZXVlLmxvY2spOwogICAgICAgIHNrYl9xdWV1ZV9zcGxpY2VfaW5pdCgmdnNvY2stPnBrdF9xdWV1
ZSwgJnBrdHMpOwotICAgICAgIHNwaW5fdW5sb2NrX2JoKCZ2c29jay0+cGt0X2xpc3RfbG9jayk7
CisgICAgICAgc3Bpbl91bmxvY2tfYmgoJnZzb2NrLT5wa3RfcXVldWUubG9jayk7CgogICAgICAg
IHdoaWxlICgoc2tiID0gX19za2JfZGVxdWV1ZSgmcGt0cykpKSB7CiAgICAgICAgICAgICAgICB2
aXJ0aW9fdHJhbnNwb3J0X2RlbGl2ZXJfdGFwX3BrdChza2IpOwpAQCAtMTMyLDcgKzEyOSw2IEBA
IHN0YXRpYyBpbnQgX19pbml0IHZzb2NrX2xvb3BiYWNrX2luaXQodm9pZCkKICAgICAgICBpZiAo
IXZzb2NrLT53b3JrcXVldWUpCiAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsKCi0gICAg
ICAgc3Bpbl9sb2NrX2luaXQoJnZzb2NrLT5wa3RfbGlzdF9sb2NrKTsKICAgICAgICBza2JfcXVl
dWVfaGVhZF9pbml0KCZ2c29jay0+cGt0X3F1ZXVlKTsKICAgICAgICBJTklUX1dPUksoJnZzb2Nr
LT5wa3Rfd29yaywgdnNvY2tfbG9vcGJhY2tfd29yayk7CgpAQCAtMTU2LDkgKzE1Miw3IEBAIHN0
YXRpYyB2b2lkIF9fZXhpdCB2c29ja19sb29wYmFja19leGl0KHZvaWQpCgogICAgICAgIGZsdXNo
X3dvcmsoJnZzb2NrLT5wa3Rfd29yayk7CgotICAgICAgIHNwaW5fbG9ja19iaCgmdnNvY2stPnBr
dF9saXN0X2xvY2spOwogICAgICAgIHZpcnRpb192c29ja19za2JfcXVldWVfcHVyZ2UoJnZzb2Nr
LT5wa3RfcXVldWUpOwotICAgICAgIHNwaW5fdW5sb2NrX2JoKCZ2c29jay0+cGt0X2xpc3RfbG9j
ayk7CgogICAgICAgIGRlc3Ryb3lfd29ya3F1ZXVlKHZzb2NrLT53b3JrcXVldWUpOwogfQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
