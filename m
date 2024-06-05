Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B35154BE5
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717603383; cv=none; b=HYVTFm4ylTulXzdonFbz1ivN5ikIa636nCSU2D5PoKASRxvFetkzNPCW38KI4GkvHs2yz6GUOauG2eEw+Mf62oQv075TVb/jS/fssfrNAgNi4VNJwr9NjSJaIafnQkJNKwvZ98IWZ6IEnnr34aQOKaiBmAk8BzRY+1A5V1a9rfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717603383; c=relaxed/simple;
	bh=C0bCEbIkgFeTXnBAOsl8boxV6hIyhsh9cdh4AjtWpAU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CkZ7kuKSM77auTy+nm38apuiPpu/49QxMWhR0Lv6/UudU0kHasZF05LDPGYRQDgmiKxFmDOCMZKzRo0I0rVzjnlMb7hIbVE1xWpe+AGCu2gqv873GdG79c+YexkjLZdlyDyYwbrzI0xybhMTRRWfurJc+TPrkuCBAy/7VetYvBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZF48eKoR; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZF48eKoR"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C5C961143
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 16:03:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.998
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mkZNx2Z8bEWh for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jun 2024 16:03:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=iii@linux.ibm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 450DC61142
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 450DC61142
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZF48eKoR
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 450DC61142
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 16:03:01 +0000 (UTC)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 455FqccJ001302;
	Wed, 5 Jun 2024 16:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=VoD8tX52FvDat9NcjNAX98NVbgaw2ECRczO9sAXN6Zk=;
 b=ZF48eKoRnALAvrJbyJKK96YuFZev/7Sl78hii05OBMRBLG1NDxTRMShJlrsgIyr+FEWL
 JKwSN+vLTyw95FbHtYvmO8ALatkPEDqBi8aBXsl+xofy24NxVP5B1NRyEKQ2/UaVH4HJ
 3YW/jjBgcHyh3x0yCTBoA8DElc6nHUsxms4Me7csTUzD4rrtuLDrkimgXfceCJ5XRVRu
 t2sH9pJ2zIXbzqCjfeBkMn8AcHkWpUOASyCHOZLEx0vpIOIhdfi8dGR7Mz58qlXIzK+S
 Hem5DcORgIfC/lc23ZBxlsox/JlGAN5wFsla11pdx0Z4jIc/CxI8nquMOFzeUqUQ7IAp tw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yju1j01w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 16:02:44 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 455G2h42022506;
	Wed, 5 Jun 2024 16:02:43 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yju1j01w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 16:02:43 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 455EYUuw026521;
	Wed, 5 Jun 2024 16:02:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yggp34kx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 16:02:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 455G2csL48628082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Jun 2024 16:02:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC28A20043;
	Wed,  5 Jun 2024 16:02:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A10A20040;
	Wed,  5 Jun 2024 16:02:38 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Jun 2024 16:02:38 +0000 (GMT)
Message-ID: <ecde3264696efe9145ce0785e7c3c2c7d0182ea4.camel@linux.ibm.com>
Subject: Re: [PATCH vhost v13 04/12] virtio_ring: support add premapped buf
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexander Potapenko <glider@google.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin"
 <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard
 Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Christoph Hellwig
 <hch@infradead.org>
Date: Wed, 05 Jun 2024 18:02:38 +0200
In-Reply-To: <CAG_fn=Wv4Tw8guW=mFYyV9T18C_qPZOxr3fwKcRkDVXm1e+iXg@mail.gmail.com>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
	 <20230810123057.43407-5-xuanzhuo@linux.alibaba.com>
	 <0b726a75574ad98200b815f173e59a5378e9df04.camel@linux.ibm.com>
	 <CAG_fn=Wv4Tw8guW=mFYyV9T18C_qPZOxr3fwKcRkDVXm1e+iXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xYTW5mHPVypOduDonLVEW2AGx82bOgi3
X-Proofpoint-ORIG-GUID: ezpYYrInLL1W71wsacFlf4Y4GCv2Vv5B
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
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406050121

On Tue, 2024-06-04 at 18:17 +0200, Alexander Potapenko wrote:
> On Tue, Jun 4, 2024 at 6:07=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m>
> wrote:
> >=20
> > On Thu, 2023-08-10 at 20:30 +0800, Xuan Zhuo wrote:
> > > If the vq is the premapped mode, use the sg_dma_address()
> > > directly.
> > >=20
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > > =C2=A0drivers/virtio/virtio_ring.c | 19 +++++++++++++++++--
> > > =C2=A01 file changed, 17 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/virtio/virtio_ring.c
> > > b/drivers/virtio/virtio_ring.c
> > > index 8e81b01e0735..f9f772e85a38 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -361,6 +361,11 @@ static struct device *vring_dma_dev(const
> > > struct
> > > vring_virtqueue *vq)
> > > =C2=A0static int vring_map_one_sg(const struct vring_virtqueue *vq,
> > > struct
> > > scatterlist *sg,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 enum dma_data_direction direction,
> > > dma_addr_t *addr)
> > > =C2=A0{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (vq->premapped) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 *addr =3D sg_dma_address(sg);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +
> >=20
> > I wonder if something needs to be done for KMSAN here, like it's
> > done
> > by the next block in this function? I'm looking into what seems to
> > be a
> > KMSAN false positive on s390x:
> >=20
> > BUG: KMSAN: uninit-value in receive_buf+0x45ca/0x6990
> > =C2=A0receive_buf+0x45ca/0x6990
> > =C2=A0virtnet_poll+0x17e0/0x3130
> > =C2=A0net_rx_action+0x832/0x26e0
> > =C2=A0handle_softirqs+0x330/0x10f0
> > =C2=A0[...]
>=20
> I think there's a similar problem on x86 as well:
> https://syzkaller.appspot.com/bug?extid=3Dc5336dcd1b741349d27a
>=20
> I was going to look closer this week.

Thanks! I bisected it in the meantime and the first failing commit is:

commit f9dac92ba9081062a6477ee015bd3b8c5914efc4
Author: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date:   Sat May 11 11:14:01 2024 +0800

    virtio_ring: enable premapped mode whatever use_dma_api

so it's definitely related.
