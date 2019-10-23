From: Dmitry Vyukov via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 0/3] kcov: collect coverage from usb and vhost
Date: Wed, 23 Oct 2019 10:37:12 +0200
Message-ID: <CACT4Y+aUf5_+U90BD=1FsS1vVFrH=kskkUJWFyg2cdeRjL1LVw@mail.gmail.com>
References: <cover.1571762488.git.andreyknvl@google.com>
Reply-To: Dmitry Vyukov <dvyukov@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1571762488.git.andreyknvl@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, KVM list <kvm@vger.kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, netdev <netdev@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Elena Reshetova <elena.reshetova@intel.com>, David Windsor <dwindsor@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 22, 2019 at 6:46 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This patchset extends kcov to allow collecting coverage from the USB
> subsystem and vhost workers. See the first patch description for details
> about the kcov extension. The other two patches apply this kcov extension
> to USB and vhost.
>
> These patches have been used to enable coverage-guided USB fuzzing with
> syzkaller for the last few years, see the details here:
>
> https://github.com/google/syzkaller/blob/master/docs/linux/external_fuzzing_usb.md
>
> This patchset has been pushed to the public Linux kernel Gerrit instance:
>
> https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/1524

Oh, so much easier to review with side-by-side diffs, context and
smart in-line colouring!

> Changes from RFC v1:
> - Remove unnecessary #ifdef's from drivers/vhost/vhost.c.
> - Reset t->kcov when area allocation fails in kcov_remote_start().
> - Use struct_size to calculate array size in kcov_ioctl().
> - Add a limit on area_size in kcov_remote_arg.
> - Added kcov_disable() helper.
> - Changed encoding of kcov remote handle ids, see the documentation.
> - Added a comment reference for kcov_sequence task_struct field.
> - Change common_handle type to u32.
> - Add checks for handle validity into kcov_ioctl_locked() and
>     kcov_remote_start().
> - Updated documentation to reflect the changes.
>
> Andrey Konovalov (3):
>   kcov: remote coverage support
>   usb, kcov: collect coverage from hub_event
>   vhost, kcov: collect coverage from vhost_worker
>
>  Documentation/dev-tools/kcov.rst | 120 ++++++++
>  drivers/usb/core/hub.c           |   5 +
>  drivers/vhost/vhost.c            |   6 +
>  drivers/vhost/vhost.h            |   1 +
>  include/linux/kcov.h             |   6 +
>  include/linux/sched.h            |   6 +
>  include/uapi/linux/kcov.h        |  20 ++
>  kernel/kcov.c                    | 464 ++++++++++++++++++++++++++++---
>  8 files changed, 593 insertions(+), 35 deletions(-)
>
> --
> 2.23.0.866.gb869b98d4c-goog
>
