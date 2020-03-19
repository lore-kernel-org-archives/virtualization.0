From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 42/70] x86/sev-es: Support nested #VC exceptions
Date: Thu, 19 Mar 2020 08:46:36 -0700
Message-ID: <CALCETrXiWjALMTcG=92DmMn_H=yR88e0-3cj8CjTAjtjTvBR8w@mail.gmail.com>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-43-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200319091407.1481-43-joro@8bytes.org>
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
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 19, 2020 at 2:14 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> Handle #VC exceptions that happen while the GHCB is in use. This can
> happen when an NMI happens in the #VC exception handler and the NMI
> handler causes a #VC exception itself. Save the contents of the GHCB
> when nesting is detected and restore it when the GHCB is no longer
> used.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/kernel/sev-es.c | 63 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
> index 97241d2f0f70..3b7bbc8d841e 100644
> --- a/arch/x86/kernel/sev-es.c
> +++ b/arch/x86/kernel/sev-es.c
> @@ -32,9 +32,57 @@ struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>   */
>  struct ghcb __initdata *boot_ghcb;
>
> +struct ghcb_state {
> +       struct ghcb *ghcb;
> +};
> +
>  /* Runtime GHCB pointers */
>  static struct ghcb __percpu *ghcb_page;
>
> +/*
> + * Mark the per-cpu GHCB as in-use to detect nested #VC exceptions.
> + * There is no need for it to be atomic, because nothing is written to the GHCB
> + * between the read and the write of ghcb_active. So it is safe to use it when a
> + * nested #VC exception happens before the write.
> + */
> +static DEFINE_PER_CPU(bool, ghcb_active);
> +
> +static struct ghcb *sev_es_get_ghcb(struct ghcb_state *state)
> +{
> +       struct ghcb *ghcb = (struct ghcb *)this_cpu_ptr(ghcb_page);
> +       bool *active = this_cpu_ptr(&ghcb_active);
> +
> +       if (unlikely(*active)) {
> +               /* GHCB is already in use - save its contents */
> +
> +               state->ghcb = kzalloc(sizeof(struct ghcb), GFP_ATOMIC);
> +               if (!state->ghcb)
> +                       return NULL;

This can't possibly end well.  Maybe have a little percpu list of
GHCBs and make sure there are enough for any possible nesting?

Also, I admit confusion.  Isn't the GHCB required to be unencrypted?
How does that work with kzalloc()?
