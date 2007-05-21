From: Zachary Amsden <zach@vmware.com>
Subject: Re: changing definition of paravirt_ops.iret
Date: Mon, 21 May 2007 11:37:03 -0700
Message-ID: <4651E6CF.9010001@vmware.com>
References: <4651C865.9090605@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4651C865.9090605@goop.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> I'm implementing a more efficient version of the Xen iret paravirt_op,
> so that it can use the real iret instruction where possible.  I really
> need to get access to per-cpu variables, so I can set the event mask
> state in the vcpu_info structure, but unfortunately at the point where
> INTERRUPT_RETURN is used in entry.S, the usermode %fs has already been
> restored.
>
> How would you feel if we changed paravirt_ops.iret to make it also
> responsible for restoring %fs? 
>
> In other words, change RESTORE_REGS to skip %fs, and then native_iret
> would look like:
>
> 1:	popl %fs
> 	iret
>
> with the normal exception stuff.  Fortunately, %fs is already the first
> thing to be saved and last to be restored, so there's no major
> rearrangements.
>
> Ideally I'd also like a register to play with, but that would require
> rearranging pt_regs, which is a bit tricky.
>   

Strongly nacked.  If you need %fs and a free register, just push / pop 
them yourself.  We use push / pop to get %eax free for IRET in the VMI ROM.

A change in IRET call convention is performance critical, and has severe 
negative effects on VMI, since we then need to wrap the IRET entry point 
in the ROM with more code in Linux - so iret is a jump to fs restore, 
call to ROM gobbledygook that misaligns the call/return stack and rots 
performance in some hitherto unkown case - perhaps on native.

There is absolutely no argument that re-arranging entry.S like this is 
nightmarish and makes the code near unmaintainable without carefully 
considering the effects on paravirt-ops hypervisors.

If you really absolutely must avoid reloading %fs for your own 
performance, I can suggest several alternative schemes that, while more 
complex, might also make native exception handling faster, thus 
justifying the hack-to-bitty-pieces of entry.S

Zach
