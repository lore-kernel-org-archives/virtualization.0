Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B81C6FD19
	for <virtualization@archiver.kernel.org>; Mon, 13 Mar 2023 06:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08E6E80E53;
	Mon, 13 Mar 2023 06:31:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 08E6E80E53
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cuhXfW1T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UgVtIpdTLo-p; Mon, 13 Mar 2023 06:31:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 807C980DC0;
	Mon, 13 Mar 2023 06:31:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 807C980DC0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52E80C0071;
	Mon, 13 Mar 2023 06:31:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32596C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 06:31:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 135DB80DCD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 06:31:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 135DB80DCD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hMjDATr_3PgK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 06:31:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B24EA80DC0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B24EA80DC0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 06:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678689105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uP6OPkCE+3XV/LM8KCZyJuOxYGuLRyW9hCJ+ior5xWo=;
 b=cuhXfW1TvjgJ+Tp1kEqGeasMdbcT0EI+OSChNuTAO9mToMezh5y9dSxkNQ7CnZOfgyF8kM
 0ZPZn0zkwhZx54I440D4iPZEKv3cVdizjpEkcpTmgo6TykZwG7CEQKtMjd0jHrw+v99F1Q
 uNLCgPlBCY9CqahOmsrxYppaag33EQM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-D-LIqI3UPCeVYpoMZ6rdOg-1; Mon, 13 Mar 2023 02:31:43 -0400
X-MC-Unique: D-LIqI3UPCeVYpoMZ6rdOg-1
Received: by mail-wm1-f70.google.com with SMTP id
 j32-20020a05600c1c2000b003e9bdf02c9fso7309699wms.6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 23:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678689102;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uP6OPkCE+3XV/LM8KCZyJuOxYGuLRyW9hCJ+ior5xWo=;
 b=QdB3NIoNjyiGqh0lhnfLhgguODotSJBuCPzYnM0QXy3ld9D01yPIfUp/f82e/WRkab
 q2+d/fGWn8ffIYtcV6avU1WGClbJznqUBv66rRpVhVxTApy8M0ddjfn2ho8ybCc2WDBg
 mtBNWQXrH/0si7StVfC3Gy0VTH5qNt8C2PLzwFcUlzLnWp/Z8qDwPlqZqzGX/Zk6XUjo
 fp3dYTc2nxdGaWaqGKHUvoJrM06CDU2xgnpUnmAZVsVRVggQnShD6T6LRvoT3wrcB8OA
 QVZ4JpWI/fIwjUhVd54pc5eHg2B7dCZzv/pWx6lrOA4VBH1XQUQM6qk35SHZkED0ytOy
 a9Gw==
X-Gm-Message-State: AO0yUKVAtOrSouvXaC8emNh4awbvJyVCyR3uygHL/Igi8WLBfZZ2qU/z
 f7XZlzqJ9wK403ZxPjDDaBkxWJkIc/eT+DptC1Uz/ohn1D/1ckfMq3YPx8fqEpWPwOiwqZR8B7G
 yeWYzASmr5mGLFkla0TGOvjBv7uY4fpbGNyyz7kOLWA==
X-Received: by 2002:a05:600c:a4c:b0:3e2:d3:b2b6 with SMTP id
 c12-20020a05600c0a4c00b003e200d3b2b6mr7122723wmq.14.1678689102680; 
 Sun, 12 Mar 2023 23:31:42 -0700 (PDT)
X-Google-Smtp-Source: AK7set/m0d39bBRh2a53avY9wpGXBQ5w6WVRLPsP4dfir1NMRR7vQctreaympSD9w7L/W8ZMq9gTgQ==
X-Received: by 2002:a05:600c:a4c:b0:3e2:d3:b2b6 with SMTP id
 c12-20020a05600c0a4c00b003e200d3b2b6mr7122711wmq.14.1678689102415; 
 Sun, 12 Mar 2023 23:31:42 -0700 (PDT)
Received: from redhat.com ([2.52.26.7]) by smtp.gmail.com with ESMTPSA id
 f25-20020a7bc8d9000000b003ed24653333sm1899615wml.33.2023.03.12.23.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Mar 2023 23:31:41 -0700 (PDT)
Date: Mon, 13 Mar 2023 02:31:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio,vhost,vdpa: bugfixes
Message-ID: <20230313023139-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lulu@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 leiyang@redhat.com, rongtao@cestc.cn, gautam.dawar@amd.com, elic@nvidia.com
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBmZTE1YzI2ZWUyNmVmYTExNzQxYTdi
NjMyZTlmMjNiMDFhY2E0Y2M2OgoKICBMaW51eCA2LjMtcmMxICgyMDIzLTAzLTA1IDE0OjUyOjAz
IC0wODAwKQoKYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6CgogIGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21zdC92aG9zdC5naXQg
dGFncy9mb3JfbGludXMKCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBhZTQzYzIwZGEy
YTc3YzUwODcxNWE5Yzc3ODQ1YjRlODdlNmExZTI1OgoKICB0b29scy92aXJ0aW86IElnbm9yZSB2
aXJ0aW8tdHJhY2UvdHJhY2UtYWdlbnQgKDIwMjMtMDMtMTMgMDI6Mjk6MTIgLTA0MDApCgotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCnZpcnRpbyx2aG9zdCx2ZHBhOiBidWdmaXhlcwoKU29tZSBmaXhlcyBhY2N1bXVsYXRlZCBz
byBmYXIuCgpTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29t
PgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQpDaW5keSBMdSAoMSk6CiAgICAgIHZwX3ZkcGE6IGZpeCB0aGUgY3Jhc2ggaW4g
aG90IHVucGx1ZyB3aXRoIHZwX3ZkcGEKCkV1Z2VuaW8gUMOpcmV6ICgxKToKICAgICAgdmRwYV9z
aW06IHNldCBsYXN0X3VzZWRfaWR4IGFzIGxhc3RfYXZhaWxfaWR4IGluIHZkcGFzaW1fcXVldWVf
cmVhZHkKCkdhdXRhbSBEYXdhciAoMSk6CiAgICAgIHZob3N0LXZkcGE6IGZyZWUgaW9tbXUgZG9t
YWluIGFmdGVyIGxhc3QgdXNlIGR1cmluZyBjbGVhbnVwCgpSb25nIFRhbyAoMSk6CiAgICAgIHRv
b2xzL3ZpcnRpbzogSWdub3JlIHZpcnRpby10cmFjZS90cmFjZS1hZ2VudAoKU2ktV2VpIExpdSAo
MSk6CiAgICAgIHZkcGEvbWx4NTogc2hvdWxkIG5vdCBhY3RpdmF0ZSB2aXJ0cSBvYmplY3Qgd2hl
biBzdXNwZW5kZWQKCiBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oIHwgIDEgKwog
ZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jICB8ICA2ICsrKysrLQogZHJpdmVycy92
ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgICB8IDExICsrKysrKysrKysrCiBkcml2ZXJzL3ZkcGEv
dmlydGlvX3BjaS92cF92ZHBhLmMgIHwgIDIgKy0KIGRyaXZlcnMvdmhvc3QvdmRwYS5jICAgICAg
ICAgICAgICAgfCAgMyArKy0KIHRvb2xzL3ZpcnRpby8uZ2l0aWdub3JlICAgICAgICAgICAgfCAg
MSArCiA2IGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
