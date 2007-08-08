From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 23/25] [PATCH] paravirt hooks for arch initialization
Date: Wed, 8 Aug 2007 11:44:02 +0200
Message-ID: <200708081144.04119.ak__23320.7511868843$1186567559$gmane$org@suse.de>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<11865468394005-git-send-email-gcosta@redhat.com>
	<11865468431616-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11865468431616-git-send-email-gcosta@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org


> -static void discover_ebda(void)
> +void native_ebda_info(unsigned *addr, unsigned *size)

I guess it would be better to use the resources frame work here. 
Before checking EBDA check if it is already reserved. Then lguest/Xen
can reserve these areas and stop using it.


> +/* Overridden in paravirt.c if CONFIG_PARAVIRT */
> +void __attribute__((weak)) memory_setup(void)
> +{
> +       return setup_memory_region();
> +}
> +
> +
>  void __init setup_arch(char **cmdline_p)
>  {
>  	printk(KERN_INFO "Command line: %s\n", boot_command_line);
> @@ -231,12 +255,19 @@ void __init setup_arch(char **cmdline_p)
>  	saved_video_mode = SAVED_VIDEO_MODE;
>  	bootloader_type = LOADER_TYPE;
>
> +	/*
> +	 * By returning non-zero here, a paravirt impl can choose to
> +	 * skip the rest of the setup process
> +	 */
> +	if (paravirt_arch_setup())
> +		return;

Sorry, but that's an extremly ugly and clumpsy interface and will lead
to extensive code duplication in hypervisors because so much code
is disabled.

This needs to be solved in some better way.


-Andi
