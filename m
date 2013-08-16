From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] xen: initialize xen panic handler for PVHVM
Date: Fri, 16 Aug 2013 08:43:28 -0400
Message-ID: <20130816124327.GC10190@konrad-lan.dumpdata.com>
References: <1376640656-32381-1-git-send-email-vaughan.cao@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1376640656-32381-1-git-send-email-vaughan.cao@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vaughan Cao <vaughan.cao@oracle.com>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 16, 2013 at 04:10:56PM +0800, Vaughan Cao wrote:
> kernel use callback linked in panic_notifier_list to notice others when panic
> happens.
> NORET_TYPE void panic(const char * fmt, ...){
>     ...
>     atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> }
> When xen aware this, it will call xen_reboot(SHUTDOWN_crash) to send out an
  ^^^^^^^^^^^^^^^^^^^-> "When Xen becomes aware of this"

> event with reason code - SHUTDOWN_crash.
> xen_panic_handler_init() is defined to register on panic_notifier_list but
> we only call it in xen_arch_setup which only be called by pvm, this patch is
                                          ^^^^^^^-> "is only"
>  necessary for pvhvm.

Could you tell me what has been happening without this patch?

Thank you.

> 
> Signed-off-by: Vaughan Cao <vaughan.cao@oracle.com>
> ---
>  arch/x86/xen/enlighten.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> index 4aec5ed..53e5726 100644
> --- a/arch/x86/xen/enlighten.c
> +++ b/arch/x86/xen/enlighten.c
> @@ -1713,6 +1713,8 @@ static void __init xen_hvm_guest_init(void)
>  
>  	xen_hvm_init_shared_info();
>  
> +	xen_panic_handler_init();
> +
>  	if (xen_feature(XENFEAT_hvm_callback_vector))
>  		xen_have_vector_callback = 1;
>  	xen_hvm_smp_init();
> -- 
> 1.7.11.7
> 
