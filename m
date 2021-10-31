Return-Path: <SRS0=Mk6X=PT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8143C433EF
	for <virtualization@archiver.kernel.org>; Sun, 31 Oct 2021 18:59:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 476DB60F58
	for <virtualization@archiver.kernel.org>; Sun, 31 Oct 2021 18:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 476DB60F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0F6A40151;
	Sun, 31 Oct 2021 18:59:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q_Y1O0WP5jGF; Sun, 31 Oct 2021 18:59:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 739EF4013E;
	Sun, 31 Oct 2021 18:59:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EB3DC0012;
	Sun, 31 Oct 2021 18:59:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C243FC000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 18:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B13FE606A0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 18:59:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UWIc-aogP7Id
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 18:59:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D3DF060616
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 18:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635706765;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l/4kG6bMV5loA1A9FHzGwLm47Xc3PteREau0B796BFM=;
 b=epC78ubTusEPrpCxOJzd2Mxv9SFHj4EMP56ansgOPgSlA6aV9sJomD7ZXotofMt1ySzfW5
 I/j2jUruwVk5TDw/93NRMfrHXuA2vxJ6tYzKUJgJlek6IhqGwBnmbRS+bTzhR9t6mgN4bP
 N0KocpDGAuEQkhHqCtVM6fpfQ6gHEL8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-JuTMKQc_OK6eV1kAPoZgRA-1; Sun, 31 Oct 2021 14:59:24 -0400
X-MC-Unique: JuTMKQc_OK6eV1kAPoZgRA-1
Received: by mail-wr1-f72.google.com with SMTP id
 d13-20020adf9b8d000000b00160a94c235aso5497223wrc.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 11:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=l/4kG6bMV5loA1A9FHzGwLm47Xc3PteREau0B796BFM=;
 b=raEikwfc//BClNBbEbh5ZGTXCGQYQrZSyM2yFZPI+lPzonO/2wBc42qOSAEs0sR1uk
 wnsDY5Olb7wFLKXdLO5kGsOjsfWb4XU5s4W8tAI3MkIhyCfGnNgAPdq2+4gA62pVwKz4
 RHrX4/fM07iYyWdM5Y4ohcxEYVgamrVHbLEiXOnlAyyW4I5QYzb8537ioEjT6v33jogT
 RDvqg1XiMldbR+n05DFg7GNoMCz0MGMZSAe/g64y6rXJLA73rtPELNBnzzUIJChXK4wB
 pRffa2OQWoF+zvl6QjnCmedX9yaQZARanXM13hRMioT5t+bxPwS76S5xCiW2E5Ax+9j+
 4drw==
X-Gm-Message-State: AOAM531d5oGJCjKxnvr+9LbOpfHRc5aKpoElepiq8ZZmKV02LcXz5uab
 sqKYroDB2TVpiz2rbovAca1nSWgaLttRDk70PFN7NPrMVAa98SoPAivjqhLDsane4kfE6gXgkSJ
 6KWHC84hpKIFZflk7IyMsVigP3RF3xRYzNB2NXNFzLA==
X-Received: by 2002:a05:600c:4a27:: with SMTP id
 c39mr14031021wmp.101.1635706763054; 
 Sun, 31 Oct 2021 11:59:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSuUBBToMZtFRRwyz33tJ9ibJ+rkz4BtRbW3+NAw8h4vD2Zr4BCuLyo4hInMYsaw49tmGyZQ==
X-Received: by 2002:a05:600c:4a27:: with SMTP id
 c39mr14031002wmp.101.1635706762896; 
 Sun, 31 Oct 2021 11:59:22 -0700 (PDT)
Received: from localhost ([178.139.231.243])
 by smtp.gmail.com with ESMTPSA id a26sm10170372wmm.46.2021.10.31.11.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Oct 2021 11:59:22 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Eugenio =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH v5 01/26] util: Make some iova_tree parameters const
In-Reply-To: <20211029183525.1776416-2-eperezma@redhat.com> ("Eugenio
 =?utf-8?Q?P=C3=A9rez=22's?=
 message of "Fri, 29 Oct 2021 20:35:00 +0200")
References: <20211029183525.1776416-1-eperezma@redhat.com>
 <20211029183525.1776416-2-eperezma@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date: Sun, 31 Oct 2021 19:59:21 +0100
Message-ID: <87a6iprpfa.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Xiao W Wang <xiao.w.wang@intel.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Eli Cohen <eli@mellanox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, virtualization@lists.linux-foundation.org,
 Parav Pandit <parav@mellanox.com>
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
Reply-To: quintela@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

RXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+IHdyb3RlOgo+IEFzIHFlbXUgZ3Vp
ZGVsaW5lczoKPiBVbmxlc3MgYSBwb2ludGVyIGlzIHVzZWQgdG8gbW9kaWZ5IHRoZSBwb2ludGVk
LXRvIHN0b3JhZ2UsIGdpdmUgaXQgdGhlCj4gImNvbnN0IiBhdHRyaWJ1dGUuCj4KPiBJbiB0aGUg
cGFydGljdWxhciBjYXNlIG9mIGlvdmFfdHJlZV9maW5kIGl0IGFsbG93cyB0byBlbmZvcmNlIHdo
YXQgaXMKPiByZXF1ZXN0ZWQgYnkgaXRzIGNvbW1lbnQsIHNpbmNlIHRoZSBjb21waWxlciB3b3Vs
ZCBzaG91dCBpbiBjYXNlIG9mCj4gbW9kaWZ5aW5nIG9yIGZyZWVpbmcgdGhlIGNvbnN0LXF1YWxp
ZmllZCByZXR1cm5lZCBwb2ludGVyLgo+Cj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXog
PGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gQWNrZWQtYnk6IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0
LmNvbT4KPiBSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRo
YXQuY29tPgoKUmV2aWV3ZWQtYnk6IEp1YW4gUXVpbnRlbGEgPHF1aW50ZWxhQHJlZGhhdC5jb20+
CgpUaGlzIHBhdGNoIGNhbiBnbyBpbiBhbHJlYWR5LCB3aG9zZSB0cmVlIHNob3VsZCB0aGlzIGdv
IHRocm91Z2g/CgpMYXRlciwgSnVhbi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
