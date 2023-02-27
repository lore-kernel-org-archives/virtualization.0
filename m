Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44007C64ED8
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 08:11:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C609781C44;
	Mon, 27 Feb 2023 08:11:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C609781C44
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YyBpngTg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aIjc-f7YZ27q; Mon, 27 Feb 2023 08:11:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6348A812C9;
	Mon, 27 Feb 2023 08:11:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6348A812C9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F76FC0033;
	Mon, 27 Feb 2023 08:11:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80CCEC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:11:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5AAA260F58
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:11:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5AAA260F58
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YyBpngTg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yu8CPM48p2nf
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:11:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77B8260F4D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 77B8260F4D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677485479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hUtR13nE9ADMPfRUasH4TVIIvHusnhAtQQrD5pDjQxw=;
 b=YyBpngTgzfp+viEed+NlOD6su572K4etXQxZn8xK7eQ3yt9cx7T4CUrFLKB8i7UtKdQ9tJ
 pR9BTBtYk3jiu3lUR7Obdkl8gCGd/ZnffxXuGOcLEAqTvIvm/LkLJKH9K98nDPrPl3Hd56
 O9ssc11+7dPvb/R7HohGUY4thx6ewWg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-j6MQVoNAOyW8A7Dyb2-jzA-1; Mon, 27 Feb 2023 03:11:18 -0500
X-MC-Unique: j6MQVoNAOyW8A7Dyb2-jzA-1
Received: by mail-pf1-f199.google.com with SMTP id
 bx9-20020a056a00428900b005f077bc6e5eso1823807pfb.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 00:11:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hUtR13nE9ADMPfRUasH4TVIIvHusnhAtQQrD5pDjQxw=;
 b=7vAE1eheVociUmgqhEs1gNMnt2pVd6IloCv3yh1sIMVcf8dmyvEoNM/9B1t0ii1WR+
 2LoHWMIx6HccodC0qFKwKoTQG7HIX9zRJNjB/uLtMjCoUDsShmhFPPC7eeLlPAMvbZSQ
 sJRdi6VpliOtDuNmwNi1jNXg2LYApZ4+tYNGsyldK+jhqaeiO+tnkcLHThRfI0MjLHUr
 RvUaEMp8iFIHqQxnF9Db7DxoQ5sBGfJF6x5iFScEl3IOKvkQl1eqUdrFHthAEpDHYCgg
 YyKZWkdgrcl+8jDUrgniPZhIZyvOWS9I30isn0T+G4t2IPG7wB29Q6BO+Y0AR5ZSIeNa
 cS+w==
X-Gm-Message-State: AO0yUKVUVRFxGg/jw6zeiOViPUhVQ2pH7FUMVauovS5TgeUDbSAQIZnW
 wrHhBjq2uxhPSldoEC4czVenPLOAfw/T/I8woe7Vbp7QpeugekHzL1Kr0MPHRwoVR7Hn+jGbT2R
 igdj1fm11cX4SpktzRnr02r/hR7jF0Mr1KORoeM23mw==
X-Received: by 2002:a05:6a20:3d22:b0:cb:2c8e:14c with SMTP id
 y34-20020a056a203d2200b000cb2c8e014cmr28921265pzi.10.1677485475483; 
 Mon, 27 Feb 2023 00:11:15 -0800 (PST)
X-Google-Smtp-Source: AK7set8BhUGj4vcSwHgyu0gKLYPNZhMCRxlPQM0ZRXhswU/X8LocF0YSDbVhbN1tzMwhbVQS25+x4Q==
X-Received: by 2002:a05:6a20:3d22:b0:cb:2c8e:14c with SMTP id
 y34-20020a056a203d2200b000cb2c8e014cmr28921230pzi.10.1677485475193; 
 Mon, 27 Feb 2023 00:11:15 -0800 (PST)
Received: from [10.72.13.83] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 g66-20020a636b45000000b004ff6b744248sm3471596pgc.48.2023.02.27.00.11.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Feb 2023 00:11:14 -0800 (PST)
Message-ID: <45482a90-1bb6-fc67-3fbd-86833d7d00c1@redhat.com>
Date: Mon, 27 Feb 2023 16:11:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 10/15] vdpa: disable RAM block discard only for the
 first device
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230224155438.112797-1-eperezma@redhat.com>
 <20230224155438.112797-11-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230224155438.112797-11-eperezma@redhat.com>
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

CuWcqCAyMDIzLzIvMjQgMjM6NTQsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPiBBbHRob3VnaCBp
dCBkb2VzIG5vdCBtYWtlIGEgYmlnIGRpZmZlcmVuY2UsIGl0cyBtb3JlIGNvcnJlY3QgYW5kCj4g
c2ltcGxpZmllcyB0aGUgY2xlYW51cCBwYXRoIGluIHN1YnNlcXVlbnQgcGF0Y2hlcy4KPgo+IE1v
dmUgcmFtX2Jsb2NrX2Rpc2NhcmRfZGlzYWJsZShmYWxzZSkgY2FsbCB0byB0aGUgdG9wIG9mCj4g
dmhvc3RfdmRwYV9jbGVhbnVwIGJlY2F1c2U6Cj4gKiBXZSBjYW5ub3QgdXNlIHZob3N0X3ZkcGFf
Zmlyc3RfZGV2IGFmdGVyIGRldi0+b3BhcXVlID0gTlVMTAo+ICAgIGFzc2lnbm1lbnQuCj4gKiBJ
bXByb3ZlIHRoZSBzdGFjayBvcmRlciBpbiBjbGVhbnVwOiBzaW5jZSBpdCBpcyB0aGUgbGFzdCBh
Y3Rpb24gdGFrZW4KPiAgICBpbiBpbml0LCBpdCBzaG91bGQgYmUgdGhlIGZpcnN0IGF0IGNsZWFu
dXAuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNv
bT4KPiAtLS0KPiAgIGh3L3ZpcnRpby92aG9zdC12ZHBhLmMgfCAyNSArKysrKysrKysrKysrKy0t
LS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRp
b25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXZkcGEuYyBiL2h3L3ZpcnRp
by92aG9zdC12ZHBhLmMKPiBpbmRleCA3MWUzZGMyMWZlLi4yNzY1NWU3NTgyIDEwMDY0NAo+IC0t
LSBhL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPiArKysgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5j
Cj4gQEAgLTQzMSwxNiArNDMxLDYgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX2luaXQoc3RydWN0
IHZob3N0X2RldiAqZGV2LCB2b2lkICpvcGFxdWUsIEVycm9yICoqZXJycCkKPiAgICAgICB0cmFj
ZV92aG9zdF92ZHBhX2luaXQoZGV2LCBvcGFxdWUpOwo+ICAgICAgIGludCByZXQ7Cj4gICAKPiAt
ICAgIC8qCj4gLSAgICAgKiBTaW1pbGFyIHRvIFZGSU8sIHdlIGVuZCB1cCBwaW5uaW5nIGFsbCBn
dWVzdCBtZW1vcnkgYW5kIGhhdmUgdG8KPiAtICAgICAqIGRpc2FibGUgZGlzY2FyZGluZyBvZiBS
QU0uCj4gLSAgICAgKi8KPiAtICAgIHJldCA9IHJhbV9ibG9ja19kaXNjYXJkX2Rpc2FibGUodHJ1
ZSk7Cj4gLSAgICBpZiAocmV0KSB7Cj4gLSAgICAgICAgZXJyb3JfcmVwb3J0KCJDYW5ub3Qgc2V0
IGRpc2NhcmRpbmcgb2YgUkFNIGJyb2tlbiIpOwo+IC0gICAgICAgIHJldHVybiByZXQ7Cj4gLSAg
ICB9Cj4gLQo+ICAgICAgIHYgPSBvcGFxdWU7Cj4gICAgICAgdi0+ZGV2ID0gZGV2Owo+ICAgICAg
IGRldi0+b3BhcXVlID0gIG9wYXF1ZSA7Cj4gQEAgLTQ1Miw2ICs0NDIsMTYgQEAgc3RhdGljIGlu
dCB2aG9zdF92ZHBhX2luaXQoc3RydWN0IHZob3N0X2RldiAqZGV2LCB2b2lkICpvcGFxdWUsIEVy
cm9yICoqZXJycCkKPiAgICAgICAgICAgcmV0dXJuIDA7Cj4gICAgICAgfQo+ICAgCj4gKyAgICAv
Kgo+ICsgICAgICogU2ltaWxhciB0byBWRklPLCB3ZSBlbmQgdXAgcGlubmluZyBhbGwgZ3Vlc3Qg
bWVtb3J5IGFuZCBoYXZlIHRvCj4gKyAgICAgKiBkaXNhYmxlIGRpc2NhcmRpbmcgb2YgUkFNLgo+
ICsgICAgICovCj4gKyAgICByZXQgPSByYW1fYmxvY2tfZGlzY2FyZF9kaXNhYmxlKHRydWUpOwo+
ICsgICAgaWYgKHJldCkgewo+ICsgICAgICAgIGVycm9yX3JlcG9ydCgiQ2Fubm90IHNldCBkaXNj
YXJkaW5nIG9mIFJBTSBicm9rZW4iKTsKPiArICAgICAgICByZXR1cm4gcmV0Owo+ICsgICAgfQoK
CldlIHNlZW1zIHRvIGxvc2UgdGhlIGNoYW5jZSB0byBmcmVlIHN2cSBhbGxvY2F0ZWQgYnkgCnZo
b3N0X3ZkcGFfaW5pdF9zdnEoKSBpbiB0aGlzIGNhc2U/CgpUaGFua3MKCgo+ICsKPiAgICAgICB2
aG9zdF92ZHBhX2FkZF9zdGF0dXMoZGV2LCBWSVJUSU9fQ09ORklHX1NfQUNLTk9XTEVER0UgfAo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19DT05GSUdfU19EUklWRVIp
Owo+ICAgCj4gQEAgLTU3NywxMiArNTc3LDE1IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9jbGVh
bnVwKHN0cnVjdCB2aG9zdF9kZXYgKmRldikKPiAgICAgICBhc3NlcnQoZGV2LT52aG9zdF9vcHMt
PmJhY2tlbmRfdHlwZSA9PSBWSE9TVF9CQUNLRU5EX1RZUEVfVkRQQSk7Cj4gICAgICAgdiA9IGRl
di0+b3BhcXVlOwo+ICAgICAgIHRyYWNlX3Zob3N0X3ZkcGFfY2xlYW51cChkZXYsIHYpOwo+ICsg
ICAgaWYgKHZob3N0X3ZkcGFfZmlyc3RfZGV2KGRldikpIHsKPiArICAgICAgICByYW1fYmxvY2tf
ZGlzY2FyZF9kaXNhYmxlKGZhbHNlKTsKPiArICAgIH0KPiArCj4gICAgICAgdmhvc3RfdmRwYV9o
b3N0X25vdGlmaWVyc191bmluaXQoZGV2LCBkZXYtPm52cXMpOwo+ICAgICAgIG1lbW9yeV9saXN0
ZW5lcl91bnJlZ2lzdGVyKCZ2LT5saXN0ZW5lcik7Cj4gICAgICAgdmhvc3RfdmRwYV9zdnFfY2xl
YW51cChkZXYpOwo+ICAgCj4gICAgICAgZGV2LT5vcGFxdWUgPSBOVUxMOwo+IC0gICAgcmFtX2Js
b2NrX2Rpc2NhcmRfZGlzYWJsZShmYWxzZSk7Cj4gICAKPiAgICAgICByZXR1cm4gMDsKPiAgIH0K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
