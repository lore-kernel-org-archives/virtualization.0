Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A95C433EF
	for <virtualization@archiver.kernel.org>; Wed, 29 Jun 2022 04:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF39241765;
	Wed, 29 Jun 2022 04:12:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF39241765
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OVRMU/78
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KeaqDh6imfZ4; Wed, 29 Jun 2022 04:12:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E263E41799;
	Wed, 29 Jun 2022 04:12:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E263E41799
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0C8DC0039;
	Wed, 29 Jun 2022 04:12:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AD2DC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 04:12:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5060B60BE1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 04:12:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5060B60BE1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OVRMU/78
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MH0E5r8T_Oz8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 04:12:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C0A660B2A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C0A660B2A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 04:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656475962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GNM+BbnxY/R2xbw+iRFV6Wl10CXwSKS8xeWt77Ki534=;
 b=OVRMU/78d8x28k4NPo7SmSckoXcrIHbCy91wFQ83mqhPGr0HsOa6Mtl5OMXTxIeL+dufMw
 N0CGh6gDC832wT42b3PIDL5USh52sVG6a++FiHg74rwf0l7s4FFi/pRVc8XFHw9lhsVDhT
 2mdW4gE2lHP9kkQms3mD07qb0Xjmc/I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-4XMPmTXRN0mnjOUmgbIeiw-1; Wed, 29 Jun 2022 00:12:40 -0400
X-MC-Unique: 4XMPmTXRN0mnjOUmgbIeiw-1
Received: by mail-lf1-f72.google.com with SMTP id
 j7-20020a056512398700b004811ba582d2so3551251lfu.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 21:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GNM+BbnxY/R2xbw+iRFV6Wl10CXwSKS8xeWt77Ki534=;
 b=C4u4yF38TiIm2CDEj6wCMF88fsynETbznlgsDEu7sI48/BZPz0dCWovI9awQsQZsEa
 AbX8Jz1xW5N/niF3S0JAWwnlWonAtPzoRVJMKFAGs2kyeXI/4yCWeVmMZRA1AvrwFFJ0
 IYhazCS6ORAhm+Z7ubdqZg8Atzd2MtcIO/rmcP5eplgVdZkwTLUxkxyUIDbI0TCzaQii
 Ci+MtDBDfxIjOonG3BGCUXrQK6Pc4LLQ1vLX1fMuP3DfAtJVKt6DX8yyMdIXMvp3NPDs
 KX6lVmegFZCanwxP+UJTHiWi20v7cDtNmnu5zKSKbg7Ogh2zNi8VCzIc6b8NVQfDq7U9
 Ykhw==
X-Gm-Message-State: AJIora8kzaa0p4cXI9oVCHF1pXUJGMNEZrNLgRVqaUFyIIbT5CvFyDRN
 S9IG2dGuWgs1YbIGGfGtRIiYxFGSdJnx2dL8JnCiLnNxPLgDCSl9RnM4YX+f6nC/psxvObKhAqb
 K14urugc9G9RopU/EZ0oYjMNij6khetuWGUye+zwyE0/ScnAn9nN8RfrIcw==
X-Received: by 2002:a05:651c:895:b0:250:c5ec:bc89 with SMTP id
 d21-20020a05651c089500b00250c5ecbc89mr574054ljq.251.1656475958717; 
 Tue, 28 Jun 2022 21:12:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tHRCeQEYFeDihZwqrb3gPA69zDi6jWiWd/DBiz6ym7vRZ1l6srncfxGDke2JCiHZCDM5Ja741bHC00eazMkAU=
X-Received: by 2002:a05:651c:895:b0:250:c5ec:bc89 with SMTP id
 d21-20020a05651c089500b00250c5ecbc89mr574045ljq.251.1656475958454; Tue, 28
 Jun 2022 21:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220623160738.632852-1-eperezma@redhat.com>
 <20220623160738.632852-3-eperezma@redhat.com>
In-Reply-To: <20220623160738.632852-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 29 Jun 2022 12:12:27 +0800
Message-ID: <CACGkMEtNC=4KeigQXr4NuaiuVGkxK2ruQTk6-Fbr3B1MqHieTA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] vhost-vdpa: introduce SUSPEND backend feature bit
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Kamde, Tanuj" <tanuj.kamde@amd.com>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>,
 Pablo Cascon Katchadourian <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, Cindy Lu <lulu@redhat.com>, "Uminski,
 Piotr" <Piotr.Uminski@intel.com>,
 Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, Dinan Gunawardena <dinang@xilinx.com>,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Laurent Vivier <lvivier@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 ecree.xilinx@gmail.com, Harpreet Singh Anand <hanand@xilinx.com>,
 Martin Porter <martinpo@xilinx.com>, "Dawar, Gautam" <gautam.dawar@amd.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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

T24gRnJpLCBKdW4gMjQsIDIwMjIgYXQgMTI6MDggQU0gRXVnZW5pbyBQw6lyZXogPGVwZXJlem1h
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gVXNlcmxhbmQga25vd3MgaWYgaXQgY2FuIHN1c3BlbmQg
dGhlIGRldmljZSBvciBub3QgYnkgY2hlY2tpbmcgdGhpcyBmZWF0dXJlCj4gYml0Lgo+Cj4gSXQn
cyBvbmx5IG9mZmVyZWQgaWYgdGhlIHZkcGEgZHJpdmVyIGJhY2tlbmQgaW1wbGVtZW50cyB0aGUg
c3VzcGVuZCgpCj4gb3BlcmF0aW9uIGNhbGxiYWNrLCBhbmQgdG8gb2ZmZXIgaXQgb3IgdXNlcmxh
bmQgdG8gYWNrIGl0IGlmIHRoZSBiYWNrZW5kCj4gZG9lcyBub3Qgb2ZmZXIgdGhhdCBjYWxsYmFj
ayBpcyBhbiBlcnJvci4KPgo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXpt
YUByZWRoYXQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyAgICAgICAgICAgICB8
IDE2ICsrKysrKysrKysrKysrKy0KPiAgaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmgg
fCAgMiArKwo+ICAyIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jCj4gaW5kZXggMjNkY2JmZGZhMTNiLi4zZDYzNmUxOTIwNjEgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy92aG9zdC92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IEBAIC0z
NDcsNiArMzQ3LDE0IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0X2NvbmZpZyhzdHJ1Y3Qg
dmhvc3RfdmRwYSAqdiwKPiAgICAgICAgIHJldHVybiAwOwo+ICB9Cj4KPiArc3RhdGljIGJvb2wg
dmhvc3RfdmRwYV9jYW5fc3VzcGVuZChjb25zdCBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPiArewo+
ICsgICAgICAgc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRwYTsKPiArICAgICAgIGNv
bnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKPiArCj4gKyAg
ICAgICByZXR1cm4gb3BzLT5zdXNwZW5kOwo+ICt9Cj4gKwo+ICBzdGF0aWMgbG9uZyB2aG9zdF92
ZHBhX2dldF9mZWF0dXJlcyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTY0IF9fdXNlciAqZmVhdHVy
ZXApCj4gIHsKPiAgICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4g
QEAgLTU3Nyw3ICs1ODUsMTEgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV91bmxvY2tlZF9pb2N0
bChzdHJ1Y3QgZmlsZSAqZmlsZXAsCj4gICAgICAgICBpZiAoY21kID09IFZIT1NUX1NFVF9CQUNL
RU5EX0ZFQVRVUkVTKSB7Cj4gICAgICAgICAgICAgICAgIGlmIChjb3B5X2Zyb21fdXNlcigmZmVh
dHVyZXMsIGZlYXR1cmVwLCBzaXplb2YoZmVhdHVyZXMpKSkKPiAgICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVGQVVMVDsKPiAtICAgICAgICAgICAgICAgaWYgKGZlYXR1cmVzICYgflZI
T1NUX1ZEUEFfQkFDS0VORF9GRUFUVVJFUykKPiArICAgICAgICAgICAgICAgaWYgKGZlYXR1cmVz
ICYgfihWSE9TVF9WRFBBX0JBQ0tFTkRfRkVBVFVSRVMgfAo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1NVU1BFTkQpKSkKPiArICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7Cj4gKyAgICAgICAgICAgICAgIGlm
ICgoZmVhdHVyZXMgJiBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9TVVNQRU5EKSkgJiYKPiArICAg
ICAgICAgICAgICAgICAgICAhdmhvc3RfdmRwYV9jYW5fc3VzcGVuZCh2KSkKCkRvIHdlIG5lZWQg
dG8gYWR2ZXJ0aXNlIHRoaXMgdG8gdGhlIG1hbmFnZW1lbnQ/CgpUaGFua3MKCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOwo+ICAgICAgICAgICAgICAgICB2aG9z
dF9zZXRfYmFja2VuZF9mZWF0dXJlcygmdi0+dmRldiwgZmVhdHVyZXMpOwo+ICAgICAgICAgICAg
ICAgICByZXR1cm4gMDsKPiBAQCAtNjI4LDYgKzY0MCw4IEBAIHN0YXRpYyBsb25nIHZob3N0X3Zk
cGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGVwLAo+ICAgICAgICAgICAgICAgICBi
cmVhazsKPiAgICAgICAgIGNhc2UgVkhPU1RfR0VUX0JBQ0tFTkRfRkVBVFVSRVM6Cj4gICAgICAg
ICAgICAgICAgIGZlYXR1cmVzID0gVkhPU1RfVkRQQV9CQUNLRU5EX0ZFQVRVUkVTOwo+ICsgICAg
ICAgICAgICAgICBpZiAodmhvc3RfdmRwYV9jYW5fc3VzcGVuZCh2KSkKPiArICAgICAgICAgICAg
ICAgICAgICAgICBmZWF0dXJlcyB8PSBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9TVVNQRU5EKTsK
PiAgICAgICAgICAgICAgICAgaWYgKGNvcHlfdG9fdXNlcihmZWF0dXJlcCwgJmZlYXR1cmVzLCBz
aXplb2YoZmVhdHVyZXMpKSkKPiAgICAgICAgICAgICAgICAgICAgICAgICByID0gLUVGQVVMVDsK
PiAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51
eC92aG9zdF90eXBlcy5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmgKPiBpbmRl
eCA2MzRjZWU0ODVhYmIuLjFiZGQ2ZTM2M2Y0YyAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3VhcGkv
bGludXgvdmhvc3RfdHlwZXMuaAo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aG9zdF90eXBl
cy5oCj4gQEAgLTE2MSw1ICsxNjEsNyBAQCBzdHJ1Y3Qgdmhvc3RfdmRwYV9pb3ZhX3JhbmdlIHsK
PiAgICogbWVzc2FnZQo+ICAgKi8KPiAgI2RlZmluZSBWSE9TVF9CQUNLRU5EX0ZfSU9UTEJfQVNJ
RCAgMHgzCj4gKy8qIERldmljZSBjYW4gYmUgc3VzcGVuZGVkICovCj4gKyNkZWZpbmUgVkhPU1Rf
QkFDS0VORF9GX1NVU1BFTkQgIDB4NAo+Cj4gICNlbmRpZgo+IC0tCj4gMi4zMS4xCj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
