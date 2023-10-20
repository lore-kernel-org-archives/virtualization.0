Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2DDCDB474
	for <virtualization@archiver.kernel.org>; Fri, 20 Oct 2023 06:57:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85ED98478E;
	Fri, 20 Oct 2023 06:57:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 85ED98478E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cqMbBLDF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PacIc7w37klj; Fri, 20 Oct 2023 06:57:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1C55A84467;
	Fri, 20 Oct 2023 06:57:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C55A84467
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05E9EC0071;
	Fri, 20 Oct 2023 06:57:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B407AC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:57:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 82FB284792
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:57:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82FB284792
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8eu-TeebUXbA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:57:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4B428478E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:57:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4B428478E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697785043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cHQSIwEZHQWP+tSXUJE+jHEMURynrqRjJWGru8ceQos=;
 b=cqMbBLDFJj4w/WihtcVeL0sgR/I5+umpAtXpy/nM7dSY9W+TznjXpzzOBg/0zAHWGVQlhJ
 1L9GVBOMIZbW4Lw0enRMslhNTSBkATvYicC8KZxEUEW+9fTaMCeKFXLufz8jNvPeQ9KB11
 fkDU54h+iEWx4snJbYXYk+FXowiydw8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-oMM4LXhLM5CDMzlOWrkblw-1; Fri, 20 Oct 2023 02:57:22 -0400
X-MC-Unique: oMM4LXhLM5CDMzlOWrkblw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507bd5f4b2dso422381e87.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 23:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697785041; x=1698389841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cHQSIwEZHQWP+tSXUJE+jHEMURynrqRjJWGru8ceQos=;
 b=cD6PZUWESNRvOOLBd4cLuJfZWbHHAezjs/9HVd1Cu0m4WR8a4T6xkYyrM/YkS1j0to
 HsMpZbqIBqRvjKcP1BEpJg8BwcSv0ya8XugjN1fQLzv0trenIXY/imG9XHzAdUwiaA0Q
 UjUBk8IZjrDHFEzgzysJeor0aSpvRTHGOUFcqZKk+iQq3QxH2p23Px6mAXhrmzaQ/nfz
 3Z+NqCYXbQL+P2CYcx/VzBcWLPfa13e04qhHcz2X73tbIFqk1odJrMSJNtR/c09UuhJh
 tJveORqZflqeWRO+W2k2Pm0+W4o+8KBUpt4CURMNmTUyAXRtvf2av1ykT9H3ESCNCY7L
 ykKg==
X-Gm-Message-State: AOJu0YwGEygMmw/Lk8qCTt4mIpY1PhAdoZtOs/T8JY9rChl4beXEoCMB
 QsEflAUGsqW1RtMvgN+D1cU8VMhkup7b5cHrEGmzcildfIaAYcrWkdY/xvl+NLPJcWpglQQhLe0
 hStxQs0mRyI3ArIac4epvwFR53k3yjwf+ADvH83/OzRGjj20XHA900VovVCxSZ5f63+CP
X-Received: by 2002:ac2:58ca:0:b0:507:9a32:fd89 with SMTP id
 u10-20020ac258ca000000b005079a32fd89mr578135lfo.44.1697785040993; 
 Thu, 19 Oct 2023 23:57:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDIndMynMMz19N4vsFZpfGiNEUT/sYvsBfrXutsJMURgpn/F07AOz8Z/xOPZDI3cmdYmWj8ognG4ckObJf4HU=
X-Received: by 2002:ac2:58ca:0:b0:507:9a32:fd89 with SMTP id
 u10-20020ac258ca000000b005079a32fd89mr578128lfo.44.1697785040764; Thu, 19 Oct
 2023 23:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-19-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-19-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 14:57:10 +0800
Message-ID: <CACGkMEurBykMNNxf2XYe_dUpBLrUwuUupjzhJQL-b9di7moMGQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 18/19] virtio_net: update tx timeout record
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

T24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgODowMeKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gSWYgc2VuZCBxdWV1ZSBzZW50IHNvbWUgcGFja2V0
cywgd2UgdXBkYXRlIHRoZSB0eCB0aW1lb3V0Cj4gcmVjb3JkIHRvIHByZXZlbnQgdGhlIHR4IHRp
bWVvdXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJh
YmEuY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFu
a3MKCgo+IC0tLQo+ICBkcml2ZXJzL25ldC92aXJ0aW8veHNrLmMgfCAxMCArKysrKysrKysrCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvdmlydGlvL3hzay5jIGIvZHJpdmVycy9uZXQvdmlydGlvL3hzay5jCj4gaW5kZXggZjFj
NjQ0MTRmYWM5Li41ZDNkZTUwNWM1NmMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlv
L3hzay5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvL3hzay5jCj4gQEAgLTI3NCw2ICsyNzQs
MTYgQEAgYm9vbCB2aXJ0bmV0X3hza194bWl0KHN0cnVjdCB2aXJ0bmV0X3NxICpzcSwgc3RydWN0
IHhza19idWZmX3Bvb2wgKnBvb2wsCj4KPiAgICAgICAgIHZpcnRuZXRfeHNrX2NoZWNrX3F1ZXVl
KHNxKTsKPgo+ICsgICAgICAgaWYgKHN0YXRzLnBhY2tldHMpIHsKPiArICAgICAgICAgICAgICAg
c3RydWN0IG5ldGRldl9xdWV1ZSAqdHhxOwo+ICsgICAgICAgICAgICAgICBzdHJ1Y3QgdmlydG5l
dF9pbmZvICp2aTsKPiArCj4gKyAgICAgICAgICAgICAgIHZpID0gc3EtPnZxLT52ZGV2LT5wcml2
Owo+ICsKPiArICAgICAgICAgICAgICAgdHhxID0gbmV0ZGV2X2dldF90eF9xdWV1ZSh2aS0+ZGV2
LCBzcSAtIHZpLT5zcSk7Cj4gKyAgICAgICAgICAgICAgIHR4cV90cmFuc19jb25kX3VwZGF0ZSh0
eHEpOwo+ICsgICAgICAgfQo+ICsKPiAgICAgICAgIHU2NF9zdGF0c191cGRhdGVfYmVnaW4oJnNx
LT5zdGF0cy5zeW5jcCk7Cj4gICAgICAgICBzcS0+c3RhdHMucGFja2V0cyArPSBzdGF0cy5wYWNr
ZXRzOwo+ICAgICAgICAgc3EtPnN0YXRzLmJ5dGVzICs9IHN0YXRzLmJ5dGVzOwo+IC0tCj4gMi4z
Mi4wLjMuZzAxMTk1Y2Y5Zgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
