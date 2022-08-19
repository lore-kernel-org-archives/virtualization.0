Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CF0C25B0E
	for <virtualization@archiver.kernel.org>; Fri, 19 Aug 2022 00:55:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7698A60A7E;
	Fri, 19 Aug 2022 00:55:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7698A60A7E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YkXuRSRi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KnsCnwbf-trd; Fri, 19 Aug 2022 00:55:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1D7B360AC1;
	Fri, 19 Aug 2022 00:55:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D7B360AC1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AED1FC0032;
	Fri, 19 Aug 2022 00:55:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2934C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 00:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A46BE41BA2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 00:55:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A46BE41BA2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YkXuRSRi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LIX_FdIAN9Tp
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 00:55:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B29FF41B9E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B29FF41B9E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 00:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660870544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nAd/+cM4nZ9kiL+UQq/k1a1/NhUGZtyDcD6og5LvfI0=;
 b=YkXuRSRiDsknmVR7rbbnNyhzTaWJrjCyVKjTR2dk1lZGlXSUUhZRkpMwHCp0wKpI+j4D2r
 1ZmPHCWbObdWLY1AvcjcsY9lRS8pHiuSR5Vlr+ZUMF3Q6SJaFvLT/fz+ScpzKRPmksGurY
 AMAlHIUg5DKmzjM3g3l/o4RzKM73iuE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-661-UOFJXlzDOXCxM9Do0aYUEg-1; Thu, 18 Aug 2022 20:55:43 -0400
X-MC-Unique: UOFJXlzDOXCxM9Do0aYUEg-1
Received: by mail-lf1-f71.google.com with SMTP id
 y2-20020ac24462000000b0048cf602474aso971737lfl.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 17:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=nAd/+cM4nZ9kiL+UQq/k1a1/NhUGZtyDcD6og5LvfI0=;
 b=OvQH8dtVQhrUcsK09aodEQvByRZjCI9Talhi5UL1nJRzSk/NmoBTi4VZXwbPeQHo7L
 qtHbpP2Oe3YUeRAcxwc064yEx1SWPltjH/MDchpzeGunnC9dwDduWWevTsb/0kkKKaHI
 b+vonAvzbOyq91Hq/4lUJ+35RTLLiVyEuPJdvy4erJ8OwxRFNL4SQU1H3jd9srMDEgAm
 dmzoTO3Q+NWxK7ovKyCWskfeFMDguQsS9oU1RvuXwyf7f1UPjDVtJ8k6Gh6L9EdwPQhy
 wmwXW0vPNKSEPxrNI+hObPQMhW0kN7aoyCyWnCW5wPjOy6JbEjh6ffZzc0njS0FubXga
 VjEA==
X-Gm-Message-State: ACgBeo123+Qde+SWogqItbJDA+omf24gTxVjP33ew2EV85eKyUJJOP3G
 s9nxWn6DwZ3hN19fr5aEp+EiIfz4PXaHEAAnBA0bKzry1rQ7g2fu5eQ+yd7mUf4HE6k07kCLgMA
 6cJuXGvdZzrE+uKVIKYmRjMLRvpznloongwpuoxOAnPfunm/gwMj25JYk+w==
X-Received: by 2002:a2e:a5c3:0:b0:261:ac2d:2820 with SMTP id
 n3-20020a2ea5c3000000b00261ac2d2820mr1575620ljp.243.1660870541940; 
 Thu, 18 Aug 2022 17:55:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5yNZcX0ZYYl5wi2Ajj1Zn3BopMcLzRyHDmesw1YcQgFxMbsXTpyZrKS/KZ/n0mefgLfPKqM+qY83EfJJoPgEg=
X-Received: by 2002:a2e:a5c3:0:b0:261:ac2d:2820 with SMTP id
 n3-20020a2ea5c3000000b00261ac2d2820mr1575598ljp.243.1660870541756; Thu, 18
 Aug 2022 17:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220811135353.2549658-1-eperezma@redhat.com>
 <20220811135353.2549658-2-eperezma@redhat.com>
In-Reply-To: <20220811135353.2549658-2-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Aug 2022 08:55:30 +0800
Message-ID: <CACGkMEvz3kKKhpnn6=P1BiSYgvDaSx_t_QuTAKo6yYC8UH_aAA@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] vdpa: delete unreachable branch on vdpasim_suspend
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Kamde, Tanuj" <tanuj.kamde@amd.com>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>,
 Pablo Cascon Katchadourian <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, Cindy Lu <lulu@redhat.com>, "Uminski,
 Piotr" <Piotr.Uminski@intel.com>,
 Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, Dinan Gunawardena <dinang@xilinx.com>,
 Martin Habets <habetsm.xilinx@gmail.com>, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Laurent Vivier <lvivier@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 ecree.xilinx@gmail.com, Harpreet Singh Anand <hanand@xilinx.com>,
 Martin Porter <martinpo@xilinx.com>, "Dawar, Gautam" <gautam.dawar@amd.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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

T24gVGh1LCBBdWcgMTEsIDIwMjIgYXQgOTo1NCBQTSBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBJdCB3YXMgYSBsZWZ0b3ZlciBmcm9tIHByZXZpb3VzIHZl
cnNpb25zLgo+Cj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhh
dC5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCj4gLS0t
Cj4gIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIHwgNyAtLS0tLS0tCj4gIDEgZmls
ZSBjaGFuZ2VkLCA3IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92
ZHBhX3NpbS92ZHBhX3NpbS5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiBp
bmRleCAyMTM4ODM0ODdmOWIuLjc5YTUwZWRmODk5OCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zk
cGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBh
X3NpbS5jCj4gQEAgLTUwOSwxNiArNTA5LDkgQEAgc3RhdGljIGludCB2ZHBhc2ltX3Jlc2V0KHN0
cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkKPiAgc3RhdGljIGludCB2ZHBhc2ltX3N1c3BlbmQoc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZHBhKQo+ICB7Cj4gICAgICAgICBzdHJ1Y3QgdmRwYXNpbSAqdmRw
YXNpbSA9IHZkcGFfdG9fc2ltKHZkcGEpOwo+IC0gICAgICAgaW50IGk7Cj4KPiAgICAgICAgIHNw
aW5fbG9jaygmdmRwYXNpbS0+bG9jayk7Cj4gICAgICAgICB2ZHBhc2ltLT5ydW5uaW5nID0gZmFs
c2U7Cj4gLSAgICAgICBpZiAodmRwYXNpbS0+cnVubmluZykgewo+IC0gICAgICAgICAgICAgICAv
KiBDaGVjayBmb3IgbWlzc2VkIGJ1ZmZlcnMgKi8KPiAtICAgICAgICAgICAgICAgZm9yIChpID0g
MDsgaSA8IHZkcGFzaW0tPmRldl9hdHRyLm52cXM7ICsraSkKPiAtICAgICAgICAgICAgICAgICAg
ICAgICB2ZHBhc2ltX2tpY2tfdnEodmRwYSwgaSk7Cj4gLQo+IC0gICAgICAgfQo+ICAgICAgICAg
c3Bpbl91bmxvY2soJnZkcGFzaW0tPmxvY2spOwo+Cj4gICAgICAgICByZXR1cm4gMDsKPiAtLQo+
IDIuMzEuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
