Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F0AC433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 08:48:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 801CE60F72;
	Wed,  9 Mar 2022 08:48:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EotlVr8HJBsJ; Wed,  9 Mar 2022 08:48:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1760760D4E;
	Wed,  9 Mar 2022 08:48:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA2EDC001D;
	Wed,  9 Mar 2022 08:48:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F5CAC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:48:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E2B881254
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:48:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U59JyWhTAp2f
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:48:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 87FE080F2C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646815726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TO8OA67xOJIVUQ+IzXv9BnLhNmwQiU+fyDz+FkJQweU=;
 b=N0diOB2qte6ztM8F9IvzkE2XJeytdm7qP4cpBVPB/c5SIXX7bfOXHJMQrzmBkfTkIce+Gn
 5idW/0+V0ecUoB46choNn9RwuuPt4OpRKxsg3KUJjqeN3D27Tj8h0XkcvUq2uas3sSPcrA
 GfDNd6f3icjZxZ7KI2eINpmfBJyiwIM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-jB1Dit4GNNaWFBF95fWdSA-1; Wed, 09 Mar 2022 03:48:43 -0500
X-MC-Unique: jB1Dit4GNNaWFBF95fWdSA-1
Received: by mail-pf1-f197.google.com with SMTP id
 y193-20020a62ceca000000b004f6f5bbaf7cso1163952pfg.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Mar 2022 00:48:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=TO8OA67xOJIVUQ+IzXv9BnLhNmwQiU+fyDz+FkJQweU=;
 b=rJ48iohIoFfyQp2pSk+l2A/2GubA+vaxBHw/tOEHvAZQVMC5JDzxhHtYJg/LSlFyq9
 jI+U8sMfXPylZLU7P3Mm+g7oCxp5CX/ceIdFnNUC4yuctVrzdluvGwbvaam72+RMZCUr
 ryTEW2NewFSzk1ObaE9Gv+qgJEFAHPZNbADJVTDW3erUpA5IzpdkBiCY3Pf1Y1eVCccq
 8dkhDBSxERZ+doXW67G8Uyq0rau8c4LK64cMp6HvOMU6dGpcuEBRKEUxAce3soN4vXso
 21Ev38PBqEEkLYq97pAMy76s9jh+AvI0Gml90b33MCqXJzw7wF/Vs1H6bznAhKXzZX6m
 BPpg==
X-Gm-Message-State: AOAM532GhVScLjSsqiEM3EYXewuHverZ3BI5vwQ0Aik1Gsy8os1XlWHX
 QbZ/fUuLPcq3PQlADG+3XdVZ5PfjXA4tXhSf2iSLhfTFpCWCNBaitW/sXsFRnCsFwYEM1cxUh/2
 Re2vLPQ/C7LMCtOzJVOv29dqGh4SRqm3vDdw7VTCTaA==
X-Received: by 2002:aa7:8882:0:b0:4df:7b9e:1ccb with SMTP id
 z2-20020aa78882000000b004df7b9e1ccbmr22312181pfe.41.1646815722285; 
 Wed, 09 Mar 2022 00:48:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7/YbZyXIgHV6hqpeiO7757QCskmbcneG6gJIkE8+QzhmuMcmfZenCb/AE2A7PcyT+4y4qLw==
X-Received: by 2002:aa7:8882:0:b0:4df:7b9e:1ccb with SMTP id
 z2-20020aa78882000000b004df7b9e1ccbmr22312131pfe.41.1646815721958; 
 Wed, 09 Mar 2022 00:48:41 -0800 (PST)
Received: from [10.72.12.183] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 142-20020a621894000000b004dfc714b076sm2024468pfy.11.2022.03.09.00.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Mar 2022 00:48:41 -0800 (PST)
Message-ID: <fda406d7-3ed9-7c62-0f26-4058a63e73a9@redhat.com>
Date: Wed, 9 Mar 2022 16:48:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 14/26] virtio: add helper for queue reset
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-15-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-15-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 kvm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g5YaZ6YGTOgo+IEFkZCBoZWxwZXIg
Zm9yIHZpcnRpbyBxdWV1ZSByZXNldC4KPgo+ICogdmlydGlvX3Jlc2V0X3ZxKCk6IHJlc2V0IGEg
cXVldWUgaW5kaXZpZHVhbGx5Cj4gKiB2aXJ0aW9fZW5hYmxlX3Jlc2V0cSgpOiBlbmFibGUgYSBy
ZXNldCBxdWV1ZQo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5h
bGliYWJhLmNvbT4KPiAtLS0KPiAgIGluY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oIHwgNDAg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCA0
MCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW9fY29u
ZmlnLmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaAo+IGluZGV4IGQ1MTkwNmIxMzg5
Zi4uMGI4MWZiZTE3Yzg1IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZp
Zy5oCj4gKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiBAQCAtMjMwLDYgKzIz
MCw0NiBAQCBpbnQgdmlydGlvX2ZpbmRfdnFzX2N0eChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRl
diwgdW5zaWduZWQgbnZxcywKPiAgIAkJCQkgICAgICBkZXNjKTsKPiAgIH0KPiAgIAo+ICsvKioK
PiArICogdmlydGlvX3Jlc2V0X3ZxIC0gcmVzZXQgYSBxdWV1ZSBpbmRpdmlkdWFsbHkKPiArICog
QHZxOiB0aGUgdmlydHF1ZXVlCj4gKyAqCj4gKyAqIHJldHVybnMgMCBvbiBzdWNjZXNzIG9yIGVy
cm9yIHN0YXR1cwo+ICsgKgo+ICsgKiBUaGUgYXBpIHByb2Nlc3Mgb2YgcmVzZXQgdW5kZXIgbm9y
bWFsIGNpcmN1bXN0YW5jZXM6Cj4gKyAqCTEuIHZpcnRpb19yZXNldF92cSgpICAgICAgICAgICAg
ICAtIG5vdGlmeSB0aGUgZGV2aWNlIHRvIHJlc2V0IHRoZSBxdWV1ZQo+ICsgKgkyLiB2aXJ0cXVl
dWVfZGV0YWNoX3VudXNlZF9idWYoKSAgLSByZWN5Y2xlIHRoZSBidWZmZXIgc3VibWl0dGVkCj4g
KyAqCTMuIHZpcnRxdWV1ZV9yZXNldF92cmluZygpICAgICAgICAtIHJlc2V0IHRoZSB2cmluZyAo
bWF5IHJlLWFsbG9jKQo+ICsgKgk0LiB2aXJ0aW9fZW5hYmxlX3Jlc2V0cSgpICAgICAgICAgLSBt
bWFwIHZyaW5nIHRvIGRldmljZSwgYW5kIGVuYWJsZSB0aGUgcXVldWUKPiArICoKPiArICogQ2Fs
bGVyIHNob3VsZCBndWFyYW50ZWUgdGhhdCB0aGUgdnJpbmcgaXMgbm90IGFjY2Vzc2VkIGJ5IGFu
eSBmdW5jdGlvbnMKPiArICogb2YgdmlydHF1ZXVlLgo+ICsgKi8KPiArc3RhdGljIGlubGluZQo+
ICtpbnQgdmlydGlvX3Jlc2V0X3ZxKHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+ICt7CgoKSXQgbG9v
a3MgdG8gbWUgdGhlIHByZWZpeCAidmlydGlvIiBpcyB1c2VkIGZvciB0aGUgZGV2aWNlIHNwZWNp
ZmljIApvcGVyYXRpb25zLgoKSSB3b25kZXIgaWYgaXQncyBiZXR0ZXIgdG8gcmVuYW1lIHRoaXMg
YXMgdmlydHF1ZXVlX3Jlc3RlKCkgYW5kIG1vdmUgaXQgCnRvIHZpcnRpb19yaW5nLmM/CgpUaGFu
a3MKCgo+ICsJaWYgKCF2cS0+dmRldi0+Y29uZmlnLT5yZXNldF92cSkKPiArCQlyZXR1cm4gLUVO
T0VOVDsKPiArCj4gKwlyZXR1cm4gdnEtPnZkZXYtPmNvbmZpZy0+cmVzZXRfdnEodnEpOwo+ICt9
Cj4gKwo+ICsvKioKPiArICogdmlydGlvX2VuYWJsZV9yZXNldHEgLSBlbmFibGUgYSByZXNldCBx
dWV1ZQo+ICsgKiBAdnE6IHRoZSB2aXJ0cXVldWUKPiArICoKPiArICogcmV0dXJucyAwIG9uIHN1
Y2Nlc3Mgb3IgZXJyb3Igc3RhdHVzCj4gKyAqCj4gKyAqLwo+ICtzdGF0aWMgaW5saW5lCj4gK2lu
dCB2aXJ0aW9fZW5hYmxlX3Jlc2V0cShzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPiArewo+ICsJaWYg
KCF2cS0+dmRldi0+Y29uZmlnLT5lbmFibGVfcmVzZXRfdnEpCj4gKwkJcmV0dXJuIC1FTk9FTlQ7
Cj4gKwo+ICsJcmV0dXJuIHZxLT52ZGV2LT5jb25maWctPmVuYWJsZV9yZXNldF92cSh2cSk7Cj4g
K30KPiArCj4gICAvKioKPiAgICAqIHZpcnRpb19kZXZpY2VfcmVhZHkgLSBlbmFibGUgdnEgdXNl
IGluIHByb2JlIGZ1bmN0aW9uCj4gICAgKiBAdmRldjogdGhlIGRldmljZQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
