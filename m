Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEB6C71153
	for <virtualization@archiver.kernel.org>; Mon, 11 Sep 2023 03:43:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5D4E2400FB;
	Mon, 11 Sep 2023 03:43:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5D4E2400FB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ds+ReeXf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n727vtoukZr2; Mon, 11 Sep 2023 03:43:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5211240116;
	Mon, 11 Sep 2023 03:43:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5211240116
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28F21C0039;
	Mon, 11 Sep 2023 03:43:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EE28C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 03:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 08E1360C08
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 03:43:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08E1360C08
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ds+ReeXf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p3qKAFN8Q66E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 03:43:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2E53560C05
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 03:43:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E53560C05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694403779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9sqxh+GFHHbDLcfyo/0cojYj4G95x6wsRb2JSvZuE98=;
 b=Ds+ReeXfUiAwgXoeC3IwmHNR1VYNcMPlNYC3ohnxngKW3CaZW6odCj+Zke+pwQSqUMo0G4
 DADJ8n2q/G1XXRCoyQ5l3iWgHziWUq32Balz3Ij2/fIN8Cj+NgLed9X4G3FthY0e0LAhxA
 ImLgQzZ2E3XD+57t4gqap8Ymlqgd/oA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-xWYz87_MMmyBv1CGObmFkQ-1; Sun, 10 Sep 2023 23:42:57 -0400
X-MC-Unique: xWYz87_MMmyBv1CGObmFkQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5009121067cso4059078e87.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Sep 2023 20:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694403776; x=1695008576;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9sqxh+GFHHbDLcfyo/0cojYj4G95x6wsRb2JSvZuE98=;
 b=B+DPdF+A6haDezGXYt1lkhxHxOwQpSjalG9sDr+KPtQpysiJIWaRXPdsMSqRz7X1Wq
 6zdYFKch7UQcfcLba0c7509zivznECpn+ZW1bBk4huXEYpYCEl/W8JWL6N2xh3aKmxCx
 xcXmgwCnDuNOJ1aS3qgNSuJwushjNCC3iWpeI7yTmFW9p9GVSr8hK7Q0JcZZ3yTar6K4
 t7kzmUt5BUOlHkJioiA3O6IRcUDokVkPqG85G7xjC9MZj+6JylLiqu9TOvA0XRv8LLFQ
 b9G2mir7il82qQBmLqG0ikhgAYjTvIctlOCkkz/87qN4PXrSR+uf9xOUElkBVNEd4Xjq
 YFAQ==
X-Gm-Message-State: AOJu0YxREhNcMtGUq7/AG7tu6W0nUqORyqFcg3+/008NAWdNWC56UKJn
 F15xzc7n+7rEaMqZ6ki8VPk2Tiu/X2fiH/Z0wNMt5kaApgwBPjHC7AWknsoCWz2dyAl94FxidEN
 LXwqRXrCwDsRVXVmy9/vgufa0Sn4xgqztj91G/piXw7+zPyOxQMnkN20nkg==
X-Received: by 2002:a05:6512:36c2:b0:500:a2d0:51ba with SMTP id
 e2-20020a05651236c200b00500a2d051bamr5820874lfs.44.1694403776367; 
 Sun, 10 Sep 2023 20:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoAcli7voi5SOj4fZlcb+ZM7xDA53H4O2+Fw85MIXHke7Wo3XFBzwa82YD7axzYkKmsAfhKzpGbeFMLrYnzSQ=
X-Received: by 2002:a05:6512:36c2:b0:500:a2d0:51ba with SMTP id
 e2-20020a05651236c200b00500a2d051bamr5820867lfs.44.1694403776106; Sun, 10 Sep
 2023 20:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <1694266319-32287-1-git-send-email-si-wei.liu@oracle.com>
 <1694266319-32287-2-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1694266319-32287-2-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Sep 2023 11:42:45 +0800
Message-ID: <CACGkMEsACZcKQr9BGB0FzqJQbpfu9QTsh3hTxLaJ72on+3pK7w@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/4] vdpa: introduce .reset_map operation callback
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 xuanzhuo@linux.alibaba.com, mst@redhat.com
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

SGkgU2ktV2VpOgoKT24gU2F0LCBTZXAgOSwgMjAyMyBhdCA5OjM04oCvUE0gU2ktV2VpIExpdSA8
c2ktd2VpLmxpdUBvcmFjbGUuY29tPiB3cm90ZToKPgo+IE9uLWNoaXAgSU9NTVUgcGFyZW50IGRy
aXZlciBjb3VsZCB1c2UgaXQgdG8gcmVzdG9yZSBtZW1vcnkgbWFwcGluZwo+IHRvIHRoZSBpbml0
aWFsIHN0YXRlLgoKQXMgZGlzY3Vzc2VkIGJlZm9yZS4gT24tY2hpcCBJT01NVSBpcyB0aGUgaGFy
ZHdhcmUgZGV0YWlscyB0aGF0IG5lZWQKdG8gYmUgaGlkZGVuIGJ5IHRoZSB2RFBBIGJ1cy4KCkV4
cG9zaW5nIHRoaXMgd2lsbCBjb21wbGljYXRlIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBidXMgZHJp
dmVycy4KClRoYW5rcwoKPgo+IFNpZ25lZC1vZmYtYnk6IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4KPiAtLS0KPiAgaW5jbHVkZS9saW51eC92ZHBhLmggfCA3ICsrKysrKysKPiAg
MSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiBpbmRleCAxN2E0ZWZhLi5kYWVj
ZjU1IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gKysrIGIvaW5jbHVkZS9s
aW51eC92ZHBhLmgKPiBAQCAtMzI0LDYgKzMyNCwxMiBAQCBzdHJ1Y3QgdmRwYV9tYXBfZmlsZSB7
Cj4gICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAaW92YTogaW92YSB0byBiZSB1bm1h
cHBlZAo+ICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQHNpemU6IHNpemUgb2YgdGhl
IGFyZWEKPiAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJldHVybnMgaW50ZWdlcjog
c3VjY2VzcyAoMCkgb3IgZXJyb3IgKDwgMCkKPiArICogQHJlc2V0X21hcDogICAgICAgICAgICAg
ICAgIFJlc2V0IGRldmljZSBtZW1vcnkgbWFwcGluZyAob3B0aW9uYWwpCj4gKyAqICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBOZWVkZWQgZm9yIGRldmljZSB0aGF0IHVzaW5nIGRldmljZQo+
ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3BlY2lmaWMgRE1BIHRyYW5zbGF0aW9u
IChvbi1jaGlwIElPTU1VKQo+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQHZkZXY6
IHZkcGEgZGV2aWNlCj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAYXNpZDogYWRk
cmVzcyBzcGFjZSBpZGVudGlmaWVyCj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBS
ZXR1cm5zIGludGVnZXI6IHN1Y2Nlc3MgKDApIG9yIGVycm9yICg8IDApCj4gICAqIEBnZXRfdnFf
ZG1hX2RldjogICAgICAgICAgICBHZXQgdGhlIGRtYSBkZXZpY2UgZm9yIGEgc3BlY2lmaWMKPiAg
ICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRxdWV1ZSAob3B0aW9uYWwpCj4gICAq
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAdmRldjogdmRwYSBkZXZpY2UKPiBAQCAtNDAx
LDYgKzQwNyw3IEBAIHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgewo+ICAgICAgICAgICAgICAgICAg
ICAgICAgdTY0IGlvdmEsIHU2NCBzaXplLCB1NjQgcGEsIHUzMiBwZXJtLCB2b2lkICpvcGFxdWUp
Owo+ICAgICAgICAgaW50ICgqZG1hX3VubWFwKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVu
c2lnbmVkIGludCBhc2lkLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICB1NjQgaW92YSwgdTY0
IHNpemUpOwo+ICsgICAgICAgaW50ICgqcmVzZXRfbWFwKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
ZXYsIHVuc2lnbmVkIGludCBhc2lkKTsKPiAgICAgICAgIGludCAoKnNldF9ncm91cF9hc2lkKShz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBncm91cCwKPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgYXNpZCk7Cj4gICAgICAgICBzdHJ1Y3Qg
ZGV2aWNlICooKmdldF92cV9kbWFfZGV2KShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUxNiBp
ZHgpOwo+IC0tCj4gMS44LjMuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
