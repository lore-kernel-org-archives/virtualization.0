Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA8CC433EF
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 17:59:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E299860A84;
	Tue, 17 May 2022 17:59:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XD1-NnmRcuvZ; Tue, 17 May 2022 17:59:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 742DA60A91;
	Tue, 17 May 2022 17:59:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40D78C0032;
	Tue, 17 May 2022 17:59:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0B28C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 17:59:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F9A560A91
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 17:59:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fECq6WzEHH2g
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 17:59:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5723560A84
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 17:59:42 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BB0A0B81B0F;
 Tue, 17 May 2022 17:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26906C385B8;
 Tue, 17 May 2022 17:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1652810378;
 bh=HDN0i/fLgfP0+C3rAigMeFGNTGgmAKAWat0j4l5gfbs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O/hlZV1lM9b6ssnxzoR2gH1dLdX4TfNazg5eMr5XQb1v5YFeQNY5k0to0SC/yr6MQ
 N7HcInqvanepvJAnqA8BrBlfWWh8XGybBa2K9zigykejjz3PyIMBXCBwVXTrLXIBf1
 SE4qsYI7Tv7WsIRU+OhgJJA7+jht1OtRGqxEtQnA=
Date: Tue, 17 May 2022 15:54:13 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
Message-ID: <YoOpBaWcaoujWqO7@kroah.com>
References: <20220516060342.106-1-xieyongji@bytedance.com>
 <20220516060342.106-2-xieyongji@bytedance.com>
 <PH0PR12MB54813F96E346D591FBE238C1DCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACycT3sRc4bk+3oq7FLzpBMCG_XRN7tOaeEAtNg69o3h8c3=EA@mail.gmail.com>
 <PH0PR12MB5481AD3C1517331EAC4EE078DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PH0PR12MB5481AD3C1517331EAC4EE078DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Yongji Xie <xieyongji@bytedance.com>, Eli Cohen <elic@nvidia.com>,
 "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>
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

On Tue, May 17, 2022 at 12:21:03PM +0000, Parav Pandit wrote:
> Hi Greg, Yongji,
> 
> > From: Yongji Xie <xieyongji@bytedance.com>
> > Sent: Tuesday, May 17, 2022 3:25 AM
> > 
> > On Tue, May 17, 2022 at 4:06 AM Parav Pandit <parav@nvidia.com> wrote:
> > >
> > >
> > >
> > > > From: Xie Yongji <xieyongji@bytedance.com>
> > > > Sent: Monday, May 16, 2022 2:04 AM
> > > >
> > > > Introduce a device object for vdpa management device to control its
> > > > lifecycle.
> > > Why is this needed?
> > > What is the limitation of current approach that requires new device for
> > mgmtdev?
> > > The primary motivation is missing in the commit log here.
> > >
> > 
> > OK, I will add one. This patch actually comes from the discussion:
> > 
> > 
> > https://www.spinics.net/lists/linux-virtualization/msg56371.html
> > 
> > The "vdpa_mgmt_dev" makes things a little confusing. Embedding the
> > device struct in it to control its lifecycle simplifies the logic and makes the
> > driver model clear.
> > 
> No. it doesn't.
> 
> vdpa_mgmt_dev is really the handle for all the netlink socket messages targeted.
> It is not really a struct device.

Why can it not be one?  It has lifetime rules that must be followed, so
might as well use the built-in code to handle this, right?

What is wrong with it being a struct device?

> We can rename it to vdpa_mgmt_handle, if the _dev suffix is confusing.

Where is the "management" device if this is not that?

What does "handle" mean here?

> And regarding vduse_dev_release() and existing empty release function, they can be dynamically allocated.
> This is because they are really the struct device.

I do not understand this statement, sorry.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
