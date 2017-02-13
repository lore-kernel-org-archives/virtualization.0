From: Dexuan Cui via Virtualization <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH 2/2] x86/vdso: Add VCLOCK_HVCLOCK vDSO clock read method
Date: Mon, 13 Feb 2017 07:49:26 +0000
Message-ID: <MWHPR03MB266952220A7E1FA0F2D38453BF590@MWHPR03MB2669.namprd03.prod.outlook.com>
References: <20170209141052.18694-1-vkuznets@redhat.com>
	<20170209141052.18694-3-vkuznets@redhat.com>
	<alpine.DEB.2.20.1702091806400.3604@nanos>
	<BLUPR0301MB20986D17696C3E658D511FACCC450@BLUPR0301MB2098.namprd03.prod.outlook.com>
	<87d1eqqlkv.fsf@vitty.brq.redhat.com>
	<alpine.DEB.2.20.1702101326520.4036@nanos>
	<BLUPR0301MB2098E1283D42BD2C3772D839CC440@BLUPR0301MB2098.namprd03.prod.outlook.com>
	<alpine.DEB.2.20.1702101852000.4036@nanos>
Reply-To: Dexuan Cui <decui@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.20.1702101852000.4036@nanos>
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
To: Thomas Gleixner <tglx@linutronix.de>, Stephen Hemminger <sthemmin@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H.
	Peter Anvin" <hpa@zytor.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> From: Thomas Gleixner [mailto:tglx@linutronix.de]
> Sent: Saturday, February 11, 2017 02:02
>  ...
> That's important if the stuff happens cross CPU. If the update happens on
> the same CPU then this is a different story and as there are VMexits
> involved they might provide the required ordering already. But I can't tell
> as I have no idea how that host side thing is done.
> 
> 	tglx

IMO Hyper-V TSC page clocksource here seems pretty similar to KVM's pvclock,
So I would guess "the structure is only updated just before reentering the guest
after some VM event" (https://rwmj.wordpress.com/2010/10/15/kvm-pvclock/),
that is, the update should happen on the same CPU, I guess.

Thanks,
-- Dexuan
