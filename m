Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6156C4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 09:17:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2661B22DBF
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 09:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2661B22DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6B5B487329;
	Wed, 16 Dec 2020 09:17:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i2ArHdZMZU5n; Wed, 16 Dec 2020 09:17:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 94107872FC;
	Wed, 16 Dec 2020 09:17:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 837D4C0893;
	Wed, 16 Dec 2020 09:17:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 847B7C013B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 09:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7191020131
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 09:17:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id za2havlsndpl
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 09:17:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 0C1E320112
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 09:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608110222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u5zqGrC9x8nqAJsUh7MLcyFE7ZiJo4eIJRKgfoVE6xY=;
 b=JEi0qoJsFmWuO7NYFNaCL41Ov4IE1pezR64z84Q+j1CnqECGHBrR1JO0b8WkuAUcwi6QYr
 kAzz6IrR4raQdNBS4tB93exzrcpq8w/LflTnE8tXlWx59s5lCWuKPvd6DPuCprXwQYsBYi
 4ue6/FiLpeAX9zJ62WZfqXiDOxPFW1I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-QqmIS4sOOC2jbYPwtXPFOw-1; Wed, 16 Dec 2020 04:16:22 -0500
X-MC-Unique: QqmIS4sOOC2jbYPwtXPFOw-1
Received: by mail-wr1-f72.google.com with SMTP id g16so7956044wrv.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 01:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=u5zqGrC9x8nqAJsUh7MLcyFE7ZiJo4eIJRKgfoVE6xY=;
 b=YP86NWZAitlAEMFWjyfCGrWDhf6lLKbRSVj2/2fdYd6XDqTZh7Np5YRUao55igeSJs
 fVOUiisKO+HtgYuVUovRdhKJK0q1R4Ojh6L7eASk3/3fGxJNA1xpjTRXNgb3BSwQtBSu
 hsmy6oMiyigGGKJlHdBmNOKa95hMePZtGoUAPJg3ovoiH7fKnd89AqpHUWRJoEDVaa33
 baSME4GRIqddZxfPjJm6D+R7bhwvRkw1z+4HhBaItvZMltfkY+sAwtl2fKtOpmZPJN+4
 mY7SqhYXoqRJzNlYbgx3/k3M2wvRq3RUFuwzEqiLaDpV+2HP842tL9jeq/s87wQHyMLd
 JOFQ==
X-Gm-Message-State: AOAM533N2wimM6wWQrnWXSEaalClZcuEA/PNnpzwfjvuU5FKz/M0qmBc
 KZSc5shM90tc7mXqJWHKW4mba2AZ62wdc9L0vZbg35y4f6/9iS+I/63tYKGGeQv4bsxu/F7kf+D
 Xy5ce65ov/sudTRTbNvAlytQGMecT6c4bwrJMhWJ20A==
X-Received: by 2002:a1c:63d4:: with SMTP id x203mr2282374wmb.28.1608110181405; 
 Wed, 16 Dec 2020 01:16:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwiqPKKwKJLuj10t2VJ0AG3yu+O6MCXk3YllBZTjRYzKPPDCQiFlk8FkCJucZU/iv0Srhxn3g==
X-Received: by 2002:a1c:63d4:: with SMTP id x203mr2282359wmb.28.1608110181182; 
 Wed, 16 Dec 2020 01:16:21 -0800 (PST)
Received: from redhat.com (bzq-109-67-15-113.red.bezeqint.net. [109.67.15.113])
 by smtp.gmail.com with ESMTPSA id l1sm1795870wmi.15.2020.12.16.01.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Dec 2020 01:16:20 -0800 (PST)
Date: Wed, 16 Dec 2020 04:16:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH 0/7] Introduce vdpa management tool
Message-ID: <20201216041506-mutt-send-email-mst@kernel.org>
References: <20201112064005.349268-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20201112064005.349268-1-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, elic@nvidia.com,
 virtualization@lists.linux-foundation.org
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

On Thu, Nov 12, 2020 at 08:39:58AM +0200, Parav Pandit wrote:
> This patchset covers user requirements for managing existing vdpa devices,
> using a tool and its internal design notes for kernel drivers.


I applied bugfix patches 1 and 2.
Others conflict with vdpa sim block support, pls rebase.


> Background and user requirements:
> ----------------------------------
> (1) Currently VDPA device is created by driver when driver is loaded.
> However, user should have a choice when to create or not create a vdpa device
> for the underlying parent device.
> 
> For example, mlx5 PCI VF and subfunction device supports multiple classes of
> device such netdev, vdpa, rdma. Howevever it is not required to always created
> vdpa device for such device.
> 
> (2) In another use case, a device may support creating one or multiple vdpa
> device of same or different class such as net and block.
> Creating vdpa devices at driver load time further limits this use case.
> 
> (3) A user should be able to monitor and query vdpa queue level or device level
> statistics for a given vdpa device.
> 
> (4) A user should be able to query what class of vdpa devices are supported
> by its parent device.
> 
> (5) A user should be able to view supported features and negotiated features
> of the vdpa device.
> 
> (6) A user should be able to create a vdpa device in vendor agnostic manner
> using single tool.
> 
> Hence, it is required to have a tool through which user can create one or more
> vdpa devices from a parent device which addresses above user requirements.
> 
> Example devices:
> ----------------
>  +-----------+ +-----------+ +---------+ +--------+ +-----------+ 
>  |vdpa dev 0 | |vdpa dev 1 | |rdma dev | |netdev  | |vdpa dev 3 |
>  |type=net   | |type=block | |mlx5_0   | |ens3f0  | |type=net   |
>  +----+------+ +-----+-----+ +----+----+ +-----+--+ +----+------+
>       |              |            |            |         |
>       |              |            |            |         |
>  +----+-----+        |       +----+----+       |    +----+----+
>  |  mlx5    +--------+       |mlx5     +-------+    |mlx5     |
>  |pci vf 2  |                |pci vf 4 |            |pci sf 8 |
>  |03:00:2   |                |03:00.4  |            |mlx5_sf.8|
>  +----+-----+                +----+----+            +----+----+
>       |                           |                      |
>       |                      +----+-----+                |
>       +----------------------+mlx5      +----------------+
>                              |pci pf 0  |
>                              |03:00.0   |
>                              +----------+
> 
> vdpa tool:
> ----------
> vdpa tool is a tool to create, delete vdpa devices from a parent device. It is a
> tool that enables user to query statistics, features and may be more attributes
> in future.
> 
> vdpa tool command draft:
> ------------------------
> (a) List parent devices which supports creating vdpa devices.
> It also shows which class types supported by this parent device.
> In below command example two parent devices support vdpa device creation.
> First is PCI VF whose bdf is 03.00:2.
> Second is PCI VF whose name is 03:00.4.
> Third is PCI SF whose name is mlx5_core.sf.8
> 
> $ vdpa parentdev list
> vdpasim
>   supported_classes
>     net
> pci/0000:03.00:3
>   supported_classes
>     net block
> pci/0000:03.00:4
>   supported_classes
>     net block
> auxiliary/mlx5_core.sf.8
>   supported_classes
>     net
> 
> (b) Now add a vdpa device of networking class and show the device.
> $ vdpa dev add parentdev pci/0000:03.00:2 type net name foo0 $ vdpa dev show foo0
> foo0: parentdev pci/0000:03.00:2 type network parentdev vdpasim vendor_id 0 max_vqs 2 max_vq_size 256
> 
> (c) Show features of a vdpa device
> $ vdpa dev features show foo0
> supported
>   iommu platform
>   version 1
> 
> (d) Dump vdpa device statistics
> $ vdpa dev stats show foo0
> kickdoorbells 10
> wqes 100
> 
> (e) Now delete a vdpa device previously created.
> $ vdpa dev del foo0
> 
> vdpa tool support in this patchset:
> -----------------------------------
> vdpa tool is created to create, delete and query vdpa devices.
> examples:
> Show vdpa parent device that supports creating, deleting vdpa devices.
> 
> $ vdpa parentdev show
> vdpasim:
>   supported_classes
>     net
> 
> $ vdpa parentdev show -jp
> {
>     "show": {
>        "vdpasim": {
>           "supported_classes": {
>              "net"
>         }
>     }
> }
> 
> Create a vdpa device of type networking named as "foo2" from the parent device vdpasim:
> 
> $ vdpa dev add parentdev vdpasim type net name foo2
> 
> Show the newly created vdpa device by its name:
> $ vdpa dev show foo2
> foo2: type network parentdev vdpasim vendor_id 0 max_vqs 2 max_vq_size 256
> 
> $ vdpa dev show foo2 -jp
> {
>     "dev": {
>         "foo2": {
>             "type": "network",
>             "parentdev": "vdpasim",
>             "vendor_id": 0,
>             "max_vqs": 2,
>             "max_vq_size": 256
>         }
>     }
> }
> 
> Delete the vdpa device after its use:
> $ vdpa dev del foo2
> 
> vdpa tool support by kernel:
> ----------------------------
> vdpa tool user interface will be supported by existing vdpa kernel framework,
> i.e. drivers/vdpa/vdpa.c It services user command through a netlink interface.
> 
> Each parent device registers supported callback operations with vdpa subsystem
> through which vdpa device(s) can be managed.
> 
> FAQs:
> -----
> 1. Where does userspace vdpa tool reside which users can use?
> Ans: vdpa tool can possibly reside in iproute2 [1] as it enables user to
> create vdpa net devices.
> 
> 2. Why not create and delete vdpa device using sysfs/configfs?
> Ans:
> (a) A device creation may involve passing one or more attributes.
> Passing multiple attributes and returning error code and more verbose
> information for invalid attributes cannot be handled by sysfs/configfs.
> 
> (b) netlink framework is rich that enables user space and kernel driver to
> provide nested attributes.
> 
> (c) Exposing device specific file under sysfs without net namespace
> awareness exposes details to multiple containers. Instead exposing
> attributes via a netlink socket secures the communication channel with kernel.
> 
> (d) netlink socket interface enables to run syscaller kernel tests.
> 
> 3. Why not use ioctl() interface?
> Ans: ioctl() interface replicates the necessary plumbing which already
> exists through netlink socket.
> 
> 4. What happens when one or more user created vdpa devices exist for a
> parent PCI VF or SF and such parent device is removed?
> Ans: All user created vdpa devices are removed that belong to a parent.
> 
> [1] git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git
> 
> Next steps:
> -----------
> (a) Post this patchset and iproute2/vdpa inclusion, remaining two drivers
> will be coverted to support vdpa tool instead of creating unmanaged default
> device on driver load.
> (b) More net specific parameters such as mac, mtu will be added.
> (c) Features bits get and set interface will be added.
> 
> Parav Pandit (7):
>   vdpa: Add missing comment for virtqueue count
>   vdpa: Use simpler version of ida allocation
>   vdpa: Extend routine to accept vdpa device name
>   vdpa: Define vdpa parent device, ops and a netlink interface
>   vdpa: Enable a user to add and delete a vdpa device
>   vdpa: Enable user to query vdpa device info
>   vdpa/vdpa_sim: Enable user to create vdpasim net devices
> 
>  drivers/vdpa/Kconfig              |   1 +
>  drivers/vdpa/ifcvf/ifcvf_main.c   |   2 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c |   2 +-
>  drivers/vdpa/vdpa.c               | 511 +++++++++++++++++++++++++++++-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c  |  81 ++++-
>  include/linux/vdpa.h              |  46 ++-
>  include/uapi/linux/vdpa.h         |  41 +++
>  7 files changed, 660 insertions(+), 24 deletions(-)
>  create mode 100644 include/uapi/linux/vdpa.h
> 
> -- 
> 2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
