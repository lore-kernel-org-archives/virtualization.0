From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] x86/vdso: Add VCLOCK_HVCLOCK vDSO clock read
 method
Date: Fri, 10 Feb 2017 13:28:25 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1702101326520.4036@nanos>
References: <20170209141052.18694-1-vkuznets@redhat.com>
	<20170209141052.18694-3-vkuznets@redhat.com>
	<alpine.DEB.2.20.1702091806400.3604@nanos>
	<BLUPR0301MB20986D17696C3E658D511FACCC450@BLUPR0301MB2098.namprd03.prod.outlook.com>
	<87d1eqqlkv.fsf@vitty.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87d1eqqlkv.fsf@vitty.brq.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 10 Feb 2017, Vitaly Kuznetsov wrote:

> Stephen Hemminger <sthemmin@microsoft.com> writes:
> 
> > Why not use existing seqlock's?
> >
> 
> To be honest I don't quite understand how we could use it -- the
> sequence locking here is done against the page updated by the
> hypersior, we're not creating new structures (so I don't understand how
> we could use struct seqcount which we don't have) but I may be
> misunderstanding something.

You can't use seqlock, but you might be able to use seqcount. Though I
doubt it given the 0 check ....

Thanks,

	tglx
