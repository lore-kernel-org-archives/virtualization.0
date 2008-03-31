From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: Re: [PATCH 12/12] xen: import arch generic part of xencomm.
Date: Mon, 31 Mar 2008 18:49:27 +0900
Message-ID: <20080331094927.GI17609%yamahata__27906.1106885367$1206957234$gmane$org@valinux.co.jp>
References: <12067044183207-git-send-email-yamahata@valinux.co.jp>
	<12067044184070-git-send-email-yamahata@valinux.co.jp>
	<47ED508C.2000608@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <47ED508C.2000608@goop.org>
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
Cc: eddie.dong@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 28, 2008 at 01:09:48PM -0700, Jeremy Fitzhardinge wrote:
> Isaku Yamahata wrote:
> >On xen/ia64 and xen/powerpc hypercall arguments are passed by pseudo
> >physical address (guest physical address) so that it's necessary to
> >convert from virtual address into pseudo physical address. The frame
> >work is called xencomm.
> >Import arch generic part of xencomm.
> >
> >Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
> >---
> > drivers/xen/Makefile            |    1 +
> > drivers/xen/xencomm.c           |  232 
> > +++++++++++++++++++++++++++++++++++++++
> > include/xen/interface/xencomm.h |   41 +++++++
> > include/xen/xencomm.h           |   77 +++++++++++++
> >  
> 
> There's no Kconfig for this.
> 
> What ends up using xencomm?  Could we defer adding it until there's an 
> in-tree user?

We are in a dilemma.
ia64/xen needs xencomm so that it needs common xencomm code.
However merging common xencomm code needs the real user i.e. ia64/xen.

Another user of xencomm is powerpc/xen which isn't merged into
upstream. So another choice would be
- put the file into ia64 specific directory and
  merge the file through linux-ia64.
  When another user appears (possibly powerpc/xen),
  move the file into common place (drivers/xen).

We're now struggling for ia64/xen domU merge, so we want to make
ia64/xen domU patch series as small as possible.
Putting the file into drivers/xen is desirable for that.
However either way is ok.
Which way do you want (putting common dir or ia64 specfic dir)?

thanks,
-- 
yamahata
