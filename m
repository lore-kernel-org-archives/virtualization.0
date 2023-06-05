Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE8CC77B73
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 12:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BE536080B;
	Mon,  5 Jun 2023 12:42:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BE536080B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VeCXpes5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vRfCTvJ00dfE; Mon,  5 Jun 2023 12:42:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CB37A60D68;
	Mon,  5 Jun 2023 12:42:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB37A60D68
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DE49C0037;
	Mon,  5 Jun 2023 12:42:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75905C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 12:42:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 62BC060806
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 12:42:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 62BC060806
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PHJ_Ai6uGVsQ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 12:42:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3114E60E3B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3114E60E3B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 12:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685968922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mOmw6tP0FZFUTC7PGHcbRuETRmz8QZ6Xd4tQSfJHTaA=;
 b=VeCXpes5lipf15yqdEfJFqwnqCl8wRV3lhTX62evDOIpJ2Q9rVPepZpiY9TOIYg9/3PHDc
 N17/DmSAHJbtkSTJuccRPG1SIbAKlDxYGoZCAkbgrcCLXCsqhpz6GrVmgfNMVdLdh3xI6e
 iB2Xre8geBFjOAPhgft4/Y7nxHLmZpQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-1ytJMOLeNeqXBQxh6Dt1nA-1; Mon, 05 Jun 2023 08:42:00 -0400
X-MC-Unique: 1ytJMOLeNeqXBQxh6Dt1nA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4ec817fb123so3199394e87.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jun 2023 05:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685968919; x=1688560919;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mOmw6tP0FZFUTC7PGHcbRuETRmz8QZ6Xd4tQSfJHTaA=;
 b=Eel9gceah6soLPx6PkLs2RXLq2T2gKalfMKLkhUZ4B/WM/fLeDoQwPDWSLiu0olP3v
 dV7YEZLuEqf1bNGlGY++OBHH68PyMgNS7DwG+cmJo0ZgFlWozjh+20lTjX8qjERA4RRk
 s73Ad+mLrwPyfbdcZSzRKq8wrLck8LPf2Kle35KTwDVZ5CMGnVfVV34uqOCYzf7/Nwop
 awpnK5kKHXRTQ795tVrOCTs40RCcSTNC+zSJKCeijhguLE5jXGLvX12yKxTBXDk9ByuL
 z5CQ+HaLHa7vk7g3LMQgvEzBLh6kX5al/I2/d7sR3RCFmQ7F1imQwDzoD8+ZFhhUbuMG
 fDmg==
X-Gm-Message-State: AC+VfDyx5UNyhsWGwac3m8R+tkr947qUZr+x9+/5ejjRbBABKuaIdbNv
 SM6znT2OPSgrea5YPcygoOhdGWOdTtehDcuqMkpXrBV3I3sEMBxx587AcbOKzt0p1l65vunMsAu
 aX0zdIPkwLqKnndfmBMnpGSQ8hk1rvBJU5ElzHs8SEw==
X-Received: by 2002:a05:6512:96c:b0:4f5:a181:97b8 with SMTP id
 v12-20020a056512096c00b004f5a18197b8mr4498040lft.25.1685968918877; 
 Mon, 05 Jun 2023 05:41:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7c02ynCF81jcSmROQilZ0qb05p4TMq5PV+aVib550acBLMoEwSQbxeF+apcaXIC3Jw7wScGQ==
X-Received: by 2002:a05:6512:96c:b0:4f5:a181:97b8 with SMTP id
 v12-20020a056512096c00b004f5a18197b8mr4498025lft.25.1685968918475; 
 Mon, 05 Jun 2023 05:41:58 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 24-20020a05600c231800b003f6041f5a6csm10669207wmo.12.2023.06.05.05.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 05:41:58 -0700 (PDT)
Date: Mon, 5 Jun 2023 08:41:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <20230605084104-mutt-send-email-mst@kernel.org>
References: <20230605110644.151211-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230605110644.151211-1-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
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

On Mon, Jun 05, 2023 at 01:06:44PM +0200, Stefano Garzarella wrote:
> vhost-vdpa IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE)
> don't support packed virtqueue well yet, so let's filter the
> VIRTIO_F_RING_PACKED feature for now in vhost_vdpa_get_features().
> 
> This way, even if the device supports it, we don't risk it being
> negotiated, then the VMM is unable to set the vring state properly.
> 
> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> 
> Notes:
>     This patch should be applied before the "[PATCH v2 0/3] vhost_vdpa:
>     better PACKED support" series [1] and backported in stable branches.
>     
>     We can revert it when we are sure that everything is working with
>     packed virtqueues.
>     
>     Thanks,
>     Stefano
>     
>     [1] https://lore.kernel.org/virtualization/20230424225031.18947-1-shannon.nelson@amd.com/

I'm a bit lost here. So why am I merging "better PACKED support" then?
Does this patch make them a NOP?

>  drivers/vhost/vdpa.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 8c1aefc865f0..ac2152135b23 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -397,6 +397,12 @@ static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
>  
>  	features = ops->get_device_features(vdpa);
>  
> +	/*
> +	 * IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE) don't support
> +	 * packed virtqueue well yet, so let's filter the feature for now.
> +	 */
> +	features &= ~BIT_ULL(VIRTIO_F_RING_PACKED);
> +
>  	if (copy_to_user(featurep, &features, sizeof(features)))
>  		return -EFAULT;
>  
> 
> base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
> -- 
> 2.40.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
