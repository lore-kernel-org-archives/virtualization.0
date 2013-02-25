From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: Re: [PATCH] arch/x86/xen: remove depends on CONFIG_EXPERIMENTAL
Date: Mon, 25 Feb 2013 12:39:27 +0000
Message-ID: <alpine.DEB.2.02.1302251157210.5360@kaball.uk.xensource.com>
References: <20130223072959.GA4894@www.outflux.net>
	<CAE8XmWoX_TyHMTnGCMn6j_qiK0hptCgyrnVYpDJkfTAQfUNQPA@mail.gmail.com>
	<CAGXu5jKkaTStWRDQLOb6HxM7sGyj+1ekxxkGK8hw6rWkHRrVsQ@mail.gmail.com>
	<CAE8XmWq+dA5Pvhyoxm2Nqbt0psLpPxUdR7i5MKFhxVxubY0QtQ@mail.gmail.com>
	<20130224144017.GB1111@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130224144017.GB1111@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Dongsheng Song <dongsheng.song@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Mukesh Rathor <mukesh.rathor@oracle.com>, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>, Kees Cook <keescook@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 24 Feb 2013, Greg Kroah-Hartman wrote:
> On Sun, Feb 24, 2013 at 05:51:44PM +0800, Dongsheng Song wrote:
> > On Sun, Feb 24, 2013 at 1:03 AM, Kees Cook <keescook@chromium.org> wrote:
> > > On Sat, Feb 23, 2013 at 3:59 AM, Dongsheng Song
> > > <dongsheng.song@gmail.com> wrote:
> > >> On Sat, Feb 23, 2013 at 3:29 PM, Kees Cook <keescook@chromium.org> wrote:
> > >>>
> > >>> The CONFIG_EXPERIMENTAL config item has not carried much meaning for a
> > >>> while now and is almost always enabled by default. As agreed during the
> > >>> Linux kernel summit, remove it from any "depends on" lines in Kconfigs.
> > >>>
> > >>> Signed-off-by: Kees Cook <keescook@chromium.org>
> > >>> Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > >>> Cc: Mukesh Rathor <mukesh.rathor@oracle.com>
> > >>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > >>> ---
> > >>>  arch/x86/xen/Kconfig |    2 +-
> > >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
> > >>> index 93ff4e1..8cada4c 100644
> > >>> --- a/arch/x86/xen/Kconfig
> > >>> +++ b/arch/x86/xen/Kconfig
> > >>> @@ -53,7 +53,7 @@ config XEN_DEBUG_FS
> > >>>
> > >>>  config XEN_X86_PVH
> > >>>         bool "Support for running as a PVH guest (EXPERIMENTAL)"
> > >>
> > >> Why not remove this 'EXPERIMENTAL' too ?
> > >
> > > It was unclear to me if the feature was actually considered unstable.
> > > I can resend with the text removed from the title too, if that's the
> > > correct action here?
> > >
> > > -Kees
> > >
> > 
> > If such a feature was considered unstable, it should depends on EXPERIMENTAL.
> 
> CONFIG_EXPERIMENTAL is going away.
> 
> > We should not surprised users.
> 
> You should not have unstable options in the kernel in the first place,
> sorry.
 
With the premise that the removal of CONFIG_EXPERIMENTAL is not an issue
for me personally or my work, I am going to give you my 2 cents on the
matter, but feel free to ignore them :)

While I understand that CONFIG_EXPERIMENTAL has been abused, I feel that
rejecting everything that is not fully stable and with external
interfaces set in stones, might hinder the development of new features.

After all, given how fast the kernel is moving nowadays, maintaining a
project out-of-tree until is completely ready for production can be
very expensive. Merging the project earlier and completing the
development upstream can bring better results. But in these cases one
wouldn't want to "market" the feature as stable yet, because it just
isn't. If CONFIG_EXPERIMENTAL is going away, is there anything in the
kernel that can be used to tag a feature as "I wouldn't use it in
production if I were you"? Maybe just a comment in the kconfig
description?
