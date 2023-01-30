Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86957C54EAA
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 19:25:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 156F941841;
	Mon, 30 Jan 2023 19:25:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 156F941841
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fTR_BbSoDTLW; Mon, 30 Jan 2023 19:25:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4774A41840;
	Mon, 30 Jan 2023 19:25:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4774A41840
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14674C002B;
	Mon, 30 Jan 2023 19:25:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3926C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 19:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F3DAD40B42
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 19:24:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F3DAD40B42
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6TJvZI1x9Ray
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 19:24:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6ADEC40A68
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6ADEC40A68
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 19:24:45 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 e8-20020a17090a9a8800b0022c387f0f93so11531977pjp.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 11:24:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0USauUwqY1SaOU2GvOVYD8aiTVQVkxSRI7nFSgwMtU=;
 b=BRgALEtcTV55F7HQmz3y80xcbtcU0hSryjvWl+YTa5grZ7nj41FpPEwv6m6r89P04J
 dWYgaAt6G1ho63akJp7mJLzYdWYeXcZsmTmoCQUlzTBvPYYSzlIzf+gsx62DaHDOXtMQ
 oM45RHwqmD3/jg4TfNFJnQEWLuBftv9+hyX4uqvef3U/RK6GHc++vmtVflg5QXQ7YklT
 UNaF+Gt4OSI456qd1S8ENc7efa0kxogsnHcYZONZAK8qabKiTLt5ygP5WmnqGem9p7VK
 oSMxbHu59kzBJLu9Okl+c/u9K+MrE9pnqfu6G1z7fqLcB3sSM4ICBtjU31/L/YYhf2HG
 ssAQ==
X-Gm-Message-State: AO0yUKV04nfnP3I8WKP3t/IylmH0PZlqD+6D9AuQq7mH61JlQyD2i2il
 WPrpbWvLTdJtem620t1+Fx0=
X-Google-Smtp-Source: AK7set/rGKHetFHi+kM9ZonjZUNA4n9BoD4xsf4KlNV/nZP1isOdo/PYXU7cRl9F9xNCOZ6lx4KGGg==
X-Received: by 2002:a05:6a20:54a3:b0:be:a177:af43 with SMTP id
 i35-20020a056a2054a300b000bea177af43mr2872944pzk.24.1675106684718; 
 Mon, 30 Jan 2023 11:24:44 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:5016:3bcd:59fe:334b?
 ([2620:15c:211:201:5016:3bcd:59fe:334b])
 by smtp.gmail.com with ESMTPSA id
 69-20020a630248000000b0045ff216a0casm7117730pgc.3.2023.01.30.11.24.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jan 2023 11:24:43 -0800 (PST)
Message-ID: <0a7739db-13e2-efac-2c1a-872d7f2fa7aa@acm.org>
Date: Mon, 30 Jan 2023 11:24:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 01/23] block: factor out a bvec_set_page helper
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20230130092157.1759539-1-hch@lst.de>
 <20230130092157.1759539-2-hch@lst.de>
 <2bab7050-dec7-3af8-b643-31b414b8c4b4@acm.org>
In-Reply-To: <2bab7050-dec7-3af8-b643-31b414b8c4b4@acm.org>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Eric Dumazet <edumazet@google.com>, target-devel@vger.kernel.org,
 Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org,
 Mike Marshall <hubcap@omnibond.com>, linux-cifs@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, io-uring@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, devel@lists.orangefs.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>, linux-nfs@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 samba-technical@lists.samba.org, Steve French <sfrench@samba.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
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

T24gMS8zMC8yMyAwOTowOSwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOgo+IE9uIDEvMzAvMjMgMDE6
MjEsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+PiBBZGQgYSBoZWxwZXIgdG8gaW5pdGlhbGl6
ZSBhIGJ2ZWMgYmFzZWQgb2YgYSBwYWdlIHBvaW50ZXIuwqAgVGhpcyB3aWxsIAo+PiBoZWxwCj4+
IHJlbW92aW5nIHZhcmlvdXMgb3BlbiBjb2RlIGJ2ZWMgaW5pdGlhbGl6YXRpb25zLgo+IAo+IFdo
eSBkbyB5b3Ugd2FudCB0byByZW1vdmUgdGhlIG9wZW4tY29kZWQgYnZlYyBpbml0aWFsaXphdGlv
bnM/IFdoYXQgaXMgCj4gd3Jvbmcgd2l0aCBvcGVuLWNvZGluZyBidmVjIGluaXRpYWxpemF0aW9u
PyBUaGlzIHBhdGNoIHNlcmllcyBtb2RpZmllcyBhIAo+IGxvdCBvZiBjb2RlIGJ1dCBkb2VzIG5v
dCBpbXByb3ZlIGNvZGUgcmVhZGFiaWxpdHkuIEFueW9uZSB3aG8gZW5jb3VudGVycyAKPiBjb2Rl
IHRoYXQgdXNlcyB0aGUgbmV3IGZ1bmN0aW9uIGJ2ZWNfc2V0X3BhZ2UoKSBoYXMgdG8gbG9vayB1
cCB0aGUgCj4gZGVmaW5pdGlvbiBvZiB0aGF0IGZ1bmN0aW9uIHRvIGZpZ3VyZSBvdXQgd2hhdCBp
dCBkb2VzLgoKUGxlYXNlIGlnbm9yZSB0aGUgYWJvdmUgcXVlc3Rpb24gLSBJIGp1c3Qgbm90aWNl
ZCB0aGF0IHRoaXMgcXVlc3Rpb24gaGFzIApiZWVuIGFuc3dlcmVkIGluIHRoZSBjb3ZlciBsZXR0
ZXIuCgpCYXJ0LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
