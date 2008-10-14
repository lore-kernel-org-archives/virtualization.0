From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 6/6 v3] PCI: document the change
Date: Mon, 13 Oct 2008 22:46:26 -0600
Message-ID: <20081014044626.GB25780__23421.8982900076$1223959823$gmane$org@parisc-linux.org>
References: <D8078B8B3B09934AA9F8F2D5FB3F28CE088751B5F6@pdsmsx502.ccr.corp.intel.com>
	<20081001160706.GI13822@parisc-linux.org>
	<08DF4D958216244799FC84F3514D70F00235CC69@pdsmsx415.ccr.corp.intel.com>
	<20081014010827.GX25780@parisc-linux.org>
	<08DF4D958216244799FC84F3514D70F00235CE27@pdsmsx415.ccr.corp.intel.com>
	<20081014021435.GA1482@yzhao12-linux.sh.intel.com>
	<20081014040105.GA25780@parisc-linux.org>
	<08DF4D958216244799FC84F3514D70F00235CF5E@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <08DF4D958216244799FC84F3514D70F00235CF5E@pdsmsx415.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Dong, Eddie" <eddie.dong@intel.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Grant Grundler <grundler@parisc-linux.org>, Alex Chiang <achiang@hp.com>, linux-pci@vger.kernel.org, Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 14, 2008 at 12:18:40PM +0800, Dong, Eddie wrote:
> Matthew Wilcox wrote:
> > On Tue, Oct 14, 2008 at 10:14:35AM +0800, Yu Zhao wrote:
> >> As Eddie said, we have two problems here:
> >> 1) User has to set device specific parameters of a VF
> >> when he wants to use this VF with KVM (assign this
> >> device to KVM guest). In this case, 
> >> VF driver is not loaded in the host environment. So
> >> operations which 
> >> are implemented as driver callback (e.g.
> >> set_mac_address()) are not supported.
> > 
> > I suspect what you want to do is create, then configure
> > the device in the host, then assign it to the guest.
> 
> That is not true. Rememver the created VFs will be destroyed no matter
> for PF power event or error recovery conducted reset.
> So what we want is:
> 
> Config, create, assign, and then deassign and destroy and then
> recreate...

Yes, but my point is this all happens in the _host_, not in the _guest_.

> Sorry can u explain a little bit more? The SR-IOV patch won't define
> what kind of entries should be created or not, we leave network
> subsystem to decide what to do. Same for disk subsstem etc.

No entries should be created.  This needs to be not SR-IOV specific.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
