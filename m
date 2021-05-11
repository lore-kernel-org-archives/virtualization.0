Return-Path: <SRS0=GMN+=KG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AB5C433ED
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 06:50:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100E7613CA
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 06:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100E7613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D53208426E;
	Tue, 11 May 2021 06:50:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0mksHTHShhvW; Tue, 11 May 2021 06:50:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99BC78427E;
	Tue, 11 May 2021 06:50:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F361C000D;
	Tue, 11 May 2021 06:50:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D1CAC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 06:50:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 834018427E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 06:50:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PaXUMNb7Qyaj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 06:50:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE0A58426E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 06:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620715812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=umA1WrHOFiVlBbjKzKntHglDQdg2BgS3oCexgpceoV4=;
 b=dOLuLQalsomavfvd/JZPg5JzgXDadSOB/jsAMrY6VlmOrTLCkuNP3Pbw/z2u/T4ydFKCd1
 iKTsUBfZLuvrWA5oivx0ZWfP8FNDB2TtitZ4Rb1SdzakPi5WkHR6k5CsUNH+Sr/jKrDrn2
 U+/wkfWx1qMYtOz/CiSVNZJisaWpBbU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-PgcKfhGzNemhJK9Gw2zZSg-1; Tue, 11 May 2021 02:50:11 -0400
X-MC-Unique: PgcKfhGzNemhJK9Gw2zZSg-1
Received: by mail-pj1-f71.google.com with SMTP id
 mq6-20020a17090b3806b029015c12a293efso95063pjb.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 23:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=umA1WrHOFiVlBbjKzKntHglDQdg2BgS3oCexgpceoV4=;
 b=J1iknjAmDX4lzNnm09aZ8SoUXx6FhCx2Tqtf8Ew2fI7d6H8MJOcWrlKmFj5pW95eWJ
 DsAKtZqAwEZLPUaaun343XHra1LfM/DveX4lB+Ai07tuHFDgUF8F0pWAIV/K0ZR/HG5p
 MN2uKpcOqMA2SAiKJUxeF/qMo89VhFHaaBBfCBRMoTccBIXfGm8YUovYcGnGT6DdNCO1
 ntxV9PWpDjXS/jDIo6KvSZVx9Tm2Rb+OG/eQqTUmSuZkIplTyvDnSD9JwDQkCwskpqDQ
 tYtoxwKI435+69MUMYYQe9hTh5TW8Q1I9whpfmrzs/rQUpNNN42JuOk6HR0ThslevfcS
 GD4Q==
X-Gm-Message-State: AOAM5334vYG3teFC0T0SW8tzb5pOwWJ2Q6S5wKgbvHUQyo/tcPK1gyJn
 +yenGoDuM9KObZ6H9ngIKq2nRSJ+//81VvkdWgpSJbZe/p+PEpHxsGb+gu5xes5CTbugrsZQjJv
 A9pzRdywVoHgifmwpaxAGQRlZt26qZHOeHAP62W7SnA==
X-Received: by 2002:a17:90b:184:: with SMTP id
 t4mr3416775pjs.223.1620715810242; 
 Mon, 10 May 2021 23:50:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0nIA3fflnZGCrCpbroOw85DYJI2FzsmmyMHTk1Ihc+KFfaCk0aGqGfPaWbSRNEdOwp4oOXg==
X-Received: by 2002:a17:90b:184:: with SMTP id
 t4mr3416761pjs.223.1620715810062; 
 Mon, 10 May 2021 23:50:10 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j16sm13601256pgh.69.2021.05.10.23.50.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 May 2021 23:50:09 -0700 (PDT)
Subject: Re: [PATCH 4/4] tun: indicate support for USO feature
To: Yuri Benditovich <yuri.benditovich@daynix.com>, davem@davemloft.net,
 kuba@kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-5-yuri.benditovich@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <eb8c4984-f0cc-74ee-537f-fc60deaaaa73@redhat.com>
Date: Tue, 11 May 2021 14:50:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511044253.469034-5-yuri.benditovich@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: yan@daynix.com
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNS8xMSDPws7nMTI6NDIsIFl1cmkgQmVuZGl0b3ZpY2gg0LS1wDoKPiBTaWduZWQt
b2ZmLWJ5OiBZdXJpIEJlbmRpdG92aWNoIDx5dXJpLmJlbmRpdG92aWNoQGRheW5peC5jb20+Cj4g
LS0tCj4gICBkcml2ZXJzL25ldC90dW4uYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3R1
bi5jIGIvZHJpdmVycy9uZXQvdHVuLmMKPiBpbmRleCA4NGY4MzI4MDYzMTMuLmEzNTA1NGY5ZDk0
MSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC90dW4uYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3R1
bi5jCj4gQEAgLTI4MTIsNyArMjgxMiw3IEBAIHN0YXRpYyBpbnQgc2V0X29mZmxvYWQoc3RydWN0
IHR1bl9zdHJ1Y3QgKnR1biwgdW5zaWduZWQgbG9uZyBhcmcpCj4gICAJCQlhcmcgJj0gfihUVU5f
Rl9UU080fFRVTl9GX1RTTzYpOwo+ICAgCQl9Cj4gICAKPiAtCQlhcmcgJj0gflRVTl9GX1VGTzsK
PiArCQlhcmcgJj0gfihUVU5fRl9VRk98VFVOX0ZfVVNPKTsKCgpJdCBsb29rcyB0byBtZSBrZXJu
ZWwgZG9lc24ndCB1c2UgIlVTTyIsIHNvIFRVTl9GX1VEUF9HU09fTDQgaXMgYSBiZXR0ZXIgCm5h
bWUgZm9yIHRoaXMgYW5kIEkgZ3Vlc3Mgd2Ugc2hvdWxkIHRvZ2dsZSBORVRJRl9GX1VEUF9HU09f
bDQgaGVyZT8KCkFuZCBob3cgYWJvdXQgbWFjdnRhcD8KClRoYW5rcwoKCj4gICAJfQo+ICAgCj4g
ICAJLyogVGhpcyBnaXZlcyB0aGUgdXNlciBhIHdheSB0byB0ZXN0IGZvciBuZXcgZmVhdHVyZXMg
aW4gZnV0dXJlIGJ5CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
