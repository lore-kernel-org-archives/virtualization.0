From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] arch/x86/xen: remove depends on CONFIG_EXPERIMENTAL
Date: Sat, 23 Feb 2013 14:11:05 -0500
Message-ID: <20130223191104.GA12606@konrad-lan.dumpdata.com>
References: <20130223072959.GA4894@www.outflux.net>
	<CAE8XmWoX_TyHMTnGCMn6j_qiK0hptCgyrnVYpDJkfTAQfUNQPA@mail.gmail.com>
	<CAGXu5jKkaTStWRDQLOb6HxM7sGyj+1ekxxkGK8hw6rWkHRrVsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAGXu5jKkaTStWRDQLOb6HxM7sGyj+1ekxxkGK8hw6rWkHRrVsQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Kees Cook <keescook@chromium.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Dongsheng Song <dongsheng.song@gmail.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Mukesh Rathor <mukesh.rathor@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Feb 23, 2013 at 09:03:20AM -0800, Kees Cook wrote:
> On Sat, Feb 23, 2013 at 3:59 AM, Dongsheng Song
> <dongsheng.song@gmail.com> wrote:
> > On Sat, Feb 23, 2013 at 3:29 PM, Kees Cook <keescook@chromium.org> wrote:
> >>
> >> The CONFIG_EXPERIMENTAL config item has not carried much meaning for a
> >> while now and is almost always enabled by default. As agreed during the
> >> Linux kernel summit, remove it from any "depends on" lines in Kconfigs.
> >>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >> Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> >> Cc: Mukesh Rathor <mukesh.rathor@oracle.com>
> >> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> >> ---
> >>  arch/x86/xen/Kconfig |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
> >> index 93ff4e1..8cada4c 100644
> >> --- a/arch/x86/xen/Kconfig
> >> +++ b/arch/x86/xen/Kconfig
> >> @@ -53,7 +53,7 @@ config XEN_DEBUG_FS
> >>
> >>  config XEN_X86_PVH
> >>         bool "Support for running as a PVH guest (EXPERIMENTAL)"
> >
> > Why not remove this 'EXPERIMENTAL' too ?
> 
> It was unclear to me if the feature was actually considered unstable.
> I can resend with the text removed from the title too, if that's the
> correct action here?

It certainly is unstable right now (which is why it was unstaged from
the v3.9 train). I hope that by v3.10 it won't be - at which
point this patch (and the EXPERIMENTAL) makes sense.

So could you respin it please with the text removed as well - and I will
queue it up in the branch that carries the PVH feature?

Thanks!
> 
> -Kees
> 
> >
> >> -       depends on X86_64 && XEN && EXPERIMENTAL
> >> +       depends on X86_64 && XEN
> >>         default n
> >>         help
> >>            This option enables support for running as a PVH guest (PV guest
> >> --
> >> 1.7.9.5
> >>
> >>
> >> --
> >> Kees Cook
> >> Chrome OS Security
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
> -- 
> Kees Cook
> Chrome OS Security
