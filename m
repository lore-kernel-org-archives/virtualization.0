From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio: console: Return -EFAULT on copy_xx_user errors,
	allow larger writes
Date: Sat, 30 Jan 2010 15:25:08 +1030
Message-ID: <201001301525.08208.rusty@rustcorp.com.au>
References: <1264772563-25517-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1264772563-25517-1-git-send-email-amit.shah@redhat.com>
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

On Sat, 30 Jan 2010 12:12:37 am Amit Shah wrote:
> These updated patches in the series return -EFAULT on copy_xx_user
> errors and also move the copy_from_user into fops_write() instead of it
> being in send_buf. This enables send_buf to just read from kernel
> buffers, making it simpler.
> 
> This also allows write()s to write more to the host in one go,
> removingthe 4k limitation. I do limit the writes to 32k at once to not
> put too much pressure on the GFP_KERNEL area.
> 
> Both of these were pointed out by Marcelo.

Applied.

Thanks,
Rusty.
