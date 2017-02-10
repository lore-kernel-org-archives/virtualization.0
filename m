From: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH 2/2] x86/vdso: Add VCLOCK_HVCLOCK vDSO clock read
 method
Date: Fri, 10 Feb 2017 19:01:52 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1702101852000.4036@nanos>
References: <20170209141052.18694-1-vkuznets@redhat.com>
	<20170209141052.18694-3-vkuznets@redhat.com>
	<alpine.DEB.2.20.1702091806400.3604@nanos>
	<BLUPR0301MB20986D17696C3E658D511FACCC450@BLUPR0301MB2098.namprd03.prod.outlook.com>
	<87d1eqqlkv.fsf@vitty.brq.redhat.com>
	<alpine.DEB.2.20.1702101326520.4036@nanos>
	<BLUPR0301MB2098E1283D42BD2C3772D839CC440@BLUPR0301MB2098.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <BLUPR0301MB2098E1283D42BD2C3772D839CC440@BLUPR0301MB2098.namprd03.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 10 Feb 2017, Stephen Hemminger wrote:

> Since sequence count algorithm is done by hypervisor, better to not reuse seqcount.
> Still concerned that the code is racy.

That's a different question and can only be answered by the hypervisor
folks. Dunno, whether they have barrier requirements. The seqcount stuff
relies on:

do {
	seq = READ_ONCE(s->sequence);

	smp_rmb();

	sample_data();
  
	smp_rmb();
} while (s->sequence != seq);

which pairs with the writer side:

       s->sequence++;
       
       smp_wmb();

       update_data();

       smp_wmb();

       s->sequence++;

That's important if the stuff happens cross CPU. If the update happens on
the same CPU then this is a different story and as there are VMexits
involved they might provide the required ordering already. But I can't tell
as I have no idea how that host side thing is done.

Thanks,

	tglx
