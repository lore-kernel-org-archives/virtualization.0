From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RELEASE] Lguest for 2.6.21
Date: Fri, 04 May 2007 10:13:23 +1000
Message-ID: <1178237603.23670.26.camel__18565.0932988667$1178237688$gmane$org@localhost.localdomain>
References: <1178117028.19815.14.camel@localhost.localdomain>
	<20070503160201.GR11166@waste.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070503160201.GR11166@waste.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matt Mackall <mpm@selenic.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-05-03 at 11:02 -0500, Matt Mackall wrote:
> On Thu, May 03, 2007 at 12:43:48AM +1000, Rusty Russell wrote:
> > 	http://lguest.ozlabs.org/lguest-2.6.21-254.patch.gz
> > 
> > See Documentation/lguest/lguest.txt for how to run,
> > drivers/lguest/README for the draft code documentation journey.
> 
> Your lguest readme is quite lacking in the area of how to configure a
> guest kernel as opposed to the host kernel. More hand-holding, please.

Hi Matt!

	Ah, that's because they are the same kernel.  Turning on CONFIG_LGUEST
builds-in the parts needed to be a guest as well.

Thanks for pointing out that weakness.  I will modify lguest.txt to make
that clear.

Cheers,
Rusty.
