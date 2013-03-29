From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH V3 WIP 3/3] disable vhost_verify_ring_mappings check
Date: Thu, 28 Mar 2013 20:28:57 -0700
Message-ID: <1364527737.10253.74.camel__19889.0786422$1364527777$gmane$org@haakon2.linux-iscsi.org>
References: <1363653285-23776-1-git-send-email-asias@redhat.com>
	<1363653285-23776-4-git-send-email-asias@redhat.com>
	<20130319084057.GB24393@stefanha-thinkpad.redhat.com>
	<1363744628.13070.28.camel@haakon2.linux-iscsi.org>
	<20130320095140.GA16615@redhat.com>
	<1364419887.17698.19.camel@haakon2.linux-iscsi.org>
	<20130327215625.GC10678@redhat.com>
	<1364423629.17698.25.camel@haakon2.linux-iscsi.org>
	<1364453115.17698.106.camel@haakon2.linux-iscsi.org>
	<1364456142.10253.6.camel@haakon2.linux-iscsi.org>
	<20130328090416.GA18482@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130328090416.GA18482@redhat.com>
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
Cc: Kevin O'Connor <kevin@koconnor.net>, kvm@vger.kernel.org, seabios-devel <seabios@seabios.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2013-03-28 at 11:04 +0200, Michael S. Tsirkin wrote:
> On Thu, Mar 28, 2013 at 12:35:42AM -0700, Nicholas A. Bellinger wrote:
> > On Wed, 2013-03-27 at 23:45 -0700, Nicholas A. Bellinger wrote:
> > > On Wed, 2013-03-27 at 15:33 -0700, Nicholas A. Bellinger wrote:
> > > > On Wed, 2013-03-27 at 23:56 +0200, Michael S. Tsirkin wrote:
> > > > > On Wed, Mar 27, 2013 at 02:31:27PM -0700, Nicholas A. Bellinger wrote:
> > 

<SNIP>

> > locking shadow ram
> > romend: 0x000cb800 romtop: 0x000ec000
> > mem: 0x000c0000, pam: 0x0000005a
> > Calling pci_config_writeb(0x11): bdf: 0x0000 pam: 0x0000005a
> > 
> > > <No QEMU output after pci_config_writeb(0x11) in make_bios_readonly..>
> > > 
> > > Calling pci_config_writeb(0x31): bdf: 0x0000 pam: 0x0000005b
> > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > 
> > 
> > mem: 0x000c8000, pam: 0x0000005b
> > romend: 0x000cb800 mem + 16*1024: 0x000cc000
> > romtop: 0x000ec000 mem + 32*1024: 0x000d0000
> > >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> > romend: 0x000cb800, mem: 0x000c8000, romtop: 0x000ec000, mem + 16*1024: 0x000cc000
> > Calling pci_config_writeb(0x31): bdf: 0x0000 pam: 0x0000005b
> > 
> > 
> > > <QEMU output after pci_config_writeb(0x31) in make_bios_readonly..>
> > > 
> > > vhost_set_memory: section: 0x7fe2801f2b60 section->size: 2146697216 add: 0
> > > Before vhost_verify_ring_mappings: start_addr: c0000 size: 2146697216
> > > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> 
> This is also a bug. -net always initializes VQs 0..N so this is what
> vhost assumed.  Please teach vhost that it should skip uninitialized
> VQs. There are more places to fix.
> Basically look for if (!virtio_queue_get_num(vdev, queue_no)),
> all of them need to be updated to skip uninitialized vqs.
> Probably switch to a new API checking PA too.
> See patch below.

<nod>

> 
> > > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > > Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > > Calling l: 5124 for start_addr: c0000 for vq 2
> > > Unable to map ring buffer for ring 2
> > > l: 4096 ring_size: 5124
> 
> okay so the ring address is within ROM.
> Unsurprisingly it fails.
> bios should stop device before write protect.

<SNIP>

> ---
> 
> virtio: add API to check that ring is setup
> 
> virtio scsi makes it legal to only setup a subset of rings.  The only
> way to detect the ring is setup seems to be to check whether PA was
> written to.  Add API to do this, and teach code to use it instead of
> checking hardware queue size.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> --->
> 
> diff --git a/hw/virtio.c b/hw/virtio.c
> index 26fbc79..ac12c01 100644
> --- a/hw/virtio.c
> +++ b/hw/virtio.c
> @@ -651,6 +651,11 @@ int virtio_queue_get_num(VirtIODevice *vdev, int n)
>      return vdev->vq[n].vring.num;
>  }
>  
> +bool virtio_queue_valid(VirtIODevice *vdev, int n)
> +{
> +    return vdev->vq[n].vring.num && vdev->vq[n].vring.pa;
> +}

I assume you mean vring.desc here, right..?

Sending out these as a separate patch series shortly.

--nab
