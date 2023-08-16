Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43387C0015E
	for <virtualization@archiver.kernel.org>; Wed, 16 Aug 2023 03:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E656F41508;
	Wed, 16 Aug 2023 03:02:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E656F41508
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZkTARX10
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ritmahbN_Je7; Wed, 16 Aug 2023 03:02:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8BC87400C6;
	Wed, 16 Aug 2023 03:02:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8BC87400C6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D620C0072;
	Wed, 16 Aug 2023 03:02:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABBCDC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 03:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A858400C6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 03:02:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7A858400C6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bXA7Va2bFhJZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 03:02:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B4FFF41508
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 03:02:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B4FFF41508
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692154973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LcFVA2nCdKKYGmq34judjgdk23/81L6bmK0qNCyshhY=;
 b=ZkTARX10V1xzBmVSdxO9ZDl+/C6LvbpFMHPewpkCZFwHZfhLPjTBQdlx+SvysE996JGHTD
 YkmFWtGS/xtWBtfYNxhTBaNlufpeYmHfiGKNglQIQCfl/EhgK3P2brRMC389DgtDxA3WmM
 Iwzb7PFSOM1uga7YUl73FFE/EegeFl8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-RNZwGtcbMMinMunS9jfN_g-1; Tue, 15 Aug 2023 23:02:52 -0400
X-MC-Unique: RNZwGtcbMMinMunS9jfN_g-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b9fa64dba8so60233401fa.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 20:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692154970; x=1692759770;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LcFVA2nCdKKYGmq34judjgdk23/81L6bmK0qNCyshhY=;
 b=VXR/4s0w645mjVrO2weZO22m32iSE82bG4qN4ncrWSXRR3H+LqAkdNtQ10vxHW1gF6
 FKQyzgaCoa2IbZbhqUij9jnCcyw4pwtHIZX/3TG855hdBNc9y0OSuU4doio4++Rgruln
 LbLbbvc1YRCBtClhb4yIYtKP9ZnzA9Ip5pL3Ip16V+dAEbTHTRJ23F/bBoecNoJ31YXN
 ynjRuJjucSqFL/kH6ENgz+o7/HQPWdIAwAFdv2hK5Whzksv0h2R+ijbG0keqm6JRuXP2
 LtkFqa+fGd+OfkNM/V+YnAUY2yZB9BfT61tpMFMgF+363sUO9WXsFet1ok+mxfVMRZda
 qJvg==
X-Gm-Message-State: AOJu0Yxukv7UyTf6AtC5STJ/KBkdmRiYPNPMFAbDvwlhPSFA4yDARtC9
 ycy2gSF+SZ2watQ/84bFD/k+V0dW6NeI3Xtcb3uIL0WHEE5kylAOt9qrYmgyzwMoxK7OMxkKbhl
 PObW4qxthQiJ4KTE2rVWvZV6ESFS1FX2jpPsHuC2J6Z8xao89ip5+DjUgpQ==
X-Received: by 2002:a2e:8814:0:b0:2b9:4b2b:89d8 with SMTP id
 x20-20020a2e8814000000b002b94b2b89d8mr440963ljh.35.1692154970506; 
 Tue, 15 Aug 2023 20:02:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0nerfHH/tVlMsNPUjH9G3l6KwWiMRn8jUMdqKfEH2bBbtkorV2iB+yCO2UR+wYiUzHgmCo9E47+7OzL0KX1o=
X-Received: by 2002:a2e:8814:0:b0:2b9:4b2b:89d8 with SMTP id
 x20-20020a2e8814000000b002b94b2b89d8mr440953ljh.35.1692154970208; Tue, 15 Aug
 2023 20:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230815083321.533688-1-dtatulea@nvidia.com>
In-Reply-To: <20230815083321.533688-1-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Aug 2023 11:02:39 +0800
Message-ID: <CACGkMEtt55e4Bk9C6dE-jztqhstgR3oi0NiBmOmQpp8hSq+08Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as mlx5_vdpa driver
To: Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
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

T24gVHVlLCBBdWcgMTUsIDIwMjMgYXQgNDozM+KAr1BNIERyYWdvcyBUYXR1bGVhIDxkdGF0dWxl
YUBudmlkaWEuY29tPiB3cm90ZToKPgo+IEFzIEVsaSBDb2hlbiBtb3ZlZCB0byBvdGhlciB3b3Jr
LCBJJ2xsIGJlIHRoZSBjb250YWN0IHBvaW50IGZvcgo+IG1seDVfdmRwYS4KPgo+IFNpZ25lZC1v
ZmYtYnk6IERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEuY29tPgoKQWNrZWQtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4gLS0tCj4gIE1BSU5UQUlO
RVJTIHwgNiArKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQo+Cj4gZGlm
ZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMKPiBpbmRleCA5YTU4NjNmMWIwMTYu
LmM5YTkyNTlmNGQzNyAxMDA2NDQKPiAtLS0gYS9NQUlOVEFJTkVSUwo+ICsrKyBiL01BSU5UQUlO
RVJTCj4gQEAgLTEzNTU1LDYgKzEzNTU1LDEyIEBAIEY6ICAgICBEb2N1bWVudGF0aW9uL2xlZHMv
bGVkcy1tbHhjcGxkLnJzdAo+ICBGOiAgICAgZHJpdmVycy9sZWRzL2xlZHMtbWx4Y3BsZC5jCj4g
IEY6ICAgICBkcml2ZXJzL2xlZHMvbGVkcy1tbHhyZWcuYwo+Cj4gK01FTExBTk9YIE1MWDVfVkRQ
QSBEUklWRVIKPiArTTogICAgIERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEuY29tPgo+
ICtMOiAgICAgdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPiArUzog
ICAgIFN1cHBvcnRlZAo+ICtGOiAgICAgZHJpdmVycy92ZHBhL21seDUvCj4gKwo+ICBNRUxMQU5P
WCBQTEFURk9STSBEUklWRVIKPiAgTTogICAgIFZhZGltIFBhc3Rlcm5hayA8dmFkaW1wQG52aWRp
YS5jb20+Cj4gIEw6ICAgICBwbGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2VybmVsLm9yZwo+IC0t
Cj4gMi40MS4wCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
