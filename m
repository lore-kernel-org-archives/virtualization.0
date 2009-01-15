From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: Re: [PATCH] ia64, xen: compilation fix caused by
	79741dd35713ff4f6fd0eafd59fa94e8a4ba922d
Date: Thu, 15 Jan 2009 19:32:06 +0900
Message-ID: <20090115103206.GT1565%yamahata__40350.5461560146$1232015759$gmane$org@valinux.co.jp>
References: <20090115061655.GM1565%yamahata@valinux.co.jp>
	<1232009643.30152.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1232009643.30152.6.camel@localhost>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: virtualization@linuxfoundation.org, tony.luck@intel.com, linux-ia64@vger.kernel.org, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 15, 2009 at 09:54:03AM +0100, Martin Schwidefsky wrote:
> On Thu, 2009-01-15 at 15:16 +0900, Isaku Yamahata wrote:
> > This patch fixes the following errors caused by
> > 79741dd35713ff4f6fd0eafd59fa94e8a4ba922d which changed
> > the prototypes of account_steal_time() and account_idle_time().
> > 
> > >   CC      arch/ia64/xen/time.o
> > > arch/ia64/xen/time.c: In function 'consider_steal_time':
> > > arch/ia64/xen/time.c:132: warning: passing argument 1 of 'account_steal_time' makes integer from pointer without a cast
> > > arch/ia64/xen/time.c:132: error: too many arguments to function 'account_steal_time'
> > > arch/ia64/xen/time.c:133: warning: passing argument 1 of 'account_steal_time' makes integer from pointer without a cast
> > > arch/ia64/xen/time.c:133: error: too many arguments to function 'account_steal_time'
> > 
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
> 
> Sorry, somehow I managed to miss this callsite for account_steal_time,
> probably because it has not been present with 2.6.27 which is the
> version I used to create the initial patch series.
> 
> I assume that this patch will be pushed via the ia64 patch queue, no?

I suppose that Tony would handle it. Tony?

-- 
yamahata
