From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 24/26] Xen-paravirt_ops: Add the Xenbus
	sysfs and virtual device hotplug driver.
Date: Fri, 16 Mar 2007 17:19:48 +0100
Message-ID: <20070316161948.GE9413@elte.hu>
References: <20070301232443.195603797@goop.org>
	<20070301232529.271605211@goop.org>
	<20070316084704.GB23174@elte.hu>
	<20070316161804.GH10574@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <20070316161804.GH10574@sequoia.sous-sol.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Chris Wright <chrisw@sous-sol.org>
Cc: Zachary Amsden <zach@vmware.com>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, Andi Kleen <ak@muc.de>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@suse.de>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org


* Chris Wright <chrisw@sous-sol.org> wrote:

> * Ingo Molnar (mingo@elte.hu) wrote:
> > 
> > * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> > 
> > > This communicates with the machine control software via a registry 
> > > residing in a controlling virtual machine. This allows dynamic 
> > > creation, destruction and modification of virtual device 
> > > configurations (network devices, block devices and CPUS, to name some 
> > > examples).
> > 
> > should be reviewed by the driver-core folks too i guess?
> 
> Greg has gone through it a couple times.  Any more feedback would be 
> useful.

please indicate any such review feedback (and approval) via 
signed-off-by lines done by that person.

	Ingo
