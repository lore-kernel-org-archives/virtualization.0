Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0EAC4332F
	for <virtualization@archiver.kernel.org>; Wed,  1 Nov 2023 00:36:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E27056FAB0;
	Wed,  1 Nov 2023 00:36:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E27056FAB0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KDza8tWS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E8fuBB3s4YSw; Wed,  1 Nov 2023 00:36:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9EF066FABC;
	Wed,  1 Nov 2023 00:36:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9EF066FABC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6611DC0039;
	Wed,  1 Nov 2023 00:36:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 922D5C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 00:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5BD4A42E82
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 00:36:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5BD4A42E82
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KDza8tWS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id euPQgcCqeAW1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 00:36:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F7CE415BF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 00:36:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F7CE415BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698798962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C+GS7S1zs+RWJZ2acWzMVg8OF7MBFMELnGIFo6WBEv4=;
 b=KDza8tWS7R3C+D4/cDhISAO+/2FlcPOL60rpI3IN9VW2YV+FC1YjehgKRvYSb6U84Geu+7
 Qme5YYo9t1wXGADc5apD1eOa1/liQz+1qEItnY6N/vADnrK2QEZma8SrsjBV7K2kkvhrhk
 HeeJG3eYL+rf1V8N/3B1nUJJM5GfWj8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-EZQMZYsLPF2BSiRKbyvWBQ-1; Tue, 31 Oct 2023 20:35:55 -0400
X-MC-Unique: EZQMZYsLPF2BSiRKbyvWBQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507bd5f4b2dso7087215e87.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 17:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698798954; x=1699403754;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C+GS7S1zs+RWJZ2acWzMVg8OF7MBFMELnGIFo6WBEv4=;
 b=Ih5ig7Km9WYC0HgsitBVpFUZoWi5NutEH9lZzvYzjK4UTkueF4qaCiV0OuqBJRWomd
 ahv3L/2fDB3eYdUHlVENPUnHY0RSrBUndaNauodUTcqTY7SKansSWi2jkA59XDP/Y/Wt
 Z29emu4ZrLYwgJROyML8m1xwaLI2bzwUudrmXWTuqIVhj8DMZCEycXB0SbPsd+YFn279
 h72yhsfIUBtexbFkDmNsAPSaVrb/20y38cSBYDmL1VbOTmUwygOs2hSndpBpRnr+bXb4
 wNt/48UQCfqMqIRkYcRZXd5n+QIT28vwoC73aCGFm0lJ3XINOHh7QQx+K2RBeuyFdvrQ
 fr1A==
X-Gm-Message-State: AOJu0YwKd9aODMdwQsD2JXJoHSZOs60XQkF1gPCSW+Cj+MM36hxqt44P
 HfQb88hXXGvCzdD7GrZeU/7KV/kgPPOQUIkWyZHfjzE7tshd8mn8wsj8mhgyYenGAVF9w8F9Qjh
 qMuHzHCgRYqZRm+RGZd9RoghEm17HxqyBcpkO4L9zDDLl+h5bvtWx0MGwyQ==
X-Received: by 2002:a05:6512:2396:b0:503:343a:829f with SMTP id
 c22-20020a056512239600b00503343a829fmr14598983lfv.23.1698798954042; 
 Tue, 31 Oct 2023 17:35:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg+1pMD7BGHcsWb0wYXFGaP9FuBcGzatueA1YF+p9rYE0YMGk4z2qP+9HpSwembnuzfBCTmKuQjRRFMXs3AHM=
X-Received: by 2002:a05:6512:2396:b0:503:343a:829f with SMTP id
 c22-20020a056512239600b00503343a829fmr14598971lfv.23.1698798953743; Tue, 31
 Oct 2023 17:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231031144339.121453-1-sgarzare@redhat.com>
 <CAJaqyWfr123zWdM8E+H4bnfrdvv-KEvZ7r5eN+fY428G6v95Hg@mail.gmail.com>
In-Reply-To: <CAJaqyWfr123zWdM8E+H4bnfrdvv-KEvZ7r5eN+fY428G6v95Hg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 1 Nov 2023 08:35:42 +0800
Message-ID: <CACGkMEvRCdCT4A5r9up0U+Pj5m44f5V2Fw_dcPJvnJk7NBtrLQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: allocate the buffer zeroed
To: Eugenio Perez Martin <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Qing Wang <qinwang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

T24gV2VkLCBOb3YgMSwgMjAyMyBhdCAxOjUy4oCvQU0gRXVnZW5pbyBQZXJleiBNYXJ0aW4gPGVw
ZXJlem1hQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCBPY3QgMzEsIDIwMjMgYXQgMzo0
NOKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4g
Pgo+ID4gRGVsZXRpbmcgYW5kIHJlY3JlYXRpbmcgYSBkZXZpY2UgY2FuIGxlYWQgdG8gaGF2aW5n
IHRoZSBzYW1lCj4gPiBjb250ZW50IGFzIHRoZSBvbGQgZGV2aWNlLCBzbyBsZXQncyBhbHdheXMg
YWxsb2NhdGUgYnVmZmVycwo+ID4gY29tcGxldGVseSB6ZXJvZWQgb3V0Lgo+ID4KPiA+IEZpeGVz
OiBhYmViYjE2MjU0YjMgKCJ2ZHBhX3NpbV9ibGs6IHN1cHBvcnQgc2hhcmVkIGJhY2tlbmQiKQo+
ID4gU3VnZ2VzdGVkLWJ5OiBRaW5nIFdhbmcgPHFpbndhbmdAcmVkaGF0LmNvbT4KPgo+IEFja2Vk
LWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KCkFja2VkLWJ5OiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+Cj4gPiBTaWduZWQtb2ZmLWJ5
OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+ICBk
cml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMgfCA0ICsrLS0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMgYi9kcml2ZXJzL3ZkcGEv
dmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMKPiA+IGluZGV4IGIzYTNjYjE2NTc5NS4uYjEzN2YzNjc5
MzQzIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5j
Cj4gPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMKPiA+IEBAIC00
MzcsNyArNDM3LDcgQEAgc3RhdGljIGludCB2ZHBhc2ltX2Jsa19kZXZfYWRkKHN0cnVjdCB2ZHBh
X21nbXRfZGV2ICptZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+ID4gICAgICAgICBpZiAoYmxrLT5z
aGFyZWRfYmFja2VuZCkgewo+ID4gICAgICAgICAgICAgICAgIGJsay0+YnVmZmVyID0gc2hhcmVk
X2J1ZmZlcjsKPiA+ICAgICAgICAgfSBlbHNlIHsKPiA+IC0gICAgICAgICAgICAgICBibGstPmJ1
ZmZlciA9IGt2bWFsbG9jKFZEUEFTSU1fQkxLX0NBUEFDSVRZIDw8IFNFQ1RPUl9TSElGVCwKPiA+
ICsgICAgICAgICAgICAgICBibGstPmJ1ZmZlciA9IGt2emFsbG9jKFZEUEFTSU1fQkxLX0NBUEFD
SVRZIDw8IFNFQ1RPUl9TSElGVCwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEdGUF9LRVJORUwpOwo+ID4gICAgICAgICAgICAgICAgIGlmICghYmxrLT5idWZmZXIp
IHsKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FTk9NRU07Cj4gPiBAQCAtNDk1
LDcgKzQ5NSw3IEBAIHN0YXRpYyBpbnQgX19pbml0IHZkcGFzaW1fYmxrX2luaXQodm9pZCkKPiA+
ICAgICAgICAgICAgICAgICBnb3RvIHBhcmVudF9lcnI7Cj4gPgo+ID4gICAgICAgICBpZiAoc2hh
cmVkX2JhY2tlbmQpIHsKPiA+IC0gICAgICAgICAgICAgICBzaGFyZWRfYnVmZmVyID0ga3ZtYWxs
b2MoVkRQQVNJTV9CTEtfQ0FQQUNJVFkgPDwgU0VDVE9SX1NISUZULAo+ID4gKyAgICAgICAgICAg
ICAgIHNoYXJlZF9idWZmZXIgPSBrdnphbGxvYyhWRFBBU0lNX0JMS19DQVBBQ0lUWSA8PCBTRUNU
T1JfU0hJRlQsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdG
UF9LRVJORUwpOwo+ID4gICAgICAgICAgICAgICAgIGlmICghc2hhcmVkX2J1ZmZlcikgewo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVOT01FTTsKPiA+IC0tCj4gPiAyLjQxLjAK
PiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
