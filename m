From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC 3/11] pci: add pci_iomap_range
Date: Fri, 16 Dec 2011 12:26:52 +1030
Message-ID: <87wr9xp9cr.fsf@rustcorp.com.au>
References: <87pqfzgy6p.fsf@rustcorp.com.au> <87hb1bgxpt.fsf@rustcorp.com.au>
	<20111215083048.GB3630@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111215083048.GB3630@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sasha Levin <levinsasha928@gmail.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 15 Dec 2011 10:30:49 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Dec 08, 2011 at 09:02:46PM +1030, Rusty Russell wrote:
> > From: Michael S Tsirkin <mst@redhat.com>
> > 
> > Virtio drivers should map the part of the range they need, not necessarily
> > all of it.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> 
> I think that we should add a forcenocache flag.
> This will let devices put the cap structure in
> the prefetcheable BAR. That has an advantage that
> it can be located anywhere in the 2^64 space,
> while non-prefetcheable BARs are limited to lower 4G
> for devices behind a PCI-to-PCI bridge.

OK, want to respin that patch (or patch on top and I'll fold?)

Thanks,
Rusty.
