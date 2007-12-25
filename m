From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 04/16] per-cpu run guest
Date: Wed, 26 Dec 2007 10:38:45 +1100
Message-ID: <200712261038.46376.rusty__46563.6904155419$1198626123$gmane$org@rustcorp.com.au>
References: <11981576363806-git-send-email-gcosta@redhat.com>
	<1198157654189-git-send-email-gcosta@redhat.com>
	<11981576581695-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11981576581695-git-send-email-gcosta@redhat.com>
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

On Friday 21 December 2007 00:33:44 Glauber de Oliveira Costa wrote:
> @@ -55,11 +55,15 @@ static int user_send_irq(struct lguest *lg, const
> unsigned long __user *input) static ssize_t read(struct file *file, char
> __user *user, size_t size,loff_t*o) {
>  	struct lguest *lg = file->private_data;
> +	struct lguest_vcpu *vcpu = NULL;
> +	unsigned int vcpu_id = *o;
>
>  	/* You must write LHREQ_INITIALIZE first! */
>  	if (!lg)
>  		return -EINVAL;
>
> +	vcpu = &lg->vcpus[vcpu_id];
> +

Better do a bounds check here!

Cheers,
Rusty.
