From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 2/2] virtio-rng: fix stuck in catting hwrng attributes
Date: Thu, 11 Sep 2014 11:38:38 +0530
Message-ID: <20140911060838.GF19202@grmbl.mre>
References: <1410340027-15373-1-git-send-email-akong@redhat.com>
	<1410340027-15373-3-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1410340027-15373-3-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amos Kong <akong@redhat.com>
Cc: herbert.xu@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 10 Sep 2014 [17:07:07], Amos Kong wrote:
> When I check hwrng attributes in sysfs, cat process always gets
> stuck if guest has only 1 vcpu and uses a slow rng backend.
> 
> Currently we check if there is any tasks waiting to be run on
> current cpu in rng_dev_read() by need_resched(). But need_resched()
> doesn't work because rng_dev_read() is executing in user context.
> 
> This patch removed need_resched() and increase delay to 10 jiffies,
> then other tasks can have chance to execute protected code.
> Delaying 1 jiffy also works, but 10 jiffies is safer.

I'd prefer two patches for this one: one to remove the need_resched()
check, and the other to increase the timeout.

Anyway,

Reviewed-by: Amit Shah <amit.shah@redhat.com>

> 
> Signed-off-by: Amos Kong <akong@redhat.com>
> ---
>  drivers/char/hw_random/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> index c591d7e..b5d1b6f 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -195,8 +195,7 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
>  
>  		mutex_unlock(&rng_mutex);
>  
> -		if (need_resched())
> -			schedule_timeout_interruptible(1);
> +		schedule_timeout_interruptible(10);
>  
>  		if (signal_pending(current)) {
>  			err = -ERESTARTSYS;
> -- 
> 1.9.3
> 

		Amit
