From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 38/75] x86/sev-es: Add SEV-ES Feature Detection
Date: Wed, 3 Jun 2020 17:24:36 +0200
Message-ID: <20200603152436.GA17841@8bytes.org>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-39-joro@8bytes.org>
 <20200520083916.GB1457@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200520083916.GB1457@zn.tnic>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Dave Hansen <dave.hansen@linux.intel.com>, Mike Stunes <mstunes@vmware.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>, Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>, David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 20, 2020 at 10:39:16AM +0200, Borislav Petkov wrote:
> On Tue, Apr 28, 2020 at 05:16:48PM +0200, Joerg Roedel wrote:
> > +bool sev_es_active(void)
> > +{
> > +	return !!(sev_status & MSR_AMD64_SEV_ES_ENABLED);
> > +}
> > +EXPORT_SYMBOL_GPL(sev_es_active);
> 
> I don't see this being used in modules anywhere in the patchset. Or am I
> missing something?

It is used in several places, for example do do_nmi() to conditionally
re-open the NMI window in SEV-ES guests. But there are other uses too,
like int sev_es_efi_map_ghcbs() or in sev_es_init_vc_handling() to opt
out if not running as an SEV-ES guest.


	Joerg
