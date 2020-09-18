Return-Path: <SRS0=+sYM=C3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C65C43464
	for <virtualization@archiver.kernel.org>; Fri, 18 Sep 2020 08:39:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE6620C56
	for <virtualization@archiver.kernel.org>; Fri, 18 Sep 2020 08:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE6620C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 64B0C2E1E7;
	Fri, 18 Sep 2020 08:39:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MCR32TzwGloY; Fri, 18 Sep 2020 08:39:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A867C20449;
	Fri, 18 Sep 2020 08:39:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 876DEC0891;
	Fri, 18 Sep 2020 08:39:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E403C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 08:39:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 13CBE2E1DB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 08:39:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y8JUIBsJbPxU
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 08:39:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by silver.osuosl.org (Postfix) with ESMTPS id 061192E1C2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 08:39:43 +0000 (UTC)
IronPort-SDR: P7jzkxKq2xjGoKh8v5h0rVJDkmQ/5ws3+MdTcl5KN2pmauTUOI6dphWVH0AxiDT9ih3teBWtvm
 J+fjy3i9P0Og==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="221447615"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; d="scan'208";a="221447615"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2020 01:39:39 -0700
IronPort-SDR: Lg+S8n1stJIjSdgW3Xrd4fA+Q7qUXskMoJ2jmmHsqZcO2/6V+WmdXuda+bpDkCnEuXKI9D9FWZ
 jaNnatQOT+FA==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; d="scan'208";a="452669959"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.252.42.33])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2020 01:39:36 -0700
Date: Fri, 18 Sep 2020 10:39:32 +0200
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH v7 3/3] vhost: add an RPMsg API
Message-ID: <20200918083931.GB19246@ubuntu>
References: <20200910111351.20526-1-guennadi.liakhovetski@linux.intel.com>
 <20200910111351.20526-4-guennadi.liakhovetski@linux.intel.com>
 <20200917085559.kxxjrortmhbwpd22@axis.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200917085559.kxxjrortmhbwpd22@axis.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Ohad Ben-Cohen <ohad@wizery.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "sound-open-firmware@alsa-project.org" <sound-open-firmware@alsa-project.org>
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

Hi Vincent,

On Thu, Sep 17, 2020 at 10:55:59AM +0200, Vincent Whitchurch wrote:
> On Thu, Sep 10, 2020 at 01:13:51PM +0200, Guennadi Liakhovetski wrote:
> > +int vhost_rpmsg_start_lock(struct vhost_rpmsg *vr, struct vhost_rpmsg_iter *iter,
> > +			   unsigned int qid, ssize_t len)
> > +	__acquires(vq->mutex)
> > +{
> > +	struct vhost_virtqueue *vq = vr->vq + qid;
> > +	unsigned int cnt;
> > +	ssize_t ret;
> > +	size_t tmp;
> > +
> > +	if (qid >= VIRTIO_RPMSG_NUM_OF_VQS)
> > +		return -EINVAL;
> > +
> > +	iter->vq = vq;
> > +
> > +	mutex_lock(&vq->mutex);
> > +	vhost_disable_notify(&vr->dev, vq);
> > +
> > +	iter->head = vhost_rpmsg_get_msg(vq, &cnt);
> > +	if (iter->head == vq->num)
> > +		iter->head = -EAGAIN;
> > +
> > +	if (iter->head < 0) {
> > +		ret = iter->head;
> > +		goto unlock;
> > +	}
> > +
> [...]
> > +
> > +return_buf:
> > +	vhost_add_used(vq, iter->head, 0);
> > +unlock:
> > +	vhost_enable_notify(&vr->dev, vq);
> > +	mutex_unlock(&vq->mutex);
> > +
> > +	return ret;
> > +}
> 
> There is a race condition here.  New buffers could have been added while
> notifications were disabled (between vhost_disable_notify() and
> vhost_enable_notify()), so the other vhost drivers check the return
> value of vhost_enable_notify() and rerun their work loops if it returns
> true.  This driver doesn't do that so it stops processing requests if
> that condition hits.

You're right, thanks for spotting this!

> Something like the below seems to fix it but the correct fix could maybe
> involve changing this API to account for this case so that it looks more
> like the code in other vhost drivers.

I'll try to use your proposed code, we'll see if it turns out incorrect.

> diff --git a/drivers/vhost/rpmsg.c b/drivers/vhost/rpmsg.c
> index 7c753258d42..673dd4ec865 100644
> --- a/drivers/vhost/rpmsg.c
> +++ b/drivers/vhost/rpmsg.c
> @@ -302,8 +302,14 @@ static void handle_rpmsg_req_kick(struct vhost_work *work)
>  	struct vhost_virtqueue *vq = container_of(work, struct vhost_virtqueue,
>  						  poll.work);
>  	struct vhost_rpmsg *vr = container_of(vq->dev, struct vhost_rpmsg, dev);
> +	struct vhost_virtqueue *reqvq = vr->vq + VIRTIO_RPMSG_REQUEST;

This is only called on the request queue, so, we can just use vq here.

>  
> -	while (handle_rpmsg_req_single(vr, vq))
> +	/*
> +	 * The !vhost_vq_avail_empty() check is needed since the vhost_rpmsg*
> +	 * APIs don't check the return value of vhost_enable_notify() and retry
> +	 * if there were buffers added while notifications were disabled.
> +	 */
> +	while (handle_rpmsg_req_single(vr, vq) || !vhost_vq_avail_empty(reqvq->dev, reqvq))
>  		;
>  }

Thanks
Guennadi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
