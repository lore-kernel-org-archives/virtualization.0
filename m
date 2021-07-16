Return-Path: <SRS0=Pjyk=MI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55457C636C8
	for <virtualization@archiver.kernel.org>; Fri, 16 Jul 2021 02:58:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED74C613E3
	for <virtualization@archiver.kernel.org>; Fri, 16 Jul 2021 02:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED74C613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A825B60AFD;
	Fri, 16 Jul 2021 02:58:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D2PE6fO7E_eG; Fri, 16 Jul 2021 02:58:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 32E5160780;
	Fri, 16 Jul 2021 02:58:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07122C001A;
	Fri, 16 Jul 2021 02:58:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89FDCC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 02:58:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 64FD440390
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 02:58:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KOyV3_z23_Fq
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 02:58:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C21140133
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 02:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626404292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rVaJ8XvOsDBWtaRQp3apo92CSiPixBvBUSI+5KjFdc=;
 b=FlNGoJyGoWfRRD7nAQo6KYGThbMJMmdU2HV5lnBYHdVyJlItiKOa6wXLMd91yd2yl/Bh5i
 Gio38DjEECfVBfk8rzcOxjRu4VD0qrwBe4U0i5Frx212ikcb7beox9UBgcI5flcO2A+JgP
 pnlzAR7l4YSpw+6GxnOyiMZyoS+QWRY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-yxQ-9WzUNWGl20nfaMArjg-1; Thu, 15 Jul 2021 22:58:11 -0400
X-MC-Unique: yxQ-9WzUNWGl20nfaMArjg-1
Received: by mail-pg1-f200.google.com with SMTP id
 o15-20020a655bcf0000b029022c1a9c33b7so5879468pgr.18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 19:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=1rVaJ8XvOsDBWtaRQp3apo92CSiPixBvBUSI+5KjFdc=;
 b=SMR3ULkgPDWDl3TmxaMQ8ikwgJqBnmwHb//vBKNPkI9PSZnexEPhu4QAsLDyVS/hq9
 h05Z6Vekpz9cMsPqSaZQEBIaxbfHSLivpnvxwnJdMQNVgr+M12VDO/IZaSXC0naxrgVO
 Q8LSoF796CosHRmrsGMcmY3Oa9c4VgAwZbmUicuLWs6GSY+gKdkgp85tV601JdXGVSxm
 nYyQzuuRKpZfPiwkioBboakU2W2U0PmFlDhwI+ptekXA1bYKlZCY1iR++sv0uFBUz+hh
 DgFNEfFIPcpwpR6xgLYk4qkUAjf8ThTb1JhZe0OIiZXix9PKFO3KvGzbEs2T3G+IzCa0
 bsEQ==
X-Gm-Message-State: AOAM530rsbsSvnEJwKKE0NfGvDYJuNdfmiBFc7nM7L8vJIquMGJUbao5
 HLWgY3y18w00hEwxoSBWQDdXFfvw3ekOthp2SpwWen/gyCy6GPaHjiWGwTKBauSDZdD8QZ7Xrdo
 CErY4hmc6F2AItrp3a0qxU0DfJIiWCcfjaY33BxuNYw==
X-Received: by 2002:a63:2ad7:: with SMTP id q206mr7719143pgq.293.1626404290412; 
 Thu, 15 Jul 2021 19:58:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcVMtGVvo/4+WELLZqICmyEEq8fuHUEaK7zlWHRei1qwUHmSCRFN0Ja84LkdQNmIXFBviGIQ==
X-Received: by 2002:a63:2ad7:: with SMTP id q206mr7719128pgq.293.1626404290160; 
 Thu, 15 Jul 2021 19:58:10 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w123sm8061175pfb.109.2021.07.15.19.58.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jul 2021 19:58:09 -0700 (PDT)
Subject: Re: [PATCH 1/1] virtio: disable partitions scanning for no partitions
 block
To: Yury Kamenev <damtev@yandex-team.ru>, mst@redhat.com,
 pbonzini@redhat.com, stefanha@redhat.com, axboe@kernel.dk, hch@lst.de,
 cand@gmx.com, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210715094707.19997-1-damtev@yandex-team.ru>
 <20210715094707.19997-2-damtev@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <eada95b1-a1fb-3877-9b04-ac2bd16f5fe0@redhat.com>
Date: Fri, 16 Jul 2021 10:57:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715094707.19997-2-damtev@yandex-team.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNy8xNSDPws7nNTo0NywgWXVyeSBLYW1lbmV2INC0tcA6Cj4gU2lnbmVkLW9mZi1i
eTogWXVyeSBLYW1lbmV2IDxkYW10ZXZAeWFuZGV4LXRlYW0ucnU+CgoKSSB0aGluayB3ZSBuZWVk
IGEgYmV0dGVyIGNvbW1pdCBsb2cgaGVyZS4KCkFuZCB3aHkgZG8gd2UgbmVlZCBhIEtjb25maWcg
Zm9yIHRoaXM/IElmIHRoZXJlJ3MgYSBnb29kIHJlYXNvbiwgSSBndWVzcyAKdGhlIHJpZ2h0IGFw
cHJvYWNoIGlzIHRvIGludmVudCBzb21ldGhpbmcgaW4gdGhlIHZpcnRpbyBjb3JlICh2aWEgL3N5
cyk/CgpUaGFua3MKCgo+IC0tLQo+ICAgLi4uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJz
LnR4dCAgICAgICAgIHwgIDMgKysrCj4gICBkcml2ZXJzL2Jsb2NrL0tjb25maWcgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgNyArKysrKwo+ICAgZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMg
ICAgICAgICAgICAgICAgICAgIHwgMjYgKysrKysrKysrKysrKysrKysrKwo+ICAgaW5jbHVkZS91
YXBpL2xpbnV4L3ZpcnRpb19ibGsuaCAgICAgICAgICAgICAgIHwgIDIgKysKPiAgIDQgZmlsZXMg
Y2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
YWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0IGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1n
dWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQKPiBpbmRleCBiZGIyMjAwNmY3MTMuLjk0MWJkYWY1
YzE2NyAxMDA2NDQKPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJh
bWV0ZXJzLnR4dAo+ICsrKyBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFt
ZXRlcnMudHh0Cj4gQEAgLTYwNzYsNiArNjA3Niw5IEBACj4gICAJCQlicmlnaHRuZXNzIGxldmVs
Lgo+ICAgCQkJZGVmYXVsdDogMQo+Cj4gKwl2aXJ0aW9wYXJ0c2Nhbgo+ICsJCUVuYWJsZSB2aXJ0
aW8gYmxvY2sgZGV2aWNlIHBhcnRpdGlvbiBzY2FubmluZyBvbWlzc2lvbiBiYXNlZCBvbiBWSVJU
SU9fQkxLX0ZfTk9fUEFSVF9TQ0FOIGZlYXR1cmUgZmxhZy4KPiArCj4gICAJdmlydGlvX21taW8u
ZGV2aWNlPQo+ICAgCQkJW1ZNTUlPXSBNZW1vcnkgbWFwcGVkIHZpcnRpbyAocGxhdGZvcm0pIGRl
dmljZS4KPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL0tjb25maWcgYi9kcml2ZXJzL2Js
b2NrL0tjb25maWcKPiBpbmRleCA2MzA1NmNmZDRiNjIuLjY5ZWNkM2ZkNzAzNyAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2Jsb2NrL0tjb25maWcKPiArKysgYi9kcml2ZXJzL2Jsb2NrL0tjb25maWcK
PiBAQCAtMzk5LDYgKzM5OSwxMyBAQCBjb25maWcgVklSVElPX0JMSwo+ICAgCSAgVGhpcyBpcyB0
aGUgdmlydHVhbCBibG9jayBkcml2ZXIgZm9yIHZpcnRpby4gIEl0IGNhbiBiZSB1c2VkIHdpdGgK
PiAgICAgICAgICAgICBRRU1VIGJhc2VkIFZNTXMgKGxpa2UgS1ZNIG9yIFhlbikuICBTYXkgWSBv
ciBNLgo+Cj4gK2NvbmZpZyBWSVJUSU9fQkxLX05PX1BBUlRfU0NBTgo+ICsJYm9vbCAiRGlzYWJs
ZSBwYXJ0aXRpb24gc2Nhbm5pbmcgZm9yIGRldmljZXMgd2l0aCBubyBwYXJ0aXRpb25zIgo+ICsJ
ZGVwZW5kcyBvbiBWSVJUSU9fQkxLCj4gKwloZWxwCj4gKwkgIERpc2FibGUgcGFydGl0aW9uIHNj
YW5uaW5nIGZvciBkZXZpY2VzIHdpdGggbm8gcGFydGl0aW9ucy4KPiArCSAgQ2FuIHJlZHVjZSB0
aGUga2VybmVsIHN0YXJ0IHRpbWUgZm9yIHRpbnkgc3lzdGVtcyBsaWtlIHNxdWFzaGZzIGltYWdl
cy4KPiArCj4gICBjb25maWcgQkxLX0RFVl9SQkQKPiAgIAl0cmlzdGF0ZSAiUmFkb3MgYmxvY2sg
ZGV2aWNlIChSQkQpIgo+ICAgCWRlcGVuZHMgb24gSU5FVCAmJiBCTE9DSwo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYyBiL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5j
Cj4gaW5kZXggNGI0OWRmMmRmZDIzLi40Nzk3MTFkMzc5MWMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ibG9jay92aXJ0aW9fYmxrLmMKPiArKysgYi9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYwo+
IEBAIC02OTIsNiArNjkyLDE5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYmxrX21xX29wcyB2aXJ0
aW9fbXFfb3BzID0gewo+ICAgc3RhdGljIHVuc2lnbmVkIGludCB2aXJ0YmxrX3F1ZXVlX2RlcHRo
Owo+ICAgbW9kdWxlX3BhcmFtX25hbWVkKHF1ZXVlX2RlcHRoLCB2aXJ0YmxrX3F1ZXVlX2RlcHRo
LCB1aW50LCAwNDQ0KTsKPgo+ICsjaWZuZGVmIE1PRFVMRQo+ICsjaWZkZWYgQ09ORklHX1ZJUlRJ
T19CTEtfTk9fUEFSVF9TQ0FOCj4gK3N0YXRpYyBpbnQgcGFydGl0aW9uc19zY2FubmluZ19kaXNh
YmxlIF9fcmVhZF9tb3N0bHk7Cj4gKwo+ICtzdGF0aWMgaW50IF9faW5pdCBwYXJ0aXRpb25zX3Nj
YW5uaW5nX3NldHVwKGNoYXIgKl9fdW51c2VkKQo+ICt7Cj4gKwlwYXJ0aXRpb25zX3NjYW5uaW5n
X2Rpc2FibGUgPSAxOwo+ICsJcmV0dXJuIDE7Cj4gK30KPiArX19zZXR1cCgibm9wYXJ0c2NhbiIs
IHBhcnRpdGlvbnNfc2Nhbm5pbmdfc2V0dXApOwo+ICsjZW5kaWYKPiArI2VuZGlmCj4gKwo+ICAg
c3RhdGljIGludCB2aXJ0YmxrX3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ICAg
ewo+ICAgCXN0cnVjdCB2aXJ0aW9fYmxrICp2YmxrOwo+IEBAIC03OTAsNiArODAzLDEzIEBAIHN0
YXRpYyBpbnQgdmlydGJsa19wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiAgIAl2
YmxrLT5kaXNrLT5mbGFncyB8PSBHRU5IRF9GTF9FWFRfREVWVDsKPiAgIAl2YmxrLT5pbmRleCA9
IGluZGV4Owo+Cj4gKyNpZmRlZiBDT05GSUdfVklSVElPX0JMS19OT19QQVJUX1NDQU4KPiArCWlm
ICh1bmxpa2VseShwYXJ0aXRpb25zX3NjYW5uaW5nX2Rpc2FibGUpKQo+ICsJCS8qIGRpc2FibGUg
cGFydGl0aW9ucyBzY2FubmluZyBpZiBpdCB3YXMgc3RhdGVkIGluIHZpcnRpbyBmZWF0dXJlcyov
Cj4gKwkJaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fQkxLX0ZfTk9fUEFSVF9T
Q0FOKSkKPiArCQkJdmJsay0+ZGlzay0+ZmxhZ3MgfD0gR0VOSERfRkxfTk9fUEFSVF9TQ0FOOwo+
ICsjZW5kaWYKPiArCj4gICAJLyogY29uZmlndXJlIHF1ZXVlIGZsdXNoIHN1cHBvcnQgKi8KPiAg
IAl2aXJ0YmxrX3VwZGF0ZV9jYWNoZV9tb2RlKHZkZXYpOwo+Cj4gQEAgLTk2Niw2ICs5ODYsOSBA
QCBzdGF0aWMgdW5zaWduZWQgaW50IGZlYXR1cmVzX2xlZ2FjeVtdID0gewo+ICAgCVZJUlRJT19C
TEtfRl9STywgVklSVElPX0JMS19GX0JMS19TSVpFLAo+ICAgCVZJUlRJT19CTEtfRl9GTFVTSCwg
VklSVElPX0JMS19GX1RPUE9MT0dZLCBWSVJUSU9fQkxLX0ZfQ09ORklHX1dDRSwKPiAgIAlWSVJU
SU9fQkxLX0ZfTVEsIFZJUlRJT19CTEtfRl9ESVNDQVJELCBWSVJUSU9fQkxLX0ZfV1JJVEVfWkVS
T0VTLAo+ICsjaWZkZWYgQ09ORklHX1ZJUlRJT19CTEtfTk9fUEFSVF9TQ0FOCj4gKwlWSVJUSU9f
QkxLX0ZfTk9fUEFSVF9TQ0FOLAo+ICsjZW5kaWYKPiAgIH0KPiAgIDsKPiAgIHN0YXRpYyB1bnNp
Z25lZCBpbnQgZmVhdHVyZXNbXSA9IHsKPiBAQCAtOTczLDYgKzk5Niw5IEBAIHN0YXRpYyB1bnNp
Z25lZCBpbnQgZmVhdHVyZXNbXSA9IHsKPiAgIAlWSVJUSU9fQkxLX0ZfUk8sIFZJUlRJT19CTEtf
Rl9CTEtfU0laRSwKPiAgIAlWSVJUSU9fQkxLX0ZfRkxVU0gsIFZJUlRJT19CTEtfRl9UT1BPTE9H
WSwgVklSVElPX0JMS19GX0NPTkZJR19XQ0UsCj4gICAJVklSVElPX0JMS19GX01RLCBWSVJUSU9f
QkxLX0ZfRElTQ0FSRCwgVklSVElPX0JMS19GX1dSSVRFX1pFUk9FUywKPiArI2lmZGVmIENPTkZJ
R19WSVJUSU9fQkxLX05PX1BBUlRfU0NBTgo+ICsJVklSVElPX0JMS19GX05PX1BBUlRfU0NBTiwK
PiArI2VuZGlmCj4gICB9Owo+Cj4gICBzdGF0aWMgc3RydWN0IHZpcnRpb19kcml2ZXIgdmlydGlv
X2JsayA9IHsKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19ibGsuaCBi
L2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fYmxrLmgKPiBpbmRleCBkODg4ZjAxM2Q5ZmYuLjli
MzgxNjc1MzQyYSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX2Jsay5o
Cj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19ibGsuaAo+IEBAIC00MCw2ICs0MCw3
IEBACj4gICAjZGVmaW5lIFZJUlRJT19CTEtfRl9NUQkJMTIJLyogc3VwcG9ydCBtb3JlIHRoYW4g
b25lIHZxICovCj4gICAjZGVmaW5lIFZJUlRJT19CTEtfRl9ESVNDQVJECTEzCS8qIERJU0NBUkQg
aXMgc3VwcG9ydGVkICovCj4gICAjZGVmaW5lIFZJUlRJT19CTEtfRl9XUklURV9aRVJPRVMJMTQJ
LyogV1JJVEUgWkVST0VTIGlzIHN1cHBvcnRlZCAqLwo+ICsjZGVmaW5lIFZJUlRJT19CTEtfRl9O
T19QQVJUX1NDQU4JMTYJLyogRGlzYWJsZSBwYXJ0aXRpb24gc2Nhbm5pbmcgKi8KPgo+ICAgLyog
TGVnYWN5IGZlYXR1cmUgYml0cyAqLwo+ICAgI2lmbmRlZiBWSVJUSU9fQkxLX05PX0xFR0FDWQo+
IC0tCj4gMi4yNC4zIChBcHBsZSBHaXQtMTI4KQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
