From: Zachary Amsden <zach@vmware.com>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Tue, 06 Mar 2007 00:55:30 -0800
Message-ID: <45ED2C82.3080008@vmware.com>
References: <200703060654.l266sVxr014860@shell0.pdx.osdl.net>
	<45ED16D2.3000202@vmware.com> <20070306084258.GA15745@elte.hu>
	<20070306084647.GA16280@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070306084647.GA16280@elte.hu>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, mm-commits@vger.kernel.org, tglx@linutronix.de, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
>
>   =

>> no, that's not the case: next_timer_interrupt() is the NO_IDLE_HZ =

>> method of doing things - while in the NO_HZ case you are supposed to =

>> use clockevent devices to program timer hardware.
>>     =


We don't have a clockevent device.  But we need NO_IDLE_HZ support, =

which NO_HZ has now subsumed.

> a proper CE device also has the added bonus of making high-res timers =

> guests work automatically. It should be simple: just pass it through to =

> your hypervisor, a hyper-CE-device, like a hyper-clocksource device has =

> essentially no guest-side complexity.
>   =


It is not so simple.  In theory it works great.  In reality, the i386 =

implementation is completely hardwired to work the way hardware works, =

and breaking the clockevent code out of the deep ties to the APIC is =

extremely non-trivial.  We tried, and could not accomplish it for 2.6.21 =

because the hrtimers integration was complex, and introduced many bugs =

for us.  We worked around this by keeping NO_IDLE_HZ support, which now =

you deprecated.  So now we are using NO_HZ without a hyper-CE device, =

and it is working fine.  We understand the benefits of moving to the CE =

model - but it cannot be done overnight.

Xen has the same requirements for integrating their timer code.

Zach
