From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [PATCH] stopmachine: add stopmachine_timeout
Date: Tue, 15 Jul 2008 11:24:52 +0900
Message-ID: <487C0A74.4070903__709.753044839267$1216162145$gmane$org@jp.fujitsu.com>
References: <487B05CE.1050508@jp.fujitsu.com>
	<200807141351.25092.borntraeger@de.ibm.com>
	<200807142234.40700.rusty@rustcorp.com.au>
	<487BA152.1070102@goop.org>
	<20080714212026.GA6705@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080714212026.GA6705@osiris.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Heiko Carstens wrote:
> Hmm.. probably a stupid question: but what could happen that a real cpu
> (not virtual) becomes unresponsive so that it won't schedule a MAX_RT_PRIO-1
> prioritized task for 5 seconds?

The original problem (once I heard and easily reproduced) was there was an
another MAX_RT_PRIO-1 task and the task was spinning in itself by a bug.
(Now this would not be a problem since RLIMIT_RTTIME will work for it, but
 I cannot deny that there are some situations which cannot set the limit.)

However there would be more possible problem in the world, ex. assume that
a routine work with interrupt (and also preemption) disabled have an issue
of scalability so it takes long time on huge machine then stop_machine will
stop whole system such long time.  You can assume a driver's bug.  Now the
stop_machine is good tool to escalate a partial problem to global suddenly.

>> So I think monotonic wallclock time actually makes the most sense here.
> 
> This is asking for trouble... a config option to disable this would be
> nice. But as I don't know which problem this patch originally addresses
> it might be that this is needed anyway. So lets see why we need it first.

I'm not good at VM etc., but I think user doesn't care who holds a cpu,
whether other guest or actual buggy software or space alien or so.
The important thing here is return control to user if timeout.

Thanks,
H.Seto
