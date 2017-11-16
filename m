From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC v3 3/6] sched/idle: Add a generic poll before enter
	real idle path
Date: Thu, 16 Nov 2017 10:53:41 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1711161048000.2191__48505.9228995398$1510826038$gmane$org@nanos>
References: <1510567565-5118-1-git-send-email-quan.xu0@gmail.com>
	<1510567565-5118-4-git-send-email-quan.xu0@gmail.com>
	<20171115121152.gqug5wzerlo3eimd@hirez.programming.kicks-ass.net>
	<alpine.DEB.2.20.1711152240010.2146@nanos>
	<46086489-5a01-16e1-9314-70ae53c01952@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2002752408-1510826021=:2191"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46086489-5a01-16e1-9314-70ae53c01952@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Quan Xu <quan.xu0@gmail.com>
Cc: Yang Zhang <yang.zhang.wz@gmail.com>, Len Brown <len.brown@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Kyle Huey <me@kylehuey.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Quan Xu <quan.xu03@gmail.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, Tobias Klauser <tklauser@distanz.ch>
List-Id: virtualization@lists.linuxfoundation.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2002752408-1510826021=:2191
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 16 Nov 2017, Quan Xu wrote:
> On 2017-11-16 06:03, Thomas Gleixner wrote:
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -210,6 +210,13 @@ int cpuidle_enter_state(struct cpuidle_device *dev,
> struct cpuidle_driver *drv,
>                 target_state = &drv->states[index];
>         }
> 
> +#ifdef CONFIG_PARAVIRT
> +       paravirt_idle_poll();
> +
> +       if (need_resched())
> +               return -EBUSY;
> +#endif

That's just plain wrong. We don't want to see any of this PARAVIRT crap in
anything outside the architecture/hypervisor interfacing code which really
needs it.

The problem can and must be solved at the generic level in the first place
to gather the data which can be used to make such decisions.

How that information is used might be either completely generic or requires
system specific variants. But as long as we don't have any information at
all we cannot discuss that.

Please sit down and write up which data needs to be considered to make
decisions about probabilistic polling. Then we need to compare and contrast
that with the data which is necessary to make power/idle state decisions.

I would be very surprised if this data would not overlap by at least 90%.

Thanks,

	tglx
--8323329-2002752408-1510826021=:2191
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--8323329-2002752408-1510826021=:2191--
