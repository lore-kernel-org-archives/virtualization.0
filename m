From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: pv_ops - 2.6.26 - unable to handle kernel paging request
Date: Tue, 22 Jul 2008 11:46:54 -0700
Message-ID: <48862B1E.8080208__4825.5696347498$1216752638$gmane$org@goop.org>
References: <4885DACE.30600@theshore.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4885DACE.30600@theshore.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Christopher S. Aker" <caker@theshore.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Christopher S. Aker wrote:
> Xen: 3.1.2 (or thereabouts), 64bit
> dom0: 2.6.18.8, pae
> pv-ops, 2.6.26

What's the .config for this kernel?  Do you know what /proc file it's 
trying to access at the time?

> BUG: unable to handle kernel paging request at 69746174

This is address is ascii "tati".  Likely to be use-after-free, though it 
could be the result of a wild write.

The code seems to correspond to the line:

		list_add(&page->lru,
			&zone->free_area[order].free_list[migratetype]);

so it suggests that either the zone freelist or the page structure is 
corrupted.

> IP: [<c015e221>] move_freepages+0x61/0xc0
> *pdpt = 0000000204ed6007
> Oops: 0002 [#1] SMP
> Modules linked in:
>
> Pid: 6859, comm: sh Not tainted (2.6.26-linode13 #1)
> EIP: 0061:[<c015e221>] EFLAGS: 00010002 CPU: 2
> EIP is at move_freepages+0x61/0xc0
> EAX: 69746174 EBX: 25413325 ECX: c158e038 EDX: 732e316d

EBX="%31%"
EDX="m1.~"

EAX, EBX and EDX are all loaded from the page structure, so it's 
definitely been hit with something.  Or perhaps the page pointer was 
wrong in the first place.  If page_order() gets corrupted for the page, 
then it could cause that loop to march off into nowhere.

Could you try again with DEBUG_PAGEALLOC turned on?

Thanks,
    J

> ESI: c158e020 EDI: 00000000 EBP: c158ffe0 ESP: ec2cddf8
> DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0069
> Process sh (pid: 6859, ti=ec2cc000 task=ecd3f400 task.ti=ec2cc000)
> Stack: c0630200 00000008 0002c7ff c1588000 c0630200 c158ffe0 c015e2ea 
> 00000001
> 00000001 00000001 c158f6e0 00000000 c0630200 c015e5d9 c0630a84 00000000
> c0630a84 00000000 00000008 00000000 c1587418 c0630200 00000018 0000001f
> Call Trace:
> [<c015e2ea>] move_freepages_block+0x6a/0x80
> [<c015e5d9>] __rmqueue+0x1a9/0x1e0
> [<c015e651>] rmqueue_bulk+0x41/0x70
> [<c015eae4>] get_page_from_freelist+0x464/0x490
> [<c015ebba>] __alloc_pages_internal+0xaa/0x460
> [<c015ef8f>] __alloc_pages+0xf/0x20
> [<c015f4bf>] __get_free_pages+0xf/0x20
> [<c01c015f>] proc_file_read+0x8f/0x2a0
> [<c01c00d0>] proc_file_read+0x0/0x2a0
> [<c01bb7ca>] proc_reg_read+0x5a/0x90
> [<c01801f1>] vfs_read+0xa1/0x160
> [<c01bb770>] proc_reg_read+0x0/0x90
> [<c0180551>] sys_read+0x41/0x70
> [<c0107256>] syscall_call+0x7/0xb
> =======================
> Code: cb 77 6f 8b 44 24 1c 89 de c1 e0 03 89 44 24 04 eb 07 83 c6 20 
> 39 f5 72 59 f6 46 02 04 74 f3 8d 4e 18 8b 56 18 8b 41 04 8b 5e 0c <89> 
> 10 89 42 04 8d 04 9b c7 46 18 00 01 10 00 8d 04 43 8b 14 24
> EIP: [<c015e221>] move_freepages+0x61/0xc0 SS:ESP 0069:ec2cddf8
> ---[ end trace 628f7b31d5a52105 ]---
>
> Kernel binary is located here:
>
> http://www.theshore.net/~caker/kernels/2.6.26-linode13
>
> -Chris
