Return-Path: <SRS0=0lGn=FS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE9BC2BB40
	for <virtualization@archiver.kernel.org>; Mon, 14 Dec 2020 21:48:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF5120798
	for <virtualization@archiver.kernel.org>; Mon, 14 Dec 2020 21:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF5120798
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BC5228769A;
	Mon, 14 Dec 2020 21:48:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7u9MsBXP0aHI; Mon, 14 Dec 2020 21:48:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0062387699;
	Mon, 14 Dec 2020 21:48:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D313DC088E;
	Mon, 14 Dec 2020 21:48:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3CCBC013B;
 Mon, 14 Dec 2020 21:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9B1028762F;
 Mon, 14 Dec 2020 21:48:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vYFTs+0uPbnL; Mon, 14 Dec 2020 21:48:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D7B508762E;
 Mon, 14 Dec 2020 21:48:05 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BELdbB7100596;
 Mon, 14 Dec 2020 21:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=tNGcg/rZk4xJbneWDqbv2YPLOeYkzQb4eLkWEHfzmZ0=;
 b=vSwtOhnBEOYP6JIt1mLvGzawcMjRfP32wfuo2smEc/C4QBEaK7NiGQPI+Uiu6nSim3m9
 ZiIEZ2j+fUk2WMtuiFTp5ZqsUuIHIDpE5FZXrNzmb5xnSfKK3kxx92VvMoJWweneP4jV
 Wp068EttEZ7OP7p2IZsAHcrLzw5p4jhCkDRyuIzLum+fwr+Nsb5EBx3USL2le6tIWTN8
 2Ja1zTOlkkD5U5HmUO1MtIJSi4zQ8J3ViZ5mxHzz9hFlyItzsjbRLPHDKsaUZWw3cL4W
 ScxeYe6lZPmUfYBYQUTLbU45czOeNfYQVI9chXvDThmnVlA/dOgO2JpupgElbeNF1BUV RA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 35cntkykcd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Dec 2020 21:47:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BELe5Xv079388;
 Mon, 14 Dec 2020 21:47:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 35d7sv4mgt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Dec 2020 21:47:55 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BELlkv0022618;
 Mon, 14 Dec 2020 21:47:50 GMT
Received: from char.us.oracle.com (/10.152.32.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 14 Dec 2020 13:47:46 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
 id 402D46A00F4; Mon, 14 Dec 2020 16:49:50 -0500 (EST)
Date: Mon, 14 Dec 2020 16:49:50 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Felicitas Hetzelt <file@sect.tu-berlin.de>, ashish.kalra@amd.com,
 jun.nakajima@intel.com, hch@lst.de
Subject: Re: swiotlb/virtio: unchecked device dma address and length
Message-ID: <20201214214950.GC18103@char.us.oracle.com>
References: <d2ae0b1d-332b-42a1-87bf-7da2b749cac2@sect.tu-berlin.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d2ae0b1d-332b-42a1-87bf-7da2b749cac2@sect.tu-berlin.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9835
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012140143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9835
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012140143
Cc: "Radev, Martin" <martin.radev@aisec.fraunhofer.de>, david.kaplan@amd.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Robert Buhren <robert@sect.tu-berlin.de>, iommu@lists.linux-foundation.org,
 "Morbitzer, Mathias" <mathias.morbitzer@aisec.fraunhofer.de>
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

On Fri, Dec 11, 2020 at 06:31:21PM +0100, Felicitas Hetzelt wrote:
> Hello,

Hi! Please see below my responses.

> we have been analyzing the Hypervisor-OS interface of Linux
> and discovered bugs in the swiotlb/virtio implementation that can be
> triggered from a malicious Hypervisor / virtual device.
> With SEV, the SWIOTLB implementation is forcefully enabled and would
> always be used. Thus, all virtio devices and others would use it under
> the hood.
> 
> The reason for analyzing this interface is that, technologies such as
> Intel's Trusted Domain Extensions [1] and AMD's Secure Nested Paging [2]
> change the threat model assumed by various Linux kernel subsystems.
> These technologies take the presence of a fully malicious hypervisor
> into account and aim to provide protection for virtual machines in such
> an environment. Therefore, all input received from the hypervisor or an
> external device should be carefully validated. Note that these issues
> are of little (or no) relevance in a "normal" virtualization setup,
> nevertheless we believe that it is required to fix them if TDX or SNP is
> used.
> 
> We are happy to provide more information if needed!
> 
> [1]
> https://software.intel.com/content/www/us/en/develop/articles/intel-trust-domain-extensions.html
> 
> [2] https://www.amd.com/en/processors/amd-secure-encrypted-virtualization
> 
> Bug:
> OOB memory write.
> dma_unmap_single -> swiotlb_tbl_unmap_single is invoked with dma_addr
> and length parameters that are under control of the device.
> This happens e.g. in virtio_ring:
> https://elixir.bootlin.com/linux/v5.10-rc7/source/drivers/virtio/virtio_ring.c#L378

Heya!

Thank you for pointing this out! I've a couple of questions and hope you can
help me out with them.

Also CC-ing AMD / TDX folks.
> 
> This raises two issues:
> 1) swiotlb_tlb_unmap_single fails to check whether the index generated
> from the dma_addr is in range of the io_tlb_orig_addr array.

That is fairly simple to implement I would think. That is it can check
that the dma_addr is from the PA in the io_tlb pool when SWIOTLB=force
is used.

> 2) when swiotlb_bounce is called the device controls the length of the
> memory copied to the cpu address.

So.. this sounds very similar to the Intel Thunder.. something issue
where this exact issue was fixed by handing the DMA off to the SWIOTLB
bounce code.

But if that is broken, then that CVE is still not fixed?

So the issue here is that swiotlb_tbl_unmap_single(..,mapping_size,) is
under the attacker control. Ugh.

One way could be to have a io_tlb_orig_addr-ish array with the length
of mappings to double check?

Couple more questions:
 - Did you have already some PoC fixes for this? 
 - Is there a CVE associated with this?
 - Is there a paper on this you all are working on?

Thank you!
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
