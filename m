Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4A4EE49A8
	for <virtualization@archiver.kernel.org>; Mon, 21 Aug 2023 04:01:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E05B341528;
	Mon, 21 Aug 2023 04:01:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E05B341528
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JyCXcx93
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SUxreIZZdwjx; Mon, 21 Aug 2023 04:01:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1DF9F40953;
	Mon, 21 Aug 2023 04:01:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1DF9F40953
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01C30C0071;
	Mon, 21 Aug 2023 04:01:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED4B4C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 04:01:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B582C61088
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 04:01:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B582C61088
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JyCXcx93
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QCjrvdEpnEd0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 04:01:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5CD0261087
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 04:01:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5CD0261087
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692590481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K48wOkgYX/+Fqd9BgiTgVDDaxoT43hfwzWV+z1KABwU=;
 b=JyCXcx93L0muey169p6wxVR/ULBVvfjwd82E2ClVObH6cjoTUZBhxzYxwzHxRxbaHpOX94
 T8f9+rXWLjOwFTHeQ8bRawITNDZtcWWSDsAx/7nQTiAHm/Ofy3yWmHKOwhN24cypzzMETS
 txCM9zm8bpblw0dc60klANMxhZclDak=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-zOwmxk5sNwq6Av3WzQYpmQ-1; Mon, 21 Aug 2023 00:01:19 -0400
X-MC-Unique: zOwmxk5sNwq6Av3WzQYpmQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2bcb2990ba0so10435531fa.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Aug 2023 21:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692590477; x=1693195277;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K48wOkgYX/+Fqd9BgiTgVDDaxoT43hfwzWV+z1KABwU=;
 b=UST/W8bbkRzB4Nwkaeq/u/ukF6D/niuy1vDM8c3Olxe0NOD794Rf0/K0kAC/HQaqJx
 VabZ/U3aHXDjz8wT83pcmdh6rkUzCBhCgilWrAXVRNBlIcOb2U5dxlHF64PoNkvikdkM
 5Imx5UK9JRQ5zEDsXzJ406bV6/vUjtSyRbPlfC1B2+iCRhfwD+GkULce657t/j/QJAZA
 Ughw77daFO/PZTVL/1ywg/JcjDddfxLK2smP5qDicQ+VTjH7CjwiBWbOhedeZL6u+Pnm
 rtNTRQsMdCU6OsbIWSAdLPt3Xb6/uvEtSa+Z0m7acGRZpLDsKYZzhy6UUqxuMbm4Rdjn
 iV8Q==
X-Gm-Message-State: AOJu0YxfWTBo7R5cY7Fm4cR1qQN0uqTZoAPYoYfHWXuM2Tr8MDJH6pV3
 bhCemJFma8FshC+uIesoXzLUI4IcNJTeMZGWu3URvwbWY7fFHI0aqKEYok/bWr/7tU27RVqMiS7
 tx2sdcSLOpUQKD5Gx0+7JZX68jZHh4D65y9pXkaBHUsgC66Y2x+vu7261vg==
X-Received: by 2002:a2e:8283:0:b0:2bb:94e4:49f with SMTP id
 y3-20020a2e8283000000b002bb94e4049fmr3352792ljg.32.1692590477706; 
 Sun, 20 Aug 2023 21:01:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBNlrj9YNsjazLmKSqxb2YYKFRv5ifZ125cg5mmpZIBasDNsmvkUajlOqWzEspqb9PqDMdZu+/Nh/IbMwo2yM=
X-Received: by 2002:a2e:8283:0:b0:2bb:94e4:49f with SMTP id
 y3-20020a2e8283000000b002bb94e4049fmr3352775ljg.32.1692590477420; Sun, 20 Aug
 2023 21:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230821011535.1117-1-shawn.shao@jaguarmicro.com>
In-Reply-To: <20230821011535.1117-1-shawn.shao@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Aug 2023 12:01:06 +0800
Message-ID: <CACGkMEukZTMdaBvUOD_FSW+Lxb6N9rfEEcSQ1Xv1UWcedJeWvQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Update sysfs ABI documentation
To: "Shawn.Shao" <shawn.shao@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, lege.wang@jaguarmicro.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

T24gTW9uLCBBdWcgMjEsIDIwMjMgYXQgOToxNuKAr0FNIFNoYXduLlNoYW8gPHNoYXduLnNoYW9A
amFndWFybWljcm8uY29tPiB3cm90ZToKPgo+IEZpeCB0aGUgd3JvbmcgZHJpdmVyc19hdXRvcHJv
YmUgcGF0aCBuYW1lIGluIHRoZSBkb2N1bWVudAo+Cj4gU2lnbmVkLW9mZi1ieTogU2hhd24uU2hh
byA8c2hhd24uc2hhb0BqYWd1YXJtaWNyby5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPiAtLS0KPiAgRG9jdW1lbnRhdGlvbi9BQkkvdGVz
dGluZy9zeXNmcy1idXMtdmRwYSB8IDQgKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vQUJJ
L3Rlc3Rpbmcvc3lzZnMtYnVzLXZkcGEgYi9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2Zz
LWJ1cy12ZHBhCj4gaW5kZXggMjhhNjExMTIwMmJhLi40ZGE1Mzg3OGJmZjYgMTAwNjQ0Cj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtdmRwYQo+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtYnVzLXZkcGEKPiBAQCAtMSw0ICsxLDQgQEAKPiAt
V2hhdDogICAgICAgICAgL3N5cy9idXMvdmRwYS9kcml2ZXJfYXV0b3Byb2JlCj4gK1doYXQ6ICAg
ICAgICAgIC9zeXMvYnVzL3ZkcGEvZHJpdmVyc19hdXRvcHJvYmUKPiAgRGF0ZTogICAgICAgICAg
TWFyY2ggMjAyMAo+ICBDb250YWN0OiAgICAgICB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwo+ICBEZXNjcmlwdGlvbjoKPiBAQCAtMTcsNyArMTcsNyBAQCBEZXNjcmlw
dGlvbjoKPiAgICAgICAgICAgICAgICAgV3JpdGluZyBhIGRldmljZSBuYW1lIHRvIHRoaXMgZmls
ZSB3aWxsIGNhdXNlIHRoZSBrZXJuZWwgYmluZHMKPiAgICAgICAgICAgICAgICAgZGV2aWNlcyB0
byBhIGNvbXBhdGlibGUgZHJpdmVyLgo+Cj4gLSAgICAgICAgICAgICAgIFRoaXMgY2FuIGJlIHVz
ZWZ1bCB3aGVuIC9zeXMvYnVzL3ZkcGEvZHJpdmVyX2F1dG9wcm9iZSBpcwo+ICsgICAgICAgICAg
ICAgICBUaGlzIGNhbiBiZSB1c2VmdWwgd2hlbiAvc3lzL2J1cy92ZHBhL2RyaXZlcnNfYXV0b3By
b2JlIGlzCj4gICAgICAgICAgICAgICAgIGRpc2FibGVkLgo+Cj4gIFdoYXQ6ICAgICAgICAgIC9z
eXMvYnVzL3ZkcGEvZHJpdmVycy8uLi4vYmluZAo+IC0tCj4gMi4zNC4xCj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
