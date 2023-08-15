Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0529C001B0
	for <virtualization@archiver.kernel.org>; Tue, 15 Aug 2023 02:25:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 602E760BE1;
	Tue, 15 Aug 2023 02:25:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 602E760BE1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZWwcMBor
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LcCmK9EPBVFe; Tue, 15 Aug 2023 02:25:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EA56E60BA3;
	Tue, 15 Aug 2023 02:25:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA56E60BA3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C20F3C0071;
	Tue, 15 Aug 2023 02:25:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 098EEC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 02:25:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C45CA81B26
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 02:25:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C45CA81B26
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZWwcMBor
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G-C9Ml7taqO1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 02:25:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1822A814AB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 02:25:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1822A814AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692066334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=huMkYyI3IopZTTExqIZljSG+E6z9zvyVd59pXzY9sp0=;
 b=ZWwcMBorVRDwHEH9JdZ0K4Zz0sR68a1j2Js5cJQZndy3CElAAMpUBeTITbKiSaGjSgVBV9
 LqlCKVltEWDIiPFdTVreAJsQx180AowHTFJD1jXpFI/x0ekpMwElTcKR+8dd0Nq2PwmHIv
 bHLd0Cd2eITtRYwHz3Bi0d0oxGofsZk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-JD8g9TXoOviUJTeeZiuL3g-1; Mon, 14 Aug 2023 22:25:32 -0400
X-MC-Unique: JD8g9TXoOviUJTeeZiuL3g-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4fe3fb358easo4851199e87.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 19:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692066331; x=1692671131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=huMkYyI3IopZTTExqIZljSG+E6z9zvyVd59pXzY9sp0=;
 b=f9T4b+pxZc03VtAppUFyTCNyBD9Rsz0U1bONu3dh1Wf4r8Hl4p1PC05ZzseMYxfCqs
 JnjDhcl8D110T6TsYfb3O3p6pDs7g4jFo6pAdr2hOvyWSfKcgyvDgAQzjqIwUE217Plr
 veToYljZ3AvHFIJWQwjfMOLjXBz7iayiNOMuqQcWd7rE8o4JnlvU+WxoaGlRXiEy6Mj0
 UyuI9VUrA8tg5nTBcebqZFLY0WWfkoHzTfdfmw+tsF461REnqadVBQOwt3g/yJSjBgJ4
 WA+52rfMnxJSnPt8P+Slx5Hj3rxUZNPyhklxeNOLwwDbjxFa8eY/1g5S38hG/G1LxQlM
 p8zw==
X-Gm-Message-State: AOJu0YxKzFNQFd/mdBg+hgqG2o/GR72yNXBj+gqD47vmDr3Mv+9+l3uU
 OWIxWIhwUfXKM01YMg0vuGp5w9/Y5xP5dmZhce1pr9MOqbL2W96NwuyOPjdETh13454t8UH3+9u
 8WdFXek2BVUdrXj2mBH0pv5rKP+VuhlNmeUfJ00ezLHmf4kpuqnvvaJtLCw==
X-Received: by 2002:a2e:8188:0:b0:2b1:ad15:fe38 with SMTP id
 e8-20020a2e8188000000b002b1ad15fe38mr8101341ljg.3.1692066331498; 
 Mon, 14 Aug 2023 19:25:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvNiChZXsvQ/GLTCda14YUfdruIORDb1RwBBHhABgmjUe5mDgZEACu5ef/nXi9/8n+tfCK+O1Ea5+BczO9278=
X-Received: by 2002:a2e:8188:0:b0:2b1:ad15:fe38 with SMTP id
 e8-20020a2e8188000000b002b1ad15fe38mr8101327ljg.3.1692066331219; Mon, 14 Aug
 2023 19:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
 <1692063807-5018-5-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1692063807-5018-5-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Aug 2023 10:25:20 +0800
Message-ID: <CACGkMEuCDN7U2ANYvRa1TuhH5iR5rb2cdHVixwE_C9zgP__9GQ@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] vhost-vdpa: introduce IOTLB_PERSIST backend
 feature bit
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, gal@nvidia.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
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

T24gVHVlLCBBdWcgMTUsIDIwMjMgYXQgOTo0NeKAr0FNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4gd3JvdGU6Cj4KPiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWku
bGl1QG9yYWNsZS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvdmhvc3QvdmRwYS5jICAgICAgICAgICAg
IHwgMTYgKysrKysrKysrKysrKysrLQo+ICBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlwZXMu
aCB8ICAyICsrCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9z
dC92ZHBhLmMKPiBpbmRleCA2MmIwYTAxLi43NTA5MmE3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
dmhvc3QvdmRwYS5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBAQCAtNDA2LDYgKzQw
NiwxNCBAQCBzdGF0aWMgYm9vbCB2aG9zdF92ZHBhX2Nhbl9yZXN1bWUoY29uc3Qgc3RydWN0IHZo
b3N0X3ZkcGEgKnYpCj4gICAgICAgICByZXR1cm4gb3BzLT5yZXN1bWU7Cj4gIH0KPgo+ICtzdGF0
aWMgYm9vbCB2aG9zdF92ZHBhX2hhc19wZXJzaXN0ZW50X21hcChjb25zdCBzdHJ1Y3Qgdmhvc3Rf
dmRwYSAqdikKPiArewo+ICsgICAgICAgc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRw
YTsKPiArICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEtPmNv
bmZpZzsKPiArCj4gKyAgICAgICByZXR1cm4gKCFvcHMtPnNldF9tYXAgJiYgIW9wcy0+ZG1hX21h
cCkgfHwgb3BzLT5yZXNldF9tYXA7CgpTbyB0aGlzIG1lYW5zIHRoZSBJT1RMQi9JT01NVSBtYXBw
aW5ncyBoYXZlIGFscmVhZHkgYmVlbiBkZWNvdXBsZWQKZnJvbSB0aGUgdmRwYSByZXNldC4gU28g
aXQgc2hvdWxkIGhhdmUgYmVlbiBub3RpY2VkIGJ5IHRoZSB1c2Vyc3BhY2UuCkkgZ3Vlc3Mgd2Ug
Y2FuIGp1c3QgZml4IHRoZSBzaW11bGF0b3IgYW5kIG1seDUgdGhlbiB3ZSBhcmUgZmluZT8KClRo
YW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
