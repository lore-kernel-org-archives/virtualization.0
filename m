Return-Path: <SRS0=HAf6=MG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BEFC07E9A
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 08:57:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A95061369
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 08:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A95061369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61E97606C7;
	Wed, 14 Jul 2021 08:57:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aHSBRTYsLlrT; Wed, 14 Jul 2021 08:57:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 08D0660A63;
	Wed, 14 Jul 2021 08:57:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3372C001A;
	Wed, 14 Jul 2021 08:57:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F29FEC001F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 08:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E09AF40221
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 08:57:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AWeNsBcpD3wY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 08:57:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9401C40114
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 08:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626253029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b67pj1XjCFcb4vjOC6L9gEcYmcQccLEDJzYb3n+c66I=;
 b=izYdgIPViBrjodbEmKIuj31rynO1KOexp4s0EXFtCbJN0aczCRvebWxDEqPH3bFjYFGJiC
 CZaGgTxbxhySnYm+eGcA6q0Mqc8RAajrNpdR3fAUbNK3JcrHcYvhj/fEUj6Je2jTcmHv0d
 wQv44fcgVaJljc4kC+4OeHjZX8r4VtI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-Vv2-Rsj2Pqqo1BFy_msZ2A-1; Wed, 14 Jul 2021 04:57:06 -0400
X-MC-Unique: Vv2-Rsj2Pqqo1BFy_msZ2A-1
Received: by mail-pj1-f69.google.com with SMTP id
 c20-20020a17090ab294b029016fccb9582dso882234pjr.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 01:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=b67pj1XjCFcb4vjOC6L9gEcYmcQccLEDJzYb3n+c66I=;
 b=R9BYEMbjPewebBnD6Ao6skqWh8NqVOMQZ83UmIDNo8av4g8oGl89+mNsgcrE1rjBAN
 Ht6mCaINLiIPFkCyXW50xvwsEm7HkY2l5gofkkVh5DIeWUn8/TTW+hPlN6ull2j6twhg
 vMABTKWLqyT9YrRFN9IDbcqnwpckZJ3UlxuJ4pZwSaAjGr0ARtRypOrYMfzfCiApSGFi
 USKa4bErrCorCkQ1++v3H3RQK+YQcDkF8lUoBd9cFU1ZHw1JvE87kr25Y8LpVn4FeNFZ
 OLcaJPRINO/5MXHNvl9kFqXiKFd3rtUJZr4iDNWCTnOYm43UuvUJ6/y3YRGe/h9k0lBl
 5YPw==
X-Gm-Message-State: AOAM530UbIv3qSn0tpYv4VeCPmrehxGsBCTLz5rAFuVWKq7Q+tOH6M8A
 DPOZ8XZDyOmJg8eK5fZnuM+7qYwtNBTjiFcHdEXyA+B+UR8XaLVsXYKQfty5P6fa/8lb03zxZHO
 4V/411aeMBmyWjwP622wQRLAkQIij4XMzrRIe/tz34w==
X-Received: by 2002:a17:90a:af90:: with SMTP id
 w16mr2814489pjq.129.1626253025291; 
 Wed, 14 Jul 2021 01:57:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzI/UxSDMVXZBsCbO/ysTuOL+td5Krg49S3x+yII+Nt1pi43Zbgr08iKwIXB4LRw/hvEMwy1w==
X-Received: by 2002:a17:90a:af90:: with SMTP id
 w16mr2814452pjq.129.1626253024987; 
 Wed, 14 Jul 2021 01:57:04 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d2sm2127796pgh.59.2021.07.14.01.56.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jul 2021 01:57:04 -0700 (PDT)
Subject: Re: [PATCH v9 16/17] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Greg KH <gregkh@linuxfoundation.org>
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-17-xieyongji@bytedance.com>
 <26116714-f485-eeab-4939-71c4c10c30de@redhat.com>
 <20210714014817-mutt-send-email-mst@kernel.org>
 <0565ed6c-88e2-6d93-7cc6-7b4afaab599c@redhat.com>
 <YO6IiDIMUjQsA2LS@kroah.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a493bc51-9a5c-05f1-2eac-54cb9e6c9d9b@redhat.com>
Date: Wed, 14 Jul 2021 16:56:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YO6IiDIMUjQsA2LS@kroah.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, christian.brauner@canonical.com,
 corbet@lwn.net, joro@8bytes.org, willy@infradead.org, hch@infradead.org,
 Xie Yongji <xieyongji@bytedance.com>, dan.carpenter@oracle.com,
 xiaodong.liu@intel.com, viro@zeniv.linux.org.uk, stefanha@redhat.com,
 songmuchun@bytedance.com, axboe@kernel.dk, zhe.he@windriver.com,
 netdev@vger.kernel.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, bcrl@kvack.org,
 linux-fsdevel@vger.kernel.org, mika.penttila@nextfour.com
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

CuWcqCAyMDIxLzcvMTQg5LiL5Y2IMjo0NywgR3JlZyBLSCDlhpnpgZM6Cj4gT24gV2VkLCBKdWwg
MTQsIDIwMjEgYXQgMDI6MDI6NTBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4g5ZyoIDIw
MjEvNy8xNCDkuIvljYgxOjU0LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+Pj4gT24gV2Vk
LCBKdWwgMTQsIDIwMjEgYXQgMDE6NDU6MzlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+
Pj4gK3N0YXRpYyBpbnQgdmR1c2VfZGV2X21zZ19zeW5jKHN0cnVjdCB2ZHVzZV9kZXYgKmRldiwK
Pj4+Pj4gKwkJCSAgICAgIHN0cnVjdCB2ZHVzZV9kZXZfbXNnICptc2cpCj4+Pj4+ICt7Cj4+Pj4+
ICsJaW50IHJldDsKPj4+Pj4gKwo+Pj4+PiArCWluaXRfd2FpdHF1ZXVlX2hlYWQoJm1zZy0+d2Fp
dHEpOwo+Pj4+PiArCXNwaW5fbG9jaygmZGV2LT5tc2dfbG9jayk7Cj4+Pj4+ICsJbXNnLT5yZXEu
cmVxdWVzdF9pZCA9IGRldi0+bXNnX3VuaXF1ZSsrOwo+Pj4+PiArCXZkdXNlX2VucXVldWVfbXNn
KCZkZXYtPnNlbmRfbGlzdCwgbXNnKTsKPj4+Pj4gKwl3YWtlX3VwKCZkZXYtPndhaXRxKTsKPj4+
Pj4gKwlzcGluX3VubG9jaygmZGV2LT5tc2dfbG9jayk7Cj4+Pj4+ICsKPj4+Pj4gKwl3YWl0X2V2
ZW50X2tpbGxhYmxlX3RpbWVvdXQobXNnLT53YWl0cSwgbXNnLT5jb21wbGV0ZWQsCj4+Pj4+ICsJ
CQkJICAgIFZEVVNFX1JFUVVFU1RfVElNRU9VVCAqIEhaKTsKPj4+Pj4gKwlzcGluX2xvY2soJmRl
di0+bXNnX2xvY2spOwo+Pj4+PiArCWlmICghbXNnLT5jb21wbGV0ZWQpIHsKPj4+Pj4gKwkJbGlz
dF9kZWwoJm1zZy0+bGlzdCk7Cj4+Pj4+ICsJCW1zZy0+cmVzcC5yZXN1bHQgPSBWRFVTRV9SRVFf
UkVTVUxUX0ZBSUxFRDsKPj4+Pj4gKwl9Cj4+Pj4+ICsJcmV0ID0gKG1zZy0+cmVzcC5yZXN1bHQg
PT0gVkRVU0VfUkVRX1JFU1VMVF9PSykgPyAwIDogLUVJTzsKPj4+PiBJIHRoaW5rIHdlIHNob3Vs
ZCBtYXJrIHRoZSBkZXZpY2UgYXMgbWFsZnVuY3Rpb24gd2hlbiB0aGVyZSBpcyBhIHRpbWVvdXQg
YW5kCj4+Pj4gZm9yYmlkIGFueSB1c2Vyc3BhY2Ugb3BlcmF0aW9ucyBleGNlcHQgZm9yIHRoZSBk
ZXN0cm95IGFmdHdhcmRzIGZvciBzYWZldHkuCj4+PiBUaGlzIGxvb2tzIGxpa2UgaWYgb25lIHRy
aWVkIHRvIHJ1biBnZGIgb24gdGhlIHByb2dyYW0gdGhlIGJlaGF2aW91cgo+Pj4gd2lsbCBjaGFu
Z2UgY29tcGxldGVseSBiZWNhdXNlIGtlcm5lbCB3YW50cyBpdCB0byByZXNwb25kIHdpdGhpbgo+
Pj4gc3BlY2lmaWMgdGltZS4gTG9va3MgbGlrZSBhIHJlY2VpcGUgZm9yIGhlaXNlbmJ1Z3MuCj4+
Pgo+Pj4gTGV0J3Mgbm90IGJ1aWxkIGludGVyZmFjZXMgd2l0aCBhcmJpdHJhcnkgdGltZW91dHMg
bGlrZSB0aGF0Lgo+Pj4gSW50ZXJydXB0aWJsZSB3YWl0IGV4aXN0cyBmb3IgdGhpcyB2ZXJ5IHJl
YXNvbi4KPj4KPj4gVGhlIHByb2JsZW0gaXMuIERvIHdlIHdhbnQgdXNlcnNwYWNlIHByb2dyYW0g
bGlrZSBtb2Rwcm9iZSB0byBiZSBzdHVjayBmb3IKPj4gaW5kZWZpbml0ZSB0aW1lIGFuZCBleHBl
Y3QgdGhlIGFkbWluaXN0cmF0b3IgdG8ga2lsbCB0aGF0Pwo+IFdoeSB3b3VsZCBtb2Rwcm9iZSBi
ZSBzdHVjayBmb3IgZm9yZXZlcj8KPgo+IElzIHRoaXMgb24gdGhlIG1vZHVsZSBwcm9iZSBwYXRo
PwoKClllcywgaXQgaXMgY2FsbGVkIGluIHRoZSBkZXZpY2UgcHJvYmluZyBwYXRoIHdoZXJlIHRo
ZSBrZXJuZWwgZm9yd2FyZHMgCnRoZSBkZXZpY2UgY29uZmlndXJhdGlvbiByZXF1ZXN0IHRvIHVz
ZXJzcGFjZSBhbmQgd2FpdCBmb3IgaXRzIHJlc3BvbnNlLgoKSWYgaXQgdHVybnMgb3V0IHRvIGJl
IHRyaWNreSwgd2UgY2FuIGltcGxlbWVudCB0aGUgd2hvbGUgZGV2aWNlIGluc2lkZSAKdGhlIGtl
cm5lbCBhbmQgbGVhdmUgb25seSB0aGUgZGF0YXBhdGggaW4gdGhlIHVzZXJzcGFjZSAoYXMgd2hh
dCBUVU4gZGlkKS4KClRoYW5rcwoKCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
