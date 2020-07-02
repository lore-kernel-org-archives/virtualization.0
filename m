From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Subject: Re: [PATCH v2 0/4] Remove 32-bit Xen PV guest support
Date: Thu, 2 Jul 2020 17:45:23 +0200
Message-ID: <e277e875-c159-4281-e9b7-08c91882d1fb@suse.com>
References: <20200701110650.16172-1-jgross@suse.com>
 <CAMzpN2hvK2T7Qje51MPjMyTggxT7_=EFnt7gAmJEa1Zq+t3LtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMzpN2hvK2T7Qje51MPjMyTggxT7_=EFnt7gAmJEa1Zq+t3LtA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel <xen-devel@lists.xenproject.org>, Thomas Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On 02.07.20 16:48, Brian Gerst wrote:
> On Wed, Jul 1, 2020 at 7:07 AM Juergen Gross <jgross@suse.com> wrote:
>>
>> The long term plan has been to replace Xen PV guests by PVH. The first
>> victim of that plan are now 32-bit PV guests, as those are used only
>> rather seldom these days. Xen on x86 requires 64-bit support and with
>> Grub2 now supporting PVH officially since version 2.04 there is no
>> need to keep 32-bit PV guest support alive in the Linux kernel.
>> Additionally Meltdown mitigation is not available in the kernel running
>> as 32-bit PV guest, so dropping this mode makes sense from security
>> point of view, too.
> 
> One thing that you missed is removing VDSO_NOTE_NONEGSEG_BIT from
> vdso32/note.S.  With that removed there is no difference from the
> 64-bit version.

Oh, this means we can probably remove arch/x86/xen/vdso.h completely.

> 
> Otherwise this series looks good to me.

Thanks,


Juergen
