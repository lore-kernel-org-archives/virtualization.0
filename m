Return-Path: <SRS0=1MDK=KU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AD0C2B9F7
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 01:13:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 756EF613F6
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 01:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756EF613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B52D6079A;
	Tue, 25 May 2021 01:13:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FwOTohGfCTs5; Tue, 25 May 2021 01:13:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id D02F460786;
	Tue, 25 May 2021 01:13:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C6B0C000D;
	Tue, 25 May 2021 01:13:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A77FC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 01:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 646A740460
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 01:13:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U7DD3iYk76U2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 01:13:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C0184044C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 01:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621905187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UBzLgDtqavpwimWGiZi7MD4QY+93E8r07zUbXutzxWU=;
 b=hlqdVbkJ0yiboBKs/nJyrG4gvp++R0/uWTIdm/3LCgptpv+70tq/0bGFXpSetce8q0BIqs
 Z0A8KGZfa+mwptA9DiZUs+fOz8EzZBLDvjWY3rey66ceV4t+19nsKHC49NPZgECmt1sq1P
 8Zs4N1uFTAYL3LdtflNSI9EIIg62U5o=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-DeuA8QJIPBSVTPhvYtBoyw-1; Mon, 24 May 2021 21:13:05 -0400
X-MC-Unique: DeuA8QJIPBSVTPhvYtBoyw-1
Received: by mail-pg1-f198.google.com with SMTP id
 q64-20020a632a430000b0290209af2eea25so19815334pgq.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 18:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=UBzLgDtqavpwimWGiZi7MD4QY+93E8r07zUbXutzxWU=;
 b=FjDexeYijNFjl4FVmjzv2XTgGbKWxL5s+rXWfe7iITH6x38mvZZKEUcA/ocQaR1mGI
 aWIgnXl9Y/hFS9TsLXDsk8ZtU9WxG/wgeCB0FTrzMjIP7OBet2HN6aB31BLZaoaXxxG8
 FN2KO47+5DCKxBZvQyLLaz2Ia09YeMYDHyXKvK0P7EoVxWC5aBNQPDAlLMr18YZG5XUb
 MwgYoL5kDfwpls9N/0VbDdpcb4Jl/IwIGBLeIbqCqvSLn/feNvAiIKzbKAKDvHhdP+Ru
 5XgR6RsxTwd3rrf43gkJfBDZTWr/G3OlFO5hDVrDPiWacNlHsqjyYu9vF/8G2ZgJxcRt
 STvg==
X-Gm-Message-State: AOAM533/H85pvp+mhpbPv9bl8BJoIr/V/gO9PG8ipnu2SAeG2A3xwIAU
 ww+fIP7B8ijR82ePvznVXsoqn6FBNIMSa96NIo9r6MXUHzYyU/XNW1jWLdTeNLqWjTxDWUWIYz9
 FBT2/X0tBk5F/wqampfZMVrdV8L4gTaMzgy/o07teLQ==
X-Received: by 2002:a63:ed41:: with SMTP id m1mr16325189pgk.252.1621905184667; 
 Mon, 24 May 2021 18:13:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6D+XOATiRb+OS1/ThQcY+LFli2pfGqzdPD1APVDzJx1s8GwA9GrRbRoA7EMCbeWMP3l95kw==
X-Received: by 2002:a63:ed41:: with SMTP id m1mr16325169pgk.252.1621905184388; 
 Mon, 24 May 2021 18:13:04 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 204sm11729687pfy.56.2021.05.24.18.13.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 May 2021 18:13:03 -0700 (PDT)
Subject: Re: [PATCH -next] virtio_ring: Correct function name
 virtqueue_get_buf_ctx()
To: Yang Yingliang <yangyingliang@huawei.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
References: <20210518050057.614081-1-yangyingliang@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d5e348da-6101-9ead-f675-387db8c90844@redhat.com>
Date: Tue, 25 May 2021 09:12:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210518050057.614081-1-yangyingliang@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: mst@redhat.com
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

CtTaIDIwMjEvNS8xOCDPws7nMTowMCwgWWFuZyBZaW5nbGlhbmcg0LS1wDoKPiBGaXggdGhlIGZv
bGxvd2luZyBtYWtlIFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZzoKPgo+ICAgIGRyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmM6MTkwMzogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3Ig
dmlydHF1ZXVlX2dldF9idWYoKS4gUHJvdG90eXBlIHdhcyBmb3IgdmlydHF1ZXVlX2dldF9idWZf
Y3R4KCkgaW5zdGVhZAo+Cj4gU2lnbmVkLW9mZi1ieTogWWFuZyBZaW5nbGlhbmcgPHlhbmd5aW5n
bGlhbmdAaHVhd2VpLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMg
fCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDg4ZjBiMTZiMTFiOC4uOTkyY2IxY2JlYzkzIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTE4ODIsNyArMTg4Miw3IEBAIGJvb2wgdmlydHF1
ZXVlX2tpY2soc3RydWN0IHZpcnRxdWV1ZSAqdnEpCj4gICBFWFBPUlRfU1lNQk9MX0dQTCh2aXJ0
cXVldWVfa2ljayk7Cj4gICAKPiAgIC8qKgo+IC0gKiB2aXJ0cXVldWVfZ2V0X2J1ZiAtIGdldCB0
aGUgbmV4dCB1c2VkIGJ1ZmZlcgo+ICsgKiB2aXJ0cXVldWVfZ2V0X2J1Zl9jdHggLSBnZXQgdGhl
IG5leHQgdXNlZCBidWZmZXIKPiAgICAqIEBfdnE6IHRoZSBzdHJ1Y3QgdmlydHF1ZXVlIHdlJ3Jl
IHRhbGtpbmcgYWJvdXQuCj4gICAgKiBAbGVuOiB0aGUgbGVuZ3RoIHdyaXR0ZW4gaW50byB0aGUg
YnVmZmVyCj4gICAgKiBAY3R4OiBleHRyYSBjb250ZXh0IGZvciB0aGUgdG9rZW4KCgpBY2tlZC1i
eTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
