Return-Path: <SRS0=2X6m=EE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71914C2D0A3
	for <virtualization@archiver.kernel.org>; Thu, 29 Oct 2020 11:13:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08A720756
	for <virtualization@archiver.kernel.org>; Thu, 29 Oct 2020 11:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Np0zC7Or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08A720756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2273186B31;
	Thu, 29 Oct 2020 11:13:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HnCau7Wo52WM; Thu, 29 Oct 2020 11:13:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AB34B86521;
	Thu, 29 Oct 2020 11:13:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 989F9C0859;
	Thu, 29 Oct 2020 11:13:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BE6AC0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 11:13:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7D309869A0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 11:13:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pxKCvcXGewzJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 11:13:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id ECC2E8587C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 11:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603970003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zIaJu7FAw8dfZKVBgnoDacf5K6Q+ovY8+WxFh0DYprM=;
 b=Np0zC7OrFCW1L+4shDaRRAGm/JKr1Wbwh7ov7xcdEHaFmJA6CXpS+9+ahAsLZ60V7U6GdX
 pNG8rG2jeJ1dK5vDGnMt3wkoaEwZcHtpOt08pK3TQGoX61zV5D+Hsj9Pyo7lZXNQrvdFmO
 6yUIni8zL9aF3z4FAXMGdp6PJTKFYVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-koXZ2FOkOZe8sI_qzCfRWQ-1; Thu, 29 Oct 2020 07:13:21 -0400
X-MC-Unique: koXZ2FOkOZe8sI_qzCfRWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 640BA108597B;
 Thu, 29 Oct 2020 11:13:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3740C7515B;
 Thu, 29 Oct 2020 11:13:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 020BB9D0D; Thu, 29 Oct 2020 12:13:00 +0100 (CET)
Date: Thu, 29 Oct 2020 12:13:00 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 3/3] drm/qxl: Remove fbcon acceleration leftovers
Message-ID: <20201029111300.p2vld6qc4e2q53xy@sirius.home.kraxel.org>
References: <20201029101428.4058311-1-daniel.vetter@ffwll.ch>
 <20201029101428.4058311-3-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
In-Reply-To: <20201029101428.4058311-3-daniel.vetter@ffwll.ch>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Dave Airlie <airlied@redhat.com>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org, spice-devel@lists.freedesktop.org,
 Daniel Vetter <daniel.vetter@intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Oct 29, 2020 at 11:14:28AM +0100, Daniel Vetter wrote:
> These are leftovers from 13aff184ed9f ("drm/qxl: remove dead qxl fbdev
> emulation code").

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
