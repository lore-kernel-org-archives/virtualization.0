Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D08C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 21:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9354B81310;
	Mon, 15 Aug 2022 21:53:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9354B81310
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZL94OKaX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b5dRkNtD_A0K; Mon, 15 Aug 2022 21:53:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 103A780EC1;
	Mon, 15 Aug 2022 21:53:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 103A780EC1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E78F0C0033;
	Mon, 15 Aug 2022 21:53:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E39D1C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:53:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C738B403EA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:53:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C738B403EA
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZL94OKaX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E93y5c_HJP4W
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:53:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D60A6403F8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D60A6403F8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660600408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3QJuMC2X3Ls7xg8Zv+wmV/GtRe9wR+MYC+AaCjrIFhI=;
 b=ZL94OKaXi6TbHNy8MM1DVTFLgwC6j46YDBUrx4S2KD8azO89ipYOjbiQ8/rL3c6FEOkFRI
 OzDfoo2cuZMO33SHQzVKfXbi5l4Yc0dfzA4ruQfJruS85QpXOhYG7H8oroeNBpocjV1QOD
 H+TLWM9WfA3Dulx3y8Ajzr2+5l/Z3Vw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-L67uRfHQN9Gh3MNXvgbk7Q-1; Mon, 15 Aug 2022 17:53:25 -0400
X-MC-Unique: L67uRfHQN9Gh3MNXvgbk7Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 z16-20020a05600c0a1000b003a5c18a66f0so4051197wmp.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 14:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=3QJuMC2X3Ls7xg8Zv+wmV/GtRe9wR+MYC+AaCjrIFhI=;
 b=f8ZP6UwR1o2YM4VBeB/SDSe2Mq/vQzBOW2b6PymsUcyT/S1NgW5C/s7EkhWhmJlWCs
 yELKSHHPxD7UfKaIojmwKYp7l08DFYM6u7A1e+yhO/oq33RZwbStQmIr13doNjrPssHh
 6m2UPYPf2URNAC/H9kV7sE+/IheZiFMSifNwikQOXoOHMZp+WKvj9svPgOq0dFXv2emC
 rumZYO/sPpyc3ZK900Y8JR+y4fxGFa4SGvcFKPk5wVOPN1xwofOdWAzWNElHbqFug/S3
 WkVAuw8Y3Dx1684IIwJJq06heFvJvJ2PzqAu3ueizxKA8y9abw3Cv/IVxnGFUIallrS1
 IvVg==
X-Gm-Message-State: ACgBeo3GEsMQNEznR1KcO9K1Bqv8PPx7Nn5cK9QrxuloTjK2oSKnMJKY
 NGWJ1OdYYbJskJYF75EKuIdvbKlh9sqsaGb1fbw7pwl+niRKIea7Ax9vtN5fh7JpQlW843xPnkZ
 GICBjowfiNvpKypc2WHBwrKYL3D5iernELfOGOiwxbg==
X-Received: by 2002:adf:ce89:0:b0:220:6cc5:aff8 with SMTP id
 r9-20020adfce89000000b002206cc5aff8mr9905792wrn.396.1660600404290; 
 Mon, 15 Aug 2022 14:53:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4OAJ7a0UnnYJ7tqTWqb9naQHIU382zVYRVHjmmnON5u7E9HsMntuwmikOY+aox36XmsS1mBQ==
X-Received: by 2002:adf:ce89:0:b0:220:6cc5:aff8 with SMTP id
 r9-20020adfce89000000b002206cc5aff8mr9905783wrn.396.1660600403993; 
 Mon, 15 Aug 2022 14:53:23 -0700 (PDT)
Received: from redhat.com ([2.55.4.37]) by smtp.gmail.com with ESMTPSA id
 n6-20020a1c2706000000b003a511e92abcsm10796901wmn.34.2022.08.15.14.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 14:53:23 -0700 (PDT)
Date: Mon, 15 Aug 2022 17:53:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] virtio: kerneldocs fixes and enhancements
Message-ID: <20220815215251.154451-2-mst@redhat.com>
References: <20220815215251.154451-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220815215251.154451-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Eric Dumazet <edumazet@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>
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

RnJvbTogUmljYXJkbyBDYcOxdWVsbyA8cmljYXJkby5jYW51ZWxvQGNvbGxhYm9yYS5jb20+CgpG
aXggdmFyaWFibGUgbmFtZXMgaW4gc29tZSBrZXJuZWxkb2NzLCBuYW1pbmcgaW4gb3RoZXJzLgpB
ZGQga2VybmVsZG9jcyBmb3Igc3RydWN0IHZyaW5nX2Rlc2MgYW5kIHZyaW5nX2ludGVycnVwdC4K
ClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQ2HDsXVlbG8gPHJpY2FyZG8uY2FudWVsb0Bjb2xsYWJv
cmEuY29tPgpNZXNzYWdlLUlkOiA8MjAyMjA4MTAwOTQwMDQuMTI1MC0yLXJpY2FyZG8uY2FudWVs
b0Bjb2xsYWJvcmEuY29tPgpTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogQ29ybmVsaWEgSHVjayA8Y29odWNrQHJlZGhhdC5jb20+
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMKaW5kZXggZDY2YzhlNmQwZWYzLi40NjIwZTlkNzlkZGUgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKKysrIGIvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYwpAQCAtMjQyNiw2ICsyNDI2LDE0IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBt
b3JlX3VzZWQoY29uc3Qgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEpCiAJcmV0dXJuIHZxLT5w
YWNrZWRfcmluZyA/IG1vcmVfdXNlZF9wYWNrZWQodnEpIDogbW9yZV91c2VkX3NwbGl0KHZxKTsK
IH0KIAorLyoqCisgKiB2cmluZ19pbnRlcnJ1cHQgLSBub3RpZnkgYSB2aXJ0cXVldWUgb24gYW4g
aW50ZXJydXB0CisgKiBAaXJxOiB0aGUgSVJRIG51bWJlciAoaWdub3JlZCkKKyAqIEBfdnE6IHRo
ZSBzdHJ1Y3QgdmlydHF1ZXVlIHRvIG5vdGlmeQorICoKKyAqIENhbGxzIHRoZSBjYWxsYmFjayBm
dW5jdGlvbiBvZiBAX3ZxIHRvIHByb2Nlc3MgdGhlIHZpcnRxdWV1ZQorICogbm90aWZpY2F0aW9u
LgorICovCiBpcnFyZXR1cm5fdCB2cmluZ19pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqX3ZxKQog
ewogCXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7CmRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAppbmRleCBh
M2Y3M2JiNjczM2UuLmRjYWI5YzdlODc4NCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0
aW8uaAorKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCkBAIC0xMSw3ICsxMSw3IEBACiAjaW5j
bHVkZSA8bGludXgvZ2ZwLmg+CiAKIC8qKgotICogdmlydHF1ZXVlIC0gYSBxdWV1ZSB0byByZWdp
c3RlciBidWZmZXJzIGZvciBzZW5kaW5nIG9yIHJlY2VpdmluZy4KKyAqIHN0cnVjdCB2aXJ0cXVl
dWUgLSBhIHF1ZXVlIHRvIHJlZ2lzdGVyIGJ1ZmZlcnMgZm9yIHNlbmRpbmcgb3IgcmVjZWl2aW5n
LgogICogQGxpc3Q6IHRoZSBjaGFpbiBvZiB2aXJ0cXVldWVzIGZvciB0aGlzIGRldmljZQogICog
QGNhbGxiYWNrOiB0aGUgZnVuY3Rpb24gdG8gY2FsbCB3aGVuIGJ1ZmZlcnMgYXJlIGNvbnN1bWVk
IChjYW4gYmUgTlVMTCkuCiAgKiBAbmFtZTogdGhlIG5hbWUgb2YgdGhpcyB2aXJ0cXVldWUgKG1h
aW5seSBmb3IgZGVidWdnaW5nKQpAQCAtOTcsNyArOTcsNyBAQCBpbnQgdmlydHF1ZXVlX3Jlc2l6
ZShzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdTMyIG51bSwKIAkJICAgICB2b2lkICgqcmVjeWNsZSko
c3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1ZikpOwogCiAvKioKLSAqIHZpcnRpb19kZXZp
Y2UgLSByZXByZXNlbnRhdGlvbiBvZiBhIGRldmljZSB1c2luZyB2aXJ0aW8KKyAqIHN0cnVjdCB2
aXJ0aW9fZGV2aWNlIC0gcmVwcmVzZW50YXRpb24gb2YgYSBkZXZpY2UgdXNpbmcgdmlydGlvCiAg
KiBAaW5kZXg6IHVuaXF1ZSBwb3NpdGlvbiBvbiB0aGUgdmlydGlvIGJ1cwogICogQGZhaWxlZDog
c2F2ZWQgdmFsdWUgZm9yIFZJUlRJT19DT05GSUdfU19GQUlMRUQgYml0IChmb3IgcmVzdG9yZSkK
ICAqIEBjb25maWdfZW5hYmxlZDogY29uZmlndXJhdGlvbiBjaGFuZ2UgcmVwb3J0aW5nIGVuYWJs
ZWQKQEAgLTE1Niw3ICsxNTYsNyBAQCBzaXplX3QgdmlydGlvX21heF9kbWFfc2l6ZShzdHJ1Y3Qg
dmlydGlvX2RldmljZSAqdmRldik7CiAJbGlzdF9mb3JfZWFjaF9lbnRyeSh2cSwgJnZkZXYtPnZx
cywgbGlzdCkKIAogLyoqCi0gKiB2aXJ0aW9fZHJpdmVyIC0gb3BlcmF0aW9ucyBmb3IgYSB2aXJ0
aW8gSS9PIGRyaXZlcgorICogc3RydWN0IHZpcnRpb19kcml2ZXIgLSBvcGVyYXRpb25zIGZvciBh
IHZpcnRpbyBJL08gZHJpdmVyCiAgKiBAZHJpdmVyOiB1bmRlcmx5aW5nIGRldmljZSBkcml2ZXIg
KHBvcHVsYXRlIG5hbWUgYW5kIG93bmVyKS4KICAqIEBpZF90YWJsZTogdGhlIGlkcyBzZXJ2aWNl
ZCBieSB0aGlzIGRyaXZlci4KICAqIEBmZWF0dXJlX3RhYmxlOiBhbiBhcnJheSBvZiBmZWF0dXJl
IG51bWJlcnMgc3VwcG9ydGVkIGJ5IHRoaXMgZHJpdmVyLgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC92aXJ0aW9fY29uZmlnLmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaAppbmRl
eCAzNmVjN2JlMWY0ODAuLjRiNTE3NjQ5Y2ZlOCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC92
aXJ0aW9fY29uZmlnLmgKKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKQEAgLTIz
OSw3ICsyMzksNyBAQCBpbnQgdmlydGlvX2ZpbmRfdnFzX2N0eChzdHJ1Y3QgdmlydGlvX2Rldmlj
ZSAqdmRldiwgdW5zaWduZWQgbnZxcywKIAogLyoqCiAgKiB2aXJ0aW9fc3luY2hyb25pemVfY2Jz
IC0gc3luY2hyb25pemUgd2l0aCB2aXJ0cXVldWUgY2FsbGJhY2tzCi0gKiBAdmRldjogdGhlIGRl
dmljZQorICogQGRldjogdGhlIHZpcnRpbyBkZXZpY2UKICAqLwogc3RhdGljIGlubGluZQogdm9p
ZCB2aXJ0aW9fc3luY2hyb25pemVfY2JzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpCkBAIC0y
NTgsNyArMjU4LDcgQEAgdm9pZCB2aXJ0aW9fc3luY2hyb25pemVfY2JzKHN0cnVjdCB2aXJ0aW9f
ZGV2aWNlICpkZXYpCiAKIC8qKgogICogdmlydGlvX2RldmljZV9yZWFkeSAtIGVuYWJsZSB2cSB1
c2UgaW4gcHJvYmUgZnVuY3Rpb24KLSAqIEB2ZGV2OiB0aGUgZGV2aWNlCisgKiBAZGV2OiB0aGUg
dmlydGlvIGRldmljZQogICoKICAqIERyaXZlciBtdXN0IGNhbGwgdGhpcyB0byB1c2UgdnFzIGlu
IHRoZSBwcm9iZSBmdW5jdGlvbi4KICAqCkBAIC0zMDYsNyArMzA2LDcgQEAgY29uc3QgY2hhciAq
dmlydGlvX2J1c19uYW1lKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQogLyoqCiAgKiB2aXJ0
cXVldWVfc2V0X2FmZmluaXR5IC0gc2V0dGluZyBhZmZpbml0eSBmb3IgYSB2aXJ0cXVldWUKICAq
IEB2cTogdGhlIHZpcnRxdWV1ZQotICogQGNwdTogdGhlIGNwdSBuby4KKyAqIEBjcHVfbWFzazog
dGhlIGNwdSBtYXNrCiAgKgogICogUGF5IGF0dGVudGlvbiB0aGUgZnVuY3Rpb24gYXJlIGJlc3Qt
ZWZmb3J0OiB0aGUgYWZmaW5pdHkgaGludCBtYXkgbm90IGJlIHNldAogICogZHVlIHRvIGNvbmZp
ZyBzdXBwb3J0LCBpcnEgdHlwZSBhbmQgc2hhcmluZy4KZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFw
aS9saW51eC92aXJ0aW9fcmluZy5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19yaW5nLmgK
aW5kZXggNDc2ZDNlNWMwZmU3Li5mOGMyMGQzZGU4ZGEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdWFw
aS9saW51eC92aXJ0aW9fcmluZy5oCisrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcmlu
Zy5oCkBAIC05MywxNSArOTMsMjEgQEAKICNkZWZpbmUgVlJJTkdfVVNFRF9BTElHTl9TSVpFIDQK
ICNkZWZpbmUgVlJJTkdfREVTQ19BTElHTl9TSVpFIDE2CiAKLS8qIFZpcnRpbyByaW5nIGRlc2Ny
aXB0b3JzOiAxNiBieXRlcy4gIFRoZXNlIGNhbiBjaGFpbiB0b2dldGhlciB2aWEgIm5leHQiLiAq
LworLyoqCisgKiBzdHJ1Y3QgdnJpbmdfZGVzYyAtIFZpcnRpbyByaW5nIGRlc2NyaXB0b3JzLAor
ICogMTYgYnl0ZXMgbG9uZy4gVGhlc2UgY2FuIGNoYWluIHRvZ2V0aGVyIHZpYSBAbmV4dC4KKyAq
CisgKiBAYWRkcjogYnVmZmVyIGFkZHJlc3MgKGd1ZXN0LXBoeXNpY2FsKQorICogQGxlbjogYnVm
ZmVyIGxlbmd0aAorICogQGZsYWdzOiBkZXNjcmlwdG9yIGZsYWdzCisgKiBAbmV4dDogaW5kZXgg
b2YgdGhlIG5leHQgZGVzY3JpcHRvciBpbiB0aGUgY2hhaW4sCisgKiAgICAgICAgaWYgdGhlIFZS
SU5HX0RFU0NfRl9ORVhUIGZsYWcgaXMgc2V0LiBXZSBjaGFpbiB1bnVzZWQKKyAqICAgICAgICBk
ZXNjcmlwdG9ycyB2aWEgdGhpcywgdG9vLgorICovCiBzdHJ1Y3QgdnJpbmdfZGVzYyB7Ci0JLyog
QWRkcmVzcyAoZ3Vlc3QtcGh5c2ljYWwpLiAqLwogCV9fdmlydGlvNjQgYWRkcjsKLQkvKiBMZW5n
dGguICovCiAJX192aXJ0aW8zMiBsZW47Ci0JLyogVGhlIGZsYWdzIGFzIGluZGljYXRlZCBhYm92
ZS4gKi8KIAlfX3ZpcnRpbzE2IGZsYWdzOwotCS8qIFdlIGNoYWluIHVudXNlZCBkZXNjcmlwdG9y
cyB2aWEgdGhpcywgdG9vICovCiAJX192aXJ0aW8xNiBuZXh0OwogfTsKIAotLSAKTVNUCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
