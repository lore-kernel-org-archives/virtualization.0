From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Wed, 16 Sep 2009 16:57:42 +0200
Message-ID: <200909161657.42628.arnd__23805.0348162234$1253113309$gmane$org@arndb.de>
References: <20090914164750.GB3745@redhat.com> <4AAFFC8E.9010404@gmail.com>
	<20090915212545.GC27954@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090915212545.GC27954@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, Avi Kivity <avi@redhat.com>, hpa@zytor.com, mingo@elte.hu, alacrityvm-devel@lists.sourceforge.net, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 15 September 2009, Michael S. Tsirkin wrote:
> Userspace in x86 maps a PCI region, uses it for communication with ppc?

This might have portability issues. On x86 it should work, but if the
host is powerpc or similar, you cannot reliably access PCI I/O memory
through copy_tofrom_user but have to use memcpy_toio/fromio or readl/writel
calls, which don't work on user pointers.

Specifically on powerpc, copy_from_user cannot access unaligned buffers
if they are on an I/O mapping.

	Arnd <><
