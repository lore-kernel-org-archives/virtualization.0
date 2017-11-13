From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH RFC v3 4/6] Documentation: Add three sysctls for smart
	idle poll
Date: Mon, 13 Nov 2017 16:08:42 +0100
Message-ID: <20171113150842.epdffyxhlu5nq37u__39480.5238269784$1510585738$gmane$org@gmail.com>
References: <1510570064-6178-1-git-send-email-quan.xu0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1510570064-6178-1-git-send-email-quan.xu0@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Quan Xu <quan.xu04@gmail.com>
Cc: Yang Zhang <yang.zhang.wz@gmail.com>, Quan Xu <quan.xu0@gmail.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


* Quan Xu <quan.xu04@gmail.com> wrote:

> From: Quan Xu <quan.xu0@gmail.com>
> 
> To reduce the cost of poll, we introduce three sysctl to control the
> poll time when running as a virtual machine with paravirt.
> 
> Signed-off-by: Yang Zhang <yang.zhang.wz@gmail.com>
> Signed-off-by: Quan Xu <quan.xu0@gmail.com>
> ---
>  Documentation/sysctl/kernel.txt |   35 +++++++++++++++++++++++++++++++++++
>  arch/x86/kernel/paravirt.c      |    4 ++++
>  include/linux/kernel.h          |    6 ++++++
>  kernel/sysctl.c                 |   34 ++++++++++++++++++++++++++++++++++
>  4 files changed, 79 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
> index 694968c..30c25fb 100644
> --- a/Documentation/sysctl/kernel.txt
> +++ b/Documentation/sysctl/kernel.txt
> @@ -714,6 +714,41 @@ kernel tries to allocate a number starting from this one.
>  
>  ==============================================================
>  
> +paravirt_poll_grow: (X86 only)
> +
> +Multiplied value to increase the poll time. This is expected to take
> +effect only when running as a virtual machine with CONFIG_PARAVIRT
> +enabled. This can't bring any benifit on bare mental even with
> +CONFIG_PARAVIRT enabled.
> +
> +By default this value is 2. Possible values to set are in range {2..16}.
> +
> +==============================================================
> +
> +paravirt_poll_shrink: (X86 only)
> +
> +Divided value to reduce the poll time. This is expected to take effect
> +only when running as a virtual machine with CONFIG_PARAVIRT enabled.
> +This can't bring any benifit on bare mental even with CONFIG_PARAVIRT
> +enabled.
> +
> +By default this value is 2. Possible values to set are in range {2..16}.
> +
> +==============================================================
> +
> +paravirt_poll_threshold_ns: (X86 only)
> +
> +Controls the maximum poll time before entering real idle path. This is
> +expected to take effect only when running as a virtual machine with
> +CONFIG_PARAVIRT enabled. This can't bring any benifit on bare mental
> +even with CONFIG_PARAVIRT enabled.
> +
> +By default, this value is 0 means not to poll. Possible values to set
> +are in range {0..500000}. Change the value to non-zero if running
> +latency-bound workloads in a virtual machine.

I absolutely hate it how this hybrid idle loop polling mechanism is not 
self-tuning!

Please make it all work fine by default, and automatically so, instead of adding 
three random parameters...

And if it cannot be done automatically then we should rather not do it at all. 
Maybe the next submitter of a similar feature can think of a better approach.

Thanks,

	Ingo
