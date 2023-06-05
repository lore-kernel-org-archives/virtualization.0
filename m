Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11890C7EE2A
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 06:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 76E3740320;
	Mon,  5 Jun 2023 06:54:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 76E3740320
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b9m6ZSsa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TBslEs0Zs2Ei; Mon,  5 Jun 2023 06:54:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0E788401B7;
	Mon,  5 Jun 2023 06:54:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E788401B7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D53AEC007A;
	Mon,  5 Jun 2023 06:54:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7316C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 06:54:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7E49D60C03
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 06:54:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E49D60C03
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=b9m6ZSsa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V-IQxTxqmOPs
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 06:54:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A738607E1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A738607E1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 06:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685948051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v1eByadmqvsX2J2miV72HS9egA3wTa1Y2KNjCsvenxw=;
 b=b9m6ZSsaI7sSWrBqV4cu6d95NOc+STB2Yu9iMVw0bwO22s7wZ7sLSkf7LHp1fmUTusXfKS
 loRE4SwZTXVBATpRIXq2RU7J0gxxfuT9lwxE473ejgGJ+jwLqEf3DdDb0MjBHuE9QtDPAu
 QQZ5DZ+mBZlT8+yPUun9vFwqmgIo8kg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-1H0hE5v1PKCdF_Eg8hpByg-1; Mon, 05 Jun 2023 02:54:10 -0400
X-MC-Unique: 1H0hE5v1PKCdF_Eg8hpByg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b1b1693338so17809181fa.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Jun 2023 23:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685948048; x=1688540048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v1eByadmqvsX2J2miV72HS9egA3wTa1Y2KNjCsvenxw=;
 b=L8fc7iB9TvmM9QJxnUnj/JUtv9dJO1IMd19xFbv0bgjW0FbG6OcjEwGsGI6Rg6joGJ
 nfUwXgfughU5l8R8VRr/KvB2hPvDY8RhqsC76BENydSXx/4zBxeHskPb36AX3ser3yai
 nFGuaFfFU8/v/EBNBjZg4K1EBzDoMFajarQtLGcwH52PAsTRE73N2x080s/8ESjKY0vs
 /DobRTZIe+cP7kZT4RwP3949hZ5WrZk609R4AM4u4bzf6bQxNttV1jQAozjtiMkU9ZWs
 3NGJW1C+BLI1N5yflemi6yP6FOHrJzCWertM2ved9sctGMROR6GLZOB2vIqfGFh/m+qn
 jM2A==
X-Gm-Message-State: AC+VfDylw0d5a9CLQSKiGEBWOU9RYw+3o3Bgnyo9DcJoLZtMmzFenIqT
 Kh2WzAu3bPgDZKNTbhsPYy3iZCQqD1w+ybwtO2uSOJ5D97ZOq+GgklUDgSlZ/k6B+3rUFOJFFXu
 wxK/gcekYtQdirZS2EI6FU8F1p5dde2Dg3zO64LxX+tu374x+NRcHMPqhMw==
X-Received: by 2002:a2e:905a:0:b0:2ac:e6d4:2c02 with SMTP id
 n26-20020a2e905a000000b002ace6d42c02mr3499647ljg.27.1685948048424; 
 Sun, 04 Jun 2023 23:54:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ48B68vKH+UhC6uQbr9ssQ3tolVqqyHzXPOSXBU/O7tK34p9Ijx3KRGRbj7qB3LR40jH1nWx4TQQyeKgoLevKA=
X-Received: by 2002:a2e:905a:0:b0:2ac:e6d4:2c02 with SMTP id
 n26-20020a2e905a000000b002ace6d42c02mr3499639ljg.27.1685948048113; Sun, 04
 Jun 2023 23:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230602073442.1765-1-angus.chen@jaguarmicro.com>
In-Reply-To: <20230602073442.1765-1-angus.chen@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 5 Jun 2023 14:53:56 +0800
Message-ID: <CACGkMEtCr-LGVH9QJRaMJ2VF3fyDX2zEVwOSJtb-gB_VtSTV2A@mail.gmail.com>
Subject: Re: [PATCH] vp_vdpa: Check queue number of vdpa device from add_config
To: Angus Chen <angus.chen@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

T24gRnJpLCBKdW4gMiwgMjAyMyBhdCAzOjM14oCvUE0gQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBq
YWd1YXJtaWNyby5jb20+IHdyb3RlOgo+Cj4gV2hlbiBhZGQgdmlydGlvX3BjaSB2ZHBhIGRldmlj
ZSxjaGVjayB0aGUgdnFzIG51bWJlciBvZiBkZXZpY2UgY2FwCj4gYW5kIG1heF92cV9wYWlycyBm
cm9tIGFkZF9jb25maWcuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmd1cyBDaGVuIDxhbmd1cy5jaGVu
QGphZ3Vhcm1pY3JvLmNvbT4KPiAtLS0KPiAgZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRw
YS5jIHwgMTEgKysrKysrKysrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92
cF92ZHBhLmMgYi9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMKPiBpbmRleCAyODEy
ODdmYWU4OWYuLjRiZjFhYjYzN2QzMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmlydGlv
X3BjaS92cF92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMK
PiBAQCAtNDc4LDcgKzQ3OCw3IEBAIHN0YXRpYyBpbnQgdnBfdmRwYV9kZXZfYWRkKHN0cnVjdCB2
ZHBhX21nbXRfZGV2ICp2X21kZXYsIGNvbnN0IGNoYXIgKm5hbWUsCj4gICAgICAgICBzdHJ1Y3Qg
ZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Owo+ICAgICAgICAgc3RydWN0IHZwX3ZkcGEgKnZwX3Zk
cGEgPSBOVUxMOwo+ICAgICAgICAgdTY0IGRldmljZV9mZWF0dXJlczsKPiAtICAgICAgIGludCBy
ZXQsIGk7Cj4gKyAgICAgICBpbnQgcmV0LCBpLCBxdWV1ZXM7Cj4KPiAgICAgICAgIHZwX3ZkcGEg
PSB2ZHBhX2FsbG9jX2RldmljZShzdHJ1Y3QgdnBfdmRwYSwgdmRwYSwKPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBkZXYsICZ2cF92ZHBhX29wcywgMSwgMSwgbmFtZSwgZmFs
c2UpOwo+IEBAIC00OTEsNyArNDkxLDE0IEBAIHN0YXRpYyBpbnQgdnBfdmRwYV9kZXZfYWRkKHN0
cnVjdCB2ZHBhX21nbXRfZGV2ICp2X21kZXYsIGNvbnN0IGNoYXIgKm5hbWUsCj4gICAgICAgICB2
cF92ZHBhX21ndGRldi0+dnBfdmRwYSA9IHZwX3ZkcGE7Cj4KPiAgICAgICAgIHZwX3ZkcGEtPnZk
cGEuZG1hX2RldiA9ICZwZGV2LT5kZXY7Cj4gLSAgICAgICB2cF92ZHBhLT5xdWV1ZXMgPSB2cF9t
b2Rlcm5fZ2V0X251bV9xdWV1ZXMobWRldik7Cj4gKyAgICAgICBxdWV1ZXMgPSB2cF9tb2Rlcm5f
Z2V0X251bV9xdWV1ZXMobWRldik7Cj4gKyAgICAgICBpZiAoYWRkX2NvbmZpZy0+bWFzayAmIEJJ
VF9VTEwoVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVApKSB7Cj4gKyAgICAgICAgICAgICAg
IGlmIChhZGRfY29uZmlnLT5uZXQubWF4X3ZxX3BhaXJzID4gcXVldWVzIC8gMikKPiArICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiArICAgICAgICAgICAgICAgcXVldWVz
ID0gbWluX3QodTMyLCBxdWV1ZXMsIDIgKiBhZGRfY29uZmlnLT5uZXQubWF4X3ZxX3BhaXJzKTsK
Ckxvb2tzIGxpa2UgeW91IHdhbnQgdG8gbWVkaWF0ZSB0aGUgbWF4X3ZxcCBoZXJlLCBidXQgd2hh
dCBoYXBwZW5zOgoKMSkgaGFyd2FyZSBoYXZlIDQgcXVldWUgcGFyaXMKMikgdnBfdmRwYSBjYXAg
aXQgaW50byAyIHF1ZXVlIHBhaXJzCjMpIGd1ZXN0IG1heSBzdGlsbCB0cnkgdG8gZW5hYmxlIDQg
cXVldWUgcGFyaXMKCkZvciAzKSwgdGhlIGtlcm5lbCBuZWVkcyB0byBtZWRpYXRlIHRoZSBjb250
cm9sIHZpcnRxdWV1ZSB3aGljaCBzZWVtcyBub3QgZWFzeS4KCkhvdyBhYm91dCBzaW1wbHkgc3Rh
cnRpbmcgZnJvbSBmYWlsaW5nIGlmIHRoZSBwcm92aXNpb25lZCAjcXAgaXMgbm90CmVxdWFsIHRv
IHRoZSBvbmUgdGhhdCBoYXJkd2FyZSBoYXM/CgpUaGFua3MKCj4gKyAgICAgICB9Cj4gKwo+ICsg
ICAgICAgdnBfdmRwYS0+cXVldWVzID0gcXVldWVzOwo+ICAgICAgICAgdnBfdmRwYS0+bWRldiA9
IG1kZXY7Cj4KPiAgICAgICAgIGRldmljZV9mZWF0dXJlcyA9IHZwX21vZGVybl9nZXRfZmVhdHVy
ZXMobWRldik7Cj4gLS0KPiAyLjI1LjEKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
