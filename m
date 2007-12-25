From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 05/16] make write() operation smp aware
Date: Wed, 26 Dec 2007 10:40:24 +1100
Message-ID: <200712261040.24771.rusty__28331.3149623156$1198626137$gmane$org@rustcorp.com.au>
References: <11981576363806-git-send-email-gcosta@redhat.com>
	<11981576581695-git-send-email-gcosta@redhat.com>
	<11981576632726-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11981576632726-git-send-email-gcosta@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 21 December 2007 00:33:45 Glauber de Oliveira Costa wrote:
> --- a/drivers/lguest/lguest_user.c
> +++ b/drivers/lguest/lguest_user.c
> @@ -223,14 +223,21 @@ static ssize_t write(struct file *file, const char
...
>  	/* If you haven't initialized, you must do that first. */
> -	if (req != LHREQ_INITIALIZE && !lg)
> -		return -EINVAL;
> +	if (req != LHREQ_INITIALIZE) {
> +		if (!lg)
> +			return -EINVAL;
> +		vcpu = &lg->vcpus[vcpu_id];
> +		if (!vcpu)
> +			return -EINVAL;
> +	}

Bounds check again...

Cheers,
Rusty.
