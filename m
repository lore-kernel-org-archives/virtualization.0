From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: virtio-gpu without ARCH_HAS_SG_CHAIN
Date: Tue, 30 Oct 2018 09:27:46 +0000
Message-ID: <751487d7-6cfc-17dc-b53e-08d72d4b88aa__19780.9465848424$1540891566$gmane$org@amd.com>
References: <CAGw6cBsWHB4aRf=kPoT+v-FbtL0ymeBtZNEwKYobFizc0cLeaQ@mail.gmail.com>
	<20181030072344.sstmq6jxcmyzbqmr@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181030072344.sstmq6jxcmyzbqmr@sirius.home.kraxel.org>
Content-Language: en-US
Content-ID: <B69AC00C8133434CBE833B7F90ECB386@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, Michael Forney <mforney@mforney.org>
Cc: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Am 30.10.18 um 08:23 schrieb Gerd Hoffmann:
> On Mon, Oct 29, 2018 at 12:46:34PM -0700, Michael Forney wrote:
>> Hi,
>>
>> I was looking at adding virtio-gpu support to tinyemu
>> (https://bellard.org/tinyemu/). I got it to work on x86, but just for
>> fun I tried it under riscv and ran into an issue with buffer
>> allocations (though, this should affect any arch without
>> ARCH_HAS_SG_CHAIN).
>>
>> virtio-gpu uses ttm to allocate buffers, which swaps pages to ensure
>> that they aren't consecutive[0][1].
> Interesting.
>
> While hacking the virtio-gpu ttm code I've already noticed that I get
> non-contignous memory even for small allocations (cursor, which is only
> 4 pages), but havn't found the time yet to look at this.
>
> Christian, care to explain the background?  The commit message sounds a
> bit like it papers over a bug somewhere else.

The problem is that the TTM pool handler thinks that we need to free 
pages to the huge page pool when it sees that they are consecutive.

The root problem of that in turn is that we can't use compound pages for 
device allocated memory, but a real fix for that would require quite 
some work in the MM.

What we can do rather easily is to paper over the problem by only 
swapping page 511 and 510 to avoid that the pool things that this is a 
huge page.

Regards,
Christian.

>
>> However, this causes sg_alloc_table_from_pages to use a sg entry for
>> every single page, limiting buffers to only 170 pages (the number of
>> sg entries that can fit into a page). This is only 417x417 with 32bpp.
>> I believe the page swapping also makes TRANSFER_TO_HOST_2D inefficient
>> by forcing the host to do many memcpys instead of just a few.
> Probably not *that* bad, the amount of data copyed doesn't change after
> all.  But, yes, I'd prefer to have shorter sh lists too.
>
> cheers,
>    Gerd
>
>> [0] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/gpu/drm/ttm/ttm_page_alloc.c?id=fdb1a2236b07948e83e0a777e1795d4f07e52c33
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/gpu/drm/ttm/ttm_page_alloc.c?id=ae937fe19636067ec5e20d7f1fa10c6cc6000b52
