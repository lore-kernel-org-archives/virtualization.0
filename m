From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH-tip v2 2/2] x86/xen: Deprecate xen_nopvspin
Date: Thu, 2 Nov 2017 14:28:05 +0100
Message-ID: <9039d470-c805-3d9d-c0a8-56cb3e539626@suse.com>
References: <1509569934-4919-1-git-send-email-longman@redhat.com>
	<1509569934-4919-3-git-send-email-longman@redhat.com>
	<5c36ed18-e59e-1ea3-28e0-414f88965761@oracle.com>
	<2fb79da7-4c95-160a-a626-670c536f490a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2fb79da7-4c95-160a-a626-670c536f490a@redhat.com>
Content-Language: de-DE
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <longman@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On 02/11/17 14:25, Waiman Long wrote:
> On 11/01/2017 06:01 PM, Boris Ostrovsky wrote:
>> On 11/01/2017 04:58 PM, Waiman Long wrote:
>>> +/* TODO: To be removed in a future kernel version */
>>>  static __init int xen_parse_nopvspin(char *arg)
>>>  {
>>> -	xen_pvspin = false;
>>> +	pr_warn("xen_nopvspin is deprecated, replace it with \"pvlock_type=queued\"!\n");
>>> +	if (!pv_spinlock_type)
>>> +		pv_spinlock_type = locktype_queued;
>> Since we currently end up using unfair locks and because you are
>> deprecating xen_nopvspin I wonder whether it would be better to set this
>> to locktype_unfair so that current behavior doesn't change. (Sorry, I
>> haven't responded to your earlier message before you posted this). Juergen?
> 
> I think the latest patch from Juergen in tip is to use native qspinlock
> when xen_nopvspin is specified. Right? That is why I made the current
> choice. I can certainly change to unfair if it is what you guys want.

No, when we are keeping xen_nopvspin (even as deprecated) it should
behave as designed, so locktype_queued is correct.


Juergen
