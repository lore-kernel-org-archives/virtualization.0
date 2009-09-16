From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Wed, 16 Sep 2009 18:13:29 +0300
Message-ID: <20090916151329.GC5513__3117.7710545764$1253114453$gmane$org@redhat.com>
References: <20090914164750.GB3745@redhat.com> <4AAFFC8E.9010404@gmail.com>
	<20090915212545.GC27954@redhat.com>
	<200909161657.42628.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200909161657.42628.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: kvm@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, Avi Kivity <avi@redhat.com>, hpa@zytor.com, mingo@elte.hu, alacrityvm-devel@lists.sourceforge.net, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 16, 2009 at 04:57:42PM +0200, Arnd Bergmann wrote:
> On Tuesday 15 September 2009, Michael S. Tsirkin wrote:
> > Userspace in x86 maps a PCI region, uses it for communication with ppc?
> 
> This might have portability issues. On x86 it should work, but if the
> host is powerpc or similar, you cannot reliably access PCI I/O memory
> through copy_tofrom_user but have to use memcpy_toio/fromio or readl/writel
> calls, which don't work on user pointers.
> 
> Specifically on powerpc, copy_from_user cannot access unaligned buffers
> if they are on an I/O mapping.
> 
> 	Arnd <><

We are talking about doing this in userspace, not in kernel.

-- 
MST
