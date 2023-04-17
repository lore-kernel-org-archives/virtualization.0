Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5E4C77B70
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 06:20:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5037A60F45;
	Mon, 17 Apr 2023 06:20:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5037A60F45
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HnFmpt8n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VjJNs7JDU10Y; Mon, 17 Apr 2023 06:20:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E932A60F44;
	Mon, 17 Apr 2023 06:20:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E932A60F44
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C215FC0037;
	Mon, 17 Apr 2023 06:20:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11093C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:20:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C92C340273
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:20:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C92C340273
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HnFmpt8n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zuW3DPdmppZR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:20:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55F694026E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 55F694026E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681712426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePbMyRA1sPZRgCUtm4jF6vrpMcXUEcAn5cv4sWSGRdg=;
 b=HnFmpt8n9LNrWigutZzu/ISfmmZSYwMzT6SUZb7MXFtmZbVE2nQex6bi8ZRf+9dLGXkk7b
 FLZ+lapY69suM5oCVameST1+WBGAxG99+w3V+p8b/JijXDDH9uzBf72vLvN6jSXFH29pY+
 8Y32TVqQrVwxTJa0usvG/cvWtmBAepk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-yX5crIKUM3ynOS134bMTig-1; Mon, 17 Apr 2023 02:20:24 -0400
X-MC-Unique: yX5crIKUM3ynOS134bMTig-1
Received: by mail-qt1-f199.google.com with SMTP id
 y5-20020a05622a004500b003e3979be6abso17088821qtw.12
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Apr 2023 23:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681712424; x=1684304424;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ePbMyRA1sPZRgCUtm4jF6vrpMcXUEcAn5cv4sWSGRdg=;
 b=bmqsFeKeXkgN7OQH+L045qPOcjj6xNmxaOmrOdcnmMtcvav1Og7wcukLkB1DNZxTEC
 75I/q+9Z8XfiDsyN3NPQcZfaqMTxDxgyKRXviN+8UZxBNeZ8o1grOfaCDGbvBCEjNRsf
 mG+ti2KELJuz4a2dwzFJsMAsNAY5TOdGnPrdkL4rxt49UHjnoJIE35f9YfrCcpCo32SS
 J85z9f/hiYwIu7UZNBCqoqvItGK8AnWZCZbHrXJ3tRPi0X6H/eMuiYKrp8+ph/DoTk1Q
 1T8LwSTbQMg/+GTvfuZsRrLaSI92e46w8XLwUNXLJFjKPeXVLbaemff93ixzxg1Fsoco
 DRaw==
X-Gm-Message-State: AAQBX9cQF7YarYT1ByVBso3IJgKiGhPUPUkAkfi95hpZp9yn5nemGS5b
 6bPAeo8TqvFMpvSDiXjmPNcBvynBOl/K1yREXu398Jfi2/Ptnq2il5iIKJZXoU4ODDHj/2WagQr
 YypWt8YrNH/63znDsAN+4cK/+vvsvSTBX0mfvaw55ug==
X-Received: by 2002:a05:6214:400e:b0:5ef:5503:d41c with SMTP id
 kd14-20020a056214400e00b005ef5503d41cmr13070233qvb.15.1681712424104; 
 Sun, 16 Apr 2023 23:20:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350YGBvzLQl8TSywlbRHoWsuwzUmdZAtbC2GsJy/SU9rWuxjFVNqOx/mP7CdWEeGgZjqG0Nm5bg==
X-Received: by 2002:a05:6214:400e:b0:5ef:5503:d41c with SMTP id
 kd14-20020a056214400e00b005ef5503d41cmr13070223qvb.15.1681712423865; 
 Sun, 16 Apr 2023 23:20:23 -0700 (PDT)
Received: from redhat.com ([185.199.103.251]) by smtp.gmail.com with ESMTPSA id
 lx4-20020a0562145f0400b005ef42af7eb7sm2870554qvb.25.2023.04.16.23.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Apr 2023 23:20:23 -0700 (PDT)
Date: Mon, 17 Apr 2023 02:20:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230417021725-mutt-send-email-mst@kernel.org>
References: <20230416074607.292616-1-alvaro.karsz@solid-run.com>
 <AM0PR04MB4723C6E99A217F51973710F5D49F9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230416164453-mutt-send-email-mst@kernel.org>
 <CACGkMEvFhVyWb5+ET_akPvnjUq04+ZbJC8o_GtNBWqSMGNum8A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvFhVyWb5+ET_akPvnjUq04+ZbJC8o_GtNBWqSMGNum8A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

T24gTW9uLCBBcHIgMTcsIDIwMjMgYXQgMTE6MjQ6MTZBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBNb24sIEFwciAxNywgMjAyMyBhdCA0OjQ14oCvQU0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gU3VuLCBBcHIgMTYsIDIwMjMgYXQg
MDQ6NTQ6NTdQTSArMDAwMCwgQWx2YXJvIEthcnN6IHdyb3RlOgo+ID4gPiBBZnRlciBmdXJ0aGVy
IGNvbnNpZGVyYXRpb24sIG90aGVyIHZpcnRpbyBkcml2ZXJzIG5lZWQgYSBtaW5pbXVtIGxpbWl0
IHRvIHRoZSB2cmluZyBzaXplIHRvby4KPiA+ID4KPiA+ID4gTWF5YmUgdGhpcyBjYW4gYmUgbW9y
ZSBnZW5lcmFsLCBmb3IgZXhhbXBsZSBhIG5ldyB2aXJ0aW9fZHJpdmVyIGNhbGxiYWNrIHRoYXQg
aXMgY2FsbGVkIChpZiBpbXBsZW1lbnRlZCkgZHVyaW5nIHZpcnRpb19kZXZfcHJvYmUsIGJlZm9y
ZSBkcnYtPnByb2JlLgo+ID4gPgo+ID4gPiBXaGF0IGRvIHlvdSB0aGluaz8KPiA+ID4KPiA+ID4g
VGhhbmtzLAo+ID4gPiBBbHZhcm8KPiA+Cj4gPiBMZXQncyBzdGFydCB3aXRoIHdoYXQgeW91IGRp
ZCBoZXJlLCB3aGVuIG1vcmUgdGhhbiAyIGRyaXZlcnMgZG8gaXQgd2UnbGwKPiA+IG1vdmUgaXQg
dG8gY29yZS4KPiAKPiBJIHdvbmRlciBob3cgaGFyZCBpdCBpcyB0byBsZXQgdmlydGlvIHN1cHBv
cnQgc21hbGwgdnJpbmcgc2l6ZT8KPiAKPiBUaGFua3MKCkFjdHVhbGx5LCBJIHRoaW5rIHRoYXQg
YWxsIHlvdSBuZWVkIHRvIGRvIGlzIGRpc2FibGUgTkVUSUZfRl9TRywKYW5kIHRoaW5ncyB3aWxs
IHdvcmssIG5vPwpBbHZhcm8sIGNhbiB5b3UgdHJ5PwoKCj4gPgo+ID4gLS0KPiA+IE1TVAo+ID4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
