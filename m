From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/3] x86: tss: Eliminate fragile calculation of TSS segment
	limit
Date: Wed, 30 Oct 2013 15:53:11 -0700
Message-ID: <52718DD7.7040905@zytor.com>
References: <cover.1382407802.git.josh@joshtriplett.org>	<edeb47cf74bc015f4e36f5c5c7af4cd7d9532df8.1382407802.git.josh@joshtriplett.org>
	<CAGXu5jLNhzrQHtgkW8rAm3em=aEHsTXy+DndEqLJCMH0H8n_Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAGXu5jLNhzrQHtgkW8rAm3em=aEHsTXy+DndEqLJCMH0H8n_Sg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Kees Cook <keescook@chromium.org>, Josh Triplett <josh@joshtriplett.org>
Cc: Alexander van Heukelum <heukelum@fastmail.fm>, Jeremy Fitzhardinge <jeremy@goop.org>, "x86@kernel.org" <x86@kernel.org>, Len Brown <len.brown@intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Herrmann <dh.herrmann@gmail.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Seiji Aguchi <seiji.aguchi@hds.com>, Jiri Slaby <jslaby@suse.cz>, Alok Kataria <akataria@vmware.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Andi Kleen <ak@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, xen-devel@lists.xenproject.org, Borislav Petkov <bp@suse.de>, Fenghua Yu <fenghua.yu@intel.com>, Konrad
List-Id: virtualization@lists.linuxfoundation.org

On 10/30/2013 03:22 PM, Kees Cook wrote:
>>
>> -       /*
>> -        * sizeof(unsigned long) coming from an extra "long" at the end
>> -        * of the iobitmap. See tss_struct definition in processor.h
>> -        *
>> -        * -1? seg base+limit should be pointing to the address of the
>> -        * last valid byte
> 
> I think it might be better to keep at least a minimal comment near the
> TSS_LIMIT declaration, just to explain the "-1" part, which is not
> entirely obvious from just reading the code.
> 

Agreed, although it doesn't need to be an unsigned long at all... the
CPU will only ever access one extra byte past the end.

	-hpa
