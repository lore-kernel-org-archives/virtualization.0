From: Stephen Hemminger via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH 2/2] x86/vdso: Add VCLOCK_HVCLOCK vDSO clock read method
Date: Fri, 10 Feb 2017 16:31:21 +0000
Message-ID: <BLUPR0301MB2098E1283D42BD2C3772D839CC440__37248.9853100435$1486744293$gmane$org@BLUPR0301MB2098.namprd03.prod.outlook.com>
References: <20170209141052.18694-1-vkuznets@redhat.com>
	<20170209141052.18694-3-vkuznets@redhat.com>
	<alpine.DEB.2.20.1702091806400.3604@nanos>
	<BLUPR0301MB20986D17696C3E658D511FACCC450@BLUPR0301MB2098.namprd03.prod.outlook.com>
	<87d1eqqlkv.fsf@vitty.brq.redhat.com>
	<alpine.DEB.2.20.1702101326520.4036@nanos>
Reply-To: Stephen Hemminger <sthemmin@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.20.1702101326520.4036@nanos>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>, Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Since sequence count algorithm is done by hypervisor, better to not reuse seqcount.
Still concerned that the code is racy.

-----Original Message-----
From: Thomas Gleixner [mailto:tglx@linutronix.de] 
Sent: Friday, February 10, 2017 4:28 AM
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>; x86@kernel.org; Andy Lutomirski <luto@amacapital.net>; Ingo Molnar <mingo@redhat.com>; H. Peter Anvin <hpa@zytor.com>; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Dexuan Cui <decui@microsoft.com>; linux-kernel@vger.kernel.org; devel@linuxdriverproject.org; virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 2/2] x86/vdso: Add VCLOCK_HVCLOCK vDSO clock read method

On Fri, 10 Feb 2017, Vitaly Kuznetsov wrote:

> Stephen Hemminger <sthemmin@microsoft.com> writes:
> 
> > Why not use existing seqlock's?
> >
> 
> To be honest I don't quite understand how we could use it -- the 
> sequence locking here is done against the page updated by the 
> hypersior, we're not creating new structures (so I don't understand 
> how we could use struct seqcount which we don't have) but I may be 
> misunderstanding something.

You can't use seqlock, but you might be able to use seqcount. Though I doubt it given the 0 check ....

Thanks,

	tglx
