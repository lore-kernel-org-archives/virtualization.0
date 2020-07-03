From: Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Date: Fri, 3 Jul 2020 13:04:05 +0200
Message-ID: <CAG48ez2CpHX9i3YgkNyMHPz63ohjkaSZscMtwSHOFYN4VQow3Q@mail.gmail.com>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B7793B7A-3660-4769-9B9A-FFCF250728BB-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Catangiu, Adrian Costin" <acatan-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
Cc: "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "pavel-+ZI9xUNit7I@public.gmane.org" <pavel-+ZI9xUNit7I@public.gmane.org>, "mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org" <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>, "wad-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <wad-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bonzini-mXXj517/zsQ@public.gmane.org" <bonzini-mXXj517/zsQ@public.gmane.org>, "Graf (AWS), Alexander" <graf-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>, MacCa
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 3, 2020 at 12:34 PM Catangiu, Adrian Costin
<acatan-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org> wrote:
> Cryptographic libraries carry pseudo random number generators to
> quickly provide randomness when needed. If such a random pool gets
> cloned, secrets may get revealed, as the same random number may get
> used multiple times. For fork, this was fixed using the WIPEONFORK
> madvise flag [1].
>
> Unfortunately, the same problem surfaces when a virtual machine gets
> cloned. The existing flag does not help there. This patch introduces a
> new flag to automatically clear memory contents on VM suspend/resume,
> which will allow random number generators to reseed when virtual
> machines get cloned.
>
> Examples of this are:
>  - PKCS#11 API reinitialization check (mandated by specification)
>  - glibc's upcoming PRNG (reseed after wake)
>  - OpenSSL PRNG (reseed after wake)
>
> Benefits exist in two spaces:
>  - The security benefits of a cloned virtual machine having a
>    re-initialized PRNG in every process are straightforward.
>    Without reinitialization, two or more cloned VMs could produce
>    identical random numbers, which are often used to generate secure
>    keys.
>  - Provides a simple mechanism to avoid RAM exfiltration during
>    traditional sleep/hibernate on a laptop or desktop when memory,
>    and thus secrets, are vulnerable to offline tampering or inspection.

For the first usecase, I wonder which way around this would work
better - do the wiping when a VM is saved, or do it when the VM is
restored? I guess that at least in some scenarios, doing it on restore
would be nicer because that way the hypervisor can always instantly
save a VM without having to wait for the guest to say "alright, I'm
ready" - especially if someone e.g. wants to take a snapshot of a
running VM while keeping it running? Or do hypervisors inject such
ACPI transitions every time they snapshot/save/restore a VM anyway?

> This RFC is foremost aimed at defining a userspace interface to enable
> applications and libraries that store or cache sensitive information,
> to know that they need to regenerate it after process memory has been
> exposed to potential copying.  The proposed userspace interface is
> a new MADV_WIPEONSUSPEND 'madvise()' flag used to mark pages which
> contain such data. This newly added flag would only be available on
> 64bit archs, since we've run out of 32bit VMA flags.
>
> The mechanism through which the kernel marks the application sensitive
> data as potentially copied, is a secondary objective of this RFC. In
> the current PoC proposal, the RFC kernel code combines
> MADV_WIPEONSUSPEND semantics with ACPI suspend/wake transitions to zero
> out all process pages that fall in VMAs marked as MADV_WIPEONSUSPEND
> and thus allow applications and libraries be notified and regenerate
> their sensitive data.  Marking VMAs as MADV_WIPEONSUSPEND results in
> the VMAs being empty in the process after any suspend/wake cycle.
> Similar to MADV_WIPEONFORK, if the process accesses memory that was
> wiped on suspend, it will get zeroes.  The address ranges are still
> valid, they are just empty.
>
> This patch adds logic to the kernel power code to zero out contents of
> all MADV_WIPEONSUSPEND VMAs present in the system during its transition
> to any suspend state equal or greater/deeper than Suspend-to-memory,
> known as S3.
>
> MADV_WIPEONSUSPEND only works on private, anonymous mappings.
> The patch also adds MADV_KEEPONSUSPEND, to undo the effects of a
> prior MADV_WIPEONSUSPEND for a VMA.
>
> Hypervisors can issue ACPI S0->S3 and S3->S0 events to leverage this
> functionality in a virtualized environment.
>
> Alternative kernel implementation ideas:
>  - Move the code that clears MADV_WIPEONFORK pages to a virtual
>    device driver that registers itself to ACPI events.
>  - Add prerequisite that MADV_WIPEONFORK pages must be pinned (so
>    no faulting happens) and clear them in a custom/roll-your-own
>    device driver on a NMI handler. This could work in a virtualized
>    environment where the hypervisor pauses all other vCPUs before
>    injecting the NMI.
>
> [1] https://lore.kernel.org/lkml/20170811212829.29186-1-riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org/
[...]
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index c874a7026e24..4282b7f0dd03 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -323,6 +323,78 @@ static bool platform_suspend_again(suspend_state_t state)
>                 suspend_ops->suspend_again() : false;
>  }
>
> +#ifdef VM_WIPEONSUSPEND
> +static void memory_cleanup_on_suspend(suspend_state_t state)
> +{
> +       struct task_struct *p;
> +       struct mm_struct *mm;
> +       struct vm_area_struct *vma;
> +       struct page *pages[32];
> +       unsigned long max_pages_per_loop = ARRAY_SIZE(pages);
> +
> +       /* Only care about states >= S3 */
> +       if (state < PM_SUSPEND_MEM)
> +               return;
> +
> +       rcu_read_lock();
> +       for_each_process(p) {
> +               int gup_flags = FOLL_WRITE;
> +
> +               mm = p->mm;
> +               if (!mm)
> +                       continue;
> +
> +               down_read(&mm->mmap_sem);

Blocking actions, such as locking semaphores, are forbidden in RCU
read-side critical sections. Also, from a more high-level perspective,
do we need to be careful here to avoid deadlocks with frozen tasks or
stuff like that?

> +               for (vma = mm->mmap; vma; vma = vma->vm_next) {
> +                       unsigned long addr, nr_pages;
> +
> +                       if (!(vma->vm_flags & VM_WIPEONSUSPEND))
> +                               continue;
> +
> +                       addr = vma->vm_start;
> +                       nr_pages = (vma->vm_end - addr - 1) / PAGE_SIZE + 1;
> +                       while (nr_pages) {
> +                               int count = min(nr_pages, max_pages_per_loop);
> +                               void *kaddr;
> +
> +                               count = get_user_pages_remote(p, mm, addr,
> +                                                       count, gup_flags,
> +                                                       pages, NULL, NULL);

get_user_pages_remote() can wait for disk I/O (for swapping stuff back
in), which we'd probably like to avoid here. And I think it can also
wait for userfaultfd handling from userspace? zap_page_range() (which
is what e.g. MADV_DONTNEED uses) might be a better fit, since it can
yank entries out of the page table (forcing the next write fault to
allocate a new zeroed page) without faulting them into RAM.

> +                               if (count <= 0) {
> +                                       /*
> +                                        * FIXME: In this PoC just break if we
> +                                        * get an error.
> +                                        * In the final implementation we need
> +                                        * to handle this better and not leave
> +                                        * pages uncleared.
> +                                        */
> +                                       break;
> +                               }
> +                               /* Go through pages buffer and clear them. */
> +                               while (count) {
> +                                       struct page *page = pages[--count];
> +
> +                                       kaddr = kmap(page);
> +                                       clear_page(kaddr);
> +                                       kunmap(page);

(This part should go away, but if it stayed, you'd probably want to
use clear_user_highpage() or so instead of open-coding this.)

> +                                       put_page(page);
> +                                       nr_pages--;
> +                                       addr += PAGE_SIZE;
> +                               }
> +                       }
> +               }
> +               up_read(&mm->mmap_sem);
> +       }
> +       rcu_read_unlock();
> +}
