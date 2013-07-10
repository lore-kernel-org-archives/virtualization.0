From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH RFC V9 0/19] Paravirtualized ticket spinlocks
Date: Wed, 10 Jul 2013 18:16:11 +0300
Message-ID: <20130710151611.GY24941@redhat.com>
References: <20130626113744.GA6300@hawk.usersys.redhat.com>
	<20130626125240.GY18508@redhat.com>
	<51CAEF45.3010203@linux.vnet.ibm.com>
	<20130626161130.GB18152@redhat.com>
	<51CB2AD9.5060508@linux.vnet.ibm.com>
	<51DBD3C2.2040807@linux.vnet.ibm.com>
	<20130710103325.GP24941@redhat.com>
	<20130710104047.GP25631@dyad.programming.kicks-ass.net>
	<20130710104717.GR24941@redhat.com>
	<20130710150315.GE11007@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130710150315.GE11007@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: jeremy@goop.org, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, riel@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, Andrew Jones <drjones@redhat.com>, stefano.stabellini@eu.citrix.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, gregkh@suse.de, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org, stephan.diestelhorst@amd.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 10, 2013 at 11:03:15AM -0400, Konrad Rzeszutek Wilk wrote:
> On Wed, Jul 10, 2013 at 01:47:17PM +0300, Gleb Natapov wrote:
> > On Wed, Jul 10, 2013 at 12:40:47PM +0200, Peter Zijlstra wrote:
> > > On Wed, Jul 10, 2013 at 01:33:25PM +0300, Gleb Natapov wrote:
> > > 
> > > Here's an idea, trim the damn email ;-) -- not only directed at gleb.
> > > 
> > Good idea.
> > 
> > > > > Ingo, Gleb,
> > > > > 
> > > > > From the results perspective, Andrew Theurer, Vinod's test results are
> > > > > pro-pvspinlock.
> > > > > Could you please help me to know what will make it a mergeable
> > > > > candidate?.
> > > > > 
> > > > I need to spend more time reviewing it :) The problem with PV interfaces
> > > > is that they are easy to add but hard to get rid of if better solution
> > > > (HW or otherwise) appears.
> > > 
> > > How so? Just make sure the registration for the PV interface is optional; that
> > > is, allow it to fail. A guest that fails the PV setup will either have to try
> > > another PV interface or fall back to 'native'.
> > > 
> > We have to carry PV around for live migration purposes. PV interface
> > cannot disappear under a running guest.
> 
> Why can't it? This is the same as handling say XSAVE operations. Some hosts
> might have it - some might not. It is the job of the toolstack to make sure
> to not migrate to the hosts which don't have it. Or bound the guest to the
> lowest interface (so don't enable the PV interface if the other hosts in the
> cluster can't support this flag)?
XSAVE is HW feature and it is not going disappear under you after software
upgrade. Upgrading kernel on part of your hosts and no longer been
able to migrate to them is not something people who use live migration
expect. In practise it means that updating all hosts in a datacenter to
newer kernel is no longer possible without rebooting VMs.

--
			Gleb.
