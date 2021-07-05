Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D172C07E99
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 03:59:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E35613C9
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 03:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E35613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E98CF40421;
	Mon,  5 Jul 2021 03:59:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qrERbyDx4N5m; Mon,  5 Jul 2021 03:59:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 26AB1400B5;
	Mon,  5 Jul 2021 03:59:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D12E5C001A;
	Mon,  5 Jul 2021 03:59:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38A7FC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 281BE83A05
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:59:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q6Z5tzbSZ8Lo
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:59:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7C0F7839DD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625457589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WXgO0oXmvf/9A/1qL8w68Z6/mTqGpM66mMODKwc4Vbo=;
 b=Y/9V0wYz2D2UIwkSGFcyEkae9nfVeIZazhC/ybBGmZ76jxea1C92woiXcSOen/XYnaM1Cp
 C9VS2LKHpIHzhdR/n/vx5Td5FeH4LQY30XVvFNLLIrT6SZKq1e/wUxyi9dhVYn23U6qzGh
 sQcwgICOrDsmIY0YNtWNTGQhN24rcKE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-HmXeIiOiPqKW08aG-muiQg-1; Sun, 04 Jul 2021 23:59:48 -0400
X-MC-Unique: HmXeIiOiPqKW08aG-muiQg-1
Received: by mail-pj1-f69.google.com with SMTP id
 l20-20020a17090a5994b02901725eea9204so4691433pji.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Jul 2021 20:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=WXgO0oXmvf/9A/1qL8w68Z6/mTqGpM66mMODKwc4Vbo=;
 b=lAGpq8zlsazRS5NF++M5FtXOgkzS6Do8ffWnFbBNkDBM2x+60obQ48SI93MsgtzGsE
 VuuCaMMK/7TrVI/PyhIBGcbQ2wtApi1E+aOa/2dY0Q7yuSN2HLTNdXoDrV7q5ZlS3S4s
 xoxgkVuW8rinNDvBgx2QtdNiSUBYKbSur8KZqzfiKxfNvwsMIh2VO9OidRm9nVujULe6
 4Izxka3sG9v+Pk1i3QB1mlQtFGPNNUPghV7BqhwrXV0BCCVkz6eSgGnznZ22V7lVTblo
 LvlypZE5F2iiTgLawNZcjLx5LiTGmrHTu2MQUAOJc9c3rdxqT3I+cbqcUMo4FC9zYdoV
 M10A==
X-Gm-Message-State: AOAM531rqnDRtTPRJlvkb9qdC4yQXp1iaSEamQ6NkGRbtKU5Cn5yTuiz
 PS6l/xPy+dn2MbqybDz5ufUFJAB7z9fbZBbB6cnkc9MjHye8OT3A9UmpY5tE4QdPduPySjotESO
 KZm7h150Vu6uH2NoTCokaUMzDoAcpXupK+wWpBqwN33AIJ7ZRbbVqmInC5YGJv9dPW8GQQpmmxJ
 DQ+ycF4vRcRMZrS0WQcQ==
X-Received: by 2002:a17:90a:af90:: with SMTP id
 w16mr13185199pjq.129.1625457587149; 
 Sun, 04 Jul 2021 20:59:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7m1tdef3U/fD1ZeJXGh6nhQJM7pMQfOcmUl03cSHKc5dhYUnHwmNe0pBMkiHdPgpxcvo9fQ==
X-Received: by 2002:a17:90a:af90:: with SMTP id
 w16mr13185164pjq.129.1625457586781; 
 Sun, 04 Jul 2021 20:59:46 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id k9sm526132pfu.100.2021.07.04.20.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jul 2021 20:59:46 -0700 (PDT)
Subject: Re: [PATCH V2 5/6] virtio: add one field into virtio_device for
 recording if device uses managed irq
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
References: <20210702150555.2401722-1-ming.lei@redhat.com>
 <20210702150555.2401722-6-ming.lei@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fbe8e661-86c7-ef79-1c61-884715b64e87@redhat.com>
Date: Mon, 5 Jul 2021 11:59:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702150555.2401722-6-ming.lei@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Damien Le Moal <damien.lemoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Garry <john.garry@huawei.com>, virtualization@lists.linux-foundation.org,
 Keith Busch <kbusch@kernel.org>, Wen Xiong <wenxiong@us.ibm.com>
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

CtTaIDIwMjEvNy8yIM/CzucxMTowNSwgTWluZyBMZWkg0LS1wDoKPiBibGstbXEgbmVlZHMgdG8g
a25vdyBpZiB0aGUgZGV2aWNlIHVzZXMgbWFuYWdlZCBpcnEsIHNvIGFkZCBvbmUgZmllbGQKPiB0
byB2aXJ0aW9fZGV2aWNlIGZvciByZWNvcmRpbmcgaWYgZGV2aWNlIHVzZXMgbWFuYWdlZCBpcnEu
Cj4KPiBJZiB0aGUgZHJpdmVyIHVzZSBtYW5hZ2VkIGlycSwgdGhpcyBmbGFnIGhhcyB0byBiZSBz
ZXQgc28gaXQgY2FuIGJlCj4gcGFzc2VkIHRvIGJsay1tcS4KPgo+IENjOiAiTWljaGFlbCBTLiBU
c2lya2luIjxtc3RAcmVkaGF0LmNvbT4KPiBDYzogSmFzb24gV2FuZzxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgo+IENjOnZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4gU2ln
bmVkLW9mZi1ieTogTWluZyBMZWk8bWluZy5sZWlAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGRyaXZl
cnMvYmxvY2svdmlydGlvX2Jsay5jICAgICAgICAgfCAyICsrCj4gICBkcml2ZXJzL3Njc2kvdmly
dGlvX3Njc2kuYyAgICAgICAgIHwgMSArCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2Nv
bW1vbi5jIHwgMSArCj4gICBpbmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAgICAgICAgIHwgMSAr
Cj4gICA0IGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvYmxvY2svdmlydGlvX2Jsay5jIGIvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMKPiBp
bmRleCBlNGJkM2IxZmMzYzIuLjMzYjljODBhYzQ3NSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2Js
b2NrL3ZpcnRpb19ibGsuYwo+ICsrKyBiL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jCj4gQEAg
LTc2NCw2ICs3NjQsOCBAQCBzdGF0aWMgaW50IHZpcnRibGtfcHJvYmUoc3RydWN0IHZpcnRpb19k
ZXZpY2UgKnZkZXYpCj4gICAJdmJsay0+dGFnX3NldC5xdWV1ZV9kZXB0aCA9IHF1ZXVlX2RlcHRo
Owo+ICAgCXZibGstPnRhZ19zZXQubnVtYV9ub2RlID0gTlVNQV9OT19OT0RFOwo+ICAgCXZibGst
PnRhZ19zZXQuZmxhZ3MgPSBCTEtfTVFfRl9TSE9VTERfTUVSR0U7Cj4gKwlpZiAodmRldi0+dXNl
X21hbmFnZWRfaXJxKQo+ICsJCXZibGstPnRhZ19zZXQuZmxhZ3MgfD0gQkxLX01RX0ZfTUFOQUdF
RF9JUlE7CgoKSSdtIG5vdCBmYW1pbGlhciB3aXRoIGJsayBtcS4KCkJ1dCB0aGUgbmFtZSBpcyBr
aW5kIG9mIGNvbmZ1c2luZywgSSBndWVzcyAKIkJMS19NUV9GX0FGRklOSVRZX01BTkFHRURfSVJR
IiBpcyBiZXR0ZXI/IChDb25zaWRlciB3ZSBoYWQgCiJJUlFEX0FGRklOSVRZX01BTkFHRUQiKQoK
VGhpcyBoZWxwcyBtZSB0byBkaWZmZXIgdGhpcyBmcm9tIHRoZSBkZXZyZXMgKGRldmljZSBtYW5h
Z2VkIElSUSkgYXQgbGVhc3QuCgpUaGFua3MKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
