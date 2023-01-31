Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B9AC636CD
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 06:02:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02D1D813A6;
	Tue, 31 Jan 2023 06:02:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 02D1D813A6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=elQz3DNW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dtAIwigN9bka; Tue, 31 Jan 2023 06:02:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 37EB48139E;
	Tue, 31 Jan 2023 06:02:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 37EB48139E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CED6C0032;
	Tue, 31 Jan 2023 06:02:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23AFEC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 06:02:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EEA75400DD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 06:02:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EEA75400DD
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=elQz3DNW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8MC22L9et3AT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 06:02:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 09C0B400AF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 09C0B400AF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 06:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675144938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=07p/FU4ia1Gn8IO/MPImXzlVXh4Wg3uECI22mx+7UFs=;
 b=elQz3DNWusskIIaCBFKmu2RI01wG5Vybj2V16qm6fJdv+ab3438lSTMacHeG3VRiduXya9
 /EE5YlZ4JpMJx10dH0rIjZImWo+46ubxLw0giWe6lwy/mH9TdBvkgyEx/oEBsrZ3/zfs2b
 kEzhy9IcRjjeqg6nCZykEHCmjy04fk0=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-466-ExZErqcNNzmWECP6Vzfc7Q-1; Tue, 31 Jan 2023 01:02:16 -0500
X-MC-Unique: ExZErqcNNzmWECP6Vzfc7Q-1
Received: by mail-ot1-f71.google.com with SMTP id
 bx22-20020a056830601600b00684958cb0b9so6640082otb.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 22:02:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=07p/FU4ia1Gn8IO/MPImXzlVXh4Wg3uECI22mx+7UFs=;
 b=oI6BuVY8QfKTq5fGEbXTMGPBCCbTXbf3x+aAsV6UoE/Py8Dl3S+N8KM0cODBQ2dQ8d
 rKdk3ZnP4P0fKkbRS2uHwQFrYe3EN0Q7rf32T0I73BVY3haXUfrXEaYSWB/w1GF5TnaJ
 4wDPD/rDoEROzjKGz/ytFYIJlIvE4RlsaS7C+aCV+ES+76pP4iWwZHITZwaQ0RMnhntm
 Jxridb/qQ7gxHdh1oYl9OyPS8bcu3F78KWFQoM74yn89RRylPExhosp8cM4PSzdkxzhb
 OVd0pvhmY4PXYhZQF+2a6dBZ7k2ZZrvIvcA6zCP2KyCvVjLMeC4CyjYrGpH5pSqMqBnW
 7tmQ==
X-Gm-Message-State: AFqh2kpZZnvqsmTl2zy+HkYzdhVvDyxCMZKIBoQ4tiP9uEaVDQLkNS3R
 mT3Rye4HcfLRzDOqggOHQeAR9IEjJ/6YFJB86V4NPi6VzJmGSGjKhNsHBbje7XPqcstESOKf0Zz
 PdRznMPP/+seQ5A0v3ZXV7vNitjaysaWXSVApikh5uHRv5LhuiJgEMzP2VA==
X-Received: by 2002:a05:6871:10e:b0:15b:96b5:9916 with SMTP id
 y14-20020a056871010e00b0015b96b59916mr4406562oab.280.1675144936062; 
 Mon, 30 Jan 2023 22:02:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt461YBlfGbGEnPBld6IqYYssruudb17XaXcqtfRtpsV9f9r3/VWtlrVKZCdpHuuad8tnqBsQ49zcQrC/WYr20=
X-Received: by 2002:a05:6871:10e:b0:15b:96b5:9916 with SMTP id
 y14-20020a056871010e00b0015b96b59916mr4406560oab.280.1675144935781; Mon, 30
 Jan 2023 22:02:15 -0800 (PST)
MIME-Version: 1.0
References: <bc4136ed-abe0-dcc2-4dd9-31dcf3d8c179@nvidia.com>
 <CACGkMEuTz4RVf0CA9y7sf7K3N1FbKrD6A=xC6JL7N+hzX5RLjw@mail.gmail.com>
 <23806cd9-ffde-778c-5fa5-b95bd1ff0b44@nvidia.com>
 <20230130063247-mutt-send-email-mst@kernel.org>
 <734e2553-199f-94eb-88d1-a642ec1c7490@nvidia.com>
In-Reply-To: <734e2553-199f-94eb-88d1-a642ec1c7490@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 31 Jan 2023 14:02:04 +0800
Message-ID: <CACGkMEt0y_7sBsXeHjO=Y29Kn5ii9EAJSWkcq5x4Fue_9Esv8g@mail.gmail.com>
Subject: Re: RFC: VDPA Interrupt vector distribution
To: Eli Cohen <elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Mon, Jan 30, 2023 at 7:54 PM Eli Cohen <elic@nvidia.com> wrote:
>
>
> On 30/01/2023 13:34, Michael S. Tsirkin wrote:
> > On Mon, Jan 30, 2023 at 12:01:23PM +0200, Eli Cohen wrote:
> >> On 30/01/2023 10:19, Jason Wang wrote:
> >>> Hi Eli:
> >>>
> >>> On Mon, Jan 23, 2023 at 1:59 PM Eli Cohen <elic@nvidia.com> wrote:
> >>>> VDPA allows hardware drivers the propagate interrupts from the hardware
> >>>> directly to the vCPU used by the guest. In a typical implementation, the
> >>>> hardware driver will assign the interrupt vectors to the virtqueues and report
> >>>> this information back through the get_vq_irq() callback defined in
> >>>> struct vdpa_config_ops.
> >>>>
> >>>> Interrupt vectors could be a scarce resource and may be limited. For such
> >>>> cases, we can opt the administrator, through the vdpa tool, to set the policy
> >>>> defining how to distribute the available vectors amongst the data virtqueues.
> >>>>
> >>>> The following policies are proposed:
> >>>>
> >>>> 1. First comes first served. Assign a vector to each data virtqueue by the
> >>>>       virtqueue index. Virtqueues which could not be assigned a dedicated vector
> >>>>       would use the hardware driver to propagate interrupts using the available
> >>>>       callback mechanism.
> >>>>
> >>>>       vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 int=all
> >>>>
> >>>>       This is the default mode and works even if "int=all" was not specified.
> >>>>
> >>>> 2. Use round robin distribution so virtqueues could share vectors.
> >>>>       vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 int=all intmode=share
> >>>>
> >>>> 3. Assign vectors to RX virtqueues only.
> >>>> 3.1 Do not share vectors
> >>>>        vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 int=rx
> >>>> 3.2 Share vectors
> >>>>        vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 int=rx intmode=share
> >>>>
> >>>> 4. Assign vectors to TX virtqueues only. Can share or not, like rx.
> >>>> 5. Fail device creation if number of vectors cannot be fulfilled.
> >>>>       vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 max_vq_pairs 8 int=rx intnum=8
> >>> I wonder:
> >>>
> >>> 1) how the administrator can know if there's sufficient resources for
> >>> one of the above policies.
> >> There's no established way to know. The idea is to use whatever there is
> >> assuming interrupt bypassing is always better then the callback mechanism.
> >>> 2) how does the administrator know which policy is the best assuming
> >>> the resources are sufficient? (E.g vectors to RX only or vectors to TX
> >>> only)
> >> I don't think there's a rule of thumb here but he needs to experiment what
> >> works best for him.
> >>> If it requires a vendor specific way or knowledge, I believe it's
> >>> better to code them in:
> >>>
> >>> 1) the vDPA parent or
> >>> 2) underlayer management tool or drivers
> >>>
> >>> Thanks
> >> I was wondering also about the current mechanism we have. The hardware
> >> driver reports irq number for each VQ.
> >>
> >> The guest driver sees a virtio pci device with MSIX vectors as the number of
> >> virtqueues.
> >>
> >> Suppose the hardware driver provided only 5 interrupt vectors while there
> >> are 16 VQs.
> >>
> >> Which MSIX vector at the guest gets really posted interrupt and which one
> >> uses callback handled at the hardware driver?
> > Not sure I understand.
> > If you get a single interrupt from hardware callback or posted
> > you can only drive one interrupt to guest, no?
> >
> For every VQ I have a chance to assign interrupt vector.
>
> Consider this scenario:
>
> mlx5_vdpa created with 16 data virtqueu
>
> mlx5_vdpa associates VQ0 with interrupt vector. The reset of the vectors
> don't get assigned vectors and use old callback mechanism.
>
> When you go to the VM and run lspci, you will see the device has 16 MSIX
> vectors.

Note that the guest MSI-X vectors are emulated by software, you can
change by specificing "vectors=X" parameters of virtio-pci. And those
MSI-X vectors are backed by eventfds which Qemu will create and pass
to both KVM and vhost-vDPA.

>
> Do you know which of the MSIX vectors on the guest is the vector I
> assigned for VQ0?

The mapping from guest MSI-X vector to VQ0 is done via
queue_msix_vector in the capability, and it is under the control of
guest virtio-pci drivers.

The mapping from host MSI-X to guest MSI-X (required for the posted
interrupt) is done via matching the eventfd between KVM and vhost-vDPA
when assigning eventfds. So assuming:

1) guest driver use guest seen MSI-X vector X for vq0
2) host driver report irqX via get_vq_irq(0)

Then corresponding host MSI-X of irqX is mapped to vq0 (via guest seen
MSI-X vector X) via posted interrupt when it is possible. If the
posted interrupt can't work for some reasons, the code will fallback
to vq_callback which is a simple eventfd_signal().

Thanks

>
> >>>>
> >>>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
