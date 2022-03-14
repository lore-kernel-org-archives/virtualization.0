Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D738C433EF
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 06:25:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AF242405C8;
	Mon, 14 Mar 2022 06:25:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GN7MDl930h3L; Mon, 14 Mar 2022 06:25:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 44B85400D6;
	Mon, 14 Mar 2022 06:25:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F313C0012;
	Mon, 14 Mar 2022 06:25:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3C54C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 06:25:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A07460B79
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 06:25:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ltd47hxFsGTz
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 06:25:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 890B460B06
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 06:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647239133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KGW3wdvU0Gwl2eAIkTXU4wuRTrf9rfE35UQBhFIaQY4=;
 b=QOTt7LDsXorp3dIwa4IgHY4woCNSBxg2d2VlwI6zJn43ZcWDjaaWfbR33UFiaxN/jiTiEN
 ZaXpIJRGOdsZ/DYyNDEulzNMFdzURPN3B27BYtCBJu2C/XFmPytEfR6J38Xt5SGpcguLrW
 7brVW9ahtpyz/5+eTXJcZ0rEGMaM2oc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-sRUhKRIDM3mG-pyP8TD4iA-1; Mon, 14 Mar 2022 02:25:31 -0400
X-MC-Unique: sRUhKRIDM3mG-pyP8TD4iA-1
Received: by mail-lj1-f198.google.com with SMTP id
 j7-20020a2e3c07000000b00247f8eb86a4so5993837lja.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Mar 2022 23:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KGW3wdvU0Gwl2eAIkTXU4wuRTrf9rfE35UQBhFIaQY4=;
 b=rmyf6IghvfuqfujM3G9TqRy2ix+dukcu8zhsexVV+2ICXUhUaA5lSn5tPZQnkmyaq0
 FroqY1U3U8UHNnQJ0Fz81huueSoTms3KsLWbWctpIwJ2eMVGucSBJpB7UOwKVYJCfoZH
 ysPbnWNyoaF7hAZUltptcodjqpRevuQM0LhNqfJDiWzVS5nuuoRTRxdnb3kjFw3daBj6
 YjqghpLGTLi1pF6XBgHZ1d4nyIgVwXB444EiRAC7/m8JUqPQXsaZbFxZ3HzZ0eSm5rkk
 Qio4/yjliYLP9oEQWda8TexETTynIcPElMhdsd1HdTY5chzu3iEiBRBIuSSx8vMyKN8M
 58Tw==
X-Gm-Message-State: AOAM533SpHP7XwNFtA4LOO8ivNQGW0XK0xQ/fiq+SdHCSt22LkzaMzaA
 ndgPZjDYY0aVuimSYk4qUWZKXamFL21G2zKO0DQLKDWy1qlIaC2ZhlX7qe7fAcalMCVCx0LoDnC
 3i3h0Q2mOrZrA2uMTX5rzkLVBnAuRhHGVW445cAAlOlbDIgeFSijOrEEZog==
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id
 y1-20020a056512334100b00433b033bd22mr12514445lfd.190.1647239128133; 
 Sun, 13 Mar 2022 23:25:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDFspC/4h1GeCvHNG/T8VI9+puaUppCmprWnBTzKnfN+bIY3UHoU3od2DlsjW00d8CCW/sS/rohYyXyn2uJag=
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id
 y1-20020a056512334100b00433b033bd22mr12514427lfd.190.1647239127759; Sun, 13
 Mar 2022 23:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220216080022.56707-1-elic@nvidia.com>
 <20220216080022.56707-2-elic@nvidia.com>
 <22f77b5c-2003-c963-24c9-fce9cb53160d@oracle.com>
 <20220217064619.GB86497@mtl-vdi-166.wap.labs.mlnx>
 <8e834c04-47d2-1286-117d-28caa3e84606@oracle.com>
 <DM8PR12MB5400E80073521E898056578BAB089@DM8PR12MB5400.namprd12.prod.outlook.com>
 <6175d620-6be3-c249-5482-0a9448499e4a@oracle.com>
 <DM8PR12MB5400E03D7AD7833CEBF8DF9DAB099@DM8PR12MB5400.namprd12.prod.outlook.com>
 <74495f15-8f1c-93db-1277-50198ac3284e@oracle.com>
 <DM8PR12MB540086CCD1F535668D05E546AB0A9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <a30ac3c0-059d-4588-c5ac-599c060f6bbf@oracle.com>
 <DM8PR12MB54000042A48FDFA446EFE792AB0E9@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB54000042A48FDFA446EFE792AB0E9@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Mar 2022 14:25:16 +0800
Message-ID: <CACGkMEsjv+Yz0W=-V=My3E7i7+sMSJhZAZrN+vSs_Bdh9nVdHA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying vendor statistics
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>
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
Content-Type: multipart/mixed; boundary="===============2470350477935090206=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============2470350477935090206==
Content-Type: multipart/alternative; boundary="000000000000120dfa05da27bf0b"

--000000000000120dfa05da27bf0b
Content-Type: text/plain; charset="UTF-8"

On Sun, Mar 13, 2022 at 11:26 PM Eli Cohen <elic@nvidia.com> wrote:

> > On 3/8/2022 9:07 PM, Eli Cohen wrote:
> > >
> > >> -----Original Message-----
> > >> From: Si-Wei Liu <si-wei.liu@oracle.com>
> > >> Sent: Wednesday, March 9, 2022 5:33 AM
> > >> To: Eli Cohen <elic@nvidia.com>
> > >> Cc: mst@redhat.com; jasowang@redhat.com; virtualization@lists.linux-
> > >> foundation.org; eperezma@redhat.com; amorenoz@redhat.com;
> > >> lvivier@redhat.com; sgarzare@redhat.com; Parav Pandit <
> parav@nvidia.com>
> > >> Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying vendor
> statistics
> > >>
> > >>
> > >>
> > >> On 3/8/2022 6:13 AM, Eli Cohen wrote:
> > >>>> -----Original Message-----
> > >>>> From: Si-Wei Liu <si-wei.liu@oracle.com>
> > >>>> Sent: Tuesday, March 8, 2022 8:16 AM
> > >>>> To: Eli Cohen <elic@nvidia.com>
> > >>>> Cc: mst@redhat.com; jasowang@redhat.com;
> virtualization@lists.linux-
> > >>>> foundation.org; eperezma@redhat.com; amorenoz@redhat.com;
> > >>>> lvivier@redhat.com; sgarzare@redhat.com; Parav Pandit
> > >>>> <parav@nvidia.com>
> > >>>> Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying vendor
> > >>>> statistics
> > >>>>
> > >>>>
> > >>>>
> > >>>> On 3/6/2022 11:57 PM, Eli Cohen wrote:
> > >>>>>> -----Original Message-----
> > >>>>>> From: Si-Wei Liu <si-wei.liu@oracle.com>
> > >>>>>> Sent: Saturday, March 5, 2022 12:34 AM
> > >>>>>> To: Eli Cohen <elic@nvidia.com>
> > >>>>>> Cc: mst@redhat.com; jasowang@redhat.com;
> > >>>>>> virtualization@lists.linux- foundation.org; eperezma@redhat.com;
> > >>>>>> amorenoz@redhat.com; lvivier@redhat.com; sgarzare@redhat.com;
> > >> Parav
> > >>>>>> Pandit <parav@nvidia.com>
> > >>>>>> Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying vendor
> > >>>>>> statistics
> > >>>>>>
> > >>>>>> Sorry, I somehow missed this after my break. Please see comments
> in
> > >> line.
> > >>>>>> On 2/16/2022 10:46 PM, Eli Cohen wrote:
> > >>>>>>> On Wed, Feb 16, 2022 at 10:49:26AM -0800, Si-Wei Liu wrote:
> > >>>>>>>> On 2/16/2022 12:00 AM, Eli Cohen wrote:
> > >>>>>>>>> Allows to read vendor statistics of a vdpa device. The specific
> > >>>>>>>>> statistics data is received by the upstream driver in the form
> > >>>>>>>>> of an (attribute name, attribute value) pairs.
> > >>>>>>>>>
> > >>>>>>>>> An example of statistics for mlx5_vdpa device are:
> > >>>>>>>>>
> > >>>>>>>>> received_desc - number of descriptors received by the virtqueue
> > >>>>>>>>> completed_desc - number of descriptors completed by the
> > >>>>>>>>> virtqueue
> > >>>>>>>>>
> > >>>>>>>>> A descriptor using indirect buffers is still counted as 1. In
> > >>>>>>>>> addition, N chained descriptors are counted correctly N times
> as
> > >>>>>>>>> one
> > >>>>>> would expect.
> > >>>>>>>>> A new callback was added to vdpa_config_ops which provides the
> > >>>>>>>>> means for the vdpa driver to return statistics results.
> > >>>>>>>>>
> > >>>>>>>>> The interface allows for reading all the supported virtqueues,
> > >>>>>>>>> including the control virtqueue if it exists.
> > >>>>>>>>>
> > >>>>>>>>> Below are some examples taken from mlx5_vdpa which are
> > >>>>>>>>> introduced in the following patch:
> > >>>>>>>>>
> > >>>>>>>>> 1. Read statistics for the virtqueue at index 1
> > >>>>>>>>>
> > >>>>>>>>> $ vdpa dev vstats show vdpa-a qidx 1
> > >>>>>>>>> vdpa-a:
> > >>>>>>>>> queue_type tx queue_index 1 received_desc 3844836
> > >> completed_desc
> > >>>>>>>>> 3844836
> > >>>>>>>>>
> > >>>>>>>>> 2. Read statistics for the virtqueue at index 32 $ vdpa dev
> > >>>>>>>>> vstats show vdpa-a qidx 32
> > >>>>>>>>> vdpa-a:
> > >>>>>>>>> queue_type control_vq queue_index 32 received_desc 62
> > >>>>>>>>> completed_desc
> > >>>>>>>>> 62
> > >>>>>>>>>
> > >>>>>>>>> 3. Read statisitics for the virtqueue at index 0 with json
> > >>>>>>>>> output $ vdpa -j dev vstats show vdpa-a qidx 0
> > >>>>>>>>> {"vstats":{"vdpa-a":{
> > >>>>>>>>>
> > >>>>>>
> "queue_type":"rx","queue_index":0,"name":"received_desc","value":41
> > >>>>>> 77
> > >>>>>> 76,\
> > >>>>>>>>>       "name":"completed_desc","value":417548}}}
> > >>>>>>>>>
> > >>>>>>>>> 4. Read statistics for the virtqueue at index 0 with preety
> json
> > >>>>>>>>> output $ vdpa -jp dev vstats show vdpa-a qidx 0 {
> > >>>>>>>>>          "vstats": {
> > >>>>>>>>>              "vdpa-a": {
> > >>>>>>>>>
> > >>>>>>>>>                  "queue_type": "rx",
> > >>>>>>>> I wonder where this info can be inferred? I don't see relevant
> > >>>>>>>> change in the patch series that helps gather the
> > >>>> VDPA_ATTR_DEV_QUEUE_TYPE?
> > >>>>>>>> Is this an arbitrary string defined by the vendor as well? If
> so,
> > >>>>>>>> how does the user expect to consume it?
> > >>>>>>> The queue tupe is deduced from the index and whether we have a
> > >>>>>>> virtqueue. Even numbers are rx, odd numbers are tx and if there
> is
> > >>>>>>> CVQ, the last one is CVQ.
> > >>>>>> OK, then VDPA_ATTR_DEV_QUEUE_TYPE attribute introduced in this
> > >>>>>> patch might not be useful at all?
> > >>>>> Right, will remove.
> > >>>>>
> > >>>>>> And how do you determine in the vdpa tool if CVQ is negotiated or
> > >>>>>> not?
> > >>>>> I make a netlink call to get the same information as " vdpa dev
> config
> > >> show"
> > >>>> retrieves. I use the negotiated features to determine if a CVQ is
> > >>>> available. If it is, the number of VQs equals the control VQ index.
> > >>>> So there are two netlink calls under the hood.
> > >>>> The lock vdpa_dev_mutex won't hold across the two separate netlink
> > >>>> calls, and it may end up with inconsistent state - theoretically
> > >>>> things could happen like that the first call gets CVQ negotiated,
> but
> > >>>> the later call for
> > >>>> get_vendor_vq_stats() on the cvq might get -EINVAL due to device
> > >>>> reset. Can the negotiated status and stat query be done within one
> single
> > >> netlink call?
> > >>> I see your concern.
> > >>> The only reason I do the extra call is to know if we have a control
> VQ
> > >>> and what index it is, just to print a descriptive string telling if
> it's a either rx,
> > >> tx or control VQ.
> > >>> So the cure can be simple. Let's have a new attribute that returns
> the
> > >>> type of virtqueue.
> > >> I am not sure I follow the cure. Wouldn't it be possible to get both
> negotiated
> > >> status and the queue stat in vdpa_nl_cmd_dev_stats_get_doit() under
> the
> > >> same vdpa_dev_mutex lock?
> > > Yes we can, but I suggested to get only the type of the queue as a new
> attribute.
> > > The kernel will do the digest and decide per a given VQ if it's rx, tx
> or control and
> > > return the result in that new attribute.
> > The rx, tx and control queue type is net specific, while the vdpa core
> > is currently agnostic to the vdpa class.
> >
> > >
> > >> And I am not even sure if it is a must to display
> > >> the queue type - it doesn't seem the output includes the vdpa class
> info, which
> > >> makes it hard for script to parse the this field in generic way.
> > > I don't get you. You say you don't think you need the queue type and
> at the same
> > > time you're concerned lack of information makes it hard for scripts.
> > > BTW, class info is something you can get for the device through "vdpa
> dev show"
> > > so your know the class of your device.
> > Stepping back, may I ask if there's a case that queue type specific stat
> > may be defined by vendor, such that deciphering of certain vendor stat
> > would need type specific knowledge? So far the received_desc and
> > completed_desc stats offered through the mlx5_vdpa patch look to be
> > general ones and not associated with any queue type in particular. Is
> > there some future stat in your mind that needs specific knowledge of
> > queue type and vdpa class?
>
> No, the only reason for displaying the queue type is to help users
> know kind of queue they're looking at.
>
> >
> > I'd prefer the vstat output to be self-contained and self-descriptive.
> > You may argue the class of vdpa never changes in "vdpa dev show" after
> > creation. This is true, however the queue type is not - say you got a
> > control queue for qindex 2, but the next moment you may get a rx queue
> > with the same qindex.
>
> I don't think this is possible unless you destroyed the device and
> re-created it.
> What operation do you think could cause that?
>
> > Particularly you seem want to tie this with queue
> > index in the guest view, which is quite dynamic for host admin or script
> > running on the host to follow.
>
> For rx and tx queues, some index may become invalid if the user changed
> the number of queues with ethtool -L but I don't think this is an issue.
> >
> > >
> > >>>    I think Jason did not like the idea of communicating the kind of
> VQ
> > >>> from kernel to userspace but under these circumstances, maybe he
> would
> > >> approve.
> > >>> Jason?
> > >>>
> > >>>> What worried me is that the queue index being dynamic and depended
> on
> > >>>> negotiation status would make host admin user quite hard to follow.
> > >>>> The guest may or may not advertise F_MQ and/or F_CTRL_VQ across
> > >> various phases, e.g.
> > >>>> firmware (UEFI), boot loader (grub) till OS driver is up and
> running,
> > >>>> which can be agnostic to host admin. For most of the part it's not
> > >>>> easy to script and predict the queue index which can change from
> time
> > >>>> to time. Can we define the order of host predictable queue index,
> > >>>> which is independent from any guest negotiated state?
> > >> Here I think we can just use the plain queue index in the host view -
> say if vdpa
> > >> net has 4 pairs of data vqs and 1 control vq, user may use qindex 8
> across the
> > >> board to identify the control vq, regardless if the F_MQ feature is
> negotiated
> > >> or not in guest.
> > > Right, but the idea that a userspace tool should provide useful
> information to the
> > > user so it does not need to do complex logic to infer that from bare
> data.
> > The host side qindex and qtype would never change regardless of guest
> > feature negotiation, by nature it reflects the real construct and object
> > in the hardware.


This should be possible for vendor specific stats. But I'm afraid it may
cause more confusion since the spec doesn't have the concept like "host
queue index". And to be self descriptive the vendor need also display the
mappings between virtqueue index and host(vendor) queue index.

Thanks


> I don't feel it's a simple task for host users to
> > figure out the correct guest side qindex for the control queue -  it's
> > always racy for one to check some other vdpa command output if the vstat
> > output is not self-contained.
>
> So what are you actually proposing? Display received and completed
> descriptors
> per queue index without further interpretation?
>
> >
> > Thanks,
> > -Siwei
> >
> > >
> > >>
> > >> Regards,
> > >> -Siwei
> > >>
> > >>>>>> Looks to me there are still some loose end I don't quite yet
> > >>>>>> understand.
> > >>>>>>
> > >>>>>>
> > >>>>>>>>>                  "queue_index": 0,
> > >>>>> I think this can be removed since the command is for a specific
> index.
> > >>>>>
> > >>>>>>>>>                  "name": "received_desc",
> > >>>>>>>>>                  "value": 417776,
> > >>>>>>>>>                  "name": "completed_desc",
> > >>>>>>>>>                  "value": 417548
> > >>>>>>>> Not for this kernel patch, but IMHO it's the best to put the
> name
> > >>>>>>>> & value pairs in an array instead of flat entries in json's
> > >>>>>>>> hash/dictionary. The hash entries can be re-ordered deliberately
> > >>>>>>>> by external json parsing tool, ending up with inconsistent stat
> values.
> > >>>>>> This comment is missed for some reason. Please change the example
> > >>>>>> in the log if you agree to address it in vdpa tool. Or justify why
> > >>>>>> keeping the order for json hash/dictionary is fine.
> > >>>>> Sorry for skipping this comment.
> > >>>>> Do you mean to present the information like:
> > >>>>> "received_desc": 417776,
> > >>>>> "completed_desc": 417548,
> > >>>> I mean the following presentation:
> > >>>>
> > >>>> $ vdpa -jp dev vstats show vdpa-a qidx 0 {
> > >>>>        "vstats": {
> > >>>>            "vdpa-a": {
> > >>>>                "queue_stats": [{
> > >>>>                    "queue_index": 0,
> > >>>>                    "queue_type": "rx",
> > >>>>                    "stat_name": [ "received_desc","completed_desc"
> ],
> > >>>>                    "stat_value": [ 417776,417548 ],
> > >>>>                }]
> > >>>>            }
> > >>>>        }
> > >>>> }
> > >>>>
> > >>>> I think Parav had similar suggestion, too.
> > >>>>
> > >>>> Thanks,
> > >>>> -Siwei
> > >>>>
> > >>>>>> Thanks,
> > >>>>>> -Siwei
> > >>>>>>
> > >>>>>>>> Thanks,
> > >>>>>>>> -Siwei
> > >>>>>>>>>              }
> > >>>>>>>>>          }
> > >>>>>>>>> }
> > >>>>>>>>>
> > >>>>>>>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
> > >>>>>>>>> ---
> > >>>>>>>>>       drivers/vdpa/vdpa.c       | 129
> > >>>>>> ++++++++++++++++++++++++++++++++++++++
> > >>>>>>>>>       include/linux/vdpa.h      |   5 ++
> > >>>>>>>>>       include/uapi/linux/vdpa.h |   7 +++
> > >>>>>>>>>       3 files changed, 141 insertions(+)
> > >>>>>>>>>
> > >>>>>>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> > >>>>>>>>> 9846c9de4bfa..d0ff671baf88 100644
> > >>>>>>>>> --- a/drivers/vdpa/vdpa.c
> > >>>>>>>>> +++ b/drivers/vdpa/vdpa.c
> > >>>>>>>>> @@ -909,6 +909,74 @@ vdpa_dev_config_fill(struct vdpa_device
> > >>>>>>>>> *vdev,
> > >>>>>> struct sk_buff *msg, u32 portid,
> > >>>>>>>>>             return err;
> > >>>>>>>>>       }
> > >>>>>>>>> +static int vdpa_fill_stats_rec(struct vdpa_device *vdev,
> struct
> > >>>>>>>>> +sk_buff
> > >>>>>> *msg,
> > >>>>>>>>> +                          struct genl_info *info, u32 index) {
> > >>>>>>>>> +   int err;
> > >>>>>>>>> +
> > >>>>>>>>> +   if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
> > >>>>>>>>> +           return -EMSGSIZE;
> > >>>>>>>>> +
> > >>>>>>>>> +   err = vdev->config->get_vendor_vq_stats(vdev, index, msg,
> > >>>>>>>>> +info-
> > >>>>>>> extack);
> > >>>>>>>>> +   if (err)
> > >>>>>>>>> +           return err;
> > >>>>>>>>> +
> > >>>>>>>>> +   return 0;
> > >>>>>>>>> +}
> > >>>>>>>>> +
> > >>>>>>>>> +static int vendor_stats_fill(struct vdpa_device *vdev, struct
> > >>>>>>>>> +sk_buff
> > >>>> *msg,
> > >>>>>>>>> +                        struct genl_info *info, u32 index) {
> > >>>>>>>>> +   int err;
> > >>>>>>>>> +
> > >>>>>>>>> +   if (!vdev->config->get_vendor_vq_stats)
> > >>>>>>>>> +           return -EOPNOTSUPP;
> > >>>>>>>>> +
> > >>>>>>>>> +   err = vdpa_fill_stats_rec(vdev, msg, info, index);
> > >>>>>>>>> +   if (err)
> > >>>>>>>>> +           return err;
> > >>>>>>>>> +
> > >>>>>>>>> +   return 0;
> > >>>>>>>>> +}
> > >>>>>>>>> +
> > >>>>>>>>> +static int vdpa_dev_vendor_stats_fill(struct vdpa_device
> *vdev,
> > >>>>>>>>> +                                 struct sk_buff *msg,
> > >>>>>>>>> +                                 struct genl_info *info, u32
> index) {
> > >>>>>>>>> +   u32 device_id;
> > >>>>>>>>> +   void *hdr;
> > >>>>>>>>> +   int err;
> > >>>>>>>>> +   u32 portid = info->snd_portid;
> > >>>>>>>>> +   u32 seq = info->snd_seq;
> > >>>>>>>>> +   u32 flags = 0;
> > >>>>>>>>> +
> > >>>>>>>>> +   hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
> > >>>>>>>>> +                     VDPA_CMD_DEV_VSTATS_GET);
> > >>>>>>>>> +   if (!hdr)
> > >>>>>>>>> +           return -EMSGSIZE;
> > >>>>>>>>> +
> > >>>>>>>>> +   if (nla_put_string(msg, VDPA_ATTR_DEV_NAME,
> > >> dev_name(&vdev-
> > >>>>>>> dev))) {
> > >>>>>>>>> +           err = -EMSGSIZE;
> > >>>>>>>>> +           goto undo_msg;
> > >>>>>>>>> +   }
> > >>>>>>>>> +
> > >>>>>>>>> +   device_id = vdev->config->get_device_id(vdev);
> > >>>>>>>>> +   if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
> > >>>>>>>>> +           err = -EMSGSIZE;
> > >>>>>>>>> +           goto undo_msg;
> > >>>>>>>>> +   }
> > >>>>>>>>> +
> > >>>>>>>>> +   err = vendor_stats_fill(vdev, msg, info, index);
> > >>>>>>>>> +
> > >>>>>>>>> +   genlmsg_end(msg, hdr);
> > >>>>>>>>> +
> > >>>>>>>>> +   return err;
> > >>>>>>>>> +
> > >>>>>>>>> +undo_msg:
> > >>>>>>>>> +   genlmsg_cancel(msg, hdr);
> > >>>>>>>>> +   return err;
> > >>>>>>>>> +}
> > >>>>>>>>> +
> > >>>>>>>>>       static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff
> > >>>>>>>>> *skb, struct
> > >>>>>> genl_info *info)
> > >>>>>>>>>       {
> > >>>>>>>>>             struct vdpa_device *vdev;
> > >>>>>>>>> @@ -990,6 +1058,60 @@
> > >> vdpa_nl_cmd_dev_config_get_dumpit(struct
> > >>>>>> sk_buff *msg, struct netlink_callback *
> > >>>>>>>>>             return msg->len;
> > >>>>>>>>>       }
> > >>>>>>>>> +static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
> > >>>>>>>>> +                                     struct genl_info *info)
> > >>>>>>>>> +{
> > >>>>>>>>> +   struct vdpa_device *vdev;
> > >>>>>>>>> +   struct sk_buff *msg;
> > >>>>>>>>> +   const char *devname;
> > >>>>>>>>> +   struct device *dev;
> > >>>>>>>>> +   u32 index;
> > >>>>>>>>> +   int err;
> > >>>>>>>>> +
> > >>>>>>>>> +   if (!info->attrs[VDPA_ATTR_DEV_NAME])
> > >>>>>>>>> +           return -EINVAL;
> > >>>>>>>>> +
> > >>>>>>>>> +   if (!info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
> > >>>>>>>>> +           return -EINVAL;
> > >>>>>>>>> +
> > >>>>>>>>> +   devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> > >>>>>>>>> +   msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > >>>>>>>>> +   if (!msg)
> > >>>>>>>>> +           return -ENOMEM;
> > >>>>>>>>> +
> > >>>>>>>>> +   index = nla_get_u32(info-
> > >>> attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
> > >>>>>>>>> +   mutex_lock(&vdpa_dev_mutex);
> > >>>>>>>>> +   dev = bus_find_device(&vdpa_bus, NULL, devname,
> > >>>>>> vdpa_name_match);
> > >>>>>>>>> +   if (!dev) {
> > >>>>>>>>> +           NL_SET_ERR_MSG_MOD(info->extack, "device not
> > >> found");
> > >>>>>>>>> +           err = -ENODEV;
> > >>>>>>>>> +           goto dev_err;
> > >>>>>>>>> +   }
> > >>>>>>>>> +   vdev = container_of(dev, struct vdpa_device, dev);
> > >>>>>>>>> +   if (!vdev->mdev) {
> > >>>>>>>>> +           NL_SET_ERR_MSG_MOD(info->extack, "unmanaged
> > >> vdpa
> > >>>>>> device");
> > >>>>>>>>> +           err = -EINVAL;
> > >>>>>>>>> +           goto mdev_err;
> > >>>>>>>>> +   }
> > >>>>>>>>> +   err = vdpa_dev_vendor_stats_fill(vdev, msg, info, index);
> > >>>>>>>>> +   if (!err)
> > >>>>>>>>> +           err = genlmsg_reply(msg, info);
> > >>>>>>>>> +
> > >>>>>>>>> +   put_device(dev);
> > >>>>>>>>> +   mutex_unlock(&vdpa_dev_mutex);
> > >>>>>>>>> +
> > >>>>>>>>> +   if (err)
> > >>>>>>>>> +           nlmsg_free(msg);
> > >>>>>>>>> +
> > >>>>>>>>> +   return err;
> > >>>>>>>>> +
> > >>>>>>>>> +mdev_err:
> > >>>>>>>>> +   put_device(dev);
> > >>>>>>>>> +dev_err:
> > >>>>>>>>> +   mutex_unlock(&vdpa_dev_mutex);
> > >>>>>>>>> +   return err;
> > >>>>>>>>> +}
> > >>>>>>>>> +
> > >>>>>>>>>       static const struct nla_policy
> vdpa_nl_policy[VDPA_ATTR_MAX + 1]
> > >> = {
> > >>>>>>>>>             [VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type =
> > >>>> NLA_NUL_STRING },
> > >>>>>>>>>             [VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING
> > >>>> }, @@ -
> > >>>>>> 997,6
> > >>>>>>>>> +1119,7 @@ static const struct nla_policy
> > >>>>>> vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
> > >>>>>>>>>             [VDPA_ATTR_DEV_NET_CFG_MACADDR] =
> > >>>> NLA_POLICY_ETH_ADDR,
> > >>>>>>>>>             /* virtio spec 1.1 section 5.1.4.1 for valid MTU
> range */
> > >>>>>>>>>             [VDPA_ATTR_DEV_NET_CFG_MTU] =
> > >>>> NLA_POLICY_MIN(NLA_U16, 68),
> > >>>>>>>>> +   [VDPA_ATTR_DEV_QUEUE_INDEX] =
> > >> NLA_POLICY_RANGE(NLA_U32, 0,
> > >>>>>> 65535),
> > >>>>>>>>>       };
> > >>>>>>>>>       static const struct genl_ops vdpa_nl_ops[] = { @@ -1030,6
> > >>>>>>>>> +1153,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
> > >>>>>>>>>                     .doit = vdpa_nl_cmd_dev_config_get_doit,
> > >>>>>>>>>                     .dumpit =
> vdpa_nl_cmd_dev_config_get_dumpit,
> > >>>>>>>>>             },
> > >>>>>>>>> +   {
> > >>>>>>>>> +           .cmd = VDPA_CMD_DEV_VSTATS_GET,
> > >>>>>>>>> +           .validate = GENL_DONT_VALIDATE_STRICT |
> > >>>>>> GENL_DONT_VALIDATE_DUMP,
> > >>>>>>>>> +           .doit = vdpa_nl_cmd_dev_stats_get_doit,
> > >>>>>>>>> +           .flags = GENL_ADMIN_PERM,
> > >>>>>>>>> +   },
> > >>>>>>>>>       };
> > >>>>>>>>>       static struct genl_family vdpa_nl_family __ro_after_init
> =
> > >>>>>>>>> { diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index
> > >>>>>>>>> 2de442ececae..274203845cfc 100644
> > >>>>>>>>> --- a/include/linux/vdpa.h
> > >>>>>>>>> +++ b/include/linux/vdpa.h
> > >>>>>>>>> @@ -275,6 +275,9 @@ struct vdpa_config_ops {
> > >>>>>>>>>                                 const struct vdpa_vq_state
> *state);
> > >>>>>>>>>             int (*get_vq_state)(struct vdpa_device *vdev, u16
> idx,
> > >>>>>>>>>                                 struct vdpa_vq_state *state);
> > >>>>>>>>> +   int (*get_vendor_vq_stats)(struct vdpa_device *vdev, u16
> idx,
> > >>>>>>>>> +                              struct sk_buff *msg,
> > >>>>>>>>> +                              struct netlink_ext_ack *extack);
> > >>>>>>>>>             struct vdpa_notification_area
> > >>>>>>>>>             (*get_vq_notification)(struct vdpa_device *vdev,
> u16 idx);
> > >>>>>>>>>             /* vq irq is not expected to be changed once
> DRIVER_OK is
> > >>>>>>>>> set */ @@ -466,4 +469,6 @@ struct vdpa_mgmt_dev {
> > >>>>>>>>>       int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
> > >>>>>>>>>       void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
> > >>>>>>>>> +#define VDPA_INVAL_QUEUE_INDEX 0xffff
> > >>>>>>>>> +
> > >>>>>>>>>       #endif /* _LINUX_VDPA_H */
> > >>>>>>>>> diff --git a/include/uapi/linux/vdpa.h
> > >>>>>>>>> b/include/uapi/linux/vdpa.h index 1061d8d2d09d..c5f229a41dc2
> > >>>>>>>>> 100644
> > >>>>>>>>> --- a/include/uapi/linux/vdpa.h
> > >>>>>>>>> +++ b/include/uapi/linux/vdpa.h
> > >>>>>>>>> @@ -18,6 +18,7 @@ enum vdpa_command {
> > >>>>>>>>>             VDPA_CMD_DEV_DEL,
> > >>>>>>>>>             VDPA_CMD_DEV_GET,               /* can dump */
> > >>>>>>>>>             VDPA_CMD_DEV_CONFIG_GET,        /* can dump */
> > >>>>>>>>> +   VDPA_CMD_DEV_VSTATS_GET,
> > >>>>>>>>>       };
> > >>>>>>>>>       enum vdpa_attr {
> > >>>>>>>>> @@ -46,6 +47,12 @@ enum vdpa_attr {
> > >>>>>>>>>             VDPA_ATTR_DEV_NEGOTIATED_FEATURES,      /* u64 */
> > >>>>>>>>>             VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,          /*
> > >>>> u32 */
> > >>>>>>>>>             VDPA_ATTR_DEV_SUPPORTED_FEATURES,       /* u64 */
> > >>>>>>>>> +
> > >>>>>>>>> +   VDPA_ATTR_DEV_QUEUE_INDEX,              /* u16 */
> > >>>>>>>>> +   VDPA_ATTR_DEV_QUEUE_TYPE,               /* string */
> > >>>>>>>>> +   VDPA_ATTR_DEV_VENDOR_ATTR_NAME,         /*
> > >> string */
> > >>>>>>>>> +   VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
> > >>>>>>>>> +
> > >>>>>>>>>             /* new attributes must be added above here */
> > >>>>>>>>>             VDPA_ATTR_MAX,
> > >>>>>>>>>       };
>
>

--000000000000120dfa05da27bf0b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Mar 13, 2022 at 11:26 PM Eli =
Cohen &lt;<a href=3D"mailto:elic@nvidia.com">elic@nvidia.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; On 3/8/202=
2 9:07 PM, Eli Cohen wrote:<br>
&gt; &gt;<br>
&gt; &gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt; From: Si-Wei Liu &lt;<a href=3D"mailto:si-wei.liu@oracle.com"=
 target=3D"_blank">si-wei.liu@oracle.com</a>&gt;<br>
&gt; &gt;&gt; Sent: Wednesday, March 9, 2022 5:33 AM<br>
&gt; &gt;&gt; To: Eli Cohen &lt;<a href=3D"mailto:elic@nvidia.com" target=
=3D"_blank">elic@nvidia.com</a>&gt;<br>
&gt; &gt;&gt; Cc: <a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@r=
edhat.com</a>; <a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">jas=
owang@redhat.com</a>; virtualization@lists.linux-<br>
&gt; &gt;&gt; <a href=3D"http://foundation.org" rel=3D"noreferrer" target=
=3D"_blank">foundation.org</a>; <a href=3D"mailto:eperezma@redhat.com" targ=
et=3D"_blank">eperezma@redhat.com</a>; <a href=3D"mailto:amorenoz@redhat.co=
m" target=3D"_blank">amorenoz@redhat.com</a>;<br>
&gt; &gt;&gt; <a href=3D"mailto:lvivier@redhat.com" target=3D"_blank">lvivi=
er@redhat.com</a>; <a href=3D"mailto:sgarzare@redhat.com" target=3D"_blank"=
>sgarzare@redhat.com</a>; Parav Pandit &lt;<a href=3D"mailto:parav@nvidia.c=
om" target=3D"_blank">parav@nvidia.com</a>&gt;<br>
&gt; &gt;&gt; Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying ve=
ndor statistics<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 3/8/2022 6:13 AM, Eli Cohen wrote:<br>
&gt; &gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt;&gt;&gt; From: Si-Wei Liu &lt;<a href=3D"mailto:si-wei.liu@ora=
cle.com" target=3D"_blank">si-wei.liu@oracle.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt; Sent: Tuesday, March 8, 2022 8:16 AM<br>
&gt; &gt;&gt;&gt;&gt; To: Eli Cohen &lt;<a href=3D"mailto:elic@nvidia.com" =
target=3D"_blank">elic@nvidia.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt; Cc: <a href=3D"mailto:mst@redhat.com" target=3D"_blan=
k">mst@redhat.com</a>; <a href=3D"mailto:jasowang@redhat.com" target=3D"_bl=
ank">jasowang@redhat.com</a>; virtualization@lists.linux-<br>
&gt; &gt;&gt;&gt;&gt; <a href=3D"http://foundation.org" rel=3D"noreferrer" =
target=3D"_blank">foundation.org</a>; <a href=3D"mailto:eperezma@redhat.com=
" target=3D"_blank">eperezma@redhat.com</a>; <a href=3D"mailto:amorenoz@red=
hat.com" target=3D"_blank">amorenoz@redhat.com</a>;<br>
&gt; &gt;&gt;&gt;&gt; <a href=3D"mailto:lvivier@redhat.com" target=3D"_blan=
k">lvivier@redhat.com</a>; <a href=3D"mailto:sgarzare@redhat.com" target=3D=
"_blank">sgarzare@redhat.com</a>; Parav Pandit<br>
&gt; &gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:parav@nvidia.com" target=3D"_bl=
ank">parav@nvidia.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt; Subject: Re: [PATCH v1 1/2] vdpa: Add support for que=
rying vendor<br>
&gt; &gt;&gt;&gt;&gt; statistics<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; On 3/6/2022 11:57 PM, Eli Cohen wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; From: Si-Wei Liu &lt;<a href=3D"mailto:si-wei=
.liu@oracle.com" target=3D"_blank">si-wei.liu@oracle.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Sent: Saturday, March 5, 2022 12:34 AM<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; To: Eli Cohen &lt;<a href=3D"mailto:elic@nvid=
ia.com" target=3D"_blank">elic@nvidia.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Cc: <a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a>; <a href=3D"mailto:jasowang@redhat.com" targ=
et=3D"_blank">jasowang@redhat.com</a>;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; virtualization@lists.linux- <a href=3D"http:/=
/foundation.org" rel=3D"noreferrer" target=3D"_blank">foundation.org</a>; <=
a href=3D"mailto:eperezma@redhat.com" target=3D"_blank">eperezma@redhat.com=
</a>;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:amorenoz@redhat.com" target=
=3D"_blank">amorenoz@redhat.com</a>; <a href=3D"mailto:lvivier@redhat.com" =
target=3D"_blank">lvivier@redhat.com</a>; <a href=3D"mailto:sgarzare@redhat=
.com" target=3D"_blank">sgarzare@redhat.com</a>;<br>
&gt; &gt;&gt; Parav<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Pandit &lt;<a href=3D"mailto:parav@nvidia.com=
" target=3D"_blank">parav@nvidia.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Subject: Re: [PATCH v1 1/2] vdpa: Add support=
 for querying vendor<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; statistics<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Sorry, I somehow missed this after my break. =
Please see comments in<br>
&gt; &gt;&gt; line.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; On 2/16/2022 10:46 PM, Eli Cohen wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; On Wed, Feb 16, 2022 at 10:49:26AM -0800,=
 Si-Wei Liu wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 2/16/2022 12:00 AM, Eli Cohen wrot=
e:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Allows to read vendor statistics =
of a vdpa device. The specific<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; statistics data is received by th=
e upstream driver in the form<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; of an (attribute name, attribute =
value) pairs.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; An example of statistics for mlx5=
_vdpa device are:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; received_desc - number of descrip=
tors received by the virtqueue<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; completed_desc - number of descri=
ptors completed by the<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; virtqueue<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; A descriptor using indirect buffe=
rs is still counted as 1. In<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; addition, N chained descriptors a=
re counted correctly N times as<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; one<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; would expect.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; A new callback was added to vdpa_=
config_ops which provides the<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; means for the vdpa driver to retu=
rn statistics results.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The interface allows for reading =
all the supported virtqueues,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; including the control virtqueue i=
f it exists.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Below are some examples taken fro=
m mlx5_vdpa which are<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; introduced in the following patch=
:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 1. Read statistics for the virtqu=
eue at index 1<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; $ vdpa dev vstats show vdpa-a qid=
x 1<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; vdpa-a:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; queue_type tx queue_index 1 recei=
ved_desc 3844836<br>
&gt; &gt;&gt; completed_desc<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 3844836<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2. Read statistics for the virtqu=
eue at index 32 $ vdpa dev<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; vstats show vdpa-a qidx 32<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; vdpa-a:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; queue_type control_vq queue_index=
 32 received_desc 62<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; completed_desc<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 62<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 3. Read statisitics for the virtq=
ueue at index 0 with json<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; output $ vdpa -j dev vstats show =
vdpa-a qidx 0<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; {&quot;vstats&quot;:{&quot;vdpa-a=
&quot;:{<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; &quot;queue_type&quot;:&quot;rx&quot;,&quot;q=
ueue_index&quot;:0,&quot;name&quot;:&quot;received_desc&quot;,&quot;value&q=
uot;:41<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; 77<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; 76,\<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;n=
ame&quot;:&quot;completed_desc&quot;,&quot;value&quot;:417548}}}<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 4. Read statistics for the virtqu=
eue at index 0 with preety json<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; output $ vdpa -jp dev vstats show=
 vdpa-a qidx 0 {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &quot;vstats&quot;: {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;vdpa-a&quot;: {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;queue_type&quot;: &quot;rx&quot;,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I wonder where this info can be infer=
red? I don&#39;t see relevant<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; change in the patch series that helps=
 gather the<br>
&gt; &gt;&gt;&gt;&gt; VDPA_ATTR_DEV_QUEUE_TYPE?<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Is this an arbitrary string defined b=
y the vendor as well? If so,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; how does the user expect to consume i=
t?<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; The queue tupe is deduced from the index =
and whether we have a<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; virtqueue. Even numbers are rx, odd numbe=
rs are tx and if there is<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; CVQ, the last one is CVQ.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; OK, then VDPA_ATTR_DEV_QUEUE_TYPE attribute i=
ntroduced in this<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; patch might not be useful at all?<br>
&gt; &gt;&gt;&gt;&gt;&gt; Right, will remove.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; And how do you determine in the vdpa tool if =
CVQ is negotiated or<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; not?<br>
&gt; &gt;&gt;&gt;&gt;&gt; I make a netlink call to get the same information=
 as &quot; vdpa dev config<br>
&gt; &gt;&gt; show&quot;<br>
&gt; &gt;&gt;&gt;&gt; retrieves. I use the negotiated features to determine=
 if a CVQ is<br>
&gt; &gt;&gt;&gt;&gt; available. If it is, the number of VQs equals the con=
trol VQ index.<br>
&gt; &gt;&gt;&gt;&gt; So there are two netlink calls under the hood.<br>
&gt; &gt;&gt;&gt;&gt; The lock vdpa_dev_mutex won&#39;t hold across the two=
 separate netlink<br>
&gt; &gt;&gt;&gt;&gt; calls, and it may end up with inconsistent state - th=
eoretically<br>
&gt; &gt;&gt;&gt;&gt; things could happen like that the first call gets CVQ=
 negotiated, but<br>
&gt; &gt;&gt;&gt;&gt; the later call for<br>
&gt; &gt;&gt;&gt;&gt; get_vendor_vq_stats() on the cvq might get -EINVAL du=
e to device<br>
&gt; &gt;&gt;&gt;&gt; reset. Can the negotiated status and stat query be do=
ne within one single<br>
&gt; &gt;&gt; netlink call?<br>
&gt; &gt;&gt;&gt; I see your concern.<br>
&gt; &gt;&gt;&gt; The only reason I do the extra call is to know if we have=
 a control VQ<br>
&gt; &gt;&gt;&gt; and what index it is, just to print a descriptive string =
telling if it&#39;s a either rx,<br>
&gt; &gt;&gt; tx or control VQ.<br>
&gt; &gt;&gt;&gt; So the cure can be simple. Let&#39;s have a new attribute=
 that returns the<br>
&gt; &gt;&gt;&gt; type of virtqueue.<br>
&gt; &gt;&gt; I am not sure I follow the cure. Wouldn&#39;t it be possible =
to get both negotiated<br>
&gt; &gt;&gt; status and the queue stat in vdpa_nl_cmd_dev_stats_get_doit()=
 under the<br>
&gt; &gt;&gt; same vdpa_dev_mutex lock?<br>
&gt; &gt; Yes we can, but I suggested to get only the type of the queue as =
a new attribute.<br>
&gt; &gt; The kernel will do the digest and decide per a given VQ if it&#39=
;s rx, tx or control and<br>
&gt; &gt; return the result in that new attribute.<br>
&gt; The rx, tx and control queue type is net specific, while the vdpa core=
<br>
&gt; is currently agnostic to the vdpa class.<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;&gt; And I am not even sure if it is a must to display<br>
&gt; &gt;&gt; the queue type - it doesn&#39;t seem the output includes the =
vdpa class info, which<br>
&gt; &gt;&gt; makes it hard for script to parse the this field in generic w=
ay.<br>
&gt; &gt; I don&#39;t get you. You say you don&#39;t think you need the que=
ue type and at the same<br>
&gt; &gt; time you&#39;re concerned lack of information makes it hard for s=
cripts.<br>
&gt; &gt; BTW, class info is something you can get for the device through &=
quot;vdpa dev show&quot;<br>
&gt; &gt; so your know the class of your device.<br>
&gt; Stepping back, may I ask if there&#39;s a case that queue type specifi=
c stat<br>
&gt; may be defined by vendor, such that deciphering of certain vendor stat=
<br>
&gt; would need type specific knowledge? So far the received_desc and<br>
&gt; completed_desc stats offered through the mlx5_vdpa patch look to be<br=
>
&gt; general ones and not associated with any queue type in particular. Is<=
br>
&gt; there some future stat in your mind that needs specific knowledge of<b=
r>
&gt; queue type and vdpa class?<br>
<br>
No, the only reason for displaying the queue type is to help users<br>
know kind of queue they&#39;re looking at.<br>
<br>
&gt; <br>
&gt; I&#39;d prefer the vstat output to be self-contained and self-descript=
ive.<br>
&gt; You may argue the class of vdpa never changes in &quot;vdpa dev show&q=
uot; after<br>
&gt; creation. This is true, however the queue type is not - say you got a<=
br>
&gt; control queue for qindex 2, but the next moment you may get a rx queue=
<br>
&gt; with the same qindex.<br>
<br>
I don&#39;t think this is possible unless you destroyed the device and re-c=
reated it.<br>
What operation do you think could cause that?<br>
<br>
&gt; Particularly you seem want to tie this with queue<br>
&gt; index in the guest view, which is quite dynamic for host admin or scri=
pt<br>
&gt; running on the host to follow.<br>
<br>
For rx and tx queues, some index may become invalid if the user changed<br>
the number of queues with ethtool -L but I don&#39;t think this is an issue=
.<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 I think Jason did not like the idea of commu=
nicating the kind of VQ<br>
&gt; &gt;&gt;&gt; from kernel to userspace but under these circumstances, m=
aybe he would<br>
&gt; &gt;&gt; approve.<br>
&gt; &gt;&gt;&gt; Jason?<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; What worried me is that the queue index being dynamic=
 and depended on<br>
&gt; &gt;&gt;&gt;&gt; negotiation status would make host admin user quite h=
ard to follow.<br>
&gt; &gt;&gt;&gt;&gt; The guest may or may not advertise F_MQ and/or F_CTRL=
_VQ across<br>
&gt; &gt;&gt; various phases, e.g.<br>
&gt; &gt;&gt;&gt;&gt; firmware (UEFI), boot loader (grub) till OS driver is=
 up and running,<br>
&gt; &gt;&gt;&gt;&gt; which can be agnostic to host admin. For most of the =
part it&#39;s not<br>
&gt; &gt;&gt;&gt;&gt; easy to script and predict the queue index which can =
change from time<br>
&gt; &gt;&gt;&gt;&gt; to time. Can we define the order of host predictable =
queue index,<br>
&gt; &gt;&gt;&gt;&gt; which is independent from any guest negotiated state?=
<br>
&gt; &gt;&gt; Here I think we can just use the plain queue index in the hos=
t view - say if vdpa<br>
&gt; &gt;&gt; net has 4 pairs of data vqs and 1 control vq, user may use qi=
ndex 8 across the<br>
&gt; &gt;&gt; board to identify the control vq, regardless if the F_MQ feat=
ure is negotiated<br>
&gt; &gt;&gt; or not in guest.<br>
&gt; &gt; Right, but the idea that a userspace tool should provide useful i=
nformation to the<br>
&gt; &gt; user so it does not need to do complex logic to infer that from b=
are data.<br>
&gt; The host side qindex and qtype would never change regardless of guest<=
br>
&gt; feature negotiation, by nature it reflects the real construct and obje=
ct<br>
&gt; in the hardware.</blockquote><div><br></div><div>This should be possib=
le for vendor specific stats. But I&#39;m afraid it may cause more confusio=
n since the spec doesn&#39;t have the concept like &quot;host queue index&q=
uot;. And to be self descriptive the vendor need also display the mappings =
between virtqueue index and host(vendor) queue index.</div><div><br></div><=
div>Thanks</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"> I don&#39;t feel it&#39;s a simple task for host users to<br>
&gt; figure out the correct guest side qindex for the control queue -=C2=A0=
 it&#39;s<br>
&gt; always racy for one to check some other vdpa command output if the vst=
at<br>
&gt; output is not self-contained.<br>
<br>
So what are you actually proposing? Display received and completed descript=
ors<br>
per queue index without further interpretation?<br>
<br>
&gt; <br>
&gt; Thanks,<br>
&gt; -Siwei<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Regards,<br>
&gt; &gt;&gt; -Siwei<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Looks to me there are still some loose end I =
don&#39;t quite yet<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; understand.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;queue_index&quot;: 0,<br>
&gt; &gt;&gt;&gt;&gt;&gt; I think this can be removed since the command is =
for a specific index.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;received_desc&quot;,<b=
r>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;value&quot;: 417776,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;completed_desc&quot;,<=
br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;value&quot;: 417548<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Not for this kernel patch, but IMHO i=
t&#39;s the best to put the name<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &amp; value pairs in an array instead=
 of flat entries in json&#39;s<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; hash/dictionary. The hash entries can=
 be re-ordered deliberately<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; by external json parsing tool, ending=
 up with inconsistent stat values.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; This comment is missed for some reason. Pleas=
e change the example<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; in the log if you agree to address it in vdpa=
 tool. Or justify why<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; keeping the order for json hash/dictionary is=
 fine.<br>
&gt; &gt;&gt;&gt;&gt;&gt; Sorry for skipping this comment.<br>
&gt; &gt;&gt;&gt;&gt;&gt; Do you mean to present the information like:<br>
&gt; &gt;&gt;&gt;&gt;&gt; &quot;received_desc&quot;: 417776,<br>
&gt; &gt;&gt;&gt;&gt;&gt; &quot;completed_desc&quot;: 417548,<br>
&gt; &gt;&gt;&gt;&gt; I mean the following presentation:<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; $ vdpa -jp dev vstats show vdpa-a qidx 0 {<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vstats&quot;: {<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vdpa-a=
&quot;: {<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;queue_stats&quot;: [{<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;queue_index&quot;: 0,<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;queue_type&quot;: &quot;rx&quot;,<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;stat_name&quot;: [ &quot;received_desc&quot;,&quot;=
completed_desc&quot; ],<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;stat_value&quot;: [ 417776,417548 ],<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }]<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;&gt;&gt; }<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; I think Parav had similar suggestion, too.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Thanks,<br>
&gt; &gt;&gt;&gt;&gt; -Siwei<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Thanks,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -Siwei<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Thanks,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -Siwei<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 }<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; }<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Signed-off-by: Eli Cohen &lt;<a h=
ref=3D"mailto:elic@nvidia.com" target=3D"_blank">elic@nvidia.com</a>&gt;<br=
>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drivers=
/vdpa/vdpa.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 129<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; ++++++++++++++++++++++++++++++++++++++<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0include=
/linux/vdpa.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 ++<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0include=
/uapi/linux/vdpa.h |=C2=A0 =C2=A07 +++<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A03 files=
 changed, 141 insertions(+)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/vdpa/vdpa.c =
b/drivers/vdpa/vdpa.c index<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 9846c9de4bfa..d0ff671baf88 100644=
<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; --- a/drivers/vdpa/vdpa.c<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +++ b/drivers/vdpa/vdpa.c<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -909,6 +909,74 @@ vdpa_dev_con=
fig_fill(struct vdpa_device<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; *vdev,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; struct sk_buff *msg, u32 portid,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return err;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +static int vdpa_fill_stats_rec(s=
truct vdpa_device *vdev, struct<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +sk_buff<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; *msg,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct genl_inf=
o *info, u32 index) {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0int err;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0if (nla_put_u32(msg=
, VDPA_ATTR_DEV_QUEUE_INDEX, index))<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EMSGSIZE;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0err =3D vdev-&gt;co=
nfig-&gt;get_vendor_vq_stats(vdev, index, msg,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +info-<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; extack);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0if (err)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return err;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0return 0;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +static int vendor_stats_fill(str=
uct vdpa_device *vdev, struct<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +sk_buff<br>
&gt; &gt;&gt;&gt;&gt; *msg,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct genl_info *info=
, u32 index) {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0int err;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0if (!vdev-&gt;confi=
g-&gt;get_vendor_vq_stats)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EOPNOTSUPP;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0err =3D vdpa_fill_s=
tats_rec(vdev, msg, info, index);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0if (err)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return err;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0return 0;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +static int vdpa_dev_vendor_stats=
_fill(struct vdpa_device *vdev,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0struct sk_buff *msg,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0struct genl_info *info, u32 index) {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0u32 device_id;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0void *hdr;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0int err;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0u32 portid =3D info=
-&gt;snd_portid;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0u32 seq =3D info-&g=
t;snd_seq;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0u32 flags =3D 0;<br=
>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0hdr =3D genlmsg_put=
(msg, portid, seq, &amp;vdpa_nl_family, flags,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VDPA_CMD_DEV_VSTATS_GET);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0if (!hdr)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EMSGSIZE;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0if (nla_put_string(=
msg, VDPA_ATTR_DEV_NAME,<br>
&gt; &gt;&gt; dev_name(&amp;vdev-<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; dev))) {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0err =3D -EMSGSIZE;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto undo_msg;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0}<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0device_id =3D vdev-=
&gt;config-&gt;get_device_id(vdev);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0if (nla_put_u32(msg=
, VDPA_ATTR_DEV_ID, device_id)) {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0err =3D -EMSGSIZE;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto undo_msg;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0}<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0err =3D vendor_stat=
s_fill(vdev, msg, info, index);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0genlmsg_end(msg, hd=
r);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0return err;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +undo_msg:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0genlmsg_cancel(msg,=
 hdr);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0return err;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0static =
int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; *skb, struct<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; genl_info *info)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0struct vdpa_device *vdev;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -990,6 +1058,60 @@<br>
&gt; &gt;&gt; vdpa_nl_cmd_dev_config_get_dumpit(struct<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; sk_buff *msg, struct netlink_callback *<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return msg-&gt;len;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +static int vdpa_nl_cmd_dev_stats=
_get_doit(struct sk_buff *skb,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct genl_info *info)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0struct vdpa_device =
*vdev;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0struct sk_buff *msg=
;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0const char *devname=
;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0struct device *dev;=
<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0u32 index;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0int err;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0if (!info-&gt;attrs=
[VDPA_ATTR_DEV_NAME])<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0if (!info-&gt;attrs=
[VDPA_ATTR_DEV_QUEUE_INDEX])<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0devname =3D nla_dat=
a(info-&gt;attrs[VDPA_ATTR_DEV_NAME]);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0msg =3D nlmsg_new(N=
LMSG_DEFAULT_SIZE, GFP_KERNEL);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0if (!msg)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -ENOMEM;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0index =3D nla_get_u=
32(info-<br>
&gt; &gt;&gt;&gt; attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0mutex_lock(&amp;vdp=
a_dev_mutex);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0dev =3D bus_find_de=
vice(&amp;vdpa_bus, NULL, devname,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; vdpa_name_match);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0if (!dev) {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0NL_SET_ERR_MSG_MOD(info-&gt;extack, &quot;device not<br>
&gt; &gt;&gt; found&quot;);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0err =3D -ENODEV;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto dev_err;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0}<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0vdev =3D container_=
of(dev, struct vdpa_device, dev);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0if (!vdev-&gt;mdev)=
 {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0NL_SET_ERR_MSG_MOD(info-&gt;extack, &quot;unmanaged<br>
&gt; &gt;&gt; vdpa<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; device&quot;);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0err =3D -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto mdev_err;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0}<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0err =3D vdpa_dev_ve=
ndor_stats_fill(vdev, msg, info, index);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0if (!err)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0err =3D genlmsg_reply(msg, info);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0put_device(dev);<br=
>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0mutex_unlock(&amp;v=
dpa_dev_mutex);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0if (err)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0nlmsg_free(msg);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0return err;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +mdev_err:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0put_device(dev);<br=
>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +dev_err:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0mutex_unlock(&amp;v=
dpa_dev_mutex);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0return err;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0static =
const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1]<br>
&gt; &gt;&gt; =3D {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0[VDPA_ATTR_MGMTDEV_BUS_NAME] =3D { .type =3D<br>
&gt; &gt;&gt;&gt;&gt; NLA_NUL_STRING },<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0[VDPA_ATTR_MGMTDEV_DEV_NAME] =3D { .type =3D NLA_STRING<br>
&gt; &gt;&gt;&gt;&gt; }, @@ -<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; 997,6<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +1119,7 @@ static const struct nl=
a_policy<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; vdpa_nl_policy[VDPA_ATTR_MAX + 1] =3D {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0[VDPA_ATTR_DEV_NET_CFG_MACADDR] =3D<br>
&gt; &gt;&gt;&gt;&gt; NLA_POLICY_ETH_ADDR,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0[VDPA_ATTR_DEV_NET_CFG_MTU] =3D<br>
&gt; &gt;&gt;&gt;&gt; NLA_POLICY_MIN(NLA_U16, 68),<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0[VDPA_ATTR_DEV_QUEU=
E_INDEX] =3D<br>
&gt; &gt;&gt; NLA_POLICY_RANGE(NLA_U32, 0,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; 65535),<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0static =
const struct genl_ops vdpa_nl_ops[] =3D { @@ -1030,6<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +1153,12 @@ static const struct g=
enl_ops vdpa_nl_ops[] =3D {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.doit =3D vdpa_nl_cmd_dev_config_=
get_doit,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.dumpit =3D vdpa_nl_cmd_dev_confi=
g_get_dumpit,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0},<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0{<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.cmd =3D VDPA_CMD_DEV_VSTATS_GET,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.validate =3D GENL_DONT_VALIDATE_STRICT |<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; GENL_DONT_VALIDATE_DUMP,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.doit =3D vdpa_nl_cmd_dev_stats_get_doit,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.flags =3D GENL_ADMIN_PERM,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0},<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0static =
struct genl_family vdpa_nl_family __ro_after_init =3D<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; { diff --git a/include/linux/vdpa=
.h b/include/linux/vdpa.h index<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2de442ececae..274203845cfc 100644=
<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; --- a/include/linux/vdpa.h<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +++ b/include/linux/vdpa.h<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -275,6 +275,9 @@ struct vdpa_c=
onfig_ops {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const struct vdpa_vq_state *state);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct vdpa_vq_state *state);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0int (*get_vendor_vq=
_stats)(struct vdpa_device *vdev, u16 idx,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
truct sk_buff *msg,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
truct netlink_ext_ack *extack);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0struct vdpa_notification_area<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);<br=
>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* vq irq is not expected to be changed once DRIVER_OK is<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; set */ @@ -466,4 +469,6 @@ struct=
 vdpa_mgmt_dev {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int vdp=
a_mgmtdev_register(struct vdpa_mgmt_dev *mdev);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0void vd=
pa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +#define VDPA_INVAL_QUEUE_INDEX 0=
xffff<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0#endif =
/* _LINUX_VDPA_H */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; diff --git a/include/uapi/linux/v=
dpa.h<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; b/include/uapi/linux/vdpa.h index=
 1061d8d2d09d..c5f229a41dc2<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 100644<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; --- a/include/uapi/linux/vdpa.h<b=
r>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +++ b/include/uapi/linux/vdpa.h<b=
r>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -18,6 +18,7 @@ enum vdpa_comma=
nd {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0VDPA_CMD_DEV_DEL,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0VDPA_CMD_DEV_GET,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* can dump */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0VDPA_CMD_DEV_CONFIG_GET,=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* can du=
mp */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0VDPA_CMD_DEV_VSTATS=
_GET,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0enum vd=
pa_attr {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -46,6 +47,12 @@ enum vdpa_attr=
 {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0VDPA_ATTR_DEV_NEGOTIATED_FEATURES,=C2=A0 =C2=A0 =C2=A0 /* u64=
 */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /*<br>
&gt; &gt;&gt;&gt;&gt; u32 */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0VDPA_ATTR_DEV_SUPPORTED_FEATURES,=C2=A0 =C2=A0 =C2=A0 =C2=A0/=
* u64 */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0VDPA_ATTR_DEV_QUEUE=
_INDEX,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* u16 */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0VDPA_ATTR_DEV_QUEUE=
_TYPE,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* string */<b=
r>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0VDPA_ATTR_DEV_VENDO=
R_ATTR_NAME,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt;&gt; string */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0VDPA_ATTR_DEV_VENDO=
R_ATTR_VALUE,=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* u64 */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* new attributes must be added above here */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0VDPA_ATTR_MAX,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
<br>
</blockquote></div></div>

--000000000000120dfa05da27bf0b--


--===============2470350477935090206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2470350477935090206==--

