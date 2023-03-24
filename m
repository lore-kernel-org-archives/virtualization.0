Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53D5C6FD1C
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 09:31:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 638F16141B;
	Fri, 24 Mar 2023 09:31:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 638F16141B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cI5ri+wH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jng9mj-NSXSI; Fri, 24 Mar 2023 09:31:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F1C5060FB4;
	Fri, 24 Mar 2023 09:31:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F1C5060FB4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD573C0035;
	Fri, 24 Mar 2023 09:31:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2ECE0C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 09:31:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 16CE860E19
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 09:31:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 16CE860E19
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fiP03-J_QGWd
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 09:31:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F9D460FB4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F9D460FB4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 09:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679650261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KJlH9otWhMZcJiElSwL7jmGaIVB1DaHJ04Oz3GP+kqo=;
 b=cI5ri+wH7lxStIcS8vyJUNht+WFJZnU6JmKkB1MhEKSUQqeUVDvDsQh/KzmW7/tiqZwRUf
 cvdbo2ocowdDmJYZ5UVsh1ZzJToiTrOpnBcbFiAwNCaBt0RTphpWRZDLRs9Y3+qAYJIUB+
 VkjYW5bpTa/jBtQ3l7CIOyRQ1Z2a2Oc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-r4c2ACjTNyeGH0AM2BP-lw-1; Fri, 24 Mar 2023 05:31:00 -0400
X-MC-Unique: r4c2ACjTNyeGH0AM2BP-lw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5416d3a321eso13166697b3.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 02:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679650260;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KJlH9otWhMZcJiElSwL7jmGaIVB1DaHJ04Oz3GP+kqo=;
 b=TK5ne60ABjiHmHdxAax3qEBn6YswOsUzsazyBX4JPTOn9Zyrldj9ERBvKhE1lZK+2Z
 Rsw0aKRsxKBa9B4vqSwClu1WsyZ8XdCMqvq7S8wYMVs+eP0K8OVUgA2hbl34wD4tej1+
 Py1lY4qBMSNab6w2hJr2u5hoYfxSnzsJI9XFM0le7DtOPhRkxSi9SoLizT5J050a6wXH
 uqQQ5+21s+oUrt0XKphr5qXAC4XR1XGDT+ZDDsuwaXCbuKJGfshUz7fzsbTEOYLakdfE
 uQaaltM59KjhgYBdlB9NliwxSRchhY4/r9fiKC4yddXHYu2lIsosuBve7k5szDuZIPOo
 /nTA==
X-Gm-Message-State: AAQBX9eeG+bExcYWfC6gX/L3ZQhPMM+y3BUo0k1io8gFYU/eVI8k4y/o
 i/fQ1LJv1d/bxxEH3CpRbTToXNEXV+xeTSbBvQeZAwKZ8i1UZXFmPv5zoiIgq9yyiIQLsoExgMv
 hhWL1fZUumL1zslOLNruNvft8fNMS6lSxGtbwklaD3kwhSn4uG8lieaRfsg==
X-Received: by 2002:a81:c444:0:b0:544:a67b:8be0 with SMTP id
 s4-20020a81c444000000b00544a67b8be0mr724227ywj.3.1679650260056; 
 Fri, 24 Mar 2023 02:31:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350YVXApSr3DKRq01E/v59zifPTYg5WRHMqtsDqWatxGa/N8zzftHhpu9f8TwhoduQDEp4ASSab/oYJN7kHsE3ZU=
X-Received: by 2002:a81:c444:0:b0:544:a67b:8be0 with SMTP id
 s4-20020a81c444000000b00544a67b8be0mr724222ywj.3.1679650259851; Fri, 24 Mar
 2023 02:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000708b1005f79acf5c@google.com>
 <CAGxU2F4ZiNEyrZzEJnYjYDz6CxniPGNW7AwyMLPLTxA2UbBWhA@mail.gmail.com>
 <CAGxU2F6m4KWXwOF8StjWbb=S6HRx=GhV_ONDcZxCZsDkvuaeUg@mail.gmail.com>
 <CAGxU2F7XjdKgdKwfZMT-sdJ+JK10p_2zNdaQeGBwm3jpEe1Xaw@mail.gmail.com>
 <46ba9b55-c6ff-925c-d51a-8da9d1abd2f2@sberdevices.ru>
In-Reply-To: <46ba9b55-c6ff-925c-d51a-8da9d1abd2f2@sberdevices.ru>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 24 Mar 2023 10:30:48 +0100
Message-ID: <CAGxU2F4KF=YGQkGJygurNyK=KU-pxPomAbr_v3eNvgMmwKQxmQ@mail.gmail.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] general protection fault in
 virtio_transport_purge_skbs
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, Bobby Eshleman <bobby.eshleman@gmail.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 syzkaller-bugs@googlegroups.com,
 syzbot <syzbot+befff0a9536049e7902e@syzkaller.appspotmail.com>,
 edumazet@google.com, stefanha@redhat.com, Krasnov Arseniy <oxffffaa@gmail.com>,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

T24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgMTA6MTDigK9BTSBBcnNlbml5IEtyYXNub3YKPGF2a3Jh
c25vdkBzYmVyZGV2aWNlcy5ydT4gd3JvdGU6Cj4gT24gMjQuMDMuMjAyMyAxMjowNiwgU3RlZmFu
byBHYXJ6YXJlbGxhIHdyb3RlOgo+ID4gT24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgOTo1NeKAr0FN
IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4KPiA+
PiBPbiBGcmksIE1hciAyNCwgMjAyMyBhdCA5OjMx4oCvQU0gU3RlZmFubyBHYXJ6YXJlbGxhIDxz
Z2FyemFyZUByZWRoYXQuY29tPiB3cm90ZToKPiA+Pj4KPiA+Pj4gSGkgQm9iYnksCj4gPj4+IGNh
biB5b3UgdGFrZSBhIGxvb2sgYXQgdGhpcyByZXBvcnQ/Cj4gPj4+Cj4gPj4+IEl0IHNlZW1zIHJl
bGF0ZWQgdG8gdGhlIGNoYW5nZXMgd2UgbWFkZSB0byBzdXBwb3J0IHNrYnVmZi4KPiA+Pgo+ID4+
IENvdWxkIGl0IGJlIGEgcHJvYmxlbSBvZiBjb25jdXJyZW50IGFjY2VzcyB0byBwa3RfcXVldWUg
Pwo+ID4+Cj4gPj4gSUlVQyB3ZSBzaG91bGQgaG9sZCBwa3RfcXVldWUubG9jayB3aGVuIHdlIGNh
bGwgc2tiX3F1ZXVlX3NwbGljZV9pbml0KCkKPiA+PiBhbmQgcmVtb3ZlIHBrdF9saXN0X2xvY2su
IChvciBob2xkIHBrdF9saXN0X2xvY2sgd2hlbiBjYWxsaW5nCj4gPj4gdmlydGlvX3RyYW5zcG9y
dF9wdXJnZV9za2JzLCBidXQgcGt0X2xpc3RfbG9jayBzZWVtcyB1c2VsZXNzIG5vdyB0aGF0Cj4g
Pj4gd2UgdXNlIHNrYnVmZikKPiA+Pgo+ID4KPiA+IEluIHRoZSBwcmV2aW91cyBwYXRjaCB3YXMg
bWlzc2luZyBhIGh1bmssIG5ldyBvbmUgYXR0YWNoZWQ6Cj4gPgo+ID4gI3N5eiB0ZXN0IGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4
LmdpdCBmZmY1YTVlN2Y1MjgKPiA+Cj4gPiAtLS0gYS9uZXQvdm13X3Zzb2NrL3Zzb2NrX2xvb3Bi
YWNrLmMKPiA+ICsrKyBiL25ldC92bXdfdnNvY2svdnNvY2tfbG9vcGJhY2suYwo+ID4gQEAgLTE1
LDcgKzE1LDYgQEAKPiA+ICBzdHJ1Y3QgdnNvY2tfbG9vcGJhY2sgewo+ID4gICAgICAgICBzdHJ1
Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqd29ya3F1ZXVlOwo+ID4KPiA+IC0gICAgICAgc3BpbmxvY2tf
dCBwa3RfbGlzdF9sb2NrOyAvKiBwcm90ZWN0cyBwa3RfbGlzdCAqLwo+ID4gICAgICAgICBzdHJ1
Y3Qgc2tfYnVmZl9oZWFkIHBrdF9xdWV1ZTsKPiA+ICAgICAgICAgc3RydWN0IHdvcmtfc3RydWN0
IHBrdF93b3JrOwo+ID4gIH07Cj4gPiBAQCAtMzIsOSArMzEsNyBAQCBzdGF0aWMgaW50IHZzb2Nr
X2xvb3BiYWNrX3NlbmRfcGt0KHN0cnVjdCBza19idWZmICpza2IpCj4gPiAgICAgICAgIHN0cnVj
dCB2c29ja19sb29wYmFjayAqdnNvY2sgPSAmdGhlX3Zzb2NrX2xvb3BiYWNrOwo+ID4gICAgICAg
ICBpbnQgbGVuID0gc2tiLT5sZW47Cj4gPgo+ID4gLSAgICAgICBzcGluX2xvY2tfYmgoJnZzb2Nr
LT5wa3RfbGlzdF9sb2NrKTsKPiA+ICAgICAgICAgc2tiX3F1ZXVlX3RhaWwoJnZzb2NrLT5wa3Rf
cXVldWUsIHNrYik7Cj4gSGVsbG8gU3RlZmFubyBhbmQgQm9iYnksCj4KPiBTbWFsbCByZW1hcmss
IG1heSBiZSBoZXJlIHdlIGNhbiB1c2UgdmlydGlvX3Zzb2NrX3NrYl9xdWV1ZV90YWlsKCkgaW5z
dGVhZCBvZiBza2JfcXVldWVfdGFpbCgpLgo+IHNrYl9xdWV1ZV90YWlsKCkgZGlzYWJsZXMgaXJx
cyBkdXJpbmcgc3BpbmxvY2sgYWNjZXNzLCB3aGlsZSAgdmlydGlvX3Zzb2NrX3NrYl9xdWV1ZV90
YWlsKCkKPiB1c2VzIHNwaW5fbG9ja19iaCgpLiB2aG9zdCBhbmQgdmlydGlvIHRyYW5zcG9ydHMg
dXNlIHZpcnRpb192c29ja19za2JfcXVldWVfdGFpbCgpLgo+CgpZZXAsIGJ1dCB0aGlzIHNob3Vs
ZG4ndCBiZSByZWxhdGVkLgpJIHdvdWxkIG1ha2UgdGhpcyBjaGFuZ2UgaW4gYSBzZXBhcmF0ZSBw
YXRjaC4gOy0pCgpUaGFua3MsClN0ZWZhbm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
