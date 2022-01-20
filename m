Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C726AC433FE
	for <virtualization@archiver.kernel.org>; Thu, 20 Jan 2022 14:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5663B409E5;
	Thu, 20 Jan 2022 14:35:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jUknmG1R6QZu; Thu, 20 Jan 2022 14:35:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 972DF40121;
	Thu, 20 Jan 2022 14:35:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B10AC0039;
	Thu, 20 Jan 2022 14:35:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FD74C002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 14:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0D17860E0D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 14:35:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wLWKKiDFKjy3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 14:35:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6270D60D8C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 14:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642689306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D378avGhHf7Yew8dpU8oH0FTT2ZH+6InHr9T5zdsY3g=;
 b=L/rjtCY00kCK9MEHXaoHXRdrgcc4EIZHgh1xABvMHPH25VrLcQci7YIHKYcfciAMU+C5dA
 0KizTMwtz6zaPL31/XWzV/m0UlGU+2iwan3xwxew10HbKZ2hBhhKaRgE+ZXXz02GxTfWzb
 TQ+dPvPtVgKZCVMUrbR8c3SE5vbtwRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-Aati9j2NM7e9FDZ-ofjW4g-1; Thu, 20 Jan 2022 09:35:05 -0500
X-MC-Unique: Aati9j2NM7e9FDZ-ofjW4g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D3461926DA0;
 Thu, 20 Jan 2022 14:35:04 +0000 (UTC)
Received: from localhost (unknown [10.39.195.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A092678AB2;
 Thu, 20 Jan 2022 14:35:03 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] virtio: acknowledge all features before access
In-Reply-To: <20220118170225.30620-2-mst@redhat.com>
Organization: Red Hat GmbH
References: <20220118170225.30620-1-mst@redhat.com>
 <20220118170225.30620-2-mst@redhat.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date: Thu, 20 Jan 2022 15:35:01 +0100
Message-ID: <87h79ycw6i.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Halil Pasic <pasic@linux.ibm.com>, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Tue, Jan 18 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> The feature negotiation was designed in a way that
> makes it possible for devices to know which config
> fields will be accessed by drivers.
>
> This is broken since commit 404123c2db79 ("virtio: allow drivers to
> validate features") with fallout in at least block and net.  We have a
> partial work-around in commit 2f9a174f918e ("virtio: write back
> F_VERSION_1 before validate") which at least lets devices find out which
> format should config space have, but this is a partial fix: guests
> should not access config space without acknowledging features since
> otherwise we'll never be able to change the config space format.
>
> To fix, split finalize_features from virtio_finalize_features and
> call finalize_features with all feature bits before validation,
> and then - if validation changed any bits - once again after.
>
> Since virtio_finalize_features no longer writes out features
> rename it to virtio_features_ok - since that is what it does:
> checks that features are ok with the device.
>
> As a side effect, this also reduces the amount of hypervisor accesses -
> we now only acknowledge features once unless we are clearing any
> features when validating (which is uncommon).
>
> Cc: stable@vger.kernel.org
> Fixes: 404123c2db79 ("virtio: allow drivers to validate features")
> Fixes: 2f9a174f918e ("virtio: write back F_VERSION_1 before validate")
> Cc: "Halil Pasic" <pasic@linux.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> fixup! virtio: acknowledge all features before access

Leftover from rebasing?

> ---
>  drivers/virtio/virtio.c       | 39 ++++++++++++++++++++---------------
>  include/linux/virtio_config.h |  3 ++-
>  2 files changed, 24 insertions(+), 18 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Would like to see a quick sanity test from Halil, though.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
