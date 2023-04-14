Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83D8C77B61
	for <virtualization@archiver.kernel.org>; Fri, 14 Apr 2023 02:26:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A63F427C0;
	Fri, 14 Apr 2023 02:26:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0A63F427C0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hcsmBU7l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pTazKPO-F5tR; Fri, 14 Apr 2023 02:26:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 14B8642766;
	Fri, 14 Apr 2023 02:26:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14B8642766
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0667C0037;
	Fri, 14 Apr 2023 02:26:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45E3BC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 02:26:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 205D860EC4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 02:26:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 205D860EC4
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hcsmBU7l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HZ4mHhwPrU49
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 02:26:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4133860C0B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4133860C0B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 02:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681439211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ude+Qy/j2PJgdg+9aerdykEjMG9FMIe5ez4sPQIJvPw=;
 b=hcsmBU7llBzpt1aTiT+DgyNGMMVsYjKvOMeIZQywuA8TYYd5GB1ZhQOSVCyJhvm4mGKAuK
 RXXJ10Hd6KD5XMC4JucfxsAh3brLP/B41bRcfqmYAtgh4S0i9oiL0t8CqkJKyInB97B98p
 g4YCY2owA41RYtYjyATNF9Fu5qc1sRE=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-MomhnxvCPcWPErijGc_pdw-1; Thu, 13 Apr 2023 22:26:44 -0400
X-MC-Unique: MomhnxvCPcWPErijGc_pdw-1
Received: by mail-oi1-f200.google.com with SMTP id
 bb17-20020a056808169100b003846654dd65so4880501oib.19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 19:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681439203; x=1684031203;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ude+Qy/j2PJgdg+9aerdykEjMG9FMIe5ez4sPQIJvPw=;
 b=cblJl197rdymkwmHGT/lKmIW8KSUyPbvN75pD0Nk1LqzHa1BIP2i4Bi7+uWVxwBjqh
 dmUS9+YLHVClKvESAuRpeL9G47I6KOkYfu19jcF6Umzbn6o69GiFXJUp3ILqwNkzIdQn
 srXtnhBToF7LJasDcGqzJ+Zjk+JKYfHkUxlrrbfekujTcYJOEMlQDlMHcgkpJSlCNgVW
 7H41fVoOa0p0Ha5hIXH35V5c/J0oc3jzQnDiH3zqt/ANJwUlHx6+kxVwc8/fCLXfLY5G
 WChKEs0JpDTYZrCH441tOhpXQHDxl6A5ga7PsSE8bpFmYwLq9/08FejlQhzrV7eM5PnW
 cDSw==
X-Gm-Message-State: AAQBX9eIQGkI3Do42P0rHOw/Ixvc/OCEiqDnilVMR/RrHiCHryuw4HCl
 4on/XRMPnrCO2U2bQS9jERssxfrm/yoIIlPaRMGFp/T650mA9k1vjS7RS4A9d3v2VQpM/fU7D4s
 eMYtM0Rtsdk5d0p+I9q19M/WIoqEv36dNTwtaWQ0qEpiga8xPl/h0LnL/cA==
X-Received: by 2002:aca:1c0f:0:b0:384:c4a:1b49 with SMTP id
 c15-20020aca1c0f000000b003840c4a1b49mr847495oic.9.1681439203654; 
 Thu, 13 Apr 2023 19:26:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350YWoHxx/ZVrtTix/UKfdRTGh5UYww6PGffl19bPAMPBldXjuvxbh5oO+siOM+tYImwO2nSc7qK5PCdLZ3GyeWo=
X-Received: by 2002:aca:1c0f:0:b0:384:c4a:1b49 with SMTP id
 c15-20020aca1c0f000000b003840c4a1b49mr847491oic.9.1681439203459; Thu, 13 Apr
 2023 19:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230328021717.42268-1-michael.christie@oracle.com>
 <20230328021717.42268-12-michael.christie@oracle.com>
 <CACGkMEuvAGKHVtg_tdiGJRN4+5utdDVbvnkycN97eb2fE2Ddsg@mail.gmail.com>
 <faeaa023-c1ee-cd81-3397-edecc0579e8a@oracle.com>
 <CACGkMEvrvpu-xdJTzm5mVq-9JGuXRnsXZHEU7tgwfsz6qqFc4g@mail.gmail.com>
 <0ce314ff-0a1d-223d-0ccf-d2cb876b4306@oracle.com>
 <CACGkMEs5GdXuoMaOiZjWytG=JHqhzdZmCu=dK7GRRvYcx8t2+A@mail.gmail.com>
 <c7da1c60-1b89-5fab-942a-1e74214f03d5@oracle.com>
 <CACGkMEsYK5yWuFECrUM-_fLA1V4H=WayxfovT2ezMeQCmwcDoQ@mail.gmail.com>
 <26bae999-4375-ab02-a97b-056282a84ecd@oracle.com>
In-Reply-To: <26bae999-4375-ab02-a97b-056282a84ecd@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Apr 2023 10:26:32 +0800
Message-ID: <CACGkMEuU4pzDh1dbJgH_x0Oxtia3VorhLPuqU20xkoMK9HOoTQ@mail.gmail.com>
Subject: Re: [PATCH v6 11/11] vhost: allow userspace to create workers
To: Mike Christie <michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, stefanha@redhat.com,
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

T24gRnJpLCBBcHIgMTQsIDIwMjMgYXQgNjozNuKAr0FNIE1pa2UgQ2hyaXN0aWUKPG1pY2hhZWwu
Y2hyaXN0aWVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4KPiBPbiA0LzEyLzIzIDI6NTYgQU0sIEphc29u
IFdhbmcgd3JvdGU6Cj4gPj4gSSBjYW4gc3BpbiBhbm90aGVyIHBhdGNoc2V0IHdpdGggdGhlIHNp
bmdsZSBpb2N0bCBkZXNpZ24gc28gd2UgY2FuIGNvbXBhcmUuCj4gPiBTbyBJJ20gZmluZSB3aXRo
IHRoaXMgYXBwcm9hY2guIE9uZSBsYXN0IHF1ZXN0aW9uLCBJIHNlZSB0aGlzOgo+ID4KPiA+IC8q
IEJ5IGRlZmF1bHQsIGEgZGV2aWNlIGdldHMgb25lIHZob3N0X3dvcmtlciB0aGF0IGl0cyB2aXJ0
cXVldWVzIHNoYXJlLiBUaGlzICovCj4gPgo+ID4gSSdtIHdvbmRlcmluZyBpZiBpdCBpcyBiZXR0
ZXIgdG8gaGF2ZSBhIHZob3N0X2dldF93b3JrZXIoKSB0byByZXR1cm4KPiA+IHRoZSB3b3JrZXJf
aWQgb2YgYSBzcGVjaWZpYyBxdWV1ZS4gSW4gdGhlIGZ1dHVyZSwgdGhpcyBtaWdodCBiZSB1c2Vm
dWwKPiA+IGZvciBkZXZpY2VzIHRoYXQgaGF2ZSBtdWx0aXBsZSB3b3JrZXJzIGJ5IGRlZmF1bHQ/
Cj4KPiBZZWFoLCBpdCB3b3VsZCBiZSB1c2VmdWwuIEp1c3QgMiBxdWVzdGlvbnMuIFlvdSBtZWFu
IGFuIGlvY3RsIGNvbW1hbmQgdG8gZ2V0Cj4gdGhpcyBpbmZvIHJpZ2h0PyBJIGhhZCBhZGRlZCBv
bmUgaW4gb25lIHZlcnNpb24gYSB3aGlsZSBiYWNrLCBidXQgZHJvcHBlZCBpdAo+IGJlY2F1c2Ug
Zm9yIHNvbWUgcmVhc29uIEkgdGhvdWdodCB3ZSB3ZXJlIGdvaW5nIHRvIGRvIGEgZ2VuZXJpYyB2
aG9zdCBzeXNmcwo+IHR5cGUgb2YgaW50ZXJmYWNlLiBXZSBhcmUgbm90IGRvaW5nIHN5c2ZzIHJp
Z2h0PwoKUHJvYmFibHksIGJ1dCB3ZSBuZWVkIHRvIG1ha2Ugc3VyZSB0aGUgZW11bGF0b3JwaW4g
Y2FuIHdvcmsgZm9yIGxpYnZpcnQgYXQgbGFzdC4KClRoYW5rcwoKPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
