From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [Qemu-devel] [RFC qemu 4/4] migration: filter out guest's free
	pages in ram bulk stage
Date: Thu, 3 Mar 2016 12:45:20 +0000
Message-ID: <20160303124520.GE32270__25561.0035303564$1457009152$gmane$org@redhat.com>
References: <1457001868-15949-1-git-send-email-liang.z.li@intel.com>
	<1457001868-15949-5-git-send-email-liang.z.li@intel.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1457001868-15949-5-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Liang Li <liang.z.li@intel.com>
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, linux-mm@kvack.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, dgilbert@redhat.com, rth@twiddle.net
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 03, 2016 at 06:44:28PM +0800, Liang Li wrote:
> Get the free pages information through virtio and filter out the free
> pages in the ram bulk stage. This can significantly reduce the total
> live migration time as well as network traffic.
> 
> Signed-off-by: Liang Li <liang.z.li@intel.com>
> ---
>  migration/ram.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 46 insertions(+), 6 deletions(-)

> @@ -1945,6 +1971,20 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>                                              DIRTY_MEMORY_MIGRATION);
>      }
>      memory_global_dirty_log_start();
> +
> +    if (balloon_free_pages_support() &&
> +        balloon_get_free_pages(migration_bitmap_rcu->free_pages_bmap,
> +                               &free_pages_count) == 0) {
> +        qemu_mutex_unlock_iothread();
> +        while (balloon_get_free_pages(migration_bitmap_rcu->free_pages_bmap,
> +                                      &free_pages_count) == 0) {
> +            usleep(1000);
> +        }
> +        qemu_mutex_lock_iothread();
> +
> +        filter_out_guest_free_pages(migration_bitmap_rcu->free_pages_bmap);
> +    }

IIUC, this code is synchronous wrt to the guest OS balloon drive. ie it
is asking the geust for free pages and waiting for a response. If the
guest OS has crashed this is going to mean QEMU waits forever and thus
migration won't complete. Similarly you need to consider that the guest
OS may be malicious and simply never respond.

So if the migration code is going to use the guest balloon driver to get
info about free pages it has to be done in an asynchronous manner so that
migration can never be stalled by a slow/crashed/malicious guest driver.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|
