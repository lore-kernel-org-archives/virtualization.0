From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] ia64, xen: compilation fix caused by
	79741dd35713ff4f6fd0eafd59fa94e8a4ba922d
Date: Thu, 15 Jan 2009 09:54:03 +0100
Message-ID: <1232009643.30152.6.camel__33723.222060553$1232010121$gmane$org@localhost>
References: <20090115061655.GM1565%yamahata@valinux.co.jp>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090115061655.GM1565%yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>
Cc: virtualization@linuxfoundation.org, tony.luck@intel.com, linux-ia64@vger.kernel.org, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2009-01-15 at 15:16 +0900, Isaku Yamahata wrote:
> This patch fixes the following errors caused by
> 79741dd35713ff4f6fd0eafd59fa94e8a4ba922d which changed
> the prototypes of account_steal_time() and account_idle_time().
> 
> >   CC      arch/ia64/xen/time.o
> > arch/ia64/xen/time.c: In function 'consider_steal_time':
> > arch/ia64/xen/time.c:132: warning: passing argument 1 of 'account_steal_time' makes integer from pointer without a cast
> > arch/ia64/xen/time.c:132: error: too many arguments to function 'account_steal_time'
> > arch/ia64/xen/time.c:133: warning: passing argument 1 of 'account_steal_time' makes integer from pointer without a cast
> > arch/ia64/xen/time.c:133: error: too many arguments to function 'account_steal_time'
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>

Sorry, somehow I managed to miss this callsite for account_steal_time,
probably because it has not been present with 2.6.27 which is the
version I used to create the initial patch series.

I assume that this patch will be pushed via the ia64 patch queue, no?

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
