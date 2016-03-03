From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [RFC qemu 4/4] migration: filter out guest's free pages in ram
	bulk stage
Date: Thu, 3 Mar 2016 13:16:16 +0100
Message-ID: <20160303131616.753f1de5.cornelia.huck@de.ibm.com>
References: <1457001868-15949-1-git-send-email-liang.z.li@intel.com>
	<1457001868-15949-5-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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

On Thu,  3 Mar 2016 18:44:28 +0800
Liang Li <liang.z.li@intel.com> wrote:

> Get the free pages information through virtio and filter out the free
> pages in the ram bulk stage. This can significantly reduce the total
> live migration time as well as network traffic.
> 
> Signed-off-by: Liang Li <liang.z.li@intel.com>
> ---
>  migration/ram.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 46 insertions(+), 6 deletions(-)
> 

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

A general comment: Using the ballooner to get information about pages
that can be filtered out is too limited (there may be other ways to do
this; we might be able to use cmma on s390, for example), and I don't
like hardcoding to a specific method.

What about the reverse approach: Code may register a handler that
populates the free_pages_bitmap which is called during this stage?

<I like the idea of filtering in general, but I haven't looked at the
code yet>

> +    }
> +
>      migration_bitmap_sync();
>      qemu_mutex_unlock_ramlist();
>      qemu_mutex_unlock_iothread();
