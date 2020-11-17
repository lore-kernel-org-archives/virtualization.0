Return-Path: <SRS0=We/I=EX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F40C2D0E4
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 14:01:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D71C206F1
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 14:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=st.com header.i=@st.com header.b="PV53Thje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D71C206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D320B87008;
	Tue, 17 Nov 2020 14:00:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zHMEivEwPj5n; Tue, 17 Nov 2020 14:00:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C0C5986FFE;
	Tue, 17 Nov 2020 14:00:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A23ADC0800;
	Tue, 17 Nov 2020 14:00:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A160C07FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:00:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6AE8C2011A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:00:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q-b9M5j7Ldj6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:00:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 by silver.osuosl.org (Postfix) with ESMTPS id 9FD3C1FF98
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:00:53 +0000 (UTC)
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0AHDvZEd013952; Tue, 17 Nov 2020 15:00:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=jVvnEkcOSvoJYeMhxUbGozS73QUI6vmOLenEHz6g06g=;
 b=PV53Thje8eJpmKTSC2cAgUMoiFddEJyTaK/9fQINegu38IY7vRUIFI0+oEQe68cMI19o
 Sq0f0SLQjhlUsmSD+LIZZifim2jYCFDLswqi0OzPFQIYcctRMVMRdNA4aRlEaF6etNL6
 om7jCXTF4P6+fjNI71mjOhxaQb7u9tfLlzuOXpY0hkmKrDO3FakqSr+uMS97yfZhTJBU
 qdGO1kpKnzVIvhYuraB8vl/ADVgs3oBq5KeRoFRGqx+H0ISWPgh7U8Y80fVgiz0/rhq5
 VWxIq646yI60DUdZtJNOVZZDWG0th1TDV7SPU4tFiORSQJ024rKEZgwJbZ1UJ2J9dpOF hw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 34t5k51mxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2020 15:00:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AA2FB10002A;
 Tue, 17 Nov 2020 15:00:33 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6DD5B205D19;
 Tue, 17 Nov 2020 15:00:33 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.47) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Nov
 2020 15:00:32 +0100
Subject: Re: [PATCH virtio] virtio: virtio_console: fix DMA memory allocation
 for rproc serial
To: Christoph Hellwig <hch@infradead.org>
References: <AOKowLclCbOCKxyiJ71WeNyuAAj2q8EUtxrXbyky5E@cp7-web-042.plabs.ch>
 <20201116091950.GA30524@infradead.org>
 <ca183081-5a9f-0104-bf79-5fea544c9271@st.com>
 <20201116162844.GB16619@infradead.org> <20201116163907.GA19209@infradead.org>
From: Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <79d2eb78-caad-9c0d-e130-51e628cedaaa@st.com>
Date: Tue, 17 Nov 2020 15:00:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201116163907.GA19209@infradead.org>
Content-Language: en-US
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-17_03:2020-11-17,
 2020-11-17 signatures=0
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Arnd Bergmann <arnd@arndb.de>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Amit Shah <amit@kernel.org>,
 Alexander Lobakin <alobakin@pm.me>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Suman Anna <s-anna@ti.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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



On 11/16/20 5:39 PM, Christoph Hellwig wrote:
> Btw, I also still don't understand why remoteproc is using
> dma_declare_coherent_memory to start with.  The virtio code has exactly
> one call to dma_alloc_coherent vring_alloc_queue, a function that
> already switches between two different allocators.  Why can't we just
> add a third allocator specifically for these remoteproc memory carveouts
> and bypass dma_declare_coherent_memory entirely?
> 

The dma_declare_coherent_memory allows to associate vdev0buffer memory region
to the remoteproc virtio device (vdev parent). This region is used to allocated
the rpmsg buffers.
The memory for the rpmsg buffer is allocated by the rpmsg_virtio device in
rpmsg_virtio_bus[1]. The size depends on the total size needed for the rpmsg
buffers.

The vrings are allocated directly by the remoteproc device.

[1]
https://elixir.bootlin.com/linux/v5.10-rc3/source/drivers/rpmsg/virtio_rpmsg_bus.c#L925
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
