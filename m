Return-Path: <SRS0=Oc7+=FT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8B3C2BB9A
	for <virtualization@archiver.kernel.org>; Tue, 15 Dec 2020 14:28:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755E722522
	for <virtualization@archiver.kernel.org>; Tue, 15 Dec 2020 14:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755E722522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 365438766F;
	Tue, 15 Dec 2020 14:28:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ODOtlRn7d0GJ; Tue, 15 Dec 2020 14:28:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9169B8764A;
	Tue, 15 Dec 2020 14:28:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AE28C1DA2;
	Tue, 15 Dec 2020 14:28:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10F42C013B;
 Tue, 15 Dec 2020 14:28:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F189386A10;
 Tue, 15 Dec 2020 14:28:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JDYIfkCDgBdJ; Tue, 15 Dec 2020 14:28:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 398CD86D7E;
 Tue, 15 Dec 2020 14:28:04 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFEOq6b012031;
 Tue, 15 Dec 2020 14:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=YISo3GcXt/J6AEvokQ5mIG078k8oLtJfKd6u+cT9SyY=;
 b=REJHBqvEo+qXfKS8wc0YJNL8FAskGapTvGq/YQj4ElTjUfkEJBKU/vUxFH95j02A4LI3
 GSY0KwrXLQUrII6IKLHPHroTpn6xMTibJp8aGN0uuf3NyNkxd4yEIcRHmIqcTTNgdOsH
 k+ak2HU9cDCA1D7mYAKu8kfLEfnbBOg48pyZU9+Tp/kyHQayGOkzC7CLoY43oHNhN83M
 8ml9M3LJJ8sVoWLKs2fDXr4RgBhnnX1c2OAEl3u8KqYIapDKAsqnOF9KaSAmYjeCbNWn
 u+7bTQb7ykCRc5cszfQTa3gRmCTRrIoKR2P5Oa6rqtldAXxcpY/NcHgypLXmuUtcb7/Y SQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 35cn9rat0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Dec 2020 14:27:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFELACP121153;
 Tue, 15 Dec 2020 14:25:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 35e6jr61wa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Dec 2020 14:25:56 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BFEPmiJ029664;
 Tue, 15 Dec 2020 14:25:52 GMT
Received: from char.us.oracle.com (/10.152.32.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 15 Dec 2020 06:25:48 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
 id CB0E66A00F4; Tue, 15 Dec 2020 09:27:55 -0500 (EST)
Date: Tue, 15 Dec 2020 09:27:55 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: swiotlb/virtio: unchecked device dma address and length
Message-ID: <20201215142755.GB28810@char.us.oracle.com>
References: <d2ae0b1d-332b-42a1-87bf-7da2b749cac2@sect.tu-berlin.de>
 <20201214214950.GC18103@char.us.oracle.com>
 <c3629a27-3590-1d9f-211b-c0b7be152b32@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c3629a27-3590-1d9f-211b-c0b7be152b32@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9835
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012150103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9835
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150103
Cc: ashish.kalra@amd.com, Felicitas Hetzelt <file@sect.tu-berlin.de>, "Radev,
 Martin" <martin.radev@aisec.fraunhofer.de>, david.kaplan@amd.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
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

.snip.
> > > This raises two issues:
> > > 1) swiotlb_tlb_unmap_single fails to check whether the index generated
> > > from the dma_addr is in range of the io_tlb_orig_addr array.
> > That is fairly simple to implement I would think. That is it can check
> > that the dma_addr is from the PA in the io_tlb pool when SWIOTLB=force
> > is used.
> 
> 
> I'm not sure this can fix all the cases. It looks to me we should map
> descriptor coherent but readonly (which is not supported by current DMA
> API).

I think I am missing something obvious here. The attacker is the hypervisor, aka
the owner of the VirtIO device (ring0). The attacker is the one that
provides the addr/len - having that readonly from a guest perspective
does not change the fact that the hypervisor can modify the memory range
by mapping it via a different virtual address in the hypervisor? (aka
aliasing it).
> 
> Otherwise, device can modify the desc[i].addr/desc[i].len at any time to
> pretend a valid mapping.

With the swiotlb=force as long as addr/len are within the PA boundaries
within the SWIOTLB pool this should be OK?

After all that whole area is in cleartext and visible to the attacker.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
