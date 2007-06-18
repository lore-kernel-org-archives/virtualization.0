From: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Subject: Re: [PATCH 0/5] KVM paravirt_ops implementation
Date: Sun, 17 Jun 2007 21:21:35 -0700
Message-ID: <4676084F.3090901@goop.org>
References: <4675F462.1010708@codemonkey.ws> <4675F9DE.6080806@goop.org>
	<4675FDCA.4040006@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4675FDCA.4040006-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
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
Cc: Zachary Amsden <zach-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> Hi Jeremy,
>
> Jeremy Fitzhardinge wrote:
>> Anthony Liguori wrote:
>>  
>>> 1) Not really sure what is needed for CONFIG_PREEMPT support.  I'm not
>>> sure which paravirt_ops calls are actually re-entrant.
>>>     
>>
>> I'm not sure that has specifically come up.  The main issue is whether a
>> particular call can be preempted and whether that matters.  I guess the
>> calls which affect a particular CPU's state will generally be called in
>> a non-preemptable context, but I guess we can't assume that; the best
>> approach is to assume that each call be atomic with respect to
>> preemption.
>>   
>
> So each call would need to disable preemption?  I'm not sure that
> makes a whole lot of sense for something like CR reads/writes.  In
> fact, without passing in a cpu parameter, I'm pretty sure that those
> operations *have* to require preemption to be disabled.

Yeah, its a little unclear to me.  If you're poking at a control
register, then one presumes you've got a specific CPU's CRx in mind. 
But in the Xen code I don't care about the preemption state for control
register updates - except for write_cr3, which never makes any sense
with preemption enabled.

> For something like MMU operations, preemption really doesn't have to
> be disabled.

Unless you're batching, since the lazy_mode is inherently per-cpu state.

>> Things like batching must be completed with preemption disabled over the
>> whole batch.  I check that with BUG_ON in the Xen code.
>>   
>
> Right now the KVM batching requires preemption to be disabled for
> batching.

I think that's probably overkill.  I had to put a few explicit
preempt_disable/enables in the Xen code, but mostly the preempt state is
reasonable for a given operation (ie, disabled for per-cpu state
updates, enabled for memory/global state updates).

>   I don't think that's a hard requirement though since we could pass
> the current batch PA as part of the flush hypercalls.

PA?

> Things are a lot easier though if we can just assume preemption is
> disabled :-)
>
> Are you aware of any paravirt_ops calls that are probably being called
> in the kernel with preemption enabled?

Erm, I haven't made a breakdown, but many are.  The descriptor updates
generally are, for example.  Pagetable updates could be, but are
generally done under a pagetable lock, and so are not preemptible anyway.

> I don't see a compelling reason to paravirtualize earlier although I
> also don't see a compelling reason not too.  I noticed that VMI hooks
> setup.c.  It wasn't immediately obvious why it was hooking there but
> perhaps it worthwhile to have a common hook?  I suspect VMI and KVM
> will have a similar model for startup.

Well, I was suggesting we could print the banner later rather than
forcing an earlier init.

The important part is that you set your pv_ops before patching occurs,
since that will bake the function calls into the rest of the kernel, and
it will ignore any further changes to the paravirt_ops structure.

I think Zach was originally thinking of initializing VMI much later
(even as a module load), but the subtleties of inveigling its way into
the kernel at that late stage got too complex.

    J

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
