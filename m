From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH V3 WIP 3/3] disable vhost_verify_ring_mappings check
Date: Mon, 01 Apr 2013 18:05:47 -0700
Message-ID: <1364864747.3898.8.camel__14341.7873689488$1364864791$gmane$org@haakon2.linux-iscsi.org>
References: <8300718.16452772.1364465611936.JavaMail.root@redhat.com>
	<1364525606.10253.69.camel@haakon2.linux-iscsi.org>
	<51554D56.5080004@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51554D56.5080004@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin O'Connor <kevin@koconnor.net>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, seabios-devel <seabios@seabios.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2013-03-29 at 09:14 +0100, Paolo Bonzini wrote: 
> Il 29/03/2013 03:53, Nicholas A. Bellinger ha scritto:
> > On Thu, 2013-03-28 at 06:13 -0400, Paolo Bonzini wrote:
> >>> I think it's the right thing to do, but maybe not the right place
> >>> to do this, need to reset after all IO is done, before
> >>> ring memory is write protected.
> >>
> >> Our emails are crossing each other unfortunately, but I want to
> >> reinforce this: ring memory is not write protected.
> > 
> > Understood.  However, AFAICT the act of write protecting these ranges
> > for ROM generates the offending callbacks to vhost_set_memory().
> > 
> > The part that I'm missing is if ring memory is not being write protected
> > by make_bios_readonly_intel(), why are the vhost_set_memory() calls
> > being invoked..?
> 
> Because mappings change for the region that contains the ring.  vhost
> doesn't know yet that the changes do not affect ring memory,
> vhost_set_memory() is called exactly to ascertain that.
> 

Hi Paolo & Co,

Here's a bit more information on what is going on with the same
cpu_physical_memory_map() failure in vhost_verify_ring_mappings()..

So as before, at the point that seabios is marking memory as readonly
for ROM in src/shadow.c:make_bios_readonly_intel() with the following
call:

Calling pci_config_writeb(0x31): bdf: 0x0000 pam: 0x0000005b

the memory API update hook triggers back into vhost_region_del() code,
and following occurs:

Entering vhost_region_del section: 0x7fd30a213b60 offset_within_region: 0xc0000 size: 2146697216 readonly: 0
vhost_region_del: is_rom: 0, rom_device: 0
vhost_region_del: readable: 1
vhost_region_del: ram_addr 0x0, addr: 0x0 size: 2147483648
vhost_region_del: name: pc.ram
Entering vhost_set_memory, section: 0x7fd30a213b60 add: 0, dev->started: 1
Entering verify_ring_mappings: start_addr 0x00000000000c0000 size: 2146697216
verify_ring_mappings: ring_phys 0x0 ring_size: 0
verify_ring_mappings: ring_phys 0x0 ring_size: 0
verify_ring_mappings: ring_phys 0xed000 ring_size: 5124
verify_ring_mappings: calling cpu_physical_memory_map ring_phys: 0xed000 l: 5124
address_space_map: addr: 0xed000, plen: 5124
address_space_map: l: 4096, len: 5124
phys_page_find got PHYS_MAP_NODE_NIL >>>>>>>>>>>>>>>>>>>>>>..
address_space_map: section: 0x7fd30fabaed0 memory_region_is_ram: 0 readonly: 0
address_space_map: section: 0x7fd30fabaed0 offset_within_region: 0x0 section size: 18446744073709551615
Unable to map ring buffer for ring 2, l: 4096

So the interesting part is that phys_page_find() is not able to locate
the corresponding page for vq->ring_phys: 0xed000 from the
vhost_region_del() callback with section->offset_within_region:
0xc0000..

Is there any case where this would not be considered a bug..? 

register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
Entering vhost_region_add section: 0x7fd30a213aa0 offset_within_region: 0xc0000 size: 32768 readonly: 1
vhost_region_add: is_rom: 0, rom_device: 0
vhost_region_add: readable: 1
vhost_region_add: ram_addr 0x0000000000000000, addr: 0x               0 size: 2147483648
vhost_region_add: name: pc.ram
Entering vhost_set_memory, section: 0x7fd30a213aa0 add: 1, dev->started: 1
Entering verify_ring_mappings: start_addr 0x00000000000c0000 size: 32768
verify_ring_mappings: ring_phys 0x0 ring_size: 0
verify_ring_mappings: ring_phys 0x0 ring_size: 0
verify_ring_mappings: ring_phys 0xed000 ring_size: 5124
verify_ring_mappings: Got !ranges_overlap, skipping
register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
Entering vhost_region_add section: 0x7fd30a213aa0 offset_within_region: 0xc8000 size: 2146664448 readonly: 0
vhost_region_add: is_rom: 0, rom_device: 0
vhost_region_add: readable: 1
vhost_region_add: ram_addr 0x0000000000000000, addr: 0x               0 size: 2147483648
vhost_region_add: name: pc.ram
Entering vhost_set_memory, section: 0x7fd30a213aa0 add: 1, dev->started: 1
Entering verify_ring_mappings: start_addr 0x00000000000c8000 size: 2146664448
verify_ring_mappings: ring_phys 0x0 ring_size: 0
verify_ring_mappings: ring_phys 0x0 ring_size: 0
verify_ring_mappings: ring_phys 0xed000 ring_size: 5124
verify_ring_mappings: calling cpu_physical_memory_map ring_phys: 0xed000 l: 5124
address_space_map: addr: 0xed000, plen: 5124
address_space_map: l: 4096, len: 5124
address_space_map: section: 0x7fd30fabb020 memory_region_is_ram: 1 readonly: 0
address_space_map: section: 0x7fd30fabb020 offset_within_region: 0xc8000 section size: 2146664448
address_space_map: l: 4096, len: 1028
address_space_map: section: 0x7fd30fabb020 memory_region_is_ram: 1 readonly: 0
address_space_map: section: 0x7fd30fabb020 offset_within_region: 0xc8000 section size: 2146664448
address_space_map: Calling qemu_ram_ptr_length: raddr: 0x           ed000 rlen: 5124
address_space_map: After qemu_ram_ptr_length: raddr: 0x           ed000 rlen: 5124

So here the vhost_region_add() callback for
section->offset_within_region: 0xc8000 for vq->ring_phys: 0xed000 is
able to locate *section via phys_page_find() within address_space_map(),
and cpu_physical_memory_map() completes as expected..

register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
phys_page_find got PHYS_MAP_NODE_NIL >>>>>>>>>>>>>>>>>>>>>>..

So while plodding my way through the memory API, the thing that would be
useful to know is if the offending *section that is missing for the
first phys_page_find() call is getting removed before the callback makes
it's way into vhost_verify_ring_mappings() code, or that some other bug
is occuring..?

Any idea on how this could be verified..?

Thanks,

--nab
