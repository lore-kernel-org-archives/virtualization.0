Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC163EB64DD
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 14:02:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FC8160B5A;
	Thu,  6 Jul 2023 14:02:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6FC8160B5A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bHuAjGdM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8wMrhAXleBkW; Thu,  6 Jul 2023 14:02:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DFC0B600B6;
	Thu,  6 Jul 2023 14:02:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DFC0B600B6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7466C0072;
	Thu,  6 Jul 2023 14:02:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8B47C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 14:02:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B3A284189F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 14:02:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B3A284189F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bHuAjGdM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I0IGY9FeIQI3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 14:02:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 88B8E41889
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 88B8E41889
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 14:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688652143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0GE7k8I9982HVE9TTWbDiwrZOKfvdOMPK3S9DyegjXE=;
 b=bHuAjGdMeb5UM7luqOYiBeR/SBM0Uv+jAqXatTXJi/062i/HA8yoilJE8rurBOGAcNj6PJ
 6QkXfiyWmZ8I1+XwOC/2hHjGv2710/4PkQjn1WHxlCz9xzt178m6/jQdOQJkITqOcseSee
 rOrFxSlRIx5fxO95bWgnL4effoiLkVs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-hYpK7pa8NJutrJkJO-cXJg-1; Thu, 06 Jul 2023 10:02:21 -0400
X-MC-Unique: hYpK7pa8NJutrJkJO-cXJg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3141a98a29aso417740f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jul 2023 07:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688652140; x=1691244140;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0GE7k8I9982HVE9TTWbDiwrZOKfvdOMPK3S9DyegjXE=;
 b=O4kfWZiX4ePp7hiB5pnk4pjItWp8dKxCRKhzeybCLbgCvKqOJqO26mqigrHZKxXHmz
 gLA2ycZewIV/malXlPiMXC9yJNRD922JhQW5EaoWi48SWXnBhKtNc1GbI04raV2CfhTW
 QrCnaCTqKBSmFp/lJErcqrwmrQNmvf+rkKuIq9Zxm+rLrzbKPa8K/DSjv0YJL/PiSFhJ
 JiOwP/RxWp+pSeP14OsOGcuezf728f2MOqC2YKmPEjeB1ZRJdJO54/fbNxHzzLo3ddQ5
 R8I+Xa/SYGih6D7wrfGogsbXzcwPTex4YqtL62qBcRGQX6toGGv2uNxwZYlQt3EKArWk
 YBtQ==
X-Gm-Message-State: ABy/qLZAsZ1g4GIfvexthrj3oreOhv+7BYRtsLJP2ZSkXpsgZaq7a2UR
 GOWKdBBtAYv1/raTvdafyHMotKr56/l307de5VpHvT+/k3Pa880aquDGfX52QVA9EB8CnQ5WDw1
 3oelm3bqAJNR0qwDawKb2eikYIVx6EF2cisg5OCnwPQ==
X-Received: by 2002:a5d:4e12:0:b0:313:e2c8:bed1 with SMTP id
 p18-20020a5d4e12000000b00313e2c8bed1mr2235680wrt.34.1688652140615; 
 Thu, 06 Jul 2023 07:02:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHcrZAK048UNMfdOsb+IYlPvPsKZoDto6N+0HK8CkttE8tg+x61xjZ/Drujf9ZKOumGT2ngEg==
X-Received: by 2002:a5d:4e12:0:b0:313:e2c8:bed1 with SMTP id
 p18-20020a5d4e12000000b00313e2c8bed1mr2235624wrt.34.1688652140228; 
 Thu, 06 Jul 2023 07:02:20 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 o2-20020a5d4742000000b0031434936f0dsm1960350wrs.68.2023.07.06.07.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 07:02:19 -0700 (PDT)
Date: Thu, 6 Jul 2023 10:02:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yang Rong <yangrong@vivo.com>
Subject: Re: [PATCH] Fix max/min warnings in virtio_net, amd/display, and
 io_uring
Message-ID: <20230706100133-mutt-send-email-mst@kernel.org>
References: <20230706021102.2066-1-yangrong@vivo.com>
MIME-Version: 1.0
In-Reply-To: <20230706021102.2066-1-yangrong@vivo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Max Tseng <Max.Tseng@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jun Lei <Jun.Lei@amd.com>,
 Josip Pavic <Josip.Pavic@amd.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 David Airlie <airlied@gmail.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 "open list:AMD DISPLAY CORE" <amd-gfx@lists.freedesktop.org>,
 "open list:IO_URING" <io-uring@vger.kernel.org>,
 Alvin Lee <Alvin.Lee2@amd.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Harry Wentland <harry.wentland@amd.com>,
 opensource.kernel@vivo.com, Leo Li <sunpeng.li@amd.com>,
 Cruise Hung <cruise.hung@amd.com>, Jens Axboe <axboe@kernel.dk>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 open list <linux-kernel@vger.kernel.org>, luhongfei@vivo.com,
 "David S. Miller" <davem@davemloft.net>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Pavel Begunkov <asml.silence@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVGh1LCBKdWwgMDYsIDIwMjMgYXQgMTA6MDY6MTZBTSArMDgwMCwgWWFuZyBSb25nIHdyb3Rl
Ogo+IFRoZSBmaWxlcyBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMsIGRyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY19kbXViX3Nydi5jLCBhbmQgaW9fdXJpbmcvaW9fdXJpbmcuYyB3ZXJl
IG1vZGlmaWVkIHRvIGZpeCB3YXJuaW5ncy4KCndoYXQgd2FybmluZ3M/IHRoZSBwb2ludCBvZiB0
aGUgd2FybmluZyBpcyB0byBhbmFseXplIGl0IG5vdCAiZml4IiBpdApibGluZGx5LgoKPiBTcGVj
aWZpY2FsbHksIHRoZSBvcHBvcnR1bml0aWVzIGZvciBtYXgoKSBhbmQgbWluKCkgd2VyZSB1dGls
aXplZCB0byBhZGRyZXNzIHRoZSB3YXJuaW5ncy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFJv
bmcgPHlhbmdyb25nQHZpdm8uY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNfZG11Yl9zcnYuYyB8IDYgKysrLS0tCj4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
YyAgICAgICAgICAgICAgICAgICAgIHwgMyArKy0KPiAgaW9fdXJpbmcvaW9fdXJpbmcuYyAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAzICsrLQo+ICAzIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjX2RtdWJfc3J2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNfZG11Yl9zcnYuYwo+IGluZGV4IGM3NTNjNmYzMGRkNy4uZGY3OWFlYTQ5YTNjIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19kbXViX3Nydi5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX2RtdWJfc3J2LmMKPiBA
QCAtMjIsNyArMjIsNyBAQAo+ICAgKiBBdXRob3JzOiBBTUQKPiAgICoKPiAgICovCj4gLQo+ICsj
aW5jbHVkZSA8bGludXgvbWlubWF4Lmg+Cj4gICNpbmNsdWRlICJkYy5oIgo+ICAjaW5jbHVkZSAi
ZGNfZG11Yl9zcnYuaCIKPiAgI2luY2x1ZGUgIi4uL2RtdWIvZG11Yl9zcnYuaCIKPiBAQCAtNDgx
LDcgKzQ4MSw3IEBAIHN0YXRpYyB2b2lkIHBvcHVsYXRlX3N1YnZwX2NtZF9kcnJfaW5mbyhzdHJ1
Y3QgZGMgKmRjLAo+ICAgICAgICAgbWF4X2Rycl92YmxhbmtfdXMgPSBkaXY2NF91NjQoKHN1YnZw
X2FjdGl2ZV91cyAtIHByZWZldGNoX3VzIC0KPiAgICAgICAgICAgICAgICAgICAgICAgICBkYy0+
Y2Fwcy5zdWJ2cF9md19wcm9jZXNzaW5nX2RlbGF5X3VzIC0gZHJyX2FjdGl2ZV91cyksIDIpICsg
ZHJyX2FjdGl2ZV91czsKPiAgICAgICAgIG1heF9kcnJfbWFsbHJlZ2lvbl91cyA9IHN1YnZwX2Fj
dGl2ZV91cyAtIHByZWZldGNoX3VzIC0gbWFsbF9yZWdpb25fdXMgLSBkYy0+Y2Fwcy5zdWJ2cF9m
d19wcm9jZXNzaW5nX2RlbGF5X3VzOwo+IC0gICAgICAgbWF4X2Rycl9zdXBwb3J0ZWRfdXMgPSBt
YXhfZHJyX3ZibGFua191cyA+IG1heF9kcnJfbWFsbHJlZ2lvbl91cyA/IG1heF9kcnJfdmJsYW5r
X3VzIDogbWF4X2Rycl9tYWxscmVnaW9uX3VzOwo+ICsgICAgICAgbWF4X2Rycl9zdXBwb3J0ZWRf
dXMgPSBtYXgobWF4X2Rycl92YmxhbmtfdXMsIG1heF9kcnJfbWFsbHJlZ2lvbl91cyk7Cj4gICAg
ICAgICBtYXhfdnRvdGFsX3N1cHBvcnRlZCA9IGRpdjY0X3U2NCgoKHVpbnQ2NF90KWRycl90aW1p
bmctPnBpeF9jbGtfMTAwaHogKiAxMDAgKiBtYXhfZHJyX3N1cHBvcnRlZF91cyksCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgKCgodWludDY0X3QpZHJyX3RpbWluZy0+aF90b3RhbCAqIDEwMDAw
MDApKSk7Cj4gCj4gQEAgLTc3MSw3ICs3NzEsNyBAQCB2b2lkIGRjX2RtdWJfc2V0dXBfc3VidnBf
ZG11Yl9jb21tYW5kKHN0cnVjdCBkYyAqZGMsCj4gICAgICAgICAgICAgICAgIHdtX3ZhbF9yZWZj
bGsgPSBjb250ZXh0LT5id19jdHguYncuZGNuLndhdGVybWFya3MuYS5jc3RhdGVfcHN0YXRlLnBz
dGF0ZV9jaGFuZ2VfbnMgKgo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKGRjLT5y
ZXNfcG9vbC0+cmVmX2Nsb2Nrcy5kY2h1Yl9yZWZfY2xvY2tfaW5LaHogLyAxMDAwKSAvIDEwMDA7
Cj4gCj4gLSAgICAgICAgICAgICAgIGNtZC5md19hc3Npc3RlZF9tY2xrX3N3aXRjaF92Mi5jb25m
aWdfZGF0YS53YXRlcm1hcmtfYV9jYWNoZSA9IHdtX3ZhbF9yZWZjbGsgPCAweEZGRkYgPyB3bV92
YWxfcmVmY2xrIDogMHhGRkZGOwo+ICsgICAgICAgICAgICAgICBjbWQuZndfYXNzaXN0ZWRfbWNs
a19zd2l0Y2hfdjIuY29uZmlnX2RhdGEud2F0ZXJtYXJrX2FfY2FjaGUgPSBtaW4od21fdmFsX3Jl
ZmNsaywgMHhGRkZGKTsKPiAgICAgICAgIH0KPiAKPiAgICAgICAgIGRtX2V4ZWN1dGVfZG11Yl9j
bWQoZGMtPmN0eCwgJmNtZCwgRE1fRE1VQl9XQUlUX1RZUEVfV0FJVCk7Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IGlu
ZGV4IDliMzcyMTQyNGU3MS4uNWJiN2RhODg1ZjAwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IEBAIC0yMiw2
ICsyMiw3IEBACj4gICNpbmNsdWRlIDxuZXQvcm91dGUuaD4KPiAgI2luY2x1ZGUgPG5ldC94ZHAu
aD4KPiAgI2luY2x1ZGUgPG5ldC9uZXRfZmFpbG92ZXIuaD4KPiArI2luY2x1ZGUgPGxpbnV4L21p
bm1heC5oPgo+IAo+ICBzdGF0aWMgaW50IG5hcGlfd2VpZ2h0ID0gTkFQSV9QT0xMX1dFSUdIVDsK
PiAgbW9kdWxlX3BhcmFtKG5hcGlfd2VpZ2h0LCBpbnQsIDA0NDQpOwo+IEBAIC0xMjkxLDcgKzEy
OTIsNyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKmJ1aWxkX3NrYl9mcm9tX3hkcF9idWZmKHN0
cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICBfX3NrYl9wdXQoc2tiLCBkYXRhX2xlbik7
Cj4gCj4gICAgICAgICBtZXRhc2l6ZSA9IHhkcC0+ZGF0YSAtIHhkcC0+ZGF0YV9tZXRhOwo+IC0g
ICAgICAgbWV0YXNpemUgPSBtZXRhc2l6ZSA+IDAgPyBtZXRhc2l6ZSA6IDA7Cj4gKyAgICAgICBt
ZXRhc2l6ZSA9IG1heChtZXRhc2l6ZSwgMCk7Cj4gICAgICAgICBpZiAobWV0YXNpemUpCj4gICAg
ICAgICAgICAgICAgIHNrYl9tZXRhZGF0YV9zZXQoc2tiLCBtZXRhc2l6ZSk7Cj4gCj4gZGlmZiAt
LWdpdCBhL2lvX3VyaW5nL2lvX3VyaW5nLmMgYi9pb191cmluZy9pb191cmluZy5jCj4gaW5kZXgg
ZTgwOTZkNTAyYTdjLi44NzVjYTY1NzIyN2QgMTAwNjQ0Cj4gLS0tIGEvaW9fdXJpbmcvaW9fdXJp
bmcuYwo+ICsrKyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKPiBAQCAtNDcsNiArNDcsNyBAQAo+ICAj
aW5jbHVkZSA8bGludXgvcmVmY291bnQuaD4KPiAgI2luY2x1ZGUgPGxpbnV4L3Vpby5oPgo+ICAj
aW5jbHVkZSA8bGludXgvYml0cy5oPgo+ICsjaW5jbHVkZSA8bGludXgvbWlubWF4Lmg+Cj4gCj4g
ICNpbmNsdWRlIDxsaW51eC9zY2hlZC9zaWduYWwuaD4KPiAgI2luY2x1ZGUgPGxpbnV4L2ZzLmg+
Cj4gQEAgLTI2NjAsNyArMjY2MSw3IEBAIHN0YXRpYyB2b2lkICpfX2lvX3VhZGRyX21hcChzdHJ1
Y3QgcGFnZSAqKipwYWdlcywgdW5zaWduZWQgc2hvcnQgKm5wYWdlcywKPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFnZV9hcnJheSk7Cj4gICAgICAgICBpZiAocmV0
ICE9IG5yX3BhZ2VzKSB7Cj4gIGVycjoKPiAtICAgICAgICAgICAgICAgaW9fcGFnZXNfZnJlZSgm
cGFnZV9hcnJheSwgcmV0ID4gMCA/IHJldCA6IDApOwo+ICsgICAgICAgICAgICAgICBpb19wYWdl
c19mcmVlKCZwYWdlX2FycmF5LCBtYXgocmV0LCAwKSk7Cj4gICAgICAgICAgICAgICAgIHJldHVy
biByZXQgPCAwID8gRVJSX1BUUihyZXQpIDogRVJSX1BUUigtRUZBVUxUKTsKPiAgICAgICAgIH0K
PiAgICAgICAgIC8qCj4gLS0KPiAyLjM1LjMKPiAKPiAKPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwo+IOacrOmCruS7tuWPiuWFtumZhOS7tuWGheWuueWPr+iDveWQq+acieacuuWv
huWSjC/miJbpmpDnp4Hkv6Hmga/vvIzku4XkvpvmjIflrprkuKrkurrmiJbmnLrmnoTkvb/nlKjj
gILoi6XmgqjpnZ7lj5Hku7bkurrmjIflrprmlLbku7bkurrmiJblhbbku6PnkIbkurrvvIzor7fl
i7/kvb/nlKjjgIHkvKDmkq3jgIHlpI3liLbmiJblrZjlgqjmraTpgq7ku7bkuYvku7vkvZXlhoXl
rrnmiJblhbbpmYTku7bjgILlpoLmgqjor6/mlLbmnKzpgq7ku7bvvIzor7fljbPku6Xlm57lpI3m
iJbnlLXor53mlrnlvI/pgJrnn6Xlj5Hku7bkurrvvIzlubblsIbljp/lp4vpgq7ku7bjgIHpmYTk
u7blj4rlhbbmiYDmnInlpI3mnKzliKDpmaTjgILosKLosKLjgIIKPiBUaGUgY29udGVudHMgb2Yg
dGhpcyBtZXNzYWdlIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFs
IGFuZC9vciBwcml2aWxlZ2VkIGluZm9ybWF0aW9uIGFuZCBhcmUgaW50ZW5kZWQgZXhjbHVzaXZl
bHkgZm9yIHRoZSBhZGRyZXNzZWUocykuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNp
cGllbnQgb2YgdGhpcyBtZXNzYWdlIG9yIHRoZWlyIGFnZW50LCBwbGVhc2Ugbm90ZSB0aGF0IGFu
eSB1c2UsIGRpc3NlbWluYXRpb24sIGNvcHlpbmcsIG9yIHN0b3JhZ2Ugb2YgdGhpcyBtZXNzYWdl
IG9yIGl0cyBhdHRhY2htZW50cyBpcyBub3QgYWxsb3dlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBt
ZXNzYWdlIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcmVwbHkgdGhlIG1l
c3NhZ2Ugb3IgcGhvbmUgYW5kIGRlbGV0ZSB0aGlzIG1lc3NhZ2UsIGFueSBhdHRhY2htZW50cyBh
bmQgYW55IGNvcGllcyBpbW1lZGlhdGVseS4KPiBUaGFuayB5b3UKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
