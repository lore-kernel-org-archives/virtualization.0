Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70782C41513
	for <virtualization@archiver.kernel.org>; Mon, 31 Jul 2023 06:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1EE8A40545;
	Mon, 31 Jul 2023 06:25:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1EE8A40545
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qy0HvXts
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4qox-aEORFee; Mon, 31 Jul 2023 06:25:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8C1674029B;
	Mon, 31 Jul 2023 06:25:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C1674029B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EB45C0071;
	Mon, 31 Jul 2023 06:25:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01BEBC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 06:25:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C2C3E60AA8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 06:25:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C2C3E60AA8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qy0HvXts
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yU0B8017f9mG
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 06:25:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E0B2460A8D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 06:25:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E0B2460A8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690784729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AMHoeLetncmOF6knuHXAEkwDxdPPKbLQBWKiqJmYdTc=;
 b=Qy0HvXts3HJR7yhGeGHSUlxT+1149bOW+MjEDmqC0ivND7dEnyBaa8PE1CSjr3LW9YdTbP
 0NeTZtfSOg1P5ZQkZCN0EunnX5XwOZUuordRwxR0+Qd5kb+y2ot2RoRnSuDOvaqSPv/3I/
 OrDCBORHpoO4ySfnWohi3MMKtSprlGI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-KNaZwE6hN3iKXH5OfkxO4g-1; Mon, 31 Jul 2023 02:25:26 -0400
X-MC-Unique: KNaZwE6hN3iKXH5OfkxO4g-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5637a108d02so2603910a12.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jul 2023 23:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690784725; x=1691389525;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AMHoeLetncmOF6knuHXAEkwDxdPPKbLQBWKiqJmYdTc=;
 b=QTQLdTnw2A4aEO5zltIBWnOfv/UsByEy9Wm8QujLDgosEImQW2HOxP/foD39YHv7mY
 OBODTW/zMIUqe90v0nwz/aDU9wWhic1mldlFfIFOkdz/91PBjlp/ktowr+Vhyw0Dqm1n
 EUXXXgKVb2b7UPYHvP++V07JDD0amikTJPq695sW84eYQ3mk2QKWk20pYD4K3AtKnizx
 Wnxcw1Zxs1lvHwnofdgfbuagvKKImLszb/DZyLlwYK9gSGwQJoltJnQcssboN5/brAXD
 YMUQvl/nGoAoRI+koeYUic9xXf3ukvpDejAJ8XPlN/UXwrH5gZ+T0FVYTvKBdPnL11fx
 ojKg==
X-Gm-Message-State: ABy/qLbyN0Xqoz35IC63KOXMxMVoeNziqXAGEASilcN689tyE6sC8iuy
 /+vnTWSezJC1A5tmUsOczKtDnxCxqPsPEjChHOyo1tRIH3ScrkvS4eZn7FBLauELeoLCMqTweIx
 W/uUsJEf1Ae2R4CM9M+57AA/tK1Cuc8L6/IZ3Ey6yQw==
X-Received: by 2002:a05:6a20:1614:b0:13a:12c2:359e with SMTP id
 l20-20020a056a20161400b0013a12c2359emr9170169pzj.2.1690784725062; 
 Sun, 30 Jul 2023 23:25:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFhdNonBuhx20H74nszcdmRPVMO19vB0iyTVH6P4jjKCSyrny8LhZooWAfIJTGU+TRmQj5JDQ==
X-Received: by 2002:a05:6a20:1614:b0:13a:12c2:359e with SMTP id
 l20-20020a056a20161400b0013a12c2359emr9170152pzj.2.1690784724776; 
 Sun, 30 Jul 2023 23:25:24 -0700 (PDT)
Received: from [10.72.112.185] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 x25-20020a056a00271900b00653fe2d527esm6799503pfv.32.2023.07.30.23.25.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jul 2023 23:25:24 -0700 (PDT)
Message-ID: <fd3457bc-b16a-680a-0bed-80cc8505a4cc@redhat.com>
Date: Mon, 31 Jul 2023 14:25:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next V4 2/3] virtio_net: support per queue interrupt
 coalesce command
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>
References: <20230725130709.58207-1-gavinl@nvidia.com>
 <20230725130709.58207-3-gavinl@nvidia.com>
 <f5823996fffad2f3c1862917772c182df74c74e7.camel@redhat.com>
 <20230728014601-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230728014601-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org, hawk@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, john.fastabend@gmail.com,
 ast@kernel.org, gavi@nvidia.com, edumazet@google.com,
 Heng Qi <hengqi@linux.alibaba.com>, jiri@nvidia.com, kuba@kernel.org,
 bpf@vger.kernel.org, virtualization@lists.linux-foundation.org,
 davem@davemloft.net, Gavin Li <gavinl@nvidia.com>
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

CuWcqCAyMDIzLzcvMjggMTM6NDYsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gT24gVGh1
LCBKdWwgMjcsIDIwMjMgYXQgMDM6Mjg6MzJQTSArMDIwMCwgUGFvbG8gQWJlbmkgd3JvdGU6Cj4+
IE9uIFR1ZSwgMjAyMy0wNy0yNSBhdCAxNjowNyArMDMwMCwgR2F2aW4gTGkgd3JvdGU6Cj4+PiBB
ZGQgaW50ZXJydXB0X2NvYWxlc2NlIGNvbmZpZyBpbiBzZW5kX3F1ZXVlIGFuZCByZWNlaXZlX3F1
ZXVlIHRvIGNhY2hlIHVzZXIKPj4+IGNvbmZpZy4KPj4+Cj4+PiBTZW5kIHBlciB2aXJ0cXVldWUg
aW50ZXJydXB0IG1vZGVyYXRpb24gY29uZmlnIHRvIHVuZGVybHlpbmcgZGV2aWNlIGluCj4+PiBv
cmRlciB0byBoYXZlIG1vcmUgZWZmaWNpZW50IGludGVycnVwdCBtb2RlcmF0aW9uIGFuZCBjcHUg
dXRpbGl6YXRpb24gb2YKPj4+IGd1ZXN0IFZNLgo+Pj4KPj4+IEFkZGl0aW9uYWxseSwgYWRkcmVz
cyBhbGwgdGhlIFZRcyB3aGVuIHVwZGF0aW5nIHRoZSBnbG9iYWwgY29uZmlndXJhdGlvbiwKPj4+
IGFzIG5vdyB0aGUgaW5kaXZpZHVhbCBWUXMgY29uZmlndXJhdGlvbiBjYW4gZGl2ZXJnZSBmcm9t
IHRoZSBnbG9iYWwKPj4+IGNvbmZpZ3VyYXRpb24uCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogR2F2
aW4gTGkgPGdhdmlubEBudmlkaWEuY29tPgo+Pj4gUmV2aWV3ZWQtYnk6IERyYWdvcyBUYXR1bGVh
IDxkdGF0dWxlYUBudmlkaWEuY29tPgo+Pj4gUmV2aWV3ZWQtYnk6IEppcmkgUGlya28gPGppcmlA
bnZpZGlhLmNvbT4KPj4+IEFja2VkLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQu
Y29tPgo+PiBGVFIsIHRoaXMgcGF0Y2ggaXMgc2lnbmlmaWNhbnRseSBkaWZmZXJlbnQgZnJvbSB0
aGUgdmVyc2lvbiBwcmV2aW91c2x5Cj4+IGFja2VkL3Jldmlld2VkLCBJJ20gdW5zdXJlIGlmIGFs
bCB0aGUgcmV2aWV3ZXJzIGFyZSBvayB3aXRoIHRoZSBuZXcKPj4gb25lLgo+Pgo+PiBbLi4uXQo+
IHN0aWxsIG9rIGJ5IG1lCj4KPiBBY2tlZC1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVk
aGF0LmNvbT4KPgo+IGxldCdzIHdhaXQgZm9yIEphc29uIHRvby4KCgpJJ20gZmluZSB3aXRoIHRo
aXMgc2VyaWVzIChJJ3ZlIGFja2VkIGVhY2ggcGF0Y2gpLgoKVGhhbmtzCgoKPgo+Pj4gICBzdGF0
aWMgaW50IHZpcnRuZXRfc2V0X2NvYWxlc2NlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4+PiAg
IAkJCQlzdHJ1Y3QgZXRodG9vbF9jb2FsZXNjZSAqZWMsCj4+PiAgIAkJCQlzdHJ1Y3Qga2VybmVs
X2V0aHRvb2xfY29hbGVzY2UgKmtlcm5lbF9jb2FsLAo+Pj4gICAJCQkJc3RydWN0IG5ldGxpbmtf
ZXh0X2FjayAqZXh0YWNrKQo+Pj4gICB7Cj4+PiAgIAlzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9
IG5ldGRldl9wcml2KGRldik7Cj4+PiAtCWludCByZXQsIGksIG5hcGlfd2VpZ2h0Owo+Pj4gKwlp
bnQgcmV0LCBxdWV1ZV9udW1iZXIsIG5hcGlfd2VpZ2h0Owo+Pj4gICAJYm9vbCB1cGRhdGVfbmFw
aSA9IGZhbHNlOwo+Pj4gICAKPj4+ICAgCS8qIENhbid0IGNoYW5nZSBOQVBJIHdlaWdodCBpZiB0
aGUgbGluayBpcyB1cCAqLwo+Pj4gICAJbmFwaV93ZWlnaHQgPSBlYy0+dHhfbWF4X2NvYWxlc2Nl
ZF9mcmFtZXMgPyBOQVBJX1BPTExfV0VJR0hUIDogMDsKPj4+IC0JaWYgKG5hcGlfd2VpZ2h0IF4g
dmktPnNxWzBdLm5hcGkud2VpZ2h0KSB7Cj4+PiAtCQlpZiAoZGV2LT5mbGFncyAmIElGRl9VUCkK
Pj4+IC0JCQlyZXR1cm4gLUVCVVNZOwo+Pj4gLQkJZWxzZQo+Pj4gLQkJCXVwZGF0ZV9uYXBpID0g
dHJ1ZTsKPj4+ICsJZm9yIChxdWV1ZV9udW1iZXIgPSAwOyBxdWV1ZV9udW1iZXIgPCB2aS0+bWF4
X3F1ZXVlX3BhaXJzOyBxdWV1ZV9udW1iZXIrKykgewo+Pj4gKwkJcmV0ID0gdmlydG5ldF9zaG91
bGRfdXBkYXRlX3ZxX3dlaWdodChkZXYtPmZsYWdzLCBuYXBpX3dlaWdodCwKPj4+ICsJCQkJCQkg
ICAgICB2aS0+c3FbcXVldWVfbnVtYmVyXS5uYXBpLndlaWdodCwKPj4+ICsJCQkJCQkgICAgICAm
dXBkYXRlX25hcGkpOwo+Pj4gKwkJaWYgKHJldCkKPj4+ICsJCQlyZXR1cm4gcmV0Owo+Pj4gKwo+
Pj4gKwkJaWYgKHVwZGF0ZV9uYXBpKSB7Cj4+PiArCQkJLyogQWxsIHF1ZXVlcyB0aGF0IGJlbG9u
ZyB0byBbcXVldWVfbnVtYmVyLCBxdWV1ZV9jb3VudF0gd2lsbCBiZQo+Pj4gKwkJCSAqIHVwZGF0
ZWQgZm9yIHRoZSBzYWtlIG9mIHNpbXBsaWNpdHksIHdoaWNoIG1pZ2h0IG5vdCBiZSBuZWNlc3Nh
cnkKPj4gSXQgbG9va3MgbGlrZSB0aGUgY29tbWVudCBhYm92ZSBzdGlsbCByZWZlcnMgdG8gdGhl
IG9sZCBjb2RlLiBTaG91bGQKPj4gYmU6Cj4+IAlbcXVldWVfbnVtYmVyLCB2aS0+bWF4X3F1ZXVl
X3BhaXJzXQo+PiAJCQkKPj4gT3RoZXJ3aXNlIExHVE0sIHRoYW5rcyEKPj4KPj4gUGFvbG8KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
