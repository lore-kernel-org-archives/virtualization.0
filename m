Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33DEC64ED8
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 08:13:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 664034059B;
	Mon, 27 Feb 2023 08:13:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 664034059B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dajt6juu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fKLgn-in4UDA; Mon, 27 Feb 2023 08:13:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CF11440168;
	Mon, 27 Feb 2023 08:13:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CF11440168
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6B7AC0033;
	Mon, 27 Feb 2023 08:13:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAFE7C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 98A73402F4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:13:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 98A73402F4
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dajt6juu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b1zNsKNNN8z2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:13:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9196D402EA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9196D402EA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677485580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DAVnTYAtQHEGqRzHa5Lwp4NgBHmokSHOFK2RDhsKbQ=;
 b=dajt6juuUXdGxTL3MXGId7HQED2RPtFnvX4uEL1lkHzOupRwQC8QAVCRpfEY+F4tphL39R
 JvYGA5YmUOab9luDLkuf50SRazY2bs58GezsYswIb1M8NS6yo7pg1D1Pcwk6uDs/g09EDR
 5p8llr+RXKx2QpfiB5IPKYZ7M821KRs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-623-ZsvmSENeOb2svdV1IzY3_A-1; Mon, 27 Feb 2023 03:12:59 -0500
X-MC-Unique: ZsvmSENeOb2svdV1IzY3_A-1
Received: by mail-pf1-f197.google.com with SMTP id
 i11-20020a056a00224b00b005d44149eb06so3042232pfu.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 00:12:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5DAVnTYAtQHEGqRzHa5Lwp4NgBHmokSHOFK2RDhsKbQ=;
 b=VIkP0dobIb5RKWbjs4V2oPkftPNweQS9zrAIX0h0LPDF5WZmiaY4+4YoB82T09EEsG
 +cwR2GGVy8eGRXI30JX8D2M9baFWYKYZ8nkKMJmkT0GJEWOzD4UmNjBnK/FatYgCFp7j
 d/opdCBFWnOUb7PArcCtCNzQ2jg67XQ1QCdSaBlSxfLHKcsOkORKTgJbHGl6qqpb92db
 O0pkHnorFD7Q4mZcRfTNGVX5aQU7HGopYsYVQz/DFLYcV4lyD8pJT36OHpGJEGqeUNZf
 YKnyVAhFuXqc7XTE0o8Lo6U9+0ItI2OhNWQvZgZcnRosQTSlaoe5Q1MJyPbaGMpssw11
 MQkA==
X-Gm-Message-State: AO0yUKUs8BmxqL+o86j8DTHooTp4qJeT511PzOws92ObxeYi0kGItAwL
 A0COC2jWD/r+ZM5TaKZ1b7gvJtSYtEks2dUorV4WYS4noREN0AQgPAluOXxmO+UtCzhDmqRWCwk
 LHhoPAKRwkorJyIbO9Hvibs6rcs2NFi6UTlaW8BBUXw==
X-Received: by 2002:a17:903:1390:b0:19c:b11b:ffe3 with SMTP id
 jx16-20020a170903139000b0019cb11bffe3mr13523733plb.23.1677485578163; 
 Mon, 27 Feb 2023 00:12:58 -0800 (PST)
X-Google-Smtp-Source: AK7set+FKdw5XBaDf8PETzZIIX0Ka6KUuwhVZcUzDA9yECP/l5m+7vA93exeG48Jl2elXXueKJovdg==
X-Received: by 2002:a17:903:1390:b0:19c:b11b:ffe3 with SMTP id
 jx16-20020a170903139000b0019cb11bffe3mr13523712plb.23.1677485577873; 
 Mon, 27 Feb 2023 00:12:57 -0800 (PST)
Received: from [10.72.13.83] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 jg15-20020a17090326cf00b0019adbef6a63sm3938244plb.235.2023.02.27.00.12.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Feb 2023 00:12:57 -0800 (PST)
Message-ID: <687e3228-2070-2842-0e30-c636c2fbda05@redhat.com>
Date: Mon, 27 Feb 2023 16:12:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 11/15] vdpa net: block migration if the device has CVQ
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230224155438.112797-1-eperezma@redhat.com>
 <20230224155438.112797-12-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230224155438.112797-12-eperezma@redhat.com>
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

CuWcqCAyMDIzLzIvMjQgMjM6NTQsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPiBEZXZpY2VzIHdp
dGggQ1ZRIG5lZWRzIHRvIG1pZ3JhdGUgc3RhdGUgYmV5b25kIHZxIHN0YXRlLiAgTGVhdmluZyB0
aGlzCj4gdG8gZnV0dXJlIHNlcmllcy4KPgo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6
IDxlcGVyZXptYUByZWRoYXQuY29tPgo+IC0tLQo+IHYzOiBNaWdyYXRpb24gYmxvY2tlciBpcyBy
ZWdpc3RlcmVkIGluIHZob3N0X2Rldi4KPiAtLS0KPiAgIGluY2x1ZGUvaHcvdmlydGlvL3Zob3N0
LXZkcGEuaCB8IDEgKwo+ICAgaHcvdmlydGlvL3Zob3N0LXZkcGEuYyAgICAgICAgIHwgMSArCj4g
ICBuZXQvdmhvc3QtdmRwYS5jICAgICAgICAgICAgICAgfCA5ICsrKysrKysrKwo+ICAgMyBmaWxl
cyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92
aXJ0aW8vdmhvc3QtdmRwYS5oIGIvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtdmRwYS5oCj4gaW5k
ZXggNGE3ZDM5NjY3NC4uYzI3OGEyYThkZSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2h3L3ZpcnRp
by92aG9zdC12ZHBhLmgKPiArKysgYi9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC12ZHBhLmgKPiBA
QCAtNTAsNiArNTAsNyBAQCB0eXBlZGVmIHN0cnVjdCB2aG9zdF92ZHBhIHsKPiAgICAgICBjb25z
dCBWaG9zdFNoYWRvd1ZpcnRxdWV1ZU9wcyAqc2hhZG93X3ZxX29wczsKPiAgICAgICB2b2lkICpz
aGFkb3dfdnFfb3BzX29wYXF1ZTsKPiAgICAgICBzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXY7Cj4gKyAg
ICBFcnJvciAqbWlncmF0aW9uX2Jsb2NrZXI7Cj4gICAgICAgVmhvc3RWRFBBSG9zdE5vdGlmaWVy
IG5vdGlmaWVyW1ZJUlRJT19RVUVVRV9NQVhdOwo+ICAgfSBWaG9zdFZEUEE7Cj4gICAKPiBkaWZm
IC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXZkcGEuYyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMK
PiBpbmRleCAyNzY1NWU3NTgyLi4yNWI2NGFlODU0IDEwMDY0NAo+IC0tLSBhL2h3L3ZpcnRpby92
aG9zdC12ZHBhLmMKPiArKysgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gQEAgLTQzOCw2ICs0
MzgsNyBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfaW5pdChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYs
IHZvaWQgKm9wYXF1ZSwgRXJyb3IgKiplcnJwKQo+ICAgICAgIHYtPm1zZ190eXBlID0gVkhPU1Rf
SU9UTEJfTVNHX1YyOwo+ICAgICAgIHZob3N0X3ZkcGFfaW5pdF9zdnEoZGV2LCB2KTsKPiAgIAo+
ICsgICAgZXJyb3JfcHJvcGFnYXRlKCZkZXYtPm1pZ3JhdGlvbl9ibG9ja2VyLCB2LT5taWdyYXRp
b25fYmxvY2tlcik7Cj4gICAgICAgaWYgKCF2aG9zdF92ZHBhX2ZpcnN0X2RldihkZXYpKSB7Cj4g
ICAgICAgICAgIHJldHVybiAwOwo+ICAgICAgIH0KPiBkaWZmIC0tZ2l0IGEvbmV0L3Zob3N0LXZk
cGEuYyBiL25ldC92aG9zdC12ZHBhLmMKPiBpbmRleCBjNTUxMmRkZjEwLi40Zjk4M2RmMDAwIDEw
MDY0NAo+IC0tLSBhL25ldC92aG9zdC12ZHBhLmMKPiArKysgYi9uZXQvdmhvc3QtdmRwYS5jCj4g
QEAgLTgyOCw2ICs4MjgsMTUgQEAgc3RhdGljIE5ldENsaWVudFN0YXRlICpuZXRfdmhvc3RfdmRw
YV9pbml0KE5ldENsaWVudFN0YXRlICpwZWVyLAo+ICAgCj4gICAgICAgICAgIHMtPnZob3N0X3Zk
cGEuc2hhZG93X3ZxX29wcyA9ICZ2aG9zdF92ZHBhX25ldF9zdnFfb3BzOwo+ICAgICAgICAgICBz
LT52aG9zdF92ZHBhLnNoYWRvd192cV9vcHNfb3BhcXVlID0gczsKPiArCj4gKyAgICAgICAgLyoK
PiArICAgICAgICAgKiBUT0RPOiBXZSBjYW5ub3QgbWlncmF0ZSBkZXZpY2VzIHdpdGggQ1ZRIGFz
IHRoZXJlIGlzIG5vIHdheSB0byBzZXQKPiArICAgICAgICAgKiB0aGUgZGV2aWNlIHN0YXRlIChN
QUMsIE1RLCBldGMpIGJlZm9yZSBzdGFydGluZyBkYXRhcGF0aC4KPiArICAgICAgICAgKgo+ICsg
ICAgICAgICAqIE1pZ3JhdGlvbiBibG9ja2VyIG93bmVyc2hpcCBub3cgYmVsb25ncyB0byB2CgoK
VGhlIHNlbnRlbmNlIGlzIGluY29tcGxldGUuCgpPdGhlciBsb29rcyBnb29kLgoKVGhhbmtzCgoK
PiArICAgICAgICAgKi8KPiArICAgICAgICBlcnJvcl9zZXRnKCZzLT52aG9zdF92ZHBhLm1pZ3Jh
dGlvbl9ibG9ja2VyLAo+ICsgICAgICAgICAgICAgICAgICAgIm5ldCB2ZHBhIGNhbm5vdCBtaWdy
YXRlIHdpdGggQ1ZRIGZlYXR1cmUiKTsKPiAgICAgICB9Cj4gICAgICAgcmV0ID0gdmhvc3RfdmRw
YV9hZGQobmMsICh2b2lkICopJnMtPnZob3N0X3ZkcGEsIHF1ZXVlX3BhaXJfaW5kZXgsIG52cXMp
Owo+ICAgICAgIGlmIChyZXQpIHsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
