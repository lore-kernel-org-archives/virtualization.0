From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 12/22] virtio_pci: allow duplicate capabilities.
Date: Thu, 21 Mar 2013 19:07:06 +0200
Message-ID: <20130321170706.GB2994@redhat.com>
References: <20130321144330.GA1454@redhat.com> <514B1D25.9090206@zytor.com>
	<20130321151937.GB1454@redhat.com> <514B26BC.6010700@zytor.com>
	<20130321155810.GA1925@redhat.com> <514B2FA0.9000204@zytor.com>
	<20130321161143.GC1925@redhat.com> <514B3213.8070002@zytor.com>
	<20130321162636.GF1925@redhat.com> <514B3606.2090503@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <514B3606.2090503@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 21, 2013 at 09:32:06AM -0700, H. Peter Anvin wrote:
> On 03/21/2013 09:26 AM, Michael S. Tsirkin wrote:
> >>>
> >>> Thanks. Same place in latest 3.0:
> >>> 	A PCI Express Endpoint must not depend on operating system allocation of
> >>> 	I/O resources claimed through BAR(s).
> >>> 	A PCI Express Endpoint must not generate I/O Requests.
> >>> of course this only applies to express :)
> >>>
> >>
> >> And it does... but it has implications for the OS resource manager that
> >> if Linux violates, we need to fix it.  We should not fail a device in
> >> generic code because an I/O BAR allocation fails.  The device driver may
> >> opt to fail the allocation.
> >>
> >> (Note that having an I/O BAR is not *generating* an I/O request.)
> > 
> > Right. So if I read this literally, I should be able to boot
> > from the device even if it does not have an I/O BAR,
> > and BIOS really should not assume it has an I/O BAR option,
> > and if as you suggest it can't use MMIO, what is left?
> > config cycles.
> > 
> > So coming back to the issue that started it all,
> > BIOS will be able to boot without I/O BAR, no good
> > reasons to have any capabilities pointing at I/O BARs,
> > so no need for duplicate capabilities?
> > 
> 
> First of all, you appear to be deliberately overinterpreting -- the BIOS
> is the resource manager here, so it can obviously make sure the I/O
> resource is available to the boot device.

Assuming there's one, but it's wrong: we might need serial for
output, -net for downloading stuff, maybe more.

> The performance argument, though, which is the more important one, still
> remains, so your conclusion is invalid.
> 
> 	-hpa

I just think it does not apply to BIOS so much.  A bigger issue for BIOS
virtio performance is that it normally does not implement batching at
all, to keep it simple and reduce memory usage it uses a small number
(often 1) of outstanding buffers per queue.

For example, here's BIOS driver for virtio-blk.


    if (write)
        vring_add_buf(vq, sg, 2, 1, 0, 0);
    else
        vring_add_buf(vq, sg, 1, 2, 0, 0);
    vring_kick(GET_GLOBAL(vdrive_g->ioaddr), vq, 1);

    /* Wait for reply */
    while (!vring_more_used(vq))
        usleep(5);

    /* Reclaim virtqueue element */
    vring_get_buf(vq, NULL);

    /* Clear interrupt status register.  Avoid leaving interrupts stuck if
     * VRING_AVAIL_F_NO_INTERRUPT was ignored and interrupts were
     * raised.
     */
    vp_get_isr(GET_GLOBAL(vdrive_g->ioaddr));

Does it look like we should spend time optimizing vring_kick?

-- 
MST
