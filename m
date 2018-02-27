From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 2/6] pci: Scan all functions when probing while running
	over Jailhouse
Date: Tue, 27 Feb 2018 08:22:21 +0100
Message-ID: <17710852-a221-c707-0438-44031666028e__2355.81143429062$1519716067$gmane$org@siemens.com>
References: <cover.1516601570.git.jan.kiszka@siemens.com>
	<66bfcfc6dc1832baa3fbd8e4879764d36aa9c1e7.1516601570.git.jan.kiszka@siemens.com>
	<CAHp75VcssoPE8ZCiHOt8-BKcponpr3xpzn42KZGx=Y+nMmZjYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAHp75VcssoPE8ZCiHOt8-BKcponpr3xpzn42KZGx=Y+nMmZjYw@mail.gmail.com>
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
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jailhouse-dev@googlegroups.com, Benedikt Spranger <b.spranger@linutronix.de>, linux-pci@vger.kernel.org, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On 2018-02-23 14:23, Andy Shevchenko wrote:
> On Mon, Jan 22, 2018 at 8:12 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> 
>>  #include <linux/export.h>
>>  #include <linux/pci.h>
>>  #include <asm/pci_x86.h>
>> +#include <asm/jailhouse_para.h>
> 
> Keep it in order?
> 

Done.

> 
>>  #include <linux/acpi.h>
>>  #include <linux/irqdomain.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/hypervisor.h>
> 
> Ditto.
> 

Despite the context suggesting it, this file has no ordering.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
