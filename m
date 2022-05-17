Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11C3C433EF
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 03:24:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6720960F99;
	Tue, 17 May 2022 03:24:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zeEx3sThtxrq; Tue, 17 May 2022 03:24:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 04AFC60EB2;
	Tue, 17 May 2022 03:24:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D257BC0039;
	Tue, 17 May 2022 03:24:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C4DFC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:24:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 292C260EB2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:24:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cHzgDdzXVysA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:24:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7771560F99
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652757847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3fKXOO7Y5aUNq90vhSRlI/Hhp65sXCH/PkObwzcauw=;
 b=SxbVte8Fz/lCUK6R2SKqF1CYTDp5y/OQQVQ4onvCXIyra73KhRnQrka/gd+/HiJbNj41tM
 ncfD+KmRmIoVnxy2grMFiLgyHDE5SI4PLKnYKMggVS3MYFpcWOZVvTeKBLuJqrbT/XXnAi
 PNaGONbIgJIsJCv/KqMZb7bjmmx/v6k=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-QYV-i0W7NpCYjVWlosfJ7Q-1; Mon, 16 May 2022 23:24:04 -0400
X-MC-Unique: QYV-i0W7NpCYjVWlosfJ7Q-1
Received: by mail-pg1-f200.google.com with SMTP id
 l72-20020a63914b000000b003c1ac4355f5so8269321pge.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 20:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=U3fKXOO7Y5aUNq90vhSRlI/Hhp65sXCH/PkObwzcauw=;
 b=0Zh2WiXBAobE5AQWNknS0D5FZ8+5lUgnnCGBFw3PrSi2BEk7yVM8yXOV8lMCTOmQd+
 UlsV0Omv79+ybB8msohW3S724cTfomjwxOUPnzXx228Wg4ymAKc9MqQjYhdfQPFS8Azj
 cuvC7GjGSXO2n1E5vZ0nxz89Yqc+rIf2lrHY8h0x0MT/44hT0JEgEdaWFUCEidEdzoAj
 vraSNLopo/4V3/yZB3Oot08P/5QIXxhF5haQ+wAeJ/o+9Ckl0UR3jMhipg6xSBAQPrKV
 KT6lgA1LwiwQ9iYD07gM61W2nnEy/M2bbyTF1lT3nD7hS/gycjg5H+Ue+P0oubARyQHU
 ajPQ==
X-Gm-Message-State: AOAM533HRDWVpww/OD2phuNpfaPNFmkd/GxC5O5BUGvDKmXcLfGBKLg2
 MDjNR/7OAcirg61/KeaLIwrB1d/XTxEXr1v3rXLsZsED16XzvOyTyLRqf6BTJZQUcaSovRXzPJP
 eBu4cdR4hmONZavDdLDL9+A1vw1mapjP/XqsrRrSpyA==
X-Received: by 2002:a17:902:a413:b0:156:15b:524a with SMTP id
 p19-20020a170902a41300b00156015b524amr20527149plq.106.1652757842467; 
 Mon, 16 May 2022 20:24:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynDKBO8SDb0MUI2upYPJo616FN1JRB3dCrdT8m8IDMvK4bcDhDOK887PO4GaGRkTWX1RFdVA==
X-Received: by 2002:a17:902:a413:b0:156:15b:524a with SMTP id
 p19-20020a170902a41300b00156015b524amr20527133plq.106.1652757842220; 
 Mon, 16 May 2022 20:24:02 -0700 (PDT)
Received: from [10.72.12.227] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a62f80d000000b0050dc7628162sm7670863pfh.60.2022.05.16.20.23.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 May 2022 20:24:01 -0700 (PDT)
Message-ID: <d197a0ce-1d81-d54a-d5ae-0e3a92f8fbd8@redhat.com>
Date: Tue, 17 May 2022 11:23:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH V2 5/8] vhost_vsock: simplify vhost_vsock_flush()
To: Mike Christie <michael.christie@oracle.com>, stefanha@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org, arbn@yandex-team.com
References: <20220515202922.174066-1-michael.christie@oracle.com>
 <20220515202922.174066-6-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220515202922.174066-6-michael.christie@oracle.com>
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

CuWcqCAyMDIyLzUvMTYgMDQ6MjksIE1pa2UgQ2hyaXN0aWUg5YaZ6YGTOgo+IEZyb206IEFuZHJl
eSBSeWFiaW5pbiA8YXJibkB5YW5kZXgtdGVhbS5jb20+Cj4KPiB2aG9zdF92c29ja19mbHVzaCgp
IGNhbGxzIHZob3N0X3dvcmtfZGV2X2ZsdXNoKHZzb2NrLT52cXNbaV0ucG9sbC5kZXYpCj4gYmVm
b3JlIHZob3N0X3dvcmtfZGV2X2ZsdXNoKCZ2c29jay0+ZGV2KS4gVGhpcyBzZWVtcyBwb2ludGxl
c3MKPiBhcyB2c29jay0+dnFzW2ldLnBvbGwuZGV2IGlzIHRoZSBzYW1lIGFzICZ2c29jay0+ZGV2
IGFuZCBzZXZlcmFsIGZsdXNoZXMKPiBpbiBhIHJvdyBkb2Vzbid0IGRvIGFueXRoaW5nIHVzZWZ1
bCwgb25lIGlzIGp1c3QgZW5vdWdoLgo+Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFJ5YWJpbmlu
IDxhcmJuQHlhbmRleC10ZWFtLmNvbT4KPiBSZXZpZXdlZC1ieTogU3RlZmFubyBHYXJ6YXJlbGxh
IDxzZ2FyemFyZUByZWRoYXQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IE1pa2UgQ2hyaXN0aWUgPG1p
Y2hhZWwuY2hyaXN0aWVAb3JhY2xlLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92aG9zdC92c29jay5jIHwgNSAtLS0t
LQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92aG9zdC92c29jay5jIGIvZHJpdmVycy92aG9zdC92c29jay5jCj4gaW5kZXggYTRjOGFl
OTJhMGZiLi45NmJlNjM2OTcxMTcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92c29jay5j
Cj4gKysrIGIvZHJpdmVycy92aG9zdC92c29jay5jCj4gQEAgLTcwNSwxMSArNzA1LDYgQEAgc3Rh
dGljIGludCB2aG9zdF92c29ja19kZXZfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3Qg
ZmlsZSAqZmlsZSkKPiAgIAo+ICAgc3RhdGljIHZvaWQgdmhvc3RfdnNvY2tfZmx1c2goc3RydWN0
IHZob3N0X3Zzb2NrICp2c29jaykKPiAgIHsKPiAtCWludCBpOwo+IC0KPiAtCWZvciAoaSA9IDA7
IGkgPCBBUlJBWV9TSVpFKHZzb2NrLT52cXMpOyBpKyspCj4gLQkJaWYgKHZzb2NrLT52cXNbaV0u
aGFuZGxlX2tpY2spCj4gLQkJCXZob3N0X3dvcmtfZGV2X2ZsdXNoKHZzb2NrLT52cXNbaV0ucG9s
bC5kZXYpOwo+ICAgCXZob3N0X3dvcmtfZGV2X2ZsdXNoKCZ2c29jay0+ZGV2KTsKPiAgIH0KPiAg
IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
