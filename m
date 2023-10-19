Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C63CDB465
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 06:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73B4B4285A;
	Thu, 19 Oct 2023 06:37:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 73B4B4285A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZE0CavZ4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5LYHbYD6LRkW; Thu, 19 Oct 2023 06:37:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0DEB542865;
	Thu, 19 Oct 2023 06:37:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0DEB542865
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E468BC0071;
	Thu, 19 Oct 2023 06:37:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86659C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:37:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6128C6FAD3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:37:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6128C6FAD3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZE0CavZ4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wBoB0BNOWEEd
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:37:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F2DCB6FAD2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:37:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F2DCB6FAD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697697422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b7YGdF4c/ZFxSg9nV/ChxJMQEFQk8yK6EpVnN33SpoY=;
 b=ZE0CavZ4Az2H38z1wjm6qlKXxVpBTBE8Fffsa2BRbt3IZ0nsI482x5tr0meC7WpPfCxrEc
 mZbim/igWhFI0srBRNNQWtRUgQ41eqzDXtuE49KinZGKvKAZfIe/uL1KtT9acj9sU/A74o
 IXfffRK1aV3qyZisjXh4tFxybNTeg4w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-QS5CEP1PNQiKov3EVuX2Ww-1; Thu, 19 Oct 2023 02:37:01 -0400
X-MC-Unique: QS5CEP1PNQiKov3EVuX2Ww-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40647c6f71dso52455955e9.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 23:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697697420; x=1698302220;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b7YGdF4c/ZFxSg9nV/ChxJMQEFQk8yK6EpVnN33SpoY=;
 b=slRNw0F3zGFkiY/CNcbjTkN2iuoD66Vxtu9lo4RpLvtx19S8KYWFKKzKDj0ilexEIf
 Viw3guA75Vl4PzKB6gl7wtY8QLjbhtGo+3zK4erJ8zuV9r12eiQZ6MSfaWlBOXsR1aul
 o5RBN9kF87sZYqeWY8CHWlotHQDMPZ7yHxe0Ec7oUcBWAG/aRs2GmGf903JJ/DwwZz92
 NnjZeTloZ/ZWD6zDCpoQPTQIhRxmZwGlLl+YJeA92x9hZZa3T2sx1ZL/E8JMiROUMIEI
 +8YZFZEANwLYiZFfquMYHriOTmy4bXNQy52u+ZIWbaaVexxfvvtWE/POmauU9JDiLnxs
 dZkw==
X-Gm-Message-State: AOJu0YzdBfFNiqO/FLPvJcluFWx61Ns0OStKyoRJvZsYXnHc8xzzI7Ja
 3GpibBbTI/yVXm4ncf0FDEPJO368yNWfxuFS2nJEgKrBvx/XYivj09eBLK+PyVvC5LlJ9vbjRtu
 th3gSuFN9jc6uiNtrt0GOYNsHFbssesZuQMa/umhKAQ==
X-Received: by 2002:a05:6000:1287:b0:32d:b081:ff32 with SMTP id
 f7-20020a056000128700b0032db081ff32mr625920wrx.38.1697697420043; 
 Wed, 18 Oct 2023 23:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8iY58YnHTQToYzw01jGs6sEhJQ8nc4mS2k2A0gX5GvAr8vDJCYQUcwBMyolUVLl/6NSgiWA==
X-Received: by 2002:a05:6000:1287:b0:32d:b081:ff32 with SMTP id
 f7-20020a056000128700b0032db081ff32mr625899wrx.38.1697697419713; 
 Wed, 18 Oct 2023 23:36:59 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 q7-20020adffec7000000b0031980294e9fsm3684591wrs.116.2023.10.18.23.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 23:36:59 -0700 (PDT)
Date: Thu, 19 Oct 2023 02:36:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next v1 05/19] virtio_net: add prefix virtnet to all
 struct/api inside virtio_net.h
Message-ID: <20231019023548-mutt-send-email-mst@kernel.org>
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEvQvyjxX7PKVtTjMMtQNX3PzuviL=sA5sMftEToduZ5RA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvQvyjxX7PKVtTjMMtQNX3PzuviL=sA5sMftEToduZ5RA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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

T24gVGh1LCBPY3QgMTksIDIwMjMgYXQgMDI6MTQ6MjdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBNb24sIE9jdCAxNiwgMjAyMyBhdCA4OjAx4oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1
b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPgo+ID4gV2UgbW92ZSBzb21lIHN0cnVjdHVy
ZXMgYW5kIEFQSXMgdG8gdGhlIGhlYWRlciBmaWxlLCBidXQgdGhlc2UKPiA+IHN0cnVjdHVyZXMg
YW5kIEFQSXMgZG8gbm90IHByZWZpeGVkIHdpdGggdmlydG5ldC4gVGhpcyBwYXRjaCBhZGRzCj4g
PiB2aXJ0bmV0IGZvciB0aGVzZS4KPiAKPiBXaGF0J3MgdGhlIGJlbmVmaXQgb2YgZG9pbmcgdGhp
cz8gQUZBSUsgdmlydGlvLW5ldCBpcyB0aGUgb25seSB1c2VyCj4gZm9yIHZpcnRpby1uZXQuaD8K
PiAKPiBUSGFua3MKCklmIHRoZSBzcGxpdCB0YWtlcyBwbGFjZSBJLCBmb3Igb25lLCB3b3VsZCBi
ZSBoYXBweSBpZiB0aGVyZSdzIHNvbWUgd2F5CnRvIHRlbGwgd2hlcmUgdG8gbG9vayBmb3IgYSBn
aXZlbiBzdHJ1Y3R1cmUvQVBJIGp1c3QgZnJvbSB0aGUgbmFtZS4KCi0tIApNU1QKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
