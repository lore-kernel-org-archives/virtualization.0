Return-Path: <SRS0=HAf6=MG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C558AC07E95
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 02:16:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E0561361
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 02:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E0561361
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01DA760E6A;
	Wed, 14 Jul 2021 02:16:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cxWNQEU-nQkL; Wed, 14 Jul 2021 02:16:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A5FA660BDD;
	Wed, 14 Jul 2021 02:16:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAF2AC0026;
	Wed, 14 Jul 2021 02:16:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1562AC0020
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B3E160905
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:16:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vcZ-NFBSKm1d
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:16:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5316360B2D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626228961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lETjBLf02DlKWY99ILUZ8EMCaetURHel393ebRunFe0=;
 b=MDYimqu/meNLWTesxzqp/bJXo2UPJU5GNdjDe6QXV3T+AbFgnKxjoV+DhLZsUGpU6C5+E2
 nxOa6wrLMY0IrGJ8WAXHzOGjNBlHx2i1ujLyyXSVEWdwG5mQ9hvH8KF/xPlhEdsTz6P//G
 MP7188C4HWsqHZTGN5vkLE5+9xXOgDs=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-81wORvVmPYmsd-UzA4MkbA-1; Tue, 13 Jul 2021 22:14:46 -0400
X-MC-Unique: 81wORvVmPYmsd-UzA4MkbA-1
Received: by mail-pf1-f200.google.com with SMTP id
 k11-20020aa792cb0000b02903305e16bd1dso469252pfa.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 19:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=lETjBLf02DlKWY99ILUZ8EMCaetURHel393ebRunFe0=;
 b=cq0aIQ1ncvBmQiFeXpUNuXsjvbBObZSamG33QVi7eSEe9+9K74QTysGmEUfcQOggf9
 x8kpXOaBObJDMuxwMSE3COF/eeEwcNzbLwNTKPf/ZjmARY87kiQJWhEFCbdd0z8nkOZw
 pCxz0MZnc0Yl4QNO7gPqthvotqjYJvIPX/B8qDe+BWFRExLqh0JnXusA6SpYLvZI++OZ
 BOZTuGsEhe4ZDH48sfuRQGul/T/owDY+i0vG/bVDg9/P8pAmnMi0w33RZ2ObURYoAnsH
 ua32FrwRUiWL+1Mo7Rf6S3uvYlM9bt5lUvdF6QghmuvWN67iUWwyhnQFmA26S8gg3kiv
 nw7A==
X-Gm-Message-State: AOAM531a3HcdOd+CEtp1bnfLl/dX8gy9httQiWCnfSxGIzOLDOyGIP9i
 2tLFiCTfadmRG56uoRyYve4CdpfsfiLUva4tf4PesXmqRUzYKdiJ0MujVjFK4HZFuDKbWhdPTw/
 DyAbjSUajl1GsTaU3VtApL/XScrikHAePc/i8hXur+Q==
X-Received: by 2002:a17:90a:5b10:: with SMTP id
 o16mr7219034pji.76.1626228885623; 
 Tue, 13 Jul 2021 19:14:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOiPXFxUcdLZWrtqR5/IHD7VsylcBTQze23cRfzIoKwRQb/qtzHoUNsMb4X6hRI8thHVVbZQ==
X-Received: by 2002:a17:90a:5b10:: with SMTP id
 o16mr7219014pji.76.1626228885330; 
 Tue, 13 Jul 2021 19:14:45 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p40sm469474pfw.79.2021.07.13.19.14.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jul 2021 19:14:44 -0700 (PDT)
Subject: Re: [PATCH v9 13/17] vdpa: factor out vhost_vdpa_pa_map() and
 vhost_vdpa_pa_unmap()
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Xie Yongji <xieyongji@bytedance.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-14-xieyongji@bytedance.com> <20210713113114.GL1954@kadam>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <20e75b53-0dce-2f2d-b717-f78553bddcd8@redhat.com>
Date: Wed, 14 Jul 2021 10:14:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713113114.GL1954@kadam>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, christian.brauner@canonical.com,
 corbet@lwn.net, joro@8bytes.org, willy@infradead.org, hch@infradead.org,
 xiaodong.liu@intel.com, viro@zeniv.linux.org.uk, stefanha@redhat.com,
 songmuchun@bytedance.com, axboe@kernel.dk, zhe.he@windriver.com,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, bcrl@kvack.org,
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 mika.penttila@nextfour.com
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNy8xMyDPws7nNzozMSwgRGFuIENhcnBlbnRlciDQtLXAOgo+IE9uIFR1ZSwgSnVs
IDEzLCAyMDIxIGF0IDA0OjQ2OjUyUE0gKzA4MDAsIFhpZSBZb25namkgd3JvdGU6Cj4+IEBAIC02
MTMsMzcgKzYxOCwyOCBAQCBzdGF0aWMgdm9pZCB2aG9zdF92ZHBhX3VubWFwKHN0cnVjdCB2aG9z
dF92ZHBhICp2LCB1NjQgaW92YSwgdTY0IHNpemUpCj4+ICAgCX0KPj4gICB9Cj4+ICAgCj4+IC1z
dGF0aWMgaW50IHZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl91cGRhdGUoc3RydWN0IHZob3N0X3Zk
cGEgKnYsCj4+IC0JCQkJCSAgIHN0cnVjdCB2aG9zdF9pb3RsYl9tc2cgKm1zZykKPj4gK3N0YXRp
YyBpbnQgdmhvc3RfdmRwYV9wYV9tYXAoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4+ICsJCQkgICAg
IHU2NCBpb3ZhLCB1NjQgc2l6ZSwgdTY0IHVhZGRyLCB1MzIgcGVybSkKPj4gICB7Cj4+ICAgCXN0
cnVjdCB2aG9zdF9kZXYgKmRldiA9ICZ2LT52ZGV2Owo+PiAtCXN0cnVjdCB2aG9zdF9pb3RsYiAq
aW90bGIgPSBkZXYtPmlvdGxiOwo+PiAgIAlzdHJ1Y3QgcGFnZSAqKnBhZ2VfbGlzdDsKPj4gICAJ
dW5zaWduZWQgbG9uZyBsaXN0X3NpemUgPSBQQUdFX1NJWkUgLyBzaXplb2Yoc3RydWN0IHBhZ2Ug
Kik7Cj4+ICAgCXVuc2lnbmVkIGludCBndXBfZmxhZ3MgPSBGT0xMX0xPTkdURVJNOwo+PiAgIAl1
bnNpZ25lZCBsb25nIG5wYWdlcywgY3VyX2Jhc2UsIG1hcF9wZm4sIGxhc3RfcGZuID0gMDsKPj4g
ICAJdW5zaWduZWQgbG9uZyBsb2NrX2xpbWl0LCBzejJwaW4sIG5jaHVua3MsIGk7Cj4+IC0JdTY0
IGlvdmEgPSBtc2ctPmlvdmE7Cj4+ICsJdTY0IHN0YXJ0ID0gaW92YTsKPj4gICAJbG9uZyBwaW5u
ZWQ7Cj4+ICAgCWludCByZXQgPSAwOwo+PiAgIAo+PiAtCWlmIChtc2ctPmlvdmEgPCB2LT5yYW5n
ZS5maXJzdCB8fAo+PiAtCSAgICBtc2ctPmlvdmEgKyBtc2ctPnNpemUgLSAxID4gdi0+cmFuZ2Uu
bGFzdCkKPj4gLQkJcmV0dXJuIC1FSU5WQUw7Cj4gVGhpcyBpcyBub3QgcmVsYXRlZCB0byB5b3Vy
IHBhdGNoLCBidXQgY2FuIHRoZSAibXNnLT5pb3ZhICsgbXNnLT5zaXplIgo+IGFkZGl0aW9uIGNh
biBoYXZlIGFuIGludGVnZXIgb3ZlcmZsb3cuICBGcm9tIGxvb2tpbmcgYXQgdGhlIGNhbGxlcnMg
aXQKPiBzZWVtcyBsaWtlIGl0IGNhbi4gIG1zZyBjb21lcyBmcm9tOgo+ICAgIHZob3N0X2Nocl93
cml0ZV9pdGVyKCkKPiAgICAtLT4gZGV2LT5tc2dfaGFuZGxlcihkZXYsICZtc2cpOwo+ICAgICAg
ICAtLT4gdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX21zZygpCj4gICAgICAgICAgIC0tPiB2aG9z
dF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKCkKCgpZZXMuCgoKPgo+IElmIEknbSB0aGlua2lu
ZyBvZiB0aGUgcmlnaHQgdGhpbmcgdGhlbiB0aGVzZSBhcmUgYWxsb3dlZCB0byBvdmVyZmxvdyB0
bwo+IDAgYmVjYXVzZSBvZiB0aGUgIiAtIDEiIGJ1dCBub3QgZnVydGhlciB0aGFuIHRoYXQuICBJ
IGJlbGlldmUgdGhlIGNoZWNrCj4gbmVlZHMgdG8gYmUgc29tZXRoaW5nIGxpa2U6Cj4KPiAJaWYg
KG1zZy0+aW92YSA8IHYtPnJhbmdlLmZpcnN0IHx8Cj4gCSAgICBtc2ctPmlvdmEgLSAxID4gVTY0
X01BWCAtIG1zZy0+c2l6ZSB8fAoKCkkgZ3Vlc3Mgd2UgZG9uJ3QgbmVlZCAtIDEgaGVyZT8KClRo
YW5rcwoKCj4gCSAgICBtc2ctPmlvdmEgKyBtc2ctPnNpemUgLSAxID4gdi0+cmFuZ2UubGFzdCkK
Pgo+IEJ1dCB3cml0aW5nIGludGVnZXIgb3ZlcmZsb3cgY2hlY2sgY29ycmVjdGx5IGlzIG5vdG9y
aW91c2x5IGRpZmZpY3VsdC4KPiBEbyB5b3UgdGhpbmsgeW91IGNvdWxkIHNlbmQgYSBmaXggZm9y
IHRoYXQgd2hpY2ggaXMgc2VwYXJhdGUgZnJvbSB0aGUKPiBwYXRjaGVzZXQ/ICBXZSdkIHdhbnQg
dG8gYmFja3BvcnQgaXQgdG8gc3RhYmxlLgo+Cj4gcmVnYXJkcywKPiBkYW4gY2FycGVudGVyCj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
