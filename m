Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE201CD68EE
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 06:30:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3802E414D8;
	Tue, 10 Oct 2023 06:30:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3802E414D8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hU26W71+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HpsEFaWRuKMZ; Tue, 10 Oct 2023 06:30:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 93E98414E5;
	Tue, 10 Oct 2023 06:30:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 93E98414E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B0D1C0039;
	Tue, 10 Oct 2023 06:30:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A974C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:30:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5995E403AC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:30:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5995E403AC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hU26W71+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s6v-u2qwVN4Q
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:30:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 204D640232
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:30:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 204D640232
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696919452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i8kjDRjOJKKJXRR5u7v3wOkH6EfelrGYi06F0LmbMIM=;
 b=hU26W71+JHJV5zufsJXEs/cPxSzP9yCGUQCXEIu1n5L+O2C/xbIDGF2mmt3cBU7c+1EzT6
 yTA8XfNDwDfrZMCZBUHserAtu2vtyVA2AEi7PX+22qGoRj3jiA0vdBNgE4FpPySk9MpMdu
 KY2G633ma3cfNnE5qo4FRQIEstRVr/c=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-6A6jbQFYP-eokt4VsEXSuw-1; Tue, 10 Oct 2023 02:30:50 -0400
X-MC-Unique: 6A6jbQFYP-eokt4VsEXSuw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5041a779c75so4604503e87.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 23:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696919449; x=1697524249;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i8kjDRjOJKKJXRR5u7v3wOkH6EfelrGYi06F0LmbMIM=;
 b=lMWDi0y6nD7hnAyjvdpJr79LM5Z/WCkuwJDmkHwTr7CE9QkyIWXiNRDb5asmUi+WhG
 fnr/N9+QOfUndE4bf03YntXsT5cKjQaQDdiZgNOGyL8VOtHyOevU4Z18Rj4GgBxiRq3w
 tYFe2Q0BnIFR+yErQPzLFClGN6r2jmHiu7wbMUvweA5I5US9assuIfJF2t86TAW1gGMJ
 cmgkLy1/Lg1Gl9wW9Gy+R8Rxlct92NLURRkBSULCJIHsLXbur8MWee+h0WwnxykEhjPl
 eqZhZiwfaZCgwXG/bsuLt6VURubvs9y++5d6Q8NGhJWBmK4Q/fYjtTDg9he1QuZ116b/
 E0Mw==
X-Gm-Message-State: AOJu0YxuUJ7vMzK5Exd5FA5KUO3rjimWaApWqeMPZq6ThO5mkTNQZ+dh
 ry5oF1Kfp3gtLYQlr2+TocTqcpkpkRSF8b+w18v+l7wWRu0L+nhFrd7laq9SI6kO/WcOQLNwqqp
 +IJ9tIWRsXG1DU/TqaXJXvZLUFUYJbOkEdJHXJUO2yDb9a9CeyZSSkY8weQ==
X-Received: by 2002:ac2:5f89:0:b0:4fb:89e2:fc27 with SMTP id
 r9-20020ac25f89000000b004fb89e2fc27mr12884995lfe.54.1696919449076; 
 Mon, 09 Oct 2023 23:30:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmDA/vg0tl4u4YUxBy8HtRi4GakgkYvYLlL5YgdSd3QDLzEy3RLtMK2lk5R1+3JDmVtS3GeTuqJDtI9tK9sac=
X-Received: by 2002:ac2:5f89:0:b0:4fb:89e2:fc27 with SMTP id
 r9-20020ac25f89000000b004fb89e2fc27mr12884990lfe.54.1696919448905; Mon, 09
 Oct 2023 23:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231009112401.1060447-1-dtatulea@nvidia.com>
 <20231009112401.1060447-14-dtatulea@nvidia.com>
In-Reply-To: <20231009112401.1060447-14-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Oct 2023 14:30:38 +0800
Message-ID: <CACGkMEupdNSyE-cNCwePjobn8V3rSMi=TV0imfTAUBbAyaeKjQ@mail.gmail.com>
Subject: Re: [PATCH vhost v3 13/16] vdpa/mlx5: Introduce mr for vq descriptor
To: Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eugenio Perez Martin <eperezma@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>
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

T24gTW9uLCBPY3QgOSwgMjAyMyBhdCA3OjI14oCvUE0gRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVh
QG52aWRpYS5jb20+IHdyb3RlOgo+Cj4gSW50cm9kdWNlIHRoZSB2cSBkZXNjcmlwdG9yIGdyb3Vw
IGFuZCBtciBwZXIgQVNJRC4gVW50aWwgbm93Cj4gLnNldF9tYXAgb24gQVNJRCAxIHdhcyBvbmx5
IHVwZGF0aW5nIHRoZSBjdnEgaW90bGIuIEZyb20gbm93IG9uIGl0IGFsc28KPiBjcmVhdGVzIGEg
bWtleSBmb3IgaXQuIFRoZSBjdXJyZW50IHBhdGNoIGRvZXNuJ3QgdXNlIGl0IGJ1dCBmb2xsb3ct
dXAKPiBwYXRjaGVzIHdpbGwgYWRkIGhhcmR3YXJlIHN1cHBvcnQgZm9yIG1hcHBpbmcgdGhlIHZx
IGRlc2NyaXB0b3JzLgo+Cj4gQWNrZWQtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRo
YXQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEu
Y29tPgo+IC0tLQoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpU
aGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
