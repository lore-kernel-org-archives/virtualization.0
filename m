Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6404D194AF1
	for <virtualization@lists.linux.dev>; Thu,  6 Jun 2024 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674905; cv=none; b=JKzIrdzBSoMO+1LsmFCMM/XVkq56Wuz9wphE6JFpXRKwq3aeJ5AGWJfsJwG3B1pKNn6pQ5wxKdtp8s+59M5I61l0G25xQQD2+YL8N6oXBhHvR5KKQtt+8uaeYZ8Sz5QxVHCInwvCARRkA+zAUjZ3Jp+E52fbE+jMIKmVnALDQP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674905; c=relaxed/simple;
	bh=39oLk1/zBdErWlRk8MSQaN4vIez/HeBCYYcLX/0keTo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h3o4S0fKCJgR+QDitoYG/fpYjEnWwSTOo9XKJyX9rfYnlD2vpZgK+La7+UaXMBnCvbvQS/8XhzP2HezIBxWugGfrgi8N1xtD1HPLRw/7XivCrSNq32jKop/GHDuWftaggmZAtPNRsWj19MNis5H3Aba1MMiEeSm3uhMjfM81gaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OwuX0ULc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OwuX0ULc"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456BbWsF019373
	for <virtualization@lists.linux.dev>; Thu, 6 Jun 2024 11:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=wRHHqTxqc7+4cwAQn1dztd9zLO4ryTp5UA+3xHc/b9k=;
 b=OwuX0ULcFauEMEirgL4Ul8itMLJmWNXb+QaiqdaRUX5N6A4yhaP8K4WNu6UiIsvEPsvO
 R4UWuu93tSah+HOfFcT4bCJq5QOfOwtE4YIaL2A2uy7Rd4VVdniW8mTYZEFcCb0LZyNP
 p/j5Dxc88Jh3cNIo4A4q2ptqJGY+aXvdzTc0mW/hNUFJlGqkGUibGNeSmin43YqJNVA0
 IMDNilVPH2o9Qxln003n9/G/P6lsWp7xnH1ZwGZY46bX54QCBTsLHNMtL0GwnXG8Wiph
 T/g8uk3vD4AHWtPJHISyWXsv9BDxLRs5nxG71cDtd+TWX5MlNVunqd8Y8swS0sVWWAb5 RA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykcd301na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 06 Jun 2024 11:55:02 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 456Bt2Ph019583
	for <virtualization@lists.linux.dev>; Thu, 6 Jun 2024 11:55:02 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykcd301n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 11:55:02 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 456BCi9c008501;
	Thu, 6 Jun 2024 11:55:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygec12hmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 11:55:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 456BsuhJ50463000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Jun 2024 11:54:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF7622004F;
	Thu,  6 Jun 2024 11:54:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A84A52004E;
	Thu,  6 Jun 2024 11:54:56 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Jun 2024 11:54:56 +0000 (GMT)
Message-ID: <8f517bb5275d8eb9a638128d1c47339db5dc1fb3.camel@linux.ibm.com>
Subject: Re: [PATCH] virtio_ring: fix KMSAN error for premapped mode
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Alexander
 Potapenko <glider@google.com>
Date: Thu, 06 Jun 2024 13:54:56 +0200
In-Reply-To: <20240606111345.93600-1-xuanzhuo@linux.alibaba.com>
References: <20240606111345.93600-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nhveLL4cxo5ZsJkQ6jJydh-Sv5y4orb3
X-Proofpoint-GUID: Czo2ZxpVW_AkYKtjV46QFZiEi-KyLjQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=399 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 clxscore=1011
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406060087

On Thu, 2024-06-06 at 19:13 +0800, Xuan Zhuo wrote:
> Add kmsan for virtqueue_dma_map_single_attrs to fix:
>=20
> BUG: KMSAN: uninit-value in receive_buf+0x45ca/0x6990
> =C2=A0receive_buf+0x45ca/0x6990
> =C2=A0virtnet_poll+0x17e0/0x3130
> =C2=A0net_rx_action+0x832/0x26e0
> =C2=A0handle_softirqs+0x330/0x10f0
> =C2=A0[...]
>=20
> Uninit was created at:
> =C2=A0__alloc_pages_noprof+0x62a/0xe60
> =C2=A0alloc_pages_noprof+0x392/0x830
> =C2=A0skb_page_frag_refill+0x21a/0x5c0
> =C2=A0virtnet_rq_alloc+0x50/0x1500
> =C2=A0try_fill_recv+0x372/0x54c0
> =C2=A0virtnet_open+0x210/0xbe0
> =C2=A0__dev_open+0x56e/0x920
> =C2=A0__dev_change_flags+0x39c/0x2000
> =C2=A0dev_change_flags+0xaa/0x200
> =C2=A0do_setlink+0x197a/0x7420
> =C2=A0rtnl_setlink+0x77c/0x860
> =C2=A0[...]
>=20
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Tested-by: Alexander Potapenko <glider@google.com>
> ---
> =C2=A0drivers/virtio/virtio_ring.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>  # s390x

Thanks!
