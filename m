From: Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v2 0/4] Remove 32-bit Xen PV guest support
Date: Thu, 2 Jul 2020 10:48:48 -0400
Message-ID: <CAMzpN2hvK2T7Qje51MPjMyTggxT7_=EFnt7gAmJEa1Zq+t3LtA@mail.gmail.com>
References: <20200701110650.16172-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200701110650.16172-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: xen-devel <xen-devel@lists.xenproject.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <sstabellini@kernel.org>, Deep Shah <sdeep@vmware.com>, "VMware, Inc." <pv-drivers@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 1, 2020 at 7:07 AM Juergen Gross <jgross@suse.com> wrote:
>
> The long term plan has been to replace Xen PV guests by PVH. The first
> victim of that plan are now 32-bit PV guests, as those are used only
> rather seldom these days. Xen on x86 requires 64-bit support and with
> Grub2 now supporting PVH officially since version 2.04 there is no
> need to keep 32-bit PV guest support alive in the Linux kernel.
> Additionally Meltdown mitigation is not available in the kernel running
> as 32-bit PV guest, so dropping this mode makes sense from security
> point of view, too.

One thing that you missed is removing VDSO_NOTE_NONEGSEG_BIT from
vdso32/note.S.  With that removed there is no difference from the
64-bit version.

Otherwise this series looks good to me.
--
Brian Gerst
