From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [PATCH] stopmachine: add stopmachine_timeout v3
Date: Wed, 16 Jul 2008 17:12:42 +0900
Message-ID: <487DAD7A.8080407__40907.7474302196$1216196274$gmane$org@jp.fujitsu.com>
References: <487B05CE.1050508@jp.fujitsu.com>	
	<487D78A3.6050105@jp.fujitsu.com> <487D93CD.1000007@qualcomm.com>	
	<487D96A2.10904@jp.fujitsu.com> <487D9A8B.5020005@jp.fujitsu.com>
	<1216193615.5232.11.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1216193615.5232.11.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Max Krasnyansky <maxk@qualcomm.com>
List-Id: virtualization@lists.linuxfoundation.org

Peter Zijlstra wrote:
> I really don't like this, it means the system is really screwed up and
> doesn't deserve to continue.

It can be said that after timeout we just back to previous state, where
machine already limp(=partially screwed up), but have some degree of
performance.  We might be able to do some recovery, such as killing
process, restart or reset of subsystem and so on.  Even if a CPU get
stuck, it might be possible to continue its service with remaining
CPUs, ex. assume there are 1024 CPUs total.
(I wish if we were able to force-reset such unstable CPU in future...)

I agree that there are much amount of situation where this feature is
not acceptable.  But there would be others.

Thanks,
H.Seto
