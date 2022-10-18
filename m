Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCDFC4332F
	for <virtualization@archiver.kernel.org>; Tue, 18 Oct 2022 08:41:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 908FC60FFE;
	Tue, 18 Oct 2022 08:41:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 908FC60FFE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HrkS1WXm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hRdsjxrMZepf; Tue, 18 Oct 2022 08:41:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E154660FF8;
	Tue, 18 Oct 2022 08:41:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E154660FF8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE40CC0032;
	Tue, 18 Oct 2022 08:41:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D6A8C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 08:41:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 449B740A8D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 08:41:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 449B740A8D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HrkS1WXm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PRh0RL5vz7ZB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 08:41:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DC0F34019D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DC0F34019D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 08:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666082500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i/RR1Hxk78BsheEc9xl3vHs3B1J+Z1NZWyjHts3Iyx8=;
 b=HrkS1WXmxy7uC/fZtndtJ8KZCfQg74OPVyQnogCGtM3e9S5OmjHe9Ub9Tqt6/ZL2A0HbQn
 EG5+QIuGY2SU2kFe0Oe3qQaopkfMfFh9keG6CKKLDgOP6ZpFnSCHQHqM9wh9Lexk4MuuHO
 3WnJDyAvKG55DeW1+M5cl9r3Wq9y2mc=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-178-0dUrtVS-N9S4Cf5U6NOKuQ-1; Tue, 18 Oct 2022 04:41:39 -0400
X-MC-Unique: 0dUrtVS-N9S4Cf5U6NOKuQ-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-13193fb45b9so5655644fac.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 01:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i/RR1Hxk78BsheEc9xl3vHs3B1J+Z1NZWyjHts3Iyx8=;
 b=fk4dKqlVqbRW3PMSSE8exrmjN3+3x+GNUOl3CRqPMb/L4wU9iMUTu7PMs1sXB8XqKm
 sMTGOHks7FZgq2RYf50y+UiDHH6kDB0PILfN8kZxPEIBQI0lWEOuz0dfeQ3P9M5LBMyJ
 0F4L/7J+W3di5Hufl0e25iH+XpW+YsAqBK1hYFrVqroyOqb0D+XozWKBQc16dvw4Ptk6
 XL6v0dkOO/gaZmZy44E/mSNocY5tfcXkn6DBKklDgmUcUJTzyAbj5XK2nYbm1M6bc1E1
 WcrA6ACQUA1zbxOYhbRxKNstYgwIqJdNwPAI8wc2oB3Pz4Sj+3gc4p7jF0rpUQj+hSFF
 QWRg==
X-Gm-Message-State: ACrzQf3N4uGt9/40lIRQ5CVmHECyapMDhiAm5x091VwoUWpdxcHhuGKI
 pEYS6H8yi56m6J5W0kSwzbrbN5nNBvfoBvL4qQOcynIo4b0mjhBMPbFZEQVvgOrEqwwKuviGlFA
 6BzKOB4EZt96X6ff1PLfLFxWQC7UPSr+1fDcRuIQZU8Uc2dPhzqkM5lazEw==
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr17250469oad.35.1666082498735; 
 Tue, 18 Oct 2022 01:41:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7bNteYYU1ndwP/j/qAvOCjhKctfznqudVZ4PsSFW8zC58kN1VT9u3gUVrhXGIrPekqtFmAadEQ0UolmMdnPKg=
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr17250453oad.35.1666082498433; Tue, 18
 Oct 2022 01:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <1665793690-28120-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvaKnqS-0p7iqyHP_Wbbj1YdmPFA7ABfKK_8FbXMsZEkg@mail.gmail.com>
 <4f76d968-3086-0280-48fc-fcf250f11c67@oracle.com>
In-Reply-To: <4f76d968-3086-0280-48fc-fcf250f11c67@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Oct 2022 16:41:26 +0800
Message-ID: <CACGkMEs6tsPUsoP1TmEB3metqCHQF-i95G+oP3koJGAOS_5PWQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] vDPA: dev config export via "vdpa dev show" command
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Sean Mooney <smooney@redhat.com>, virtualization@lists.linux-foundation.org,
 Daniel Berrange <berrange@redhat.com>, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

On Tue, Oct 18, 2022 at 6:58 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 10/17/2022 12:08 AM, Jason Wang wrote:
> > Adding Sean and Daniel for more thoughts.
> >
> > On Sat, Oct 15, 2022 at 9:33 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> >> Live migration of vdpa would typically require re-instate vdpa
> >> device with an idential set of configs on the destination node,
> >> same way as how source node created the device in the first place.
> >>
> >> In order to allow live migration orchestration software to export the
> >> initial set of vdpa attributes with which the device was created, it
> >> will be useful if the vdpa tool can report the config on demand with
> >> simple query.
> > For live migration, I think the management layer should have this
> > knowledge and they can communicate directly without bothering the vdpa
> > tool on the source. If I was not wrong this is the way libvirt is
> > doing now.
> I think this series doesn't conflict with what libvirt is doing now. For
> example it can still remember the supported features for the parent
> mgmtdev, and mtu and mac properties for vdpa creation, and use them to
> replicate vdpa device on  destination node. The extra benefit is - the
> management software (for live migration) doesn't need to care those
> mgmtdev specifics - such as what features the parent mgmtdev supports,
> whether some features are mandatory, and what are the default values for
> those, whether there's enough system or hardware resource available to
> create vdpa with requested features et al. This kind of process can be
> simplified by just getting a vdpa created with the exact same features
> and configus exposed via the 'vdpa dev show' command. Essentially this
> export facility just provides the layer of abstraction needed for virtio
> related device configuration and for the very core need of vdpa live
> migration. For e.g. what're exported can even be useful to facilitate
> live migration from vdpa to software virtio. Basically, it doesn't
> prevent libvirt from implementing another layer on top to manage vdpa
> between mgmtdev devices and vdpa creation, and on the other hand, would
> benefit light-weighted mgmt software implementation with device
> management and live migration orchestration decoupled in the upper level.

Ok, I think this is fine.

>
> >> This will ease the orchestration software implementation
> >> so that it doesn't have to keep track of vdpa config change, or have
> >> to persist vdpa attributes across failure and recovery, in fear of
> >> being killed due to accidental software error.
> >>
> >> In this series, the initial device config for vdpa creation will be
> >> exported via the "vdpa dev show" command.
> >> This is unlike the "vdpa
> >> dev config show" command that usually goes with the live value in
> >> the device config space, which is not reliable subject to the dynamics
> >> of feature negotiation and possible change in device config space.
> >>
> >> Examples:
> >>
> >> 1) Create vDPA by default without any config attribute
> >>
> >> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
> >> $ vdpa dev show vdpa0
> >> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
> >> $ vdpa dev -jp show vdpa0
> >> {
> >>      "dev": {
> >>          "vdpa0": {
> >>              "type": "network",
> >>              "mgmtdev": "pci/0000:41:04.2",
> >>              "vendor_id": 5555,
> >>              "max_vqs": 9,
> >>              "max_vq_size": 256,
> >>          }
> >>      }
> >> }
> >>
> >> 2) Create vDPA with config attribute(s) specified
> >>
> >> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
> >>      mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> >> $ vdpa dev show
> >> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
> >>    mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> >> $ vdpa dev -jp show
> >> {
> >>      "dev": {
> >>          "vdpa0": {
> >>              "type": "network",
> >>              "mgmtdev": "pci/0000:41:04.2",
> > So "mgmtdev" looks not necessary for live migration.
> Right, so once the resulting device_features is exposed to the 'vdpa dev
> show' output, the mgmt software could infer the set of config options to
> recreate vdpa with, and filter out those unwanted attributes (or pick
> what it really wants).

Ok,  so I wonder if it is this better to have a new command instead of
mixing it with "dev show"?

Or at least have separated key for virtio like

"vdpa0": {
     "mgmtdev": "vdpasim_net",
     "virtio config: {
          ....
      }
}

Thanks

>
> -Siwei
>
> >
> > Thanks
> >
> >>              "vendor_id": 5555,
> >>              "max_vqs": 9,
> >>              "max_vq_size": 256,
> >>              "mac": "e4:11:c6:d3:45:f0",
> >>              "max_vq_pairs": 4
> >>          }
> >>      }
> >> }
> >>
> >> ---
> >>
> >> Si-Wei Liu (4):
> >>    vdpa: save vdpa_dev_set_config in struct vdpa_device
> >>    vdpa: pass initial config to _vdpa_register_device()
> >>    vdpa: show dev config as-is in "vdpa dev show" output
> >>    vdpa: fix improper error message when adding vdpa dev
> >>
> >>   drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
> >>   drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
> >>   drivers/vdpa/vdpa.c                  | 63 +++++++++++++++++++++++++++++++++---
> >>   drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
> >>   drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
> >>   drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
> >>   drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 +-
> >>   include/linux/vdpa.h                 | 26 ++++++++-------
> >>   8 files changed, 80 insertions(+), 22 deletions(-)
> >>
> >> --
> >> 1.8.3.1
> >>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
