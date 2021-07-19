Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57108C636C9
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 05:15:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C4561175
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 05:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C4561175
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42F11606AF;
	Mon, 19 Jul 2021 05:15:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lEPAwgcNMhNO; Mon, 19 Jul 2021 05:15:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E4DD3605F7;
	Mon, 19 Jul 2021 05:15:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5FE5C001A;
	Mon, 19 Jul 2021 05:15:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2DCAC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 05:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91A4660680
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 05:15:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EJXkI8Nol_Os
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 05:15:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from baidu.com (mx21.baidu.com [220.181.3.85])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5A25360643
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 05:15:01 +0000 (UTC)
Received: from BJHW-Mail-Ex08.internal.baidu.com (unknown [10.127.64.18])
 by Forcepoint Email with ESMTPS id 5AE66E362F1524674B1A;
 Mon, 19 Jul 2021 13:14:56 +0800 (CST)
Received: from BJHW-MAIL-EX25.internal.baidu.com (10.127.64.40) by
 BJHW-Mail-Ex08.internal.baidu.com (10.127.64.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 19 Jul 2021 13:14:56 +0800
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-MAIL-EX25.internal.baidu.com (10.127.64.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 19 Jul 2021 13:14:55 +0800
Received: from BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) by
 BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) with mapi id
 15.01.2308.014; Mon, 19 Jul 2021 13:14:55 +0800
From: "Cai,Huoqing" <caihuoqing@baidu.com>
To: "sgarzare@redhat.com" <sgarzare@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH 1/2] virtio_ring: fix error - unknown type name
 'spinlock_t'
Thread-Topic: [PATCH 1/2] virtio_ring: fix error - unknown type name
 'spinlock_t'
Thread-Index: AQHXeFgEtZ7bhfAxVUC3N/ftcHawDatJyDiQ
Date: Mon, 19 Jul 2021 05:14:55 +0000
Message-ID: <c25458bf5b2c46c390afb4851836f7dc@baidu.com>
References: <20210714022854.1077-1-caihuoqing@baidu.com>
 <20210714022854.1077-2-caihuoqing@baidu.com>
In-Reply-To: <20210714022854.1077-2-caihuoqing@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.18.18.49]
MIME-Version: 1.0
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex08_2021-07-19 13:14:56:368
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SXMgaXQgYSBlcnJvciwgIHRyeSChsG1ha2UgdmlydGlvobEgaW4gdGhlIHBhdGggb2YgbGludXgv
dG9vbHMvIHdpdGggY29uZmlnIFZIT1NUX0lPVExCPW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IENhaSxIdW9xaW5nIDxjYWlodW9xaW5nQGJhaWR1LmNvbT4gDQpTZW50OiAy
MDIxxOo31MIxNMjVIDEwOjI5DQpUbzogc2dhcnphcmVAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5j
b207IGphc293YW5nQHJlZGhhdC5jb20NCkNjOiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQ2FpLEh1b3Fpbmcg
PGNhaWh1b3FpbmdAYmFpZHUuY29tPg0KU3ViamVjdDogW1BBVENIIDEvMl0gdmlydGlvX3Jpbmc6
IGZpeCBlcnJvciAtIHVua25vd24gdHlwZSBuYW1lICdzcGlubG9ja190Jw0KDQp3aGVuIHJ1biAi
bWFrZSB2aXJ0aW8iIGluIGxpbnV4L3Rvb2xzLA0KdGhlIGVycm9yOiB1bmtub3duIHR5cGUgbmFt
ZSAnc3BpbmxvY2tfdCcgb2NjdXJzDQoNClNpZ25lZC1vZmYtYnk6IENhaSBIdW9xaW5nIDxjYWlo
dW9xaW5nQGJhaWR1LmNvbT4NCi0tLQ0KIGluY2x1ZGUvbGludXgvdnJpbmdoLmggfCAyICsrDQog
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC92cmluZ2guaCBiL2luY2x1ZGUvbGludXgvdnJpbmdoLmggaW5kZXggODRkYjdiOGY5MTJm
Li5mZjIxYzI2NDM3OTIgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3ZyaW5naC5oDQorKysg
Yi9pbmNsdWRlL2xpbnV4L3ZyaW5naC5oDQpAQCAtNDMsMTEgKzQzLDEzIEBAIHN0cnVjdCB2cmlu
Z2ggew0KICAgICAgICAvKiBUaGUgdnJpbmcgKG5vdGU6IGl0IG1heSBjb250YWluIHVzZXIgcG9p
bnRlcnMhKSAqLw0KICAgICAgICBzdHJ1Y3QgdnJpbmcgdnJpbmc7DQoNCisjaWYgSVNfUkVBQ0hB
QkxFKENPTkZJR19WSE9TVF9JT1RMQikNCiAgICAgICAgLyogSU9UTEIgZm9yIHRoaXMgdnJpbmcg
Ki8NCiAgICAgICAgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYjsNCg0KICAgICAgICAvKiBzcGlu
bG9jayB0byBzeW5jaHJvbml6ZSBJT1RMQiBhY2Nlc3NlcyAqLw0KICAgICAgICBzcGlubG9ja190
ICppb3RsYl9sb2NrOw0KKyNlbmRpZg0KDQogICAgICAgIC8qIFRoZSBmdW5jdGlvbiB0byBjYWxs
IHRvIG5vdGlmeSB0aGUgZ3Vlc3QgYWJvdXQgYWRkZWQgYnVmZmVycyAqLw0KICAgICAgICB2b2lk
ICgqbm90aWZ5KShzdHJ1Y3QgdnJpbmdoICopOw0KLS0NCjIuMjUuMQ0KDQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
