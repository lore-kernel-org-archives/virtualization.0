Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746FFC64ED6
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 08:15:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06E0C60F58;
	Mon, 27 Feb 2023 08:15:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06E0C60F58
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g0pY4sfz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NDmog1k9ty56; Mon, 27 Feb 2023 08:15:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7CB0860DCB;
	Mon, 27 Feb 2023 08:15:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7CB0860DCB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E7E6C0033;
	Mon, 27 Feb 2023 08:15:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5172DC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B01160DCB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:15:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B01160DCB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wRfPqd95r1o3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:15:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2222060B4C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2222060B4C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677485734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3x69ZsSNpX/akHSADnpdF99h5XqfwdxDqoeGTx5EvYg=;
 b=g0pY4sfzyVCkgO4yftzscc/ez/X5a/u4RKTzHBjt3uFxilP5KNtOlMnSIKLxZp+E+1yV21
 MRk3IP5IeRisiGT6MLu7E4fsLcaVIJRyz3Y63PhDeqKLxynmdGSYiw4xCac89flFh0JF6F
 2zDndDJrZ2MIxP0iwhUP+/S3vXWGuUM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-TX829zkWO06CtR9N_Su1Dg-1; Mon, 27 Feb 2023 03:15:32 -0500
X-MC-Unique: TX829zkWO06CtR9N_Su1Dg-1
Received: by mail-pj1-f70.google.com with SMTP id
 m9-20020a17090a7f8900b0023769205928so4802179pjl.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 00:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3x69ZsSNpX/akHSADnpdF99h5XqfwdxDqoeGTx5EvYg=;
 b=chNqmnWcPu72GFm8paJYQoYtu/HnB9m+rHExwD7r/WZOGgArH65E1qFdrGxNhPMgFe
 2f/twcjO2XGY+I9brlt1Tlwg7RyS7gWFG9fj9U0PltoXJqE+4fIjMWtKSgwAMwgO1vZX
 JlHbC2+H0oOGet5eL6yYey7raJ5dT7dfKeSQtyu3MXxmtxnBcDeWjCM0wtU8P856wtkJ
 yp0nQhvPVUoi5vwky59hfF+JTTfhX8bdFZ5z6kSOzk3y0y0w74GjldphjnqDpi31i5hO
 kb0DSEU+AXoZydEKQs2QfxcjWgiZfii3JZ/g0VotBLSGO56rQrUuQOYt3Rz6icsfDhxU
 IXgg==
X-Gm-Message-State: AO0yUKU/LrJhACFuw0ENOk9vh3a1rMx/LPBYiLw9C+59EXcM7hLo8ncf
 oB/yF4X5w8Ef0tsc11nLUWXxI8ImROfEDKmTsVAvGsYBxZC3eUz5ff8C8UmqrRAiAdefVD4XXxh
 bGIuKlPoNVZ2PquhhFYPKGqCgJpdc4eFvuPPn1Ry5Ww==
X-Received: by 2002:a05:6a20:430a:b0:cc:9b29:f617 with SMTP id
 h10-20020a056a20430a00b000cc9b29f617mr10837935pzk.0.1677485731417; 
 Mon, 27 Feb 2023 00:15:31 -0800 (PST)
X-Google-Smtp-Source: AK7set83Y7pAHa7WGvY0JfTzfSu+k9WJI1LEuOOjNvfbOzN862xjLYlfp1L5qF55Qa/P2QDQ6TeAgg==
X-Received: by 2002:a05:6a20:430a:b0:cc:9b29:f617 with SMTP id
 h10-20020a056a20430a00b000cc9b29f617mr10837907pzk.0.1677485731153; 
 Mon, 27 Feb 2023 00:15:31 -0800 (PST)
Received: from [10.72.13.83] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 g17-20020aa78751000000b0058837da69edsm3642594pfo.128.2023.02.27.00.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Feb 2023 00:15:30 -0800 (PST)
Message-ID: <2367dcff-e8c3-c3ca-378a-e9e67e10710a@redhat.com>
Date: Mon, 27 Feb 2023 16:15:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 12/15] vdpa: block migration if device has unsupported
 features
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230224155438.112797-1-eperezma@redhat.com>
 <20230224155438.112797-13-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230224155438.112797-13-eperezma@redhat.com>
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

CuWcqCAyMDIzLzIvMjQgMjM6NTQsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPiBBIHZkcGEgbmV0
IGRldmljZSBtdXN0IGluaXRpYWxpemUgd2l0aCBTVlEgaW4gb3JkZXIgdG8gYmUgbWlncmF0YWJs
ZSBhdAo+IHRoaXMgbW9tZW50LCBhbmQgaW5pdGlhbGl6YXRpb24gY29kZSB2ZXJpZmllcyBzb21l
IGNvbmRpdGlvbnMuICBJZiB0aGUKPiBkZXZpY2UgaXMgbm90IGluaXRpYWxpemVkIHdpdGggdGhl
IHgtc3ZxIHBhcmFtZXRlciwgaXQgd2lsbCBub3QgZXhwb3NlCj4gX0ZfTE9HIHNvIHRoZSB2aG9z
dCBzdWJzeXN0ZW0gd2lsbCBibG9jayBWTSBtaWdyYXRpb24gZnJvbSBpdHMKPiBpbml0aWFsaXph
dGlvbi4KPgo+IE5leHQgcGF0Y2hlcyBjaGFuZ2UgdGhpcywgc28gd2UgbmVlZCB0byB2ZXJpZnkg
bWlncmF0aW9uIGNvbmRpdGlvbnMKPiBkaWZmZXJlbnRseS4KPgo+IFFFTVUgb25seSBzdXBwb3J0
cyBhIHN1YnNldCBvZiBuZXQgZmVhdHVyZXMgaW4gU1ZRLCBhbmQgaXQgY2Fubm90Cj4gbWlncmF0
ZSBzdGF0ZSB0aGF0IGNhbm5vdCB0cmFjayBvciByZXN0b3JlIGluIHRoZSBkZXN0aW5hdGlvbi4g
IEFkZCBhCj4gbWlncmF0aW9uIGJsb2NrZXIgaWYgdGhlIGRldmljZSBvZmZlciBhbiB1bnN1cHBv
cnRlZCBmZWF0dXJlLgo+Cj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1h
QHJlZGhhdC5jb20+Cj4gLS0tCj4gdjM6IGFkZCBtaXJnYXRpb24gYmxvY2tlciBwcm9wZXJseSBz
byB2aG9zdF9kZXYgY2FuIGhhbmRsZSBpdC4KPiAtLS0KPiAgIG5ldC92aG9zdC12ZHBhLmMgfCAx
MiArKysrKysrKy0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvbmV0L3Zob3N0LXZkcGEuYyBiL25ldC92aG9zdC12
ZHBhLmMKPiBpbmRleCA0Zjk4M2RmMDAwLi4wOTRkYzFjMmQwIDEwMDY0NAo+IC0tLSBhL25ldC92
aG9zdC12ZHBhLmMKPiArKysgYi9uZXQvdmhvc3QtdmRwYS5jCj4gQEAgLTc5NSw3ICs3OTUsOCBA
QCBzdGF0aWMgTmV0Q2xpZW50U3RhdGUgKm5ldF92aG9zdF92ZHBhX2luaXQoTmV0Q2xpZW50U3Rh
dGUgKnBlZXIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQg
bnZxcywKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgaXNf
ZGF0YXBhdGgsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29s
IHN2cSwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZo
b3N0X3ZkcGFfaW92YV9yYW5nZSBpb3ZhX3JhbmdlKQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfdmRwYV9pb3ZhX3JhbmdlIGlvdmFfcmFuZ2Us
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IGZlYXR1
cmVzKQo+ICAgewo+ICAgICAgIE5ldENsaWVudFN0YXRlICpuYyA9IE5VTEw7Cj4gICAgICAgVmhv
c3RWRFBBU3RhdGUgKnM7Cj4gQEAgLTgxOCw3ICs4MTksMTAgQEAgc3RhdGljIE5ldENsaWVudFN0
YXRlICpuZXRfdmhvc3RfdmRwYV9pbml0KE5ldENsaWVudFN0YXRlICpwZWVyLAo+ICAgICAgIHMt
PnZob3N0X3ZkcGEuc2hhZG93X3Zxc19lbmFibGVkID0gc3ZxOwo+ICAgICAgIHMtPnZob3N0X3Zk
cGEuaW92YV9yYW5nZSA9IGlvdmFfcmFuZ2U7Cj4gICAgICAgcy0+dmhvc3RfdmRwYS5zaGFkb3df
ZGF0YSA9IHN2cTsKPiAtICAgIGlmICghaXNfZGF0YXBhdGgpIHsKPiArICAgIGlmIChxdWV1ZV9w
YWlyX2luZGV4ID09IDApIHsKPiArICAgICAgICB2aG9zdF92ZHBhX25ldF92YWxpZF9zdnFfZmVh
dHVyZXMoZmVhdHVyZXMsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICZzLT52aG9zdF92ZHBhLm1pZ3JhdGlvbl9ibG9ja2VyKTsKCgpTaW5jZSB3ZSBkbyB2YWxp
ZGF0aW9uIGF0IGluaXRpYWxpemF0aW9uLCBpcyB0aGlzIG5lY2Vzc2FyeSB0byB2YWxpZCAKb25j
ZSBhZ2FpbiBpbiBvdGhlciBwbGFjZXM/CgpUaGFua3MKCgo+ICsgICAgfSBlbHNlIGlmICghaXNf
ZGF0YXBhdGgpIHsKPiAgICAgICAgICAgcy0+Y3ZxX2NtZF9vdXRfYnVmZmVyID0gcWVtdV9tZW1h
bGlnbihxZW11X3JlYWxfaG9zdF9wYWdlX3NpemUoKSwKPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdmhvc3RfdmRwYV9uZXRfY3ZxX2NtZF9wYWdlX2xlbigp
KTsKPiAgICAgICAgICAgbWVtc2V0KHMtPmN2cV9jbWRfb3V0X2J1ZmZlciwgMCwgdmhvc3RfdmRw
YV9uZXRfY3ZxX2NtZF9wYWdlX2xlbigpKTsKPiBAQCAtOTU2LDcgKzk2MCw3IEBAIGludCBuZXRf
aW5pdF92aG9zdF92ZHBhKGNvbnN0IE5ldGRldiAqbmV0ZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+
ICAgICAgIGZvciAoaSA9IDA7IGkgPCBxdWV1ZV9wYWlyczsgaSsrKSB7Cj4gICAgICAgICAgIG5j
c1tpXSA9IG5ldF92aG9zdF92ZHBhX2luaXQocGVlciwgVFlQRV9WSE9TVF9WRFBBLCBuYW1lLAo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZkcGFfZGV2aWNlX2ZkLCBp
LCAyLCB0cnVlLCBvcHRzLT54X3N2cSwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGlvdmFfcmFuZ2UpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaW92YV9yYW5nZSwgZmVhdHVyZXMpOwo+ICAgICAgICAgICBpZiAoIW5jc1tpXSkKPiAgICAg
ICAgICAgICAgIGdvdG8gZXJyOwo+ICAgICAgIH0KPiBAQCAtOTY0LDcgKzk2OCw3IEBAIGludCBu
ZXRfaW5pdF92aG9zdF92ZHBhKGNvbnN0IE5ldGRldiAqbmV0ZGV2LCBjb25zdCBjaGFyICpuYW1l
LAo+ICAgICAgIGlmIChoYXNfY3ZxKSB7Cj4gICAgICAgICAgIG5jID0gbmV0X3Zob3N0X3ZkcGFf
aW5pdChwZWVyLCBUWVBFX1ZIT1NUX1ZEUEEsIG5hbWUsCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB2ZHBhX2RldmljZV9mZCwgaSwgMSwgZmFsc2UsCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIG9wdHMtPnhfc3ZxLCBpb3ZhX3JhbmdlKTsKPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgb3B0cy0+eF9zdnEsIGlvdmFfcmFuZ2UsIGZlYXR1
cmVzKTsKPiAgICAgICAgICAgaWYgKCFuYykKPiAgICAgICAgICAgICAgIGdvdG8gZXJyOwo+ICAg
ICAgIH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
