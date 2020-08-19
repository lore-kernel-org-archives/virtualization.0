Return-Path: <SRS0=s1EX=B5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAE3C433DF
	for <virtualization@archiver.kernel.org>; Wed, 19 Aug 2020 02:55:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE422076E
	for <virtualization@archiver.kernel.org>; Wed, 19 Aug 2020 02:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMmkOu5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE422076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7AFD587823;
	Wed, 19 Aug 2020 02:55:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id reesduOlJbI3; Wed, 19 Aug 2020 02:55:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DB02686BC1;
	Wed, 19 Aug 2020 02:55:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C098DC088B;
	Wed, 19 Aug 2020 02:55:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 338E3C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 02:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2287285C92
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 02:55:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2kZYfmq4hJt5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 02:55:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 648BA85C28
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 02:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597805745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wzuFejnUa6/7SvIdePc4Dxw6u4PQ7TGHV2322mPlU3g=;
 b=gMmkOu5V/eNtPmyqlVoLZHPFBLJJpxvBw0knrjoPuFjYFXeZVbg4UP/HyGnVVNW+LlgHTZ
 J+MtH4Pb9BaesQzPWrbb2FcZcVGgVwq4MopVRbLOeNczpOBu8zyJTLX9Pp0WeSr87yBoqv
 zFNRAsUxEgU5PF6FCRIK270+RXbO3j0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-oPiGWvAuMPyaXe1nKkF9KA-1; Tue, 18 Aug 2020 22:55:40 -0400
X-MC-Unique: oPiGWvAuMPyaXe1nKkF9KA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 817141DDF4;
 Wed, 19 Aug 2020 02:55:39 +0000 (UTC)
Received: from [10.72.13.88] (ovpn-13-88.pek2.redhat.com [10.72.13.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22C73BA63;
 Wed, 19 Aug 2020 02:55:33 +0000 (UTC)
Subject: Re: [PATCH -next] vdpa: Remove duplicate include
To: YueHaibing <yuehaibing@huawei.com>, mst@redhat.com, tiwei.bie@intel.com
References: <20200818114906.58304-1-yuehaibing@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <13e0a08e-abda-9b0d-53b0-03f6948a80f3@redhat.com>
Date: Wed, 19 Aug 2020 10:55:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818114906.58304-1-yuehaibing@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjAvOC8xOCDkuIvljYg3OjQ5LCBZdWVIYWliaW5nIHdyb3RlOgo+IFJlbW92ZSBkdXBs
aWNhdGUgaW5jbHVkZSBmaWxlCj4KPiBTaWduZWQtb2ZmLWJ5OiBZdWVIYWliaW5nIDx5dWVoYWli
aW5nQGh1YXdlaS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDEgLQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zo
b3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gaW5kZXggM2ZhYjk0Zjg4ODk0Li45
NWUyYjgzMDdhMmEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiArKysgYi9k
cml2ZXJzL3Zob3N0L3ZkcGEuYwo+IEBAIC0yMiw3ICsyMiw2IEBACj4gICAjaW5jbHVkZSA8bGlu
dXgvbm9zcGVjLmg+Cj4gICAjaW5jbHVkZSA8bGludXgvdmhvc3QuaD4KPiAgICNpbmNsdWRlIDxs
aW51eC92aXJ0aW9fbmV0Lmg+Cj4gLSNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KPiAgIAo+ICAg
I2luY2x1ZGUgInZob3N0LmgiCj4gICAKCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
