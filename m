From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PULL] vhost: cleanups and fixes
Date: Fri, 2 Nov 2018 13:21:06 -0400
Message-ID: <20181102131334-mutt-send-email-mst__40684.2490578585$1541179177$gmane$org@kernel.org>
References: <20181101171938-mutt-send-email-mst@kernel.org>
	<CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
	<CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
	<20181102114635.hi3q53kzmz4qljsf@lakrids.cambridge.arm.com>
	<20181102083018-mutt-send-email-mst@kernel.org>
	<CAHk-=wh_bQK5zs+CwQ5eyodq4sQT0eOPp60qzvVL2_EtgETP-g@mail.gmail.com>
	<20181102122937-mutt-send-email-mst@kernel.org>
	<CAHk-=wibzqo7C+mS+BgZxRbgdWe2w5F39EhuFUhZUxvotoGLuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=wibzqo7C+mS+BgZxRbgdWe2w5F39EhuFUhZUxvotoGLuA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: mark.rutland@arm.com, lenaic@lhuard.fr, mhocko@suse.com, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, netdev@vger.kernel.org, liang.z.li@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, stefanha@redhat.com, joe@perches.com, Andrew Morton <akpm@linux-foundation.org>, mhocko@kernel.org, bijan.mottahedeh@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 02, 2018 at 10:10:45AM -0700, Linus Torvalds wrote:
> On Fri, Nov 2, 2018 at 9:59 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Just for completeness I'd like to point out for vhost the copies are
> > done from the kernel thread.  So yes we can switch to copy_to/from_user
> > but for e.g. 32-bit userspace running on top of a 64 bit kernel it is
> > IIUC not sufficient - we must *also* do access_ok checks on control path
> > when addresses are passed to the kernel and when current points to the
> > correct task struct.
> 
> Don't you take over the VM with "use_mm()" when you do the copies?

Yes we do.

> So
> yes, it's a kernel thread, but it has a user VM, and though that
> should have the user limits.
> 
> No?
> 
>           Linus

Here's what I meant: we have

#define access_ok(type, addr, size)                                     \
({                                                                      \
        WARN_ON_IN_IRQ();                                               \
        likely(!__range_not_ok(addr, size, user_addr_max()));           \
})

and

#define user_addr_max() (current->thread.addr_limit.seg)

it seems that it depends on current not on the active mm.

get_user and friends are similar:

ENTRY(__get_user_1)
        mov PER_CPU_VAR(current_task), %_ASM_DX
        cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
        jae bad_get_user
        sbb %_ASM_DX, %_ASM_DX          /* array_index_mask_nospec() */
        and %_ASM_DX, %_ASM_AX
        ASM_STAC
1:      movzbl (%_ASM_AX),%edx
        xor %eax,%eax
        ASM_CLAC
        ret
ENDPROC(__get_user_1)
EXPORT_SYMBOL(__get_user_1)

-- 
MST
