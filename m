Return-Path: <SRS0=Cwtm=K6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4CAC47096
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 01:29:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D86061404
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 01:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D86061404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5869860AF2;
	Fri,  4 Jun 2021 01:29:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DNpAocm7mzJe; Fri,  4 Jun 2021 01:29:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA11960689;
	Fri,  4 Jun 2021 01:29:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F87EC000E;
	Fri,  4 Jun 2021 01:29:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7B0DC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 01:29:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C06AE40691
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 01:29:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0lgwe52rocZ1
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 01:29:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E562E4068E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 01:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622770158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/MGaP9q9f0JKQhqX62iqN0ZP08JFP5du6nrkmNfcZI=;
 b=K/HQSMU4LBVYpz00V1PPKjKhDMrTDf3NbQeokcJY/KZ1gwFMnyQsSZVRHXvKCYQMHwRpwM
 HxrpXfWZjLstkN++epmqAL2GWEw0KWUuwsCvIJhLeLCREABiej2cCjKpeeHsjE4VSxWC2J
 lBZ/h+FnIFWli49CMH7Eq7lm5nEu4RM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-ig_VJQtDOFaUYPuvuGT-bg-1; Thu, 03 Jun 2021 21:29:17 -0400
X-MC-Unique: ig_VJQtDOFaUYPuvuGT-bg-1
Received: by mail-pf1-f198.google.com with SMTP id
 s5-20020aa78d450000b02902ace63a7e93so4457378pfe.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 18:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=T/MGaP9q9f0JKQhqX62iqN0ZP08JFP5du6nrkmNfcZI=;
 b=tYBTNne2jrYE0Ds2QwEmdVos5PAeN8+A+hhlTPbUL9xuhCg0lrQqjFNDesuzuTLHPv
 M8rZ7Y1Y8CfPs7/pfkKGDBNosXsZ4+ImfBpvaeM5fHZ6qwiusm4p3F/Js72/tCDXyJPM
 fRfBdXICP+Yf0L8jstH3YGFweJSxSXcJZtveNyD0WKTahzgGxipg6uVsWb7H7ZEGQ3xc
 P4BP+vvjyC7/a4hNYRcRxlOwU9+QJEQyH5ItG+TvnPgHlHYH7tTla3CiFrteHSQ/geTb
 kB3P/xNvW4J8zuihKTvZt/rBsSR3tHeYlZ7EKQoo7ZDyFoDlQUZGUZTk/x3oHJSO9+uE
 CpDQ==
X-Gm-Message-State: AOAM532R1Odxpk90OHguGj7dHULVcSQRnF3pfYpfa+W3e2GkOIRlgWF3
 POrbjsGIWofbmcXcv/uaHzrqAg9CKKCKjOWTX0P9MriSuMxv2JwCUsaZN+2rk7S573ENu0qo1Wh
 06W4ZChoX8l0ZE1OIyITeHVHjkh04jPEMCQ4dQwQYGg==
X-Received: by 2002:a17:90b:1b4f:: with SMTP id
 nv15mr14342918pjb.56.1622770156272; 
 Thu, 03 Jun 2021 18:29:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwux6m9f0rUpQpP+RF5uS/fzFDKk5OPQIJa3aqTa1QYQjfa9K3fazTvsDkqAod+yFl7P/Fs/Q==
X-Received: by 2002:a17:90b:1b4f:: with SMTP id
 nv15mr14342903pjb.56.1622770155986; 
 Thu, 03 Jun 2021 18:29:15 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id h12sm289129pgn.54.2021.06.03.18.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 18:29:15 -0700 (PDT)
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To: Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
 <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4b071a9f-3683-b990-ddc2-450ac5a10388@redhat.com>
Date: Fri, 4 Jun 2021 09:29:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, jpoimboe@redhat.com, robin.murphy@arm.com,
 hch@lst.de, m.szyprowski@samsung.com
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

CuWcqCAyMDIxLzYvNCDkuIrljYgyOjAwLCBBbmRpIEtsZWVuIOWGmemBkzoKPgo+IE9uIDYvMy8y
MDIxIDEwOjMzIEFNLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6Cj4+IE9uIDYvMi8yMSA1OjQxIFBN
LCBBbmRpIEtsZWVuIHdyb3RlOgo+Pj4gT25seSBhbGxvdyBzcGxpdCBtb2RlIHdoZW4gaW4gYSBw
cm90ZWN0ZWQgZ3Vlc3QuIEZvbGxvd29uCj4+PiBwYXRjaGVzIGhhcmRlbiB0aGUgc3BsaXQgbW9k
ZSBjb2RlIHBhdGhzLCBhbmQgd2UgZG9uJ3Qgd2FudAo+Pj4gYW4gbWFsaWNpb3VzIGhvc3QgdG8g
Zm9yY2UgYW55dGhpbmcgZWxzZS4gQWxzbyBkaXNhbGxvdwo+Pj4gaW5kaXJlY3QgbW9kZSBmb3Ig
c2ltaWxhciByZWFzb25zLgo+PiBJIHJlYWQgdGhpcyBhcyAidGhlIHZpcnRpbyBkcml2ZXIgaXMg
YnVnZ3kuwqAgTGV0J3MgZGlzYWJsZSBtb3N0IG9mIHRoZQo+PiBidWdneSBjb2RlIGluIG9uZSBz
cGVjaWFsIGNhc2UgaW4gd2hpY2ggd2UgbmVlZCBhIGRyaXZlciB3aXRob3V0IGJ1Z3MuCj4+IElu
IGFsbCB0aGUgb3RoZXIgY2FzZXMgKGUuZy4gaGFyZHdhcmUgdmlydGlvIGRldmljZSBjb25uZWN0
ZWQgb3Zlcgo+PiBVU0ItQyksIGRyaXZlciBidWdzIGFyZSBzdGlsbCBhbGxvd2VkLiIKPgo+IE15
IHVuZGVyc3RhbmRpbmcgaXMgbW9zdCBvZiB0aGUgb3RoZXIgbW9kZXMgKGV4Y2VwdCBmb3Igc3Bs
aXQgd2l0aCAKPiBzZXBhcmF0ZSBkZXNjcmlwdG9ycykgYXJlIG9ic29sZXRlIGFuZCBqdXN0IHRo
ZXJlIGZvciBjb21wYXRpYmlsaXR5LiAKPiBBcyBsb25nIGFzIHRoZXkncmUgZGVwcmVjYXRlZCB0
aGV5IHdvbid0IGhhcm0gYW55b25lLgo+Cj4gLUFuZGkKPgoKRm9yICJtb2RlIiBkbyB5b3UgcGFj
a2VkIHZzIHNwbGl0PyBJZiB5ZXMsIGl0J3Mgbm90IGp1c3QgZm9yIApjb21wYXRpYmlsaXR5LiBU
aG91Z2ggcGFja2VkIHZpcnRxdWV1ZSBpcyBkZXNpZ25lZCB0byBiZSBtb3JlIGhhcmR3YXJlIApm
cmllbmRseSwgbW9zdCBoYXJkd2FyZSB2ZW5kb3JzIGNob29zZSB0byBzdGFydCBmcm9tIHNwbGl0
LgoKVGhhbmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
