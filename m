From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 00/21] Xen-paravirt: Xen guest
	implementation for paravirt_ops interface
Date: Sat, 17 Feb 2007 15:58:18 +1100
Message-ID: <1171688298.18876.63.camel@localhost.localdomain>
References: <20070216022449.739760547@goop.org>
	<Pine.LNX.4.64.0702161244380.26718@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <Pine.LNX.4.64.0702161244380.26718@schroedinger.engr.sgi.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Christoph Lameter <clameter@sgi.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-02-16 at 12:49 -0800, Christoph Lameter wrote:
> On Thu, 15 Feb 2007, Jeremy Fitzhardinge wrote:
> 
> > This patch series implements the Linux Xen guest in terms of the
> > paravirt-ops interface.  The features in implemented this patch series
> 
> I am thoroughly confused. Maybe that is because I have not been following 
> this issue closely but it seems that you are using the paravirt interface 
> as an API for Xen code in the guest? I thought the idea of paravirt was to 
> have an API that is generic? This patchset seems to be mostly realizing 
> Xen specific functionality? How does the code here interact with KVM, 
> VMWare and other hypervisors?

It doesn't.  Paravirt_ops provides the hooks.  KVM, lguest, VMI and Xen
all need to implement what they want on top of them.

Hope that clarifies,
Rusty.
