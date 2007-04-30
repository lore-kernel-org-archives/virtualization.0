From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 0/12] Early USB debug port and i386 boot cleanups
Date: Mon, 30 Apr 2007 09:46:17 -0600
Message-ID: <m1d51l6f1y.fsf__17301.5820364983$1177948139$gmane$org@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


Modern hardware relies primarily on memory mapped I/O which is typically
at addresses that are not mapped by the kernels initial page tables,
which makes using them currently unusable for early debugging print support.

So this patch set digs in and fixes the early page tables on both
arch/i386 and arch/x86_64 so that set_fixmap works with our initial boot
page tables.   All that is needed is that we allocate preallocate the pte
page that the fixmap entries live on.

On arch/i386 I accomplish this by ensuring the boot time page tables are
in the native mode.  Doing this provides an alternative and slightly
more capable fix to Jeremy's problem of not having the initial memory
mapping covering enough pages to identity map all of low memory.  Because
we are now updating the page table we are running on we add the mappings
we need for the initial page table as we build the initial page table.

Since I was in there I kept cleaning up arch/i386/head.S.
In particular I have gotten as far as removing the early cpuid,
and have added a head32.S.

Eric
