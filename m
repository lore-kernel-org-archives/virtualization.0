From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [Xen-devel] [PATCH v4 4/6] xen: add xen_pin_vcpu() to support
	calling functions on a dedicated pcpu
Date: Tue, 5 Apr 2016 10:45:11 +0100
Message-ID: <57038927.1030205@citrix.com>
References: <1459833007-11618-1-git-send-email-jgross@suse.com>
	<1459833007-11618-5-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1459833007-11618-5-git-send-email-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: jeremy@goop.org, jdelvare@suse.com, peterz@infradead.org, x86@kernel.org, pali.rohar@gmail.com, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, david.vrabel@citrix.com, Douglas_Warzecha@dell.com, hpa@zytor.com, akataria@vmware.com, boris.ostrovsky@oracle.com, linux@roeck-us.net
List-Id: virtualization@lists.linuxfoundation.org

On 05/04/16 06:10, Juergen Gross wrote:
> Some hardware models (e.g. Dell Studio 1555 laptops) require calls to
> the firmware to be issued on cpu 0 only. As Dom0 might have to use
> these calls, add xen_pin_vcpu() to achieve this functionality.
> 
> In case either the domain doesn't have the privilege to make the
> related hypercall or the hypervisor isn't supporting it, issue a
> warning once and disable further pinning attempts.
[...]
> --- a/arch/x86/xen/enlighten.c
> +++ b/arch/x86/xen/enlighten.c
> @@ -1885,6 +1885,45 @@ static void xen_set_cpu_features(struct cpuinfo_x86 *c)
>  	}
>  }
>  
> +static void xen_pin_vcpu(int cpu)
> +{
> +	static bool disable_pinning;
> +	struct sched_pin_override pin_override;
> +	int ret;
> +
> +	if (disable_pinning)
> +		return;
> +
> +	pin_override.pcpu = cpu;
> +	ret = HYPERVISOR_sched_op(SCHEDOP_pin_override, &pin_override);

	/* Ignore errors when removing override. */
> +	if (cpu < 0)
> +		return;
> +
> +	switch (ret) {
> +	case -ENOSYS:
> +		pr_warn("The kernel tried to call a function on physical cpu %d, but Xen isn't\n"
> +			"supporting this. In case of problems you might consider vcpu pinning.\n",
> +			cpu);
> +		disable_pinning = true;
> +		break;
> +	case -EPERM:
> +		WARN(1, "Trying to pin vcpu without having privilege to do so\n");
> +		disable_pinning = true;
> +		break;
> +	case -EINVAL:
> +	case -EBUSY:
> +		pr_warn("The kernel tried to call a function on physical cpu %d, but this cpu\n"
> +			"seems not to be available. Please check your Xen cpu configuration.\n",
> +			cpu);
> +		break;
> +	case 0:
> +		break;
> +	default:
> +		WARN(1, "rc %d while trying to pin vcpu\n", ret);
> +		disable_pinning = true;
> +	}

These messages are a bit wordy for my taste and since they don't say
what function failed or what driver is affected they're not as useful as
they could be.  I'd probably turn these all into:

	if (cpu >= 0 && ret < 0) {
		pr_warn("Failed to pin VCPU %d to physical CPU %d: %d",
		        smp_processor_id(), cpu, ret);
		disable_pinning = true;
	}

And look at getting the user of this API to print a more useful error.

"i8k: unable to call SMM BIOS on physical CPU %d: %d"

Or whatever.

David
