Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1C6C77B7D
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 05:57:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B72486FE86;
	Wed, 17 May 2023 05:57:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B72486FE86
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D4W6A+YG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4zYM-bJc8k22; Wed, 17 May 2023 05:57:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4CE576FE77;
	Wed, 17 May 2023 05:57:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4CE576FE77
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27F4AC0037;
	Wed, 17 May 2023 05:57:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28452C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 05:57:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 00B37420A6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 05:57:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 00B37420A6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=D4W6A+YG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X9NI9n9I_voU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 05:57:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F8134209D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F8134209D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 05:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684303052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+qfUPr0uKNy+sb2n0bJkiBPdjAbSKuNDFcmJ6hILOM=;
 b=D4W6A+YGDTw3e3dCgJpzyPq24G0isFgkTEjlG+8xslBc32kZeJW6ntoEMkqiS8/M6uQOYs
 g3UawQpI0Ju0+UVtPb12pt/IHwUiIn7lKgSD/MRsq+ATAdHx1EtUfa9vd/zTGpiXpTv2xw
 jS/ytikcTPR7b/GWyGXa1LTYZx0pjxQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-O6RhN5TqP4Cfn11wY3_IPg-1; Wed, 17 May 2023 01:57:31 -0400
X-MC-Unique: O6RhN5TqP4Cfn11wY3_IPg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4edbdd8268bso276787e87.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 22:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684303050; x=1686895050;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w+qfUPr0uKNy+sb2n0bJkiBPdjAbSKuNDFcmJ6hILOM=;
 b=ZsDTevcuQYWg90Nj6yhLLODjYySQ0vOwTDs/A1JEnnIQOwrvHzWuQyUIkq33UUK2S/
 RkE2dXsozsQmwPlFuRh/A4C1mo42F95g7YWo5iFqZOoEPFhh6BxzAMQCk85Zy7geBVoL
 E9uYoH6bif82MBny0O6ucx09RhcTHqmiK4WICBIgBMZhJ0eKzIdTemUGHFejOz3DhUfH
 q0YwkeFRnklgGLiyaQnnZQwWz2bwT1y1lGIZxU74XMSKxlICOQvjdtwricDvkno3v4iJ
 WHN5xas4NQmMObQKXVskB4AAd7RLoxu5HmwxRnv70OOJe1dfxvLvmaW1SopG0BjOuueR
 JRWw==
X-Gm-Message-State: AC+VfDy2zAJb5L+XhFVc7iodLWPewtQ+LkIwJtgOwCf+iAPaHDpJaXfV
 qu077XSg8F8vEODOqBM6bg/cE5IjotUip5eHZjRm5CpUVuzhsKlyg41PFyjNzKNKXLMiINVnZ8Q
 +fQqafKXryQQRDFLIWYlFwba7KdluWtbQdyT4NFbkgi10oP6WlTwcjgi0bA==
X-Received: by 2002:ac2:48a7:0:b0:4ed:bfcf:3109 with SMTP id
 u7-20020ac248a7000000b004edbfcf3109mr7522455lfg.56.1684303050260; 
 Tue, 16 May 2023 22:57:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ljgjund9d0mLXFRAK8YCXSNJ/xM9q4oHcAJsFnVKMrNlFDXUWPH93HOgXxpZrLm3DBx3i14I2expvGHz3AfU=
X-Received: by 2002:ac2:48a7:0:b0:4ed:bfcf:3109 with SMTP id
 u7-20020ac248a7000000b004edbfcf3109mr7522452lfg.56.1684303049974; Tue, 16 May
 2023 22:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230511175451.282096-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230511175451.282096-1-krzysztof.kozlowski@linaro.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 May 2023 13:57:19 +0800
Message-ID: <CACGkMEsbhMSqVrXZtm_ynHFVsaX4jRt+9sAN7yLCE4kjy3jZhg@mail.gmail.com>
Subject: Re: [RESEND PATCH] vdpa: solidrun: constify pointers to
 hwmon_channel_info
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gRnJpLCBNYXkgMTIsIDIwMjMgYXQgMTo1NOKAr0FNIEtyenlzenRvZiBLb3psb3dza2kKPGty
enlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBTdGF0aWNhbGx5IGFsbG9j
YXRlZCBhcnJheSBvZiBwb2ludGVycyB0byBod21vbl9jaGFubmVsX2luZm8gY2FuIGJlIG1hZGUK
PiBjb25zdCBmb3Igc2FmZXR5Lgo+Cj4gQWNrZWQtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+Cj4gUmV2aWV3ZWQtYnk6IEFsdmFybyBLYXJzeiA8YWx2YXJvLmthcnN6QHNv
bGlkLXJ1bi5jb20+Cj4gU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6
dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+CgpUaGFua3MKCj4gLS0tCj4gIGRyaXZlcnMvdmRwYS9zb2xpZHJ1bi9zbmV0
X2h3bW9uLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9zb2xpZHJ1bi9zbmV0X2h3bW9u
LmMgYi9kcml2ZXJzL3ZkcGEvc29saWRydW4vc25ldF9od21vbi5jCj4gaW5kZXggNDJjODczODdh
MGYxLi5hZjUzMWEzMzkwODIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3NvbGlkcnVuL3Nu
ZXRfaHdtb24uYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9zb2xpZHJ1bi9zbmV0X2h3bW9uLmMKPiBA
QCAtMTU5LDcgKzE1OSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaHdtb25fb3BzIHNuZXRfaHdt
b25fb3BzID0gewo+ICAgICAgICAgLnJlYWRfc3RyaW5nID0gc25ldF9od21vbl9yZWFkX3N0cmlu
Zwo+ICB9Owo+Cj4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgaHdtb25fY2hhbm5lbF9pbmZvICpzbmV0
X2h3bW9uX2luZm9bXSA9IHsKPiArc3RhdGljIGNvbnN0IHN0cnVjdCBod21vbl9jaGFubmVsX2lu
Zm8gKiBjb25zdCBzbmV0X2h3bW9uX2luZm9bXSA9IHsKPiAgICAgICAgIEhXTU9OX0NIQU5ORUxf
SU5GTyh0ZW1wLCBIV01PTl9UX0lOUFVUIHwgSFdNT05fVF9NQVggfCBIV01PTl9UX0NSSVQgfCBI
V01PTl9UX0xBQkVMLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEhXTU9OX1RfSU5QVVQg
fCBIV01PTl9UX0NSSVQgfCBIV01PTl9UX0xBQkVMKSwKPiAgICAgICAgIEhXTU9OX0NIQU5ORUxf
SU5GTyhwb3dlciwgSFdNT05fUF9JTlBVVCB8IEhXTU9OX1BfTEFCRUwpLAo+IC0tCj4gMi4zNC4x
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
