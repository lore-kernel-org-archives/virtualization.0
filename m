From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 11/11] x66/vdso: Add CLOCK_TAI support
Date: Sun, 16 Sep 2018 11:39:04 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809161129520.1650__15388.1296668716$1537090650$gmane$org@nanos.tec.linutronix.de>
References: <20180914125006.349747096@linutronix.de>
	<20180914125119.081037164@linutronix.de>
	<ABB53D42-2A06-41B9-8A8C-40B39CD0289D@amacapital.net>
	<alpine.DEB.2.21.1809141625040.10480@nanos.tec.linutronix.de>
	<FAE37798-8CCE-44A5-9EF0-F69C2199BE60@amacapital.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1473863026-1537090744=:1650"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <FAE37798-8CCE-44A5-9EF0-F69C2199BE60@amacapital.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1473863026-1537090744=:1650
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 14 Sep 2018, Andy Lutomirski wrote:
> > On Sep 14, 2018, at 7:27 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Fri, 14 Sep 2018, Andy Lutomirski wrote:
> >> That’s... horrible. In an amazing way. Can you add BUILD_BUG_ON somewhere
> >> to assert that this actually works?
> > 
> > Sure, but changing any of the clock ids will cause more wreckage than that.
> > 
> I’m more concerned that we add a new one and break the magic
> masking. Maybe two start sharing the same slot.

You are right. The obvious extension is CLOCK_BOOTTIME. That's id 7 which
indeed conflicts. I'll remove the magic.

Thanks,

	tglx
--8323329-1473863026-1537090744=:1650
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--8323329-1473863026-1537090744=:1650--
