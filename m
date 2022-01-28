Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794F8C433F5
	for <virtualization@archiver.kernel.org>; Fri, 28 Jan 2022 06:03:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3DFD813F0;
	Fri, 28 Jan 2022 06:03:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mVMnX5JGjKV7; Fri, 28 Jan 2022 06:03:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 96B27813EA;
	Fri, 28 Jan 2022 06:03:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7792CC001A;
	Fri, 28 Jan 2022 06:03:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F90FC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 06:03:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F8C640A02
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 06:03:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g6UogW0cT8H3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 06:03:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8816E409F9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 06:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643349816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=soSLJWO6vndlkhR0jm5HSAwOMNmL3Y01pSFdyGEqqPw=;
 b=We3z5e+jU/nuVA1WYAwjQAO1FbLshv9EkQYRlpluMFfQpThvVwS7ttgUEeYO8eLzjNUOlc
 bPaExpTbGgJuuCE+kvdBCo/t3JY4NJT9SMlRzj10JeIDSA/UOibdkhkXiPjEvxdE3qdRk5
 kdLH+8h2e1UxStpsRLzMwmpsER3j3cc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-etj7qVkIOl6cM6siCT2Tyg-1; Fri, 28 Jan 2022 01:03:34 -0500
X-MC-Unique: etj7qVkIOl6cM6siCT2Tyg-1
Received: by mail-pl1-f198.google.com with SMTP id
 p7-20020a1709026b8700b0014a8d8fbf6fso2665393plk.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 22:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=soSLJWO6vndlkhR0jm5HSAwOMNmL3Y01pSFdyGEqqPw=;
 b=Om0HYOcIDW6UrVuI8gJxdNhzY5vTGQXFcOixJk7RpMVSXuQS4t8VwkeqQSDYKEGy2f
 A96c+KG2l8vrPHJ1W9oQq/hgNqoIXpSa9MX+DvKdJ+AVvcPFfLHronsotoIx5u64Ogvz
 FeOJYTKZCTzJ9m6uPVcEA9pUnrDIYbRW9v45ZEP7AFyWlvQ+PSrpriUt6Z+ytvhWU77T
 O1EWxs2Ifj+G7bnARQN4PtkDYlXaO1JnUEDDlIMc/gFrF0373MC+KD60NlIKTkdXX87m
 T4xCOItjQDGRt6Ov4OAzWhjh/Q4P29f9x314KHp/CiniT43O9pXckFfgi2FBW4kptWPQ
 5N0Q==
X-Gm-Message-State: AOAM530Q+XLTTH5Hll3Kx7nlh2WzCcJZ2DZh6D5bDych0O5RPWUoambN
 KTKjxPp3x5Rn3RvJgrHR+0b08De/Di3Td7nUNyiKrrCSULgZVSZbj1q0EwncpVYLi5saztp+1X3
 i63klggipM/l3FvXjVQ+zTL+Z5bPnawt6wRrijn4fTg==
X-Received: by 2002:a17:902:db01:: with SMTP id
 m1mr7300102plx.126.1643349813643; 
 Thu, 27 Jan 2022 22:03:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzA1dUSImHs3lAOPGZJjDkRKagDs4evWu1ON5ahDUAOzITQVNjeNMcxn5loZjwB6gfNiFOJKQ==
X-Received: by 2002:a17:902:db01:: with SMTP id
 m1mr7300083plx.126.1643349813416; 
 Thu, 27 Jan 2022 22:03:33 -0800 (PST)
Received: from [10.72.13.185] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id t14sm1131657pjd.6.2022.01.27.22.03.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jan 2022 22:03:32 -0800 (PST)
Message-ID: <d97a4fce-b94b-9503-e1bb-1599b73475dd@redhat.com>
Date: Fri, 28 Jan 2022 14:03:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 03/31] vdpa: Add vhost_svq_get_dev_kick_notifier
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220121202733.404989-4-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 Eric Blake <eblake@redhat.com>
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

CuWcqCAyMDIyLzEvMjIg5LiK5Y2INDoyNywgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IElzIG5l
ZWRlZCBzbyB2aG9zdC12ZHBhIGtub3dzIHRoZSBkZXZpY2UncyBraWNrIGV2ZW50IGZkLgo+Cj4g
U2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gLS0t
Cj4gICBody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oIHwgIDQgKysrKwo+ICAgaHcv
dmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYyB8IDEwICsrKysrKysrKy0KPiAgIDIgZmls
ZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdp
dCBhL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmggYi9ody92aXJ0aW8vdmhvc3Qt
c2hhZG93LXZpcnRxdWV1ZS5oCj4gaW5kZXggNjFlYTExMjAwMi4uNDAwZWZmZDlmMiAxMDA2NDQK
PiAtLS0gYS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oCj4gKysrIGIvaHcvdmly
dGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaAo+IEBAIC0xMSw5ICsxMSwxMyBAQAo+ICAgI2Rl
ZmluZSBWSE9TVF9TSEFET1dfVklSVFFVRVVFX0gKPiAgIAo+ICAgI2luY2x1ZGUgImh3L3ZpcnRp
by92aG9zdC5oIgo+ICsjaW5jbHVkZSAicWVtdS9ldmVudF9ub3RpZmllci5oIgoKCkxldCdzIG1v
dmUgdGhpcyBwYXJ0IHRvIHBhdGNoIDIuCgpUaGFua3MKCgo+ICAgCj4gICB0eXBlZGVmIHN0cnVj
dCBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSBWaG9zdFNoYWRvd1ZpcnRxdWV1ZTsKPiAgIAo+ICtjb25z
dCBFdmVudE5vdGlmaWVyICp2aG9zdF9zdnFfZ2V0X2Rldl9raWNrX25vdGlmaWVyKAo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgVmhvc3RTaGFk
b3dWaXJ0cXVldWUgKnN2cSk7Cj4gKwo+ICAgVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnZob3N0X3N2
cV9uZXcodm9pZCk7Cj4gICAKPiAgIHZvaWQgdmhvc3Rfc3ZxX2ZyZWUoVmhvc3RTaGFkb3dWaXJ0
cXVldWUgKnZxKTsKPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVl
dWUuYyBiL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMKPiBpbmRleCA1ZWU3YjQw
MWNiLi5iZDg3MTEwMDczIDEwMDY0NAo+IC0tLSBhL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmly
dHF1ZXVlLmMKPiArKysgYi9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jCj4gQEAg
LTExLDcgKzExLDYgQEAKPiAgICNpbmNsdWRlICJody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRx
dWV1ZS5oIgo+ICAgCj4gICAjaW5jbHVkZSAicWVtdS9lcnJvci1yZXBvcnQuaCIKPiAtI2luY2x1
ZGUgInFlbXUvZXZlbnRfbm90aWZpZXIuaCIKPiAgIAo+ICAgLyogU2hhZG93IHZpcnRxdWV1ZSB0
byByZWxheSBub3RpZmljYXRpb25zICovCj4gICB0eXBlZGVmIHN0cnVjdCBWaG9zdFNoYWRvd1Zp
cnRxdWV1ZSB7Cj4gQEAgLTIxLDYgKzIwLDE1IEBAIHR5cGVkZWYgc3RydWN0IFZob3N0U2hhZG93
VmlydHF1ZXVlIHsKPiAgICAgICBFdmVudE5vdGlmaWVyIGhkZXZfY2FsbDsKPiAgIH0gVmhvc3RT
aGFkb3dWaXJ0cXVldWU7Cj4gICAKPiArLyoqCj4gKyAqIFRoZSBub3RpZmllciB0aGF0IFNWUSB3
aWxsIHVzZSB0byBub3RpZnkgdGhlIGRldmljZS4KPiArICovCj4gK2NvbnN0IEV2ZW50Tm90aWZp
ZXIgKnZob3N0X3N2cV9nZXRfZGV2X2tpY2tfbm90aWZpZXIoCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgVmhvc3RTaGFkb3dWaXJ0cXVldWUg
KnN2cSkKPiArewo+ICsgICAgcmV0dXJuICZzdnEtPmhkZXZfa2ljazsKPiArfQo+ICsKPiAgIC8q
Kgo+ICAgICogQ3JlYXRlcyB2aG9zdCBzaGFkb3cgdmlydHF1ZXVlLCBhbmQgaW5zdHJ1Y3Qgdmhv
c3QgZGV2aWNlIHRvIHVzZSB0aGUgc2hhZG93Cj4gICAgKiBtZXRob2RzIGFuZCBmaWxlIGRlc2Ny
aXB0b3JzLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
