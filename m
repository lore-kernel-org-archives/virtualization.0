Return-Path: <SRS0=j1Zo=K2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B4BC47095
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 06:32:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2855D60241
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 06:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2855D60241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9004F40223;
	Mon, 31 May 2021 06:32:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bJuS3egC5E8c; Mon, 31 May 2021 06:32:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 250B0403AE;
	Mon, 31 May 2021 06:32:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3DE0C0022;
	Mon, 31 May 2021 06:32:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE917C0001;
 Mon, 31 May 2021 06:32:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9740B4036F;
 Mon, 31 May 2021 06:32:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ogW6ypjRwmFb; Mon, 31 May 2021 06:32:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3A1B540376;
 Mon, 31 May 2021 06:32:11 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A17661002;
 Mon, 31 May 2021 06:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1622442730;
 bh=/Rpow5pd3vI3QDiPLujMq5XYut4dwN7beksCj+Osmiw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VafGWsZBf8JY9hyaPQA2lYDCFBVOsJdxrXv6Ao4UOn9xAR5q75AQDEMjMNgdMIEZB
 6dFZCv8k/YU22mPbGQ6Yw0mZr/cbVfo08aoF91SsFjWMAMKhxQobvj8iQhm6dPrCXu
 ZdZKoa1KQCAFM7bTKNo/9xjeEFXT3xPGBt94IdM4=
Date: Mon, 31 May 2021 08:32:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in
 Userspace
Message-ID: <YLSC6AthAl+VeQsv@kroah.com>
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
 <YLRsehBRAiCJEDl0@kroah.com>
 <CACycT3vRHPfOGxmy1Uv=8_dqqq8iG4YTZHUizo+y8EYKGS5g8g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACycT3vRHPfOGxmy1Uv=8_dqqq8iG4YTZHUizo+y8EYKGS5g8g@mail.gmail.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, joro@8bytes.org,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, linux-fsdevel@vger.kernel.org,
 Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>
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

On Mon, May 31, 2021 at 02:19:37PM +0800, Yongji Xie wrote:
> Hi Greg,
> 
> Thanks a lot for the review!
> 
> On Mon, May 31, 2021 at 12:56 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, May 17, 2021 at 05:55:12PM +0800, Xie Yongji wrote:
> > > +struct vduse_dev {
> > > +     struct vduse_vdpa *vdev;
> > > +     struct device dev;
> > > +     struct cdev cdev;
> >
> > You now have 2 reference counted devices controling the lifespace of a
> > single structure.  A mess that is guaranteed to go wrong.  Please never
> > do this.
> >
> 
> These two are both used by cdev_device_add(). Looks like I didn't find
> any problem. Any suggestions?

Make one of these dynamic and do not have them both control the lifespan
of the structure.

> > > +     struct vduse_virtqueue *vqs;
> > > +     struct vduse_iova_domain *domain;
> > > +     char *name;
> > > +     struct mutex lock;
> > > +     spinlock_t msg_lock;
> > > +     atomic64_t msg_unique;
> >
> > Why do you need an atomic and a lock?
> >
> 
> You are right. We don't need an atomic here.
> 
> > > +     wait_queue_head_t waitq;
> > > +     struct list_head send_list;
> > > +     struct list_head recv_list;
> > > +     struct list_head list;
> > > +     struct vdpa_callback config_cb;
> > > +     struct work_struct inject;
> > > +     spinlock_t irq_lock;
> > > +     unsigned long api_version;
> > > +     bool connected;
> > > +     int minor;
> > > +     u16 vq_size_max;
> > > +     u32 vq_num;
> > > +     u32 vq_align;
> > > +     u32 config_size;
> > > +     u32 device_id;
> > > +     u32 vendor_id;
> > > +};
> > > +
> > > +struct vduse_dev_msg {
> > > +     struct vduse_dev_request req;
> > > +     struct vduse_dev_response resp;
> > > +     struct list_head list;
> > > +     wait_queue_head_t waitq;
> > > +     bool completed;
> > > +};
> > > +
> > > +struct vduse_control {
> > > +     unsigned long api_version;
> >
> > u64?
> >
> 
> OK.
> 
> > > +};
> > > +
> > > +static unsigned long max_bounce_size = (64 * 1024 * 1024);
> > > +module_param(max_bounce_size, ulong, 0444);
> > > +MODULE_PARM_DESC(max_bounce_size, "Maximum bounce buffer size. (default: 64M)");
> > > +
> > > +static unsigned long max_iova_size = (128 * 1024 * 1024);
> > > +module_param(max_iova_size, ulong, 0444);
> > > +MODULE_PARM_DESC(max_iova_size, "Maximum iova space size (default: 128M)");
> > > +
> > > +static bool allow_unsafe_device_emulation;
> > > +module_param(allow_unsafe_device_emulation, bool, 0444);
> > > +MODULE_PARM_DESC(allow_unsafe_device_emulation, "Allow emulating unsafe device."
> > > +     " We must make sure the userspace device emulation process is trusted."
> > > +     " Otherwise, don't enable this option. (default: false)");
> > > +
> >
> > This is not the 1990's anymore, please never use module parameters, make
> > these per-device attributes if you really need them.
> >
> 
> These parameters will be used before the device is created. Or do you
> mean add some attributes to the control device?

You need to do something, as no one can mess with a module parameter
easily.  Why do you need them at all, shouldn't it "just work" properly
with no need for userspace interaction?

> > > +static int vduse_init(void)
> > > +{
> > > +     int ret;
> > > +
> > > +     if (max_bounce_size >= max_iova_size)
> > > +             return -EINVAL;
> > > +
> > > +     ret = misc_register(&vduse_misc);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     vduse_class = class_create(THIS_MODULE, "vduse");
> >
> > If you have a misc device, you do not need to create a class at the same
> > time.  Why are you doing both here?  Just stick with the misc device, no
> > need for anything else.
> >
> 
> The misc device is the control device represented by
> /dev/vduse/control. Then a VDUSE device represented by
> /dev/vduse/$NAME can be created by the ioctl(VDUSE_CREATE_DEV) on this
> control device.

Ah.  Then how about using the same MAJOR for all of these, and just have
the first minor (0) be your control?  That happens for other device
types (raw, loop, etc.).  Or just document this really well please, as
it was not obvious what you were doing here.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
