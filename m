From: Konrad Rzeszutek Wilk <konrad@kernel.org>
Subject: Re: [Xen-devel] [PATCH 1/1] xen/xenbus: Remove duplicate inclusion
	of asm/xen/hypervisor.h
Date: Fri, 7 Dec 2012 16:16:48 -0500
Message-ID: <20121207211648.GC9664__27153.4090898514$1355939768$gmane$org@phenom.dumpdata.com>
References: <1353324150-21785-1-git-send-email-sachin.kamat@linaro.org>
	<CAK9yfHwz3jUpT6tRR4hUC9kLfocEbC-pkmwjiOkgmAmkPrZ-6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAK9yfHwz3jUpT6tRR4hUC9kLfocEbC-pkmwjiOkgmAmkPrZ-6Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: konrad.wilk@oracle.com, xen-devel@lists.xensource.com, patches@linaro.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 27, 2012 at 09:03:26AM +0530, Sachin Kamat wrote:
> ping

I think I have this in my tree.
> 
> On 19 November 2012 16:52, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> > asm/xen/hypervisor.h was included twice.
> >
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > ---
> >  drivers/xen/xenbus/xenbus_xs.c |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
> > index acedeab..88e677b 100644
> > --- a/drivers/xen/xenbus/xenbus_xs.c
> > +++ b/drivers/xen/xenbus/xenbus_xs.c
> > @@ -48,7 +48,6 @@
> >  #include <xen/xenbus.h>
> >  #include <xen/xen.h>
> >  #include "xenbus_comms.h"
> > -#include <asm/xen/hypervisor.h>
> >
> >  struct xs_stored_msg {
> >         struct list_head list;
> > --
> > 1.7.4.1
> >
> 
> 
> 
> -- 
> With warm regards,
> Sachin
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> http://lists.xen.org/xen-devel
> 
