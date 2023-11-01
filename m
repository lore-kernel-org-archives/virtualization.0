Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632D9C4332F
	for <virtualization@archiver.kernel.org>; Wed,  1 Nov 2023 04:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F2516FB17;
	Wed,  1 Nov 2023 04:36:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F2516FB17
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HHVfMrSB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BNXvBw5g8Fzi; Wed,  1 Nov 2023 04:36:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 49CB26FB16;
	Wed,  1 Nov 2023 04:36:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 49CB26FB16
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17D47C0071;
	Wed,  1 Nov 2023 04:36:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C1B5C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 04:36:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 330844047B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 04:36:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 330844047B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HHVfMrSB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o2FEG-ibXArE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 04:36:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F286400B9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 04:36:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F286400B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698813393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bm6nv3OrJNAdAjBRVuIThTw9zVigtFmJLGDyu68dZkw=;
 b=HHVfMrSBP1WiarZ76VH1Heo8TMzC2tUMnnVp/ZznP9gINGpEqGzoS7VQrfC5/xEOILWYRm
 UAM1o4tyzYfq3YtajI6CHPtylCJA3PecbfXuj1Jo5wYNzf2CTH3xwqs9BrnS51YH4KpM8/
 628tXQY1kCeZn9Z6blAQeSgBPsBam/Q=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-QZX79JTCOOSIvgTrcKgzZg-1; Wed, 01 Nov 2023 00:36:32 -0400
X-MC-Unique: QZX79JTCOOSIvgTrcKgzZg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c503804667so69651251fa.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 21:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698813391; x=1699418191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bm6nv3OrJNAdAjBRVuIThTw9zVigtFmJLGDyu68dZkw=;
 b=wfaHVB8eFt3hHXBYmMyjLKzUs56GL94l8WT2GsIKxq2SnzMifG5PaPki1w2TMZThRL
 IZAMt4HY/ruMKTCSG2rLjvJBd/EynBny1g9aQuxHaFOKAD0nlX1k4YivILCsce3O0jig
 Z88Wfi37RELfpzMl4ZvyWo5Chy65J28pNPozZjrZFvyBV6L0KsjBXRiMpPFeXhoJ4EFE
 rbIhZr2BmKAOI/5/bRzJZ2BblTwZ1brdEh0XkyuVJjG4192Gnnv9RboHQGPC2NkwlgA8
 cCzM737y5DtvdhdkLDb25ZP7y/sKvFv0vRxSkityx6a63S2QRLikhywWw/sfyYMfT6qY
 yhMg==
X-Gm-Message-State: AOJu0Yxw9Nb2fgr6RTek5svmwgtPk/ZXRdLRWlDMzx6dCOJAcerx+BoE
 VtRN9GALjUASfTNEHkYrsStDQLy7HW87eX38YYPNXqZVDah18zgIaJwOqVTaVoPnoCFUZOh5mJv
 YjWBfwrQYD3eARojLI/CNNrhYz8x3oHONlyem05z9TGnlixksNzpgQS2h4w==
X-Received: by 2002:a19:ae16:0:b0:503:afa:e79 with SMTP id
 f22-20020a19ae16000000b005030afa0e79mr10181916lfc.5.1698813390936; 
 Tue, 31 Oct 2023 21:36:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFiWTEEXffIJuc8scoNdDy3OwhB3Mf/+OrEdEdZTWinIPqM4Ur7SHi0nvzq6dnmpW4or5dSxVvXJ3rxzRcbLU=
X-Received: by 2002:a19:ae16:0:b0:503:afa:e79 with SMTP id
 f22-20020a19ae16000000b005030afa0e79mr10181908lfc.5.1698813390652; 
 Tue, 31 Oct 2023 21:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <cf53cb61-0699-4e36-a980-94fd4268ff00@moroto.mountain>
In-Reply-To: <cf53cb61-0699-4e36-a980-94fd4268ff00@moroto.mountain>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 1 Nov 2023 12:36:19 +0800
Message-ID: <CACGkMEvytH47Wb2LjP2667-D8OWbDruwV8aRvqcUzksWB-ruvg@mail.gmail.com>
Subject: Re: [PATCH net-XXX] vhost-vdpa: fix use after free in
 vhost_vdpa_probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Bo Liu <liubo03@inspur.com>
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

T24gRnJpLCBPY3QgMjcsIDIwMjMgYXQgODoxM+KAr1BNIERhbiBDYXJwZW50ZXIgPGRhbi5jYXJw
ZW50ZXJAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBUaGUgcHV0X2RldmljZSgpIGNhbGxzIHZob3N0
X3ZkcGFfcmVsZWFzZV9kZXYoKSB3aGljaCBjYWxscwo+IGlkYV9zaW1wbGVfcmVtb3ZlKCkgYW5k
IGZyZWVzICJ2Ii4gIFNvIHRoaXMgY2FsbCB0bwo+IGlkYV9zaW1wbGVfcmVtb3ZlKCkgaXMgYSB1
c2UgYWZ0ZXIgZnJlZSBhbmQgYSBkb3VibGUgZnJlZS4KPgo+IEZpeGVzOiBlYmU2YTM1NGZhN2Ug
KCJ2aG9zdC12ZHBhOiBDYWxsIGlkYV9zaW1wbGVfcmVtb3ZlKCkgd2hlbiBmYWlsZWQiKQo+IFNp
Z25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4KCkFj
a2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+IC0tLQo+
ICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDEgLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlv
bigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9z
dC92ZHBhLmMKPiBpbmRleCA5YTIzNDNjNDVkZjAuLjFhYTY3NzI5ZTE4OCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gQEAg
LTE1MTEsNyArMTUxMSw2IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9wcm9iZShzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkcGEpCj4KPiAgZXJyOgo+ICAgICAgICAgcHV0X2RldmljZSgmdi0+ZGV2KTsK
PiAtICAgICAgIGlkYV9zaW1wbGVfcmVtb3ZlKCZ2aG9zdF92ZHBhX2lkYSwgdi0+bWlub3IpOwo+
ICAgICAgICAgcmV0dXJuIHI7Cj4gIH0KPgo+IC0tCj4gMi40Mi4wCj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
