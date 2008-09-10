From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 2/4 v2] PCI: support ARI capability
Date: Wed, 10 Sep 2008 14:07:21 -0600
Message-ID: <20080910200721.GI2772__22458.2676929005$1221077477$gmane$org@parisc-linux.org>
References: <ada3akjj268.fsf@cisco.com>
	<7A25B56E4BE99C4283EB931CD1A40E110181CAF7@pdsmsx414.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <7A25B56E4BE99C4283EB931CD1A40E110181CAF7@pdsmsx414.ccr.corp.intel.com>
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
Cc: Randy Dunlap <randy.dunlap@oracle.com>, xen-devel@lists.xensource.com, Grant Grundler <grundler@parisc-linux.org>, Alex Chiang <achiang@hp.com>, linux-pci@vger.kernel.org, Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 10, 2008 at 03:48:04PM +0800, Zhao, Yu wrote:
> >I agree with this improvement to the help text.  But a further question
> >is whether ARI even merits its own user-visible config option.  Is it
> >worth having yet another choice for users?  When would someone want ARI
> >but not SR-IOV?
> 
> ARI is an independent PCI Express extended capability. Multi-function devices supporting this capability may use it to track dependency between different functions and assign function group numbers to these functions.
> 
> Another reason to keep this separated with SR-IOV is that after ARI is enabled, PCI Express Endpoint may have non-zero slot number (device number), which is different from traditional PCI Express Endpoint.

Let me ask the question slightly differently: Why would someone want to
turn the capability off?  Is it just to save a few hundred bytes in the
kernel image, or is there some hardware that won't work?  Or some other
reason I haven't thought of?

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
