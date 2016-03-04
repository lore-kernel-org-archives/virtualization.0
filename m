From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [Qemu-devel] [RFC qemu 0/4] A PV solution for live migration
	optimization
Date: Fri, 4 Mar 2016 15:13:03 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E04145231__48111.1818146475$1457104402$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1457001868-15949-1-git-send-email-liang.z.li@intel.com>
	<20160303174615.GF2115@work-vm> <20160304075538.GC9100@rkaganb.sw.ru>
	<F2CBF3009FA73547804AE4C663CAB28E037714DA@SHSMSX101.ccr.corp.intel.com>
	<20160304083550.GE9100@rkaganb.sw.ru> <20160304090820.GA2149@work-vm>
	<F2CBF3009FA73547804AE4C663CAB28E03771639@SHSMSX101.ccr.corp.intel.com>
	<20160304114519-mutt-send-email-mst@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E037717B5@SHSMSX101.ccr.corp.intel.com>
	<20160304122456-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160304122456-mutt-send-email-mst@redhat.com>
Content-Language: en-US
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Roman Kagan <rkagan@virtuozzo.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "rth@twiddle.net" <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

> > Maybe I am not clear enough.
> >
> > I mean if we inflate balloon before live migration, for a 8GB guest, it takes
> about 5 Seconds for the inflating operation to finish.
> 
> And these 5 seconds are spent where?
> 

The time is spent on allocating the pages and send the allocated pages pfns to QEMU
through virtio.

> > For the PV solution, there is no need to inflate balloon before live
> > migration, the only cost is to traversing the free_list to  construct
> > the free pages bitmap, and it takes about 20ms for a 8GB idle guest( less if
> there is less free pages),  passing the free pages info to host will take about
> extra 3ms.
> >
> >
> > Liang
> 
> So now let's please stop talking about solutions at a high level and discuss the
> interface changes you make in detail.
> What makes it faster? Better host/guest interface? No need to go through
> buddy allocator within guest? Less interrupts? Something else?
> 

I assume you are familiar with the current virtio-balloon and how it works. 
The new interface is very simple, send a request to the virtio-balloon driver,
The virtio-driver will travers the '&zone->free_area[order].free_list[t])' to 
construct a 'free_page_bitmap', and then the driver will send the content
of  'free_page_bitmap' back to QEMU. That all the new interface does and
there are no ' alloc_page' related affairs, so it's faster.


Some code snippet:
----------------------------------------------
+static void mark_free_pages_bitmap(struct zone *zone,
+		 unsigned long *free_page_bitmap, unsigned long pfn_gap) {
+	unsigned long pfn, flags, i;
+	unsigned int order, t;
+	struct list_head *curr;
+
+	if (zone_is_empty(zone))
+		return;
+
+	spin_lock_irqsave(&zone->lock, flags);
+
+	for_each_migratetype_order(order, t) {
+		list_for_each(curr, &zone->free_area[order].free_list[t]) {
+
+			pfn = page_to_pfn(list_entry(curr, struct page, lru));
+			for (i = 0; i < (1UL << order); i++) {
+				if ((pfn + i) >= PFN_4G)
+					set_bit_le(pfn + i - pfn_gap,
+						   free_page_bitmap);
+				else
+					set_bit_le(pfn + i, free_page_bitmap);
+			}
+		}
+	}
+
+	spin_unlock_irqrestore(&zone->lock, flags); }
----------------------------------------------------
Sorry for my poor English and expression, if you still can't understand,
you could glance at the patch, total about 400 lines.
> 
> > > --
> > > MST
