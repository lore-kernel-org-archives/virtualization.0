From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [kvm-devel] [PATCH resent] virtio_net: Fix stalled inbound
	trafficon early packets
Date: Wed, 12 Dec 2007 19:14:38 +0100
Message-ID: <200712121914.38135.borntraeger__21316.1524654881$1197483449$gmane$org@de.ibm.com>
References: <200712111242.28843.borntraeger@de.ibm.com>
	<200712121239.51435.borntraeger@de.ibm.com>
	<476002E7.5050301@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <476002E7.5050301@qumranet.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dor.laor@qumranet.com
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Mittwoch, 12. Dezember 2007 schrieb Dor Laor:
> I think the change below handles the race. Otherwise please detail the 
> use case.
[...]
> > @@ -292,6 +292,9 @@ static int virtnet_open(struct net_devic
> >                 return -ENOMEM;
> >
> >         napi_enable(&vi->napi);
> > +
> > +       vi->rvq->vq_ops->enable(vi->rvq);
> > +       vi->svq->vq_ops->enable(vi->svq);
> >
> If you change it to:
> if (!vi->rvq->vq_ops->enable(vi->rvq))
>     vi->rvq->vq_ops->kick(vi->rvq);
> if (!vi->rvq->vq_ops->enable(vi->svq))
>     vi->rvq->vq_ops->kick(vi->svq);
> 
> You solve the race of packets already waiting in the queue without 
> triggering the irq.

Hmm, I dont fully understand your point. I think this will work as long as 
the host has not consumed all inbound buffers. It will also require that 
the host sends an additional packet, no? If no additional packet comes the 
host has no reason to send an interrupt just because it got a notify 
hypercall. kick inside a guest also does not trigger the poll routine. 

It also wont work on the following scenario:
in virtnet open we will allocate buffers and send them to the host using the 
kick callback. The host can now use _all_ buffers for incoming data while 
interrupts are still disabled and the guest is not running.( Lets say the 
host bridge has lots of multicast traffic and the guest gets not scheduled 
for a while). When the guest now continues and enables the interrupts 
nothing happens. Doing a kick does not help, as the host code will bail out 
with "no dma memory for transfer".

Christian
