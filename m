Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69180C64ED6
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 07:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E738081B10;
	Mon, 27 Feb 2023 07:24:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E738081B10
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M5Kn7TBM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lh0vqAt8zs3G; Mon, 27 Feb 2023 07:24:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6C2CF81B01;
	Mon, 27 Feb 2023 07:24:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6C2CF81B01
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49605C0032;
	Mon, 27 Feb 2023 07:24:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C27FC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:24:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D8A594017B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:24:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D8A594017B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=M5Kn7TBM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d85xjeERgti4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:24:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 17097400B8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 17097400B8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677482677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BqRfkJziOVWTgz2m6u36TUb0eCx9zJz3dkGhOiSCknE=;
 b=M5Kn7TBMzZEznTZZZ8mGhnc4BZsTAVhPW3LfGNtoiuqf17H3xIdw9FcVxtlkcbsTEjnX/o
 tLlmtXNs3rxEpirws/2qMsOxnEgvi1akTC+kl3WQsuMB6mZJtDdoB0Wg9uLw7nFIgnrXky
 pxWTV1SG0vZb2JLZ8U6DQRV2hQh4EjA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-345-AAL9Dkd4OOiuT_en9gr3Fw-1; Mon, 27 Feb 2023 02:24:35 -0500
X-MC-Unique: AAL9Dkd4OOiuT_en9gr3Fw-1
Received: by mail-pl1-f200.google.com with SMTP id
 n1-20020a170902968100b0019cf3c5728fso2572748plp.19
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Feb 2023 23:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BqRfkJziOVWTgz2m6u36TUb0eCx9zJz3dkGhOiSCknE=;
 b=az1ZeZptYLkrH4l2/CyobFSFGIMaqF9iOHePq+x1yZ+4Nm/kAlIGjzGWlvC0FZxepB
 rFt5liwYme+3R6Mjillnr0HvVsK+Yhf3IUaLtTh9OrwM8VLmB0jh/HfdyUP8XeK1ZMZZ
 N2Y4oOicIUn/ID8gFnhlwm01tO9GTXLu5F/0/haK2tZThSQpM90/DSKxu+nzGJiUN7gC
 dqYVS1MXLe4OtjvqYiRWEShYK+2yIH4IcrJHrMlbsQCbF5GasRrwNyeva/2eFS6PzFnA
 JOB+vyMsv3V5AxO3RWQ8X90V/wBaJnAZJymogOotKODAXHXz5FMbF1/Yd5qe7VOECv2v
 WxzQ==
X-Gm-Message-State: AO0yUKUmdMhpTepOFCsu+bLM+80VrfXWLQySEe2tkO7tYtQL+rXbUAv2
 9VfFKvywKayQs0EMpn2Z3vSgk61ZNoNeYML769JvzS5CgPxEKowTugnynttckWP0/2I92dxcbF/
 OYl4WtocCSWbuA5GOCzPsE9egA/Qykxi0tFdu6WiXzQ==
X-Received: by 2002:a17:902:da8e:b0:19b:c37:25e7 with SMTP id
 j14-20020a170902da8e00b0019b0c3725e7mr29355713plx.66.1677482674515; 
 Sun, 26 Feb 2023 23:24:34 -0800 (PST)
X-Google-Smtp-Source: AK7set8vX6lFW0QlupFix5ypN1cDdCGCZxlDq6ClTJx5LCiD1ZUkF6+3to8/rhiA3HelzE8vuckhog==
X-Received: by 2002:a17:902:da8e:b0:19b:c37:25e7 with SMTP id
 j14-20020a170902da8e00b0019b0c3725e7mr29355687plx.66.1677482674249; 
 Sun, 26 Feb 2023 23:24:34 -0800 (PST)
Received: from [10.72.13.83] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a1709027c8900b00186a2274382sm3804096pll.76.2023.02.26.23.24.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Feb 2023 23:24:33 -0800 (PST)
Message-ID: <f3111a92-75a0-c12e-147e-a75084e7457b@redhat.com>
Date: Mon, 27 Feb 2023 15:24:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 06/15] vdpa: add vhost_vdpa->suspended parameter
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230224155438.112797-1-eperezma@redhat.com>
 <20230224155438.112797-7-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230224155438.112797-7-eperezma@redhat.com>
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

CuWcqCAyMDIzLzIvMjQgMjM6NTQsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPiBUaGlzIGFsbG93
cyB2aG9zdF92ZHBhIHRvIHRyYWNrIGlmIGl0IGlzIHNhZmUgdG8gZ2V0IHZyaW5nIGJhc2UgZnJv
bSB0aGUKPiBkZXZpY2Ugb3Igbm90LiAgSWYgaXQgaXMgbm90LCB2aG9zdCBjYW4gZmFsbCBiYWNr
IHRvIGZldGNoIGlkeCBmcm9tIHRoZQo+IGd1ZXN0IGJ1ZmZlciBhZ2Fpbi4KPgo+IE5vIGZ1bmN0
aW9uYWwgY2hhbmdlIGludGVuZGVkIGluIHRoaXMgcGF0Y2gsIGxhdGVyIHBhdGNoZXMgd2lsbCB1
c2UgdGhpcwo+IGZpZWxkLgo+Cj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJl
em1hQHJlZGhhdC5jb20+CgoKSSB0aGluayB3ZSBwcm9iYWJseSBuZWVkIHRvIHJlLW9yZGVyIHRo
ZSBwYXRjaCwgZS5nIHRvIGxldCB0aGlzIGNvbWUgCmJlZm9yZSBhdCBsZWFzdCBwYXRjaCA1LgoK
Cj4gLS0tCj4gICBpbmNsdWRlL2h3L3ZpcnRpby92aG9zdC12ZHBhLmggfCAyICsrCj4gICBody92
aXJ0aW8vdmhvc3QtdmRwYS5jICAgICAgICAgfCA4ICsrKysrKysrCj4gICAyIGZpbGVzIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZpcnRpby92
aG9zdC12ZHBhLmggYi9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC12ZHBhLmgKPiBpbmRleCA3OTk3
ZjA5YThkLi40YTdkMzk2Njc0IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0
LXZkcGEuaAo+ICsrKyBiL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LXZkcGEuaAo+IEBAIC00Miw2
ICs0Miw4IEBAIHR5cGVkZWYgc3RydWN0IHZob3N0X3ZkcGEgewo+ICAgICAgIGJvb2wgc2hhZG93
X3Zxc19lbmFibGVkOwo+ICAgICAgIC8qIFZkcGEgbXVzdCBzZW5kIHNoYWRvdyBhZGRyZXNzZXMg
YXMgSU9UTEIga2V5IGZvciBkYXRhIHF1ZXVlcywgbm90IEdQQSAqLwo+ICAgICAgIGJvb2wgc2hh
ZG93X2RhdGE7Cj4gKyAgICAvKiBEZXZpY2Ugc3VzcGVuZGVkIHN1Y2Nlc3NmdWxseSAqLwo+ICsg
ICAgYm9vbCBzdXNwZW5kZWQ7CgoKU2hvdWxkIHdlIGltcGxlbWVudCB0aGUgc2V0L2NsZWFyIGlu
IHRoaXMgcGF0Y2ggYXMgd2VsbD8KClRoYW5rcwoKCj4gICAgICAgLyogSU9WQSBtYXBwaW5nIHVz
ZWQgYnkgdGhlIFNoYWRvdyBWaXJ0cXVldWUgKi8KPiAgICAgICBWaG9zdElPVkFUcmVlICppb3Zh
X3RyZWU7Cj4gICAgICAgR1B0ckFycmF5ICpzaGFkb3dfdnFzOwo+IGRpZmYgLS1naXQgYS9ody92
aXJ0aW8vdmhvc3QtdmRwYS5jIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+IGluZGV4IDhjYzlj
OThkYjkuLjIyODY3Nzg5NWEgMTAwNjQ0Cj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+
ICsrKyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPiBAQCAtMTIyNyw2ICsxMjI3LDE0IEBAIHN0
YXRpYyBpbnQgdmhvc3RfdmRwYV9nZXRfdnJpbmdfYmFzZShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYs
Cj4gICAgICAgICAgIHJldHVybiAwOwo+ICAgICAgIH0KPiAgIAo+ICsgICAgaWYgKCF2LT5zdXNw
ZW5kZWQpIHsKPiArICAgICAgICAvKgo+ICsgICAgICAgICAqIENhbm5vdCB0cnVzdCBpbiB2YWx1
ZSByZXR1cm5lZCBieSBkZXZpY2UsIGxldCB2aG9zdCByZWNvdmVyIHVzZWQKPiArICAgICAgICAg
KiBpZHggZnJvbSBndWVzdC4KPiArICAgICAgICAgKi8KPiArICAgICAgICByZXR1cm4gLTE7Cj4g
KyAgICB9Cj4gKwo+ICAgICAgIHJldCA9IHZob3N0X3ZkcGFfY2FsbChkZXYsIFZIT1NUX0dFVF9W
UklOR19CQVNFLCByaW5nKTsKPiAgICAgICB0cmFjZV92aG9zdF92ZHBhX2dldF92cmluZ19iYXNl
KGRldiwgcmluZy0+aW5kZXgsIHJpbmctPm51bSk7Cj4gICAgICAgcmV0dXJuIHJldDsKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
