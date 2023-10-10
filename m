Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19E5CD68F1
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 06:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 60BF4403AC;
	Tue, 10 Oct 2023 06:42:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60BF4403AC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pv5tAHyV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nh5ETdcATkTJ; Tue, 10 Oct 2023 06:42:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A03FA40232;
	Tue, 10 Oct 2023 06:42:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A03FA40232
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6750BC0039;
	Tue, 10 Oct 2023 06:42:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D8A1C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:42:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 29061610EC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:42:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 29061610EC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pv5tAHyV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X-CNzEBTvbjX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:42:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DE8E660F48
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:42:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE8E660F48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696920135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHdmeQ1oXwDSdGe49zHWloEN920VxWDoZjPmVJPE1jQ=;
 b=Pv5tAHyV/74wr8/iAhbuiG6xB8wtdGF060JqVMaPxsTWq+FnDp64TK/ZOLTVHaDmk5W6ut
 z2f4v4qgvqco0P8uF56t6WrDJiOaneC8Mc8U9IuEUBUQ9sEXvt/dXfgcmyAFl5arYUF1MR
 eqe3+uiCUM7lBkr4jJlrXx1GXpBpBUE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-GrmSsNsFN7-Plu3mo_dDtA-1; Tue, 10 Oct 2023 02:42:14 -0400
X-MC-Unique: GrmSsNsFN7-Plu3mo_dDtA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50433ca6d81so4884235e87.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 23:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696920133; x=1697524933;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nHdmeQ1oXwDSdGe49zHWloEN920VxWDoZjPmVJPE1jQ=;
 b=n9LOMmRqUfL7j29LQk36/Qadl1nwC8tb/dsgF+82KhM0YZU1XMgEyTLMeiz+EsRXtw
 5ndilh0vZXu828xWf5jPj7NrGmPoS1xvlwOvv8lDlkVhQ39S1BTNxKQ0ZSiR7oUS70ph
 L10ZzvVDiGPUVwbUX2J11zIQgK+XE47oBH8pw0Nxqznp4wryTY15fXmZA1/8AxyRj+aM
 g5tHcIGDXWqgBCxBCz5qL9Pp6YFN8UMbJjUJAfKhUs3nDNIj1SD+It5i9UyLu24YO+q1
 Hloq3UfuMvI2/1rjCl9TslY4J1tRxVRmyf2SmfqPUT8buaZ9BPKq9I7TgKEKor8uhnA9
 YDng==
X-Gm-Message-State: AOJu0Yw7kFlftd+YqGmmwe2/6nmteKrhzW7bGyUdMD9KV2WQessgLCeO
 Qz9eoGj+ocJjqnxN7MzHKMGHfvPNdp+YX/pwUmY4d0+cCQgziar/4woZ2njrJWCvkT/K/pGOBr+
 abSFhS2MM+aIZnJbWeAtqZVIskObA3wy2jooPwBsuwjf1H/XLlQwGs4qjSQ==
X-Received: by 2002:a05:6512:39d4:b0:4fb:911b:4e19 with SMTP id
 k20-20020a05651239d400b004fb911b4e19mr17813660lfu.35.1696920133300; 
 Mon, 09 Oct 2023 23:42:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBr0Fc3oau7q85ZNa3dVVhvnnS2eaHik0APtyVt5VYtFniJxRLbHW+8KSlxltyZyr+NXoATHcCRPOVRSWWygg=
X-Received: by 2002:a05:6512:39d4:b0:4fb:911b:4e19 with SMTP id
 k20-20020a05651239d400b004fb911b4e19mr17813648lfu.35.1696920132996; Mon, 09
 Oct 2023 23:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231010031120.81272-1-xuanzhuo@linux.alibaba.com>
 <20231010031120.81272-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231010031120.81272-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Oct 2023 14:42:01 +0800
Message-ID: <CACGkMEt-p54mUmb5RqELXxZwmu8yjUKOFZf9Kuhbm6yOiva1CQ@mail.gmail.com>
Subject: Re: [PATCH vhost v3 2/4] virtio_pci: fix the common cfg map size
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

T24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgMTE6MTHigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IFRoZSBmdW5jdGlvbiB2cF9tb2Rlcm5fbWFwX2Nh
cGFiaWxpdHkoKSB0YWtlcyB0aGUgc2l6ZSBwYXJhbWV0ZXIsCj4gd2hpY2ggY29ycmVzcG9uZHMg
dG8gdGhlIHNpemUgb2YgdmlydGlvX3BjaV9jb21tb25fY2ZnLiBBcyBhIHJlc3VsdCwKPiB0aGlz
IGluZGljYXRlcyB0aGUgc2l6ZSBvZiBtZW1vcnkgYXJlYSB0byBtYXAuCj4KPiBOb3cgdGhlIHNp
emUgaXMgdGhlIHNpemUgb2YgdmlydGlvX3BjaV9jb21tb25fY2ZnLCBidXQgc29tZSBmZWF0dXJl
KHN1Y2gKPiBhcyB0aGUgX0ZfUklOR19SRVNFVCkgbmVlZHMgdGhlIHZpcnRpb19wY2lfbW9kZXJu
X2NvbW1vbl9jZmcsIHNvIHRoaXMKPiBjb21taXQgY2hhbmdlcyB0aGUgc2l6ZSB0byB0aGUgc2l6
ZSBvZiB2aXJ0aW9fcGNpX21vZGVybl9jb21tb25fY2ZnLgo+Cj4gRml4ZXM6IDBiNTBjZWNlMGI3
OCAoInZpcnRpb19wY2k6IGludHJvZHVjZSBoZWxwZXIgdG8gZ2V0L3NldCBxdWV1ZSByZXNldCIp
Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4K
CkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+IC0t
LQo+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybl9kZXYuYyB8IDIgKy0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMgYi9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcGNpX21vZGVybl9kZXYuYwo+IGluZGV4IGFhZDdkOTI5NmU3Ny4uOWNiNjAxZTE2
Njg4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuX2Rldi5j
Cj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMKPiBAQCAtMjkx
LDcgKzI5MSw3IEBAIGludCB2cF9tb2Rlcm5fcHJvYmUoc3RydWN0IHZpcnRpb19wY2lfbW9kZXJu
X2RldmljZSAqbWRldikKPiAgICAgICAgIGVyciA9IC1FSU5WQUw7Cj4gICAgICAgICBtZGV2LT5j
b21tb24gPSB2cF9tb2Rlcm5fbWFwX2NhcGFiaWxpdHkobWRldiwgY29tbW9uLAo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fcGNpX2Nv
bW1vbl9jZmcpLCA0LAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMCwg
c2l6ZW9mKHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcpLAo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgMCwgc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9j
b21tb25fY2ZnKSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEws
IE5VTEwpOwo+ICAgICAgICAgaWYgKCFtZGV2LT5jb21tb24pCj4gICAgICAgICAgICAgICAgIGdv
dG8gZXJyX21hcF9jb21tb247Cj4gLS0KPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
