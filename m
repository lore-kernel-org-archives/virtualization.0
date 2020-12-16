Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB81C4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 13:05:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A1723357
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 13:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A1723357
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 95323227AA;
	Wed, 16 Dec 2020 13:05:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id so-hqqKsWSy4; Wed, 16 Dec 2020 13:04:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2D972227DB;
	Wed, 16 Dec 2020 13:04:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E66FFC1D9F;
	Wed, 16 Dec 2020 13:04:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AC36C013B;
 Wed, 16 Dec 2020 13:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 853B984E74;
 Wed, 16 Dec 2020 13:04:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n-4L0-zmL9SW; Wed, 16 Dec 2020 13:04:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 887CA84E5F;
 Wed, 16 Dec 2020 13:04:50 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGD3ttB123365;
 Wed, 16 Dec 2020 13:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding :
 subject : to : cc : from : message-id; s=corp-2020-01-29;
 bh=ip3E0wXdiprHZ/4Ozz7KCIciubqnmFxqd3y8ROMIgt8=;
 b=WvAKdtojUJOz3v/SW1mXM2pFoOByaEWl2vhtO+zsHmETOH9Wf48dYiPRObPNYb+K7VHw
 wm1RDF0DE04WRlSX/KiP67TmiRbv7dUj7akl7jTpyUBZessx9a5u3M/m4HN0HYpT1CrC
 O3tuG14X/8wJxh58GRV4Xfa0Oe76LShm0f2iYHl1Lzct5ZZv4f1LsHy9xTE7v6IUnmer
 A1gewtgREbmhEb5Z+bOEy2Ot0nXcqfpoRN1QZMo1tqXsChpH1XWwKyBJjkFqBg7wskz5
 Bi/JCUsGtrGX6J5f7gWPy299+BuT+4gLKCT8djUxCl0ruVk6xMk1f6kElVj04nB6Gw4H 9w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 35ckcbg4fn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Dec 2020 13:04:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGD19kb084714;
 Wed, 16 Dec 2020 13:04:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 35e6erv40r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Dec 2020 13:04:41 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BGD4Zk2019221;
 Wed, 16 Dec 2020 13:04:37 GMT
Received: from [192.168.86.39] (/209.6.208.110)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 16 Dec 2020 05:04:35 -0800
Date: Wed, 16 Dec 2020 08:04:32 -0500
User-Agent: K-9 Mail for Android
In-Reply-To: <613214145.36646222.1608100908658.JavaMail.zimbra@redhat.com>
References: <d2ae0b1d-332b-42a1-87bf-7da2b749cac2@sect.tu-berlin.de>
 <20201214214950.GC18103@char.us.oracle.com>
 <c3629a27-3590-1d9f-211b-c0b7be152b32@redhat.com>
 <20201215142755.GB28810@char.us.oracle.com>
 <1330503106.36174346.1608098013639.JavaMail.zimbra@redhat.com>
 <613214145.36646222.1608100908658.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: Re: swiotlb/virtio: unchecked device dma address and length
To: Jason Wang <jasowang@redhat.com>
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <2CCB61BD-19F0-48A3-A8D2-0D22E51D3677@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160086
Cc: ashish kalra <ashish.kalra@amd.com>,
 Felicitas Hetzelt <file@sect.tu-berlin.de>,
 Martin Radev <martin.radev@aisec.fraunhofer.de>,
 david kaplan <david.kaplan@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Robert Buhren <robert@sect.tu-berlin.de>, iommu@lists.linux-foundation.org,
 Mathias Morbitzer <mathias.morbitzer@aisec.fraunhofer.de>, hch@lst.de
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

On December 16, 2020 1:41:48 AM EST, Jason Wang <jasowang@redhat.com> wrote:
>
>
>----- Original Message -----
>> 
>> 
>> ----- Original Message -----
>> > .snip.
>> > > > > This raises two issues:
>> > > > > 1) swiotlb_tlb_unmap_single fails to check whether the index
>> > > > > generated
>> > > > > from the dma_addr is in range of the io_tlb_orig_addr array.
>> > > > That is fairly simple to implement I would think. That is it
>can check
>> > > > that the dma_addr is from the PA in the io_tlb pool when
>SWIOTLB=force
>> > > > is used.
>> > > 
>> > > 
>> > > I'm not sure this can fix all the cases. It looks to me we should
>map
>> > > descriptor coherent but readonly (which is not supported by
>current DMA
>> > > API).
>> > 
>> > I think I am missing something obvious here. The attacker is the
>> > hypervisor,
>> > aka
>> > the owner of the VirtIO device (ring0). The attacker is the one
>that
>> > provides the addr/len - having that readonly from a guest
>perspective
>> > does not change the fact that the hypervisor can modify the memory
>range
>> > by mapping it via a different virtual address in the hypervisor?
>(aka
>> > aliasing it).
>> 
>> Right, but if we allow hypervisor to provide arbitrary addr/len, does
>> it mean hypervisor can read encrypted content of encrypted memory of
>> guest through swiotlb?

Yes .
>> 
>> Thanks
>
>Actually not. I think you're right.


Your sentence is very confusing.

On a DMA unmap SWIOTLB (when force is used) it trusts the driver from providing the correct DMA address and length which SWIOTLB uses to match to its associated original PA address.

Think original PA having a mapping to a PA in the SWIOTLB pool.


The length is not checked so the attacker can modify that to say a huge number and cause SWIOTLB bounce code to write or read data from non SWIOTLB PA into the SWIOTLB PA pool.




>
>Thanks
>
>> 
>> > > 
>> > > Otherwise, device can modify the desc[i].addr/desc[i].len at any
>time to
>> > > pretend a valid mapping.
>> > 
>> > With the swiotlb=force as long as addr/len are within the PA
>boundaries
>> > within the SWIOTLB pool this should be OK?
>> > 
>> > After all that whole area is in cleartext and visible to the
>attacker.
>> > 
>> > 
>> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
