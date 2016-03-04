From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [Qemu-devel] [RFC qemu 4/4] migration: filter out guest's free
	pages in ram bulk stage
Date: Fri, 4 Mar 2016 02:43:49 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E03770FEA__16292.1809395359$1457059452$gmane$org@SHSMSX101.ccr.corp.intel.com>
References: <1457001868-15949-1-git-send-email-liang.z.li@intel.com>
	<1457001868-15949-5-git-send-email-liang.z.li@intel.com>
	<20160303124520.GE32270@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160303124520.GE32270@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

> On Thu, Mar 03, 2016 at 06:44:28PM +0800, Liang Li wrote:
> > Get the free pages information through virtio and filter out the free
> > pages in the ram bulk stage. This can significantly reduce the total
> > live migration time as well as network traffic.
> >
> > Signed-off-by: Liang Li <liang.z.li@intel.com>
> > ---
> >  migration/ram.c | 52
> > ++++++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 46 insertions(+), 6 deletions(-)
> 
> > @@ -1945,6 +1971,20 @@ static int ram_save_setup(QEMUFile *f, void
> *opaque)
> >                                              DIRTY_MEMORY_MIGRATION);
> >      }
> >      memory_global_dirty_log_start();
> > +
> > +    if (balloon_free_pages_support() &&
> > +        balloon_get_free_pages(migration_bitmap_rcu->free_pages_bmap,
> > +                               &free_pages_count) == 0) {
> > +        qemu_mutex_unlock_iothread();
> > +        while (balloon_get_free_pages(migration_bitmap_rcu-
> >free_pages_bmap,
> > +                                      &free_pages_count) == 0) {
> > +            usleep(1000);
> > +        }
> > +        qemu_mutex_lock_iothread();
> > +
> > +        filter_out_guest_free_pages(migration_bitmap_rcu-
> >free_pages_bmap);
> > +    }
> 
> IIUC, this code is synchronous wrt to the guest OS balloon drive. ie it is asking
> the geust for free pages and waiting for a response. If the guest OS has
> crashed this is going to mean QEMU waits forever and thus migration won't
> complete. Similarly you need to consider that the guest OS may be malicious
> and simply never respond.
> 
> So if the migration code is going to use the guest balloon driver to get info
> about free pages it has to be done in an asynchronous manner so that
> migration can never be stalled by a slow/crashed/malicious guest driver.
> 
> Regards,
> Daniel

Really,  thanks a lot!

Liang
