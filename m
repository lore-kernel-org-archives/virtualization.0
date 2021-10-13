Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62735C433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 05:34:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E734D60FDA
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 05:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E734D60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9B52D401E5;
	Wed, 13 Oct 2021 05:34:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fmJHoXsEh_S8; Wed, 13 Oct 2021 05:34:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1165F40119;
	Wed, 13 Oct 2021 05:34:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7793C0011;
	Wed, 13 Oct 2021 05:34:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBAC1C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 05:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A169A60623
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 05:34:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OrqIKlGz7ePH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 05:34:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9FD4060653
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 05:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634103275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WtrlVoKuLfOYKsehm561O/XQVc6V0dbs6gDvvYnszE8=;
 b=NYG1UyXBYAcxliDGDm94KQrtO5uK9/CAlISbj6LNiMK8qp6DziD17YfIr7qyJiPyWmEFtQ
 hKpjA0ySFsRvyHihSm3IBLVCPzL+Erc/f2wxi5JOSv7ZzOqaNXQ07xwYZolu9IXmE13MXN
 2UhIGeZGiJmRVd3s30RYW4AZfcN58sQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287--GBfk5r5P_GvYV4iqorD3w-1; Wed, 13 Oct 2021 01:34:34 -0400
X-MC-Unique: -GBfk5r5P_GvYV4iqorD3w-1
Received: by mail-pf1-f200.google.com with SMTP id
 3-20020a620603000000b0042aea40c2ddso926760pfg.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 22:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=WtrlVoKuLfOYKsehm561O/XQVc6V0dbs6gDvvYnszE8=;
 b=aTLX5Br+GunYT8Bnt85vAvkmUVix9Bkzwc2BQ2lyLZujufGSCw5+DDDea6Mp+C3jDh
 nIlJYbRE62F701/+ExOlckAZd+XqRgDhZGltRS9XH6FJy1hzOfvuF0IqiSvEBO4i1vQr
 JhnyIx+2yPWgpx/nbU5t/cBro9LzRX/sSWn1lwGOjcdGiZauQJB0EoYUai6oBCOYATv8
 g8LPlqo4jVy3IysRJIYM77EktMXyTn05YNEZNdAls37ckOS6CjPQ2c2WPRV3EWKhZNvt
 kh/t5iwh3CYRdjCH42nvPg5B4+emOSddUqb7XcrtcboU5M3Rba1LUVgKgRQ0EUUpWrpV
 T0sQ==
X-Gm-Message-State: AOAM533dPT/CNQB4gEMMQsXfGc8pKVnm8yr5o6MUhKczQO7ulpu1AAve
 OvhRwyLoyORYI5XATqSbhakKj5GaZ2CzoI0Px+jtTtnnQOogHxoI6ZdM9QR8pCK0vMCGp40wF/z
 Vr9xXtmJtyZ9aPdatpsVWpN6yxFJii/2gsWTsl7hETQ==
X-Received: by 2002:a17:90a:8b82:: with SMTP id
 z2mr10977224pjn.216.1634103273005; 
 Tue, 12 Oct 2021 22:34:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHf8rcqcR4Ua0QADtIf4MOVkKSeYHcO3YHVjN5ZW38uP45MMYzjDvCLUgIciPTQ71i8oVxng==
X-Received: by 2002:a17:90a:8b82:: with SMTP id
 z2mr10977200pjn.216.1634103272757; 
 Tue, 12 Oct 2021 22:34:32 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u2sm12401401pfi.120.2021.10.12.22.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Oct 2021 22:34:32 -0700 (PDT)
Subject: Re: [RFC PATCH v4 20/20] vdpa: Add custom IOTLB translations to SVQ
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20211001070603.307037-1-eperezma@redhat.com>
 <20211001070603.307037-21-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d5f837ec-7b89-2e47-fcfb-680ee808f6ad@redhat.com>
Date: Wed, 13 Oct 2021 13:34:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211001070603.307037-21-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 virtualization@lists.linux-foundation.org,
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

CuWcqCAyMDIxLzEwLzEg5LiL5Y2IMzowNiwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFVzZSB0
cmFuc2xhdGlvbnMgYWRkZWQgaW4gVmhvc3RJT1ZBVHJlZSBpbiBTVlEuCj4KPiBOb3cgZXZlcnkg
ZWxlbWVudCBuZWVkcyB0byBzdG9yZSB0aGUgcHJldmlvdXMgYWRkcmVzcyBhbHNvLCBzbyBWaXJ0
UXVldWUKPiBjYW4gY29uc3VtZSB0aGUgZWxlbWVudHMgcHJvcGVybHkuIFRoaXMgYWRkcyBhIGxp
dHRsZSBvdmVyaGVhZCBwZXIgVlEKPiBlbGVtZW50LCBoYXZpbmcgdG8gYWxsb2NhdGUgbW9yZSBt
ZW1vcnkgdG8gc3Rhc2ggdGhlbS4gQXMgYSBwb3NzaWJsZQo+IG9wdGltaXphdGlvbiwgdGhpcyBh
bGxvY2F0aW9uIGNvdWxkIGJlIGF2b2lkZWQgaWYgdGhlIGRlc2NyaXB0b3IgaXMgbm90Cj4gYSBj
aGFpbiBidXQgYSBzaW5nbGUgb25lLCBidXQgdGhpcyBpcyBsZWZ0IHVuZG9uZS4KPgo+IFRPRE86
IGlvdmEgcmFuZ2Ugc2hvdWxkIGJlIHF1ZXJpZWQgYmVmb3JlLCBhbmQgYWRkIGxvZ2ljIHRvIGZh
aWwgd2hlbgo+IEdQQSBpcyBvdXRzaWRlIG9mIGl0cyByYW5nZSBhbmQgbWVtb3J5IGxpc3RlbmVy
IG9yIHN2cSBhZGQgaXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJlejxlcGVyZXpt
YUByZWRoYXQuY29tPgo+IC0tLQo+ICAgaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUu
aCB8ICAgNCArLQo+ICAgaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYyB8IDEzMCAr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLQo+ICAgaHcvdmlydGlvL3Zob3N0LXZkcGEuYyAg
ICAgICAgICAgICB8ICA0MCArKysrKysrKy0KPiAgIGh3L3ZpcnRpby90cmFjZS1ldmVudHMgICAg
ICAgICAgICAgfCAgIDEgKwo+ICAgNCBmaWxlcyBjaGFuZ2VkLCAxNTIgaW5zZXJ0aW9ucygrKSwg
MjMgZGVsZXRpb25zKC0pCgoKVGhpbmsgaGFyZCBhYm91dCB0aGUgd2hvbGUgbG9naWMuIFRoaXMg
aXMgc2FmZSBzaW5jZSBxZW11IG1lbW9yeSBtYXAgCndpbGwgZmFpbCBpZiBndWVzdCBzdWJtaXRz
IGEgaW52YWxpZGF0ZSBJT1ZBLgoKVGhlbiBJIHdvbmRlciBpZiB3ZSBkbyBzb21ldGhpbmcgbXVj
aCBtb3JlIHNpbXBsZXI6CgoxKSBVc2luZyBxZW11IFZBIGFzIElPVkEgYnV0IG9ubHkgbWFwcyB0
aGUgVkEgdGhhdCBiZWxvbmdzIHRvIGd1ZXN0CjIpIFRoZW4gd2UgZG9uJ3QgbmVlZCBhbnkgSU9W
QSB0cmVlIGhlcmUsIHdoYXQgd2UgbmVlZCBpcyB0byBqdXN0IG1hcCAKdnJpbmcgYW5kIHVzZSBx
ZW11IFZBIHdpdGhvdXQgYW55IHRyYW5zbGF0aW9uCgpUaGFua3MKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
