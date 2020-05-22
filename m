From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 43/75] x86/sev-es: Setup per-cpu GHCBs for the runtime
 handler
Date: Fri, 22 May 2020 10:33:21 +0200
Message-ID: <20200522083321.GA28750@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-44-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200428151725.31091-44-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Dave Hansen <dave.hansen@linux.intel.com>, Mike Stunes <mstunes@vmware.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>, Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>, David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 05:16:53PM +0200, Joerg Roedel wrote:
> @@ -198,6 +210,48 @@ static bool __init sev_es_setup_ghcb(void)
>  	return true;
>  }
>  
> +static void __init sev_es_alloc_runtime_data(int cpu)
> +{
> +	struct sev_es_runtime_data *data;
> +
> +	data = memblock_alloc(sizeof(*data), PAGE_SIZE);
> +	if (!data)
> +		panic("Can't allocate SEV-ES runtime data");
> +
> +	per_cpu(runtime_data, cpu) = data;
> +}
> +
> +static void __init sev_es_init_ghcb(int cpu)

Since those are static functions, I'd drop the "sev_es_" prefix from the
name for better readability. Because otherwise the whole file is a sea
of "sev_es_"-prefixed identifiers which you need to read until the end
to know what they are.

> +{
> +	struct sev_es_runtime_data *data;
> +	int err;
> +
> +	data = per_cpu(runtime_data, cpu);
> +
> +	err = early_set_memory_decrypted((unsigned long)&data->ghcb_page,
> +					 sizeof(data->ghcb_page));
> +	if (err)
> +		panic("Can not map GHCBs unencrypted");

			"Error mapping ..."

> +
> +	memset(&data->ghcb_page, 0, sizeof(data->ghcb_page));
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
