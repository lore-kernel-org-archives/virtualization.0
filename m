Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EF6C77B70
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 03:24:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47FDE81FF7;
	Mon, 17 Apr 2023 03:24:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47FDE81FF7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eLCoBmYI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KcEQeuCakYCp; Mon, 17 Apr 2023 03:24:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B953081FE5;
	Mon, 17 Apr 2023 03:24:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B953081FE5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BBD4C0037;
	Mon, 17 Apr 2023 03:24:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BC6BC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 03:24:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C6BCD81FE6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 03:24:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6BCD81FE6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LgIDjNTUx7d6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 03:24:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A89581FE5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A89581FE5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 03:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681701872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zKGM0UuJktFVFn7nlGHkLlmdThLbMLf0gM6cQd9y1wc=;
 b=eLCoBmYIv96A7afubkOgJKvjZjLWbhxSE+M6P4i3XmnQGoN9f9vp8uO6Ryrpqa3mFOEhsW
 FhjZmJ3t5kChMN3fzwZJ5qpIZ7Qz8D0UFHZqQUsWm0AdrRj1lW+4mg5nvVTnyneaU7v8FD
 oPM2IZzyNRc2RiqFyq93b7NPcR14AME=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-zzM0UAS-NxqE9v8W_CCLfQ-1; Sun, 16 Apr 2023 23:24:28 -0400
X-MC-Unique: zzM0UAS-NxqE9v8W_CCLfQ-1
Received: by mail-ot1-f71.google.com with SMTP id
 l8-20020a05683004a800b006a384299c67so11080426otd.6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Apr 2023 20:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681701867; x=1684293867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zKGM0UuJktFVFn7nlGHkLlmdThLbMLf0gM6cQd9y1wc=;
 b=GBGrQ94IZmqXZ3tAkcFjCmB+Ey5WOfhskjXsKcVCDbz33woaL8WVyNPlo012J4CftS
 Qw+uXQxrUnIQSz7ylg27+0ZjMqwn/HrsMmasQguhlMl2Ek1Iv1YCtzvquT2ze/aWMbvx
 vgzR7xG1alG0LNQLNY4XLuPKppUtCRbkMrKcJkH6yw/NjhSU03KF2HiLvDkqmxqov1tN
 COL2gDLUUiKqNly+VHgdHKZgVFYBz/Epg2DNFh04D139EvoXRMdwY+SoUPQLIZd6ShbI
 hzbdLqk9EMPyoWwP/4NyHclNVsTZpTudzBealXe+wLOcOQqIPEkrkE+tKryFEBo+BPGb
 dLcw==
X-Gm-Message-State: AAQBX9dXlqO7HTAQgGbwqeJqoxJMc3cNi5SFukagEwp1Hd3AbZGnjpDi
 QIj/YItZV9KQZZCTIOtqOZG7XF4N5/0G30Xq9Sj2gHxfbaioRfQVYHrraBAEyjl8ZXa5VPZQxyF
 OQCewDC5SIRPE28/sKfVsMi+1q9WeinqehT6cDwHyfYg0iyVBtzEifEbDvg==
X-Received: by 2002:a05:6870:3489:b0:187:7f2e:98d6 with SMTP id
 n9-20020a056870348900b001877f2e98d6mr5063285oah.9.1681701867834; 
 Sun, 16 Apr 2023 20:24:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350btdvSh+yfsA0KDTP5tl/3eCzJUDrZFp6vNFLcoded+JiAPxym7277acm9HPgpEBflChrr5DV/GvuTzFRR65KI=
X-Received: by 2002:a05:6870:3489:b0:187:7f2e:98d6 with SMTP id
 n9-20020a056870348900b001877f2e98d6mr5063275oah.9.1681701867587; Sun, 16 Apr
 2023 20:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230416074607.292616-1-alvaro.karsz@solid-run.com>
 <AM0PR04MB4723C6E99A217F51973710F5D49F9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230416164453-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230416164453-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Apr 2023 11:24:16 +0800
Message-ID: <CACGkMEvFhVyWb5+ET_akPvnjUq04+ZbJC8o_GtNBWqSMGNum8A@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

T24gTW9uLCBBcHIgMTcsIDIwMjMgYXQgNDo0NeKAr0FNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gU3VuLCBBcHIgMTYsIDIwMjMgYXQgMDQ6NTQ6NTdQ
TSArMDAwMCwgQWx2YXJvIEthcnN6IHdyb3RlOgo+ID4gQWZ0ZXIgZnVydGhlciBjb25zaWRlcmF0
aW9uLCBvdGhlciB2aXJ0aW8gZHJpdmVycyBuZWVkIGEgbWluaW11bSBsaW1pdCB0byB0aGUgdnJp
bmcgc2l6ZSB0b28uCj4gPgo+ID4gTWF5YmUgdGhpcyBjYW4gYmUgbW9yZSBnZW5lcmFsLCBmb3Ig
ZXhhbXBsZSBhIG5ldyB2aXJ0aW9fZHJpdmVyIGNhbGxiYWNrIHRoYXQgaXMgY2FsbGVkIChpZiBp
bXBsZW1lbnRlZCkgZHVyaW5nIHZpcnRpb19kZXZfcHJvYmUsIGJlZm9yZSBkcnYtPnByb2JlLgo+
ID4KPiA+IFdoYXQgZG8geW91IHRoaW5rPwo+ID4KPiA+IFRoYW5rcywKPiA+IEFsdmFybwo+Cj4g
TGV0J3Mgc3RhcnQgd2l0aCB3aGF0IHlvdSBkaWQgaGVyZSwgd2hlbiBtb3JlIHRoYW4gMiBkcml2
ZXJzIGRvIGl0IHdlJ2xsCj4gbW92ZSBpdCB0byBjb3JlLgoKSSB3b25kZXIgaG93IGhhcmQgaXQg
aXMgdG8gbGV0IHZpcnRpbyBzdXBwb3J0IHNtYWxsIHZyaW5nIHNpemU/CgpUaGFua3MKCj4KPiAt
LQo+IE1TVAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
