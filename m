Return-Path: <SRS0=l/A6=KW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04738C4708C
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 05:40:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF5E613DD
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 05:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF5E613DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 588A8607AB;
	Thu, 27 May 2021 05:40:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TTBFB3yZcMHG; Thu, 27 May 2021 05:40:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06B4B6078B;
	Thu, 27 May 2021 05:40:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE080C000D;
	Thu, 27 May 2021 05:40:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79883C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 05:40:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 52733839E4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 05:40:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ibGQNotLAeTp
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 05:40:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9FB25839DB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 05:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622094043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AU/RuY2ymovNRYn9DIYtROZdNQLFTgpR1rexfb2OF3c=;
 b=N1/ocHRmo7AWpG6/7nLrdOYRAd5Uru10vZ6ei9T4zNgzfrbNjdD/3CTsBheXanRxPW2CSU
 Fsa2dqfqhI8XeCvsCa6NVLat7P/lAfXr+ce986tyzHq+dJ3cPuqjIGQUfzda39lsGfD5bz
 h788r12lhHM1nZAtw0hHM4mu8yjmvng=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-n4vMX73ANl6i8qkqFfoMaQ-1; Thu, 27 May 2021 01:40:41 -0400
X-MC-Unique: n4vMX73ANl6i8qkqFfoMaQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 15-20020a630c4f0000b029021a6da9af28so2263243pgm.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 22:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=AU/RuY2ymovNRYn9DIYtROZdNQLFTgpR1rexfb2OF3c=;
 b=SEf5bd83nxZZNmXlfo5XucPRPzHK9eNQ4sK5adTAknw6Q0N4xoERcblLhTM+J/LyHI
 6K1lDE1xFivJyc1aGtOHPkdco7GQc+kgdChw9n4JQclnjyv9G38JjWQmiujlxxoJrppo
 fY9vLXb2syA7AasNama3pGL/L3vfTp1GBw23HWrqluHl5LAJ1ZGrUfnJTkNh/nl0XcP4
 RtiU5zV5z1ATBAtkaKPjxsAgnojh1512HsF2Cm/xc9Zp/LFjRIPJhzc0LGOSXXTFoBY4
 3VFa5SwDdBafyX6iiwZa11a68L+Q8T7jAer1Bln4tpDGjrPvk0JUd9RZDeK3dRXqwpbf
 QIOg==
X-Gm-Message-State: AOAM533oUvH2NQtAgf8KrJj712v8Yn0taO0ujJe+Axu7ZULOPEfj7LDo
 DBABkonGkgJhcBumKGl2mbM2qoTzEmeVtNKvYne4p6uFn8X/qgG9BCttSNh5FJQ2kjun7fjNZdQ
 Pc/0+spWP/dfmiZHogbmx5NkU6nmTmJmZVwnJkewx5A==
X-Received: by 2002:a17:90a:71c7:: with SMTP id m7mr7691837pjs.9.1622094040613; 
 Wed, 26 May 2021 22:40:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdvc47LfRqVL36pEPdXD9AUGFkROiA0ecx8aq5qhRtKjUnV9VTluCW50o4cKagpZC5qThkZA==
X-Received: by 2002:a17:90a:71c7:: with SMTP id m7mr7691807pjs.9.1622094040375; 
 Wed, 26 May 2021 22:40:40 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z19sm851114pjq.11.2021.05.26.22.40.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 22:40:39 -0700 (PDT)
Subject: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
 <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com>
 <CACycT3uAqa6azso_8MGreh+quj-JXO1piuGnrV8k2kTfc34N2g@mail.gmail.com>
 <5a68bb7c-fd05-ce02-cd61-8a601055c604@redhat.com>
 <CACycT3ve7YvKF+F+AnTQoJZMPua+jDvGMs_ox8GQe_=SGdeCMA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ee00efca-b26d-c1be-68d2-f9e34a735515@redhat.com>
Date: Thu, 27 May 2021 13:40:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CACycT3ve7YvKF+F+AnTQoJZMPua+jDvGMs_ox8GQe_=SGdeCMA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, joro@8bytes.org,
 Randy Dunlap <rdunlap@infradead.org>, iommu@lists.linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <christian.brauner@canonical.com>, bcrl@kvack.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
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

CuWcqCAyMDIxLzUvMjcg5LiL5Y2IMTowOCwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4gT24gVGh1LCBN
YXkgMjcsIDIwMjEgYXQgMTowMCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPj4KPj4g5ZyoIDIwMjEvNS8yNyDkuIvljYgxMjo1NywgWW9uZ2ppIFhpZSDlhpnpgZM6
Cj4+PiBPbiBUaHUsIE1heSAyNywgMjAyMSBhdCAxMjoxMyBQTSBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPiB3cm90ZToKPj4+PiDlnKggMjAyMS81LzE3IOS4i+WNiDU6NTUsIFhpZSBZ
b25namkg5YaZ6YGTOgo+Pj4+PiArCj4+Pj4+ICtzdGF0aWMgaW50IHZkdXNlX2Rldl9tc2dfc3lu
YyhzdHJ1Y3QgdmR1c2VfZGV2ICpkZXYsCj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgdmR1c2VfZGV2X21zZyAqbXNnKQo+Pj4+PiArewo+Pj4+PiArICAgICBpbml0X3dh
aXRxdWV1ZV9oZWFkKCZtc2ctPndhaXRxKTsKPj4+Pj4gKyAgICAgc3Bpbl9sb2NrKCZkZXYtPm1z
Z19sb2NrKTsKPj4+Pj4gKyAgICAgdmR1c2VfZW5xdWV1ZV9tc2coJmRldi0+c2VuZF9saXN0LCBt
c2cpOwo+Pj4+PiArICAgICB3YWtlX3VwKCZkZXYtPndhaXRxKTsKPj4+Pj4gKyAgICAgc3Bpbl91
bmxvY2soJmRldi0+bXNnX2xvY2spOwo+Pj4+PiArICAgICB3YWl0X2V2ZW50X2tpbGxhYmxlKG1z
Zy0+d2FpdHEsIG1zZy0+Y29tcGxldGVkKTsKPj4+PiBXaGF0IGhhcHBlbnMgaWYgdGhlIHVzZXJz
cGFjZShtYWxpY291cykgZG9lc24ndCBnaXZlIGEgcmVzcG9uc2UgZm9yZXZlcj8KPj4+Pgo+Pj4+
IEl0IGxvb2tzIGxpa2UgYSBET1MuIElmIHllcywgd2UgbmVlZCB0byBjb25zaWRlciBhIHdheSB0
byBmaXggdGhhdC4KPj4+Pgo+Pj4gSG93IGFib3V0IHVzaW5nIHdhaXRfZXZlbnRfa2lsbGFibGVf
dGltZW91dCgpIGluc3RlYWQ/Cj4+Cj4+IFByb2JhYmx5LCBhbmQgdGhlbiB3ZSBuZWVkIGNob29z
ZSBhIHN1aXRhYmxlIHRpbWVvdXQgYW5kIG1vcmUgaW1wb3J0YW50LAo+PiBuZWVkIHRvIHJlcG9y
dCB0aGUgZmFpbHVyZSB0byB2aXJ0aW8uCj4+Cj4gTWFrZXMgc2Vuc2UgdG8gbWUuIEJ1dCBpdCBs
b29rcyBsaWtlIHNvbWUKPiB2ZHBhX2NvbmZpZ19vcHMvdmlydGlvX2NvbmZpZ19vcHMgc3VjaCBh
cyBzZXRfc3RhdHVzKCkgZGlkbid0IGhhdmUgYQo+IHJldHVybiB2YWx1ZS4gIE5vdyBJIGFkZCBh
IFdBUk5fT04oKSBmb3IgdGhlIGZhaWx1cmUuIERvIHlvdSBtZWFuIHdlCj4gbmVlZCB0byBhZGQg
c29tZSBjaGFuZ2UgZm9yIHZpcnRpbyBjb3JlIHRvIGhhbmRsZSB0aGUgZmFpbHVyZT8KCgpNYXli
ZSwgYnV0IEknbSBub3Qgc3VyZSBob3cgaGFyZCB3ZSBjYW4gZG8gdGhhdC4KCldlIGhhZCBORUVE
U19SRVNFVCBidXQgaXQgbG9va3Mgd2UgZG9uJ3QgaW1wbGVtZW50IGl0LgoKT3IgYSByb3VnaCBp
ZGVhIGlzIHRoYXQgbWF5YmUgbmVlZCBzb21lIHJlbGF4aW5nIHRvIGJlIGNvdXBsZWQgbG9vc2Vs
eSAKd2l0aCB1c2Vyc3BhY2UuIEUuZyB0aGUgZGV2aWNlIChjb250cm9sIHBhdGgpIGlzIGltcGxl
bWVudGVkIGluIHRoZSAKa2VybmVsIGJ1dCB0aGUgZGF0YXBhdGggaXMgaW1wbGVtZW50ZWQgaW4g
dGhlIHVzZXJzcGFjZSBsaWtlIFRVTi9UQVAuCgpUaGFua3MKCj4KPiBUaGFua3MsCj4gWW9uZ2pp
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
