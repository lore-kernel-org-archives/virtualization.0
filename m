Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF151C76195
	for <virtualization@archiver.kernel.org>; Mon, 27 Mar 2023 09:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 53BEE40101;
	Mon, 27 Mar 2023 09:08:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53BEE40101
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=azKpY2j6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 34jvazDJ-31G; Mon, 27 Mar 2023 09:08:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7B21640AA2;
	Mon, 27 Mar 2023 09:08:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B21640AA2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53756C0035;
	Mon, 27 Mar 2023 09:08:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 531CEC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 09:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C31F404E7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 09:08:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1C31F404E7
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=azKpY2j6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rucS50vYNxrO
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 09:08:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E6E24035B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E6E24035B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 09:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679908088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/jHqPQ9labkDpwONGksLRLwMhvFcLpODPDEk10PFbM=;
 b=azKpY2j63zcmEidnzUBigdCcGcBHM0wzMOH30rILZYTYEhxbMjRVtBkNWPORL0w1ebIoLE
 j1frkE+jcbeYEbCwoodw3mYMbUQoLHDdGquMe+zuisJEg9AYpn9O0H4KQmriyN9AeBkho/
 lNMQRd17ThOLRPElL706+P/mxlliM5Q=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-Dt_Z-4IAPr-E52TuJZFJ0Q-1; Mon, 27 Mar 2023 05:08:05 -0400
X-MC-Unique: Dt_Z-4IAPr-E52TuJZFJ0Q-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-54574d6204aso81143567b3.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 02:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679908084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q/jHqPQ9labkDpwONGksLRLwMhvFcLpODPDEk10PFbM=;
 b=OwOo3cV0lbZNyc6lYZnlwpnSV2MOs5Qe+ZgvOJTNMxecfPYStjAwG/k4SvhiTX/c+P
 7rtS9c7olW4CdUUY444R3zar51LfeX9gGFN+KIJ6zyBtl3sf4n5E+BRuUhiUkxsKATNZ
 OBnI1K2t8y+hdh+JXOG+rAtf5hPMxHv44j54VSfIj13ONJAM0GNIwXQq2EdYlMCpAB6V
 2HDp5k+WQ7wgUcsCUOZas4/51T8n3JeGYVO3zfagqhi3JdQ+t/qNqXOZMlMNNW1eK896
 M7b3G1nCPGa/ZOKlzQ6bN5LWp96hYIrLQbLDtbs9Fq8VFs+DNopKiYsS7ngVGGTKBoEW
 BRhA==
X-Gm-Message-State: AAQBX9f7BB3I9DXb3QYP3F2FC56cfYXhOu020BPfSvPahMbL5qVs0Ga3
 plwPSyXV2DSOYIMJyRU+AYRiqjPIcBrd5DwLf4kdSqj1HIFU6B9Oc+P6igc52Bvr/IPy4aaO6P1
 g2ECL0G3xum8Jtl5dAkT888zhMJV/R14WfCIY4llTNOlBqUPyuNpVtcFUug==
X-Received: by 2002:a05:6902:168d:b0:b6d:1483:bc18 with SMTP id
 bx13-20020a056902168d00b00b6d1483bc18mr6595376ybb.7.1679908084554; 
 Mon, 27 Mar 2023 02:08:04 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZK4A0vkFV+Fi54XXazb/aOmFl65dPrh+4dL2oYcZ2EWPZ/YWITfHG4vrrsNYo/PRnSdXQDyk1J9i2vTaifXNI=
X-Received: by 2002:a05:6902:168d:b0:b6d:1483:bc18 with SMTP id
 bx13-20020a056902168d00b00b6d1483bc18mr6595359ybb.7.1679908084346; Mon, 27
 Mar 2023 02:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000075bebb05f79acfde@google.com>
 <CAGxU2F4jxdzK8Y-jaoKRaX_bDhoMtomOT6TyMek+un-Bp8RX3g@mail.gmail.com>
 <ZBUGp5bvNuE3sK5g@bullseye>
In-Reply-To: <ZBUGp5bvNuE3sK5g@bullseye>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 27 Mar 2023 11:07:52 +0200
Message-ID: <CAGxU2F6StMA+Dp77thrC-Tdq+GMiA802yCgxpE5atDn3RiVA1w@mail.gmail.com>
Subject: Re: [syzbot] [net?] [virt?] [io-uring?] [kvm?] BUG: soft lockup in
 vsock_connect
To: Bobby Eshleman <bobbyeshleman@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: axboe@kernel.dk, Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org,
 syzbot <syzbot+0bc015ebddc291a97116@syzkaller.appspotmail.com>,
 Bobby Eshleman <bobby.eshleman@gmail.com>, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org, syzkaller-bugs@googlegroups.com, edumazet@google.com,
 stefanha@redhat.com, Krasnov Arseniy <oxffffaa@gmail.com>, kuba@kernel.org,
 pabeni@redhat.com, virtualization@lists.linux-foundation.org,
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

T24gU2F0LCBNYXIgMjUsIDIwMjMgYXQgMTo0NOKAr0FNIEJvYmJ5IEVzaGxlbWFuIDxib2JieWVz
aGxlbWFuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBPbiBGcmksIE1hciAyNCwgMjAyMyBhdCAwOToz
ODozOEFNICswMTAwLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gPiBIaSBCb2JieSwKPiA+
IEZZSSB3ZSBoYXZlIGFsc28gdGhpcyBvbmUsIGJ1dCBpdCBzZWVtcyByZWxhdGVkIHRvCj4gPiBz
eXpib3QrYmVmZmYwYTk1MzYwNDllNzkwMmVAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQo+ID4K
PiA+IFRoYW5rcywKPiA+IFN0ZWZhbm8KPiA+Cj4KPiBHb3QgaXQsIEknbGwgbG9vayBpbnRvIGl0
LgoKSSB0aGluayBpdCBpcyByZWxhdGVkIHRvCnN5emJvdCtiZWZmZjBhOTUzNjA0OWU3OTAyZUBz
eXprYWxsZXIuYXBwc3BvdG1haWwuY29tLCBzbyBJIHRlc3RlZCB0aGUKc2FtZSBwYXRjaCBhbmQg
c3l6Ym90IHNlZW1zIGhhcHB5LgpJIG1hcmtlZCB0aGlzIGFzIGR1cGxpY2F0ZWQsIGJ1dCBmZWVs
IGZyZWUgdG8gdW5kdXAgaWYgaXQgaXMgbm90IHRoZSBjYXNlLgoKVGhhbmtzLApTdGVmYW5vCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
