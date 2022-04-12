Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7A0C433FE
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 07:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3EDB83E7B;
	Tue, 12 Apr 2022 07:56:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WtRI8Hb94BG4; Tue, 12 Apr 2022 07:56:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8617381BB2;
	Tue, 12 Apr 2022 07:56:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A60FC002F;
	Tue, 12 Apr 2022 07:56:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A1E8C002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0769B41296
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:56:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MLaz28J45ssj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:56:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8CBEA40926
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:56:11 +0000 (UTC)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23C6ft7Y029349; 
 Tue, 12 Apr 2022 07:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=xBbtpFu+g0M5oAS5qWS81PsG9t3GJIOwiA28DUQVs5g=;
 b=SVt+WNZtqmPYAF1sZKsrFMSalIkYkLBUKYWFGmso0cvIt6pFOBLJn+hFqCkiGkQZ8QlW
 Cpm3SrNXmSZI1LyT5UoWIFoLoW9CyJvTSevYp6+23sjOFvnru3bBUx6U5IJKMCjm+YxC
 8OU7TpD1xZny6mJvUjc8AESJO7YtKCWqAUUsYG5Ff58UoMrv/Yf8ruq2uH/gTgTiGTAM
 UdzurUjj7dXdoMLi03n2lbdmhcS1os5jK6pAAjIfs3CPUeuvMF/6AJTPH2AJ0sIbtmBL
 jTmjME6SO4w33YEUfPIdnSPjVB3nc5vGAhUMtQ1L0UWZC8LvuPx2GvaurSL5+sXxHaxI Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3fd4cj9e3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Apr 2022 07:55:46 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23C7YZ1Z024509;
 Tue, 12 Apr 2022 07:55:46 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3fd4cj9e2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Apr 2022 07:55:45 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23C7sIaW012477;
 Tue, 12 Apr 2022 07:55:43 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04ams.nl.ibm.com with ESMTP id 3fb1s8vd9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Apr 2022 07:55:43 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 23C7tf9n34013486
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Apr 2022 07:55:41 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29C2BAE04D;
 Tue, 12 Apr 2022 07:55:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 776EBAE055;
 Tue, 12 Apr 2022 07:55:40 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.60.83])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Tue, 12 Apr 2022 07:55:40 +0000 (GMT)
Date: Tue, 12 Apr 2022 09:55:19 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
Message-ID: <20220412095519.245cf9f7.pasic@linux.ibm.com>
In-Reply-To: <CACGkMEvDSv+sZwLYqqfP-jzDzonmon+CxeSXkvyd6F-CbfV3tQ@mail.gmail.com>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org>
 <87wng2e527.fsf@redhat.com>
 <20220408150307.24b6b99f.pasic@linux.ibm.com>
 <20220410034556-mutt-send-email-mst@kernel.org>
 <CACGkMEtarZb6g3ij5=+As17+d9jtdAqNa1EzSuTXc7Pq_som0Q@mail.gmail.com>
 <877d7vbspu.fsf@redhat.com>
 <20220412020145.32e26e5a.pasic@linux.ibm.com>
 <CACGkMEvDSv+sZwLYqqfP-jzDzonmon+CxeSXkvyd6F-CbfV3tQ@mail.gmail.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CmSVxQ2lgNAuH9PRyaNdXW8BiJbSoWi6
X-Proofpoint-ORIG-GUID: k8zmRpchgAEYpZ3jEgIZi-3Qw_H2iW3j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-12_02,2022-04-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxlogscore=814 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120035
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Tue, 12 Apr 2022 10:24:35 +0800
Jason Wang <jasowang@redhat.com> wrote:

> > Regarding the question "are we safe against notifications before
> > indicators have been registered" I think we really need to think about
> > something like Secure Execution. We don't have, and we are unlikely
> > to have in hardware virtio-ccw implementations, and for a malicious hypervisor
> > that has full access to the guest memory hardening makes no sense.  
> 
> Does s390 have something like memory encryption? (I guess yes). In the
> case of x86 VM encryption, the I/O buffers were now done via software
> IOTLB, that's why hardening of the virtio driver is needed to prevent
> the hypervisor to poke the swiotlb etc.

Yep! Secure Execution is a confidential computing solution which is much
like encrypted guest memory, except for one gets exceptions when trying
to access private memory instead of ending up with garbage  because of
the encryption. These improvements are IMHO relevant to us!

Regards,
Halil
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
