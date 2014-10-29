From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 3/3] x86: Support compiling out userspace I/O (iopl
	and ioperm)
Date: Wed, 29 Oct 2014 10:20:28 -0700
Message-ID: <545121DC.5050305__21691.3446588025$1414603281$gmane$org@zytor.com>
References: <7159269982aac3b732af2c33a2e3d04e2048bdfb.1414598511.git.josh@joshtriplett.org>
	<9d77d0e4df8feb2cb55fb21689e016a3145cb7f8.1414598511.git.josh@joshtriplett.org>
	<CAGXu5jKCuWmbUgNtnVWC2JQF3ML_SQQwBMooVynsbBO8cDLudA@mail.gmail.com>
	<20141029171754.GA18888@cloud>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141029171754.GA18888@cloud>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: josh@joshtriplett.org, Kees Cook <keescook@chromium.org>
Cc: "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On 10/29/2014 10:17 AM, josh@joshtriplett.org wrote:
>>
>> But this is entirely a style decision, so I leave it up to the x86
>> maintainers ...
> 
> I can certainly do that if the x86 maintainers prefer, but that tends to
> produce a net increase in lines of code, as well as duplicating all the
> function prototypes, which to me seems more error-prone.  If the
> stub versions contained any code, rather than just becoming no-ops, I'd
> definitely do that.
> 

I concur with this style choice.

>> Another nit may be that we should call this CONFIG_SYSCALL_IOPL or
>> CONFIG_SYSCALL_IOPERM in keeping with the other CONFIG_SYSCALL_*
>> naming thread? Again, I don't really care strongly beyond really
>> wanting to use this new feature! :)
> 
> I don't feel strongly about the naming.  Ingo?

It is sort of a special case here, as this reflects more than one syscall.

	-hpa
