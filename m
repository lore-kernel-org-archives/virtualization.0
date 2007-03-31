From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 0/6] i386 gdt and percpu cleanups
Date: Fri, 30 Mar 2007 19:00:42 -0700
Message-ID: <20070331020042.003398870@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Andi,

This is a series of patches based on your latest queue (as of the
other day, at least).

It includes:
 - the most recent patch to compute the appropriate amount of percpu
   space to allocate, using a separate reservation for modules where
   needed.
 - make the percpu sections page-aligned, so that percpu variables can
   be page aligned if needed (which is used by gdt_page)
 - page-align the gdt
 - remove the pda and convert all pda usages into percpu variables
   (percpu variables still use the %fs prefix mechanism the pda used)
 - some improvements to asm-i386/percpu.h to make asm access to percpu
   variables easy
 - define per_cpu_offset in asm-i386/percpu.h, to match asm-generic/

Thanks,
	J

-- =
