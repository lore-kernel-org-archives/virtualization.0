Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A423C433EF
	for <virtualization@archiver.kernel.org>; Thu,  5 May 2022 08:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3EA9883FF3;
	Thu,  5 May 2022 08:41:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FBb5jTEFCowb; Thu,  5 May 2022 08:40:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C480284003;
	Thu,  5 May 2022 08:40:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98EC5C0032;
	Thu,  5 May 2022 08:40:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C1F8C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:40:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1020441949
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:40:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x6Frs9XlwakR
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:40:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [170.10.129.74])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C13141596
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651740052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W7LO8hebdbIw0WAuomKQFjBNareExAhRiWx3BsvsTNQ=;
 b=YzgKvaFmthjqn7qhaed3NGZHztcRHDRmSNdIAK9nBy8q05LkR6dbn4Vo5l+zqHHJA4jhH+
 myg9eVjXEZ8Hq0y0Qnpl0p8Qgkjfn3rxEsZFmSDaBZKfdii2d9vEz8wUkyCHCvBzNEB0k+
 6rx7eCvbwudlA3pig0N/bHGxl9DzaCQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-Y6qBpBqxMV6kktD8eQEIcQ-1; Thu, 05 May 2022 04:40:51 -0400
X-MC-Unique: Y6qBpBqxMV6kktD8eQEIcQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 v29-20020adfa1dd000000b0020ad932b7c0so1201134wrv.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 May 2022 01:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=W7LO8hebdbIw0WAuomKQFjBNareExAhRiWx3BsvsTNQ=;
 b=Ch+clHGvPBBhDzAET+MRjhzq0kTUHOtaJq+2eRZrV6YIhbLP6baUVEfnfO0osEjCo8
 c+CZq1g0BOwoWGojuKNsCKuJJHez9l/nrdED1C0jB+M2Slc8S3XIzkIkyS8cB8wzN46V
 jbGz5pALi9Z76pjPUk3hVRACQyWPdKjeSCiZsjlduXg7HVHajqHhwHZKk23hBB0J3Zrh
 soFmDqKcOae+NZ4IIGpKgzMi28zsavlfMqkObX5N/CkGnIz+WX+Vu22aESDItksmMN0Q
 +Qm0fPwr3xSICZez1sHAZk20/Rxt41miDIfRBTHn6HhknxnuwOT7ZQAQzwCGNBf3RWpq
 M+3w==
X-Gm-Message-State: AOAM530lHIqHfF1jDBd1eVHilhJfhoEzqHwz7H9R96eMgL+jLTvOS+og
 DfinQW7Z7zAKDm2OPX2Jz6wrdmaxz2PfWKd9qkeihm/Gtn0oFo+nQCxzjL/W7Xm4JjKlCd8O83e
 8hhwC0gSvzQ93hsIdt7ZmaxqMeKcqRSu7B8cQ9PmnMA==
X-Received: by 2002:a05:600c:19d2:b0:393:efff:7c26 with SMTP id
 u18-20020a05600c19d200b00393efff7c26mr3623077wmq.9.1651740050378; 
 Thu, 05 May 2022 01:40:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcbG871wt8Ul5pXQZdb/CfKU/UNSFjxHuQCDKeSp3PMM+Po2SZi2INJ/W6uVagnsqlJsEQqA==
X-Received: by 2002:a05:600c:19d2:b0:393:efff:7c26 with SMTP id
 u18-20020a05600c19d200b00393efff7c26mr3623056wmq.9.1651740050085; 
 Thu, 05 May 2022 01:40:50 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-85.retail.telecomitalia.it.
 [82.57.51.85]) by smtp.gmail.com with ESMTPSA id
 p20-20020a7bcc94000000b003942a244f38sm5584441wma.17.2022.05.05.01.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 May 2022 01:40:49 -0700 (PDT)
Date: Thu, 5 May 2022 10:40:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa_sim_blk: add support for VIRTIO_BLK_T_FLUSH
Message-ID: <20220505084045.xdh3xwgfr2spp3fj@sgarzare-redhat>
References: <20220428151242.213824-1-sgarzare@redhat.com>
 <CACGkMEv=0VWh_NxhvM+6_TRHEx0f2RGRWbR1n5RhKfq0a7xJUw@mail.gmail.com>
 <20220429071449.pycbkk2dvvxmtvay@sgarzare-redhat>
 <CACGkMEtRwRb_jUdCcdrx77=O4bnRGssQ5z_81KJi1hEKdbMcCQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtRwRb_jUdCcdrx77=O4bnRGssQ5z_81KJi1hEKdbMcCQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, May 05, 2022 at 04:26:24PM +0800, Jason Wang wrote:
>On Fri, Apr 29, 2022 at 3:14 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Fri, Apr 29, 2022 at 10:46:40AM +0800, Jason Wang wrote:
>> >On Thu, Apr 28, 2022 at 11:13 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >>
>> >> The simulator behaves like a ramdisk, so we don't have to do
>> >> anything when a VIRTIO_BLK_T_FLUSH request is received, but it
>> >> could be useful to test driver behavior.
>> >>
>> >> Let's expose the VIRTIO_BLK_F_FLUSH feature to inform the driver
>> >> that we support the flush command.
>> >>
>> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> >> ---
>> >>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 12 ++++++++++++
>> >>  1 file changed, 12 insertions(+)
>> >>
>> >> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> >> index 42d401d43911..a6dd1233797c 100644
>> >> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> >> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> >> @@ -25,6 +25,7 @@
>> >>  #define DRV_LICENSE  "GPL v2"
>> >>
>> >>  #define VDPASIM_BLK_FEATURES   (VDPASIM_FEATURES | \
>> >> +                                (1ULL << VIRTIO_BLK_F_FLUSH)    | \
>> >>                                  (1ULL << VIRTIO_BLK_F_SIZE_MAX) | \
>> >>                                  (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
>> >>                                  (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
>> >> @@ -166,6 +167,17 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>> >>                 pushed += bytes;
>> >>                 break;
>> >>
>> >> +       case VIRTIO_BLK_T_FLUSH:
>> >> +               if (sector != 0) {
>> >> +                       dev_err(&vdpasim->vdpa.dev,
>> >> +                               "A driver MUST set sector to 0 for a VIRTIO_BLK_T_FLUSH request - sector: 0x%llx\n",
>> >> +                               sector);
>> >
>> >If this is something that could be triggered by userspace/guest, then
>> >we should avoid this.
>>
>> It can only be triggered by an erratic driver.
>
>Right, so guest can try to DOS the host via this.

Yes, but I don't expect the simulator to be used in the real world, but 
only for testing and development, so the user should have full control 
of the guest.

>
>>
>> I was using the simulator to test a virtio-blk driver that I'm writing
>> in userspace and I forgot to set `sector` to zero, so I thought it would
>> be useful.
>>
>> Do you mean to remove the error message?
>
>Some like dev_warn_once() might be better here.

We also have other checks we do for each request (in and out header 
length, etc.) where we use dev_err(), should we change those too?

I don't know, from a developer's point of view I'd prefer to have them 
all printed, but actually if we have a totally wrong driver in the 
guest, we risk to hang our host to print an infinite number of messages.

Maybe we should change all the errors in the data path to 
dev_warn_once() and keep returning VIRTIO_BLK_S_IOERR to the guest which 
will surely get angry and print something.

If you agree, I'll send a patch to change all the printing and then 
repost this with your suggestion as well.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
