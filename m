Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B53EC433EF
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 06:57:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E88EC40398;
	Tue, 23 Nov 2021 06:57:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gv257n5XMm5l; Tue, 23 Nov 2021 06:57:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 36492400C4;
	Tue, 23 Nov 2021 06:57:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07E6DC001E;
	Tue, 23 Nov 2021 06:57:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6F67C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 06:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8012E4036D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 06:57:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V9r56copeDKs
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 06:57:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 39A4E40367
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 06:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637650625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GWUj1kggOJwVn9nufANfVaiqNMAveWmuMeYYz856+vQ=;
 b=RDugUy/ArJgAv1mkmcPlcMIcMglRYjswiSVqd/97UDd5+T/nF+Sr43SHP/XDBKDb08G/bt
 GZ3JNDOYoS0iDo2PSRxqVUuajI3Cq8Zs3frVaBvqkwEaUimOT45TomRAQb7E3h7JgPE7xV
 sPjKyXWMxjUjhNxVGNRHrOBXwprLOSY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-e1dWUEE7NjyKnEF99Pr1Wg-1; Tue, 23 Nov 2021 01:57:04 -0500
X-MC-Unique: e1dWUEE7NjyKnEF99Pr1Wg-1
Received: by mail-pg1-f197.google.com with SMTP id
 a26-20020a63bd1a000000b002fab31bc2d9so6463660pgf.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 22:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=GWUj1kggOJwVn9nufANfVaiqNMAveWmuMeYYz856+vQ=;
 b=h1/8vDtTiu2lVH3AUNcXXYSd4GO0WLOTwRGOO2oEObUTrqovzVzDRIXxYPd4Q/VBr5
 81qbJHUR97m4k70FSANsyun1IYeaUdwWoRFGNLYqlr52GsVzeLUDRvXeXMl0+SRGpE97
 7Xf6B4S8kYt+Acf2RzB4XB7JxiygpxxbARy5sod7NIRC2AOLA8aBe3t66DoiQZY6mqHW
 ZQo96s3bYfWup7TbVZTgZB0VRrv+T9LstymC0Ww2/LpqMwTqD6GhCCEe3ogw8qjLBWvY
 2ZPi4IIYNaEt0Si4tl5cBfCXb3F8fuW6kmW3FI6wp3g6cqCp0epavvW9bV/7IQCtesjv
 spqQ==
X-Gm-Message-State: AOAM532ySbAPYCP9eVq1f6gl1WpDmdIhvQPHJ6+cwVmy7Gc937e1Xq3a
 rZrDvbqTo4kiEFfFSqZswurFwEcHrEB/gvpdlAvGouL1c1DhDClnEDLfUtp5SuORU9ScXyZlwMQ
 30L23qxPZJpmm/dOFx0b/gbXtP4O6PCoEs8a629VNug==
X-Received: by 2002:a17:90b:1bc4:: with SMTP id
 oa4mr180945pjb.179.1637650623321; 
 Mon, 22 Nov 2021 22:57:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPL2QJKjoHPmdLbtxKbySabAMZ4bDIWG493PG9oDl/f0ZYXaMp+tb1JDcCUCke02dyT0JXrw==
X-Received: by 2002:a17:90b:1bc4:: with SMTP id
 oa4mr180909pjb.179.1637650623001; 
 Mon, 22 Nov 2021 22:57:03 -0800 (PST)
Received: from xz-m1.local ([191.101.132.71])
 by smtp.gmail.com with ESMTPSA id md6sm107102pjb.22.2021.11.22.22.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Nov 2021 22:57:01 -0800 (PST)
Date: Tue, 23 Nov 2021 14:56:52 +0800
From: Peter Xu <peterx@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH v5 23/26] util: Add iova_tree_alloc
Message-ID: <YZyQtF0SIPcVZI+v@xz-m1.local>
References: <20211029183525.1776416-1-eperezma@redhat.com>
 <20211029183525.1776416-24-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211029183525.1776416-24-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Xiao W Wang <xiao.w.wang@intel.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Eli Cohen <eli@mellanox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, virtualization@lists.linux-foundation.org,
 Parav Pandit <parav@mellanox.com>
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

SGksIEV1Z2VuaW8sCgpTb3JyeSBmb3IgdGhlIHN1cGVyIGxhdGUgcmVzcG9uc2UuCgpPbiBGcmks
IE9jdCAyOSwgMjAyMSBhdCAwODozNToyMlBNICswMjAwLCBFdWdlbmlvIFDDqXJleiB3cm90ZToK
ClsuLi5dCgo+ICtpbnQgaW92YV90cmVlX2FsbG9jKElPVkFUcmVlICp0cmVlLCBETUFNYXAgKm1h
cCwgaHdhZGRyIGlvdmFfYmVnaW4sCj4gKyAgICAgICAgICAgICAgICAgICAgaHdhZGRyIGlvdmFf
bGFzdCkKPiArewo+ICsgICAgc3RydWN0IElPVkFUcmVlQWxsb2NBcmdzIGFyZ3MgPSB7Cj4gKyAg
ICAgICAgLm5ld19zaXplID0gbWFwLT5zaXplLAo+ICsgICAgICAgIC5pb3ZhX2JlZ2luID0gaW92
YV9iZWdpbiwKPiArICAgICAgICAuaW92YV9sYXN0ID0gaW92YV9sYXN0LAo+ICsgICAgfTsKPiAr
Cj4gKyAgICBpZiAoaW92YV9iZWdpbiA9PSAwKSB7Cj4gKyAgICAgICAgLyogU29tZSBkZXZpY2Vz
IGRvZXMgbm90IGxpa2UgYWRkciAwICovCj4gKyAgICAgICAgaW92YV9iZWdpbiArPSBxZW11X3Jl
YWxfaG9zdF9wYWdlX3NpemU7Cj4gKyAgICB9CgpBbnkgZXhwbGFuYXRpb24gb2Ygd2h5IHplcm8g
aXMgbm90IHdlbGNvbWVkPwoKSXQgd291bGQgYmUgZ3JlYXQgaWYgd2UgY2FuIG1vdmUgdGhpcyBv
dXQgb2YgaW92YS10cmVlLmMsIGJlY2F1c2UgdGhhdCBkb2Vzbid0Cmxvb2sgbGlrZSBhIGdvb2Qg
cGxhY2UgdG8sIGUuZy4gcmVmZXJlbmNlIHFlbXVfcmVhbF9ob3N0X3BhZ2Vfc2l6ZSwgYW55d2F5
cy4KVGhlIGNhbGxlciBjYW4gc2ltcGx5IHBhc3MgaW4gcWVtdV9yZWFsX2hvc3RfcGFnZV9zaXpl
IGFzIGlvdmFfYmVnaW4gd2hlbgpuZWVkZWQgKGFuZCBJIGhpZ2hseSBkb3VidCBpdCdsbCBiZSBh
IG11c3QgZm9yIGFsbCBpb3ZhLXRyZWUgdXNlcnMuLikKCj4gKwo+ICsgICAgYXNzZXJ0KGlvdmFf
YmVnaW4gPCBpb3ZhX2xhc3QpOwo+ICsKPiArICAgIC8qCj4gKyAgICAgKiBGaW5kIGEgdmFsaWQg
aG9sZSBmb3IgdGhlIG1hcHBpbmcKPiArICAgICAqCj4gKyAgICAgKiBBc3N1bWluZyBsb3cgaW92
YV9iZWdpbiwgc28gbm8gbmVlZCB0byBkbyBhIGJpbmFyeSBzZWFyY2ggdG8KPiArICAgICAqIGxv
Y2F0ZSB0aGUgZmlyc3Qgbm9kZS4KPiArICAgICAqCj4gKyAgICAgKiBUT0RPOiBXZSBjYW4gaW1w
cm92ZSB0aGUgc2VhcmNoIHNwZWVkIGlmIHdlIHNhdmUgdGhlIGJlZ2lubmluZyBhbmQgdGhlCj4g
KyAgICAgKiBlbmQgb2YgaG9sZXMsIHNvIHdlIGRvbid0IGl0ZXJhdGUgb3ZlciB0aGUgcHJldmlv
dXMgc2F2ZWQgb25lcy4KPiArICAgICAqCj4gKyAgICAgKiBUT0RPOiBSZXBsYWNlIGFsbCB0aGlz
IHdpdGggZ190cmVlX25vZGVfZmlyc3QvbmV4dC9sYXN0IHdoZW4gYXZhaWxhYmxlCj4gKyAgICAg
KiAoZnJvbSBnbGliIHNpbmNlIDIuNjgpLiBUbyBkbyBpdCB3aXRoIGdfdHJlZV9mb3JlYWNoIGNv
bXBsaWNhdGVzIHRoZQo+ICsgICAgICogY29kZSBhIGxvdC4KPiArICAgICAqCj4gKyAgICAgKi8K
PiArICAgIGdfdHJlZV9mb3JlYWNoKHRyZWUtPnRyZWUsIGlvdmFfdHJlZV9hbGxvY190cmF2ZXJz
ZSwgJmFyZ3MpOwo+ICsgICAgaWYgKCFpb3ZhX3RyZWVfYWxsb2NfbWFwX2luX2hvbGUoJmFyZ3Mp
KSB7Cj4gKyAgICAgICAgLyoKPiArICAgICAgICAgKiAybmQgdHJ5OiBMYXN0IGl0ZXJhdGlvbiBs
ZWZ0IGFyZ3MtPnJpZ2h0IGFzIHRoZSBsYXN0IERNQU1hcC4gQnV0Cj4gKyAgICAgICAgICogKHJp
Z2h0LCBlbmQpIGhvbGUgbmVlZHMgdG8gYmUgY2hlY2tlZCB0b28KPiArICAgICAgICAgKi8KPiAr
ICAgICAgICBpb3ZhX3RyZWVfYWxsb2NfYXJnc19pdGVyYXRlKCZhcmdzLCBOVUxMKTsKPiArICAg
ICAgICBpZiAoIWlvdmFfdHJlZV9hbGxvY19tYXBfaW5faG9sZSgmYXJncykpIHsKPiArICAgICAg
ICAgICAgcmV0dXJuIElPVkFfRVJSX05PTUVNOwo+ICsgICAgICAgIH0KPiArICAgIH0KPiArCj4g
KyAgICBtYXAtPmlvdmEgPSBNQVgoaW92YV9iZWdpbiwKPiArICAgICAgICAgICAgICAgICAgICBh
cmdzLmhvbGVfbGVmdCA/Cj4gKyAgICAgICAgICAgICAgICAgICAgYXJncy5ob2xlX2xlZnQtPmlv
dmEgKyBhcmdzLmhvbGVfbGVmdC0+c2l6ZSArIDEgOiAwKTsKPiArICAgIHJldHVybiBpb3ZhX3Ry
ZWVfaW5zZXJ0KHRyZWUsIG1hcCk7Cj4gK30KClJlIHRoZSBhbGdvcml0aG0gLSBJIHRvdGFsbHkg
YWdyZWUgSmFzb24ncyB2ZXJzaW9uIGlzIG11Y2ggYmV0dGVyLgoKVGhhbmtzLAoKLS0gClBldGVy
IFh1CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
