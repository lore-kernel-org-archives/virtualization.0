From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] Re: [patch] xen: off by one errors in multicalls.c
Date: Fri, 3 Jun 2011 15:57:15 -0400
Message-ID: <20110603195715.GB30940@dumpdata.com>
References: <20110603044528.GD3661@shale.localdomain>
	<4DE926D4.9010009@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4DE926D4.9010009@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "open list:XEN HYPERVISOR IN..." <xen-devel@lists.xensource.com>, Dan Carpenter <error27@gmail.com>, "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>, kernel-janitors@vger.kernel.org, "open list:XEN HYPERVISOR IN..." <virtualization@lists.linux-foundation.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 03, 2011 at 11:24:20AM -0700, Jeremy Fitzhardinge wrote:
> On 06/02/2011 09:45 PM, Dan Carpenter wrote:
> > b->args[] has MC_ARGS elements, so the comparison here should be
> > ">=" instead of ">".  Otherwise we read past the end of the array
> > one space.
> 
> Yeah, looks like a correct fix.  Fortunately I don't think anything
> currently hits that path in practice, though there are some pending
> patches which will exercise it more.

OK, queueing it for rc1.
