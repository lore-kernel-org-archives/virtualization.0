From: Zachary Amsden <zach-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/5] KVM paravirt_ops implementation
Date: Wed, 20 Jun 2007 14:08:37 -0700
Message-ID: <46799755.8060405@vmware.com>
References: <4675F462.1010708@codemonkey.ws> <4675F9DE.6080806@goop.org>
	<4675FDCA.4040006@codemonkey.ws> <4676084F.3090901@goop.org>
	<46787325.30804@vmware.com> <4679381E.9090404@codemonkey.ws>
	<46794899.6070708@goop.org> <46798174.2060304@vmware.com>
	<46798597.4020903@codemonkey.ws> <4679882B.7070605@vmware.com>
	<46798B16.5090407@goop.org> <46798D9B.5000400@codemonkey.ws>
	<46799157.3070805@vmware.com> <467993B1.6000307@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <467993B1.6000307-TSDbQ3PG+2Y@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Cc: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Zachary Amsden wrote:
>> Unless you also migrate the hypercall page itself and impose 
>> migration restrictions on compatible hypercall pages.
>
> Seems unreasonable, especially if you support migration between VT and 
> SVM machines.  The whole point of a hypercall page is to give you a 
> point of indirection in order to hide these kinds of hardware 
> differences; migrating it would defeat the purpose.

Migrating across Intel<->AMD is likely to be problematic for many other 
reasons, and in general, migrating between such different hardware (yes, 
different instruction sets even) will probably not be possible in the 
majority of cases.

If I had a gentoo install, I would probably go so far as to want to 
recompile everything after migration across CPU vendors; things like 
NMIs, MSRs, thermal controls and sleep states are also vendor dependent 
and either need to be emulated both ways, re-invented in a new way 
entirely, or just dropped.

I don't think cross-CPU vendor hot migration is particularly compelling, 
although it certainly is possible, the payoff doesn't seem worth the 
implementation cost and you will find a maze of brambly thorns blocking 
your path.

>> Although I favor the guarantee that execution within the hypercall 
>> page is finished - it is important for protecting against 
>> non-reentrancy as well.  Think about interrupts during batching / 
>> queueing operations.
>
> Not quite sure that's specifically relevant to migration, but yes, its 
> important to disable interrupts while doing the setup for a batch of 
> stuff unless you want to see some surprises in your queue (and not 
> "Oh, yay, a puppy!" kind of surprises).

I would argue making the hypercall page atomic is a better solution to 
reentrancy than disable / enable, but perhaps just because it happened 
to work out very nicely for our implementation.  The point is, that also 
solves part of the migration problem.

Zach

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
