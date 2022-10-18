Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B133C433FE
	for <virtualization@archiver.kernel.org>; Tue, 18 Oct 2022 08:00:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C815440B05;
	Tue, 18 Oct 2022 08:00:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C815440B05
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EBDfOmzX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IplUGGI8TPVC; Tue, 18 Oct 2022 08:00:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2D67340AFC;
	Tue, 18 Oct 2022 08:00:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2D67340AFC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE412C0081;
	Tue, 18 Oct 2022 08:00:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8B8DC0082
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 08:00:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B3F5A60FE0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 08:00:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B3F5A60FE0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EBDfOmzX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ufsbWRqNwb6p
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 08:00:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CDB860FDE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2CDB860FDE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 08:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666080008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M9V/E+gyYuQ+bZyzBd+ENqQPbpX7i2C1TSamw6Aqs6A=;
 b=EBDfOmzXZbSU8g8UcY5J+da0UIfXH7Osp2qvbX1Ui0h9QMo0j59gC3IE9SypjPKANDt8Tq
 cCvKciGyu1aYkOHgPPVBoxtY2WoeiUD8OXfoEm0EX97KCRGZPkIbZssAV4unRPbC34g8mq
 DPMzscWrBUkL13plGDk63zfhWQs9Qmo=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-632-a5S-pA7ONyKEuRTHumEQGw-1; Tue, 18 Oct 2022 04:00:07 -0400
X-MC-Unique: a5S-pA7ONyKEuRTHumEQGw-1
Received: by mail-oo1-f69.google.com with SMTP id
 a11-20020a4a80cb000000b004805cba57f1so5796357oog.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 01:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M9V/E+gyYuQ+bZyzBd+ENqQPbpX7i2C1TSamw6Aqs6A=;
 b=j8NXWeGHN34OfDjm0/qtBxHjuVtlGHCQ6AZ8zaHIccAlGzfS7Cmwmz6Ss6NJBwAnlE
 vpXWxmqF88519++RRLIcO6vijw+0f0tsOFiYPY1cuHlKCJkbsUCVVoeTckPmNCDLmumG
 Hz9IRHr6XKBiEVv6OEFKJhOWEkFIdQ1bwXx/tqh7NvSGS6wEm84NqgHokuWmrej8aZFp
 IFEutgmE4uQ+ZxuR0yW64fzunSO4qz+Z6ctH+dXmyvNE2DLnfYyOpfT4sIEZ/ZyZqYyS
 apZBCjMH1dxcqxARu7NO6DIBif0dO0K0XSg4ntEUU1aPmQzPZguNi17+n/dbkgt1T4U5
 aIGA==
X-Gm-Message-State: ACrzQf22sZ32hbHWSMvI0IDk8ZBYrRExLNYdgLYi0mqbvdgzjwvAExbG
 B176bf1YcGjG+oBBx7x48dnZaPvNYGi/ZD3WWYGGbV0IqM8AtqeYIkEJG5kaV9LM/kKDIcD3DLZ
 Eey7bpl3AKe15i4brKRwqcxXjhKj+1QUlM8Z0uLu8b1+AbO19BB7++wQ4ow==
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr17183030oad.35.1666080006165; 
 Tue, 18 Oct 2022 01:00:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5sVNZD+JQIUuPUjl4lRd3buziWCBqRcdKW/0rjAzY3IrTHZF48ERxB5fnFzWKHQP23bdF6ebGGl279R6EBWzg=
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr17183023oad.35.1666080005814; Tue, 18
 Oct 2022 01:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <1665793690-28120-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvaKnqS-0p7iqyHP_Wbbj1YdmPFA7ABfKK_8FbXMsZEkg@mail.gmail.com>
 <08d98212a355fdce5820d57bd0ffaf3ca0968531.camel@redhat.com>
 <5887b71e-cef2-a7b9-133c-e4ba860bf24a@oracle.com>
In-Reply-To: <5887b71e-cef2-a7b9-133c-e4ba860bf24a@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Oct 2022 15:59:54 +0800
Message-ID: <CACGkMEvQhfenW9-StMwaJ887eatb_qtRYdDn=E12Wwkc6HU-sQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] vDPA: dev config export via "vdpa dev show" command
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Daniel Berrange <berrange@redhat.com>, Sean Mooney <smooney@redhat.com>,
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

On Tue, Oct 18, 2022 at 7:35 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 10/17/2022 5:28 AM, Sean Mooney wrote:
> > On Mon, 2022-10-17 at 15:08 +0800, Jason Wang wrote:
> >> Adding Sean and Daniel for more thoughts.
> >>
> >> On Sat, Oct 15, 2022 at 9:33 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> >>> Live migration of vdpa would typically require re-instate vdpa
> >>> device with an idential set of configs on the destination node,
> >>> same way as how source node created the device in the first place.
> >>>
> >>> In order to allow live migration orchestration software to export the
> >>> initial set of vdpa attributes with which the device was created, it
> >>> will be useful if the vdpa tool can report the config on demand with
> >>> simple query.
> >> For live migration, I think the management layer should have this
> >> knowledge and they can communicate directly without bothering the vdpa
> >> tool on the source. If I was not wrong this is the way libvirt is
> >> doing now.
> > At least form a openstack(nova) perspective we are not expecting to do any vdpa device configuration
> > at the openstack level. To use a vdpa device in openstack the oeprator when installing openstack
> > need to create a udev/systemd script to precreatre the vdpa devices.
> This seems to correlate vdpa device creation with the static allocation
> of SR-IOV VF devices. Perhaps OpenStack doesn't have a plan to support
> dynamic vdpa creation, but conceptionally vdpa creation can be on demand
> for e.g. over Mellanox SubFunction or Intel Scalable IOV device.

Yes, it's not specific to vDPA but something that openstack needs to consider.

>
> >
> > nova will query libvirt for the list avaiable vdpa devices at start up and record them in our database.
> > when schudling we select a host that has a free vdpa device and on that host we generate a xml snipit
> > that refernce the vdpa device and proivde that to libvirt and it will in turn program the mac.
> >
> > """
> > <interface type="vdpa">
> >      <mac address="b5:bc:2e:e7:51:ee"/>
> >      <source dev="/dev/vhost-vdpa-3"/>
> > </interface>
> > """
> >
> > when live migrating the workflow is similar. we ask our schduler for a host that should have enough avaiable
> > resouces, then we make an rpc call "pre_live_migrate" which makes a number of assterions such as cpu compatiablity

A migration compatibility check for vDPA should be done as well here.

> > but also computes cpu pinning and device passthough asignemnts. i.e. in pre_live_migate we select wich cpu cores, pcie
> > devices and in this case vdpa devices to use on the destination host
> In the case of vdpa, does it (the pre_live_migrate rpc) now just selects
> the parent mgmtdev for creating vdpa in later phase, or it ends up with
> a vdpa device being created? Be noted by now there's only a few
> properties for vdpa creation e.g. mtu and mac, that it doesn't need
> special reservation of resources for creating a vdpa device. But that
> may well change in the future.
>
> > and return that in our rpc result.
> >
> > we then use that information to udpate the libvirt domain xml with the new host specific information and start
> > the migration at the libvirt level.
> >
> > today in openstack we use a hack i came up with to workaroudn that fact that you cant migrate with sriov/pci passthough
> > devices to support live migration with vdpa. basically before we call libvirt to live migrate we hot unplug the vdpa nic
> > form the guest and add them back after the migration is complte. if you dont bound the vdpa nics wiht a transparently migratable
> > nic in the guest that obvioulsy result in a loss of network connectivity while the migration is happenign which is not ideal
> > so a normal virtio-net interface on ovs is what we recommend as the fallback interface for the bound.
> Do you need to preserve the mac address when falling back to the normal
> virtio-net interface, and similarly any other network config/state?
> Basically vDPA doesn't support live migration for the moment.

Basic shadow vq based live migration can work now. Eugenio is working
to make it fully ready in the near future.

>This
> doesn't like to be a technically correct solution for it to work.

I agree.

> >
> > obviouly when vdpa supprot transparent live migration we can just skip this workaround which woudl be a very nice ux improvement.
> > one of the sideeffct of the hack however is you can start with an intel nic and end up with a melonox nic becasue we dont need
> > to preserve the device capablies sicne we are hotplugging.
> Exactly. This is the issue.
> >
> > with vdpa we will at least have a virtaul virtio-net-pci frontend in qemu to provide some level of abstraction.
> > i guess the point you are raising is that for live migration we cant start with 4 queue paris and vq_size=256
> > and select a device with 2 queue pairs and vq_size of 512 and expect that to just work.
> Not exactly, the vq_size comes from QEMU that has nothing to do with
> vDPA tool. And live migrating from 4 queue pairs to 2 queue pairs won't
> work for the guest driver. Change of queue pair numbers would need
> device reset which  won't happen transparently during live migration.
> Basically libvirt has to match the exact queue pair number and queue
> length on destination node.
>
> >
> > There are two ways to adress that. 1 we can start recording this infor in our db and schdule only ot hosts with the same
> > configuration values, or 2 we can record the capablities i.e. the max vaulues that are support by a devcice and schdule to a host
> > where its >= the current value and rely on libvirt to reconfigure the device.
> >
> > libvirt required very little input today to consume a vdpa interface
> > https://libvirt.org/formatdomain.html#vdpa-devices

So a question here, if we need to create vDPA on demand (e.g with the
features and configs from the source) who will do the provision? Is it
libvirt?

Thanks

> > there are some generic virtio device optiosn we could set https://libvirt.org/formatdomain.html#virtio-related-options
> > and some generic options like the mtu that the interface element supportr
> >
> > but the miniumal valide xml snipit is litrally just the source dev path.
> >
> > <devices>
> >    <interface type='vdpa'>
> >      <source dev='/dev/vhost-vdpa-0'/>
> >    </interface>
> > </devices>
> >
> > nova only add the mac address and MTU today although i have some untested code that will try to also set the vq size.
> > https://github.com/openstack/nova/blob/11cb31258fa5b429ea9881c92b2d745fd127cdaf/nova/virt/libvirt/designer.py#L154-L167
> >
> > The basic supprot we have today assumes however that the vq_size is either the same on all host or it does not matter because we do
> > not support transparent live migration today so its ok for it to change form host to host.
> > in any case we do not track the vq_size or vq count today so we cant schdule based on it or comunicate it to libvirt via our
> > pre_live_migration rpc result. that means libvirt shoudl check if the dest device has the same cofnig or update it if posible
> > before starting the destination qemu instance and begining the migration.
> >
> >>> This will ease the orchestration software implementation
> >>> so that it doesn't have to keep track of vdpa config change, or have
> >>> to persist vdpa attributes across failure and recovery, in fear of
> >>> being killed due to accidental software error.
> > the vdpa device config is not somethign we do today so this woudl make our lives more complex
> It's regarding use case whether to support or not. These configs well
> exist before my change.
>
> > depending on
> > what that info is. at least in the case of nova we do not use the vdpa cli at all, we use libvirt as an indirection layer.
> > so libvirt would need to support this interface, we would have to then add it to our db and modify our RPC interface
> > to then update the libvirt xml with addtional info we dont need today.
>
> Yes. You can follow libvirt when the corresponding support is done, but
> I think it's orthogonal with my changes. Basically my change won't
> affect libvirt's implementation at all.
>
> Thanks,
> -Siwei
>
>
> >>> In this series, the initial device config for vdpa creation will be
> >>> exported via the "vdpa dev show" command.
> >>> This is unlike the "vdpa
> >>> dev config show" command that usually goes with the live value in
> >>> the device config space, which is not reliable subject to the dynamics
> >>> of feature negotiation and possible change in device config space.
> >>>
> >>> Examples:
> >>>
> >>> 1) Create vDPA by default without any config attribute
> >>>
> >>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
> >>> $ vdpa dev show vdpa0
> >>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
> >>> $ vdpa dev -jp show vdpa0
> >>> {
> >>>      "dev": {
> >>>          "vdpa0": {
> >>>              "type": "network",
> >>>              "mgmtdev": "pci/0000:41:04.2",
> >>>              "vendor_id": 5555,
> >>>              "max_vqs": 9,
> >>>              "max_vq_size": 256,
> >>>          }
> >>>      }
> >>> }
> > This is how openstack works today. this step is done statically at boot time typiccly via a udev script or systemd servic file.
> > the mac adress is udpate don the vdpa interface by libvirt when its asigined to the qemu process.
> > if we wanted to suport multi queue or vq size configuration it would also happen at that time not during device creation.
> >>> 2) Create vDPA with config attribute(s) specified
> >>>
> >>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
> >>>      mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> >>> $ vdpa dev show
> >>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
> >>>    mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> >>> $ vdpa dev -jp show
> >>> {
> >>>      "dev": {
> >>>          "vdpa0": {
> >>>              "type": "network",
> >>>              "mgmtdev": "pci/0000:41:04.2",
> >> So "mgmtdev" looks not necessary for live migration.
> >>
> >> Thanks
> >>
> >>>              "vendor_id": 5555,
> >>>              "max_vqs": 9,
> >>>              "max_vq_size": 256,
> >>>              "mac": "e4:11:c6:d3:45:f0",
> >>>              "max_vq_pairs": 4
> >>>          }
> >>>      }
> >>> }
> > dynmaicaly creating vdpa device at runtime while possible is not an approch we are plannign to supprot.
> >
> > currntly in nova we perefer to do allcoation of staticically provsioned resouces in nova.
> > for persitent memory, sriov/pci passthorgh, dedciated cpus, hugepages and vdpa devices we manage inventories
> > of resouce that the operator has configured on the platform.
> >
> > we have one excption to this static aproch which is semi dynmaic that is how we manage vifo mediated devices.
> > for reasons that are not important we currrnly track the partent devices that are capable of providing MDEVs
> > and we directlly write to /sys/... to create teh mdev instance  of a requested mdev on demand.
> >
> > This has proven ot be quite problematic as we have encountered caching bugs due to the delay between device
> > creation and when the /sys interface expost the direcotry stucture for the mdev. This has lead ot libvirt and as a result
> > nova getting out of sync with the actual state of the host. There are also issue with host reboots.
> >
> > while we do see the advantage of beign able to create vdpa interface on demad espicaly if we can do finer grained resouce
> > partioning by allcoating one mdev with 4 vqs adn another with 8 ectra, or experice with dynmic mdev management gives us
> > pause. we can and will fix our bugs with mdevs but we have found that most of our customers that use feature  like this
> > are telcos or other similar industries that typiclly have very static wrokloads. while there is  some interest in making
> > there clouds more dynmaic they typically file a host and run the same worklaod on that host form months to years at a
> > time and plan there hardware and acordingly so they are well seved by the static usecase "1) Create vDPA by default without any config attribute".
> >
> >>> ---
> >>>
> >>> Si-Wei Liu (4):
> >>>    vdpa: save vdpa_dev_set_config in struct vdpa_device
> >>>    vdpa: pass initial config to _vdpa_register_device()
> >>>    vdpa: show dev config as-is in "vdpa dev show" output
> >>>    vdpa: fix improper error message when adding vdpa dev
> >>>
> >>>   drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
> >>>   drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
> >>>   drivers/vdpa/vdpa.c                  | 63 +++++++++++++++++++++++++++++++++---
> >>>   drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
> >>>   drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
> >>>   drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
> >>>   drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 +-
> >>>   include/linux/vdpa.h                 | 26 ++++++++-------
> >>>   8 files changed, 80 insertions(+), 22 deletions(-)
> >>>
> >>> --
> >>> 1.8.3.1
> >>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
