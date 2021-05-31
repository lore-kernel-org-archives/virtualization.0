Return-Path: <SRS0=j1Zo=K2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEB2C47082
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 06:44:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131D2611CA
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 06:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131D2611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D319C403AE;
	Mon, 31 May 2021 06:44:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kaNtQ0Brha4w; Mon, 31 May 2021 06:44:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 72D0F40134;
	Mon, 31 May 2021 06:44:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 414A0C000E;
	Mon, 31 May 2021 06:44:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 437C8C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:44:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2DDAD403AE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:44:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K0J0ZLudWlXQ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:44:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6E1CA403AF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622443446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIWAUfwgcui+A5fvQ+stNJmoyeMH3B/9N1MfI1yf4jc=;
 b=NH7jpwjF69SRvAa5BOkegkttnKzHs6vr5RcbRXENacDHfaQVXMXWCmEHR/IeTXCl+rja5J
 uuLo1Te4lfi5q38S0Ec+0Q0z23/9XEF7Cmce7p4lU63iTxeoRXyZzx0wTONkTcL9NiXP63
 v4YrlzjJ73lfGNEdl+qMpnpKoVm+Rp8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-QBic0mmkPyewTeSalAwfNA-1; Mon, 31 May 2021 02:44:04 -0400
X-MC-Unique: QBic0mmkPyewTeSalAwfNA-1
Received: by mail-pg1-f198.google.com with SMTP id
 s14-20020a63450e0000b029021f631b8861so4020236pga.20
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 23:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=TIWAUfwgcui+A5fvQ+stNJmoyeMH3B/9N1MfI1yf4jc=;
 b=SiIPJ6dydXO0Dxp6RwWReWcEtuFOZ3Eqgmy+gOaH+MjCPMWgzefYn+VDAIu31rWM92
 67W/tGY+RvfUmNY5d9GLzhcCknwLQ4CLJNndSijOq9zv8QrkWYYKCb92RjeyfDmklRD9
 cpyNNTWcAdZWtk3BRyH1eDeI1dkdNycTI0bOh3LDUehiT90hCcWvVF8lx7W1RzBTki4v
 cRmo+YTsmeErrAdTsLuqHU0bwxZV4i3o55RsiaPO5b43VBj+lBwhjw5cQMEhPtRn0lZc
 1v/aoTfe51wobcd2NvR2y1VgpvvPLyE6jY73yM2cnoZVKi1K65TxTCQbHvBtwVc8Ea11
 K3mg==
X-Gm-Message-State: AOAM530xO6XrUnrOktc5nSlci/QLtbLfDd3Cw7+Fyol6MQcgsWdibCJi
 qP8XcK/tPQ/4Q0CORP0OZkUTAYwjv0LVwYiYHNEin8eH75vP9s09gpcg76KD3Nu67PMrqr8T/yh
 uiOcnP3UTS+mC3ibWQUJWr3m1G/hi6SD3+jP/y5gd1g==
X-Received: by 2002:a17:90b:1e05:: with SMTP id
 pg5mr17681415pjb.65.1622443443070; 
 Sun, 30 May 2021 23:44:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAtVgDwKFNXkgIrbDystmbQJqx+LiZ7tTXQgOt9gmZoo6uxj5ICpwEvDlwzpx/A4gnUxVHWg==
X-Received: by 2002:a17:90b:1e05:: with SMTP id
 pg5mr17681403pjb.65.1622443442859; 
 Sun, 30 May 2021 23:44:02 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u1sm10771915pgh.80.2021.05.30.23.44.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 May 2021 23:44:02 -0700 (PDT)
Subject: Re: [PATCH 1/2] vdpa/mlx5: Support creating resources with uid == 0
To: Eli Cohen <elic@nvidia.com>
References: <20210530075415.4644-1-elic@nvidia.com>
 <20210530075415.4644-2-elic@nvidia.com>
 <7e4f741e-e595-fe19-91ef-e6faeec765d4@redhat.com>
 <c9c2a453-7ceb-a0ad-7731-d150b3bc1e53@redhat.com>
 <20210531045914.GB158940@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3717ebc5-66ce-2d50-1853-49442a8e71e1@redhat.com>
Date: Mon, 31 May 2021 14:43:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210531045914.GB158940@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

CuWcqCAyMDIxLzUvMzEg5LiL5Y2IMTI6NTksIEVsaSBDb2hlbiDlhpnpgZM6Cj4gT24gTW9uLCBN
YXkgMzEsIDIwMjEgYXQgMTE6MDY6NTlBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4g5Zyo
IDIwMjEvNS8zMSDkuIrljYgxMTowMiwgSmFzb24gV2FuZyDlhpnpgZM6Cj4+PiDlnKggMjAyMS81
LzMwIOS4i+WNiDM6NTQsIEVsaSBDb2hlbiDlhpnpgZM6Cj4+Pj4gQ3VycmVudGx5IGFsbCByZXNv
dXJjZXMgbXVzdCBiZSBjcmVhdGVkIHdpdGggdWlkICE9IDAgd2hpY2ggaXMgZXNzZW50aWFsCj4+
Pj4gdXNlcnNwYWNlIHByb2Nlc3NlcyBhbGxvY2F0aW5nIHZpcnRxdXVldWUgcmVzb3VyY2VzLiBT
aW5jZSB0aGlzIGlzIGEKPj4+PiBrZXJuZWwgaW1wbGVtZW50YXRpb24sIGl0IGlzIHBlcmZlY3Rs
eSBsZWdhbCB0byBvcGVuIHJlc291cmNlcyB3aXRoCj4+Pj4gdWlkID09IDAuCj4+Pj4KPj4+PiBJ
biBjYXNlIGZyaW13YXJlIHN1cHBvcnRzLCBhdm9pZCBhbGxvY2F0aW5nIHVzZXIgY29udGV4dC4K
Pj4+Cj4+PiBUeXBvICJmcmltd2FyZSIuCj4+Pgo+Pj4gT3RoZXJ3aXNlLgo+Pj4KPj4+IEFja2Vk
LWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+Pj4KPj4+IChJIGRvbid0IHNl
ZSBhbnkgY29kZSB0byBjaGVjayB0aGUgZmlybXdhcmUgY2FwYWJpbGl0eSwgaXMgdGhpcwo+Pj4g
aW50ZW5kZWQ/KQo+Pgo+PiBTcGVhayB0b28gZmFzdC4gSSBzZWUgdGhlIE1MWDVfQ0FQX0dFTigp
LCBzbyBpdCdzIGZpbmUuCj4gQW5kIEkgcmVzcG9uZGVkIHRvbyBmYXN0IDotKQoKClJpZ2h0IGFu
ZCB0aGFua3MgZm9yIHRoZSBxdWljayByZXNwb25zZSA6KQoKCj4+IFRoYW5rcwo+Pgo+Pgo+Pj4g
VGhhbmtzCj4+Pgo+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlh
LmNvbT4KPj4+PiAtLS0KPj4+PiAgwqAgZHJpdmVycy92ZHBhL21seDUvY29yZS9yZXNvdXJjZXMu
YyB8IDYgKysrKysrCj4+Pj4gIMKgIGluY2x1ZGUvbGludXgvbWx4NS9tbHg1X2lmYy5owqDCoMKg
wqDCoCB8IDQgKysrLQo+Pj4+ICDCoCAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2Nv
cmUvcmVzb3VyY2VzLmMKPj4+PiBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3VyY2VzLmMK
Pj4+PiBpbmRleCA2NTIxY2JkMGY1YzIuLjgzNmFiOWVmMGZhNiAxMDA2NDQKPj4+PiAtLS0gYS9k
cml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jCj4+Pj4gKysrIGIvZHJpdmVycy92ZHBh
L21seDUvY29yZS9yZXNvdXJjZXMuYwo+Pj4+IEBAIC01NCw2ICs1NCw5IEBAIHN0YXRpYyBpbnQg
Y3JlYXRlX3VjdHgoc3RydWN0IG1seDVfdmRwYV9kZXYKPj4+PiAqbXZkZXYsIHUxNiAqdWlkKQo+
Pj4+ICDCoMKgwqDCoMKgIHZvaWQgKmluOwo+Pj4+ICDCoMKgwqDCoMKgIGludCBlcnI7Cj4+Pj4g
IMKgICvCoMKgwqAgaWYgKE1MWDVfQ0FQX0dFTihtdmRldi0+bWRldiwgdW1lbV91aWRfMCkpCj4+
Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4+ICsKPj4+PiAgwqDCoMKgwqDCoCAvKiAw
IG1lYW5zIG5vdCBzdXBwb3J0ZWQgKi8KPj4+PiAgwqDCoMKgwqDCoCBpZiAoIU1MWDVfQ0FQX0dF
TihtdmRldi0+bWRldiwgbG9nX21heF91Y3R4KSkKPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiAtRU9QTk9UU1VQUDsKPj4+PiBAQCAtNzksNiArODIsOSBAQCBzdGF0aWMgdm9pZCBkZXN0
cm95X3VjdHgoc3RydWN0IG1seDVfdmRwYV9kZXYKPj4+PiAqbXZkZXYsIHUzMiB1aWQpCj4+Pj4g
IMKgwqDCoMKgwqAgdTMyIG91dFtNTFg1X1NUX1NaX0RXKGRlc3Ryb3lfdWN0eF9vdXQpXSA9IHt9
Owo+Pj4+ICDCoMKgwqDCoMKgIHUzMiBpbltNTFg1X1NUX1NaX0RXKGRlc3Ryb3lfdWN0eF9pbild
ID0ge307Cj4+Pj4gIMKgICvCoMKgwqAgaWYgKCF1aWQpCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJl
dHVybjsKPj4+PiArCj4+Pj4gIMKgwqDCoMKgwqAgTUxYNV9TRVQoZGVzdHJveV91Y3R4X2luLCBp
biwgb3Bjb2RlLCBNTFg1X0NNRF9PUF9ERVNUUk9ZX1VDVFgpOwo+Pj4+ICDCoMKgwqDCoMKgIE1M
WDVfU0VUKGRlc3Ryb3lfdWN0eF9pbiwgaW4sIHVpZCwgdWlkKTsKPj4+PiAgwqAgZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvbWx4NS9tbHg1X2lmYy5oCj4+Pj4gYi9pbmNsdWRlL2xpbnV4L21s
eDUvbWx4NV9pZmMuaAo+Pj4+IGluZGV4IDljNjhiMmRhMTRjNi4uNjA2ZDJhZWFjYWQ0IDEwMDY0
NAo+Pj4+IC0tLSBhL2luY2x1ZGUvbGludXgvbWx4NS9tbHg1X2lmYy5oCj4+Pj4gKysrIGIvaW5j
bHVkZS9saW51eC9tbHg1L21seDVfaWZjLmgKPj4+PiBAQCAtMTQ4Nyw3ICsxNDg3LDkgQEAgc3Ry
dWN0IG1seDVfaWZjX2NtZF9oY2FfY2FwX2JpdHMgewo+Pj4+ICDCoMKgwqDCoMKgIHU4wqDCoMKg
wqDCoMKgwqDCoCB1YXJfNGtbMHgxXTsKPj4+PiAgwqDCoMKgwqDCoCB1OMKgwqDCoMKgwqDCoMKg
wqAgcmVzZXJ2ZWRfYXRfMjQxWzB4OV07Cj4+Pj4gIMKgwqDCoMKgwqAgdTjCoMKgwqDCoMKgwqDC
oMKgIHVhcl9zelsweDZdOwo+Pj4+IC3CoMKgwqAgdTjCoMKgwqDCoMKgwqDCoMKgIHJlc2VydmVk
X2F0XzI1MFsweDhdOwo+Pj4+ICvCoMKgwqAgdTjCoMKgwqDCoMKgwqDCoMKgIHJlc2VydmVkX2F0
XzI0OFsweDJdOwo+Pj4+ICvCoMKgwqAgdTjCoMKgwqDCoMKgwqDCoMKgIHVtZW1fdWlkXzBbMHgx
XTsKPj4+PiArwqDCoMKgIHU4wqDCoMKgwqDCoMKgwqDCoCByZXNlcnZlZF9hdF8yNTBbMHg1XTsK
Pj4+PiAgwqDCoMKgwqDCoCB1OMKgwqDCoMKgwqDCoMKgwqAgbG9nX3BnX3N6WzB4OF07Cj4+Pj4g
IMKgIMKgwqDCoMKgwqAgdTjCoMKgwqDCoMKgwqDCoMKgIGJmWzB4MV07CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
