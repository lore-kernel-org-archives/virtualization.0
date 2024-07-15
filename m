Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA0318785B
	for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721057460; cv=none; b=FlCySdCDZRlg4C3NKDQPzGTMVje6bcOJFKlg3vgoWop3GiszvltGNVokfY7zdl72if+Rv6KwHLcOo+Gy7TPbZhJJ768qgYV6DJkkqb0CDpPoqUP58fLkOdbD1Mj7DcINEvO2Brd/Vdw/Q4XF4lDfgImkwTrjJ8fmXmDdInhIXJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721057460; c=relaxed/simple;
	bh=FhJFss3S/yHa/GMdCgQmJl//GsZVUXtvz4fxE1Xri28=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mhVeKqeOIlwDf4e+rAyNqcU8lFaq9HmX7rlUkZKoKIqJoZUrr5lZ0gbdrErq3npmC2fR0pg1Fhsop8H582us7JQiDw8KmfFgmFmwGpKmQ4HXOavqEoZD7rbcQCPZXhDDwO6pybRE9VY13aJ3XetjAR9wR7G5nh2kGdUXdyEqzV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VgzPORPA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VgzPORPA"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FDvj0a002761
	for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 15:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	FhJFss3S/yHa/GMdCgQmJl//GsZVUXtvz4fxE1Xri28=; b=VgzPORPAMsg/H5tX
	87EAZnp/scPkhA5U/ciBVKga+BXr/zrCTg6bVR0uwZu/7YCFfevQo0biZB0slhBW
	skxWXXfdiSyRuLet4Bq436DQSrjHulunSFcL6pViMqsughWfCSAOEQ9QApQYIAcj
	srS90ZUos5tNqt7fzlAIAilgLTaS+cXoF25u5dsJV5LxqXtu4i+hemfVfl4mqlaw
	p6PAHXqqU5Oh73WyaUD+UURm9pWkKm6/NtGIymFNEBvdatb6Z9pv/dAUfzZ+n/P4
	PyGJz9m+PTbhl6VP5VFhVek7G2lynAfbpPOul3xFKc9XWV9ZmbwG3i19esH8lpDK
	YsYDcw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d4p9ga7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 15:30:55 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46FFUZui014940
	for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 15:30:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d4p9ga78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 15:30:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46FCR11O030685;
	Mon, 15 Jul 2024 15:30:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40c4a0fre9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 15:30:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46FFUolG48890356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 15:30:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECD6120043;
	Mon, 15 Jul 2024 15:30:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DD2A20040;
	Mon, 15 Jul 2024 15:30:49 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jul 2024 15:30:49 +0000 (GMT)
Message-ID: <090a8152eab55555b23b1a7605520567ce0bffa3.camel@linux.ibm.com>
Subject: Re: [PATCH] virtio_ring: fix KMSAN error for premapped mode
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
        Alexander Potapenko
	 <glider@google.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux.dev,
        Eugenio
 =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Aleksandr Nogikh
 <nogikh@google.com>
Date: Mon, 15 Jul 2024 17:30:49 +0200
In-Reply-To: <20240715102018-mutt-send-email-mst@kernel.org>
References: <20240606111345.93600-1-xuanzhuo@linux.alibaba.com>
	 <CACGkMEtZWJJ1TxnbDLio28M1_0mUZmDd_HbQrZOVB9ixKoLbMQ@mail.gmail.com>
	 <CAG_fn=Xe+XQROUqZ9zy94BXVj8SRKprW3fUj_0rD3AhSAvtn-w@mail.gmail.com>
	 <20240624095629-mutt-send-email-mst@kernel.org>
	 <CAG_fn=VwB_EepsY7GcMM2ihz77vtWDR3tsxJ6iD0Sdx-wQVx+g@mail.gmail.com>
	 <20240715102018-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CZo7mgIIrCnd74VPf0X29R1UPhpt1iSA
X-Proofpoint-GUID: QRaKX5caLPTYGi0HCPRtjsnttHuUdYx5
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_10,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=474 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150121

On Mon, 2024-07-15 at 10:20 -0400, Michael S. Tsirkin wrote:
> On Mon, Jul 15, 2024 at 03:24:17PM +0200, Alexander Potapenko wrote:
> > On Mon, Jun 24, 2024 at 3:57=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com>
> > wrote:
> > >=20
> > > On Mon, Jun 24, 2024 at 03:51:50PM +0200, Alexander Potapenko
> > > wrote:
> > > > On Fri, Jun 7, 2024 at 8:34=E2=80=AFAM Jason Wang <jasowang@redhat.=
com>
> > > > wrote:
> > > > >=20
> > > > > On Thu, Jun 6, 2024 at 7:13=E2=80=AFPM Xuan Zhuo
> > > > > <xuanzhuo@linux.alibaba.com> wrote:
> > > > > >=20
> > > > > > Add kmsan for virtqueue_dma_map_single_attrs to fix:
> > > > > >=20
> > > > > > BUG: KMSAN: uninit-value in receive_buf+0x45ca/0x6990
> > > > > > =C2=A0receive_buf+0x45ca/0x6990
> > > > > > =C2=A0virtnet_poll+0x17e0/0x3130
> > > > > > =C2=A0net_rx_action+0x832/0x26e0
> > > > > > =C2=A0handle_softirqs+0x330/0x10f0
> > > > > > =C2=A0[...]
> > > > > >=20
> > > > > > Uninit was created at:
> > > > > > =C2=A0__alloc_pages_noprof+0x62a/0xe60
> > > > > > =C2=A0alloc_pages_noprof+0x392/0x830
> > > > > > =C2=A0skb_page_frag_refill+0x21a/0x5c0
> > > > > > =C2=A0virtnet_rq_alloc+0x50/0x1500
> > > > > > =C2=A0try_fill_recv+0x372/0x54c0
> > > > > > =C2=A0virtnet_open+0x210/0xbe0
> > > > > > =C2=A0__dev_open+0x56e/0x920
> > > > > > =C2=A0__dev_change_flags+0x39c/0x2000
> > > > > > =C2=A0dev_change_flags+0xaa/0x200
> > > > > > =C2=A0do_setlink+0x197a/0x7420
> > > > > > =C2=A0rtnl_setlink+0x77c/0x860
> > > > > > =C2=A0[...]
> > > > > >=20
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > Tested-by: Alexander Potapenko <glider@google.com>
> > > > >=20
> > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > >=20
> > > > Jason, Michael, any chance this patch can make it to 6.10?
> > > > The bug in question has essentially been blocking KMSAN on
> > > > syzbot for
> > > > the past month:
> > > > https://syzkaller.appspot.com/bug?id=3D2819883f3d376b703e686e700fde=
00a01eec62fa
> > > >=20
> > > > The patch should probably have
> > > > =C2=A0 Fixes: b6253b4e21939 ("virtio_ring: introduce dma map api for
> > > > virtqueue")
> > > >=20
> > > > , but I am not exactly sure why syzkaller only started
> > > > triggering the
> > > > bug this year, given that the patch dates back to 2023.
> > >=20
> > > Yes that's probably a good idea. I will queue it with this tag.
> >=20
> > Hi Michael,
> >=20
> > Looks like the patch is still stuck in the limbo :(
>=20
> It should be in linux next. Don't you see it there?

FWIW I ran linux-next with KMSAN today and this fix was already there.

But in the meantime another similarly looking issue crept in:

https://lore.kernel.org/netdev/20240712195759.GA2972562@myrica/T/
