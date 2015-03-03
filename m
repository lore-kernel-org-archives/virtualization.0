From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: kasan_map_early_shadow() on Xen
Date: Tue, 3 Mar 2015 01:40:00 -0800
Message-ID: <CAB=NE6Xs5fepzNtymzT4CueeJZ0KMPETpda114DpL4eMtDswtw__20316.4451326758$1425376396$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrey Ryabinin <a.ryabinin@samsung.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Andrey,

I believe that on Xen we should disable kasan, would like confirmation
from someone on xen-devel though. Here's the thing though -- if true
-- I'd like to do it *properly*, where *properly* means addressing a
bit of architecture. A simple Kconfig slap seems rather reactive. I'd
like to address a way to properly ensure we don't run into this and
other similar issues in the future. The CR4 shadow issue was another
recent example issue, also introduced via v4.0 [0]. We can't keep
doing this reactively.

Let's go down the rabbit hole for a bit. HAVE_ARCH_KASAN will be
selected on x86 when:

if X86_64 && SPARSEMEM_VMEMMAP

Now Xen should not have SPARSEMEM_VMEMMAP but PVOPs' goal is to enable
distributions to be able to have a single binary kernels and let the
rest be figured out, so we can't just disable SPARSEMEM_VMEMMAP for
Xen alone, we want to build Xen.. or part of Xen and perhaps keep
SPARSEMEM_VMEMMAP, and only later figure things out.

How do we do this cleanly and avoid future reactive measures? If the
answer is not upon us, I'd like to at least highlight the issue so
that in case we do come up with something its no surprise PVOPs is
falling short for that single binary pipe dream right now.

[0] https://lkml.org/lkml/2015/2/23/328

 Luis
