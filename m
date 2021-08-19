Return-Path: <SRS0=U4FE=NK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D56C4338F
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 04:19:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73B81610FE
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 04:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 73B81610FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3401540308;
	Thu, 19 Aug 2021 04:19:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C-mDcqQt9VD7; Thu, 19 Aug 2021 04:18:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CD1DF4056D;
	Thu, 19 Aug 2021 04:18:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FF44C0010;
	Thu, 19 Aug 2021 04:18:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04CA2C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 04:18:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D323C401E3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 04:18:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ddbzfa4cUYur
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 04:18:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E4C5F400E7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 04:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629346733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQTrvZtRenIwlcGn7k+hSUvdDKL0c8oNRiXwr2F/eBQ=;
 b=aCuAAz85p04bqLBJlUOzgxjR+Kn9fNJZ1bg2wXnd9tv4a5nH8BsshYC5QLewymhL7zuMmw
 ScDf2Ki4Tx2GnWgBfqDzYtLdTG1/zzDWKhu5qcgiX8hpmVIjR4PQc3B7HEbz/AzGA3NXlA
 tmB0dFgPlJyrD9xcPrcVg3syuqUz4dk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-fN9aBKSmPp2_pRlFpppHHA-1; Thu, 19 Aug 2021 00:18:52 -0400
X-MC-Unique: fN9aBKSmPp2_pRlFpppHHA-1
Received: by mail-pf1-f197.google.com with SMTP id
 h14-20020a62b40e0000b02903131bc4a1acso2426930pfn.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 21:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=XQTrvZtRenIwlcGn7k+hSUvdDKL0c8oNRiXwr2F/eBQ=;
 b=BJgxBQrX5SqCQkviOFrJBbJTEnQL4a6/1Z2w3ufSdB0oyNFSAEepYOJB1dhzjHBcHB
 EpfM9XTiA6xbSMjzJ67IVnDWWjbvf4lK8sr5WaDWIGijrittyUMbZun1upTJQZi5zKdD
 TLsxgZ8KKa6X4C/AOkaGWDwuptEUrgzhPdgV/8+2QA6iMtOALvOHO4YJSaRASs10VXYu
 hfs5ed2/iBv98KPRy8qIR7Bwl3M369Wc9wtu23icWEZWR0LqcpQeygv+Zlu91D8Rq/Jt
 fTV/GJ5G4pz96kXnv9AeCj8A9eUQjQVLRBHhRmpiny5JzLXQ72DGT6H9sF1sbix572z9
 nNOw==
X-Gm-Message-State: AOAM530A1SHSwyiQhSaMWc1J5Kg9KMRJ8Bq90RxSfA6PnGuEalaZqKdQ
 MT5TO09Fq2vHR0WWmBfzmFU6MJVY3lA4nU1d7pjnrpyLv2XEw6naoDVv4sJd4xFbBS6PJob7PKG
 mNnjBavFGqkZGFaEQMyQXuM8N3fGXng1A89Wp3AxmkQ==
X-Received: by 2002:a17:902:ab98:b029:12b:acc0:e18c with SMTP id
 f24-20020a170902ab98b029012bacc0e18cmr10075341plr.10.1629346731315; 
 Wed, 18 Aug 2021 21:18:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaMw/bLLfOhEyY1sfQSLEqFqkrQi3E+Ac36vee6WYedDt7OQ1i6fCDgs+DLd2m3uJ/Hcg6BA==
X-Received: by 2002:a17:902:ab98:b029:12b:acc0:e18c with SMTP id
 f24-20020a170902ab98b029012bacc0e18cmr10075322plr.10.1629346731010; 
 Wed, 18 Aug 2021 21:18:51 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c23sm1645897pgb.74.2021.08.18.21.18.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Aug 2021 21:18:50 -0700 (PDT)
Subject: Re: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
To: Parav Pandit <parav@nvidia.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
 <20210806034817-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210809053624-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CF2E07B38C45A2829B7BDCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210816165217-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819F68856798FBA8528BBADCFF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEs4fnV2RT8DSW3i0TtHL6t1rwuNyC-uLi3tRopb7mOhvA@mail.gmail.com>
 <PH0PR12MB5481EF1FFD6EED706E831C89DCFF9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9a88dea1-dc45-a196-f16d-ba3848ca0668@redhat.com>
Date: Thu, 19 Aug 2021 12:18:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481EF1FFD6EED706E831C89DCFF9@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIxLzgvMTgg5LiL5Y2IMTI6MzYsIFBhcmF2IFBhbmRpdCDlhpnpgZM6Cj4KPj4gRnJv
bTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4gU2VudDogV2VkbmVzZGF5LCBB
dWd1c3QgMTgsIDIwMjEgMTA6MDIgQU0KPj4gT24gV2VkLCBBdWcgMTgsIDIwMjEgYXQgMTE6MTUg
QU0gUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPiB3cm90ZToKPiBbLi5dCj4+Pj4gSSdt
IGluY2xpbmVkIHRvIHNheSB2eGxhbiBpcyBjbG9zZXIgdG8gYSBtb2RlbCB0byBmb2xsb3cuCj4+
PiBPay4gdGhhbmtzIGZvciB0aGUgZmVlZGJhY2suIFdlIGFyZSB1c2luZyB0aGUgbW9kZWwgY2xv
c2UgdG8gdnhsYW4uCj4+PiBMZXRzIHJlc29sdmUgc2hvdWxkIHdlIGhhdmUgaXQgYXQgY3JlYXRp
b24gdGltZSwgcG9zdCBjcmVhdGlvbiBvciBib3RoPwo+Pj4gKGEpIENyZWF0aW9uIHRpbWUKPj4+
IFByb3M6Cj4+PiAtIHNpbXBsZXIgc2luZ2xlIGFwaSBmb3IgdXNlcgo+Pj4gLSBlbGltaW5hdGVz
IG5lZWRzIG9mIGludmVudGluZyBzdGF0cyByZXNldCBpbiBmdXR1cmUgc2VyaWVzCj4+PiBDb25z
Ogo+Pj4gLSBpbmFiaWxpdHkgdG8gcmV1c2UgdGhlIGRldmljZSB3aXRoIGRpZmZlcmVudCBjb25m
aWcKPj4gVGhpcyBjYW4gYmUgc29sdmVkIGJ5IGRlc3Ryb3lpbmcgdGhlIGluc3RhbmNlIGFuZCBy
ZS1jcmVhdGluZyBpdCB3aXRoIGEKPj4gZGlmZmVyZW50IHBhcmFtcz8KPj4KPiBZZXMsIHdoaWNo
IGlzIHdoYXQgSSB0cmllZCBiZSBzYXkgYmVsb3cuCj4KPj4+IC0gVGhpcyBtYXkgbm90IGJlIG9m
IGdyZWF0IGFkdmFudGFnZSwgYW5kIGl0IGlzIHByb2JhYmx5IGZpbmUgdG8gaGF2ZSBjcmVhdGlv
biB0aW1lIHBhcmFtcwo+ICAgICAgICBeXl5eXiBoZXJlLgoKCk9oIHJpZ2h0LCBJIG1pc3MgdGhp
cyBzaW5jZSBpdCBiZWxvbmdzIHRvIHRoZSBidWxsZXRzIG9mICJjb25zIi4KCgo+Cj4+PiAoYikg
cG9zdCBjcmVhdGlvbiB0aW1lOgo+Pj4gUHJvczoKPj4+IC0gYWJsZSB0byByZXVzZSB0aGUgZGV2
aWNlIHdpdGggZGlmZmVyZW50IGNvbmZpZyBmb3Igc2F5IGRpZmZlcmVudCBWTS4KPj4+IC0gd2ls
bCByZXF1aXJlIHN0YXRzIHJlc2V0IGluIGZ1dHVyZSBvbmNlIHN0YXRzIGFyZSBpbXBsZW1lbnRl
ZAo+PiBBbnkgcmVhc29uIGZvciBkb2luZyB0aGlzIG90aGVyIHRoYW4gcmUtY3JlYXRpbmcgdGhl
IGRldmljZT8KPj4KPiBOby4gT25seSByZWFzb24gSSBjYW4gdGhpbmsgb2YgaXMsIGRldmljZSBy
ZWNvbmZpZyBtYXkgYmUgZmFzdGVyIHRoYW4gcmVjcmVhdGUuCj4gQnV0IEkgd2VpZ2ggdXNlciBz
aW1wbGljaXR5IG1vcmUgYXQgdGhlIGJlZ2lubmluZyBhbmQgb3B0aW1pemF0aW9ucyB0byBicmlu
ZyBsYXRlciBpZiByZXF1aXJlZC4KPgoKUmlnaHQsIGJ1dCBpdCBsb29rcyB0byBtZSB3ZSBzaG91
bGQgb25seSBhbGxvdyB0aGUgcG9zdC1jcmVhdGlvbiBjaGFuZ2VzIApvbmx5IGlmIGl0IGlzIGFs
bG93ZWQgYnkgdGhlIHNwZWMuCgpFLmcgaWYgd2UgYWxsb3cgbWFjIHRvIGJlIG1vZGlmaWVkIGJ5
IHRoZSBndWVzdCwgaXQgaXMgbm90IGV4cGVjdGVkIHRvIApiZSBjaGFuZ2VkIGZyb20gdGhlIGhv
c3QuCgoKPj4+IENvbnM6Cj4+PiAtIG1vcmUgY29tbWFuZHMgZm9yIHVzZXJzIHRvIGNvbmZpZyBh
IGRldmljZSwgYmV0dGVyIHRvIGhhdmUgdGhlIGFiaWxpdHkgYXQKPj4gY3JlYXRlIHRpbWUuCj4+
Cj4+IFdlIHByb2JhYmx5IG5lZWQgdG8gc3VwcG9ydCBwb3N0IGNyZWF0aW9uIGJ1dCBpdCBzaG91
bGQgYmUgZGV2aWNlIHNwZWNpZmljLgo+IFRydWUuIFlvdXIgYmVsb3cgZGV2aWNlIHJlc2l6ZSBp
cyBnb29kIGV4YW1wbGUgb2YgaXQuCj4KPj4gRS5nIHdlIG1heSBzdXBwb3J0IGRldmljZSByZXNp
emUgZm9yIHZpcnRpby1ibGsgZGV2aWNlcy4KPj4KPj4gQnV0IGl0IGNhbiBiZSBkb25lIG9uIHRv
cCBJIHRoaW5rLgo+IEkgdGhpbmsgc28gdG9vLgoKClRoYW5rcwoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
