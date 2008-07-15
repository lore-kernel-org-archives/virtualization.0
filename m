From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH] stopmachine: add stopmachine_timeout
Date: Mon, 14 Jul 2008 19:37:55 -0700
Message-ID: <487C0D83.8050106@qualcomm.com>
References: <487B05CE.1050508@jp.fujitsu.com>
	<200807141351.25092.borntraeger@de.ibm.com>
	<200807142234.40700.rusty@rustcorp.com.au>
	<487BA152.1070102@goop.org>
	<20080714212026.GA6705@osiris.boeblingen.de.ibm.com>
	<487C0A74.4070903@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <487C0A74.4070903@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org



Hidetoshi Seto wrote:
> Heiko Carstens wrote:
>> Hmm.. probably a stupid question: but what could happen that a real cpu
>> (not virtual) becomes unresponsive so that it won't schedule a MAX_RT_PRIO-1
>> prioritized task for 5 seconds?
> 
> The original problem (once I heard and easily reproduced) was there was an
> another MAX_RT_PRIO-1 task and the task was spinning in itself by a bug.
> (Now this would not be a problem since RLIMIT_RTTIME will work for it, but
> I cannot deny that there are some situations which cannot set the limit.)
Yep. As I described in the prev email in my case it's a legitimate thing. Some
of the CPU cores are running wireless basestation schedulers and the deadlines
are way too tight for them to sleep (it's "cpu as a dedicated engine" kind of
thing, they are properly isolated and stuff).

In this case actually RT limit is the first thing that I disable :).
I'd rather have stop_machine fail and tell the user that something is wrong.
In which case they can simply stop the basestation app that is running when
convinient. ie It give control back to the user rather than wedging the box or
killing the app.

Max
