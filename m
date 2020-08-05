Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B95C433E1
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 08:11:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 779B022B45
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 08:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZjmHi5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779B022B45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8781286F8D;
	Wed,  5 Aug 2020 08:11:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eoDWh4GJjypZ; Wed,  5 Aug 2020 08:11:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EB47186DF0;
	Wed,  5 Aug 2020 08:11:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4A84C0050;
	Wed,  5 Aug 2020 08:11:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DC17C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 08:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1CD3B86DF0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 08:11:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TmjCmHCXkD7v
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 08:11:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7ED0686F8D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 08:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596615111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kq2PiHN4d43s5PFrLhzWB+jalzzIkTTsT/m6YIrJ9Kc=;
 b=eZjmHi5JE/uVowzyL3Y2zugfuF3yeV43+LvFYmGSKF2M+hxb4HaMcIwLGUBf5vUlDMgf+Y
 yR2mCCIpWALLhJ/C8eO7st5QZgP7xCgptrQk4ic0UG0Qz4lugmqp+JsmNvYYRWwjVbacJR
 LNMCIMOt0741VzqpeCTw1CtCwGzPHxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-FJgq2jiCN1WMVDk0YMDCCw-1; Wed, 05 Aug 2020 04:11:47 -0400
X-MC-Unique: FJgq2jiCN1WMVDk0YMDCCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23C138064AB;
 Wed,  5 Aug 2020 08:11:46 +0000 (UTC)
Received: from [10.72.12.225] (ovpn-12-225.pek2.redhat.com [10.72.12.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2B2460BF3;
 Wed,  5 Aug 2020 08:11:40 +0000 (UTC)
Subject: Re: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX
 devices
To: Eli Cohen <eli@mellanox.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200804162048.22587-1-eli@mellanox.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8cac76d4-680e-979b-6dea-64087acf9c5d@redhat.com>
Date: Wed, 5 Aug 2020 16:11:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804162048.22587-1-eli@mellanox.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: shahafs@mellanox.com, parav@mellanox.com, saeedm@mellanox.com
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

Ck9uIDIwMjAvOC81IOS4iuWNiDEyOjIwLCBFbGkgQ29oZW4gd3JvdGU6Cj4gSGkgTWljaGFlbCwK
PiBwbGVhc2Ugbm90ZSB0aGF0IHRoaXMgc2VyaWVzIGRlcGVuZHMgb24gbWx4NSBjb3JlIGRldmlj
ZSBkcml2ZXIgcGF0Y2hlcwo+IGluIG1seDUtbmV4dCBicmFuY2ggaW4KPiBnaXQ6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbWVsbGFub3gvbGludXguZ2l0Lgo+Cj4g
Z2l0IHB1bGwgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21l
bGxhbm94L2xpbnV4LmdpdCBtbHg1LW5leHQKPgo+IFRoZXkgYWxzbyBkZXBlbmQgSmFzb24gV2Fu
ZydzIHBhdGNoZXM6aHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvNy8xLzMwMQo+Cj4gSmFzb24s
IEkgaGFkIHRvIHJlc29sdmUgc29tZSBjb25mbGljdHMgc28gSSB3b3VsZCBhcHByZWNpYXRlIG9m
IHlvdSBjYW4gdmVyaWZ5Cj4gdGhhdCBpdCBpcyBvay4KCgpMb29rcyBnb29kIHRvIG1lLgoKVGhh
bmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
