From: "Mohammed Gamal" <m.gamal005@gmail.com>
Subject: Re: [PATCH] Do not calculate linear rip in emulation failure report
Date: Fri, 13 Jun 2008 20:33:24 +0300
Message-ID: <52d4a3890806131033g56ec2bc0o43442d2c290401f2__49809.0498535477$1213378573$gmane$org@mail.gmail.com>
References: <1213105613-8571-1-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1213105613-8571-1-git-send-email-gcosta@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber Costa <gcosta@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 10, 2008 at 4:46 PM, Glauber Costa <gcosta@redhat.com> wrote:
> If we're not gonna do anything (case in which failure is already
> reported), we do not need to even bother with calculating the linear rip.
>
> This is a nitpick, but I saw it while doing some testing, so here's
> the patch.
>
> Signed-off-by: Glauber Costa <gcosta@redhat.com>
> ---
>  arch/x86/kvm/x86.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 77fb2bd..191fef1 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2026,11 +2026,11 @@ void kvm_report_emulation_failure(struct kvm_vcpu *vcpu, const char *context)
>        unsigned long rip = vcpu->arch.rip;
>        unsigned long rip_linear;
>
> -       rip_linear = rip + get_segment_base(vcpu, VCPU_SREG_CS);
> -
>        if (reported)
>                return;
>
> +       rip_linear = rip + get_segment_base(vcpu, VCPU_SREG_CS);
> +
>        emulator_read_std(rip_linear, (void *)opcodes, 4, vcpu);
>
>        printk(KERN_ERR "emulation failed (%s) rip %lx %02x %02x %02x %02x\n",
> --
> 1.5.4.5

Why return immediately? Shouldn't we report on failure whenever it
occurs (i.e. by rather removing the if condition)?
