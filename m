From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 0/13 v7] PCI: Linux kernel SR-IOV support
Date: Wed, 17 Dec 2008 12:07:32 -0800
Message-ID: <200812171207.34396.jbarnes__26636.1331953251$1229545188$gmane$org@virtuousgeek.org>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
	<200812171142.56170.jbarnes@virtuousgeek.org>
	<20081217195143.GA25211@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081217195143.GA25211@kroah.com>
Content-Disposition: inline
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
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, Jike Song <albcamus@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rose, Gregory V" <gregory.v.rose@intel.com>, "horms@verge.net.au" <horms@verge.net.au>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "yinghai@kernel.org" <yinghai@kernel.org>, "bjorn.helgaas@hp.com" <bjorn.helgaas@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday, December 17, 2008 11:51 am Greg KH wrote:
> On Wed, Dec 17, 2008 at 11:42:54AM -0800, Jesse Barnes wrote:
> > I really don't want the SR-IOV stuff to sit out another merge cycle
> > though... Arg.
>
> Why, is there some rush to get it in?  As there is no in-kernel users of
> it, I don't see the problem with postponing it until someone actually
> needs it.

Well it *does* make development of SR-IOV drivers that much harder.  As you 
know, out of tree development is a pain.  OTOH if any changes end up being 
required, they can be done before the code is merged.

Anyway, hopefully we won't have to worry about it because some driver will 
come along soon that uses Yu's code. :)  If not, Yu might have to maintain a 
separate git tree or something until the drivers are ready to be merged.

-- 
Jesse Barnes, Intel Open Source Technology Center
