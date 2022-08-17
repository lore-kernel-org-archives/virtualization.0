Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0284C2BB41
	for <virtualization@archiver.kernel.org>; Wed, 17 Aug 2022 10:38:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69E0A610A6;
	Wed, 17 Aug 2022 10:38:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 69E0A610A6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gozaqb0+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MhULRNRTIYWS; Wed, 17 Aug 2022 10:38:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC84E60AA5;
	Wed, 17 Aug 2022 10:38:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC84E60AA5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA114C0033;
	Wed, 17 Aug 2022 10:38:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12507C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 10:38:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D0241419CA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 10:38:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D0241419CA
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gozaqb0+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w-zvTVto8l6q
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 10:38:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D27814192B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D27814192B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 10:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660732729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SGf4yDWBy0MoLiNZXRg5kkyZxBFtMy9Dt/eWAs4QNsU=;
 b=gozaqb0+CprWEZaQ1pAWDB6YvvlaVI61n56/US08SaWuXp8VVTDWaKVVAn7QMPinzeewhH
 KGXBtL8Ye69w/Hen0ACenUYIXkb9LSlsiLuGLwGOrWp+mFrRkv9H/QVnq5TRw5xQwcxWs0
 v/7UGskTvy2Sq6gg97YT+PoG2if5ISc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-149-sWWHxemlNJ2LSWYYZ0K3ag-1; Wed, 17 Aug 2022 06:38:48 -0400
X-MC-Unique: sWWHxemlNJ2LSWYYZ0K3ag-1
Received: by mail-wm1-f69.google.com with SMTP id
 b16-20020a05600c4e1000b003a5a47762c3so6159486wmq.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 03:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=SGf4yDWBy0MoLiNZXRg5kkyZxBFtMy9Dt/eWAs4QNsU=;
 b=h1tmkexKjJfOCwTKwQNL2k2O9cbyVJqtP1msIeNYxPd1X45GVb00X/z/k3j8cy/a/N
 SKIGSJ3O5SCymkbcBLrJoCQzGWlEFInMntxhupbaeYnvgzkhUE5IpCLLIXmwhl9GoyDh
 5+GsFvXTXLJ49XxmpQRKqFPXYTeDCdqBQlBM1la7uSivjdjoBFK6sh5JDiFtNWnW9Xvz
 zJQvHsYb9urH/is9rNQd4pDQa8FRyFWJd2JkEpEX9Z5j/gU24Wx+f1IUhW/dyURVQQxb
 dyuz1r6G1luBAhnt5a+WB128wEPr4JkRZ1Wmca5NRs3pXagNlCjlD8IUiyzTBVgbY+P2
 8wUA==
X-Gm-Message-State: ACgBeo36VMFM5kUv5IcXoeRsJO7kW6sB8rj+PvfOvbSPRmVJPZylGTol
 IbxNfh3Bkrm4eLshYUL/bCWlp9LR1XcfTBm7NuyCGvPvcyP5U55v/jvV3YiwVBEwxcVv8pn+1Wk
 /9kXIcronjCcxmlgu+Y80gwDktWq3JUuj6/QKuic/xQ==
X-Received: by 2002:a05:600c:4f51:b0:3a3:478f:6d1c with SMTP id
 m17-20020a05600c4f5100b003a3478f6d1cmr1672732wmq.143.1660732726626; 
 Wed, 17 Aug 2022 03:38:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7dbhTPaz6ve0R5EtpfO+eiBgy3kuKD4ntpw1VnHcvDHghg9FaQouSYJkAbBGtbVE5hQUvDNQ==
X-Received: by 2002:a05:600c:4f51:b0:3a3:478f:6d1c with SMTP id
 m17-20020a05600c4f5100b003a3478f6d1cmr1672714wmq.143.1660732726372; 
 Wed, 17 Aug 2022 03:38:46 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b003a601707174sm1772072wmq.33.2022.08.17.03.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Aug 2022 03:38:45 -0700 (PDT)
Date: Wed, 17 Aug 2022 06:38:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: fixes
Message-ID: <20220817063842-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 andres@anarazel.de, linux@roeck-us.net
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA1NjgwMzViMDFjZmIxMDdhZjhkMmU0
YmQyZmI5YWVhMjJjZjViODY4OgoKICBMaW51eCA2LjAtcmMxICgyMDIyLTA4LTE0IDE1OjUwOjE4
IC0wNzAwKQoKYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6CgogIGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21zdC92aG9zdC5naXQg
dGFncy9mb3JfbGludXMKCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA1YzY2OWM0YTRj
NmFhMDQ4OTg0ODA5M2M5M2I4MDI5ZjVjNWM3NWVjOgoKICB2aXJ0aW86IGtlcm5lbGRvY3MgZml4
ZXMgYW5kIGVuaGFuY2VtZW50cyAoMjAyMi0wOC0xNiAwMTo0MDoyNCAtMDQwMCkKCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
dmlydGlvOiBmaXhlcwoKTW9zdCBub3RhYmx5IHRoaXMgZHJvcHMgdGhlIGNvbW1pdHMgdGhhdCB0
cmlwIHVwIGdvb2dsZSBjbG91ZAoodHVybnMgb3V0LCBpdCdzIGFueSBsZWdhY3kgZGV2aWNlKS4K
UGx1cyBhIGtlcm5lbGRvYyBwYXRjaC4KClNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtp
biA8bXN0QHJlZGhhdC5jb20+CgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCk1pY2hhZWwgUy4gVHNpcmtpbiAoNik6CiAgICAg
IHZpcnRpb19uZXQ6IFJldmVydCAidmlydGlvX25ldDogc2V0IHRoZSBkZWZhdWx0IG1heCByaW5n
IHNpemUgYnkgZmluZF92cXMoKSIKICAgICAgdmlydGlvOiBSZXZlcnQgInZpcnRpbzogYWRkIGhl
bHBlciB2aXJ0aW9fZmluZF92cXNfY3R4X3NpemUoKSIKICAgICAgdmlydGlvLW1taW86IFJldmVy
dCAidmlydGlvX21taW86IHN1cHBvcnQgdGhlIGFyZyBzaXplcyBvZiBmaW5kX3ZxcygpIgogICAg
ICB2aXJ0aW9fcGNpOiBSZXZlcnQgInZpcnRpb19wY2k6IHN1cHBvcnQgdGhlIGFyZyBzaXplcyBv
ZiBmaW5kX3ZxcygpIgogICAgICB2aXJ0aW9fdmRwYTogUmV2ZXJ0ICJ2aXJ0aW9fdmRwYTogc3Vw
cG9ydCB0aGUgYXJnIHNpemVzIG9mIGZpbmRfdnFzKCkiCiAgICAgIHZpcnRpbzogUmV2ZXJ0ICJ2
aXJ0aW86IGZpbmRfdnFzKCkgYWRkIGFyZyBzaXplcyIKClJpY2FyZG8gQ2HDsXVlbG8gKDEpOgog
ICAgICB2aXJ0aW86IGtlcm5lbGRvY3MgZml4ZXMgYW5kIGVuaGFuY2VtZW50cwoKIGFyY2gvdW0v
ZHJpdmVycy92aXJ0aW9fdW1sLmMgICAgICAgICAgICAgfCAgMiArLQogZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jICAgICAgICAgICAgICAgICB8IDQyICsrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCiBkcml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJmLXRtZmlmby5jIHwgIDEgLQog
ZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfdmlydGlvLmMgICB8ICAxIC0KIGRyaXZlcnMv
czM5MC92aXJ0aW8vdmlydGlvX2Njdy5jICAgICAgICAgfCAgMSAtCiBkcml2ZXJzL3ZpcnRpby92
aXJ0aW9fbW1pby5jICAgICAgICAgICAgIHwgIDkgKystLS0tLQogZHJpdmVycy92aXJ0aW8vdmly
dGlvX3BjaV9jb21tb24uYyAgICAgICB8IDIwICsrKysrKystLS0tLS0tLQogZHJpdmVycy92aXJ0
aW8vdmlydGlvX3BjaV9jb21tb24uaCAgICAgICB8ICAzICstLQogZHJpdmVycy92aXJ0aW8vdmly
dGlvX3BjaV9sZWdhY3kuYyAgICAgICB8ICA2ICstLS0tCiBkcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cGNpX21vZGVybi5jICAgICAgIHwgMTcgKysrKy0tLS0tLS0tLQogZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYyAgICAgICAgICAgICB8ICA4ICsrKysrKwogZHJpdmVycy92aXJ0aW8vdmlydGlv
X3ZkcGEuYyAgICAgICAgICAgICB8IDE2ICsrKysrLS0tLS0tLQogaW5jbHVkZS9saW51eC92aXJ0
aW8uaCAgICAgICAgICAgICAgICAgICB8ICA2ICsrLS0tCiBpbmNsdWRlL2xpbnV4L3ZpcnRpb19j
b25maWcuaCAgICAgICAgICAgIHwgMzIgKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tCiBpbmNsdWRl
L3VhcGkvbGludXgvdmlydGlvX3JpbmcuaCAgICAgICAgIHwgMTYgKysrKysrKystLS0tCiAxNSBm
aWxlcyBjaGFuZ2VkLCA1OSBpbnNlcnRpb25zKCspLCAxMjEgZGVsZXRpb25zKC0pCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
