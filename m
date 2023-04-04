Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D81C76196
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 01:51:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C9A560DFD;
	Tue,  4 Apr 2023 01:51:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C9A560DFD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e4qHqNNm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tvg1-bS5jn6D; Tue,  4 Apr 2023 01:51:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CB82860C11;
	Tue,  4 Apr 2023 01:51:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB82860C11
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3EB8C0037;
	Tue,  4 Apr 2023 01:51:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B295EC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 01:51:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7ECB34098E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 01:51:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7ECB34098E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=e4qHqNNm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8_STYQ1Nw5RL
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 01:51:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 895E540984
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 895E540984
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 01:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680573096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JS3mZcGJaHckmugfTVaadbrsrn59lLy/jmuAj/9XB14=;
 b=e4qHqNNmcC0GuRFZzOqJfZXbP7fWaD6hWMldXnu+i3dvWqF6Ri3bbmZl5wo2YjeKEG1JOJ
 qoZcX3Hsv9xrNUZdelADlBi6zurSCFz/XxbyTmxA6dS9WNvaKJ4n8qRQ/GfS+ml/ugQC5J
 cnUJ5T7Gnexs3DOb0tMgpqMvsB3jixA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-eXpccJQ9PI-lCYCYQV7W-g-1; Mon, 03 Apr 2023 21:51:35 -0400
X-MC-Unique: eXpccJQ9PI-lCYCYQV7W-g-1
Received: by mail-oi1-f198.google.com with SMTP id
 v3-20020aca6103000000b0038b19442c1cso1598378oib.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Apr 2023 18:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680573094; x=1683165094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JS3mZcGJaHckmugfTVaadbrsrn59lLy/jmuAj/9XB14=;
 b=up0tP/Vx7MVwXpBkusypgLyeMGtWiieOHIzZt8pOueEeIloGSOXNoPiXzsJUGFEulf
 SAHWYAtPQjkVKoWYeLuFeEWEC/lC2NYORoGKcXVUJDR4B3Lhws+V7kDrFr40/jEs4uPS
 hhVEV2uFAoa4ssoXj70aXxUM1+v1h633IJ8HyWvmsv0jzPic9aom0dDVq6x2/ZX//YbV
 sfMLhw1tmHFjy4FlVDa/iwY2rBtohSFJh6FPCTTEmMSOiYGTj1xoCDD712jKtGIgAjWX
 rxdPX1D5o7BGuRdMOD2NB3rSce2+0hbr4vFJ3IyYE8+hYtCgKZf2TnyHw2iLumTIWZJ1
 GzBg==
X-Gm-Message-State: AAQBX9cnzvkW6MkveTXcQEIteJDQmSj3hrcMRkoD966Z16GF/g6EMuC3
 Bq2qCjqAacHqTG7kTqePD8LcYK8k/ncZz1E8nNQJhbDkFj/X/iTnqC8ZN/aJnAKWYqwk8rdLjTY
 Vv+X8ZTGpJZuNfgEe/jjprRsD6AdQsQmwdi+XLGYSyQs8fiVdR3tVCxR/Ag==
X-Received: by 2002:a05:6870:65a3:b0:177:c2fb:8cec with SMTP id
 fp35-20020a05687065a300b00177c2fb8cecmr553256oab.9.1680573094560; 
 Mon, 03 Apr 2023 18:51:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZV/vij0AVEvV0KxcjKjuKpElcSQvs3XNJrvmfvE4xxLvvcLCfGMwDYCZWlrJn+lPzRXrBgQ2sjr7VNIEOJTw0=
X-Received: by 2002:a05:6870:65a3:b0:177:c2fb:8cec with SMTP id
 fp35-20020a05687065a300b00177c2fb8cecmr553249oab.9.1680573094381; Mon, 03 Apr
 2023 18:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230403114039.11102-1-elic@nvidia.com>
In-Reply-To: <20230403114039.11102-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Apr 2023 09:51:23 +0800
Message-ID: <CACGkMEtjE7LpR3dAVB8TZtmw4JU=zNkFzLSCYAi4qW1JV93AcA@mail.gmail.com>
Subject: Re: [PATCH v3] vdpa/mlx5: Add and remove debugfs in setup/teardown
 driver
To: Eli Cohen <elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: parav@mellanox.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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

T24gTW9uLCBBcHIgMywgMjAyMyBhdCA3OjQx4oCvUE0gRWxpIENvaGVuIDxlbGljQG52aWRpYS5j
b20+IHdyb3RlOgo+Cj4gVGhlIHJpZ2h0IHBsYWNlIHRvIGFkZCB0aGUgZGVidWdmcyBjcmVhdGUg
aXMgaW4KPiBzZXR1cF9kcml2ZXIoKSBhbmQgcmVtb3ZlIGl0IGluIHRlYXJkb3duX2RyaXZlcigp
Lgo+Cj4gQ3VycmVudCBjb2RlIGFkZHMgdGhlIGRlYnVnZnMgd2hlbiBjcmVhdGluZyB0aGUgZGV2
aWNlIGJ1dCByZXNldHRpbmcgYQo+IGRldmljZSB3aWxsIHJlbW92ZSB0aGUgZGVidWdmcyBzdWJ0
cmVlIGFuZCBzdWJzZXF1ZW50IHNldF9kcml2ZXIgd2lsbAo+IG5vdCBiZSBhYmxlIHRvIGNyZWF0
ZSB0aGUgZmlsZXMgc2luY2UgdGhlIGRlYnVnZnMgcG9pbnRlciBpcyBOVUxMLgo+Cj4gRml4ZXM6
IDI5NDIyMTAwNDMyMiAoInZkcGEvbWx4NTogQWRkIGRlYnVnZnMgc3VidHJlZSIpCj4gU2lnbmVk
LW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+CgpBY2tlZC1ieTogSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPgo+IHYzIC0+IHY0Ogo+IEZpeCBlcnJv
ciBmbG93IGluIHNldHVwX2RyaXZlcigpCj4gLS0tCj4gIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYyB8IDggKysrKysrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBpbmRleCA5
ZGYwNzNiMGRkNTYuLjlkYjllNTQyMTQ4NSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4
NS9uZXQvbWx4NV92bmV0LmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0
LmMKPiBAQCAtMjQ5MSwxMCArMjQ5MSwxMSBAQCBzdGF0aWMgaW50IHNldHVwX2RyaXZlcihzdHJ1
Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYpCj4gICAgICAgICAgICAgICAgIGVyciA9IDA7Cj4gICAg
ICAgICAgICAgICAgIGdvdG8gb3V0Owo+ICAgICAgICAgfQo+ICsgICAgICAgbWx4NV92ZHBhX2Fk
ZF9kZWJ1Z2ZzKG5kZXYpOwo+ICAgICAgICAgZXJyID0gc2V0dXBfdmlydHF1ZXVlcyhtdmRldik7
Cj4gICAgICAgICBpZiAoZXJyKSB7Cj4gICAgICAgICAgICAgICAgIG1seDVfdmRwYV93YXJuKG12
ZGV2LCAic2V0dXBfdmlydHF1ZXVlc1xuIik7Cj4gLSAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+
ICsgICAgICAgICAgICAgICBnb3RvIGVycl9zZXR1cDsKPiAgICAgICAgIH0KPgo+ICAgICAgICAg
ZXJyID0gY3JlYXRlX3JxdChuZGV2KTsKPiBAQCAtMjUyNCw2ICsyNTI1LDggQEAgc3RhdGljIGlu
dCBzZXR1cF9kcml2ZXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2KQo+ICAgICAgICAgZGVz
dHJveV9ycXQobmRldik7Cj4gIGVycl9ycXQ6Cj4gICAgICAgICB0ZWFyZG93bl92aXJ0cXVldWVz
KG5kZXYpOwo+ICtlcnJfc2V0dXA6Cj4gKyAgICAgICBtbHg1X3ZkcGFfcmVtb3ZlX2RlYnVnZnMo
bmRldi0+ZGVidWdmcyk7Cj4gIG91dDoKPiAgICAgICAgIHJldHVybiBlcnI7Cj4gIH0KPiBAQCAt
MjUzNyw2ICsyNTQwLDggQEAgc3RhdGljIHZvaWQgdGVhcmRvd25fZHJpdmVyKHN0cnVjdCBtbHg1
X3ZkcGFfbmV0ICpuZGV2KQo+ICAgICAgICAgaWYgKCFuZGV2LT5zZXR1cCkKPiAgICAgICAgICAg
ICAgICAgcmV0dXJuOwo+Cj4gKyAgICAgICBtbHg1X3ZkcGFfcmVtb3ZlX2RlYnVnZnMobmRldi0+
ZGVidWdmcyk7Cj4gKyAgICAgICBuZGV2LT5kZWJ1Z2ZzID0gTlVMTDsKPiAgICAgICAgIHRlYXJk
b3duX3N0ZWVyaW5nKG5kZXYpOwo+ICAgICAgICAgZGVzdHJveV90aXIobmRldik7Cj4gICAgICAg
ICBkZXN0cm95X3JxdChuZGV2KTsKPiBAQCAtMzI4Nyw3ICszMjkyLDYgQEAgc3RhdGljIGludCBt
bHg1X3ZkcGFfZGV2X2FkZChzdHJ1Y3QgdmRwYV9tZ210X2RldiAqdl9tZGV2LCBjb25zdCBjaGFy
ICpuYW1lLAo+ICAgICAgICAgaWYgKGVycikKPiAgICAgICAgICAgICAgICAgZ290byBlcnJfcmVn
Owo+Cj4gLSAgICAgICBtbHg1X3ZkcGFfYWRkX2RlYnVnZnMobmRldik7Cj4gICAgICAgICBtZ3Rk
ZXYtPm5kZXYgPSBuZGV2Owo+ICAgICAgICAgcmV0dXJuIDA7Cj4KPiAtLQo+IDIuMzguMQo+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
