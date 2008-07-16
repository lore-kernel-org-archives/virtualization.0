From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH] stopmachine: add stopmachine_timeout v2
Date: Tue, 15 Jul 2008 23:23:09 -0700
Message-ID: <487D93CD.1000007__42403.7265278914$1216189564$gmane$org@qualcomm.com>
References: <487B05CE.1050508@jp.fujitsu.com> <487D78A3.6050105@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <487D78A3.6050105@jp.fujitsu.com>
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
> Thank you for useful feedbacks!
> Here is the updated version.
> Could you put this on top of your patches, Rusty?
> 
> Thanks,
> H.Seto
> 
> 
> If stop_machine() invoked while one of onlined cpu is locked up
> by some reason, stop_machine cannot finish its work because the
> locked cpu cannot stop.  This means all other healthy cpus
> will be blocked infinitely by one dead cpu.
> 
> This patch allows stop_machine to return -EBUSY with some printk
> messages if any of stop_machine's threads cannot start running on
> its target cpu.
> 
> v2:
>  - remove fix for warning since it will be fixed upcoming typesafe
>    patches
>  - make stopmachine_timeout from secs to msecs, and set default to
>    200 msec (since v1's arbitrary 5 sec is too long)
>  - allow disabling timeout by setting the stopmachine_timeout to 0
> 

I'd set the default to zero. I beleive that's what Heiko suggested too.

Max
