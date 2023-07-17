Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB13EB64DD
	for <virtualization@archiver.kernel.org>; Mon, 17 Jul 2023 01:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ECD54400D0;
	Mon, 17 Jul 2023 01:49:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ECD54400D0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NqUEog+D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m8D-EYN4D5qw; Mon, 17 Jul 2023 01:49:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8C40B4086E;
	Mon, 17 Jul 2023 01:49:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C40B4086E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5ACBEC0071;
	Mon, 17 Jul 2023 01:49:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92B30C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jul 2023 01:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 562F740600
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jul 2023 01:49:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 562F740600
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NqUEog+D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jx-WTO_4-Xfz
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jul 2023 01:49:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5159740524
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5159740524
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jul 2023 01:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689558543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BhSII6RyRCcd/I61R6d6Q8X5ErH4c8gthtxPgCym0Po=;
 b=NqUEog+DrvJmKTdYMmMY/tdoaCtbKJHEz2jfeo+0YKUlirVe5DQhHPMWU+PD2a1Uiv9EDJ
 UOAOX6xwLTBdPkFJYTfoLLvN8Y2X6twHZirMJzA1u8xqOBZw4CRapECH4fG+7RTEheoWKr
 fXpyQ0SpcuheNMsrFUzcoqNnd0nPQcM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-v4criuC5PRSmgsoT3b54Bw-1; Sun, 16 Jul 2023 21:49:02 -0400
X-MC-Unique: v4criuC5PRSmgsoT3b54Bw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b6cf671d94so32396751fa.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Jul 2023 18:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689558541; x=1692150541;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BhSII6RyRCcd/I61R6d6Q8X5ErH4c8gthtxPgCym0Po=;
 b=go7LiBCEgnjfNUWU7VVtpW5BwUg1FRV2LcjVS7AW/FL7TatVNf/dhDlRtJLLd+7Yov
 wAKJ9gctPLjkJUrvIcWK2n3RUfR7SXxaa7t/eD8zeUvEl4hMFXvmOsROcb1QaKPbwllb
 dUdoNpDAH7ERl90P0GsDxarsynTYlbATsUAxfWNjsGDcKVYVJ9McTqshIW3aiJV4G4ks
 GIEA64yb9q5MjSW/ORqP/vCNQDgOEI0ch+L6uSf0Qm3XItKniCRKEVlK9OIv0xEkhBqv
 luyiUILMBLPmFiDeps0HvqedUBQPGLDvFCevKnkct9s+sPlltEbwoIzPELEn2V4zWIPc
 fNSA==
X-Gm-Message-State: ABy/qLbeBrM10x/0JMryIC26fz5kB35kqsoo7l+jG+RUW1oPt7RpG6FC
 3RlzfvDR0/H6ENaOQ2rmqxjhBglpEeTOreNiVrbdiNbtUGeGyx5GWlxFn2yL7vDC38kXrRR4fr4
 Mtcn5Bcy43+rw7mQZiQGC2bQXtB1Z+mFDf12kk7oASOjlX2KquGyAOXySlA==
X-Received: by 2002:a2e:6a13:0:b0:2b1:d588:a1a5 with SMTP id
 f19-20020a2e6a13000000b002b1d588a1a5mr6689289ljc.52.1689558540961; 
 Sun, 16 Jul 2023 18:49:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFWocObjF3MWICvo89P8kfNKjQeyqzHmP/YvTqwdRALteEMa9uwNHBnN/KURVUsuMLaSSH4X8GeR8wrVesEQKU=
X-Received: by 2002:a2e:6a13:0:b0:2b1:d588:a1a5 with SMTP id
 f19-20020a2e6a13000000b002b1d588a1a5mr6689281ljc.52.1689558540660; Sun, 16
 Jul 2023 18:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230715142027.5572-1-michael.christie@oracle.com>
In-Reply-To: <20230715142027.5572-1-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jul 2023 09:48:49 +0800
Message-ID: <CACGkMEv48L5zATNtVkR8c3MAvj9rZ3aqZB972se6dtkGKa94Tg@mail.gmail.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: add vhost-scsi entry and myself as a
 co-maintainer
To: Mike Christie <michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: pbonzini@redhat.com, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, mst@redhat.com
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

T24gU2F0LCBKdWwgMTUsIDIwMjMgYXQgMTA6MjDigK9QTSBNaWtlIENocmlzdGllCjxtaWNoYWVs
LmNocmlzdGllQG9yYWNsZS5jb20+IHdyb3RlOgo+Cj4gSSd2ZSBiZWVuIGRvaW5nIGEgbG90IG9m
IHRoZSBkZXZlbG9wbWVudCBvbiB2aG9zdC1zY3NpIHRoZSBsYXN0IGNvdXBsZSBvZgo+IHllYXJz
LCBzbyBwZXIgTWljaGFlbCBUJ3Mgc3VnZ2VzdGlvbiB0aGlzIGFkZHMgbWUgYXMgY28tbWFpbnRh
aW5lci4KPgo+IFNpZ25lZC1vZmYtYnk6IE1pa2UgQ2hyaXN0aWUgPG1pY2hhZWwuY2hyaXN0aWVA
b3JhY2xlLmNvbT4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoK
VGhhbmtzCgo+IC0tLQo+ICBNQUlOVEFJTkVSUyB8IDExICsrKysrKysrKystCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
TUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUwo+IGluZGV4IDNiZTFiZGZlOGVjYy4uMmM0YThhODYw
YWUwIDEwMDY0NAo+IC0tLSBhL01BSU5UQUlORVJTCj4gKysrIGIvTUFJTlRBSU5FUlMKPiBAQCAt
MjI0NTgsNyArMjI0NTgsNiBAQCBMOiAgICAgIHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCj4gIFM6ICAgICBNYWludGFpbmVkCj4gIEY6ICAgICBkcml2ZXJzL2Jsb2Nr
L3ZpcnRpb19ibGsuYwo+ICBGOiAgICAgZHJpdmVycy9zY3NpL3ZpcnRpb19zY3NpLmMKPiAtRjog
ICAgIGRyaXZlcnMvdmhvc3Qvc2NzaS5jCj4gIEY6ICAgICBpbmNsdWRlL3VhcGkvbGludXgvdmly
dGlvX2Jsay5oCj4gIEY6ICAgICBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3Njc2kuaAo+Cj4g
QEAgLTIyNTU3LDYgKzIyNTU2LDE2IEBAIEY6ICAgICBpbmNsdWRlL2xpbnV4L3Zob3N0X2lvdGxi
LmgKPiAgRjogICAgIGluY2x1ZGUvdWFwaS9saW51eC92aG9zdC5oCj4gIEY6ICAgICBrZXJuZWwv
dmhvc3RfdGFzay5jCj4KPiArVklSVElPIEhPU1QgKFZIT1NULVNDU0kpCj4gK006ICAgICAiTWlj
aGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+Cj4gK006ICAgICBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPgo+ICtNOiAgICAgTWlrZSBDaHJpc3RpZSA8bWljaGFlbC5jaHJp
c3RpZUBvcmFjbGUuY29tPgo+ICtSOiAgICAgUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0
LmNvbT4KPiArUjogICAgIFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KPiAr
TDogICAgIHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4gK1M6ICAg
ICBNYWludGFpbmVkCj4gK0Y6ICAgICBkcml2ZXJzL3Zob3N0L3Njc2kuYwo+ICsKPiAgVklSVElP
IEkyQyBEUklWRVIKPiAgTTogICAgIENvbmdodWkgQ2hlbiA8Y29uZ2h1aS5jaGVuQGludGVsLmNv
bT4KPiAgTTogICAgIFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+Cj4gLS0K
PiAyLjM0LjEKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
