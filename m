Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF507C433DF
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 13:36:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2412073E
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 13:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfrOSxze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2412073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 49A2685078;
	Tue,  4 Aug 2020 13:36:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UjPRq6g2vp9H; Tue,  4 Aug 2020 13:36:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C32E885044;
	Tue,  4 Aug 2020 13:36:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADFF6C0050;
	Tue,  4 Aug 2020 13:36:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C240C004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 13:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 37F7386256
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 13:36:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iA1mxYcteW5z
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 13:36:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 721B785FAD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 13:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596548197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IOCwdMErKnn1pYLabxDoC9kp0B6qr2CDAm+6i+5EwqY=;
 b=PfrOSxzeT+myqnyZXf++MnJt4X5QpBxIG1cxqtfbKLwT6pRqsQNlusYSi5GbjnrfHWcVTt
 5NGJdMmBHzOjPWi6OQNlfpOmZqIKtQPTN5o2nPu+4o4h8Axa/RMnwMc/qppaehOlx0IEc6
 Qie7WDBmh82OyW1Rqy5raQAv9TWsx18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-fY9lu491MzGQTCeekwHRPA-1; Tue, 04 Aug 2020 09:36:35 -0400
X-MC-Unique: fY9lu491MzGQTCeekwHRPA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01A73107BA73;
 Tue,  4 Aug 2020 13:36:34 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-15.rdu2.redhat.com [10.10.116.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A352F7B909;
 Tue,  4 Aug 2020 13:36:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 208BB220406; Tue,  4 Aug 2020 09:36:33 -0400 (EDT)
Date: Tue, 4 Aug 2020 09:36:33 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 09/24] virtio_fs: correct tags for config space fields
Message-ID: <20200804133633.GC273445@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-10-mst@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200803205814.540410-10-mst@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org
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

On Mon, Aug 03, 2020 at 04:59:13PM -0400, Michael S. Tsirkin wrote:
> Since fs is a modern-only device,
> tag config space fields as having little endian-ness.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

virtio spec does list this field as "le32".

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
>  include/uapi/linux/virtio_fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/virtio_fs.h b/include/uapi/linux/virtio_fs.h
> index b02eb2ac3d99..3056b6e9f8ce 100644
> --- a/include/uapi/linux/virtio_fs.h
> +++ b/include/uapi/linux/virtio_fs.h
> @@ -13,7 +13,7 @@ struct virtio_fs_config {
>  	__u8 tag[36];
>  
>  	/* Number of request queues */
> -	__u32 num_request_queues;
> +	__le32 num_request_queues;
>  } __attribute__((packed));
>  
>  #endif /* _UAPI_LINUX_VIRTIO_FS_H */
> -- 
> MST
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
