From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 13/22] virtio_pci: new, capability-aware driver.
Date: Sun, 24 Mar 2013 15:08:55 +0200
Message-ID: <20130324130855.GC6601@redhat.com>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-14-git-send-email-rusty@rustcorp.com.au>
	<20130321102439.GB30493@redhat.com>
	<87zjxwdz6e.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87zjxwdz6e.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 22, 2013 at 11:32:33AM +1030, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > On Thu, Mar 21, 2013 at 06:59:34PM +1030, Rusty Russell wrote:
> >> Differences:
> >> 1) Uses 4 pci capabilities to demark common, irq, notify and dev-specific areas.
> >> 2) Guest sets queue size, using host-provided maximum.
> >> 3) Guest sets queue alignment, rather than ABI-defined 4096.
> >> 4) More than 32 feature bits (a lot more!).
> ...
> >> +/* Constants for MSI-X */
> >> +/* Use first vector for configuration changes, second and the rest for
> >> + * virtqueues Thus, we need at least 2 vectors for MSI. */
> >> +enum {
> >> +	VP_MSIX_CONFIG_VECTOR = 0,
> >> +	VP_MSIX_VQ_VECTOR = 1,
> >> +};
> >
> > In the future, I have a plan to allow one vector only.  To make this
> > work without exits for data path VQ, we could make hypervisor set a bit
> > in guest memory whenever it wants to signal a configuration change.
> > Guest will execute a config write that will make the hypervisor clear
> > this register.
> >
> > I guess this can wait, we are putting too stuff much into this
> > new layout patchset already.
> 
> Yeah, trying not to boil the ocean... and I'm not sure that reinventing
> MSI-X manually is a good idea anyway.

I'm not sure this is reinventing MSI-X but I agree let's do things
gradually.

> >> +static void vp_reset(struct virtio_device *vdev)
> >> +{
> >> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >> +	/* 0 status means a reset. */
> >> +	iowrite8(0, &vp_dev->common->device_status);
> >> +	/* Flush out the status write, and flush in device writes,
> >> +	 * including MSi-X interrupts, if any. */
> >
> > MSI-X ?
> 
> Thanks, fixed.
> 
> Cheers,
> Rusty.
