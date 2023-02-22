Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C1BC61DA4
	for <virtualization@archiver.kernel.org>; Wed, 22 Feb 2023 03:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7BF0F404BF;
	Wed, 22 Feb 2023 03:56:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7BF0F404BF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OCjW5jQ/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nBPyaXTe_xgM; Wed, 22 Feb 2023 03:56:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B8C16404A5;
	Wed, 22 Feb 2023 03:56:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B8C16404A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80508C0033;
	Wed, 22 Feb 2023 03:56:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8192C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 03:56:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A878281EEA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 03:56:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A878281EEA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OCjW5jQ/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 57nNuRaGXtGd
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 03:56:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 975E081EE8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 975E081EE8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 03:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677038162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ezMuI5YG23ad7qY4EaNZuXK4S2JL7CXJcZVLJx8IXKc=;
 b=OCjW5jQ/nO9f5rFbH2f0dZHH05NWCzMit7MdTgl+mreSJiIBj1lXSpWcukjJ+iMaoWfYPq
 5hfYuBwwGH//62W/v34bDo0NHyCOooSP+Ta0FZozk6w3EShUSec/s41+cJOZGLlWuloTQH
 vQrOZTQjy/EpjVsHf1RCVUSomdA6Iuk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-541-YXMZuMf9PrynfJn42OFUbg-1; Tue, 21 Feb 2023 22:56:01 -0500
X-MC-Unique: YXMZuMf9PrynfJn42OFUbg-1
Received: by mail-pl1-f199.google.com with SMTP id
 j1-20020a170902c3c100b0019a94475927so2916386plj.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 19:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ezMuI5YG23ad7qY4EaNZuXK4S2JL7CXJcZVLJx8IXKc=;
 b=EPc8EGoKgQBn3CmleO9sgM+4Bv71MQzA/TsJ63ldZ54ZUuhITTiM6MVG6+0G9ZGIZo
 CdyNmo73VrMkwdtxOJG2PvUEEZOc1egBYVXAGYi4ggRUovwA0SSh38R+HHfpeqlIqHRK
 BZlZ6YMhzUr6tFHjocvPxpGd0FBWROKO9vBRos/dORDJtZX3jWJVN6wNLspMouttLUQv
 CsiLkvc8CjJTDSr5dYLNmusFbxoKhqkqf9UMU+pQksEojc648HuKVoCactpaGZ9AoTei
 z1Kgb7+isDxMRizzqe7WiNoAUK5668pnZ1eq7c8xU0O2d6XJJywcoR5yH6yyTXgavrJs
 fWzA==
X-Gm-Message-State: AO0yUKUrZy9McvyLplMjIk6tAfAjoOuP1qQfhzYQ1SDBfNGOB0aHacKK
 8s92j4+/K9YLbN2JuTULW5n+16svDrhzYgEiWiQdT1GB7UNkH/9JREI581k1BQ0EjeUJDqaTiVx
 tfiH62bW9Deh58ZZUIAyHYNv2fn7zjrSrrzOz6d4pdA==
X-Received: by 2002:a17:90b:1d01:b0:234:27a4:fba2 with SMTP id
 on1-20020a17090b1d0100b0023427a4fba2mr5912282pjb.18.1677038160411; 
 Tue, 21 Feb 2023 19:56:00 -0800 (PST)
X-Google-Smtp-Source: AK7set/zZDuzN6HImOMgEwUCsIL85iGMzphb5M1qLWzYmswPLzYwBtMNCKMfZWNHlR1LdXLnJE6B3A==
X-Received: by 2002:a17:90b:1d01:b0:234:27a4:fba2 with SMTP id
 on1-20020a17090b1d0100b0023427a4fba2mr5912249pjb.18.1677038160032; 
 Tue, 21 Feb 2023 19:56:00 -0800 (PST)
Received: from [10.72.13.76] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a636116000000b004fbb4a55b64sm2342151pgb.86.2023.02.21.19.55.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Feb 2023 19:55:59 -0800 (PST)
Message-ID: <17716bcb-9281-c5bb-f0c8-7715378569a2@redhat.com>
Date: Wed, 22 Feb 2023 11:55:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 07/13] vdpa: add vdpa net migration state notifier
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230208094253.702672-1-eperezma@redhat.com>
 <20230208094253.702672-8-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230208094253.702672-8-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gautam Dawar <gdawar@xilinx.com>, virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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

CuWcqCAyMDIzLzIvOCAxNzo0MiwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFRoaXMgYWxsb3dz
IG5ldCB0byByZXN0YXJ0IHRoZSBkZXZpY2UgYmFja2VuZCB0byBjb25maWd1cmUgU1ZRIG9uIGl0
Lgo+Cj4gSWRlYWxseSwgdGhlc2UgY2hhbmdlcyBzaG91bGQgbm90IGJlIG5ldCBzcGVjaWZpYy4g
SG93ZXZlciwgdGhlIHZkcGEgbmV0Cj4gYmFja2VuZCBpcyB0aGUgb25lIHdpdGggZW5vdWdoIGtu
b3dsZWRnZSB0byBjb25maWd1cmUgZXZlcnl0aGluZyBiZWNhdXNlCj4gb2Ygc29tZSByZWFzb25z
Ogo+ICogUXVldWVzIG1pZ2h0IG5lZWQgdG8gYmUgc2hhZG93ZWQgb3Igbm90IGRlcGVuZGluZyBv
biBpdHMga2luZCAoY29udHJvbAo+ICAgIHZzIGRhdGEpLgo+ICogUXVldWVzIG5lZWQgdG8gc2hh
cmUgdGhlIHNhbWUgbWFwIHRyYW5zbGF0aW9ucyAoaW92YSB0cmVlKS4KPgo+IEJlY2F1c2Ugb2Yg
dGhhdCBpdCBpcyBjbGVhbmVyIHRvIHJlc3RhcnQgdGhlIHdob2xlIG5ldCBiYWNrZW5kIGFuZAo+
IGNvbmZpZ3VyZSBhZ2FpbiBhcyBleHBlY3RlZCwgc2ltaWxhciB0byBob3cgdmhvc3Qta2VybmVs
IG1vdmVzIGJldHdlZW4KPiB1c2Vyc3BhY2UgYW5kIHBhc3N0aHJvdWdoLgo+Cj4gSWYgbW9yZSBr
aW5kcyBvZiBkZXZpY2VzIG5lZWQgZHluYW1pYyBzd2l0Y2hpbmcgdG8gU1ZRIHdlIGNhbiBjcmVh
dGUgYQo+IGNhbGxiYWNrIHN0cnVjdCBsaWtlIFZob3N0T3BzIGFuZCBtb3ZlIG1vc3Qgb2YgdGhl
IGNvZGUgdGhlcmUuCj4gVmhvc3RPcHMgY2Fubm90IGJlIHJldXNlZCBzaW5jZSBhbGwgdmRwYSBi
YWNrZW5kIHNoYXJlIHRoZW0sIGFuZCB0bwo+IHBlcnNvbmFsaXplIGp1c3QgZm9yIG5ldHdvcmtp
bmcgd291bGQgYmUgdG9vIGhlYXZ5Lgo+Cj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXog
PGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gLS0tCj4gdjM6Cj4gKiBBZGQgVE9ETyB0byB1c2UgdGhl
IHJlc3VtZSBvcGVyYXRpb24gaW4gdGhlIGZ1dHVyZS4KPiAqIFVzZSBtaWdyYXRpb25faW5fc2V0
dXAgYW5kIG1pZ3JhdGlvbl9oYXNfZmFpbGVkIGluc3RlYWQgb2YgYQo+ICAgIGNvbXBsaWNhdGVk
IHN3aXRjaCBjYXNlLgo+IC0tLQo+ICAgbmV0L3Zob3N0LXZkcGEuYyB8IDc2ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQs
IDc2IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9uZXQvdmhvc3QtdmRwYS5jIGIvbmV0
L3Zob3N0LXZkcGEuYwo+IGluZGV4IGRkNjg2YjQ1MTQuLmJjYTEzZjk3ZmQgMTAwNjQ0Cj4gLS0t
IGEvbmV0L3Zob3N0LXZkcGEuYwo+ICsrKyBiL25ldC92aG9zdC12ZHBhLmMKPiBAQCAtMjYsMTIg
KzI2LDE0IEBACj4gICAjaW5jbHVkZSA8ZXJyLmg+Cj4gICAjaW5jbHVkZSAic3RhbmRhcmQtaGVh
ZGVycy9saW51eC92aXJ0aW9fbmV0LmgiCj4gICAjaW5jbHVkZSAibW9uaXRvci9tb25pdG9yLmgi
Cj4gKyNpbmNsdWRlICJtaWdyYXRpb24vbWlzYy5oIgo+ICAgI2luY2x1ZGUgImh3L3ZpcnRpby92
aG9zdC5oIgo+ICAgCj4gICAvKiBUb2RvOm5lZWQgdG8gYWRkIHRoZSBtdWx0aXF1ZXVlIHN1cHBv
cnQgaGVyZSAqLwo+ICAgdHlwZWRlZiBzdHJ1Y3QgVmhvc3RWRFBBU3RhdGUgewo+ICAgICAgIE5l
dENsaWVudFN0YXRlIG5jOwo+ICAgICAgIHN0cnVjdCB2aG9zdF92ZHBhIHZob3N0X3ZkcGE7Cj4g
KyAgICBOb3RpZmllciBtaWdyYXRpb25fc3RhdGU7Cj4gICAgICAgVkhvc3ROZXRTdGF0ZSAqdmhv
c3RfbmV0Owo+ICAgCj4gICAgICAgLyogQ29udHJvbCBjb21tYW5kcyBzaGFkb3cgYnVmZmVycyAq
Lwo+IEBAIC0yNDEsMTAgKzI0Myw3OSBAQCBzdGF0aWMgVmhvc3RWRFBBU3RhdGUgKnZob3N0X3Zk
cGFfbmV0X2ZpcnN0X25jX3ZkcGEoVmhvc3RWRFBBU3RhdGUgKnMpCj4gICAgICAgcmV0dXJuIERP
X1VQQ0FTVChWaG9zdFZEUEFTdGF0ZSwgbmMsIG5jMCk7Cj4gICB9Cj4gICAKPiArc3RhdGljIHZv
aWQgdmhvc3RfdmRwYV9uZXRfbG9nX2dsb2JhbF9lbmFibGUoVmhvc3RWRFBBU3RhdGUgKnMsIGJv
b2wgZW5hYmxlKQo+ICt7Cj4gKyAgICBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiA9ICZzLT52aG9zdF92
ZHBhOwo+ICsgICAgVmlydElPTmV0ICpuOwo+ICsgICAgVmlydElPRGV2aWNlICp2ZGV2Owo+ICsg
ICAgaW50IGRhdGFfcXVldWVfcGFpcnMsIGN2cSwgcjsKPiArICAgIE5ldENsaWVudFN0YXRlICpw
ZWVyOwo+ICsKPiArICAgIC8qIFdlIGFyZSBvbmx5IGNhbGxlZCBvbiB0aGUgZmlyc3QgZGF0YSB2
cXMgYW5kIG9ubHkgaWYgeC1zdnEgaXMgbm90IHNldCAqLwo+ICsgICAgaWYgKHMtPnZob3N0X3Zk
cGEuc2hhZG93X3Zxc19lbmFibGVkID09IGVuYWJsZSkgewo+ICsgICAgICAgIHJldHVybjsKPiAr
ICAgIH0KPiArCj4gKyAgICB2ZGV2ID0gdi0+ZGV2LT52ZGV2Owo+ICsgICAgbiA9IFZJUlRJT19O
RVQodmRldik7CgoKTGV0J3MgdHdlYWsgdGhlIGNvZGUgdG8gbW92ZSB0aG9zZSBpbml0aWFsaXph
dGlvbiB0byB0aGUgYmVnaW5uaW5nIG9mIAp0aGUgZnVuY3Rpb24uCgoKPiArICAgIGlmICghbi0+
dmhvc3Rfc3RhcnRlZCkgewo+ICsgICAgICAgIHJldHVybjsKPiArICAgIH0KCgpXaGF0IGhhcHBl
bnMgaWYgdGhlIHZob3N0IGlzIHN0YXJ0ZWQgZHVyaW5nIHRoZSBsaXZlIG1pZ3JhdGlvbj8KCgo+
ICsKPiArICAgIGRhdGFfcXVldWVfcGFpcnMgPSBuLT5tdWx0aXF1ZXVlID8gbi0+bWF4X3F1ZXVl
X3BhaXJzIDogMTsKPiArICAgIGN2cSA9IHZpcnRpb192ZGV2X2hhc19mZWF0dXJlKHZkZXYsIFZJ
UlRJT19ORVRfRl9DVFJMX1ZRKSA/Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBuLT5tYXhfbmNzIC0gbi0+bWF4X3F1ZXVlX3BhaXJzIDogMDsKPiArICAgIC8qCj4gKyAgICAg
KiBUT0RPOiB2aG9zdF9uZXRfc3RvcCBkb2VzIHN1c3BlbmQsIGdldF9iYXNlIGFuZCByZXNldC4g
V2UgY2FuIGJlIHNtYXJ0ZXIKPiArICAgICAqIGluIHRoZSBmdXR1cmUgYW5kIHJlc3VtZSB0aGUg
ZGV2aWNlIGlmIHJlYWQtb25seSBvcGVyYXRpb25zIGJldHdlZW4KPiArICAgICAqIHN1c3BlbmQg
YW5kIHJlc2V0IGdvZXMgd3JvbmcuCj4gKyAgICAgKi8KPiArICAgIHZob3N0X25ldF9zdG9wKHZk
ZXYsIG4tPm5pYy0+bmNzLCBkYXRhX3F1ZXVlX3BhaXJzLCBjdnEpOwo+ICsKPiArICAgIHBlZXIg
PSBzLT5uYy5wZWVyOwo+ICsgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBkYXRhX3F1ZXVlX3BhaXJz
ICsgY3ZxOyBpKyspIHsKPiArICAgICAgICBWaG9zdFZEUEFTdGF0ZSAqdmRwYV9zdGF0ZTsKPiAr
ICAgICAgICBOZXRDbGllbnRTdGF0ZSAqbmM7Cj4gKwo+ICsgICAgICAgIGlmIChpIDwgZGF0YV9x
dWV1ZV9wYWlycykgewo+ICsgICAgICAgICAgICBuYyA9IHFlbXVfZ2V0X3BlZXIocGVlciwgaSk7
Cj4gKyAgICAgICAgfSBlbHNlIHsKPiArICAgICAgICAgICAgbmMgPSBxZW11X2dldF9wZWVyKHBl
ZXIsIG4tPm1heF9xdWV1ZV9wYWlycyk7Cj4gKyAgICAgICAgfQo+ICsKPiArICAgICAgICB2ZHBh
X3N0YXRlID0gRE9fVVBDQVNUKFZob3N0VkRQQVN0YXRlLCBuYywgbmMpOwo+ICsgICAgICAgIHZk
cGFfc3RhdGUtPnZob3N0X3ZkcGEuc2hhZG93X2RhdGEgPSBlbmFibGU7Cj4gKwo+ICsgICAgICAg
IGlmIChpIDwgZGF0YV9xdWV1ZV9wYWlycykgewo+ICsgICAgICAgICAgICAvKiBEbyBub3Qgb3Zl
cnJpZGUgQ1ZRIHNoYWRvd192cXNfZW5hYmxlZCAqLwo+ICsgICAgICAgICAgICB2ZHBhX3N0YXRl
LT52aG9zdF92ZHBhLnNoYWRvd192cXNfZW5hYmxlZCA9IGVuYWJsZTsKPiArICAgICAgICB9CgoK
SSB3b25kZXIgd2hhdCBoYXBwZW5zIGlmIHRoZSBudW1iZXIgb2YgcXVldWUgcGFpcnMgaXMgY2hh
bmdlZCBkdXJpbmcgCmxpdmUgbWlncmF0aW9uPyBTaG91bGQgd2UgYXNzaWduIGFsbCBxcHMgaW4g
dGhpcyBjYXNlPwoKVGhhbmtzCgoKPiArICAgIH0KPiArCj4gKyAgICByID0gdmhvc3RfbmV0X3N0
YXJ0KHZkZXYsIG4tPm5pYy0+bmNzLCBkYXRhX3F1ZXVlX3BhaXJzLCBjdnEpOwo+ICsgICAgaWYg
KHVubGlrZWx5KHIgPCAwKSkgewo+ICsgICAgICAgIGVycm9yX3JlcG9ydCgidW5hYmxlIHRvIHN0
YXJ0IHZob3N0IG5ldDogJXMoJWQpIiwgZ19zdHJlcnJvcigtciksIC1yKTsKPiArICAgIH0KPiAr
fQo+ICsKPiArc3RhdGljIHZvaWQgdmRwYV9uZXRfbWlncmF0aW9uX3N0YXRlX25vdGlmaWVyKE5v
dGlmaWVyICpub3RpZmllciwgdm9pZCAqZGF0YSkKPiArewo+ICsgICAgTWlncmF0aW9uU3RhdGUg
Km1pZ3JhdGlvbiA9IGRhdGE7Cj4gKyAgICBWaG9zdFZEUEFTdGF0ZSAqcyA9IGNvbnRhaW5lcl9v
Zihub3RpZmllciwgVmhvc3RWRFBBU3RhdGUsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBtaWdyYXRpb25fc3RhdGUpOwo+ICsKPiArICAgIGlmIChtaWdyYXRpb25faW5f
c2V0dXAobWlncmF0aW9uKSkgewo+ICsgICAgICAgIHZob3N0X3ZkcGFfbmV0X2xvZ19nbG9iYWxf
ZW5hYmxlKHMsIHRydWUpOwo+ICsgICAgfSBlbHNlIGlmIChtaWdyYXRpb25faGFzX2ZhaWxlZCht
aWdyYXRpb24pKSB7Cj4gKyAgICAgICAgdmhvc3RfdmRwYV9uZXRfbG9nX2dsb2JhbF9lbmFibGUo
cywgZmFsc2UpOwo+ICsgICAgfQo+ICt9Cj4gKwo+ICAgc3RhdGljIHZvaWQgdmhvc3RfdmRwYV9u
ZXRfZGF0YV9zdGFydF9maXJzdChWaG9zdFZEUEFTdGF0ZSAqcykKPiAgIHsKPiAgICAgICBzdHJ1
Y3Qgdmhvc3RfdmRwYSAqdiA9ICZzLT52aG9zdF92ZHBhOwo+ICAgCj4gKyAgICBhZGRfbWlncmF0
aW9uX3N0YXRlX2NoYW5nZV9ub3RpZmllcigmcy0+bWlncmF0aW9uX3N0YXRlKTsKPiAgICAgICBp
ZiAodi0+c2hhZG93X3Zxc19lbmFibGVkKSB7Cj4gICAgICAgICAgIHYtPmlvdmFfdHJlZSA9IHZo
b3N0X2lvdmFfdHJlZV9uZXcodi0+aW92YV9yYW5nZS5maXJzdCwKPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2LT5pb3ZhX3JhbmdlLmxhc3QpOwo+IEBAIC0y
NzgsNiArMzQ5LDEwIEBAIHN0YXRpYyB2b2lkIHZob3N0X3ZkcGFfbmV0X2NsaWVudF9zdG9wKE5l
dENsaWVudFN0YXRlICpuYykKPiAgIAo+ICAgICAgIGFzc2VydChuYy0+aW5mby0+dHlwZSA9PSBO
RVRfQ0xJRU5UX0RSSVZFUl9WSE9TVF9WRFBBKTsKPiAgIAo+ICsgICAgaWYgKHMtPnZob3N0X3Zk
cGEuaW5kZXggPT0gMCkgewo+ICsgICAgICAgIHJlbW92ZV9taWdyYXRpb25fc3RhdGVfY2hhbmdl
X25vdGlmaWVyKCZzLT5taWdyYXRpb25fc3RhdGUpOwo+ICsgICAgfQo+ICsKPiAgICAgICBkZXYg
PSBzLT52aG9zdF92ZHBhLmRldjsKPiAgICAgICBpZiAoZGV2LT52cV9pbmRleCArIGRldi0+bnZx
cyA9PSBkZXYtPnZxX2luZGV4X2VuZCkgewo+ICAgICAgICAgICBnX2NsZWFyX3BvaW50ZXIoJnMt
PnZob3N0X3ZkcGEuaW92YV90cmVlLCB2aG9zdF9pb3ZhX3RyZWVfZGVsZXRlKTsKPiBAQCAtNzQx
LDYgKzgxNiw3IEBAIHN0YXRpYyBOZXRDbGllbnRTdGF0ZSAqbmV0X3Zob3N0X3ZkcGFfaW5pdChO
ZXRDbGllbnRTdGF0ZSAqcGVlciwKPiAgICAgICBzLT52aG9zdF92ZHBhLmRldmljZV9mZCA9IHZk
cGFfZGV2aWNlX2ZkOwo+ICAgICAgIHMtPnZob3N0X3ZkcGEuaW5kZXggPSBxdWV1ZV9wYWlyX2lu
ZGV4Owo+ICAgICAgIHMtPmFsd2F5c19zdnEgPSBzdnE7Cj4gKyAgICBzLT5taWdyYXRpb25fc3Rh
dGUubm90aWZ5ID0gdmRwYV9uZXRfbWlncmF0aW9uX3N0YXRlX25vdGlmaWVyOwo+ICAgICAgIHMt
PnZob3N0X3ZkcGEuc2hhZG93X3Zxc19lbmFibGVkID0gc3ZxOwo+ICAgICAgIHMtPnZob3N0X3Zk
cGEuaW92YV9yYW5nZSA9IGlvdmFfcmFuZ2U7Cj4gICAgICAgcy0+dmhvc3RfdmRwYS5zaGFkb3df
ZGF0YSA9IHN2cTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
