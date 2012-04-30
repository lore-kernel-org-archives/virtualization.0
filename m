From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCHv2] x86info: dump kvm cpuid's
Date: Mon, 30 Apr 2012 18:03:20 +0300
Message-ID: <20120430150320.GA16592@redhat.com>
References: <20120430143835.GA10190@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120430143835.GA10190@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xen-devel@lists.xensource.com, kvm@vger.kernel.org, pv-drivers@vmware.com, virtualization@lists.linux-foundation.org, devel@linuxdriverproject.org, davej@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 30, 2012 at 05:38:35PM +0300, Michael S. Tsirkin wrote:
> The following makes 'x86info -r' dump hypervisor leaf cpu ids
> (for kvm this is signature+features) when running in a vm.
> 
> On the guest we see the signature and the features:
> eax in: 0x40000000, eax = 00000000 ebx = 4b4d564b ecx = 564b4d56 edx = 0000004d
> eax in: 0x40000001, eax = 0100007b ebx = 00000000 ecx = 00000000 edx = 00000000
> 
> Hypervisor flag is checked to avoid output changes when not
> running on a VM.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
Looks good to me.

> Changes from v1:
> 	Make work on non KVM hypervisors (only KVM was tested).
> 	Avi Kivity said kvm will in the future report
> 	max HV leaf in eax. For now it reports eax = 0
>         so add a work around for that.
> 
> ---
> 
> diff --git a/identify.c b/identify.c
> index 33f35de..a4a3763 100644
> --- a/identify.c
> +++ b/identify.c
> @@ -9,8 +9,8 @@
>  
>  void get_cpu_info_basics(struct cpudata *cpu)
>  {
> -	unsigned int maxi, maxei, vendor, address_bits;
> -	unsigned int eax;
> +	unsigned int maxi, maxei, maxhv, vendor, address_bits;
> +	unsigned int eax, ebx, ecx;
>  
>  	cpuid(cpu->number, 0, &maxi, &vendor, NULL, NULL);
>  	maxi &= 0xffff;		/* The high-order word is non-zero on some Cyrix CPUs */
> @@ -19,7 +19,7 @@ void get_cpu_info_basics(struct cpudata *cpu)
>  		return;
>  
>  	/* Everything that supports cpuid supports these. */
> -	cpuid(cpu->number, 1, &eax, NULL, NULL, NULL);
> +	cpuid(cpu->number, 1, &eax, &ebx, &ecx, NULL);
>  	cpu->stepping = eax & 0xf;
>  	cpu->model = (eax >> 4) & 0xf;
>  	cpu->family = (eax >> 8) & 0xf;
> @@ -29,6 +29,19 @@ void get_cpu_info_basics(struct cpudata *cpu)
>  
>  	cpuid(cpu->number, 0xC0000000, &maxei, NULL, NULL, NULL);
>  	cpu->maxei2 = maxei;
> +	if (ecx & 0x80000000) {
> +		cpuid(cpu->number, 0x40000000, &maxhv, NULL, NULL, NULL);
> +		/*
> +		 * KVM up to linux 3.4 reports 0 as the max hypervisor leaf,
> +		 * where it really means 0x40000001.
> +		 * Most (all?) hypervisors have at least one CPUID besides
> +		 * the vendor ID so assume that.
> +		 */
> +		cpu->maxhv = maxhv ? maxhv : 0x40000001;
> +	} else {
> +		/* Suppress hypervisor cpuid unless running on a hypervisor */
> +		cpu->maxhv = 0;
> +	}
>  
>  	cpuid(cpu->number, 0x80000008,&address_bits, NULL, NULL, NULL);
>  	cpu->phyaddr_bits = address_bits & 0xFF;
> diff --git a/x86info.c b/x86info.c
> index 22c4734..80cae36 100644
> --- a/x86info.c
> +++ b/x86info.c
> @@ -44,6 +44,10 @@ static void display_detailed_info(struct cpudata *cpu)
>  
>  		if (cpu->maxei2 >=0xC0000000)
>  			dump_raw_cpuid(cpu->number, 0xC0000000, cpu->maxei2);
> +
> +		if (cpu->maxhv >= 0x40000000)
> +			dump_raw_cpuid(cpu->number, 0x40000000, cpu->maxhv);
> +
>  	}
>  
>  	if (show_cacheinfo) {
> diff --git a/x86info.h b/x86info.h
> index 7d2a455..c4f5d81 100644
> --- a/x86info.h
> +++ b/x86info.h
> @@ -84,7 +84,7 @@ struct cpudata {
>  	unsigned int cachesize_trace;
>  	unsigned int phyaddr_bits;
>  	unsigned int viraddr_bits;
> -	unsigned int cpuid_level, maxei, maxei2;
> +	unsigned int cpuid_level, maxei, maxei2, maxhv;
>  	char name[CPU_NAME_LEN];
>  	enum connector connector;
>  	unsigned int flags_ecx;

--
			Gleb.
