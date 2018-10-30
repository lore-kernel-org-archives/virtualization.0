From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: virtio-gpu without ARCH_HAS_SG_CHAIN
Date: Tue, 30 Oct 2018 08:23:44 +0100
Message-ID: <20181030072344.sstmq6jxcmyzbqmr__32457.1396843114$1540884123$gmane$org@sirius.home.kraxel.org>
References: <CAGw6cBsWHB4aRf=kPoT+v-FbtL0ymeBtZNEwKYobFizc0cLeaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAGw6cBsWHB4aRf=kPoT+v-FbtL0ymeBtZNEwKYobFizc0cLeaQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michael Forney <mforney@mforney.org>, christian.koenig@amd.com
Cc: linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 29, 2018 at 12:46:34PM -0700, Michael Forney wrote:
> Hi,
> 
> I was looking at adding virtio-gpu support to tinyemu
> (https://bellard.org/tinyemu/). I got it to work on x86, but just for
> fun I tried it under riscv and ran into an issue with buffer
> allocations (though, this should affect any arch without
> ARCH_HAS_SG_CHAIN).
> 
> virtio-gpu uses ttm to allocate buffers, which swaps pages to ensure
> that they aren't consecutive[0][1].

Interesting.

While hacking the virtio-gpu ttm code I've already noticed that I get
non-contignous memory even for small allocations (cursor, which is only
4 pages), but havn't found the time yet to look at this.

Christian, care to explain the background?  The commit message sounds a
bit like it papers over a bug somewhere else.

> However, this causes sg_alloc_table_from_pages to use a sg entry for
> every single page, limiting buffers to only 170 pages (the number of
> sg entries that can fit into a page). This is only 417x417 with 32bpp.
> I believe the page swapping also makes TRANSFER_TO_HOST_2D inefficient
> by forcing the host to do many memcpys instead of just a few.

Probably not *that* bad, the amount of data copyed doesn't change after
all.  But, yes, I'd prefer to have shorter sh lists too.

cheers,
  Gerd

> [0] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/gpu/drm/ttm/ttm_page_alloc.c?id=fdb1a2236b07948e83e0a777e1795d4f07e52c33
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/gpu/drm/ttm/ttm_page_alloc.c?id=ae937fe19636067ec5e20d7f1fa10c6cc6000b52
