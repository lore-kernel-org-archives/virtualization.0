Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E108BC433F5
	for <virtualization@archiver.kernel.org>; Thu, 20 Jan 2022 20:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DB6060C21;
	Thu, 20 Jan 2022 20:39:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fPJtKhOm-MWb; Thu, 20 Jan 2022 20:39:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CBA4460B02;
	Thu, 20 Jan 2022 20:39:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A521AC0039;
	Thu, 20 Jan 2022 20:39:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8833C002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 20:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D6B8F81319
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 20:39:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y9i9J_nFj4_i
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 20:39:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF86E81318
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 20:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642711161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ntrYMeN6pl5yWZvzZ3V4QM6g66eYCG9Ga0nZ73KJC1k=;
 b=VOXlGQ32H+sc4UreuTLXfdFhhfhZev2Vnt/3tEjLmUe7OZ9adCFh/WEQM0hk7uqG9E29eC
 xzcNqxZojyaygK8HIhNGNQ9a3xTzGM9VDdWxhGEEUvtN3HZsgZECp8QocfvxLTExPKAWvL
 COl5F2ogCSG9UH4b/RydZqIaHE2QVqQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-SKPau_cwMxyBcEiXMjHBcA-1; Thu, 20 Jan 2022 15:39:20 -0500
X-MC-Unique: SKPau_cwMxyBcEiXMjHBcA-1
Received: by mail-wm1-f72.google.com with SMTP id
 g80-20020a1c9d53000000b0034da9d62199so1425790wme.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 12:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ntrYMeN6pl5yWZvzZ3V4QM6g66eYCG9Ga0nZ73KJC1k=;
 b=KQa/p+4oDnl9lZsUX80TeuKPTbwUgu3smbVV7NXqgFanX6OY7lDhdu/WZvpVZSHHhB
 B+7abHfw0CQIeJe3OlfiNh7JbE7BWKOmuC7M1lq0rn0u9KfjgIcP667RUZDe6wCd7S+U
 waMe+ymGarJV/MpmWu/lv5lX9e9OHJo02B1yqXdrPYDvnRqIgtp9eHk7NUGbcAOy7lr8
 wNSHx8RfsljjzMNyu4wV1Ppyr/eXNJeZnh5t2mSU4EaRxZ3winP2kde+wyBSRztfBUCX
 DmMSwFOFI7nX0ZYOQCFV5y9gN0WbYQ6AsLnupiMDAPzvD9CAuep3zyz0CipzS3behj7b
 flkw==
X-Gm-Message-State: AOAM533swOVrbqbwanaeUNZCaDBw/xvcN5jM3y+sJjVbDDbevl7VypIR
 W+mXJyiO4SwxmWEfgKWwVWdGOrggjjRYjrqoTzSfCAI/u8VA4cxGE0PmC/W0+Hl3Y+smTxEK5kl
 bBshK/eehiH255Xa4zGj4LehJsvz4nqS2z1l+GsGGwA==
X-Received: by 2002:a05:600c:b58:: with SMTP id
 k24mr10696400wmr.47.1642711159205; 
 Thu, 20 Jan 2022 12:39:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEU3AJ1MJ37HmYik7y2xEv9ymA+ChFMYK53evSZLFYotO4fNcJ7hcEvE9AiCo/v2DXA2gnCg==
X-Received: by 2002:a05:600c:b58:: with SMTP id
 k24mr10696382wmr.47.1642711158959; 
 Thu, 20 Jan 2022 12:39:18 -0800 (PST)
Received: from redhat.com ([2.55.159.47])
 by smtp.gmail.com with ESMTPSA id u9sm8250777wmc.11.2022.01.20.12.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jan 2022 12:39:17 -0800 (PST)
Date: Thu, 20 Jan 2022 15:39:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v9 09/11] firmware: arm_scmi: Add atomic mode support to
 virtio transport
Message-ID: <20220120150418-mutt-send-email-mst@kernel.org>
References: <20211220195646.44498-10-cristian.marussi@arm.com>
 <20211221140027.41524-1-cristian.marussi@arm.com>
 <f231094a-6f34-3dc1-237d-97218e8fde91@opensynergy.com>
 <20220119122338.GE6113@e120937-lin>
 <2f1ea794-a0b9-2099-edc0-b2aeb3ca6b92@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <2f1ea794-a0b9-2099-edc0-b2aeb3ca6b92@opensynergy.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: f.fainelli@gmail.com, vincent.guittot@linaro.org,
 igor.skalkin@opensynergy.com, sudeep.holla@arm.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Cristian Marussi <cristian.marussi@arm.com>, james.quinlan@broadcom.com,
 Jonathan.Cameron@huawei.com, souvik.chakravarty@arm.com,
 etienne.carriere@linaro.org, linux-arm-kernel@lists.infradead.org
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

On Thu, Jan 20, 2022 at 08:09:56PM +0100, Peter Hilber wrote:
> On 19.01.22 13:23, Cristian Marussi wrote:
> > On Tue, Jan 18, 2022 at 03:21:03PM +0100, Peter Hilber wrote:
> >> On 21.12.21 15:00, Cristian Marussi wrote:
> >>> Add support for .mark_txdone and .poll_done transport operations to SCMI
> >>> VirtIO transport as pre-requisites to enable atomic operations.
> >>>
> >>> Add a Kernel configuration option to enable SCMI VirtIO transport polling
> >>> and atomic mode for selected SCMI transactions while leaving it default
> >>> disabled.
> >>>
> >>
> >> Hi Cristian,
> >>
> >> thanks for the update. I have some more remarks inline below.
> >>
> > 
> > Hi Peter,
> > 
> > thanks for your review, much appreciated, please see my replies online.
> > 
> >> My impression is that the virtio core does not expose helper functions suitable
> >> to busy-poll for used buffers. But changing this might not be difficult. Maybe
> >> more_used() from virtio_ring.c could be exposed via a wrapper?
> >>
> > 
> > While I definitely agree that the virtio core support for polling is far from
> > ideal, some support is provided and my point was at first to try implement SCMI
> > virtio polling leveraging what we have now in the core and see if it was attainable
> > (indeed I tried early in this series to avoid as a whole to have to support polling
> > at the SCMI transport layer to attain SCMI cmds atomicity..but that was an ill
> > attempt that led nowhere good...)
> > 
> > Btw, I was planning to post a new series next week (after merge-windows) with some
> > fixes I did already, at this point I'll include also some fixes derived
> > from some of your remarks.
> > 
> >> Best regards,
> >>
> >> Peter
> >>
> [snip]>>> + *
> >>> + * Return: True once polling has successfully completed.
> >>> + */
> >>> +static bool virtio_poll_done(struct scmi_chan_info *cinfo,
> >>> +			     struct scmi_xfer *xfer)
> >>> +{
> >>> +	bool pending, ret = false;
> >>> +	unsigned int length, any_prefetched = 0;
> >>> +	unsigned long flags;
> >>> +	struct scmi_vio_msg *next_msg, *msg = xfer->priv;
> >>> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
> >>> +
> >>> +	if (!msg)
> >>> +		return true;
> >>> +
> >>> +	spin_lock_irqsave(&msg->poll_lock, flags);
> >>> +	/* Processed already by other polling loop on another CPU ? */
> >>> +	if (msg->poll_idx == VIO_MSG_POLL_DONE) {
> >>> +		spin_unlock_irqrestore(&msg->poll_lock, flags);
> >>> +		return true;
> >>> +	}
> >>> +
> >>> +	/* Has cmdq index moved at all ? */
> >>> +	pending = virtqueue_poll(vioch->vqueue, msg->poll_idx);
> >>
> >> In my understanding, the polling comparison could still be subject to the ABA
> >> problem when exactly 2**16 messages have been marked as used since
> >> msg->poll_idx was set (unlikely scenario, granted).
> >>
> >> I think this would be a lot simpler if the virtio core exported some
> >> concurrency-safe helper function for such polling (similar to more_used() from
> >> virtio_ring.c), as discussed at the top.
> > 
> > So this is the main limitation indeed of the current implementation, I
> > cannot distinguish if there was an exact full wrap and I'm reading the same
> > last_idx as before but a whoppying 2**16 messages have instead gone through...
> > 
> > The tricky part seems to me here that even introducing dedicated helpers
> > for polling in order to account for such wrapping (similar to more_used())
> > those would be based by current VirtIO spec on a single bit wrap counter,
> > so how do you discern if 2 whole wraps have happened (even more unlikely..) ?
> > 
> > Maybe I'm missing something though...
> > 
> 
> In my understanding, there is no need to keep track of the old state. We
> actually only want to check whether the device has marked any buffers as `used'
> which we did not retrieve yet via virtqueue_get_buf_ctx().
> 
> This is what more_used() checks in my understanding. One would just need to
> translate the external `struct virtqueue' param to the virtio_ring.c internal
> representation `struct vring_virtqueue' and then call `more_used()'.
> 
> There would be no need to keep `poll_idx` then.
> 
> Best regards,
> 
> Peter

Not really, I don't think so.

There's no magic in more_used. No synchronization happens.
more_used is exactly like virtqueue_poll except
you get to maintain your own index.

As it is, it is quite possible to read the cached index,
then another thread makes 2^16 bufs available, then device
uses them all, and presto you get a false positive.

I guess we can play with memory barriers such that cache
read happens after the index read - but it seems that
will just lead to the same wrap around problem
in reverse. So IIUC it's quite a bit more involved than
just translating structures.

And yes, a more_used like API would remove the need to pass
the index around, but it will also obscure the fact that
there's internal state here and that it's inherently racy
wrt wrap arounds. Whereas I'm happy to see that virtqueue_poll
seems to have made it clear enough that people get it.


It's not hard to handle wrap around in the driver if you like though:
just have a 32 bit atomic counter and increment it each time you are
going to make 2^16 buffers available. That gets you to 2^48 with an
overhead of an atomic read and that should be enough short term. Make
sure the cache line where you put the counter is not needed elsewhere -
checking it in a tight loop with an atomic will force it to the local
CPU. And if you are doing that virtqueue_poll will be enough.



> 
> > I'll have a though about this, but in my opinion this seems something so
> > unlikely that we could live with it, for the moment at least...
> > [snip]

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
