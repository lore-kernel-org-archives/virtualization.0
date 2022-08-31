Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE537ECAAD1
	for <virtualization@archiver.kernel.org>; Wed, 31 Aug 2022 13:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5210740C5D;
	Wed, 31 Aug 2022 13:08:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5210740C5D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SfJgce6J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G3iGYuE0fcup; Wed, 31 Aug 2022 13:08:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DD5574050C;
	Wed, 31 Aug 2022 13:08:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD5574050C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B19B5C0032;
	Wed, 31 Aug 2022 13:08:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4214C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 13:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F55C82BEB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 13:08:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F55C82BEB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SfJgce6J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1jH1C0DkV6mH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 13:08:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A831382ACA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A831382ACA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 13:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661951299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hywdEPUBwDEXmtkI0jnmSRJpF0zIazv7Rc1AGtOEGW8=;
 b=SfJgce6JU7LPqGoKh9crawRJY/FSbJCdANAz29upmpBJ5Ufus3vu0kObbd+Sd+u0Hv3KMb
 FaBzeucc8pympQ1fMlm0pOgmrFyofFwgvW/PIiFCq7IhypcDlyDevBr4C+fipEbYo1XXj0
 6GCf6QFDu9+tSzO/5QJ0nRZR1R7s6XE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-320-uwRxfYnBN2CqeV31w1D-CA-1; Wed, 31 Aug 2022 09:08:18 -0400
X-MC-Unique: uwRxfYnBN2CqeV31w1D-CA-1
Received: by mail-wm1-f70.google.com with SMTP id
 r83-20020a1c4456000000b003a7b679981cso7268817wma.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 06:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=hywdEPUBwDEXmtkI0jnmSRJpF0zIazv7Rc1AGtOEGW8=;
 b=ZAxDoyd1ttYZ/8t4AEnJrHlZWlLcQeWHG06jZ39AyhTQ+FX6b/C2aLo8nOZpMdqTHM
 GPWWjPWYdwy4rDTBCWDLJFdYEvz6qDXaKaTwJdpUNFj6O1FZpGgHqRrquwGLsfG7bKOq
 qVarT7imVUzNf6IqID4aOArPQ+oy32qi1++6JPS0a1ezHDxYDa89WDlRTVhT3Q7Mi/ae
 HGiNdxPVun/P+7Fdnc6WQCLBUYLY62AFZVn6HucbZhbuI1TigVLHJP+lN4Ei7zgm7I+C
 BzXxZG2X3/E52C+0u2zgR2eXlxedjJiM9n3ah5LVx21eLNwPw84Uh3EHDhBZSA9mRrjI
 fs9g==
X-Gm-Message-State: ACgBeo1kxpx9mNv6hzhudBdtlPwsVyOSQ0B1Mkq4MVPZOzFmu7CSrD7D
 4XWh4PFGVpIEG2S3QvYck+TGO2uj8xPD2hTPYHSo5HYXAYVCLRiXJ7tyIGe6tGVliGG6SAR0TyA
 Bb2VhHa9JDyEPk3lhzKochaYkucdX9kPzcAphmQWxTQ==
X-Received: by 2002:a5d:4082:0:b0:226:d019:c91e with SMTP id
 o2-20020a5d4082000000b00226d019c91emr11914080wrp.557.1661951296177; 
 Wed, 31 Aug 2022 06:08:16 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5ohNbZ482TWkudDJOWI8JLnbpEFRUINvd3UPL3S0CQwHgE0OAjwRxPcbUVSPcRsLsbVCut+g==
X-Received: by 2002:a5d:4082:0:b0:226:d019:c91e with SMTP id
 o2-20020a5d4082000000b00226d019c91emr11914059wrp.557.1661951295958; 
 Wed, 31 Aug 2022 06:08:15 -0700 (PDT)
Received: from redhat.com ([2.55.191.225]) by smtp.gmail.com with ESMTPSA id
 t20-20020a05600c199400b003a845621c5bsm2177751wmq.34.2022.08.31.06.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Aug 2022 06:08:15 -0700 (PDT)
Date: Wed, 31 Aug 2022 09:08:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Li <gavinl@nvidia.com>
Subject: Re: [PATCH RESEND v4 1/2] virtio-net: introduce and use helper
 function for guest gso support checks
Message-ID: <20220831090721-mutt-send-email-mst@kernel.org>
References: <20220831130541.81217-1-gavinl@nvidia.com>
 <20220831130541.81217-2-gavinl@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220831130541.81217-2-gavinl@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org,
 sridhar.samudrala@intel.com, jesse.brandeburg@intel.com, gavi@nvidia.com,
 virtualization@lists.linux-foundation.org, stephen@networkplumber.org,
 loseweigh@gmail.com, netdev@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net
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

On Wed, Aug 31, 2022 at 04:05:40PM +0300, Gavin Li wrote:
> Probe routine is already several hundred lines.
> Use helper function for guest gso support check.
> 
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Gavi Teitz <gavi@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
> changelog:
> v1->v2
> - Add new patch
> ---
>  drivers/net/virtio_net.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9cce7dec7366..e1904877d461 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3682,6 +3682,14 @@ static int virtnet_validate(struct virtio_device *vdev)
>  	return 0;
>  }
>  
> +static bool virtnet_check_guest_gso(const struct virtnet_info *vi)
> +{
> +	return (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> +		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
> +		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
> +		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO));
> +}
> +

fine but can we please drop the outer ()?
they are necessary with if but not with return.


>  static int virtnet_probe(struct virtio_device *vdev)
>  {
>  	int i, err = -ENOMEM;
> @@ -3777,10 +3785,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	spin_lock_init(&vi->refill_lock);
>  
>  	/* If we can receive ANY GSO packets, we must allocate large ones. */
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> -	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
> -	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
> -	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
> +	if (virtnet_check_guest_gso(vi))
>  		vi->big_packets = true;
>  
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
