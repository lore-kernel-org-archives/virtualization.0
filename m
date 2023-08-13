Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2308EEB64DD
	for <virtualization@archiver.kernel.org>; Sun, 13 Aug 2023 23:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CB0781516;
	Sun, 13 Aug 2023 23:08:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8CB0781516
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gAYdFQ/T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H70gt4-mMrTr; Sun, 13 Aug 2023 23:08:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0CDCA81449;
	Sun, 13 Aug 2023 23:08:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0CDCA81449
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC961C0071;
	Sun, 13 Aug 2023 23:08:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C421C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Aug 2023 23:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EACEA81449
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Aug 2023 23:08:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EACEA81449
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tZFtOTj5fP20
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Aug 2023 23:08:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC59D81448
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Aug 2023 23:08:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AC59D81448
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691968094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AUa1QX/mJ1ef9VxwUsegnOGKLjQxThmW1L4mbjRAl5o=;
 b=gAYdFQ/TBCNWCbrOzuFmK2+Vz4ns4QeDYNYSoIHdEwWzBOUq9I1ppLu/Z3O6oLAPjrto7B
 oHPUhRcWo4mL6witR4/r+lAwnuI8zK51jSqK8Stw9KfPN1Rjzej6wJU39mdveEHbMk8jOK
 IU4moGJmi2AdtzCng0wkUDhNr+AQj0A=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-lxRB5beIMsuzbMtrg0Lctg-1; Sun, 13 Aug 2023 19:08:12 -0400
X-MC-Unique: lxRB5beIMsuzbMtrg0Lctg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b9f0b7af1cso36451291fa.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Aug 2023 16:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691968091; x=1692572891;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AUa1QX/mJ1ef9VxwUsegnOGKLjQxThmW1L4mbjRAl5o=;
 b=RhFDmI5eQa7qzqW2wH4rtQlXnEeMY933I7199KVTglixBvFkHL4J/1k4AqGAjCgbUQ
 b6T8nSVGIrIienHX8An1gCqz6IB4KgTbZ+1XtRPlk9q5EdvEcqBGZM3OVMvrzzlBR17g
 /pPEksR+0f1v/YNouBjZ5dD2ELPTUkFBicxnTs9NFZ8UsPl1yZomqX3tIoRnDr4NQoWR
 lRcVFMD0v2TQ3LiqXUgI2EhBLj7HLcrycFtOHSQnq3V8bmbOO0TKCobOPRtKKFTeQ0zL
 MPwRHykwtJeqdkKzne16BGnbKLZmUALsp4s2uq3npoaepCqAbP8Jq4NYZ6jpbPAVQB9h
 twPw==
X-Gm-Message-State: AOJu0YxqRIurMB0nCHCLmUMnNTQEBb6XpMINRLrnGv+0kcwlPgvHrcrC
 bd95SV/hNiJ+NpeZAksXM09gPatKel8AjrHbkraH79LHwC0qHszGPttagQgVq17PJ3BN1ph3u9S
 3tYd7Wbo3yMAi6RmDutUMl+7AJ7uTneDkC2OvVwXFAA==
X-Received: by 2002:a2e:8503:0:b0:2b7:1005:931b with SMTP id
 j3-20020a2e8503000000b002b71005931bmr5573396lji.0.1691968090804; 
 Sun, 13 Aug 2023 16:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfB6KQC44UtzTvTIQLTU6WSArsFvqwFM/tL9oeOdLXdw+TuyKztZH0mu5DyTnZ3c9/bKtQHw==
X-Received: by 2002:a2e:8503:0:b0:2b7:1005:931b with SMTP id
 j3-20020a2e8503000000b002b71005931bmr5573379lji.0.1691968090444; 
 Sun, 13 Aug 2023 16:08:10 -0700 (PDT)
Received: from redhat.com ([2.55.42.146]) by smtp.gmail.com with ESMTPSA id
 jo19-20020a170906f6d300b0099bcd1fa5b0sm5002759ejb.192.2023.08.13.16.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 16:08:09 -0700 (PDT)
Date: Sun, 13 Aug 2023 19:08:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: bugfixes
Message-ID: <20230813190803-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: andrew@daynix.com, kvm@vger.kernel.org, allen.hubbe@amd.com,
 virtualization@lists.linux-foundation.org, wsa+renesas@sang-engineering.com,
 xieyongji@bytedance.com, gal@nvidia.com, mst@redhat.com, eperezma@redhat.com,
 yin31149@gmail.com, leiyang@redhat.com, stefanha@redhat.com,
 stable@vger.kernelorg, linma@zju.edu.cn, netdev@vger.kernel.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 maxime.coquelin@redhat.com
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

QWxsIHNtYWxsLCBmYWlybHkgc2FmZSBjaGFuZ2VzLgoKVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNp
bmNlIGNvbW1pdCA1MmE5M2QzOWIxN2RjN2ViOThiNmFhM2VkYjkzOTQzMjQ4ZTAzYjJmOgoKICBM
aW51eCA2LjUtcmM1ICgyMDIzLTA4LTA2IDE1OjA3OjUxIC0wNzAwKQoKYXJlIGF2YWlsYWJsZSBp
biB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6CgogIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L21zdC92aG9zdC5naXQgdGFncy9mb3JfbGludXMKCmZvciB5b3Ug
dG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBmNTU0ODRmZDdiZTkyM2I3NDBlOGUxZmMzMDQwNzBiYTUz
Njc1Y2I0OgoKICB2aXJ0aW8tbWVtOiBjaGVjayBpZiB0aGUgY29uZmlnIGNoYW5nZWQgYmVmb3Jl
IGZha2Ugb2ZmbGluaW5nIG1lbW9yeSAoMjAyMy0wOC0xMCAxNTo1MTo0NiAtMDQwMCkKCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KdmlydGlvOiBidWdmaXhlcwoKanVzdCBhIGJ1bmNoIG9mIGJ1Z2ZpeGVzIGFsbCBvdmVyIHRo
ZSBwbGFjZS4KClNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5j
b20+CgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCkFsbGVuIEh1YmJlICgyKToKICAgICAgcGRzX3ZkcGE6IHJlc2V0IHRvIHZk
cGEgc3BlY2lmaWVkIG1hYwogICAgICBwZHNfdmRwYTogYWxsb2MgaXJxIHZlY3RvcnMgb24gRFJJ
VkVSX09LCgpEYXZpZCBIaWxkZW5icmFuZCAoNCk6CiAgICAgIHZpcnRpby1tZW06IHJlbW92ZSB1
bnNhZmUgdW5wbHVnIGluIEJpZyBCbG9jayBNb2RlIChCQk0pCiAgICAgIHZpcnRpby1tZW06IGNv
bnZlcnQgbW9zdCBvZmZsaW5lX2FuZF9yZW1vdmVfbWVtb3J5KCkgZXJyb3JzIHRvIC1FQlVTWQog
ICAgICB2aXJ0aW8tbWVtOiBrZWVwIHJldHJ5aW5nIG9uIG9mZmxpbmVfYW5kX3JlbW92ZV9tZW1v
cnkoKSBlcnJvcnMgaW4gU3ViIEJsb2NrIE1vZGUgKFNCTSkKICAgICAgdmlydGlvLW1lbTogY2hl
Y2sgaWYgdGhlIGNvbmZpZyBjaGFuZ2VkIGJlZm9yZSBmYWtlIG9mZmxpbmluZyBtZW1vcnkKCkRy
YWdvcyBUYXR1bGVhICg0KToKICAgICAgdmRwYTogRW5hYmxlIHN0cmljdCB2YWxpZGF0aW9uIGZv
ciBuZXRsaW5rcyBvcHMKICAgICAgdmRwYS9tbHg1OiBDb3JyZWN0IGRlZmF1bHQgbnVtYmVyIG9m
IHF1ZXVlcyB3aGVuIE1RIGlzIG9uCiAgICAgIHZkcGEvbWx4NTogRml4IG1yLT5pbml0aWFsaXpl
ZCBzZW1hbnRpY3MKICAgICAgdmRwYS9tbHg1OiBGaXggY3Jhc2ggb24gc2h1dGRvd24gZm9yIHdo
ZW4gbm8gbmRldiBleGlzdHMKCkV1Z2VuaW8gUMOpcmV6ICgxKToKICAgICAgdmRwYS9tbHg1OiBE
ZWxldGUgY29udHJvbCB2cSBpb3RsYiBpbiBkZXN0cm95X21yIG9ubHkgd2hlbiBuZWNlc3NhcnkK
CkZlbmcgTGl1ICgxKToKICAgICAgdmlydGlvLXBjaTogRml4IGxlZ2FjeSBkZXZpY2UgZmxhZyBz
ZXR0aW5nIGVycm9yIGluIHByb2JlCgpHYWwgUHJlc3NtYW4gKDEpOgogICAgICB2aXJ0aW8tdmRw
YTogRml4IGNwdW1hc2sgbWVtb3J5IGxlYWsgaW4gdmlydGlvX3ZkcGFfZmluZF92cXMoKQoKSGF3
a2lucyBKaWF3ZWkgKDEpOgogICAgICB2aXJ0aW8tbmV0OiBaZXJvIG1heF90eF92cSBmaWVsZCBm
b3IgVklSVElPX05FVF9DVFJMX01RX0hBU0hfQ09ORklHIGNhc2UKCkxpbiBNYSAoMyk6CiAgICAg
IHZkcGE6IEFkZCBmZWF0dXJlcyBhdHRyIHRvIHZkcGFfbmxfcG9saWN5IGZvciBubGF0dHIgbGVu
Z3RoIGNoZWNrCiAgICAgIHZkcGE6IEFkZCBxdWV1ZSBpbmRleCBhdHRyIHRvIHZkcGFfbmxfcG9s
aWN5IGZvciBubGF0dHIgbGVuZ3RoIGNoZWNrCiAgICAgIHZkcGE6IEFkZCBtYXggdnFwIGF0dHIg
dG8gdmRwYV9ubF9wb2xpY3kgZm9yIG5sYXR0ciBsZW5ndGggY2hlY2sKCk1heGltZSBDb3F1ZWxp
biAoMSk6CiAgICAgIHZkdXNlOiBVc2UgcHJvcGVyIHNwaW5sb2NrIGZvciBJUlEgaW5qZWN0aW9u
CgpNaWtlIENocmlzdGllICgzKToKICAgICAgdmhvc3Qtc2NzaTogRml4IGFsaWdubWVudCBoYW5k
bGluZyB3aXRoIHdpbmRvd3MKICAgICAgdmhvc3Qtc2NzaTogUmVuYW1lIHZob3N0X3Njc2lfaW92
X3RvX3NnbAogICAgICBNQUlOVEFJTkVSUzogYWRkIHZob3N0LXNjc2kgZW50cnkgYW5kIG15c2Vs
ZiBhcyBhIGNvLW1haW50YWluZXIKClNoYW5ub24gTmVsc29uICg0KToKICAgICAgcGRzX3ZkcGE6
IHByb3RlY3QgTWFrZWZpbGUgZnJvbSB1bmNvbmZpZ3VyZWQgZGVidWdmcwogICAgICBwZHNfdmRw
YTogYWx3YXlzIGFsbG93IG9mZmVyaW5nIFZJUlRJT19ORVRfRl9NQUMKICAgICAgcGRzX3ZkcGE6
IGNsZWFuIGFuZCByZXNldCB2cXMgZW50cmllcwogICAgICBwZHNfdmRwYTogZml4IHVwIGRlYnVn
ZnMgZmVhdHVyZSBiaXQgcHJpbnRpbmcKCldvbGZyYW0gU2FuZyAoMSk6CiAgICAgIHZpcnRpby1t
bWlvOiBkb24ndCBicmVhayBsaWZlY3ljbGUgb2Ygdm1fZGV2CgogTUFJTlRBSU5FUlMgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAxMSArKy0KIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyAgICAg
ICAgICAgfCAgIDIgKy0KIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmggfCAgIDIg
KwogZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jICAgICAgICB8IDEwNSArKysrKysrKysrKysr
KystLS0tLS0KIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyAgfCAgMjYgKysrLS0t
CiBkcml2ZXJzL3ZkcGEvcGRzL01ha2VmaWxlICAgICAgICAgIHwgICAzICstCiBkcml2ZXJzL3Zk
cGEvcGRzL2RlYnVnZnMuYyAgICAgICAgIHwgIDE1ICsrLQogZHJpdmVycy92ZHBhL3Bkcy92ZHBh
X2Rldi5jICAgICAgICB8IDE3NiArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tCiBk
cml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmggICAgICAgIHwgICA1ICstCiBkcml2ZXJzL3ZkcGEv
dmRwYS5jICAgICAgICAgICAgICAgIHwgICA5ICstCiBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3Zk
dXNlX2Rldi5jIHwgICA4ICstCiBkcml2ZXJzL3Zob3N0L3Njc2kuYyAgICAgICAgICAgICAgIHwg
MTg3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0KIGRyaXZlcnMvdmlydGlv
L3ZpcnRpb19tZW0uYyAgICAgICAgfCAxNjggKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tCiBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jICAgICAgIHwgICA1ICstCiBkcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jIHwgICAyIC0KIGRyaXZlcnMvdmlydGlvL3ZpcnRp
b19wY2lfbGVnYWN5LmMgfCAgIDEgKwogZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyAgICAg
ICB8ICAgMiArCiAxNyBmaWxlcyBjaGFuZ2VkLCA1MTkgaW5zZXJ0aW9ucygrKSwgMjA4IGRlbGV0
aW9ucygtKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
