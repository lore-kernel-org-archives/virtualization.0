Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53C7C77B7A
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 05:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 694E784215;
	Wed, 17 May 2023 05:56:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 694E784215
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bdvSWKHe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xAT2K-Ah96MT; Wed, 17 May 2023 05:56:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 129A7841F6;
	Wed, 17 May 2023 05:56:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 129A7841F6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC0E2C0037;
	Wed, 17 May 2023 05:56:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41639C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 05:56:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C59840105
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 05:56:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C59840105
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bdvSWKHe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L0R7YKI_x6Om
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 05:56:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D25A40101
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D25A40101
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 05:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684303007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=paowWkASk16hubwATQo3Brz1Kl1HeTMdLB0m2zyw74E=;
 b=bdvSWKHeNOlIIJ/J6tl+/KPwH1yHn0QfdjYYJvworW22Q+sFX3I+J9O+8Tp0ZeCeOHxjdc
 jakieHi/okuIg1InoCb7CGVU5mfc06KHipu8ziJ2w4E80GEPWAl+wMYhbWy/6S06JzrMD5
 qePWxQrig26byjy3xdW6DuzvXy+0u+Y=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-56oPByizOJWiPJJHYcwNoA-1; Wed, 17 May 2023 01:56:45 -0400
X-MC-Unique: 56oPByizOJWiPJJHYcwNoA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4edc5526c5fso276408e87.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 22:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684303004; x=1686895004;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=paowWkASk16hubwATQo3Brz1Kl1HeTMdLB0m2zyw74E=;
 b=T2E8CMHYHtjYCKobHADt2JzMEZpWalcY1EvFLf8+N92SH+j1sGCtham+CnQn6aJ8Fm
 fZxof2d3yuFVmijamH34gwfM6IaqUj9ZJGa2g0VECiuzNeCFhOsljXmHa7UFBQgmX5xH
 Xf+ISPbaHjm9qEwm9otiewdT8TdV6T44mkRHmGdafBALexlUL1UXnZq7Bt9jJCm153mF
 cJKiueaBjgAr4tis93q07iUvvkqKKRJrCKCezNnDhQfaMs8b8AjDtjzh1LRQwAwAn2Fj
 sNyCo/PozAvgqjfO2VYEsbwn3MDO8HZJAoNApFl0XGxDx8gqNMmCJs/+RVTra6iVVvdT
 /Isg==
X-Gm-Message-State: AC+VfDyjgtdX/Ba/9iyKlTcIfR6wad0vNIPQJuFKz6dWcPcAmMLH+flT
 yik5DK6eSKko3AAf5YPCC7ehkWJM7VDtJKO4p53BRVlrSryD+LuR5fm+5gzan5McHY0nhizbPuJ
 vci0/lkBpuItwXkyffVamQmyWcNy7A4TifEUnZYm3mP6QLxkNbWpwzmO1tw==
X-Received: by 2002:a19:ee0f:0:b0:4f1:1de7:1aaf with SMTP id
 g15-20020a19ee0f000000b004f11de71aafmr8591206lfb.69.1684303004490; 
 Tue, 16 May 2023 22:56:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6c5lVz5bfrEcS2OQVMQdb5WrybHfTwnvBceDooNozxkZdY1qQHR0m0Uhv89nelaL2B6z9XJn/liEVS/bUZXdA=
X-Received: by 2002:a19:ee0f:0:b0:4f1:1de7:1aaf with SMTP id
 g15-20020a19ee0f000000b004f11de71aafmr8591199lfb.69.1684303004242; Tue, 16
 May 2023 22:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <29db10bca7e5ef6b1137282292660fc337a4323a.1683907102.git.allen.hubbe@amd.com>
In-Reply-To: <29db10bca7e5ef6b1137282292660fc337a4323a.1683907102.git.allen.hubbe@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 May 2023 13:56:33 +0800
Message-ID: <CACGkMEu2d2ap_jzUGH8MpLZvscEPGZLtDxRqM2gjPQ43GS1B1g@mail.gmail.com>
Subject: Re: [PATCH] vdpa: consume device_features parameter
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, allen.hubbe@amd.com, netdev@vger.kernel.org,
 dsahern@kernel.org, virtualization@lists.linux-foundation.org,
 drivers@pensando.io
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

T24gU2F0LCBNYXkgMTMsIDIwMjMgYXQgMTI6NDLigK9BTSBTaGFubm9uIE5lbHNvbiA8c2hhbm5v
bi5uZWxzb25AYW1kLmNvbT4gd3JvdGU6Cj4KPiBGcm9tOiBBbGxlbiBIdWJiZSA8YWxsZW4uaHVi
YmVAYW1kLmNvbT4KPgo+IENvbnN1bWUgdGhlIHBhcmFtZXRlciB0byBkZXZpY2VfZmVhdHVyZXMg
d2hlbiBwYXJzaW5nIGNvbW1hbmQgbGluZQo+IG9wdGlvbnMuICBPdGhlcndpc2UgdGhlIHBhcmFt
ZXRlciBtYXkgYmUgdXNlZCBhZ2FpbiBhcyBhbiBvcHRpb24gbmFtZS4KPgo+ICAjIHZkcGEgZGV2
IGFkZCAuLi4gZGV2aWNlX2ZlYXR1cmVzIDB4ZGVhZGJlZWYgbWFjIDAwOjExOjIyOjMzOjQ0OjU1
Cj4gIFVua25vd24gb3B0aW9uICIweGRlYWRiZWVmIgo+Cj4gRml4ZXM6IGE0NDQyY2U1OGViYiAo
InZkcGE6IGFsbG93IHByb3Zpc2lvbmluZyBkZXZpY2UgZmVhdHVyZXMiKQo+IFNpZ25lZC1vZmYt
Ynk6IEFsbGVuIEh1YmJlIDxhbGxlbi5odWJiZUBhbWQuY29tPgo+IFJldmlld2VkLWJ5OiBTaGFu
bm9uIE5lbHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4KCkFja2VkLWJ5OiBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+IC0tLQo+ICB2ZHBhL3ZkcGEuYyB8IDIg
KysKPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL3Zk
cGEvdmRwYS5jIGIvdmRwYS92ZHBhLmMKPiBpbmRleCAyNzY0N2Q3M2Q0OTguLjhhMmZjYTg2NDdi
NiAxMDA2NDQKPiAtLS0gYS92ZHBhL3ZkcGEuYwo+ICsrKyBiL3ZkcGEvdmRwYS5jCj4gQEAgLTM1
Myw2ICszNTMsOCBAQCBzdGF0aWMgaW50IHZkcGFfYXJndl9wYXJzZShzdHJ1Y3QgdmRwYSAqdmRw
YSwgaW50IGFyZ2MsIGNoYXIgKiphcmd2LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICZvcHRzLT5kZXZpY2VfZmVhdHVyZXMpOwo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIGlmIChlcnIpCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gZXJyOwo+ICsKPiArICAgICAgICAgICAgICAgICAgICAgICBORVhUX0FSR19GV0QoKTsK
PiAgICAgICAgICAgICAgICAgICAgICAgICBvX2ZvdW5kIHw9IFZEUEFfT1BUX1ZERVZfRkVBVFVS
RVM7Cj4gICAgICAgICAgICAgICAgIH0gZWxzZSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAg
ZnByaW50ZihzdGRlcnIsICJVbmtub3duIG9wdGlvbiBcIiVzXCJcbiIsICphcmd2KTsKPiAtLQo+
IDIuMTcuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
