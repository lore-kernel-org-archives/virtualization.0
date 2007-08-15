From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [PATCH 21/25][V3] export cpu_gdt_descr
Date: Wed, 15 Aug 2007 12:28:00 -0300
Message-ID: <46C31B80.4040509@redhat.com>
References: <11871823373106-git-send-email-gcosta@redhat.com>
	<11871823673236-git-send-email-gcosta@redhat.com>
	<11871823782610-git-send-email-gcosta@redhat.com>
	<11871823892519-git-send-email-gcosta@redhat.com>
	<11871823991803-git-send-email-gcosta@redhat.com>
	<11871824081337-git-send-email-!gcosta@redhat.com>
	<11871824192375-git-send-email-gcosta@redhat.com>
	<11871824292046-git-send-email-gcosta@redhat.com>
	<20070815140339.GG3406@bingen.suse.de>
	<5d6222a80708150725i45a064bfqfd43139338287988@mail.gmail.com>
	<20070815154351.GI3406@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070815154351.GI3406@bingen.suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen escreveu:
> On Wed, Aug 15, 2007 at 11:25:43AM -0300, Glauber de Oliveira Costa wrote:
>> On 8/15/07, Andi Kleen <ak@suse.de> wrote:
>>>> +#ifdef CONFIG_PARAVIRT
>>>> +extern unsigned long *cpu_gdt_descr;
>>> No externs in .c files
>>>
>>> Normally they should be where the variable is defined
>>> anyways.
>> Given that this  variable is defined in head.S, what do you propose?
> 
> Move it to C code first.
> 

duh. I haven't noticed that this variable is already defined as extern 
in desc.h.

If you don't oppose, I'll just include it in x8664_ksyms.c

Thanks for the nitpicking, Andi.
