From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 3/8] hvc_console: make the ops pointer const.
Date: Tue, 10 Nov 2009 09:56:45 +0100
Message-ID: <200911100956.45668.borntraeger__5251.88811957396$1257843493$gmane$org@de.ibm.com>
References: <1257834450..rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257834450..rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, linuxppc-dev@ozlabs.org, virtualization@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Dienstag 10 November 2009 07:27:30 schrieb Rusty Russell:
> This is nicer for modern R/O protection.  And noone needs it non-const, so
> constify the callers as well.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> To: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: linuxppc-dev@ozlabs.org
> ---
>  drivers/char/hvc_beat.c       |    2 +-
>  drivers/char/hvc_console.c    |    7 ++++---
>  drivers/char/hvc_console.h    |    7 ++++---
>  drivers/char/hvc_iseries.c    |    2 +-
>  drivers/char/hvc_iucv.c       |    2 +-
>  drivers/char/hvc_rtas.c       |    2 +-
>  drivers/char/hvc_udbg.c       |    2 +-
>  drivers/char/hvc_vio.c        |    2 +-
>  drivers/char/hvc_xen.c        |    2 +-
>  drivers/char/virtio_console.c |    2 +-
>  10 files changed, 16 insertions(+), 14 deletions(-)

Ok, I started with patches 1-3. I like the result.

So for the first 3 patches you can add
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com> (on s390)
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

I have not yet looked at the other ones, but I will try to find some time to 
look at them.

Christian
