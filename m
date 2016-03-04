From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [RFC qemu 0/4] A PV solution for live migration
	optimization
Date: Fri, 4 Mar 2016 16:45:29 +0200
Message-ID: <20160304163246-mutt-send-email-mst@redhat.com>
References: <1457001868-15949-1-git-send-email-liang.z.li@intel.com>
	<20160303174615.GF2115@work-vm>
	<F2CBF3009FA73547804AE4C663CAB28E03770E33@SHSMSX101.ccr.corp.intel.com>
	<20160304081411.GD9100@rkaganb.sw.ru>
	<F2CBF3009FA73547804AE4C663CAB28E0377160A@SHSMSX101.ccr.corp.intel.com>
	<20160304102346.GB2479@rkaganb.sw.ru>
	<F2CBF3009FA73547804AE4C663CAB28E0414516C@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E0414516C@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Li, Liang Z" <liang.z.li@intel.com>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Roman Kagan <rkagan@virtuozzo.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "rth@twiddle.net" <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 04, 2016 at 02:26:49PM +0000, Li, Liang Z wrote:
> > Subject: Re: [Qemu-devel] [RFC qemu 0/4] A PV solution for live migration
> > optimization
> > 
> > On Fri, Mar 04, 2016 at 09:08:44AM +0000, Li, Liang Z wrote:
> > > > On Fri, Mar 04, 2016 at 01:52:53AM +0000, Li, Liang Z wrote:
> > > > > >   I wonder if it would be possible to avoid the kernel changes
> > > > > > by parsing /proc/self/pagemap - if that can be used to detect
> > > > > > unmapped/zero mapped pages in the guest ram, would it achieve
> > > > > > the
> > > > same result?
> > > > >
> > > > > Only detect the unmapped/zero mapped pages is not enough.
> > Consider
> > > > the
> > > > > situation like case 2, it can't achieve the same result.
> > > >
> > > > Your case 2 doesn't exist in the real world.  If people could stop
> > > > their main memory consumer in the guest prior to migration they
> > > > wouldn't need live migration at all.
> > >
> > > The case 2 is just a simplified scenario, not a real case.
> > > As long as the guest's memory usage does not keep increasing, or not
> > > always run out, it can be covered by the case 2.
> > 
> > The memory usage will keep increasing due to ever growing caches, etc, so
> > you'll be left with very little free memory fairly soon.
> > 
> 
> I don't think so.

Here's my laptop:
KiB Mem : 16048560 total,  8574956 free,  3360532 used,  4113072 buff/cache

But here's a server:
KiB Mem:  32892768 total, 20092812 used, 12799956 free,   368704 buffers

What is the difference? A ton of tiny daemons not doing anything,
staying resident in memory.

> > > > I tend to think you can safely assume there's no free memory in the
> > > > guest, so there's little point optimizing for it.
> > >
> > > If this is true, we should not inflate the balloon either.
> > 
> > We certainly should if there's "available" memory, i.e. not free but cheap to
> > reclaim.
> > 
> 
> What's your mean by "available" memory? if they are not free, I don't think it's cheap.

clean pages are cheap to drop as they don't have to be written.
whether they will be ever be used is another matter.

> > > > OTOH it makes perfect sense optimizing for the unmapped memory
> > > > that's made up, in particular, by the ballon, and consider inflating
> > > > the balloon right before migration unless you already maintain it at
> > > > the optimal size for other reasons (like e.g. a global resource manager
> > optimizing the VM density).
> > > >
> > >
> > > Yes, I believe the current balloon works and it's simple. Do you take the
> > performance impact for consideration?
> > > For and 8G guest, it takes about 5s to  inflating the balloon. But it
> > > only takes 20ms to  traverse the free_list and construct the free pages
> > bitmap.
> > 
> > I don't have any feeling of how important the difference is.  And if the
> > limiting factor for balloon inflation speed is the granularity of communication
> > it may be worth optimizing that, because quick balloon reaction may be
> > important in certain resource management scenarios.
> > 
> > > By inflating the balloon, all the guest's pages are still be processed (zero
> > page checking).
> > 
> > Not sure what you mean.  If you describe the current state of affairs that's
> > exactly the suggested optimization point: skip unmapped pages.
> > 
> 
> You'd better check the live migration code.

What's there to check in migration code?
Here's the extent of what balloon does on output:


        while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) == 4) {
            ram_addr_t pa;
            ram_addr_t addr;
            int p = virtio_ldl_p(vdev, &pfn);

            pa = (ram_addr_t) p << VIRTIO_BALLOON_PFN_SHIFT;
            offset += 4;

            /* FIXME: remove get_system_memory(), but how? */
            section = memory_region_find(get_system_memory(), pa, 1);
            if (!int128_nz(section.size) || !memory_region_is_ram(section.mr))
                continue;

            trace_virtio_balloon_handle_output(memory_region_name(section.mr),
                                               pa);
            /* Using memory_region_get_ram_ptr is bending the rules a bit, but
               should be OK because we only want a single page.  */
            addr = section.offset_within_region;
            balloon_page(memory_region_get_ram_ptr(section.mr) + addr,
                         !!(vq == s->dvq));
            memory_region_unref(section.mr);
        }

so all that happens when we get a page is balloon_page.
and

static void balloon_page(void *addr, int deflate)
{
#if defined(__linux__)
    if (!qemu_balloon_is_inhibited() && (!kvm_enabled() ||
                                         kvm_has_sync_mmu())) {
        qemu_madvise(addr, TARGET_PAGE_SIZE,
                deflate ? QEMU_MADV_WILLNEED : QEMU_MADV_DONTNEED);
    }
#endif
}


Do you see anything that tracks pages to help migration skip
the ballooned memory? I don't.



> > > The only advantage of ' inflating the balloon before live migration' is simple,
> > nothing more.
> > 
> > That's a big advantage.  Another one is that it does something useful in real-
> > world scenarios.
> > 
> 
> I don't think the heave performance impaction is something useful in real world scenarios.
> 
> Liang
> > Roman.

So fix the performance then. You will have to try harder if you want to
convince people that the performance is due to bad host/guest interface,
and so we have to change *that*.

-- 
MST
