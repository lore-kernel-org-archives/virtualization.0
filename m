From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] 9p/trans_virtio.c: Fix broken zero-copy on vmalloc()
	buffers
Date: Fri, 6 Dec 2013 16:29:37 +0000
Message-ID: <20131206162937.GB12376@mudshark.cambridge.arm.com>
References: <1386189798-22157-1-git-send-email-ryao@gentoo.org>
	<20131206111422.GB16079@mudshark.cambridge.arm.com>
	<52A1E164.20006@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <52A1E164.20006@gentoo.org>
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

On Fri, Dec 06, 2013 at 02:38:28PM +0000, Richard Yao wrote:
> On 12/06/2013 06:14 AM, Will Deacon wrote:
> > On Wed, Dec 04, 2013 at 08:43:18PM +0000, Richard Yao wrote:
> >> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> >> index 9c5a1aa..5d1d04b 100644
> >> --- a/net/9p/trans_virtio.c
> >> +++ b/net/9p/trans_virtio.c
> >> @@ -340,7 +340,10 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
> >>  		int count = nr_pages;
> >>  		while (nr_pages) {
> >>  			s = rest_of_page(data);
> >> -			pages[index++] = kmap_to_page(data);
> >> +			if (is_vmalloc_or_module_addr(data))
> > 
> > Can this really end up being a module address?
> 
> Yes. Here is the stacktrace to prove it:
> 
> [<ffffffff814878ce>] p9_virtio_zc_request+0x45e/0x510
> [<ffffffff814814ed>] p9_client_zc_rpc.constprop.16+0xfd/0x4f0
> [<ffffffff814839dd>] p9_client_read+0x15d/0x240
> [<ffffffff811c8440>] v9fs_fid_readn+0x50/0xa0
> [<ffffffff811c84a0>] v9fs_file_readn+0x10/0x20
> [<ffffffff811c84e7>] v9fs_file_read+0x37/0x70
> [<ffffffff8114e3fb>] vfs_read+0x9b/0x160
> [<ffffffff81153571>] kernel_read+0x41/0x60
> [<ffffffff810c83ab>] copy_module_from_fd.isra.34+0xfb/0x180
> [<ffffffff810cc420>] SyS_finit_module+0x70/0xd0
> [<ffffffff814a08fd>] system_call_fastpath+0x1a/0x1f
> [<ffffffffffffffff>] 0xffffffffffffffff
> 
> This is easily reproducible by trying to load a module off virtfs. QEMU
> will print the message that I cited in the commit message and then kill
> itself.

Ok, thanks for confirming!

In which case, this patch looks fine to me:

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
