From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] tools/virtio: Fix build
Date: Sun, 13 Oct 2019 08:20:46 -0400
Message-ID: <20191013081541-mutt-send-email-mst__12255.8760269143$1570969727$gmane$org@kernel.org>
References: <4b686914-075b-a0a9-c97b-9def82ee0336@web.de>
	<20191013075107-mutt-send-email-mst@kernel.org>
	<08c1e081-765b-7c3a-ed31-2059dc521fd0@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <08c1e081-765b-7c3a-ed31-2059dc521fd0@web.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Oct 13, 2019 at 02:01:03PM +0200, Jan Kiszka wrote:
> On 13.10.19 13:52, Michael S. Tsirkin wrote:
> > On Sun, Oct 13, 2019 at 11:03:30AM +0200, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> Various changes in the recent kernel versions broke the build due to
> >> missing function and header stubs.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >
> > Thanks!
> > I think it's already fixes in the vhost tree.
> > That tree also includes a bugfix for the test.
> > Can you pls give it a spin and report?
> 
> Mostly fixed: the xen_domain stup is missing.
> 
> Jan

That's in xen/xen.h. Do you still see any build errors?

> > Thanks!
> >
> >> ---
> >>  tools/virtio/crypto/hash.h       | 0
> >>  tools/virtio/linux/dma-mapping.h | 2 ++
> >>  tools/virtio/linux/kernel.h      | 2 ++
> >>  3 files changed, 4 insertions(+)
> >>  create mode 100644 tools/virtio/crypto/hash.h
> >>
> >> diff --git a/tools/virtio/crypto/hash.h b/tools/virtio/crypto/hash.h
> >> new file mode 100644
> >> index 000000000000..e69de29bb2d1
> >> diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-mapping.h
> >> index f91aeb5fe571..db96cb4bf877 100644
> >> --- a/tools/virtio/linux/dma-mapping.h
> >> +++ b/tools/virtio/linux/dma-mapping.h
> >> @@ -29,4 +29,6 @@ enum dma_data_direction {
> >>  #define dma_unmap_single(...) do { } while (0)
> >>  #define dma_unmap_page(...) do { } while (0)
> >>
> >> +#define dma_max_mapping_size(d)	0
> >> +
> >>  #endif
> >> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> >> index 6683b4a70b05..ccf321173210 100644
> >> --- a/tools/virtio/linux/kernel.h
> >> +++ b/tools/virtio/linux/kernel.h
> >> @@ -141,4 +141,6 @@ static inline void free_page(unsigned long addr)
> >>  #define list_for_each_entry(a, b, c) while (0)
> >>  /* end of stubs */
> >>
> >> +#define xen_domain() 0
> >> +
> >>  #endif /* KERNEL_H */
> >> --
> >> 2.16.4
