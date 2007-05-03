From: Matt Mackall <mpm@selenic.com>
Subject: Re: [RELEASE] Lguest for 2.6.21
Date: Thu, 3 May 2007 11:02:01 -0500
Message-ID: <20070503160201.GR11166@waste.org>
References: <1178117028.19815.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1178117028.19815.14.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 03, 2007 at 12:43:48AM +1000, Rusty Russell wrote:
> Hi all,
> 
> 	Lguest is a simple hypervisor which runs Linux under Linux, without
> needing VT hardware.
> 
> 	Two people asked if I had a version of lguest which worked on
> other-than-bleeding-edge-mm kernels, so I did a backport of the latest
> version to 2.6.21.
> 
> 	http://lguest.ozlabs.org/lguest-2.6.21-254.patch.gz
> 
> See Documentation/lguest/lguest.txt for how to run,
> drivers/lguest/README for the draft code documentation journey.

Your lguest readme is quite lacking in the area of how to configure a
guest kernel as opposed to the host kernel. More hand-holding, please.

Maybe it's obvious once I've actually applied the patch and run
menuconfig, but I'm loathe to attempt anything that isn't a cake walk
at my current loadavg, especially given the fits of blind rage trying
to do anything nontrivial with Xen tends to provoke in me.

-- 
Mathematics is the supreme nostalgia of our time.
