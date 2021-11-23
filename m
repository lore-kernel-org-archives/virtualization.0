Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC74CC433EF
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 12:43:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5729480DCA;
	Tue, 23 Nov 2021 12:43:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZXinmh7vTkwo; Tue, 23 Nov 2021 12:43:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A7E6980DDB;
	Tue, 23 Nov 2021 12:43:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A4D0C001E;
	Tue, 23 Nov 2021 12:43:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C31D6C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 12:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AA2074018E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 12:43:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6G8YenLiA-y8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 12:43:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3BB8D40163
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 12:43:16 +0000 (UTC)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANCJFYJ016896; 
 Tue, 23 Nov 2021 12:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Vm9WxCDj1ilksPqb5oNTNZfKtWpg8KvDP02Ygctbjtk=;
 b=XKzyE8jVnORvr5nXMSKR0gW65lDcmAa9FWnsvQKdtnlbgYFDu4mk1rwgSXfqe9rMk7Nh
 UbKpS+uXrvtSFFZgaf51Zf6L+HWr4qL/mTG2lZNr34yl1+6CR18P94DPTP2ClTpLizEB
 ixZb8HBFgztCJ/pQG87bcnXaQyLGivbAQaSJDvps/E1YDquwMbr3oN8TnQVFl2RjU40p
 jbR0TcWUZ1gZeCkCotfc5PWZM+Mh7CL7Gb/2AZxerP+ZH08W8wJBLrP+z9A16Bvc+pc4
 52tI1UEakYMy90cir9QmGYriIj3bMq5nvDwj6H1elHLLV08Qsy0+CHBFel4M/wTUs/ed RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3cgvq852gk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Nov 2021 12:43:08 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ANCJdE0019607;
 Tue, 23 Nov 2021 12:43:08 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3cgvq852g2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Nov 2021 12:43:08 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ANCgD4a032076;
 Tue, 23 Nov 2021 12:43:06 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma05fra.de.ibm.com with ESMTP id 3cern9pr9k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Nov 2021 12:43:06 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1ANCh44A30015922
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Nov 2021 12:43:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C05DA4053;
 Tue, 23 Nov 2021 12:43:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EF47A4055;
 Tue, 23 Nov 2021 12:43:03 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.0.71])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Tue, 23 Nov 2021 12:43:03 +0000 (GMT)
Date: Tue, 23 Nov 2021 13:43:01 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
Message-ID: <20211123134301.0dd999ad.pasic@linux.ibm.com>
In-Reply-To: <20211123071340-mutt-send-email-mst@kernel.org>
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
 <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com>
 <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
 <20211122145003.3e127a03.pasic@linux.ibm.com>
 <20211123071340-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f7tZ5hzDLzWxoqPvwlMmPnUbaSgB3Ngb
X-Proofpoint-GUID: 46zEd1XnL-tw2YR8bv94r0leZsd6sG1m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_04,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111230071
Cc: "kaplan, david" <david.kaplan@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

On Tue, 23 Nov 2021 07:17:05 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Nov 22, 2021 at 02:50:03PM +0100, Halil Pasic wrote:
> > On Mon, 22 Nov 2021 14:25:26 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> >   
> > > On Mon, Nov 22, 2021 at 1:49 PM Halil Pasic <pasic@linux.ibm.com> wrote:  
> > > >
> > > > On Mon, 22 Nov 2021 06:35:18 +0100
> > > > Halil Pasic <pasic@linux.ibm.com> wrote:
> > > >    
> > > > > > I think it should be a common issue, looking at
> > > > > > vhost_vsock_handle_tx_kick(), it did:
> > > > > >
> > > > > > len += sizeof(pkt->hdr);
> > > > > > vhost_add_used(vq, head, len);
> > > > > >
> > > > > > which looks like a violation of the spec since it's TX.    
> > > > >
> > > > > I'm not sure the lines above look like a violation of the spec. If you
> > > > > examine vhost_vsock_alloc_pkt() I believe that you will agree that:
> > > > > len == pkt->len == pkt->hdr.len
> > > > > which makes sense since according to the spec both tx and rx messages
> > > > > are hdr+payload. And I believe hdr.len is the size of the payload,
> > > > > although that does not seem to be properly documented by the spec.    
> > > 
> > > Sorry for being unclear, what I meant is that we probably should use
> > > zero here. TX doesn't use in buffer actually.
> > > 
> > > According to the spec, 0 should be the used length:
> > > 
> > > "and len the total of bytes written into the buffer."  
> > 
> > Right, I was wrong. I somehow assumed this is the total length and not
> > just the number of bytes written.
> >   
> > >   
> > > > >
> > > > > On the other hand tx messages are stated to be device read-only (in the
> > > > > spec) so if the device writes stuff, that is certainly wrong.
> > > > >    
> > > 
> > > Yes.
> > >   
> > > > > If that is what happens.
> > > > >
> > > > > Looking at virtqueue_get_buf_ctx_split() I'm not sure that is what
> > > > > happens. My hypothesis is that we just a last descriptor is an 'in'
> > > > > type descriptor (i.e. a device writable one). For tx that assumption
> > > > > would be wrong.
> > > > >
> > > > > I will have another look at this today and send a fix patch if my
> > > > > suspicion is confirmed.  
> > 
> > Yeah, I didn't remember the semantic of
> > vq->split.vring.used->ring[last_used].len
> > correctly, and in fact also how exactly the rings work. So your objection
> > is correct. 
> > 
> > Maybe updating some stuff would make it easier to not make this mistake.
> > 
> > For example the spec and also the linux header says:
> > 
> > /* le32 is used here for ids for padding reasons. */ 
> > struct virtq_used_elem { 
> >         /* Index of start of used descriptor chain. */ 
> >         le32 id; 
> >         /* Total length of the descriptor chain which was used (written to) */ 
> >         le32 len; 
> > };
> > 
> > I think that comment isn't as clear as it could be. I would prefer:
> > /* The number of bytes written into the device writable portion of the
> > buffer described by the descriptor chain. */
> > 
> > I believe "the descriptor chain which was used" includes both the
> > descriptors that map the device read only and the device write
> > only portions of the buffer described by the descriptor chain. And the
> > total length of that descriptor chain may be defined either as a number
> > of the descriptors that form the chain, or the length of the buffer.
> > 
> > One has to use the descriptor chain even if the whole buffer is device
> > read only. So "used" == "written to" does not make any sense to me.  
> 
> The virtio spec actually says
> 
> Total length of the descriptor chain which was written to
> 
> without the "used" part.

Yes, that is in the text after the (pseudo-)code listing which contains
the description I was referring to (in 2.6.8 The Virtqueue Used Ring).
> 
> > Also something like
> > int vhost_add_used(struct vhost_virtqueue *vq, unsigned int head, int bytes_written)
> > instead of
> > int vhost_add_used(struct vhost_virtqueue *vq, unsigned int head, int len)
> > would make it easier to read the code correctly.  
> 
> I think we agree here. Patches?
> 

Will send some :D

Thanks!

[..]
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
