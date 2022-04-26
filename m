Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5C9C433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 02:29:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56B3B81386;
	Tue, 26 Apr 2022 02:29:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hvkKp52HTCkF; Tue, 26 Apr 2022 02:29:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DA9DC8134F;
	Tue, 26 Apr 2022 02:29:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF41BC0039;
	Tue, 26 Apr 2022 02:29:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F4D4C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 02:29:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1932581384
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 02:29:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ad_MVv0SYd1I
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 02:29:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 729118134F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 02:29:33 +0000 (UTC)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q2BKn3027092;
 Tue, 26 Apr 2022 02:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ORjGnEMDrvo3+6uualxTOacerrMHtkGkqIJwhd1RrQw=;
 b=OI1fPB+6S7gRMEmbdzYIzZHZZ8ZPD+2UWPeLdXiBuiPfx8kkd72at4f6ed+nH2KdPuDs
 jOu00CwrtdfH8t1YX7B0cwO1GtfgZCFAYH2HL009F7E1Z3EC/AOdayRuAHcOpJV/Mf7w
 afcmMvphSwa42C2VTPpZ3Tv/yx6q8YPb0Nud/ID/Wrv7rZkniZ3ZYaTEqDa9Uoee2Uno
 82onSqbv+HTquPHFdSSB+vzHOPSSttxxaGXXuESPQ3LRlyX54etm3ndB5lgstKYFnETR
 8eVRu8DF2KM1TYeCvY+2U508e3/51RdWf0xgfryrLQJ0gJSb11rCNjYM28U5dH87y4Op LA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fp4txtsyf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Apr 2022 02:29:19 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23Q2Olka010189;
 Tue, 26 Apr 2022 02:29:19 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fp4txtsy0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Apr 2022 02:29:19 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23Q2CPW0003706;
 Tue, 26 Apr 2022 02:29:16 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06ams.nl.ibm.com with ESMTP id 3fm8qj36vy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Apr 2022 02:29:16 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 23Q2TExw47645034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Apr 2022 02:29:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 418EC42042;
 Tue, 26 Apr 2022 02:29:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 968DB4203F;
 Tue, 26 Apr 2022 02:29:13 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.52.32])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Tue, 26 Apr 2022 02:29:13 +0000 (GMT)
Date: Tue, 26 Apr 2022 04:29:11 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220426042911.544477f9.pasic@linux.ibm.com>
In-Reply-To: <20220425095742-mutt-send-email-mst@kernel.org>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com>
 <20220425095742-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eUvDg2_gBEW68dtdUTwHrS5eIvmZyaS2
X-Proofpoint-ORIG-GUID: c41i5I_tk-ghEpQj5XSK1OlF6NaEfU5F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260012
Cc: paulmck@kernel.org, lulu@redhat.com, peterz@infradead.org, maz@kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 eperezma@redhat.com, tglx@linutronix.de
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

On Mon, 25 Apr 2022 09:59:55 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck wrote:
> > On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:  
> > >> This patch tries to implement the synchronize_cbs() for ccw. For the
> > >> vring_interrupt() that is called via virtio_airq_handler(), the
> > >> synchronization is simply done via the airq_info's lock. For the
> > >> vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> > >> device spinlock for irq is introduced ans used in the synchronization
> > >> method.
> > >> 
> > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> > >> Cc: Peter Zijlstra <peterz@infradead.org>
> > >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > >> Cc: Marc Zyngier <maz@kernel.org>
> > >> Cc: Halil Pasic <pasic@linux.ibm.com>
> > >> Cc: Cornelia Huck <cohuck@redhat.com>
> > >> Signed-off-by: Jason Wang <jasowang@redhat.com>  
> > >
> > >
> > > This is the only one that is giving me pause. Halil, Cornelia,
> > > should we be concerned about the performance impact here?
> > > Any chance it can be tested?  
> > 
> > We can have a bunch of devices using the same airq structure, and the
> > sync cb creates a choke point, same as registering/unregistering.  
> 
> BTW can callbacks for multiple VQs run on multiple CPUs at the moment?

I'm not sure I understand the question.

I do think we can have multiple CPUs that are executing some portion of
virtio_ccw_int_handler(). So I guess the answer is yes. Connie what do you think?

On the other hand we could also end up serializing synchronize_cbs()
calls for different devices if they happen to use the same airq_info. But
this probably was not your question

> this patch serializes them on a spinlock.
>

Those could then pile up on the newly introduced spinlock.

Regards,
Halil

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
