Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50743C433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 03:45:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E752B60ED4
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 03:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E752B60ED4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A6100401B0;
	Tue, 12 Oct 2021 03:45:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PC-hmqk0U45s; Tue, 12 Oct 2021 03:45:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C6441401AE;
	Tue, 12 Oct 2021 03:45:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5619C000F;
	Tue, 12 Oct 2021 03:45:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC224C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 03:45:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE75A80D42
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 03:45:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 92JcT2ac4Bdr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 03:45:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DDC8080D41
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 03:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634010348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zeexGU51e3vYmEUlaGSPpjbIySlFsVG+RPUlciCb13Y=;
 b=g7VuKPJQLFMgsjpvI82jaKQl1bd2ey6x0N5oMtBBiY+ZBXvIkXkUsaomA3W2+PkvTQFIv2
 BhLpK7jovvK/ULDbTY8Y90J4gn6sUQAl9E5fNE28bxwJb+LMPnT1Y2j+5CC9lQIS/V58np
 W+lVeKFjLqF1Y4Y4pn1kMUxcG446sdQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-J4SIQ-YYPzCLBgBY4pMaIA-1; Mon, 11 Oct 2021 23:45:44 -0400
X-MC-Unique: J4SIQ-YYPzCLBgBY4pMaIA-1
Received: by mail-lf1-f71.google.com with SMTP id
 x33-20020a0565123fa100b003fcfd99073dso14203581lfa.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 20:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zeexGU51e3vYmEUlaGSPpjbIySlFsVG+RPUlciCb13Y=;
 b=BoxW9nsoKSrk2hEVEkNm3ZaXmMCdxaFlUA//nAaLW+y72AvRb/xxlzVyW1dIoR+v0/
 QweGE556YGKfOegSLq9Og1Fkr2EjVEdciKanOux9PqOKHFKxWlicyuIwNC+bathgD1GS
 fAvzd7LT6fRfoVsXnfidU7wxtSELc6tx0/L++hTL2/QQcSQ/PD7iDr6FGhzRmbnLhRUm
 dgQVuTG3eKXqGwzYPeubcs4TjukbTEB2YLBWyVoCXyAXMIp+5tZBWR1WYQ3n/qwdBGar
 1xHaE0ls3WvM0NSCMa2y9DP+bruuXTaPsOTbM2dnSjFzCr/hXJG94GXgWezbxzr9AciD
 COJA==
X-Gm-Message-State: AOAM532B7m+ySbgowl+anBLlGcT9QrVoBOZ5iSW6RgicQArPN6OxcduD
 VLLpkszHEXjsyk6XnK7NUuXUlipSFUgsX3+2BsuHyCcSV1qT7+sv2b3J6wh6vwws/0rkCRDJt2T
 rVrb6/dR/uEEnUppNmJXA17SI5m9oZ1oMlfur9vJIN++MV1rHyvKvmXEMMw==
X-Received: by 2002:a05:6512:3b22:: with SMTP id
 f34mr29615045lfv.629.1634010343261; 
 Mon, 11 Oct 2021 20:45:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBfhDcD8P9heIBeiFoVy3OsD6cBfwDChLGhGX26b6vPJdSsrG3Px6fUedr0m9nS4ZP8ZIOdqPkC0YqeD5xI04=
X-Received: by 2002:a05:6512:3b22:: with SMTP id
 f34mr29615031lfv.629.1634010343108; 
 Mon, 11 Oct 2021 20:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211005134843.439050-1-eperezma@redhat.com>
 <20211005134843.439050-2-eperezma@redhat.com>
In-Reply-To: <20211005134843.439050-2-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Oct 2021 11:45:32 +0800
Message-ID: <CACGkMEtHdXSNT8v0UwWMd+eSVk6D0ztpOA9LpzF38b0eqiGcmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] vdpa: Skip protected ram IOMMU mappings
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>
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

T24gVHVlLCBPY3QgNSwgMjAyMSBhdCA5OjQ5IFBNIEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IEZvbGxvd2luZyB0aGUgbG9naWMgb2YgY29tbWl0IDU2OTE4
YTEyNmFlICgibWVtb3J5OiBBZGQgUkFNX1BST1RFQ1RFRAo+IGZsYWcgdG8gc2tpcCBJT01NVSBt
YXBwaW5ncyIpIHdpdGggVkZJTywgc2tpcCBtZW1vcnkgc2VjdGlvbnMKPiBpbmFjY2Vzc2libGUg
dmlhIG5vcm1hbCBtZWNoYW5pc21zLCBpbmNsdWRpbmcgRE1BLgo+Cj4gU2lnbmVkLW9mZi1ieTog
RXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+CgpBY2tlZC1ieTogSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCj4gLS0tCj4gIGh3L3ZpcnRpby92aG9zdC12ZHBhLmMg
fCAxICsKPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPiBkaWZmIC0tZ2l0IGEv
aHcvdmlydGlvL3Zob3N0LXZkcGEuYyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPiBpbmRleCA0
N2Q3YTVhMjNkLi5lYTFhYTcxYWQ4IDEwMDY0NAo+IC0tLSBhL2h3L3ZpcnRpby92aG9zdC12ZHBh
LmMKPiArKysgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gQEAgLTI4LDYgKzI4LDcgQEAgc3Rh
dGljIGJvb2wgdmhvc3RfdmRwYV9saXN0ZW5lcl9za2lwcGVkX3NlY3Rpb24oTWVtb3J5UmVnaW9u
U2VjdGlvbiAqc2VjdGlvbikKPiAgewo+ICAgICAgcmV0dXJuICghbWVtb3J5X3JlZ2lvbl9pc19y
YW0oc2VjdGlvbi0+bXIpICYmCj4gICAgICAgICAgICAgICFtZW1vcnlfcmVnaW9uX2lzX2lvbW11
KHNlY3Rpb24tPm1yKSkgfHwKPiArICAgICAgICAgICAgbWVtb3J5X3JlZ2lvbl9pc19wcm90ZWN0
ZWQoc2VjdGlvbi0+bXIpIHx8Cj4gICAgICAgICAgICAgLyogdmhvc3QtdkRQQSBkb2Vzbid0IGFs
bG93IE1NSU8gdG8gYmUgbWFwcGVkICAqLwo+ICAgICAgICAgICAgICBtZW1vcnlfcmVnaW9uX2lz
X3JhbV9kZXZpY2Uoc2VjdGlvbi0+bXIpIHx8Cj4gICAgICAgICAgICAgLyoKPiAtLQo+IDIuMjcu
MAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
