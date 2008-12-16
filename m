From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 0/13 v7] PCI: Linux kernel SR-IOV support
Date: Tue, 16 Dec 2008 15:23:53 -0800
Message-ID: <200812161523.55238.jbarnes__22970.7419210628$1229470034$gmane$org@virtuousgeek.org>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
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
To: Yu Zhao <yu.zhao@intel.com>
Cc: randy.dunlap@oracle.com, grundler@parisc-linux.org, achiang@hp.com, matthew@wil.cx, linux-pci@vger.kernel.org, rdreier@cisco.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, horms@verge.net.au, kvm@vger.kernel.org, greg@kroah.com, mingo@elte.hu, yinghai@kernel.org, bjorn.helgaas@hp.com
List-Id: virtualization@lists.linuxfoundation.org

On Friday, November 21, 2008 10:36 am Yu Zhao wrote:
> Greetings,
>
> Following patches are intended to support SR-IOV capability in the
> Linux kernel. With these patches, people can turn a PCI device with
> the capability into multiple ones from software perspective, which
> will benefit KVM and achieve other purposes such as QoS, security,
> and etc.
>
> The Physical Function and Virtual Function drivers using the SR-IOV
> APIs will come soon!
>
> Major changes from v6 to v7:
> 1, remove boot-time resource rebalancing support. (Greg KH)
> 2, emit uevent upon the PF driver is loaded. (Greg KH)
> 3, put SR-IOV callback function into the 'pci_driver'. (Matthew Wilcox)
> 4, register SR-IOV service at the PF loading stage.
> 5, remove unnecessary APIs (pci_iov_enable/disable).

Thanks for your patience with this, Yu, I know it's been a long haul. :)

I applied 1-9 to my linux-next branch; and at least patch #10 needs a respin, 
so can you re-do 10-13 as a new patch set?

On re-reading the last thread, there was a lot of smoke, but very little fire 
afaict.  The main questions I saw were:

  1) do we need SR-IOV at all?  why not just make each subsystem export
     devices to guests?
    This is a bit of a red herring.  Nothing about SR-IOV prevents us from
    making subsystems more v12n friendly.  And since SR-IOV is a hardware
    feature supported by devices these days, we should make Linux support it.

  2) should the PF/VF drivers be the same or not?
    Again, the SR-IOV patchset and PCI spec don't dictate this.  We're free to
    do what we want here.

  3) should VF devices be represented by pci_dev structs?
    Yes.  (This is an easy one :)

  4) can VF devices be used on the host?
    Yet again, SR-IOV doesn't dictate this.  Developers can make PF/VF combo
    drivers or split them, and export the resulting devices however they want. 
    Some subsystem work may be needed to make this efficient, but SR-IOV
    itself is agnostic about it.

So overall I didn't see many objections to the actual code in the last post, 
and the issues above certainly don't merit a NAK IMO...

Given a respin of 10-13 I think it's reasonable to merge this into 2.6.29, but 
I'd be much happier about it if we got some driver code along with it, so as 
not to have an unused interface sitting around for who knows how many 
releases.  Is that reasonable?  Do you know if any of the corresponding PF/VF 
driver bits are ready yet?

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
