From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFT 02/13] alpha: Constify ioreadX() iomem argument (as in
 generic implementation)
Date: Wed, 8 Jan 2020 09:10:06 +0100
Message-ID: <CAMuHMdXHhF6GhS1W8qS4j7Jv5YnxXjcRopT5QSA=+trc8qwFng__17735.5280307651$1578471388$gmane$org@mail.gmail.com>
References: <1578415992-24054-1-git-send-email-krzk@kernel.org>
 <1578415992-24054-3-git-send-email-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1578415992-24054-3-git-send-email-krzk@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rich Felker <dalias@libc.org>, Jiri Slaby <jirislaby@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, netdev <netdev@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, Linux-Arch <linux-arch@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, Linux-sh list <linux-sh@vger.kernel.org>, Alexey Brodkin <abrodkin@synopsys.com>, Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Matt Turner <mattst88@gmail.com>, arcml <linux-snps-arc@lists.infradead.org>, Nick Kossifidis <mic>
List-Id: virtualization@lists.linuxfoundation.org

Hi Krzysztof,

On Tue, Jan 7, 2020 at 5:53 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> The ioreadX() helpers have inconsistent interface.  On some architectures
> void *__iomem address argument is a pointer to const, on some not.
>
> Implementations of ioreadX() do not modify the memory under the address
> so they can be converted to a "const" version for const-safety and
> consistency among architectures.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

> --- a/arch/alpha/include/asm/io.h
> +++ b/arch/alpha/include/asm/io.h
> @@ -151,9 +151,9 @@ static inline void generic_##NAME(TYPE b, QUAL void __iomem *addr)  \
>         alpha_mv.mv_##NAME(b, addr);                                    \
>  }
>
> -REMAP1(unsigned int, ioread8, /**/)
> -REMAP1(unsigned int, ioread16, /**/)
> -REMAP1(unsigned int, ioread32, /**/)
> +REMAP1(unsigned int, ioread8, const)
> +REMAP1(unsigned int, ioread16, const)
> +REMAP1(unsigned int, ioread32, const)

If these would become "const volatile", there would no longer be a need
for the last parameter of the REMAP1() macro.

>  REMAP1(u8, readb, const volatile)
>  REMAP1(u16, readw, const volatile)
>  REMAP1(u32, readl, const volatile)

Same for REMAP2() macro below, for iowrite*().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
