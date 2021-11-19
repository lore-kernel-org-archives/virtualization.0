Return-Path: <SRS0=gSim=QG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450BAC433F5
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 15:10:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD20161AA2
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 15:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD20161AA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F50181BF4;
	Fri, 19 Nov 2021 15:10:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bNXz3j006VQ1; Fri, 19 Nov 2021 15:10:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 180DD81BD9;
	Fri, 19 Nov 2021 15:10:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00599C002E;
	Fri, 19 Nov 2021 15:10:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99F42C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 15:10:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7BB5C61C16
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 15:10:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ssn51gNYRMYI
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 15:10:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2111E61C0E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 15:10:19 +0000 (UTC)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AJEBsuM004293; 
 Fri, 19 Nov 2021 15:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=0MP0TcvzjP8SfMirHVdpCIcpMxsE5ZR81uig9gebZSg=;
 b=N3/PYHEZiSUfBuxeuUjtBpqfv4C5w5du1/uSC2hY+4XPbssPtcM8brqBzodE/b4+YxAk
 oQUVOfY3J7YSPO+Io2L4mcQFegw9rlhwz+1e2L34cI2L7a1hUAnlfU0ACtaJDQYup9Ew
 87ErWNum2KuMpjWbNk8cACpsxecJl7zl/SVy9JmkPzywNtZpijml3gs0FQI6bSuJ7Z4U
 3V74xieHLPq8RzkvxGhz3Z9oC4zVcugL5TMXk04eT4ydhLdjg3rbwKmUFO3GoqL2q8VD
 YLmwpC+MHGkjWZlr+HuBsiq+KS6CegKQDwLNtW/5SFtkpS8z/oBCiRsY57RSP2UqACij IA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3cec0kk6ts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Nov 2021 15:10:16 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AJEC34W005179;
 Fri, 19 Nov 2021 15:10:16 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3cec0kk6ss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Nov 2021 15:10:16 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AJF3VqE012380;
 Fri, 19 Nov 2021 15:10:14 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma06ams.nl.ibm.com with ESMTP id 3ca4mksy31-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Nov 2021 15:10:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 1AJF38hD60686658
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Nov 2021 15:03:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BF4FAE068;
 Fri, 19 Nov 2021 15:10:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0BD0AE055;
 Fri, 19 Nov 2021 15:10:10 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.32.96])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Fri, 19 Nov 2021 15:10:10 +0000 (GMT)
Date: Fri, 19 Nov 2021 16:09:51 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
Message-ID: <20211119160951.5f2294c8.pasic@linux.ibm.com>
In-Reply-To: <20211027022107.14357-2-jasowang@redhat.com>
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W2LqPQDNQ3Yv7uyJXxNO4ROVIPAicV5n
X-Proofpoint-GUID: XpNAgGaEGisJ6W2H3HhA84DWCLUvvQRA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_09,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111190084
Cc: david.kaplan@amd.com, konrad.wilk@oracle.com, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Halil Pasic <pasic@linux.ibm.com>, mst@redhat.com
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

On Wed, 27 Oct 2021 10:21:04 +0800
Jason Wang <jasowang@redhat.com> wrote:

> This patch validate the used buffer length provided by the device
> before trying to use it. This is done by record the in buffer length
> in a new field in desc_state structure during virtqueue_add(), then we
> can fail the virtqueue_get_buf() when we find the device is trying to
> give us a used buffer length which is greater than the in buffer
> length.
> 
> Since some drivers have already done the validation by themselves,
> this patch tries to makes the core validation optional. For the driver
> that doesn't want the validation, it can set the
> suppress_used_validation to be true (which could be overridden by
> force_used_validation module parameter). To be more efficient, a
> dedicate array is used for storing the validate used length, this
> helps to eliminate the cache stress if validation is done by the
> driver.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Hi Jason!

Our CI has detected, that virtio-vsock became unusable with this
patch on s390x. I didn't test on x86 yet. The guest kernel says
something like:
vmw_vsock_virtio_transport virtio1: tx: used len 44 is larger than in buflen 0

Did you, or anybody else, see something like this on platforms other that
s390x?

I had a quick look at this code, and I speculate that it probably
uncovers a pre-existig bug, rather than introducing a new one.

If somebody is already working on this please reach out to me.

Regards,
Halil
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
