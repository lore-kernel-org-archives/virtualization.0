Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7C7CDB474
	for <virtualization@archiver.kernel.org>; Mon, 23 Oct 2023 03:09:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9FB060EA4;
	Mon, 23 Oct 2023 03:09:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B9FB060EA4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HI90R3a4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uknvnUy_VSrD; Mon, 23 Oct 2023 03:09:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DC07A60E97;
	Mon, 23 Oct 2023 03:09:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC07A60E97
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6730C0071;
	Mon, 23 Oct 2023 03:09:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 178BEC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 03:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D7DE840A06
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 03:09:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D7DE840A06
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HI90R3a4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mntUW5nv2Wbo
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 03:09:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B15C2405E9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 03:09:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B15C2405E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698030564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uR3upPr1un9Y15hnQrF7MdsdEdC4wHgJk4tSO1HctOg=;
 b=HI90R3a4yt1GHO10d0fTiMQJWAXEftAZgcO+eSGhSGfH6iK/pXVU5/i9fSUFcyLC+j2R6O
 zXKuZJlKkPU4+xSZfppeLPpT/eTgCtCgU8FxAT+0bkrtRkQsi3kCC2iCwmlSzM+KoTp469
 q+TGsT1n9fox71oKL/itWKyJjUqpisI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-Cec17KwyPT6wrJYznGQVTg-1; Sun, 22 Oct 2023 23:09:18 -0400
X-MC-Unique: Cec17KwyPT6wrJYznGQVTg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-507c8a8e5d1so2958275e87.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Oct 2023 20:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698030557; x=1698635357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uR3upPr1un9Y15hnQrF7MdsdEdC4wHgJk4tSO1HctOg=;
 b=vHhKjiP7F8GgRFcCfcy4w92wfdK0xU+QSyTSHA06GEzIBZxC6MbjmUMovMI7NgEH8X
 JYxxBqP+byB/RoJ1LDJnUXIJTGSLs7aVrLzjr4hPTK7ZPMuDruAzPNHZf7YqyDCLbjVC
 dEiWSMM54O2bA3g7xAqQkZkW+fmbl1onGisrR8IsAlsrfJyhTkR95XeQXPBSF+GTJCi5
 WbgQVEBr6PLhqCeONGoO4jAsjyEUkWkyOTxnbGM7vTR8pfriEatBUmtZOpthL53zaap7
 w6TqR7BQhJ6LYHjuNQuu51NRtuawKVE6rUoHgbXd2+XSymy8RApMhkBx3LUFlI2EWUwF
 aZzQ==
X-Gm-Message-State: AOJu0YxHYifPTnUUxdb+9w5KfR6Nf3lWNrITz806n84bJ93r8CEWX/L3
 FkLkzWZMyZL5kJSSZ1+wmuL/vMj1i9LmstKY+lJynZq/FDYyIN+aBCySEcs00hm3gBz/goEV0Fk
 +I4/xFQ94cbkr2P4UZNV0DX8FY5MilB+3HsMkAZSgu1JjDKJ/Wn6oO9KsxA==
X-Received: by 2002:ac2:518b:0:b0:503:55c:7999 with SMTP id
 u11-20020ac2518b000000b00503055c7999mr4906982lfi.34.1698030557001; 
 Sun, 22 Oct 2023 20:09:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgWCb7RrjHP+YKyif/eQ3pCH0351kwLRVv4y6D+4xjgstUC95BiBq1L5oqqzYLzjBLiA8Wpf2Vn16vXSmNb5E=
X-Received: by 2002:ac2:518b:0:b0:503:55c:7999 with SMTP id
 u11-20020ac2518b000000b00503055c7999mr4906972lfi.34.1698030556727; Sun, 22
 Oct 2023 20:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231020155819.24000-1-maxime.coquelin@redhat.com>
 <20231020155819.24000-5-maxime.coquelin@redhat.com>
In-Reply-To: <20231020155819.24000-5-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 23 Oct 2023 11:09:05 +0800
Message-ID: <CACGkMEvht+u9nO96u-Tosw9un8_rt+-RuJJo-kAA+0mrkNspbw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] vduse: Add LSM hooks to check Virtio device type
To: Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, paul@paul-moore.com, lulu@redhat.com,
 mst@redhat.com, selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 stephen.smalley.work@gmail.com, jmorris@namei.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 linux-security-module@vger.kernel.org, eparis@parisplace.org,
 david.marchand@redhat.com, serge@hallyn.com
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

T24gRnJpLCBPY3QgMjAsIDIwMjMgYXQgMTE6NTjigK9QTSBNYXhpbWUgQ29xdWVsaW4KPG1heGlt
ZS5jb3F1ZWxpbkByZWRoYXQuY29tPiB3cm90ZToKPgo+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBM
U00gaG9va3MgZm9yIGRldmljZXMgY3JlYXRpb24sCj4gZGVzdHJ1Y3Rpb24gYW5kIG9wZW5pbmcg
b3BlcmF0aW9ucywgY2hlY2tpbmcgdGhlCj4gYXBwbGljYXRpb24gaXMgYWxsb3dlZCB0byBwZXJm
b3JtIHRoZXNlIG9wZXJhdGlvbnMgZm9yCj4gdGhlIFZpcnRpbyBkZXZpY2UgdHlwZS4KPgo+IFNp
Z25lZC1vZmYtYnk6IE1heGltZSBDb3F1ZWxpbiA8bWF4aW1lLmNvcXVlbGluQHJlZGhhdC5jb20+
Cj4gLS0tCgpIaSBNYXhpbWU6CgpJIHRoaW5rIHdlIG5lZWQgdG8gZG9jdW1lbnQgdGhlIHJlYXNv
biB3aHkgd2UgbmVlZCB0aG9zZSBob29rcyBub3cuCgpUaGFua3MKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
