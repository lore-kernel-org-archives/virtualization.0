From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 4/6] x86: Consolidate PCI_MMCONFIG configs
Date: Sun, 28 Jan 2018 19:26:44 +0200
Message-ID: <CAHp75Vd3AsdOayA0FSaug6L4K+Xx5pk=Eeh4F5mZQsKiV3RxwA__46434.6987697811$1517160326$gmane$org@mail.gmail.com>
References: <cover.1516601570.git.jan.kiszka@siemens.com>
	<5dcaec50bb59140c1cb63c35ce566ccc02188bcb.1516601570.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5dcaec50bb59140c1cb63c35ce566ccc02188bcb.1516601570.git.jan.kiszka@siemens.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 22, 2018 at 8:12 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Not sure if those two worked by design or just by chance so far. In any
> case, it's at least cleaner and clearer to express this in a single
> config statement.

Congrats! You found by the way a bug in

commit e279b6c1d329e50b766bce96aacc197eae8a053b
Author: Sam Ravnborg <sam@ravnborg.org>
Date:   Tue Nov 6 20:41:05 2007 +0100

   x86: start unification of arch/x86/Kconfig.*

...and proper fix seems to split PCI stuff to common + X86_32 only + X86_64 only

-- 
With Best Regards,
Andy Shevchenko
