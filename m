Return-Path: <SRS0=pGqY=CS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7AEC433E2
	for <virtualization@archiver.kernel.org>; Wed,  9 Sep 2020 02:38:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84BD721D24
	for <virtualization@archiver.kernel.org>; Wed,  9 Sep 2020 02:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idlO/KHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BD721D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 291458749C;
	Wed,  9 Sep 2020 02:38:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SVEbWPwxYg68; Wed,  9 Sep 2020 02:38:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0B1DC87487;
	Wed,  9 Sep 2020 02:38:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1601C0890;
	Wed,  9 Sep 2020 02:38:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F0B6C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 02:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E49B72E10F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 02:38:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id idZHXgIG9E7K
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 02:38:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 895D527E4C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 02:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599619122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B8V/E1J+FloLvbRgdM82im9tBAuMNmHArMRMtM0VkOI=;
 b=idlO/KHXnXCq3h0H0UeulHCcABa0SmRljp9w1JadEiYGZrChUa+1rJbUN2lCsm0uRXkv4v
 Qy3XTAgWkxfVkxnTVrB63QVdZBvZf+AtgfzqzH31uodMYx8g9LyhpDLlXY1TTl+Gq0oq0r
 3DGhRnRcJtetKQplDG1hnGi3JmPgHxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-eUh4UVXXN-StxtVZTGDaIw-1; Tue, 08 Sep 2020 22:38:40 -0400
X-MC-Unique: eUh4UVXXN-StxtVZTGDaIw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08ABF800EBB;
 Wed,  9 Sep 2020 02:38:39 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EEC4C60C0F;
 Wed,  9 Sep 2020 02:38:38 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id E01EA7A00C;
 Wed,  9 Sep 2020 02:38:38 +0000 (UTC)
Date: Tue, 8 Sep 2020 22:38:37 -0400 (EDT)
From: Jason Wang <jasowang@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Message-ID: <2104155542.16285964.1599619117641.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200909022233.26559-1-lingshan.zhu@intel.com>
References: <20200909022233.26559-1-lingshan.zhu@intel.com>
Subject: Re: [PATCH] vhost: new vhost_vdpa SET/GET_BACKEND_FEATURES handlers
MIME-Version: 1.0
X-Originating-IP: [10.68.5.20, 10.4.195.10]
Thread-Topic: vhost: new vhost_vdpa SET/GET_BACKEND_FEATURES handlers
Thread-Index: 7zVLAssoNeH734drqaqg1blqsRLnOA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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



----- Original Message -----
> This commit introduced vhost_vdpa_set/get_backend_features() to
> resolve these issues:
> (1)In vhost_vdpa ioctl SET_BACKEND_FEATURES path, currect code
> would try to acquire vhost dev mutex twice
> (first shown in vhost_vdpa_unlocked_ioctl), which can lead
> to a dead lock issue.
> (2)SET_BACKEND_FEATURES was blindly added to vring ioctl instead
> of vdpa device ioctl
> 
> To resolve these issues, this commit (1)removed mutex operations
> in vhost_set_backend_features. (2)Handle ioctl
> SET/GET_BACKEND_FEATURES in vdpa ioctl. (3)introduce a new
> function vhost_net_set_backend_features() for vhost_net,
> which is a wrap of vhost_set_backend_features() with
> necessary mutex lockings.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>

So this patch touches not only vhost-vDPA.

Though the function looks correct, I'd prefer you do cleanup on top of
my patches which has been tested by Eli.

Note that, vhost generic handlers tend to hold mutex by itself.

So we probably need more thought on this.

Thanks

> ---
>  drivers/vhost/net.c   |  9 ++++++++-
>  drivers/vhost/vdpa.c  | 47 ++++++++++++++++++++++++++++++-------------
>  drivers/vhost/vhost.c |  2 --
>  3 files changed, 41 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 531a00d703cd..e01da77538c8 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1679,6 +1679,13 @@ static long vhost_net_set_owner(struct vhost_net *n)
>  	return r;
>  }
>  
> +static void vhost_net_set_backend_features(struct vhost_dev *dev, u64
> features)
> +{
> +	mutex_lock(&dev->mutex);
> +	vhost_set_backend_features(dev, features);
> +	mutex_unlock(&dev->mutex);
> +}
> +
>  static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>  			    unsigned long arg)
>  {
> @@ -1715,7 +1722,7 @@ static long vhost_net_ioctl(struct file *f, unsigned
> int ioctl,
>  			return -EFAULT;
>  		if (features & ~VHOST_NET_BACKEND_FEATURES)
>  			return -EOPNOTSUPP;
> -		vhost_set_backend_features(&n->dev, features);
> +		vhost_net_set_backend_features(&n->dev, features);
>  		return 0;
>  	case VHOST_RESET_OWNER:
>  		return vhost_net_reset_owner(n);
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 3fab94f88894..ade33c566a81 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -344,6 +344,33 @@ static long vhost_vdpa_set_config_call(struct vhost_vdpa
> *v, u32 __user *argp)
>  	return 0;
>  }
>  
> +
> +static long vhost_vdpa_get_backend_features(void __user *argp)
> +{
> +	u64 features = VHOST_VDPA_BACKEND_FEATURES;
> +	u64 __user *featurep = argp;
> +	long r;
> +
> +	r = copy_to_user(featurep, &features, sizeof(features));
> +
> +	return r;
> +}
> +static long vhost_vdpa_set_backend_features(struct vhost_vdpa *v, void
> __user *argp)
> +{
> +	u64 __user *featurep = argp;
> +	u64 features;
> +
> +	if (copy_from_user(&features, featurep, sizeof(features)))
> +		return -EFAULT;
> +
> +	if (features & ~VHOST_VDPA_BACKEND_FEATURES)
> +		return -EOPNOTSUPP;
> +
> +	vhost_set_backend_features(&v->vdev, features);
> +
> +	return 0;
> +}
> +
>  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  				   void __user *argp)
>  {
> @@ -353,8 +380,6 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v,
> unsigned int cmd,
>  	struct vdpa_callback cb;
>  	struct vhost_virtqueue *vq;
>  	struct vhost_vring_state s;
> -	u64 __user *featurep = argp;
> -	u64 features;
>  	u32 idx;
>  	long r;
>  
> @@ -381,18 +406,6 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v,
> unsigned int cmd,
>  
>  		vq->last_avail_idx = vq_state.avail_index;
>  		break;
> -	case VHOST_GET_BACKEND_FEATURES:
> -		features = VHOST_VDPA_BACKEND_FEATURES;
> -		if (copy_to_user(featurep, &features, sizeof(features)))
> -			return -EFAULT;
> -		return 0;
> -	case VHOST_SET_BACKEND_FEATURES:
> -		if (copy_from_user(&features, featurep, sizeof(features)))
> -			return -EFAULT;
> -		if (features & ~VHOST_VDPA_BACKEND_FEATURES)
> -			return -EOPNOTSUPP;
> -		vhost_set_backend_features(&v->vdev, features);
> -		return 0;
>  	}
>  
>  	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
> @@ -476,6 +489,12 @@ static long vhost_vdpa_unlocked_ioctl(struct file
> *filep,
>  	case VHOST_VDPA_SET_CONFIG_CALL:
>  		r = vhost_vdpa_set_config_call(v, argp);
>  		break;
> +	case VHOST_SET_BACKEND_FEATURES:
> +		r = vhost_vdpa_set_backend_features(v, argp);
> +		break;
> +	case VHOST_GET_BACKEND_FEATURES:
> +		r = vhost_vdpa_get_backend_features(argp);
> +		break;
>  	default:
>  		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
>  		if (r == -ENOIOCTLCMD)
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index b45519ca66a7..e03c9e6f058f 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2591,14 +2591,12 @@ void vhost_set_backend_features(struct vhost_dev
> *dev, u64 features)
>  	struct vhost_virtqueue *vq;
>  	int i;
>  
> -	mutex_lock(&dev->mutex);
>  	for (i = 0; i < dev->nvqs; ++i) {
>  		vq = dev->vqs[i];
>  		mutex_lock(&vq->mutex);
>  		vq->acked_backend_features = features;
>  		mutex_unlock(&vq->mutex);
>  	}
> -	mutex_unlock(&dev->mutex);
>  }
>  EXPORT_SYMBOL_GPL(vhost_set_backend_features);
>  
> --
> 2.18.4
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
