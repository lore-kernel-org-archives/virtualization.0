Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CC8C83F2C
	for <virtualization@archiver.kernel.org>; Sun,  3 Sep 2023 22:13:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA4B960F17;
	Sun,  3 Sep 2023 22:13:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA4B960F17
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HbDxDHKD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PvwS3c_Qw1uz; Sun,  3 Sep 2023 22:13:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1E5E160655;
	Sun,  3 Sep 2023 22:13:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E5E160655
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0B70C0071;
	Sun,  3 Sep 2023 22:13:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5E48C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  3 Sep 2023 22:13:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8097E81272
 for <virtualization@lists.linux-foundation.org>;
 Sun,  3 Sep 2023 22:13:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8097E81272
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HbDxDHKD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 64EB7WWVGVLO
 for <virtualization@lists.linux-foundation.org>;
 Sun,  3 Sep 2023 22:13:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 717658126E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  3 Sep 2023 22:13:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 717658126E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693779226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VjL9JGcLByfgPaZswLky26tlQQfEuGeRmQ8TWkF1Et8=;
 b=HbDxDHKD1MmabWjRGAoJpB15cqrCRVg6fNJChly9hPLTdLhcF6DTnHJZsrKY2HRu3j3FGl
 CaY6UJICcaAXDJ2WBiJ0Ec+VguPPPM4K6l7/fvAyl793UaOPyfZb/ZWQhPS4Vdc7zDCaN9
 jX7v/P88pUAwbixXGeDOAYBPhlHocns=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-pEFTAi9GPFmcgfzyXRUrHA-1; Sun, 03 Sep 2023 18:13:45 -0400
X-MC-Unique: pEFTAi9GPFmcgfzyXRUrHA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2bcc5098038so7649471fa.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 03 Sep 2023 15:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693779223; x=1694384023;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VjL9JGcLByfgPaZswLky26tlQQfEuGeRmQ8TWkF1Et8=;
 b=Wj2r+0sFRjyXqw4DnvAr9o0vhEB8d70dQEKtZfSs+aBknSscsmE+L8ZRSdLoJDbiqH
 1MWWPTThLhMHCBubqVrGkoarC1JVma+xiDdqiA8vQRXL3VOQ8wjSYHpXd2W8FVvdngjL
 pD95xc/YAKTEgx0QSHbmSmd9iGPG0GA+aGgDcAxaPOOQyzMbfMYtqQi3tPuxKxYyP5gh
 BjLTfY4LhgG0Zxvitrk2Weym6R5zKp3oSMFtGhUEsRz920IwH7JJPvcl/289XdpbwJj9
 KfQmhnse8aiqHERdif4J8GfS/S3TKg3oOOl9XNNsM47Apx4BqMLRGFt9qQY95pQFSv8p
 7JuA==
X-Gm-Message-State: AOJu0YxTJFir7rV99ACEhZmqM5d2VHpHn5MPEMeZ4ZQCCBYQbT94pU7m
 koaDsjL0doEQaE90lJlxcbt/wMG/QfCiWUDXU1AzVjNU2rr7YQyiH5IsLuZP27goh6oXBY+/xT9
 OCRHfJekP1iybz7yMp+KZ14ObGxgvA634d9ao/HElMg==
X-Received: by 2002:a2e:b70d:0:b0:2bd:133c:58ff with SMTP id
 j13-20020a2eb70d000000b002bd133c58ffmr5371564ljo.48.1693779223760; 
 Sun, 03 Sep 2023 15:13:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt5eq/oqAhbyqYfgrqKLbNZZyl3X0ZXzNnLt/MouQMoz3QQr7CiE/cjPIeQZ0ta3ELUrf4kA==
X-Received: by 2002:a2e:b70d:0:b0:2bd:133c:58ff with SMTP id
 j13-20020a2eb70d000000b002bd133c58ffmr5371549ljo.48.1693779223406; 
 Sun, 03 Sep 2023 15:13:43 -0700 (PDT)
Received: from redhat.com ([2.52.1.236]) by smtp.gmail.com with ESMTPSA id
 gf20-20020a170906e21400b0099ce23c57e6sm5257536ejb.224.2023.09.03.15.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 15:13:42 -0700 (PDT)
Date: Sun, 3 Sep 2023 18:13:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: features
Message-ID: <20230903181338-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, yuehaibing@huawei.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, yuanyaogoog@chromium.org,
 eperezma@redhat.com
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAyZGRlMThjZDFkOGZhYzczNTg3NWYy
ZTQ5ODdmMTE4MTdjYzBiYzJjOgoKICBMaW51eCA2LjUgKDIwMjMtMDgtMjcgMTQ6NDk6NTEgLTA3
MDApCgphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoKCiAgaHR0cHM6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbXN0L3Zob3N0LmdpdCB0YWdz
L2Zvcl9saW51cwoKZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDFhY2ZlMmMxMjI1ODk5
ZWFiNWFiNzI0YzkxYjdlMWViMjg4MWI5YWI6CgogIHZpcnRpb19yaW5nOiBmaXggYXZhaWxfd3Jh
cF9jb3VudGVyIGluIHZpcnRxdWV1ZV9hZGRfcGFja2VkICgyMDIzLTA5LTAzIDE4OjEwOjI0IC0w
NDAwKQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQp2aXJ0aW86IGZlYXR1cmVzCgphIHNtYWxsIHB1bGwgcmVxdWVzdCB0aGlz
IHRpbWUgYXJvdW5kLCBtb3N0bHkgYmVjYXVzZSB0aGUKdmR1c2UgbmV0d29yayBnb3QgcG9zdHBv
bmVkIHRvIG5leHQgcmVsYXNlIHNvIHdlIGNhbiBiZSBzdXJlCndlIGdvdCB0aGUgc2VjdXJpdHkg
c3RvcmUgcmlnaHQuCgpTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRo
YXQuY29tPgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQpFdWdlbmlvIFDDqXJleiAoNCk6CiAgICAgIHZkcGE6IGFkZCBWSE9T
VF9CQUNLRU5EX0ZfRU5BQkxFX0FGVEVSX0RSSVZFUl9PSyBmbGFnCiAgICAgIHZkcGE6IGFjY2Vw
dCBWSE9TVF9CQUNLRU5EX0ZfRU5BQkxFX0FGVEVSX0RSSVZFUl9PSyBiYWNrZW5kIGZlYXR1cmUK
ICAgICAgdmRwYTogYWRkIGdldF9iYWNrZW5kX2ZlYXR1cmVzIHZkcGEgb3BlcmF0aW9uCiAgICAg
IHZkcGFfc2ltOiBvZmZlciBWSE9TVF9CQUNLRU5EX0ZfRU5BQkxFX0FGVEVSX0RSSVZFUl9PSwoK
SmFzb24gV2FuZyAoMSk6CiAgICAgIHZpcnRpb192ZHBhOiBidWlsZCBhZmZpbml0eSBtYXNrcyBj
b25kaXRpb25hbGx5CgpYdWFuIFpodW8gKDEyKToKICAgICAgdmlydGlvX3Jpbmc6IGNoZWNrIHVz
ZV9kbWFfYXBpIGJlZm9yZSB1bm1hcCBkZXNjIGZvciBpbmRpcmVjdAogICAgICB2aXJ0aW9fcmlu
ZzogcHV0IG1hcHBpbmcgZXJyb3IgY2hlY2sgaW4gdnJpbmdfbWFwX29uZV9zZwogICAgICB2aXJ0
aW9fcmluZzogaW50cm9kdWNlIHZpcnRxdWV1ZV9zZXRfZG1hX3ByZW1hcHBlZCgpCiAgICAgIHZp
cnRpb19yaW5nOiBzdXBwb3J0IGFkZCBwcmVtYXBwZWQgYnVmCiAgICAgIHZpcnRpb19yaW5nOiBp
bnRyb2R1Y2UgdmlydHF1ZXVlX2RtYV9kZXYoKQogICAgICB2aXJ0aW9fcmluZzogc2tpcCB1bm1h
cCBmb3IgcHJlbWFwcGVkCiAgICAgIHZpcnRpb19yaW5nOiBjb3JyZWN0IHRoZSBleHByZXNzaW9u
IG9mIHRoZSBkZXNjcmlwdGlvbiBvZiB2aXJ0cXVldWVfcmVzaXplKCkKICAgICAgdmlydGlvX3Jp
bmc6IHNlcGFyYXRlIHRoZSBsb2dpYyBvZiByZXNldC9lbmFibGUgZnJvbSB2aXJ0cXVldWVfcmVz
aXplCiAgICAgIHZpcnRpb19yaW5nOiBpbnRyb2R1Y2UgdmlydHF1ZXVlX3Jlc2V0KCkKICAgICAg
dmlydGlvX3Jpbmc6IGludHJvZHVjZSBkbWEgbWFwIGFwaSBmb3IgdmlydHF1ZXVlCiAgICAgIHZp
cnRpb19yaW5nOiBpbnRyb2R1Y2UgZG1hIHN5bmMgYXBpIGZvciB2aXJ0cXVldWUKICAgICAgdmly
dGlvX25ldDogbWVyZ2UgZG1hIG9wZXJhdGlvbnMgd2hlbiBmaWxsaW5nIG1lcmdlYWJsZSBidWZm
ZXJzCgpZdWFuIFlhbyAoMSk6CiAgICAgIHZpcnRpb19yaW5nOiBmaXggYXZhaWxfd3JhcF9jb3Vu
dGVyIGluIHZpcnRxdWV1ZV9hZGRfcGFja2VkCgpZdWUgSGFpYmluZyAoMSk6CiAgICAgIHZkcGEv
bWx4NTogUmVtb3ZlIHVudXNlZCBmdW5jdGlvbiBkZWNsYXJhdGlvbnMKCiBkcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgICAgICAgICAgIHwgMjMwICsrKysrKysrKysrKysrKysrKy0tLQogZHJpdmVy
cy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaCB8ICAgMyAtCiBkcml2ZXJzL3ZkcGEvdmRwYV9z
aW0vdmRwYV9zaW0uYyAgIHwgICA4ICsKIGRyaXZlcnMvdmhvc3QvdmRwYS5jICAgICAgICAgICAg
ICAgfCAgMTUgKy0KIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgICAgICAgfCA0MTIgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQogZHJpdmVycy92aXJ0aW8vdmlydGlv
X3ZkcGEuYyAgICAgICB8ICAxNyArLQogaW5jbHVkZS9saW51eC92ZHBhLmggICAgICAgICAgICAg
ICB8ICAgNCArCiBpbmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAgICAgICAgIHwgIDIyICsrCiBp
bmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlwZXMuaCAgIHwgICA0ICsKIDkgZmlsZXMgY2hhbmdl
ZCwgNjI1IGluc2VydGlvbnMoKyksIDkwIGRlbGV0aW9ucygtKQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
