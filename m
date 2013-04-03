From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH V3 WIP 3/3] disable vhost_verify_ring_mappings check
Date: Tue, 02 Apr 2013 21:59:45 -0700
Message-ID: <1364965185.3898.277.camel@haakon2.linux-iscsi.org>
References: <8300718.16452772.1364465611936.JavaMail.root@redhat.com>
	<1364525606.10253.69.camel@haakon2.linux-iscsi.org>
	<51554D56.5080004@redhat.com>
	<1364864747.3898.8.camel@haakon2.linux-iscsi.org>
	<20130402132729.GK21545@redhat.com>
	<1364961850.3898.261.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1364961850.3898.261.camel@haakon2.linux-iscsi.org>
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

On Tue, 2013-04-02 at 21:04 -0700, Nicholas A. Bellinger wrote:
> On Tue, 2013-04-02 at 16:27 +0300, Michael S. Tsirkin wrote:
> > On Mon, Apr 01, 2013 at 06:05:47PM -0700, Nicholas A. Bellinger wrote:
> > > On Fri, 2013-03-29 at 09:14 +0100, Paolo Bonzini wrote: 
> > > > Il 29/03/2013 03:53, Nicholas A. Bellinger ha scritto:
> > > > > On Thu, 2013-03-28 at 06:13 -0400, Paolo Bonzini wrote:
> > > > >>> I think it's the right thing to do, but maybe not the right place
> > > > >>> to do this, need to reset after all IO is done, before
> > > > >>> ring memory is write protected.
> > > > >>
> > > > >> Our emails are crossing each other unfortunately, but I want to
> > > > >> reinforce this: ring memory is not write protected.
> > > > > 
> > > > > Understood.  However, AFAICT the act of write protecting these ranges
> > > > > for ROM generates the offending callbacks to vhost_set_memory().
> > > > > 
> > > > > The part that I'm missing is if ring memory is not being write protected
> > > > > by make_bios_readonly_intel(), why are the vhost_set_memory() calls
> > > > > being invoked..?
> > > > 
> > > > Because mappings change for the region that contains the ring.  vhost
> > > > doesn't know yet that the changes do not affect ring memory,
> > > > vhost_set_memory() is called exactly to ascertain that.
> > > > 

<SNIP>

> > 
> > Is it possible that what is going on here,
> > is that we had a region at address 0x0 size 0x80000000,
> > and now a chunk from it is being made readonly,
> > and to this end the whole old region is removed
> > then new ones are added?
> 
> Yes, I believe this is exactly what is happening..
> 
> > 
> > If yes maybe the problem is that we don't use the atomic
> > begin/commit ops in the memory API.
> > Maybe the following will help?
> > Completely untested, posting just to give you the idea:
> > 
> 
> Mmmm, one question on how vhost_region_del() + vhost_region_add() +
> vhost_commit() should work..
> 
> Considering the following when the same seabios code snippet:
> 
>    pci_config_writeb(0x31): bdf: 0x0000 pam: 0x0000005b
> 
> is executed to mark an pc.ram area 0xc0000 as readonly:
> 
> Entering vhost_begin >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> Entering vhost_region_del section: 0x7fd037a4bb60 offset_within_region: 0xc0000 size: 2146697216 readonly: 0
> vhost_region_del: is_rom: 0, rom_device: 0
> vhost_region_del: readable: 1
> vhost_region_del: ram_addr 0x0, addr: 0x0 size: 2147483648
> vhost_region_del: name: pc.ram
> Entering vhost_set_memory, section: 0x7fd037a4bb60 add: 0, dev->started: 1
> vhost_set_memory: Setting dev->memory_changed = true for start_addr: 0xc0000
> Entering vhost_region_add section: 0x7fd037a4baa0 offset_within_region: 0xc0000 size: 32768 readonly: 1
> vhost_region_add is readonly !!!!!!!!!!!!!!!!!!!
> vhost_region_add: is_rom: 0, rom_device: 0
> vhost_region_add: readable: 1
> vhost_region_add: ram_addr 0x0000000000000000, addr: 0x               0 size: 2147483648
> vhost_region_add: name: pc.ram
> Entering vhost_set_memory, section: 0x7fd037a4baa0 add: 1, dev->started: 1
> vhost_dev_assign_memory(); >>>>>>>>>>>>>>>>>>>>>>>>>>>> reg->guest_phys_addr: 0xc0000
> vhost_set_memory: Setting dev->memory_changed = true for start_addr: 0xc0000
> Entering vhost_region_add section: 0x7fd037a4baa0 offset_within_region: 0xc8000 size: 2146664448 readonly: 0
> vhost_region_add: is_rom: 0, rom_device: 0
> vhost_region_add: readable: 1
> vhost_region_add: ram_addr 0x0000000000000000, addr: 0x               0 size: 2147483648
> vhost_region_add: name: pc.ram
> Entering vhost_set_memory, section: 0x7fd037a4baa0 add: 1, dev->started: 1
> vhost_set_memory: Setting dev->memory_changed = true for start_addr: 0xc8000
> phys_page_find got PHYS_MAP_NODE_NIL >>>>>>>>>>>>>>>>>>>>>>..
> Entering vhost_commit >>>>>>>>>>>>>>>>>>>>>>>>>>>
> 
> Note that originally we'd see the cpu_physical_memory_map() failure in
> vhost_verify_ring_mappings() after the first ->region_del() above.
> 
> Adding a hardcoded cpu_physical_memory_map() testcase in vhost_commit()
> for phys_addr=0xed000, len=5124 (vq ring) does locate the correct
> *section from address_space_map(), which correct points to the section
> generated by the last vhost_region_add() above:
> 
> Entering vhost_commit >>>>>>>>>>>>>>>>>>>>>>>>>>>
> address_space_map: addr: 0xed000, plen: 5124
> address_space_map: l: 4096, len: 5124
> address_space_map: section: 0x7f41b325f020 memory_region_is_ram: 1 readonly: 0
> address_space_map: section: 0x7f41b325f020 offset_within_region: 0xc8000 section size: 2146664448
> address_space_map: l: 4096, len: 1028
> address_space_map: section: 0x7f41b325f020 memory_region_is_ram: 1 readonly: 0
> address_space_map: section: 0x7f41b325f020 offset_within_region: 0xc8000 section size: 2146664448
> address_space_map: Calling qemu_ram_ptr_length: raddr: 0x           ed000 rlen: 5124
> address_space_map: After qemu_ram_ptr_length: raddr: 0x           ed000 rlen: 5124
> cpu_physical_memory_map(0xed000) got l: 5124
> 
> So, does using a ->commit callback for MemoryListener  mean that
> vhost_verify_ring_mappings() is OK to be called only from the final
> ->commit callback, and not from each ->region_del + ->region_add
> callback..?   Eg: I seem to recall something about
> vhost_verify_ring_mappings() being called during each ->region_del()
> when dev->started == true was important, no..?
> 
> If this OK, then it seems a matter of keeping an updated bit for each of
> the regions in vhost_dev->mem_sections[] and performing the
> vhost_verify_ring_mappings() on all three above during the final
> ->commit() call, right..?

Or even better, what about just invoking vhost_verify_ring_mappings()
once from ->commit without section start_addr+size + drop the existing
!rings_overlap check..?

Does the following look like you'd expect for marking 0xc0000 area as
read-only case..?

Entering vhost_begin >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Entering vhost_region_del section: 0x7f16d3a1db60 offset_within_region: 0xc0000 size: 2146697216 readonly: 0
vhost_region_del: is_rom: 0, rom_device: 0
vhost_region_del: readable: 1
vhost_region_del: ram_addr 0x0, addr: 0x0 size: 2147483648
vhost_region_del: name: pc.ram
Entering vhost_set_memory, section: 0x7f16d3a1db60 add: 0, dev->started: 1
vhost_set_memory: Setting dev->memory_changed = true for start_addr: 0xc0000
Entering vhost_region_add section: 0x7f16d3a1daa0 offset_within_region: 0xc0000 size: 32768 readonly: 1
vhost_region_add is readonly !!!!!!!!!!!!!!!!!!!
vhost_region_add: is_rom: 0, rom_device: 0
vhost_region_add: readable: 1
vhost_region_add: ram_addr 0x0000000000000000, addr: 0x               0 size: 2147483648
vhost_region_add: name: pc.ram
Entering vhost_set_memory, section: 0x7f16d3a1daa0 add: 1, dev->started: 1
vhost_dev_assign_memory(); >>>>>>>>>>>>>>>>>>>>>>>>>>>> reg->guest_phys_addr: 0xc0000
vhost_set_memory: Setting dev->memory_changed = true for start_addr: 0xc0000
Entering vhost_region_add section: 0x7f16d3a1daa0 offset_within_region: 0xc8000 size: 2146664448 readonly: 0
vhost_region_add: is_rom: 0, rom_device: 0
vhost_region_add: readable: 1
vhost_region_add: ram_addr 0x0000000000000000, addr: 0x               0 size: 2147483648
vhost_region_add: name: pc.ram
Entering vhost_set_memory, section: 0x7f16d3a1daa0 add: 1, dev->started: 1
vhost_set_memory: Setting dev->memory_changed = true for start_addr: 0xc8000
phys_page_find got PHYS_MAP_NODE_NIL >>>>>>>>>>>>>>>>>>>>>>..
Entering vhost_commit >>>>>>>>>>>>>>>>>>>>>>>>>>>
vhost_commit, skipping vhost_verify_ring_mappings without start_addr !!!!!!!!!!!!!
Entering verify_ring_mappings: start_addr 0x0000000000000000 size: 0
verify_ring_mappings: ring_phys 0x0 ring_size: 0
verify_ring_mappings: ring_phys 0x0 ring_size: 0
verify_ring_mappings: ring_phys 0xed000 ring_size: 5124
verify_ring_mappings: calling cpu_physical_memory_map ring_phys: 0xed000 l: 5124
address_space_map: addr: 0xed000, plen: 5124
address_space_map: l: 4096, len: 5124
address_space_map: section: 0x7f16d92c6020 memory_region_is_ram: 1 readonly: 0
address_space_map: section: 0x7f16d92c6020 offset_within_region: 0xc8000 section size: 2146664448
address_space_map: l: 4096, len: 1028
address_space_map: section: 0x7f16d92c6020 memory_region_is_ram: 1 readonly: 0
address_space_map: section: 0x7f16d92c6020 offset_within_region: 0xc8000 section size: 2146664448
address_space_map: Calling qemu_ram_ptr_length: raddr: 0x           ed000 rlen: 5124
address_space_map: After qemu_ram_ptr_length: raddr: 0x           ed000 rlen: 5124
