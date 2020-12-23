Return-Path: <SRS0=+X4x=F3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FA3C433E0
	for <virtualization@archiver.kernel.org>; Wed, 23 Dec 2020 08:14:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7F62070B
	for <virtualization@archiver.kernel.org>; Wed, 23 Dec 2020 08:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7F62070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 846F2868B5;
	Wed, 23 Dec 2020 08:14:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qB84tDsZKrPv; Wed, 23 Dec 2020 08:14:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DE854868B0;
	Wed, 23 Dec 2020 08:14:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6018C1787;
	Wed, 23 Dec 2020 08:14:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB9AFC0893
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A95F3871EF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:14:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9NdRPmLxBd4R
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:14:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2D77C87153
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608711286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0U6heNY7fxOOhdzytPgLhxCjf8UFXUIBZYCgUBbqf4=;
 b=iIMVhk3gC8aX6+dHB57JL6bu1BifZ/q9tmnGkWpw+IUZYQQh6ibZ38OzyZmAUfrrR20a3O
 CRGmp3R1YLdObpgPNcOY0SYH6dPfL2oV76daQP8mDLSpZDydhZiTuA42Sufp9WYR0FLUEZ
 sNLwarLDn6/S/zCW5IFTIYZ+Y22G6Sg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-6cTF2La4MIuhN7JQfCiujg-1; Wed, 23 Dec 2020 03:14:42 -0500
X-MC-Unique: 6cTF2La4MIuhN7JQfCiujg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 460971005513;
 Wed, 23 Dec 2020 08:14:40 +0000 (UTC)
Received: from [10.72.12.54] (ovpn-12-54.pek2.redhat.com [10.72.12.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AE6060C69;
 Wed, 23 Dec 2020 08:14:28 +0000 (UTC)
Subject: Re: [RFC v2 00/13] Introduce VDUSE - vDPA Device in Userspace
From: Jason Wang <jasowang@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 akpm@linux-foundation.org, rdunlap@infradead.org, willy@infradead.org,
 viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org, corbet@lwn.net
References: <20201222145221.711-1-xieyongji@bytedance.com>
 <c892652a-3f57-c337-8c67-084ba6d10834@redhat.com>
Message-ID: <faa0b9ba-c230-931b-86c6-624a302f6637@redhat.com>
Date: Wed, 23 Dec 2020 16:14:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c892652a-3f57-c337-8c67-084ba6d10834@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: linux-aio@kvack.org, kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
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

Ck9uIDIwMjAvMTIvMjMg5LiL5Y2IMjozOCwgSmFzb24gV2FuZyB3cm90ZToKPj4KPj4gVjEgdG8g
VjI6Cj4+IC0gQWRkIHZob3N0LXZkcGEgc3VwcG9ydAo+Cj4KPiBJIG1heSBtaXNzIHNvbWV0aGlu
ZyBidXQgSSBkb24ndCBzZWUgYW55IGNvZGUgdG8gc3VwcG9ydCB0aGF0LiBFLmcgCj4gbmVpdGhl
ciBzZXRfbWFwIG5vciBkbWFfbWFwL3VubWFwIGlzIGltcGxlbWVudGVkIGluIHRoZSBjb25maWcg
b3BzLgo+Cj4gVGhhbmtzIAoKClNwZWFrIHRvbyBmYXN0IDooCgpJIHNhdyBhIG5ldyBjb25maWcg
b3BzIHdhcyBpbnRyb2R1Y2VkLgoKTGV0IG1lIGRpdmUgaW50byB0aGF0LgoKVGhhbmtzCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
