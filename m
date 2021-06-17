Return-Path: <SRS0=fqYQ=LL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2CCC2B9F4
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 06:01:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096F06100A
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 06:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096F06100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D99CE60778;
	Thu, 17 Jun 2021 06:01:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p3FpjvWkxCHQ; Thu, 17 Jun 2021 06:01:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7AAF960765;
	Thu, 17 Jun 2021 06:01:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F1E4C000D;
	Thu, 17 Jun 2021 06:01:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C33FC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3DCB86076D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:01:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id phBZzZf7QihA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:01:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 718F360765
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623909713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zeqlgzOeyLHlVfCtn0FqLKQsQgrLb4eS0/o16mmkHIk=;
 b=Dyh9lOuBymrd5Bx6YC0yyQ/EpnMbD+Zm+ktp+x4sehC7JY3sfbGBVBGsjLFKia//xuopE0
 4X/sWS7jnKqmcRIUZMlZCdDrkJnAlqaBwHCZhVXabUntW6wuvAHfamR4MEvjduUD8NwD2u
 JrLt1hmvuwV0a9gF9LfZoFVoaJlp6F0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-T8oRZoYSOQmVqM28zeDLDw-1; Thu, 17 Jun 2021 02:01:51 -0400
X-MC-Unique: T8oRZoYSOQmVqM28zeDLDw-1
Received: by mail-pj1-f71.google.com with SMTP id
 g1-20020a17090a3c81b029016e08b01199so5468629pjc.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 23:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=zeqlgzOeyLHlVfCtn0FqLKQsQgrLb4eS0/o16mmkHIk=;
 b=EXUUlUm7NaZ9YcpGHhtiHqB+5ffQOD8/H9ojWmhSf6d6CDJHZEkwcYNTyKqQmYAS5B
 JaXy9AKAFQSmvpNwvz6EiYSUSAn1tY6bejH1jYi2QVojRMpJjhxBccsGQTNTxRFKQG/I
 xRENkmTk7Obdt2//bBJCQEFO1rUOZbzM0Jp6tOMidAoMdeTgERmYjU8CaffToDdeJ7H9
 j+xq1n0zd+lOFR+uzUiJvIVUtuslsQHtGOWs5csCFzIl1j66TuRvK4qbjlx+qj3lPIMU
 +CkoD1ej+W/qMXH9StP3H64kW/mXRSU/zMdBmwPrANso6yf2k2tRZKvrIIdq3eK5Kp8v
 BsYg==
X-Gm-Message-State: AOAM530xpcAJq4owFWl1SeiAbeE1nJMHZZejD5hrfm9j7Xg4mUOeheZk
 wyRDuB5WVOsRzrEZboxBgeLCzJh5hmMT+CfhMAsNzWabD/i/Bd3C7JCcMyfKHp8mEftp6hnCayj
 eI9A4o8z+yEV/BF92ucCsVrJ7rHX/12UoOhFDjty5aw==
X-Received: by 2002:a63:ce07:: with SMTP id y7mr3428177pgf.249.1623909710019; 
 Wed, 16 Jun 2021 23:01:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCbt3koOSCSoPCxeKahYUVTaehdFD8TluMS6k/bbR0i7dh8yWIpiWdNXvdky6YrOTUyk7Wsw==
X-Received: by 2002:a63:ce07:: with SMTP id y7mr3428160pgf.249.1623909709764; 
 Wed, 16 Jun 2021 23:01:49 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id n11sm3800958pfu.29.2021.06.16.23.01.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 23:01:49 -0700 (PDT)
Subject: Re: [PATCH net-next v5 14/15] virtio-net: xsk direct xmit inside xsk
 wakeup
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1623909331.6403847-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e606f6aa-5aba-0d47-8cc1-616cfead0faf@redhat.com>
Date: Thu, 17 Jun 2021 14:01:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623909331.6403847-2-xuanzhuo@linux.alibaba.com>
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
 netdev@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "dust.li" <dust.li@linux.alibaba.com>,
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzYvMTcg5LiL5Y2IMTo1NSwgWHVhbiBaaHVvIOWGmemBkzoKPiBPbiBUaHUsIDE3
IEp1biAyMDIxIDExOjA3OjE3ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PiB3cm90ZToKPj4g5ZyoIDIwMjEvNi8xMCDkuIvljYg0OjIyLCBYdWFuIFpodW8g5YaZ6YGTOgo+
Pj4gQ2FsbGluZyB2aXJ0cXVldWVfbmFwaV9zY2hlZHVsZSgpIGluIHdha2V1cCByZXN1bHRzIGlu
IG5hcGkgcnVubmluZyBvbgo+Pj4gdGhlIGN1cnJlbnQgY3B1LiBJZiB0aGUgYXBwbGljYXRpb24g
aXMgbm90IGJ1c3ksIHRoZW4gdGhlcmUgaXMgbm8KPj4+IHByb2JsZW0uIEJ1dCBpZiB0aGUgYXBw
bGljYXRpb24gaXRzZWxmIGlzIGJ1c3ksIGl0IHdpbGwgY2F1c2UgYSBsb3Qgb2YKPj4+IHNjaGVk
dWxpbmcuCj4+Pgo+Pj4gSWYgdGhlIGFwcGxpY2F0aW9uIGlzIGNvbnRpbnVvdXNseSBzZW5kaW5n
IGRhdGEgcGFja2V0cywgZHVlIHRvIHRoZQo+Pj4gY29udGludW91cyBzY2hlZHVsaW5nIGJldHdl
ZW4gdGhlIGFwcGxpY2F0aW9uIGFuZCBuYXBpLCB0aGUgZGF0YSBwYWNrZXQKPj4+IHRyYW5zbWlz
c2lvbiB3aWxsIG5vdCBiZSBzbW9vdGgsIGFuZCB0aGVyZSB3aWxsIGJlIGFuIG9idmlvdXMgZGVs
YXkgaW4KPj4+IHRoZSB0cmFuc21pc3Npb24gKHlvdSBjYW4gdXNlIHRjcGR1bXAgdG8gc2VlIGl0
KS4gV2hlbiBwcmVzc2luZyBhCj4+PiBjaGFubmVsIHRvIDEwMCUgKHZob3N0IHJlYWNoZXMgMTAw
JSksIHRoZSBjcHUgd2hlcmUgdGhlIGFwcGxpY2F0aW9uIGlzCj4+PiBsb2NhdGVkIHJlYWNoZXMg
MTAwJS4KPj4+Cj4+PiBUaGlzIHBhdGNoIHNlbmRzIGEgc21hbGwgYW1vdW50IG9mIGRhdGEgZGly
ZWN0bHkgaW4gd2FrZXVwLiBUaGUgcHVycG9zZQo+Pj4gb2YgdGhpcyBpcyB0byB0cmlnZ2VyIHRo
ZSB0eCBpbnRlcnJ1cHQuIFRoZSB0eCBpbnRlcnJ1cHQgd2lsbCBiZQo+Pj4gYXdha2VuZWQgb24g
dGhlIGNwdSBvZiBpdHMgYWZmaW5pdHksIGFuZCB0aGVuIHRyaWdnZXIgdGhlIG9wZXJhdGlvbiBv
Zgo+Pj4gdGhlIG5hcGkgbWVjaGFuaXNtLCBuYXBpIGNhbiBjb250aW51ZSB0byBjb25zdW1lIHRo
ZSB4c2sgdHggcXVldWUuIFR3bwo+Pj4gY3B1cyBhcmUgcnVubmluZywgY3B1MCBpcyBydW5uaW5n
IGFwcGxpY2F0aW9ucywgY3B1MSBleGVjdXRlcwo+Pj4gbmFwaSBjb25zdW1wdGlvbiBkYXRhLiBU
aGUgc2FtZSBpcyB0byBwcmVzcyBhIGNoYW5uZWwgdG8gMTAwJSwgYnV0IHRoZQo+Pj4gdXRpbGl6
YXRpb24gcmF0ZSBvZiBjcHUwIGlzIDEyLjclIGFuZCB0aGUgdXRpbGl6YXRpb24gcmF0ZSBvZiBj
cHUxIGlzCj4+PiAyLjklLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpo
dW9AbGludXguYWxpYmFiYS5jb20+Cj4+PiAtLS0KPj4+ICAgIGRyaXZlcnMvbmV0L3ZpcnRpby94
c2suYyB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0KPj4+ICAgIDEgZmlsZSBjaGFu
Z2VkLCAyMyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmMgYi9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmMKPj4+
IGluZGV4IDM2Y2RhMmRjZjhlNy4uMzk3M2M4MmQxYWQyIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVy
cy9uZXQvdmlydGlvL3hzay5jCj4+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmMKPj4+
IEBAIC01NDcsNiArNTQ3LDcgQEAgaW50IHZpcnRuZXRfeHNrX3dha2V1cChzdHJ1Y3QgbmV0X2Rl
dmljZSAqZGV2LCB1MzIgcWlkLCB1MzIgZmxhZykKPj4+ICAgIHsKPj4+ICAgIAlzdHJ1Y3Qgdmly
dG5ldF9pbmZvICp2aSA9IG5ldGRldl9wcml2KGRldik7Cj4+PiAgICAJc3RydWN0IHhza19idWZm
X3Bvb2wgKnBvb2w7Cj4+PiArCXN0cnVjdCBuZXRkZXZfcXVldWUgKnR4cTsKPj4+ICAgIAlzdHJ1
Y3Qgc2VuZF9xdWV1ZSAqc3E7Cj4+Pgo+Pj4gICAgCWlmICghbmV0aWZfcnVubmluZyhkZXYpKQo+
Pj4gQEAgLTU1OSwxMSArNTYwLDI4IEBAIGludCB2aXJ0bmV0X3hza193YWtldXAoc3RydWN0IG5l
dF9kZXZpY2UgKmRldiwgdTMyIHFpZCwgdTMyIGZsYWcpCj4+Pgo+Pj4gICAgCXJjdV9yZWFkX2xv
Y2soKTsKPj4+ICAgIAlwb29sID0gcmN1X2RlcmVmZXJlbmNlKHNxLT54c2sucG9vbCk7Cj4+PiAt
CWlmIChwb29sKSB7Cj4+PiAtCQlsb2NhbF9iaF9kaXNhYmxlKCk7Cj4+PiAtCQl2aXJ0cXVldWVf
bmFwaV9zY2hlZHVsZSgmc3EtPm5hcGksIHNxLT52cSk7Cj4+PiAtCQlsb2NhbF9iaF9lbmFibGUo
KTsKPj4+IC0JfQo+Pj4gKwlpZiAoIXBvb2wpCj4+PiArCQlnb3RvIGVuZDsKPj4+ICsKPj4+ICsJ
aWYgKG5hcGlfaWZfc2NoZWR1bGVkX21hcmtfbWlzc2VkKCZzcS0+bmFwaSkpCj4+PiArCQlnb3Rv
IGVuZDsKPj4+ICsKPj4+ICsJdHhxID0gbmV0ZGV2X2dldF90eF9xdWV1ZShkZXYsIHFpZCk7Cj4+
PiArCj4+PiArCV9fbmV0aWZfdHhfbG9ja19iaCh0eHEpOwo+Pj4gKwo+Pj4gKwkvKiBTZW5kIHBh
cnQgb2YgdGhlIHBhY2tldCBkaXJlY3RseSB0byByZWR1Y2UgdGhlIGRlbGF5IGluIHNlbmRpbmcg
dGhlCj4+PiArCSAqIHBhY2tldCwgYW5kIHRoaXMgY2FuIGFjdGl2ZWx5IHRyaWdnZXIgdGhlIHR4
IGludGVycnVwdHMuCj4+PiArCSAqCj4+PiArCSAqIElmIG5vIHBhY2tldCBpcyBzZW50IG91dCwg
dGhlIHJpbmcgb2YgdGhlIGRldmljZSBpcyBmdWxsLiBJbiB0aGlzCj4+PiArCSAqIGNhc2UsIHdl
IHdpbGwgc3RpbGwgZ2V0IGEgdHggaW50ZXJydXB0IHJlc3BvbnNlLiBUaGVuIHdlIHdpbGwgZGVh
bAo+Pj4gKwkgKiB3aXRoIHRoZSBzdWJzZXF1ZW50IHBhY2tldCBzZW5kaW5nIHdvcmsuCj4+PiAr
CSAqLwo+Pj4gKwl2aXJ0bmV0X3hza19ydW4oc3EsIHBvb2wsIHNxLT5uYXBpLndlaWdodCwgZmFs
c2UpOwo+Pgo+PiBUaGlzIGxvb2tzIHRyaWNreSwgYW5kIGl0IHdvbid0IGJlIGVmZmljaWVudCBz
aW5jZSB0aGVyZSBjb3VsZCBiZSBzb21lCj4+IGNvbnRlbnRpb24gb24gdGhlIHR4IGxvY2suCj4+
Cj4+IEkgd29uZGVyIGlmIHdlIGNhbiBzaW11bGF0ZSB0aGUgaW50ZXJydXB0IHZpYSBJUEkgbGlr
ZSB3aGF0IFJQUyBkaWQuCj4gTGV0IG1lIHRyeS4KPgo+PiBJbiB0aGUgbG9uZyBydW4sIHdlIG1h
eSB3YW50IHRvIGV4dGVuZCB0aGUgc3BlYyB0byBzdXBwb3J0IGludGVycnVwdAo+PiB0cmlnZ2Vy
IHRob3VnaCBkcml2ZXIuCj4gQ2FuIHdlIHN1Ym1pdCB0aGlzIHdpdGggcmVzZXQgcXVldWU/CgoK
V2UgbmVlZCBzZXBhcmF0ZSBmZWF0dXJlcy4gQW5kIGl0IGxvb2tzIHRvIG1lIGl0J3Mgbm90IGFz
IHVyZ2VudCBhcyByZXNldC4KClRoYW5rcwoKCj4KPiBUaGFua3MuCj4KPj4gVGhhbmtzCj4+Cj4+
Cj4+PiArCj4+PiArCV9fbmV0aWZfdHhfdW5sb2NrX2JoKHR4cSk7Cj4+PiArCj4+PiArZW5kOgo+
Pj4gICAgCXJjdV9yZWFkX3VubG9jaygpOwo+Pj4gICAgCXJldHVybiAwOwo+Pj4gICAgfQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
