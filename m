From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 9/10] provide __parainstructions section
Date: Fri, 18 Jan 2008 21:41:25 +0100
Message-ID: <20080118204125.GA20904__11149.6342499324$1200689011$gmane$org@uranus.ravnborg.org>
References: <12006768251548-git-send-email-gcosta@redhat.com>
	<12006768362108-git-send-email-gcosta@redhat.com>
	<1200676842822-git-send-email-gcosta@redhat.com>
	<12006768473571-git-send-email-gcosta@redhat.com>
	<12006768521391-git-send-email-gcosta@redhat.com>
	<1200676857691-git-send-email-gcosta@redhat.com>
	<12006768631010-git-send-email-gcosta@redhat.com>
	<12006768683247-git-send-email-gcosta@redhat.com>
	<12006768732175-git-send-email-gcosta@redhat.com>
	<12006768793416-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <12006768793416-git-send-email-gcosta@redhat.com>
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
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, mingo@elte.hu, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 18, 2008 at 03:20:24PM -0200, Glauber de Oliveira Costa wrote:
> This patch adds the __parainstructions section to vmlinux.lds.S.
> It's needed for the patching system.
> 
> Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
> ---
>  arch/x86/kernel/vmlinux_64.lds.S |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/x86/kernel/vmlinux_64.lds.S b/arch/x86/kernel/vmlinux_64.lds.S
> index 5ae8aa8..5e0300f 100644
> --- a/arch/x86/kernel/vmlinux_64.lds.S
> +++ b/arch/x86/kernel/vmlinux_64.lds.S
> @@ -175,6 +175,14 @@ SECTIONS
>    }
>    __con_initcall_end = .;
>    SECURITY_INIT
> +
> +  . = ALIGN(8);
> +  .parainstructions : AT(ADDR(.parainstructions) - LOAD_OFFSET) {
> +  __parainstructions = .;
> +       *(.parainstructions)
> +  __parainstructions_end = .;
> +  }
> +

Are we going to see this for other archs than just x86?
If so then please add this to include/asm-generic/vmlinux.lds.h

The altinstructions right below is antoehr candidate..

	Sam
