From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 0/3] checkpatch: handling of memory barriers
Date: Sun, 10 Jan 2016 13:56:50 +0200
Message-ID: <1452427000-4520-1-git-send-email-mst__1067.66645699299$1452427047$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Tony Lindgren <tony@atomide.com>, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Andrey Konovalov <andreyknvl@google.com>, adi-buildroot-devel@lists.sourceforge.net, Andy Whitcroft <apw@canonical.com>, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.orgAndrew Cooper <an>
List-Id: virtualization@lists.linuxfoundation.org

As part of memory barrier cleanup, this patchset
extends checkpatch to make it easier to stop
incorrect memory barrier usage.

This applies on top of my series
	arch: barrier cleanup + barriers for virt
and will be included in the next version of the series.

Changes from v2:
	catch optional\s* before () in barriers
	rewrite using qr{} instead of map

Michael S. Tsirkin (3):
  checkpatch.pl: add missing memory barriers
  checkpatch: check for __smp outside barrier.h
  checkpatch: add virt barriers

 scripts/checkpatch.pl | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

-- 
MST
