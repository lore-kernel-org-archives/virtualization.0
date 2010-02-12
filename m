From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/6] virtio: Initialize vq->data entries to NULL
Date: Fri, 12 Feb 2010 20:28:55 +1030
Message-ID: <201002122028.55869.rusty@rustcorp.com.au>
References: <1265950939-12359-1-git-send-email-amit.shah@redhat.com>
	<1265950939-12359-2-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1265950939-12359-2-git-send-email-amit.shah@redhat.com>
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
Cc: Shirley Ma <mashirle@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 12 Feb 2010 03:32:14 pm Amit Shah wrote:
> vq operations depend on vq->data[i] being NULL to figure out if the vq
> entry is in use.
> 
> We have to initialize them to NULL to ensure we don't work with junk
> data and trigger false BUG_ONs.

Not really.  We wouldn't detect some bogus get_buf() calls if it's not NULL,
but we only *need* this since detach_bufs was added.

I've updated the commit message to reflect it.

Thanks,
Rusty.
