Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD86ECA0ECE
	for <virtualization@archiver.kernel.org>; Tue, 12 Sep 2023 03:18:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1358460A98;
	Tue, 12 Sep 2023 03:18:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1358460A98
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ThJl6Amy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8hIXSOh4O5Cv; Tue, 12 Sep 2023 03:18:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 312D760A65;
	Tue, 12 Sep 2023 03:18:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 312D760A65
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA37BC0071;
	Tue, 12 Sep 2023 03:18:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32DF5C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 03:18:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07DF54018B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 03:18:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07DF54018B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ThJl6Amy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u1XK6Cn-mpo0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 03:18:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50EDB40003
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 03:18:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 50EDB40003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694488711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yeybBoB7J55cAsRT4vB+kKuTH4cQaXdnVyGYiAsXlEA=;
 b=ThJl6AmynftDm4w0i01EJM6UqGcK8cWiRQotIkgBmm7w/evSydaVBXS+SmHQ9h3UZ1Ndr9
 8cHoPIYyl7FNdUInEG1Y/BGpxT/VoE6ZD/SPlTw0N6ajlUXkcIRIFqUXRvoLg2hN5EiwBW
 nu0Dl1TkTeINZQRCYeAOvAVZgSwzc/U=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-g2lxnv9_PJC7Az1CeAnZzA-1; Mon, 11 Sep 2023 23:18:29 -0400
X-MC-Unique: g2lxnv9_PJC7Az1CeAnZzA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5008240846fso3262418e87.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 20:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694488708; x=1695093508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yeybBoB7J55cAsRT4vB+kKuTH4cQaXdnVyGYiAsXlEA=;
 b=kwemjJERjrZpaT9EzCcqDEA+aRbff9vI/OqkNyYy2bT/QGiyG8NjB6GKtjP9osKZ+h
 6ovgqZJpuEYhksWVovobr4xd3180FhWSNk9/g25Y3gNGCRzk+rHMNvd64JDGOb/ex5qZ
 F2L6Aea+AjYF5FzjJ+nDe58R5wGQMNBZJFx2DZ1+EfzNDFRwSD2GrEa/RKC91MMtEa55
 8Fnq+VVDcQBncI8JqylP8UA2cFICxzoCrxNIPiqu1bJtVx9fZT+BB3vUclu5vCPPqSJ0
 RUFOhh/8HeYfCs1v5vBhSO6HXi/0dPPvRrlzizD0Vq1v3he10y/j+0Iw1bkSALtKcWnL
 XOkw==
X-Gm-Message-State: AOJu0Yxkd7Xn6q4/TX1rIFNujGtZGIsyxGxBT252p483aGz0Un4WijrA
 bbG6jrJAyuN5tQPVf411Q93PBvGkvjTtnsEo4mm+He1vXbSKOpeAwyHwdmIBlrEM+NFhiLTXYj0
 Yke6mSlgapccOAMrg6POaDRveP7di7rjpm+P1xGiy1YlZ+3nKT5zDjqW0SQ==
X-Received: by 2002:a05:6512:2316:b0:4fe:bfa:9d8b with SMTP id
 o22-20020a056512231600b004fe0bfa9d8bmr483630lfu.12.1694488708171; 
 Mon, 11 Sep 2023 20:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcI0EBEc/QXrime6KsTNxJiED9DaU9PSMy94XNYwPaePPhMWRnYMoxdWeG/PqyWi06hFiToOQxQZyCUvQ+zf4=
X-Received: by 2002:a05:6512:2316:b0:4fe:bfa:9d8b with SMTP id
 o22-20020a056512231600b004fe0bfa9d8bmr483618lfu.12.1694488707796; Mon, 11 Sep
 2023 20:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230911180815.820-1-shannon.nelson@amd.com>
In-Reply-To: <20230911180815.820-1-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Sep 2023 11:18:16 +0800
Message-ID: <CACGkMEtkieLpkwifTEUw7ROpj8Ywb8BBspzJRoL6qj_O5+ZFQw@mail.gmail.com>
Subject: Re: [PATCH iproute2] vdpa: consume device_features parameter
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, allen.hubbe@amd.com, netdev@vger.kernel.org,
 dsahern@kernel.org, virtualization@lists.linux-foundation.org,
 drivers@pensando.io
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

T24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgMjowOOKAr0FNIFNoYW5ub24gTmVsc29uIDxzaGFubm9u
Lm5lbHNvbkBhbWQuY29tPiB3cm90ZToKPgo+IEZyb206IEFsbGVuIEh1YmJlIDxhbGxlbi5odWJi
ZUBhbWQuY29tPgo+Cj4gQ29uc3VtZSB0aGUgcGFyYW1ldGVyIHRvIGRldmljZV9mZWF0dXJlcyB3
aGVuIHBhcnNpbmcgY29tbWFuZCBsaW5lCj4gb3B0aW9ucy4gIE90aGVyd2lzZSB0aGUgcGFyYW1l
dGVyIG1heSBiZSB1c2VkIGFnYWluIGFzIGFuIG9wdGlvbiBuYW1lLgo+Cj4gICMgdmRwYSBkZXYg
YWRkIC4uLiBkZXZpY2VfZmVhdHVyZXMgMHhkZWFkYmVlZiBtYWMgMDA6MTE6MjI6MzM6NDQ6NTUK
PiAgVW5rbm93biBvcHRpb24gIjB4ZGVhZGJlZWYiCj4KPiBGaXhlczogYTQ0NDJjZTU4ZWJiICgi
dmRwYTogYWxsb3cgcHJvdmlzaW9uaW5nIGRldmljZSBmZWF0dXJlcyIpCj4gU2lnbmVkLW9mZi1i
eTogQWxsZW4gSHViYmUgPGFsbGVuLmh1YmJlQGFtZC5jb20+Cj4gUmV2aWV3ZWQtYnk6IFNoYW5u
b24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPgo+IFJldmlld2VkLWJ5OiBTaS1XZWkg
TGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPiAtLS0KPiAgdmRwYS92ZHBhLmMgfCAyICsrCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS92ZHBhL3ZkcGEu
YyBiL3ZkcGEvdmRwYS5jCj4gaW5kZXggOGJiZTQ1MmMuLjZlNGE5YzExIDEwMDY0NAo+IC0tLSBh
L3ZkcGEvdmRwYS5jCj4gKysrIGIvdmRwYS92ZHBhLmMKPiBAQCAtMzUzLDYgKzM1Myw4IEBAIHN0
YXRpYyBpbnQgdmRwYV9hcmd2X3BhcnNlKHN0cnVjdCB2ZHBhICp2ZHBhLCBpbnQgYXJnYywgY2hh
ciAqKmFyZ3YsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgJm9wdHMtPmRldmljZV9mZWF0dXJlcyk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYg
KGVycikKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBlcnI7Cj4gKwo+
ICsgICAgICAgICAgICAgICAgICAgICAgIE5FWFRfQVJHX0ZXRCgpOwo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIG9fZm91bmQgfD0gVkRQQV9PUFRfVkRFVl9GRUFUVVJFUzsKPiAgICAgICAgICAg
ICAgICAgfSBlbHNlIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICBmcHJpbnRmKHN0ZGVyciwg
IlVua25vd24gb3B0aW9uIFwiJXNcIlxuIiwgKmFyZ3YpOwo+IC0tCj4gMi4xNy4xCj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
