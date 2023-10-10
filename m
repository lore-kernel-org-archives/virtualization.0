Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96431CD68F1
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 06:33:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 48935405B7;
	Tue, 10 Oct 2023 06:33:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48935405B7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WeeaElO5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kq0tleiUIyzu; Tue, 10 Oct 2023 06:33:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8454D403AC;
	Tue, 10 Oct 2023 06:33:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8454D403AC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CD00C0039;
	Tue, 10 Oct 2023 06:33:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59602C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:33:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 277FF405B7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:33:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 277FF405B7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 55-wbx42YzAE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:33:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 70370403AC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:33:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 70370403AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696919616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L/WWvP4QrvqQqSlBOZhfRHFJcoPieF7wXeR0DebzApE=;
 b=WeeaElO5p1VKAz5J6GjcbIOHxDoPyfOdcPmZYCsE7TuW2FSaPx9dcXqjEk8EdxLd2fBjMc
 gSn9HkDLq8PH6+EB4tHnW9DHJlkPtM8t8rp4Jtg+xBTsRihsnYAkwR/ym6Y74rC2+VtDqE
 TBU4H6CIV6PS72bIjCKMqS7S/ZmgFv4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-64-UGalDPMyGbxgzdwWSEg-1; Tue, 10 Oct 2023 02:33:27 -0400
X-MC-Unique: 64-UGalDPMyGbxgzdwWSEg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50433ca6d81so4876971e87.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 23:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696919606; x=1697524406;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L/WWvP4QrvqQqSlBOZhfRHFJcoPieF7wXeR0DebzApE=;
 b=ctkP96+07Es33T4RZuOlA+mxO3csNTZ1bbKEgYJ+tJSSWKkLqGmrEIgapDsoT6/Pfx
 oJzPOThCrNd+rfN9EWI9LAVL/0hUhgeRmVlWQ+ftbaGFAaOAXCB0xx1rDAvc5ZwT18nn
 DP4Ou9SY07vyeop3YodR1eYCoJfHn7NtKmZV9WR1BiYW65c3DzdAV56VQ0wargaVTE0w
 MA/X1cccq2N6YUP1dAh1Fom5fkUoHSIYJOSg8gVdTEtHKF+y3TynnSy5iYZFEjA7Oxgu
 +ihKhFkYgXOsci7ETmUhJ6C9BdPj4Lwdft7jDtDtbE3BShIQ8C/sr2QjE7npCqRXjR6B
 SojQ==
X-Gm-Message-State: AOJu0YyE4QALjXPDIR35cIO57yjXmEC1y6NEmGjEmFhoKSihdEsd4fbW
 9NUL278dbCZXjLwN7SR+s4b2P4srynXlfHT3LXjdEMNuCBieJmFosPOaJVcOQMbR+m6h6QNJq+H
 d8aU4+ddLGlpZJpmf7gf1Okr7+o6EQFNkYJsAhVXjzXknvGmHFIjBov5/WA==
X-Received: by 2002:ac2:4f09:0:b0:500:b553:c09e with SMTP id
 k9-20020ac24f09000000b00500b553c09emr18089915lfr.32.1696919605984; 
 Mon, 09 Oct 2023 23:33:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfDwrS8UnprtgX0H66/N9LaZXIPIn1izgf0p9kGHS1+OexDm2JvipAbhcvFs0hN9t/aq0yQfXWido0W9mnmrw=
X-Received: by 2002:ac2:4f09:0:b0:500:b553:c09e with SMTP id
 k9-20020ac24f09000000b00500b553c09emr18089905lfr.32.1696919605637; Mon, 09
 Oct 2023 23:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231009112401.1060447-1-dtatulea@nvidia.com>
 <20231009112401.1060447-17-dtatulea@nvidia.com>
In-Reply-To: <20231009112401.1060447-17-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Oct 2023 14:33:14 +0800
Message-ID: <CACGkMEuffeRaJh9P4Mo-PnXk06mFWKDbCcR_0Eogx3FBU-KW-A@mail.gmail.com>
Subject: Re: [PATCH vhost v3 16/16] vdpa/mlx5: Update cvq iotlb mapping on
 ASID change
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
QG52aWRpYS5jb20+IHdyb3RlOgo+Cj4gRm9yIHRoZSBmb2xsb3dpbmcgc2VxdWVuY2U6Cj4gLSBj
dnEgZ3JvdXAgaXMgaW4gQVNJRCAwCj4gLSAuc2V0X21hcCgxLCBjdnFfaW90bGIpCj4gLSAuc2V0
X2dyb3VwX2FzaWQoY3ZxX2dyb3VwLCAxKQo+Cj4gLi4uIHRoZSBjdnEgbWFwcGluZyBmcm9tIEFT
SUQgMCB3aWxsIGJlIHVzZWQuIFRoaXMgaXMgbm90IGFsd2F5cyBjb3JyZWN0Cj4gYmVoYXZpb3Vy
Lgo+Cj4gVGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIHRoZSBhYm92ZSBtZW50aW9uZWQgZmxv
dyBieSBzYXZpbmcgdGhlIGlvdGxiCj4gb24gZWFjaCAuc2V0X21hcCBhbmQgdXBkYXRpbmcgdGhl
IGN2cSBpb3RsYiB3aXRoIGl0IG9uIGEgY3ZxIGdyb3VwIGNoYW5nZS4KPgo+IEFja2VkLWJ5OiBF
dWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBEcmFn
b3MgVGF0dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4KPiAtLS0KCkFja2VkLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
