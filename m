From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] stopmachine: add stopmachine_timeout
Date: Wed, 16 Jul 2008 11:15:55 +0200
Message-ID: <200807161115.55214.borntraeger__37024.4919010021$1216200003$gmane$org@de.ibm.com>
References: <487B05CE.1050508@jp.fujitsu.com> <487C0A76.8060401@qualcomm.com>
	<200807151810.00365.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200807151810.00365.rusty@rustcorp.com.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, virtualization@lists.linux-foundation.org, Max Krasnyansky <maxk@qualcomm.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Dienstag, 15. Juli 2008 schrieb Rusty Russell:
> > btw Rusty, I just had this "why didn't I think of that" moments. This is
> > actually another way of handling my workload. I mean it certainly does not
> > fix the root case of the problems and we still need other things that we
> > talked about (non-blocking module delete, lock-free module insertion, etc)
> > but at least in the mean time it avoids wedging the machines for good.
> > btw I'd like that timeout in milliseconds. I think 5 seconds is way tooooo
> > long :).
> 
> We can make it ms, sure.  200ms should be plenty of time: worst I ever saw 
was 
> 150ms, and that was some weird Power box doing crazy stuff.  I wouldn't be 
> surprised if you'd never see 1ms on your hardware.

I disagree that 5 seconds is to long :-). I even think having it default to 0 
is the safest option for virtualized environments. What if the host is paging 
like hell and the vcpu cannot run due to a missing page? In that case 200ms 
can be an incredible short amount of time. If the timeout triggers, 
stop_machine_run fails, but everything would work fine - it just takes 
longer.
