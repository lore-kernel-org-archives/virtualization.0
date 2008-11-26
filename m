From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [SR-IOV driver example 2/3] PF driver: integrate with SR-IOV core
Date: Wed, 26 Nov 2008 09:54:27 -0800
Message-ID: <20081126175427.GE19881__58.401274918829$1227722209$gmane$org@sequoia.sous-sol.org>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
	<20081126140303.GA13641@yzhao12-linux.sh.intel.com>
	<20081126142156.GB13668@yzhao12-linux.sh.intel.com>
	<20081126165859.GA28251@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081126165859.GA28251@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

* Greg KH (greg@kroah.com) wrote:
> > +static	int
> > +igb_virtual(struct pci_dev *pdev, int nr_virtfn)
> > +{
> > +	unsigned char my_mac_addr[6] = {0x00, 0xDE, 0xAD, 0xBE, 0xEF, 0xFF};
> > +	struct net_device *netdev = pci_get_drvdata(pdev);
> > +	struct igb_adapter *adapter = netdev_priv(netdev);
> > +	int i;
> > +
> > +	if (nr_virtfn > 7)
> > +		return -EINVAL;
> 
> Why the check for 7?  Is that the max virtual functions for this card?
> Shouldn't that be a define somewhere so it's easier to fix in future
> versions of this hardware?  :)

IIRC it's 8 for the card, 1 reserved for PF.  I think both notions
should be captured w/ commented constants.

thanks,
-chris
