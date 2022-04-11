Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F555C433EF
	for <virtualization@archiver.kernel.org>; Mon, 11 Apr 2022 08:52:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F02064157E;
	Mon, 11 Apr 2022 08:52:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2NsazLLsk3rU; Mon, 11 Apr 2022 08:52:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1211A410CA;
	Mon, 11 Apr 2022 08:52:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9FF7C002F;
	Mon, 11 Apr 2022 08:52:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6B80C002C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 08:52:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A8E8D607F9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 08:52:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NsLpFhA9yMK2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 08:52:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F0231607F6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 08:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649667166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3vhVjgwfYwcRcHV2AMePulXHtfyrvzl0sIkmLC3McIg=;
 b=egs1BLSWwNc7QoaaHS9lguHxOQ0gUS4Ef5fssBCnGwISSy69eCq+XfRfauKky0h5V8piTZ
 BMJtZFcVtANInGMo97wTaEl/iGWp8+XuPn+zvH3IZzrHikKQ2tL4NeAtUhglQc8EJn5ttA
 zL6rKIieF0q7K9GLlFv4iCEfbFZG1SM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-LNBiYHcJOzGejCgaempHtQ-1; Mon, 11 Apr 2022 04:52:42 -0400
X-MC-Unique: LNBiYHcJOzGejCgaempHtQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 h7-20020a2eb0e7000000b0024b6115035dso1081591ljl.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 01:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3vhVjgwfYwcRcHV2AMePulXHtfyrvzl0sIkmLC3McIg=;
 b=Amn7lpCufmY6fY/JSwQpSTvIbEnmH5iXTDrZ4a5+ejUBf7sG/cMH88kmxYggSPtxIq
 JFxM0FYjd12w07gf8Tc/+SHLWF01onz6Dl3gpUb046y6ZX/2uQQ6PsS1bf/wfvZgNW9f
 GcwO6b4cdZA9UZGRmyZhtQhGbgJvLDkKssBhG+Mg2qWsoqrsXkzuqEv/QF8xuFk2Zn18
 tLxSr7HF5Rk4Bkij1y7QL7z7dyPNhikrR1vgjrclNYtCxol2ZVgDx7mXHDkmNtvMty1C
 gD2fMZp7m46UwsLCA8RxU6UvHpRN1gHmRrMVjmqydrSsY1WMvAloEawZnOEKB9EM7nUI
 tZ6Q==
X-Gm-Message-State: AOAM532nPkuNPEM0eba1763nWNgnKqKHfkt/7yhuyHz8TFvw+dkUG0+C
 W2I7eTSh22vaU5wePVyyXdVtQJsX1WqjcS15atYaNZ30idbHLbPQy6r0atUE7oVCyXC1xC1m427
 V4wx4D8dIYy7cvTBlXVJOXU4RM9hn2jvUoIJs7tXmZgIsMPTpPgNrJEIB+w==
X-Received: by 2002:a2e:534a:0:b0:24a:f64f:a1d6 with SMTP id
 t10-20020a2e534a000000b0024af64fa1d6mr19829766ljd.315.1649667161213; 
 Mon, 11 Apr 2022 01:52:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaCCcq7nzVRPmSTC73Cx4/AdfiCOSQZBHo+c8EM69IwSw30oxA7oVSPieHafcAVtM2ZPlOdRk8jntSD0+GICQ=
X-Received: by 2002:a2e:534a:0:b0:24a:f64f:a1d6 with SMTP id
 t10-20020a2e534a000000b0024af64fa1d6mr19829758ljd.315.1649667161018; Mon, 11
 Apr 2022 01:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220411014039.3368218-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220411014039.3368218-1-peng.fan@oss.nxp.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Apr 2022 16:52:30 +0800
Message-ID: <CACGkMEtnXPBvv1W8SdT0Hv4riShQP3Du+EMv0XNgOGNmmfS6ng@mail.gmail.com>
Subject: Re: [PATCH] tools/virtio: drop phys_addr_t typedef
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Peng Fan <peng.fan@nxp.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mst <mst@redhat.com>
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

T24gTW9uLCBBcHIgMTEsIDIwMjIgYXQgOTozOSBBTSBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5A
b3NzLm54cC5jb20+IHdyb3RlOgo+Cj4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+
Cj4KPiBXaXRoIGNvbW1pdCA4ODRlZTFlNTg1Y2EgKCJ0b29scy9pbmNsdWRlOiBBZGQgcGh5c19h
ZGRyX3QgdG8gdHlwZXMuaCIpLAo+Cj4gV2hlbiBidWlsZGluZyB2aXJ0aW8gdG9vbHMsIHRoZXJl
IGlzIGEgdHlwZSBjb25maWN0aW5nIGVycm9yOgo+Cj4gIgo+IC4vbGludXgva2VybmVsLmg6MzI6
Mjg6IGVycm9yOiBjb25mbGljdGluZyB0eXBlcyBmb3Ig4oCYcGh5c19hZGRyX3TigJkKPiAgICAz
MiB8IHR5cGVkZWYgdW5zaWduZWQgbG9uZyBsb25nIHBoeXNfYWRkcl90Owo+ICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn4KPiBJbiBmaWxlIGluY2x1ZGVkIGZy
b20gL3Vzci9pbmNsdWRlL2xpbnV4L3ZpcnRpb19ibGsuaDoyOCwKPiAgICAgICAgICAgICAgICAg
IGZyb20gdmlydGlvLWl2c2htZW0tYmxvY2suYzoyOToKPiAuLi9pbmNsdWRlL2xpbnV4L3R5cGVz
Lmg6Njk6MTM6IG5vdGU6IHByZXZpb3VzIGRlY2xhcmF0aW9uIG9mIOKAmHBoeXNfYWRkcl904oCZ
IHdhcyBoZXJlCj4gICAgNjkgfCB0eXBlZGVmIHUzMiBwaHlzX2FkZHJfdDsKPiAgICAgICB8ICAg
ICAgICAgICAgIF5+fn5+fn5+fn5+Cj4gIgo+Cj4gTGV0J3MgZHJvcCB0aGUgdHlwZWRlZiBpbiB0
b29scy92aXJ0aW8vbGludXgva2VybmVsLmgKPgo+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxw
ZW5nLmZhbkBueHAuY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+Cgo+IC0tLQo+ICB0b29scy92aXJ0aW8vbGludXgva2VybmVsLmggfCAxIC0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS90b29scy92aXJ0aW8vbGlu
dXgva2VybmVsLmggYi90b29scy92aXJ0aW8vbGludXgva2VybmVsLmgKPiBpbmRleCAwYjQ5MzU0
MmU2MWEuLjFkMzI0OGUzZjI3MCAxMDA2NDQKPiAtLS0gYS90b29scy92aXJ0aW8vbGludXgva2Vy
bmVsLmgKPiArKysgYi90b29scy92aXJ0aW8vbGludXgva2VybmVsLmgKPiBAQCAtMjksNyArMjks
NiBAQAo+ICAjZGVmaW5lIFJFQUQgICAgICAgICAgICAgICAgICAgIDAKPiAgI2RlZmluZSBXUklU
RSAgICAgICAgICAgICAgICAgICAxCj4KPiAtdHlwZWRlZiB1bnNpZ25lZCBsb25nIGxvbmcgcGh5
c19hZGRyX3Q7Cj4gIHR5cGVkZWYgdW5zaWduZWQgbG9uZyBsb25nIGRtYV9hZGRyX3Q7Cj4gIHR5
cGVkZWYgc2l6ZV90IF9fa2VybmVsX3NpemVfdDsKPiAgdHlwZWRlZiB1bnNpZ25lZCBpbnQgX193
c3VtOwo+IC0tCj4gMi4yNS4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
