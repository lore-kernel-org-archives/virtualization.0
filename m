Return-Path: <SRS0=LX6v=GL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD526C433E6
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 13:33:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E71C235FF
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 13:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E71C235FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E15D38730D;
	Fri,  8 Jan 2021 13:33:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SbLKdUfVZO4Y; Fri,  8 Jan 2021 13:33:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EB2E8872ED;
	Fri,  8 Jan 2021 13:33:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF7E3C088B;
	Fri,  8 Jan 2021 13:33:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BAD9C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 13:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 23028872ED
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 13:33:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aapxxvMqXtww
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 13:33:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A8A8887034
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 13:33:17 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 108DPdUd109883;
 Fri, 8 Jan 2021 13:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=S4zkW1M4aTxRNcJblTq8nmnAoFttecuVr7DB3iYS6lc=;
 b=u43BWw/YI46k+PZDdz6WgFXEaetk1U74Zlf6i1GzYDfBCjp2TclctQZfEm69hfePQ3lF
 cLN/e1XxgUS2OeTwOaaTys0uRP1vUFZEKV3i/6tXp/NaKhytTrPuVZ8wiGwQCbSUbxys
 P60h0XHWLot0qHkXh9mVOxr89HvQ6nVgMAvA+OPttZmzmXyf+fgt3zfqNS5eqXGIFtig
 uyVdf/PpYc/lmKRfaqoHjE5emwYXEjn20lwGfJZRlhSkp6SrMtJaxZ1JWh9NwbiwE/Ov
 FjYEbhHZEolr0NNoVTS9y8SvZnd50yp4LcmRpMM97dXdvLPbhRCG7O4hC+MoKZ+oUAW+ Rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 35wepmh24m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 08 Jan 2021 13:32:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 108DKYVC100966;
 Fri, 8 Jan 2021 13:32:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 35v4rfafy5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Jan 2021 13:32:42 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 108DWXDO026007;
 Fri, 8 Jan 2021 13:32:33 GMT
Received: from [192.168.1.6] (/116.231.20.68)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 08 Jan 2021 13:32:33 +0000
Subject: Re: [RFC v2 06/13] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com, jasowang@redhat.com, 
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 akpm@linux-foundation.org, rdunlap@infradead.org, willy@infradead.org,
 viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org, corbet@lwn.net
References: <20201222145221.711-1-xieyongji@bytedance.com>
 <20201222145221.711-7-xieyongji@bytedance.com>
From: Bob Liu <bob.liu@oracle.com>
Message-ID: <f8dcb8d0-0024-1f78-d1a7-e487ca3deda7@oracle.com>
Date: Fri, 8 Jan 2021 21:32:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201222145221.711-7-xieyongji@bytedance.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1011 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080076
Cc: linux-aio@kvack.org, kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
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

On 12/22/20 10:52 PM, Xie Yongji wrote:
> This VDUSE driver enables implementing vDPA devices in userspace.
> Both control path and data path of vDPA devices will be able to
> be handled in userspace.
> 
> In the control path, the VDUSE driver will make use of message
> mechnism to forward the config operation from vdpa bus driver
> to userspace. Userspace can use read()/write() to receive/reply
> those control messages.
> 
> In the data path, the VDUSE driver implements a MMU-based on-chip
> IOMMU driver which supports mapping the kernel dma buffer to a
> userspace iova region dynamically. Userspace can access those
> iova region via mmap(). Besides, the eventfd mechanism is used to
> trigger interrupt callbacks and receive virtqueue kicks in userspace
> 
> Now we only support virtio-vdpa bus driver with this patch applied.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  Documentation/driver-api/vduse.rst                 |   74 ++
>  Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
>  drivers/vdpa/Kconfig                               |    8 +
>  drivers/vdpa/Makefile                              |    1 +
>  drivers/vdpa/vdpa_user/Makefile                    |    5 +
>  drivers/vdpa/vdpa_user/eventfd.c                   |  221 ++++
>  drivers/vdpa/vdpa_user/eventfd.h                   |   48 +
>  drivers/vdpa/vdpa_user/iova_domain.c               |  442 ++++++++
>  drivers/vdpa/vdpa_user/iova_domain.h               |   93 ++
>  drivers/vdpa/vdpa_user/vduse.h                     |   59 ++
>  drivers/vdpa/vdpa_user/vduse_dev.c                 | 1121 ++++++++++++++++++++
>  include/uapi/linux/vdpa.h                          |    1 +
>  include/uapi/linux/vduse.h                         |   99 ++
>  13 files changed, 2173 insertions(+)
>  create mode 100644 Documentation/driver-api/vduse.rst
>  create mode 100644 drivers/vdpa/vdpa_user/Makefile
>  create mode 100644 drivers/vdpa/vdpa_user/eventfd.c
>  create mode 100644 drivers/vdpa/vdpa_user/eventfd.h
>  create mode 100644 drivers/vdpa/vdpa_user/iova_domain.c
>  create mode 100644 drivers/vdpa/vdpa_user/iova_domain.h
>  create mode 100644 drivers/vdpa/vdpa_user/vduse.h
>  create mode 100644 drivers/vdpa/vdpa_user/vduse_dev.c
>  create mode 100644 include/uapi/linux/vduse.h
> 
> diff --git a/Documentation/driver-api/vduse.rst b/Documentation/driver-api/vduse.rst
> new file mode 100644
> index 000000000000..da9b3040f20a
> --- /dev/null
> +++ b/Documentation/driver-api/vduse.rst
> @@ -0,0 +1,74 @@
> +==================================
> +VDUSE - "vDPA Device in Userspace"
> +==================================
> +
> +vDPA (virtio data path acceleration) device is a device that uses a
> +datapath which complies with the virtio specifications with vendor
> +specific control path. vDPA devices can be both physically located on
> +the hardware or emulated by software. VDUSE is a framework that makes it
> +possible to implement software-emulated vDPA devices in userspace.
> +

Could you explain a bit more why need a VDUSE framework?
Software emulated vDPA devices is more likely used by debugging only when
don't have real hardware.
Do you think do the emulation in kernel space is not enough?

Thanks,
Bob

> +How VDUSE works
> +------------
> +Each userspace vDPA device is created by the VDUSE_CREATE_DEV ioctl on
> +the VDUSE character device (/dev/vduse). Then a file descriptor pointing
> +to the new resources will be returned, which can be used to implement the
> +userspace vDPA device's control path and data path.
> +
> +To implement control path, the read/write operations to the file descriptor
> +will be used to receive/reply the control messages from/to VDUSE driver.
> +Those control messages are based on the vdpa_config_ops which defines a
> +unified interface to control different types of vDPA device.
> +


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
