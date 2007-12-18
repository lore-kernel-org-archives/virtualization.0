From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [PATCH 7/21] [PATCH] unify common parts of processor.h
Date: Tue, 18 Dec 2007 10:05:30 -0200
Message-ID: <4767B78A.5030903__22674.6045206257$1197979725$gmane$org@redhat.com>
References: <11979319641796-git-send-email-gcosta@redhat.com>
	<1197931971748-git-send-email-gcosta@redhat.com>
	<11979319763641-git-send-email-gcosta@redhat.com>
	<11979319811234-git-send-email-gcosta@redhat.com>
	<11979319853319-git-send-email-gcosta@redhat.com>
	<11979319903443-git-send-email-gcosta@redhat.com>
	<11979319953427-git-send-email-gcosta@redhat.com>
	<11979320011968-git-send-email-gcosta@redhat.com>
	<20071218114504.GA22832@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20071218114504.GA22832@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> * Glauber de Oliveira Costa <gcosta@redhat.com> wrote:
> 
>> This patch moves the pieces of processor_32.h and processor_64 that 
>> are equal to processor.h. Only what's exactly the same is moved 
>> around, the rest not being touched.
> 
> argh, it doesnt even build cleanly:
> 
>  In file included from include/linux/elf.h:6,
>                   from include/linux/module.h:14,
>                   from include/linux/crypto.h:21,
>                   from arch/x86/kernel/asm-offsets_32.c:7,
>                   from arch/x86/kernel/asm-offsets.c:2:
>  include/asm/elf.h:286: warning: 'struct mm_struct' declared inside parameter list
>  include/asm/elf.h:286: warning: its scope is only this definition or declaration, which is probably not what you want
> 
> due to zapping this bit of include/asm-x86/processor_32.h:
> 
>  -/* Forward declaration, a strange C thing */
>  -struct task_struct;
>  -struct mm_struct;
> 
> 	Ingo
> 
I'll test it with your config, and repost.
