Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371E5C433F5
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 11:15:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D37B24019B;
	Mon, 14 Mar 2022 11:15:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ptpUiEqkfnIj; Mon, 14 Mar 2022 11:15:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1E0244011A;
	Mon, 14 Mar 2022 11:15:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E654CC001D;
	Mon, 14 Mar 2022 11:15:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84BDDC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 11:15:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E95941553
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 11:15:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 85wBSDRudmxa
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 11:15:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE33A41551
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 11:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647256527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vRM52XfMFpa+GGYk7qRe4D8nr6y9mk+cexYCZkh1YuM=;
 b=Nkd269X4iQZq2JURLCts6aYGEW1gu9QgK9kI/TfoOeiKXWvw7E1K2xKE65hxkwi3e3s5ET
 bS+H7hPlNa9C+RmdNNkV7rIU9Km3w0rcSvnBA1OgZO06AZdeNVZ0PZi+eDW3FUeyoQEJHE
 fJR5Aq0OTwdZmrVHY62zaN9S3WtskeE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-bODpMphXM7qHDzGFbiudXA-1; Mon, 14 Mar 2022 07:15:24 -0400
X-MC-Unique: bODpMphXM7qHDzGFbiudXA-1
Received: by mail-wm1-f70.google.com with SMTP id
 3-20020a05600c230300b00384e15ceae4so9467552wmo.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 04:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vRM52XfMFpa+GGYk7qRe4D8nr6y9mk+cexYCZkh1YuM=;
 b=E/0EqXfN2U8svSW8GQmTsMK/ShWsvnH5E+KMD2FParVWbVT6EkKdN+AZCdwqzQ0SDB
 C6YaM8SkAgntX7lqCdGxbmoqukVJSyKZ0VldWiTL+DDSNNF2Xm1CBviqeJk0YPVg7Mdd
 LNmfYBwMPWdDogJfviYXAlEarIqm5pE7dosh2LCJUH00HOBGBU6kEd/z/EZRJ6n1AbfW
 HoE4ap/7fW8QQ6jO3cTrbby52BzjFXmp+lqjfR32NC5BlldEeKQrdo5KZdZEy6HZVN5u
 le+hi7/uExvjPT953EegzacK15Wv6bvEuIfhYiTs1BUWhXsJaKPl2qFq5//dGZedMxSO
 u20Q==
X-Gm-Message-State: AOAM530pWvahzpJrzgVYflqmG26fIyBI47ytSVIv9jMhh2375HCeO9Sj
 06U57yL4H8lH5rS08o5UKMUns6vCjT/4A546czagrj/pkbPhK76VFbyBpZn7iYqhWyZe3auq4Qe
 guPtJx1/geQj0cm/meSR+uBHA9XF8dQN5ToEW6VQxQQ==
X-Received: by 2002:a5d:63d2:0:b0:203:aa78:b80c with SMTP id
 c18-20020a5d63d2000000b00203aa78b80cmr5559950wrw.593.1647256523100; 
 Mon, 14 Mar 2022 04:15:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgV5YKM6coB4lOg5TcFTzl+9eWgz47tpTOZwXZmQhnPdteRXRixkC02+1snXHeRpooHr/O1w==
X-Received: by 2002:a5d:63d2:0:b0:203:aa78:b80c with SMTP id
 c18-20020a5d63d2000000b00203aa78b80cmr5559930wrw.593.1647256522883; 
 Mon, 14 Mar 2022 04:15:22 -0700 (PDT)
Received: from redhat.com ([2.55.183.53]) by smtp.gmail.com with ESMTPSA id
 g1-20020a1c4e01000000b003899c8053e1sm20888382wmh.41.2022.03.14.04.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Mar 2022 04:15:22 -0700 (PDT)
Date: Mon, 14 Mar 2022 07:15:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <20220314071222-mutt-send-email-mst@kernel.org>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <20220311103549-mutt-send-email-mst@kernel.org>
 <YitzuxYHywdCRKVO@localhost.localdomain>
 <c91ad1e9-8c5b-ff1e-7e7f-8590ea6c67e8@nvidia.com>
 <Yi8OSE2hYoS8rSEo@localhost.localdomain>
 <e441429b-90ef-a2e4-1365-3f55c7ff21d0@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <e441429b-90ef-a2e4-1365-3f55c7ff21d0@nvidia.com>
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

On Mon, Mar 14, 2022 at 12:25:08PM +0200, Max Gurtovoy wrote:
> 
> On 3/14/2022 11:43 AM, Suwan Kim wrote:
> > On Sun, Mar 13, 2022 at 12:37:21PM +0200, Max Gurtovoy wrote:
> > > On 3/11/2022 6:07 PM, Suwan Kim wrote:
> > > > On Fri, Mar 11, 2022 at 10:38:07AM -0500, Michael S. Tsirkin wrote:
> > > > > On Sat, Mar 12, 2022 at 12:28:32AM +0900, Suwan Kim wrote:
> > > > > > diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> > > > > > index d888f013d9ff..3fcaf937afe1 100644
> > > > > > --- a/include/uapi/linux/virtio_blk.h
> > > > > > +++ b/include/uapi/linux/virtio_blk.h
> > > > > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > > > > >    	 * deallocation of one or more of the sectors.
> > > > > >    	 */
> > > > > >    	__u8 write_zeroes_may_unmap;
> > > > > > +	__u8 unused1;
> > > > > > -	__u8 unused1[3];
> > > > > > +	__virtio16 num_poll_queues;
> > > > > >    } __attribute__((packed));
> > > > > Same as any virtio UAPI change, this has to go through the virtio TC.
> > > > > In particular I don't think gating a new config field on
> > > > > an existing feature flag is a good idea.
> > > > Did you mean that the polling should be based on a new feature like
> > > > "VIRTIO_BLK_F_POLL" and be added at the end of features_legacy[]
> > > > and features[]? If then, I will add the new feture flag and resend it.
> > > Isn't there a way in the SPEC today to create a queue without interrupt
> > > vector ?
> > It seems that it is not possible to create a queue without interrupt
> > vector. If it is possible, we can expect more polling improvement.

Yes, it's possible:

Writing a valid MSI-X Table entry number, 0 to 0x7FF, to
\field{config_msix_vector}/\field{queue_msix_vector} maps interrupts triggered
by the configuration change/selected queue events respectively to
the corresponding MSI-X vector. To disable interrupts for an
event type, the driver unmaps this event by writing a special NO_VECTOR
value:

\begin{lstlisting}
/* Vector value used to disable MSI for queue */
#define VIRTIO_MSI_NO_VECTOR            0xffff
\end{lstlisting}



> MST/Jason/Stefan,
> 
> can you confirm that please ?
>
> what does VIRTQ_AVAIL_F_NO_INTERRUPT supposed to do ?

This is a hint to the device not to send interrupts.

> 
> > Regards,
> > Suwan Kim

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
