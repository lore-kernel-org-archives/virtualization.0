Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C503EC6FD20
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 11:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3504E60AC3;
	Fri, 24 Mar 2023 11:58:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3504E60AC3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PtMTO9gB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ai8Cmagiw_CN; Fri, 24 Mar 2023 11:58:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C371960675;
	Fri, 24 Mar 2023 11:58:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C371960675
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6310C0035;
	Fri, 24 Mar 2023 11:58:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDDC7C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 11:58:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 82FF681EF7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 11:58:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82FF681EF7
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PtMTO9gB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lh_KURp7DMYx
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 11:58:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79D9D81ECC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 79D9D81ECC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 11:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679659114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WFRhAEW+lBgl4z20TkQtu5IaRn9JzQcLohklOWmxl9I=;
 b=PtMTO9gBRo8V4gQHZwyA/+8c3LBY0K8RHW+qF9ujoHMDeskKtURbLHPTty0SRRVTvIaPAL
 tRX641d33tPc3A9T5hkBI2+hYca1qt8IvzzD+09tBoktmGp93QfKK4l2Tw4kgRbV/nCWSW
 ZGnU2yZiyUjpSW89cwmtshmpdOa3QJg=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-rz2g8YmrNqCFhZbZDvza7w-1; Fri, 24 Mar 2023 07:58:32 -0400
X-MC-Unique: rz2g8YmrNqCFhZbZDvza7w-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-5458dde029bso16187367b3.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 04:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679659112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WFRhAEW+lBgl4z20TkQtu5IaRn9JzQcLohklOWmxl9I=;
 b=Ied8WPdKMYf5vfYYIzqGmXi6hQ9ibnpcg0d8skn9kHWP7u/wkH+VlrK7g5foOK3QIm
 EW+9ULrrahyY6729C5CrzbSfX1cBA/4XjQZZlNuIzZIfLPidzqu5hdiunLjgyJ2YjUGd
 VTa9DH0vltJr2c43AterdfXqgd3Y6EagNe//kFrPW+qhBs0BlwcG3rgr4gJhijGlY6pw
 KHdRCDavd6vlai2Dh0R9PCk/+erdK6pn/17JW5hsN+UJzDOnKFtxCI6xqp3SYWAHjEvP
 GrHRzHpg/yndN4oBnvCv8nliHUpyFoTGPJPkg+aDKVJebtossj+SbjV0Bv31j/d0qOgC
 3Ywg==
X-Gm-Message-State: AAQBX9d2fu+jx0HaU1b/zqoBhxCjd23YJwglSvhzr0MOapEIgg97c3vD
 j6loJ8igL0WPikipLDm8kP9EgwKOA+k0d+IhiaGlMmm2e/fQERm2ufa0poOXZfTCEGFI2VABRx3
 7eh4B33HHsSqbQWPnVvVh1jWL/GKRk9ni7D9zdcjkBFGox+54PUvJpIqvXw==
X-Received: by 2002:a81:ed08:0:b0:545:624a:874f with SMTP id
 k8-20020a81ed08000000b00545624a874fmr1127713ywm.3.1679659112406; 
 Fri, 24 Mar 2023 04:58:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZqTA4xw2AJ7nh6DTMfcKRQq3tCXDjfqRBOsmdfigLt1Fagj6zEUmXaVvwqLo5wUZNoPZiX6cX52rWCA91hRqI=
X-Received: by 2002:a81:ed08:0:b0:545:624a:874f with SMTP id
 k8-20020a81ed08000000b00545624a874fmr1127700ywm.3.1679659112185; Fri, 24 Mar
 2023 04:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000708b1005f79acf5c@google.com>
 <CAGxU2F4ZiNEyrZzEJnYjYDz6CxniPGNW7AwyMLPLTxA2UbBWhA@mail.gmail.com>
 <CAGxU2F6m4KWXwOF8StjWbb=S6HRx=GhV_ONDcZxCZsDkvuaeUg@mail.gmail.com>
 <CAGxU2F7XjdKgdKwfZMT-sdJ+JK10p_2zNdaQeGBwm3jpEe1Xaw@mail.gmail.com>
In-Reply-To: <CAGxU2F7XjdKgdKwfZMT-sdJ+JK10p_2zNdaQeGBwm3jpEe1Xaw@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 24 Mar 2023 12:58:20 +0100
Message-ID: <CAGxU2F5Q09wFbhfoGB-Wa_0xQFoP8Ah34vqf4gG3DRFdPny1fQ@mail.gmail.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] general protection fault in
 virtio_transport_purge_skbs
To: syzbot <syzbot+befff0a9536049e7902e@syzkaller.appspotmail.com>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Bobby Eshleman <bobby.eshleman@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

T24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgMTA6MDbigK9BTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNn
YXJ6YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgOTo1
NeKAr0FNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4g
Pgo+ID4gT24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgOTozMeKAr0FNIFN0ZWZhbm8gR2FyemFyZWxs
YSA8c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IEhpIEJvYmJ5LAo+ID4g
PiBjYW4geW91IHRha2UgYSBsb29rIGF0IHRoaXMgcmVwb3J0Pwo+ID4gPgo+ID4gPiBJdCBzZWVt
cyByZWxhdGVkIHRvIHRoZSBjaGFuZ2VzIHdlIG1hZGUgdG8gc3VwcG9ydCBza2J1ZmYuCj4gPgo+
ID4gQ291bGQgaXQgYmUgYSBwcm9ibGVtIG9mIGNvbmN1cnJlbnQgYWNjZXNzIHRvIHBrdF9xdWV1
ZSA/Cj4gPgo+ID4gSUlVQyB3ZSBzaG91bGQgaG9sZCBwa3RfcXVldWUubG9jayB3aGVuIHdlIGNh
bGwgc2tiX3F1ZXVlX3NwbGljZV9pbml0KCkKPiA+IGFuZCByZW1vdmUgcGt0X2xpc3RfbG9jay4g
KG9yIGhvbGQgcGt0X2xpc3RfbG9jayB3aGVuIGNhbGxpbmcKPiA+IHZpcnRpb190cmFuc3BvcnRf
cHVyZ2Vfc2ticywgYnV0IHBrdF9saXN0X2xvY2sgc2VlbXMgdXNlbGVzcyBub3cgdGhhdAo+ID4g
d2UgdXNlIHNrYnVmZikKPiA+Cj4KClBhdGNoIHBvc3RlZCBoZXJlOgpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9uZXRkZXYvMjAyMzAzMjQxMTU0NTAuMTEyNjgtMS1zZ2FyemFyZUByZWRoYXQuY29t
LwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
