Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D664C47083
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 07:15:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D164E61375
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 07:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D164E61375
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A70E833A8;
	Wed,  2 Jun 2021 07:15:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 96YpJNNIxwBf; Wed,  2 Jun 2021 07:15:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E1C1833B7;
	Wed,  2 Jun 2021 07:15:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22B31C000D;
	Wed,  2 Jun 2021 07:15:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 120ABC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E7A7940232
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:15:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8vOhx6f_vUDQ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:15:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0669D401FB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622618103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lhy5TNU50fmOq5Bhp93lg/KbZ5b2aX5N5cZ4YcFgRAI=;
 b=gI761mT5PAgyv1QCVy31T/SUETWPKXFrHYP91r8MnmheU+Qv2UL66h/+uRPH5Jib8eycym
 TfwVU9WcPozqSh24weUM8CSFUYMEH7KujKDoUCk0rUcgrbPdpvduIhH8R5fM1Zq/xxlk1g
 J3dfH1721fqnSI7GFU+PdtNKcXBIsIA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-tQ7SsW1dPZqXszfm226_1Q-1; Wed, 02 Jun 2021 03:15:01 -0400
X-MC-Unique: tQ7SsW1dPZqXszfm226_1Q-1
Received: by mail-pg1-f200.google.com with SMTP id
 15-20020a630c4f0000b029021a6da9af28so1112731pgm.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Jun 2021 00:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Lhy5TNU50fmOq5Bhp93lg/KbZ5b2aX5N5cZ4YcFgRAI=;
 b=l1ynogbEB9UEFdlHxPswa297W5JQreCyNYPpm54mBYGcx+pA9hMz2wiY8rwXkBGVGF
 Em0n1YuQ31TXZDQk+b68iUr/DcFh0kfBY/VKfIBFqPjU1ACV3B7pRs6s6GeUKfHNxIN2
 UvnThAaSeryX4G6svHEdVvypF1nksZjwtxc4BGL+s9RijxqutckQRF6nc/SAuVsXRBBj
 Lo3uzMQoI2UKJ0b/bcYoOpLR10dSciXNqeH8koSfEiecKxPOadNwhzYJradr8AOUrCsN
 gzMdXojvUeSstEcfJptkdAdr8+aL4CbQM9w7IbsuxdD0RNI/ovU+3D3YLyq1RrdUi8S5
 wIdA==
X-Gm-Message-State: AOAM533UmykvWn9z29wghAdzJiTRyyX6DadHOpaKNhWe087dCYOBNbER
 AlnOFTzyr7Px5fOSHZNUik+rBgjLNVnhHWSU62ZRO4SR8h6PjQp4wWFlaMQmy5nJ+f6UjFfcF/L
 zt52232XZVQBogh0QrkYUdyT7irN6KgzSVm8oRzDQcA==
X-Received: by 2002:a63:1703:: with SMTP id x3mr15032580pgl.421.1622618100242; 
 Wed, 02 Jun 2021 00:15:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxufrPCd7Pf/XaCWAaBdiVWeER94rYldeUimhvZhIrvYw6A2cPFCPX7XVd/UFcPhoryLQJVig==
X-Received: by 2002:a63:1703:: with SMTP id x3mr15032563pgl.421.1622618100025; 
 Wed, 02 Jun 2021 00:15:00 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c134sm15028445pfb.135.2021.06.02.00.14.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 00:14:59 -0700 (PDT)
Subject: Re: [PATCH] virtio_net: Remove BUG() to aviod machine dead
To: Leon Romanovsky <leon@kernel.org>
References: <a351fbe1-0233-8515-2927-adc826a7fb94@linux.alibaba.com>
 <20210518055336-mutt-send-email-mst@kernel.org>
 <4aaf5125-ce75-c72a-4b4a-11c91cb85a72@linux.alibaba.com>
 <72f284c6-b2f5-a395-a68f-afe801eb81be@redhat.com> <YLcePtKhnt9gXq8E@unreal>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b80a2841-32aa-02ff-b2cc-f2fb3eeed9a1@redhat.com>
Date: Wed, 2 Jun 2021 15:14:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLcePtKhnt9gXq8E@unreal>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Xianting Tian <xianting.tian@linux.alibaba.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kuba@kernel.org, davem@davemloft.net
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

CuWcqCAyMDIxLzYvMiDkuIvljYgxOjU5LCBMZW9uIFJvbWFub3Zza3kg5YaZ6YGTOgo+IE9uIFR1
ZSwgTWF5IDI1LCAyMDIxIGF0IDAyOjE5OjAzUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
IOWcqCAyMDIxLzUvMTkg5LiL5Y2IMTA6MTgsIFhpYW50aW5nIFRpYW4g5YaZ6YGTOgo+Pj4gdGhh
bmtzLCBJIHN1Ym1pdCB0aGUgcGF0Y2ggYXMgY29tbWVudGVkIGJ5IEFuZHJldwo+Pj4gaHR0cHM6
Ly9sa21sLm9yZy9sa21sLzIwMjEvNS8xOC8yNTYKPj4+Cj4+PiBBY3R1YWxseSwgaWYgeG1pdF9z
a2IoKSByZXR1cm5zIGVycm9yLCBiZWxvdyBjb2RlIHdpbGwgZ2l2ZSBhIHdhcm5pbmcKPj4+IHdp
dGggZXJyb3IgY29kZS4KPj4+Cj4+PiAgwqDCoMKgwqAvKiBUcnkgdG8gdHJhbnNtaXQgKi8KPj4+
ICDCoMKgwqDCoGVyciA9IHhtaXRfc2tiKHNxLCBza2IpOwo+Pj4KPj4+ICDCoMKgwqDCoC8qIFRo
aXMgc2hvdWxkIG5vdCBoYXBwZW4hICovCj4+PiAgwqDCoMKgwqBpZiAodW5saWtlbHkoZXJyKSkg
ewo+Pj4gIMKgwqDCoMKgwqDCoMKgIGRldi0+c3RhdHMudHhfZmlmb19lcnJvcnMrKzsKPj4+ICDC
oMKgwqDCoMKgwqDCoCBpZiAobmV0X3JhdGVsaW1pdCgpKQo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZGV2X3dhcm4oJmRldi0+ZGV2LAo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICJVbmV4cGVjdGVkIFRYUSAoJWQpIHF1ZXVlIGZhaWx1cmU6ICVkXG4iLAo+Pj4gIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHFudW0sIGVycik7Cj4+PiAgwqDCoMKgwqDC
oMKgwqAgZGV2LT5zdGF0cy50eF9kcm9wcGVkKys7Cj4+PiAgwqDCoMKgwqDCoMKgwqAgZGV2X2tm
cmVlX3NrYl9hbnkoc2tiKTsKPj4+ICDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTkVUREVWX1RYX09L
Owo+Pj4gIMKgwqDCoMKgfQo+Pj4KPj4+Cj4+Pgo+Pj4KPj4+Cj4+PiDlnKggMjAyMS81LzE4IOS4
i+WNiDU6NTQsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4+Pj4gdHlwbyBpbiBzdWJqZWN0
Cj4+Pj4KPj4+PiBPbiBUdWUsIE1heSAxOCwgMjAyMSBhdCAwNTo0Njo1NlBNICswODAwLCBYaWFu
dGluZyBUaWFuIHdyb3RlOgo+Pj4+PiBXaGVuIG1ldCBlcnJvciwgd2Ugb3V0cHV0IGEgcHJpbnQg
dG8gYXZvaWQgYSBCVUcoKS4KPj4KPj4gU28geW91IGRvbid0IGV4cGxhaW4gd2h5IHlvdSBuZWVk
IHRvIHJlbW92ZSBCVUcoKS4gSSB0aGluayBpdCBkZXNlcnZlIGEKPj4gQlVHKCkuCj4gQlVHKCkg
d2lsbCBjcmFzaCB0aGUgbWFjaGluZSBhbmQgdmlydGlvX25ldCBpcyBub3Qga2VybmVsIGNvcmUK
PiBmdW5jdGlvbmFsaXR5IHRoYXQgbXVzdCBzdG9wIHRoZSBtYWNoaW5lIHRvIHByZXZlbnQgYW55
dGhpbmcgdHJ1bHkKPiBoYXJtZnVsIGFuZCBiYXNpYy4KCgpOb3RlIHRoYXQgdGhlIEJVRygpIGhl
cmUgaXMgbm90IGZvciB2aXJ0aW8tbmV0IGl0c2VsZi4gSXQgdGVsbHMgdXMgdGhhdCAKYSBidWcg
d2FzIGZvdW5kIGJ5IHZpcnRpby1uZXQuCgpUaGF0IGlzLCB0aGUgb25lIHRoYXQgcHJvZHVjZXMg
dGhlIHNrYiBoYXMgYSBidWcsIHVzdWFsbHkgaXQncyB0aGUgCm5ldHdvcmsgY29yZS4KClRoZXJl
IGNvdWxkIGFsc28gYmUgdGhlIGlzc3VlIG9mIHRoZSBwYWNrZXQgZnJvbSB1bnRydXN0ZWQgc291
cmNlIAoodXNlcnNwYWNlIGxpa2UgVEFQIG9yIHBhY2tldCBzb2NrZXQpIGJ1dCB0aGV5IHNob3Vs
ZCBiZSB2YWxpZGF0ZWQgdGhlcmUuCgpUaGFua3MKCgo+Cj4gSSB3b3VsZCBhcmd1ZSB0aGF0IGNv
ZGUgaW4gZHJpdmVycy8qIHNob3VsZG4ndCBjYWxsIEJVRygpIG1hY3JvcyBhdCBhbGwuCj4KPiBJ
ZiBpdCBpcyBpbXBvc3NpYmxlLCBkb24ndCBjaGVjayBmb3IgdGhhdCBvciBhZGQgV0FSTl9PTigp
IGFuZCByZWNvdmVyLAo+IGJ1dCBkb24ndCBjcmFzaCB3aG9sZSBzeXN0ZW0uCj4KPiBUaGFua3MK
PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
