From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/13 v7] PCI: Linux kernel SR-IOV support
Date: Tue, 16 Dec 2008 23:21:05 -0800
Message-ID: <20081217072105.GA13408__45800.7322079085$1229498714$gmane$org@kroah.com>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
	<200812161523.55238.jbarnes@virtuousgeek.org>
	<49486602.5000108@gmail.com> <20081217060608.GA12618@kroah.com>
	<4948A52B.7040403@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4948A52B.7040403@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Zhao, Yu" <yu.zhao@intel.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, Jike Song <albcamus@gmail.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "horms@verge.net.au" <horms@verge.net.au>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "yinghai@kernel.org" <yinghai@kernel.org>, "bjorn.helgaas@hp.com" <bjorn.helgaas@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 17, 2008 at 03:07:23PM +0800, Zhao, Yu wrote:
> Greg KH wrote:
>> On Wed, Dec 17, 2008 at 10:37:54AM +0800, Jike Song wrote:
>>> Jesse Barnes wrote:
>>>> Given a respin of 10-13 I think it's reasonable to merge this into 
>>>> 2.6.29, but I'd be much happier about it if we got some driver code 
>>>> along with it, so as not to have an unused interface sitting around for 
>>>> who knows how many releases.  Is that reasonable?  Do you know if any of 
>>>> the corresponding PF/VF driver bits are ready yet?
>>> Hi Jesse, 
>>> Yu Zhao has posted a patch set with subject "SR-IOV driver example" at 
>>> November 26, which illustrated the usage of SR-IOV API in Intel 82576 
>>> VF/PF
>>> drivers;-)
>> Yes, but that driver was soundly rejected by the network driver
>> maintainers, so I wouldn't go around showing that as your primary
>> example of how to use this interface :)
>> The point is valid, I don't think these apis should go into the tree
>> without a driver or some other code using them.  Otherwise they make no
>> sense at all to have in-tree.
>
> I agree the point is valid, but on another hand this is a 'the chicken & 
> the egg' problem -- if we don't have the SR-IOV base, people who are 
> developing PF drivers can not get their changes in-tree. Maybe they are 
> holding the patches and waiting on the infrastructure... :-)

Are they?  They can both go in at the same time, like almost every other
api addition to the kernel, right?

thanks,

greg k-h
