From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH-tip v2 2/2] x86/xen: Deprecate xen_nopvspin
Date: Wed, 1 Nov 2017 18:01:10 -0400
Message-ID: <5c36ed18-e59e-1ea3-28e0-414f88965761@oracle.com>
References: <1509569934-4919-1-git-send-email-longman@redhat.com>
	<1509569934-4919-3-git-send-email-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1509569934-4919-3-git-send-email-longman@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Juergen Gross <jgross@suse.com>, Rusty Russell <rusty@rustcorp.com.au>, kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11/01/2017 04:58 PM, Waiman Long wrote:
> +/* TODO: To be removed in a future kernel version */
>  static __init int xen_parse_nopvspin(char *arg)
>  {
> -	xen_pvspin = false;
> +	pr_warn("xen_nopvspin is deprecated, replace it with \"pvlock_type=queued\"!\n");
> +	if (!pv_spinlock_type)
> +		pv_spinlock_type = locktype_queued;

Since we currently end up using unfair locks and because you are
deprecating xen_nopvspin I wonder whether it would be better to set this
to locktype_unfair so that current behavior doesn't change. (Sorry, I
haven't responded to your earlier message before you posted this). Juergen?

I am also not sure I agree with making pv_spinlock an enum *and* a
bitmask at the same time. I understand that it makes checks easier but I
think not assuming a value or a pattern would be better, especially
since none of the uses is on a critical path.

(For example, !pv_spinlock_type is the same as locktype_auto, which is
defined but never used)


-boris

>  	return 0;
>  }
>  early_param("xen_nopvspin", xen_parse_nopvspin);
> -
