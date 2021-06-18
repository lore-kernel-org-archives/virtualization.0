Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD16C48BE8
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 09:35:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986BA613EB
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 09:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986BA613EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D64A835C9;
	Fri, 18 Jun 2021 09:35:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VrgvErVjFZao; Fri, 18 Jun 2021 09:35:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0D63C834F6;
	Fri, 18 Jun 2021 09:35:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF373C000D;
	Fri, 18 Jun 2021 09:35:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88D6FC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 09:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6242A835BA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 09:35:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t9i9BrmSEcpd
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 09:35:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C64A834F6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 09:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624008939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rLL8PB172SRL8lGgz205HV0dC/eqDJtIYHSvhcZcv70=;
 b=fzMLwXq8ghGTtTkF6cEwGWk19tFWo1nvopXBikxp2ZO37bP3cSuawZchKeeSJw4UX6Ih7Q
 PEZ2EH2oPE/8StesFgUS5U9ikvQ0hU2wYv6PNO6jyzdyG2OXsUd+7wkIrdVHY62ja+yYf2
 fOtU4nd0KP6APa53Ttwhfce+DTg64WM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-f9GyLIQKP0iLjCr6W2wAQQ-1; Fri, 18 Jun 2021 05:35:37 -0400
X-MC-Unique: f9GyLIQKP0iLjCr6W2wAQQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 y18-20020a0564022712b029038ffac1995eso3254548edd.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 02:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=rLL8PB172SRL8lGgz205HV0dC/eqDJtIYHSvhcZcv70=;
 b=c1pPY2ROlfTeRR55JUoCgTn9hpRVvrnLgtyZvPIdPX1P3+Gm9Yk7V3UTlZkqhxf/m6
 DCCnMIpMAmA4APqWY8HyxTeSL6mHp3ravo/Nc+2l6tViJzPTaokSrsz4vC+6eVNgX7Jz
 g/2bQJAh3p+ULY/yZ5DBGsYplEh4ldzjffVLZma/d3Mo6H9b9tPJ18yr5pjsOY0khCJK
 /vasa7w6pajVygMWE9If4mZ8IQXVcoGjx5GN+wCJtvOMh0kyMRBHp0CUwhNsUBjAH3wM
 CdpVCmG2r0mjOzOUqrpstRB+MCv3GhypxtIuXJxemOZU8E1tlazv+2lihIYGkrO9VzHL
 nr9A==
X-Gm-Message-State: AOAM531BskhiAmeUvWGVM4FRNf1iA1aITOiHnb7EJKLXAIKeZCOs6tUs
 rxmhjwR3228/vrP1lPeWS6CqcZZoFpCoqzzYTJkC1HugL03XlgdD+Gxq0ZG1R6XnfiAzmbe7KKD
 WMuRFFof0gdG/xuRU/cmdi+kz8iqGZw819bwPQ0JCpg==
X-Received: by 2002:a50:9d8d:: with SMTP id w13mr3745075ede.94.1624008934360; 
 Fri, 18 Jun 2021 02:35:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrTXbUUFRfwaNYCZ2CYmaoH3ldgRuFW7Ykg1x5qXMOhN3Q/A6Vhme8lxLfTWTSAbzIR/PDfg==
X-Received: by 2002:a50:9d8d:: with SMTP id w13mr3745054ede.94.1624008934194; 
 Fri, 18 Jun 2021 02:35:34 -0700 (PDT)
Received: from steredhat.lan ([5.170.128.252])
 by smtp.gmail.com with ESMTPSA id ch17sm5993778edb.42.2021.06.18.02.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 02:35:33 -0700 (PDT)
Date: Fri, 18 Jun 2021 11:35:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jiang Wang <jiang.wang@bytedance.com>
Subject: Re: [RFC v1 0/6] virtio/vsock: introduce SOCK_DGRAM support
Message-ID: <20210618093529.bxsv4qnryccivdsd@steredhat.lan>
References: <20210609232501.171257-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210609232501.171257-1-jiang.wang@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, Andra Paraschiv <andraprs@amazon.com>,
 kvm@vger.kernel.org, mst@redhat.com, virtualization@lists.linux-foundation.org,
 Norbert Slusarek <nslusarek@gmx.net>, jhansen@vmware.comments,
 duanxiongchun@bytedance.com, xieyongji@bytedance.com,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexander Popov <alex.popov@linux.com>, Steven Rostedt <rostedt@goodmis.org>,
 chaiwen.cc@bytedance.com, stefanha@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lu Wei <luwei32@huawei.com>,
 Colin Ian King <colin.king@canonical.com>, arseny.krasnov@kaspersky.com,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

T24gV2VkLCBKdW4gMDksIDIwMjEgYXQgMTE6MjQ6NTJQTSArMDAwMCwgSmlhbmcgV2FuZyB3cm90
ZToKPlRoaXMgcGF0Y2hzZXQgaW1wbGVtZW50cyBzdXBwb3J0IG9mIFNPQ0tfREdSQU0gZm9yIHZp
cnRpbwo+dHJhbnNwb3J0Lgo+Cj5EYXRhZ3JhbSBzb2NrZXRzIGFyZSBjb25uZWN0aW9ubGVzcyBh
bmQgdW5yZWxpYWJsZS4gVG8gYXZvaWQgdW5mYWlyIGNvbnRlbnRpb24KPndpdGggc3RyZWFtIGFu
ZCBvdGhlciBzb2NrZXRzLCBhZGQgdHdvIG1vcmUgdmlydHF1ZXVlcyBhbmQKPmEgbmV3IGZlYXR1
cmUgYml0IHRvIGluZGljYXRlIGlmIHRob3NlIHR3byBuZXcgcXVldWVzIGV4aXN0IG9yIG5vdC4K
Pgo+RGdyYW0gZG9lcyBub3QgdXNlIHRoZSBleGlzdGluZyBjcmVkaXQgdXBkYXRlIG1lY2hhbmlz
bSBmb3IKPnN0cmVhbSBzb2NrZXRzLiBXaGVuIHNlbmRpbmcgZnJvbSB0aGUgZ3Vlc3QvZHJpdmVy
LCBzZW5kaW5nIHBhY2tldHMKPnN5bmNocm9ub3VzbHksIHNvIHRoZSBzZW5kZXIgd2lsbCBnZXQg
YW4gZXJyb3Igd2hlbiB0aGUgdmlydHF1ZXVlIGlzIGZ1bGwuCj5XaGVuIHNlbmRpbmcgZnJvbSB0
aGUgaG9zdC9kZXZpY2UsIHNlbmQgcGFja2V0cyBhc3luY2hyb25vdXNseQo+YmVjYXVzZSB0aGUg
ZGVzY3JpcHRvciBtZW1vcnkgYmVsb25ncyB0byB0aGUgY29ycmVzcG9uZGluZyBRRU1VCj5wcm9j
ZXNzLgo+Cj5UaGUgdmlydGlvIHNwZWMgcGF0Y2ggaXMgaGVyZToKPmh0dHBzOi8vd3d3LnNwaW5p
Y3MubmV0L2xpc3RzL2xpbnV4LXZpcnR1YWxpemF0aW9uL21zZzUwMDI3Lmh0bWwKPgo+Rm9yIHRo
b3NlIHdobyBwcmVmZXIgZ2l0IHJlcG8sIGhlcmUgaXMgdGhlIGxpbmsgZm9yIHRoZSBsaW51eCBr
ZXJuZWzvvJoKPmh0dHBzOi8vZ2l0aHViLmNvbS9KaWFuZzExNTUvbGludXgvdHJlZS92c29jay1k
Z3JhbS12MQo+Cj5xZW11IHBhdGNoIGxpbms6Cj5odHRwczovL2dpdGh1Yi5jb20vSmlhbmcxMTU1
L3FlbXUvdHJlZS92c29jay1kZ3JhbS12MQo+Cj4KPlRvIGRvOgo+MS4gdXNlIHNrYiB3aGVuIHJl
Y2VpdmluZyBwYWNrZXRzCj4yLiBzdXBwb3J0IG11bHRpcGxlIHRyYW5zcG9ydAo+My4gc3VwcG9y
dCBtZXJnZWFibGUgcnggYnVmZmVyCgpKaWFuZywgSSdsbCBkbyBhIGZhc3QgcmV2aWV3LCBidXQg
SSB0aGluayBpcyBiZXR0ZXIgdG8gcmViYXNlIG9uIApuZXQtbmV4dCBzaW5jZSBTRVFQQUNLRVQg
c3VwcG9ydCBpcyBub3cgbWVyZ2VkLgoKUGxlYXNlIGFsc28gcnVuIC4vc2NyaXB0cy9jaGVja3Bh
dGNoLnBsLCB0aGVyZSBhcmUgYSBsb3Qgb2YgaXNzdWVzLgoKSSdsbCBsZWF2ZSBzb21lIHNpbXBs
ZSBjb21tZW50cyBpbiB0aGUgcGF0Y2hlcywgYnV0IEkgcHJlZmVyIHRvIGRvIGEgCmRlZXAgcmV2
aWV3IGFmdGVyIHRoZSByZWJhc2UgYW5kIHRoZSBkeW5hbWljIGhhbmRsaW5nIG9mIERHUkFNLgoK
VGhhbmtzLApTdGVmYW5vCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
