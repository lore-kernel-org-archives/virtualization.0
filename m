Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C36C77B73
	for <virtualization@archiver.kernel.org>; Wed, 26 Apr 2023 03:16:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F1FF41B93;
	Wed, 26 Apr 2023 03:16:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F1FF41B93
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=STWYHAyv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nb61sCjCvh6p; Wed, 26 Apr 2023 03:15:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1BBD241960;
	Wed, 26 Apr 2023 03:15:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1BBD241960
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8BD8C0037;
	Wed, 26 Apr 2023 03:15:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3625BC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 03:15:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0260F60BBC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 03:15:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0260F60BBC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=STWYHAyv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L2jKsXHFiLuY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 03:15:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3681460AA6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3681460AA6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 03:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682478954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FdgqUYnfdAd9yYGT3jWLr/aAVynWA1K/zHRTBmBRQZU=;
 b=STWYHAyvr6W/QK2Xg80T+Tp2VJlrsUQEORMxE9eGZmNwPPX8ylJMrenl+WCuw23EZIQ0g2
 8zBk/9fHc9oCix70KBxeKRwKd7SCWaI0lNfrAbyE/tvIKQcZlo+UDQk0h/Xx9XqAnhe614
 097z52YPyMeI744JmqPAm37TOUDTJtk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-eNB8wH4xNRS-uFP03W89MQ-1; Tue, 25 Apr 2023 23:15:53 -0400
X-MC-Unique: eNB8wH4xNRS-uFP03W89MQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-63b60018e71so4495687b3a.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 20:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682478952; x=1685070952;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FdgqUYnfdAd9yYGT3jWLr/aAVynWA1K/zHRTBmBRQZU=;
 b=a+XVyHoS88KKByifmnyk8K7sjnMzk8kWq/rTv6uAQZ4u9mpF1KB9o57qZXpnb5s5Be
 f31kX+HksDtSbf03dZnr1M8ozrrAtZ7EP8bZLUxVvRGJQE/lbF7nwKkYUTYXE9osKY0R
 sBTo0ozz+cZGvDgg3GNrfPN0qmW7pVIRWuZavphyIGlYurRDaySPw7wuuneXnzjNx2Ui
 /lFTONUSamRWU3pxXCyhPI4bNzSyp+RsnoRFbEW+UpCAY36E26DyaVkK29nDzKIC054M
 wgp6Bt11P1v/azyTs8uefP/XDpw3XRR8eOcKFMuDzTs+Ns2AkVyarCNf8L3Q40wlSwCu
 u0xg==
X-Gm-Message-State: AAQBX9dJj9RUiYOSinUC7h+PlSQ8cCqyD4BIT9SvaHT88EY3MrwoSWTR
 8Zbexdmn7ey50M5BbMcxaeZqzv/tysnXexZCgHP+mr/i+5aKjczW5COGbLY4WWrrmMbIKvnMZky
 VINwC8JSi0OxPNjKt4zzCTtkOLo5Aw9tt0e9ePjEe5w==
X-Received: by 2002:a05:6a00:15c9:b0:63b:854e:8459 with SMTP id
 o9-20020a056a0015c900b0063b854e8459mr28889457pfu.31.1682478952342; 
 Tue, 25 Apr 2023 20:15:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350YwsMM+6nH+RCaQZjSGkf/VpoJD7jHIjgY6Elv8FV37cNsdgbEzPSNGm46pnGbHEC4ks7bD8w==
X-Received: by 2002:a05:6a00:15c9:b0:63b:854e:8459 with SMTP id
 o9-20020a056a0015c900b0063b854e8459mr28889440pfu.31.1682478952021; 
 Tue, 25 Apr 2023 20:15:52 -0700 (PDT)
Received: from [10.72.13.54] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 p14-20020a62ab0e000000b0063a5837d9e8sm9935447pff.156.2023.04.25.20.15.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Apr 2023 20:15:51 -0700 (PDT)
Message-ID: <2f2899c4-4e7a-85fd-f399-7cd119fa6aca@redhat.com>
Date: Wed, 26 Apr 2023 11:15:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH net-next v3 14/15] virtio_net: introduce
 receive_small_build_xdp
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20230423105736.56918-1-xuanzhuo@linux.alibaba.com>
 <20230423105736.56918-15-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230423105736.56918-15-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIzLzQvMjMgMTg6NTcsIFh1YW4gWmh1byDlhpnpgZM6Cj4gU2ltcGxpZnlpbmcgcmVj
ZWl2ZV9zbWFsbCgpIGZ1bmN0aW9uLiBCcmluZ2luZyB0aGUgbG9naWMgcmVsYXRpbmcgdG8KPiBi
dWlsZF9za2IgdG9nZXRoZXIuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVv
QGxpbnV4LmFsaWJhYmEuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPgoKVGhhbmtzCgoKPiAtLS0KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDQ4
ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAzMSBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRl
eCBkMjk3M2M4ZmE0OGMuLjgxMWNmMTA0NmRmMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtOTMxLDYg
KzkzMSwzNCBAQCBzdGF0aWMgc3RydWN0IHBhZ2UgKnhkcF9saW5lYXJpemVfcGFnZShzdHJ1Y3Qg
cmVjZWl2ZV9xdWV1ZSAqcnEsCj4gICAJcmV0dXJuIE5VTEw7Cj4gICB9Cj4gICAKPiArc3RhdGlj
IHN0cnVjdCBza19idWZmICpyZWNlaXZlX3NtYWxsX2J1aWxkX3NrYihzdHJ1Y3QgdmlydG5ldF9p
bmZvICp2aSwKPiArCQkJCQkgICAgICAgdW5zaWduZWQgaW50IHhkcF9oZWFkcm9vbSwKPiArCQkJ
CQkgICAgICAgdm9pZCAqYnVmLAo+ICsJCQkJCSAgICAgICB1bnNpZ25lZCBpbnQgbGVuKQo+ICt7
Cj4gKwl1bnNpZ25lZCBpbnQgaGVhZGVyX29mZnNldDsKPiArCXVuc2lnbmVkIGludCBoZWFkcm9v
bTsKPiArCXVuc2lnbmVkIGludCBidWZsZW47Cj4gKwlzdHJ1Y3Qgc2tfYnVmZiAqc2tiOwo+ICsK
PiArCWhlYWRlcl9vZmZzZXQgPSBWSVJUTkVUX1JYX1BBRCArIHhkcF9oZWFkcm9vbTsKPiArCWhl
YWRyb29tID0gdmktPmhkcl9sZW4gKyBoZWFkZXJfb2Zmc2V0Owo+ICsJYnVmbGVuID0gU0tCX0RB
VEFfQUxJR04oR09PRF9QQUNLRVRfTEVOICsgaGVhZHJvb20pICsKPiArCQlTS0JfREFUQV9BTElH
TihzaXplb2Yoc3RydWN0IHNrYl9zaGFyZWRfaW5mbykpOwo+ICsKPiArCXNrYiA9IGJ1aWxkX3Nr
YihidWYsIGJ1Zmxlbik7Cj4gKwlpZiAoIXNrYikKPiArCQlyZXR1cm4gTlVMTDsKPiArCj4gKwlz
a2JfcmVzZXJ2ZShza2IsIGhlYWRyb29tKTsKPiArCXNrYl9wdXQoc2tiLCBsZW4pOwo+ICsKPiAr
CWJ1ZiArPSBoZWFkZXJfb2Zmc2V0Owo+ICsJbWVtY3B5KHNrYl92bmV0X2hkcihza2IpLCBidWYs
IHZpLT5oZHJfbGVuKTsKPiArCj4gKwlyZXR1cm4gc2tiOwo+ICt9Cj4gKwo+ICAgc3RhdGljIHN0
cnVjdCBza19idWZmICpyZWNlaXZlX3NtYWxsX3hkcChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+
ICAgCQkJCQkgc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gICAJCQkJCSBzdHJ1Y3QgcmVjZWl2
ZV9xdWV1ZSAqcnEsCj4gQEAgLTEwMzAsOSArMTA1OCw2IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVm
ZiAqcmVjZWl2ZV9zbWFsbChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAgewo+ICAgCXVuc2ln
bmVkIGludCB4ZHBfaGVhZHJvb20gPSAodW5zaWduZWQgbG9uZyljdHg7Cj4gICAJc3RydWN0IHBh
Z2UgKnBhZ2UgPSB2aXJ0X3RvX2hlYWRfcGFnZShidWYpOwo+IC0JdW5zaWduZWQgaW50IGhlYWRl
cl9vZmZzZXQ7Cj4gLQl1bnNpZ25lZCBpbnQgaGVhZHJvb207Cj4gLQl1bnNpZ25lZCBpbnQgYnVm
bGVuOwo+ICAgCXN0cnVjdCBza19idWZmICpza2I7Cj4gICAKPiAgIAlsZW4gLT0gdmktPmhkcl9s
ZW47Cj4gQEAgLTEwNjAsMjAgKzEwODUsOSBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2Vp
dmVfc21hbGwoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgIAkJcmN1X3JlYWRfdW5sb2NrKCk7
Cj4gICAJfQo+ICAgCj4gLQloZWFkZXJfb2Zmc2V0ID0gVklSVE5FVF9SWF9QQUQgKyB4ZHBfaGVh
ZHJvb207Cj4gLQloZWFkcm9vbSA9IHZpLT5oZHJfbGVuICsgaGVhZGVyX29mZnNldDsKPiAtCWJ1
ZmxlbiA9IFNLQl9EQVRBX0FMSUdOKEdPT0RfUEFDS0VUX0xFTiArIGhlYWRyb29tKSArCj4gLQkJ
U0tCX0RBVEFfQUxJR04oc2l6ZW9mKHN0cnVjdCBza2Jfc2hhcmVkX2luZm8pKTsKPiAtCj4gLQlz
a2IgPSBidWlsZF9za2IoYnVmLCBidWZsZW4pOwo+IC0JaWYgKCFza2IpCj4gLQkJZ290byBlcnI7
Cj4gLQlza2JfcmVzZXJ2ZShza2IsIGhlYWRyb29tKTsKPiAtCXNrYl9wdXQoc2tiLCBsZW4pOwo+
IC0KPiAtCWJ1ZiArPSBoZWFkZXJfb2Zmc2V0Owo+IC0JbWVtY3B5KHNrYl92bmV0X2hkcihza2Ip
LCBidWYsIHZpLT5oZHJfbGVuKTsKPiAtCXJldHVybiBza2I7Cj4gKwlza2IgPSByZWNlaXZlX3Nt
YWxsX2J1aWxkX3NrYih2aSwgeGRwX2hlYWRyb29tLCBidWYsIGxlbik7Cj4gKwlpZiAobGlrZWx5
KHNrYikpCj4gKwkJcmV0dXJuIHNrYjsKPiAgIAo+ICAgZXJyOgo+ICAgCXN0YXRzLT5kcm9wcysr
OwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
