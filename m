From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [kvm-devel] [PATCH resent] virtio_net: Fix stalled inbound
	trafficon early packets
Date: Thu, 13 Dec 2007 19:30:31 +0100
Message-ID: <200712131930.31602.borntraeger__30053.3281093978$1197570791$gmane$org@de.ibm.com>
References: <200712111242.28843.borntraeger@de.ibm.com>
	<200712121914.38135.borntraeger@de.ibm.com>
	<47613277.3060403@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47613277.3060403@qumranet.com>
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

Am Donnerstag, 13. Dezember 2007 schrieb Dor Laor:
> You're right I got confused somehow.
> So in that case setting the driver status field on open in addition to 
> your enable will do the trick.
> On DRIVER_OPEN the host will trigger an interrupt if the queue is not 
> empty..
> Thanks,
> Dor

After looking into some other drivers, I prefer my first patch (moving 
napi_enable) ;-)

There are some drivers like xen-netfront, b44, which call napi_enable before 
the buffers are passed to the hardware. So it seems that moving napi is 
also a valid option.

But maybe I can just wait until Rusty returns from vacation (I will leave 
next week) so everything might be wonderful when I return ;-)

Rusty, if you decide to apply my patch, there is one downside: The debugging 
code in virtio_ring sometimes triggers with a false positive:

try_fill_recv calls vring_kick. Here we do a notify to the host. This might 
cause an immediate interrupt, triggering the poll routine before vring_kick 
can run END_USE. This is no real problem, as we dont touch the vq after 
notify.

Christian, facing 64 guest cpus unconvering all kind of races
