Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD325C678D4
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 07:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2691B4042B;
	Tue,  7 Mar 2023 07:26:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2691B4042B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hcyXPuRU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ouoftylTxJ1t; Tue,  7 Mar 2023 07:26:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B6B064010F;
	Tue,  7 Mar 2023 07:26:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B6B064010F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 914B6C0071;
	Tue,  7 Mar 2023 07:26:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 723E8C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 07:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A8B84091A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 07:26:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A8B84091A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hcyXPuRU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jXMyWay81v-n
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 07:26:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F35140917
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F35140917
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 07:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678173978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C0N3yr2D0n//bvmW5AU0UzWXlsnYFe4KuT9Sib39vHo=;
 b=hcyXPuRUroE8eM+QeMPKFOlXk3fbGD17PdJyInZhpigIp+dK3heVkTyhmsrtIaGbQvsTBg
 SDKOG5WBJUSlWAIzIT3Dk51f/ve3D0YyN7tJ2ghP1tkY+/TcxC+jLhsLF1Eykh1NESc1OD
 4zpHaj0gSD30l8Ycn651714awKNGJc0=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-NvGpu7AROBKhwoqVvUXSNw-1; Tue, 07 Mar 2023 02:26:17 -0500
X-MC-Unique: NvGpu7AROBKhwoqVvUXSNw-1
Received: by mail-oi1-f198.google.com with SMTP id
 bi38-20020a05680818a600b0037b36626937so5115962oib.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Mar 2023 23:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678173976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C0N3yr2D0n//bvmW5AU0UzWXlsnYFe4KuT9Sib39vHo=;
 b=zjUSFORLTEXRlr1q3kPa/QeDXa45AvUwuOtFdj9ww6Unw6QIYODajOJmX7VfVE8WmM
 vFnwP9X/KsFlWhbOPyzr6xuhf8PBpr8by5aZTOREuAXCZwPclyTOfCHupl/juMsBEseT
 Jm5sZ/24+jHNsPhe0s+NqK9/MrnZDVP97ITXAO8O36sj46G16WJwquSMZAD0oXRn1EPq
 An08m9YLsTtekNzs/AuNJBowF+Z1a9YdHfpjZk63ZBy+Y9xYe8WtgNuYZCEblE5j8//o
 q5jhwmOXJoG36tG6YRdjmJanbRHFFRgU/a9oKdhxMV5k7tuIOVsBpMBmJs6LLUXxLxHK
 GcMw==
X-Gm-Message-State: AO0yUKV4JRfrth1UF+AtKmQfAmCn8ylMFoS+TKq4fs4i0QNNaee2fEoL
 TS6/ahDV66hPqDf8bhff4SadodXAJtD+uEKp6YA83OTkAxIX6BLFIJ6hWwgj/dan5Nrp7YyIfDz
 M6uV8LgKWwXcInWEYblpanZKdPZIy5TKZvrUI0lB3UbDrnr5Q2awR9NeuRQ==
X-Received: by 2002:a54:4810:0:b0:384:4e2d:81ea with SMTP id
 j16-20020a544810000000b003844e2d81eamr4364913oij.9.1678173976345; 
 Mon, 06 Mar 2023 23:26:16 -0800 (PST)
X-Google-Smtp-Source: AK7set/yWmAmkrZoh3sXtiWqFkEs+35eUsn8N6EW6JW0lnDZnTBEh/0/0GOdejKcbi4AMupvstMks2xeKIx/FWYm3Wg=
X-Received: by 2002:a54:4810:0:b0:384:4e2d:81ea with SMTP id
 j16-20020a544810000000b003844e2d81eamr4364904oij.9.1678173976152; Mon, 06 Mar
 2023 23:26:16 -0800 (PST)
MIME-Version: 1.0
References: <20230305154942.1770925-1-alvaro.karsz@solid-run.com>
 <CACGkMEuc_MtVpM2bJH20dmXC30Po8Fbd2Y-xv-Q=O13=pLSLpA@mail.gmail.com>
 <AM0PR04MB4723D2274F037EDD814007A7D4B69@AM0PR04MB4723.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4723D2274F037EDD814007A7D4B69@AM0PR04MB4723.eurprd04.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 7 Mar 2023 15:26:05 +0800
Message-ID: <CACGkMEv4Cw+W2KKZXchCLcqo3Gy8HyBokG-Hw3QXnZmmSwW+gw@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: unify notifications coalescing structs
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gTW9uLCBNYXIgNiwgMjAyMyBhdCAzOjQ44oCvUE0gQWx2YXJvIEthcnN6IDxhbHZhcm8ua2Fy
c3pAc29saWQtcnVuLmNvbT4gd3JvdGU6Cj4KPiA+IElzIHRoaXMgdG9vIGxhdGUgdG8gYmUgY2hh
bmdlZD8KPiA+Cj4gPiBUaGFua3MKPgo+IFlvdSdyZSByaWdodC4KPiBXaGF0IGRvIHlvdSBzdWdn
ZXN0LCBkcm9wcGluZyB0aGUgcGF0Y2ggb3IgYWRkaW5nIHRoZSB1bmlmaWVkIHN0cnVjdCB3aXRo
b3V0IGRlbGV0aW5nIHRoZSBleGlzdGluZyBvbmVzPwoKQXQgbGVhc3Qgd2UgbmVlZCB0byBhdm9p
ZCB0b3VjaGluZyBleGlzdGluZyB1QVBJIHN0cnVjdHVyZXMuCgpJIHRoaW5rIHdlIGNhbiBsZWF2
ZSB0aGUgY29kZSBhcyBpcyBidXQgd2UgY2FuIGhlYXIgZnJvbSBvdGhlcnMuCgpUaGFua3MKCj4K
PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
