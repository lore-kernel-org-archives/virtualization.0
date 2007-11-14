From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Remove pagesize parameter from vring_init/vring_size
Date: Thu, 15 Nov 2007 09:19:55 +1100
Message-ID: <200711150919.55752.rusty@rustcorp.com.au>
References: <11950564033349-git-send-email-aliguori@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11950564033349-git-send-email-aliguori@us.ibm.com>
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
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 15 November 2007 03:06:43 Anthony Liguori wrote:
> The PAGE_SIZE constant should be used instead of taking an extra parameter.
> Moreover, once we use PAGE_SIZE, we can use PAGE_ALIGN() instead of having
> it open coded.

Unfortunately this is exposed to userspace.  I should probably add a comment.

Cheers,
Rusty.
