From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/13 v7] PCI: Linux kernel SR-IOV support
Date: Tue, 16 Dec 2008 22:06:08 -0800
Message-ID: <20081217060608.GA12618__22980.307651642$1229494113$gmane$org@kroah.com>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
	<200812161523.55238.jbarnes@virtuousgeek.org>
	<49486602.5000108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <49486602.5000108@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jike Song <albcamus@gmail.com>
Cc: randy.dunlap@oracle.com, grundler@parisc-linux.org, achiang@hp.com, matthew@wil.cx, linux-pci@vger.kernel.org, rdreier@cisco.com, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, virtualization@lists.linux-foundation.org, horms@verge.net.au, kvm@vger.kernel.org, mingo@elte.hu, yinghai@kernel.org, bjorn.helgaas@hp.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 17, 2008 at 10:37:54AM +0800, Jike Song wrote:
> Jesse Barnes wrote:
> > Given a respin of 10-13 I think it's reasonable to merge this into 2.6.29, but 
> > I'd be much happier about it if we got some driver code along with it, so as 
> > not to have an unused interface sitting around for who knows how many 
> > releases.  Is that reasonable?  Do you know if any of the corresponding PF/VF 
> > driver bits are ready yet?
> 
> Hi Jesse, 
> 
> Yu Zhao has posted a patch set with subject "SR-IOV driver example" 
> at November 26, which illustrated the usage of SR-IOV API in Intel 82576 VF/PF
> drivers;-)

Yes, but that driver was soundly rejected by the network driver
maintainers, so I wouldn't go around showing that as your primary
example of how to use this interface :)

The point is valid, I don't think these apis should go into the tree
without a driver or some other code using them.  Otherwise they make no
sense at all to have in-tree.

thanks,

greg k-h
