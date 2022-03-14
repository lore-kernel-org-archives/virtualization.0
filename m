Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4140CC433F5
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 22:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC6B460F26;
	Mon, 14 Mar 2022 22:22:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xNcnh-uYvffP; Mon, 14 Mar 2022 22:22:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 52A2D60F20;
	Mon, 14 Mar 2022 22:22:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32B92C0012;
	Mon, 14 Mar 2022 22:22:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15FF6C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 22:22:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E444883E65
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 22:22:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cgs0ynamxGMR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 22:22:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06E7B8332A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 22:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647296546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=448GABWMYqDQxarVEaCkpTgjvImz20CTRUQciGD2cbU=;
 b=gjD4KdG+cn4QQvrn0f6VvPXDN20Qm6oze4ZdzYilGtObtTc2WWygxxjntrF45lTxHGZ4aB
 OrlPUrV9jxJ3jeCxhp+pEXHodbhK9GtwaTRwo+pPbYENXNxUaEehEhEUMWvoOTI+XjP8h2
 Ej9Q04kLPMK2UdDlcNlxj3YX/5BiFrc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-oTIiflf0MbqpsIIGNDQ39A-1; Mon, 14 Mar 2022 18:22:25 -0400
X-MC-Unique: oTIiflf0MbqpsIIGNDQ39A-1
Received: by mail-ej1-f72.google.com with SMTP id
 el10-20020a170907284a00b006db9df1f3bbso5224549ejc.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 15:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=448GABWMYqDQxarVEaCkpTgjvImz20CTRUQciGD2cbU=;
 b=jDT3ilyC9vlGZMcHfZN1Zj+gcJcCKjGRav3vuHi1sxlP/22V6W2J9JQMIs4YW8HOoT
 i6yNd96Mz/EvG2j5bbRE7M8iEZeZO2EmVNK/OusJHzAYRgw/f/GlEwyHqbrB7JOYq1E4
 sSxl6pD9bd10pqrcES4z4LxuojmrZ1o93OpOOoSBUsNnPfrAo1VmV97OHTua1JRbA3WE
 acsAKl8tN7Kdlu61WZYjwosHSoZhP+rbwdrldLJYWoecKbtyNxQaqu/zDxdPH3C2iaJN
 88gRrSfcOiCWoMbnHl8WFaYZHoUTkciDCZ8l+jo0UpcaT16kgJfpaRIk+F98L4r84mHd
 dkKw==
X-Gm-Message-State: AOAM531h7mrXJFpjmYbiQM3qI9mVZgWAWvjEpWka08ITL5xmKVm0FQS+
 qAfK/dMqiYbqZP2QRIUF82y4OrPhtnGjoesUDbJZJNsqES/Yx+a/EfEmUPYC/ffgiSVspdvx78g
 n4CTfnwHfTL58sbY19PXvEnHCt5Kfl8E/BAK21xlw+A==
X-Received: by 2002:a17:907:94cd:b0:6d9:89e1:3036 with SMTP id
 dn13-20020a17090794cd00b006d989e13036mr21208054ejc.231.1647296544138; 
 Mon, 14 Mar 2022 15:22:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTESGPdMCjU7Jvr1WtD2xxT/v+GSQHRJ65ip+MO0R/5zTFOd1YnfN3O5Oeqw3yqAVrM+g/Qw==
X-Received: by 2002:a17:907:94cd:b0:6d9:89e1:3036 with SMTP id
 dn13-20020a17090794cd00b006d989e13036mr21208038ejc.231.1647296543907; 
 Mon, 14 Mar 2022 15:22:23 -0700 (PDT)
Received: from redhat.com ([176.12.250.92]) by smtp.gmail.com with ESMTPSA id
 kw3-20020a170907770300b006d2a835ac33sm7408819ejc.197.2022.03.14.15.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Mar 2022 15:22:23 -0700 (PDT)
Date: Mon, 14 Mar 2022 18:22:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <20220314182148-mutt-send-email-mst@kernel.org>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <20220311103549-mutt-send-email-mst@kernel.org>
 <YitzuxYHywdCRKVO@localhost.localdomain>
 <c91ad1e9-8c5b-ff1e-7e7f-8590ea6c67e8@nvidia.com>
 <Yi8OSE2hYoS8rSEo@localhost.localdomain>
 <e441429b-90ef-a2e4-1365-3f55c7ff21d0@nvidia.com>
 <20220314071222-mutt-send-email-mst@kernel.org>
 <d9121e3c-abe5-fe4d-8088-8339c418c7a8@nvidia.com>
 <20220314111306-mutt-send-email-mst@kernel.org>
 <332c35ec-734b-d2bd-dd0f-c577b1c6174b@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <332c35ec-734b-d2bd-dd0f-c577b1c6174b@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com,
 Suwan Kim <suwan.kim027@gmail.com>
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

On Mon, Mar 14, 2022 at 06:33:06PM +0200, Max Gurtovoy wrote:
> 
> On 3/14/2022 5:15 PM, Michael S. Tsirkin wrote:
> > On Mon, Mar 14, 2022 at 03:26:13PM +0200, Max Gurtovoy wrote:
> > > On 3/14/2022 1:15 PM, Michael S. Tsirkin wrote:
> > > > On Mon, Mar 14, 2022 at 12:25:08PM +0200, Max Gurtovoy wrote:
> > > > > On 3/14/2022 11:43 AM, Suwan Kim wrote:
> > > > > > On Sun, Mar 13, 2022 at 12:37:21PM +0200, Max Gurtovoy wrote:
> > > > > > > On 3/11/2022 6:07 PM, Suwan Kim wrote:
> > > > > > > > On Fri, Mar 11, 2022 at 10:38:07AM -0500, Michael S. Tsirkin wrote:
> > > > > > > > > On Sat, Mar 12, 2022 at 12:28:32AM +0900, Suwan Kim wrote:
> > > > > > > > > > diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> > > > > > > > > > index d888f013d9ff..3fcaf937afe1 100644
> > > > > > > > > > --- a/include/uapi/linux/virtio_blk.h
> > > > > > > > > > +++ b/include/uapi/linux/virtio_blk.h
> > > > > > > > > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > > > > > > > > >      	 * deallocation of one or more of the sectors.
> > > > > > > > > >      	 */
> > > > > > > > > >      	__u8 write_zeroes_may_unmap;
> > > > > > > > > > +	__u8 unused1;
> > > > > > > > > > -	__u8 unused1[3];
> > > > > > > > > > +	__virtio16 num_poll_queues;
> > > > > > > > > >      } __attribute__((packed));
> > > > > > > > > Same as any virtio UAPI change, this has to go through the virtio TC.
> > > > > > > > > In particular I don't think gating a new config field on
> > > > > > > > > an existing feature flag is a good idea.
> > > > > > > > Did you mean that the polling should be based on a new feature like
> > > > > > > > "VIRTIO_BLK_F_POLL" and be added at the end of features_legacy[]
> > > > > > > > and features[]? If then, I will add the new feture flag and resend it.
> > > > > > > Isn't there a way in the SPEC today to create a queue without interrupt
> > > > > > > vector ?
> > > > > > It seems that it is not possible to create a queue without interrupt
> > > > > > vector. If it is possible, we can expect more polling improvement.
> > > > Yes, it's possible:
> > > > 
> > > > Writing a valid MSI-X Table entry number, 0 to 0x7FF, to
> > > > \field{config_msix_vector}/\field{queue_msix_vector} maps interrupts triggered
> > > > by the configuration change/selected queue events respectively to
> > > > the corresponding MSI-X vector. To disable interrupts for an
> > > > event type, the driver unmaps this event by writing a special NO_VECTOR
> > > > value:
> > > > 
> > > > \begin{lstlisting}
> > > > /* Vector value used to disable MSI for queue */
> > > > #define VIRTIO_MSI_NO_VECTOR            0xffff
> > > > \end{lstlisting}
> > > > 
> > > > 
> > > > 
> > > > > MST/Jason/Stefan,
> > > > > 
> > > > > can you confirm that please ?
> > > > > 
> > > > > what does VIRTQ_AVAIL_F_NO_INTERRUPT supposed to do ?
> > > > This is a hint to the device not to send interrupts.
> > > Why do you need a hint if the driver implicitly wrote 0xffff to disable MSI
> > > for a virtqueue ?
> > 
> > VIRTIO_MSI_NO_VECTOR is an expensive write into config space, followed
> > by an even more expensive read. Reliable and appropriate if you turn
> > events on/off very rarely.
> > 
> > VIRTQ_AVAIL_F_NO_INTERRUPT is an in-memory write so it's much cheaper,
> > but it's less reliable. Appropriate if you need to turn events on/off a
> > lot.
> 
> An "expensive" operation in the ctrl path during vq creation is fine IMO.

Yes.

> I see that nobody even used VIRTQ_AVAIL_F_NO_INTERRUPT in-memory write in
> Linux.

Because it's called VRING_AVAIL_F_NO_INTERRUPT there.

> > 
> > 
> > > > > > Regards,
> > > > > > Suwan Kim

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
