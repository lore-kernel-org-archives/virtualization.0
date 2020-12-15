Return-Path: <SRS0=Oc7+=FT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DCAC4361B
	for <virtualization@archiver.kernel.org>; Tue, 15 Dec 2020 14:35:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D2A207AD
	for <virtualization@archiver.kernel.org>; Tue, 15 Dec 2020 14:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D2A207AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5BBF586988;
	Tue, 15 Dec 2020 14:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dO1Gv7QDHV8P; Tue, 15 Dec 2020 14:35:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F403F868A4;
	Tue, 15 Dec 2020 14:35:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8B0BC0893;
	Tue, 15 Dec 2020 14:35:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36BEAC013B;
 Tue, 15 Dec 2020 14:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2F92C868A4;
 Tue, 15 Dec 2020 14:35:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b9pS2ra+oUmP; Tue, 15 Dec 2020 14:35:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E7A6C86833;
 Tue, 15 Dec 2020 14:35:40 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFETgLj184657;
 Tue, 15 Dec 2020 14:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=d+hWdLWQC22vSxV2iPJWhnu2WrFAwrEzioZFIsCEB2w=;
 b=rujV94qs73yfJhxZtX9YxGAGFOD5zT64JPjmJKpWxzGlachvp/MB0BVZq+YaVADdCVPS
 I5M4PBQCQpUuP0ha/F0uo2QT/BvQehedHmBqlVk7FKNeqYkwfeCFr9AIcbVGZxzkUeUS
 20vrwviFx3wDPCN+cUwXfOZ3QIjS7qQOIJG9Q3Z9ZTpuxC7J158w8wdgQUTNZRUbQYeZ
 lspVezSJgquB4eMylrgt8FRmRRjpBU+MkIjniY/CWBUF/psCQRjsedH598xLLkEIRdMh
 lYaFxQh32Jm/yWA3UWMnVjy465ky9hCfA12SIMgXscchODcVYCI7XXT6xyqD4ollJMrr fA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 35ckcbb0ca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Dec 2020 14:35:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFEUA8x183783;
 Tue, 15 Dec 2020 14:35:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 35d7sw9m4w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Dec 2020 14:35:31 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BFEZT0I019469;
 Tue, 15 Dec 2020 14:35:29 GMT
Received: from char.us.oracle.com (/10.152.32.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 15 Dec 2020 06:35:28 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
 id 7443F6A00F4; Tue, 15 Dec 2020 09:37:34 -0500 (EST)
Date: Tue, 15 Dec 2020 09:37:34 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Felicitas Hetzelt <file@sect.tu-berlin.de>, baolu.lu@linux.intel.com
Subject: Re: swiotlb/virtio: unchecked device dma address and length
Message-ID: <20201215143734.GC28810@char.us.oracle.com>
References: <d2ae0b1d-332b-42a1-87bf-7da2b749cac2@sect.tu-berlin.de>
 <20201214214950.GC18103@char.us.oracle.com>
 <20201215084720.GA9981@ashkalra_ubuntu_server>
 <c90f5ea4-b8b2-98d7-546a-dc71fb618230@sect.tu-berlin.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c90f5ea4-b8b2-98d7-546a-dc71fb618230@sect.tu-berlin.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9835
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9835
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150104
Cc: Thomas.Lendacky@amd.com, Ashish Kalra <ashish.kalra@amd.com>,
 brijesh.singh@amd.com, "Radev, Martin" <martin.radev@aisec.fraunhofer.de>,
 david.kaplan@amd.com, "Michael S. Tsirkin" <mst@redhat.com>, Jon.Grimm@amd.com,
 virtualization@lists.linux-foundation.org,
 Robert Buhren <robert@sect.tu-berlin.de>, iommu@lists.linux-foundation.org,
 "Morbitzer, Mathias" <mathias.morbitzer@aisec.fraunhofer.de>, hch@lst.de
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

On Tue, Dec 15, 2020 at 11:54:08AM +0100, Felicitas Hetzelt wrote:
> Hello,
> thank you all for looking into this! To answer some of the questions:
>  - Did you have already some PoC fixes for this:
>    We don't have a full PoC or fix currently. Thought we have a PoC
>    with which were able to overwrite memory outside of the mapped
>    dma region.
>  - Is there a CVE associated with this?
>    No
>  - Is there a paper on this you all are working on?
>    Yes, we were planning to use this bug (among others
>    in a paper)
> 
> Could you point us to the intel thunder issue that you mentioned?

ThunderClap was it!

https://lwn.net/Articles/786558/

Cc-ing Lu Baolu ..

Hm, this was a year ago and it looks like there are some extra SWIOTLB
patches to be done ?

> 
> On 12/15/20 9:47 AM, Ashish Kalra wrote:
> > On Mon, Dec 14, 2020 at 04:49:50PM -0500, Konrad Rzeszutek Wilk wrote:
> >> On Fri, Dec 11, 2020 at 06:31:21PM +0100, Felicitas Hetzelt wrote:
> >>> Hello,
> >>
> >> Hi! Please see below my responses.
> >>
> >>> we have been analyzing the Hypervisor-OS interface of Linux
> >>> and discovered bugs in the swiotlb/virtio implementation that can be
> >>> triggered from a malicious Hypervisor / virtual device.
> >>> With SEV, the SWIOTLB implementation is forcefully enabled and would
> >>> always be used. Thus, all virtio devices and others would use it under
> >>> the hood.
> >>>
> >>> The reason for analyzing this interface is that, technologies such as
> >>> Intel's Trusted Domain Extensions [1] and AMD's Secure Nested Paging [2]
> >>> change the threat model assumed by various Linux kernel subsystems.
> >>> These technologies take the presence of a fully malicious hypervisor
> >>> into account and aim to provide protection for virtual machines in such
> >>> an environment. Therefore, all input received from the hypervisor or an
> >>> external device should be carefully validated. Note that these issues
> >>> are of little (or no) relevance in a "normal" virtualization setup,
> >>> nevertheless we believe that it is required to fix them if TDX or SNP is
> >>> used.
> >>>
> >>> We are happy to provide more information if needed!
> >>>
> >>> [1]
> >>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsoftware.intel.com%2Fcontent%2Fwww%2Fus%2Fen%2Fdevelop%2Farticles%2Fintel-trust-domain-extensions.html&amp;data=04%7C01%7Cashish.kalra%40amd.com%7C1d1cbca182a84c0e504708d8a079eec0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637435792867090126%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=THAJlYGLSOx3bKQYH62TLKH50By7Wnsu0z92snfNY84%3D&amp;reserved=0
> >>>
> >>> [2] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.amd.com%2Fen%2Fprocessors%2Famd-secure-encrypted-virtualization&amp;data=04%7C01%7Cashish.kalra%40amd.com%7C1d1cbca182a84c0e504708d8a079eec0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637435792867090126%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=M3jmYCWaEvmAzIy%2F4z5XstsPf812SbEkuNX5PVVr0HY%3D&amp;reserved=0
> >>>
> >>> Bug:
> >>> OOB memory write.
> >>> dma_unmap_single -> swiotlb_tbl_unmap_single is invoked with dma_addr
> >>> and length parameters that are under control of the device.
> >>> This happens e.g. in virtio_ring:
> >>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.10-rc7%2Fsource%2Fdrivers%2Fvirtio%2Fvirtio_ring.c%23L378&amp;data=04%7C01%7Cashish.kalra%40amd.com%7C1d1cbca182a84c0e504708d8a079eec0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637435792867090126%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=j0CIi%2F8hBkVx45XGBtT4Ri52uWIOdOts%2BSbJ0kCB5B0%3D&amp;reserved=0
> >>
> >> Heya!
> >>
> >> Thank you for pointing this out! I've a couple of questions and hope you can
> >> help me out with them.
> >>
> >> Also CC-ing AMD / TDX folks.
> >>>
> > 
> > Adding more relevant folks in AMD.
> > 
> > Needless to say, the swiotlb code needs to validate this external untrusted input dma_addr and length parameters.
> > 
> > Thanks,
> > Ashish
> > 
> >>> This raises two issues:
> >>> 1) swiotlb_tlb_unmap_single fails to check whether the index generated
> >>> from the dma_addr is in range of the io_tlb_orig_addr array.
> >>
> >> That is fairly simple to implement I would think. That is it can check
> >> that the dma_addr is from the PA in the io_tlb pool when SWIOTLB=force
> >> is used.
> >>
> >>> 2) when swiotlb_bounce is called the device controls the length of the
> >>> memory copied to the cpu address.
> >>
> >> So.. this sounds very similar to the Intel Thunder.. something issue
> >> where this exact issue was fixed by handing the DMA off to the SWIOTLB
> >> bounce code.
> >>
> >> But if that is broken, then that CVE is still not fixed?
> >>
> >> So the issue here is that swiotlb_tbl_unmap_single(..,mapping_size,) is
> >> under the attacker control. Ugh.
> >>
> >> One way could be to have a io_tlb_orig_addr-ish array with the length
> >> of mappings to double check?
> >>
> >> Couple more questions:
> >>  - Did you have already some PoC fixes for this? 
> >>  - Is there a CVE associated with this?
> >>  - Is there a paper on this you all are working on?
> >>
> >> Thank you!
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
