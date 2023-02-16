Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3C0C61DA4
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 13:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E987611A7;
	Thu, 16 Feb 2023 13:48:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E987611A7
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=7r+zhVsO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KpNs7hJKpMPR; Thu, 16 Feb 2023 13:48:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C611C6080A;
	Thu, 16 Feb 2023 13:48:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C611C6080A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACE50C0033;
	Thu, 16 Feb 2023 13:48:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E15AAC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 13:48:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BCC9C81EFE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 13:48:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCC9C81EFE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=7r+zhVsO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iOE0xyYfOsFT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 13:48:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E632813D5
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E632813D5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 13:48:34 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id z6so1318663pgk.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 05:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wtprkMmgE7hoJ6Y8aJ3Nve9pxuJnzGGALFqVXwWI6js=;
 b=7r+zhVsO05E4aQwd42ejOPV3GO7RVgTz0oj/B1uTxz5YPKbOYir3V69Jx8jPtIz13u
 xo2OJ15xoixlo7UlVM3HJjYCFfYNRhmugxRPZ3eiDZKhPLHfWDawV+fPH82MSWfBiiIp
 0O+2RkKYJBh/XRFDBZXgegv/WT73R71zsGFYDrw8vOUc80kpJTTQ2KT1y/ohQLAetETQ
 RTyuEmYE7A5N9YfaMIhZ9ltfMvk6uG2ajUXIcZg/GrOA9X1Oz9gAeUpqcM6mtsEkgjn/
 X5WWk7rCqALZnHEiDdvbvXC9Zd4gkusWPeJj4xROxIYprYEeBkHRsLc8VOz3Z6lEsYlp
 O2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wtprkMmgE7hoJ6Y8aJ3Nve9pxuJnzGGALFqVXwWI6js=;
 b=eYMQLJGPpgZXZH0ugCiDj236+5l9eGqzB0KLreB3DIINQgBUVfeqcCItuk+myGXQ09
 J5O/4tvBUfF0BD3iGosYG8bL/waWXM8P6CFFmaLhOmkqsYGfYeVZFwzenjzktGPWvV/8
 A1h3ZwfVjiaUtHDhA+wU5g527JSw0zuHubdLmnOjg4kfRSLm2bapGAtch7MdbYGzCkve
 TS/FTy3SVTjl11u2q13QdNeFhNExaaRkz2UQElRKFRNgGQ51qiSUTT6NFxfADx7qyOP/
 1/2exe+8gcDfQGgAoR1TGGkYNvfQK+U54XrUtPLEijXwx+kJZyoQgY6lBmH8/Jf4y6wj
 HmqA==
X-Gm-Message-State: AO0yUKWzrlwW2s9hP18weIqHz7cUB3mSuy1cwF8YmPXB6u8B92WuDH2Q
 855wT0OGY1UEitc9NAB2j2OzX15aVrGnIUUtlCFxoA==
X-Google-Smtp-Source: AK7set9Ibvt/gd41trfRELwqc0Ybl60labYoMsG/vCNdC7KGVO2grQsGWkcJBYvltqVAZCKYFh8StVF+jNDkP62nYdk=
X-Received: by 2002:a63:f508:0:b0:4fb:d8d:2362 with SMTP id
 w8-20020a63f508000000b004fb0d8d2362mr882406pgh.8.1676555314430; Thu, 16 Feb
 2023 05:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20230215173850.298832-1-eperezma@redhat.com>
 <20230215173850.298832-5-eperezma@redhat.com>
In-Reply-To: <20230215173850.298832-5-eperezma@redhat.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Thu, 16 Feb 2023 15:47:57 +0200
Message-ID: <CAJs=3_Ci0m2wGYmw6cbdmJmeM+Gv05z2sJ_mdnAbpTRm9pbP5w@mail.gmail.com>
Subject: Re: [PATCH v3 04/14] vdpa: add vhost_vdpa_suspend
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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

SGksCgo+IFRoZSBmdW5jdGlvbiB2aG9zdC5jOnZob3N0X2Rldl9zdG9wIGZldGNoZXMgdGhlIHZy
aW5nIGJhc2Ugc28gdGhlIHZxCj4gc3RhdGUgY2FuIGJlIG1pZ3JhdGVkIHRvIG90aGVyIGRldmlj
ZXMuICBIb3dldmVyLCB0aGlzIGlzIHVucmVsaWFibGUgaW4KPiB2ZHBhLCBzaW5jZSB3ZSBkaWRu
J3Qgc2lnbmFsIHRoZSBkZXZpY2UgdG8gc3VzcGVuZCB0aGUgcXVldWVzLCBtYWtpbmcKPiB0aGUg
dmFsdWUgZmV0Y2hlZCB1c2VsZXNzLgo+Cj4gU3VzcGVuZCB0aGUgZGV2aWNlIGlmIHBvc3NpYmxl
IGJlZm9yZSBmZXRjaGluZyBmaXJzdCBhbmQgc3Vic2VxdWVudAo+IHZyaW5nIGJhc2VzLgo+Cj4g
TW9yZW92ZXIsIHZkcGEgdG90YWxseSByZXNldCBhbmQgd2lwZXMgdGhlIGRldmljZSBhdCB0aGUg
bGFzdCBkZXZpY2UKPiBiZWZvcmUgZmV0Y2ggaXRzIHZyaW5ncyBiYXNlLCBtYWtpbmcgdGhhdCBv
cGVyYXRpb24gdXNlbGVzcyBpbiB0aGUgbGFzdAo+IGRldmljZS4gVGhpcyB3aWxsIGJlIGZpeGVk
IGluIGxhdGVyIHBhdGNoZXMgb2YgdGhpcyBzZXJpZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFdWdl
bmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiAtLS0KPiAgaHcvdmlydGlvL3Zob3N0
LXZkcGEuYyB8IDE5ICsrKysrKysrKysrKysrKysrKysKPiAgaHcvdmlydGlvL3RyYWNlLWV2ZW50
cyB8ICAxICsKPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0t
Z2l0IGEvaHcvdmlydGlvL3Zob3N0LXZkcGEuYyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPiBp
bmRleCAxZDAyMDlkNmFkLi43OTZmMzhkNjRlIDEwMDY0NAo+IC0tLSBhL2h3L3ZpcnRpby92aG9z
dC12ZHBhLmMKPiArKysgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gQEAgLTExMDksNiArMTEw
OSwyNCBAQCBzdGF0aWMgdm9pZCB2aG9zdF92ZHBhX3N2cXNfc3RvcChzdHJ1Y3Qgdmhvc3RfZGV2
ICpkZXYpCj4gICAgICB9Cj4gIH0KPgo+ICtzdGF0aWMgdm9pZCB2aG9zdF92ZHBhX3N1c3BlbmQo
c3RydWN0IHZob3N0X2RldiAqZGV2KQo+ICt7Cj4gKyAgICBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiA9
IGRldi0+b3BhcXVlOwo+ICsgICAgaW50IHI7Cj4gKwo+ICsgICAgaWYgKCF2aG9zdF92ZHBhX2Zp
cnN0X2RldihkZXYpIHx8Cj4gKyAgICAgICAgIShkZXYtPmJhY2tlbmRfZmVhdHVyZXMgJiBCSVRf
VUxMKFZIT1NUX0JBQ0tFTkRfRl9TVVNQRU5EKSkpIHsKClNob3VsZG4ndCBpdCBiZSBiYWNrZW5k
X2NhcD8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
