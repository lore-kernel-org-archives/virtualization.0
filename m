From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 24/26] Xen-paravirt_ops: Add the Xenbus sysfs and virtual
	device hotplug driver.
Date: Fri, 16 Mar 2007 09:18:04 -0700
Message-ID: <20070316161804.GH10574@sequoia.sous-sol.org>
References: <20070301232443.195603797@goop.org>
	<20070301232529.271605211@goop.org>
	<20070316084704.GB23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070316084704.GB23174@elte.hu>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>
Cc: xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@suse.de>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

* Ingo Molnar (mingo@elte.hu) wrote:
> =

> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> =

> > This communicates with the machine control software via a registry =

> > residing in a controlling virtual machine. This allows dynamic =

> > creation, destruction and modification of virtual device =

> > configurations (network devices, block devices and CPUS, to name some =

> > examples).
> =

> should be reviewed by the driver-core folks too i guess?

Greg has gone through it a couple times.  Any more feedback would
be useful.

> > +//#include <asm/maddr.h>
> =

> > +//#include <xen/xen_proc.h>
> > +//#include <xen/evtchn.h>
> =

> > +//#include <xen/hvm.h>
> =

> > +//		.shutdown =3D xenbus_dev_shutdown,
> =

> hm?

fixing that up, not sure where that snuck in.
