From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] arch/x86/xen: remove depends on CONFIG_EXPERIMENTAL
Date: Sun, 24 Feb 2013 06:40:17 -0800
Message-ID: <20130224144017.GB1111@kroah.com>
References: <20130223072959.GA4894@www.outflux.net>
	<CAE8XmWoX_TyHMTnGCMn6j_qiK0hptCgyrnVYpDJkfTAQfUNQPA@mail.gmail.com>
	<CAGXu5jKkaTStWRDQLOb6HxM7sGyj+1ekxxkGK8hw6rWkHRrVsQ@mail.gmail.com>
	<CAE8XmWq+dA5Pvhyoxm2Nqbt0psLpPxUdR7i5MKFhxVxubY0QtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAE8XmWq+dA5Pvhyoxm2Nqbt0psLpPxUdR7i5MKFhxVxubY0QtQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dongsheng Song <dongsheng.song@gmail.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Kees Cook <keescook@chromium.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Mukesh Rathor <mukesh.rathor@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Feb 24, 2013 at 05:51:44PM +0800, Dongsheng Song wrote:
> On Sun, Feb 24, 2013 at 1:03 AM, Kees Cook <keescook@chromium.org> wrote:
> > On Sat, Feb 23, 2013 at 3:59 AM, Dongsheng Song
> > <dongsheng.song@gmail.com> wrote:
> >> On Sat, Feb 23, 2013 at 3:29 PM, Kees Cook <keescook@chromium.org> wrote:
> >>>
> >>> The CONFIG_EXPERIMENTAL config item has not carried much meaning for a
> >>> while now and is almost always enabled by default. As agreed during the
> >>> Linux kernel summit, remove it from any "depends on" lines in Kconfigs.
> >>>
> >>> Signed-off-by: Kees Cook <keescook@chromium.org>
> >>> Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> >>> Cc: Mukesh Rathor <mukesh.rathor@oracle.com>
> >>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> >>> ---
> >>>  arch/x86/xen/Kconfig |    2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
> >>> index 93ff4e1..8cada4c 100644
> >>> --- a/arch/x86/xen/Kconfig
> >>> +++ b/arch/x86/xen/Kconfig
> >>> @@ -53,7 +53,7 @@ config XEN_DEBUG_FS
> >>>
> >>>  config XEN_X86_PVH
> >>>         bool "Support for running as a PVH guest (EXPERIMENTAL)"
> >>
> >> Why not remove this 'EXPERIMENTAL' too ?
> >
> > It was unclear to me if the feature was actually considered unstable.
> > I can resend with the text removed from the title too, if that's the
> > correct action here?
> >
> > -Kees
> >
> 
> If such a feature was considered unstable, it should depends on EXPERIMENTAL.

CONFIG_EXPERIMENTAL is going away.

> We should not surprised users.

You should not have unstable options in the kernel in the first place,
sorry.

greg k-h
