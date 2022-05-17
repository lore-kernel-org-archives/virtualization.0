Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA8DC433EF
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 03:28:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CEE7417CD;
	Tue, 17 May 2022 03:28:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gYNUUZJfDI6G; Tue, 17 May 2022 03:28:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E475D418F7;
	Tue, 17 May 2022 03:28:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B00FBC0039;
	Tue, 17 May 2022 03:28:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15739C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:28:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E9D18418F7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:28:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hyJIuSrgVhBj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:28:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CCC22417CD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652758127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yar6Yihs2foNxgYX4kdXC2OUYwTS2j94KEh9Z01XwIk=;
 b=WCM6YqAY3xBxSdijs+W158jtB2JUG6nwOCark24h0YdL+B00gx92hd5ENwNY8CKWLy/dKk
 rUAVyuWLfyGsGocA2nJq1jh4OUmCHnMSqWb5xQ6QrTWFRhcdXdBSjg4E0liKbP7bCBGojO
 BrmlsrQkrRX23F9BSlIRh7qqCTcjtVI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-MXaCalciNzSOaIDhW5GNfQ-1; Mon, 16 May 2022 23:28:46 -0400
X-MC-Unique: MXaCalciNzSOaIDhW5GNfQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 rj11-20020a17090b3e8b00b001df51eb1831so713860pjb.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 20:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Yar6Yihs2foNxgYX4kdXC2OUYwTS2j94KEh9Z01XwIk=;
 b=xmycxyHJ0L6y39ojJGM0kksW3qL8vqpeLHCjkr/tn7zGraErALV+EtjP6kqDIqd/F3
 /8mA5/Pux+Y41FvL+lFZv2kY32p7bT8yBONl3PGfQb35TF8NbnQZOdJJdoCJlJk1Molg
 twHiCHC/osoftlBP5b8By66ciSrSe3dqY3/CV9FAbYnACqrxFxRpoFK+brXuZyMOvIXW
 oTx5gr3ppHwUPl4+5Pb/eKgv2Jj1hylnLJ2xNb4x5oKr85MXdES+F6Ty87087gk8Dr9A
 3zMlvirzlmTDaMn1Jzh6mpm6oqy5aFj/x9n3ALgNdy9dI5x5GCdrB6ex9HZvq0QusDjR
 HdrA==
X-Gm-Message-State: AOAM5321ux/crkmKyzHrESrvPT+yDOc04ala7JWz6Uth9NtzzsMdrxy8
 +um4AkmvwzP8swetWUFqvZhpTIPDmy77KELxt/llfC036nhNmCPGpgyladnV4tgyQwBRma5V9c0
 4vDexS57aEiPutnn5nR8vXmu9kCSxcIqYSuPnoiBpcQ==
X-Received: by 2002:a17:90b:4f43:b0:1dc:c1f1:59c9 with SMTP id
 pj3-20020a17090b4f4300b001dcc1f159c9mr22748642pjb.183.1652758124771; 
 Mon, 16 May 2022 20:28:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzdE874mgeE+sZpAIQjLJOsZiViyFteT4Yb7vCUtu0E8nJ+khrWBQT1XmQXyE6bVy3UdP2zA==
X-Received: by 2002:a17:90b:4f43:b0:1dc:c1f1:59c9 with SMTP id
 pj3-20020a17090b4f4300b001dcc1f159c9mr22748619pjb.183.1652758124484; 
 Mon, 16 May 2022 20:28:44 -0700 (PDT)
Received: from [10.72.12.227] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 bb2-20020a17090b008200b001cd630f301fsm435591pjb.36.2022.05.16.20.28.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 May 2022 20:28:44 -0700 (PDT)
Message-ID: <751f1d5f-3798-3154-7764-4b8ac4c4fceb@redhat.com>
Date: Tue, 17 May 2022 11:28:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH V2 8/8] vhost: rename vhost_work_dev_flush
To: Mike Christie <michael.christie@oracle.com>, stefanha@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org, arbn@yandex-team.com
References: <20220515202922.174066-1-michael.christie@oracle.com>
 <20220515202922.174066-9-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220515202922.174066-9-michael.christie@oracle.com>
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzUvMTYgMDQ6MjksIE1pa2UgQ2hyaXN0aWUg5YaZ6YGTOgo+IFRoaXMgcGF0Y2gg
cmVuYW1lcyB2aG9zdF93b3JrX2Rldl9mbHVzaCB0byBqdXN0IHZob3N0X2Rldl9mbHVzaCB0bwo+
IHJlbGZlY3QgdGhhdCBpdCBmbHVzaGVzIGV2ZXJ5dGhpbmcgb24gdGhlIGRldmljZSBhbmQgdGhh
dCBkcml2ZXJzCj4gZG9uJ3Qga25vdy9jYXJlIHRoYXQgcG9sbHMgYXJlIGJhc2VkIG9uIHZob3N0
X3dvcmtzLiBEcml2ZXJzIGp1c3QKPiBmbHVzaCB0aGUgZW50aXJlIGRldmljZSBhbmQgcG9sbHMs
IGFuZCB3b3JrcyBmb3Igdmhvc3Qtc2NzaQo+IG1hbmFnZW1lbnQgVE1GcyBhbmQgSU8gbmV0IHZp
cnRxdWV1ZXMsIGV0YyBhbGwgYXJlIGZsdXNoZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNaWtlIENo
cmlzdGllIDxtaWNoYWVsLmNocmlzdGllQG9yYWNsZS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmhvc3QvbmV0LmMg
ICB8ICA0ICsrLS0KPiAgIGRyaXZlcnMvdmhvc3Qvc2NzaS5jICB8ICAyICstCj4gICBkcml2ZXJz
L3Zob3N0L3Rlc3QuYyAgfCAgMiArLQo+ICAgZHJpdmVycy92aG9zdC92aG9zdC5jIHwgMTAgKysr
KystLS0tLQo+ICAgZHJpdmVycy92aG9zdC92aG9zdC5oIHwgIDIgKy0KPiAgIGRyaXZlcnMvdmhv
c3QvdnNvY2suYyB8ICAyICstCj4gICA2IGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyks
IDExIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvbmV0LmMgYi9k
cml2ZXJzL3Zob3N0L25ldC5jCj4gaW5kZXggMDQ3YjdiMDUxMDlhLi4wZTRmZjZhMDhmNWYgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC9uZXQuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvbmV0
LmMKPiBAQCAtMTM3Niw3ICsxMzc2LDcgQEAgc3RhdGljIHZvaWQgdmhvc3RfbmV0X3N0b3Aoc3Ry
dWN0IHZob3N0X25ldCAqbiwgc3RydWN0IHNvY2tldCAqKnR4X3NvY2ssCj4gICAKPiAgIHN0YXRp
YyB2b2lkIHZob3N0X25ldF9mbHVzaChzdHJ1Y3Qgdmhvc3RfbmV0ICpuKQo+ICAgewo+IC0Jdmhv
c3Rfd29ya19kZXZfZmx1c2goJm4tPmRldik7Cj4gKwl2aG9zdF9kZXZfZmx1c2goJm4tPmRldik7
Cj4gICAJaWYgKG4tPnZxc1tWSE9TVF9ORVRfVlFfVFhdLnVidWZzKSB7Cj4gICAJCW11dGV4X2xv
Y2soJm4tPnZxc1tWSE9TVF9ORVRfVlFfVFhdLnZxLm11dGV4KTsKPiAgIAkJbi0+dHhfZmx1c2gg
PSB0cnVlOwo+IEBAIC0xNTY2LDcgKzE1NjYsNyBAQCBzdGF0aWMgbG9uZyB2aG9zdF9uZXRfc2V0
X2JhY2tlbmQoc3RydWN0IHZob3N0X25ldCAqbiwgdW5zaWduZWQgaW5kZXgsIGludCBmZCkKPiAg
IAl9Cj4gICAKPiAgIAlpZiAob2xkc29jaykgewo+IC0JCXZob3N0X3dvcmtfZGV2X2ZsdXNoKCZu
LT5kZXYpOwo+ICsJCXZob3N0X2Rldl9mbHVzaCgmbi0+ZGV2KTsKPiAgIAkJc29ja2ZkX3B1dChv
bGRzb2NrKTsKPiAgIAl9Cj4gICAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC9zY3NpLmMg
Yi9kcml2ZXJzL3Zob3N0L3Njc2kuYwo+IGluZGV4IDk0NTM1YzgxM2VmNy4uZmZkOWU2YzJmZmMx
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3Qvc2NzaS5jCj4gKysrIGIvZHJpdmVycy92aG9z
dC9zY3NpLmMKPiBAQCAtMTQzNiw3ICsxNDM2LDcgQEAgc3RhdGljIHZvaWQgdmhvc3Rfc2NzaV9m
bHVzaChzdHJ1Y3Qgdmhvc3Rfc2NzaSAqdnMpCj4gICAJCWtyZWZfcHV0KCZvbGRfaW5mbGlnaHRb
aV0tPmtyZWYsIHZob3N0X3Njc2lfZG9uZV9pbmZsaWdodCk7Cj4gICAKPiAgIAkvKiBGbHVzaCBi
b3RoIHRoZSB2aG9zdCBwb2xsIGFuZCB2aG9zdCB3b3JrICovCj4gLQl2aG9zdF93b3JrX2Rldl9m
bHVzaCgmdnMtPmRldik7Cj4gKwl2aG9zdF9kZXZfZmx1c2goJnZzLT5kZXYpOwo+ICAgCj4gICAJ
LyogV2FpdCBmb3IgYWxsIHJlcXMgaXNzdWVkIGJlZm9yZSB0aGUgZmx1c2ggdG8gYmUgZmluaXNo
ZWQgKi8KPiAgIAlmb3IgKGkgPSAwOyBpIDwgVkhPU1RfU0NTSV9NQVhfVlE7IGkrKykKPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92aG9zdC90ZXN0LmMgYi9kcml2ZXJzL3Zob3N0L3Rlc3QuYwo+IGlu
ZGV4IGE2M2E2MjZhNTU0ZS4uODc0OThjMTEwOWZlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhv
c3QvdGVzdC5jCj4gKysrIGIvZHJpdmVycy92aG9zdC90ZXN0LmMKPiBAQCAtMTQ2LDcgKzE0Niw3
IEBAIHN0YXRpYyB2b2lkIHZob3N0X3Rlc3Rfc3RvcChzdHJ1Y3Qgdmhvc3RfdGVzdCAqbiwgdm9p
ZCAqKnByaXZhdGVwKQo+ICAgCj4gICBzdGF0aWMgdm9pZCB2aG9zdF90ZXN0X2ZsdXNoKHN0cnVj
dCB2aG9zdF90ZXN0ICpuKQo+ICAgewo+IC0Jdmhvc3Rfd29ya19kZXZfZmx1c2goJm4tPmRldik7
Cj4gKwl2aG9zdF9kZXZfZmx1c2goJm4tPmRldik7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyBpbnQg
dmhvc3RfdGVzdF9yZWxlYXNlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmKQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMgYi9kcml2ZXJzL3Zob3N0L3Zob3N0
LmMKPiBpbmRleCA5ZjhkZTA0YmI2NzMuLjcxNmE4MGM2MWZhOSAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL3Zob3N0L3Zob3N0LmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiBAQCAtMjMx
LDcgKzIzMSw3IEBAIHZvaWQgdmhvc3RfcG9sbF9zdG9wKHN0cnVjdCB2aG9zdF9wb2xsICpwb2xs
KQo+ICAgfQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwodmhvc3RfcG9sbF9zdG9wKTsKPiAgIAo+IC12
b2lkIHZob3N0X3dvcmtfZGV2X2ZsdXNoKHN0cnVjdCB2aG9zdF9kZXYgKmRldikKPiArdm9pZCB2
aG9zdF9kZXZfZmx1c2goc3RydWN0IHZob3N0X2RldiAqZGV2KQo+ICAgewo+ICAgCXN0cnVjdCB2
aG9zdF9mbHVzaF9zdHJ1Y3QgZmx1c2g7Cj4gICAKPiBAQCAtMjQzLDcgKzI0Myw3IEBAIHZvaWQg
dmhvc3Rfd29ya19kZXZfZmx1c2goc3RydWN0IHZob3N0X2RldiAqZGV2KQo+ICAgCQl3YWl0X2Zv
cl9jb21wbGV0aW9uKCZmbHVzaC53YWl0X2V2ZW50KTsKPiAgIAl9Cj4gICB9Cj4gLUVYUE9SVF9T
WU1CT0xfR1BMKHZob3N0X3dvcmtfZGV2X2ZsdXNoKTsKPiArRVhQT1JUX1NZTUJPTF9HUEwodmhv
c3RfZGV2X2ZsdXNoKTsKPiAgIAo+ICAgdm9pZCB2aG9zdF93b3JrX3F1ZXVlKHN0cnVjdCB2aG9z
dF9kZXYgKmRldiwgc3RydWN0IHZob3N0X3dvcmsgKndvcmspCj4gICB7Cj4gQEAgLTUzMCw3ICs1
MzAsNyBAQCBzdGF0aWMgaW50IHZob3N0X2F0dGFjaF9jZ3JvdXBzKHN0cnVjdCB2aG9zdF9kZXYg
KmRldikKPiAgIAlhdHRhY2gub3duZXIgPSBjdXJyZW50Owo+ICAgCXZob3N0X3dvcmtfaW5pdCgm
YXR0YWNoLndvcmssIHZob3N0X2F0dGFjaF9jZ3JvdXBzX3dvcmspOwo+ICAgCXZob3N0X3dvcmtf
cXVldWUoZGV2LCAmYXR0YWNoLndvcmspOwo+IC0Jdmhvc3Rfd29ya19kZXZfZmx1c2goZGV2KTsK
PiArCXZob3N0X2Rldl9mbHVzaChkZXYpOwo+ICAgCXJldHVybiBhdHRhY2gucmV0Owo+ICAgfQo+
ICAgCj4gQEAgLTY1Nyw3ICs2NTcsNyBAQCB2b2lkIHZob3N0X2Rldl9zdG9wKHN0cnVjdCB2aG9z
dF9kZXYgKmRldikKPiAgIAkJCXZob3N0X3BvbGxfc3RvcCgmZGV2LT52cXNbaV0tPnBvbGwpOwo+
ICAgCX0KPiAgIAo+IC0Jdmhvc3Rfd29ya19kZXZfZmx1c2goZGV2KTsKPiArCXZob3N0X2Rldl9m
bHVzaChkZXYpOwo+ICAgfQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwodmhvc3RfZGV2X3N0b3ApOwo+
ICAgCj4gQEAgLTE3MTEsNyArMTcxMSw3IEBAIGxvbmcgdmhvc3RfdnJpbmdfaW9jdGwoc3RydWN0
IHZob3N0X2RldiAqZCwgdW5zaWduZWQgaW50IGlvY3RsLCB2b2lkIF9fdXNlciAqYXJnCj4gICAJ
bXV0ZXhfdW5sb2NrKCZ2cS0+bXV0ZXgpOwo+ICAgCj4gICAJaWYgKHBvbGxzdG9wICYmIHZxLT5o
YW5kbGVfa2ljaykKPiAtCQl2aG9zdF93b3JrX2Rldl9mbHVzaCh2cS0+cG9sbC5kZXYpOwo+ICsJ
CXZob3N0X2Rldl9mbHVzaCh2cS0+cG9sbC5kZXYpOwo+ICAgCXJldHVybiByOwo+ICAgfQo+ICAg
RVhQT1JUX1NZTUJPTF9HUEwodmhvc3RfdnJpbmdfaW9jdGwpOwo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3Zob3N0L3Zob3N0LmggYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmgKPiBpbmRleCBhZWI4ZTFh
ZDE0OTYuLmQwMmFkZjFiMmJmOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmgK
PiArKysgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmgKPiBAQCAtNDUsNyArNDUsNyBAQCB2b2lkIHZo
b3N0X3BvbGxfaW5pdChzdHJ1Y3Qgdmhvc3RfcG9sbCAqcG9sbCwgdmhvc3Rfd29ya19mbl90IGZu
LAo+ICAgaW50IHZob3N0X3BvbGxfc3RhcnQoc3RydWN0IHZob3N0X3BvbGwgKnBvbGwsIHN0cnVj
dCBmaWxlICpmaWxlKTsKPiAgIHZvaWQgdmhvc3RfcG9sbF9zdG9wKHN0cnVjdCB2aG9zdF9wb2xs
ICpwb2xsKTsKPiAgIHZvaWQgdmhvc3RfcG9sbF9xdWV1ZShzdHJ1Y3Qgdmhvc3RfcG9sbCAqcG9s
bCk7Cj4gLXZvaWQgdmhvc3Rfd29ya19kZXZfZmx1c2goc3RydWN0IHZob3N0X2RldiAqZGV2KTsK
PiArdm9pZCB2aG9zdF9kZXZfZmx1c2goc3RydWN0IHZob3N0X2RldiAqZGV2KTsKPiAgIAo+ICAg
c3RydWN0IHZob3N0X2xvZyB7Cj4gICAJdTY0IGFkZHI7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmhvc3QvdnNvY2suYyBiL2RyaXZlcnMvdmhvc3QvdnNvY2suYwo+IGluZGV4IDk2YmU2MzY5NzEx
Ny4uMzY4MzMwNDE3YmRlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdnNvY2suYwo+ICsr
KyBiL2RyaXZlcnMvdmhvc3QvdnNvY2suYwo+IEBAIC03MDUsNyArNzA1LDcgQEAgc3RhdGljIGlu
dCB2aG9zdF92c29ja19kZXZfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAq
ZmlsZSkKPiAgIAo+ICAgc3RhdGljIHZvaWQgdmhvc3RfdnNvY2tfZmx1c2goc3RydWN0IHZob3N0
X3Zzb2NrICp2c29jaykKPiAgIHsKPiAtCXZob3N0X3dvcmtfZGV2X2ZsdXNoKCZ2c29jay0+ZGV2
KTsKPiArCXZob3N0X2Rldl9mbHVzaCgmdnNvY2stPmRldik7Cj4gICB9Cj4gICAKPiAgIHN0YXRp
YyB2b2lkIHZob3N0X3Zzb2NrX3Jlc2V0X29ycGhhbnMoc3RydWN0IHNvY2sgKnNrKQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
