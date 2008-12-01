From: Yu Zhao <yu.zhao@intel.com>
Subject: Re: [SR-IOV driver example 2/3] PF driver: integrate with SR-IOV core
Date: Tue, 2 Dec 2008 00:46:22 +0800
Message-ID: <20081201164622.GC1464__346.881725318049$1228135570$gmane$org@yzhao12-linux.sh.intel.com>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
	<20081126140303.GA13641@yzhao12-linux.sh.intel.com>
	<20081126142156.GB13668@yzhao12-linux.sh.intel.com>
	<20081126165859.GA28251@kroah.com>
	<20081126175427.GE19881@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081126175427.GE19881@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "matthew@wil.cx" <matthew@wil.cx>, Greg KH <greg@kroah.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 27, 2008 at 01:54:27AM +0800, Chris Wright wrote:
> * Greg KH (greg@kroah.com) wrote:
> > > +static	int
> > > +igb_virtual(struct pci_dev *pdev, int nr_virtfn)
> > > +{
> > > +	unsigned char my_mac_addr[6] = {0x00, 0xDE, 0xAD, 0xBE, 0xEF, 0xFF};
> > > +	struct net_device *netdev = pci_get_drvdata(pdev);
> > > +	struct igb_adapter *adapter = netdev_priv(netdev);
> > > +	int i;
> > > +
> > > +	if (nr_virtfn > 7)
> > > +		return -EINVAL;
> > 
> > Why the check for 7?  Is that the max virtual functions for this card?
> > Shouldn't that be a define somewhere so it's easier to fix in future
> > versions of this hardware?  :)
> 
> IIRC it's 8 for the card, 1 reserved for PF.  I think both notions
> should be captured w/ commented constants.

You remember correctly! I'll put some comments there as suggested.

Thanks,
Yu
