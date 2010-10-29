From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] xen: xenfs: privcmd: check put_user() return code
Date: Fri, 29 Oct 2010 10:18:01 -0700
Message-ID: <4CCB01C9.4020007@goop.org>
References: <1288265942-12581-1-git-send-email-segooon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1288265942-12581-1-git-send-email-segooon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vasiliy Kulikov <segooon@gmail.com>
Cc: kernel-janitors@vger.kernel.org, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Ian Campbell <ian.campbell@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

 On 10/28/2010 04:39 AM, Vasiliy Kulikov wrote:
> put_user() may fail.  In this case propagate error code from
> privcmd_ioctl_mmap_batch().

Thanks for looking at this.  I'm in two minds about this; the existing
logic is such that these put_users can only fail if something else has
already failed and its returning an error.  I guess it would be useful
to get an EFAULT if you've got a problem writing back the results.

IanC, any opinion?

Thanks,
    J

> Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
> ---
>  Compile tested.
>
>  drivers/xen/xenfs/privcmd.c |    8 ++------
>  1 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/xen/xenfs/privcmd.c b/drivers/xen/xenfs/privcmd.c
> index f80be7f..2eb04c8 100644
> --- a/drivers/xen/xenfs/privcmd.c
> +++ b/drivers/xen/xenfs/privcmd.c
> @@ -266,9 +266,7 @@ static int mmap_return_errors(void *data, void *state)
>  	xen_pfn_t *mfnp = data;
>  	struct mmap_batch_state *st = state;
>  
> -	put_user(*mfnp, st->user++);
> -
> -	return 0;
> +	return put_user(*mfnp, st->user++);
>  }
>  
>  static struct vm_operations_struct privcmd_vm_ops;
> @@ -323,10 +321,8 @@ static long privcmd_ioctl_mmap_batch(void __user *udata)
>  	up_write(&mm->mmap_sem);
>  
>  	if (state.err > 0) {
> -		ret = 0;
> -
>  		state.user = m.arr;
> -		traverse_pages(m.num, sizeof(xen_pfn_t),
> +		ret = traverse_pages(m.num, sizeof(xen_pfn_t),
>  			       &pagelist,
>  			       mmap_return_errors, &state);
>  	}
