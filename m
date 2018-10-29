From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Outreachy kernel] [PATCH 0/6] drm/qxl: Remove checkpatch issues
Date: Mon, 29 Oct 2018 14:54:34 +0100
Message-ID: <20181029135434.GY21967__39728.7139938728$1540821158$gmane$org@phenom.ffwll.local>
References: <cover.1540579956.git.shayenneluzmoura@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1540579956.git.shayenneluzmoura@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, outreachy-kernel@googlegroups.com, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 26, 2018 at 04:20:30PM -0300, Shayenne da Luz Moura wrote:
> This series cleans the following checkpatch.pl issues:
> 
> ERROR: trailing whitespace
> WARNING: Missing a blank line after declarations
> CHECK: Please don't use multiple blank lines
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> ERROR: space required before the open parenthesis '('
> CHECK: Avoid using bool structure members because of possible alignment issues

I looked through the patches, all fine, great work. I've pinged
maintainers and will merge it all as soon as they've acked it.

Assuming you want to continue hacking on gpu drivers, we have a todo list
with more advanced tasks:

https://dri.freedesktop.org/docs/drm/gpu/todo.html

Best to discuss those on #dri-devel irc before getting started, to make
sure scope and all is clear.

Cheers, Daniel

> 
> Shayenne da Luz Moura (6):
>   drm/qxl: Remove trailing whitespace
>   drm/qxl: Add line after variable declarations
>   drm/qxl: Remove exceding whiteline
>   drm/qxl: Use 'unsigned int' instead of 'usigned'
>   drm/qxl: Add space before open parentheses
>   drm/qxl: Use 'unsigned int' instead of bool
> 
>  drivers/gpu/drm/qxl/qxl_cmd.c     |  7 +++++--
>  drivers/gpu/drm/qxl/qxl_debugfs.c |  5 ++---
>  drivers/gpu/drm/qxl/qxl_dev.h     |  1 -
>  drivers/gpu/drm/qxl/qxl_display.c | 19 ++++++++++---------
>  drivers/gpu/drm/qxl/qxl_draw.c    | 11 ++++++-----
>  drivers/gpu/drm/qxl/qxl_drv.h     | 31 ++++++++++++++-----------------
>  drivers/gpu/drm/qxl/qxl_dumb.c    |  3 ++-
>  drivers/gpu/drm/qxl/qxl_fb.c      |  4 ++--
>  drivers/gpu/drm/qxl/qxl_image.c   |  4 +++-
>  drivers/gpu/drm/qxl/qxl_ioctl.c   |  2 ++
>  drivers/gpu/drm/qxl/qxl_kms.c     |  2 +-
>  drivers/gpu/drm/qxl/qxl_object.c  |  5 ++---
>  drivers/gpu/drm/qxl/qxl_object.h  |  2 ++
>  drivers/gpu/drm/qxl/qxl_prime.c   |  1 -
>  drivers/gpu/drm/qxl/qxl_release.c |  1 -
>  drivers/gpu/drm/qxl/qxl_ttm.c     | 12 +++++-------
>  16 files changed, 56 insertions(+), 54 deletions(-)
> 
> -- 
> 2.19.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/cover.1540579956.git.shayenneluzmoura%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
