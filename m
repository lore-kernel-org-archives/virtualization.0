Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E18C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 07:02:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72FC1600CD
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 07:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 72FC1600CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 423E8403A1;
	Mon, 25 Oct 2021 07:02:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bVBo4Hd-qMNu; Mon, 25 Oct 2021 07:02:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E61AE40399;
	Mon, 25 Oct 2021 07:02:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6EBFC0019;
	Mon, 25 Oct 2021 07:02:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60317C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:02:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4F269402B6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:02:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LHt_07c7-Z6k
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:02:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7925740295
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635145339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g7IhFD7+yCaZAy566XHcMoBRiNpub/tyPuqq2DMYvu0=;
 b=P6qFkJOeob+xIW5rMhMOht7RiCBpJwikv1LLKvwIDC2TSXLtlRePsd+FRg/h3VOhtzP+BO
 cZv+G1RySM/3kwZbjLp36BJq4R297oKDiNH/UfWyMWLLmHZ22euxIwX5zwDV64Dei9CSWV
 OhxQ4cOxVjLZimO6kMKpIvAw7Hhg61E=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-c6obP-pmMtqUUdSSU1o-fg-1; Mon, 25 Oct 2021 03:02:18 -0400
X-MC-Unique: c6obP-pmMtqUUdSSU1o-fg-1
Received: by mail-pl1-f198.google.com with SMTP id
 v14-20020a170902e8ce00b0013fcb85c0ebso3332114plg.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 00:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=g7IhFD7+yCaZAy566XHcMoBRiNpub/tyPuqq2DMYvu0=;
 b=o16plcfJ/Z0mKljaQCxMIfUFOqYgSzu3aZfMNRRlIOFgqYxFGxXxRcOvyhQMm1ldCl
 CxAcSlzH8qZg+jSViWdipzhBtL+aadJFBaNXOyycL1npzbnYng1fbo9lCRCyMrYMdjSX
 4VJ4Q6rJ98toTkPD+IeiVOpJ0vlBeGuHLWG0ES66nSrbE0a1ENJ36RL39mJ4201wJ4y/
 nmgoAxLJcJiZABcn61LpOnxH8tiTC/vgq16DBhHNL8Cu5vWi0slejD7TTNTQJnpqoA+p
 McMsxNmIcWhblW6B4QVCOOPaMvu+S06fruVgGGAQzYqF9vVZ/dNLBOGP5kBHSsIyWAkM
 LLGA==
X-Gm-Message-State: AOAM532gK6wnrlbFXxa5TlHFVcxtrU7IE4WrIufoC2flONerS/gYnsu+
 BiK7tboExKOMBUiuOwtri/UpsSNJcZeSIG7tQu8rVeL+dBGYaPujts5zDn0bjAczAF5IYTEiEjg
 B9nwTQ2/KzsP9Lc1ezyGELSXIHHD8buTL6oSPakp++g==
X-Received: by 2002:a17:902:654b:b0:13d:c967:9cbd with SMTP id
 d11-20020a170902654b00b0013dc9679cbdmr14902265pln.88.1635145337310; 
 Mon, 25 Oct 2021 00:02:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrPeLZNBw/2Ny3rPlvawaUxYNr2ms8i5XBnh2L7GDU4Vb/RImsQXtRjiTQ19b7q634isCikQ==
X-Received: by 2002:a17:902:654b:b0:13d:c967:9cbd with SMTP id
 d11-20020a170902654b00b0013dc9679cbdmr14902255pln.88.1635145337119; 
 Mon, 25 Oct 2021 00:02:17 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id pg17sm3951700pjb.8.2021.10.25.00.02.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Oct 2021 00:02:16 -0700 (PDT)
Subject: Re: [PATCH linux-next v4 5/8] vdpa_sim_net: Enable user to set mac
 address and mtu
To: Parav Pandit <parav@nvidia.com>, virtualization@lists.linux-foundation.org
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211021163509.6978-6-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <03d8d907-f54d-f9e2-a058-fd8d50ff927e@redhat.com>
Date: Mon, 25 Oct 2021 15:02:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211021163509.6978-6-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: elic@nvidia.com, mst@redhat.com
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

CtTaIDIwMjEvMTAvMjIgyc/O5zEyOjM1LCBQYXJhdiBQYW5kaXQg0LS1wDoKPiBFbmFibGUgdXNl
ciB0byBzZXQgdGhlIG1hYyBhZGRyZXNzIGFuZCBtdHUgc28gdGhhdCBlYWNoIHZkcGEgZGV2aWNl
Cj4gY2FuIGhhdmUgaXRzIG93biB1c2VyIHNwZWNpZmllZCBtYWMgYWRkcmVzcyBhbmQgbXR1Lgo+
IFRoaXMgaXMgZG9uZSBieSBpbXBsZW1lbnRpbmcgdGhlIG1hbmFnZW1lbnQgZGV2aWNlJ3MgY29u
ZmlndXJhdGlvbgo+IGxheW91dCBmaWVsZHMgc2V0dGluZyBjYWxsYmFjayByb3V0aW5lLgo+Cj4g
Tm93IHRoYXQgdXNlciBpcyBlbmFibGVkIHRvIHNldCB0aGUgbWFjIGFkZHJlc3MsIHJlbW92ZSB0
aGUgbW9kdWxlCj4gcGFyYW1ldGVyIGZvciBzYW1lLgo+Cj4gQW5kIGV4YW1wbGUgb2Ygc2V0dGlu
ZyBtYWMgYWRkciBhbmQgbXR1Ogo+ICQgdmRwYSBtZ210ZGV2IHNob3cKPgo+ICQgdmRwYSBkZXYg
YWRkIG5hbWUgYmFyIG1nbXRkZXYgdmRwYXNpbV9uZXQKPiAkIHZkcGEgZGV2IGNvbmZpZyBzZXQg
YmFyIG1hYyAwMDoxMToyMjozMzo0NDo1NSBtdHUgOTAwMAoKClRoZSBhdHRyaWJ1dGVzIHdlcmUg
c2V0IGR1cmluZyBkZXYgYWRkIGlmIEkgd2FzIG5vdCB3cm9uZy4KClRoYW5rcwoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
