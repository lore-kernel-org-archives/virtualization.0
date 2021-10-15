Return-Path: <SRS0=T5WV=PD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55CEC433EF
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 04:24:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C857611C3
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 04:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C857611C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB49040453;
	Fri, 15 Oct 2021 04:24:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J1B__5zhJ6P3; Fri, 15 Oct 2021 04:24:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9D38840298;
	Fri, 15 Oct 2021 04:24:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78E8FC0011;
	Fri, 15 Oct 2021 04:24:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AE1AC000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 04:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4734B83AF3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 04:24:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j_zydm6urTo8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 04:24:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D403834AE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 04:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634271888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZNhCwdAKUbCznlT06H6dwqEXij/fqHeurKPhn0fgjy8=;
 b=iBtcuAXAVwlk2MiqQ00bs6d4rRU/L6vNnTafe1GOpKR3M4YArZdRiS0Ss1FRFw8eW5Zjtu
 420N0xItYN1RaeAW7knCfwaFSxbtur0erkL87QHazOM8zIyIRwZwIhle3cCmpmD1l+wDvv
 Z2xFWe7f1Z71nomjvlVnYkUCzXi5RnU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-Yn_79RixMcKytf9dWRH8NA-1; Fri, 15 Oct 2021 00:24:44 -0400
X-MC-Unique: Yn_79RixMcKytf9dWRH8NA-1
Received: by mail-pl1-f197.google.com with SMTP id
 o6-20020a170902778600b0013c8ce59005so3357634pll.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 21:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ZNhCwdAKUbCznlT06H6dwqEXij/fqHeurKPhn0fgjy8=;
 b=b2N0YBVJXki23VjcVxB4Jyi/ec/V4o0Q61UEiluP+ddwhjlA6Fo/a0Mm+bAqq1Nzm6
 K+5vpes139pq5C5MDH0RGDC39Kz7ZxCLkR3w/hxsfrj3Pp9tWn/NeVEbFu5KPICa0oZf
 1l04DVcw4rORdu2lpaB1pbaEePDGPWsfksW+Iclb01SpQdjkjcexMx635mevpT30GfHx
 BDr8exPEmZY9ehGMG4EGKCioY869KNug7wP6EN94cwee4LQMlnHVS/+drmnS3G6cpIeU
 kY4ZVOk88Tuq4ay1WKmLJ8ZMNpXlExQ7ThhdLTta851fTt0mf6nIBW4QTPk1UgiZAjnj
 Z0xA==
X-Gm-Message-State: AOAM533EYEuSvVHftt5R1MQXr9dybtMUXkrr2DcNVyfFll8j5tOIp0G5
 BjHNOnIOyVea4Hc+ymmqPhIyQLgNMw37CrsmP9bALGOY67W3jlRXA/KKjDpu2TOUWxYgj9trObu
 17NfGFXV8bYtf5gVAhWMKN4f7ARlM1NNMN/QjjYnMLw==
X-Received: by 2002:a63:4f43:: with SMTP id p3mr7319661pgl.435.1634271883428; 
 Thu, 14 Oct 2021 21:24:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynfFcvB6LOz/U8+oOa9vKGdSD2EBIWNan+gH9EKZ7Mz49GXgsSDUYx6FbS4XvdmqfaarODzQ==
X-Received: by 2002:a63:4f43:: with SMTP id p3mr7319653pgl.435.1634271883231; 
 Thu, 14 Oct 2021 21:24:43 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id q6sm3681240pgc.1.2021.10.14.21.24.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Oct 2021 21:24:42 -0700 (PDT)
Subject: Re: [RFC PATCH v4 11/20] vhost: Route host->guest notification
 through shadow virtqueue
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20211001070603.307037-1-eperezma@redhat.com>
 <20211001070603.307037-12-eperezma@redhat.com>
 <69c4056c-4a9b-8480-80a0-2b78c9b90ffb@redhat.com>
 <CAJaqyWcQ314RN7-U1bYqCMXb+-nyhSi3ddqWv90ofFucMbveUw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8a68a144-ee7c-6e12-ebf0-e72aaa7d1e3c@redhat.com>
Date: Fri, 15 Oct 2021 12:24:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcQ314RN7-U1bYqCMXb+-nyhSi3ddqWv90ofFucMbveUw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>
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

CuWcqCAyMDIxLzEwLzE0IOS4i+WNiDExOjU4LCBFdWdlbmlvIFBlcmV6IE1hcnRpbiDlhpnpgZM6
Cj4gT24gV2VkLCBPY3QgMTMsIDIwMjEgYXQgNTo0OSBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPj4KPj4g5ZyoIDIwMjEvMTAvMSDkuIvljYgzOjA1LCBFdWdlbmlv
IFDDqXJleiDlhpnpgZM6Cj4+PiBUaGlzIHdpbGwgbWFrZSBxZW11IGF3YXJlIG9mIHRoZSBkZXZp
Y2UgdXNlZCBidWZmZXJzLCBhbGxvd2luZyBpdCB0bwo+Pj4gd3JpdGUgdGhlIGd1ZXN0IG1lbW9y
eSB3aXRoIGl0cyBjb250ZW50cyBpZiBuZWVkZWQuCj4+Pgo+Pj4gU2luY2UgdGhlIHVzZSBvZiB2
aG9zdF92aXJ0cXVldWVfc3RhcnQgY2FuIHVubWFza3MgYW5kIGRpc2NhcmQgY2FsbAo+Pj4gZXZl
bnRzLCB2aG9zdF92aXJ0cXVldWVfc3RhcnQgc2hvdWxkIGJlIG1vZGlmaWVkIGluIG9uZSBvZiB0
aGVzZSB3YXlzOgo+Pj4gKiBTcGxpdCBpbiB0d286IE9uZSBvZiB0aGVtIHVzZXMgYWxsIGxvZ2lj
IHRvIHN0YXJ0IGEgcXVldWUgd2l0aCBubwo+Pj4gICAgIHNpZGUgZWZmZWN0cyBmb3IgdGhlIGd1
ZXN0LCBhbmQgYW5vdGhlciBvbmUgdGhhIGFjdHVhbGx5IGFzc3VtZXMgdGhhdAo+Pj4gICAgIHRo
ZSBndWVzdCBoYXMganVzdCBzdGFydGVkIHRoZSBkZXZpY2UuIFZkcGEgc2hvdWxkIHVzZSBqdXN0
IHRoZQo+Pj4gICAgIGZvcm1lci4KPj4+ICogQWN0dWFsbHkgc3RvcmUgYW5kIGNoZWNrIGlmIHRo
ZSBndWVzdCBub3RpZmllciBpcyBtYXNrZWQsIGFuZCBkbyBpdAo+Pj4gICAgIGNvbmRpdGlvbmFs
bHkuCj4+PiAqIExlZnQgYXMgaXQgaXMsIGFuZCBkdXBsaWNhdGUgYWxsIHRoZSBsb2dpYyBpbiB2
aG9zdC12ZHBhLgo+Pgo+PiBCdHcsIHRoZSBsb2cgbG9va3Mgbm90IGNsZWFyLiBJIGd1ZXNzIHRo
aXMgcGF0Y2ggZ29lcyBmb3IgbWV0aG9kIDMuIElmCj4+IHllcywgd2UgbmVlZCBleHBsYWluIGl0
IGFuZCB3aHkuCj4+Cj4+IFRoYW5rcwo+Pgo+IFNvcnJ5IGFib3V0IGJlaW5nIHVuY2xlYXIuIFRo
aXMgY29tbWl0IGxvZyAoYW5kIGNvZGUpIGp1c3QgZXhwb3NlcyB0aGUKPiBwcm9ibGVtIGFuZCB0
aGUgc29sdXRpb25zIEkgY2FtZSB1cCB3aXRoIGJ1dCBkb2VzIG5vdGhpbmcgdG8gc29sdmUgaXQu
Cj4gSSdtIGFjdHVhbGx5IGdvaW5nIGZvciBtZXRob2QgMyBmb3IgdGhlIG5leHQgc2VyaWVzIGJ1
dCBJJ20gb3BlbiB0bwo+IGRvaW5nIGl0IGRpZmZlcmVudGx5LgoKClRoYXQncyBmaW5lLCBidXQg
bmVlZCB0byBkb2MgdGhhdCBtZXRob2QgMyBpcyBzb21ldGhpbmcgdGhhdCBpcyBkb25lIGluIAp0
aGUgcGF0Y2guCgpUaGFua3MKCgo+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJlejxl
cGVyZXptYUByZWRoYXQuY29tPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
