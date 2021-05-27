Return-Path: <SRS0=l/A6=KW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53E5C4707F
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 04:22:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F0EF613D1
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 04:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0EF613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 096AE4016C;
	Thu, 27 May 2021 04:22:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id av_jWOvqQOyo; Thu, 27 May 2021 04:22:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8724A400F2;
	Thu, 27 May 2021 04:22:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 463B4C000E;
	Thu, 27 May 2021 04:22:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98EA0C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E7524016C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:22:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z0Hc7S6tpa-l
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:22:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A4A54400F2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622089354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OAGVZlyn+FPPGIT5k/Jxmg610YPRZpRAynqprUWUe3g=;
 b=SNunUYOy1bvcEfLqcY8xnTxZfdXIBb3+kITx3LbSApBocBnJf02DUG1Z1rW8YYfC8iT1hf
 39s15sO4yRZbNYLatre1N1Pb6+YsJE2FJiLENBt/OsRbaqPcwyl7135LM0XlP1HCfBS1wL
 /Z1FicwGNOS/J+FdjJifu1PY+4Pgf0c=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-wamh-jE9P8Kan8AocVuAUA-1; Thu, 27 May 2021 00:22:30 -0400
X-MC-Unique: wamh-jE9P8Kan8AocVuAUA-1
Received: by mail-pj1-f70.google.com with SMTP id
 f15-20020a17090aa78fb029015c411f061bso1676677pjq.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 21:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=OAGVZlyn+FPPGIT5k/Jxmg610YPRZpRAynqprUWUe3g=;
 b=A/iskzMoJttBkLseIwcsT2KBOEQB5OPDto0U8ZmMlD8poRIwKTMTms4Y4c9S3w8NAt
 pnjnARs4+qvmFAGh/hGTxw6oqgIvmqE9WvvsPakpGtw5371bxX4LIPJ0jm6GoJd9K3cM
 iPd3jAW0Jx1jAKKWgy9VrxeFQ2gIxLQWoXXXdc/MiL74yjGsZ3dvbQU60n/A5BKwWbr1
 +tSXixauAHICZ1vsh61jFk13SgTJqfZ8Rg5WScpqn9kllgEjYmSLHPY6td/wngmbYIZi
 3ok+y+r0YOIRhYT2a1+r3QBKDV+AzD97XfFEptlhdY8XjXY85hYAo5CnVX3qTvQlAMK0
 UBdA==
X-Gm-Message-State: AOAM531uHd65nq9ELZ8bvvEPydjwokaXZWL5g01DCWm/2Pdd4JZMHwE7
 7SWW069xOb7Sp2zlkpq+yH0VdtjC5bjxozG9ZaLP37/MoOBAODiWDrzQmEiFwQTYbwEMpZkYXHi
 cggEuF8F90+Xjk0MV4SBxtv86t+WLQ8aiJfGUlfUrNg==
X-Received: by 2002:aa7:8ec4:0:b029:2e6:54e2:3055 with SMTP id
 b4-20020aa78ec40000b02902e654e23055mr1876354pfr.15.1622089348981; 
 Wed, 26 May 2021 21:22:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyd2eT/V1Ms2ZM7PWLESpRQekmEteUSwxxEgZMT8D6lNlMWkAWMl4EbTD5ypfjP5ICL6WJPw==
X-Received: by 2002:aa7:8ec4:0:b029:2e6:54e2:3055 with SMTP id
 b4-20020aa78ec40000b02902e654e23055mr1876329pfr.15.1622089348681; 
 Wed, 26 May 2021 21:22:28 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w189sm618069pfb.46.2021.05.26.21.22.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 21:22:28 -0700 (PDT)
Subject: Re: [PATCH net-next] virtio_net: set link state down when virtqueue
 is broken
To: wangyunjian <wangyunjian@huawei.com>, netdev@vger.kernel.org
References: <79907bf6c835572b4af92f16d9a3ff2822b1c7ea.1622028946.git.wangyunjian@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <03c68dd1-a636-9d3b-1dec-5e11c8025ccc@redhat.com>
Date: Thu, 27 May 2021 12:22:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <79907bf6c835572b4af92f16d9a3ff2822b1c7ea.1622028946.git.wangyunjian@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kuba@kernel.org, virtualization@lists.linux-foundation.org,
 dingxiaoxiong@huawei.com, davem@davemloft.net, mst@redhat.com
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

CuWcqCAyMDIxLzUvMjYg5LiL5Y2INzozOSwgd2FuZ3l1bmppYW4g5YaZ6YGTOgo+IEZyb206IFl1
bmppYW4gV2FuZyA8d2FuZ3l1bmppYW5AaHVhd2VpLmNvbT4KPgo+IFRoZSBOSUMgY2FuJ3QgcmVj
ZWl2ZS9zZW5kIHBhY2tldHMgaWYgYSByeC90eCB2aXJ0cXVldWUgaXMgYnJva2VuLgo+IEhvd2V2
ZXIsIHRoZSBsaW5rIHN0YXRlIG9mIHRoZSBOSUMgaXMgc3RpbGwgbm9ybWFsLiBBcyBhIHJlc3Vs
dCwKPiB0aGUgdXNlciBjYW5ub3QgZGV0ZWN0IHRoZSBOSUMgZXhjZXB0aW9uLgoKCkRvZXNuJ3Qg
d2UgaGF2ZToKCiDCoMKgwqDCoMKgwqAgLyogVGhpcyBzaG91bGQgbm90IGhhcHBlbiEgKi8KIMKg
wqDCoMKgwqDCoMKgIGlmICh1bmxpa2VseShlcnIpKSB7CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZGV2LT5zdGF0cy50eF9maWZvX2Vycm9ycysrOwogwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlmIChuZXRfcmF0ZWxpbWl0KCkpCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl93YXJuKCZkZXYtPmRldiwKIMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIlVu
ZXhwZWN0ZWQgVFhRICglZCkgcXVldWUgZmFpbHVyZTogJWRcbiIsCiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHFudW0sIGVy
cik7CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2LT5zdGF0cy50eF9kcm9wcGVk
Kys7CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2tmcmVlX3NrYl9hbnkoc2ti
KTsKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTkVUREVWX1RYX09LOwog
wqDCoMKgwqDCoMKgwqAgfQoKV2hpY2ggc2hvdWxkIGJlIHN1ZmZpY2llbnQ/CgoKPgo+IFRoZSBk
cml2ZXIgY2FuIHNldCB0aGUgbGluayBzdGF0ZSBkb3duIHdoZW4gdGhlIHZpcnRxdWV1ZSBpcyBi
cm9rZW4uCj4gSWYgdGhlIHN0YXRlIGlzIGRvd24sIHRoZSB1c2VyIGNhbiBzd2l0Y2ggb3ZlciB0
byBhbm90aGVyIE5JQy4KCgpOb3RlIHRoYXQsIHdlIHByb2JhYmx5IG5lZWQgdGhlIHdhdGNoZG9n
IGZvciB2aXJ0aW8tbmV0IGluIG9yZGVyIHRvIGJlIGEgCmNvbXBsZXRlIHNvbHV0aW9uLgoKVGhh
bmtzCgoKPgo+IFNpZ25lZC1vZmYtYnk6IFl1bmppYW4gV2FuZyA8d2FuZ3l1bmppYW5AaHVhd2Vp
LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDM2ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDM1IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCAwNzNmZWM0YzBkZjEuLjA1
YTNjZDFjNTg5YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysg
Yi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtMjM3LDYgKzIzNywxMCBAQCBzdHJ1Y3Qg
dmlydG5ldF9pbmZvIHsKPiAgIAo+ICAgCS8qIGZhaWxvdmVyIHdoZW4gU1RBTkRCWSBmZWF0dXJl
IGVuYWJsZWQgKi8KPiAgIAlzdHJ1Y3QgZmFpbG92ZXIgKmZhaWxvdmVyOwo+ICsKPiArCS8qIFdv
cmsgc3RydWN0IGZvciBjaGVja2luZyB2cSBzdGF0dXMsIHN0b3AgTklDIGlmIHZxIGlzIGJyb2tl
bi4gKi8KPiArCXN0cnVjdCBkZWxheWVkX3dvcmsgdnFfY2hlY2tfd29yazsKPiArCWJvb2wgYnJv
a2VuOwo+ICAgfTsKPiAgIAo+ICAgc3RydWN0IHBhZGRlZF92bmV0X2hkciB7Cj4gQEAgLTE0MDcs
NiArMTQxMSwyNyBAQCBzdGF0aWMgdm9pZCByZWZpbGxfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3Qg
KndvcmspCj4gICAJfQo+ICAgfQo+ICAgCj4gK3N0YXRpYyB2b2lkIHZpcm5ldF92cV9jaGVja193
b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiArewo+ICsJc3RydWN0IHZpcnRuZXRfaW5m
byAqdmkgPQo+ICsJCWNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgdmlydG5ldF9pbmZvLCB2cV9j
aGVja193b3JrLndvcmspOwo+ICsJc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldiA9IHZpLT5kZXY7
Cj4gKwlpbnQgaTsKPiArCj4gKwlpZiAodmktPmJyb2tlbikKPiArCQlyZXR1cm47Cj4gKwo+ICsJ
LyogSWYgdmlydHF1ZXVlIGlzIGJyb2tlbiwgc2V0IGxpbmsgZG93biBhbmQgc3RvcCBhbGwgcXVl
dWVzICovCj4gKwlmb3IgKGkgPSAwOyBpIDwgdmktPm1heF9xdWV1ZV9wYWlyczsgaSsrKSB7Cj4g
KwkJaWYgKHZpcnRxdWV1ZV9pc19icm9rZW4odmktPnJxW2ldLnZxKSB8fCB2aXJ0cXVldWVfaXNf
YnJva2VuKHZpLT5zcVtpXS52cSkpIHsKPiArCQkJbmV0aWZfY2Fycmllcl9vZmYobmV0ZGV2KTsK
PiArCQkJbmV0aWZfdHhfc3RvcF9hbGxfcXVldWVzKG5ldGRldik7Cj4gKwkJCXZpLT5icm9rZW4g
PSB0cnVlOwo+ICsJCQlicmVhazsKPiArCQl9Cj4gKwl9Cj4gK30KPiArCj4gICBzdGF0aWMgaW50
IHZpcnRuZXRfcmVjZWl2ZShzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsIGludCBidWRnZXQsCj4g
ICAJCQkgICB1bnNpZ25lZCBpbnQgKnhkcF94bWl0KQo+ICAgewo+IEBAIC0xNDMyLDYgKzE0NTcs
OSBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcmVjZWl2ZShzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEs
IGludCBidWRnZXQsCj4gICAJCX0KPiAgIAl9Cj4gICAKPiArCWlmICh1bmxpa2VseSghdmlydHF1
ZXVlX2lzX2Jyb2tlbihycS0+dnEpKSkKPiArCQlzY2hlZHVsZV9kZWxheWVkX3dvcmsoJnZpLT52
cV9jaGVja193b3JrLCBIWik7Cj4gKwo+ICAgCWlmIChycS0+dnEtPm51bV9mcmVlID4gbWluKCh1
bnNpZ25lZCBpbnQpYnVkZ2V0LCB2aXJ0cXVldWVfZ2V0X3ZyaW5nX3NpemUocnEtPnZxKSkgLyAy
KSB7Cj4gICAJCWlmICghdHJ5X2ZpbGxfcmVjdih2aSwgcnEsIEdGUF9BVE9NSUMpKQo+ICAgCQkJ
c2NoZWR1bGVfZGVsYXllZF93b3JrKCZ2aS0+cmVmaWxsLCAwKTsKPiBAQCAtMTY4MSw2ICsxNzA5
LDcgQEAgc3RhdGljIG5ldGRldl90eF90IHN0YXJ0X3htaXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwg
c3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiAgIAkJCQkgcW51bSwgZXJyKTsKPiAgIAkJZGV2LT5z
dGF0cy50eF9kcm9wcGVkKys7Cj4gICAJCWRldl9rZnJlZV9za2JfYW55KHNrYik7Cj4gKwkJc2No
ZWR1bGVfZGVsYXllZF93b3JrKCZ2aS0+dnFfY2hlY2tfd29yaywgSFopOwo+ICAgCQlyZXR1cm4g
TkVUREVWX1RYX09LOwo+ICAgCX0KPiAgIAo+IEBAIC0xOTA1LDYgKzE5MzQsNyBAQCBzdGF0aWMg
aW50IHZpcnRuZXRfY2xvc2Uoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiAgIAo+ICAgCS8qIE1h
a2Ugc3VyZSByZWZpbGxfd29yayBkb2Vzbid0IHJlLWVuYWJsZSBuYXBpISAqLwo+ICAgCWNhbmNl
bF9kZWxheWVkX3dvcmtfc3luYygmdmktPnJlZmlsbCk7Cj4gKwljYW5jZWxfZGVsYXllZF93b3Jr
X3N5bmMoJnZpLT52cV9jaGVja193b3JrKTsKPiAgIAo+ICAgCWZvciAoaSA9IDA7IGkgPCB2aS0+
bWF4X3F1ZXVlX3BhaXJzOyBpKyspIHsKPiAgIAkJeGRwX3J4cV9pbmZvX3VucmVnKCZ2aS0+cnFb
aV0ueGRwX3J4cSk7Cj4gQEAgLTIzODEsNiArMjQxMSw3IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRf
ZnJlZXplX2Rvd24oc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gICAJbmV0aWZfZGV2aWNl
X2RldGFjaCh2aS0+ZGV2KTsKPiAgIAluZXRpZl90eF91bmxvY2tfYmgodmktPmRldik7Cj4gICAJ
Y2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZ2aS0+cmVmaWxsKTsKPiArCWNhbmNlbF9kZWxheWVk
X3dvcmtfc3luYygmdmktPnZxX2NoZWNrX3dvcmspOwo+ICAgCj4gICAJaWYgKG5ldGlmX3J1bm5p
bmcodmktPmRldikpIHsKPiAgIAkJZm9yIChpID0gMDsgaSA8IHZpLT5tYXhfcXVldWVfcGFpcnM7
IGkrKykgewo+IEBAIC0yNjYyLDcgKzI2OTMsNyBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X2NvbmZp
Z19jaGFuZ2VkX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ICAgCj4gICAJdmktPnN0
YXR1cyA9IHY7Cj4gICAKPiAtCWlmICh2aS0+c3RhdHVzICYgVklSVElPX05FVF9TX0xJTktfVVAp
IHsKPiArCWlmICgodmktPnN0YXR1cyAmIFZJUlRJT19ORVRfU19MSU5LX1VQKSAmJiAhdmktPmJy
b2tlbikgewo+ICAgCQl2aXJ0bmV0X3VwZGF0ZV9zZXR0aW5ncyh2aSk7Cj4gICAJCW5ldGlmX2Nh
cnJpZXJfb24odmktPmRldik7Cj4gICAJCW5ldGlmX3R4X3dha2VfYWxsX3F1ZXVlcyh2aS0+ZGV2
KTsKPiBAQCAtMjg4OSw2ICsyOTIwLDggQEAgc3RhdGljIGludCB2aXJ0bmV0X2FsbG9jX3F1ZXVl
cyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkKPiAgIAkJZ290byBlcnJfcnE7Cj4gICAKPiAgIAlJ
TklUX0RFTEFZRURfV09SSygmdmktPnJlZmlsbCwgcmVmaWxsX3dvcmspOwo+ICsJSU5JVF9ERUxB
WUVEX1dPUksoJnZpLT52cV9jaGVja193b3JrLCB2aXJuZXRfdnFfY2hlY2tfd29yayk7Cj4gKwo+
ICAgCWZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspIHsKPiAgIAkJdmkt
PnJxW2ldLnBhZ2VzID0gTlVMTDsKPiAgIAkJbmV0aWZfbmFwaV9hZGQodmktPmRldiwgJnZpLT5y
cVtpXS5uYXBpLCB2aXJ0bmV0X3BvbGwsCj4gQEAgLTMyNDAsNiArMzI3Myw3IEBAIHN0YXRpYyBp
bnQgdmlydG5ldF9wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiAgIAluZXRfZmFp
bG92ZXJfZGVzdHJveSh2aS0+ZmFpbG92ZXIpOwo+ICAgZnJlZV92cXM6Cj4gICAJY2FuY2VsX2Rl
bGF5ZWRfd29ya19zeW5jKCZ2aS0+cmVmaWxsKTsKPiArCWNhbmNlbF9kZWxheWVkX3dvcmtfc3lu
YygmdmktPnZxX2NoZWNrX3dvcmspOwo+ICAgCWZyZWVfcmVjZWl2ZV9wYWdlX2ZyYWdzKHZpKTsK
PiAgIAl2aXJ0bmV0X2RlbF92cXModmkpOwo+ICAgZnJlZToKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
