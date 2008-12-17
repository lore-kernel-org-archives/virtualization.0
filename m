From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 0/13 v7] PCI: Linux kernel SR-IOV support
Date: Wed, 17 Dec 2008 11:42:54 -0800
Message-ID: <200812171142.56170.jbarnes__21491.9155034751$1229543185$gmane$org@virtuousgeek.org>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
	<200812171051.36645.jbarnes@virtuousgeek.org>
	<43F901BD926A4E43B106BF17856F07554B525A02@orsmsx508.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <43F901BD926A4E43B106BF17856F07554B525A02@orsmsx508.amr.corp.intel.com>
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
To: "Rose, Gregory V" <gregory.v.rose@intel.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, Greg KH <greg@kroah.com>, "rdreier@cisco.com" <rdreier@cisco.com>, Jike Song <albcamus@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "horms@verge.net.au" <horms@verge.net.au>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "yinghai@kernel.org" <yinghai@kernel.org>, "bjorn.helgaas@hp.com" <bjorn.helgaas@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday, December 17, 2008 11:05 am Rose, Gregory V wrote:
> -----Original Message-----
> From: Jesse Barnes [mailto:jbarnes@virtuousgeek.org]
>
> On Wednesday, December 17, 2008 8:44 am Rose, Gregory V wrote:
> > As noted in the attached email to the netdev list, we (e1000_devel) will
> > support the API.
>
> Do you think you'll have those changes ready for 2.6.29?  Would merging
> core SR-IOV support now make that any more likely?
>
>
>
> I'm not sure about readiness for 2.6.29.  I can tell you that as soon as I
> get a Xen Dom0 kernel with these API's included it will take me less than a
> day to convert over to them from the current drivers I have that are using
> an older API from back in August.  The drivers are mostly functional, they
> have a few bugs.  I could do some quick regression testing to make sure
> that the API changes haven't broken anything and then some bug fixes to get
> everything ready for release.  Maybe two or three weeks for the major bugs.
>  I'll be out over the Christmas holidays so that puts us into middle or
> late January if I got the Xen Dom0 kernel today.  That seems unlikely but
> it gives you an idea of the time required.

Hm, that's not the answer I was hoping for. :)  (Was looking for, "Yeah we 
just need this bits queued and we'll send an update for e1000 right away." :)

I really don't want the SR-IOV stuff to sit out another merge cycle though...  
Arg.

-- 
Jesse Barnes, Intel Open Source Technology Center
