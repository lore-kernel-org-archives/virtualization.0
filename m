Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500E8C433DF
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 14:23:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 206AB208A9
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 14:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hT9HPjSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206AB208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DF26785F31;
	Tue,  4 Aug 2020 14:23:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dgh0RWsGYNzJ; Tue,  4 Aug 2020 14:23:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2BB1A853D9;
	Tue,  4 Aug 2020 14:23:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1ACFAC0051;
	Tue,  4 Aug 2020 14:23:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B278C004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:23:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 79FB720343
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:23:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uol+1jPMPNBM
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:23:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id 84A062012D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596551029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iy5rOiKvzn/ihf1AsNDgRAp385wBg2mwZBntnUSOdjY=;
 b=hT9HPjSFt8YBB/MEENy1OTOaGfNleaf5V1zHXy3LdXT/alj70aF9CyQGLSD8iBaDTgXaej
 EcB5SazeQ1HSrXDXJbtbVCKuJ6E9DcBIyLKI2ab7nV97yrAwEiIholWrYLjPj4tVs74mm0
 lYxvNL6C565snCCDQ4oQNPATIQ2YLQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-jw4ds942OKiTFM2bmKBI3A-1; Tue, 04 Aug 2020 10:23:47 -0400
X-MC-Unique: jw4ds942OKiTFM2bmKBI3A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 228AE800461;
 Tue,  4 Aug 2020 14:23:46 +0000 (UTC)
Received: from gondolin (ovpn-112-169.ams2.redhat.com [10.36.112.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E13B7B90F;
 Tue,  4 Aug 2020 14:23:42 +0000 (UTC)
Date: Tue, 4 Aug 2020 16:23:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 03/24] virtio: allow __virtioXX, __leXX in config space
Message-ID: <20200804162340.046b719b.cohuck@redhat.com>
In-Reply-To: <20200803205814.540410-4-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-4-mst@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, 3 Aug 2020 16:58:46 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Currently all config space fields are of the type __uXX.
> This confuses people and some drivers (notably vdpa)
> access them using CPU endian-ness - which only
> works well for legacy or LE platforms.
> 
> Update virtio_cread/virtio_cwrite macros to allow __virtioXX
> and __leXX field types. Follow-up patches will convert
> config space to use these types.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/virtio_config.h | 50 +++++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)

(...)

> @@ -287,12 +288,57 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
>  	return __cpu_to_virtio64(virtio_is_little_endian(vdev), val);
>  }
>  
> +/*
> + * Only the checker differentiates between __virtioXX and __uXX types. But we
> + * try to share as much code as we can with the regular GCC build.
> + */
> +#if !defined(CONFIG_CC_IS_GCC) && !defined(__CHECKER__)
> +
> +/* Not a checker - we can keep things simple */
> +#define __virtio_native_typeof(x) typeof(x)
> +
> +#else
> +
> +/*
> + * We build this out of a couple of helper macros in a vain attempt to
> + * help you keep your lunch down while reading it.
> + */

It might help with the lunch, but it still gives a slight queasiness.
No ideas for a better version, though.

> +#define __virtio_pick_value(x, type, then, otherwise)			\
> +	__builtin_choose_expr(__same_type(x, type), then, otherwise)
> +
> +#define __virtio_pick_type(x, type, then, otherwise)			\
> +	__virtio_pick_value(x, type, (then)0, otherwise)
> +
> +#define __virtio_pick_endian(x, x16, x32, x64, otherwise)			\
> +	__virtio_pick_type(x, x16, __u16,					\
> +		__virtio_pick_type(x, x32, __u32,				\
> +			__virtio_pick_type(x, x64, __u64,			\
> +				otherwise)))
> +
> +#define __virtio_native_typeof(x) typeof(					\
> +	__virtio_pick_type(x, __u8, __u8,					\
> +		__virtio_pick_endian(x, __virtio16, __virtio32, __virtio64,	\
> +			__virtio_pick_endian(x, __le16, __le32, __le64,		\
> +				__virtio_pick_endian(x, __u16, __u32, __u64,	\
> +					/* No other type allowed */		\
> +					(void)0)))))
> +
> +#endif
> +
> +#define __virtio_native_type(structname, member) \
> +	__virtio_native_typeof(((structname*)0)->member)
> +
> +#define __virtio_typecheck(structname, member, val) \
> +		/* Must match the member's type, and be integer */ \
> +		typecheck(__virtio_native_type(structname, member), (val))
> +
> +

Acked-by: Cornelia Huck <cohuck@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
