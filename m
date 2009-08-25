From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/2] virtio: Add a can_add_buf helper
Date: Tue, 25 Aug 2009 23:57:54 +0930
Message-ID: <200908252357.54455.rusty@rustcorp.com.au>
References: <1250611290-2410-1-git-send-email-amit.shah@redhat.com>
	<200908221731.26834.rusty@rustcorp.com.au>
	<20090824073944.GA7653@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090824073944.GA7653@amit-x200.redhat.com>
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
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 24 Aug 2009 05:09:44 pm Amit Shah wrote:
>  	sg_init_table(sg, 2+MAX_SKB_FRAGS);
> -	for (;;) {
> +	ret = 1;
> +	while(ret > 0) { /* Is there space to add another buffer to the vq */

This is called a "do" loop :)

Please test, and I'll apply.

Cheers,
Rusty.
