From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RFT 00/13] iomap: Constify ioreadX() iomem argument
Date: Wed, 8 Jan 2020 09:18:03 +0100
Message-ID: <CAJKOXPfq9vS4kSyx1jOPHBvi9_HjviRv0LU2A8ZwdmqgUuebHQ__7917.61379675648$1578471724$gmane$org@mail.gmail.com>
References: <1578415992-24054-1-git-send-email-krzk@kernel.org>
 <CAMuHMdW4ek0OYQDrrbcpZjNUTTP04nSbwkmiZvBmKcU=PQM9qA@mail.gmail.com>
 <CAMuHMdUBmYtJKtSYzS_5u67hVZOqcKSgFY1rDGme6gLNRBJ_gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMuHMdUBmYtJKtSYzS_5u67hVZOqcKSgFY1rDGme6gLNRBJ_gA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rich Felker <dalias@libc.org>, Jiri Slaby <jirislaby@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, netdev <netdev@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, Linux-Arch <linux-arch@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, Linux-sh list <linux-sh@vger.kernel.org>, Alexey Brodkin <abrodkin@synopsys.com>, Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Matt Turner <mattst88@gmail.com>, arcml <linux-snps-arc@lists.infradead.org>, Nick Kossifidis <mic>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 8 Jan 2020 at 09:13, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Krzysztof,
>
> On Wed, Jan 8, 2020 at 9:07 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Jan 7, 2020 at 5:53 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > The ioread8/16/32() and others have inconsistent interface among the
> > > architectures: some taking address as const, some not.
> > >
> > > It seems there is nothing really stopping all of them to take
> > > pointer to const.
> >
> > Shouldn't all of them take const volatile __iomem pointers?
> > It seems the "volatile" is missing from all but the implementations in
> > include/asm-generic/io.h.
>
> As my "volatile" comment applies to iowrite*(), too, probably that should be
> done in a separate patch.
>
> Hence with patches 1-5 squashed, and for patches 11-13:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I'll add to this one also changes to ioreadX_rep() and add another
patch for volatile for reads and writes. I guess your review will be
appreciated once more because of ioreadX_rep()

Thanks,
Krzysztof
