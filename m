From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native ops
Date: Mon, 07 Aug 2006 13:51:50 -0700
Message-ID: <44D7A7E6.2060401@vmware.com>
References: <1154925835.21647.29.camel@localhost.localdomain>	
	<200608070730.17813.ak@muc.de>
	<1154930669.7642.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1154930669.7642.12.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
>>> +
>>> +/*
>>> + * Set IOPL bits in EFLAGS from given mask
>>> + */
>>> +static inline void set_iopl_mask(unsigned mask)
>>>       =

>> This function can be completely written in C using local_save_flags()/lo=
cal_restore_flags()
>> Please do that. I guess it's still a good idea to keep it separated
>> though because it might allow other optimizations.
>>
>> e.g. i've been thinking about special casing IF changes in save/restore =
flags =

>> to optimize CPUs which have slow pushf/popf. If you already make sure
>> all non IF manipulations of flags are separated that would help.
>>     =



Actually, that is not quite true.  Local_save_flags / =

raw_local_irq_restore today is used only for operating on IF flag, and =

raw_local_restore_flags does not exist.  Our implementation of these in =

VMI assumes that only the IF flag is being changed, and this is the =

default assumption under which Xen runs as well.  Using local_restore to =

switch IOPL as well causes the extremely performance critical common =

case of pure IRQ restore to do potentially a lot more work in a hypervisor.

So if you do want us to go with the C approach, I would propose using =

raw_local_iopl_restore, which can make a different hypercall (actually, =

in our case, this is not even a hypercall, merely a VMI call).

Zach
