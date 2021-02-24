Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBBFC433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 09:30:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C14264EBB
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 09:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C14264EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 19F9343090;
	Wed, 24 Feb 2021 09:30:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d23R9RISGS4f; Wed, 24 Feb 2021 09:30:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id C304243050;
	Wed, 24 Feb 2021 09:30:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EF35C000B;
	Wed, 24 Feb 2021 09:30:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C9B8C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:30:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3ED3343090
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:30:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pXqJEoFGgAd6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:30:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 92C3B43050
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614159052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7aDdkz1NoI966nz5oxyifwdANt/93ivruZ7xE/ouurI=;
 b=Lc7iRSzoVb3Gm2IU9aiVufLKL0GbGXpYuqflwn4ad4ZK8YkvRO+muG0NHLV0jVrJNXIxpM
 Jj6MaVLMJlGK21dY7HY0i6ipgjzRt3MOeP3AKL5lDyLlguxSOT8HdbEq0KMirFP+WITIuy
 n7oabmQ8QIrq7bUWdCDO5v8/fUHgjo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-OesmgzzbMM6P57rwNLKp_A-1; Wed, 24 Feb 2021 04:30:50 -0500
X-MC-Unique: OesmgzzbMM6P57rwNLKp_A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BFF480364D;
 Wed, 24 Feb 2021 09:30:49 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-28.pek2.redhat.com
 [10.72.12.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EADDD6064B;
 Wed, 24 Feb 2021 09:30:38 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <0559fd8c-ff44-cb7a-8a74-71976dd2ee33@redhat.com>
 <20210224014232-mutt-send-email-mst@kernel.org>
 <ce6b0380-bc4c-bcb8-db82-2605e819702c@redhat.com>
 <20210224021222-mutt-send-email-mst@kernel.org>
 <babc654d-8dcd-d8a2-c3b6-d20cc4fc554c@redhat.com>
 <20210224034240-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d2992c03-d639-54e3-4599-c168ceeac148@redhat.com>
Date: Wed, 24 Feb 2021 17:30:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224034240-mutt-send-email-mst@kernel.org>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org, elic@nvidia.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMi8yNCA0OjQzIOS4i+WNiCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IFdlZCwgRmViIDI0LCAyMDIxIGF0IDA0OjI2OjQzUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+ICAgICAgQmFzaWNhbGx5IG9uIGZpcnN0IGd1ZXN0IGFjY2VzcyBRRU1VIHdvdWxkIHRlbGwg
a2VybmVsIHdoZXRoZXIKPj4gICAgICBndWVzdCBpcyB1c2luZyB0aGUgbGVnYWN5IG9yIHRoZSBt
b2Rlcm4gaW50ZXJmYWNlLgo+PiAgICAgIEUuZy4gdmlydGlvX3BjaV9jb25maWdfcmVhZC92aXJ0
aW9fcGNpX2NvbmZpZ193cml0ZSB3aWxsIGNhbGwgaW9jdGwoRU5BQkxFX0xFR0FDWSwgMSkKPj4g
ICAgICB3aGlsZSB2aXJ0aW9fcGNpX2NvbW1vbl9yZWFkIHdpbGwgY2FsbCBpb2N0bChFTkFCTEVf
TEVHQUNZLCAwKQo+Pgo+Pgo+PiBCdXQgdGhpcyB0cmljayB3b3JrIG9ubHkgZm9yIFBDSSBJIHRo
aW5rPwo+Pgo+PiBUaGFua3MKPiBjY3cgaGFzIGEgcmV2aXNpb24gaXQgY2FuIGNoZWNrLiBtbWlv
IGRvZXMgbm90IGhhdmUgdHJhbnNpdGlvbmFsIGRldmljZXMKPiBhdCBhbGwuCgoKT2ssIHRoZW4g
d2UgY2FuIGRvIHRoZSB3b3JrYXJvdW5kIGluIHRoZSBxZW11LCBpc24ndCBpdD8KClRoYW5rcwoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
