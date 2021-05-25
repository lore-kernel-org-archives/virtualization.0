Return-Path: <SRS0=1MDK=KU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DF2C2B9F8
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 00:02:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FA46141F
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 00:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FA46141F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4F8FE4014A;
	Tue, 25 May 2021 00:02:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AGfZnp1BhwNj; Tue, 25 May 2021 00:02:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 038704010D;
	Tue, 25 May 2021 00:02:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3287C000E;
	Tue, 25 May 2021 00:02:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D346FC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 00:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C22974014A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 00:02:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BCY5sqq3Z3BW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 00:02:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1A6F54010D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 00:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621900967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6JwmMpBs7TpaCI3ZuipI6pwwy6y5d3sU9vlG1AsbdUE=;
 b=VTJMr5kGXrPAMo7H4AumdHWKzzj76f63C1fCGAH5oW/CatTiXoYS4dh4cDP0+BT+kJkvD/
 zKfqsngP7I+26cANXpaeJCHlTDaR9NaWNTGU0LzZJjGR+Q0z0okTdt72+GanpP1AUWPU3o
 FZUS8cfXDAs8bzNfURk5TlO5CTtdDL0=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-r3Y5-qNjPn-1esXGvmkZJA-1; Mon, 24 May 2021 20:02:45 -0400
X-MC-Unique: r3Y5-qNjPn-1esXGvmkZJA-1
Received: by mail-pf1-f199.google.com with SMTP id
 g21-20020aa787550000b02902db9841d2a1so16713735pfo.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 17:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=6JwmMpBs7TpaCI3ZuipI6pwwy6y5d3sU9vlG1AsbdUE=;
 b=EGyeZHX1xtyAY+XPiFKtfKnqdso34zyNakgbIlyyn+LPl11x/7VtWbzBTYcFbfDcxh
 F6/xhVs5CJF6NwLQfIdpV8uf76Jmwq7+Y3tIBfWX6l67dQK7zF1pqjc6U0m4NF3XQ/mn
 2400i6Kb5T5qWHVv2TD1ozAML4jAwPx9987h/WGM7pfCHfcggEHtMGZy/V2qcvSTDgvg
 Q63sZRcmW4DTocnmlVLmn9a8qMs/J/mCkYjDcfR2NyIvv30WtbEhGrZXNOA5lr7zL9Sx
 gDZUJgRkyKCZ+zk5xf90gxoedSHa59Gf1sz7COGe5f3FEiExU15NWwOEJ5JGm3h5uVz3
 4fTA==
X-Gm-Message-State: AOAM532I6Mofc+IrT5NxTyhaiT3R3kRTb0KYQPK3kEjgbi9/Ln/6boId
 m9nKKTMke9l1Kn4rnybMEnJKD1QfRkvM8TgE4R/zC7ZTotxs22tKdFtWgz4AsJvWrxWzyYJWOsn
 DocWykopu99w5jxXiSc4S1oQa+rw2/uNERTQnC4x8+g==
X-Received: by 2002:aa7:828c:0:b029:2d2:3231:7ef8 with SMTP id
 s12-20020aa7828c0000b02902d232317ef8mr26847629pfm.80.1621900964804; 
 Mon, 24 May 2021 17:02:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbyrmCLUcE53s8m/jtPYUcLYHs6nAUzwHtcyLOuUAj4w+gEoX+N4uv8UIlnp35amw76TvK2w==
X-Received: by 2002:aa7:828c:0:b029:2d2:3231:7ef8 with SMTP id
 s12-20020aa7828c0000b02902d232317ef8mr26847606pfm.80.1621900964580; 
 Mon, 24 May 2021 17:02:44 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c7sm12444120pga.4.2021.05.24.17.02.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 May 2021 17:02:44 -0700 (PDT)
Subject: Re: [PATCH] vhost: Remove the repeated declaration
To: Shaokun Zhang <zhangshaokun@hisilicon.com>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
References: <1621857884-19964-1-git-send-email-zhangshaokun@hisilicon.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c93bda5e-edd0-0d63-b8bd-0d73fc505d90@redhat.com>
Date: Tue, 25 May 2021 08:02:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1621857884-19964-1-git-send-email-zhangshaokun@hisilicon.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

CtTaIDIwMjEvNS8yNCDPws7nODowNCwgU2hhb2t1biBaaGFuZyDQtLXAOgo+IEZ1bmN0aW9uICd2
aG9zdF92cmluZ19pb2N0bCcgaXMgZGVjbGFyZWQgdHdpY2UsIHJlbW92ZSB0aGUgcmVwZWF0ZWQK
PiBkZWNsYXJhdGlvbi4KPgo+IENjOiAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5j
b20+Cj4gQ2M6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gU2lnbmVkLW9mZi1i
eTogU2hhb2t1biBaaGFuZyA8emhhbmdzaGFva3VuQGhpc2lsaWNvbi5jb20+Cj4gLS0tCj4gICBk
cml2ZXJzL3Zob3N0L3Zob3N0LmggfCAxIC0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9u
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92aG9zdC5oIGIvZHJpdmVycy92aG9z
dC92aG9zdC5oCj4gaW5kZXggYjA2MzMyNGM3NjY5Li4zNzRmNDc5NWNiNWEgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy92aG9zdC92aG9zdC5oCj4gKysrIGIvZHJpdmVycy92aG9zdC92aG9zdC5oCj4g
QEAgLTQ3LDcgKzQ3LDYgQEAgdm9pZCB2aG9zdF9wb2xsX3N0b3Aoc3RydWN0IHZob3N0X3BvbGwg
KnBvbGwpOwo+ICAgdm9pZCB2aG9zdF9wb2xsX2ZsdXNoKHN0cnVjdCB2aG9zdF9wb2xsICpwb2xs
KTsKPiAgIHZvaWQgdmhvc3RfcG9sbF9xdWV1ZShzdHJ1Y3Qgdmhvc3RfcG9sbCAqcG9sbCk7Cj4g
ICB2b2lkIHZob3N0X3dvcmtfZmx1c2goc3RydWN0IHZob3N0X2RldiAqZGV2LCBzdHJ1Y3Qgdmhv
c3Rfd29yayAqd29yayk7Cj4gLWxvbmcgdmhvc3RfdnJpbmdfaW9jdGwoc3RydWN0IHZob3N0X2Rl
diAqZCwgdW5zaWduZWQgaW50IGlvY3RsLCB2b2lkIF9fdXNlciAqYXJncCk7Cj4gICAKPiAgIHN0
cnVjdCB2aG9zdF9sb2cgewo+ICAgCXU2NCBhZGRyOwoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
