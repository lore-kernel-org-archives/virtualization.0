From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 24/26] Xen-paravirt_ops: Add the Xenbus sysfs and virtual
	device hotplug driver.
Date: Fri, 16 Mar 2007 09:47:04 +0100
Message-ID: <20070316084704.GB23174@elte.hu>
References: <20070301232443.195603797@goop.org>
	<20070301232529.271605211@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070301232529.271605211@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> This communicates with the machine control software via a registry =

> residing in a controlling virtual machine. This allows dynamic =

> creation, destruction and modification of virtual device =

> configurations (network devices, block devices and CPUS, to name some =

> examples).

should be reviewed by the driver-core folks too i guess?

> +//#include <asm/maddr.h>

> +//#include <xen/xen_proc.h>
> +//#include <xen/evtchn.h>

> +//#include <xen/hvm.h>

> +//		.shutdown =3D xenbus_dev_shutdown,

hm?

	Ingo
