Return-Path: <SRS0=u9Em=C2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0465AC43461
	for <virtualization@archiver.kernel.org>; Thu, 17 Sep 2020 08:56:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B72520872
	for <virtualization@archiver.kernel.org>; Thu, 17 Sep 2020 08:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=axis.com header.i=@axis.com header.b="Tw2DhNNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B72520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E0A5A2E16B;
	Thu, 17 Sep 2020 08:56:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J4Vez8I9Gqy9; Thu, 17 Sep 2020 08:56:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 66EE220468;
	Thu, 17 Sep 2020 08:56:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E871C0864;
	Thu, 17 Sep 2020 08:56:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98ED4C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 08:56:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8E2A48786D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 08:56:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id caEgUFUAKNK5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 08:56:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D546F871AA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 08:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; l=2275; q=dns/txt; s=axis-central1;
 t=1600332964; x=1631868964;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7NfOGX/GL1UDMwdZ9k07i7ou/GGUBIMx7JAJVjygZ7I=;
 b=Tw2DhNNthP/mL4sh5ABU9b/7QCQ3W4bYIvYGBvvZM5RUNkjsGwtkAPWs
 zPG+pJWSvevyO42D17MRn404E39h0jg++hsXzUuBjLetAPn7VWt006pFk
 j05TAAEdCFSLxn8/p4/yZh3jwpXehmeCcrfTnscdvMYTl0PNkbJK1Bxyk
 QJC4duQpjwL5C1rxvTE/Y5ttz3dsoLpLWnZV5sHeW2hDsupfFatgYEARI
 3PY9wbKEqV6HijUdLUNYAaLuU4Wtbues4njC9UD3GiOqDNcmRn0pKXCZb
 6+8E0gCq+DsOBqxppA6z2vEjnbpHIdS1r4BwUrMiYXl/pMwjFpGKgd7ox A==;
IronPort-SDR: 6MqQxFg+KYlYJphHffimUhmitKEWQPSswtENyoQ91Ovj6pMX7T6qnNokxLq4K1YYqIKW+8XOXr
 8QxFFxVrBt4TANYJEnUU/zc/mxdRg7mGqCOauW90Ho32mryhm8H3Sw595FtOFZ6oJaimDN+N8J
 /MMYYZq38yqB6MUsXNxl3vZ0hOpba2p7rXyfh8R3zXjBcn8VmYaWDrPOptWGXktOddOp6rPiKd
 y1daRMgtUItqjCYrg2WJQQYJ0Fya8TEg1mGxkPnANvFXWBSKn3ItgMDLGHghqOeRJc0uwK3AgP
 Yq0=
X-IronPort-AV: E=Sophos;i="5.76,436,1592863200"; d="scan'208";a="13045882"
Date: Thu, 17 Sep 2020 10:55:59 +0200
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH v7 3/3] vhost: add an RPMsg API
Message-ID: <20200917085559.kxxjrortmhbwpd22@axis.com>
References: <20200910111351.20526-1-guennadi.liakhovetski@linux.intel.com>
 <20200910111351.20526-4-guennadi.liakhovetski@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200910111351.20526-4-guennadi.liakhovetski@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
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

On Thu, Sep 10, 2020 at 01:13:51PM +0200, Guennadi Liakhovetski wrote:
> +int vhost_rpmsg_start_lock(struct vhost_rpmsg *vr, struct vhost_rpmsg_iter *iter,
> +			   unsigned int qid, ssize_t len)
> +	__acquires(vq->mutex)
> +{
> +	struct vhost_virtqueue *vq = vr->vq + qid;
> +	unsigned int cnt;
> +	ssize_t ret;
> +	size_t tmp;
> +
> +	if (qid >= VIRTIO_RPMSG_NUM_OF_VQS)
> +		return -EINVAL;
> +
> +	iter->vq = vq;
> +
> +	mutex_lock(&vq->mutex);
> +	vhost_disable_notify(&vr->dev, vq);
> +
> +	iter->head = vhost_rpmsg_get_msg(vq, &cnt);
> +	if (iter->head == vq->num)
> +		iter->head = -EAGAIN;
> +
> +	if (iter->head < 0) {
> +		ret = iter->head;
> +		goto unlock;
> +	}
> +
[...]
> +
> +return_buf:
> +	vhost_add_used(vq, iter->head, 0);
> +unlock:
> +	vhost_enable_notify(&vr->dev, vq);
> +	mutex_unlock(&vq->mutex);
> +
> +	return ret;
> +}

There is a race condition here.  New buffers could have been added while
notifications were disabled (between vhost_disable_notify() and
vhost_enable_notify()), so the other vhost drivers check the return
value of vhost_enable_notify() and rerun their work loops if it returns
true.  This driver doesn't do that so it stops processing requests if
that condition hits.

Something like the below seems to fix it but the correct fix could maybe
involve changing this API to account for this case so that it looks more
like the code in other vhost drivers.

diff --git a/drivers/vhost/rpmsg.c b/drivers/vhost/rpmsg.c
index 7c753258d42..673dd4ec865 100644
--- a/drivers/vhost/rpmsg.c
+++ b/drivers/vhost/rpmsg.c
@@ -302,8 +302,14 @@ static void handle_rpmsg_req_kick(struct vhost_work *work)
 	struct vhost_virtqueue *vq = container_of(work, struct vhost_virtqueue,
 						  poll.work);
 	struct vhost_rpmsg *vr = container_of(vq->dev, struct vhost_rpmsg, dev);
+	struct vhost_virtqueue *reqvq = vr->vq + VIRTIO_RPMSG_REQUEST;
 
-	while (handle_rpmsg_req_single(vr, vq))
+	/*
+	 * The !vhost_vq_avail_empty() check is needed since the vhost_rpmsg*
+	 * APIs don't check the return value of vhost_enable_notify() and retry
+	 * if there were buffers added while notifications were disabled.
+	 */
+	while (handle_rpmsg_req_single(vr, vq) || !vhost_vq_avail_empty(reqvq->dev, reqvq))
 		;
 }
 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
