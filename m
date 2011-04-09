From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC][PATCH] virtio balloon: kill tell-host-first logic
Date: Sun, 10 Apr 2011 08:18:22 +0930
Message-ID: <87ei5bdosp.fsf__24813.300142023$1302396180$gmane$org@rustcorp.com.au>
References: <20110407174325.ED21C82B@kernel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110407174325.ED21C82B@kernel>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Dave Hansen <dave@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 07 Apr 2011 10:43:25 -0700, Dave Hansen <dave@linux.vnet.ibm.com> wrote:
> 
> The virtio balloon driver has a VIRTIO_BALLOON_F_MUST_TELL_HOST
> feature bit.  Whenever the bit is set, we must always tell the
> host before we free pages back to the allocator.  Without this
> we might free a page (and have another user touch it) while the
> hypervisor is unprepared for it.
> 
> But, if the bit is _not_ set, we are under no obligation to
> reverse the order.  Furthermore, all modern qemus set this bit.
> So, the "tell second" code is completely unused and untestable.
> Quoting Anthony: "untested code is broken code".
> 
> This _also_ means that we don't have to preserve a pfn list
> after the pages are freed, which should let us get rid of some
> temporary storage (vb->pfns) eventually.
> 
> Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>

Thanks, applied!

Rusty.
