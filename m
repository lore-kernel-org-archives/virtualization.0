Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E76C2BBCA
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 13:07:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E5C233A2
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 13:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E5C233A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9B6FC872FE;
	Wed, 16 Dec 2020 13:07:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VOU7sQwz+PTc; Wed, 16 Dec 2020 13:07:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1313F873AA;
	Wed, 16 Dec 2020 13:07:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6712C1D9F;
	Wed, 16 Dec 2020 13:07:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F4F1C013B;
 Wed, 16 Dec 2020 13:07:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 781C3227DB;
 Wed, 16 Dec 2020 13:07:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2vhq+sicfNEn; Wed, 16 Dec 2020 13:07:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by silver.osuosl.org (Postfix) with ESMTPS id AA0F12152E;
 Wed, 16 Dec 2020 13:07:27 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGD3gMO106137;
 Wed, 16 Dec 2020 13:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding :
 subject : to : cc : from : message-id; s=corp-2020-01-29;
 bh=rwh9Uc+wMV+j606UhKUuXwBaj3AJkP8UiVNpiIaBbLM=;
 b=Gd1otr/QUZoPyODVsP4uh/zjgMPtYkwUf/aIoXzC4bl6J3xpVwWvaO0gkg4Lsbxuz2nG
 6BeRftKHTBdDtz3C8WSqbT8w8ZJ/3/sJ/01sPzUpwsYV5Ilh8crxInz2LWxLUZVW0EvM
 DiI59szXV7KSoBxWM6hyjvFL4Lr/dTqrpx3yYy6SEQ54HFQxgW9UVUBpMcvqaNELHM00
 fbUDz7H3BXp5DE65UK4mhB5OeGOYLxeHGA2Vh/69/oqSw254cXvVxEwlcA7I0HsLWKp5
 DNkDzW5YRRrzlR9rBNtcOG+8kbvjJrhz3YCJgWFhlFUdxQV9HiOTlxddraS2RyHLy/sy Zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 35ckcbg4v1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Dec 2020 13:07:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGD0D3B136782;
 Wed, 16 Dec 2020 13:07:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 35d7sxs6ya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Dec 2020 13:07:20 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BGD7J7F020031;
 Wed, 16 Dec 2020 13:07:19 GMT
Received: from [192.168.86.39] (/209.6.208.110)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 16 Dec 2020 05:07:18 -0800
Date: Wed, 16 Dec 2020 08:07:16 -0500
User-Agent: K-9 Mail for Android
In-Reply-To: <20201215074427-mutt-send-email-mst@kernel.org>
References: <d2ae0b1d-332b-42a1-87bf-7da2b749cac2@sect.tu-berlin.de>
 <20201214214950.GC18103@char.us.oracle.com>
 <c3629a27-3590-1d9f-211b-c0b7be152b32@redhat.com>
 <20201215074427-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: Re: swiotlb/virtio: unchecked device dma address and length
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <DBDBA8B6-6CC3-47B5-A20E-6D5DD29DB47E@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160086
Cc: ashish.kalra@amd.com, Felicitas Hetzelt <file@sect.tu-berlin.de>, "Radev,
 Martin" <martin.radev@aisec.fraunhofer.de>, david.kaplan@amd.com,
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

..snip..
>> > > This raises two issues:
>> > > 1) swiotlb_tlb_unmap_single fails to check whether the index
>generated
>> > > from the dma_addr is in range of the io_tlb_orig_addr array.
>> > That is fairly simple to implement I would think. That is it can
>check
>> > that the dma_addr is from the PA in the io_tlb pool when
>SWIOTLB=force
>> > is used.
>> 
>> 
>> I'm not sure this can fix all the cases. It looks to me we should map
>> descriptor coherent but readonly (which is not supported by current
>DMA
>> API).
>
>Neither is this supported but encrypted memory technologies.


-ECONFUSED.

Could you state this once more please? I am not exactly sure what you are saying 

>
>> Otherwise, device can modify the desc[i].addr/desc[i].len at any time
>to
>> pretend a valid mapping.
>> 
>> Thanks
>> 
>> 
>> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
