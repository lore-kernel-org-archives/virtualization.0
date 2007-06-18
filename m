From: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Subject: Re: [PATCH 5/5] KVM: paravirt time source
Date: Mon, 18 Jun 2007 18:33:19 -0500
Message-ID: <4677163F.2030308@codemonkey.ws>
References: <4675F462.1010708@codemonkey.ws> <4675F601.3090706@codemonkey.ws>
	<4676D8E4.3020806@goop.org> <4676FEB9.6060308@codemonkey.ws>
	<46770162.6030101@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46770162.6030101-TSDbQ3PG+2Y@public.gmane.org>
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
> Anthony Liguori wrote:
>   
>> Okay.  I may remove this patch from the patch series and attempt to
>> sit down next week and work out something more complete that also
>> implements stolen time accounting.
>>     
>
> Well, that's a separate problem.  clocksource.read should always return
> real time passed, so stolen time doesn't come into it.

Right.

>  
> paravirt_ops.sched_clock should take stolen time into account, but
> that's almost completely orthogonal.
>   

Except that I wanted to change the hypercall to allow querying of real 
time or "available" time as VMI puts it.

> How are you doing clockevents?
>   

Right now, I'm relying on the PIT but it would be nice to eliminate 
that.  I'd like to move to something PV so that I can make use of 
tickless guest kernels.  I'm very open to suggestion and even more open 
to reusing other people's code :-)

Regards,

Anthony Liguori

>     J
>
>   


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
