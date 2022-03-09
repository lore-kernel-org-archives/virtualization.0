Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE794C433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 02:40:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62E67417BC;
	Wed,  9 Mar 2022 02:40:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M9diSBIkUfVf; Wed,  9 Mar 2022 02:40:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C7128417BA;
	Wed,  9 Mar 2022 02:40:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5078C001D;
	Wed,  9 Mar 2022 02:40:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCFEFC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 02:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A22AE40103
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 02:40:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SxD3v3OKjRwT
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 02:40:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A62D3400CB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 02:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646793610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fsypai228pysrrYSQFjyPRGerqe1p8neYPAnlj5euOk=;
 b=Rj69FAqIFSpxpjWQI+0/GJUU8MzBQi9j7MMy4hzDhDh1NxQ5oCcn4KSflEQpuaIvShEqD+
 anlACH7e0Y1qOUBV5g6+/a3+PZJFC6pCUyT1V0kVKSgJiEfG4Jhras7yY4p/0otAPr7/DN
 yg6ve1xFa5wn7smSmFTW2/7OO6D0Fnw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-yMXJbtwQPS-HzQIke_IFOA-1; Tue, 08 Mar 2022 21:39:52 -0500
X-MC-Unique: yMXJbtwQPS-HzQIke_IFOA-1
Received: by mail-lf1-f71.google.com with SMTP id
 x12-20020a0565123f8c00b004482e097a3bso311474lfa.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 18:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fsypai228pysrrYSQFjyPRGerqe1p8neYPAnlj5euOk=;
 b=cqo17pvHkE+QCbywGb6toXRpv1Wxe3jGilP2wIge7Mfqms1r43FCQR9n2evceISOxq
 XBO67jJC3jfKn2lHNCEXBGDbd1NnI2v1j7e9LsqT6RoKuO3ic8aH9PFuOOwGD1H4b8hA
 RenKrcljcnQWnoQ9PhU+E07vuXeAVdEoWTM7E8X7bmd+055srVMvtmwp5Nu2Uku640gi
 ZogjXkyUBpzfjWXkMhXrZ380q2qpaCZE8gpeHnr9bf5Y/weNcOwKpIpXXA0QFy+lV0br
 wf0I6Xn0dF0J1cb2VHcmpEwdY6ENXkyQ27Z7t3+xdgVLQjP2dbTHOdM/epRH1MbJ9Wsw
 tD2w==
X-Gm-Message-State: AOAM533PuSLg876wQ6b2jcd5KXWqcwezmoaZrnwiPMe/FvxQ2u3d4r7V
 jRSP7L78AiyYCPP1D72kvXY+6IpKwQbmz3g3O9j9hLeceFYkgYPFeMsS8iaC/kz/tEecnXO8u0Q
 G6eg72rARcUyPh2YDM9xnFmHSy6NZNZ0RrF53gnv/DuvN5zIpChF7vLkr1Q==
X-Received: by 2002:a05:651c:b23:b0:247:ee17:e9ed with SMTP id
 b35-20020a05651c0b2300b00247ee17e9edmr4376191ljr.243.1646793590448; 
 Tue, 08 Mar 2022 18:39:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRB6mj3gNrSCJ5CifG+6GI9Q0KvBYDI0XnS+z7yTB8SE2p4JVtzXkejjWuYmWKpeUTXJUzVbJnuour9CrnE0I=
X-Received: by 2002:a05:651c:b23:b0:247:ee17:e9ed with SMTP id
 b35-20020a05651c0b2300b00247ee17e9edmr4376172ljr.243.1646793590029; Tue, 08
 Mar 2022 18:39:50 -0800 (PST)
MIME-Version: 1.0
References: <20220216080022.56707-1-elic@nvidia.com>
 <20220216080022.56707-2-elic@nvidia.com>
 <22f77b5c-2003-c963-24c9-fce9cb53160d@oracle.com>
 <20220217064619.GB86497@mtl-vdi-166.wap.labs.mlnx>
 <8e834c04-47d2-1286-117d-28caa3e84606@oracle.com>
 <DM8PR12MB5400E80073521E898056578BAB089@DM8PR12MB5400.namprd12.prod.outlook.com>
 <6175d620-6be3-c249-5482-0a9448499e4a@oracle.com>
 <DM8PR12MB5400E03D7AD7833CEBF8DF9DAB099@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5400E03D7AD7833CEBF8DF9DAB099@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Mar 2022 10:39:38 +0800
Message-ID: <CACGkMEvT1oiTM+sKSYcRnNAJ6gTjuYkL=9kA_Tq6wPqHPfz2dw@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============7734428198435906213=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============7734428198435906213==
Content-Type: multipart/alternative; boundary="000000000000f3d4c505d9c00299"

--000000000000f3d4c505d9c00299
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 8, 2022 at 10:13 PM Eli Cohen <elic@nvidia.com> wrote:

>
>
> > -----Original Message-----
> > From: Si-Wei Liu <si-wei.liu@oracle.com>
> > Sent: Tuesday, March 8, 2022 8:16 AM
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: mst@redhat.com; jasowang@redhat.com; virtualization@lists.linux-
> > foundation.org; eperezma@redhat.com; amorenoz@redhat.com;
> > lvivier@redhat.com; sgarzare@redhat.com; Parav Pandit <parav@nvidia.com>
> > Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying vendor
> statistics
> >
> >
> >
> > On 3/6/2022 11:57 PM, Eli Cohen wrote:
> > >
> > >> -----Original Message-----
> > >> From: Si-Wei Liu <si-wei.liu@oracle.com>
> > >> Sent: Saturday, March 5, 2022 12:34 AM
> > >> To: Eli Cohen <elic@nvidia.com>
> > >> Cc: mst@redhat.com; jasowang@redhat.com; virtualization@lists.linux-
> > >> foundation.org; eperezma@redhat.com; amorenoz@redhat.com;
> > >> lvivier@redhat.com; sgarzare@redhat.com; Parav Pandit
> > >> <parav@nvidia.com>
> > >> Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying vendor
> > >> statistics
> > >>
> > >> Sorry, I somehow missed this after my break. Please see comments in
> line.
> > >>
> > >> On 2/16/2022 10:46 PM, Eli Cohen wrote:
> > >>> On Wed, Feb 16, 2022 at 10:49:26AM -0800, Si-Wei Liu wrote:
> > >>>> On 2/16/2022 12:00 AM, Eli Cohen wrote:
> > >>>>> Allows to read vendor statistics of a vdpa device. The specific
> > >>>>> statistics data is received by the upstream driver in the form of
> > >>>>> an (attribute name, attribute value) pairs.
> > >>>>>
> > >>>>> An example of statistics for mlx5_vdpa device are:
> > >>>>>
> > >>>>> received_desc - number of descriptors received by the virtqueue
> > >>>>> completed_desc - number of descriptors completed by the virtqueue
> > >>>>>
> > >>>>> A descriptor using indirect buffers is still counted as 1. In
> > >>>>> addition, N chained descriptors are counted correctly N times as
> > >>>>> one
> > >> would expect.
> > >>>>> A new callback was added to vdpa_config_ops which provides the
> > >>>>> means for the vdpa driver to return statistics results.
> > >>>>>
> > >>>>> The interface allows for reading all the supported virtqueues,
> > >>>>> including the control virtqueue if it exists.
> > >>>>>
> > >>>>> Below are some examples taken from mlx5_vdpa which are introduced
> > >>>>> in the following patch:
> > >>>>>
> > >>>>> 1. Read statistics for the virtqueue at index 1
> > >>>>>
> > >>>>> $ vdpa dev vstats show vdpa-a qidx 1
> > >>>>> vdpa-a:
> > >>>>> queue_type tx queue_index 1 received_desc 3844836 completed_desc
> > >>>>> 3844836
> > >>>>>
> > >>>>> 2. Read statistics for the virtqueue at index 32 $ vdpa dev vstats
> > >>>>> show vdpa-a qidx 32
> > >>>>> vdpa-a:
> > >>>>> queue_type control_vq queue_index 32 received_desc 62
> > >>>>> completed_desc
> > >>>>> 62
> > >>>>>
> > >>>>> 3. Read statisitics for the virtqueue at index 0 with json output
> > >>>>> $ vdpa -j dev vstats show vdpa-a qidx 0 {"vstats":{"vdpa-a":{
> > >>>>>
> > >> "queue_type":"rx","queue_index":0,"name":"received_desc","value":4177
> > >> 76,\
> > >>>>>     "name":"completed_desc","value":417548}}}
> > >>>>>
> > >>>>> 4. Read statistics for the virtqueue at index 0 with preety json
> > >>>>> output $ vdpa -jp dev vstats show vdpa-a qidx 0 {
> > >>>>>        "vstats": {
> > >>>>>            "vdpa-a": {
> > >>>>>
> > >>>>>                "queue_type": "rx",
> > >>>> I wonder where this info can be inferred? I don't see relevant
> > >>>> change in the patch series that helps gather the
> > VDPA_ATTR_DEV_QUEUE_TYPE?
> > >>>> Is this an arbitrary string defined by the vendor as well? If so,
> > >>>> how does the user expect to consume it?
> > >>> The queue tupe is deduced from the index and whether we have a
> > >>> virtqueue. Even numbers are rx, odd numbers are tx and if there is
> > >>> CVQ, the last one is CVQ.
> > >> OK, then VDPA_ATTR_DEV_QUEUE_TYPE attribute introduced in this patch
> > >> might not be useful at all?
> > > Right, will remove.
> > >
> > >> And how do you determine in the vdpa tool if CVQ is negotiated or
> > >> not?
> > > I make a netlink call to get the same information as " vdpa dev config
> show"
> > retrieves. I use the negotiated features to determine if a CVQ is
> available. If it
> > is, the number of VQs equals the control VQ index. So there are two
> netlink
> > calls under the hood.
> > The lock vdpa_dev_mutex won't hold across the two separate netlink
> calls, and
> > it may end up with inconsistent state - theoretically things could
> happen like
> > that the first call gets CVQ negotiated, but the later call for
> > get_vendor_vq_stats() on the cvq might get -EINVAL due to device reset.
> Can
> > the negotiated status and stat query be done within one single netlink
> call?
>
> I see your concern.
> The only reason I do the extra call is to know if we have a control VQ and
> what
> index it is, just to print a descriptive string telling if it's a either
> rx, tx or control VQ.
>
> So the cure can be simple. Let's have a new attribute that returns the
> type of
> virtqueue. I think Jason did not like the idea of communicating the kind
> of VQ
> from kernel to userspace but under these circumstances, maybe he would
> approve.
> Jason?
>


I may miss something but I still don't get the reason for this. I think the
atom could be done by using a single netlink call. Then the userspace could
deduce the queue type based on the negotiated features.

For returning the type, it means the vdpa core has the device specific
knowledge which still seems sub-optimal.

Thanks



>
> >
> > What worried me is that the queue index being dynamic and depended on
> > negotiation status would make host admin user quite hard to follow. The
> guest
> > may or may not advertise F_MQ and/or F_CTRL_VQ across various phases,
> e.g.
> > firmware (UEFI), boot loader (grub) till OS driver is up and running,
> which can
> > be agnostic to host admin. For most of the part it's not easy to script
> and
> > predict the queue index which can change from time to time. Can we define
> > the order of host predictable queue index, which is independent from any
> > guest negotiated state?
> >
> > >
> > >> Looks to me there are still some loose end I don't quite yet
> > >> understand.
> > >>
> > >>
> > >>>>>                "queue_index": 0,
> > > I think this can be removed since the command is for a specific index.
> > >
> > >>>>>                "name": "received_desc",
> > >>>>>                "value": 417776,
> > >>>>>                "name": "completed_desc",
> > >>>>>                "value": 417548
> > >>>> Not for this kernel patch, but IMHO it's the best to put the name &
> > >>>> value pairs in an array instead of flat entries in json's
> > >>>> hash/dictionary. The hash entries can be re-ordered deliberately by
> > >>>> external json parsing tool, ending up with inconsistent stat values.
> > >> This comment is missed for some reason. Please change the example in
> > >> the log if you agree to address it in vdpa tool. Or justify why
> > >> keeping the order for json hash/dictionary is fine.
> > > Sorry for skipping this comment.
> > > Do you mean to present the information like:
> > > "received_desc": 417776,
> > > "completed_desc": 417548,
> > I mean the following presentation:
> >
> > $ vdpa -jp dev vstats show vdpa-a qidx 0 {
> >      "vstats": {
> >          "vdpa-a": {
> >              "queue_stats": [{
> >                  "queue_index": 0,
> >                  "queue_type": "rx",
> >                  "stat_name": [ "received_desc","completed_desc" ],
> >                  "stat_value": [ 417776,417548 ],
> >              }]
> >          }
> >      }
> > }
> >
> > I think Parav had similar suggestion, too.
> >
> > Thanks,
> > -Siwei
> >
> > >
> > >> Thanks,
> > >> -Siwei
> > >>
> > >>>> Thanks,
> > >>>> -Siwei
> > >>>>>            }
> > >>>>>        }
> > >>>>> }
> > >>>>>
> > >>>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
> > >>>>> ---
> > >>>>>     drivers/vdpa/vdpa.c       | 129
> > >> ++++++++++++++++++++++++++++++++++++++
> > >>>>>     include/linux/vdpa.h      |   5 ++
> > >>>>>     include/uapi/linux/vdpa.h |   7 +++
> > >>>>>     3 files changed, 141 insertions(+)
> > >>>>>
> > >>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> > >>>>> 9846c9de4bfa..d0ff671baf88 100644
> > >>>>> --- a/drivers/vdpa/vdpa.c
> > >>>>> +++ b/drivers/vdpa/vdpa.c
> > >>>>> @@ -909,6 +909,74 @@ vdpa_dev_config_fill(struct vdpa_device
> > >>>>> *vdev,
> > >> struct sk_buff *msg, u32 portid,
> > >>>>>         return err;
> > >>>>>     }
> > >>>>> +static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct
> > >>>>> +sk_buff
> > >> *msg,
> > >>>>> +                              struct genl_info *info, u32 index) {
> > >>>>> +       int err;
> > >>>>> +
> > >>>>> +       if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
> > >>>>> +               return -EMSGSIZE;
> > >>>>> +
> > >>>>> +       err = vdev->config->get_vendor_vq_stats(vdev, index, msg,
> info-
> > >>> extack);
> > >>>>> +       if (err)
> > >>>>> +               return err;
> > >>>>> +
> > >>>>> +       return 0;
> > >>>>> +}
> > >>>>> +
> > >>>>> +static int vendor_stats_fill(struct vdpa_device *vdev, struct
> sk_buff
> > *msg,
> > >>>>> +                            struct genl_info *info, u32 index) {
> > >>>>> +       int err;
> > >>>>> +
> > >>>>> +       if (!vdev->config->get_vendor_vq_stats)
> > >>>>> +               return -EOPNOTSUPP;
> > >>>>> +
> > >>>>> +       err = vdpa_fill_stats_rec(vdev, msg, info, index);
> > >>>>> +       if (err)
> > >>>>> +               return err;
> > >>>>> +
> > >>>>> +       return 0;
> > >>>>> +}
> > >>>>> +
> > >>>>> +static int vdpa_dev_vendor_stats_fill(struct vdpa_device *vdev,
> > >>>>> +                                     struct sk_buff *msg,
> > >>>>> +                                     struct genl_info *info, u32
> index) {
> > >>>>> +       u32 device_id;
> > >>>>> +       void *hdr;
> > >>>>> +       int err;
> > >>>>> +       u32 portid = info->snd_portid;
> > >>>>> +       u32 seq = info->snd_seq;
> > >>>>> +       u32 flags = 0;
> > >>>>> +
> > >>>>> +       hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
> > >>>>> +                         VDPA_CMD_DEV_VSTATS_GET);
> > >>>>> +       if (!hdr)
> > >>>>> +               return -EMSGSIZE;
> > >>>>> +
> > >>>>> +       if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev-
> > >>> dev))) {
> > >>>>> +               err = -EMSGSIZE;
> > >>>>> +               goto undo_msg;
> > >>>>> +       }
> > >>>>> +
> > >>>>> +       device_id = vdev->config->get_device_id(vdev);
> > >>>>> +       if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
> > >>>>> +               err = -EMSGSIZE;
> > >>>>> +               goto undo_msg;
> > >>>>> +       }
> > >>>>> +
> > >>>>> +       err = vendor_stats_fill(vdev, msg, info, index);
> > >>>>> +
> > >>>>> +       genlmsg_end(msg, hdr);
> > >>>>> +
> > >>>>> +       return err;
> > >>>>> +
> > >>>>> +undo_msg:
> > >>>>> +       genlmsg_cancel(msg, hdr);
> > >>>>> +       return err;
> > >>>>> +}
> > >>>>> +
> > >>>>>     static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff
> > >>>>> *skb, struct
> > >> genl_info *info)
> > >>>>>     {
> > >>>>>         struct vdpa_device *vdev;
> > >>>>> @@ -990,6 +1058,60 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct
> > >> sk_buff *msg, struct netlink_callback *
> > >>>>>         return msg->len;
> > >>>>>     }
> > >>>>> +static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
> > >>>>> +                                         struct genl_info *info)
> > >>>>> +{
> > >>>>> +       struct vdpa_device *vdev;
> > >>>>> +       struct sk_buff *msg;
> > >>>>> +       const char *devname;
> > >>>>> +       struct device *dev;
> > >>>>> +       u32 index;
> > >>>>> +       int err;
> > >>>>> +
> > >>>>> +       if (!info->attrs[VDPA_ATTR_DEV_NAME])
> > >>>>> +               return -EINVAL;
> > >>>>> +
> > >>>>> +       if (!info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
> > >>>>> +               return -EINVAL;
> > >>>>> +
> > >>>>> +       devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> > >>>>> +       msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > >>>>> +       if (!msg)
> > >>>>> +               return -ENOMEM;
> > >>>>> +
> > >>>>> +       index =
> nla_get_u32(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
> > >>>>> +       mutex_lock(&vdpa_dev_mutex);
> > >>>>> +       dev = bus_find_device(&vdpa_bus, NULL, devname,
> > >> vdpa_name_match);
> > >>>>> +       if (!dev) {
> > >>>>> +               NL_SET_ERR_MSG_MOD(info->extack, "device not
> found");
> > >>>>> +               err = -ENODEV;
> > >>>>> +               goto dev_err;
> > >>>>> +       }
> > >>>>> +       vdev = container_of(dev, struct vdpa_device, dev);
> > >>>>> +       if (!vdev->mdev) {
> > >>>>> +               NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa
> > >> device");
> > >>>>> +               err = -EINVAL;
> > >>>>> +               goto mdev_err;
> > >>>>> +       }
> > >>>>> +       err = vdpa_dev_vendor_stats_fill(vdev, msg, info, index);
> > >>>>> +       if (!err)
> > >>>>> +               err = genlmsg_reply(msg, info);
> > >>>>> +
> > >>>>> +       put_device(dev);
> > >>>>> +       mutex_unlock(&vdpa_dev_mutex);
> > >>>>> +
> > >>>>> +       if (err)
> > >>>>> +               nlmsg_free(msg);
> > >>>>> +
> > >>>>> +       return err;
> > >>>>> +
> > >>>>> +mdev_err:
> > >>>>> +       put_device(dev);
> > >>>>> +dev_err:
> > >>>>> +       mutex_unlock(&vdpa_dev_mutex);
> > >>>>> +       return err;
> > >>>>> +}
> > >>>>> +
> > >>>>>     static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX +
> 1] = {
> > >>>>>         [VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type =
> > NLA_NUL_STRING },
> > >>>>>         [VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING
> > }, @@ -
> > >> 997,6
> > >>>>> +1119,7 @@ static const struct nla_policy
> > >> vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
> > >>>>>         [VDPA_ATTR_DEV_NET_CFG_MACADDR] =
> > NLA_POLICY_ETH_ADDR,
> > >>>>>         /* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
> > >>>>>         [VDPA_ATTR_DEV_NET_CFG_MTU] =
> > NLA_POLICY_MIN(NLA_U16, 68),
> > >>>>> +       [VDPA_ATTR_DEV_QUEUE_INDEX] = NLA_POLICY_RANGE(NLA_U32, 0,
> > >> 65535),
> > >>>>>     };
> > >>>>>     static const struct genl_ops vdpa_nl_ops[] = { @@ -1030,6
> > >>>>> +1153,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
> > >>>>>                 .doit = vdpa_nl_cmd_dev_config_get_doit,
> > >>>>>                 .dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
> > >>>>>         },
> > >>>>> +       {
> > >>>>> +               .cmd = VDPA_CMD_DEV_VSTATS_GET,
> > >>>>> +               .validate = GENL_DONT_VALIDATE_STRICT |
> > >> GENL_DONT_VALIDATE_DUMP,
> > >>>>> +               .doit = vdpa_nl_cmd_dev_stats_get_doit,
> > >>>>> +               .flags = GENL_ADMIN_PERM,
> > >>>>> +       },
> > >>>>>     };
> > >>>>>     static struct genl_family vdpa_nl_family __ro_after_init = {
> > >>>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h index
> > >>>>> 2de442ececae..274203845cfc 100644
> > >>>>> --- a/include/linux/vdpa.h
> > >>>>> +++ b/include/linux/vdpa.h
> > >>>>> @@ -275,6 +275,9 @@ struct vdpa_config_ops {
> > >>>>>                             const struct vdpa_vq_state *state);
> > >>>>>         int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
> > >>>>>                             struct vdpa_vq_state *state);
> > >>>>> +       int (*get_vendor_vq_stats)(struct vdpa_device *vdev, u16
> idx,
> > >>>>> +                                  struct sk_buff *msg,
> > >>>>> +                                  struct netlink_ext_ack *extack);
> > >>>>>         struct vdpa_notification_area
> > >>>>>         (*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
> > >>>>>         /* vq irq is not expected to be changed once DRIVER_OK is
> set
> > >>>>> */ @@ -466,4 +469,6 @@ struct vdpa_mgmt_dev {
> > >>>>>     int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
> > >>>>>     void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
> > >>>>> +#define VDPA_INVAL_QUEUE_INDEX 0xffff
> > >>>>> +
> > >>>>>     #endif /* _LINUX_VDPA_H */
> > >>>>> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > >>>>> index 1061d8d2d09d..c5f229a41dc2 100644
> > >>>>> --- a/include/uapi/linux/vdpa.h
> > >>>>> +++ b/include/uapi/linux/vdpa.h
> > >>>>> @@ -18,6 +18,7 @@ enum vdpa_command {
> > >>>>>         VDPA_CMD_DEV_DEL,
> > >>>>>         VDPA_CMD_DEV_GET,               /* can dump */
> > >>>>>         VDPA_CMD_DEV_CONFIG_GET,        /* can dump */
> > >>>>> +       VDPA_CMD_DEV_VSTATS_GET,
> > >>>>>     };
> > >>>>>     enum vdpa_attr {
> > >>>>> @@ -46,6 +47,12 @@ enum vdpa_attr {
> > >>>>>         VDPA_ATTR_DEV_NEGOTIATED_FEATURES,      /* u64 */
> > >>>>>         VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,          /*
> > u32 */
> > >>>>>         VDPA_ATTR_DEV_SUPPORTED_FEATURES,       /* u64 */
> > >>>>> +
> > >>>>> +       VDPA_ATTR_DEV_QUEUE_INDEX,              /* u16 */
> > >>>>> +       VDPA_ATTR_DEV_QUEUE_TYPE,               /* string */
> > >>>>> +       VDPA_ATTR_DEV_VENDOR_ATTR_NAME,         /* string */
> > >>>>> +       VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
> > >>>>> +
> > >>>>>         /* new attributes must be added above here */
> > >>>>>         VDPA_ATTR_MAX,
> > >>>>>     };
>
>

--000000000000f3d4c505d9c00299
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 8, 2022 at 10:13 PM Eli C=
ohen &lt;<a href=3D"mailto:elic@nvidia.com">elic@nvidia.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Si-Wei Liu &lt;<a href=3D"mailto:si-wei.liu@oracle.com" target=
=3D"_blank">si-wei.liu@oracle.com</a>&gt;<br>
&gt; Sent: Tuesday, March 8, 2022 8:16 AM<br>
&gt; To: Eli Cohen &lt;<a href=3D"mailto:elic@nvidia.com" target=3D"_blank"=
>elic@nvidia.com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com=
</a>; <a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowang@red=
hat.com</a>; virtualization@lists.linux-<br>
&gt; <a href=3D"http://foundation.org" rel=3D"noreferrer" target=3D"_blank"=
>foundation.org</a>; <a href=3D"mailto:eperezma@redhat.com" target=3D"_blan=
k">eperezma@redhat.com</a>; <a href=3D"mailto:amorenoz@redhat.com" target=
=3D"_blank">amorenoz@redhat.com</a>;<br>
&gt; <a href=3D"mailto:lvivier@redhat.com" target=3D"_blank">lvivier@redhat=
.com</a>; <a href=3D"mailto:sgarzare@redhat.com" target=3D"_blank">sgarzare=
@redhat.com</a>; Parav Pandit &lt;<a href=3D"mailto:parav@nvidia.com" targe=
t=3D"_blank">parav@nvidia.com</a>&gt;<br>
&gt; Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying vendor stat=
istics<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; On 3/6/2022 11:57 PM, Eli Cohen wrote:<br>
&gt; &gt;<br>
&gt; &gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt; From: Si-Wei Liu &lt;<a href=3D"mailto:si-wei.liu@oracle.com"=
 target=3D"_blank">si-wei.liu@oracle.com</a>&gt;<br>
&gt; &gt;&gt; Sent: Saturday, March 5, 2022 12:34 AM<br>
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
>sgarzare@redhat.com</a>; Parav Pandit<br>
&gt; &gt;&gt; &lt;<a href=3D"mailto:parav@nvidia.com" target=3D"_blank">par=
av@nvidia.com</a>&gt;<br>
&gt; &gt;&gt; Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying ve=
ndor<br>
&gt; &gt;&gt; statistics<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Sorry, I somehow missed this after my break. Please see comme=
nts in line.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 2/16/2022 10:46 PM, Eli Cohen wrote:<br>
&gt; &gt;&gt;&gt; On Wed, Feb 16, 2022 at 10:49:26AM -0800, Si-Wei Liu wrot=
e:<br>
&gt; &gt;&gt;&gt;&gt; On 2/16/2022 12:00 AM, Eli Cohen wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt; Allows to read vendor statistics of a vdpa device=
. The specific<br>
&gt; &gt;&gt;&gt;&gt;&gt; statistics data is received by the upstream drive=
r in the form of<br>
&gt; &gt;&gt;&gt;&gt;&gt; an (attribute name, attribute value) pairs.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; An example of statistics for mlx5_vdpa device are=
:<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; received_desc - number of descriptors received by=
 the virtqueue<br>
&gt; &gt;&gt;&gt;&gt;&gt; completed_desc - number of descriptors completed =
by the virtqueue<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; A descriptor using indirect buffers is still coun=
ted as 1. In<br>
&gt; &gt;&gt;&gt;&gt;&gt; addition, N chained descriptors are counted corre=
ctly N times as<br>
&gt; &gt;&gt;&gt;&gt;&gt; one<br>
&gt; &gt;&gt; would expect.<br>
&gt; &gt;&gt;&gt;&gt;&gt; A new callback was added to vdpa_config_ops which=
 provides the<br>
&gt; &gt;&gt;&gt;&gt;&gt; means for the vdpa driver to return statistics re=
sults.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; The interface allows for reading all the supporte=
d virtqueues,<br>
&gt; &gt;&gt;&gt;&gt;&gt; including the control virtqueue if it exists.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Below are some examples taken from mlx5_vdpa whic=
h are introduced<br>
&gt; &gt;&gt;&gt;&gt;&gt; in the following patch:<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; 1. Read statistics for the virtqueue at index 1<b=
r>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; $ vdpa dev vstats show vdpa-a qidx 1<br>
&gt; &gt;&gt;&gt;&gt;&gt; vdpa-a:<br>
&gt; &gt;&gt;&gt;&gt;&gt; queue_type tx queue_index 1 received_desc 3844836=
 completed_desc<br>
&gt; &gt;&gt;&gt;&gt;&gt; 3844836<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; 2. Read statistics for the virtqueue at index 32 =
$ vdpa dev vstats<br>
&gt; &gt;&gt;&gt;&gt;&gt; show vdpa-a qidx 32<br>
&gt; &gt;&gt;&gt;&gt;&gt; vdpa-a:<br>
&gt; &gt;&gt;&gt;&gt;&gt; queue_type control_vq queue_index 32 received_des=
c 62<br>
&gt; &gt;&gt;&gt;&gt;&gt; completed_desc<br>
&gt; &gt;&gt;&gt;&gt;&gt; 62<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; 3. Read statisitics for the virtqueue at index 0 =
with json output<br>
&gt; &gt;&gt;&gt;&gt;&gt; $ vdpa -j dev vstats show vdpa-a qidx 0 {&quot;vs=
tats&quot;:{&quot;vdpa-a&quot;:{<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt; &quot;queue_type&quot;:&quot;rx&quot;,&quot;queue_index&quot;=
:0,&quot;name&quot;:&quot;received_desc&quot;,&quot;value&quot;:4177<br>
&gt; &gt;&gt; 76,\<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;name&quot;:&quot;complet=
ed_desc&quot;,&quot;value&quot;:417548}}}<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; 4. Read statistics for the virtqueue at index 0 w=
ith preety json<br>
&gt; &gt;&gt;&gt;&gt;&gt; output $ vdpa -jp dev vstats show vdpa-a qidx 0 {=
<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vstats&quot;: {<=
br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vd=
pa-a&quot;: {<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;queue_type&quot;: &quot;rx&quot;,<br>
&gt; &gt;&gt;&gt;&gt; I wonder where this info can be inferred? I don&#39;t=
 see relevant<br>
&gt; &gt;&gt;&gt;&gt; change in the patch series that helps gather the<br>
&gt; VDPA_ATTR_DEV_QUEUE_TYPE?<br>
&gt; &gt;&gt;&gt;&gt; Is this an arbitrary string defined by the vendor as =
well? If so,<br>
&gt; &gt;&gt;&gt;&gt; how does the user expect to consume it?<br>
&gt; &gt;&gt;&gt; The queue tupe is deduced from the index and whether we h=
ave a<br>
&gt; &gt;&gt;&gt; virtqueue. Even numbers are rx, odd numbers are tx and if=
 there is<br>
&gt; &gt;&gt;&gt; CVQ, the last one is CVQ.<br>
&gt; &gt;&gt; OK, then VDPA_ATTR_DEV_QUEUE_TYPE attribute introduced in thi=
s patch<br>
&gt; &gt;&gt; might not be useful at all?<br>
&gt; &gt; Right, will remove.<br>
&gt; &gt;<br>
&gt; &gt;&gt; And how do you determine in the vdpa tool if CVQ is negotiate=
d or<br>
&gt; &gt;&gt; not?<br>
&gt; &gt; I make a netlink call to get the same information as &quot; vdpa =
dev config show&quot;<br>
&gt; retrieves. I use the negotiated features to determine if a CVQ is avai=
lable. If it<br>
&gt; is, the number of VQs equals the control VQ index. So there are two ne=
tlink<br>
&gt; calls under the hood.<br>
&gt; The lock vdpa_dev_mutex won&#39;t hold across the two separate netlink=
 calls, and<br>
&gt; it may end up with inconsistent state - theoretically things could hap=
pen like<br>
&gt; that the first call gets CVQ negotiated, but the later call for<br>
&gt; get_vendor_vq_stats() on the cvq might get -EINVAL due to device reset=
. Can<br>
&gt; the negotiated status and stat query be done within one single netlink=
 call?<br>
<br>
I see your concern.<br>
The only reason I do the extra call is to know if we have a control VQ and =
what<br>
index it is, just to print a descriptive string telling if it&#39;s a eithe=
r rx, tx or control VQ.<br>
<br>
So the cure can be simple. Let&#39;s have a new attribute that returns the =
type of<br>
virtqueue. I think Jason did not like the idea of communicating the kind of=
 VQ<br>
from kernel to userspace but under these circumstances, maybe he would appr=
ove.<br>
Jason?<br></blockquote><div><br></div><div><br></div><div>I may miss someth=
ing but I still don&#39;t get the reason for this. I think the atom could b=
e done by using a single netlink call. Then the userspace could deduce the =
queue type based on the negotiated features.</div><div><br></div><div>For r=
eturning the type, it means the vdpa core has the device specific knowledge=
 which still seems sub-optimal.</div><div><br></div><div>Thanks</div><div><=
br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
&gt; <br>
&gt; What worried me is that the queue index being dynamic and depended on<=
br>
&gt; negotiation status would make host admin user quite hard to follow. Th=
e guest<br>
&gt; may or may not advertise F_MQ and/or F_CTRL_VQ across various phases, =
e.g.<br>
&gt; firmware (UEFI), boot loader (grub) till OS driver is up and running, =
which can<br>
&gt; be agnostic to host admin. For most of the part it&#39;s not easy to s=
cript and<br>
&gt; predict the queue index which can change from time to time. Can we def=
ine<br>
&gt; the order of host predictable queue index, which is independent from a=
ny<br>
&gt; guest negotiated state?<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;&gt; Looks to me there are still some loose end I don&#39;t quite =
yet<br>
&gt; &gt;&gt; understand.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;queue_index&quot;: 0,<br>
&gt; &gt; I think this can be removed since the command is for a specific i=
ndex.<br>
&gt; &gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;name&quot;: &quot;received_desc&quot;,<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;value&quot;: 417776,<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;name&quot;: &quot;completed_desc&quot;,<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;value&quot;: 417548<br>
&gt; &gt;&gt;&gt;&gt; Not for this kernel patch, but IMHO it&#39;s the best=
 to put the name &amp;<br>
&gt; &gt;&gt;&gt;&gt; value pairs in an array instead of flat entries in js=
on&#39;s<br>
&gt; &gt;&gt;&gt;&gt; hash/dictionary. The hash entries can be re-ordered d=
eliberately by<br>
&gt; &gt;&gt;&gt;&gt; external json parsing tool, ending up with inconsiste=
nt stat values.<br>
&gt; &gt;&gt; This comment is missed for some reason. Please change the exa=
mple in<br>
&gt; &gt;&gt; the log if you agree to address it in vdpa tool. Or justify w=
hy<br>
&gt; &gt;&gt; keeping the order for json hash/dictionary is fine.<br>
&gt; &gt; Sorry for skipping this comment.<br>
&gt; &gt; Do you mean to present the information like:<br>
&gt; &gt; &quot;received_desc&quot;: 417776,<br>
&gt; &gt; &quot;completed_desc&quot;: 417548,<br>
&gt; I mean the following presentation:<br>
&gt; <br>
&gt; $ vdpa -jp dev vstats show vdpa-a qidx 0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;vstats&quot;: {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vdpa-a&quot;: {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;queue_stats&quot=
;: [{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;qu=
eue_index&quot;: 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;qu=
eue_type&quot;: &quot;rx&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;st=
at_name&quot;: [ &quot;received_desc&quot;,&quot;completed_desc&quot; ],<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;st=
at_value&quot;: [ 417776,417548 ],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; }<br>
&gt; <br>
&gt; I think Parav had similar suggestion, too.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; -Siwei<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt; -Siwei<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Thanks,<br>
&gt; &gt;&gt;&gt;&gt; -Siwei<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;&gt;&gt;&gt; }<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Signed-off-by: Eli Cohen &lt;<a href=3D"mailto:el=
ic@nvidia.com" target=3D"_blank">elic@nvidia.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0drivers/vdpa/vdpa.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 129<br>
&gt; &gt;&gt; ++++++++++++++++++++++++++++++++++++++<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0include/linux/vdpa.h=C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A05 ++<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0include/uapi/linux/vdpa.h |=C2=
=A0 =C2=A07 +++<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A03 files changed, 141 insertion=
s(+)<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/v=
dpa.c index<br>
&gt; &gt;&gt;&gt;&gt;&gt; 9846c9de4bfa..d0ff671baf88 100644<br>
&gt; &gt;&gt;&gt;&gt;&gt; --- a/drivers/vdpa/vdpa.c<br>
&gt; &gt;&gt;&gt;&gt;&gt; +++ b/drivers/vdpa/vdpa.c<br>
&gt; &gt;&gt;&gt;&gt;&gt; @@ -909,6 +909,74 @@ vdpa_dev_config_fill(struct =
vdpa_device<br>
&gt; &gt;&gt;&gt;&gt;&gt; *vdev,<br>
&gt; &gt;&gt; struct sk_buff *msg, u32 portid,<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt;&gt;&gt;&gt; +static int vdpa_fill_stats_rec(struct vdpa_devic=
e *vdev, struct<br>
&gt; &gt;&gt;&gt;&gt;&gt; +sk_buff<br>
&gt; &gt;&gt; *msg,<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct genl_info *=
info, u32 index) {<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (nla_put_u32(msg, =
VDPA_ATTR_DEV_QUEUE_INDEX, index))<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EMSGSIZE;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D vdev-&gt;conf=
ig-&gt;get_vendor_vq_stats(vdev, index, msg, info-<br>
&gt; &gt;&gt;&gt; extack);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err)<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return err;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +}<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +static int vendor_stats_fill(struct vdpa_device =
*vdev, struct sk_buff<br>
&gt; *msg,<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct genl_info *info, u=
32 index) {<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vdev-&gt;config-=
&gt;get_vendor_vq_stats)<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EOPNOTSUPP;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D vdpa_fill_sta=
ts_rec(vdev, msg, info, index);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err)<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return err;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +}<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +static int vdpa_dev_vendor_stats_fill(struct vdp=
a_device *vdev,<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct sk_buff *msg,<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct genl_info *info, u32 index) {<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 device_id;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0void *hdr;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 portid =3D info-&=
gt;snd_portid;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 seq =3D info-&gt;=
snd_seq;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 flags =3D 0;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0hdr =3D genlmsg_put(m=
sg, portid, seq, &amp;vdpa_nl_family, flags,<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VDPA_CMD_DEV_VSTATS_GET);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!hdr)<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EMSGSIZE;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (nla_put_string(ms=
g, VDPA_ATTR_DEV_NAME, dev_name(&amp;vdev-<br>
&gt; &gt;&gt;&gt; dev))) {<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0err =3D -EMSGSIZE;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto undo_msg;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0device_id =3D vdev-&g=
t;config-&gt;get_device_id(vdev);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (nla_put_u32(msg, =
VDPA_ATTR_DEV_ID, device_id)) {<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0err =3D -EMSGSIZE;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto undo_msg;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D vendor_stats_=
fill(vdev, msg, info, index);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0genlmsg_end(msg, hdr)=
;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +undo_msg:<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0genlmsg_cancel(msg, h=
dr);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +}<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0static int vdpa_nl_cmd_dev_con=
fig_get_doit(struct sk_buff<br>
&gt; &gt;&gt;&gt;&gt;&gt; *skb, struct<br>
&gt; &gt;&gt; genl_info *info)<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0{<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vdpa_devi=
ce *vdev;<br>
&gt; &gt;&gt;&gt;&gt;&gt; @@ -990,6 +1058,60 @@ vdpa_nl_cmd_dev_config_get_=
dumpit(struct<br>
&gt; &gt;&gt; sk_buff *msg, struct netlink_callback *<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return msg-&gt;l=
en;<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt;&gt;&gt;&gt; +static int vdpa_nl_cmd_dev_stats_get_doit(struct=
 sk_buff *skb,<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0struct genl_info *info)<br>
&gt; &gt;&gt;&gt;&gt;&gt; +{<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vdpa_device *v=
dev;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sk_buff *msg;<=
br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *devname;<=
br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev;<b=
r>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 index;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!info-&gt;attrs[V=
DPA_ATTR_DEV_NAME])<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!info-&gt;attrs[V=
DPA_ATTR_DEV_QUEUE_INDEX])<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0devname =3D nla_data(=
info-&gt;attrs[VDPA_ATTR_DEV_NAME]);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0msg =3D nlmsg_new(NLM=
SG_DEFAULT_SIZE, GFP_KERNEL);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!msg)<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -ENOMEM;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D nla_get_u32=
(info-&gt;attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;vdpa_=
dev_mutex);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0dev =3D bus_find_devi=
ce(&amp;vdpa_bus, NULL, devname,<br>
&gt; &gt;&gt; vdpa_name_match);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!dev) {<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0NL_SET_ERR_MSG_MOD(info-&gt;extack, &quot;device not found&quot;);<b=
r>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0err =3D -ENODEV;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto dev_err;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0vdev =3D container_of=
(dev, struct vdpa_device, dev);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vdev-&gt;mdev) {=
<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0NL_SET_ERR_MSG_MOD(info-&gt;extack, &quot;unmanaged vdpa<br>
&gt; &gt;&gt; device&quot;);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0err =3D -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto mdev_err;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D vdpa_dev_vend=
or_stats_fill(vdev, msg, info, index);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!err)<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0err =3D genlmsg_reply(msg, info);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0put_device(dev);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;vdp=
a_dev_mutex);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err)<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0nlmsg_free(msg);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +mdev_err:<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0put_device(dev);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +dev_err:<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;vdp=
a_dev_mutex);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +}<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0static const struct nla_policy=
 vdpa_nl_policy[VDPA_ATTR_MAX + 1] =3D {<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[VDPA_ATTR_MGMTD=
EV_BUS_NAME] =3D { .type =3D<br>
&gt; NLA_NUL_STRING },<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[VDPA_ATTR_MGMTD=
EV_DEV_NAME] =3D { .type =3D NLA_STRING<br>
&gt; }, @@ -<br>
&gt; &gt;&gt; 997,6<br>
&gt; &gt;&gt;&gt;&gt;&gt; +1119,7 @@ static const struct nla_policy<br>
&gt; &gt;&gt; vdpa_nl_policy[VDPA_ATTR_MAX + 1] =3D {<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[VDPA_ATTR_DEV_N=
ET_CFG_MACADDR] =3D<br>
&gt; NLA_POLICY_ETH_ADDR,<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* virtio spec 1=
.1 section 5.1.4.1 for valid MTU range */<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[VDPA_ATTR_DEV_N=
ET_CFG_MTU] =3D<br>
&gt; NLA_POLICY_MIN(NLA_U16, 68),<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0[VDPA_ATTR_DEV_QUEUE_=
INDEX] =3D NLA_POLICY_RANGE(NLA_U32, 0,<br>
&gt; &gt;&gt; 65535),<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0};<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0static const struct genl_ops v=
dpa_nl_ops[] =3D { @@ -1030,6<br>
&gt; &gt;&gt;&gt;&gt;&gt; +1153,12 @@ static const struct genl_ops vdpa_nl_=
ops[] =3D {<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.doit =3D vdpa_nl_cmd_dev_config_get_doit,<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.dumpit =3D vdpa_nl_cmd_dev_config_get_dumpit,<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0.cmd =3D VDPA_CMD_DEV_VSTATS_GET,<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0.validate =3D GENL_DONT_VALIDATE_STRICT |<br>
&gt; &gt;&gt; GENL_DONT_VALIDATE_DUMP,<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0.doit =3D vdpa_nl_cmd_dev_stats_get_doit,<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0.flags =3D GENL_ADMIN_PERM,<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0};<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0static struct genl_family vdpa=
_nl_family __ro_after_init =3D {<br>
&gt; &gt;&gt;&gt;&gt;&gt; diff --git a/include/linux/vdpa.h b/include/linux=
/vdpa.h index<br>
&gt; &gt;&gt;&gt;&gt;&gt; 2de442ececae..274203845cfc 100644<br>
&gt; &gt;&gt;&gt;&gt;&gt; --- a/include/linux/vdpa.h<br>
&gt; &gt;&gt;&gt;&gt;&gt; +++ b/include/linux/vdpa.h<br>
&gt; &gt;&gt;&gt;&gt;&gt; @@ -275,6 +275,9 @@ struct vdpa_config_ops {<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct vdpa_vq=
_state *state);<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int (*get_vq_sta=
te)(struct vdpa_device *vdev, u16 idx,<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vdpa_vq_state=
 *state);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*get_vendor_vq_s=
tats)(struct vdpa_device *vdev, u16 idx,<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stru=
ct sk_buff *msg,<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stru=
ct netlink_ext_ack *extack);<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vdpa_noti=
fication_area<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*get_vq_notific=
ation)(struct vdpa_device *vdev, u16 idx);<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* vq irq is not=
 expected to be changed once DRIVER_OK is set<br>
&gt; &gt;&gt;&gt;&gt;&gt; */ @@ -466,4 +469,6 @@ struct vdpa_mgmt_dev {<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0int vdpa_mgmtdev_register(stru=
ct vdpa_mgmt_dev *mdev);<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0void vdpa_mgmtdev_unregister(s=
truct vdpa_mgmt_dev *mdev);<br>
&gt; &gt;&gt;&gt;&gt;&gt; +#define VDPA_INVAL_QUEUE_INDEX 0xffff<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0#endif /* _LINUX_VDPA_H */<br>
&gt; &gt;&gt;&gt;&gt;&gt; diff --git a/include/uapi/linux/vdpa.h b/include/=
uapi/linux/vdpa.h<br>
&gt; &gt;&gt;&gt;&gt;&gt; index 1061d8d2d09d..c5f229a41dc2 100644<br>
&gt; &gt;&gt;&gt;&gt;&gt; --- a/include/uapi/linux/vdpa.h<br>
&gt; &gt;&gt;&gt;&gt;&gt; +++ b/include/uapi/linux/vdpa.h<br>
&gt; &gt;&gt;&gt;&gt;&gt; @@ -18,6 +18,7 @@ enum vdpa_command {<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VDPA_CMD_DEV_DEL=
,<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VDPA_CMD_DEV_GET=
,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* can dump */<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VDPA_CMD_DEV_CON=
FIG_GET,=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* can dump */<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0VDPA_CMD_DEV_VSTATS_G=
ET,<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0};<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0enum vdpa_attr {<br>
&gt; &gt;&gt;&gt;&gt;&gt; @@ -46,6 +47,12 @@ enum vdpa_attr {<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VDPA_ATTR_DEV_NE=
GOTIATED_FEATURES,=C2=A0 =C2=A0 =C2=A0 /* u64 */<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VDPA_ATTR_DEV_MG=
MTDEV_MAX_VQS,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; u32 */<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VDPA_ATTR_DEV_SU=
PPORTED_FEATURES,=C2=A0 =C2=A0 =C2=A0 =C2=A0/* u64 */<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0VDPA_ATTR_DEV_QUEUE_I=
NDEX,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* u16 */<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0VDPA_ATTR_DEV_QUEUE_T=
YPE,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* string */<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0VDPA_ATTR_DEV_VENDOR_=
ATTR_NAME,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* string */<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0VDPA_ATTR_DEV_VENDOR_=
ATTR_VALUE,=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* u64 */<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* new attribute=
s must be added above here */<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VDPA_ATTR_MAX,<b=
r>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0};<br>
<br>
</blockquote></div></div>

--000000000000f3d4c505d9c00299--


--===============7734428198435906213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7734428198435906213==--

