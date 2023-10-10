Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A57CD68F1
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 06:33:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F3F9540520;
	Tue, 10 Oct 2023 06:33:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F3F9540520
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g1WnGEoE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ahTBCRxqf89W; Tue, 10 Oct 2023 06:32:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 39AA3403AC;
	Tue, 10 Oct 2023 06:32:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 39AA3403AC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15D63C0039;
	Tue, 10 Oct 2023 06:32:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74283C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:32:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 59DCE81FB9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:32:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 59DCE81FB9
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=g1WnGEoE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hu4vHTJWX2Vq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:32:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E5E981FB8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:32:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E5E981FB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696919575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HVu0GN3UMuC1J5U/X30RP90Co4BnseMhqCL4ftuMT78=;
 b=g1WnGEoEsG94LQsXnFWDydN0/zKTXpoccIKOfeRm7pwG4trMwhYOn5EQNT5E5ejobOXZkn
 qPxNye0hC7Bz8CDn5TlR75HXiy7tiyjl0QG8dQAjTfhASwv6igS0ivPrW7LhR6P95mkXgj
 9nJhyuq/ChZFpjC343xWf1U5YZmFk8M=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-aiveZgWoNGOI-FdKtwV44g-1; Tue, 10 Oct 2023 02:32:53 -0400
X-MC-Unique: aiveZgWoNGOI-FdKtwV44g-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5042178944eso4247883e87.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 23:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696919572; x=1697524372;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HVu0GN3UMuC1J5U/X30RP90Co4BnseMhqCL4ftuMT78=;
 b=cTXUJ0NEBwV819dLE+7P+sfBwUvi5ZowxY7Uk08tWZuyp0MYdmgfmZ8XQRT6pjhilh
 SffySvR9PPnAsHaOmT05274+d2IRJR/esGnECTkmSB2Mquk+svmQtjTw6nTjmCzoWihl
 4FtSRlEndBbVmgywj5E+aC15S1mAtspoFQDakZzKV47jbpqVzpCOj6Q0JZqGNhMVCmM6
 JfNRExZ25M1/m8rStl96dLHTorFk6pv4qrM0w+u9LYyOuxtl0l2Z2fecbDNYnilBH0Hl
 LfdSYSUEblIFfG4RQgC64I/AcR+SGEIh6IW5I979BR7PA/1oXcieYZxZUB9300U139rz
 5NCA==
X-Gm-Message-State: AOJu0YxhxX8sDEE0Vrr8MLt+Hr/R0EovOqbYG1CbFNh/udWavbTbDNB6
 u4PnC1gP80ZwQu16WkDlZo1ZkZmN7oB14BP8CJ8U7lo0uZxQjiuJDdVHq0+TybLfl5IsWHW7/VN
 163NOf4cR/b71dEr8izyWvvwS/eicAfa5CL39xjgL+qDgn1w/iewRfLGrEA==
X-Received: by 2002:a05:6512:314a:b0:4ff:62a4:7aaf with SMTP id
 s10-20020a056512314a00b004ff62a47aafmr11127846lfi.2.1696919572312; 
 Mon, 09 Oct 2023 23:32:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtMFsi49pUcXNrsqLVVSMxqRi3/wpikBnKYjqg8bB3txkiYAAARR8apYbcnWGISxwA+jW/drDYstJJ6tJP3Rw=
X-Received: by 2002:a05:6512:314a:b0:4ff:62a4:7aaf with SMTP id
 s10-20020a056512314a00b004ff62a47aafmr11127828lfi.2.1696919571953; Mon, 09
 Oct 2023 23:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231009112401.1060447-1-dtatulea@nvidia.com>
 <20231009112401.1060447-16-dtatulea@nvidia.com>
In-Reply-To: <20231009112401.1060447-16-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Oct 2023 14:32:41 +0800
Message-ID: <CACGkMEveT2-iXsjvyAo9ucZgegEmw4Zs2cVvuTrH4yFfGxd0PQ@mail.gmail.com>
Subject: Re: [PATCH vhost v3 15/16] vdpa/mlx5: Make iotlb helper functions
 more generic
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
QG52aWRpYS5jb20+IHdyb3RlOgo+Cj4gVGhleSB3aWxsIGJlIHVzZWQgaW4gYSBmb2xsb3ctdXAg
cGF0Y2guCj4KPiBGb3IgZHVwX2lvdGxiLCBhdm9pZCB0aGUgc3JjID09IGRzdCBjYXNlLiBUaGlz
IGlzIGFuIGVycm9yLgo+Cj4gQWNrZWQtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRo
YXQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEu
Y29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
