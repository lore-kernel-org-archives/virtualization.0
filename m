From: Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC, PATCH 5/5] Paravirt_ops export.patch
Date: Mon, 23 Apr 2007 13:53:16 -0700
Message-ID: <462D1CBC.6050405@vmware.com>
References: <20070420015304.74394BFC@zach-dev2.vmware.com>	
	<46284B40.5010106@goop.org>
	<m1y7kkzdon.fsf@ebiederm.dsl.xmission.com>
	<8a06f3d10704220959r16a78690ib1c90c56e4d1367@mail.gmail.com>
	<462B9BE6.6040302@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <462B9BE6.6040302@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zamsden@gmail.com>, Andi Kleen <ak@muc.de>, Petr Vandrovec <petr@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Zachary Amsden wrote:
>   
>> Doing nothing is a BUG, even before this change.  If you can't patch
>> in a properly virtualizable substitute for a non-virtualizable
>> sequence, the kernel will not work.  The only way for the patching to
>> fail is for lack of space or failure to meet clobber constraints, both
>> of which would be fatal even without the patching.
>>     
>
> Could you give a specific example?  Because the intent is that if you do
> nothing (ie, don't apply patching at all), then you'll just end up with
> indirect calls which will be a bit expensive but completely functional. 
> The idea is that every time there's a paravirt call, it must be
> surrounded with push/pops to make the C call compatible with the
> callsite's register usage.  Or are you talking about something else?
>   

There are two specific examples, both of which are real BUGs.  If there 
is not enough space to do generic patching to a direct function call, 
then it is a bug, since there would not have even been enough space to 
do an indirect call in the first place.  Obviously, with the i386 ISA, 
this is impossible as long as there was an indirect in the first place.  
But an attempt to place native "cli" inline with no padding, to use as a 
patch point, would fire this BUG and rightly so.

The second BUG I added is also justified.  If the patch point has a 
smaller than normal clobber list, then the original indirect call is 
incorrect unless the code has taken care to save and restore clobbered 
registers around the patch point.  That is the case today, but there is 
nothing validating that in the patching code.

We could make the patching code more intelligent and have it emit the 
proper push / pop sequence around the call, but it is difficult to do 
and does not work for more than 3 argument function calls.  Or we could 
record the EIP of the call instruction in the patch information, 
allowing the patcher to either overwrite the whole thing, or do indirect 
/ direct conversion.

asm volatile("
patch_begin:
    push %edx
    push %ecx
 patch_call:
    call *(paravirt_ops+op*4)
   pop %ecx
   pop %edx
patch_end:
.section .paravirt_patch
.long patch_begin
.long patch_end
.long patch_call
.byte CLBR_ANY
" :: "eax");

Maybe that is too complicated for just this special case.

>> 2) You must support dynamic re-linking - the kernel has to boot and
>> use builtin native style operations before switching over to the
>> virtualized operations.  So you have to have some kind of jettisonable
>> early binding support.
>>     
>
> I don't think there's any particular reason we can't do this very early,
> at the same time we currently populate paravirt_ops.  I think the idea
> is that if you do nothing, the calls will all point to the native
> versions, so if you do the late-paravirtualization (do you still do
> that?) then you'll get native ops initially.
>   

Yes, we still do late paravirtualization.  My point is that because of 
that, you can't just link once and be done with it - you must relink the 
paravirt-ops later, which is more complex than a one time pre-execution 
link.

Zach
