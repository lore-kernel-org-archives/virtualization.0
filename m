Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCE9EB64DC
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 02:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5202081FF7;
	Mon, 26 Jun 2023 02:30:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5202081FF7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HV0guCNv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tywY5-ZeIbPc; Mon, 26 Jun 2023 02:30:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B2CD581E05;
	Mon, 26 Jun 2023 02:30:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2CD581E05
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AB0AC0037;
	Mon, 26 Jun 2023 02:30:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68367C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2ECE140278
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:30:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2ECE140278
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HV0guCNv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WH-e4xG3qrhY
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:30:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 43C964012D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 43C964012D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687746637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyVJTlx31H4Is5RtNpqHEWThTelTV7dr4ksD2iywiNs=;
 b=HV0guCNvmBdnUu9igIgrRkOXc/RPH64m+oaQIRiuKS+GFVjZ9r4q9/PydPFqHtvzShFjfH
 kIaq/MnlAOEl+OTybJqNkSAiidAT3YmsQGqVLZA3YVp4GMC8CDMaYs75oB5YfAF+eLpZ9p
 bFVkVo7xjSviMfBUSUo/kgTWGpMufuo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-BeDt2VdcNYaad4RiPE1qrQ-1; Sun, 25 Jun 2023 22:30:35 -0400
X-MC-Unique: BeDt2VdcNYaad4RiPE1qrQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b1d8fa45a6so19808311fa.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 19:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687746634; x=1690338634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyVJTlx31H4Is5RtNpqHEWThTelTV7dr4ksD2iywiNs=;
 b=bd6nKt6eFL+Szz0HYV2Z8IElGlw8v/fzbLPM531+1T6asabYI0xtn7xrLLRHA721Gu
 N2WYen5rW41P7CyiCRCW+PSR2W7Lq4QzVm6mV1uycI+Ovn5qECV6qqx1Hxj2fL9NEjW+
 RDS28TqZjQy3ig5QJ6ojqpk516POkps/JY9dWa1qJfoFJKWgNqv8/7QYGz0kozgG6Guf
 V0mJ1Qs4nrUzwPL0pIhjwu94tXce5sEZJq9yxjr3+6GBv7hnSUfAQj+E5kK1uFgM963u
 7UenkEb+oEMPS3nr5XuJcBHELfhYWkGrzWCuqKnW7c3oIaFICOcNKuwYIX7tKybtAU19
 tSCQ==
X-Gm-Message-State: AC+VfDzHZmQwcjpHU8C/N6TmW9XaClGQUGf0VFsewiFCISCS9P+EpSPf
 GQ/e7ngd8eDL/cs5mtta6eb9mHtvBPeRmb8jUUF0EuyH7RIJpTg2X43UDTDknPJJO+59nVkWYeI
 MOZCRgchAPVRUhQuo73MsC/uyfckmAxOVQPFEdmbBkcgF8pFf2cJSfDbUPQ==
X-Received: by 2002:a2e:9650:0:b0:2b6:9d4a:d67b with SMTP id
 z16-20020a2e9650000000b002b69d4ad67bmr1157084ljh.44.1687746634077; 
 Sun, 25 Jun 2023 19:30:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4HE5Ezou0qdo0xZEVjTVRdjNGvL6VVNXXpvsoN0NxxZSiZjMETeAiuuywApgDMhKzz0YDmkwXa9PxEvFhwehE=
X-Received: by 2002:a2e:9650:0:b0:2b6:9d4a:d67b with SMTP id
 z16-20020a2e9650000000b002b69d4ad67bmr1157076ljh.44.1687746633791; Sun, 25
 Jun 2023 19:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230608090124.1807-1-angus.chen@jaguarmicro.com>
In-Reply-To: <20230608090124.1807-1-angus.chen@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Jun 2023 10:30:22 +0800
Message-ID: <CACGkMEtp6H1x301CynwDfsXCMOVt_mrVh9G7dUxVdDLdLBB8yg@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device from
 add_config
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

T24gVGh1LCBKdW4gOCwgMjAyMyBhdCA1OjAy4oCvUE0gQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBq
YWd1YXJtaWNyby5jb20+IHdyb3RlOgo+Cj4gV2hlbiBhZGQgdmlydGlvX3BjaSB2ZHBhIGRldmlj
ZSxjaGVjayB0aGUgdnFzIG51bWJlciBvZiBkZXZpY2UgY2FwCj4gYW5kIG1heF92cV9wYWlycyBm
cm9tIGFkZF9jb25maWcuCj4gU2ltcGx5IHN0YXJ0aW5nIGZyb20gZmFpbGluZyBpZiB0aGUgcHJv
dmlzaW9uZWQgI3FwIGlzIG5vdAo+IGVxdWFsIHRvIHRoZSBvbmUgdGhhdCBoYXJkd2FyZSBoYXMu
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmd1cyBDaGVuIDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNv
bT4KPiAtLS0KPiB2MTogVXNlIG1heF92cXMgZnJvbSBhZGRfY29uZmlnCj4gdjI6IEp1c3QgcmV0
dXJuIGZhaWwgaWYgbWF4X3ZxcyBmcm9tIGFkZF9jb25maWcgaXMgbm90IHNhbWUgYXMgZGV2aWNl
Cj4gICAgICAgICBjYXAuIFN1Z2dlc3RlZCBieSBqYXNvbi4KPgo+ICBkcml2ZXJzL3ZkcGEvdmly
dGlvX3BjaS92cF92ZHBhLmMgfCAzNSArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMgYi9kcml2ZXJzL3Zk
cGEvdmlydGlvX3BjaS92cF92ZHBhLmMKPiBpbmRleCAyODEyODdmYWU4OWYuLmMxZmI2OTYzZGEx
MiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMKPiArKysg
Yi9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMKPiBAQCAtNDgwLDMyICs0ODAsMzkg
QEAgc3RhdGljIGludCB2cF92ZHBhX2Rldl9hZGQoc3RydWN0IHZkcGFfbWdtdF9kZXYgKnZfbWRl
diwgY29uc3QgY2hhciAqbmFtZSwKPiAgICAgICAgIHU2NCBkZXZpY2VfZmVhdHVyZXM7Cj4gICAg
ICAgICBpbnQgcmV0LCBpOwo+Cj4gLSAgICAgICB2cF92ZHBhID0gdmRwYV9hbGxvY19kZXZpY2Uo
c3RydWN0IHZwX3ZkcGEsIHZkcGEsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZGV2LCAmdnBfdmRwYV9vcHMsIDEsIDEsIG5hbWUsIGZhbHNlKTsKPiAtCj4gLSAgICAgICBp
ZiAoSVNfRVJSKHZwX3ZkcGEpKSB7Cj4gLSAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAidnBf
dmRwYTogRmFpbGVkIHRvIGFsbG9jYXRlIHZEUEEgc3RydWN0dXJlXG4iKTsKPiAtICAgICAgICAg
ICAgICAgcmV0dXJuIFBUUl9FUlIodnBfdmRwYSk7Cj4gKyAgICAgICBpZiAoYWRkX2NvbmZpZy0+
bWFzayAmIEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVApKSB7Cj4gKyAgICAg
ICAgICAgICAgIGlmIChhZGRfY29uZmlnLT5uZXQubWF4X3ZxX3BhaXJzICE9ICh2X21kZXYtPm1h
eF9zdXBwb3J0ZWRfdnFzIC8gMikpIHsKPiArICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJy
KCZwZGV2LT5kZXYsICJtYXggdnFzIDB4JXggc2hvdWxkIGJlIGVxdWFsIHRvIDB4JXggd2hpY2gg
ZGV2aWNlIGhhc1xuIiwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZF9jb25m
aWctPm5ldC5tYXhfdnFfcGFpcnMqMiwgdl9tZGV2LT5tYXhfc3VwcG9ydGVkX3Zxcyk7Cj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gKyAgICAgICAgICAgICAgIH0K
PiAgICAgICAgIH0KPgo+IC0gICAgICAgdnBfdmRwYV9tZ3RkZXYtPnZwX3ZkcGEgPSB2cF92ZHBh
Owo+IC0KPiAtICAgICAgIHZwX3ZkcGEtPnZkcGEuZG1hX2RldiA9ICZwZGV2LT5kZXY7Cj4gLSAg
ICAgICB2cF92ZHBhLT5xdWV1ZXMgPSB2cF9tb2Rlcm5fZ2V0X251bV9xdWV1ZXMobWRldik7Cj4g
LSAgICAgICB2cF92ZHBhLT5tZGV2ID0gbWRldjsKPiAtCj4gICAgICAgICBkZXZpY2VfZmVhdHVy
ZXMgPSB2cF9tb2Rlcm5fZ2V0X2ZlYXR1cmVzKG1kZXYpOwo+ICAgICAgICAgaWYgKGFkZF9jb25m
aWctPm1hc2sgJiBCSVRfVUxMKFZEUEFfQVRUUl9ERVZfRkVBVFVSRVMpKSB7Cj4gICAgICAgICAg
ICAgICAgIGlmIChhZGRfY29uZmlnLT5kZXZpY2VfZmVhdHVyZXMgJiB+ZGV2aWNlX2ZlYXR1cmVz
KSB7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVJTlZBTDsKPiAgICAgICAgICAg
ICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICJUcnkgdG8gcHJvdmlzaW9uIGZlYXR1
cmVzICIKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJ0aGF0IGFyZSBub3Qgc3Vw
cG9ydGVkIGJ5IHRoZSBkZXZpY2U6ICIKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICJkZXZpY2VfZmVhdHVyZXMgMHglbGx4IHByb3Zpc2lvbmVkIDB4JWxseFxuIiwKPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGRldmljZV9mZWF0dXJlcywgYWRkX2NvbmZpZy0+ZGV2
aWNlX2ZlYXR1cmVzKTsKPiAtICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycjsKPiArICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiAgICAgICAgICAgICAgICAgfQo+
ICAgICAgICAgICAgICAgICBkZXZpY2VfZmVhdHVyZXMgPSBhZGRfY29uZmlnLT5kZXZpY2VfZmVh
dHVyZXM7Cj4gICAgICAgICB9Cj4gKwo+ICsgICAgICAgdnBfdmRwYSA9IHZkcGFfYWxsb2NfZGV2
aWNlKHN0cnVjdCB2cF92ZHBhLCB2ZHBhLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGRldiwgJnZwX3ZkcGFfb3BzLCAxLCAxLCBuYW1lLCBmYWxzZSk7Cj4gKwo+ICsgICAg
ICAgaWYgKElTX0VSUih2cF92ZHBhKSkgewo+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwg
InZwX3ZkcGE6IEZhaWxlZCB0byBhbGxvY2F0ZSB2RFBBIHN0cnVjdHVyZVxuIik7Cj4gKyAgICAg
ICAgICAgICAgIHJldHVybiBQVFJfRVJSKHZwX3ZkcGEpOwo+ICsgICAgICAgfQo+ICsKPiArICAg
ICAgIHZwX3ZkcGFfbWd0ZGV2LT52cF92ZHBhID0gdnBfdmRwYTsKPiArCj4gKyAgICAgICB2cF92
ZHBhLT52ZHBhLmRtYV9kZXYgPSAmcGRldi0+ZGV2Owo+ICsgICAgICAgdnBfdmRwYS0+cXVldWVz
ID0gdl9tZGV2LT5tYXhfc3VwcG9ydGVkX3ZxczsKCldoeSBib3RoZXIgd2l0aCB0aG9zZSBjaGFu
Z2VzPwoKICAgICAgICBtZ3RkZXYtPm1heF9zdXBwb3J0ZWRfdnFzID0gdnBfbW9kZXJuX2dldF9u
dW1fcXVldWVzKG1kZXYpOwoKVGhhbmtzCgoKPiArICAgICAgIHZwX3ZkcGEtPm1kZXYgPSBtZGV2
Owo+ICAgICAgICAgdnBfdmRwYS0+ZGV2aWNlX2ZlYXR1cmVzID0gZGV2aWNlX2ZlYXR1cmVzOwo+
Cj4gICAgICAgICByZXQgPSBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoZGV2LCB2cF92ZHBhX2Zy
ZWVfaXJxX3ZlY3RvcnMsIHBkZXYpOwo+IC0tCj4gMi4yNS4xCj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
