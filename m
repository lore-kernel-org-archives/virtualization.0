Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD7FC433F5
	for <virtualization@archiver.kernel.org>; Fri, 29 Apr 2022 02:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9FB1611CF;
	Fri, 29 Apr 2022 02:09:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uGO-TQJDn4O1; Fri, 29 Apr 2022 02:09:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6025661198;
	Fri, 29 Apr 2022 02:09:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 340B4C0032;
	Fri, 29 Apr 2022 02:09:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BF8EC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 02:09:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE467611A0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 02:09:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 56FjktykIMrN
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 02:09:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2859E61198
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 02:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651198142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n1hFr6Yi4j7w9u2wUwkc3nSsLkNRf93uROLqf4bH3hw=;
 b=OPZGuSwnPLXoWNspjWejbyYHMInLitx54MWnGdpXQs9L+wPRip5DaUkum1X+UawuOM0YfE
 wVLVb+Yq/1KDWxwjYHTjv5WoM3TAzaRh3LS1wrKyV1orpEfCX2YofE5j1DaecZkFyaA1OG
 NUEjgmfHz30wB/ESG4r3JU7foFjIpqQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-mhOPR4t6Oqe-f0opmVXiSg-1; Thu, 28 Apr 2022 22:08:53 -0400
X-MC-Unique: mhOPR4t6Oqe-f0opmVXiSg-1
Received: by mail-lf1-f69.google.com with SMTP id
 h4-20020a0565123c8400b00471f8c2a09eso2717287lfv.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 19:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n1hFr6Yi4j7w9u2wUwkc3nSsLkNRf93uROLqf4bH3hw=;
 b=FdIzeIFDVdbnVN7qYfggxvmVXnaoQPouxXg1B1qj7o6h6eCA2Iu0QYe2TxJhHM8aUP
 c0UtQN/vm7pH16o0pTWPbluyEabf5LY3HheWegTTae6RbJc0YI5oibiEcdAyX3dvXwF3
 DnvxNGq3q4zcB9cpJE24ddbkwE9ER6flT342Kn0ooto60YmFnlq5d09Dhj6hgxAoO7iW
 uBnd9kcKjK5RbW3ZGgtEWBSE6NA6o1ujiozEh0Wf33A7Uf276tnpsPyqsUqgvYOsQVXv
 KcGhAawVvk9DC2UnYPK9II3ovXQcRkLXNHAMZOucGFLx6TkkRoxHHgomTKCBb7rJgHj2
 Vd+Q==
X-Gm-Message-State: AOAM532xL1GIqKJenU+IJ1aXp8b2PjNOeDG7DAGEBAJpUr759PBdLojl
 CjfoJjULyTnSkDOTyNCB0dVlRTrakOcwEObf9ANXBRvIs4mY7GybWjCfTX12Es2zzYq2giPGgpQ
 qnlo8Yih7O4IJBj/eXjwSW4/PmP/BayfSETxA4BcfHOSz84sEfDZQYxLdmw==
X-Received: by 2002:a05:651c:892:b0:249:9e23:15 with SMTP id
 d18-20020a05651c089200b002499e230015mr23697093ljq.492.1651198131736; 
 Thu, 28 Apr 2022 19:08:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxg9jpPQWsuBYVjm9WMW0PBgw9VuFnAduhGEOWG/ZXQHEFn6JmM4VwclH4MDqex/tZ+M8KTzTqL1c5etuwsVIY=
X-Received: by 2002:a05:651c:892:b0:249:9e23:15 with SMTP id
 d18-20020a05651c089200b002499e230015mr23697078ljq.492.1651198131581; Thu, 28
 Apr 2022 19:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-4-jasowang@redhat.com>
 <87r15hlgel.fsf@redhat.com>
In-Reply-To: <87r15hlgel.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 29 Apr 2022 10:08:40 +0800
Message-ID: <CACGkMEsrSHtD9iO1qHjMGgwG5YwYVpX+7OKZaN9Oq29tPpGZYg@mail.gmail.com>
Subject: Re: [PATCH V3 3/9] virtio: introduce config op to synchronize vring
 callbacks
To: Cornelia Huck <cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Cindy Lu <lulu@redhat.com>,
 mst <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Thu, Apr 28, 2022 at 5:13 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Mon, Apr 25 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > This patch introduces new virtio config op to vring
> > callbacks. Transport specific method is required to make sure the
> > write before this function is visible to the vring_interrupt() that is
>
> Which kind of writes? I.e., what is the scope?

Any writes before synchronize_cbs(). Is something like the following better?

The function guarantees that all memory operations before it are
visible to the vring_interrupt() that is called after it.

>
> > called after the return of this function. For the transport that
> > doesn't provide synchronize_vqs(), use synchornize_rcu() which
>
> Typo: synchronize_rcu()

Will fix it.

Thanks

>
> > synchronize with IRQ implicitly as a fallback.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Halil Pasic <pasic@linux.ibm.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  include/linux/virtio_config.h | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index b341dd62aa4d..14fe89ff99c7 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -57,6 +57,10 @@ struct virtio_shm_region {
> >   *           include a NULL entry for vqs unused by driver
> >   *   Returns 0 on success or error status
> >   * @del_vqs: free virtqueues found by find_vqs().
> > + * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
> > + *      Make sure the writes commited before this method is visible to
> > + *      vring_interrupt() which is called after this method.
>
> Same here, I think the description needs to be a bit more explicit about
> which writes we care about here.
>
> > + *      vdev: the virtio_device
> >   * @get_features: get the array of feature bits for this device.
> >   *   vdev: the virtio_device
> >   *   Returns the first 64 feature bits (all we currently need).
> > @@ -89,6 +93,7 @@ struct virtio_config_ops {
> >                       const char * const names[], const bool *ctx,
> >                       struct irq_affinity *desc);
> >       void (*del_vqs)(struct virtio_device *);
> > +     void (*synchronize_cbs)(struct virtio_device *);
> >       u64 (*get_features)(struct virtio_device *vdev);
> >       int (*finalize_features)(struct virtio_device *vdev);
> >       const char *(*bus_name)(struct virtio_device *vdev);
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
