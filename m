Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649D9C77B73
	for <virtualization@archiver.kernel.org>; Fri, 14 Apr 2023 04:54:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D56C54011B;
	Fri, 14 Apr 2023 04:54:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D56C54011B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i3GVAyAR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Im7ME6BnD7Bc; Fri, 14 Apr 2023 04:54:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 40D6940025;
	Fri, 14 Apr 2023 04:54:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 40D6940025
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 144D6C0037;
	Fri, 14 Apr 2023 04:54:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28C93C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 04:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F1D998407C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 04:54:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F1D998407C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i3GVAyAR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6CFqGaddW-4W
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 04:54:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4601B84077
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4601B84077
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 04:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681448052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tocrHY6nV4YHVi/za0FgRWwQlzOhOYvZ+UJ+s+zXC54=;
 b=i3GVAyAR6BhUP0GsLp+gM+nf/uODuWwL+OnYqOqbiaJeoOpu3bux3IRBZy7r06sS+7sDE/
 gdzLuG4IJP9q86Xzqj+1yBKMowjIX8/ioiraRkyD9fbGGVnMnyX0+8WYcklHfGdGVO46II
 lo11CeX9I9ZYWsn8UGUaZnLPrNVGe1c=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-A0912rsANWOHfsSjq9U3Aw-1; Fri, 14 Apr 2023 00:54:10 -0400
X-MC-Unique: A0912rsANWOHfsSjq9U3Aw-1
Received: by mail-oi1-f197.google.com with SMTP id
 s14-20020a05680810ce00b003872286998bso2767635ois.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 21:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681448050; x=1684040050;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tocrHY6nV4YHVi/za0FgRWwQlzOhOYvZ+UJ+s+zXC54=;
 b=MCB2PmurzjDWUSRW9qbTqeWi5nA7r4d65tTUM+mSSZWH8KRv5LkEvaxZw0nPkzl9bD
 uvTqrS4xmnZTW8rZcyoE9MDipS6iMo0CmsMkBQZZRVH5U5I2sXzjsvciRSDik3FoUD12
 P2UKTl65nMRbRgMQO3NwC0x+wodNlDfRgIW4rJqHmGhH0PwOBgDJQnJqN1xWC14q3dVz
 NBECP7TiukrieJYbnHHtWmCinD5u+TNTGa4/UffZWuLpABj/kc1JRFE0v3RWQ4yj4uQB
 aZxgVODrGM4a5i/FOYR/dr3AOlxs1zgeLUvkfGpT7G3/dDtVlMIlk5SuR2SStUShGMdN
 /1xg==
X-Gm-Message-State: AAQBX9d5FuE9J7uYX4wDnNvaIWa1c8Am1/3u/D8LaywknRp4omDXieQC
 i73sxJy9EtMVhT9MPdC4O0p+QNvLrCHOJLDOYBXRM7/OlLCR6IVwLR5uXsbIGLdK3UDEmBK9NoD
 wgLLWUwo2FLT5QjiiweV0oCh5la0DNgWSAszIdgTZVGVgk0dmwt9WCyaOfA==
X-Received: by 2002:a05:6830:1e68:b0:69f:bac:aa8a with SMTP id
 m8-20020a0568301e6800b0069f0bacaa8amr1184191otr.2.1681448049929; 
 Thu, 13 Apr 2023 21:54:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZAIBCx4X+NNcvZ8A50bkSP9FEpyJ2twQnWfg2TY5sYS6XErk+0sb1nV9eWtNhrxdMNTlOsljAiPXJyV7oGAZs=
X-Received: by 2002:a05:6830:1e68:b0:69f:bac:aa8a with SMTP id
 m8-20020a0568301e6800b0069f0bacaa8amr1184177otr.2.1681448049732; Thu, 13 Apr
 2023 21:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230413064027.13267-1-jasowang@redhat.com>
 <20230413070408.630fa731@kernel.org>
In-Reply-To: <20230413070408.630fa731@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Apr 2023 12:53:58 +0800
Message-ID: <CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com>
Subject: Re: [PATCH net-next V2 0/2] virtio-net: don't busy poll for cvq
 command
To: Jakub Kicinski <kuba@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, pabeni@redhat.com,
 david.marchand@redhat.com, davem@davemloft.net
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

T24gVGh1LCBBcHIgMTMsIDIwMjMgYXQgMTA6MDTigK9QTSBKYWt1YiBLaWNpbnNraSA8a3ViYUBr
ZXJuZWwub3JnPiB3cm90ZToKPgo+IE9uIFRodSwgMTMgQXByIDIwMjMgMTQ6NDA6MjUgKzA4MDAg
SmFzb24gV2FuZyB3cm90ZToKPiA+IFRoZSBjb2RlIHVzZWQgdG8gYnVzeSBwb2xsIGZvciBjdnEg
Y29tbWFuZCB3aGljaCB0dXJucyBvdXQgdG8gaGF2ZQo+ID4gc2V2ZXJhbCBzaWRlIGVmZmVjdHM6
Cj4gPgo+ID4gMSkgaW5maW5pdGUgcG9sbCBmb3IgYnVnZ3kgZGV2aWNlcwo+ID4gMikgYmFkIGlu
dGVyYWN0aW9uIHdpdGggc2NoZWR1bGVyCj4gPgo+ID4gU28gdGhpcyBzZXJpZXMgdHJpZXMgdG8g
dXNlIHNsZWVwIGluc3RlYWQgb2YgYnVzeSBwb2xsaW5nLiBJbiB0aGlzCj4gPiB2ZXJzaW9uLCBJ
IHRha2UgYSBzdGVwIGJhY2s6IHRoZSBoYXJkZW5pbmcgcGFydCBpcyBub3QgaW1wbGVtZW50ZWQg
YW5kCj4gPiBsZWF2ZSBmb3IgZnV0dXJlIGludmVzdGlnYXRpb24uIFdlIHVzZSB0byBhZ2dyZWUg
dG8gdXNlIGludGVycnVwdGlibGUKPiA+IHNsZWVwIGJ1dCBpdCBkb2Vzbid0IHdvcmsgZm9yIGEg
Z2VuZXJhbCB3b3JrcXVldWUuCj4KPiBDQzogbmV0ZGV2IG1pc3Npbmc/CgpNeSBiYWQuIFdpbGwg
Y2MgbmV0ZGV2IGZvciBhbnkgZGlzY3Vzc2lvbi4KClRoYW5rcwoKPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
