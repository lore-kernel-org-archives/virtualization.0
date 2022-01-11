Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526F9C433EF
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 07:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AEBE410AE;
	Tue, 11 Jan 2022 07:10:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B9exLy6sHVgp; Tue, 11 Jan 2022 07:09:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 31267409A9;
	Tue, 11 Jan 2022 07:09:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6417C002F;
	Tue, 11 Jan 2022 07:09:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD4D6C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 07:09:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BAE86409AB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 07:09:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dD7ClZ0ciIaz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 07:09:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99473409A9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 07:09:56 +0000 (UTC)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4JY1zP3Nwmz83Lwn;
 Tue, 11 Jan 2022 15:09:53 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
 by mse-fl1.zte.com.cn with SMTP id 20B79fBY066368;
 Tue, 11 Jan 2022 15:09:41 +0800 (GMT-8)
 (envelope-from wang.yi59@zte.com.cn)
Received: from mapi (szxlzmapp02[null]) by mapi (Zmail) with MAPI id mid14;
 Tue, 11 Jan 2022 15:09:40 +0800 (CST)
Date: Tue, 11 Jan 2022 15:09:40 +0800 (CST)
X-Zmail-TransId: 2b0461dd2d3495c83906
X-Mailer: Zmail v1.0
Message-ID: <202201111509409733901@zte.com.cn>
In-Reply-To: <CACGkMEvdKATVvLVQtfPfSeev83Ajskg4gFoHDhWT7wrWEQ3FEA@mail.gmail.com>
References: 20211224070404.54840-1-wang.yi59@zte.com.cn,
 CACGkMEvdKATVvLVQtfPfSeev83Ajskg4gFoHDhWT7wrWEQ3FEA@mail.gmail.com
Mime-Version: 1.0
From: <wang.yi59@zte.com.cn>
To: <jasowang@redhat.com>
Subject: =?UTF-8?B?UmU6W1BBVENIIHYyXSB2ZHBhOiByZWdpc3Qgdmhvc3QtdmRwYSBkZXYgY2xhc3M=?=
X-MAIL: mse-fl1.zte.com.cn 20B79fBY066368
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID
 61DD2D41.000 by FangMail milter!
X-FangMail-Envelope: 1641884993/4JY1zP3Nwmz83Lwn/61DD2D41.000/10.30.14.238/[10.30.14.238]/mse-fl1.zte.com.cn/<wang.yi59@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 61DD2D41.000/4JY1zP3Nwmz83Lwn
Cc: zhang.min9@zte.com.cn, wang.liang82@zte.com.cn, kvm@vger.kernel.org,
 mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xue.zhihong@zte.com.cn
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

Hi Jason,
> On Fri, Dec 24, 2021 at 3:13 PM Yi Wangwrote:
> >
> > From: Zhang Min
> >
> > Some applications like kata-containers need to acquire MAJOR/MINOR/DEVNAME
> > for devInfo [1], so regist vhost-vdpa dev class to expose uevent.
>
> Hi:
>
> I think we need to be more verbose here e.g:
>
> 1) why can't we get major/minor with the current interface

Although major/minor can be acquired in /sys/bus/vdpa/devices/vdpa0/vhost-vdpa/vhost-vdpa-0/dev,
applications like kata-containers prefer and actually have tried to obtain them
in /sys/class/vhost-vdpa/vhost-vdpa-0/uevent, such like [1].

> 2) what kind of the uevent is required and not supported currently

The items needed show in uevent are MAJOR MINOR DEVNAME that vhost_vdpa_probe
currently has registed, but dev_uevent_filter failed to pass and uevent show is
empty now, so we regist dev class to let dev_uevent_filter pass and show them.

1. https://github.com/kata-containers/kata-containers/blob/main/src/runtime/virtcontainers/device/config/config.go

>
> Thanks
>
> >
> > 1. https://github.com/kata-containers/kata-containers/blob/main/src/runtime/virtcontainers/device/config/config.go
> >
> > Signed-off-by: Zhang Min
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
