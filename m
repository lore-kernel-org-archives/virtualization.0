Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA19DC433F5
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 03:48:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5C460E78
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 03:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F5C460E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0722160662;
	Wed, 13 Oct 2021 03:48:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QTd79eNILEZv; Wed, 13 Oct 2021 03:48:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 784A960655;
	Wed, 13 Oct 2021 03:47:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26459C0011;
	Wed, 13 Oct 2021 03:47:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CEA5C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ED22560662
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:47:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 40Jfomw3LZxJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:47:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0832C60655
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634096875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=403XhRrbqTgS5pX0yoPoYsUNHnuGOWora6p1EcA/70I=;
 b=JwoZjLiZPnh07+nVrPw+R6oxaLYCWqYfa6GqAreKBIWfQC2Cl7SFGdxMFw+b9Zvh4C8Lw+
 a/AAavGVlk6vY/EWKKaJj/6C1/wcHDg3X214IL5rNKUlxg9cm8cOtsgG+aJf+2DAx9zCty
 zTmsSi2Fzowf1F6idgGgCUzjbFn4mmw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-YRCVXk9bOOqSnkN6as_fLA-1; Tue, 12 Oct 2021 23:47:52 -0400
X-MC-Unique: YRCVXk9bOOqSnkN6as_fLA-1
Received: by mail-pj1-f70.google.com with SMTP id
 x10-20020a17090abc8a00b001a04877d05bso934678pjr.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 20:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=403XhRrbqTgS5pX0yoPoYsUNHnuGOWora6p1EcA/70I=;
 b=HKB/2Ry9+g/YxVCro61Xe2DlHUWY9C6jRgkVS+vybiZqy9e4bFoYKhyuX83uc20VBQ
 oUe0YmRG/iJP8xd7qHB2m3FJKIWuXYwCuD37XpbvYRR2jtcvKd07s0gFZOsx4pgXAeC9
 gzYkFaR1fEMEBLwU0bGcQ4YX3fDShNxlyA4gQDQV2B2byN2GCbIjP1gZoKaGNX7D8a7U
 q2MZMCTD+SNt+geLtc9aqGDYRlJyXvuG1QSZGe5SMnnENiPqlSN7Fs99oYzvsZi6IgPK
 27Bp1YM3QFNqGopvhOebB7fFRTvjqPluk2C/VqffP7R5La/vaczm3R/LI7JOxhKNUqSS
 p4pA==
X-Gm-Message-State: AOAM531Zrc5PvqL3I5nyEVq1dsP6T9hMO0ax0bsON+a1Mxz2I1sDX0OA
 9SK9Igx9XPek1QAbbTVGJURV9s8zex/ee5CUG6trvX02SQGkchV/XPahSencKNeE7FKkAU3wzyi
 qdBlzTDVblj45BGA6vKVsq1Y0wh4WlU2/PBD0BRzUHg==
X-Received: by 2002:a17:90b:a18:: with SMTP id
 gg24mr10420360pjb.18.1634096871607; 
 Tue, 12 Oct 2021 20:47:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/+1+2C2IU4yGR3B86dlFI0i3hEhvgGvmJJ+q7sq9lbN9kb1e4O2OhWWgfxjAjGlOdXukgoQ==
X-Received: by 2002:a17:90b:a18:: with SMTP id
 gg24mr10420323pjb.18.1634096871235; 
 Tue, 12 Oct 2021 20:47:51 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id rm6sm4437692pjb.18.2021.10.12.20.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Oct 2021 20:47:50 -0700 (PDT)
Subject: Re: [RFC PATCH v4 11/20] vhost: Route host->guest notification
 through shadow virtqueue
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20211001070603.307037-1-eperezma@redhat.com>
 <20211001070603.307037-12-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ab9a7771-5f9b-6413-3e38-bd3dc7373256@redhat.com>
Date: Wed, 13 Oct 2021 11:47:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211001070603.307037-12-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>
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

CuWcqCAyMDIxLzEwLzEg5LiL5Y2IMzowNSwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFRoaXMg
d2lsbCBtYWtlIHFlbXUgYXdhcmUgb2YgdGhlIGRldmljZSB1c2VkIGJ1ZmZlcnMsIGFsbG93aW5n
IGl0IHRvCj4gd3JpdGUgdGhlIGd1ZXN0IG1lbW9yeSB3aXRoIGl0cyBjb250ZW50cyBpZiBuZWVk
ZWQuCj4KPiBTaW5jZSB0aGUgdXNlIG9mIHZob3N0X3ZpcnRxdWV1ZV9zdGFydCBjYW4gdW5tYXNr
cyBhbmQgZGlzY2FyZCBjYWxsCj4gZXZlbnRzLCB2aG9zdF92aXJ0cXVldWVfc3RhcnQgc2hvdWxk
IGJlIG1vZGlmaWVkIGluIG9uZSBvZiB0aGVzZSB3YXlzOgo+ICogU3BsaXQgaW4gdHdvOiBPbmUg
b2YgdGhlbSB1c2VzIGFsbCBsb2dpYyB0byBzdGFydCBhIHF1ZXVlIHdpdGggbm8KPiAgICBzaWRl
IGVmZmVjdHMgZm9yIHRoZSBndWVzdCwgYW5kIGFub3RoZXIgb25lIHRoYSBhY3R1YWxseSBhc3N1
bWVzIHRoYXQKPiAgICB0aGUgZ3Vlc3QgaGFzIGp1c3Qgc3RhcnRlZCB0aGUgZGV2aWNlLiBWZHBh
IHNob3VsZCB1c2UganVzdCB0aGUKPiAgICBmb3JtZXIuCj4gKiBBY3R1YWxseSBzdG9yZSBhbmQg
Y2hlY2sgaWYgdGhlIGd1ZXN0IG5vdGlmaWVyIGlzIG1hc2tlZCwgYW5kIGRvIGl0Cj4gICAgY29u
ZGl0aW9uYWxseS4KPiAqIExlZnQgYXMgaXQgaXMsIGFuZCBkdXBsaWNhdGUgYWxsIHRoZSBsb2dp
YyBpbiB2aG9zdC12ZHBhLgo+Cj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJl
em1hQHJlZGhhdC5jb20+Cj4gLS0tCj4gICBody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1
ZS5jIHwgMTkgKysrKysrKysrKysrKysrCj4gICBody92aXJ0aW8vdmhvc3QtdmRwYS5jICAgICAg
ICAgICAgIHwgMzggKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCj4gICAyIGZpbGVzIGNo
YW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9o
dy92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRv
dy12aXJ0cXVldWUuYwo+IGluZGV4IDIxZGM5OWFiNWQuLjNmZTEyOWNmNjMgMTAwNjQ0Cj4gLS0t
IGEvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYwo+ICsrKyBiL2h3L3ZpcnRpby92
aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMKPiBAQCAtNTMsNiArNTMsMjIgQEAgc3RhdGljIHZvaWQg
dmhvc3RfaGFuZGxlX2d1ZXN0X2tpY2soRXZlbnROb3RpZmllciAqbikKPiAgICAgICBldmVudF9u
b3RpZmllcl9zZXQoJnN2cS0+a2lja19ub3RpZmllcik7Cj4gICB9Cj4gICAKPiArLyogRm9yd2Fy
ZCB2aG9zdCBub3RpZmljYXRpb25zICovCj4gK3N0YXRpYyB2b2lkIHZob3N0X3N2cV9oYW5kbGVf
Y2FsbF9ub190ZXN0KEV2ZW50Tm90aWZpZXIgKm4pCj4gK3sKPiArICAgIFZob3N0U2hhZG93Vmly
dHF1ZXVlICpzdnEgPSBjb250YWluZXJfb2YobiwgVmhvc3RTaGFkb3dWaXJ0cXVldWUsCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNhbGxfbm90aWZpZXIp
Owo+ICsKPiArICAgIGV2ZW50X25vdGlmaWVyX3NldCgmc3ZxLT5ndWVzdF9jYWxsX25vdGlmaWVy
KTsKPiArfQo+ICsKPiArc3RhdGljIHZvaWQgdmhvc3Rfc3ZxX2hhbmRsZV9jYWxsKEV2ZW50Tm90
aWZpZXIgKm4pCj4gK3sKPiArICAgIGlmIChsaWtlbHkoZXZlbnRfbm90aWZpZXJfdGVzdF9hbmRf
Y2xlYXIobikpKSB7Cj4gKyAgICAgICAgdmhvc3Rfc3ZxX2hhbmRsZV9jYWxsX25vX3Rlc3Qobik7
Cj4gKyAgICB9Cj4gK30KPiArCj4gICAvKgo+ICAgICogT2J0YWluIHRoZSBTVlEgY2FsbCBub3Rp
Zmllciwgd2hlcmUgdmhvc3QgZGV2aWNlIG5vdGlmaWVzIFNWUSB0aGF0IHRoZXJlCj4gICAgKiBl
eGlzdHMgcGVuZGluZyB1c2VkIGJ1ZmZlcnMuCj4gQEAgLTE4MCw2ICsxOTYsOCBAQCBWaG9zdFNo
YWRvd1ZpcnRxdWV1ZSAqdmhvc3Rfc3ZxX25ldyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIGludCBp
ZHgpCj4gICAgICAgfQo+ICAgCj4gICAgICAgc3ZxLT52cSA9IHZpcnRpb19nZXRfcXVldWUoZGV2
LT52ZGV2LCB2cV9pZHgpOwo+ICsgICAgZXZlbnRfbm90aWZpZXJfc2V0X2hhbmRsZXIoJnN2cS0+
Y2FsbF9ub3RpZmllciwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZob3N0X3N2
cV9oYW5kbGVfY2FsbCk7Cj4gICAgICAgcmV0dXJuIGdfc3RlYWxfcG9pbnRlcigmc3ZxKTsKPiAg
IAo+ICAgZXJyX2luaXRfY2FsbF9ub3RpZmllcjoKPiBAQCAtMTk1LDYgKzIxMyw3IEBAIGVycl9p
bml0X2tpY2tfbm90aWZpZXI6Cj4gICB2b2lkIHZob3N0X3N2cV9mcmVlKFZob3N0U2hhZG93Vmly
dHF1ZXVlICp2cSkKPiAgIHsKPiAgICAgICBldmVudF9ub3RpZmllcl9jbGVhbnVwKCZ2cS0+a2lj
a19ub3RpZmllcik7Cj4gKyAgICBldmVudF9ub3RpZmllcl9zZXRfaGFuZGxlcigmdnEtPmNhbGxf
bm90aWZpZXIsIE5VTEwpOwo+ICAgICAgIGV2ZW50X25vdGlmaWVyX2NsZWFudXAoJnZxLT5jYWxs
X25vdGlmaWVyKTsKPiAgICAgICBnX2ZyZWUodnEpOwo+ICAgfQo+IGRpZmYgLS1naXQgYS9ody92
aXJ0aW8vdmhvc3QtdmRwYS5jIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+IGluZGV4IGJjMzRk
ZTI0MzkuLjZjNWY0Yzk4YjggMTAwNjQ0Cj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+
ICsrKyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPiBAQCAtNzEyLDEzICs3MTIsNDAgQEAgc3Rh
dGljIGJvb2wgdmhvc3RfdmRwYV9zdnFfc3RhcnRfdnEoc3RydWN0IHZob3N0X2RldiAqZGV2LCB1
bnNpZ25lZCBpZHgpCj4gICB7Cj4gICAgICAgc3RydWN0IHZob3N0X3ZkcGEgKnYgPSBkZXYtPm9w
YXF1ZTsKPiAgICAgICBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxID0gZ19wdHJfYXJyYXlfaW5k
ZXgodi0+c2hhZG93X3ZxcywgaWR4KTsKPiAtICAgIHJldHVybiB2aG9zdF9zdnFfc3RhcnQoZGV2
LCBpZHgsIHN2cSk7Cj4gKyAgICBFdmVudE5vdGlmaWVyICp2aG9zdF9jYWxsX25vdGlmaWVyID0g
dmhvc3Rfc3ZxX2dldF9zdnFfY2FsbF9ub3RpZmllcihzdnEpOwo+ICsgICAgc3RydWN0IHZob3N0
X3ZyaW5nX2ZpbGUgdmhvc3RfY2FsbF9maWxlID0gewo+ICsgICAgICAgIC5pbmRleCA9IGlkeCAr
IGRldi0+dnFfaW5kZXgsCj4gKyAgICAgICAgLmZkID0gZXZlbnRfbm90aWZpZXJfZ2V0X2ZkKHZo
b3N0X2NhbGxfbm90aWZpZXIpLAo+ICsgICAgfTsKPiArICAgIGludCByOwo+ICsgICAgYm9vbCBi
Owo+ICsKPiArICAgIC8qIFNldCBzaGFkb3cgdnEgLT4gZ3Vlc3Qgbm90aWZpZXIgKi8KPiArICAg
IGFzc2VydCh2LT5jYWxsX2ZkW2lkeF0pOwoKCldlIG5lZWQgYW92aWQgdGhlIGFzc2VyKCkgaGVy
ZS4gT24gd2hpY2ggY2FzZSB3ZSBjYW4gaGl0IHRoaXM/CgoKPiArICAgIHZob3N0X3N2cV9zZXRf
Z3Vlc3RfY2FsbF9ub3RpZmllcihzdnEsIHYtPmNhbGxfZmRbaWR4XSk7Cj4gKwo+ICsgICAgYiA9
IHZob3N0X3N2cV9zdGFydChkZXYsIGlkeCwgc3ZxKTsKPiArICAgIGlmICh1bmxpa2VseSghYikp
IHsKPiArICAgICAgICByZXR1cm4gZmFsc2U7Cj4gKyAgICB9Cj4gKwo+ICsgICAgLyogU2V0IGRl
dmljZSAtPiBTVlEgbm90aWZpZXIgKi8KPiArICAgIHIgPSB2aG9zdF92ZHBhX3NldF92cmluZ19k
ZXZfY2FsbChkZXYsICZ2aG9zdF9jYWxsX2ZpbGUpOwo+ICsgICAgaWYgKHVubGlrZWx5KHIpKSB7
Cj4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJ2aG9zdF92ZHBhX3NldF92cmluZ19jYWxsIGZvciBz
aGFkb3cgdnEgZmFpbGVkIik7Cj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOwo+ICsgICAgfQoKClNp
bWlsYXIgdG8ga2ljaywgZG8gd2UgbmVlZCB0byBzZXRfdnJpbmdfY2FsbCgpIGJlZm9yZSB2aG9z
dF9zdnFfc3RhcnQoKT8KCgo+ICsKPiArICAgIC8qIENoZWNrIGZvciBwZW5kaW5nIGNhbGxzICov
Cj4gKyAgICBldmVudF9ub3RpZmllcl9zZXQodmhvc3RfY2FsbF9ub3RpZmllcik7CgoKSW50ZXJl
c3RpbmcsIGNhbiB0aGlzIHJlc3VsdCBzcHVyaW91cyBpbnRlcnJ1cHQ/CgoKPiArICAgIHJldHVy
biB0cnVlOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgdW5zaWduZWQgdmhvc3RfdmRwYV9lbmFibGVf
c3ZxKHN0cnVjdCB2aG9zdF92ZHBhICp2LCBib29sIGVuYWJsZSkKPiAgIHsKPiAgICAgICBzdHJ1
Y3Qgdmhvc3RfZGV2ICpoZGV2ID0gdi0+ZGV2Owo+ICAgICAgIHVuc2lnbmVkIG47Cj4gKyAgICBp
bnQgcjsKPiAgIAo+ICAgICAgIGlmIChlbmFibGUgPT0gdi0+c2hhZG93X3Zxc19lbmFibGVkKSB7
Cj4gICAgICAgICAgIHJldHVybiBoZGV2LT5udnFzOwo+IEBAIC03NTIsOSArNzc5LDE4IEBAIHN0
YXRpYyB1bnNpZ25lZCB2aG9zdF92ZHBhX2VuYWJsZV9zdnEoc3RydWN0IHZob3N0X3ZkcGEgKnYs
IGJvb2wgZW5hYmxlKQo+ICAgICAgIGlmICghZW5hYmxlKSB7Cj4gICAgICAgICAgIC8qIERpc2Fi
bGUgYWxsIHF1ZXVlcyBvciBjbGVhbiB1cCBmYWlsZWQgc3RhcnQgKi8KPiAgICAgICAgICAgZm9y
IChuID0gMDsgbiA8IHYtPnNoYWRvd192cXMtPmxlbjsgKytuKSB7Cj4gKyAgICAgICAgICAgIHN0
cnVjdCB2aG9zdF92cmluZ19maWxlIGZpbGUgPSB7Cj4gKyAgICAgICAgICAgICAgICAuaW5kZXgg
PSB2aG9zdF92ZHBhX2dldF92cV9pbmRleChoZGV2LCBuKSwKPiArICAgICAgICAgICAgICAgIC5m
ZCA9IHYtPmNhbGxfZmRbbl0sCj4gKyAgICAgICAgICAgIH07Cj4gKwo+ICsgICAgICAgICAgICBy
ID0gdmhvc3RfdmRwYV9zZXRfdnJpbmdfY2FsbChoZGV2LCAmZmlsZSk7Cj4gKyAgICAgICAgICAg
IGFzc2VydChyID09IDApOwo+ICsKPiAgICAgICAgICAgICAgIHVuc2lnbmVkIHZxX2lkeCA9IHZo
b3N0X3ZkcGFfZ2V0X3ZxX2luZGV4KGhkZXYsIG4pOwo+ICAgICAgICAgICAgICAgVmhvc3RTaGFk
b3dWaXJ0cXVldWUgKnN2cSA9IGdfcHRyX2FycmF5X2luZGV4KHYtPnNoYWRvd192cXMsIG4pOwo+
ICAgICAgICAgICAgICAgdmhvc3Rfc3ZxX3N0b3AoaGRldiwgbiwgc3ZxKTsKPiArICAgICAgICAg
ICAgLyogVE9ETzogVGhpcyBjYW4gdW5tYXNrIG9yIG92ZXJyaWRlIGNhbGwgZmQhICovCgoKSSBk
b24ndCBnZXQgdGhpcyBjb21tZW50LiBEb2VzIHRoaXMgbWVhbiB0aGUgY3VycmVudCBjb2RlIGNh
bid0IHdvcmsgCndpdGggbWFza19ub3RpZmllcnM/IElmIHllcywgdGhpcyBpcyBzb21ldGhpbmcg
d2UgbmVlZCB0byBmaXguCgpUaGFua3MKCgo+ICAgICAgICAgICAgICAgdmhvc3RfdmlydHF1ZXVl
X3N0YXJ0KGhkZXYsIGhkZXYtPnZkZXYsICZoZGV2LT52cXNbbl0sIHZxX2lkeCk7Cj4gICAgICAg
ICAgIH0KPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
