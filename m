Return-Path: <SRS0=XE2Y=MP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DD3C4338F
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 08:00:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A406560EFD
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 08:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A406560EFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C350600D1;
	Fri, 23 Jul 2021 08:00:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wq0Lc4UyEi9F; Fri, 23 Jul 2021 07:59:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 753F9600CA;
	Fri, 23 Jul 2021 07:59:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55C98C0010;
	Fri, 23 Jul 2021 07:59:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 047CEC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 07:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E060640151
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 07:59:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vkG3C5_ZgZCM
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 07:59:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 41A584012C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 07:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627027194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NPCcVR9Gydk1vTLrG0sQH6M++On46hKKveYJDVAmd2o=;
 b=R1GEjpD6601o+o5mF5kk9p1DC/5+8b0ohmDFcCq0QXtY2uzdicDC2ovbneo1z0rracao99
 PQUYLGFMOCGqMM3+QFyyOePug9bPl2OM49yZjjgfA5yAi2/iYegWtwdL1eo5UtD4EjqOLA
 tEtsfZODI5L8pI66K6As3nKy/LmcSpo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-Jd8QKBVxNkK07hLF1OxlHA-1; Fri, 23 Jul 2021 03:59:53 -0400
X-MC-Unique: Jd8QKBVxNkK07hLF1OxlHA-1
Received: by mail-ed1-f69.google.com with SMTP id
 c20-20020a0564021014b029039994f9cab9so278861edu.22
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 00:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=NPCcVR9Gydk1vTLrG0sQH6M++On46hKKveYJDVAmd2o=;
 b=qXNDBRWDDzEy1qnIUdwMp38XzbXaDM0RO6rE9keaQ64+Gf08StDhkQAO+EUdLPH+QQ
 sBiwWzmSMOUj8J3gNVd/o+5Nh8dCvgkNGK1giQa2hcShpyhsqITw06K72f55Itk1saP9
 kYqDldkAVSBEoMOJrgyzkn5qkdGdf4PmMUlfR/LXBVahNFB7hWT84eYOhCaIHdZI42Hp
 U2PWwwe5sJ30gXGZ2qbFHlLzXaOreJ5bRN9XV7pLkAtb8wO24rsEnyA20ve8WBotpAyz
 TC/IibLdvE/ry5nwupxKO4uDvHg71wzU020qAr2TQ/nI5IZk8VZj48NzZHeJvJ1ZTul/
 TNgw==
X-Gm-Message-State: AOAM530V9W+v5GTjhqdfNpPTiWEpW9x2z5+MWZYSCdmmwtrPHqpfR9/9
 S/+FgQ1VEFtloTz2vGJuxkLAcx+r4MsxBp86N5CmxM81/1+xy+AkPIZh+eySOp8JW0NZ6lUuQt/
 wHHGB1jRwknGj7vlLnaDkBZdPZj8jnDi1Y1QirffPQw==
X-Received: by 2002:a17:906:8618:: with SMTP id
 o24mr3614942ejx.175.1627027192256; 
 Fri, 23 Jul 2021 00:59:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymmMQBwebTVLtgzby/+mTOPvY3jotP7aaNi62ypt5oOWqtPIykX9/dG29yhH/N+NoVUwMbmQ==
X-Received: by 2002:a17:906:8618:: with SMTP id
 o24mr3614934ejx.175.1627027192074; 
 Fri, 23 Jul 2021 00:59:52 -0700 (PDT)
Received: from redhat.com ([2.55.16.196])
 by smtp.gmail.com with ESMTPSA id c28sm10292116ejc.102.2021.07.23.00.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jul 2021 00:59:50 -0700 (PDT)
Date: Fri, 23 Jul 2021 03:59:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ivan <ivan@prestigetransportation.com>
Subject: Re: PROBLEM: virtio_net LRO kernel panics
Message-ID: <20210723035713-mutt-send-email-mst@kernel.org>
References: <CACFia2dwacaVVYD+1uG=CDGaJqdCOSBvZ5FcXp04caecaWAY3w@mail.gmail.com>
 <CAMDZJNXthLpAPHn62gA1qSmfLOoDFcFGdgnNwW6yA+wjn0FjgQ@mail.gmail.com>
 <CACFia2fDZHUZB5wJ7LK8M2sv_+W58rHw0NzzrwPPoX9=s7yPdQ@mail.gmail.com>
 <9547a9e5-738c-2009-a2af-66173d305c2d@redhat.com>
 <CACFia2eLCJuy=w1r20691s_cSYkBkPaY-Dbd-9CkrcpSAe7z6g@mail.gmail.com>
 <5fd9c67f-d900-7694-f0a8-62682c8a14c8@redhat.com>
 <CACFia2eH3eCZxtt70LB5zoPbhLXRv=crPh5oOhR=6mY3auDdQA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACFia2eH3eCZxtt70LB5zoPbhLXRv=crPh5oOhR=6mY3auDdQA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "David S. Miller" <davem@davemloft.net>,
 virtualization@lists.linux-foundation.org,
 Willem de Bruijn <willemb@google.com>
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

T24gVGh1LCBKdWwgMjIsIDIwMjEgYXQgMTE6NTA6MTFQTSAtMDUwMCwgSXZhbiB3cm90ZToKPiBP
biBUaHUsIEp1bCAyMiwgMjAyMSBhdCAxMToyNSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPiA+IOWcqCAyMDIxLzcvMjMg5LiK5Y2IMTA6NTQsIEl2YW4g5YaZ6YGT
Ogo+ID4gPiBPbiBUaHUsIEp1bCAyMiwgMjAyMSBhdCA5OjM3IFBNIEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPj4gRG9lcyBpdCB3b3JrIGlmIHlvdSB0dXJuIG9m
ZiBscm8gYmVmb3JlIGVuYWJsaW5nIHRoZSBmb3J3YXJkaW5nPwo+ID4gPiAwIHJvb3RATnVSYWlk
On4jIGV0aHRvb2wgLUsgZXRoMCBscm8gb2ZmCj4gPiA+IEFjdHVhbCBjaGFuZ2VzOgo+ID4gPiBy
eC1scm86IG9uIFtyZXF1ZXN0ZWQgb2ZmXQo+ID4gPiBDb3VsZCBub3QgY2hhbmdlIGFueSBkZXZp
Y2UgZmVhdHVyZXMKPiA+Cj4gPiBPaywgaXQgbG9va3MgbGlrZSB0aGUgZGV2aWNlIG1pc3NlcyB0
aGUgVklSVElPX05FVF9GX0NUUkxfR1VFU1RfT0ZGTE9BRFMKPiA+IHdoaWNoIG1ha2VzIGl0IGlt
cG9zc2libGUgdG8gY2hhbmdlIHRoZSBMUk8gc2V0dGluZy4KPiA+Cj4gPiBEaWQgeW91IHVzZSBx
ZW11PyBJZiB5ZXMsIHdoYXQncyB0aGUgcWVtdSB2ZXJzaW9uIHlvdSd2ZSB1c2VkPwo+IAo+IFRo
ZXNlIGFyZSBWaXJ0dWFsQm94IG1hY2hpbmVzLCB3aGljaCBJJ3ZlIGJlZW4gdXNpbmcgZm9yIHll
YXJzIHdpdGgKPiBsb25ndGVybSBrZXJuZWxzIDQuMTksIGFuZCBJIG5ldmVyIGhhZCBzdWNoIGEg
cHJvYmxlbS4gIEJ1dCBub3cgdGhhdCBJCj4gdHJpZWQgdXBncmFkaW5nIHRvIGtlcm5lbHMgNS4x
MCBvciA1LjEzIC0tIHRoZSBwYW5pY3Mgc3RhcnRlZC4gIFRoZXNlCj4gYXJlIGp1c3QgZ2VuZXJp
YyBrZXJuZWwgYnVpbGRzLCBhbmQgYSBtaW5pbWFsaXN0aWMgdXNlcnNwYWNlLgoKSSB3b3VsZCBi
ZSB1c2VmdWwgdG8gc2VlIHRoZSBmZWF0dXJlcyB5b3VyIHZpcnR1YWxib3ggaW5zdGFuY2UgcHJv
dmlkZXMKCmNhdCAvc3lzL2NsYXNzL25ldC9ldGgwL2RldmljZS9mZWF0dXJlcwoKcmVwbGFjaW5n
IGV0aDAgd2l0aCBkZXZpY2UgbmFtZSBhcyBhcHByb3ByaWF0ZQoKCgotLSAKTVNUCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
