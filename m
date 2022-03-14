Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C79C433EF
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 15:13:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6269B4019C;
	Mon, 14 Mar 2022 15:13:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xAqJc0Ecnp3C; Mon, 14 Mar 2022 15:13:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3BD94404AA;
	Mon, 14 Mar 2022 15:13:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3A81C001D;
	Mon, 14 Mar 2022 15:13:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65581C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 15:12:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 415CC60AEA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 15:12:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x4L8k2sWL4Sx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 15:12:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8671A6068B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 15:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647270777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xm5VItqmMeZ6zs2ROdtREMMlUCtcYW6wNdINQGNfwNM=;
 b=TQuv7wTeFM56xiFtqtZrfXy3HP9qra5+64JDSMheFlDQzx+27ctkREUT+aPd8J89R7wzSb
 qcmxtJ9O/m1SIV/10OwV7wVhlVnQbbewMOTds4ycuLKAk8VrEm5/xNom9Mp+THFu00fDw2
 6k+NhaEnuamgJxQBin98wmo+1lEC/AE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-xt2uifheOv2LrKMqOSv86Q-1; Mon, 14 Mar 2022 11:12:55 -0400
X-MC-Unique: xt2uifheOv2LrKMqOSv86Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 l10-20020a05600012ca00b001f1e4669c98so4453714wrx.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 08:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Xm5VItqmMeZ6zs2ROdtREMMlUCtcYW6wNdINQGNfwNM=;
 b=rc4wg6jXDKsg9YdhaS7O5TanRHyrNqevbgoWtwCQORuHuw+vfO4W17kngXntf++3up
 04uOkFtxgUlZgjyDDSnAhSX53M0ebr9sIq9dSXOz4eMAVIJXtzdoswrznZd8bnPuwM6o
 UJ6BqbmhY4j4oU+/y6MSf/PQvrJTllH89W0j0Unrwu7rLJbd4+GvQIvfbO0NKLsyNXQk
 n/7yX1zbITLO0dAndrcaerKUo7y4WDhauMlEt3hDj6rbaHJcL0++kkyf6cdLHWNtQPwg
 VNRN7Vk9aYFZhzR2CgVJU0APNoZd6ih6mIETDEXYyBPHyWgBeBOskCpYtBTvNn8s6FeG
 j1eg==
X-Gm-Message-State: AOAM530zkOtK4KyiH40d/RbkdR/vyJ0gg+WxBUGbX8Rr4AqUHY/Qz0pg
 0gKr0wjNjiabjTs5o0f9x/Wc0C58TpPnP7wAhto854kmwzPaa0LdcP+hKNOL6Cb3XfJCtI33Mma
 cLu764loIpjqDbRfRSoQYnO9Nwb3wxpjtM2SHbj97jA==
X-Received: by 2002:a5d:62cd:0:b0:1f0:23d2:b38c with SMTP id
 o13-20020a5d62cd000000b001f023d2b38cmr17563844wrv.82.1647270774507; 
 Mon, 14 Mar 2022 08:12:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXqZHlp62TJ7mYscv84hghthLLQrKhjSIjAq6n5pdy+N/m2JFUJhUTeMR6qQTGPLmhq1InIw==
X-Received: by 2002:a5d:62cd:0:b0:1f0:23d2:b38c with SMTP id
 o13-20020a5d62cd000000b001f023d2b38cmr17563826wrv.82.1647270774280; 
 Mon, 14 Mar 2022 08:12:54 -0700 (PDT)
Received: from redhat.com ([2.55.155.245]) by smtp.gmail.com with ESMTPSA id
 c2-20020a056000184200b002037b40de23sm13481923wri.8.2022.03.14.08.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Mar 2022 08:12:53 -0700 (PDT)
Date: Mon, 14 Mar 2022 11:12:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <20220314111239-mutt-send-email-mst@kernel.org>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <20220311103549-mutt-send-email-mst@kernel.org>
 <YitzuxYHywdCRKVO@localhost.localdomain>
 <c91ad1e9-8c5b-ff1e-7e7f-8590ea6c67e8@nvidia.com>
 <Yi8OSE2hYoS8rSEo@localhost.localdomain>
 <e441429b-90ef-a2e4-1365-3f55c7ff21d0@nvidia.com>
 <20220314071222-mutt-send-email-mst@kernel.org>
 <Yi9BeVK3GbFrxIgB@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <Yi9BeVK3GbFrxIgB@localhost.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com
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

On Mon, Mar 14, 2022 at 10:22:01PM +0900, Suwan Kim wrote:
> On Mon, Mar 14, 2022 at 07:15:18AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Mar 14, 2022 at 12:25:08PM +0200, Max Gurtovoy wrote:
> > > 
> > > On 3/14/2022 11:43 AM, Suwan Kim wrote:
> > > > On Sun, Mar 13, 2022 at 12:37:21PM +0200, Max Gurtovoy wrote:
> > > > > On 3/11/2022 6:07 PM, Suwan Kim wrote:
> > > > > > On Fri, Mar 11, 2022 at 10:38:07AM -0500, Michael S. Tsirkin wrote:
> > > > > > > On Sat, Mar 12, 2022 at 12:28:32AM +0900, Suwan Kim wrote:
> > > > > > > > diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> > > > > > > > index d888f013d9ff..3fcaf937afe1 100644
> > > > > > > > --- a/include/uapi/linux/virtio_blk.h
> > > > > > > > +++ b/include/uapi/linux/virtio_blk.h
> > > > > > > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > > > > > > >    	 * deallocation of one or more of the sectors.
> > > > > > > >    	 */
> > > > > > > >    	__u8 write_zeroes_may_unmap;
> > > > > > > > +	__u8 unused1;
> > > > > > > > -	__u8 unused1[3];
> > > > > > > > +	__virtio16 num_poll_queues;
> > > > > > > >    } __attribute__((packed));
> > > > > > > Same as any virtio UAPI change, this has to go through the virtio TC.
> > > > > > > In particular I don't think gating a new config field on
> > > > > > > an existing feature flag is a good idea.
> > > > > > Did you mean that the polling should be based on a new feature like
> > > > > > "VIRTIO_BLK_F_POLL" and be added at the end of features_legacy[]
> > > > > > and features[]? If then, I will add the new feture flag and resend it.
> > > > > Isn't there a way in the SPEC today to create a queue without interrupt
> > > > > vector ?
> > > > It seems that it is not possible to create a queue without interrupt
> > > > vector. If it is possible, we can expect more polling improvement.
> > 
> > Yes, it's possible:
> > 
> > Writing a valid MSI-X Table entry number, 0 to 0x7FF, to
> > \field{config_msix_vector}/\field{queue_msix_vector} maps interrupts triggered
> > by the configuration change/selected queue events respectively to
> > the corresponding MSI-X vector. To disable interrupts for an
> > event type, the driver unmaps this event by writing a special NO_VECTOR
> > value:
> > 
> > \begin{lstlisting}
> > /* Vector value used to disable MSI for queue */
> > #define VIRTIO_MSI_NO_VECTOR            0xffff
> > \end{lstlisting}
>  
> Thanks for the information.
> 
> Then, in function vp_find_vqs_msix() at virtio_pci_common.c, it sets
> VIRTIO_MSI_NO_VECTOR if vritqueue->callback is NULL as below code.
> 
> static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
> 		struct virtqueue *vqs[], vq_callback_t *callbacks[],
> ...
> 		if (!callbacks[i])
> 			msix_vec = VIRTIO_MSI_NO_VECTOR;
> ...
> 
> In oder to create poll queue in virtio-blk, I set NULL callback for
> poll virtqueues and it will create queue without irq.
> 
> Regards,
> Suwan Kim

Yes, it will.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
