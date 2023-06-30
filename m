Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8914EB64D7
	for <virtualization@archiver.kernel.org>; Fri, 30 Jun 2023 08:02:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39B0B83518;
	Fri, 30 Jun 2023 08:02:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 39B0B83518
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WlMm6Tv5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AnqJwDuyvhDm; Fri, 30 Jun 2023 08:02:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C1B4681FE0;
	Fri, 30 Jun 2023 08:02:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C1B4681FE0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86024C0072;
	Fri, 30 Jun 2023 08:02:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04DB0C0037
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 08:02:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D390F81FEB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 08:02:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D390F81FEB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YTPCpWpBI6yZ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 08:02:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 05AD281FE0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 05AD281FE0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 08:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688112156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bEA6Seiw1hdOM5JV2jPU02HAiyKo01nOt8ftgnD9214=;
 b=WlMm6Tv54qAqoCzA20CkO9vMJvt/2rPoRfRTUV2bFoxnBhk+8xhjh3e9v/fJYSoOl5ABH1
 wWRyIl8jfvzPKHNiXxETduLqQi9JD5Aj8iL3PzRuJOA4sCycbpQc/tq6EJpPKJXAJnEAHH
 LbBC5nfsOVP5WzK/ERzDmdBi2gtFgek=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-bpnO8Q7OO7mD479CUikApQ-1; Fri, 30 Jun 2023 04:02:34 -0400
X-MC-Unique: bpnO8Q7OO7mD479CUikApQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b6a47b59a5so17875681fa.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 01:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688112153; x=1690704153;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bEA6Seiw1hdOM5JV2jPU02HAiyKo01nOt8ftgnD9214=;
 b=X618Nphy6mCnm5zQvzFarRU/1KEc3iuMWyStBwJ7YSSwGBQfqx0g9b9C2AqH142AQK
 hDbIGe2ZjyLf7gIEBOSXr8/qI5vEzn9t+R5mR31pgzMDQkA/C9yHZ7RBsOYbjP6mir25
 gWQN91wZr8oYHxfgQVqqeg2agUIMAMul2RbWST6lwbtLvJKxZXd+i6ZE+5kuT60kgbLO
 cNxKl71Z+HIWc3VOoc6KXeyVcs+fBmxMPff8W5vSrmFNij6g68BdriPdcRzOSCVQg7Zt
 ad/kfXAYtExpvxkPKkjN8WdceFQZe2sXEpGJVFNE5IKmtUsKc66C2JlPhF4FXvgr1KRS
 +GbA==
X-Gm-Message-State: ABy/qLb1xIkOcQSgFWih21nKukhJr6Z7D8kPUmAECb+CTjUaEQjkq0PM
 JEf0Jc+cNtILPfOEA8yRnhqrNtb0LJYB9qpXPqq5bO1m7JEqpSW7C233yEvHlmgDajYuH79QU72
 S6MIM5364aCMmRPSN7u+UOLqFU0qpYvMbtdcWn5KHZMgWbqTqvxWGBZfYQg==
X-Received: by 2002:a05:651c:231:b0:2b6:a057:8098 with SMTP id
 z17-20020a05651c023100b002b6a0578098mr1412890ljn.0.1688112153253; 
 Fri, 30 Jun 2023 01:02:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGT88TJiZhJn/Ljx5RignUVdcoRW+uHj3ue4RBlYJq3byAtgh10LXjZ4dDeZ3YRMGakAbklUjbtNEXgZ8WcaXA=
X-Received: by 2002:a05:651c:231:b0:2b6:a057:8098 with SMTP id
 z17-20020a05651c023100b002b6a0578098mr1412876ljn.0.1688112152978; Fri, 30 Jun
 2023 01:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230630103656.345870-1-lingshan.zhu@intel.com>
In-Reply-To: <20230630103656.345870-1-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Jun 2023 16:02:22 +0800
Message-ID: <CACGkMEteNC5vKe5QUyhPaiBAoEKHzyMKc2W5MpzbzeVWBe0qWQ@mail.gmail.com>
Subject: Re: [PATCH] vp_vdpa: synchronize irq when free irq
To: Zhu Lingshan <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, Cindy Lu <lulu@redhat.com>,
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

T24gRnJpLCBKdW4gMzAsIDIwMjMgYXQgMTA6MzfigK9BTSBaaHUgTGluZ3NoYW4gPGxpbmdzaGFu
LnpodUBpbnRlbC5jb20+IHdyb3RlOgo+Cj4gVGhpcyBjb21taXRzIHN5bmNocm9uaXplcyBpcnFz
IHdoZW4gZnJlZSB0aGVtCgpOZWVkIHRvIGV4cGxhaW4gd2h5IGl0IGlzIG5lZWRlZC4KCj4KPiBT
aWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4gVGVz
dGVkLWJ5OiBDaW5keSBMdSA8bHVsdUByZWRoYXQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL3ZkcGEv
dmlydGlvX3BjaS92cF92ZHBhLmMgfCAyICsrCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMg
Yi9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMKPiBpbmRleCAyODEyODdmYWU4OWYu
LmQ4ZWUzZTY4Y2QyZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92
ZHBhLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMKPiBAQCAtMTE2
LDYgKzExNiw3IEBAIHN0YXRpYyB2b2lkIHZwX3ZkcGFfZnJlZV9pcnEoc3RydWN0IHZwX3ZkcGEg
KnZwX3ZkcGEpCj4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgdnBfdmRwYS0+cXVldWVzOyBpKysp
IHsKPiAgICAgICAgICAgICAgICAgaWYgKHZwX3ZkcGEtPnZyaW5nW2ldLmlycSAhPSBWSVJUSU9f
TVNJX05PX1ZFQ1RPUikgewo+ICAgICAgICAgICAgICAgICAgICAgICAgIHZwX21vZGVybl9xdWV1
ZV92ZWN0b3IobWRldiwgaSwgVklSVElPX01TSV9OT19WRUNUT1IpOwo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHN5bmNocm9uaXplX2lycSh2cF92ZHBhLT52cmluZ1tpXS5pcnEpOwoKSW50ZXJl
c3RpbmdseSwgd2UgZG9uJ3QgZG8gdGhpcyBpbiB2aXJ0aW9fcGNpX2NvbW1vbi5jIGFuZCB3ZSBv
bmx5CnN5bmNocm9uaXplIGR1cmluZyByZXNldCB0aGVyZS4KCkFueSByZWFzb24gbWFrZXMgdnBf
dmRwYSBkaWZmZXJlbnQ/CgpUaGFua3MKCj4gICAgICAgICAgICAgICAgICAgICAgICAgZGV2bV9m
cmVlX2lycSgmcGRldi0+ZGV2LCB2cF92ZHBhLT52cmluZ1tpXS5pcnEsCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAmdnBfdmRwYS0+dnJpbmdbaV0pOwo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIHZwX3ZkcGEtPnZyaW5nW2ldLmlycSA9IFZJUlRJT19NU0lfTk9fVkVD
VE9SOwo+IEBAIC0xMjQsNiArMTI1LDcgQEAgc3RhdGljIHZvaWQgdnBfdmRwYV9mcmVlX2lycShz
dHJ1Y3QgdnBfdmRwYSAqdnBfdmRwYSkKPgo+ICAgICAgICAgaWYgKHZwX3ZkcGEtPmNvbmZpZ19p
cnEgIT0gVklSVElPX01TSV9OT19WRUNUT1IpIHsKPiAgICAgICAgICAgICAgICAgdnBfbW9kZXJu
X2NvbmZpZ192ZWN0b3IobWRldiwgVklSVElPX01TSV9OT19WRUNUT1IpOwo+ICsgICAgICAgICAg
ICAgICBzeW5jaHJvbml6ZV9pcnEodnBfdmRwYS0+Y29uZmlnX2lycSk7Cj4gICAgICAgICAgICAg
ICAgIGRldm1fZnJlZV9pcnEoJnBkZXYtPmRldiwgdnBfdmRwYS0+Y29uZmlnX2lycSwgdnBfdmRw
YSk7Cj4gICAgICAgICAgICAgICAgIHZwX3ZkcGEtPmNvbmZpZ19pcnEgPSBWSVJUSU9fTVNJX05P
X1ZFQ1RPUjsKPiAgICAgICAgIH0KPiAtLQo+IDIuMzkuMwo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
