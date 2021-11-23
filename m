Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A49C433EF
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 13:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FBFA4039D;
	Tue, 23 Nov 2021 13:35:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TBBnWh07x-EK; Tue, 23 Nov 2021 13:35:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2B9BA403B5;
	Tue, 23 Nov 2021 13:35:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D1FBC002E;
	Tue, 23 Nov 2021 13:35:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0F51C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 13:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A04036059F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 13:35:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VZr4rH1EDFRj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 13:35:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 36F91607FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 13:35:07 +0000 (UTC)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANDWvV3030294; 
 Tue, 23 Nov 2021 13:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=JhkYMBSB3TFJwO+8btge7mrVeNvkGW7dfXyrbtfjwXE=;
 b=ri1UKDFNNHoCXCg5mpYSNaeT2zPoj8xucNoM85jQP3wPvGTH5DsW9ixtcceiwp38I3g4
 wsZKZDpJcQAsHkDKSOzk1g8yGOPYavf5CNMQYyp08yISz9tqqMP4vTk2NB9AwpXdnjN5
 xeOJ4MthZRcV/vw086ugaXRjR26I3bJ39CbByHuZUmVqm5GcfG8zcCrx5RfZlYsNAZQM
 7prmGLXfTZi6Z1UhC2D05YySI/WpG3Wh2telp4eYHokZmEadu+Qcfdo3ryDkMqQ3SkBl
 Qm4JtWVUs0ZMbG7lZlYCKqjPWbuLDm+rOj0nVD9FIJI3+G6Cn8r3pfWPugqBc+FsSnZD 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3cgw5nnk65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Nov 2021 13:35:05 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ANDXc9I032676;
 Tue, 23 Nov 2021 13:35:05 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3cgw5nnk5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Nov 2021 13:35:05 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AND94hI029337;
 Tue, 23 Nov 2021 13:22:34 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06ams.nl.ibm.com with ESMTP id 3cer9jr949-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Nov 2021 13:22:34 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1ANDMW4415073734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Nov 2021 13:22:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01FF94C044;
 Tue, 23 Nov 2021 13:22:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83C934C046;
 Tue, 23 Nov 2021 13:22:31 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.0.71])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Tue, 23 Nov 2021 13:22:31 +0000 (GMT)
Date: Tue, 23 Nov 2021 14:22:29 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 1/2] vhost/vsock: fix incorrect used length reported to
 the guest
Message-ID: <20211123142229.78edf43a.pasic@linux.ibm.com>
In-Reply-To: <20211122163525.294024-2-sgarzare@redhat.com>
References: <20211122163525.294024-1-sgarzare@redhat.com>
 <20211122163525.294024-2-sgarzare@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wRsvhxK9Lethzrk-8OpJ2qBrcMHq6Gmt
X-Proofpoint-ORIG-GUID: rEbIEAYwChKL5YaPQCZC2OyfUobdXAVK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_04,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111230076
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Asias He <asias@redhat.com>
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

On Mon, 22 Nov 2021 17:35:24 +0100
Stefano Garzarella <sgarzare@redhat.com> wrote:

> The "used length" reported by calling vhost_add_used() must be the
> number of bytes written by the device (using "in" buffers).
> 
> In vhost_vsock_handle_tx_kick() the device only reads the guest
> buffers (they are all "out" buffers), without writing anything,
> so we must pass 0 as "used length" to comply virtio spec.
> 
> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
> Cc: stable@vger.kernel.org
> Reported-by: Halil Pasic <pasic@linux.ibm.com>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

> ---
>  drivers/vhost/vsock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 938aefbc75ec..4e3b95af7ee4 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -554,7 +554,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
>  			virtio_transport_free_pkt(pkt);
>  
>  		len += sizeof(pkt->hdr);
> -		vhost_add_used(vq, head, len);
> +		vhost_add_used(vq, head, 0);
>  		total_len += len;
>  		added = true;
>  	} while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
