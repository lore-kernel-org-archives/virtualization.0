From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH RFC 1/5] vringfd syscall
Date: Sat, 12 Apr 2008 14:18:20 -0300
Message-ID: <20080412171820.GA29568__9245.46850515089$1208020612$gmane$org@dmt>
References: <200804052202.09157.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200804052202.09157.rusty@rustcorp.com.au>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Max Krasnyansky <maxk@qualcomm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty,

A couple comments below.

On Sat, Apr 05, 2008 at 10:02:08PM +1000, Rusty Russell wrote:

> +static unsigned int vring_poll(struct file *filp,
> +			       struct poll_table_struct *poll)
> +{
> +	struct vring_info *vr = filp->private_data;
> +	int err;
> +	unsigned int mask;
> +	u16 used, last_used;
> +
> +	/* Some uses of vrings require updating in user context.  This
> +	 * is best done close to the caller, ie. here. */
> +	if (vr->ops && vr->ops->pull) {
> +		err = vr->ops->pull(vr->ops_data);
> +		if (unlikely(err < 0))
> +			return err;
> +
> +		if (err > 0) {
> +			/* Buffers have been used, no need to check indices */
> +			mask = POLLIN | POLLRDNORM;
> +			goto poll_wait;
> +		}
> +	}
> +
> +	err = get_user(used, &vr->ring.used->idx);
> +	if (unlikely(err))
> +		return err;
> +
> +	err = get_user(last_used, vr->last_used);
> +	if (unlikely(err))
> +		return err;
> +
> +	/* More buffers have been used?  It's 'readable'. */
> +	if (used != last_used)
> +		mask = POLLIN | POLLRDNORM;
> +	else
> +		mask = 0;
> +
> +poll_wait:
> +	poll_wait(filp, &vr->poll_wait, poll);
> +
> +	return mask;
> +}

I suppose you are doing data copy in ->poll instead of ->read to save
a system call? This is weird, not conformant to what the interface is
supposed to do.

This way select/poll syscalls might block in userspace datacopy. The
application might have a higher priority fd in the fdset to be informed
of, for example.

So why not change this to the common arrangement, with vring_poll adding
the waitqueue with poll_wait() and vring_read doing the actual data copy ?

> +struct vring_info *vring_attach(int fd, const struct vring_ops *ops,
> +				void *data, bool atomic_use)
> +{
> +	struct file *filp;
> +	struct vring_info *vr;
> +
> +	/* Must be a valid fd, and must be one of ours. */
> +	filp = fget(fd);
> +	if (!filp) {
> +		vr = ERR_PTR(-EBADF);
> +		goto out;
> +	}
> +
> +	if (filp->f_op != &vring_fops) {
> +		vr = ERR_PTR(-EBADF);
> +		goto fput;
> +	}
> +
> +	/* Mutex simply protects against parallel vring_attach. */
> +	mutex_lock(&vring_lock);
> +	vr = filp->private_data;
> +	if (vr->ops) {
> +		vr = ERR_PTR(-EBUSY);
> +		goto unlock;
> +	}
> +
> +	/* If they want to use atomically, we have to map the page. */
> +	if (atomic_use) {
> +		if (get_user_pages(current, current->mm,
> +				   (unsigned long)vr->ring.used, 1, 1, 1,
> +				   &vr->used_page, NULL) != 1) {

Can't the same be achieved by the app mlocking the vring pages, which
then goes through standard rlimit checking ?
