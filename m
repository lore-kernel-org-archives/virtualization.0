From: Amit Shah <amit.shah@redhat.com>
Subject: Re: Ballooning on TPS!=HPS hosts
Date: Fri, 1 Apr 2016 16:22:34 +0530
Message-ID: <20160401105234.GA21483@grmbl.mre>
References: <20160331180024.GN2265@work-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160331180024.GN2265@work-vm>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: lvivier@redhat.com, aarcange@redhat.com, drjones@redhat.com, qemu-devel@nongnu.org, Virtualization List <virtualization@lists.linux-foundation.org>, lcapitulino@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

CC'ing virtualization list.

On (Thu) 31 Mar 2016 [19:00:24], Dr. David Alan Gilbert wrote:
> Hi,
>   I was reading the balloon code and am confused as to how/if ballooning
> works on hosts where the host page size is larger than the
> target page size.
> 
> static void balloon_page(void *addr, int deflate)
> {
> #if defined(__linux__)
>     if (!qemu_balloon_is_inhibited() && (!kvm_enabled() ||
>                                          kvm_has_sync_mmu())) {
>         qemu_madvise(addr, TARGET_PAGE_SIZE,
>                 deflate ? QEMU_MADV_WILLNEED : QEMU_MADV_DONTNEED);
>     }
> #endif
> }
> 
> The virtio-balloon code only does stuff through ballon_page,
> and an madvise DONTNEED should fail if you try and do it on
> a size smaller than the host page size.  So does ballooning work on
> Power/ARM?
> 
> Am I misunderstanding this?

I think you're right.  Guess no one's tested this in such scenarios
yet.

> Of course looking at the above we won't actually generate an error since
> we don't check the return of qemu_madvise.

... at least we can deflate the balloon in case the madvise fails, so
the guest can use the pages it's given us.

> We have three sizes:
>     a) host page size
>     b) target page size
>     c) VIRTIO_BALLOON_PFN_SHIFT
> 
>  c == 12 (4k) for everyone
>  
> 
>     1) I think the virtio-balloon code needs to coallesce adjecent requests
>       and call balloon_page on whole chunks at once passing a length.
>     2) why does balloon_page use TARGET_PAGE_SIZE, ignoring anything else
>        shouldn't it be 1 << VIRTIO_BALLOON_PFN_SHIFT ?
>     3) I'm guessing the guest kernel doesn't know the host page size, so
>        how can it know what size chunks of balloon to work in?

Thanks,

		Amit
