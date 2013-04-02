From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V3 WIP 3/3] disable vhost_verify_ring_mappings check
Date: Tue, 2 Apr 2013 16:27:29 +0300
Message-ID: <20130402132729.GK21545@redhat.com>
References: <8300718.16452772.1364465611936.JavaMail.root@redhat.com>
	<1364525606.10253.69.camel@haakon2.linux-iscsi.org>
	<51554D56.5080004@redhat.com>
	<1364864747.3898.8.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1364864747.3898.8.camel@haakon2.linux-iscsi.org>
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
Cc: Kevin O'Connor <kevin@koconnor.net>, kvm@vger.kernel.org, seabios-devel <seabios@seabios.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 01, 2013 at 06:05:47PM -0700, Nicholas A. Bellinger wrote:
> On Fri, 2013-03-29 at 09:14 +0100, Paolo Bonzini wrote: 
> > Il 29/03/2013 03:53, Nicholas A. Bellinger ha scritto:
> > > On Thu, 2013-03-28 at 06:13 -0400, Paolo Bonzini wrote:
> > >>> I think it's the right thing to do, but maybe not the right place
> > >>> to do this, need to reset after all IO is done, before
> > >>> ring memory is write protected.
> > >>
> > >> Our emails are crossing each other unfortunately, but I want to
> > >> reinforce this: ring memory is not write protected.
> > > 
> > > Understood.  However, AFAICT the act of write protecting these ranges
> > > for ROM generates the offending callbacks to vhost_set_memory().
> > > 
> > > The part that I'm missing is if ring memory is not being write protected
> > > by make_bios_readonly_intel(), why are the vhost_set_memory() calls
> > > being invoked..?
> > 
> > Because mappings change for the region that contains the ring.  vhost
> > doesn't know yet that the changes do not affect ring memory,
> > vhost_set_memory() is called exactly to ascertain that.
> > 
> 
> Hi Paolo & Co,
> 
> Here's a bit more information on what is going on with the same
> cpu_physical_memory_map() failure in vhost_verify_ring_mappings()..
> 
> So as before, at the point that seabios is marking memory as readonly
> for ROM in src/shadow.c:make_bios_readonly_intel() with the following
> call:
> 
> Calling pci_config_writeb(0x31): bdf: 0x0000 pam: 0x0000005b
> 
> the memory API update hook triggers back into vhost_region_del() code,
> and following occurs:
> 
> Entering vhost_region_del section: 0x7fd30a213b60 offset_within_region: 0xc0000 size: 2146697216 readonly: 0
> vhost_region_del: is_rom: 0, rom_device: 0
> vhost_region_del: readable: 1
> vhost_region_del: ram_addr 0x0, addr: 0x0 size: 2147483648
> vhost_region_del: name: pc.ram
> Entering vhost_set_memory, section: 0x7fd30a213b60 add: 0, dev->started: 1
> Entering verify_ring_mappings: start_addr 0x00000000000c0000 size: 2146697216
> verify_ring_mappings: ring_phys 0x0 ring_size: 0
> verify_ring_mappings: ring_phys 0x0 ring_size: 0
> verify_ring_mappings: ring_phys 0xed000 ring_size: 5124
> verify_ring_mappings: calling cpu_physical_memory_map ring_phys: 0xed000 l: 5124
> address_space_map: addr: 0xed000, plen: 5124
> address_space_map: l: 4096, len: 5124
> phys_page_find got PHYS_MAP_NODE_NIL >>>>>>>>>>>>>>>>>>>>>>..
> address_space_map: section: 0x7fd30fabaed0 memory_region_is_ram: 0 readonly: 0
> address_space_map: section: 0x7fd30fabaed0 offset_within_region: 0x0 section size: 18446744073709551615
> Unable to map ring buffer for ring 2, l: 4096
> 
> So the interesting part is that phys_page_find() is not able to locate
> the corresponding page for vq->ring_phys: 0xed000 from the
> vhost_region_del() callback with section->offset_within_region:
> 0xc0000..
> 
> Is there any case where this would not be considered a bug..? 
> 
> register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
> register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
> register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
> Entering vhost_region_add section: 0x7fd30a213aa0 offset_within_region: 0xc0000 size: 32768 readonly: 1
> vhost_region_add: is_rom: 0, rom_device: 0
> vhost_region_add: readable: 1
> vhost_region_add: ram_addr 0x0000000000000000, addr: 0x               0 size: 2147483648
> vhost_region_add: name: pc.ram
> Entering vhost_set_memory, section: 0x7fd30a213aa0 add: 1, dev->started: 1
> Entering verify_ring_mappings: start_addr 0x00000000000c0000 size: 32768
> verify_ring_mappings: ring_phys 0x0 ring_size: 0
> verify_ring_mappings: ring_phys 0x0 ring_size: 0
> verify_ring_mappings: ring_phys 0xed000 ring_size: 5124
> verify_ring_mappings: Got !ranges_overlap, skipping
> register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
> Entering vhost_region_add section: 0x7fd30a213aa0 offset_within_region: 0xc8000 size: 2146664448 readonly: 0
> vhost_region_add: is_rom: 0, rom_device: 0
> vhost_region_add: readable: 1
> vhost_region_add: ram_addr 0x0000000000000000, addr: 0x               0 size: 2147483648
> vhost_region_add: name: pc.ram
> Entering vhost_set_memory, section: 0x7fd30a213aa0 add: 1, dev->started: 1
> Entering verify_ring_mappings: start_addr 0x00000000000c8000 size: 2146664448
> verify_ring_mappings: ring_phys 0x0 ring_size: 0
> verify_ring_mappings: ring_phys 0x0 ring_size: 0
> verify_ring_mappings: ring_phys 0xed000 ring_size: 5124
> verify_ring_mappings: calling cpu_physical_memory_map ring_phys: 0xed000 l: 5124
> address_space_map: addr: 0xed000, plen: 5124
> address_space_map: l: 4096, len: 5124
> address_space_map: section: 0x7fd30fabb020 memory_region_is_ram: 1 readonly: 0
> address_space_map: section: 0x7fd30fabb020 offset_within_region: 0xc8000 section size: 2146664448
> address_space_map: l: 4096, len: 1028
> address_space_map: section: 0x7fd30fabb020 memory_region_is_ram: 1 readonly: 0
> address_space_map: section: 0x7fd30fabb020 offset_within_region: 0xc8000 section size: 2146664448
> address_space_map: Calling qemu_ram_ptr_length: raddr: 0x           ed000 rlen: 5124
> address_space_map: After qemu_ram_ptr_length: raddr: 0x           ed000 rlen: 5124
> 
> So here the vhost_region_add() callback for
> section->offset_within_region: 0xc8000 for vq->ring_phys: 0xed000 is
> able to locate *section via phys_page_find() within address_space_map(),
> and cpu_physical_memory_map() completes as expected..
> 
> register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
> register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
> register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
> register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
> register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
> register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
> register_multipage : d: 0x7fd30f7d0ed0 section: 0x7fd30a2139b0
> phys_page_find got PHYS_MAP_NODE_NIL >>>>>>>>>>>>>>>>>>>>>>..
> 
> So while plodding my way through the memory API, the thing that would be
> useful to know is if the offending *section that is missing for the
> first phys_page_find() call is getting removed before the callback makes
> it's way into vhost_verify_ring_mappings() code, or that some other bug
> is occuring..?
> 
> Any idea on how this could be verified..?
> 
> Thanks,
> 
> --nab

Is it possible that what is going on here,
is that we had a region at address 0x0 size 0x80000000,
and now a chunk from it is being made readonly,
and to this end the whole old region is removed
then new ones are added?

If yes maybe the problem is that we don't use the atomic
begin/commit ops in the memory API.
Maybe the following will help?
Completely untested, posting just to give you the idea:

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/hw/vhost.c b/hw/vhost.c
index 4d6aee3..716cfaa 100644
--- a/hw/vhost.c
+++ b/hw/vhost.c
@@ -416,6 +416,25 @@ static void vhost_set_memory(MemoryListener *listener,
         /* Remove old mapping for this memory, if any. */
         vhost_dev_unassign_memory(dev, start_addr, size);
     }
+    dev->memory_changed = true;
+}
+
+static bool vhost_section(MemoryRegionSection *section)
+{
+    return memory_region_is_ram(section->mr);
+}
+
+static void vhost_begin(MemoryListener *listener)
+{
+}
+
+static void vhost_commit(MemoryListener *listener)
+{
+    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
+                                         memory_listener);
+    if (!dev->memory_changed) {
+        return;
+    }
 
     if (!dev->started) {
         return;
@@ -445,19 +464,7 @@ static void vhost_set_memory(MemoryListener *listener,
     if (dev->log_size > log_size + VHOST_LOG_BUFFER) {
         vhost_dev_log_resize(dev, log_size);
     }
-}
-
-static bool vhost_section(MemoryRegionSection *section)
-{
-    return memory_region_is_ram(section->mr);
-}
-
-static void vhost_begin(MemoryListener *listener)
-{
-}
-
-static void vhost_commit(MemoryListener *listener)
-{
+    dev->memory_changed = false;
 }
 
 static void vhost_region_add(MemoryListener *listener,
@@ -842,6 +849,7 @@ int vhost_dev_init(struct vhost_dev *hdev, int devfd, const char *devpath,
     hdev->log_size = 0;
     hdev->log_enabled = false;
     hdev->started = false;
+    hdev->memory_changed = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
     hdev->force = force;
     return 0;
