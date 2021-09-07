Return-Path: <SRS0=fvq/=N5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4ADC433EF
	for <virtualization@archiver.kernel.org>; Tue,  7 Sep 2021 07:20:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93836610CB
	for <virtualization@archiver.kernel.org>; Tue,  7 Sep 2021 07:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 93836610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C7DD60BC3;
	Tue,  7 Sep 2021 07:20:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dJDv4i3FclV8; Tue,  7 Sep 2021 07:20:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1AC606070F;
	Tue,  7 Sep 2021 07:20:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7077C000F;
	Tue,  7 Sep 2021 07:20:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90CACC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:20:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7DA08828D1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:20:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UxT7ZoeJIp-o
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:20:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF0E6828C5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630999248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s4Ly7fIbQ4JKQE44G4Zaruzx7ULS/iZdWe5zbP0bV4I=;
 b=QDjoNpQPE2znk53rXzcpXS3L222v2NE5tK/lD+YEpVDCH2uFGXY304LRpuMnpPnESMX4GS
 EzMsF06V0tVcnF1L34G7gYHyYCQ4kxDH4DW1w6DtP8IYm2Jeyv+drgQQip1dcBn+nES3s1
 IbKJ/17HTFy6/vQ5geY3MxJjm0qF66U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-BuGZdUJGN22SKzZsJkwoaQ-1; Tue, 07 Sep 2021 03:20:47 -0400
X-MC-Unique: BuGZdUJGN22SKzZsJkwoaQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 g17-20020a056402425100b003cd5ba2852fso4775996edb.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Sep 2021 00:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=s4Ly7fIbQ4JKQE44G4Zaruzx7ULS/iZdWe5zbP0bV4I=;
 b=ktHNLgCulFU7IUgtEpAPGkjEhvfM8XzTXT3ssIG8b06jETPAalGsnjCdG662t7rf4n
 YUvzg24ZbuUBpXkMMgMqBYJYc9xgdh1BP4abVdayO+OICv/aFLfk5kWHidsETaNYDcYp
 P4myfVKVWjE+JXUrNpmmw4U2T8tITbkrKspVhDqzaWkhCRQr+8MtCXKgL54rin3rGWe+
 VzDYIj5pkDQFHE7mN3s9CRBojpXAOHgzC+0bGBLKLIJMPU0JZgWF41KuZBf0ZzipUuAt
 +28MDq2nOHgFjzgHPFYnpSpDs9CyGlAMA3GGKoq7ZjUstWUtdn6MizoSdYj/67hYLBKv
 Ikcg==
X-Gm-Message-State: AOAM530tOck4GgMW5wsg28eM9U6dvWKDYOURW0gmX1XxOenbguXkqFhq
 P2ur0nkvNPKuudoXJr1P5r9i7J8dgcHffgotkYvx3olZZc3igigxYpvd/FN4lmajbcA+K1xHxi6
 gJO2+TZNF6zneiBmK6nqm7rGkYMFtizbSh2YSqwYjjQ==
X-Received: by 2002:a17:906:8684:: with SMTP id
 g4mr17008900ejx.262.1630999246765; 
 Tue, 07 Sep 2021 00:20:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycsKk7/2k3FGDdBfsw54D5sdZdgF9d1aZBwueZVYMOIqt9Oei7oj8hYc05kHLYdWZZo5FKfg==
X-Received: by 2002:a17:906:8684:: with SMTP id
 g4mr17008891ejx.262.1630999246637; 
 Tue, 07 Sep 2021 00:20:46 -0700 (PDT)
Received: from steredhat (host-79-51-2-59.retail.telecomitalia.it.
 [79.51.2.59])
 by smtp.gmail.com with ESMTPSA id n13sm5828597edq.91.2021.09.07.00.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Sep 2021 00:20:46 -0700 (PDT)
Date: Tue, 7 Sep 2021 09:20:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [PATCH] MAINTAINERS: add VM SOCKETS (AF_VSOCK) entry
Message-ID: <20210907072043.zaxobbj5gvj2qm3w@steredhat>
References: <20210906091159.66181-1-sgarzare@redhat.com>
 <52DB430E-AD5D-45A5-BF72-C103B2BD2511@vmware.com>
MIME-Version: 1.0
In-Reply-To: <52DB430E-AD5D-45A5-BF72-C103B2BD2511@vmware.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCBTZXAgMDYsIDIwMjEgYXQgMDI6NTA6NTlQTSArMDAwMCwgSm9yZ2VuIEhhbnNlbiB3
cm90ZToKPgo+Cj4+IE9uIDYgU2VwIDIwMjEsIGF0IDExOjExLCBTdGVmYW5vIEdhcnphcmVsbGEg
PHNnYXJ6YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+Pgo+PiBBZGQgYSBuZXcgZW50cnkgZm9yIFZN
IFNvY2tldHMgKEFGX1ZTT0NLKSB0aGF0IGNvdmVycyB2c29jayBjb3JlLAo+PiB0ZXN0cywgYW5k
IGhlYWRlcnMuIE1vdmUgc29tZSBnZW5lcmFsIHZzb2NrIHN0dWZmIGZyb20gdmlydGlvLXZzb2Nr
Cj4+IGVudHJ5IGludG8gdGhpcyBuZXcgbW9yZSBnZW5lcmFsIHZzb2NrIGVudHJ5Lgo+Pgo+PiBJ
J3ZlIGJlZW4gcmV2aWV3aW5nIGFuZCBjb250cmlidXRpbmcgZm9yIHRoZSBsYXN0IGZldyB5ZWFy
cywKPj4gc28gSSdtIGF2YWlsYWJsZSB0byBoZWxwIG1haW50YWluIHRoaXMgY29kZS4KPj4KPj4g
Q2M6IERleHVhbiBDdWkgPGRlY3VpQG1pY3Jvc29mdC5jb20+Cj4+IENjOiBKb3JnZW4gSGFuc2Vu
IDxqaGFuc2VuQHZtd2FyZS5jb20+Cj4+IENjOiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJl
ZGhhdC5jb20+Cj4+IFN1Z2dlc3RlZC1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0
LmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRo
YXQuY29tPgo+PiAtLS0KPj4KPj4gRGV4dWFuLCBKb3JnZW4sIFN0ZWZhbiwgd291bGQgeW91IGxp
a2UgdG8gY28tbWFpbnRhaW4gb3IKPj4gYmUgYWRkZWQgYXMgYSByZXZpZXdlcj8KPgo+SGkgU3Rl
ZmFubywKPgo+UGxlYXNlIGFkZCBtZSBhcyBhIG1haW50YWluZXIgYXMgd2VsbC4gSeKAmWxsIHRy
eSB0byBoZWxwIG1vcmUgb3V0LgoKVGhpcyBpcyBncmVhdCA6LSkKClNpbmNlIHRoaXMgcGF0Y2gg
aXMgYWxyZWFkeSBpbiB0aGUgbmV0IHRyZWUsIHBsZWFzZSBjYW4geW91IHNlbmQgYSAKZm9sbG93
dXAgYWRkaW5nIHlvdXJzZWxmIGFzIGNvLW1haW50YWluZXI/CgpUaGFua3MsClN0ZWZhbm8KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
