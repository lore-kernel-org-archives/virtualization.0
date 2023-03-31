Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B31C76196
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 09:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8887041FEB;
	Fri, 31 Mar 2023 09:18:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8887041FEB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yl7wUrum
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2q-D3BSgxmyV; Fri, 31 Mar 2023 09:18:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 35FDE41FE2;
	Fri, 31 Mar 2023 09:18:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 35FDE41FE2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12C4DC0036;
	Fri, 31 Mar 2023 09:18:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0226C002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 09:18:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8CCAA41BF0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 09:18:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8CCAA41BF0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yl7wUrum
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N7NDhZxUw76M
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 09:18:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B342641BE6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B342641BE6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 09:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680254317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NjF7kg5QmZ1/qJ69Al0S1LwU0awEPb7/otJ5sPvHIVM=;
 b=Yl7wUrumcW14cnJrDdhoMa7ritqV9DYboJ3f9wIjugD37OaRW1UydcNiLIHJC7owNxV0pu
 H+MhA/O+2qMZ7MSmS/G4AyxfYvjQ+pnZ4jUxY93lDQFEoBHg1wPd9OYvcPqfFQpx5Yk7Kw
 zGfGREzk18XvVzBHAv+sh5A9itPJWeA=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-kq5zmUPkN1qMhjZTtrMQIA-1; Fri, 31 Mar 2023 05:18:36 -0400
X-MC-Unique: kq5zmUPkN1qMhjZTtrMQIA-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-1777dadbde5so11108773fac.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 02:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680254315; x=1682846315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NjF7kg5QmZ1/qJ69Al0S1LwU0awEPb7/otJ5sPvHIVM=;
 b=63aoDuAHFKQoRx2Cud1c7sZi8diriH08HX2bCA5bPPmfx9maLhfo1oFecayVywocOP
 zkDE0ncEWbLkPgxhj2+Ce2WLTFD/d2X7qOVUu+50bexB0PxQwuqXjvnU8zZ5G87wkUjD
 1i6acDb/vvE/LGF+XTsLIHxhUa/mBxRHUjvvC5H8IMmH8v+LlrVElnJK2b6o86+TfR3a
 tgKIjI2uL9cqoEaAXAK4unbUnJEgNZGS5WiHxHuqWpC3dqyZ3SV7Wezd7KMe6SKBmhXl
 b5o0vRo/bC88Uhz6HwpZuKOyF8SnkPj4bzzULptv138XCbNqO/lYb7m5kOdIFXLaGrJ7
 uW4Q==
X-Gm-Message-State: AAQBX9dXQybWFjJ1JS0gsESWjIu15I/h0MbMpJrFGy0gVg8DrGpl4ylY
 UzafpPZitKjPqEkVFEQbh2fIU7bRbeuHWXQ8Gavut/Qwclb4ekjBcsjQsBYiRUzMko6QLt1q2wS
 ODfdxSsOuBPEL7S8ByGZwscpdF0tnazTyW8tk/CNRkDZ7KgolVqdYPUzsBw==
X-Received: by 2002:a05:6870:8310:b0:177:c2fb:8cec with SMTP id
 p16-20020a056870831000b00177c2fb8cecmr10256795oae.9.1680254315580; 
 Fri, 31 Mar 2023 02:18:35 -0700 (PDT)
X-Google-Smtp-Source: AK7set8h/g9cwwlFDEN3CpISOrlwRlyD8WoPl87WsZC7TGG3Rc64PVQuD9PxGq42lxRD587X8v/3rvk9TjWgnzfbZZE=
X-Received: by 2002:a05:6870:8310:b0:177:c2fb:8cec with SMTP id
 p16-20020a056870831000b00177c2fb8cecmr10256789oae.9.1680254315408; Fri, 31
 Mar 2023 02:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230331-vhost-fixes-v1-0-1f046e735b9e@kernel.org>
 <20230331-vhost-fixes-v1-3-1f046e735b9e@kernel.org>
In-Reply-To: <20230331-vhost-fixes-v1-3-1f046e735b9e@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 31 Mar 2023 17:18:24 +0800
Message-ID: <CACGkMEu-0=-Kfw28BfxTWSWZ2Dwov_0NJMOxbh4n-=e2RU2x7Q@mail.gmail.com>
Subject: Re: [PATCH vhost 3/3] MAINTAINERS: add vringh.h to Virtio Core and
 Net Drivers
To: Simon Horman <horms@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, Eli Cohen <elic@nvidia.com>
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

T24gRnJpLCBNYXIgMzEsIDIwMjMgYXQgNDo1OeKAr1BNIFNpbW9uIEhvcm1hbiA8aG9ybXNAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4KPiB2cmluZ2guaCBkb2Vzbid0IHNlZW0gdG8gYmVsb25nIHRvIGFu
eSBzZWN0aW9uIGluIE1BSU5UQUlORVJTLgo+IEFkZCBpdCB0byBWaXJ0aW8gQ29yZSBhbmQgTmV0
IERyaXZlcnMsIHdoaWNoIHNlZW1zIHRvIGJlIHRoZSBtb3N0Cj4gYXBwcm9wcmlhdGUgc2VjdGlv
biB0byBtZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9y
Zz4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+
IC0tLQo+ICBNQUlOVEFJTkVSUyB8IDEgKwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykKPgo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCj4gaW5kZXggOTEy
MDFjMmI4MTkwLi43Y2Y1NDgzMDJjNTYgMTAwNjQ0Cj4gLS0tIGEvTUFJTlRBSU5FUlMKPiArKysg
Yi9NQUlOVEFJTkVSUwo+IEBAIC0yMjA5NSw2ICsyMjA5NSw3IEBAIEY6ICAgICAgZHJpdmVycy92
ZHBhLwo+ICBGOiAgICAgZHJpdmVycy92aXJ0aW8vCj4gIEY6ICAgICBpbmNsdWRlL2xpbnV4L3Zk
cGEuaAo+ICBGOiAgICAgaW5jbHVkZS9saW51eC92aXJ0aW8qLmgKPiArRjogICAgIGluY2x1ZGUv
bGludXgvdnJpbmdoLmgKPiAgRjogICAgIGluY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fKi5oCj4g
IEY6ICAgICB0b29scy92aXJ0aW8vCj4KPgo+IC0tCj4gMi4zMC4yCj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
