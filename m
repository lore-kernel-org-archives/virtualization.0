Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8776EC433F5
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 07:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BB10605EB;
	Tue, 23 Nov 2021 07:49:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bBRc4FHeip4I; Tue, 23 Nov 2021 07:49:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CD4F3605CB;
	Tue, 23 Nov 2021 07:49:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C0B9C002E;
	Tue, 23 Nov 2021 07:49:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF756C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 07:49:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ABC3880D5E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 07:49:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KI0jA6ojHm-O
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 07:49:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB9C580D55
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 07:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637653782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BMzfZVjswiFu/FdpG242HOh4TRJ6CN97zN9fwi2fakg=;
 b=TU7FBjc1hzXDMJZXbC2bUXkqfVO1WmEvukgEAVIRSEIKtlIuYlFySm/ZQkp4O+opdC6N0R
 2P9u685oXpjFZllf/hbzMVDoJs8oMaAchdHbgGhIZcXuBe9pht/+WGm4nDtGWIIReybFjo
 +2jyd3fCUy+lyRbNdo3meWLBWku9JVw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-89-_4_FrHgVOKy91Yk6tffaZw-1; Tue, 23 Nov 2021 02:49:40 -0500
X-MC-Unique: _4_FrHgVOKy91Yk6tffaZw-1
Received: by mail-lf1-f71.google.com with SMTP id
 b23-20020a0565120b9700b00403a044bfcdso13739682lfv.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 23:49:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BMzfZVjswiFu/FdpG242HOh4TRJ6CN97zN9fwi2fakg=;
 b=6cTKim5TPVfucUEwQRKkpvuXAR5cfLUtUmhUnRXWVlC1yi3NR2bpb5FkB4QzYQ076b
 U4wXLLxVBcJppCK2x4X23eOeWf5awL8DOaPGVWyFehr4+6SFmHjHvh1TSGZBQ9gfbTf/
 n/fGKi8DLNiAaFyHjlGgfEPz83C+sHqAJPQfVxQL0/D6ZrP3FjrHCgFYwmTblUvew0aD
 cklj2NGBF0lTvwMcj8O4QkdScIKjPZ/Z7GZ5FgMgBsJMVy8tUOhXKtzg5daUgJxsxH0z
 XiSq7ckNyeHXZ0Gb0wZevHMFVcqU0tXKK2Noj0gs3ySxzh6Tk0t1YS4sZHox7AoNZmjF
 Gt4Q==
X-Gm-Message-State: AOAM531OhE5yb9NC9jcL1ceSLtaD1QE19pc00uoT/UaTPABN3Pl9raRI
 hvUn3rP6dW3KGREp5lRFERglfy9Kgk8PTMEL4DMwF12gY6o2VVQg4eqaZKu46ypI462t5G89C7x
 oh240mqfchd9WGJC1oEbVtO8Cy5Gtz6uvUFD2aqeXEM7NKWvEYt1ocnZEsw==
X-Received: by 2002:ac2:5310:: with SMTP id c16mr2915114lfh.580.1637653779346; 
 Mon, 22 Nov 2021 23:49:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrwim06MS8nqcjuMrcaNGdb2t4qRgIJ3GUBoRldgBBO2/yI87QUfCfrsu+SsUR1Pt6ZX7eDOLmepIJBwtsjIA=
X-Received: by 2002:ac2:5310:: with SMTP id c16mr2915090lfh.580.1637653779123; 
 Mon, 22 Nov 2021 23:49:39 -0800 (PST)
MIME-Version: 1.0
References: <tencent_38FA65E45E1BD89E5C1965C5@qq.com>
In-Reply-To: <tencent_38FA65E45E1BD89E5C1965C5@qq.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Nov 2021 15:49:28 +0800
Message-ID: <CACGkMEv-eZEa1aC+F7-uo_b36q55ar=O-8b_B7Lx7Y-09kKuNQ@mail.gmail.com>
Subject: Re: Kvm virtual machine uses virtio graphics card, the rotating
 screen is stuck
To: =?UTF-8?B?6Iuf5rWp?= <gouhao@uniontech.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>
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

T24gVHVlLCBOb3YgMjMsIDIwMjEgYXQgMzowMCBQTSDoi5/mtakgPGdvdWhhb0B1bmlvbnRlY2gu
Y29tPiB3cm90ZToKPgo+IEhlbGxvLAo+Cj4gSSB1c2UgYHhyYW5kciAtbyBsZWZ0YCB0byByb3Rh
dGUgdGhlIHNjcmVlbiBpbiB0aGUga3ZtIHZpcnR1YWwgbWFjaGluZS4KPiBXaGVuIGNvbmZpZ3Vy
ZWQgYXMgYSBWaXJ0aW8gZ3JhcGhpY3MgY2FyZCwgdGhlIHNjcmVlbiB3aWxsIGZyZWV6ZSBhZnRl
ciByb3RhdGluZyB0aGUgc2NyZWVuLCBhbmQgdGhlIGtleWJvYXJkIGFuZCBtb3VzZSB3aWxsIG5v
dCByZXNwb25kLgo+IFdoZW4gY29uZmlndXJlZCBhcyBhIFZHQSBncmFwaGljcyBjYXJkLCBpdCBp
cyBub3JtYWwgYWZ0ZXIgcm90YXRpbmcgdGhlIHNjcmVlbi4KPgo+IElzIHRoZSBWaXJ0aW8gZ3Jh
cGhpY3MgY2FyZCBub3Qgc3VwcG9ydGluZyByb3RhdGluZz8KCkFkZGluZyBsaXN0IGFuZCBHZXJk
IGZvciB0aGUgYW5zd2VyLgoKVGhhbmtzCgo+Cj4KPiBUaGFua3MhCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
