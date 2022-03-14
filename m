Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B22EC433EF
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 15:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C3C3414A1;
	Mon, 14 Mar 2022 15:15:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fBAJXyz_vm9i; Mon, 14 Mar 2022 15:15:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AAA474148F;
	Mon, 14 Mar 2022 15:15:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D37BC001D;
	Mon, 14 Mar 2022 15:15:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B98FC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 15:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 334298330B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 15:15:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sQAkNfuTKPyP
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 15:15:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D17D832D1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 15:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647270942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SvxQBenhY0K2tHuSKRLu17L4DvLSraMyryG81r/SsG8=;
 b=cdWpw1RO79FSQ7zKZcRJbrnSh4dvr0zACwxLbVVf4dqJXfkT2d26rlyFVVUJhBGIiIp8Fu
 Z0lil7/NG/DGs7puMDYcOJjkqShhG90aflLXMMsY3B0uuNnHqGwEoPPHn0TcXtVUUTpcLa
 HnIE1BPbLzFOfwvwUb4p3QysO7sjWM0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-ovIdbTkJPAiErzW59ynGDA-1; Mon, 14 Mar 2022 11:15:41 -0400
X-MC-Unique: ovIdbTkJPAiErzW59ynGDA-1
Received: by mail-wm1-f70.google.com with SMTP id
 20-20020a05600c231400b00389886f6b23so7151091wmo.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 08:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SvxQBenhY0K2tHuSKRLu17L4DvLSraMyryG81r/SsG8=;
 b=YokknNSMG352xH0u9+6qCMiKABKBB+tK2D3uOx3llYlY/WHGcfc/z8lRXOeR/yUMSl
 2MXOIarkSia0KMpi8zM4M95duMHZYgJZmdAPUclK+XWVukWRSqS3w80ORZWYQe6Fz8Yd
 VN9OIY8XCDYDMwL1bTHPWQxtZEG93EAG3rp0QAwz6JmCAj3Wc1EAcf4Z1bvPUl4JRTGc
 FIZVaObeW7bEg2QTlKIjNKCwApaaLXVtBpc5yLOwSycLug7w8B7tzVNReiOWkedQwsbf
 pHZ4we1k3iSqmzuxylMDjvQimNX4IQdqozm4mHiOgo3BwAsHmAeHiXDTb18l4DVPuvfg
 TOjw==
X-Gm-Message-State: AOAM531kuYCp0V6RKvKdN1XPq93n3oN3HoYnb2uLPA8X//NKQ8T6msW2
 ttRO7yZcjVnC8woQmfBW7RSvn+Tx+DnWYxvUCowPbjZkzjxqdmyrwamwzgxgOapvvNfO2jqsAWs
 ZIRs+kDYldYFPvZeMg1wnjn8FmrRUoEBc/bJWvPweWg==
X-Received: by 2002:a05:600c:3590:b0:389:f1c5:fd10 with SMTP id
 p16-20020a05600c359000b00389f1c5fd10mr12013112wmq.76.1647270939750; 
 Mon, 14 Mar 2022 08:15:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2JUgYXrReL9oDX4OetYT3pAzApLUMhnT7wy2uiAQTaGcAYO4gYWtQTf+/ly9jGC4djagRlg==
X-Received: by 2002:a05:600c:3590:b0:389:f1c5:fd10 with SMTP id
 p16-20020a05600c359000b00389f1c5fd10mr12013100wmq.76.1647270939561; 
 Mon, 14 Mar 2022 08:15:39 -0700 (PDT)
Received: from redhat.com ([2.55.183.53]) by smtp.gmail.com with ESMTPSA id
 l5-20020a5d6745000000b001f1e4e40e42sm13479732wrw.77.2022.03.14.08.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Mar 2022 08:15:39 -0700 (PDT)
Date: Mon, 14 Mar 2022 11:15:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <20220314111306-mutt-send-email-mst@kernel.org>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <20220311103549-mutt-send-email-mst@kernel.org>
 <YitzuxYHywdCRKVO@localhost.localdomain>
 <c91ad1e9-8c5b-ff1e-7e7f-8590ea6c67e8@nvidia.com>
 <Yi8OSE2hYoS8rSEo@localhost.localdomain>
 <e441429b-90ef-a2e4-1365-3f55c7ff21d0@nvidia.com>
 <20220314071222-mutt-send-email-mst@kernel.org>
 <d9121e3c-abe5-fe4d-8088-8339c418c7a8@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <d9121e3c-abe5-fe4d-8088-8339c418c7a8@nvidia.com>
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

On Mon, Mar 14, 2022 at 03:26:13PM +0200, Max Gurtovoy wrote:
> 
> On 3/14/2022 1:15 PM, Michael S. Tsirkin wrote:
> > On Mon, Mar 14, 2022 at 12:25:08PM +0200, Max Gurtovoy wrote:
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
> > > > > > > >     	 * deallocation of one or more of the sectors.
> > > > > > > >     	 */
> > > > > > > >     	__u8 write_zeroes_may_unmap;
> > > > > > > > +	__u8 unused1;
> > > > > > > > -	__u8 unused1[3];
> > > > > > > > +	__virtio16 num_poll_queues;
> > > > > > > >     } __attribute__((packed));
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
> > 
> > 
> > 
> > > MST/Jason/Stefan,
> > > 
> > > can you confirm that please ?
> > > 
> > > what does VIRTQ_AVAIL_F_NO_INTERRUPT supposed to do ?
> > This is a hint to the device not to send interrupts.
> 
> Why do you need a hint if the driver implicitly wrote 0xffff to disable MSI
> for a virtqueue ?


VIRTIO_MSI_NO_VECTOR is an expensive write into config space, followed
by an even more expensive read. Reliable and appropriate if you turn
events on/off very rarely.

VIRTQ_AVAIL_F_NO_INTERRUPT is an in-memory write so it's much cheaper,
but it's less reliable. Appropriate if you need to turn events on/off a
lot.



> 
> > 
> > > > Regards,
> > > > Suwan Kim

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
