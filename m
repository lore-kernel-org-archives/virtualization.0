Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75F6EE7FF4
	for <virtualization@archiver.kernel.org>; Mon, 11 Sep 2023 06:57:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 367A6408E3;
	Mon, 11 Sep 2023 06:57:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 367A6408E3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g0VkRDCr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N6Y3HyroKcDa; Mon, 11 Sep 2023 06:57:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8ADF7408E7;
	Mon, 11 Sep 2023 06:57:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8ADF7408E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5415CC0039;
	Mon, 11 Sep 2023 06:57:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25BE3C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 06:57:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F2C23408E7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 06:57:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2C23408E7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z8O3oQ7IDeg8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 06:57:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DBB0F408E3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 06:57:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DBB0F408E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694415432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxqH6Tn3jjo0ZWDpTkc6jzELn61wJze0oqZwAdBJHRo=;
 b=g0VkRDCrUCuiDOgwKz0gZrGvqzi7iODL5Rrf4G3vENpNwvV/LKSJXmVMUNDyiDhjjk56bP
 O7y2qwnk0ZD3Lr3dkn8GPc3IxFfq2co02dO3zPca4Wniwp59rsLophjCcHe/62p+6gdCC1
 ch212DUplV2f4EFTQ5adR3aYz1u99jE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-HJvIC_5BNA-7HrFoTvEXpg-1; Mon, 11 Sep 2023 02:57:11 -0400
X-MC-Unique: HJvIC_5BNA-7HrFoTvEXpg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-501c7c4059aso4164458e87.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Sep 2023 23:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694415429; x=1695020229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MxqH6Tn3jjo0ZWDpTkc6jzELn61wJze0oqZwAdBJHRo=;
 b=c3rqbUX+8Hkx+U0UAzn+49LnzR2oBiHCxWhqzdYgM1civFow7y1BzqwvZTFZ8Yu+kb
 didoNVBVYuZauyPC6iUGWRo2FNQvDRPsGBbNK9Ep4Ux5GllY22nfFawjcMGa31H9ybf3
 phgIdy5Hc2leM5oFmeQkJPxNFqvTOEGVL0oximPCHqzR3TZYl1mNEGvnAptoc1a2b/7k
 Rq1058tY33HJPDVm37qWBDXQ2jE+OoLcGS8Al0FDHkq5+NmLiu7JZ+0bOZkYelA2kgbK
 2FN/uoOlN/fxzbjmp61mWXpy0C1UYig/jRkvrdQq344udvnnHwe13CUAr0+SdABrvARQ
 8VFw==
X-Gm-Message-State: AOJu0YyzBvRLhEDKV4KKSCm30HP3KQTfVJ5tNr3SiEqZI3jYlkPtarNn
 Y9K4ECVQKdgumgkQiDprN4DJmiQF44x4lVnCOZ5hcrsyCBzIFhJsWQ39a1DVoyPs4LadGqSfTMF
 XDdesKRDlEXK7uO7/Z4JtcYwwGpCSYvh54XqaFvBQSYfHQA+gMuUcrrgXdg==
X-Received: by 2002:a05:6512:10ce:b0:500:c2d7:3ab4 with SMTP id
 k14-20020a05651210ce00b00500c2d73ab4mr7773976lfg.8.1694415429585; 
 Sun, 10 Sep 2023 23:57:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD2DFdqiS+J4e4em76cRX2svkyaUCa4g2FN2ipe5WdIInV8vo4cj5F+oOFP/ZKlg4fYDtjOxmlYBJKN7H0e9o=
X-Received: by 2002:a05:6512:10ce:b0:500:c2d7:3ab4 with SMTP id
 k14-20020a05651210ce00b00500c2d73ab4mr7773960lfg.8.1694415429311; Sun, 10 Sep
 2023 23:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693012755.git.jiangdongxu1@huawei.com>
In-Reply-To: <cover.1693012755.git.jiangdongxu1@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Sep 2023 14:56:58 +0800
Message-ID: <CACGkMEsP+3nTjG8gj0PoYg0DvyqqOpJKoAxG=m27t+iv-6GVbQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] vdpa: Add logging operatins
To: Jiang Dongxu <jiangdongxu1@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eric.fangyi@huawei.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma <eperezma@redhat.com>,
 longpeng2@huawei.com, Siwei Liu <loseweigh@gmail.com>
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

QWRkaW5nIEV1Z2VuaW8gYW5kIFNpIFdlaS4KCk9uIFNhdCwgQXVnIDI2LCAyMDIzIGF0IDk6MjTi
gK9BTSBKaWFuZyBEb25neHUgPGppYW5nZG9uZ3h1MUBodWF3ZWkuY29tPiB3cm90ZToKPgo+IEZy
b206IGppYW5nZG9uZ3h1IDxqaWFuZ2Rvbmd4dTFAaHVhd2VpLmNvbT4KPgo+IEN1cnJlbnRseSwg
dGhlIHZkcGEgZGV2aWNlIHN1cHBvcnRzIHN1c3BlbmQgYW5kIHJlc3VtZSBvcGVyYXRpb25zLgo+
IFRvIHN1cHBvcnQgdmRwYSBkZXZpY2UgbGl2ZSBtaWdyYXRpb24sIHdlIG5lZWQgdG8gc3VwcG9y
dCBsb2dnaW5nCj4gb3BlcmF0aW9ucyBhbmQgZGV2aWNlIHN0YXRlIHNhdmUvbG9hZCBvcGVydGlv
bnMuCj4KPiBUaGVzZSBzZXJpZXMgaW50cm9kdWNlcyBzb21lIG5ldyBvcGVyYXRpb25zIGZvciB2
ZHBhIGRldmljZXMuCj4gVGhleSBhbGxvdyB2ZHBhIHRvIGVuYWJsZSBsb2dnaW5nIHdoaWxlIHZt
IHN0YXJ0IGxpdmUgbWlncmF0aW9uLgo+Cj4gQW5kIEkgd2lsbCBzdWJtaXQgYW5vdGhlciBwYXRj
aGVzIGFib3V0IHNhdmluZyBhbmQgbG9hZGluZwo+IHZkcGEgZGV2aWNlIHN0YXRlIGxhdGVyLgoK
VGhhbmtzIGZvciB3b3JraW5nIG9uIHRoaXMsIEkgaGF2ZSBzZXZlcmFsIHF1ZXN0aW9uczoKCjEp
IElzIHRoZXJlIGFuIGV4YW1wbGUgaW1wbGVtZW50YXRpb24gb2YgdGhlIGxvZ2dpbmcgaW4gdGhl
IGRyaXZlcnM/CldlIG5lZWQgYSByZWFsIHVzZXIgaW4gb3JkZXIgdG8gbWVyZ2UgdGhpcy4KMikg
SXMgdGhlIGxvZ2dpbmcgYmFzZWQgb24gSU9WQSBvciBWQT8gSG93IHRoZSBETUEgaXNvbGF0aW9u
IGlzIGJlaW5nCmRvbmUgd2l0aCB0aGlzPyBEbyB3ZSBuZWVkIGEgU0VUX0xPR0dJTkdfQVNJRCB1
QVBJIGZvciB0aGlzPyAoV2UgaGFkCnNvbWUgZGlzY3Vzc2lvbiBvbiB0aGlzIGluIHRoZSBwYXN0
KS4KClRoYW5rcwoKPgo+IGppYW5nZG9uZ3h1ICgyKToKPiAgIHZkcGE6IGFkZCBsb2cgb3BlcmF0
aW9ucwo+ICAgdmhvc3QtdmRwYTogYWRkIHVBUEkgZm9yIGxvZ2dpbmcKPgo+ICBkcml2ZXJzL3Zo
b3N0L3ZkcGEuYyAgICAgICB8IDQ5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrCj4gIGluY2x1ZGUvbGludXgvdmRwYS5oICAgICAgIHwgMTQgKysrKysrKysrKysKPiAgaW5j
bHVkZS91YXBpL2xpbnV4L3Zob3N0LmggfCAgNCArKysrCj4gIDMgZmlsZXMgY2hhbmdlZCwgNjcg
aW5zZXJ0aW9ucygrKQo+Cj4gLS0KPiAyLjI3LjAKPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
