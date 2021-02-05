Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358C3C433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 18:06:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A604B64DD4
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 18:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A604B64DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CD3BB85459;
	Fri,  5 Feb 2021 18:06:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wuvs9m9BjHqw; Fri,  5 Feb 2021 18:06:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D335F871BC;
	Fri,  5 Feb 2021 18:06:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2815C08A1;
	Fri,  5 Feb 2021 18:06:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE910C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 18:06:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AC3FD86287
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 18:06:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ibXl8rRJno2
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 18:06:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 90C57862B4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 18:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612548374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FjDDzt899a+6Dw48JUOAsTP6/4I6PwMF8aJyEspxHY=;
 b=XNXh72zmWjvMIyiEHe0FLrNqr+SZvP2G5QwknqNpHc8phnmdyUeZVmdSWCxuN8K3EFhlVn
 WsLHvSX9qHS+HgZfwhfOauK7Udp3sU/5MmzVffImH2pbqEKed5GHzWUucNLjBqbz61os7t
 F7Uh6xluzwuGSpIJxCBMcCZ6BRWouak=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-BD8Lh5OoMGiX3IHZ7Z8DzQ-1; Fri, 05 Feb 2021 13:06:12 -0500
X-MC-Unique: BD8Lh5OoMGiX3IHZ7Z8DzQ-1
Received: by mail-wm1-f71.google.com with SMTP id z188so5832707wme.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Feb 2021 10:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/FjDDzt899a+6Dw48JUOAsTP6/4I6PwMF8aJyEspxHY=;
 b=md6rOnWYT91P2yBH6jrqbeWQ9g/1vhCg+b6OVlv+otC+uPS90V0/sYjHYBH722K98I
 ERrOahXxD8k4OO70nVG0OmQnHyi11UlpixOiYII7dE86VzIfl6qcOvtl0mKfOGlN1Vct
 /5inpYWQJE6fGLFP13sh0wYHpFily+L+MUjHkJMbwakP42isvIVEW7juV4lfAao3bHed
 0FXJnMbY7Cl0eEPyC0GfT5wsGTIM7qg0D75b29UiBFTWP3q6QczDK3GRx6RFQGXywO4n
 izFFyU56TpAItGtb0ZdDCOvwTHTn9WA+XOjvC/nTA9/xQHyhZXTj1sfcZM+5efhGIojJ
 LmHQ==
X-Gm-Message-State: AOAM533qLZ0wBG3yk+CUQUq0mi4KaILoSb+BeCS3wm38Rr9TZcBCpYuK
 wbbZ6HE0KaFiH4qMRKb1gufif9984DC3qjxouwWCTXf4Vy9VEMOAYDlPTSDXbgqkqKyodRVgnk7
 uMP+dbTSnkD8HAhYbUm7Br/QCJTbfYPqO5u9C2rbepw==
X-Received: by 2002:a05:600c:4c19:: with SMTP id
 d25mr1011058wmp.181.1612548370942; 
 Fri, 05 Feb 2021 10:06:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyiNK6RY5vl+1amocTZGPvTluMg/eusfL4dCCwJwbcZNca6nMHi9LeGq6BuHkyFHouH3+22Cw==
X-Received: by 2002:a05:600c:4c19:: with SMTP id
 d25mr1011043wmp.181.1612548370719; 
 Fri, 05 Feb 2021 10:06:10 -0800 (PST)
Received: from amorenoz.users.ipa.redhat.com ([94.73.56.18])
 by smtp.gmail.com with ESMTPSA id y63sm9275908wmd.21.2021.02.05.10.06.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Feb 2021 10:06:09 -0800 (PST)
Subject: Re: [PATCH iproute2-next v3 0/5] Add vdpa device management tool
To: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "dsahern@gmail.com" <dsahern@gmail.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "mst@redhat.com" <mst@redhat.com>
References: <20210122112654.9593-3-parav@nvidia.com>
 <20210202103518.3858-1-parav@nvidia.com>
 <99106d07-1730-6ed8-c847-0400be0dcd57@redhat.com>
 <1d1ff638-d498-6675-ead5-6e09213af3a8@redhat.com>
 <0017c3d7-9b04-d26c-94e2-485e4da6a778@redhat.com>
 <BY5PR12MB4322BB72FCC893EB8D4D1B30DCB29@BY5PR12MB4322.namprd12.prod.outlook.com>
From: Adrian Moreno <amorenoz@redhat.com>
Message-ID: <d056ca1c-8c7f-84ce-dc4a-0105e53c6773@redhat.com>
Date: Fri, 5 Feb 2021 19:06:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB4322BB72FCC893EB8D4D1B30DCB29@BY5PR12MB4322.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=amorenoz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAyLzUvMjEgNjo1MyBQTSwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+IAo+IAo+PiBGcm9tOiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+PiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5
IDUsIDIwMjEgOToxMSBBTQo+Pgo+Pgo+PiBPbiAyMDIxLzIvNCDkuIvljYg3OjE1LCBBZHJpYW4g
TW9yZW5vIHdyb3RlOgo+Pj4gU29ycnkgSSBoYXZlIG5vdCBmb2xsb3dlZCB0aGlzIHdvcmsgYXMg
Y2xvc2UgYXMgSSB3b3VsZCBoYXZlIHdhbnRlZC4KPj4+IFNvbWUgcXVlc3Rpb25zIGJlbG93Lgo+
Pj4KPj4+IE9uIDIvNC8yMSA0OjE2IEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+IE9uIDIwMjEv
Mi8yIOS4i+WNiDY6MzUsIFBhcmF2IFBhbmRpdCB3cm90ZToKPj4+Pj4gTGludXggdmRwYSBpbnRl
cmZhY2UgYWxsb3dzIHZkcGEgZGV2aWNlIG1hbmFnZW1lbnQgZnVuY3Rpb25hbGl0eS4KPj4+Pj4g
VGhpcyBpbmNsdWRlcyBhZGRpbmcsIHJlbW92aW5nLCBxdWVyeWluZyB2ZHBhIGRldmljZXMuCj4+
Pj4+Cj4+Pj4+IHZkcGEgaW50ZXJmYWNlIGFsc28gaW5jbHVkZXMgc2hvd2luZyBzdXBwb3J0ZWQg
bWFuYWdlbWVudCBkZXZpY2VzCj4+Pj4+IHdoaWNoIHN1cHBvcnQgc3VjaCBvcGVyYXRpb25zLgo+
Pj4+Pgo+Pj4+PiBUaGlzIHBhdGNoc2V0IGluY2x1ZGVzIGtlcm5lbCB1YXBpIGhlYWRlcnMgYW5k
IGEgdmRwYSB0b29sLgo+Pj4+Pgo+Pj4+PiBleGFtcGxlczoKPj4+Pj4KPj4+Pj4gJCB2ZHBhIG1n
bXRkZXYgc2hvdwo+Pj4+PiB2ZHBhc2ltOgo+Pj4+PiAgwqDCoCBzdXBwb3J0ZWRfY2xhc3NlcyBu
ZXQKPj4+Pj4KPj4+Pj4gJCB2ZHBhIG1nbXRkZXYgc2hvdyAtanAKPj4+Pj4gewo+Pj4+PiAgwqDC
oMKgwqAgInNob3ciOiB7Cj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgICJ2ZHBhc2ltIjogewo+Pj4+
PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJzdXBwb3J0ZWRfY2xhc3NlcyI6IFsgIm5ldCIg
XQo+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+Pj4+ICDCoMKgwqDCoCB9Cj4+Pj4+IH0KPj4+
Pj4KPj4+IEhvdyBjYW4gYSB1c2VyIGVzdGFibGlzaCB0aGUgcmVsYXRpb25zaGlwIGJldHdlZW4g
YSBtZ210ZGV2IGFuZCBpdCdzCj4+PiBwYXJlbnQgZGV2aWNlIChwY2kgdmYsIHNmLCBldGMpPwo+
Pgo+Pgo+PiBQYXJhdiBzaG91bGQga25vdyBtb3JlIGJ1dCBJIHRyeSB0byBhbnN3ZXIuCj4+Cj4+
IEkgdGhpbmsgdGhlcmUgc2hvdWxkIGJlIEJERiBpbmZvcm1hdGlvbiBpbiB0aGUgbWdtdGRldiBz
aG93IGNvbW1hbmQgaWYKPj4gdGhlIHBhcmVudCBpcyBhIFBDSSBkZXZpY2UsIG9yIHdlIGNhbiBz
aW1wbHkgc2hvdyB0aGUgcGFyZW50IGhlcmU/Cj4+Cj4gWWVzLCBpdCBpcyBwcmVzZW50IGluIHRo
ZSBtZ210ZGV2IHNob3cgY29tbWFuZC4KPiBJIHNob3VsZCBoYXZlIGFkZGVkIHRoZSBleGFtcGxl
IGZyb20gdGhlIGtlcm5lbCBjb3ZlciBsZXR0ZXIgaGVyZS4KPiBMaW5rIHRvIHRoZSBrZXJuZWwg
Y292ZXIgbGV0dGVyIGlzIGF0IAo+IAo+IEFuIGV4YW1wbGUgZm9yIHJlYWwgUENJIFBGLFZGLFNG
IGRldmljZSBsb29rcyBsaWtlIGJlbG93Lgo+IEkgd2lsbCBjb3ZlciBiZWxvdyBleGFtcGxlIHRv
IHRoZSB2NCBjb3ZlciBsZXR0ZXIgd2hpbGUgYWRkcmVzc2luZyBEYXZpZCdzIGNvbW1lbnQgZm9y
IGhlYWRlciBmaWxlIHJlbG9jYXRpb24uCj4gCj4gJCB2ZHBhIG1nbXRkZXYgbGlzdAo+IHBjaS8w
MDAwOjAzLjAwOjAKPiAgIHN1cHBvcnRlZF9jbGFzc2VzCj4gICAgIG5ldAo+IHBjaS8wMDAwOjAz
LjAwOjQKPiAgIHN1cHBvcnRlZF9jbGFzc2VzCj4gICAgIG5ldAo+IGF1eGlsaWFyeS9tbHg1X2Nv
cmUuc2YuOAo+ICAgc3VwcG9ydGVkX2NsYXNzZXMKPiAgICAgbmV0Cj4gCj4gWzFdIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDIxMDEwNTEwMzIwMy44MjUwOC0xLXBhcmF2QG52aWRp
YS5jb20vCj4gCgpUaGFua3MgUGFyYXYKCi0tIApBZHJpw6FuIE1vcmVubwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
