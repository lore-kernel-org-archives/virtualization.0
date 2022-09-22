Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC988C6FA82
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 16:57:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A14041B2E;
	Thu, 22 Sep 2022 16:57:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3A14041B2E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SPAsUmXP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8IYpJOYIH-HC; Thu, 22 Sep 2022 16:57:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2ED0741B39;
	Thu, 22 Sep 2022 16:57:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2ED0741B39
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 113E6C0033;
	Thu, 22 Sep 2022 16:57:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C62AFC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 16:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A1F6610EA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 16:57:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A1F6610EA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SPAsUmXP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X-48oCe_8Mkh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 16:57:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A244761113
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A244761113
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 16:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663865825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yyt8s7rtR8wMMR0HFPkltZSreD1Ms3xAJkzr/utjGb0=;
 b=SPAsUmXPIp0Y2ek/hpjT06N1PrKqgaPcgukUrWuRJakAHxeBd7Y0MsHKAB8WO+xQTxVzXv
 HyQwdHd2ZWaedMONSkZTM3dK65EJUDaRwbuNjAGTDOgK7lHTOtaoXICZUkWXgexkyZtgyq
 UL9otkE0RM+427b7d78IBIctzD8ZSds=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-371-mjqo2-b2MLGCKq8zQwDSsg-1; Thu, 22 Sep 2022 12:57:04 -0400
X-MC-Unique: mjqo2-b2MLGCKq8zQwDSsg-1
Received: by mail-wr1-f71.google.com with SMTP id
 d9-20020adfa349000000b0022ad6fb2845so3428263wrb.17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=Yyt8s7rtR8wMMR0HFPkltZSreD1Ms3xAJkzr/utjGb0=;
 b=Hq2wqXv0A0ht72IZH6HEZNPkKoHl7VWipTdi4P3kf7kjF0FdknvTC3mQ5obsXqhIh7
 Wsg6rF82fF/KtR7RARMOwMugSs9vxe/cWZDm8VVgn7DUHSnFmbqzugrgJLugqsnLuFW3
 wC0P7GhLcMJ4oVpptMO3wpsCzLBrTEhS5UtB1N65CfhnKHZHycDfH0mVBjxKu4ZR8hcb
 zN9lLAwDOX4ZfS7L2Pp9ibIQ8PGIeT2+WThWKtL5clS9nVx2GjCEQI1XbBLM3tLSSMQO
 OZn73FtuMlhlBm7nZN5hhH2GAH7Z1VmS8GoMOkaXFBK0HUa0ZkLT0dOuKn52bdWqjJGX
 AuoQ==
X-Gm-Message-State: ACrzQf1NeLrbOU+bk+wYg7cbR6tXqnTb/+B13dK6ZjSQaurbLTaDMxcR
 EfXRxFsMZsHw239AK2Nw2yV8cnqqEzCYJy6b6FGyWr4dmVziCKGbfYHS9OaWcnmSszHnFCkUYka
 5a43bbTkEpCHadg3yIUlhzltGS2oZxfRe0/xTS41UGA==
X-Received: by 2002:a1c:f406:0:b0:3a5:d667:10 with SMTP id
 z6-20020a1cf406000000b003a5d6670010mr3153545wma.70.1663865821830; 
 Thu, 22 Sep 2022 09:57:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5HQ9wUXgateIanUNTPd9egfTTPl/FeoXUYGmnE0AnooT0W5RTbRrdSGb3SrKD5a9/fCVNzKw==
X-Received: by 2002:a1c:f406:0:b0:3a5:d667:10 with SMTP id
 z6-20020a1cf406000000b003a5d6670010mr3153528wma.70.1663865821535; 
 Thu, 22 Sep 2022 09:57:01 -0700 (PDT)
Received: from redhat.com ([2.55.16.18]) by smtp.gmail.com with ESMTPSA id
 t2-20020adfe102000000b0022917d58603sm5691394wrz.32.2022.09.22.09.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 09:57:00 -0700 (PDT)
Date: Thu, 22 Sep 2022 12:56:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: [PATCH v2] virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()
Message-ID: <20220922125632-mutt-send-email-mst@kernel.org>
References: <20220830150153.12627-1-suwan.kim027@gmail.com>
 <20220831124441.ai5xratdpemiqmyv@quentin>
 <CAFNWusaxT38RyQBFZu6jN_kaL3p3hTQ0oXPQZkZdEJ3VjUMVWg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFNWusaxT38RyQBFZu6jN_kaL3p3hTQ0oXPQZkZdEJ3VjUMVWg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-block@vger.kernel.org, Pankaj Raghav <pankydev8@gmail.com>,
 acourbot@chromium.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, stefanha@redhat.com, pbonzini@redhat.com
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

On Thu, Sep 22, 2022 at 11:45:15PM +0900, Suwan Kim wrote:
> Hi Michael,
> 
> Can this patch be merged to the next rc?
> We received two bug reports about this issue and need to fix it.
> 
> Regards,
> Suwan Kim
> 
> 
> On Wed, Aug 31, 2022 at 9:44 PM Pankaj Raghav <pankydev8@gmail.com> wrote:
> >
> > On Wed, Aug 31, 2022 at 12:01:53AM +0900, Suwan Kim wrote:
> > > If a request fails at virtio_queue_rqs(), it is inserted to requeue_list
> > > and passed to virtio_queue_rq(). Then blk_mq_start_request() can be called
> > > again at virtio_queue_rq() and trigger WARN_ON_ONCE like below trace because
> > > request state was already set to MQ_RQ_IN_FLIGHT in virtio_queue_rqs()
> > > despite the failure.
> > >
> > > To avoid calling blk_mq_start_request() twice, This patch moves the
> > > execution of blk_mq_start_request() to the end of virtblk_prep_rq().
> > > And instead of requeuing failed request to plug list in the error path of
> > > virtblk_add_req_batch(), it uses blk_mq_requeue_request() to change failed
> > > request state to MQ_RQ_IDLE. Then virtblk can safely handle the request
> > > on the next trial.
> > >
> > > Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
> > > Reported-by: Alexandre Courbot <acourbot@chromium.org>
> > > Tested-by: Alexandre Courbot <acourbot@chromium.org>
> > > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > > ---
> > Looks good.
> > Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

Stefan, Paolo, any feedback here?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
