Return-Path: <SRS0=jANb=LB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB1EC4743E
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 02:18:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B88B4611AE
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 02:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88B4611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 753F24020F;
	Mon,  7 Jun 2021 02:18:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4cMd-JTKhitI; Mon,  7 Jun 2021 02:18:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A4C7401FC;
	Mon,  7 Jun 2021 02:18:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 671C3C000E;
	Mon,  7 Jun 2021 02:18:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F8A7C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:18:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 09B93401D6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:18:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bjwDmXKta3NA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:18:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5330540015
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623032319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/YSBBQ9cGooM1hAnJfrax+C1tCPnWfT7V7/0+qUaI/k=;
 b=WkRHesx/Dtb7jd8qpLScFGqe3Xq0hPC0aJk4KknY8qXrpo3ZMoJuNtTW0hesZ5pf8nkeKX
 NAJFsMsZsTcVB1dizvb0TxybO2w8H4F1VGSsBVSkfbQMvYxuYD2TnUnv/V5Gf3oTZxhchn
 LGXlYIZ+lrEux+1sMcvX3i+xDEdbCy8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-zc7KHFH9PMyjVg59x3nFCQ-1; Sun, 06 Jun 2021 22:18:38 -0400
X-MC-Unique: zc7KHFH9PMyjVg59x3nFCQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 p11-20020a1709028a8bb029010f3d701dfaso3746040plo.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 06 Jun 2021 19:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=/YSBBQ9cGooM1hAnJfrax+C1tCPnWfT7V7/0+qUaI/k=;
 b=TcjEUj41HJ248AmKbmVtJtbbIfMpE9FnOEhiNpEG2TlHqlhr7RaofmMKckCb2WLoJb
 6teRc1CkJJF33rNORQrlhbN6B5FVJLg+KssiLlbZs5gTB1uFob4Bx82fZ9na3MfmgNye
 Du8a/cT30avpqnjYrBQ3wtjaT4iRaG4ejBNjARXPJ2hhKGfSXbdHqcEOy0LZMCWoRVWk
 Qi6MCn9YzVvyblVgiYKSPTvQvSN7YPYbGuUveisKLkYY4jDZ6kXA6T11A9NLV/4+HDrq
 PcSyrwhGhb27R7WhkWGOiN/ZZoavm597r4OLsF0Y6FrCY/iLj3AHCe/NvkKGFbM6Bd7e
 murA==
X-Gm-Message-State: AOAM5337DGruGg7uDn+HahyRvH+9oxls1b2ReLXhAgHrdmouegINIZpC
 SHhyNe/GmfHe95RkL3dJsiTkwWaOeCF2tTMMFr/QbslmN1KHuzJZU1WdqYTkTyLGCqUMWP56/xa
 Z+UFYYMEMfoJnr2mwCheMYpSw5HvNGsgb9wu+lRxHFBnW67Pmbm6gR2Gh82M5OX6TVuKDR95ZWm
 y/bsh29iUcYTVcUtDgNA==
X-Received: by 2002:a17:902:c403:b029:106:7793:3fcc with SMTP id
 k3-20020a170902c403b029010677933fccmr15707475plk.81.1623032317162; 
 Sun, 06 Jun 2021 19:18:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1Mz9rWZDNywIxinqZddVbgfmBbg3wbcfPQEw6zpB+wsjqIzZBnXaVdGeLRKGzInGbXtwyVA==
X-Received: by 2002:a17:902:c403:b029:106:7793:3fcc with SMTP id
 k3-20020a170902c403b029010677933fccmr15707445plk.81.1623032316810; 
 Sun, 06 Jun 2021 19:18:36 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w21sm2048729pfq.143.2021.06.06.19.18.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Jun 2021 19:18:36 -0700 (PDT)
Subject: Re: [PATCH 9/9] vhost: support sharing workers across devs
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Mike Christie <michael.christie@oracle.com>
References: <20210525180600.6349-1-michael.christie@oracle.com>
 <20210525180600.6349-10-michael.christie@oracle.com>
 <YLjoDjas6ga3Ovad@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f475f7fe-75ec-02fe-34a3-df8c863e8a73@redhat.com>
Date: Mon, 7 Jun 2021 10:18:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YLjoDjas6ga3Ovad@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-scsi@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
 pbonzini@redhat.com
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

CuWcqCAyMDIxLzYvMyDkuIvljYgxMDozMiwgU3RlZmFuIEhham5vY3ppIOWGmemBkzoKPiBPbiBU
dWUsIE1heSAyNSwgMjAyMSBhdCAwMTowNjowMFBNIC0wNTAwLCBNaWtlIENocmlzdGllIHdyb3Rl
Ogo+PiBUaGlzIGFsbG93cyBhIHdvcmtlciB0byBoYW5kbGUgbXVsdGlwbGUgZGV2aWNlJ3MgdnFz
Lgo+Pgo+PiBUT0RPOgo+PiAtIFRoZSB3b3JrZXIgaXMgYXR0YWNoZWQgdG8gdGhlIGNncm91cCBv
ZiB0aGUgZGV2aWNlIHRoYXQgY3JlYXRlZCBpdC4gSW4KPj4gdGhpcyBwYXRjaCB5b3UgY2FuIHNo
YXJlIHdvcmtlcnMgd2l0aCBkZXZpY2VzIHdpdGggZGlmZmVyZW50IG93bmVycyB3aGljaAo+PiBj
b3VsZCBiZSBpbiBkaWZmZXJlbnQgY2dyb3Vwcy4gRG8gd2Ugd2FudCB0byByZXN0aWN0IHNoYXJp
bmcgd29ya2VycyB3aXRoCj4+IGRldmljZXMgdGhhdCBoYXZlIHRoZSBzYW1lIG93bmVyIChkZXYt
Pm1tIHZhbHVlKT8KPiBRdWVzdGlvbiBmb3IgTWljaGFlbCBvciBKYXNvbi4KCgpJIHRoaW5nIHNo
YXJpbmcgd29ya2VycyB3aXRoaW4gYSBjZ3JvdXAgc2hvdWxkIGJlIGZpbmUuCgpUaGUgZGlmZmVy
ZW5jZXMgaXMgdGhhdCBpZiB3ZSByZXN0cmljdCB0aGUgd29ya3Mgd2l0aCB0aGUgc2FtZSBvd25l
ciwgaXQgCm1heSBvbmx5IHdvcmsgaW4gdGhlIGNhc2Ugd2hlcmUgYW4gVk0gaGF2ZSBtdWx0aXBs
ZSB2aG9zdCBkZXZpY2VzLgoKVGhhbmtzCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
