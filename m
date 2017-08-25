From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] [RFC] virtio: Limit the retries on a virtio device reset
Date: Fri, 25 Aug 2017 19:46:10 +0300
Message-ID: <20170825194404-mutt-send-email-mst@kernel.org>
References: <1503505982-29568-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<20170824171253-mutt-send-email-mst@kernel.org>
	<05de15a6-9c4f-f44f-b8bd-ca04e7e91499@linux.vnet.ibm.com>
	<20170825001922-mutt-send-email-mst@kernel.org>
	<d271e548-efd2-5315-c406-a32fad838e87@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d271e548-efd2-5315-c406-a32fad838e87@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: cohuck@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 25, 2017 at 10:33:57AM +0200, Pierre Morel wrote:
> On 24/08/2017 23:23, Michael S. Tsirkin wrote:
> > On Thu, Aug 24, 2017 at 07:42:07PM +0200, Pierre Morel wrote:
> > > On 24/08/2017 16:19, Michael S. Tsirkin wrote:
> > > > On Wed, Aug 23, 2017 at 06:33:02PM +0200, Pierre Morel wrote:
> > > > > Reseting a device can sometime fail, even a virtual device.
> > > > > If the device is not reseted after a while the driver should
> > > > > abandon the retries.
> > > > > This is the change proposed for the modern virtio_pci.
> > > > > 
> > > > > More generally, when this happens,the virtio driver can set the
> > > > > VIRTIO_CONFIG_S_FAILED status flag to advertise the caller.
> > > > > 
> > > > > The virtio core can test if the reset was succesful by testing
> > > > > this flag after a reset.
> > > > > 
> > > > > This behavior is backward compatible with existing drivers.
> > > > > This behavior seems to me compatible with Virtio-1.0 specifications,
> > > > > Chapters 2.1 Device Status Field.
> > > > > There I definitively need your opinion: Is it right?
> > > > > 
> > > > > This patch also lead to another question:
> > > > > do we care if a device provided by the hypervisor is buggy?
> > > > > 
> > > > > Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> > > > 
> > > > So I think this is not the best place to start to add error recovery.
> > > 
> > > I agree, there can not be any error recovery there.
> > > If reset does not work we can let fall the device until next reset of the
> > > hypervisor.
> > 
> > On probe, yes. But failures are more likely to trigger at other times.
> 
> OK, what about:
> - On probe if reset fail, the probe fail.
> 
> - On freeze and remove : we can not free resources which are common
> 	with the device, at least the queues.
> 	... we can only signal the error and give up with the device.
> 
> > 
> > > > It should be much more common to have a situation where device gets
> > > > broken while it's being used.  Spec has a NEEDS_RESET flag for this.
> > > 
> > > Yes the device side can set this flag, but it is another problem, it is
> > > supposing that:
> > > - the transport, device side, still works.
> > > - it is able to detect that the device need a reset
> > > - a reset is effective
> > 
> > Right. OTOH in this case there's more we can do.
> 
> Yes, I did not find a single test of this flag (NEEDS_RESET).
> even QEMU set it quite often (though virtio_error())
> 
> The decision to reset the device must come from the driver.
> The protocol to reset the device is device/driver specific... lotta work
> 
> Shouldn't it be separate from the "reset failed" problem?
> 
> 
> Regards,
> 
> Pierre
> 

I just don't think we can do a lot about reset failed without risk of
breaking some working config. So I would start with need reset
and maybe some reset failures will be fixable as a side effect.

Yes it's a lot of work. For example we need to validate device
input, can't rely on it to be consistent.

-- 
MST
