Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D66EC47083
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 07:30:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6AB261396
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 07:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AB261396
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A27AE40177;
	Wed,  2 Jun 2021 07:30:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N9KDb7H9cepI; Wed,  2 Jun 2021 07:30:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3F9C401D2;
	Wed,  2 Jun 2021 07:30:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1DA7C000D;
	Wed,  2 Jun 2021 07:30:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA8CCC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:30:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98E2260705
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:30:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j5JyFJBqqimT
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:30:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A5008606AF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622619003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6AIMJ1wDfcsnadW+2812aa3UstJXUN6qADShYHbFMHI=;
 b=aGC1pFcXT2+RnDXd/2fNjDD55H3ZGzOavgu2Y2MBxf+U4DzZzafCDuEAXwVUhLU84owikL
 8qhwKnXHCKD9YPuJYvZkvR1ERvI8DOg+H1C84BDLoYCztBeINZP5eoSjpBNL+CmA7/W5dy
 1NLKdpSYUoDEvmyuINvY9IPr79B4e7I=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-ixOfDAR0OxaCXtT4HHoQcg-1; Wed, 02 Jun 2021 03:30:01 -0400
X-MC-Unique: ixOfDAR0OxaCXtT4HHoQcg-1
Received: by mail-pg1-f198.google.com with SMTP id
 17-20020a630b110000b029022064e7cdcfso1157814pgl.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Jun 2021 00:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=6AIMJ1wDfcsnadW+2812aa3UstJXUN6qADShYHbFMHI=;
 b=aIJhsNGN96k9qyejAnan8nhr72C9b6AK9aF9RhdSFCyaska0ZFyhPCl3wjYWM3YnOh
 x0klombN1ay2mP2Ly+h+ovMkob8jCKF/4SavY5RZ2/mOpo6TvUuRInKyIykY4uApAMNU
 SUfsvseeuiKBmvNqGkT0HgToBw+ZTAmKVtz/VpCEqD+FNYdhAbxSvrw8PAPg88jpvbQn
 Qe7FlD1gclGHTxkGBO4AfcYYEFAoNleGRg3vjTGu+EFS9MRt6ooLhXgQt6mQ5n9OFegF
 iqLgPAVZbTVEbpceArx2pKPdMgd32YNa+lEmlDgzIdDZabs6ARHSq0QtxC0PhxWsrFeq
 t38g==
X-Gm-Message-State: AOAM533lZIBOR1oC/Icj3B38z9G4aKOHnNBK3QVfRZvv7GsyjtkJ0kRF
 tRxc31Q2EiCoLNBOt2xOOBkDZUw0stYlOn4XAyyga8sC4tuwvEzSSXmgxsWeSZVXNW0lKu4V6ev
 nNeWxyNVpjbGdwtcrjYAAYuyPj6TQec2KFEFGL6S1GQ==
X-Received: by 2002:a17:90a:d70f:: with SMTP id
 y15mr3389706pju.220.1622619000890; 
 Wed, 02 Jun 2021 00:30:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymYtLtE9oER1yh8UIGEqRJzss30I19zXLCYKDFA2oiIvIAwt1lDsiyl1oPiS6Uodd+VnaxGg==
X-Received: by 2002:a17:90a:d70f:: with SMTP id
 y15mr3389692pju.220.1622619000630; 
 Wed, 02 Jun 2021 00:30:00 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c16sm14933694pfd.206.2021.06.02.00.29.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 00:30:00 -0700 (PDT)
Subject: Re: [PATCH 2/3] vdpa/mlx5: Only return vq ready if vq is initialized
To: Eli Cohen <elic@nvidia.com>
References: <20210531160448.31537-1-elic@nvidia.com>
 <0fbd8484-9e8b-d7cc-4996-74306e6e2867@redhat.com>
 <20210601041351.GC203469@mtl-vdi-166.wap.labs.mlnx>
 <67b26a20-b418-4893-a42f-f03852c2123e@redhat.com>
 <20210601102129.GB215954@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <76a44f0b-91c7-595b-f3a8-1d07e2f1bc78@redhat.com>
Date: Wed, 2 Jun 2021 15:29:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601102129.GB215954@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

CuWcqCAyMDIxLzYvMSDkuIvljYg2OjIxLCBFbGkgQ29oZW4g5YaZ6YGTOgo+IE9uIFR1ZSwgSnVu
IDAxLCAyMDIxIGF0IDAxOjAzOjM2UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+IOWcqCAy
MDIxLzYvMSDkuIvljYgxMjoxMywgRWxpIENvaGVuIOWGmemBkzoKPj4+IE9uIFR1ZSwgSnVuIDAx
LCAyMDIxIGF0IDEwOjE4OjA0QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4g5ZyoIDIw
MjEvNi8xIOS4iuWNiDEyOjA0LCBFbGkgQ29oZW4g5YaZ6YGTOgo+Pj4+PiBPbmx5IHJldHVybiB0
aGUgdmFsdWUgb2YgdGhlIHJlYWR5IGZpZWxkIGlmIHRoZSBWUSBpcyBpbml0aWFsaXplZCBpbgo+
Pj4+PiB3aGljaCBjYXNlIHRoZSB2YWx1ZSBvZiB0aGUgZmllbGQgaXMgdmFsaWQuCj4+Pj4+Cj4+
Pj4+IEZhaWxpbmcgdG8gZG8gc28gY2FuIHJlc3VsdCBpbiB2aXJ0aW9fdmRwYSBmYWlsaW5nIHRv
IGxvYWQgaWYgdGhlIGRldmljZQo+Pj4+PiB3YXMgcHJldmlvdXNseSB1c2VkIGJ5IHZob3N0X3Zk
cGEgYW5kIHRoZSBvbGQgdmFsdWVzIGFyZSByZWFkeS4KPj4+Pj4gdmlydGlvX3ZkcGEgZXhwZWN0
cyB0byBmaW5kIFZRcyBpbiAibm90IHJlYWR5IiBzdGF0ZS4KPj4+Pj4KPj4+Pj4gRml4ZXM6IDFh
ODZiMzc3YWEyMSAoInZkcGEvbWx4NTogQWRkIFZEUEEgZHJpdmVyIGZvciBzdXBwb3J0ZWQgbWx4
NSBkZXZpY2VzIikKPj4+Pj4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5j
b20+Cj4+Pj4+IC0tLQo+Pj4+PiAgICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
IHwgMiArLQo+Pj4+PiAgICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4
NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+Pj4gaW5kZXgg
MDJhMDU0OTIyMDRjLi5mNmI2ODBkMmFiMWMgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMKPj4+Pj4gQEAgLTE0MDcsNyArMTQwNyw3IEBAIHN0YXRpYyBib29sIG1seDVf
dmRwYV9nZXRfdnFfcmVhZHkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4KQo+Pj4+
PiAgICAgCXN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYobXZk
ZXYpOwo+Pj4+PiAgICAgCXN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlICptdnEgPSAmbmRldi0+
dnFzW2lkeF07Cj4+Pj4+IC0JcmV0dXJuIG12cS0+cmVhZHk7Cj4+Pj4+ICsJcmV0dXJuIG12cS0+
aW5pdGlhbGl6ZWQgJiYgbXZxLT5yZWFkeTsKPj4+PiBJIHRoaW5rIHRoZSBtb3JlIHN1aXRhYmxl
IGZpeCBpcyB0byByZXNldCBtdnEtPnJlYWR5IGR1cmluZyByZXNldC4gVGhlCj4+Pj4gdnFfcmVh
ZHkgc2hvdWxkIGZvbGxvdyB0aGUgcXVldWVfZW5hYmxlIHNlbWFudGljIGluIHZpcnRpby1wY2k6
Cj4+Pj4KPj4+PiAiCj4+Pj4gVGhlIGRldmljZSBNVVNUIHByZXNlbnQgYSAwIGluIHF1ZXVlX2Vu
YWJsZSBvbiByZXNldC4KPj4+PiAiCj4+PiBUaGlua2luZyBhZ2FpbiwgSSB0aGluayB3ZSBzaG91
bGQgY2FsbCBzZXRfdnFfcmVhZHkoKSBmcm9tCj4+PiBxZW11L3ZpcnRpb192ZHBhIGV0Yy4gYWZ0
ZXIgcmVzZXQgdG8gZXhwbGljaXRseSBzZXQgcmVhZHkgdG8gZmFsc2UuCj4+Cj4+IFRoaXMgaXMg
bm90IHdoYXQgSSByZWFkIGZyb20gdGhlIHNwZWMgYW5kIGhvdyB0aGUgY3VycmVudCBkcml2ZXIg
YmVoYXZlLgo+Pgo+PiBBbmQgSSBkb24ndCBzZWUgd2h5IHdlIG5lZWQgdG8gc3RpY2sgdG8gMSBh
ZnRlciB0aGUgcmVzZXQuCj4gTGlrZSB5b3Ugc2FpZCBiZWxvdywgdGhpcyBtdXN0IGJlIGNsYXJp
ZmllZCBieSB0aGUgc3BlYy4KCgpJIHdpbGwgYWRkIHRoaXMgdG8gbXkgdG9kbyBsaXN0LgoKCj4g
QmVjYXVzZSBteQo+IHVuZGVyc3RhbmRpbmcgb2YgdGhlIHRleHQgaXMgdGhhdCB0aGUgcmVhZHkg
ZmxhZyBpcyBhIG1lYW5zIGZvciB0aGUKPiBkcml2ZXIgdG8gdGVsbCB0aGUgZGV2aWNlIHdoZXRo
ZXIgaXQgbWF5IG9yIG1heSBub3QgZXhlY3V0ZSByZXF1ZXN0cy4gU28KPiBmb2xsb3dpbmcgdGhp
cyByZWFzb25pbmcsIHRoZSBkcml2ZXIgc2hvdWxkIHRlbGwgdGhlIGRldmljZSB3aGVuIHJlYWR5
Cj4gc2hvdWxkIGJlIHplcm8uIEFzIHlvdSBzdWdnZXN0LCBhZnRlciByZXNldC4KCgpBbm90aGVy
IHRob3VnaHQsIHJlc2V0IHNob3VsZCBwcmV2ZW50IHRoZSBkZXZpY2UgZnJvbSBleGVjdXRpbmcg
cmVxdWVzdHMgCm9uIGVhY2ggcXVldWUuIEluIHRoaXMgY2FzZSwgcHJlc2VudGluZyB2cV9yZWFk
eSB0byB6ZXJvIG1ha2Ugc2Vuc2UuIApPdGhlcndpc2UgdGhlcmUgd291bGQgYmUgYSBjb25mbGlj
dC4KClRoYW5rcwoKCj4KPiBNZWFud2hpbGUgSSBhbSBnb2luZyB0byBjaGFuZ2UgdGhlIGNvZGUg
dG8gcmVzZXQgcmVhZHkgYWZ0ZXIgZGV2aWNlCj4gcmVzZXQuCj4KPj4KPj4+IFRoZSByZWFkeSBp
bmRpY2F0aW9uIGlzIG5vdCBuZWNlc3NhaXJpbHkgYSByZWZsZWN0aW9uIG9mIHRoZSBoYXJkd2Fy
ZQo+Pj4gcXVldWU6Cj4+Pgo+Pj4gIlZpcnR1YWwgcXVldWUgcmVhZHkgYml0Cj4+PiBXcml0aW5n
IG9uZSAoMHgxKSB0byB0aGlzIHJlZ2lzdGVyIG5vdGlmaWVzIHRoZSBkZXZpY2UgdGhhdCBpdCBj
YW4KPj4+IGV4ZWN1dGUgcmVxdWVzdHMgZnJvbSB0aGlzIHZpcnR1YWwgcXVldWUuIFJlYWRpbmcg
ZnJvbSB0aGlzIHJlZ2lzdGVyCj4+PiByZXR1cm5zIHRoZSBsYXN0IHZhbHVlIHdyaXR0ZW4gdG8g
aXQuIEJvdGggcmVhZCBhbmQgd3JpdGUgYWNjZXNzZXMgYXBwbHkKPj4+IHRvIHRoZSBxdWV1ZSBz
ZWxlY3RlZCBieSB3cml0aW5nIHRvIFF1ZXVlU2VsLiIKPj4KPj4gTXkgdW5kZXJzdGFuZGluZyB0
aGF0IHRoaXMgYXBwbGllcyBpZiBub3QgcmVzZXQgaW4gdGhlIG1pZGRsZS4gV2UgY2FuCj4+IGNs
YXJpZnkgdGhpcyBpbiB0aGUgc3BlYyBpZiBuZWVkZWQuCj4+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4K
Pj4+PiBUaGFua3MKPj4+Pgo+Pj4+Cj4+Pj4+ICAgICB9Cj4+Pj4+ICAgICBzdGF0aWMgaW50IG1s
eDVfdmRwYV9zZXRfdnFfc3RhdGUoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4LAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
