From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [RFC] kvm tools: Add support for virtio-mmio
Date: Tue, 15 Nov 2011 19:56:13 +0200
Message-ID: <1321379773.3200.9.camel@lappy>
References: <1321375667-17284-1-git-send-email-levinsasha928@gmail.com>
	<CAFEAcA-2QGk_Y1R_FPrVRVGiP7KyQOuv0zubORm77cOoU_K6gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAFEAcA-2QGk_Y1R_FPrVRVGiP7KyQOuv0zubORm77cOoU_K6gQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Maydell <peter.maydell@linaro.org>
Cc: gorcunov@gmail.com, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, asias.hejun@gmail.com, virtualization@lists.linux-foundation.org, penberg@kernel.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2011-11-15 at 17:00 +0000, Peter Maydell wrote:
> On 15 November 2011 16:47, Sasha Levin <levinsasha928@gmail.com> wrote:
> > +       vmmio->hdr = (struct virtio_mmio_hdr) {
> > +               .magic          = {'v', 'i', 'r', 't'},
> > +               .version        = 1,
> > +               .device_id      = device_id - 0x1000 + 1,
> > +               .vendor_id      = PCI_VENDOR_ID_REDHAT_QUMRANET,
> > +               .queue_num_max  = 256,
> > +       };
> 
> This isn't a PCI device, so does it make sense to use a PCI vendor
> ID here? The kernel doesn't check the vendor ID at the moment,
> but presumably the idea of the field is to allow the kernel to
> work around implementation bugs/blacklist/whatever if necessary.
> If that's the theory then it would make more sense for QEMU and
> kvm-tool to use IDs that say "this is the QEMU implementation"
> and "this is the kvm-tool implementation".
> 
> (I picked 0x554D4551 for QEMU...)
> 
> -- PMM

I just sheepishly filled in the only vendor ID I knew of in the virtio
spec :)
 
Hmm... If thats the plan, it should probably be a virtio thing (not
virtio-mmio specific).

Either way, it could also use some clarification in the spec.

-- 

Sasha.
