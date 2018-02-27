From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/6] pci: Scan all functions when probing while running
	over Jailhouse
Date: Tue, 27 Feb 2018 17:48:35 +0200
Message-ID: <CAHp75Vc+DpKPwm7us+1kDYU3e5UMF25MjmqLBfghdih8_FSWtw__49382.6223690577$1519746430$gmane$org@mail.gmail.com>
References: <cover.1516601570.git.jan.kiszka@siemens.com>
	<66bfcfc6dc1832baa3fbd8e4879764d36aa9c1e7.1516601570.git.jan.kiszka@siemens.com>
	<CAHp75VcssoPE8ZCiHOt8-BKcponpr3xpzn42KZGx=Y+nMmZjYw@mail.gmail.com>
	<17710852-a221-c707-0438-44031666028e@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <17710852-a221-c707-0438-44031666028e@siemens.com>
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
Cc: jailhouse-dev@googlegroups.com, Benedikt Spranger <b.spranger@linutronix.de>, linux-pci@vger.kernel.org, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 27, 2018 at 9:22 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2018-02-23 14:23, Andy Shevchenko wrote:
>> On Mon, Jan 22, 2018 at 8:12 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

>>>  #include <linux/acpi.h>
>>>  #include <linux/irqdomain.h>
>>>  #include <linux/pm_runtime.h>
>>> +#include <linux/hypervisor.h>
>>
>> Ditto.
>>
>
> Despite the context suggesting it, this file has no ordering.

At least you might not increase disordering by putting the line after acpi.h.

-- 
With Best Regards,
Andy Shevchenko
