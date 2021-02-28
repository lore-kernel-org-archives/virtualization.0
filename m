Return-Path: <SRS0=D/xy=H6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7A7C433E0
	for <virtualization@archiver.kernel.org>; Sun, 28 Feb 2021 21:30:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59BA964E21
	for <virtualization@archiver.kernel.org>; Sun, 28 Feb 2021 21:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59BA964E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1F6464301B;
	Sun, 28 Feb 2021 21:30:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CArex3ExiJ6Y; Sun, 28 Feb 2021 21:30:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id AD43043016;
	Sun, 28 Feb 2021 21:30:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81B26C000A;
	Sun, 28 Feb 2021 21:30:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B831C0001
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 21:30:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 29C974DC17
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 21:30:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bYwb8SjQZfTT
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 21:30:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC0254C88E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 21:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614547815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CXqPeJKg2QGKVw3n7fJTnHQgpBneaYrsq3vZdSqlW7k=;
 b=jKIPazpL0ttfbnMbIpfWoM846qktBAJZ0DGq1UOyiw7Sdq5SlfKX89/f9IE5IdRSFbUhqn
 KFB48ioNBV58vl5HT9nwH+B9s2jzyIiG9tdlp5O6kH6xjKbOHaxZApLQDRBx/dqyGe+neO
 EOdTVVSuurpQ5vbw12MGOTkPfOHh/Gg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-ZaQF8UtgO0GSdqCCBf94Mg-1; Sun, 28 Feb 2021 16:30:12 -0500
X-MC-Unique: ZaQF8UtgO0GSdqCCBf94Mg-1
Received: by mail-ed1-f71.google.com with SMTP id h2so3287092edw.10
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 13:30:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=CXqPeJKg2QGKVw3n7fJTnHQgpBneaYrsq3vZdSqlW7k=;
 b=VN17vUILzPn7M9E88CVS82yEgyyOD4JUiqzjF4lGt5KNaqlYAPsplR8sJ6WzhcM/7G
 CMjV61Nd9aTxBDTcAND0FXkLJIrCci7elV4XCKkx+li/2Er7D1gXmLLkj1xwKt8ZOb+a
 IadtnC4GGpjaatsVSe8dUIJaBepm/ycPP2KYae1QF/AJsBYDrXXyBDzBYdTzDTRJWhNb
 DQ0oTuOAfOUh+fdY3wHqBdEXCgh3xlBXLP6Q0crj2L9cyx+Go9jUcK4dYHQzIuDmxyMm
 M24BAciHUF86qXqa7LvoBi95SD3RsRuXgycaL1rnavQLVXMrs+IfEfF955T/aBKvc1Bk
 lnUg==
X-Gm-Message-State: AOAM531kmdwWszBvNkQRR9smybKV/6TzaTfQ+bW5DfrqQ3LSGwdGEhZL
 KfEuW5Pu1FHPvHHuNdkOAccAMoQcGmgRHuSpno0CMDgHZ0K/JN/8QEruk5JMQOLjZdUYj+13N/U
 1tRpwA4R6o+9tVmg1x8GhMD1k9UFV3qVuLI4uO50IDA==
X-Received: by 2002:a05:6402:3047:: with SMTP id
 bu7mr13480396edb.227.1614547811752; 
 Sun, 28 Feb 2021 13:30:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQe0ItppMYhgmAUA2vjPEcmW4kC/4bt6WO+XXuj+FLAiEv0vViE+9442NUKWzZGOmTe4jrsA==
X-Received: by 2002:a05:6402:3047:: with SMTP id
 bu7mr13480386edb.227.1614547811608; 
 Sun, 28 Feb 2021 13:30:11 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id e4sm11440644ejz.4.2021.02.28.13.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Feb 2021 13:30:11 -0800 (PST)
Date: Sun, 28 Feb 2021 16:30:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210228162909-mutt-send-email-mst@kernel.org>
References: <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <0559fd8c-ff44-cb7a-8a74-71976dd2ee33@redhat.com>
 <20210224014232-mutt-send-email-mst@kernel.org>
 <ce6b0380-bc4c-bcb8-db82-2605e819702c@redhat.com>
 <20210224021222-mutt-send-email-mst@kernel.org>
 <babc654d-8dcd-d8a2-c3b6-d20cc4fc554c@redhat.com>
 <20210224034240-mutt-send-email-mst@kernel.org>
 <d2992c03-d639-54e3-4599-c168ceeac148@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d2992c03-d639-54e3-4599-c168ceeac148@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCBGZWIgMjQsIDIwMjEgYXQgMDU6MzA6MzdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIxLzIvMjQgNDo0MyDkuIvljYgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90
ZToKPiA+IE9uIFdlZCwgRmViIDI0LCAyMDIxIGF0IDA0OjI2OjQzUE0gKzA4MDAsIEphc29uIFdh
bmcgd3JvdGU6Cj4gPiA+ICAgICAgQmFzaWNhbGx5IG9uIGZpcnN0IGd1ZXN0IGFjY2VzcyBRRU1V
IHdvdWxkIHRlbGwga2VybmVsIHdoZXRoZXIKPiA+ID4gICAgICBndWVzdCBpcyB1c2luZyB0aGUg
bGVnYWN5IG9yIHRoZSBtb2Rlcm4gaW50ZXJmYWNlLgo+ID4gPiAgICAgIEUuZy4gdmlydGlvX3Bj
aV9jb25maWdfcmVhZC92aXJ0aW9fcGNpX2NvbmZpZ193cml0ZSB3aWxsIGNhbGwgaW9jdGwoRU5B
QkxFX0xFR0FDWSwgMSkKPiA+ID4gICAgICB3aGlsZSB2aXJ0aW9fcGNpX2NvbW1vbl9yZWFkIHdp
bGwgY2FsbCBpb2N0bChFTkFCTEVfTEVHQUNZLCAwKQo+ID4gPiAKPiA+ID4gCj4gPiA+IEJ1dCB0
aGlzIHRyaWNrIHdvcmsgb25seSBmb3IgUENJIEkgdGhpbms/Cj4gPiA+IAo+ID4gPiBUaGFua3MK
PiA+IGNjdyBoYXMgYSByZXZpc2lvbiBpdCBjYW4gY2hlY2suIG1taW8gZG9lcyBub3QgaGF2ZSB0
cmFuc2l0aW9uYWwgZGV2aWNlcwo+ID4gYXQgYWxsLgo+IAo+IAo+IE9rLCB0aGVuIHdlIGNhbiBk
byB0aGUgd29ya2Fyb3VuZCBpbiB0aGUgcWVtdSwgaXNuJ3QgaXQ/Cj4gCj4gVGhhbmtzCgp3aGlj
aCBvbmUgZG8geW91IG1lYW4/CgotLSAKTVNUCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
