From: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Subject: Re: [PATCH 0/5] KVM paravirt_ops implementation
Date: Sun, 17 Jun 2007 20:19:58 -0700
Message-ID: <4675F9DE.6080806@goop.org>
References: <4675F462.1010708@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4675F462.1010708-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Cc: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> 1) Not really sure what is needed for CONFIG_PREEMPT support.  I'm not
> sure which paravirt_ops calls are actually re-entrant.

I'm not sure that has specifically come up.  The main issue is whether a
particular call can be preempted and whether that matters.  I guess the
calls which affect a particular CPU's state will generally be called in
a non-preemptable context, but I guess we can't assume that; the best
approach is to assume that each call be atomic with respect to preemption.

Things like batching must be completed with preemption disabled over the
whole batch.  I check that with BUG_ON in the Xen code.

> 2) The paravirt_ops implementation is registered with
> core_initcall().  However, the paravirt_ops banner is also printed
> with core_initcall() so that fact that this works now is just the luck
> of build order.  Need a better way to initialize the KVM paravirt_ops
> backend.

Hm.  We could make the banner printing later; obviously its purely
cosmetic.  I put it as a core_initcall on the assumption that pv-ops
would be set up very early as it is with Xen and lguest, and so the
banner should print relatively early.  But if your model is that you
boot fully virtualized for a while, and then become paravirtualized
later, then it would make sense to defer banner printing until then.

    J

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
