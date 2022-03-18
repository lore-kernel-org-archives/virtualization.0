Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F264CC433F5
	for <virtualization@archiver.kernel.org>; Fri, 18 Mar 2022 02:27:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB8E38478D;
	Fri, 18 Mar 2022 02:27:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C3T19m-6kiSM; Fri, 18 Mar 2022 02:27:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 762428478E;
	Fri, 18 Mar 2022 02:27:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37A19C0033;
	Fri, 18 Mar 2022 02:27:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD4D0C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 02:27:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A338A403A4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 02:27:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qfmzk8Dkv_mm
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 02:27:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 92AC240275
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 02:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647570468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+KD8zQwWCGzTjd0VM7SEGkor6mqPM+Ke15tGzUnvo5E=;
 b=N8HuVOhRammx7fU1dzkC/xJ1IdQPH8/3usD5iTdFlJQk8xHEM2c+vaAYumQPwG2UR9Z9G7
 MKCjWRqEWVd+ajeE2LYDtjG5N9OrCPWnHXdU6gM4qD+coeuWnYV+UYcHBw0c8c/KHB5djI
 nUvkbmuFr7hyuoJVRyiMhOnKNSLkKNM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-ArMKCC2ROdOXmJRcdAlT0w-1; Thu, 17 Mar 2022 22:27:46 -0400
X-MC-Unique: ArMKCC2ROdOXmJRcdAlT0w-1
Received: by mail-lj1-f199.google.com with SMTP id
 u22-20020a2eb816000000b00247e3bb7d2eso2838283ljo.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 19:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+KD8zQwWCGzTjd0VM7SEGkor6mqPM+Ke15tGzUnvo5E=;
 b=i37Co+0FliKo3mzLRlO0II8pWyyuw0eOwQTBipMPVa0aVCG1v9JnAutgP/VHdidU52
 LgvPtMaxAgX+sUhJTU+5Fi8RfLrESSqXKqgKuxa8mzC7y4/pPUcMzxq5gkAMOF7UEC1b
 md1k26e+7lKPRp46WatnS4QHrG88SDSGjknglAFr6W6x/7fJDGMhajr4hddayI9qrhFX
 QciokjOBdnSLOB5jLDEdULCV7v2Nu77xaVzo58eL8bgQa+29VSmuKQmcy20SY33MzfD3
 MJK0hnPvUXAzawGV5hyD9I5KOhDd9RlsbwxT8LnIQ/FsqbvZwooXkh/ADNWDalK9nmEC
 KzqQ==
X-Gm-Message-State: AOAM532ZmQynhXdJsIr1izXd+KiWfvgtRpntRtcHHH5nxh19Mu4epTCF
 fAWJl0PxyQGV+aEWDC4he5qNY/XDZI5rWm37p78bs4ISc9csGQecScHrRXxTvONhw2DP/+KJ46A
 swUi4Smr+sPQ3cf/MkWRpv5R6xpSdF4ut/667geJnfd3lwvFSb5Qsccu1QQ==
X-Received: by 2002:a2e:a490:0:b0:248:8f0:e4ee with SMTP id
 h16-20020a2ea490000000b0024808f0e4eemr4678665lji.97.1647570464936; 
 Thu, 17 Mar 2022 19:27:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKfSnRBFxl98gUUjOrsJOfbfwSMOZH5gVPMbIjuo8SdYjq1iUm5yDKKl9juVBfBVlRz8n7zw8ArgfrO4Mou10=
X-Received: by 2002:a2e:a490:0:b0:248:8f0:e4ee with SMTP id
 h16-20020a2ea490000000b0024808f0e4eemr4678654lji.97.1647570464681; Thu, 17
 Mar 2022 19:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220216080022.56707-1-elic@nvidia.com>
 <8e834c04-47d2-1286-117d-28caa3e84606@oracle.com>
 <DM8PR12MB5400E80073521E898056578BAB089@DM8PR12MB5400.namprd12.prod.outlook.com>
 <6175d620-6be3-c249-5482-0a9448499e4a@oracle.com>
 <DM8PR12MB5400E03D7AD7833CEBF8DF9DAB099@DM8PR12MB5400.namprd12.prod.outlook.com>
 <74495f15-8f1c-93db-1277-50198ac3284e@oracle.com>
 <DM8PR12MB540086CCD1F535668D05E546AB0A9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <a30ac3c0-059d-4588-c5ac-599c060f6bbf@oracle.com>
 <DM8PR12MB54000042A48FDFA446EFE792AB0E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <61748d91-153c-ec79-c1f0-e3c44cdbea5d@oracle.com>
 <DM8PR12MB540054565515158F9209723EAB109@DM8PR12MB5400.namprd12.prod.outlook.com>
 <53dd5c21-5045-bb66-05fe-1a1157f7abe8@oracle.com>
 <DM8PR12MB5400E7B2359FE4797F190AC5AB119@DM8PR12MB5400.namprd12.prod.outlook.com>
 <7fa43ec9-202e-0cbc-22fb-0770ed023c35@oracle.com>
 <CACGkMEuvbWWiCrmuCKG7Z9OWUaFU5GT+U_yEBVg=QcWDrwOSzA@mail.gmail.com>
 <f9cd0cf9-dbbc-78e1-c6f1-50597b796545@oracle.com>
In-Reply-To: <f9cd0cf9-dbbc-78e1-c6f1-50597b796545@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Mar 2022 10:27:33 +0800
Message-ID: <CACGkMEtbY07y=_CPpeoSYyd7oPEbB2OwKssQfw9=_Ly4igsEEw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying vendor statistics
To: Si-Wei Liu <si-wei.liu@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>
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

On Fri, Mar 18, 2022 at 8:59 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 3/16/2022 7:32 PM, Jason Wang wrote:
> > On Thu, Mar 17, 2022 at 6:00 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> >>
> >>
> >> On 3/16/2022 12:10 AM, Eli Cohen wrote:
> >>>> From: Si-Wei Liu <si-wei.liu@oracle.com>
> >>>> Sent: Wednesday, March 16, 2022 8:52 AM
> >>>> To: Eli Cohen <elic@nvidia.com>
> >>>> Cc: mst@redhat.com; jasowang@redhat.com; virtualization@lists.linux-foundation.org; eperezma@redhat.com; amorenoz@redhat.com;
> >>>> lvivier@redhat.com; sgarzare@redhat.com; Parav Pandit <parav@nvidia.com>
> >>>> Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying vendor statistics
> >>>>
> >>>>
> >>>>
> >>>> On 3/15/2022 2:10 AM, Eli Cohen wrote:
> >>>>
> >>>> <...snip...>
> >>>>
> >>>>>> Say you got a vdpa net device created with 4 data queue pairs and a
> >>>>>> control vq. On boot some guest firmware may support just F_CTRL_VQ but
> >>>>>> not F_MQ, then the index for the control vq in guest ends up with 2, as
> >>>>>> in this case there's only a single queue pair enabled for rx (index 0)
> >>>>>> and tx (index 1). From the host driver (e.g. mlx5_vdpa) perspective, the
> >>>>>> control vq is the last vq following 8
> >>>>> If the host sees F_MQ was not negotiated but F_CTRL_VQ was, then it knows
> >>>>> that control VQ index is 2
> >>>> Right, but I don't see this feature negotiation info getting returned
> >>>> from your vdpa_dev_vendor_stats_fill(), or did I miss something? How do
> >>>> you plan for host user to get this info? If you meant another "vdpa dev
> >>>> show" command to query negotiated features ahead, this won't get the
> >>>> same lock protected as the time you run the stat query. It's very easy
> >>>> to miss that ephemeral queue index.
> >>> Right, so I suggested to include the negotiated features in the netlink message
> >>> for the statistics. That would save us from using two system calls to get the
> >>> information required and it answers your concern with respect to locking.
> >>> I think Jason was reluctant to adding this attribute to the message but can't
> >>> find where he explained the reasoning.
> >> Maybe Jason can clarify and correct me, but I just did not get the same
> >> impression as what you said? I just skimmed through all of the emails in
> >> the thread, only finding that he didn't want device specific attribute
> >> such as queue type to get returned by the vdpa core, which I agree. I'm
> >> not sure if he's explicitly against piggyback negotiated features to aid
> >> userspace parsing the index.
> > I think we need piggyback the negotiated features, otherwise as you
> > mentioned, we will probably get in-consistency.
> Great. Thanks for confirming it.
>
> >
> > But a question for the "host queue index", as mentioned before. It's
> > something that is not defined in the spec, so technically, vendor can
> > do any mappings between it and the index what guest can see. I feel
> > like we need to clarify it in the spec first.
> I have been thinking about this for some while today. Actually I am not
> against exposing the host queue index to the spec, as we know it's
> somewhat implicitly defined in the QEMU device model for multiqueue. The
> thing is, I'm not sure if there's extra benefit than this minor
> requirement (*) given that all of the other vDPA kAPI are taking the
> guest queue index rather than the host queue index.

Rethink of this, consider currently we do this via vendor stats, so
it's probably fine. Maybe we can have a better netlink API like
"vendor_queue_index" etc then everything should be fine.

> It works for
> mlx5_vdpa as the control vq is implemented in the software, so it can
> map to whatever guest qindex it wishes to. But would it cause extra
> trouble for some other emulated vDPA device or other vendor's vDPA such
> as ifcvf to fabricate a fake mapping between the host queue index and
> the one guest can see? I would have to send a heads-up ahead that the
> current vhost-vdpa mq implementation in upstream QEMU has some issue in
> mapping the host qindex to the guest one. This would become a problem
> with MQ enabled vdpa device and a non-MQ supporting guest e.g. OVMF, for
> which I'm about to share some RFC patches shortly to demonstrate the
> issue.

Sure.

> If exposing the host queue index to the spec turns is essential
> to resolving this issue and maybe help with software virtio QEMU
> implementation too, I won't hesitate to expose this important
> implementation detail to the spec.
>
> (*) another means that may somehow address my use case is to use some
> magic keyword e.g. "ctrlvq" to identify the control vq. Implementation
> wise, we can extensively pass -1 to indicate the last guest qindex to
> the get_vq_vstat() API given that we know for sure the ctrlvq is the
> last queue in the array when the relevant features are present. Since
> the negotiated features are piggybacked, it's not hard for the vdpa tool
> to tell apart whether the last queue is a control vq or not.

For virtqueue index (guest index) defined in the spec, I'd let
userspace to deduce it.

But for the host or vendor index, we probably can do this.

(Btw, I feel like we need to separate the features, if we agree to go
with host/vendor index, we can let guest index part in first).

Thanks

>
> I'd also welcome other ideas that can make virtqueue identification
> easier and predictable from the CLI.
>
> Thanks,
> -Siwei
>
> >
> > Thanks
> >
> >> Another way around, vdpa tool may pass down -1 to get_vq_vstat() to
> >> represent the queue index for the control queue - but that's less
> >> favorable as the vdpa core needs to maintain device specific knowledge.
> >>
> >>
> >>
> >>>>>> data vqs of all 4 pairs, hence got
> >>>>>> the 8th index in the rank. Since F_MQ is not negotiated and only 1 data
> >>>>>> queue pair enabled, in such event only host qindex 0,1 and 8 have vendor
> >>>>>> stats available, and the rest of qindex would get invalid/empty stat.
> >>>>>>
> >>>>>> Later on say boot continues towards loading the Linux virtio driver,
> >>>>>> then guest could successfully negotiate both F_CTRL_VQ and F_MQ
> >>>>>> features. In this case, all 8 data virtqueues are fully enabled, the
> >>>>>> index for the control vq ends up as 8, following tightly after all the 4
> >>>>>> data queue pairs. Only until both features are negotiated, the guest and
> >>>>>> host are able to see consistent view in identifying the control vq.
> >>>>>> Since F_MQ is negotiated, all host queues, indexed from 0 through 8,
> >>>>>> should have vendor stats available.
> >>>>>>
> >>>>>> That's why I said the guest qindex is ephemeral and hard to predict
> >>>>>> subjected to negotiated features, but host qindex is reliable and more
> >>>>>> eligible for command line identification purpose.
> >>>>>>
> >>>> <...snip...>
> >>>>>>> So what are you actually proposing? Display received and completed descriptors
> >>>>>>> per queue index without further interpretation?
> >>>>>> I'd suggest using a more stable queue id i.e. the host queue index to
> >>>>>> represent the qidx (which seems to be what you're doing now?), and
> >>>>>> displaying both the host qindex (queue_index_device in the example
> >>>>>> below), as well as the guest's (queue_index_driver as below) in the output:
> >>>>>>
> >>>>> Given that per vdpa device you can display statistics only after features have
> >>>>> been negotiated, you can always know the correct queue index for the control
> >>>>> VQ.
> >>>> The stats can be displayed only after features are negotiated, and only
> >>>> when the corresponding queue is enabled. If you know it from "vdpa dev
> >>>> show" on day 1 that the control vq and mq features are negotiated, but
> >>>> then on day2 you got nothing for the predicted control vq index, what
> >>>> would you recommend the host admin to do to get the right qindex again?
> >>>> Re-run the stat query on the same queue index, or check the "vdpa dev
> >>>> show" output again on day 3? This CLI design makes cloud administrator
> >>>> really challenging to follow the dynamics of guest activities were to
> >>>> manage hundreds or thousands of virtual machines...
> >>>>
> >>>> It would be easier, in my opinion, to grasp some well-defined handle
> >>>> that is easily predictable or fixed across the board, for looking up the
> >>>> control virtqueue. This could be a constant host queue index, or a
> >>>> special magic keyword like "qidx ctrlvq". If cloud admin runs vstat
> >>>> query on the control vq using a determined handle but get nothing back,
> >>>> then s/he knows *for sure* the control vq was not available for some
> >>>> reason at the point when the stat was being collected. S/he doesn't even
> >>>> need to care negotiated status via "vdpa dev show" at all. Why bother?
> >>> So, per my suggestion above, passing the negotiated attribute in the netlink
> >>> message would satisfy the requirements for atomicity, right?
> >> Yes, it satisfied the atomicity requirement, though not sure how you
> >> want to represent the queue index for control vq? Basically if cloud
> >> admin wants to dump control queue stats explicitly with a fixed handle
> >> or identifier, how that can be done with the negotiated attribute?
> >>
> >> Thanks,
> >> -Siwei
> >>>>> Do you still hold see your proposal required?
> >>>> Yes, this is essential to any cloud admin that runs stat query on all of
> >>>> the queues on periodic basis. You'd get some deterministic without
> >>>> blindly guessing or bothering other irrelevant command.
> >>>>
> >>>>
> >>>> Thanks,
> >>>> -Siwei
> >>>>>> $ vdpa -jp dev vstats show vdpa-a qidx 8
> >>>>>> {
> >>>>>>         "vstats": {
> >>>>>>             "vdpa-a": {
> >>>>>>                 "queue_stats": [{
> >>>>>>                     "queue_index_device": 8,
> >>>>>>                     "queue_index_driver": 2,
> >>>>>>                     "queue_type": "control_vq",
> >>>>>>                     "stat_name": [ "received_desc","completed_desc" ],
> >>>>>>                     "stat_value": [ 417776,417775 ],
> >>>>>>                 }]
> >>>>>>             }
> >>>>>>         }
> >>>>>> }
> >>>>>>
> >>>>>> Optionally, user may use guest queue index gqidx, which is kind of an
> >>>>>> ephemeral ID and F_MQ negotiation depended, to query the stat on a
> >>>>>> specific guest queue:
> >>>>>>
> >>>>>> $ vdpa -jp dev vstats show vdpa-a gqidx 2
> >>>>>> {
> >>>>>>         "vstats": {
> >>>>>>             "vdpa-a": {
> >>>>>>                 "queue_stats": [{
> >>>>>>                     "queue_index_device": 8,
> >>>>>>                     "queue_index_driver": 2,
> >>>>>>                     "queue_type": "control_vq",
> >>>>>>                     "stat_name": [ "received_desc","completed_desc" ],
> >>>>>>                     "stat_value": [ 417776,417775 ],
> >>>>>>                 }]
> >>>>>>             }
> >>>>>>         }
> >>>>>> }
> >>>>>>
> >>>>>> Thanks,
> >>>>>> -Siwei
> >>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> -Siwei
> >>>>>>>>
> >>>>>>>>>> Regards,
> >>>>>>>>>> -Siwei
> >>>>>>>>>>
> >>>>>>>>>>>>>> Looks to me there are still some loose end I don't quite yet
> >>>>>>>>>>>>>> understand.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>                      "queue_index": 0,
> >>>>>>>>>>>>> I think this can be removed since the command is for a specific index.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>                      "name": "received_desc",
> >>>>>>>>>>>>>>>>>                      "value": 417776,
> >>>>>>>>>>>>>>>>>                      "name": "completed_desc",
> >>>>>>>>>>>>>>>>>                      "value": 417548
> >>>>>>>>>>>>>>>> Not for this kernel patch, but IMHO it's the best to put the name
> >>>>>>>>>>>>>>>> & value pairs in an array instead of flat entries in json's
> >>>>>>>>>>>>>>>> hash/dictionary. The hash entries can be re-ordered deliberately
> >>>>>>>>>>>>>>>> by external json parsing tool, ending up with inconsistent stat values.
> >>>>>>>>>>>>>> This comment is missed for some reason. Please change the example
> >>>>>>>>>>>>>> in the log if you agree to address it in vdpa tool. Or justify why
> >>>>>>>>>>>>>> keeping the order for json hash/dictionary is fine.
> >>>>>>>>>>>>> Sorry for skipping this comment.
> >>>>>>>>>>>>> Do you mean to present the information like:
> >>>>>>>>>>>>> "received_desc": 417776,
> >>>>>>>>>>>>> "completed_desc": 417548,
> >>>>>>>>>>>> I mean the following presentation:
> >>>>>>>>>>>>
> >>>>>>>>>>>> $ vdpa -jp dev vstats show vdpa-a qidx 0 {
> >>>>>>>>>>>>            "vstats": {
> >>>>>>>>>>>>                "vdpa-a": {
> >>>>>>>>>>>>                    "queue_stats": [{
> >>>>>>>>>>>>                        "queue_index": 0,
> >>>>>>>>>>>>                        "queue_type": "rx",
> >>>>>>>>>>>>                        "stat_name": [ "received_desc","completed_desc" ],
> >>>>>>>>>>>>                        "stat_value": [ 417776,417548 ],
> >>>>>>>>>>>>                    }]
> >>>>>>>>>>>>                }
> >>>>>>>>>>>>            }
> >>>>>>>>>>>> }
> >>>>>>>>>>>>
> >>>>>>>>>>>> I think Parav had similar suggestion, too.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Thanks,
> >>>>>>>>>>>> -Siwei
> >>>>>>>>>>>>
> >>>>>>>>>>>>>> Thanks,
> >>>>>>>>>>>>>> -Siwei
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Thanks,
> >>>>>>>>>>>>>>>> -Siwei
> >>>>>>>>>>>>>>>>>                  }
> >>>>>>>>>>>>>>>>>              }
> >>>>>>>>>>>>>>>>> }
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
> >>>>>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>>>>>           drivers/vdpa/vdpa.c       | 129
> >>>>>>>>>>>>>> ++++++++++++++++++++++++++++++++++++++
> >>>>>>>>>>>>>>>>>           include/linux/vdpa.h      |   5 ++
> >>>>>>>>>>>>>>>>>           include/uapi/linux/vdpa.h |   7 +++
> >>>>>>>>>>>>>>>>>           3 files changed, 141 insertions(+)
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> >>>>>>>>>>>>>>>>> 9846c9de4bfa..d0ff671baf88 100644
> >>>>>>>>>>>>>>>>> --- a/drivers/vdpa/vdpa.c
> >>>>>>>>>>>>>>>>> +++ b/drivers/vdpa/vdpa.c
> >>>>>>>>>>>>>>>>> @@ -909,6 +909,74 @@ vdpa_dev_config_fill(struct vdpa_device
> >>>>>>>>>>>>>>>>> *vdev,
> >>>>>>>>>>>>>> struct sk_buff *msg, u32 portid,
> >>>>>>>>>>>>>>>>>                  return err;
> >>>>>>>>>>>>>>>>>           }
> >>>>>>>>>>>>>>>>> +static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct
> >>>>>>>>>>>>>>>>> +sk_buff
> >>>>>>>>>>>>>> *msg,
> >>>>>>>>>>>>>>>>> +                              struct genl_info *info, u32 index) {
> >>>>>>>>>>>>>>>>> +       int err;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
> >>>>>>>>>>>>>>>>> +               return -EMSGSIZE;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       err = vdev->config->get_vendor_vq_stats(vdev, index, msg,
> >>>>>>>>>>>>>>>>> +info-
> >>>>>>>>>>>>>>> extack);
> >>>>>>>>>>>>>>>>> +       if (err)
> >>>>>>>>>>>>>>>>> +               return err;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       return 0;
> >>>>>>>>>>>>>>>>> +}
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +static int vendor_stats_fill(struct vdpa_device *vdev, struct
> >>>>>>>>>>>>>>>>> +sk_buff
> >>>>>>>>>>>> *msg,
> >>>>>>>>>>>>>>>>> +                            struct genl_info *info, u32 index) {
> >>>>>>>>>>>>>>>>> +       int err;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       if (!vdev->config->get_vendor_vq_stats)
> >>>>>>>>>>>>>>>>> +               return -EOPNOTSUPP;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       err = vdpa_fill_stats_rec(vdev, msg, info, index);
> >>>>>>>>>>>>>>>>> +       if (err)
> >>>>>>>>>>>>>>>>> +               return err;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       return 0;
> >>>>>>>>>>>>>>>>> +}
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +static int vdpa_dev_vendor_stats_fill(struct vdpa_device *vdev,
> >>>>>>>>>>>>>>>>> +                                     struct sk_buff *msg,
> >>>>>>>>>>>>>>>>> +                                     struct genl_info *info, u32 index) {
> >>>>>>>>>>>>>>>>> +       u32 device_id;
> >>>>>>>>>>>>>>>>> +       void *hdr;
> >>>>>>>>>>>>>>>>> +       int err;
> >>>>>>>>>>>>>>>>> +       u32 portid = info->snd_portid;
> >>>>>>>>>>>>>>>>> +       u32 seq = info->snd_seq;
> >>>>>>>>>>>>>>>>> +       u32 flags = 0;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
> >>>>>>>>>>>>>>>>> +                         VDPA_CMD_DEV_VSTATS_GET);
> >>>>>>>>>>>>>>>>> +       if (!hdr)
> >>>>>>>>>>>>>>>>> +               return -EMSGSIZE;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       if (nla_put_string(msg, VDPA_ATTR_DEV_NAME,
> >>>>>>>>>> dev_name(&vdev-
> >>>>>>>>>>>>>>> dev))) {
> >>>>>>>>>>>>>>>>> +               err = -EMSGSIZE;
> >>>>>>>>>>>>>>>>> +               goto undo_msg;
> >>>>>>>>>>>>>>>>> +       }
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       device_id = vdev->config->get_device_id(vdev);
> >>>>>>>>>>>>>>>>> +       if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
> >>>>>>>>>>>>>>>>> +               err = -EMSGSIZE;
> >>>>>>>>>>>>>>>>> +               goto undo_msg;
> >>>>>>>>>>>>>>>>> +       }
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       err = vendor_stats_fill(vdev, msg, info, index);
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       genlmsg_end(msg, hdr);
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       return err;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +undo_msg:
> >>>>>>>>>>>>>>>>> +       genlmsg_cancel(msg, hdr);
> >>>>>>>>>>>>>>>>> +       return err;
> >>>>>>>>>>>>>>>>> +}
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>           static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff
> >>>>>>>>>>>>>>>>> *skb, struct
> >>>>>>>>>>>>>> genl_info *info)
> >>>>>>>>>>>>>>>>>           {
> >>>>>>>>>>>>>>>>>                  struct vdpa_device *vdev;
> >>>>>>>>>>>>>>>>> @@ -990,6 +1058,60 @@
> >>>>>>>>>> vdpa_nl_cmd_dev_config_get_dumpit(struct
> >>>>>>>>>>>>>> sk_buff *msg, struct netlink_callback *
> >>>>>>>>>>>>>>>>>                  return msg->len;
> >>>>>>>>>>>>>>>>>           }
> >>>>>>>>>>>>>>>>> +static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
> >>>>>>>>>>>>>>>>> +                                         struct genl_info *info)
> >>>>>>>>>>>>>>>>> +{
> >>>>>>>>>>>>>>>>> +       struct vdpa_device *vdev;
> >>>>>>>>>>>>>>>>> +       struct sk_buff *msg;
> >>>>>>>>>>>>>>>>> +       const char *devname;
> >>>>>>>>>>>>>>>>> +       struct device *dev;
> >>>>>>>>>>>>>>>>> +       u32 index;
> >>>>>>>>>>>>>>>>> +       int err;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       if (!info->attrs[VDPA_ATTR_DEV_NAME])
> >>>>>>>>>>>>>>>>> +               return -EINVAL;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       if (!info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
> >>>>>>>>>>>>>>>>> +               return -EINVAL;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> >>>>>>>>>>>>>>>>> +       msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> >>>>>>>>>>>>>>>>> +       if (!msg)
> >>>>>>>>>>>>>>>>> +               return -ENOMEM;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       index = nla_get_u32(info-
> >>>>>>>>>>> attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
> >>>>>>>>>>>>>>>>> +       mutex_lock(&vdpa_dev_mutex);
> >>>>>>>>>>>>>>>>> +       dev = bus_find_device(&vdpa_bus, NULL, devname,
> >>>>>>>>>>>>>> vdpa_name_match);
> >>>>>>>>>>>>>>>>> +       if (!dev) {
> >>>>>>>>>>>>>>>>> +               NL_SET_ERR_MSG_MOD(info->extack, "device not
> >>>>>>>>>> found");
> >>>>>>>>>>>>>>>>> +               err = -ENODEV;
> >>>>>>>>>>>>>>>>> +               goto dev_err;
> >>>>>>>>>>>>>>>>> +       }
> >>>>>>>>>>>>>>>>> +       vdev = container_of(dev, struct vdpa_device, dev);
> >>>>>>>>>>>>>>>>> +       if (!vdev->mdev) {
> >>>>>>>>>>>>>>>>> +               NL_SET_ERR_MSG_MOD(info->extack, "unmanaged
> >>>>>>>>>> vdpa
> >>>>>>>>>>>>>> device");
> >>>>>>>>>>>>>>>>> +               err = -EINVAL;
> >>>>>>>>>>>>>>>>> +               goto mdev_err;
> >>>>>>>>>>>>>>>>> +       }
> >>>>>>>>>>>>>>>>> +       err = vdpa_dev_vendor_stats_fill(vdev, msg, info, index);
> >>>>>>>>>>>>>>>>> +       if (!err)
> >>>>>>>>>>>>>>>>> +               err = genlmsg_reply(msg, info);
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       put_device(dev);
> >>>>>>>>>>>>>>>>> +       mutex_unlock(&vdpa_dev_mutex);
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       if (err)
> >>>>>>>>>>>>>>>>> +               nlmsg_free(msg);
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       return err;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +mdev_err:
> >>>>>>>>>>>>>>>>> +       put_device(dev);
> >>>>>>>>>>>>>>>>> +dev_err:
> >>>>>>>>>>>>>>>>> +       mutex_unlock(&vdpa_dev_mutex);
> >>>>>>>>>>>>>>>>> +       return err;
> >>>>>>>>>>>>>>>>> +}
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>           static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1]
> >>>>>>>>>> = {
> >>>>>>>>>>>>>>>>>                  [VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type =
> >>>>>>>>>>>> NLA_NUL_STRING },
> >>>>>>>>>>>>>>>>>                  [VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING
> >>>>>>>>>>>> }, @@ -
> >>>>>>>>>>>>>> 997,6
> >>>>>>>>>>>>>>>>> +1119,7 @@ static const struct nla_policy
> >>>>>>>>>>>>>> vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
> >>>>>>>>>>>>>>>>>                  [VDPA_ATTR_DEV_NET_CFG_MACADDR] =
> >>>>>>>>>>>> NLA_POLICY_ETH_ADDR,
> >>>>>>>>>>>>>>>>>                  /* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
> >>>>>>>>>>>>>>>>>                  [VDPA_ATTR_DEV_NET_CFG_MTU] =
> >>>>>>>>>>>> NLA_POLICY_MIN(NLA_U16, 68),
> >>>>>>>>>>>>>>>>> +       [VDPA_ATTR_DEV_QUEUE_INDEX] =
> >>>>>>>>>> NLA_POLICY_RANGE(NLA_U32, 0,
> >>>>>>>>>>>>>> 65535),
> >>>>>>>>>>>>>>>>>           };
> >>>>>>>>>>>>>>>>>           static const struct genl_ops vdpa_nl_ops[] = { @@ -1030,6
> >>>>>>>>>>>>>>>>> +1153,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
> >>>>>>>>>>>>>>>>>                          .doit = vdpa_nl_cmd_dev_config_get_doit,
> >>>>>>>>>>>>>>>>>                          .dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
> >>>>>>>>>>>>>>>>>                  },
> >>>>>>>>>>>>>>>>> +       {
> >>>>>>>>>>>>>>>>> +               .cmd = VDPA_CMD_DEV_VSTATS_GET,
> >>>>>>>>>>>>>>>>> +               .validate = GENL_DONT_VALIDATE_STRICT |
> >>>>>>>>>>>>>> GENL_DONT_VALIDATE_DUMP,
> >>>>>>>>>>>>>>>>> +               .doit = vdpa_nl_cmd_dev_stats_get_doit,
> >>>>>>>>>>>>>>>>> +               .flags = GENL_ADMIN_PERM,
> >>>>>>>>>>>>>>>>> +       },
> >>>>>>>>>>>>>>>>>           };
> >>>>>>>>>>>>>>>>>           static struct genl_family vdpa_nl_family __ro_after_init =
> >>>>>>>>>>>>>>>>> { diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h index
> >>>>>>>>>>>>>>>>> 2de442ececae..274203845cfc 100644
> >>>>>>>>>>>>>>>>> --- a/include/linux/vdpa.h
> >>>>>>>>>>>>>>>>> +++ b/include/linux/vdpa.h
> >>>>>>>>>>>>>>>>> @@ -275,6 +275,9 @@ struct vdpa_config_ops {
> >>>>>>>>>>>>>>>>>                                      const struct vdpa_vq_state *state);
> >>>>>>>>>>>>>>>>>                  int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
> >>>>>>>>>>>>>>>>>                                      struct vdpa_vq_state *state);
> >>>>>>>>>>>>>>>>> +       int (*get_vendor_vq_stats)(struct vdpa_device *vdev, u16 idx,
> >>>>>>>>>>>>>>>>> +                                  struct sk_buff *msg,
> >>>>>>>>>>>>>>>>> +                                  struct netlink_ext_ack *extack);
> >>>>>>>>>>>>>>>>>                  struct vdpa_notification_area
> >>>>>>>>>>>>>>>>>                  (*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
> >>>>>>>>>>>>>>>>>                  /* vq irq is not expected to be changed once DRIVER_OK is
> >>>>>>>>>>>>>>>>> set */ @@ -466,4 +469,6 @@ struct vdpa_mgmt_dev {
> >>>>>>>>>>>>>>>>>           int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
> >>>>>>>>>>>>>>>>>           void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
> >>>>>>>>>>>>>>>>> +#define VDPA_INVAL_QUEUE_INDEX 0xffff
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>           #endif /* _LINUX_VDPA_H */
> >>>>>>>>>>>>>>>>> diff --git a/include/uapi/linux/vdpa.h
> >>>>>>>>>>>>>>>>> b/include/uapi/linux/vdpa.h index 1061d8d2d09d..c5f229a41dc2
> >>>>>>>>>>>>>>>>> 100644
> >>>>>>>>>>>>>>>>> --- a/include/uapi/linux/vdpa.h
> >>>>>>>>>>>>>>>>> +++ b/include/uapi/linux/vdpa.h
> >>>>>>>>>>>>>>>>> @@ -18,6 +18,7 @@ enum vdpa_command {
> >>>>>>>>>>>>>>>>>                  VDPA_CMD_DEV_DEL,
> >>>>>>>>>>>>>>>>>                  VDPA_CMD_DEV_GET,               /* can dump */
> >>>>>>>>>>>>>>>>>                  VDPA_CMD_DEV_CONFIG_GET,        /* can dump */
> >>>>>>>>>>>>>>>>> +       VDPA_CMD_DEV_VSTATS_GET,
> >>>>>>>>>>>>>>>>>           };
> >>>>>>>>>>>>>>>>>           enum vdpa_attr {
> >>>>>>>>>>>>>>>>> @@ -46,6 +47,12 @@ enum vdpa_attr {
> >>>>>>>>>>>>>>>>>                  VDPA_ATTR_DEV_NEGOTIATED_FEATURES,      /* u64 */
> >>>>>>>>>>>>>>>>>                  VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,          /*
> >>>>>>>>>>>> u32 */
> >>>>>>>>>>>>>>>>>                  VDPA_ATTR_DEV_SUPPORTED_FEATURES,       /* u64 */
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       VDPA_ATTR_DEV_QUEUE_INDEX,              /* u16 */
> >>>>>>>>>>>>>>>>> +       VDPA_ATTR_DEV_QUEUE_TYPE,               /* string */
> >>>>>>>>>>>>>>>>> +       VDPA_ATTR_DEV_VENDOR_ATTR_NAME,         /*
> >>>>>>>>>> string */
> >>>>>>>>>>>>>>>>> +       VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>                  /* new attributes must be added above here */
> >>>>>>>>>>>>>>>>>                  VDPA_ATTR_MAX,
> >>>>>>>>>>>>>>>>>           };
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
