Return-Path: <SRS0=j1Zo=K2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961E7C4708F
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 07:58:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D78D60FE3
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 07:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D78D60FE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA368607C3;
	Mon, 31 May 2021 07:58:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ghzhhU0GfMBs; Mon, 31 May 2021 07:58:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3317E60A41;
	Mon, 31 May 2021 07:58:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E41C6C000D;
	Mon, 31 May 2021 07:58:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57BFCC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 07:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 458CE401DB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 07:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d36ELovu4HV9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 07:58:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE4574015C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 07:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622447894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EdRsDMw4H1zTHoV4Q0DDi+MXBcsk6roz9PziidrlNag=;
 b=DnqUoRAy4Uqw1XaHjWu3Kw3vuvVNS1jH6yTUe1z2TWGbaaWKr0aHglMEl29BbYKR3ij8t0
 N2Mv1E24gEhb51fgWifKSjAe94EN7onPgmzj59OiiiZ7+3qo1KWZtHvZh0fTvL2V9nBv+A
 sLqr2l+qrnQevTfG/W5iOm37aTVQN0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-I3OLvASbNja5hRImbNs9cg-1; Mon, 31 May 2021 03:58:12 -0400
X-MC-Unique: I3OLvASbNja5hRImbNs9cg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C7F8107ACCA;
 Mon, 31 May 2021 07:58:11 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-113-190.ams2.redhat.com
 [10.36.113.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F0D91E6;
 Mon, 31 May 2021 07:58:07 +0000 (UTC)
Date: Mon, 31 May 2021 09:58:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH RESEND 1/2] virtio: update virtio id table, add
 transitional ids
Message-ID: <20210531095804.47629646.cohuck@redhat.com>
In-Reply-To: <20210531072743.363171-2-lingshan.zhu@intel.com>
References: <20210531072743.363171-1-lingshan.zhu@intel.com>
 <20210531072743.363171-2-lingshan.zhu@intel.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kvm@vger.kernel.org, mst@redhat.com
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

On Mon, 31 May 2021 15:27:42 +0800
Zhu Lingshan <lingshan.zhu@intel.com> wrote:

> This commit updates virtio id table by adding transitional device
> ids
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  include/uapi/linux/virtio_ids.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index f0c35ce8628c..fcc9ec6a73c1 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -57,4 +57,16 @@
>  #define VIRTIO_ID_BT			28 /* virtio bluetooth */
>  #define VIRTIO_ID_MAC80211_HWSIM	29 /* virtio mac80211-hwsim */
>  
> +/*
> + * Virtio Transitional IDs
> + */
> +
> +#define VIRTIO_TRANS_ID_NET		1000 /* transitional virtio net */
> +#define VIRTIO_TRANS_ID_BLOCK		1001 /* transitional virtio block */
> +#define VIRTIO_TRANS_ID_BALLOON		1002 /* transitional virtio balloon */
> +#define VIRTIO_TRANS_ID_CONSOLE		1003 /* transitional virtio console */
> +#define VIRTIO_TRANS_ID_SCSI		1004 /* transitional virtio SCSI */
> +#define VIRTIO_TRANS_ID_RNG		1005 /* transitional virtio rng */
> +#define VIRTIO_TRANS_ID_9P		1009 /* transitional virtio 9p console */
> +
>  #endif /* _LINUX_VIRTIO_IDS_H */

Isn't this a purely virtio-pci concept? (The spec lists the virtio ids
in the common section, and those transitional ids in the pci section.)
IOW, is there a better, virtio-pci specific, header for this?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
