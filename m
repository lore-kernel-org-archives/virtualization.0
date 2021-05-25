Return-Path: <SRS0=1MDK=KU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57D2C2B9F8
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 06:19:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5673A61409
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 06:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5673A61409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F98C607BC;
	Tue, 25 May 2021 06:19:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NlsWqKesP6ah; Tue, 25 May 2021 06:19:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 973006063D;
	Tue, 25 May 2021 06:19:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75376C000D;
	Tue, 25 May 2021 06:19:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A0FAC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 06:19:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 51D7E606B4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 06:19:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d_-DHUFcg2U5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 06:19:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5733F6063D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 06:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621923555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rP1fweoyRJtr6Mi6XlE6lVpYI+0VMhwzNpbtJBa3S1E=;
 b=beNpEusYOZaCFFdR6igcbT/i/IJGR0Kl3uQl82bcQshVBJXcQh7eJndtnC0mqMLchbP7rw
 oF9NGM1yX8X3xkCRoO+xq0RHZfUkwAj1dvuEamNeKHcO6ei+QogxuOmUCR8D6EbfZMlhSM
 F7xkqo35LJGMNka6ES5CcXqjP6ujyQg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-Fb-YPJOjOYuortiO4nMPdw-1; Tue, 25 May 2021 02:19:12 -0400
X-MC-Unique: Fb-YPJOjOYuortiO4nMPdw-1
Received: by mail-pj1-f70.google.com with SMTP id
 cv23-20020a17090afd17b029015cdd292fe8so15553979pjb.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 23:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=rP1fweoyRJtr6Mi6XlE6lVpYI+0VMhwzNpbtJBa3S1E=;
 b=btuHlDMFOw4fDoH4v1R35ZN8acoQ/rOvblgYdhuHJDa6Ykj3FIouQCxDHGN5phusjy
 q5PLBrNtY3pKfrvxdmSilPliAP3dCTGG7KPdTiZyJHGjNH/9m5HxpiSj3RIJvygEvNEi
 C1KfAKhav4p7o9Apj/uxliqSrIVMwXU5xB9CMzJXGkoUU5p0H0fkMPIky5BnZLtej2S3
 2LVvuMg8uO8EKdfE5GSVyNrZXn6ZoHWTuQBhg+wU7Kr3wv+hdIV5xRT5YXRymA6HexWY
 LsfJVozoMbe0FbWyJBERtn256I5np79SF6FtzFjmUtPxS+ZymeYprwlLINILFLjJnZpZ
 lhdg==
X-Gm-Message-State: AOAM532mk7YZikiA/jQLaPKeHL+R8zoAjM/ajWe8+E9zExfJ+Owou86s
 9HlXpeYgY5RhbH+/GLSaUqfzwrtq0o9/mBZJKkjHhR8V/AdHOD6tsG8XluSEoCavbO1Qmqbcv+j
 Q4jicEH79UvQn7jOJr2EZQToCdd8Vep+uYwB2R5GxzQ==
X-Received: by 2002:a17:90a:3988:: with SMTP id
 z8mr29530497pjb.175.1621923551449; 
 Mon, 24 May 2021 23:19:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHuSGZNZRBpr7BFjN2z2DGgUtoW4OBh5VlH3j5+cXLDOpjFD+S6KAYt8UK28l5a4+wF9lImw==
X-Received: by 2002:a17:90a:3988:: with SMTP id
 z8mr29530464pjb.175.1621923551060; 
 Mon, 24 May 2021 23:19:11 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id r13sm12449973pfl.191.2021.05.24.23.19.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 May 2021 23:19:10 -0700 (PDT)
Subject: Re: [PATCH] virtio_net: Remove BUG() to aviod machine dead
To: Xianting Tian <xianting.tian@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <a351fbe1-0233-8515-2927-adc826a7fb94@linux.alibaba.com>
 <20210518055336-mutt-send-email-mst@kernel.org>
 <4aaf5125-ce75-c72a-4b4a-11c91cb85a72@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <72f284c6-b2f5-a395-a68f-afe801eb81be@redhat.com>
Date: Tue, 25 May 2021 14:19:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <4aaf5125-ce75-c72a-4b4a-11c91cb85a72@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kuba@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIxLzUvMTkg5LiL5Y2IMTA6MTgsIFhpYW50aW5nIFRpYW4g5YaZ6YGTOgo+IHRoYW5r
cywgSSBzdWJtaXQgdGhlIHBhdGNoIGFzIGNvbW1lbnRlZCBieSBBbmRyZXcgCj4gaHR0cHM6Ly9s
a21sLm9yZy9sa21sLzIwMjEvNS8xOC8yNTYKPgo+IEFjdHVhbGx5LCBpZiB4bWl0X3NrYigpIHJl
dHVybnMgZXJyb3IsIGJlbG93IGNvZGUgd2lsbCBnaXZlIGEgd2FybmluZyAKPiB3aXRoIGVycm9y
IGNvZGUuCj4KPiDCoMKgwqDCoC8qIFRyeSB0byB0cmFuc21pdCAqLwo+IMKgwqDCoMKgZXJyID0g
eG1pdF9za2Ioc3EsIHNrYik7Cj4KPiDCoMKgwqDCoC8qIFRoaXMgc2hvdWxkIG5vdCBoYXBwZW4h
ICovCj4gwqDCoMKgwqBpZiAodW5saWtlbHkoZXJyKSkgewo+IMKgwqDCoMKgwqDCoMKgIGRldi0+
c3RhdHMudHhfZmlmb19lcnJvcnMrKzsKPiDCoMKgwqDCoMKgwqDCoCBpZiAobmV0X3JhdGVsaW1p
dCgpKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X3dhcm4oJmRldi0+ZGV2LAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJVbmV4cGVjdGVkIFRYUSAoJWQpIHF1ZXVlIGZh
aWx1cmU6ICVkXG4iLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHFudW0sIGVy
cik7Cj4gwqDCoMKgwqDCoMKgwqAgZGV2LT5zdGF0cy50eF9kcm9wcGVkKys7Cj4gwqDCoMKgwqDC
oMKgwqAgZGV2X2tmcmVlX3NrYl9hbnkoc2tiKTsKPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTkVU
REVWX1RYX09LOwo+IMKgwqDCoMKgfQo+Cj4KPgo+Cj4KPiDlnKggMjAyMS81LzE4IOS4i+WNiDU6
NTQsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4+IHR5cG8gaW4gc3ViamVjdAo+Pgo+PiBP
biBUdWUsIE1heSAxOCwgMjAyMSBhdCAwNTo0Njo1NlBNICswODAwLCBYaWFudGluZyBUaWFuIHdy
b3RlOgo+Pj4gV2hlbiBtZXQgZXJyb3IsIHdlIG91dHB1dCBhIHByaW50IHRvIGF2b2lkIGEgQlVH
KCkuCgoKU28geW91IGRvbid0IGV4cGxhaW4gd2h5IHlvdSBuZWVkIHRvIHJlbW92ZSBCVUcoKS4g
SSB0aGluayBpdCBkZXNlcnZlIGEgCkJVRygpLgoKCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogWGlh
bnRpbmcgVGlhbiA8eGlhbnRpbmcudGlhbkBsaW51eC5hbGliYWJhLmNvbT4KPj4+IC0tLQo+Pj4g
wqAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgNSArKy0tLQo+Pj4gwqAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+PiBp
bmRleCBjOTIxZWJmM2FlODIuLmE2NjE3NGQxM2U4MSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+Pj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+PiBA
QCAtMTY0Nyw5ICsxNjQ3LDggQEAgc3RhdGljIGludCB4bWl0X3NrYihzdHJ1Y3Qgc2VuZF9xdWV1
ZSAqc3EsIHN0cnVjdAo+Pj4gc2tfYnVmZiAqc2tiKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGhk
ciA9IHNrYl92bmV0X2hkcihza2IpOwo+Pj4KPj4+IMKgwqDCoMKgwqAgaWYgKHZpcnRpb19uZXRf
aGRyX2Zyb21fc2tiKHNrYiwgJmhkci0+aGRyLAo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHZpcnRpb19pc19saXR0bGVfZW5kaWFuKHZpLT52ZGV2KSwgZmFsc2Us
Cj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMCkpCj4+PiAtwqDC
oMKgwqDCoMKgwqAgQlVHKCk7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZp
cnRpb19pc19saXR0bGVfZW5kaWFuKHZpLT52ZGV2KSwgZmFsc2UsIDApKQo+Pj4gK8KgwqDCoMKg
wqDCoMKgIHJldHVybiAtRVBST1RPOwo+Pj4KPj4KPj4gd2h5IEVQUk9UTz8gY2FuIHlvdSBhZGQg
c29tZSBjb21tZW50cyB0byBleHBsYWluIHdoYXQgaXMgZ29pbmcgb24gcGxzPwo+Pgo+PiBpcyB0
aGlzIHJlbGF0ZWQgdG8gYSBtYWxpY2lvdXMgaHlwZXJ2aXNvciB0aGluZz8KCgpJIHRoaW5rIG5v
dCBpZiBJIHdhcyBub3Qgd3JvbmcuCgpFYWNoIHNvdXJjZXMgKGVpdGhlciB1c2Vyc3BhY2Ugb3Ig
ZGV2aWNlKSwgdGhlIHNrYiBzaG91bGQgYmUgYnVpbHQgCnRocm91Z2ggdmlydGlvX25ldF9oZHJf
dG9fc2tiKCkgd2hpY2ggbWVhbnMgdGhlIHZhbGlkYXRpb24gaGFzIGFscmVhZHkgCmJlZW4gZG9u
ZS4KCklmIHdlIGl0IGZhaWxzIGhlcmUsIGl0J3MgYSByZWFsIGJ1Zy4KClRoYW5rcwoKCj4+Cj4+
IGRvbid0IHdlIHdhbnQgYXQgbGVhc3QgYSBXQVJOX09OPyBPciBfT05DRT8KPj4KPj4+IMKgwqDC
oMKgwqAgaWYgKHZpLT5tZXJnZWFibGVfcnhfYnVmcykKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBo
ZHItPm51bV9idWZmZXJzID0gMDsKPj4+IC0tIAo+Pj4gMi4xNy4xCj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
