From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [RFC PATCH 1/6] virtio/console: Add splice_write support
Date: Thu, 9 Aug 2012 14:30:15 +0530
Message-ID: <20120809090015.GG3280@amit.redhat.com>
References: <20120724023657.6600.52706.stgit@ltc189.sdl.hitachi.co.jp>
	<20120724023707.6600.69536.stgit@ltc189.sdl.hitachi.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120724023707.6600.69536.stgit@ltc189.sdl.hitachi.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Cc: Arnd Bergmann <arnd@arndb.de>, qemu-devel@nongnu.org, Frederic Weisbecker <fweisbec@gmail.com>, yrl.pp-manager.tt@hitachi.com, linux-kernel@vger.kernel.org, Borislav Petkov <bp@amd64.org>, virtualization@lists.linux-foundation.org, Herbert Xu <herbert@gondor.hengli.com.au>, "Franch Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, Anthony Liguori <anthony@codemonkey.ws>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) 24 Jul 2012 [11:37:07], Yoshihiro YUNOMAE wrote:
> From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> 
> Enable to use splice_write from pipe to virtio-console port.
> This steals pages from pipe and directly send it to host.
> 
> Note that this may accelerate only the guest to host path.
> 
> Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> Cc: Amit Shah <amit.shah@redhat.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

> +/* Faster zero-copy write by splicing */
> +static ssize_t port_fops_splice_write(struct pipe_inode_info *pipe,
> +				      struct file *filp, loff_t *ppos,
> +				      size_t len, unsigned int flags)
> +{
> +	struct port *port = filp->private_data;
> +	struct sg_list sgl;
> +	ssize_t ret;
> +	struct splice_desc sd = {
> +		.total_len = len,
> +		.flags = flags,
> +		.pos = *ppos,
> +		.u.data = &sgl,
> +	};
> +
> +	sgl.n = 0;
> +	sgl.len = 0;
> +	sgl.sg = kmalloc(sizeof(struct scatterlist) * MAX_SPLICE_PAGES,
> +			 GFP_ATOMIC);

Do you expect this function to be called from interrupt context?

> +	if (unlikely(!sgl.sg))
> +		return -ENOMEM;
> +
> +	sg_init_table(sgl.sg, MAX_SPLICE_PAGES);
> +	ret = __splice_from_pipe(pipe, &sd, pipe_to_sg);
> +	if (likely(ret > 0))
> +		ret = send_pages(port, sgl.sg, sgl.n, sgl.len, true);
> +
> +	return ret;
> +}

		Amit
