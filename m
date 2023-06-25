Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734CDEB64DC
	for <virtualization@archiver.kernel.org>; Sun, 25 Jun 2023 07:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EAA7E40154;
	Sun, 25 Jun 2023 07:09:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EAA7E40154
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UWvrf0yX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nkK3OUW3xU09; Sun, 25 Jun 2023 07:09:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9918C400D2;
	Sun, 25 Jun 2023 07:09:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9918C400D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BD6EC0037;
	Sun, 25 Jun 2023 07:09:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B391C0029
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 07:09:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4F19B81971
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 07:09:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F19B81971
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UWvrf0yX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BmWZmh6xe1-p
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 07:09:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44E82818EC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44E82818EC
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 07:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687676979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YbYPIjkR3XyYE7RueUh8/3QvrSdR3D1Go2rsedUr3Z4=;
 b=UWvrf0yXKSbWq+CydkcTEH1C+PyN5GIir5hj+XowQCKBb5rDLI4OyI190jIdmj5WPoS9Sc
 jdSCe+FZ7nj/mZptFgF9+mIR8ehwwGg9Pk5KMHHumOQfmxQfxxy25I2GJYb4m5pNJm69or
 C/fbcvGrsJu1L+6yH3eoFVNgUcDaESQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-3HwSaB5QO9Wg5Le-wEqjgg-1; Sun, 25 Jun 2023 03:09:38 -0400
X-MC-Unique: 3HwSaB5QO9Wg5Le-wEqjgg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f8757ca7c6so1718899e87.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 00:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687676976; x=1690268976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YbYPIjkR3XyYE7RueUh8/3QvrSdR3D1Go2rsedUr3Z4=;
 b=W/1FqJwl2zvm8y/73MP11JSE7vMrI1dTBnoeMsL0v3LN2Qoc6ugrl5VDUWPOIkMjFR
 ky30UKpA6Tc6sdz9PoPxnh+GseY/WuBBG4JTYakI9kWtFhBMXIzbuM0JgHd2xuQrZw9E
 uOmuf8R+z7mjN9iKfKM4zz/T86/xeqkyOC3W1dDEEMfGjGgpeNHpd1MxkdIf0bkAc5aF
 fdE3KxYyFwISbslLki7GzxTXQzgxcOMUHJn+/a0ck8yP7fXEJJxQep2keOy65Es9C+7j
 z7IEH8Puk9XIaRTLfEHjYfAkpfAZBlI/FjgqCC0fZmspCeJK8Y9oXykWzEN8QxQXhPDX
 +TGw==
X-Gm-Message-State: AC+VfDwe3IRuaHhBwmscSChhYTy2h8OdTpPowyP2Idiu+ykZTI/J/ACz
 vsrIbekQKZgXq5q2nytabe3jwXE2b28lDA2bDEwvtt0yNPE0CMEvZfgWwF9P/SAuBtS6u/115FR
 qFWtBiXARApj+ow5bp8x5FGVMSYJ3yQIUUIM7B83y3//y8LmBSDFdE/X+1w==
X-Received: by 2002:a19:8c14:0:b0:4f8:7333:d1fd with SMTP id
 o20-20020a198c14000000b004f87333d1fdmr11221952lfd.34.1687676976585; 
 Sun, 25 Jun 2023 00:09:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4iCpsy8J97MsvZhIh4Vr0xVedBNb3evsSFHyVeolxdYqrf2lfu5rzZT1HgQUgv/7X0z5JP9Aoj9/QtPPgYvzM=
X-Received: by 2002:a19:8c14:0:b0:4f8:7333:d1fd with SMTP id
 o20-20020a198c14000000b004f87333d1fdmr11221945lfd.34.1687676976263; Sun, 25
 Jun 2023 00:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230622204851.318125-1-maxime.coquelin@redhat.com>
In-Reply-To: <20230622204851.318125-1-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 25 Jun 2023 15:09:25 +0800
Message-ID: <CACGkMEuEHroKkBa4ccRKAyPR6E1-5AtjjABXicAOuyJtkYO6sw@mail.gmail.com>
Subject: Re: [PATCH v2] vduse: fix NULL pointer dereference
To: Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, sheng.zhao@bytedance.com
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

T24gRnJpLCBKdW4gMjMsIDIwMjMgYXQgNDo0OeKAr0FNIE1heGltZSBDb3F1ZWxpbgo8bWF4aW1l
LmNvcXVlbGluQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gdmR1c2VfdmRwYV9zZXRfdnFfYWZmaW5p
dHkgY2FsbGJhY2sgY2FuIGJlIGNhbGxlZAo+IHdpdGggTlVMTCB2YWx1ZSBhcyBjcHVfbWFzayB3
aGVuIGRlbGV0aW5nIHRoZSB2ZHVzZQo+IGRldmljZS4KPgo+IFRoaXMgcGF0Y2ggcmVzZXRzIHZp
cnRxdWV1ZSdzIElSUSBhZmZpbml0eSBtYXNrIHZhbHVlCj4gdG8gc2V0IGFsbCBDUFVzIGluc3Rl
YWQgb2YgZGVyZWZlcmVuY2luZyBOVUxMIGNwdV9tYXNrLgo+Cj4gWyA0NzYwLjk1MjE0OV0gQlVH
OiBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAw
MDAwCj4gWyA0NzYwLjk1OTExMF0gI1BGOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNzIGluIGtlcm5l
bCBtb2RlCj4gWyA0NzYwLjk2NDI0N10gI1BGOiBlcnJvcl9jb2RlKDB4MDAwMCkgLSBub3QtcHJl
c2VudCBwYWdlCj4gWyA0NzYwLjk2OTM4NV0gUEdEIDAgUDREIDAKPiBbIDQ3NjAuOTcxOTI3XSBP
b3BzOiAwMDAwIFsjMV0gUFJFRU1QVCBTTVAgUFRJCj4gWyA0NzYwLjk3NjExMl0gQ1BVOiAxMyBQ
SUQ6IDIzNDYgQ29tbTogdmRwYSBOb3QgdGFpbnRlZCA2LjQuMC1yYzYrICM0Cj4gWyA0NzYwLjk4
MjI5MV0gSGFyZHdhcmUgbmFtZTogRGVsbCBJbmMuIFBvd2VyRWRnZSBSNjQwLzBXMjNIOCwgQklP
UyAyLjguMSAwNi8yNi8yMDIwCj4gWyA0NzYwLjk4OTc2OV0gUklQOiAwMDEwOm1lbWNweV9vcmln
KzB4YzUvMHgxMzAKPiBbIDQ3NjAuOTk0MDQ5XSBDb2RlOiAxNiBmOCA0YyA4OSAwNyA0YyA4OSA0
ZiAwOCA0YyA4OSA1NCAxNyBmMCA0YyA4OSA1YyAxNyBmOCBjMyBjYyBjYyBjYyBjYyA2NiA2NiAy
ZSAwZiAxZiA4NCAwMCAwMCAwMCAwMCAwMCA2NiA5MCA4MyBmYSAwOCA3MiAxYiA8NGM+IDhiIDA2
IDRjIDhiIDRjIDE2IGY4IDRjIDg5IDA3IDRjIDg5IDRjIDE3IGY4IGMzIGNjIGNjIGNjIGNjIDY2
Cj4gWyA0NzYxLjAxMjc5M10gUlNQOiAwMDE4OmZmZmZiMWQ1NjVhYmI4MzAgRUZMQUdTOiAwMDAx
MDI0Ngo+IFsgNDc2MS4wMTgwMjBdIFJBWDogZmZmZjlmNGJmNmIyNzg5OCBSQlg6IGZmZmY5ZjRi
ZTIzOTY5YzAgUkNYOiBmZmZmOWY0YmNhZGY2NDAwCj4gWyA0NzYxLjAyNTE1Ml0gUkRYOiAwMDAw
MDAwMDAwMDAwMDA4IFJTSTogMDAwMDAwMDAwMDAwMDAwMCBSREk6IGZmZmY5ZjRiZjZiMjc4OTgK
PiBbIDQ3NjEuMDMyMjg2XSBSQlA6IDAwMDAwMDAwMDAwMDAwMDAgUjA4OiAwMDAwMDAwMDAwMDAw
MDA4IFIwOTogMDAwMDAwMDAwMDAwMDAwMAo+IFsgNDc2MS4wMzk0MTZdIFIxMDogMDAwMDAwMDAw
MDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAwMDA2MDAgUjEyOiAwMDAwMDAwMDAwMDAwMDAwCj4gWyA0
NzYxLjA0NjU0OV0gUjEzOiAwMDAwMDAwMDAwMDAwMDAwIFIxNDogMDAwMDAwMDAwMDAwMDA4MCBS
MTU6IGZmZmZiMWQ1NjVhYmJiMTAKPiBbIDQ3NjEuMDUzNjgwXSBGUzogIDAwMDA3ZjY0YzJlYzI3
NDAoMDAwMCkgR1M6ZmZmZjlmNjM1Zjk4MDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAw
Cj4gWyA0NzYxLjA2MTc2NV0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAw
MDA4MDA1MDAzMwo+IFsgNDc2MS4wNjc1MTNdIENSMjogMDAwMDAwMDAwMDAwMDAwMCBDUjM6IDAw
MDAwMDE4NzUyNzAwMDYgQ1I0OiAwMDAwMDAwMDAwNzcwNmUwCj4gWyA0NzYxLjA3NDY0NV0gRFIw
OiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAw
MDAwMDAKPiBbIDQ3NjEuMDgxNzc1XSBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAw
MGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMAo+IFsgNDc2MS4wODg5MDldIFBLUlU6IDU1
NTU1NTU0Cj4gWyA0NzYxLjA5MTYyMF0gQ2FsbCBUcmFjZToKPiBbIDQ3NjEuMDk0MDc0XSAgPFRB
U0s+Cj4gWyA0NzYxLjA5NjE4MF0gID8gX19kaWUrMHgxZi8weDcwCj4gWyA0NzYxLjA5OTIzOF0g
ID8gcGFnZV9mYXVsdF9vb3BzKzB4MTcxLzB4NGYwCj4gWyA0NzYxLjEwMzM0MF0gID8gZXhjX3Bh
Z2VfZmF1bHQrMHg3Yi8weDE4MAo+IFsgNDc2MS4xMDcyNjVdICA/IGFzbV9leGNfcGFnZV9mYXVs
dCsweDIyLzB4MzAKPiBbIDQ3NjEuMTExNDYwXSAgPyBtZW1jcHlfb3JpZysweGM1LzB4MTMwCj4g
WyA0NzYxLjExNTEyNl0gIHZkdXNlX3ZkcGFfc2V0X3ZxX2FmZmluaXR5KzB4M2UvMHg1MCBbdmR1
c2VdCj4gWyA0NzYxLjEyMDUzM10gIHZpcnRuZXRfY2xlYW5fYWZmaW5pdHkucGFydC4wKzB4M2Qv
MHg5MCBbdmlydGlvX25ldF0KPiBbIDQ3NjEuMTI2NjM1XSAgcmVtb3ZlX3ZxX2NvbW1vbisweDFh
NC8weDI1MCBbdmlydGlvX25ldF0KPiBbIDQ3NjEuMTMxNzgxXSAgdmlydG5ldF9yZW1vdmUrMHg1
ZC8weDcwIFt2aXJ0aW9fbmV0XQo+IFsgNDc2MS4xMzY1ODBdICB2aXJ0aW9fZGV2X3JlbW92ZSsw
eDNhLzB4OTAKPiBbIDQ3NjEuMTQwNTA5XSAgZGV2aWNlX3JlbGVhc2VfZHJpdmVyX2ludGVybmFs
KzB4MTliLzB4MjAwCj4gWyA0NzYxLjE0NTc0Ml0gIGJ1c19yZW1vdmVfZGV2aWNlKzB4YzIvMHgx
MzAKPiBbIDQ3NjEuMTQ5NzU1XSAgZGV2aWNlX2RlbCsweDE1OC8weDNlMAo+IFsgNDc2MS4xNTMy
NDVdICA/IGtlcm5mc19maW5kX25zKzB4MzUvMHhjMAo+IFsgNDc2MS4xNTcwODZdICBkZXZpY2Vf
dW5yZWdpc3RlcisweDEzLzB4NjAKPiBbIDQ3NjEuMTYxMDEwXSAgdW5yZWdpc3Rlcl92aXJ0aW9f
ZGV2aWNlKzB4MTEvMHgyMAo+IFsgNDc2MS4xNjU1NDNdICBkZXZpY2VfcmVsZWFzZV9kcml2ZXJf
aW50ZXJuYWwrMHgxOWIvMHgyMDAKPiBbIDQ3NjEuMTcwNzcwXSAgYnVzX3JlbW92ZV9kZXZpY2Ur
MHhjMi8weDEzMAo+IFsgNDc2MS4xNzQ3ODJdICBkZXZpY2VfZGVsKzB4MTU4LzB4M2UwCj4gWyA0
NzYxLjE3ODI3Nl0gID8gX19wZnhfdmRwYV9uYW1lX21hdGNoKzB4MTAvMHgxMCBbdmRwYV0KPiBb
IDQ3NjEuMTgzMzM2XSAgZGV2aWNlX3VucmVnaXN0ZXIrMHgxMy8weDYwCj4gWyA0NzYxLjE4NzI2
MF0gIHZkcGFfbmxfY21kX2Rldl9kZWxfc2V0X2RvaXQrMHg2My8weGUwIFt2ZHBhXQo+Cj4gRml4
ZXM6IDI4ZjYyODhlYjYzZCAoInZkdXNlOiBTdXBwb3J0IHNldF92cV9hZmZpbml0eSBjYWxsYmFj
ayIpCj4gQ2M6IHhpZXlvbmdqaUBieXRlZGFuY2UuY29tCj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXhp
bWUgQ29xdWVsaW4gPG1heGltZS5jb3F1ZWxpbkByZWRoYXQuY29tPgoKQWNrZWQtYnk6IEphc29u
IFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4gLS0tCj4gIGRyaXZlcnMvdmRw
YS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMgfCA2ICsrKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBh
L3ZkcGFfdXNlci92ZHVzZV9kZXYuYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2
LmMKPiBpbmRleCA1ZjVjMjE2NzRmZGMuLjBkODRlNmE5YzNjYyAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFf
dXNlci92ZHVzZV9kZXYuYwo+IEBAIC03MjYsNyArNzI2LDExIEBAIHN0YXRpYyBpbnQgdmR1c2Vf
dmRwYV9zZXRfdnFfYWZmaW5pdHkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1MTYgaWR4LAo+
ICB7Cj4gICAgICAgICBzdHJ1Y3QgdmR1c2VfZGV2ICpkZXYgPSB2ZHBhX3RvX3ZkdXNlKHZkcGEp
Owo+Cj4gLSAgICAgICBjcHVtYXNrX2NvcHkoJmRldi0+dnFzW2lkeF0tPmlycV9hZmZpbml0eSwg
Y3B1X21hc2spOwo+ICsgICAgICAgaWYgKGNwdV9tYXNrKQo+ICsgICAgICAgICAgICAgICBjcHVt
YXNrX2NvcHkoJmRldi0+dnFzW2lkeF0tPmlycV9hZmZpbml0eSwgY3B1X21hc2spOwo+ICsgICAg
ICAgZWxzZQo+ICsgICAgICAgICAgICAgICBjcHVtYXNrX3NldGFsbCgmZGV2LT52cXNbaWR4XS0+
aXJxX2FmZmluaXR5KTsKPiArCj4gICAgICAgICByZXR1cm4gMDsKPiAgfQo+Cj4gLS0KPiAyLjQx
LjAKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
