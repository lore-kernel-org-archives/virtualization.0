Return-Path: <SRS0=u9Em=C2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849F4C433E2
	for <virtualization@archiver.kernel.org>; Thu, 17 Sep 2020 15:21:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8E120708
	for <virtualization@archiver.kernel.org>; Thu, 17 Sep 2020 15:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=st.com header.i=@st.com header.b="1THMI8w4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8E120708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 884E8874CD;
	Thu, 17 Sep 2020 15:21:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qrTg9J5VsKGI; Thu, 17 Sep 2020 15:21:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0F107873B5;
	Thu, 17 Sep 2020 15:21:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECE81C0888;
	Thu, 17 Sep 2020 15:21:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD5DEC0859
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 15:21:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9682087868
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 15:21:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9wVQITka14B5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 15:21:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E38108746C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 15:21:16 +0000 (UTC)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08HF6nd0014345; Thu, 17 Sep 2020 17:21:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=dc3oSM8XDCtcc+k2l3MnhFKjEOsvwqsYwIC+PfUHgMc=;
 b=1THMI8w4ah0GjXsZ4mZ6cly4M5BkG199hkLyscfaRB78hhA5Opv33a5LLmiz/Y2/O0fJ
 XKThjgcxwRwbbyi9llKF8JbW2opVwpqGOUFcMLkzCTh4EBehjMRMgISWhTARkYCpl01m
 r3d2N7E8HD/5VvKvfK/8IZE28uJFMA8vDEdPBa3FwC14teTQSgzzfBEX9XC/y8lOXCcB
 C3K/QBSXlPcuwfiOBPjCD26YMrcktvRIPiccxU3fRPKg9Eev+3/77FMvKF2ulwQJEgkz
 XiEYoS6zCn9oG6ern81BPv5Un5E8SA0NQWIKomhUP9H2FO/R+n/d+N3o5NfgnSjQ86+C /Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 33k67bufvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2020 17:21:06 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6FCA410002A;
 Thu, 17 Sep 2020 17:21:04 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1E9682BF9AC;
 Thu, 17 Sep 2020 17:21:04 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.47) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 17:21:02 +0200
Subject: RE: [PATCH v6 0/4] Add a vhost RPMsg API
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
References: <20200901151153.28111-1-guennadi.liakhovetski@linux.intel.com>
 <9433695b-5757-db73-bd8a-538fd1375e2a@st.com> <20200917054705.GA11491@ubuntu>
From: Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <47a9ad01-c922-3b1c-84de-433f229ffba3@st.com>
Date: Thu, 17 Sep 2020 17:21:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917054705.GA11491@ubuntu>
Content-Language: en-US
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-17_10:2020-09-16,
 2020-09-17 signatures=0
Cc: Ohad Ben-Cohen <ohad@wizery.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "sound-open-firmware@alsa-project.org" <sound-open-firmware@alsa-project.org>
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

Hi Guennadi,

> -----Original Message-----
> From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> Sent: jeudi 17 septembre 2020 07:47
> To: Arnaud POULIQUEN <arnaud.pouliquen@st.com>
> Cc: kvm@vger.kernel.org; linux-remoteproc@vger.kernel.org;
> virtualization@lists.linux-foundation.org; sound-open-firmware@alsa-
> project.org; Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>; Liam
> Girdwood <liam.r.girdwood@linux.intel.com>; Michael S. Tsirkin
> <mst@redhat.com>; Jason Wang <jasowang@redhat.com>; Ohad Ben-Cohen
> <ohad@wizery.com>; Bjorn Andersson <bjorn.andersson@linaro.org>; Mathieu
> Poirier <mathieu.poirier@linaro.org>; Vincent Whitchurch
> <vincent.whitchurch@axis.com>
> Subject: Re: [PATCH v6 0/4] Add a vhost RPMsg API
> 
> Hi Arnaud,
> 
> On Tue, Sep 15, 2020 at 02:13:23PM +0200, Arnaud POULIQUEN wrote:
> > Hi  Guennadi,
> >
> > On 9/1/20 5:11 PM, Guennadi Liakhovetski wrote:
> > > Hi,
> > >
> > > Next update:
> > >
> > > v6:
> > > - rename include/linux/virtio_rpmsg.h ->
> > > include/linux/rpmsg/virtio.h
> > >
> > > v5:
> > > - don't hard-code message layout
> > >
> > > v4:
> > > - add endianness conversions to comply with the VirtIO standard
> > >
> > > v3:
> > > - address several checkpatch warnings
> > > - address comments from Mathieu Poirier
> > >
> > > v2:
> > > - update patch #5 with a correct vhost_dev_init() prototype
> > > - drop patch #6 - it depends on a different patch, that is currently
> > >   an RFC
> > > - address comments from Pierre-Louis Bossart:
> > >   * remove "default n" from Kconfig
> > >
> > > Linux supports RPMsg over VirtIO for "remote processor" / AMP use
> > > cases. It can however also be used for virtualisation scenarios,
> > > e.g. when using KVM to run Linux on both the host and the guests.
> > > This patch set adds a wrapper API to facilitate writing vhost
> > > drivers for such RPMsg-based solutions. The first use case is an
> > > audio DSP virtualisation project, currently under development, ready
> > > for review and submission, available at
> > > https://github.com/thesofproject/linux/pull/1501/commits
> >
> > Mathieu pointed me your series. On my side i proposed the rpmsg_ns_msg
> > service[1] that does not match with your implementation.
> > As i come late, i hope that i did not miss something in the history...
> > Don't hesitate to point me the discussions, if it is the case.
> 
> Well, as you see, this is a v6 only of this patch set, and apart from it there have
> been several side discussions and patch sets.
> 
> > Regarding your patchset, it is quite confusing for me. It seems that
> > you implement your own protocol on top of vhost forked from the RPMsg
> one.
> > But look to me that it is not the RPMsg protocol.
> 
> I'm implementing a counterpart to the rpmsg protocol over VirtIO as initially
> implemented by drivers/rpmsg/virtio_rpmsg_bus.c for the "main CPU" (in case
> of remoteproc over VirtIO) or the guest side in case of Linux virtualisation.
> Since my implementation can talk to that driver, I don't think, that I'm inventing
> a new protocol. I'm adding support for the same protocol for the opposite side
> of the VirtIO divide.

The main point I would like to highlight here is related to the use of the name "RPMsg"
more than how you implement your IPC protocol.
If It is a counterpart, it probably does not respect interface for RPMsg clients.
A good way to answer this, might be to respond to this question:
Is the rpmsg sample client[4] can be used on top of your vhost RPMsg implementation?
If the response is no, describe it as a RPMsg implementation could lead to confusion...

[4] https://elixir.bootlin.com/linux/v5.9-rc5/source/samples/rpmsg/rpmsg_client_sample.c

Regards,
Arnaud

> 
> > So i would be agree with Vincent[2] which proposed to switch on a
> > RPMsg API and creating a vhost rpmsg device. This is also proposed in
> > the "Enhance VHOST to enable SoC-to-SoC communication" RFC[3].
> > Do you think that this alternative could match with your need?
> 
> As I replied to Vincent, I understand his proposal and the approach taken in the
> series [3], but I'm not sure I agree, that adding yet another virtual device /
> driver layer on the vhost side is a good idea. As far as I understand adding new
> completely virtual devices isn't considered to be a good practice in the kernel.
> Currently vhost is just a passive "library"
> and my vhost-rpmsg support keeps it that way. Not sure I'm in favour of
> converting vhost to a virtual device infrastructure.
> 
> Thanks for pointing me out at [3], I should have a better look at it.
> 
> Thanks
> Guennadi
> 
> > [1].
> > https://patchwork.kernel.org/project/linux-remoteproc/list/?series=338
> > 335 [2].
> > https://www.spinics.net/lists/linux-virtualization/msg44195.html
> > [3]. https://www.spinics.net/lists/linux-remoteproc/msg06634.html
> >
> > Thanks,
> > Arnaud
> >
> > >
> > > Thanks
> > > Guennadi
> > >
> > > Guennadi Liakhovetski (4):
> > >   vhost: convert VHOST_VSOCK_SET_RUNNING to a generic ioctl
> > >   rpmsg: move common structures and defines to headers
> > >   rpmsg: update documentation
> > >   vhost: add an RPMsg API
> > >
> > >  Documentation/rpmsg.txt          |   6 +-
> > >  drivers/rpmsg/virtio_rpmsg_bus.c |  78 +------
> > >  drivers/vhost/Kconfig            |   7 +
> > >  drivers/vhost/Makefile           |   3 +
> > >  drivers/vhost/rpmsg.c            | 373 +++++++++++++++++++++++++++++++
> > >  drivers/vhost/vhost_rpmsg.h      |  74 ++++++
> > >  include/linux/rpmsg/virtio.h     |  83 +++++++
> > >  include/uapi/linux/rpmsg.h       |   3 +
> > >  include/uapi/linux/vhost.h       |   4 +-
> > >  9 files changed, 551 insertions(+), 80 deletions(-)  create mode
> > > 100644 drivers/vhost/rpmsg.c  create mode 100644
> > > drivers/vhost/vhost_rpmsg.h  create mode 100644
> > > include/linux/rpmsg/virtio.h
> > >
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
