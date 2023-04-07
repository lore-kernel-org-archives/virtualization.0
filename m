Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B671C77B61
	for <virtualization@archiver.kernel.org>; Fri,  7 Apr 2023 13:37:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BFFA6168A;
	Fri,  7 Apr 2023 13:37:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9BFFA6168A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XvLoVRpy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jCcBhnC2S8e9; Fri,  7 Apr 2023 13:37:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 244AA61671;
	Fri,  7 Apr 2023 13:37:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 244AA61671
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04650C0036;
	Fri,  7 Apr 2023 13:37:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9F37C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 13:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BAD9641E24
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 13:37:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BAD9641E24
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XvLoVRpy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lhiDoBfUNxfR
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 13:37:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB9B741E2B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB9B741E2B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 13:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680874628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aIvmfG2D4lMXQvYk341nc+hYEXy66ytDTxFyh3hTIFM=;
 b=XvLoVRpyjwLY8+y5uPyJ/uzuB+i6cCWsxui06Z5K6YQyiYWXgTryu3mIUofGrTyEMtNtyH
 4r7ijow1qNyyt+qe4+5cSui/56JZQlUuEqDhmgvMO+i7khmTWiGReU9wLnGoAjGuolmJ5/
 Z1cGs5vq7yhmQFWhtHuEfT9qKNn6+CA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-SpPkz3QlMaq377EcDOKleA-1; Fri, 07 Apr 2023 09:37:07 -0400
X-MC-Unique: SpPkz3QlMaq377EcDOKleA-1
Received: by mail-qk1-f197.google.com with SMTP id
 q143-20020a374395000000b0074690a17414so19222509qka.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Apr 2023 06:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680874625; x=1683466625;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aIvmfG2D4lMXQvYk341nc+hYEXy66ytDTxFyh3hTIFM=;
 b=WfdJSG5sIA9CaBOHp+M65X1DHPF7BJLEhioNdcGxsQ0fmFBiuYbA9vRyCmmg7P5UBZ
 egsxwsBZa7Rw0i47C11BN5rxFM4/+l/DkcNqhEpZg5DtGT+e4vFwVLmt0kTp9YS+8au+
 K0ftQdw0v1bwBZLh51K0YtSeLL2/Y9r8fi9jHDPeyVhuboYxTA81HVU7taDWtfe+DOLV
 I/SHh4gTJjNGOdPD/24vikiUqWc8yqhYFn7jYqPINcrIXwybYLrJkVjQ7E2PsqHGsPP4
 d3SFoeZyAnPFfE3nkQfIoEWAeCu2K7rAXKWwrdO2dRYAhfsC0+O+hSzQRXINy8vewMkU
 tDsw==
X-Gm-Message-State: AAQBX9e8CQZ343qaAmi4I+bCqnaB7stRHX6Da5eNXKI0Yh+usB1uXZyD
 IGYkKKRzDDBehJnR/BdBU2/ty2FwfRKda/7m/bTDAPl7tmHcZEsuO0wOvNAprmRwE7prszo5puN
 ADMlFSL3uVHywtPSWQiG49miaZem7nKwjnkzLw1FN2CPMBdzynd5JoIAv6VbwGA1X87HdmVzC5D
 NUP2kpTWIEe7qIXrcSoZm1EHu2Hw==
X-Received: by 2002:a05:6214:21aa:b0:5a5:9297:21b2 with SMTP id
 t10-20020a05621421aa00b005a5929721b2mr3148639qvc.21.1680874624828; 
 Fri, 07 Apr 2023 06:37:04 -0700 (PDT)
X-Google-Smtp-Source: AKy350YAYMwT2wYKup442yHZBqo2BdAdAw1o1pmJYgAzO/7ubEP4yOwY4XvBBvM3cXQjkygfMrvgUA==
X-Received: by 2002:a05:6214:21aa:b0:5a5:9297:21b2 with SMTP id
 t10-20020a05621421aa00b005a5929721b2mr3148598qvc.21.1680874624509; 
 Fri, 07 Apr 2023 06:37:04 -0700 (PDT)
Received: from step1.redhat.com ([5.77.69.107])
 by smtp.gmail.com with ESMTPSA id
 h2-20020ad45442000000b005dd8b9345e0sm1332899qvt.120.2023.04.07.06.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Apr 2023 06:37:03 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 0/2] vdpa_sim_blk: support shared backend
Date: Fri,  7 Apr 2023 15:36:56 +0200
Message-Id: <20230407133658.66339-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Eugenio=20P=C3=A9rez=20Martin?= <eperezma@redhat.com>
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

VGhpcyBzZXJpZXMgaXMgbWFpbmx5IGZvciB0ZXN0aW5nIGxpdmUgbWlncmF0aW9uIGJldHdlZW4g
MiB2ZHBhX3NpbV9ibGsKZGV2aWNlcy4KClRoZSBmaXJzdCBwYXRjaCBpcyBwcmVwYXJhdGlvbiBh
bmQgbW92ZXMgdGhlIGJ1ZmZlciBhbGxvY2F0aW9uIGludG8gZGV2aWNlcywKdGhlIHNlY29uZCBw
YXRjaCBhZGRzIHRoZSBgc2hhcmVkX2J1ZmZlcl9tdXRleGAgcGFyYW1ldGVyIHRvIHZkcGFfc2lt
X2JsayB0bwp1c2UgdGhlIHNhbWUgcmFtZGlzayBmb3IgYWxsIGRldmljZXMuCgpUZXN0ZWQgd2l0
aCBRRU1VIHY4LjAuMC1yYzIgaW4gdGhpcyB3YXk6Cgptb2Rwcm9iZSB2aG9zdF92ZHBhCm1vZHBy
b2JlIHZkcGFfc2ltX2JsayBzaGFyZWRfYmFja2VuZD10cnVlCgp2ZHBhIGRldiBhZGQgbWdtdGRl
diB2ZHBhc2ltX2JsayBuYW1lIGJsazAKdmRwYSBkZXYgYWRkIG1nbXRkZXYgdmRwYXNpbV9ibGsg
bmFtZSBibGsxCgpxZW11LXN5c3RlbS14ODZfNjQgLW0gNTEyTSAtc21wIDIgLU0gcTM1LGFjY2Vs
PWt2bSxtZW1vcnktYmFja2VuZD1tZW0gXAogwqAtb2JqZWN0IG1lbW9yeS1iYWNrZW5kLWZpbGUs
c2hhcmU9b24saWQ9bWVtLHNpemU9IjUxMk0iLG1lbS1wYXRoPSIvZGV2L3NobSIKIMKgLi4uCiDC
oC1ibG9ja2RldiBub2RlLW5hbWU9ZHJpdmVfc3JjMSxkcml2ZXI9dmlydGlvLWJsay12aG9zdC12
ZHBhLHBhdGg9L2Rldi92aG9zdC12ZHBhLTEsY2FjaGUuZGlyZWN0PW9uIFwKIMKgLWRldmljZSB2
aXJ0aW8tYmxrLXBjaSxpZD1zcmMxLGJvb3RpbmRleD0yLGRyaXZlPWRyaXZlX3NyYzEgXAogIC1p
bmNvbWluZyB0Y3A6MDozMzMzCgpxZW11LXN5c3RlbS14ODZfNjQgLW0gNTEyTSAtc21wIDIgLU0g
cTM1LGFjY2VsPWt2bSxtZW1vcnktYmFja2VuZD1tZW0gXAogIC1vYmplY3QgbWVtb3J5LWJhY2tl
bmQtZmlsZSxzaGFyZT1vbixpZD1tZW0sc2l6ZT0iNTEyTSIsbWVtLXBhdGg9Ii9kZXYvc2htIgog
IC4uLgogIC1ibG9ja2RldiBub2RlLW5hbWU9ZHJpdmVfc3JjMSxkcml2ZXI9dmlydGlvLWJsay12
aG9zdC12ZHBhLHBhdGg9L2Rldi92aG9zdC12ZHBhLTAsY2FjaGUuZGlyZWN0PW9uIFwKICAtZGV2
aWNlIHZpcnRpby1ibGstcGNpLGlkPXNyYzEsYm9vdGluZGV4PTIsZHJpdmU9ZHJpdmVfc3JjMQoK
KHFlbXUpIG1pZ3JhdGUgLWQgdGNwOjA6MzMzMwoKU3RlZmFubyBHYXJ6YXJlbGxhICgyKToKICB2
ZHBhX3NpbTogbW92ZSBidWZmZXIgYWxsb2NhdGlvbiBpbiB0aGUgZGV2aWNlcwogIHZkcGFfc2lt
X2Jsazogc3VwcG9ydCBzaGFyZWQgYmFja2VuZAoKIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBh
X3NpbS5oICAgICB8ICAzICstCiBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyAgICAg
fCAgNyArLS0KIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYyB8IDgzICsrKysr
KysrKysrKysrKysrKysrKysrKystLS0KIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9u
ZXQuYyB8IDI4ICsrKysrKystLS0KIDQgZmlsZXMgY2hhbmdlZCwgMTAwIGluc2VydGlvbnMoKyks
IDIxIGRlbGV0aW9ucygtKQoKLS0gCjIuMzkuMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
