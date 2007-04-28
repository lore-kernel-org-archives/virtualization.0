From: ebiederm@xmission.com (Eric W. Biederman)
Subject: The virtuailization patches break Voyager.
Date: Sat, 28 Apr 2007 00:40:33 -0600
Message-ID: <m1mz0tgfxa.fsf@ebiederm.dsl.xmission.com>
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
To: Andi Kleen <ak@suse.de>, Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@linux-foundation.org>
Cc: James.Bottomley@HansenPartnership.com, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org


Guys currently I am horrified by the ease at which I can find
bugs in the pending paravirtualization patches.  I have barely
even looked at arch/i386 in the -mm tree and it feels like
I am tripping over significant bugs left and right.

Because no one has heeded my advice and put in a proper platform
layer on arch/i386 and we are instead doing a half baked job
with paravirt_ops it is still trivially easy to miss the
fact that subarchitectures do something different, and thus
it is easy to miss when you break a sub architecture on
arch/i386.

Not that the paravirtuailzation patches are even safe on the
primary arch/i386.

To some extent I grant with major changes a little goofing up on
pending patches is to be expected, but it would be nice if
things were restructured to make it harder to miss the
subarchitectures on arch/i386.

The patch known as x86_64-mm-use-per-cpu-gdt-immediately-upon-boot
on -mm currently breaks voyager smp support in some very obvious ways.

Making init_gdt a function which is called from voyager_smp.c static
in smpboot.c a file that is not even used on voayger is an obvious
one.

Adding start_pda and not setting it in voyager_smp is another.

Rusty do you think you can address this?

Eric
