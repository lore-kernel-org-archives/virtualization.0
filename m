From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH V3 WIP 3/3] disable vhost_verify_ring_mappings check
Date: Wed, 3 Apr 2013 02:47:18 -0400 (EDT)
Message-ID: <1867268167.1051750.1364971638240.JavaMail.root@redhat.com>
References: <8300718.16452772.1364465611936.JavaMail.root@redhat.com>
	<1364525606.10253.69.camel@haakon2.linux-iscsi.org>
	<51554D56.5080004@redhat.com>
	<1364864747.3898.8.camel@haakon2.linux-iscsi.org>
	<20130402132729.GK21545@redhat.com>
	<1364961850.3898.261.camel@haakon2.linux-iscsi.org>
	<1364965185.3898.277.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1364965185.3898.277.camel@haakon2.linux-iscsi.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: Kevin O'Connor <kevin@koconnor.net>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, seabios-devel <seabios@seabios.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> > Considering the following when the same seabios code snippet:
> > 
> >    pci_config_writeb(0x31): bdf: 0x0000 pam: 0x0000005b
> > 
> > is executed to mark an pc.ram area 0xc0000 as readonly:
> > 
> > Entering vhost_begin >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> > Entering vhost_region_del section: 0x7fd037a4bb60 offset_within_region:
> > 0xc0000 size: 2146697216 readonly: 0
> > vhost_region_del: is_rom: 0, rom_device: 0
> > vhost_region_del: readable: 1
> > vhost_region_del: ram_addr 0x0, addr: 0x0 size: 2147483648
> > vhost_region_del: name: pc.ram
> > Entering vhost_set_memory, section: 0x7fd037a4bb60 add: 0, dev->started: 1
> > vhost_set_memory: Setting dev->memory_changed = true for start_addr:
> > 0xc0000
> > Entering vhost_region_add section: 0x7fd037a4baa0 offset_within_region:
> > 0xc0000 size: 32768 readonly: 1
> > vhost_region_add is readonly !!!!!!!!!!!!!!!!!!!
> > vhost_region_add: is_rom: 0, rom_device: 0
> > vhost_region_add: readable: 1
> > vhost_region_add: ram_addr 0x0000000000000000, addr: 0x               0
> > size: 2147483648
> > vhost_region_add: name: pc.ram
> > Entering vhost_set_memory, section: 0x7fd037a4baa0 add: 1, dev->started: 1
> > vhost_dev_assign_memory(); >>>>>>>>>>>>>>>>>>>>>>>>>>>>
> > reg->guest_phys_addr: 0xc0000
> > vhost_set_memory: Setting dev->memory_changed = true for start_addr:
> > 0xc0000
> > Entering vhost_region_add section: 0x7fd037a4baa0 offset_within_region:
> > 0xc8000 size: 2146664448 readonly: 0
> > vhost_region_add: is_rom: 0, rom_device: 0
> > vhost_region_add: readable: 1
> > vhost_region_add: ram_addr 0x0000000000000000, addr: 0x               0
> > size: 2147483648
> > vhost_region_add: name: pc.ram
> > Entering vhost_set_memory, section: 0x7fd037a4baa0 add: 1, dev->started: 1
> > vhost_set_memory: Setting dev->memory_changed = true for start_addr:
> > 0xc8000
> > phys_page_find got PHYS_MAP_NODE_NIL >>>>>>>>>>>>>>>>>>>>>>..
> > Entering vhost_commit >>>>>>>>>>>>>>>>>>>>>>>>>>>
> > 
> > Note that originally we'd see the cpu_physical_memory_map() failure in
> > vhost_verify_ring_mappings() after the first ->region_del() above.
> > 
> > So, does using a ->commit callback for MemoryListener  mean that
> > vhost_verify_ring_mappings() is OK to be called only from the final
> > ->commit callback, and not from each ->region_del + ->region_add
> > callback..?   Eg: I seem to recall something about
> > vhost_verify_ring_mappings() being called during each ->region_del()
> > when dev->started == true was important, no..?

It is important in the case there are only some deleted regions, and
no added region, or in general when the last callback is a ->region_del().

But it is even better to just call vhost_verify_ring_mappings() once,
from the ->region_commit() callback.

> > If this OK, then it seems a matter of keeping an updated bit for each of
> > the regions in vhost_dev->mem_sections[] and performing the
> > vhost_verify_ring_mappings() on all three above during the final
> > ->commit() call, right..?
> 
> Or even better, what about just invoking vhost_verify_ring_mappings()
> once from ->commit without section start_addr+size + drop the existing
> !rings_overlap check..?

Either drop the ranges_overlap check, or keep the start_addr/end_addr
up-to-date.  Compared to Michael's prototype patch, that would be like
this:

   vhost_begin()
   {
       dev->mem_changed_end_addr = 0;
       dev->mem_changed_start_addr = -1;
   }

   vhost_set_memory()
   {
       ...
       dev->mem_changed_start_addr = MIN(dev->mem_changed_start_addr, start_addr);
       dev->mem_changed_end_addr = MAX(dev->mem_changed_end_addr, start_addr + size - 1);
   }

   vhost_commit()
   {
       if (dev->mem_changed_start_addr > dev->mem_changed_end_addr) {
           return;
       }
       start_addr = dev->mem_changed_start_addr;
       size = dev->mem_changed_end_addr - dev->mem_changed_start_addr + 1;
       ...
   }

Paolo

> Does the following look like you'd expect for marking 0xc0000 area as
> read-only case..?
> 
> Entering vhost_begin >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> Entering vhost_region_del section: 0x7f16d3a1db60 offset_within_region:
> 0xc0000 size: 2146697216 readonly: 0
> vhost_region_del: is_rom: 0, rom_device: 0
> vhost_region_del: readable: 1
> vhost_region_del: ram_addr 0x0, addr: 0x0 size: 2147483648
> vhost_region_del: name: pc.ram
> Entering vhost_set_memory, section: 0x7f16d3a1db60 add: 0, dev->started: 1
> vhost_set_memory: Setting dev->memory_changed = true for start_addr: 0xc0000
> Entering vhost_region_add section: 0x7f16d3a1daa0 offset_within_region:
> 0xc0000 size: 32768 readonly: 1
> vhost_region_add is readonly !!!!!!!!!!!!!!!!!!!
> vhost_region_add: is_rom: 0, rom_device: 0
> vhost_region_add: readable: 1
> vhost_region_add: ram_addr 0x0000000000000000, addr: 0x               0 size:
> 2147483648
> vhost_region_add: name: pc.ram
> Entering vhost_set_memory, section: 0x7f16d3a1daa0 add: 1, dev->started: 1
> vhost_dev_assign_memory(); >>>>>>>>>>>>>>>>>>>>>>>>>>>> reg->guest_phys_addr:
> 0xc0000
> vhost_set_memory: Setting dev->memory_changed = true for start_addr: 0xc0000
> Entering vhost_region_add section: 0x7f16d3a1daa0 offset_within_region:
> 0xc8000 size: 2146664448 readonly: 0
> vhost_region_add: is_rom: 0, rom_device: 0
> vhost_region_add: readable: 1
> vhost_region_add: ram_addr 0x0000000000000000, addr: 0x               0 size:
> 2147483648
> vhost_region_add: name: pc.ram
> Entering vhost_set_memory, section: 0x7f16d3a1daa0 add: 1, dev->started: 1
> vhost_set_memory: Setting dev->memory_changed = true for start_addr: 0xc8000
> phys_page_find got PHYS_MAP_NODE_NIL >>>>>>>>>>>>>>>>>>>>>>..
> Entering vhost_commit >>>>>>>>>>>>>>>>>>>>>>>>>>>
> vhost_commit, skipping vhost_verify_ring_mappings without start_addr
> !!!!!!!!!!!!!
> Entering verify_ring_mappings: start_addr 0x0000000000000000 size: 0
> verify_ring_mappings: ring_phys 0x0 ring_size: 0
> verify_ring_mappings: ring_phys 0x0 ring_size: 0
> verify_ring_mappings: ring_phys 0xed000 ring_size: 5124
> verify_ring_mappings: calling cpu_physical_memory_map ring_phys: 0xed000 l:
> 5124
> address_space_map: addr: 0xed000, plen: 5124
> address_space_map: l: 4096, len: 5124
> address_space_map: section: 0x7f16d92c6020 memory_region_is_ram: 1 readonly:
> 0
> address_space_map: section: 0x7f16d92c6020 offset_within_region: 0xc8000
> section size: 2146664448
> address_space_map: l: 4096, len: 1028
> address_space_map: section: 0x7f16d92c6020 memory_region_is_ram: 1 readonly:
> 0
> address_space_map: section: 0x7f16d92c6020 offset_within_region: 0xc8000
> section size: 2146664448
> address_space_map: Calling qemu_ram_ptr_length: raddr: 0x           ed000
> rlen: 5124
> address_space_map: After qemu_ram_ptr_length: raddr: 0x           ed000 rlen:
> 5124
> 
> 
