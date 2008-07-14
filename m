From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] stopmachine: add stopmachine_timeout
Date: Mon, 14 Jul 2008 22:34:40 +1000
Message-ID: <200807142234.40700.rusty__19689.753073226$1216039059$gmane$org@rustcorp.com.au>
References: <487B05CE.1050508@jp.fujitsu.com>
	<200807141351.25092.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200807141351.25092.borntraeger@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Monday 14 July 2008 21:51:25 Christian Borntraeger wrote:
> Am Montag, 14. Juli 2008 schrieb Hidetoshi Seto:
> > +	/* Wait all others come to life */
> > +	while (cpus_weight(prepared_cpus) != num_online_cpus() - 1) {
> > +		if (time_is_before_jiffies(limit))
> > +			goto timeout;
> > +		cpu_relax();
> > +	}
> > +
>
> Hmm. I think this could become interesting on virtual machines. The
> hypervisor might be to busy to schedule a specific cpu at certain load
> scenarios. This would cause a failure even if the cpu is not really locked
> up. We had similar problems with the soft lockup daemon on s390.

5 seconds is a fairly long time.  If all else fails we could have a config 
option to simply disable this code.

> It would be good to not-use wall-clock time, but really used cpu time
> instead. Unfortunately I have no idea, if that is possible in a generic
> way. Heiko, any ideas?

Ah, cpu time comes up again.  Perhaps we should actually dig that up again; 
Zach and Jeremy CC'd.

Thanks,
Rusty.
