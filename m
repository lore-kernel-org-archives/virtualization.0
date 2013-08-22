From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: updated: kvm PCI todo wiki
Date: Thu, 22 Aug 2013 11:27:22 +0300
Message-ID: <20130822082722.GA22117@redhat.com>
References: <20130821104844.GA6218@redhat.com> <5214B670.5030509@suse.de>
	<1377160174.32763.61.camel@haakon3.risingtidesystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1377160174.32763.61.camel@haakon3.risingtidesystems.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 22, 2013 at 01:29:34AM -0700, Nicholas A. Bellinger wrote:
> On Wed, 2013-08-21 at 14:45 +0200, Hannes Reinecke wrote:
> > On 08/21/2013 12:48 PM, Michael S. Tsirkin wrote:
> > > Hey guys,
> > > I've put up a wiki page with a kvm PCI todo list,
> > > mainly to avoid effort duplication, but also in the hope
> > > to draw attention to what I think we should try addressing
> > > in KVM:
> > >
> > > http://www.linux-kvm.org/page/PCITodo
> > >
> > > This page could cover all PCI related activity in KVM,
> > > it is very incomplete.
> > > We should probably add e.g. IOMMU related stuff.
> > >
> > > Note: if there's no developer listed for an item,
> > > this just means I don't know of anyone actively working
> > > on an issue at the moment, not that no one intends to.
> > >
> > > I would appreciate it if others working on one of the items on this list
> > > would add their names so we can communicate better.  If others like this
> > > wiki page, please go ahead and add stuff you are working on if any.
> > >
> > > It would be especially nice to add testing projects.
> > >
> > > Also, feel free to add links to bugzillas items.
> > >
> > On a related note, did anyone ever tried to test MSI / MSI-X with a 
> > windows guest? I've tried to enable it for virtio but for some reason 
> > Windows didn't wanted to enable it. AHCI was even worse; the stock 
> > Windows version doesn't support MSI and the Intel one doesn't like our 
> > implementation :-(.
> > 
> > Anyone ever managed to get this to work?
> > 
> > If not it'd be a good topic for the wiki ...
> > 
> 
> Speaking of which, I asked Asias about this recently and he seems to
> think that virtio-net + virtio-blk drivers for MSFT do in fact support
> MSI /MSI-X.
> 
> MST, do you know if that that true..?
> 
> --nab

Yes, they do for modern windows versions.
