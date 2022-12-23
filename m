Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFDAC4167B
	for <virtualization@archiver.kernel.org>; Fri, 23 Dec 2022 03:04:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC110417BC;
	Fri, 23 Dec 2022 03:04:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC110417BC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LnQtYyap
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P6EaIJqwf_kP; Fri, 23 Dec 2022 03:04:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 29926410DE;
	Fri, 23 Dec 2022 03:04:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29926410DE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F22FCC0071;
	Fri, 23 Dec 2022 03:04:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4D91C0070
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 03:04:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F0AA80C14
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 03:04:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F0AA80C14
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LnQtYyap
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mS6LS53s-sVR
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 03:04:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AEABA80A54
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AEABA80A54
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 03:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671764652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nk22SddT8s32uuy10mS2yxkS5L294EJjQs4S55LMRvI=;
 b=LnQtYyapObiIaYhPtDb71yldwiIwSrxyYnMQGOrxXO20iKDMcJ9c5kmBuSu3l3mcYygoE1
 at2pz4+jQM3SdbyNp2IlvrArOph3JsOYZgbQ3/Gor7zQBBXOCsrHF0dg4ulI6UvaoNcYeR
 D43/aPd0eeEcJjWHqRtylUhkYm49MWI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-281-7sL52CR3N0-1hLwxJHpcfA-1; Thu, 22 Dec 2022 22:04:11 -0500
X-MC-Unique: 7sL52CR3N0-1hLwxJHpcfA-1
Received: by mail-ot1-f69.google.com with SMTP id
 f39-20020a9d03aa000000b006705c6992daso1954519otf.14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 19:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nk22SddT8s32uuy10mS2yxkS5L294EJjQs4S55LMRvI=;
 b=y++4AEW0iCs5dIFg1dS5GAQRjSOcreRSCG2XVIUHm0KqG7Ju+KyHuLzuly5r5K7Tys
 ILgJhduZgdfs11eJmQmbdGL664NxQ4vlklOZ3OwsjK+VNYi7OEs1mpqwnaIJlau5E9I1
 Q8JRkijHq70+nS5LOn4hV3tVSmDtMjddf4YilhNL2nyYV+WanH8Kc+w66kxB4G/HDXlQ
 rfFPa2D+BGvNGfgJ5mlTOpRGNdi3mqjtfUy2+t1T1ydK1J0Zzsdm7dCsYwsujhpx7lG9
 o0rG3MsYdUcqzAbM1OKZ+jVZEg8mUhIanPktu6R+/WubVzXpl3iF7VLa/ax6dqWC1Bk3
 VPcA==
X-Gm-Message-State: AFqh2kpCZmgCGggvv+/NUruVMk20u5FYvCnd+pX/Ucy1ujZ/Vxd2yL0R
 flxMejbzN5RCmK4gMWMfav2wEaJKwvUf3XIEC9cJVgzpOk2Ty443aoKjWld+Z40S0WtaaK97ZNm
 +tiKw7rIkkXoU9ueuQerDj9Bf6ZzW/O4SmFgV5ni7BBjU0t8A8NqdeAnLPA==
X-Received: by 2002:a54:4e89:0:b0:35c:303d:fe37 with SMTP id
 c9-20020a544e89000000b0035c303dfe37mr218401oiy.35.1671764650578; 
 Thu, 22 Dec 2022 19:04:10 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsbL3LlKBLthwI89NipAwg3/BzVWpLTk8GXoTYMUIMS3DQO3dU//K5z2UA8qfcPRw+PutWyU9/4ADoDgk3Mic0=
X-Received: by 2002:a54:4e89:0:b0:35c:303d:fe37 with SMTP id
 c9-20020a544e89000000b0035c303dfe37mr218393oiy.35.1671764650344; Thu, 22 Dec
 2022 19:04:10 -0800 (PST)
MIME-Version: 1.0
References: <20221222060427.21626-1-jasowang@redhat.com>
 <20221222060427.21626-5-jasowang@redhat.com>
 <CAJaqyWetutMj=GrR+ieS265_aRr7OhoP+7O5rWgPnP+ZAyxbPg@mail.gmail.com>
In-Reply-To: <CAJaqyWetutMj=GrR+ieS265_aRr7OhoP+7O5rWgPnP+ZAyxbPg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 23 Dec 2022 11:03:59 +0800
Message-ID: <CACGkMEvs6QenyQNR0GyJ81PgT-w2fy7Rag-JkJ7xNGdNZLGSfQ@mail.gmail.com>
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

On Thu, Dec 22, 2022 at 5:19 PM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Dec 22, 2022 at 7:05 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > We used to busy waiting on the cvq command this tends to be
> > problematic since:
> >
> > 1) CPU could wait for ever on a buggy/malicous device
> > 2) There's no wait to terminate the process that triggers the cvq
> >    command
> >
> > So this patch switch to use sleep with a timeout (1s) instead of busy
> > polling for the cvq command forever. This gives the scheduler a breath
> > and can let the process can respond to a signal.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 8225496ccb1e..69173049371f 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -405,6 +405,7 @@ static void disable_rx_mode_work(struct virtnet_info *vi)
> >         vi->rx_mode_work_enabled = false;
> >         spin_unlock_bh(&vi->rx_mode_lock);
> >
> > +       virtqueue_wake_up(vi->cvq);
> >         flush_work(&vi->rx_mode_work);
> >  }
> >
> > @@ -1497,6 +1498,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
> >         return !oom;
> >  }
> >
> > +static void virtnet_cvq_done(struct virtqueue *cvq)
> > +{
> > +       virtqueue_wake_up(cvq);
> > +}
> > +
> >  static void skb_recv_done(struct virtqueue *rvq)
> >  {
> >         struct virtnet_info *vi = rvq->vdev->priv;
> > @@ -2024,12 +2030,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> >         if (unlikely(!virtqueue_kick(vi->cvq)))
> >                 return vi->ctrl->status == VIRTIO_NET_OK;
> >
> > -       /* Spin for a response, the kick causes an ioport write, trapping
> > -        * into the hypervisor, so the request should be handled immediately.
> > -        */
> > -       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > -              !virtqueue_is_broken(vi->cvq))
> > -               cpu_relax();
> > +       virtqueue_wait_for_used(vi->cvq, &tmp);
> >
> >         return vi->ctrl->status == VIRTIO_NET_OK;
> >  }
> > @@ -3524,7 +3525,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> >
> >         /* Parameters for control virtqueue, if any */
> >         if (vi->has_cvq) {
> > -               callbacks[total_vqs - 1] = NULL;
> > +               callbacks[total_vqs - 1] = virtnet_cvq_done;
>
> If we're using CVQ callback, what is the actual use of the timeout?

Because we can't sleep forever since locks could be held like RTNL_LOCK.

>
> I'd say there is no right choice neither in the right timeout value
> nor in the action to take.

In the next version, I tend to put BAD_RING() to prevent future requests.

> Why not simply trigger the cmd and do all
> the changes at command return?

I don't get this, sorry.

>
> I suspect the reason is that it complicates the code. For example,
> having the possibility of many in flight commands, races between their
> completion, etc.

Actually the cvq command was serialized through RTNL_LOCK, so we don't
need to worry about this.

In the next version I can add ASSERT_RTNL().

Thanks

> The virtio standard does not even cover unordered
> used commands if I'm not wrong.
>
> Is there any other fundamental reason?
>
> Thanks!
>
> >                 names[total_vqs - 1] = "control";
> >         }
> >
> > --
> > 2.25.1
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
