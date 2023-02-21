Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD24C636D7
	for <virtualization@archiver.kernel.org>; Tue, 21 Feb 2023 05:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 934F36116F;
	Tue, 21 Feb 2023 05:27:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 934F36116F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C2lGmgHx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bWI8MfWMi3qo; Tue, 21 Feb 2023 05:27:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 212436117E;
	Tue, 21 Feb 2023 05:27:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 212436117E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7D52C0033;
	Tue, 21 Feb 2023 05:27:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3285C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 05:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B0487823C6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 05:27:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B0487823C6
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=C2lGmgHx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9gc2jyO0cZA3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 05:27:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 717888234E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 717888234E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 05:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676957251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYckSckbKHBwH8kfTD9dVCbY9JEcejpIIfa4s8CYo70=;
 b=C2lGmgHx8/l8ISwhAEIXN7ju+UX5oiBq3msvvJsnKZtuzQuC9I+OmSq0GxyOqleVG0D7OE
 yE0GtUgOTUqxZ3FvxNKVBWDnMMyJAHigyYxvzAE9PjUeOMEcAKpYUV6xzeCtOWm8xQYCp8
 yVPQqmq+U+g1Gz8GSAUrkIPmeQai2Ps=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-62-O4dygZ2ZNYSY9xrgCR4W2Q-1; Tue, 21 Feb 2023 00:27:17 -0500
X-MC-Unique: O4dygZ2ZNYSY9xrgCR4W2Q-1
Received: by mail-pj1-f69.google.com with SMTP id
 cx12-20020a17090afd8c00b002366e47e91bso1656048pjb.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 21:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jYckSckbKHBwH8kfTD9dVCbY9JEcejpIIfa4s8CYo70=;
 b=2LGZZyDsxQ2Qrh/pLnf3cnf1FM1qR+nnVlx/6uYmKGzSk4j2nfhJT8uVLiuo7SNvRf
 qCpngun9SqpiSUAag2d2zUIhr6mbC7z7RqIlPf4y6pVjDRB7jhAypCm0joVjaQq2W5fk
 UpNLHiUJtt3LbffvBskpUJpyP94qJF7/qLC01I3npF6GduV9pri6e1r8KuN1D1+xdH8z
 qO9EPC4BfaCaBqBoKmXjPlwBpwJSVMk+3EvZQuqVKQmbdzlhfCloXLpDiNhAW3DAMUMC
 p7xkkmFOfkePo3NvKiU03mXDh41YUQAxsPOL5oHIHb2CLZIfjaVtx4quN9GptTBkLUmI
 NTjA==
X-Gm-Message-State: AO0yUKVfnVEfmINWx5WeHm0TqrOQBr4/fC5oCjkgvT4IIq/SLsXvRwWa
 ofX33r0h0jS8jxjBxIVnuewD7myAb+HF3hwFZWsuUUm2CGClgUFOVpLtow7LwxCif6hFDfWE/Od
 WXwmbSeZP/N6/Brp6kAkqYjk7HEGdnoXMaiLlhRyUPw==
X-Received: by 2002:a62:52d7:0:b0:5a8:4bf8:1752 with SMTP id
 g206-20020a6252d7000000b005a84bf81752mr3205416pfb.32.1676957236841; 
 Mon, 20 Feb 2023 21:27:16 -0800 (PST)
X-Google-Smtp-Source: AK7set/B+GHiyc6TxOq5UNQpcp6YODyPrndi8qcbM+x67bp+rNuHxroo+CQTFroZlOLYTl/y7hL8tg==
X-Received: by 2002:a62:52d7:0:b0:5a8:4bf8:1752 with SMTP id
 g206-20020a6252d7000000b005a84bf81752mr3205390pfb.32.1676957236538; 
 Mon, 20 Feb 2023 21:27:16 -0800 (PST)
Received: from [10.72.12.235] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 y25-20020a62b519000000b005a8bc11d259sm8814823pfe.141.2023.02.20.21.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Feb 2023 21:27:16 -0800 (PST)
Message-ID: <5a4749e4-4cd4-4f07-a4db-665772003058@redhat.com>
Date: Tue, 21 Feb 2023 13:27:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 03/13] vdpa: add vhost_vdpa_suspend
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230208094253.702672-1-eperezma@redhat.com>
 <20230208094253.702672-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230208094253.702672-4-eperezma@redhat.com>
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

CuWcqCAyMDIzLzIvOCAxNzo0MiwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFRoZSBmdW5jdGlv
biB2aG9zdC5jOnZob3N0X2Rldl9zdG9wIGZldGNoZXMgdGhlIHZyaW5nIGJhc2Ugc28gdGhlIHZx
Cj4gc3RhdGUgY2FuIGJlIG1pZ3JhdGVkIHRvIG90aGVyIGRldmljZXMuICBIb3dldmVyLCB0aGlz
IGlzIHVucmVsaWFibGUgaW4KPiB2ZHBhLCBzaW5jZSB3ZSBkaWRuJ3Qgc2lnbmFsIHRoZSBkZXZp
Y2UgdG8gc3VzcGVuZCB0aGUgcXVldWVzLCBtYWtpbmcKPiB0aGUgdmFsdWUgZmV0Y2hlZCB1c2Vs
ZXNzLgo+Cj4gU3VzcGVuZCB0aGUgZGV2aWNlIGlmIHBvc3NpYmxlIGJlZm9yZSBmZXRjaGluZyBm
aXJzdCBhbmQgc3Vic2VxdWVudAo+IHZyaW5nIGJhc2VzLgo+Cj4gTW9yZW92ZXIsIHZkcGEgdG90
YWxseSByZXNldCBhbmQgd2lwZXMgdGhlIGRldmljZSBhdCB0aGUgbGFzdCBkZXZpY2UKPiBiZWZv
cmUgZmV0Y2ggaXRzIHZyaW5ncyBiYXNlLCBtYWtpbmcgdGhhdCBvcGVyYXRpb24gdXNlbGVzcyBp
biB0aGUgbGFzdAo+IGRldmljZS4gVGhpcyB3aWxsIGJlIGZpeGVkIGluIGxhdGVyIHBhdGNoZXMg
b2YgdGhpcyBzZXJpZXMuCgoKSXQgd291bGQgYmUgYmV0dGVyIG5vdCBpbnRyb2R1Y2UgYSBidWcg
Zmlyc3QgYW5kIGZpeCBpdCBpbiB0aGUgZm9sbG93aW5nIApwYXRjaC4KCgo+Cj4gU2lnbmVkLW9m
Zi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gLS0tCj4gICBody92
aXJ0aW8vdmhvc3QtdmRwYS5jIHwgMTkgKysrKysrKysrKysrKysrKysrKwo+ICAgaHcvdmlydGlv
L3RyYWNlLWV2ZW50cyB8ICAxICsKPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygr
KQo+Cj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMgYi9ody92aXJ0aW8vdmhv
c3QtdmRwYS5jCj4gaW5kZXggMmU3OWZiZTRiMi4uY2JiZTkyZmZlOCAxMDA2NDQKPiAtLS0gYS9o
dy92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gKysrIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+IEBA
IC0xMTA4LDYgKzExMDgsMjQgQEAgc3RhdGljIHZvaWQgdmhvc3RfdmRwYV9zdnFzX3N0b3Aoc3Ry
dWN0IHZob3N0X2RldiAqZGV2KQo+ICAgICAgIH0KPiAgIH0KPiAgIAo+ICtzdGF0aWMgdm9pZCB2
aG9zdF92ZHBhX3N1c3BlbmQoc3RydWN0IHZob3N0X2RldiAqZGV2KQo+ICt7Cj4gKyAgICBzdHJ1
Y3Qgdmhvc3RfdmRwYSAqdiA9IGRldi0+b3BhcXVlOwo+ICsgICAgaW50IHI7Cj4gKwo+ICsgICAg
aWYgKCF2aG9zdF92ZHBhX2ZpcnN0X2RldihkZXYpIHx8CgoKQW55IHJlYXNvbiB3ZSBuZWVkIHRv
IHVzZSB2aG9zdF92ZHBhX2ZpcnN0X2RldigpIGluc3RlYWQgb2YgcmVwbGFjaW5nIHRoZQoKaWYg
KHN0YXJ0ZWQpIHsKfSBlbHNlIHsKIMKgwqDCoCB2aG9zdF92ZHBhX3Jlc2V0X2RldmljZShkZXYp
OwogwqDCoMKgIC4uLi4KfQoKCldlIGNoZWNrCgppZiAoZGV2LT52cV9pbmRleCArIGRldi0+bnZx
cyAhPSBkZXYtPnZxX2luZGV4X2VuZCkgaW4gCnZob3N0X3ZkcGFfZGV2X3N0YXJ0KCkgYnV0IHZo
b3N0X3ZkcGFfZmlyc3RfZGV2KCkgaW5zaWRlIAp2aG9zdF92ZHBhX3N1c3BlbmQoKS4gVGhpcyB3
aWxsIHJlc3VsdCBjb2RlIHRoYXQgaXMgaGFyZCB0byBtYWludGFpbi4KClRoYW5rcwoKCj4gKyAg
ICAgICAgIShkZXYtPmJhY2tlbmRfY2FwICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfU1VTUEVO
RCkpKSB7Cj4gKyAgICAgICAgcmV0dXJuOwo+ICsgICAgfQo+ICsKPiArICAgIHRyYWNlX3Zob3N0
X3ZkcGFfc3VzcGVuZChkZXYpOwo+ICsgICAgciA9IGlvY3RsKHYtPmRldmljZV9mZCwgVkhPU1Rf
VkRQQV9TVVNQRU5EKTsKPiArICAgIGlmICh1bmxpa2VseShyKSkgewo+ICsgICAgICAgIGVycm9y
X3JlcG9ydCgiQ2Fubm90IHN1c3BlbmQ6ICVzKCVkKSIsIGdfc3RyZXJyb3IoZXJybm8pLCBlcnJu
byk7Cj4gKyAgICAgICAgLyogTm90IGFib3J0aW5nIHNpbmNlIHdlJ3JlIGNhbGxlZCBmcm9tIHN0
b3AgY29udGV4dCAqLwo+ICsgICAgfQo+ICt9Cj4gKwo+ICAgc3RhdGljIGludCB2aG9zdF92ZHBh
X2Rldl9zdGFydChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIGJvb2wgc3RhcnRlZCkKPiAgIHsKPiAg
ICAgICBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiA9IGRldi0+b3BhcXVlOwo+IEBAIC0xMTIyLDYgKzEx
NDAsNyBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfZGV2X3N0YXJ0KHN0cnVjdCB2aG9zdF9kZXYg
KmRldiwgYm9vbCBzdGFydGVkKQo+ICAgICAgICAgICB9Cj4gICAgICAgICAgIHZob3N0X3ZkcGFf
c2V0X3ZyaW5nX3JlYWR5KGRldik7Cj4gICAgICAgfSBlbHNlIHsKPiArICAgICAgICB2aG9zdF92
ZHBhX3N1c3BlbmQoZGV2KTsKPiAgICAgICAgICAgdmhvc3RfdmRwYV9zdnFzX3N0b3AoZGV2KTsK
PiAgICAgICAgICAgdmhvc3RfdmRwYV9ob3N0X25vdGlmaWVyc191bmluaXQoZGV2LCBkZXYtPm52
cXMpOwo+ICAgICAgIH0KPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3RyYWNlLWV2ZW50cyBiL2h3
L3ZpcnRpby90cmFjZS1ldmVudHMKPiBpbmRleCBhODdjNWYzOWEyLi44ZjhkMDVjZjliIDEwMDY0
NAo+IC0tLSBhL2h3L3ZpcnRpby90cmFjZS1ldmVudHMKPiArKysgYi9ody92aXJ0aW8vdHJhY2Ut
ZXZlbnRzCj4gQEAgLTUwLDYgKzUwLDcgQEAgdmhvc3RfdmRwYV9zZXRfdnJpbmdfcmVhZHkodm9p
ZCAqZGV2KSAiZGV2OiAlcCIKPiAgIHZob3N0X3ZkcGFfZHVtcF9jb25maWcodm9pZCAqZGV2LCBj
b25zdCBjaGFyICpsaW5lKSAiZGV2OiAlcCAlcyIKPiAgIHZob3N0X3ZkcGFfc2V0X2NvbmZpZyh2
b2lkICpkZXYsIHVpbnQzMl90IG9mZnNldCwgdWludDMyX3Qgc2l6ZSwgdWludDMyX3QgZmxhZ3Mp
ICJkZXY6ICVwIG9mZnNldDogJSJQUkl1MzIiIHNpemU6ICUiUFJJdTMyIiBmbGFnczogMHglIlBS
SXgzMgo+ICAgdmhvc3RfdmRwYV9nZXRfY29uZmlnKHZvaWQgKmRldiwgdm9pZCAqY29uZmlnLCB1
aW50MzJfdCBjb25maWdfbGVuKSAiZGV2OiAlcCBjb25maWc6ICVwIGNvbmZpZ19sZW46ICUiUFJJ
dTMyCj4gK3Zob3N0X3ZkcGFfc3VzcGVuZCh2b2lkICpkZXYpICJkZXY6ICVwIgo+ICAgdmhvc3Rf
dmRwYV9kZXZfc3RhcnQodm9pZCAqZGV2LCBib29sIHN0YXJ0ZWQpICJkZXY6ICVwIHN0YXJ0ZWQ6
ICVkIgo+ICAgdmhvc3RfdmRwYV9zZXRfbG9nX2Jhc2Uodm9pZCAqZGV2LCB1aW50NjRfdCBiYXNl
LCB1bnNpZ25lZCBsb25nIGxvbmcgc2l6ZSwgaW50IHJlZmNudCwgaW50IGZkLCB2b2lkICpsb2cp
ICJkZXY6ICVwIGJhc2U6IDB4JSJQUkl4NjQiIHNpemU6ICVsbHUgcmVmY250OiAlZCBmZDogJWQg
bG9nOiAlcCIKPiAgIHZob3N0X3ZkcGFfc2V0X3ZyaW5nX2FkZHIodm9pZCAqZGV2LCB1bnNpZ25l
ZCBpbnQgaW5kZXgsIHVuc2lnbmVkIGludCBmbGFncywgdWludDY0X3QgZGVzY191c2VyX2FkZHIs
IHVpbnQ2NF90IHVzZWRfdXNlcl9hZGRyLCB1aW50NjRfdCBhdmFpbF91c2VyX2FkZHIsIHVpbnQ2
NF90IGxvZ19ndWVzdF9hZGRyKSAiZGV2OiAlcCBpbmRleDogJXUgZmxhZ3M6IDB4JXggZGVzY191
c2VyX2FkZHI6IDB4JSJQUkl4NjQiIHVzZWRfdXNlcl9hZGRyOiAweCUiUFJJeDY0IiBhdmFpbF91
c2VyX2FkZHI6IDB4JSJQUkl4NjQiIGxvZ19ndWVzdF9hZGRyOiAweCUiUFJJeDY0CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
