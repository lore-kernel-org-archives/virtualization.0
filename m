Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20391C61DA3
	for <virtualization@archiver.kernel.org>; Tue, 21 Feb 2023 05:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93ABA61109;
	Tue, 21 Feb 2023 05:40:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 93ABA61109
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a+axrV4/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3eAQqHBfZ-No; Tue, 21 Feb 2023 05:40:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1FD7A6112D;
	Tue, 21 Feb 2023 05:40:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1FD7A6112D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB0FCC0033;
	Tue, 21 Feb 2023 05:40:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23379C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 05:40:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E1199401ED
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 05:40:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E1199401ED
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=a+axrV4/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RGdVRNEPtIme
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 05:40:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 19289400A6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19289400A6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 05:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676958033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xhU90GNw6OZQxVjr6vg0gPZqUqSvGTjZ+hkuVjE7ZXg=;
 b=a+axrV4/RoS3eFIJbPYLPqU2+Y6CE8PK5Cgdn4p1vpvU0x+5xXcHMurh3MQgvnB5iRK8Mx
 aPGVdLSwYoz85KaMmJCdq4IMVGUhSYiTnMYXmUjBHsGWZ5JEF0ntXXaamylc8WkBYY3U0h
 CO7UZtCwHYqplCC+SLtZHsP0WaZ0RCQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-311-nM0YUmSaNLSRiAFCkV0sXg-1; Tue, 21 Feb 2023 00:40:32 -0500
X-MC-Unique: nM0YUmSaNLSRiAFCkV0sXg-1
Received: by mail-pj1-f71.google.com with SMTP id
 i6-20020a17090a974600b0023487c793d0so1670793pjw.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 21:40:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xhU90GNw6OZQxVjr6vg0gPZqUqSvGTjZ+hkuVjE7ZXg=;
 b=EbZGIkfz8IdXUvallKZgT1K1IgTJMOxJPxHkbKntNmgAC7Tk8QBE08Nss39RXgkpNU
 +9wwDitRjq2983JKEXuqwAdiMeu9k8B06lSihWnSHtHAFhZHWunictIzUIXMo/3R4Csc
 de9472PRgjdKVHyqduTYwKBDb4OFyUERIJARpAbvDHZX4iMwhvQYrcFT3BnLVxiHGPHe
 qHq+a2P45hlTmYKrR5U1hFjJ1yiAkToG/a8Da+4BBjQHZ6PVZMcdD4Vb3p5e1aAOfMkf
 9oI8EOc+z8FwfC1ED+brAH9+goo3CUiuPa0mA0XEmsxiOjXyVUGCliHjWmwqT6ZuJ+Su
 b2sQ==
X-Gm-Message-State: AO0yUKUngdUSY0f5H0E/GQki7P7pzLUgplrCRnhOywDylfWwWFhJnM6A
 aOD5HZrum87AnqZkJbtLZIL44kAwZ/59xgi9ry9eH89o+l2vQnTrjj717+1Iej2SNzCB+j4fHsR
 jKwwM47J9wNjOm/OIr2aDz9jMsQss8D36G4/CMhGQsw==
X-Received: by 2002:a05:6a20:a026:b0:c7:2138:1011 with SMTP id
 p38-20020a056a20a02600b000c721381011mr2121247pzj.2.1676958031398; 
 Mon, 20 Feb 2023 21:40:31 -0800 (PST)
X-Google-Smtp-Source: AK7set/mBE8YsmwdzUWPJ03jLtGvc8GYsIvxkeQyn154JB4YkxwRzHNUZYhXxkeJD4Mqr4498hxFig==
X-Received: by 2002:a05:6a20:a026:b0:c7:2138:1011 with SMTP id
 p38-20020a056a20a02600b000c721381011mr2121217pzj.2.1676958031102; 
 Mon, 20 Feb 2023 21:40:31 -0800 (PST)
Received: from [10.72.12.235] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a63bf08000000b004fbb6200482sm333990pgf.41.2023.02.20.21.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Feb 2023 21:40:30 -0800 (PST)
Message-ID: <cbec89c4-6637-8ec2-20c1-1caa59e3849a@redhat.com>
Date: Tue, 21 Feb 2023 13:40:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 05/13] vdpa: rewind at get_base, not set_base
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230208094253.702672-1-eperezma@redhat.com>
 <20230208094253.702672-6-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230208094253.702672-6-eperezma@redhat.com>
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

CuWcqCAyMDIzLzIvOCAxNzo0MiwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IEF0IHRoaXMgbW9t
ZW50IGl0IGlzIG9ubHkgcG9zc2libGUgdG8gbWlncmF0ZSB0byBhIHZkcGEgZGV2aWNlIHJ1bm5p
bmcKPiB3aXRoIHgtc3ZxPW9uLiBBcyBhIHByb3RlY3RpdmUgbWVhc3VyZSwgdGhlIHJld2luZCBv
ZiB0aGUgaW5mbGlnaHQKPiBkZXNjcmlwdG9ycyB3YXMgZG9uZSBhdCB0aGUgZGVzdGluYXRpb24u
IFRoYXQgd2F5IGlmIHRoZSBzb3VyY2Ugc2VudCBhCj4gdmlydHF1ZXVlIHdpdGggaW51c2UgZGVz
Y3JpcHRvcnMgdGhleSBhcmUgYWx3YXlzIGRpc2NhcmRlZC4KPgo+IFNpbmNlIHRoaXMgc2VyaWVz
IGFsbG93cyB0byBtaWdyYXRlIGFsc28gdG8gcGFzc3Rocm91Z2ggZGV2aWNlcyB3aXRoIG5vCj4g
U1ZRLCB0aGUgcmlnaHQgdGhpbmcgdG8gZG8gaXMgdG8gcmV3aW5kIGF0IHRoZSBzb3VyY2Ugc28g
dGhlIGJhc2Ugb2YKPiB2cmluZ3MgYXJlIGNvcnJlY3QuCj4KPiBTdXBwb3J0IGZvciBpbmZsaWdo
dCBkZXNjcmlwdG9ycyBtYXkgYmUgYWRkZWQgaW4gdGhlIGZ1dHVyZS4KPgo+IFNpZ25lZC1vZmYt
Ynk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgoKCkFja2VkLWJ5OiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgoKPiAtLS0KPiAgIGh3L3ZpcnRp
by92aG9zdC12ZHBhLmMgfCAyNCArKysrKysrKysrKysrLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+IGluZGV4
IDI2ZTM4YTZhYWIuLmQ5OWRiMGJkMDMgMTAwNjQ0Cj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXZk
cGEuYwo+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPiBAQCAtMTIxMSwxOCArMTIxMSw3
IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9zZXRfdnJpbmdfYmFzZShzdHJ1Y3Qgdmhvc3RfZGV2
ICpkZXYsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
dmhvc3RfdnJpbmdfc3RhdGUgKnJpbmcpCj4gICB7Cj4gICAgICAgc3RydWN0IHZob3N0X3ZkcGEg
KnYgPSBkZXYtPm9wYXF1ZTsKPiAtICAgIFZpcnRRdWV1ZSAqdnEgPSB2aXJ0aW9fZ2V0X3F1ZXVl
KGRldi0+dmRldiwgcmluZy0+aW5kZXgpOwo+ICAgCj4gLSAgICAvKgo+IC0gICAgICogdmhvc3Qt
dmRwYSBkZXZpY2VzIGRvZXMgbm90IHN1cHBvcnQgaW4tZmxpZ2h0IHJlcXVlc3RzLiBTZXQgYWxs
IG9mIHRoZW0KPiAtICAgICAqIGFzIGF2YWlsYWJsZS4KPiAtICAgICAqCj4gLSAgICAgKiBUT0RP
OiBUaGlzIGlzIG9rIGZvciBuZXR3b3JraW5nLCBidXQgb3RoZXIga2luZHMgb2YgZGV2aWNlcyBt
aWdodAo+IC0gICAgICogaGF2ZSBwcm9ibGVtcyB3aXRoIHRoZXNlIHJldHJhbnNtaXNzaW9ucy4K
PiAtICAgICAqLwo+IC0gICAgd2hpbGUgKHZpcnRxdWV1ZV9yZXdpbmQodnEsIDEpKSB7Cj4gLSAg
ICAgICAgY29udGludWU7Cj4gLSAgICB9Cj4gICAgICAgaWYgKHYtPnNoYWRvd192cXNfZW5hYmxl
ZCkgewo+ICAgICAgICAgICAvKgo+ICAgICAgICAgICAgKiBEZXZpY2UgdnJpbmcgYmFzZSB3YXMg
c2V0IGF0IGRldmljZSBzdGFydC4gU1ZRIGJhc2UgaXMgaGFuZGxlZCBieQo+IEBAIC0xMjQxLDYg
KzEyMzAsMTkgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX2dldF92cmluZ19iYXNlKHN0cnVjdCB2
aG9zdF9kZXYgKmRldiwKPiAgICAgICBpbnQgcmV0Owo+ICAgCj4gICAgICAgaWYgKHYtPnNoYWRv
d192cXNfZW5hYmxlZCkgewo+ICsgICAgICAgIFZpcnRRdWV1ZSAqdnEgPSB2aXJ0aW9fZ2V0X3F1
ZXVlKGRldi0+dmRldiwgcmluZy0+aW5kZXgpOwo+ICsKPiArICAgICAgICAvKgo+ICsgICAgICAg
ICAqIHZob3N0LXZkcGEgZGV2aWNlcyBkb2VzIG5vdCBzdXBwb3J0IGluLWZsaWdodCByZXF1ZXN0
cy4gU2V0IGFsbCBvZgo+ICsgICAgICAgICAqIHRoZW0gYXMgYXZhaWxhYmxlLgo+ICsgICAgICAg
ICAqCj4gKyAgICAgICAgICogVE9ETzogVGhpcyBpcyBvayBmb3IgbmV0d29ya2luZywgYnV0IG90
aGVyIGtpbmRzIG9mIGRldmljZXMgbWlnaHQKPiArICAgICAgICAgKiBoYXZlIHByb2JsZW1zIHdp
dGggdGhlc2UgcmV0cmFuc21pc3Npb25zLgo+ICsgICAgICAgICAqLwo+ICsgICAgICAgIHdoaWxl
ICh2aXJ0cXVldWVfcmV3aW5kKHZxLCAxKSkgewo+ICsgICAgICAgICAgICBjb250aW51ZTsKPiAr
ICAgICAgICB9Cj4gKwo+ICAgICAgICAgICByaW5nLT5udW0gPSB2aXJ0aW9fcXVldWVfZ2V0X2xh
c3RfYXZhaWxfaWR4KGRldi0+dmRldiwgcmluZy0+aW5kZXgpOwo+ICAgICAgICAgICByZXR1cm4g
MDsKPiAgICAgICB9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
