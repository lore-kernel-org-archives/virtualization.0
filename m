Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C224C4742C
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 10:22:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A80AF21527
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 10:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVlkDmmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80AF21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 43F0F87047;
	Mon, 16 Nov 2020 10:22:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Wli70u4pKoQ; Mon, 16 Nov 2020 10:22:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8647786632;
	Mon, 16 Nov 2020 10:22:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A1BFC0800;
	Mon, 16 Nov 2020 10:22:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78E07C07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 10:22:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5FA5120131
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 10:22:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mj1mk9moR-OR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 10:22:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 9238920005
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 10:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605522165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LbuGc0/uWmZkkv1PjDNiiAipM9HKIfrFobewTRjKHTE=;
 b=hVlkDmmvWJpZHrbsJM0QbIinysxGc5EVy2P8brl+gJrm6wdfbIRbsvLgtg9Ra+GsWxxgBQ
 MyHgr1SfX9cmsloNjWToGBpNneF9skAEqv9qcnboDlKMO4m1dOY4Bl0x7aCVvfaeZX1+AT
 IZqJzu6ATqCKHts3QVDoAxnvQgYjiy8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-4cCNsGYEP6CV3kYAZBEIVQ-1; Mon, 16 Nov 2020 05:22:43 -0500
X-MC-Unique: 4cCNsGYEP6CV3kYAZBEIVQ-1
Received: by mail-wr1-f70.google.com with SMTP id u1so10970832wri.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 02:22:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=LbuGc0/uWmZkkv1PjDNiiAipM9HKIfrFobewTRjKHTE=;
 b=tBHO/I4TThhakTJJqfjTeRYA27jBk3N1ClycElOSu3To4AD4CnWklhcF6bMzIKdwDh
 gxZG6CNczvUS+Y8q8kBW7cpylJfAQ+uSoTdqZ8W4nvnfJKWBmAZpfksZAuGf3tiWr9BC
 JcfrLSRlMcyGnx9Qdoj4RD/QPIoyLkseb/317rFgy1l3kbvCYKq2x4kpverygTzYYKL8
 C+PttyAe6Lfg2/ZdWBTJYbCiLaosqE2+PNxMp9uXILnAQz9V1W8FzXwwwtsMr61/E3Ae
 t1vKUahqXi/08jpYlEQPemCQD4H4lgfRpZmJZRhUqsv9xYJNc4Laa5qeg2AJoQWt8Hnj
 +G6A==
X-Gm-Message-State: AOAM533Jr3/pCs+DIm6FP4Sy88b7VxLl41BtQfWx8nCN1iKGdBzDalWg
 f47WM8TMVh9ZSGxtoN0jzVkfxkDVxPMErR4WJoVqCSVbael3MAgcsI2zXQqZH0zmmoWSPJ9akGI
 BvKR1BARqBRYzG2R6zwztpVel2XIcM4plj9qm0iT5gg==
X-Received: by 2002:adf:9b95:: with SMTP id d21mr18023451wrc.335.1605522162408; 
 Mon, 16 Nov 2020 02:22:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx139v61XiPzgtOleGag58qeN3Zua/6HVQ+vfxq5o0fOMqggcja1P2b8rKUEvt/WzM8J+HV8A==
X-Received: by 2002:adf:9b95:: with SMTP id d21mr18023430wrc.335.1605522162245; 
 Mon, 16 Nov 2020 02:22:42 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id j71sm20107227wmj.10.2020.11.16.02.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 02:22:41 -0800 (PST)
Date: Mon, 16 Nov 2020 11:22:39 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC 05/12] vdpa_sim: remove the limit of IOTLB entries
Message-ID: <20201116102239.bdqxbqfsdpbydkw2@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-6-sgarzare@redhat.com>
 <67e0358e-0ae8-75e9-156f-4156f58387d9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <67e0358e-0ae8-75e9-156f-4156f58387d9@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCBOb3YgMTYsIDIwMjAgYXQgMTI6MTI6MjFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMC8xMS8xMyDkuIvljYg5OjQ3LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+VGhlIHNpbXVsYXRlZCBkZXZpY2VzIGNhbiBzdXBwb3J0IG11bHRpcGxlIHF1ZXVlcywgc28g
dGhpcyBsaW1pdAo+PnNob3VsZCBiZSBkZWZpbmVkIGFjY29yZGluZyB0byB0aGUgbnVtYmVyIG9m
IHF1ZXVlcyBzdXBwb3J0ZWQgYnkKPj50aGUgZGV2aWNlLgo+Pgo+PlNpbmNlIHdlIGFyZSBpbiBh
IHNpbXVsYXRvciwgbGV0J3Mgc2ltcGx5IHJlbW92ZSB0aGF0IGxpbWl0Lgo+Pgo+PlN1Z2dlc3Rl
ZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj5TaWduZWQtb2ZmLWJ5OiBT
dGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4KPgo+QWNrZWQtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4KPkl0IHdvdWxkIGJlIGdvb2QgdG8gaW50
cm9kdWNlIGEgbWFjcm8gaW5zdGVhZCBvZiB1c2luZyB0aGUgbWFnaWMgMCBoZXJlLgoKRG9uZS4K
ClRoYW5rcywKU3RlZmFubwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
