Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874E6C433EF
	for <virtualization@archiver.kernel.org>; Thu, 30 Jun 2022 15:32:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F2FD613AA;
	Thu, 30 Jun 2022 15:32:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F2FD613AA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hho663fz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6SaLb_YWvp2n; Thu, 30 Jun 2022 15:32:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ADB32613A5;
	Thu, 30 Jun 2022 15:32:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ADB32613A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72047C0035;
	Thu, 30 Jun 2022 15:32:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 659C8C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D43142435
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:32:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D43142435
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hho663fz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id szlWmJ71YM_L
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:32:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0525D42425
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0525D42425
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656603154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YJ2kJ9M3J473925A1Sz+6DavMX+WtsWN9FnXUNFiskQ=;
 b=Hho663fzn+A0J7Wjx2VqZ1X1Jd96X8laWkICdcvQuLPAt1XqB0mLHlc4iu7ISrUEzewr5v
 kLpFKbAgLYFp2j52Zyfj2JMbwDuj/5Im2N/y+ChurdtIz6y71RnOfEy9xtZTnCawpmdqNu
 R5cTbE4E0JaGC0KDlOkV+319UyAGk60=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-UyM6SVHkPDqcuYjEks2lmw-1; Thu, 30 Jun 2022 11:32:33 -0400
X-MC-Unique: UyM6SVHkPDqcuYjEks2lmw-1
Received: by mail-qk1-f197.google.com with SMTP id
 194-20020a3704cb000000b006af069d1e0aso18428427qke.15
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 08:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YJ2kJ9M3J473925A1Sz+6DavMX+WtsWN9FnXUNFiskQ=;
 b=KkBQwoOZSwmhov2TODRLkIZ3FjIQrWVi29xKdcl4JmKCuHnSEz3+XguZ0b1OcXUttq
 atzm0J74/N/AD9zzPp9+DpN4mDu22KRaxvOJiy3x4aphcq1hLx+Ukmc9u9aK77C+1JyO
 plau7PF0sDTAzSC+8QsOzj5s6ntKvLI7rbiN0Xi/aJKWKijhCOjqRjZUI7Om+i1DTu3K
 SPX6UjViACkH58DdjPIyTg89xcO50jZmZU2W42gDBpaLBWOCToACePdOTYzq8gEmRUSW
 oGQ0kI2GdrZIV++jU09945HomCfMz2+0IMiIIar0GZ8JguueLRdnNH9BbkRxtXhJjs7X
 jlDA==
X-Gm-Message-State: AJIora8QBfqE4TiETc1rSkTnULJ/SUYWO153JQxjUdtv0XA5bdRm1QM3
 c8dCVToQgg5gMdGmbXSdjEO/UzRvgMpMOKM9lQs08JuKxMGplJYuNXK7yFq4bA+txeID4W0c3IU
 lhe6/sunOYl4g/Tkl48GSJm2ahDO7aK/r3+4q0clWAR+dVPSMnqxH52WiZHcHpjO+qPc44rHL3M
 Wbolla2XRa89vaRnBFLg==
X-Received: by 2002:a05:6214:2307:b0:46e:5fbc:3c30 with SMTP id
 gc7-20020a056214230700b0046e5fbc3c30mr12691630qvb.21.1656603152722; 
 Thu, 30 Jun 2022 08:32:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1syyg6jTK7iMokKvzkf30z0DmBsGln/1Z2e4Epr35QPBJLcZ3UXJlIecbQRWimM+K/3INQ4BQ==
X-Received: by 2002:a05:6214:2307:b0:46e:5fbc:3c30 with SMTP id
 gc7-20020a056214230700b0046e5fbc3c30mr12691583qvb.21.1656603152249; 
 Thu, 30 Jun 2022 08:32:32 -0700 (PDT)
Received: from step1.redhat.com (host-87-11-6-149.retail.telecomitalia.it.
 [87.11.6.149]) by smtp.gmail.com with ESMTPSA id
 y20-20020a05620a44d400b006af0639f7casm16089325qkp.12.2022.06.30.08.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jun 2022 08:32:31 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 2/3] vdpa_sim_blk: limit the number of request handled per
 batch
Date: Thu, 30 Jun 2022 17:32:20 +0200
Message-Id: <20220630153221.83371-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220630153221.83371-1-sgarzare@redhat.com>
References: <20220630153221.83371-1-sgarzare@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

TGltaXQgdGhlIG51bWJlciBvZiByZXF1ZXN0cyAoNCBwZXIgcXVldWUgYXMgZm9yIHZkcGFfc2lt
X25ldCkgaGFuZGxlZAppbiBhIGJhdGNoIHRvIHByZXZlbnQgdGhlIHdvcmtlciBmcm9tIHVzaW5n
IHRoZSBDUFUgZm9yIHRvbyBsb25nLgoKU3VnZ2VzdGVkLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBl
cmV6bWFAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2Fy
emFyZUByZWRoYXQuY29tPgotLS0KdjI6Ci0gcmVzdG9yZWQgcHJldmlvdXMgYmVoYXZpb3VyLCBl
eGl0aW5nIHRoZSBsb29wIGltbWVkaWF0ZWx5IGlmIHRoZQogIHJlcXVlc3QgaXMgbWFsZm9ybWVk
IFtKYXNvbl0KLS0tCiBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMgfCAxMCAr
KysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYyBiL2RyaXZlcnMvdmRwYS92ZHBh
X3NpbS92ZHBhX3NpbV9ibGsuYwppbmRleCBhODNhNWM3NmY2MjAuLmIyZDc1ZWZlYzYzYSAxMDA2
NDQKLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jCisrKyBiL2RyaXZl
cnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYwpAQCAtMTk3LDYgKzE5Nyw3IEBAIHN0YXRp
YyBib29sIHZkcGFzaW1fYmxrX2hhbmRsZV9yZXEoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0sCiBz
dGF0aWMgdm9pZCB2ZHBhc2ltX2Jsa193b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIHsK
IAlzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSA9IGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgdmRw
YXNpbSwgd29yayk7CisJYm9vbCByZXNjaGVkdWxlID0gZmFsc2U7CiAJaW50IGk7CiAKIAlzcGlu
X2xvY2soJnZkcGFzaW0tPmxvY2spOwpAQCAtMjA2LDYgKzIwNyw3IEBAIHN0YXRpYyB2b2lkIHZk
cGFzaW1fYmxrX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCiAJZm9yIChpID0gMDsg
aSA8IFZEUEFTSU1fQkxLX1ZRX05VTTsgaSsrKSB7CiAJCXN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1
ZSAqdnEgPSAmdmRwYXNpbS0+dnFzW2ldOworCQlpbnQgcmVxcyA9IDA7CiAKIAkJaWYgKCF2cS0+
cmVhZHkpCiAJCQljb250aW51ZTsKQEAgLTIxOCwxMCArMjIwLDE4IEBAIHN0YXRpYyB2b2lkIHZk
cGFzaW1fYmxrX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCQkJaWYgKHZyaW5naF9u
ZWVkX25vdGlmeV9pb3RsYigmdnEtPnZyaW5nKSA+IDApCiAJCQkJdnJpbmdoX25vdGlmeSgmdnEt
PnZyaW5nKTsKIAkJCWxvY2FsX2JoX2VuYWJsZSgpOworCisJCQlpZiAoKytyZXFzID4gNCkgewor
CQkJCXJlc2NoZWR1bGUgPSB0cnVlOworCQkJCWJyZWFrOworCQkJfQogCQl9CiAJfQogb3V0Ogog
CXNwaW5fdW5sb2NrKCZ2ZHBhc2ltLT5sb2NrKTsKKworCWlmIChyZXNjaGVkdWxlKQorCQlzY2hl
ZHVsZV93b3JrKCZ2ZHBhc2ltLT53b3JrKTsKIH0KIAogc3RhdGljIHZvaWQgdmRwYXNpbV9ibGtf
Z2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSwgdm9pZCAqY29uZmlnKQotLSAKMi4z
Ni4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
