From: Yu Zhao <yu.zhao@intel.com>
Subject: Re: [PATCH 16/16 v6] PCI: document the new PCI boot parameters
Date: Thu, 11 Dec 2008 09:43:13 +0800
Message-ID: <20081211014313.GA4947__79.5416454367981$1228959985$gmane$org@yzhao12-linux.sh.intel.com>
References: <20081022083809.GA3757@yzhao12-linux.sh.intel.com>
	<20081022084531.GP3773@yzhao12-linux.sh.intel.com>
	<20081106043235.GA30292@kroah.com> <4913AA03.5060807@intel.com>
	<20081107025032.GA12824@kroah.com> <4913B8A5.5010806@intel.com>
	<20081107041721.GB15439@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081107041721.GB15439@parisc-linux.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, Greg KH <greg@kroah.com>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 07, 2008 at 12:17:22PM +0800, Matthew Wilcox wrote:
> On Fri, Nov 07, 2008 at 11:40:21AM +0800, Zhao, Yu wrote:
> > Greg KH wrote:
> > >We've thought about this in the past, and even Microsoft said it was
> > >going to happen for Vista, but they realized in the end, like we did a
> > >few years previously, that it would require full support of all PCI
> > >drivers as well (if you rebalance stuff that is already bound to a
> > >driver.)  So they dropped it.
> > >
> > >When would you want to do this kind of rebalancing?  Before any PCI
> > >driver is bound to any devices?  Or afterwards?
> > 
> > I guess if we want the rebalance dynamic, then we should have it full -- 
> > the rebalance would be functional even after the driver is loaded.
> > 
> > But in most cases, there will be problem when we unload driver from a 
> > hard disk controller, etc. We can mount root on a ramdisk and do the 
> > rebalance there, but it's complicated for a real user.
> > 
> > So looks like doing rebalancing before any driver is bound to any device 
> > is also a nice idea, if user can get a shell to do rebalance before 
> > built-in PCI driver grabs device.
> 
> Can we use the suspend/resume code to do this?  Some drivers (sym2 for
> one) would definitely need to rerun some of their init code to cope with
> a BAR address changing.

Yes, that is what I was thinking. But after some grep on the PCI device
drivers, I feel frustrated because all those drivers only do 'ioremap'
once at the 'probe' stage.

I believe this is the only problem that preclude us having the run-time
resource rebalance. And I'm not sure how much effort we can fix it. Any
comments?


Thanks,
Yu
