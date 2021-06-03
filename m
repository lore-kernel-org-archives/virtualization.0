Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C5AC47092
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 01:34:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BCCD613DC
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 01:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCCD613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DEFBC4033C;
	Thu,  3 Jun 2021 01:34:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ov4YR7DiQ5bX; Thu,  3 Jun 2021 01:34:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B6C0404D9;
	Thu,  3 Jun 2021 01:34:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E254C000D;
	Thu,  3 Jun 2021 01:34:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A58EFC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 01:34:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 83E43404B8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 01:34:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SsZOy-kRBk9p
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 01:34:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 236E6400DA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 01:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622684062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ay34ayc0XC/WtKXXL+jwzIp+HQgsy2OJ9U8cZG5Fktk=;
 b=cxBF9wwfSOrPrM7soE/MAzChZ4MGm45vjkAFAUasdNdyjI4hZzGy99OiV4eBM004R3chfF
 ll+fP2OPd17sGuN2uobDzUXQjTGy7hMLVVXiTyRoSnIGzT15fCznQxmRBZWsOlkXqdG8Kr
 5xFQN3jERiUGE2v/ZLeA1GP7wmIvbdU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-jA-xk7idN3Gb-00c1m2TmA-1; Wed, 02 Jun 2021 21:34:19 -0400
X-MC-Unique: jA-xk7idN3Gb-00c1m2TmA-1
Received: by mail-pf1-f200.google.com with SMTP id
 j206-20020a6280d70000b02902e9e02e1654so2583388pfd.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Jun 2021 18:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Ay34ayc0XC/WtKXXL+jwzIp+HQgsy2OJ9U8cZG5Fktk=;
 b=ejBvK/nQ9QA6o3LqehPrW4J67prMnQ0dxMRGmQrds9GNZVh2Sr1sp9M2ImVjqr9PB9
 0O1DFw0JzWTZITmvpX/vnK/s5UYQaWZTKoYRbvoGtVd2zFFXs2eJ3k+EMM72R1mQk4k6
 931nzE8rDNFI07oB/HSPAIyPVV2yo7eDbE1+2R2qzev3z4jZJWKewhZtX6D0aegewmJW
 dKeOEYDvU93XwlanjKZl7hu0lsmbQsd/yrGbHdiw5MDvF5AVNtxhWa5AIbsH1krIPs+v
 Yc7hSRrgZXSxibYS3tHJphR5RCRYxgVtM4PaCRijr28ULyePVuq8A584QmknSLEOW3oP
 P5DQ==
X-Gm-Message-State: AOAM530lNUA2cSf4LiEyV1h8E4/mWP6yi3kaoUaYOxgPGPADAxEwHv46
 98MTcw1fUcueTMuul4IcjuXJ1UeU5BzNlCfKtU74EWav+DsxD4WKHiPM8TPJquS6nlr+eGjQCCf
 CqcDLPRpXd016a8hmZhXW7KmHzrGl93aIcXBbxdFdvQ==
X-Received: by 2002:a63:cd16:: with SMTP id i22mr17954372pgg.251.1622684058137; 
 Wed, 02 Jun 2021 18:34:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJyXEZUAiaYZdr9WbuWSy8K0NWk52sC+zgmLSU88RNWlKo9NgUzTDhRO6ojpL1AFvITL5iKg==
X-Received: by 2002:a63:cd16:: with SMTP id i22mr17954351pgg.251.1622684057916; 
 Wed, 02 Jun 2021 18:34:17 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c15sm884731pgt.68.2021.06.02.18.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 18:34:17 -0700 (PDT)
Subject: Re: Virtio hardening for TDX
To: Andi Kleen <ak@linux.intel.com>, mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <63d01084-68d2-a8d5-931d-541a22b5f231@redhat.com>
Date: Thu, 3 Jun 2021 09:34:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603004133.4079390-1-ak@linux.intel.com>
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

CuWcqCAyMDIxLzYvMyDkuIrljYg4OjQxLCBBbmRpIEtsZWVuIOWGmemBkzoKPiBbdjE6IEluaXRp
YWwgcG9zdF0KPgo+IFdpdGggY29uZmlkZW50aWFsIGNvbXB1dGluZyBsaWtlIFREWCB0aGUgZ3Vl
c3QgZG9lc24ndCB0cnVzdCB0aGUgaG9zdAo+IGFueW1vcmUuIFRoZSBob3N0IGlzIGFsbG93ZWQg
dG8gRE9TIG9mIGNvdXJzZSwgYnV0IGl0IGlzIG5vdCBhbGxvd2VkCj4gdG8gcmVhZCBvciB3cml0
ZSBhbnkgZ3Vlc3QgbWVtb3J5IG5vdCBleHBsaWNpdGVseSBzaGFyZWQgd2l0aCBpdC4KPgo+IFRo
aXMgaGFzIGltcGxpY2F0aW9uIGZvciB2aXJ0aW8uIFRyYWRpdGlvbmFsbHkgdmlydGlvIGRpZG4n
dCBhc3N1bWUKPiB0aGUgb3RoZXIgc2lkZSBvZiB0aGUgY29tbXVuaWNhdGlvbiBjaGFubmVsIGlz
IG1hbGljaW91cywgYW5kIHRoZXJlZm9yZQo+IGRpZG4ndCBkbyBhbnkgYm91bmRhcnkgY2hlY2tz
IGluIHZpcnRpbyByaW5nIGRhdGEgc3RydWN0dXJlcy4KPgo+IFRoaXMgcGF0Y2hraXQgZG9lcyBo
YXJkZW5pbmcgZm9yIHZpcnRpby4gIEluIGEgVERYIGxpa2UgbW9kZWwKPiB0aGUgb25seSBob3N0
IG1lbW9yeSBhY2Nlc3NlcyBhbGxvd2VkIGFyZSBpbiB0aGUgdmlydGlvIHJpbmcsCj4gYXMgd2Vs
bCBhcyB0aGUgKGZvcmNlZCkgc3dpb3RsYiBidWZmZXIuCj4KPiBUaGlzIHBhdGNoIGtpdCBkb2Vz
IHZhcmlvdXMgY2hhbmdlcyB0byBlbnN1cmUgdGhlcmUgY2FuIGJlIG5vCj4gYWNjZXNzIG91dHNp
ZGUgdGhlc2UgdHdvIGFyZWFzLiBJdCBpcyBwb3NzaWJsZSBmb3IgdGhlIGhvc3QKPiB0byBicmVh
ayB0aGUgY29tbXVuaWNhdGlvbiwgYnV0IHRoaXMgc2hvdWxkIHJlc3VsdCBpbiBhIElPCj4gZXJy
b3Igb24gdGhlIGd1ZXN0LCBidXQgbm8gbWVtb3J5IHNhZmV0eSB2aW9sYXRpb25zLgo+Cj4gdmly
dGlvIGlzIHF1aXRlIGNvbXBsaWNhdGVkIHdpdGggbWFueSBtb2Rlcy4gVG8gc2ltcGxpZnkKPiB0
aGUgdGFzayB3ZSBlbmZvcmNlIHRoYXQgdmlydGlvIGlzIG9ubHkgaW4gc3BsaXQgbW9kZSB3aXRo
b3V0Cj4gaW5kaXJlY3QgZGVzY3JpcHRvcnMsIHdoZW4gcnVubmluZyBhcyBhIFREWCBndWVzdC4g
V2UgYWxzbwo+IGVuZm9yY2UgdXNlIG9mIHRoZSBETUEgQVBJLgo+Cj4gVGhlbiB0aGVzZSBjb2Rl
IHBhdGhzIGFyZSBoYXJkZW5lZCBhZ2FpbnN0IGFueSBjb3JydXB0aW9ucwo+IG9uIHRoZSByaW5n
Lgo+Cj4gVGhpcyBwYXRjaGtpdCBoYXMgY29tcG9uZW50cyBpbiB0aHJlZSBzdWJzeXN0ZW1zOgo+
IC0gSGFyZGVuaW5nIGNoYW5nZXMgdG8gdmlydGlvLCBhbGwgaW4gdGhlIGdlbmVyaWMgdmlydGlv
LXJpbmcKPiAtIEhhcmRlbmluZyBjaGFuZ2VzIHRvIGtlcm5lbC9kbWEgc3dpb3RsYiB0byBoYXJk
ZW4gc3dpb3RsYiBhZ2FpbnN0Cj4gbWFsaWNpb3VzIHBvaW50ZXJzLiBJdCByZXF1aXJlcyBhbiBB
UEkgY2hhbmdlIHdoaWNoIG5lZWRlZCBhIHRyZWUgc3dlZXAuCj4gLSBBIHNpbmdsZSB4ODYgcGF0
Y2ggdG8gZW5hYmxlIHRoZSBhcmNoX2hhc19yZXN0cmljdGVkX21lbW9yeV9hY2Nlc3MKPiBmb3Ig
VERYCj4KPiBJdCBkZXBlbmRzIG9uIFNhdGh5YSdzIGVhcmxpZXIgcGF0Y2hraXQgdGhhdCBhZGRz
IHRoZSBiYXNpYyBpbmZyYXN0cnVjdHVyZQo+IGZvciBURFguIFRoaXMgaXMgb25seSBuZWVkZWQg
Zm9yIHRoZSAiYW0gSSBydW5uaW5nIGluIFREWCIgcGFydC4KCgpOb3RlIHRoYXQgaXQncyBwcm9i
YWJseSBuZWVkZWQgYnkgb3RoZXIgY2FzZXMgYXMgd2VsbDoKCjEpIE90aGVyIGVuY3J5cHRlZCBW
TSB0ZWNobm9sb2d5CjIpIFZEVVNFWzFdCjMpIFNtYXJ0IE5JQ3MKCldlIGhhdmUgYWxyZWFkeSBo
YWQgZGlzY3Vzc2lvbnMgYW5kIHNvbWUgcGF0Y2hlcyBoYXZlIGJlZW4gcG9zdGVkWzJdWzNdWzRd
LgoKSSB0aGluayB0aGUgYmFzaWMgaWRlYSBpcyBzaW1pbGFyLCBiYXNpY2FsbHkswqAgd2UgZG9u
J3QgdHJ1c3QgYW55IAptZXRhZGF0YSBwcm92aWRlZCBieSB0aGUgZGV2aWNlLgoKWzJdIGlzIHRo
ZSBzZXJpZXMgdGhhdCB1c2UgdGhlIG1ldGFkYXRhIHN0b3JlZCBpbiB0aGUgcHJpdmF0ZSBtZW1v
cnkgCndoaWNoIGNhbid0IGJlIGFjY2Vzc2VkIGJ5IHN3aW90bGIsIHRoaXMgc2VyaWVzIGFpbXMg
dG8gZWxpbWluYXRlIGFsbCAKdGhlIHBvc3NpYmxlIGF0dGFja3MgdmlhIHZpcnRxdWV1ZSBtZXRh
ZGF0YQpbM10gaXMgb25lIGV4YW1wbGUgZm9yIHRoZSB0aGUgdXNlZCBsZW5ndGggdmFsaWRhdGlv
bgpbNF0gaXMgdGhlIGZpeCBmb3IgdGhlIG1hbGljaW91cyBjb25maWcgc3BhY2UKClRoYW5rcwoK
WzFdIGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL25ldGRldi9tc2c3NDMyNjQuaHRtbApb
Ml0gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMva3ZtL21zZzI0MTgyNS5odG1sClszXSBo
dHRwczovL3BhdGNoZXMubGluYXJvLm9yZy9wYXRjaC80NTA3MzMvCls0XSBodHRwczovL2xrbWwu
b3JnL2xrbWwvMjAyMS81LzE3LzM3NgoKPgo+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
