From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 1/3] x86/xen: Avoid fast syscall path for Xen PV guests
Date: Wed, 18 Nov 2015 17:05:23 -0500
Message-ID: <564CF623.40502@oracle.com>
References: <1447877179-2775-1-git-send-email-boris.ostrovsky@oracle.com>
	<1447877179-2775-2-git-send-email-boris.ostrovsky@oracle.com>
	<CALCETrVUpqQy_EZMe8T5iRkA0FzS0Oz1Kuicr9yz3SwtdF1=9g@mail.gmail.com>
	<CAMzpN2iofkEeYkiZa8FRJ5gbz5smPbV0COOye9wZ9OhV6pBfow@mail.gmail.com>
	<CALCETrUTp=Shcmvh44fE5URugd6c41dDGdDM8cKvnP=Gqap45A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrUTp=Shcmvh44fE5URugd6c41dDGdDM8cKvnP=Gqap45A@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>, Brian Gerst <brgerst@gmail.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, Andrew Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On 11/18/2015 03:58 PM, Andy Lutomirski wrote:
> On Wed, Nov 18, 2015 at 12:50 PM, Brian Gerst <brgerst@gmail.com> wrote:
>>
>> Can you just add !xen_pv_domain() to the opportunistic SYSRET check
>> instead?  Bury the alternatives in that macro, ie.
>> static_cpu_has(X86_FEATURE_XENPV).  That would likely benefit other
>> code as well.
> We could, but that won't help the 64-bit case where we want to keep
> the full asm path.

I don't think I understand what you mean here. Which full asm path?

-boris
