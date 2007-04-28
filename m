From: ebiederm@xmission.com (Eric W. Biederman)
Subject: huh startup_ipi_hook?
Date: Sat, 28 Apr 2007 01:14:57 -0600
Message-ID: <m1d51pgeby.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org


The current paravirt startup_ipi hook for vmware 
commit: ae5da273fe3352febd38658d8d34484cbcfb3423
is quite frankly ridiculous.

In the middle of wake_up_secondary_cpu:
We have:
      /*
       * Paravirt / VMI wants a startup IPI hook here to set up the
       * target processor state.
       */
      startup_ipi_hook(phys_apicid, (unsigned long) start_secondary,
                       (unsigned long) stack_start.esp);

As far as I can tell from reading this there is a completely
different mechanism in place to start for a secondary processor.
Which seems sane.

What doesn't seem sane is bothering to run the rest of the code
for sending an INIT message to a secondary processor.  It certainly
does not feel general at all.

I think we should be intercepting this startup call at a higher level,
where we can just say:  Start secondary cpu with this stack
and with this esp.  Or something like that.

So conceptually I think the concept makes sense but implementation
wise I think what is currently present is totally ridiculous.

Eric
