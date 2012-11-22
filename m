From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 01/11] kexec: introduce kexec_ops struct
Date: Thu, 22 Nov 2012 09:37:45 -0800
Message-ID: <50AE62E9.3000602@zytor.com>
References: <1353423893-23125-1-git-send-email-daniel.kiper@oracle.com>
	<1353423893-23125-2-git-send-email-daniel.kiper@oracle.com>
	<87lidwtego.fsf@xmission.com>
	<20121121105221.GA2925@host-192-168-1-59.local.net-space.pl>
	<87txshx28b.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87txshx28b.fsf@xmission.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, Daniel Kiper <daniel.kiper@oracle.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, jbeulich@suse.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

On 11/22/2012 04:15 AM, Eric W. Biederman wrote:
>
> Let me be clear.  kexec_ops as you have implemented it is absolutely
> unacceptable.
>
> Your kexec_ops is not an abstraction but a hack that enshrines in stone
> implementation details.
>

This is the kind of stuff that is absolutely endemic to the Xen 
endeavour, and which is why Xen is such a disease.  The design principle 
seems to have been "hey, let's go and replace random Linux kernel 
internals with our own stuff, and make them ABIs, so that they can never 
change.  Oh, and let's not bother documenting the constraints we're 
imposing, that might make the code manageable."

I actually talked to Ian Jackson at LCE, and mentioned among other 
things the bogosity of requiring a PUD page for three-level paging in 
Linux -- a bogosity which has spread from Xen into native.  It's a page 
wasted for no good reason, since it only contains 32 bytes worth of 
data, *inherently*.  Furthermore, contrary to popular belief, it is 
*not* pa page table per se.

Ian told me: "I didn't know we did that, and we shouldn't have to." 
Here we have suffered this overhead for at least six years, because *XEN 
FUCKED UP AND NOONE ELSE HAD ANY WAY OF KNOWING THAT*.

Now we know that it can "maybe"(!!!) be fixed, if we are willing to 
spend time working on a dying platform, whereas we have already suffered 
the damage during the height of its importance.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
