From: Thomas Garnier <thgarnie@chromium.org>
Subject: Re: [PATCH v7 11/12] x86/paravirt: Adapt assembly for PIE support
Date: Wed, 29 May 2019 08:48:32 -0700
Message-ID: <CAJcbSZF1xcMpLDrOLkh493+ciVUqrku9WkWdb5xxAqWuXMjGZw__15076.169480902$1559145240$gmane$org@mail.gmail.com>
References: <20190520231948.49693-1-thgarnie@chromium.org>
	<20190520231948.49693-12-thgarnie@chromium.org>
	<1b53b8eb-5dd3-fb57-d8db-06eedd0ce49f@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1b53b8eb-5dd3-fb57-d8db-06eedd0ce49f@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Kristen Carlson Accardi <kristen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, May 26, 2019 at 10:47 PM Juergen Gross <jgross@suse.com> wrote:
>
> On 21/05/2019 01:19, Thomas Garnier wrote:
> > From: Thomas Garnier <thgarnie@google.com>
> >
> > if PIE is enabled, switch the paravirt assembly constraints to be
> > compatible. The %c/i constrains generate smaller code so is kept by
> > default.
> >
> > Position Independent Executable (PIE) support will allow to extend the
> > KASLR randomization range below 0xffffffff80000000.
> >
> > Signed-off-by: Thomas Garnier <thgarnie@google.com>
>
> Acked-by: Juergen Gross <jgross@suse.com>

Thanks Juergen.

>
>
> Juergen
