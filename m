From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 0/3] Fix and cleanup for 32-bit PV sysexit
Date: Thu, 19 Nov 2015 14:07:02 -0800
Message-ID: <CALCETrUeGoeB8vNgbRNkFXjH0A570=M+4L1sRsfh-7btym59nA@mail.gmail.com>
References: <1447970147-1733-1-git-send-email-boris.ostrovsky@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1447970147-1733-1-git-send-email-boris.ostrovsky@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, Andrew Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 19, 2015 at 1:55 PM, Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
> The first patch fixes Xen PV regression introduced by 32-bit rewrite. Unlike the
> earlier version it uses ALTERNATIVE instruction and avoids using xen_sysexit
> (and sysret32 in compat mode) pv ops, as suggested by Andy.
>
> As result of this patch irq_enable_sysexit and usergs_sysret32 pv ops are not
> used anymore by anyone and so can be removed.

This whole series is:

Acked-by: Andy Lutomirski <luto@kernel.org>

Now I just have to sucker someone into getting rid of
PARAVIRT_ADJUST_EXCEPTION_FRAME (by using stub entries) and the
overcomplicated syscall entry stuff.  :)  And whoever gets rid of
PARAVIRT_ADJUST_EXCEPTION_FRAME gets to wonder why it doesn't crash
and burn for NMIs on Xen, since I'm reasonably confident that it can't
possibly be correct.

--Andy
