From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 3/6] x86/jailhouse: Enable PCI mmconfig access in
	inmates
Date: Thu, 1 Mar 2018 12:31:08 +0200
Message-ID: <CAHp75VeH5tBBY4D-1_VVaYiCdRyBG+2vA8ZGg_QBfVujawh=iA__33942.881334997$1519900152$gmane$org@mail.gmail.com>
References: <cover.1519882849.git.jan.kiszka@siemens.com>
	<188edc11aa5fa11d4915097831a2a4a153f6ed83.1519882849.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <188edc11aa5fa11d4915097831a2a4a153f6ed83.1519882849.git.jan.kiszka@siemens.com>
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

On Thu, Mar 1, 2018 at 7:40 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

> Use the PCI mmconfig base address exported by jailhouse in boot
> parameters in order to access the memory mapped PCI configuration space.


> --- a/arch/x86/kernel/jailhouse.c
> +++ b/arch/x86/kernel/jailhouse.c
> @@ -124,6 +124,13 @@ static int __init jailhouse_pci_arch_init(void)
>         if (pcibios_last_bus < 0)
>                 pcibios_last_bus = 0xff;
>
> +#ifdef CONFIG_PCI_MMCONFIG
> +       if (setup_data.pci_mmconfig_base) {

> +               pci_mmconfig_add(0, 0, 0xff, setup_data.pci_mmconfig_base);

Hmm... Shouldn't be pcibios_last_bus instead of 0xff?

> +               pci_mmcfg_arch_init();
> +       }
> +#endif

-- 
With Best Regards,
Andy Shevchenko
