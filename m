Return-Path: <SRS0=fqYQ=LL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ED6C48BE5
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 03:07:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A3C613E2
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 03:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A3C613E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 112918294A;
	Thu, 17 Jun 2021 03:07:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 431wtoBpgQC5; Thu, 17 Jun 2021 03:07:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A558082897;
	Thu, 17 Jun 2021 03:07:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 708D5C000D;
	Thu, 17 Jun 2021 03:07:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B141AC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 03:07:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A910826B4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 03:07:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vqyJyNy2xnv6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 03:07:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8DA4A82549
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 03:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623899247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UMQv9oH5M2Iy204odLTWw8+glUtgOSzA8bgiiuKdmss=;
 b=JLcyxxLO3GVfNUtk8v5rK/bu/gqFY3pSrIh8qU88mukfS4mmEFapPNtdimhWSZfSyAT8O4
 8WDjAiRb4QGlsqxsqAkm6/2e+2T9zfNs8TG2G+J8MS00NwaXGTcPkALvO7HsvhGKZWG82w
 tLWuZaT999sgl0ulmRxnSsYrm4lHZnw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-G3GDvdKZPw6nusrCbljOtg-1; Wed, 16 Jun 2021 23:07:26 -0400
X-MC-Unique: G3GDvdKZPw6nusrCbljOtg-1
Received: by mail-pg1-f199.google.com with SMTP id
 z71-20020a63334a0000b029022250d765d3so2833542pgz.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 20:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=UMQv9oH5M2Iy204odLTWw8+glUtgOSzA8bgiiuKdmss=;
 b=Qaqo/J25ndaAFkxi0FU/jq4N+NbOjDz3cYbhzedEONQTCF8M+RxDr/j6UE8UrE0PTq
 nG96EJFGATWPI2WhRfjzKqR9xppizEusNx+Oho4l+s4c5fdnGYM2wP7HuVcCLHnM6uz3
 RTqZ+AjOZH9TWjLQ4z0HJlbqosqRfXE1YuoHNLcJ2Ohe+HvEvWA/LYZWtV03rtK88XxU
 FZKotJk0v3NIhsQ+4JU4FNyLKrTEgaU+CN67gakZtYsG/fghjl+Hi46WMDc10oixg/dy
 iQ3pBuXwgFPky8Ye2Fh5Y+9Y2Go07y3No30KK5F1LNzAkuMSZrxZkci3YVw3Xqsp7dbj
 +QxQ==
X-Gm-Message-State: AOAM531HMmZ2RF4BueGB5JDlGX4o5S5YEDbGnbMJ+8xTUjX2J3UTZjqL
 F7r+akzZPavnwXFkJZKkjxDd+09fOhAqPA23eOSYiWL0p9L28nilG9aUIBK8Lfm/3Dcvhx3B2+Q
 SCPBzE00ebcrSaCA3IMYRlQ/Qo7XA80Gi7xT658R5qg==
X-Received: by 2002:a63:344d:: with SMTP id b74mr2827261pga.266.1623899245813; 
 Wed, 16 Jun 2021 20:07:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzS2x+Jc2Kml1O/dOiSY0qquwtdpUMptUnjji8wtNEfdMdakI18DQJ4a92xTd3nzX5F2jAyRg==
X-Received: by 2002:a63:344d:: with SMTP id b74mr2827234pga.266.1623899245520; 
 Wed, 16 Jun 2021 20:07:25 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u38sm3514424pgm.14.2021.06.16.20.07.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 20:07:24 -0700 (PDT)
Subject: Re: [PATCH net-next v5 14/15] virtio-net: xsk direct xmit inside xsk
 wakeup
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
 <20210610082209.91487-15-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c5d955f5-6c8b-03df-9e16-56b700aa9f22@redhat.com>
Date: Thu, 17 Jun 2021 11:07:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610082209.91487-15-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "dust . li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNi8xMCDPws7nNDoyMiwgWHVhbiBaaHVvINC0tcA6Cj4gQ2FsbGluZyB2aXJ0cXVl
dWVfbmFwaV9zY2hlZHVsZSgpIGluIHdha2V1cCByZXN1bHRzIGluIG5hcGkgcnVubmluZyBvbgo+
IHRoZSBjdXJyZW50IGNwdS4gSWYgdGhlIGFwcGxpY2F0aW9uIGlzIG5vdCBidXN5LCB0aGVuIHRo
ZXJlIGlzIG5vCj4gcHJvYmxlbS4gQnV0IGlmIHRoZSBhcHBsaWNhdGlvbiBpdHNlbGYgaXMgYnVz
eSwgaXQgd2lsbCBjYXVzZSBhIGxvdCBvZgo+IHNjaGVkdWxpbmcuCj4KPiBJZiB0aGUgYXBwbGlj
YXRpb24gaXMgY29udGludW91c2x5IHNlbmRpbmcgZGF0YSBwYWNrZXRzLCBkdWUgdG8gdGhlCj4g
Y29udGludW91cyBzY2hlZHVsaW5nIGJldHdlZW4gdGhlIGFwcGxpY2F0aW9uIGFuZCBuYXBpLCB0
aGUgZGF0YSBwYWNrZXQKPiB0cmFuc21pc3Npb24gd2lsbCBub3QgYmUgc21vb3RoLCBhbmQgdGhl
cmUgd2lsbCBiZSBhbiBvYnZpb3VzIGRlbGF5IGluCj4gdGhlIHRyYW5zbWlzc2lvbiAoeW91IGNh
biB1c2UgdGNwZHVtcCB0byBzZWUgaXQpLiBXaGVuIHByZXNzaW5nIGEKPiBjaGFubmVsIHRvIDEw
MCUgKHZob3N0IHJlYWNoZXMgMTAwJSksIHRoZSBjcHUgd2hlcmUgdGhlIGFwcGxpY2F0aW9uIGlz
Cj4gbG9jYXRlZCByZWFjaGVzIDEwMCUuCj4KPiBUaGlzIHBhdGNoIHNlbmRzIGEgc21hbGwgYW1v
dW50IG9mIGRhdGEgZGlyZWN0bHkgaW4gd2FrZXVwLiBUaGUgcHVycG9zZQo+IG9mIHRoaXMgaXMg
dG8gdHJpZ2dlciB0aGUgdHggaW50ZXJydXB0LiBUaGUgdHggaW50ZXJydXB0IHdpbGwgYmUKPiBh
d2FrZW5lZCBvbiB0aGUgY3B1IG9mIGl0cyBhZmZpbml0eSwgYW5kIHRoZW4gdHJpZ2dlciB0aGUg
b3BlcmF0aW9uIG9mCj4gdGhlIG5hcGkgbWVjaGFuaXNtLCBuYXBpIGNhbiBjb250aW51ZSB0byBj
b25zdW1lIHRoZSB4c2sgdHggcXVldWUuIFR3bwo+IGNwdXMgYXJlIHJ1bm5pbmcsIGNwdTAgaXMg
cnVubmluZyBhcHBsaWNhdGlvbnMsIGNwdTEgZXhlY3V0ZXMKPiBuYXBpIGNvbnN1bXB0aW9uIGRh
dGEuIFRoZSBzYW1lIGlzIHRvIHByZXNzIGEgY2hhbm5lbCB0byAxMDAlLCBidXQgdGhlCj4gdXRp
bGl6YXRpb24gcmF0ZSBvZiBjcHUwIGlzIDEyLjclIGFuZCB0aGUgdXRpbGl6YXRpb24gcmF0ZSBv
ZiBjcHUxIGlzCj4gMi45JS4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9A
bGludXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL25ldC92aXJ0aW8veHNrLmMgfCAy
OCArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92
aXJ0aW8veHNrLmMgYi9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmMKPiBpbmRleCAzNmNkYTJkY2Y4
ZTcuLjM5NzNjODJkMWFkMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmMK
PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmMKPiBAQCAtNTQ3LDYgKzU0Nyw3IEBAIGlu
dCB2aXJ0bmV0X3hza193YWtldXAoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgdTMyIHFpZCwgdTMy
IGZsYWcpCj4gICB7Cj4gICAJc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBuZXRkZXZfcHJpdihk
ZXYpOwo+ICAgCXN0cnVjdCB4c2tfYnVmZl9wb29sICpwb29sOwo+ICsJc3RydWN0IG5ldGRldl9x
dWV1ZSAqdHhxOwo+ICAgCXN0cnVjdCBzZW5kX3F1ZXVlICpzcTsKPiAgIAo+ICAgCWlmICghbmV0
aWZfcnVubmluZyhkZXYpKQo+IEBAIC01NTksMTEgKzU2MCwyOCBAQCBpbnQgdmlydG5ldF94c2tf
d2FrZXVwKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIHUzMiBxaWQsIHUzMiBmbGFnKQo+ICAgCj4g
ICAJcmN1X3JlYWRfbG9jaygpOwo+ICAgCXBvb2wgPSByY3VfZGVyZWZlcmVuY2Uoc3EtPnhzay5w
b29sKTsKPiAtCWlmIChwb29sKSB7Cj4gLQkJbG9jYWxfYmhfZGlzYWJsZSgpOwo+IC0JCXZpcnRx
dWV1ZV9uYXBpX3NjaGVkdWxlKCZzcS0+bmFwaSwgc3EtPnZxKTsKPiAtCQlsb2NhbF9iaF9lbmFi
bGUoKTsKPiAtCX0KPiArCWlmICghcG9vbCkKPiArCQlnb3RvIGVuZDsKPiArCj4gKwlpZiAobmFw
aV9pZl9zY2hlZHVsZWRfbWFya19taXNzZWQoJnNxLT5uYXBpKSkKPiArCQlnb3RvIGVuZDsKPiAr
Cj4gKwl0eHEgPSBuZXRkZXZfZ2V0X3R4X3F1ZXVlKGRldiwgcWlkKTsKPiArCj4gKwlfX25ldGlm
X3R4X2xvY2tfYmgodHhxKTsKPiArCj4gKwkvKiBTZW5kIHBhcnQgb2YgdGhlIHBhY2tldCBkaXJl
Y3RseSB0byByZWR1Y2UgdGhlIGRlbGF5IGluIHNlbmRpbmcgdGhlCj4gKwkgKiBwYWNrZXQsIGFu
ZCB0aGlzIGNhbiBhY3RpdmVseSB0cmlnZ2VyIHRoZSB0eCBpbnRlcnJ1cHRzLgo+ICsJICoKPiAr
CSAqIElmIG5vIHBhY2tldCBpcyBzZW50IG91dCwgdGhlIHJpbmcgb2YgdGhlIGRldmljZSBpcyBm
dWxsLiBJbiB0aGlzCj4gKwkgKiBjYXNlLCB3ZSB3aWxsIHN0aWxsIGdldCBhIHR4IGludGVycnVw
dCByZXNwb25zZS4gVGhlbiB3ZSB3aWxsIGRlYWwKPiArCSAqIHdpdGggdGhlIHN1YnNlcXVlbnQg
cGFja2V0IHNlbmRpbmcgd29yay4KPiArCSAqLwo+ICsJdmlydG5ldF94c2tfcnVuKHNxLCBwb29s
LCBzcS0+bmFwaS53ZWlnaHQsIGZhbHNlKTsKCgpUaGlzIGxvb2tzIHRyaWNreSwgYW5kIGl0IHdv
bid0IGJlIGVmZmljaWVudCBzaW5jZSB0aGVyZSBjb3VsZCBiZSBzb21lIApjb250ZW50aW9uIG9u
IHRoZSB0eCBsb2NrLgoKSSB3b25kZXIgaWYgd2UgY2FuIHNpbXVsYXRlIHRoZSBpbnRlcnJ1cHQg
dmlhIElQSSBsaWtlIHdoYXQgUlBTIGRpZC4KCkluIHRoZSBsb25nIHJ1biwgd2UgbWF5IHdhbnQg
dG8gZXh0ZW5kIHRoZSBzcGVjIHRvIHN1cHBvcnQgaW50ZXJydXB0IAp0cmlnZ2VyIHRob3VnaCBk
cml2ZXIuCgpUaGFua3MKCgo+ICsKPiArCV9fbmV0aWZfdHhfdW5sb2NrX2JoKHR4cSk7Cj4gKwo+
ICtlbmQ6Cj4gICAJcmN1X3JlYWRfdW5sb2NrKCk7Cj4gICAJcmV0dXJuIDA7Cj4gICB9CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
