Return-Path: <SRS0=+sYM=C3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5452C43465
	for <virtualization@archiver.kernel.org>; Fri, 18 Sep 2020 02:18:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7760E23772
	for <virtualization@archiver.kernel.org>; Fri, 18 Sep 2020 02:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByDmbHL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7760E23772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1163A87754;
	Fri, 18 Sep 2020 02:18:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C5i68g+lyF6e; Fri, 18 Sep 2020 02:18:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8BFB187651;
	Fri, 18 Sep 2020 02:18:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 719B6C0859;
	Fri, 18 Sep 2020 02:18:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB164C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 02:18:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CF9DB87136
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 02:18:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iMGWQSSc6ZfC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 02:18:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1CBC5872CD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 02:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600395499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fScXCn92Z2M4f5AGmAC2C4Z0ZYGJptb/Xy5j5iRbW78=;
 b=ByDmbHL3FHuSOEdaWNdsHFKLmGA48ZtOti1gA9+mnYc6u/UBznam2+dWqayBKLTvJN1vOE
 k6ywfMb9h6r51OPNZwJRKyKnSEljFAY/m/GlzrUS/tuwOb0IK/XyWfAFWgazjZoT/0zlE1
 0J+r1FtIAHg7JFkfhrrkt2VpF6ZOj8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-PPTSZXiXN8q1jnpCMVT9Rg-1; Thu, 17 Sep 2020 22:18:16 -0400
X-MC-Unique: PPTSZXiXN8q1jnpCMVT9Rg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C417C10BBED9;
 Fri, 18 Sep 2020 02:18:15 +0000 (UTC)
Received: from [10.72.13.167] (ovpn-13-167.pek2.redhat.com [10.72.13.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63F0555765;
 Fri, 18 Sep 2020 02:18:08 +0000 (UTC)
Subject: Re: [vhost next 0/2] mlx5 vdpa fix netdev status
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200917121320.GA98085@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c3b9f21c-11ae-b192-be5b-4a3bc0338712@redhat.com>
Date: Fri, 18 Sep 2020 10:18:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917121320.GA98085@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: lulu@redhat.com
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

Ck9uIDIwMjAvOS8xNyDkuIvljYg4OjEzLCBFbGkgQ29oZW4gd3JvdGU6Cj4gSGkgTWljaGFlbCwK
Pgo+IHRoZSBmb2xsb3dpbmcgdHdvIHBhdGNoZXMgYWltIHRvIGZpeCBhIGZhaWx1cmUgdG8gc2V0
IHRoZSB2ZHBhIGRyaXZlcgo+IHN0YXR1cyBiaXQgVklSVElPX05FVF9TX0xJTktfVVAgdGh1cyBj
YXVzaW5nIGZhaWx1cmUgdG8gYnJpbmcgdGhlIGxpbmsKPiB1cC4gSSBicmVhayBpdCB0byB0d28g
cGF0Y2hlczoKPgo+IDEuIEludHJvZHVjZSBwcm9wZXIgbWx4NSBBUEkgdG8gc2V0IDE2IGJpdCBz
dGF0dXMgZmllbGRzIHBlciB2aXJ0aW8KPiByZXF1aXJlbWVudHMuCj4gMi4gRml4IHRoZSBmYWls
dXJlIHRvIHNldCB0aGUgYml0Cj4KPiBFbGkgQ29oZW4gKDIpOgo+ICAgIHZkcGEvbWx4NTogTWFr
ZSB1c2Ugb2YgYSBzcGVjaWZpYyAxNiBiaXQgZW5kaWFubmVzcyBBUEkKPiAgICB2ZHBhL21seDU6
IEZpeCBmYWlsdXJlIHRvIGJyaW5nIGxpbmsgdXAKPgo+ICAgZHJpdmVycy92ZHBhL21seDUvbmV0
L21seDVfdm5ldC5jIHwgOSArKysrKysrLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
