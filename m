From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 13/16] per-vcpu lguest task management
Date: Wed, 26 Dec 2007 10:47:38 +1100
Message-ID: <200712261047.39247.rusty__19594.0589918338$1198626553$gmane$org@rustcorp.com.au>
References: <11981576363806-git-send-email-gcosta@redhat.com>
	<11981576972655-git-send-email-gcosta@redhat.com>
	<11981577021091-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11981577021091-git-send-email-gcosta@redhat.com>
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

On Friday 21 December 2007 00:33:53 Glauber de Oliveira Costa wrote:
> @@ -114,6 +116,19 @@ static int vcpu_start(struct lguest_vcpu *vcpu, int
> vcpu_id, * address. */
>  	lguest_arch_setup_regs(vcpu, start_ip);
>
> +	/* Initialize the queue for the waker to wait on */
> +	init_waitqueue_head(&vcpu->break_wq);
> +
> +	/* We keep a pointer to the Launcher task (ie. current task) for when
> +	 * other Guests want to wake this one (inter-Guest I/O). */
> +	vcpu->tsk = current;
> +
> +	/* We need to keep a pointer to the Launcher's memory map, because if
> +	 * the Launcher dies we need to clean it up.  If we don't keep a
> +	 * reference, it is destroyed before close() is called. */
> +	vcpu->mm = get_task_mm(vcpu->tsk);
> +
> +

Nitpick: extra line?

Cheers,
Rusty.
