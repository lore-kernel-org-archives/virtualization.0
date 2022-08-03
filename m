Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEE7C19F2C
	for <virtualization@archiver.kernel.org>; Wed,  3 Aug 2022 11:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2468D6F725;
	Wed,  3 Aug 2022 11:40:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2468D6F725
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y9K08+BU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tMG0hFp6_Z6F; Wed,  3 Aug 2022 11:40:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8CC536F71D;
	Wed,  3 Aug 2022 11:40:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8CC536F71D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DCE3C0033;
	Wed,  3 Aug 2022 11:40:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32AD5C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 11:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E96F64029B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 11:40:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E96F64029B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y9K08+BU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EDR82X_WMcSW
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 11:40:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B48840162
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9B48840162
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 11:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659526804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JwfvYO99TCB9FiKX3BYcocI/S5+Oq3USCEZauc8Ysww=;
 b=Y9K08+BU22N8Am63BEFKxuUhvTwgsssPilFl65hI9xdNNnCTkUWWZsOCYleTN3+OZfb7Ng
 PAB5ZitGAPBnwWZ0TkRYjYjonqTUAuQdixTweULcokrZTJCcuN8M2fpXEP0ifPeRjBXNi2
 IAeeqGTVjUk8vMHP7z4ExdAAwu7wvNc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-AE5i_3t8OyyQVAnuPPvQtw-1; Wed, 03 Aug 2022 07:40:03 -0400
X-MC-Unique: AE5i_3t8OyyQVAnuPPvQtw-1
Received: by mail-wr1-f69.google.com with SMTP id
 m2-20020adfc582000000b0021e28acded7so4202470wrg.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Aug 2022 04:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=JwfvYO99TCB9FiKX3BYcocI/S5+Oq3USCEZauc8Ysww=;
 b=7kqZNGIUJ0BnCKl13UvCetqtzoLimbDF7Mc9dUV/AvHoDg1nXv+sI+DvVd+imuJTlN
 uBoZqkiqpnIw72JuiPH+tb7WtOGQcr7NMpwr/Sd1QlnImM4oJi1DF8vL8JdmEMoP0A13
 fy/6n8JuRjo2xk1P6lOwjDxMCDwXADiS1cJ5BdggWKm4kuo25t2gLXoHuck13Qo0sPWV
 Q/Jal0IkoEw0AALVPUXCcuD7wst9h1UPR4NYQCQn8wENKT1tDrVPlueR3NTrsMnowebt
 hVYBbAv8brW13RQwbgUEriTJWKO+aZV+Re+Xhpu/hfsSuYbtJrDsT9Q4Fsa0rg6HsOV1
 zNwQ==
X-Gm-Message-State: ACgBeo0BAEefjNVDNYTlsE8xMy0ekf6Kgw+3vPF5lMlVn36qllJVy+uH
 moT0GryLomrmw0g2lE2lWUdAXGTU/cCdXAAeHNRy7eLBCmq/d5Yi+t1/sJCXJugKnDqHMC2N83A
 7FwpwZYkMfAVu5PlM+sJywT1vdhRWJF2Gm2bDTKVyww==
X-Received: by 2002:a05:600c:5029:b0:3a3:7308:6a43 with SMTP id
 n41-20020a05600c502900b003a373086a43mr2482226wmr.99.1659526801886; 
 Wed, 03 Aug 2022 04:40:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Rj/RNdfFfFtzgtWn3I7gaknofBvNO8dT4fRFSg4D4OhE4MQPKh3aT/w+L1QYSSL2Mvr0VaA==
X-Received: by 2002:a05:600c:5029:b0:3a3:7308:6a43 with SMTP id
 n41-20020a05600c502900b003a373086a43mr2482207wmr.99.1659526801602; 
 Wed, 03 Aug 2022 04:40:01 -0700 (PDT)
Received: from redhat.com ([2.54.191.86]) by smtp.gmail.com with ESMTPSA id
 a1-20020adfe5c1000000b0021e491fd250sm11957635wrn.89.2022.08.03.04.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Aug 2022 04:40:01 -0700 (PDT)
Date: Wed, 3 Aug 2022 07:39:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: [PATCH v2 4/4] hwrng: virtio - always add a pending request
Message-ID: <20220803073243-mutt-send-email-mst@kernel.org>
References: <20211028101111.128049-1-lvivier@redhat.com>
 <20211028101111.128049-5-lvivier@redhat.com>
 <7e64ce61-89b1-40aa-8295-00ca42b9a959@arm.com>
 <2c1198c4-77aa-5cb8-6bb4-b974850651be@arm.com>
MIME-Version: 1.0
In-Reply-To: <2c1198c4-77aa-5cb8-6bb4-b974850651be@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>,
 Mauricio De Carvalho <Mauricio.DeCarvalho@arm.com>,
 Kevin Brodsky <Kevin.Brodsky@arm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, amit@kernel.org,
 rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Alexander Potapenko <glider@google.com>, linux-crypto@vger.kernel.org,
 Matt Mackall <mpm@selenic.com>, akong@redhat.com,
 Dmitriy Vyukov <dvyukov@google.com>
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

On Wed, Aug 03, 2022 at 09:57:35AM +0100, Vladimir Murzin wrote:
> On 8/2/22 13:49, Vladimir Murzin wrote:
> > Hi Laurent,
> > 
> > On 10/28/21 11:11, Laurent Vivier wrote:
> >> If we ensure we have already some data available by enqueuing
> >> again the buffer once data are exhausted, we can return what we
> >> have without waiting for the device answer.
> >>
> >> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> >> ---
> >>  drivers/char/hw_random/virtio-rng.c | 26 ++++++++++++--------------
> >>  1 file changed, 12 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> >> index 8ba97cf4ca8f..0a7dde135db1 100644
> >> --- a/drivers/char/hw_random/virtio-rng.c
> >> +++ b/drivers/char/hw_random/virtio-rng.c
> >> @@ -20,7 +20,6 @@ struct virtrng_info {
> >>  	struct virtqueue *vq;
> >>  	char name[25];
> >>  	int index;
> >> -	bool busy;
> >>  	bool hwrng_register_done;
> >>  	bool hwrng_removed;
> >>  	/* data transfer */
> >> @@ -44,16 +43,18 @@ static void random_recv_done(struct virtqueue *vq)
> >>  		return;
> >>  
> >>  	vi->data_idx = 0;
> >> -	vi->busy = false;
> >>  
> >>  	complete(&vi->have_data);
> >>  }
> >>  
> >> -/* The host will fill any buffer we give it with sweet, sweet randomness. */
> >> -static void register_buffer(struct virtrng_info *vi)
> >> +static void request_entropy(struct virtrng_info *vi)
> >>  {
> >>  	struct scatterlist sg;
> >>  
> >> +	reinit_completion(&vi->have_data);
> >> +	vi->data_avail = 0;
> >> +	vi->data_idx = 0;
> >> +
> >>  	sg_init_one(&sg, vi->data, sizeof(vi->data));
> >>  
> >>  	/* There should always be room for one buffer. */
> >> @@ -69,6 +70,8 @@ static unsigned int copy_data(struct virtrng_info *vi, void *buf,
> >>  	memcpy(buf, vi->data + vi->data_idx, size);
> >>  	vi->data_idx += size;
> >>  	vi->data_avail -= size;
> >> +	if (vi->data_avail == 0)
> >> +		request_entropy(vi);
> >>  	return size;
> >>  }
> >>  
> >> @@ -98,13 +101,7 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
> >>  	 * so either size is 0 or data_avail is 0
> >>  	 */
> >>  	while (size != 0) {
> >> -		/* data_avail is 0 */
> >> -		if (!vi->busy) {
> >> -			/* no pending request, ask for more */
> >> -			vi->busy = true;
> >> -			reinit_completion(&vi->have_data);
> >> -			register_buffer(vi);
> >> -		}
> >> +		/* data_avail is 0 but a request is pending */
> >>  		ret = wait_for_completion_killable(&vi->have_data);
> >>  		if (ret < 0)
> >>  			return ret;
> >> @@ -126,8 +123,7 @@ static void virtio_cleanup(struct hwrng *rng)
> >>  {
> >>  	struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
> >>  
> >> -	if (vi->busy)
> >> -		complete(&vi->have_data);
> >> +	complete(&vi->have_data);
> >>  }
> >>  
> >>  static int probe_common(struct virtio_device *vdev)
> >> @@ -163,6 +159,9 @@ static int probe_common(struct virtio_device *vdev)
> >>  		goto err_find;
> >>  	}
> >>  
> >> +	/* we always have a pending entropy request */
> >> +	request_entropy(vi);
> >> +
> >>  	return 0;
> >>  
> >>  err_find:
> >> @@ -181,7 +180,6 @@ static void remove_common(struct virtio_device *vdev)
> >>  	vi->data_idx = 0;
> >>  	complete(&vi->have_data);
> >>  	vdev->config->reset(vdev);
> >> -	vi->busy = false;
> >>  	if (vi->hwrng_register_done)
> >>  		hwrng_unregister(&vi->hwrng);
> >>  	vdev->config->del_vqs(vdev);
> > 
> > We observed that after this commit virtio-rng implementation in FVP doesn't
> > work
> > 
> > INFO: bp.virtio_rng: Selected Random Generator Device: XORSHIFT DEVICE
> > INFO: bp.virtio_rng: Using seed value: 0x5674bba8
> > Error: FVP_Base_AEMvA: bp.virtio_rng: <vq0-requestq> Found invalid descriptor index
> > In file: (unknown):0
> > In process: FVP_Base_AEMvA.thread_p_12 @ 935500020 ns
> > Info: FVP_Base_AEMvA: bp.virtio_rng: Could not extract buffer
> > 
> > while basic baremetal test works as expected
> > 
> > INFO: bp.virtio_rng: Selected Random Generator Device: XORSHIFT DEVICE
> > INFO: bp.virtio_rng: Using seed value: 0x541c142e
> > Info: FVP_Base_AEMv8A: bp.virtio_rng: Generated Number: 0x4b098991ceb377e6
> > Info: FVP_Base_AEMv8A: bp.virtio_rng: Generated Number: 0xbdcbe3f765ba62f7
> > 
> > We are trying to get an idea what is missing and where, yet none of us familiar
> > with the driver :(
> > 
> > I'm looping Kevin who originally reported that and Mauricio who is looking form
> > the FVP side. 
> 
> With the following diff FVP works agin
> 
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> index a6f3a8a2ac..042503ad6c 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -54,6 +54,7 @@ static void request_entropy(struct virtrng_info *vi)
>         reinit_completion(&vi->have_data);
>         vi->data_avail = 0;
>         vi->data_idx = 0;
> +       smp_mb();
>  
>         sg_init_one(&sg, vi->data, sizeof(vi->data));
>  
> 
> What do you reckon?
> 
> Cheers
> Vladimir

Thanks for debugging this!

OK, interesting.

data_idx and data_avail are accessed from virtio_read.

Which as far as I can tell is invoked just with reading_mutex.


But, request_entropy is called from probe when device is registered
this time without locks
so it can trigger while another thread is calling virtio_read.

Second request_entropy is called from a callback random_recv_done
also without locks.

So it's great that smp_mb helped here but I suspect in fact we
need locking. Laurent?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
