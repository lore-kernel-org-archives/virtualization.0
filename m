Return-Path: <SRS0=EgWE=L6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C1CC07E99
	for <virtualization@archiver.kernel.org>; Tue,  6 Jul 2021 02:34:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7170D61246
	for <virtualization@archiver.kernel.org>; Tue,  6 Jul 2021 02:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7170D61246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E3EF837C4;
	Tue,  6 Jul 2021 02:34:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DGwhamE2jbwa; Tue,  6 Jul 2021 02:34:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C673D83806;
	Tue,  6 Jul 2021 02:34:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1729C0010;
	Tue,  6 Jul 2021 02:34:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C30EC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 02:34:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1EA1660646
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 02:34:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1dycff02IOui
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 02:34:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3435560641
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 02:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625538888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HVuNMGPjUFR4EYVE5SY3SOVJbIMJT/f5oi+I5uWxFrM=;
 b=ZS0+wT7x39CdPuwhMLd0iPluB21iZcmBTXC+V59xYWqIKF3zhXsBdPc+yrtezYi0CGLsBs
 CslvgkX8ElTFg/iNgpOeS9vXUjIGpXX7A1Bc9NlkX9Fnryi9Ou55b0zm0AiUNTEkNSNtdS
 WSbnKD6/j2cnN0/6riOUcn79/RxT9W4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-PzpiMl6-N0ewPBkwxFUM6w-1; Mon, 05 Jul 2021 22:34:44 -0400
X-MC-Unique: PzpiMl6-N0ewPBkwxFUM6w-1
Received: by mail-pg1-f200.google.com with SMTP id
 1-20020a6317410000b0290228062f22a0so14964240pgx.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jul 2021 19:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=HVuNMGPjUFR4EYVE5SY3SOVJbIMJT/f5oi+I5uWxFrM=;
 b=EXH4t2doNhJY7fJ4R0lChOhmcgh4Hli9+QmqrKLRNw2E87gkbNJcshjvxCbsj+Q3no
 O9YNtnDGZdeWzn8onNfOT3CsFEl2LX1R7GXKy4QtiRG9moNCFj5iOymPC4Pqx3U5g/24
 jp5oHUvgTLbgxg9TpFx5c+C8NFxdqrBpZA8SkJD/7fAHxHALvhAkmzkhFEfMRd2U7Kas
 lHv/2BL5C1c44K5Rbv5zxzI7u1q2Tx9p8Ent1wiPoKFdAKMGx44Kk2mYAW6BH5oMweEr
 Lb0lAkbUSWSUiiRSuOoK8uDaXZylRclLyZcvj7OpIYyiJOlB7CmgTFd7Lq78NaruMDaf
 qXxg==
X-Gm-Message-State: AOAM530qCiA6Zo/A0gVHq26PV6Z++e1wsbw7qo4VANxTTi9OizOSAC+4
 GTiOryZx2eWlpTueeAuyG7jZG5oS6JHEx1d9cbXtO0SETK6hyH6LAdxVjtldAcDp9V/R6km5jTx
 1NoMlTJ75HOxpaAxv3w1Tt+2cINnLfEGyr+x7giKwLQ==
X-Received: by 2002:a63:f556:: with SMTP id e22mr18650443pgk.189.1625538883949; 
 Mon, 05 Jul 2021 19:34:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzILej/0FQHGxl4T6zrYB/SOfscbH6OhsOWvj703yvNi6LpSqIaMqZLCnRp/+Zmr1wzG6xIfg==
X-Received: by 2002:a63:f556:: with SMTP id e22mr18650421pgk.189.1625538883702; 
 Mon, 05 Jul 2021 19:34:43 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g18sm13838184pfi.199.2021.07.05.19.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jul 2021 19:34:42 -0700 (PDT)
Subject: Re: [PATCH v8 10/10] Documentation: Add documentation for VDUSE
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-11-xieyongji@bytedance.com>
 <YNSCH6l31zwPxBjL@stefanha-x1.localdomain>
 <CACycT3uxnQmXWsgmNVxQtiRhz1UXXTAJFY3OiAJqokbJH6ifMA@mail.gmail.com>
 <YNxCDpM3bO5cPjqi@stefanha-x1.localdomain>
 <CACycT3taKhf1cWp3Jd0aSVekAZvpbR-_fkyPLQ=B+jZBB5H=8Q@mail.gmail.com>
 <YN3ABqCMLQf7ejOm@stefanha-x1.localdomain>
 <CACycT3vo-diHgTSLw_FS2E+5ia5VjihE3qw7JmZR7JT55P-wQA@mail.gmail.com>
 <8320d26d-6637-85c6-8773-49553dfa502d@redhat.com>
 <YOL/9mxkJaokKDHc@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5b5107fa-3b32-8a3b-720d-eee6b2a84ace@redhat.com>
Date: Tue, 6 Jul 2021 10:34:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOL/9mxkJaokKDHc@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, joro@8bytes.org,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Yongji Xie <xieyongji@bytedance.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 Al Viro <viro@zeniv.linux.org.uk>, songmuchun@bytedance.com,
 Jens Axboe <axboe@kernel.dk>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
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

CuWcqCAyMDIxLzcvNSDkuIvljYg4OjQ5LCBTdGVmYW4gSGFqbm9jemkg5YaZ6YGTOgo+IE9uIE1v
biwgSnVsIDA1LCAyMDIxIGF0IDExOjM2OjE1QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
IOWcqCAyMDIxLzcvNCDkuIvljYg1OjQ5LCBZb25namkgWGllIOWGmemBkzoKPj4+Pj4gT0ssIEkg
Z2V0IHlvdSBub3cuIFNpbmNlIHRoZSBWSVJUSU8gc3BlY2lmaWNhdGlvbiBzYXlzICJEZXZpY2UK
Pj4+Pj4gY29uZmlndXJhdGlvbiBzcGFjZSBpcyBnZW5lcmFsbHkgdXNlZCBmb3IgcmFyZWx5LWNo
YW5naW5nIG9yCj4+Pj4+IGluaXRpYWxpemF0aW9uLXRpbWUgcGFyYW1ldGVycyIuIEkgYXNzdW1l
IHRoZSBWRFVTRV9ERVZfU0VUX0NPTkZJRwo+Pj4+PiBpb2N0bCBzaG91bGQgbm90IGJlIGNhbGxl
ZCBmcmVxdWVudGx5Lgo+Pj4+IFRoZSBzcGVjIHVzZXMgTVVTVCBhbmQgb3RoZXIgdGVybXMgdG8g
ZGVmaW5lIHRoZSBwcmVjaXNlIHJlcXVpcmVtZW50cy4KPj4+PiBIZXJlIHRoZSBsYW5ndWFnZSAo
ZXNwZWNpYWxseSB0aGUgd29yZCAiZ2VuZXJhbGx5IikgaXMgd2Vha2VyIGFuZCBtZWFucwo+Pj4+
IHRoZXJlIG1heSBiZSBleGNlcHRpb25zLgo+Pj4+Cj4+Pj4gQW5vdGhlciB0eXBlIG9mIGFjY2Vz
cyB0aGF0IGRvZXNuJ3Qgd29yayB3aXRoIHRoZSBWRFVTRV9ERVZfU0VUX0NPTkZJRwo+Pj4+IGFw
cHJvYWNoIGlzIHJlYWRzIHRoYXQgaGF2ZSBzaWRlLWVmZmVjdHMuIEZvciBleGFtcGxlLCBpbWFn
aW5lIGEgZmllbGQKPj4+PiBjb250YWluaW5nIGFuIGVycm9yIGNvZGUgaWYgdGhlIGRldmljZSBl
bmNvdW50ZXJzIGEgcHJvYmxlbSB1bnJlbGF0ZWQgdG8KPj4+PiBhIHNwZWNpZmljIHZpcnRxdWV1
ZSByZXF1ZXN0LiBSZWFkaW5nIGZyb20gdGhpcyBmaWVsZCByZXNldHMgdGhlIGVycm9yCj4+Pj4g
Y29kZSB0byAwLCBzYXZpbmcgdGhlIGRyaXZlciBhbiBleHRyYSBjb25maWd1cmF0aW9uIHNwYWNl
IHdyaXRlIGFjY2Vzcwo+Pj4+IGFuZCBwb3NzaWJseSByYWNlIGNvbmRpdGlvbnMuIEl0IGlzbid0
IHBvc3NpYmxlIHRvIGltcGxlbWVudCB0aG9zZQo+Pj4+IHNlbWFudGljcyBzdWluZyBWRFVTRV9E
RVZfU0VUX0NPTkZJRy4gSXQncyBhbm90aGVyIGNvcm5lciBjYXNlLCBidXQgaXQKPj4+PiBtYWtl
cyBtZSB0aGluayB0aGF0IHRoZSBpbnRlcmZhY2UgZG9lcyBub3QgYWxsb3cgZnVsbCBWSVJUSU8g
c2VtYW50aWNzLgo+Pgo+PiBOb3RlIHRoYXQgdGhvdWdoIHlvdSdyZSBjb3JyZWN0LCBteSB1bmRl
cnN0YW5kaW5nIGlzIHRoYXQgY29uZmlnIHNwYWNlIGlzCj4+IG5vdCBzdWl0YWJsZSBmb3IgdGhp
cyBraW5kIG9mIGVycm9yIHByb3BhZ2F0aW5nLiBBbmQgaXQgd291bGQgYmUgdmVyeSBoYXJkCj4+
IHRvIGltcGxlbWVudCBzdWNoIGtpbmQgb2Ygc2VtYW50aWMgaW4gc29tZSB0cmFuc3BvcnRzLsKg
IFZpcnRxdWV1ZSBzaG91bGQgYmUKPj4gbXVjaCBiZXR0ZXIuIEFzIFlvbmcgSmkgcXVvdGVkLCB0
aGUgY29uZmlnIHNwYWNlIGlzIHVzZWQgZm9yCj4+ICJyYXJlbHktY2hhbmdpbmcgb3IgaW50aWFs
aXphdGlvbi10aW1lIHBhcmFtZXRlcnMiLgo+Pgo+Pgo+Pj4gQWdyZWVkLiBJIHdpbGwgdXNlIFZE
VVNFX0RFVl9HRVRfQ09ORklHIGluIHRoZSBuZXh0IHZlcnNpb24uIEFuZCB0bwo+Pj4gaGFuZGxl
IHRoZSBtZXNzYWdlIGZhaWx1cmUsIEknbSBnb2luZyB0byBhZGQgYSByZXR1cm4gdmFsdWUgdG8K
Pj4+IHZpcnRpb19jb25maWdfb3BzLmdldCgpIGFuZCB2aXJ0aW9fY3JlYWRfKiBBUEkgc28gdGhh
dCB0aGUgZXJyb3IgY2FuCj4+PiBiZSBwcm9wYWdhdGVkIHRvIHRoZSB2aXJ0aW8gZGV2aWNlIGRy
aXZlci4gVGhlbiB0aGUgdmlydGlvLWJsayBkZXZpY2UKPj4+IGRyaXZlciBjYW4gYmUgbW9kaWZp
ZWQgdG8gaGFuZGxlIHRoYXQuCj4+Pgo+Pj4gSmFzb24gYW5kIFN0ZWZhbiwgd2hhdCBkbyB5b3Ug
dGhpbmsgb2YgdGhpcyB3YXk/Cj4gV2h5IGRvZXMgVkRVU0VfREVWX0dFVF9DT05GSUcgbmVlZCB0
byBzdXBwb3J0IGFuIGVycm9yIHJldHVybiB2YWx1ZT8KPgo+IFRoZSBWSVJUSU8gc3BlYyBwcm92
aWRlcyBubyB3YXkgZm9yIHRoZSBkZXZpY2UgdG8gcmVwb3J0IGVycm9ycyBmcm9tCj4gY29uZmln
IHNwYWNlIGFjY2Vzc2VzLgo+Cj4gVGhlIFFFTVUgdmlydGlvLXBjaSBpbXBsZW1lbnRhdGlvbiBy
ZXR1cm5zIC0xIGZyb20gaW52YWxpZAo+IHZpcnRpb19jb25maWdfcmVhZCooKSBhbmQgc2lsZW50
bHkgZGlzY2FyZHMgdmlydGlvX2NvbmZpZ193cml0ZSooKQo+IGFjY2Vzc2VzLgo+Cj4gVkRVU0Ug
Y2FuIHRha2UgdGhlIHNhbWUgYXBwcm9hY2ggd2l0aAo+IFZEVVNFX0RFVl9HRVRfQ09ORklHL1ZE
VVNFX0RFVl9TRVRfQ09ORklHLgo+Cj4+IEknZCBsaWtlIHRvIHN0aWNrIHRvIHRoZSBjdXJyZW50
IGFzc3VtcHRpb24gdGhpY2ggZ2V0X2NvbmZpZyB3b24ndCBmYWlsLgo+PiBUaGF0IGlzIHRvIHNh
eSwKPj4KPj4gMSkgbWFpbnRhaW4gYSBjb25maWcgaW4gdGhlIGtlcm5lbCwgbWFrZSBzdXJlIHRo
ZSBjb25maWcgc3BhY2UgcmVhZCBjYW4KPj4gYWx3YXlzIHN1Y2NlZWQKPj4gMikgaW50cm9kdWNl
IGFuIGlvY3RsIGZvciB0aGUgdmR1c2UgdXNlcnNhcGNlIHRvIHVwZGF0ZSB0aGUgY29uZmlnIHNw
YWNlLgo+PiAzKSB3ZSBjYW4gc3luY2hyb25pemUgd2l0aCB0aGUgdmR1c2UgdXNlcnNwYWNlIGR1
cmluZyBzZXRfY29uZmlnCj4+Cj4+IERvZXMgdGhpcyB3b3JrPwo+IEkgbm90aWNlZCB0aGF0IGNh
Y2hpbmcgaXMgYWxzbyBhbGxvd2VkIGJ5IHRoZSB2aG9zdC11c2VyIHByb3RvY29sCj4gbWVzc2Fn
ZXMgKFFFTVUncyBkb2NzL2ludGVyb3Avdmhvc3QtdXNlci5yc3QpLCBidXQgdGhlIGRldmljZSBk
b2Vzbid0Cj4ga25vdyB3aGV0aGVyIG9yIG5vdCBjYWNoaW5nIGlzIGluIGVmZmVjdC4gVGhlIGlu
dGVyZmFjZSB5b3Ugb3V0bGluZWQKPiBhYm92ZSByZXF1aXJlcyBjYWNoaW5nLgo+Cj4gSXMgdGhl
cmUgYSByZWFzb24gd2h5IHRoZSBob3N0IGtlcm5lbCB2RFBBIGNvZGUgbmVlZHMgdG8gY2FjaGUg
dGhlCj4gY29uZmlndXJhdGlvbiBzcGFjZT8KCgpCZWNhdXNlOgoKMSkgS2VybmVsIGNhbiBub3Qg
d2FpdCBmb3JldmVyIGluIGdldF9jb25maWcoKSwgdGhpcyBpcyB0aGUgbWFqb3IgCmRpZmZlcmVu
Y2Ugd2l0aCB2aG9zdC11c2VyLgoyKSBTdGljayB0byB0aGUgY3VycmVudCBhc3N1bXB0aW9uIHRo
YXQgdmlydGlvX2NyZWFkKCkgc2hvdWxkIGFsd2F5cyAKc3VjY2VlZC4KClRoYW5rcwoKCj4KPiBI
ZXJlIGFyZSB0aGUgdmhvc3QtdXNlciBwcm90b2NvbCBtZXNzYWdlczoKPgo+ICAgIFZpcnRpbyBk
ZXZpY2UgY29uZmlnIHNwYWNlCj4gICAgXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl4KPgo+ICAg
ICstLS0tLS0tLSstLS0tLS0rLS0tLS0tLSstLS0tLS0tLS0rCj4gICAgfCBvZmZzZXQgfCBzaXpl
IHwgZmxhZ3MgfCBwYXlsb2FkIHwKPiAgICArLS0tLS0tLS0rLS0tLS0tKy0tLS0tLS0rLS0tLS0t
LS0tKwo+Cj4gICAgOm9mZnNldDogYSAzMi1iaXQgb2Zmc2V0IG9mIHZpcnRpbyBkZXZpY2UncyBj
b25maWd1cmF0aW9uIHNwYWNlCj4KPiAgICA6c2l6ZTogYSAzMi1iaXQgY29uZmlndXJhdGlvbiBz
cGFjZSBhY2Nlc3Mgc2l6ZSBpbiBieXRlcwo+Cj4gICAgOmZsYWdzOiBhIDMyLWJpdCB2YWx1ZToK
PiAgICAgIC0gMDogVmhvc3QgbWFzdGVyIG1lc3NhZ2VzIHVzZWQgZm9yIHdyaXRlYWJsZSBmaWVs
ZHMKPiAgICAgIC0gMTogVmhvc3QgbWFzdGVyIG1lc3NhZ2VzIHVzZWQgZm9yIGxpdmUgbWlncmF0
aW9uCj4KPiAgICA6cGF5bG9hZDogU2l6ZSBieXRlcyBhcnJheSBob2xkaW5nIHRoZSBjb250ZW50
cyBvZiB0aGUgdmlydGlvCj4gICAgICAgICAgICAgIGRldmljZSdzIGNvbmZpZ3VyYXRpb24gc3Bh
Y2UKPgo+ICAgIC4uLgo+Cj4gICAgYGBWSE9TVF9VU0VSX0dFVF9DT05GSUdgYAo+ICAgICAgOmlk
OiAyNAo+ICAgICAgOmVxdWl2YWxlbnQgaW9jdGw6IE4vQQo+ICAgICAgOm1hc3RlciBwYXlsb2Fk
OiB2aXJ0aW8gZGV2aWNlIGNvbmZpZyBzcGFjZQo+ICAgICAgOnNsYXZlIHBheWxvYWQ6IHZpcnRp
byBkZXZpY2UgY29uZmlnIHNwYWNlCj4KPiAgICAgIFdoZW4gYGBWSE9TVF9VU0VSX1BST1RPQ09M
X0ZfQ09ORklHYGAgaXMgbmVnb3RpYXRlZCwgdGhpcyBtZXNzYWdlIGlzCj4gICAgICBzdWJtaXR0
ZWQgYnkgdGhlIHZob3N0LXVzZXIgbWFzdGVyIHRvIGZldGNoIHRoZSBjb250ZW50cyBvZiB0aGUK
PiAgICAgIHZpcnRpbyBkZXZpY2UgY29uZmlndXJhdGlvbiBzcGFjZSwgdmhvc3QtdXNlciBzbGF2
ZSdzIHBheWxvYWQgc2l6ZQo+ICAgICAgTVVTVCBtYXRjaCBtYXN0ZXIncyByZXF1ZXN0LCB2aG9z
dC11c2VyIHNsYXZlIHVzZXMgemVybyBsZW5ndGggb2YKPiAgICAgIHBheWxvYWQgdG8gaW5kaWNh
dGUgYW4gZXJyb3IgdG8gdmhvc3QtdXNlciBtYXN0ZXIuIFRoZSB2aG9zdC11c2VyCj4gICAgICBt
YXN0ZXIgbWF5IGNhY2hlIHRoZSBjb250ZW50cyB0byBhdm9pZCByZXBlYXRlZAo+ICAgICAgYGBW
SE9TVF9VU0VSX0dFVF9DT05GSUdgYCBjYWxscy4KPgo+ICAgIGBgVkhPU1RfVVNFUl9TRVRfQ09O
RklHYGAKPiAgICAgIDppZDogMjUKPiAgICAgIDplcXVpdmFsZW50IGlvY3RsOiBOL0EKPiAgICAg
IDptYXN0ZXIgcGF5bG9hZDogdmlydGlvIGRldmljZSBjb25maWcgc3BhY2UKPiAgICAgIDpzbGF2
ZSBwYXlsb2FkOiBOL0EKPgo+ICAgICAgV2hlbiBgYFZIT1NUX1VTRVJfUFJPVE9DT0xfRl9DT05G
SUdgYCBpcyBuZWdvdGlhdGVkLCB0aGlzIG1lc3NhZ2UgaXMKPiAgICAgIHN1Ym1pdHRlZCBieSB0
aGUgdmhvc3QtdXNlciBtYXN0ZXIgd2hlbiB0aGUgR3Vlc3QgY2hhbmdlcyB0aGUgdmlydGlvCj4g
ICAgICBkZXZpY2UgY29uZmlndXJhdGlvbiBzcGFjZSBhbmQgYWxzbyBjYW4gYmUgdXNlZCBmb3Ig
bGl2ZSBtaWdyYXRpb24KPiAgICAgIG9uIHRoZSBkZXN0aW5hdGlvbiBob3N0LiBUaGUgdmhvc3Qt
dXNlciBzbGF2ZSBtdXN0IGNoZWNrIHRoZSBmbGFncwo+ICAgICAgZmllbGQsIGFuZCBzbGF2ZXMg
TVVTVCBOT1QgYWNjZXB0IFNFVF9DT05GSUcgZm9yIHJlYWQtb25seQo+ICAgICAgY29uZmlndXJh
dGlvbiBzcGFjZSBmaWVsZHMgdW5sZXNzIHRoZSBsaXZlIG1pZ3JhdGlvbiBiaXQgaXMgc2V0Lgo+
Cj4gU3RlZmFuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
