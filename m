Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E70C433EF
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 12:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E137C60F8A;
	Tue,  8 Mar 2022 12:17:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7bJyoCY2pFK9; Tue,  8 Mar 2022 12:17:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5F02160F3E;
	Tue,  8 Mar 2022 12:17:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32BF2C001D;
	Tue,  8 Mar 2022 12:17:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A330C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:17:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 67BEB84161
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:17:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zQ72_QZqlZk2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:17:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AAD488413F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646741827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q4MFrwUeHA8411pLnFPfvridBdBqiDj0gRgIbPX7Bco=;
 b=KbO95jtLFgW76SE70CvFl7fNlopNxISuvcXgkUS6ojrvN5CYLD97HmtWH08yatiEZlDJru
 6LE/dpyc0krGn4eCtp8ChmJzMMud3qFZh9RoH7RBgReV9YHQ+d/7XXJQ3X4Epfw/oYia07
 /gbtz08tFIzQyFHgj9cUCg5tTvBXkbM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-qCpsYC2YPfGQKhqlLbc1Ag-1; Tue, 08 Mar 2022 07:17:04 -0500
X-MC-Unique: qCpsYC2YPfGQKhqlLbc1Ag-1
Received: by mail-ed1-f69.google.com with SMTP id
 b9-20020aa7d489000000b0041669cd2cbfso1325436edr.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 04:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Q4MFrwUeHA8411pLnFPfvridBdBqiDj0gRgIbPX7Bco=;
 b=ieKT5N/Bo5574O2IDtNw+T+lLyHz8183vPeSD68ByV0GdIbf47nTx8b1FomWK9okeT
 S9XJNNZobzFy3qC/YMwUHahnjQjgwy752qKboDCgYnZj0DoVQ9tN67dVj/G84Mom/89e
 ZfiMa+Gxp7IR+cgcngUroUGdOKzbn0kCaCGGdaiz4DaZm0DKToCbhO0HdMZXIDPmwmr4
 97udUfPWJVSfjXSd4ploPBcVkHWzEAPw7vvw+QvTonigKsjOKXeencKkn0xR+sLzlz03
 piwkOzwzwm/rlkF67A6KBaHlj89OiwO+/7XFELt+86FHGel5irFYSGz0SGh06OQd1Suz
 PHdg==
X-Gm-Message-State: AOAM531yXFz70Hjkm836EEhg/KNpOJEc59cSIbVpDqCPa+Q5goYxOd2o
 uJJn+0Du87/xae83YaNoLwNIPtowBud9qVzBnRcz38sDQKazCWxcDXkQyuKwTi+zOqDNLg4IO/e
 1GbCo/Sd6Lnk+FlO18+WUzKPUXAIsPSVBILeRz48pHQ==
X-Received: by 2002:a17:906:1c57:b0:69f:2625:3f67 with SMTP id
 l23-20020a1709061c5700b0069f26253f67mr12471654ejg.632.1646741823320; 
 Tue, 08 Mar 2022 04:17:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyv3KjBNigyGaaSVueJxA+9S47u/8qNhANARzSvnWtSt6/hRP6zGr3bHeHqG0RYzeGW5mXQEA==
X-Received: by 2002:a17:906:1c57:b0:69f:2625:3f67 with SMTP id
 l23-20020a1709061c5700b0069f26253f67mr12471627ejg.632.1646741823073; 
 Tue, 08 Mar 2022 04:17:03 -0800 (PST)
Received: from redhat.com ([2.55.138.228]) by smtp.gmail.com with ESMTPSA id
 dx10-20020a170906a84a00b006da8608e09fsm5748303ejb.9.2022.03.08.04.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 04:17:02 -0800 (PST)
Date: Tue, 8 Mar 2022 07:16:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH v5 00/15] vDPA shadow virtqueue
Message-ID: <20220308071253-mutt-send-email-mst@kernel.org>
References: <20220307153334.3854134-1-eperezma@redhat.com>
 <14d4fde4-6ea5-4805-b684-c33f6b448565@redhat.com>
 <20220308020348-mutt-send-email-mst@kernel.org>
 <CACGkMEvY-+XpPWbtiX9dy+fwDxPp7sHFhH_LY0PB2YuusEugyw@mail.gmail.com>
 <20220308022300-mutt-send-email-mst@kernel.org>
 <CACGkMEvuTPCRk7Ng7CbgpPSPgs_QYijzc5fU+cV3kW09W1R7Qg@mail.gmail.com>
 <20220308024724-mutt-send-email-mst@kernel.org>
 <CACGkMEsPBDM8ko1qgnCR1DcofPNJJo3S2j3pOJHk4xaSGQimcQ@mail.gmail.com>
 <20220308054623-mutt-send-email-mst@kernel.org>
 <CAJaqyWcuitG+01pjO__tYERN9910fL_JGiHG88xU=fTG3KmpJw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcuitG+01pjO__tYERN9910fL_JGiHG88xU=fTG3KmpJw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: qemu-devel <qemu-devel@nongnu.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <eli@mellanox.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cindy Lu <lulu@redhat.com>,
 "Fangyi \(Eric\)" <eric.fangyi@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, yebiaoxiang@huawei.com,
 Liuxiangdong <liuxiangdong5@huawei.com>, Laurent Vivier <lvivier@redhat.com>,
 Parav Pandit <parav@mellanox.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gautam Dawar <gdawar@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Lingshan <lingshan.zhu@intel.com>
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

On Tue, Mar 08, 2022 at 12:37:33PM +0100, Eugenio Perez Martin wrote:
> On Tue, Mar 8, 2022 at 11:48 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Mar 08, 2022 at 04:20:53PM +0800, Jason Wang wrote:
> > > > Not by itself but I'm not sure we can guarantee guest will not
> > > > attempt to use the IOVA addresses we are reserving down
> > > > the road.
> > >
> > > The IOVA is allocated via the listeners and stored in the iova tree
> > > per GPA range as IOVA->(GPA)->HVA.Guests will only see GPA, Qemu
> > > virtio core see GPA to HVA mapping. And we do a reverse lookup to find
> > > the HVA->IOVA we allocated previously.  So we have double check here:
> > >
> > > 1) Qemu memory core to make sure the GPA that guest uses is valid
> > > 2) the IOVA tree that guarantees there will be no HVA beyond what
> > > guest can see is used
> > >
> > > So technically, there's no way for the guest to use the IOVA address
> > > allocated for the shadow virtqueue.
> > >
> > > Thanks
> >
> > I mean, IOVA is programmed in the host hardware to translate to HPA, right?
> >
> 
> Yes, that's right if the device uses physical maps. Also to note, SVQ
> vring is allocated in multiples of host huge pages to avoid garbage or
> unintended access from the device.
> 
> If a vdpa device uses physical addresses, kernel vdpa will pin qemu
> memory first and then will send IOVA to HPA translation to hardware.
> But this IOVA space is not controlled by the guest, but by SVQ. If a
> guest's virtqueue buffer cannot be translated first to GPA, it will
> not be forwarded.
> 
> Thanks!

Right. So if guests send a buffer where buffer address overlaps the
range we used for the SVQ, then I think at the moment guest won't work.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
