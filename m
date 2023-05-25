Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F28C77B7A
	for <virtualization@archiver.kernel.org>; Thu, 25 May 2023 07:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DCEA41F62;
	Thu, 25 May 2023 07:44:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8DCEA41F62
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gLRFAWgq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hPcCLItTQEzW; Thu, 25 May 2023 07:44:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DF17441F69;
	Thu, 25 May 2023 07:44:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF17441F69
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FC78C0035;
	Thu, 25 May 2023 07:44:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43292C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:44:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 17AED8203F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:44:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 17AED8203F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gLRFAWgq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hbx58dryDiw5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:44:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D60B81FF2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6D60B81FF2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685000674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZidSCpbYm+YuZEoatpe8DCv0kxzBXKit5E4US/iPhJw=;
 b=gLRFAWgqaKVMNfo/BzpE0JdVHqzhUmSpuoPvgBwdrUGIsXB82I5GCEGSREZfxT91m1/UAW
 akxq81b/ikkMQtUm5nU4kqmOJU0+QtCrf+SbiMJpgyIVmzVbvhQP4Rt0mQRAJs5ZjIsSOq
 OszTZhuiGnIsHrGUzMbMVM4YMY0ZqJg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-GJqp_RwGPG6dStWhzuJgzA-1; Thu, 25 May 2023 03:44:33 -0400
X-MC-Unique: GJqp_RwGPG6dStWhzuJgzA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6237c937691so6896866d6.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 00:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685000672; x=1687592672;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZidSCpbYm+YuZEoatpe8DCv0kxzBXKit5E4US/iPhJw=;
 b=I59ieDyvV5MziaA3VefgJJZjDqJHtTYViNzh4Om6z/QrAnhrKtIZYfnuIEpg/8BPc7
 jvM99njJOXxfnojH/tMV9Ws2FC0hi7qJys7+PYv0Xgsrow0GadaKAHbR7pW4avAcX+Cl
 ETiVC3clhA9AqQVJlsjH17ytIUZ4KlLd4RmcLCkvKxsXlFr/msPKiBjnKIV6gY5/xAlG
 AcTcdxqiIxPVs4CaBFYvxu9VriWlEQkd6AuCwjp+d993AnM8BS5nMfJX8iud6d3SDjK0
 Zw9NL2sN9db1mDSIhezIkozH1FfGra/uatOLicAfLD5+IGny4DaXbdXckA95ZZ2MJJlc
 BfOg==
X-Gm-Message-State: AC+VfDwsyCSOc6H14HbPj7gy4xTrq22v+6bREWA+/qiZFPMdDcJ4bfk6
 MoUa0tnu6mNYqs0zVVTWlIGuUX3F+CB0fXbyjXEVvgdvY6pRd+A9uDrCo7aPEcQ6zpoGzvr4IP9
 RwpjuR6oEeHUljqu7RTtkAg6Jg80Bhb3vH2RVvq1wiQ==
X-Received: by 2002:a05:6214:c82:b0:5f1:6a6a:f566 with SMTP id
 r2-20020a0562140c8200b005f16a6af566mr393319qvr.19.1685000672482; 
 Thu, 25 May 2023 00:44:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/1ui/g02jA0DgMpqIrlVxdCIlV4iF1Q0iEUDTPVHiDhFLNXv+XV7D9obvkc2A78610pRF5w==
X-Received: by 2002:a05:6214:c82:b0:5f1:6a6a:f566 with SMTP id
 r2-20020a0562140c8200b005f16a6af566mr393310qvr.19.1685000672217; 
 Thu, 25 May 2023 00:44:32 -0700 (PDT)
Received: from redhat.com ([191.101.160.247]) by smtp.gmail.com with ESMTPSA id
 mx3-20020a0562142e0300b00623854510cfsm230604qvb.31.2023.05.25.00.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 00:44:31 -0700 (PDT)
Date: Thu, 25 May 2023 03:44:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Rong Tao <rtoax@foxmail.com>
Subject: Re: [PATCH] tools/virtio: Add .gitignore to ringtest
Message-ID: <20230525034409-mutt-send-email-mst@kernel.org>
References: <tencent_C8F0F579940491D14055C82FABE812478505@qq.com>
MIME-Version: 1.0
In-Reply-To: <tencent_C8F0F579940491D14055C82FABE812478505@qq.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>, Rong Tao <rongtao@cestc.cn>,
 open list <linux-kernel@vger.kernel.org>
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

On Wed, May 24, 2023 at 08:36:12PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Ignore executions for ringtest.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  tools/virtio/ringtest/.gitignore | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 tools/virtio/ringtest/.gitignore
> 
> diff --git a/tools/virtio/ringtest/.gitignore b/tools/virtio/ringtest/.gitignore
> new file mode 100644
> index 000000000000..100b9e30c0f4
> --- /dev/null
> +++ b/tools/virtio/ringtest/.gitignore
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only

This one, with SPDX tag seems better.

> +/noring
> +/ptr_ring
> +/ring
> +/virtio_ring_0_9
> +/virtio_ring_inorder
> +/virtio_ring_poll
> -- 
> 2.39.1
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
