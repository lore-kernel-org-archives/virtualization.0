Return-Path: <SRS0=+9Ss=O5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EEFC433FE
	for <virtualization@archiver.kernel.org>; Sat,  9 Oct 2021 09:18:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA8B660F4B
	for <virtualization@archiver.kernel.org>; Sat,  9 Oct 2021 09:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA8B660F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C62F6069F;
	Sat,  9 Oct 2021 09:18:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cPU1IUdee8yb; Sat,  9 Oct 2021 09:18:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 22F20606B3;
	Sat,  9 Oct 2021 09:18:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F036AC000F;
	Sat,  9 Oct 2021 09:18:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D5E1C000D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 09:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E27334066C
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 09:18:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p8JZLJaRsoXr
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 09:18:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D406440669
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 09:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633771083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2UwzU/Hl4oyLBnA1BVpvqm3h7gRDiFiszHCb/NTENEE=;
 b=NeQIzLRZG8Ci6Wyi5PTHTSFZzkUnvMOM3qh7K4TpBZz/aOX1l95yYszilRTMEl7bBYsuRv
 hZcHjziBnigJjhYKa9b+McH1OGDr28GcQkpu8izAXfFy1OjTxsMESzOwv7SknAFBNL4YK0
 uaMBVc/MQKE+4jQhSWt2mt1rw/2K5X8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-OsroG-qLONiadKVOvGKg1A-1; Sat, 09 Oct 2021 05:18:01 -0400
X-MC-Unique: OsroG-qLONiadKVOvGKg1A-1
Received: by mail-ed1-f72.google.com with SMTP id
 z23-20020aa7cf97000000b003db7be405e1so458649edx.13
 for <virtualization@lists.linux-foundation.org>;
 Sat, 09 Oct 2021 02:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=2UwzU/Hl4oyLBnA1BVpvqm3h7gRDiFiszHCb/NTENEE=;
 b=FWNFAlITtOR8WeDAKGRjk9h3fl7k8nr/40PkCNH4Uj3MaH4mBEr+rcvzlX3EbPx8fZ
 MM26bHvERnyYb9yu1qS5uTGsNr7Ut62wqvVINznhHrXTxygWSYjHhOrPCBZ0Hz0yg13Z
 JEL7/39cIzS2AfxUSh08dc7Tvr8CRYR2rACFuF1jHQvGczqNb/hnzcdROpDaZoB1bdWe
 vXb7ZVSZ2ycfh+5nAgKyPdvVFmTv9ci8OXvrWqAcUT4OsT2QJbZZetTQXPzkZ4pksev5
 ppJCzBXeaS13Rk84AX+R5VPL4DGCPfr68fOxw3SOXJw5A/5pjtRQ3OVaWXA0Iaf6w3dQ
 5PTA==
X-Gm-Message-State: AOAM533eAoKfYUKlpaOci2DQ8YZj/FzaQGdKvAvIqYiNixOVE5dZD/rh
 Uj68NVaap/4dilg4tUf9KL1UmElD7vRrTju9mHQcKBlUmofUlz3YKyutR3DRE4qzWdqOFWlIEoI
 +e0zaoUdSmiUaMXHsBWBjibp20MnPtVSkkUgICc8axw==
X-Received: by 2002:a05:6402:5202:: with SMTP id
 s2mr15544697edd.67.1633771080215; 
 Sat, 09 Oct 2021 02:18:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGfmIQZR+1/PAQ0xIABJbC6CJzPRKYIoGKikbdWi9pwKm3KdMLPvApqQ8MIxMgBYddw5gdjQ==
X-Received: by 2002:a05:6402:5202:: with SMTP id
 s2mr15544541edd.67.1633771078558; 
 Sat, 09 Oct 2021 02:17:58 -0700 (PDT)
Received: from redhat.com ([2.55.132.170])
 by smtp.gmail.com with ESMTPSA id ck9sm722624ejb.56.2021.10.09.02.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Oct 2021 02:17:57 -0700 (PDT)
Date: Sat, 9 Oct 2021 05:17:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH net] virtio-net: fix for skb_over_panic inside big mode
Message-ID: <20211009091604.84141-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Corentin =?utf-8?B?Tm/Dq2w=?= <corentin.noel@collabora.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

RnJvbTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KCmNvbW1pdCAxMjYy
ODU2NTFiN2YgKCJNZXJnZSByYS5rZXJuZWwub3JnOi9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
bmV0ZGV2L25ldCIpCmFjY2lkZW50YWxseSByZXZlcnRlZCB0aGUgZWZmZWN0IG9mCmNvbW1pdCAx
YTgwMjQyMzlkYSAoInZpcnRpby1uZXQ6IGZpeCBmb3Igc2tiX292ZXJfcGFuaWMgaW5zaWRlIGJp
ZyBtb2RlIikKb24gZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCgpBcyBhIHJlc3VsdCwgdXNlcnMg
b2YgY3Jvc3ZtICh3aGljaCBpcyB1c2luZyBsYXJnZSBwYWNrZXQgbW9kZSkKYXJlIGV4cGVyaWVu
Y2luZyBjcmFzaGVzIHdpdGggNS4xNC1yYzEgYW5kIGFib3ZlIHRoYXQgZG8gbm90Cm9jY3VyIHdp
dGggNS4xMy4KCkNyYXNoIHRyYWNlOgoKWyAgIDYxLjM0NjY3N10gc2tidWZmOiBza2Jfb3Zlcl9w
YW5pYzogdGV4dDpmZmZmZmZmZjg4MWFlMmM3IGxlbjozNzYyIHB1dDozNzYyIGhlYWQ6ZmZmZjhh
NWVjOGMyMjAwMCBkYXRhOmZmZmY4YTVlYzhjMjIwMTAgdGFpbDoweGVjMiBlbmQ6MHhlYzAgZGV2
OjxOVUxMPgpbICAgNjEuMzY5MTkyXSBrZXJuZWwgQlVHIGF0IG5ldC9jb3JlL3NrYnVmZi5jOjEx
MSEKWyAgIDYxLjM3Mjg0MF0gaW52YWxpZCBvcGNvZGU6IDAwMDAgWyMxXSBTTVAgUFRJClsgICA2
MS4zNzQ4OTJdIENQVTogNSBQSUQ6IDAgQ29tbTogc3dhcHBlci81IE5vdCB0YWludGVkIDUuMTQu
MC1yYzEgbGludXgtdjUuMTQtcmMxLWZvci1tZXNhLWNpLnRhci5iejIgIzEKWyAgIDYxLjM3NjQ1
MF0gSGFyZHdhcmUgbmFtZTogQ2hyb21pdW1PUyBjcm9zdm0sIEJJT1MgMAoKLi4KClsgICA2MS4z
OTM2MzVdIENhbGwgVHJhY2U6ClsgICA2MS4zOTQxMjddICA8SVJRPgpbICAgNjEuMzk0NDg4XSAg
c2tiX3B1dC5jb2xkKzB4MTAvMHgxMApbICAgNjEuMzk1MDk1XSAgcGFnZV90b19za2IrMHhmNy8w
eDQxMApbICAgNjEuMzk1Njg5XSAgcmVjZWl2ZV9idWYrMHg4MS8weDE2NjAKWyAgIDYxLjM5NjIy
OF0gID8gbmV0aWZfcmVjZWl2ZV9za2JfbGlzdF9pbnRlcm5hbCsweDFhZC8weDJiMApbICAgNjEu
Mzk3MTgwXSAgPyBuYXBpX2dyb19mbHVzaCsweDk3LzB4ZTAKWyAgIDYxLjM5Nzg5Nl0gID8gZGV0
YWNoX2J1Zl9zcGxpdCsweDY3LzB4MTIwClsgICA2MS4zOTg1NzNdICB2aXJ0bmV0X3BvbGwrMHgy
Y2YvMHg0MjAKWyAgIDYxLjM5OTE5N10gIF9fbmFwaV9wb2xsKzB4MjUvMHgxNTAKWyAgIDYxLjM5
OTc2NF0gIG5ldF9yeF9hY3Rpb24rMHgyMmYvMHgyODAKWyAgIDYxLjQwMDM5NF0gIF9fZG9fc29m
dGlycSsweGJhLzB4MjU3ClsgICA2MS40MDEwMTJdICBpcnFfZXhpdF9yY3UrMHg4ZS8weGIwClsg
ICA2MS40MDE2MThdICBjb21tb25faW50ZXJydXB0KzB4N2IvMHhhMApbICAgNjEuNDAyMjcwXSAg
PC9JUlE+CgpTZWUKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci81ZWRhYTJiN2MyZmU0YWJkMDM0
N2I4NDU0YjJhYzAzMmI2Njk0ZTJjLmNhbWVsJTQwY29sbGFib3JhLmNvbQpmb3IgdGhlIHJlcG9y
dC4KCkFwcGx5IHRoZSBvcmlnaW5hbCAxYTgwMjQyMzlkYSAoInZpcnRpby1uZXQ6IGZpeCBmb3Ig
c2tiX292ZXJfcGFuaWMgaW5zaWRlIGJpZyBtb2RlIikKYWdhaW4sIHRoZSBvcmlnaW5hbCBsb2dp
YyBzdGlsbCBob2xkczoKCkluIHZpcnRpby1uZXQncyBsYXJnZSBwYWNrZXQgbW9kZSwgdGhlcmUg
aXMgYSBob2xlIGluIHRoZSBzcGFjZSBiZWhpbmQKYnVmLgoKICAgIGhkcl9wYWRkZWRfbGVuIC0g
aGRyX2xlbgoKV2UgbXVzdCB0YWtlIHRoaXMgaW50byBhY2NvdW50IHdoZW4gY2FsY3VsYXRpbmcg
dGFpbHJvb20uCgpDYzogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+CkZpeGVz
OiBmYjMyODU2YjE2YWQgKCJ2aXJ0aW8tbmV0OiBwYWdlX3RvX3NrYigpIHVzZSBidWlsZF9za2Ig
d2hlbiB0aGVyZSdzIHN1ZmZpY2llbnQgdGFpbHJvb20iKQpGaXhlczogMTI2Mjg1NjUxYjdmICgi
TWVyZ2UgcmEua2VybmVsLm9yZzovcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25ldGRldi9uZXQi
KQpTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgpS
ZXBvcnRlZC1ieTogQ29yZW50aW4gTm/Dq2wgPGNvcmVudGluLm5vZWxAY29sbGFib3JhLmNvbT4K
VGVzdGVkLWJ5OiBDb3JlbnRpbiBOb8OrbCA8Y29yZW50aW4ubm9lbEBjb2xsYWJvcmEuY29tPgpT
aWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgotLS0KCkRh
dmlkLCBJIHRoaW5rIHdlIG5lZWQgdGhpcyBpbiBzdGFibGUsIHRvby4KCiBkcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMKaW5kZXggMDk2YzJhYzZiN2E2Li42YjA4MTJmNDRiYmYgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYworKysgYi9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMKQEAgLTQwNiw3ICs0MDYsNyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnBhZ2VfdG9f
c2tiKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAogCSAqIGFkZF9yZWN2YnVmX21lcmdlYWJsZSgp
ICsgZ2V0X21lcmdlYWJsZV9idWZfbGVuKCkKIAkgKi8KIAl0cnVlc2l6ZSA9IGhlYWRyb29tID8g
UEFHRV9TSVpFIDogdHJ1ZXNpemU7Ci0JdGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxlbiAtIGhlYWRy
b29tOworCXRhaWxyb29tID0gdHJ1ZXNpemUgLSBsZW4gLSBoZWFkcm9vbSAtIChoZHJfcGFkZGVk
X2xlbiAtIGhkcl9sZW4pOwogCWJ1ZiA9IHAgLSBoZWFkcm9vbTsKIAogCWxlbiAtPSBoZHJfbGVu
OwotLSAKTVNUCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
