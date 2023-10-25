Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C150EC0032E
	for <virtualization@archiver.kernel.org>; Wed, 25 Oct 2023 03:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4D961431CC;
	Wed, 25 Oct 2023 03:36:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4D961431CC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RqzZTWqp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vnvOG5E0vLj0; Wed, 25 Oct 2023 03:36:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4EDA5434D9;
	Wed, 25 Oct 2023 03:36:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4EDA5434D9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29800C0071;
	Wed, 25 Oct 2023 03:36:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFE97C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 03:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9AB5D84B1E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 03:36:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9AB5D84B1E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RqzZTWqp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xYAF4iyYWVi7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 03:36:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4F8584B16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 03:36:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4F8584B16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698204960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xfDLb1C5fG+3hvae1lcC3XUNoWIDZjI8HvveldeQhUI=;
 b=RqzZTWqppVrwhBwJlRjE1/HDUcU6JGJrfKw5zfo50Ohpbe7fe8oXoxKDy463OO0AARwNqv
 m57aEfWxqsCgPDiMaaZDHlVwo9JOZi0rhcDCMLSFE+iN+FR0JdSAXiN8KEPdHlEXZ0mqQs
 e/xoKT31uMS89iQj66FYWAE1bgBg4xc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-fnWT7P4LO9exmEAOAIe0hA-1; Tue, 24 Oct 2023 23:35:57 -0400
X-MC-Unique: fnWT7P4LO9exmEAOAIe0hA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50798a25ebaso243898e87.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 20:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698204955; x=1698809755;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xfDLb1C5fG+3hvae1lcC3XUNoWIDZjI8HvveldeQhUI=;
 b=GXd5lACmdVVC5tGiqdyo8RYAHnHYIDmtn/4yjmqNqzCt7rHbTEU7+FV6Beqh8/cF3n
 fml2016EEct9RTtvLQjp6TvqHoqTXJj3TmwFOoPZKstNR0+hwuv/CcXPW4uoNiglYEFH
 VAQcSx9jHzAuGpNn7MoWeddDp11nNDYS8NAUINgZHFUyZbZ+LlUD3NQci21iu6YoZE1l
 O/W99Gyg4NQPqOLMwd2kOL56HSpboUP+bOseV5j00Dp3ZVms9dXAAU0sO6s642YjJm13
 ZGt4aUNTjmuAWDre9nDfsAu1hZuv6W9W6jOLzXYMG66PBELP4R/TfYzKS9KiJy6eW++f
 QGsw==
X-Gm-Message-State: AOJu0Yw8UVL6UjiA+wlxztZkNlcVaTTv78y++oTHE2TrBUcQ/E0oHrmB
 x7L4uus0VH9eT0VMd/rudkRWNZ6z4W+DDSEIR4dh+3I6stNjzbGBkZZLaTVjnYx0pXH/kdjghiH
 CkCotWbuOR7PFOtA3KAvU/h2D2nzjnP7omMab9DpDfHyDbmlVA90B47QMlA==
X-Received: by 2002:a05:6512:3e14:b0:507:9c72:3ace with SMTP id
 i20-20020a0565123e1400b005079c723acemr6015129lfv.26.1698204955592; 
 Tue, 24 Oct 2023 20:35:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeHtwk890NQeEoItJvcNRHX2Ml0qXCOmSqFUCIUrPgkJHFPDqdG2NJa8DayWvoA5ZFM/qWvP6c0YG2Q898ATQ=
X-Received: by 2002:a05:6512:3e14:b0:507:9c72:3ace with SMTP id
 i20-20020a0565123e1400b005079c723acemr6015114lfv.26.1698204955289; Tue, 24
 Oct 2023 20:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <ef5d159875745040e406473bd5c03e9875742ff5.1697093455.git.hengqi@linux.alibaba.com>
In-Reply-To: <ef5d159875745040e406473bd5c03e9875742ff5.1697093455.git.hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 Oct 2023 11:35:43 +0800
Message-ID: <CACGkMEuX+kJ8G2CitnACVgx_OSsdbtedD+dvXJ_REFdwzx56Vg@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] virtio-net: support tx netdim
To: Heng Qi <hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Liu, Yujie" <yujie.liu@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gVGh1LCBPY3QgMTIsIDIwMjMgYXQgMzo0NOKAr1BNIEhlbmcgUWkgPGhlbmdxaUBsaW51eC5h
bGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBTaW1pbGFyIHRvIHJ4IG5ldGRpbSwgdGhpcyBwYXRjaCBz
dXBwb3J0cyBhZGFwdGl2ZSB0eAo+IGNvYWxlc2NpbmcgbW9kZXJhdGlvbiBmb3IgdGhlIHZpcnRp
by1uZXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBIZW5nIFFpIDxoZW5ncWlAbGludXguYWxpYmFiYS5j
b20+Cj4gLS0tCj4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDE0MyArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDExOSBpbnNlcnRp
b25zKCspLCAyNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCA2YWQyODkwYTc5MDku
LjFjNjgwY2IwOWQ0OCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiAr
KysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtMTU0LDYgKzE1NCwxNSBAQCBzdHJ1
Y3Qgc2VuZF9xdWV1ZSB7Cj4KPiAgICAgICAgIHN0cnVjdCB2aXJ0bmV0X3NxX3N0YXRzIHN0YXRz
Owo+Cj4gKyAgICAgICAvKiBUaGUgbnVtYmVyIG9mIHR4IG5vdGlmaWNhdGlvbnMgKi8KPiArICAg
ICAgIHUxNiBjYWxsczsKPiArCj4gKyAgICAgICAvKiBJcyBkeW5hbWljIGludGVycnVwdCBtb2Rl
cmF0aW9uIGVuYWJsZWQ/ICovCj4gKyAgICAgICBib29sIGRpbV9lbmFibGVkOwo+ICsKPiArICAg
ICAgIC8qIER5bmFtaWMgSW50ZXJydXB0IE1vZGVyYXRpb24gKi8KPiArICAgICAgIHN0cnVjdCBk
aW0gZGltOwo+ICsKPiAgICAgICAgIHN0cnVjdCB2aXJ0bmV0X2ludGVycnVwdF9jb2FsZXNjZSBp
bnRyX2NvYWw7Cj4KPiAgICAgICAgIHN0cnVjdCBuYXBpX3N0cnVjdCBuYXBpOwo+IEBAIC0zMTcs
OCArMzI2LDkgQEAgc3RydWN0IHZpcnRuZXRfaW5mbyB7Cj4gICAgICAgICB1OCBkdXBsZXg7Cj4g
ICAgICAgICB1MzIgc3BlZWQ7Cj4KPiAtICAgICAgIC8qIElzIHJ4IGR5bmFtaWMgaW50ZXJydXB0
IG1vZGVyYXRpb24gZW5hYmxlZD8gKi8KPiArICAgICAgIC8qIElzIGR5bmFtaWMgaW50ZXJydXB0
IG1vZGVyYXRpb24gZW5hYmxlZD8gKi8KPiAgICAgICAgIGJvb2wgcnhfZGltX2VuYWJsZWQ7Cj4g
KyAgICAgICBib29sIHR4X2RpbV9lbmFibGVkOwo+Cj4gICAgICAgICAvKiBJbnRlcnJ1cHQgY29h
bGVzY2luZyBzZXR0aW5ncyAqLwo+ICAgICAgICAgc3RydWN0IHZpcnRuZXRfaW50ZXJydXB0X2Nv
YWxlc2NlIGludHJfY29hbF90eDsKPiBAQCAtNDY0LDE5ICs0NzQsNDAgQEAgc3RhdGljIGJvb2wg
dmlydHF1ZXVlX25hcGlfY29tcGxldGUoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLAo+ICAgICAg
ICAgcmV0dXJuIGZhbHNlOwo+ICB9Cj4KPiArc3RhdGljIHZvaWQgdmlydG5ldF90eF9kaW1fd29y
ayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspOwo+ICsKPiArc3RhdGljIHZvaWQgdmlydG5ldF90
eF9kaW1fdXBkYXRlKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCBzdHJ1Y3Qgc2VuZF9xdWV1ZSAq
c3EpCj4gK3sKPiArICAgICAgIHN0cnVjdCB2aXJ0bmV0X3NxX3N0YXRzICpzdGF0cyA9ICZzcS0+
c3RhdHM7Cj4gKyAgICAgICBzdHJ1Y3QgZGltX3NhbXBsZSBjdXJfc2FtcGxlID0ge307Cj4gKwo+
ICsgICAgICAgdTY0X3N0YXRzX3VwZGF0ZV9iZWdpbigmc3EtPnN0YXRzLnN5bmNwKTsKPiArICAg
ICAgIGRpbV91cGRhdGVfc2FtcGxlKHNxLT5jYWxscywgc3RhdHMtPnBhY2tldHMsCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICBzdGF0cy0+Ynl0ZXMsICZjdXJfc2FtcGxlKTsKPiArICAgICAg
IHU2NF9zdGF0c191cGRhdGVfZW5kKCZzcS0+c3RhdHMuc3luY3ApOwo+ICsKPiArICAgICAgIG5l
dF9kaW0oJnNxLT5kaW0sIGN1cl9zYW1wbGUpOwo+ICt9Cj4gKwo+ICBzdGF0aWMgdm9pZCBza2Jf
eG1pdF9kb25lKHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+ICB7Cj4gICAgICAgICBzdHJ1Y3Qgdmly
dG5ldF9pbmZvICp2aSA9IHZxLT52ZGV2LT5wcml2Owo+IC0gICAgICAgc3RydWN0IG5hcGlfc3Ry
dWN0ICpuYXBpID0gJnZpLT5zcVt2cTJ0eHEodnEpXS5uYXBpOwo+ICsgICAgICAgc3RydWN0IHNl
bmRfcXVldWUgKnNxID0gJnZpLT5zcVt2cTJ0eHEodnEpXTsKPiArICAgICAgIHN0cnVjdCBuYXBp
X3N0cnVjdCAqbmFwaSA9ICZzcS0+bmFwaTsKPiArCj4gKyAgICAgICBzcS0+Y2FsbHMrKzsKCkkg
d29uZGVyIHdoYXQncyB0aGUgaW1wYWN0IG9mIHRoaXMgY291bnRlcnMgZm9yIG5ldGRpbS4gQXMg
d2UgaGF2ZSBhCm1vZGUgb2Ygb3JwaGFuIHNrYiBpbiB4bWl0LgoKV2UgbmVlZCB0byB0ZXN0IHRv
IHNlZS4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
