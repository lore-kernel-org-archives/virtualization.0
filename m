From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 0/7] (Re-)introducing pvops for x86_64 - Consolidation part
Date: Wed, 31 Oct 2007 16:13:12 -0300
Message-ID: <1193857999499-git-send-email-gcosta__13147.0826607712$1193869015$gmane$org@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org


Hi folks,

Here is the result of the latest work on the pvops front, after the x86
arch merge. From the functionality point of view, almost nothing was
changed, except for proper vsmp support - which was discussed, but not
implemented before - and the introduction of smp_ops in x86_64, which eased
the merging of the smp header.

Speaking of the merge, a significant part (although not majority) of this
work is merging things that was not possible before, due to the lack of
paravirt for x86_64. What was done then, can be thought as a
"lookahead-merge", which is a normal code, but just taking into account that
we'll have support for paravirt_ops in x86_64 in the future. Note for that
files, there can be room left for more integration. This is just the first,
not the final step.

For this reason, I'm splitting this series in two. The first one, which will
follow this message, are really just integration patches. Besides making
review even easier, we believe that those could get into the .24 time frame,
just like all the other merge patches that are already going in.

In a separate series, you'll get the actual pvops implementation.

That said, have fun!
