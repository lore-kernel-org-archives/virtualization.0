Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780B8C3DA79
	for <virtualization@archiver.kernel.org>; Mon, 26 Dec 2022 03:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D988F607AA;
	Mon, 26 Dec 2022 03:45:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D988F607AA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cZKDOz9t
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZCk-AEaOlTod; Mon, 26 Dec 2022 03:45:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1480B60746;
	Mon, 26 Dec 2022 03:45:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1480B60746
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF26CC0035;
	Mon, 26 Dec 2022 03:45:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92B94C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 03:45:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6DA0C40298
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 03:45:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6DA0C40298
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cZKDOz9t
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aOXNjm7fklzF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 03:45:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C45640104
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C45640104
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 03:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672026314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v6UhDCmakXh8a6UllVBzSFIWUqyi4qvcOl3b6DYLJeI=;
 b=cZKDOz9tviPnLcYqPTlIxw2qUsepAYdi+T0wNAYjXtkVsQtSMlvCwOipjavRXVN6r87kn2
 F6HYeX2enHMLYo2O1UgpxO2umhhFOT7tfyf5N6udSCyn/RssWz2LA86ky5H14KKM3SdwZC
 mqrVi7xOW1bFoWTs3eeQivjYi873hYo=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-85-fwHAzd7bMM6ayfS4F7-Bhw-1; Sun, 25 Dec 2022 22:45:05 -0500
X-MC-Unique: fwHAzd7bMM6ayfS4F7-Bhw-1
Received: by mail-ot1-f72.google.com with SMTP id
 o11-20020a9d6d0b000000b0067074f355b3so5887444otp.23
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Dec 2022 19:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v6UhDCmakXh8a6UllVBzSFIWUqyi4qvcOl3b6DYLJeI=;
 b=vciEYIbJdIiT1ogLzab5vyDAavpOVpR20Ke6WpcPsWKsHO03Clnq1qWRVUTEK9s9fU
 eS87XZ8hRZ/nw/bTyVtBrAkqN0jTLfUBku7SEZ37ZOBeDWChKRorukMV0wfVy0UM86dh
 jRgJ8qT/21Z7m6QWmXnmjOTLU+RKEYE5JDiET4NnmlEciHNPTIi21524x+jkuCOx2l24
 +Ud2wYpj+UrHeJsfpuIisWhr1RbTVy27iijBraofenl8ERHqJ/6MnkQ1laqzlyDa5uOr
 O7CURRhKaZa1kdPjyJ0fnUdT1j3ZAtySkYwgj/1OyygHh87DN6vmuGIdP6VVpRbf0Ws+
 9EKw==
X-Gm-Message-State: AFqh2kp9zqe2/4sH+WKXtfiqO8846Ml4TOgydptrwRhr/J3JUZYt2ge3
 ddMq3NPX/makmdQBhV3lDTmWvC01RJUwodYljXiC4fgM9JIjfTLyZqHpny3ODQhLIJaVCGwFLru
 O9MZ8efZMYtFxPs9fQ+x0pJ0K7xQ8RF2rmiMjkC3CQA7JwmLv0pipDKYQSQ==
X-Received: by 2002:a9d:7843:0:b0:678:1eb4:3406 with SMTP id
 c3-20020a9d7843000000b006781eb43406mr1074890otm.237.1672026304541; 
 Sun, 25 Dec 2022 19:45:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuuFZprgssl3UYeZRNHdhEmv9X+l3MPWp5HXJ8UsDPnAmMUZUZsmZJzzO7LV6M+colYpmnRAcxyg0NMseykUt0=
X-Received: by 2002:a9d:7843:0:b0:678:1eb4:3406 with SMTP id
 c3-20020a9d7843000000b006781eb43406mr1074880otm.237.1672026304284; Sun, 25
 Dec 2022 19:45:04 -0800 (PST)
MIME-Version: 1.0
References: <20221222060427.21626-1-jasowang@redhat.com>
 <20221222060427.21626-5-jasowang@redhat.com>
 <CAJaqyWetutMj=GrR+ieS265_aRr7OhoP+7O5rWgPnP+ZAyxbPg@mail.gmail.com>
 <CACGkMEvs6QenyQNR0GyJ81PgT-w2fy7Rag-JkJ7xNGdNZLGSfQ@mail.gmail.com>
 <CAJaqyWfJriGB1aLJ8BWZnnZ+fYrpwpkwxSAmKhzmYE72VWBvEA@mail.gmail.com>
In-Reply-To: <CAJaqyWfJriGB1aLJ8BWZnnZ+fYrpwpkwxSAmKhzmYE72VWBvEA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Dec 2022 11:44:53 +0800
Message-ID: <CACGkMEuZqe8=hmn+SWFb6DZ+8BgTJ5xiaXTMTnz_4Cc0b1E0pg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq
 command
To: Eugenio Perez Martin <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 maxime.coquelin@redhat.com, kuba@kernel.org, pabeni@redhat.com,
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

On Fri, Dec 23, 2022 at 4:05 PM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Dec 23, 2022 at 4:04 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, Dec 22, 2022 at 5:19 PM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Thu, Dec 22, 2022 at 7:05 AM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > We used to busy waiting on the cvq command this tends to be
> > > > problematic since:
> > > >
> > > > 1) CPU could wait for ever on a buggy/malicous device
> > > > 2) There's no wait to terminate the process that triggers the cvq
> > > >    command
> > > >
> > > > So this patch switch to use sleep with a timeout (1s) instead of busy
> > > > polling for the cvq command forever. This gives the scheduler a breath
> > > > and can let the process can respond to a signal.
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 15 ++++++++-------
> > > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 8225496ccb1e..69173049371f 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -405,6 +405,7 @@ static void disable_rx_mode_work(struct virtnet_info *vi)
> > > >         vi->rx_mode_work_enabled = false;
> > > >         spin_unlock_bh(&vi->rx_mode_lock);
> > > >
> > > > +       virtqueue_wake_up(vi->cvq);
> > > >         flush_work(&vi->rx_mode_work);
> > > >  }
> > > >
> > > > @@ -1497,6 +1498,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
> > > >         return !oom;
> > > >  }
> > > >
> > > > +static void virtnet_cvq_done(struct virtqueue *cvq)
> > > > +{
> > > > +       virtqueue_wake_up(cvq);
> > > > +}
> > > > +
> > > >  static void skb_recv_done(struct virtqueue *rvq)
> > > >  {
> > > >         struct virtnet_info *vi = rvq->vdev->priv;
> > > > @@ -2024,12 +2030,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > > >         if (unlikely(!virtqueue_kick(vi->cvq)))
> > > >                 return vi->ctrl->status == VIRTIO_NET_OK;
> > > >
> > > > -       /* Spin for a response, the kick causes an ioport write, trapping
> > > > -        * into the hypervisor, so the request should be handled immediately.
> > > > -        */
> > > > -       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > -              !virtqueue_is_broken(vi->cvq))
> > > > -               cpu_relax();
> > > > +       virtqueue_wait_for_used(vi->cvq, &tmp);
> > > >
> > > >         return vi->ctrl->status == VIRTIO_NET_OK;
> > > >  }
> > > > @@ -3524,7 +3525,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > > >
> > > >         /* Parameters for control virtqueue, if any */
> > > >         if (vi->has_cvq) {
> > > > -               callbacks[total_vqs - 1] = NULL;
> > > > +               callbacks[total_vqs - 1] = virtnet_cvq_done;
> > >
> > > If we're using CVQ callback, what is the actual use of the timeout?
> >
> > Because we can't sleep forever since locks could be held like RTNL_LOCK.
> >
>
> Right, rtnl_lock kind of invalidates it for a general case.
>
> But do all of the commands need to take rtnl_lock? For example I see
> how we could remove it from ctrl_announce,

I think not, it's intended to serialize all cvq commands.

> so lack of ack may not be
> fatal for it.

Then there could be more than one cvq commands sent to the device, the
busy poll logic may not work.

And it's a hint that the device malfunctioned which is something that
the driver should be aware of.

Thanks

> Assuming a buggy device, we can take some cvq commands
> out of this fatal situation.
>
> This series already improves the current situation and my suggestion
> (if it's worth it) can be applied on top of it, so it is not a blocker
> at all.
>
> > >
> > > I'd say there is no right choice neither in the right timeout value
> > > nor in the action to take.
> >
> > In the next version, I tend to put BAD_RING() to prevent future requests.
> >
> > > Why not simply trigger the cmd and do all
> > > the changes at command return?
> >
> > I don't get this, sorry.
> >
>
> It's actually expanding the first point so you already answered it :).
>
> Thanks!
>
> > >
> > > I suspect the reason is that it complicates the code. For example,
> > > having the possibility of many in flight commands, races between their
> > > completion, etc.
> >
> > Actually the cvq command was serialized through RTNL_LOCK, so we don't
> > need to worry about this.
> >
> > In the next version I can add ASSERT_RTNL().
> >
> > Thanks
> >
> > > The virtio standard does not even cover unordered
> > > used commands if I'm not wrong.
> > >
> > > Is there any other fundamental reason?
> > >
> > > Thanks!
> > >
> > > >                 names[total_vqs - 1] = "control";
> > > >         }
> > > >
> > > > --
> > > > 2.25.1
> > > >
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
