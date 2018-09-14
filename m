From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [patch 10/11] x86/vdso: Move cycle_last handling into the caller
Date: Fri, 14 Sep 2018 17:26:01 +0200
Message-ID: <874les85iu.fsf__31890.0876016871$1536938650$gmane$org@vitty.brq.redhat.com>
References: <20180914125006.349747096@linutronix.de>
	<20180914125118.998589817@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180914125118.998589817@linutronix.de> (Thomas Gleixner's
	message of "Fri, 14 Sep 2018 14:50:16 +0200")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Dereferencing gtod->cycle_last all over the place and foing the cycles <
> last comparison in the vclock read functions generates horrible code. Doing
> it at the call site is much better and gains a few cycles both for TSC and
> pvclock.
>
> Caveat: This adds the comparison to the hyperv vclock as well, but I have
> no way to test that.

While the change looks obviously correct for Hyper-V vclock too, by saying
that you encouraged me to give the whole series a shot. I did and turns
out Hyper-V vclock is broken: simple clock_gettime(CLOCK_REALTIME, )
test goes from 70 cpu cycles to 1000 (meaning that we're falling back to
syscall I guess). Bisecting now, stay tuned!

-- 
  Vitaly
