Return-Path: <SRS0=Wmx8=KA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D16C433B4
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 04:38:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 733BC6112D
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 04:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733BC6112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10B5240615;
	Wed,  5 May 2021 04:38:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oNZY3z7_f0w9; Wed,  5 May 2021 04:38:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75B1F40613;
	Wed,  5 May 2021 04:38:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39D8BC000E;
	Wed,  5 May 2021 04:38:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDBFFC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 04:38:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D416C607FC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 04:38:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dp-hjeRGMoit
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 04:38:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 097B3607F5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 04:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620189508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6yVNxWj/wGGOgYdtthMPoI7mCPnyJvOQocx3yTI0Fvg=;
 b=RstdNb0YI5jiiCY5ZzPm5k/ka7NKfNUra/X8lTv6ycbVjKR8EON49NwpFwBc8FF/lD10V1
 S0V7bWA79aA/tXMl5tCfVpxLjyC2tBP2QQhD+hPWLzL/WKPyDH7RTzitT1pLPv43uSj7Em
 R8TAkaWs19KveLdDVfnaR8Tkw3FENag=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-kQkPfuBGN7GHqGk9NakKUg-1; Wed, 05 May 2021 00:38:27 -0400
X-MC-Unique: kQkPfuBGN7GHqGk9NakKUg-1
Received: by mail-wm1-f72.google.com with SMTP id
 n9-20020a1c40090000b02901401bf40f9dso1141587wma.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 May 2021 21:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=6yVNxWj/wGGOgYdtthMPoI7mCPnyJvOQocx3yTI0Fvg=;
 b=LPv54fhMkyaM1/ygSV4KUnBWHHgJbuD/NaMDQIsHi1dP9i9eELTQ/yBgAl13c3ApSa
 WJV8cBAVDlfZiyUGeQu54jIxvp6SpMgMTlFh5fHbuinNbxdMwNk10p9bFa4AghZpIS60
 unhBInxQjWGb/lVEJz+cv88DetSJhrwZwOp2HqGc0nvK5074OhFfMkJUz9HrSvOoxhCM
 Yfhdosd6lI7pmfiVSVZegJSHZShDxP8Yh7IlSaAuTZZXXkmMBZJLHYZVnfyZrNlSgHgM
 vaGa6qm3X1W/FnPjQ8HRR7Jkg45lQa/sgOrMmKQqv8MoFmeovevGn9wy5jF3EyaweU8C
 myGg==
X-Gm-Message-State: AOAM5315mwaL26V4/MYhpmhqpQ57LwQz+JA2Y7YA4l8PfZ8EXQsEArPE
 C7P0DklanKHkP2sFAiZelV75IM+tQdtHRNPopn8CpcmDoB4pP+LFcooBEcz+XuSJSGN3tkEgKwZ
 sZd2tmxIiBEbdDcitGT186EfRN/CljvFyLB0vdaDl4A==
X-Received: by 2002:a1c:a914:: with SMTP id s20mr7739707wme.106.1620189505927; 
 Tue, 04 May 2021 21:38:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5TxS+BmZuvt5WiviH50Lclf5Xxsj1NDlf/f/RBKa/5VjATFVo470ooq0Cl7f/rAtcAI0oUA==
X-Received: by 2002:a1c:a914:: with SMTP id s20mr7739697wme.106.1620189505774; 
 Tue, 04 May 2021 21:38:25 -0700 (PDT)
Received: from redhat.com ([2a10:800c:8fce:0:8e1b:40f0:6a74:513b])
 by smtp.gmail.com with ESMTPSA id f8sm4449512wmc.8.2021.05.04.21.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 May 2021 21:38:24 -0700 (PDT)
Date: Wed, 5 May 2021 00:38:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: virtio_net: Almost a second until link becomes ready
Message-ID: <20210505003117-mutt-send-email-mst@kernel.org>
References: <f4e3a841-ebc4-3f6d-928a-5d81a3ab3f31@molgen.mpg.de>
MIME-Version: 1.0
In-Reply-To: <f4e3a841-ebc4-3f6d-928a-5d81a3ab3f31@molgen.mpg.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

T24gVHVlLCBNYXkgMDQsIDIwMjEgYXQgMDg6MDQ6NTBQTSArMDIwMCwgUGF1bCBNZW56ZWwgd3Jv
dGU6Cj4gRGVhciBWaXJ0SU8gbmV0IGRyaXZlciBmb2xrcywKPiAKPiAKPiBJIHdvdWxkIGxpa2Ug
dG8gc3RhcnQgdGhlIHZpZGVvIGNvbmZlcmVuY2luZyBzb2Z0d2FyZSBKaXRzaSBpbiBhIFFFTVUv
S1ZNIFZNCj4gYXMgcXVpY2tseSBhcyBwb3NzaWJsZS4KPiAKPiBgYGAKPiAkIHFlbXUtc3lzdGVt
LXg4Nl82NCAtLXZlcnNpb24KPiBRRU1VIGVtdWxhdG9yIHZlcnNpb24gNS4xLjAKPiBDb3B5cmln
aHQgKGMpIDIwMDMtMjAyMCBGYWJyaWNlIEJlbGxhcmQgYW5kIHRoZSBRRU1VIFByb2plY3QgZGV2
ZWxvcGVycwo+ICQgcWVtdS1zeXN0ZW0teDg2XzY0IC1lbmFibGUta3ZtIC1uYW1lIGppdHNpIC1j
cHUgaG9zdCAtbSA4RyAtc21wIDEyIC1nbG9iYWwKPiB2aXJ0aW8tbmV0LXBjaS5yb21maWxlPSAt
ZGV2aWNlIHZpcnRpby1ybmctcGNpIC1ib290IG1lbnU9b2ZmIC1kcml2ZQo+IGZpbGU9aml0c2ku
MDAzLmRpc2ssZm9ybWF0PXFjb3cyLGlmPXZpcnRpbyAtbmljIHRhcCxpZm5hbWU9dGFwLmppdHNp
LHNjcmlwdD0vYmluL3RydWUsZG93bnNjcmlwdD0vYmluL3RydWUsbW9kZWw9dmlydGlvLW5ldC1w
Y2ksbWFjPTUyOmM2OjExOjAwOjAwOjE4Cj4gLXZuYyA6NjAgLWsgZGUgLXNlcmlhbCBub25lIC1j
aGFyZGV2Cj4gc29ja2V0LGlkPW1vbjEscGF0aD1tb24uc29ja2V0LHNlcnZlcixub3dhaXQgLWNo
YXJkZXYKPiBzb2NrZXQsaWQ9bW9uMixwYXRoPXFtcC5zb2NrZXQsc2VydmVyLG5vd2FpdCAtbW9u
IGNoYXJkZXY9bW9uMSxtb2RlPXJlYWRsaW5lCj4gLW1vbiBjaGFyZGV2PW1vbjIsbW9kZT1jb250
cm9sCj4gYGBgCj4gCj4gVGhlIChpbmFjY3VyYXRlKSBtZWFzdXJlbWVudCB3aXRoIGBzeXN0ZW1k
LWFuYWx5emUgY3JpdGljYWwtY2hhaW5gIHNob3dzCj4gdGhhdCBgc3lzdGVtZC1uZXR3b3JrLXdh
aXQtb25saW5lLnNlcnZpY2VgIHRha2VzIHNvbWUgdGltZS4KPiAKPiAgICAgICAgICAg4pSU4pSA
c3lzdGVtZC1uZXR3b3JrZC13YWl0LW9ubGluZS5zZXJ2aWNlIEAxNTltcyArMi44NzFzCj4gCj4g
TGludXggbG9nczoKPiAKPiAgICAgWyAgICAxLjA1ODI1M10gdmlydGlvX25ldCB2aXJ0aW8wIGVu
czM6IHJlbmFtZWQgZnJvbSBldGgwCj4gICAgIFvigKZdCj4gICAgIFsgICAgMS4xMDMxNjVdIElQ
djY6IEFERFJDT05GKE5FVERFVl9VUCk6IGVuczM6IGxpbmsgaXMgbm90IHJlYWR5Cj4gICAgIFvi
gKZdCj4gICAgIFsgICAgMi4wNDQ5NDddIElQdjY6IEFERFJDT05GKE5FVERFVl9DSEFOR0UpOiBl
bnMzOiBsaW5rIGJlY29tZXMgcmVhZHkKPiAKCgpJJ20gbm90IHN1cmUgd2hhdCBpcyBnb2luZyBv
biBoZXJlOiBhIGxvc3QgY29uZmlnIGludGVycnVwdD8Kc3lzdGVtZCBmb3JjaW5nIGxpbmsgZG93
biB0aGVuIHVwIGZvciBpdHMgb3duIHJlYXNvbnM/CkJ1dCBhIHBvc3NpYmxlIHdvcmthcm91bmQg
aXMKdG8gYWRkIHN0YXR1cz1vZmYgdG8gdGhlIHZpcnRpbyBuZXQgZGV2aWNlIHRvIGZvcmNlIGxp
bmsgdG8gYWx3YXlzCmJlIHVwLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
