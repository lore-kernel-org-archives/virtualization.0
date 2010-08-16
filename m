From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Using virtio as a physical (wire-level) transport
Date: Mon, 16 Aug 2010 09:49:40 +0930
Message-ID: <201008160949.41348.rusty__12090.2120056146$1281918036$gmane$org@rustcorp.com.au>
References: <20100804230441.GJ23951@ovro.caltech.edu>
	<20100806153427.GB12392@ovro.caltech.edu>
	<4C336074-FC8C-4BDF-B945-5295133CDB38@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4C336074-FC8C-4BDF-B945-5295133CDB38@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Zang Roy <r61911@freescale.com>, "Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 14 Aug 2010 09:04:19 pm Alexander Graf wrote:
> 
> Am 06.08.2010 um 11:34 schrieb "Ira W. Snyder" <iws@ovro.caltech.edu>:
> > This problem is not limited to my new use of virtio. Virtio is
> > completely useless in a relatively common virtualization scenario:
> > x86 host with qemu-ppc guest. Or any other big endian guest system.
> 
> This one actually works because we know that we're building for a BE guest.
> But I agree that it's a mess and clearly a very incorrect design decision.

Yes, since you need to know the guest's endian to virtualize it, the
correct interpretation of the virtio ring seemed the least problem.  Perhaps
I went overboard in simplification here, but it seemed pure legacy.

If we did a virtio2, as has been suggested, it would be possible to address
this.  You could of course do a hack where you detect the ring endianness
the first time they use it (based on avail.flags, avail.index and the
descriptor it would be quite reliable in practice).

Cheers,
Rusty.
