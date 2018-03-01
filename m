From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3 1/6] jailhouse: Provide detection for non-x86 systems
Date: Thu, 1 Mar 2018 07:17:57 +0100
Message-ID: <18fdcca5-1afb-23ea-07f6-b24eabdc04a0__12929.2521546178$1519885404$gmane$org@suse.com>
References: <cover.1519882849.git.jan.kiszka@siemens.com>
	<558f5cbae432ae029e2d8ee9b0ef44d837318625.1519882849.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <558f5cbae432ae029e2d8ee9b0ef44d837318625.1519882849.git.jan.kiszka@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: jailhouse-dev@googlegroups.com, Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 01/03/18 06:40, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Implement jailhouse_paravirt() via device tree probing on architectures
> != x86. Will be used by the PCI core.
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  Documentation/devicetree/bindings/jailhouse.txt |  8 ++++++++
>  arch/x86/include/asm/jailhouse_para.h           |  2 +-
>  include/linux/hypervisor.h                      | 17 +++++++++++++++--

I'd appreciate if you'd Cc: the maintainers of the touched files...

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
