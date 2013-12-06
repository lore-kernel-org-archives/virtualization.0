From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] 9p/trans_virtio.c: Fix broken zero-copy on vmalloc()
	buffers
Date: Fri, 6 Dec 2013 11:14:22 +0000
Message-ID: <20131206111422.GB16079@mudshark.cambridge.arm.com>
References: <1386189798-22157-1-git-send-email-ryao@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1386189798-22157-1-git-send-email-ryao@gentoo.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Richard Yao <ryao@gentoo.org>
Cc: Eric Van Hensbergen <ericvh@gmail.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kernel@gentoo.org" <kernel@gentoo.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Ron Minnich <rminnich@sandia.gov>, "v9fs-developer@lists.sourceforge.net" <v9fs-developer@lists.sourceforge.net>, Brian Behlendorf <behlendorf1@llnl.gov>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 04, 2013 at 08:43:18PM +0000, Richard Yao wrote:
> The 9p-virtio transport does zero copy on things larger than 1024 bytes
> in size. It accomplishes this by returning the physical addresses of
> pages to the virtio-pci device. At present, the translation is usually a
> bit shift.
> 
> However, that approach produces an invalid page address when we
> read/write to vmalloc buffers, such as those used for Linux kernle
> modules. This causes QEMU to die printing:
> 
> qemu-system-x86_64: virtio: trying to map MMIO memory
> 
> This patch enables 9p-virtio to correctly handle this case. This not
> only enables us to load Linux kernel modules off virtfs, but also
> enables ZFS file-based vdevs on virtfs to be used without killing QEMU.
> 
> Also, special thanks to both Avi Kivity and Alexander Graf for their
> interpretation of QEMU backtraces. Without their guidence, tracking down
> this bug would have taken much longer.
> 
> Signed-off-by: Richard Yao <ryao@gentoo.org>
> ---
>  net/9p/trans_virtio.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 9c5a1aa..5d1d04b 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -340,7 +340,10 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
>  		int count = nr_pages;
>  		while (nr_pages) {
>  			s = rest_of_page(data);
> -			pages[index++] = kmap_to_page(data);
> +			if (is_vmalloc_or_module_addr(data))

Can this really end up being a module address?

Will
