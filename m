From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC 1/5] vringfd syscall
Date: Wed, 09 Apr 2008 14:28:05 -0500
Message-ID: <47FD18C5.6040709__13313.1296527155$1207769431$gmane$org@goop.org>
References: <200804052202.09157.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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

Rusty Russell wrote:
> +asmlinkage long sys_vringfd(void __user *addr,
> +			    unsigned num_descs,
> +			    u16 __user *last_used)
> +{
> +	int fd, err;
> +	struct file *filp;
> +	struct vring_info *vr;
> +
> +	/* Must be a power of two, and representable by u16 */
> +	if (!num_descs || (num_descs & (num_descs-1)) || num_descs > 65536) {
>   

65536 doesn't fit in u16.

    J
