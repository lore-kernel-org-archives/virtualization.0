From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] [RFC] virtio: Limit the retries on a virtio device reset
Date: Fri, 25 Aug 2017 10:26:12 +0200
Message-ID: <20170825102612.39a5ca60.cohuck@redhat.com>
References: <1503505982-29568-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<20170824130746.25f80368.cohuck@redhat.com>
	<af4aa628-3583-50b3-1007-4c8b6d4e2183@linux.vnet.ibm.com>
	<20170824170725-mutt-send-email-mst@kernel.org>
	<d75121e6-5685-295a-7430-6aa8d713060b@linux.vnet.ibm.com>
	<20170825001411-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170825001411-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 25 Aug 2017 00:16:05 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Aug 24, 2017 at 07:07:42PM +0200, Pierre Morel wrote:
> > > - we'll have to spread these tests all over the place.  
> > 
> > I counted 19 places where to check if the reset went OK.
> > 
> > None of them touch the device anymore after reset and just free driver's
> > resources.  
> 
> ... and then hypervisor uses the resources after free. Not good.

The only place where we can simply give up on the device and be sure
that nothing bad happens is during initial setup. In the other places,
it seems we have the choice between looping (as now) or panic.

> 
> > So that if reset failed, nothing goes wrong, no device access, but the
> > probability that the next probe fail is high. (If it ever succeed).
> >   
> > >    Allowing reset to fail would be better.  
> > 
> > May be I did not understand what you mean.
> > Testing the flag or a return value is as expensive.
> > 
> > Of course the implementation is a mater of taste.  
> 
> If a function can fail it should return an error, not just set a flag.

ccw reset can (a) succeed, (b) fail (by returning an error status via
standard channel subsystem mechanisms), or (c) run into a timeout
(where the driver should recover via csch and friends). [1] In any
case, we need to able to rely on the channel subsystem to make sure a
broken device is dead.

pci-modern reset can (a) succeed, or (b) be in an indeterminate state
(it has not yet completed, but we don't know whether it will complete
in the future). It may be reasonable to just give up if (b) happens
during initial setup.

I'm not sure that allowing to fail reset will help much, other than
allowing to give up on a pci device early.

> 
> 
> > I notice two other things to do:
> > 
> > - May be adding a warning would be fine too.
> > - Virtio_ccw may add a fail flag when allocation of CCW failed.
> >   I did not find anything to do for virtio_mmio or legacy virtio_pci.
> > 
> > Regards,
> > 
> > Pierre  

[1] At that point, we either succeed with csch and can either retry or
fail, or fail with device gone, in which case the device is, well,
gone, which we also should be able to handle fine.
