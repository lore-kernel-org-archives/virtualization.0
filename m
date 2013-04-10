From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: make IDT read-only
Date: Wed, 10 Apr 2013 09:48:27 -0700
Message-ID: <516597DB.4020208@zytor.com>
References: <20130408224328.GA17641@www.outflux.net>
	<51634935.9010905@zytor.com> <877gkc596d.fsf@xmission.com>
	<20130410095716.GF24443@gmail.com> <87sj2yzn1a.fsf@xmission.com>
	<CAG7+5M06h_UEy39OQqdT7Z6r-85q_R9zHHKGO6F2PX2pgT6U9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAG7+5M06h_UEy39OQqdT7Z6r-85q_R9zHHKGO6F2PX2pgT6U9g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eric Northup <digitaleric@google.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Frederic Weisbecker <fweisbec@gmail.com>, Dan Rosenberg <drosenberg@vsecurity.com>, lf-virt <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Alex Shi <alex.shi@intel.com>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Kees Cook <keescook@chromium.org>, Julien Tinnes <jln@google.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <borislav.petkov@amd.com>, Steven Rostedt <rostedt@goodmis.org>, Xen Devel <xen-devel@lists.xensource.com>, Thomas Gleixner <tglx@linutronix.de>, Will Drewry <wad@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebie>
List-Id: virtualization@lists.linuxfoundation.org

On 04/10/2013 09:31 AM, Eric Northup wrote:
>>
>> If the effect is measurable I agree it is a legitimate optimization.  At
>> one point there was a suggestion to make the code in the IDT vectors
>> differ based on the which interrupt was registed.  While that can also
>> reduce cache misses that can get hairy very quickly, and of course that
>> would require read-write IDTs.
> 
> read-write IDT or GDT are fine: map them twice, once read+write, once
> read-only.  Point the GDTR and IDTR at the read-only alias.
> 

Well, it is weaker, because if you can discover the pointer to the
writable alias you win.

Now, as has been pointed out the GDT needs to be writable on 32 bits as
a matter of hardware requirement.  However, doing it for 64 bits only is
probably enough of a win.

	-hpa
